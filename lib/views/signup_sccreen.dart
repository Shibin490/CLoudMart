// ignore_for_file: deprecated_member_use

import 'package:cloud_mart/providers/signup_provider.dart';
import 'package:cloud_mart/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SignUpProvider>(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        height: size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: const [
              Color.fromARGB(255, 26, 5, 146),
              Color.fromARGB(255, 2, 7, 13),
              Color.fromARGB(255, 5, 19, 124),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: size.height * 0.03),
                Text(
                  'Create\nAccount',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                  ),
                ),
                Text(
                  'Fill the details to continue',
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
                SizedBox(height: 25),
                Container(
                  padding: EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      CustomTextField(
                        controller: provider.nameController,
                        prefixIcon: Icon(
                          Icons.person_outline,
                          color: Colors.white70,
                        ),
                        label: 'Full Name',
                      ),
                      SizedBox(height: 10),
                      CustomTextField(
                        controller: provider.emailController,
                        prefixIcon: Icon(
                          Icons.email_outlined,
                          color: Colors.white70,
                        ),
                        label: 'Email',
                      ),
                      SizedBox(height: 10),
                      CustomTextField(
                        controller: provider.passwordController,
                        prefixIcon: Icon(
                          Icons.lock_outline,
                          color: Colors.white70,
                        ),
                        label: 'Password',
                        obscureText: !provider.isPasswordVisible,
                        suffixIcon: IconButton(
                          icon: Icon(
                            provider.isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.white70,
                          ),
                          onPressed: provider.togglePasswordVisibility,
                        ),
                      ),
                      SizedBox(height: 10),
                      CustomTextField(
                        controller: provider.phoneController,
                        prefixIcon: Icon(
                          Icons.phone_outlined,
                          color: Colors.white70,
                        ),
                        label: 'Phone Number',
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                provider.isLoading
                    ? Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    )
                    : Column(
                      children: [
                        CustomButton(
                          text: 'Create Account',
                          onPressed: () => provider.signUp(context),
                          color: Colors.white,
                          textStyle: TextStyle(
                            color: Color.fromARGB(255, 26, 5, 146),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          width: 280, 
                          height: 50, 
                        ),
                        SizedBox(height: 5),
                        Text(
                          'OR',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        SizedBox(height: 9),

                        CustomButton(
                          onPressed: () => provider.signInWithGoogle(context),
                          color: Colors.white,
                          // icon: Image.asset(
                          //   'assets/icons/google.png',
                          //   height: 24,
                          //   width: 24,
                          // ),
                          text: 'Continue with Google',
                          textStyle: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                          width: 280, // Custom width
                          height: 50, // Custom height
                        ),

                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already have an account? ",
                              style: TextStyle(color: Colors.white70),
                            ),
                            GestureDetector(
                              onTap:
                                  () => Navigator.pushReplacementNamed(
                                    context,
                                    '/signin',
                                  ),

                              child: Text(
                                "Sign In",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
