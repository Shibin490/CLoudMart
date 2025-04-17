import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';

class AuthService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Current user
  User? get currentUser => _auth.currentUser;

  // Stream of auth changes (user login state)
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Sign up with email and password
  Future<User?> signUp(String email, String password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      print("✅ User signed up: ${userCredential.user?.uid}");
      notifyListeners();
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      print("❌ Sign up failed: ${e.code} - ${e.message}");
      throw _handleAuthException(e);
    }
  }

  // Sign in with email and password
  Future<User?> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      print("✅ User signed in: ${userCredential.user?.uid}");
      notifyListeners();
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      print("❌ Sign in failed: ${e.code} - ${e.message}");
      throw _handleAuthException(e);
    }
  }

  // Sign in with Google
  Future<User?> signInWithGoogle() async {
    try {
      // Trigger the Google Sign-In flow
      GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        print("❌ Google sign-in aborted.");
        return null; // User canceled the sign-in
      }

      // Obtain the GoogleAuth details
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Create a new credential using the GoogleAuth details
      OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in with the Google credentials
      UserCredential userCredential = await _auth.signInWithCredential(credential);
      print("✅ User signed in with Google: ${userCredential.user?.uid}");
      notifyListeners();
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      print("❌ Google sign-in failed: ${e.code} - ${e.message}");
      throw _handleAuthException(e);
    }
  }

  // Handle FirebaseAuthException and return a readable message
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
      default:
        return 'An unknown error occurred. Please try again.';
    }
  }

  // Sign out the user
  Future<void> signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
    print("🚪 User signed out");
    notifyListeners();
  }
}
