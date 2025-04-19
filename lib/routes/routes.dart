
import 'package:cloud_mart/views/auth_wraper.dart';
import 'package:cloud_mart/views/home_screen.dart';
import 'package:cloud_mart/views/login_screen.dart';
import 'package:cloud_mart/views/signup_sccreen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static final Map<String, Widget Function(BuildContext)> routes = {
    '/auth': (context) => AuthWrapper(),
    '/login': (context) => LoginScreen(),
    '/signup': (context) => SignUpScreen(),
    '/home': (context) => HomeScreen(),
    
  };
}