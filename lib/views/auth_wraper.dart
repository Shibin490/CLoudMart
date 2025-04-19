import 'package:cloud_mart/providers/login_provider.dart';
import 'package:cloud_mart/views/home_screen.dart';
import 'package:cloud_mart/views/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: context.read<AuthService>().authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final user = snapshot.data;
          
          if (user == null) {
            return ChangeNotifierProvider(
              create: (_) => LoginProvider(),
              child: LoginScreen(),
            );
          }
          
          return HomeScreen();
        }
        
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}