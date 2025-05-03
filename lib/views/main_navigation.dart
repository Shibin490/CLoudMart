import 'package:cloud_mart/views/bottom_navbar.dart';
import 'package:cloud_mart/views/cart_scren.dart';
import 'package:cloud_mart/views/home_screen.dart';
import 'package:cloud_mart/views/profile_screen.dart';
import 'package:cloud_mart/views/wish_listscreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NavigationProvider extends ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void setIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}

class MainApp extends StatelessWidget {
  final List<Widget> screens = [
    HomeScreen(),
    CartScreen(),
    WishlistScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<NavigationProvider>(
      builder: (context, navigationProvider, _) {
        return Scaffold(
          body: screens[navigationProvider.currentIndex],
          bottomNavigationBar: CustomBottomNavBar(
            currentIndex: navigationProvider.currentIndex,
            onTap: (index) {
              navigationProvider.setIndex(index);
            },
          ),
        );
      },
    );
  }
}

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => NavigationProvider(),
      child: MaterialApp(home: MainApp()),
    ),
  );
}
