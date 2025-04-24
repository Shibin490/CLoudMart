import 'package:cloud_mart/models/product_mode.dart';
import 'package:cloud_mart/views/add_product.dart';
import 'package:cloud_mart/views/auth_wraper.dart';
import 'package:cloud_mart/views/edit_product.dart';
import 'package:cloud_mart/views/login_screen.dart';
import 'package:cloud_mart/views/product_detail.dart';
import 'package:cloud_mart/views/signup_sccreen.dart';
import 'package:cloud_mart/views/home_screen.dart';

import 'package:flutter/material.dart';

class AppRoutes {
  static final Map<String, Widget Function(BuildContext)> routes = {
    '/': (context) => AuthWrapper(),
    '/login': (context) => LoginScreen(),
    '/signup': (context) => SignUpScreen(),
    '/addProduct': (context) => AddProductScreen(),
    '/home': (context) => HomeScreen(),
    '/productDetail': (context) {
      final product = ModalRoute.of(context)?.settings.arguments as Product?;
      return ProductDetailScreen(product: product!);
    },
    '/editProduct': (context) {
      final product = ModalRoute.of(context)?.settings.arguments as Product?;
      return EditProductScreen(product: product!);
    },
  };
}
