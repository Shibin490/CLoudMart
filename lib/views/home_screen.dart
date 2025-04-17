// lib/home_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get the current user from the AuthService
    final authService = Provider.of<AuthService>(context);
    final user = authService.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text('Cloud Mart'),
        actions: [
          // Sign out button
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await authService.signOut(); // Log out the user
              Navigator.pushReplacementNamed(context, '/signIn'); // Navigate to sign-in screen
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Display a welcome message
            Text(
              'Welcome to Cloud Mart!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            // Show email of the current user or display 'Unknown User'
            Text(
              'You are signed in as:',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              user?.email ?? 'Unknown User',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 32),
            // Sign out button
            ElevatedButton(
              onPressed: () async {
                await authService.signOut(); // Sign the user out
                Navigator.pushReplacementNamed(context, '/signIn'); // Redirect to sign-in screen
              },
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text('Sign Out', style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
