import 'package:cloud_mart/providers/login_provider.dart';
import 'package:cloud_mart/themes/app_theme.dart';
import 'package:cloud_mart/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        height: 100.h,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: const [
              AppTheme.primaryColor,
              AppTheme.secondaryColor,
              Color.fromARGB(255, 5, 19, 124),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8.h),
                  Text(
                    'Welcome\nBack',
                    style: AppTheme.headerTextStyle.copyWith(fontSize: 28.sp),
                  ),
                  SizedBox(height: 1.h),
                  Text(
                    'Login to continue your journy',
                    style: AppTheme.subHeaderTextStyle.copyWith(
                      fontSize: 15.sp,
                    ),
                  ),

                  SizedBox(height: 5.h),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.white.withOpacity(0.08),
                    ),
                    padding: EdgeInsets.all(3.h),
                    child: Column(
                      children: [
                        CustomTextField(
                          controller: loginProvider.emailController,
                          label: 'Email',
                          prefixIcon: Icon(
                            Icons.email_outlined,
                            color: Colors.white70,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        CustomTextField(
                          controller: loginProvider.passwordController,
                          label: 'Password',
                          prefixIcon: Icon(
                            Icons.lock_outline,
                            color: Colors.white70,
                          ),
                          obscureText: !loginProvider.isPasswordVisible,
                          suffixIcon: IconButton(
                            icon: Icon(
                              loginProvider.isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.white70,
                            ),
                            onPressed: loginProvider.togglePasswordVisibility,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 4.h),
                  if (loginProvider.isLoading)
                    Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  else
                    Column(
                      children: [
                        CustomButton(
                          text: 'Sign In',
                          onPressed: () => loginProvider.signIn(context),
                          textStyle: AppTheme.buttonTextStyle.copyWith(
                            fontSize: 15.sp,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          "or continue with",
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(height: 2.h),
                        CustomButton(
                          text: 'Google',
                          onPressed:
                              () => loginProvider.signInWithGoogle(context),
                          textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                          ),
                          color: const Color.fromARGB(255, 11, 3, 151),
                        ),
                      ], 
                    ),
                  SizedBox(height: 3.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account? ",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 10.sp,
                        ),
                      ),
                      GestureDetector(
                        onTap:
                            () => Navigator.pushReplacementNamed(
                              context,
                              '/signup',
                            ),
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 10.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
