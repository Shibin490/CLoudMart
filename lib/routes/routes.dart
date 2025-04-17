import 'package:cloud_mart/providers/login_provider.dart';
import 'package:cloud_mart/providers/signup_provider.dart';
import 'package:cloud_mart/views/login_screen.dart';
import 'package:cloud_mart/views/signup_sccreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class AppRoutes {
  static final routes = <String, WidgetBuilder>{
    '/signin': (context) => ChangeNotifierProvider(
          create: (_) => LoginProvider(),
          child: LoginScreen(),
        ),
    '/signup': (context) => ChangeNotifierProvider(
          create: (_) => SignUpProvider(),
          child: SignUpScreen(),
        ),
  };
}
