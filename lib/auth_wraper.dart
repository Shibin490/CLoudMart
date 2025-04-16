// lib/auth_wrapper.dart
import 'package:cloud_mart/homescreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'auth_service.dart';
import 'login_screen.dart';

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: context.read<AuthService>().authStateChanges, // Stream of auth state changes
      builder: (context, snapshot) {
        // Check if the snapshot has data and it's active
        if (snapshot.connectionState == ConnectionState.active) {
          User? user = snapshot.data;
          
          // If user is not logged in, show login screen
          if (user == null) {
            return SignInScreen();
          }
          
          // If user is logged in, show home screen
          return HomeScreen();
        }

        // While waiting for the user state to be determined, show a loading indicator
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
