// import 'package:cloud_mart/providers/login_provider.dart';
import 'package:cloud_mart/providers/login_provider.dart';
import 'package:cloud_mart/providers/navigation_provider.dart'; // Import the navigation provider
import 'package:cloud_mart/views/bottom_navbar.dart';
import 'package:cloud_mart/views/cart_scren.dart';
import 'package:cloud_mart/views/home_screen.dart';
import 'package:cloud_mart/views/login_screen.dart';
import 'package:cloud_mart/views/profile_screen.dart';
import 'package:cloud_mart/views/wish_listscreen.dart';
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
          return ChangeNotifierProvider(
            create: (_) => NavigationProvider(),
            child: Consumer<NavigationProvider>(
              builder: (context, navigationProvider, _) {
                return Scaffold(
                  body: IndexedStack(
                    index: navigationProvider.currentIndex,
                    children: [
                      HomeScreen(),
                      CartScreen(),
                      WishlistScreen(),
                      ProfileScreen(),
                    ],
                  ),
                  bottomNavigationBar: CustomBottomNavBar(
                    currentIndex: navigationProvider.currentIndex,
                    onTap: (index) {
                      navigationProvider.setIndex(index);
                    },
                  ),
                );
              },
            ),
          );
        }
        return Scaffold(body: Center(child: CircularProgressIndicator()));
      },
    );
  }
}
