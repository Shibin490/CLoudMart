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
            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 3.h),
                Text(
                  'Welcome\nBack',
                  style: AppTheme.headerTextStyle.copyWith(fontSize: 28.sp),
                ),
                Text(
                  'Login to continue your journey',
                  style: AppTheme.subHeaderTextStyle.copyWith(fontSize: 14.sp),
                ),
                SizedBox(height: 2.5.h),
                Container(
                  padding: EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(16),
                  ),
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
                      SizedBox(height: 10),
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
                SizedBox(height: 15),
                loginProvider.isLoading
                    ? Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                    : Column(
                      children: [
                        CustomButton(
                          text: 'Sign In',
                          onPressed: () => loginProvider.signIn(context),
                          color: Colors.white,
                          textStyle: TextStyle(
                            color: AppTheme.primaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          width: 280,
                          height: 50,
                        ),

                        SizedBox(height: 10),

                        Text(
                          'Or sign in with',
                          style: TextStyle(color: Colors.white70, fontSize: 12),
                        ),

                        SizedBox(height: 10),

                        CustomButton(
                          text: 'Continue with Google',
                          onPressed:
                              () => loginProvider.signInWithGoogle(context),
                          // icon: Image.asset(
                          //   'assets/icons/google.png',
                          //   height: 24,
                          //   width: 24,
                          // ),
                          color: Colors.white,
                          textStyle: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                          width: 280,
                          height: 50,
                        ),

                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account? ",
                              style: TextStyle(color: Colors.white70),
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
