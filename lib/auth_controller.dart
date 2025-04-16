// import 'package:cloud_mart/auth_service.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class AuthController extends ChangeNotifier {
//   final AuthService _authService = AuthService();
//   User? _user;

//   User? get user => _user;

//   // Sign up
//   Future<void> signUp(String email, String password) async {
//     try {
//       _user = await _authService.signUp(email, password);
//       notifyListeners();
//     } catch (e) {
//       throw Exception('Sign Up Error: $e');
//     }
//   }

//   // Sign in
//   Future<void> signIn(String email, String password) async {
//     try {
//       _user = await _authService.signIn(email, password);
//       notifyListeners();
//     } catch (e) {
//       throw Exception('Sign In Error: $e');
//     }
//   }

//   // Sign out
//   Future<void> signOut() async {
//     await _authService.signOut();
//     _user = null;
//     notifyListeners();
//   }
// }
