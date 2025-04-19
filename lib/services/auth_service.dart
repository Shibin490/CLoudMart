// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';

class AuthService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  User? get currentUser => _auth.currentUser;
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<User?> signUp(String email, String password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      print(" User signed up: ${userCredential.user?.uid}");
      notifyListeners();
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      print(" Sign up failed: ${e.code} - ${e.message}");
      throw _handleAuthException(e);
    }
  }

  Future<User?> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      print(" User signed in: ${userCredential.user?.uid}");
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      print(" Sign-in failed: ${e.code} - ${e.message}");

      String errorMessage = _handleAuthException(e);
      print("Error: $errorMessage");

      throw errorMessage;
    }
  }

  Future<User?> signInWithGoogle() async {
    try {
      GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        print(" Google sign-in aborted.");
        return null; 
      }

      GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential = await _auth.signInWithCredential(
        credential,
      );
      print(" User signed in with Google: ${userCredential.user?.uid}");
      notifyListeners();
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      print(" Google sign-in failed: ${e.code} - ${e.message}");
      throw _handleAuthException(e);
    }
  }

  String _handleAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'email-already-in-use':
        return 'This email is already in use. Please try another one.';
      case 'invalid-email':
        return 'Please provide a valid email address.';
      case 'weak-password':
        return 'Password should be at least 6 characters long.';
      case 'user-not-found':
        return 'No user found for that email.';
      case 'wrong-password':
        return 'Incorrect password. Please try again.';
      case 'user-disabled':
        return 'Your account has been disabled. Please contact support.';
      case 'too-many-requests':
        return 'Too many requests. Please try again later.';
      case 'operation-not-allowed':
        return 'This operation is not allowed. Please contact support.';
      default:
        return 'An unknown error occurred. Please try again.';
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
    print(" User signed out");
    notifyListeners();
  }
}
