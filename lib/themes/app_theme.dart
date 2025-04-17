import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color.fromARGB(255, 26, 5, 146);
  static const Color secondaryColor = Color.fromARGB(255, 2, 7, 13);
  static const Color white70 = Colors.white70;

  static final TextStyle headerTextStyle = TextStyle(
    color: Colors.white,
    fontSize: 40,
    fontWeight: FontWeight.bold,
    height: 1.2,
  );

  static final TextStyle subHeaderTextStyle = TextStyle(
    color: Colors.white70,
    fontSize: 16,
  );

  static final TextStyle buttonTextStyle = TextStyle(
    color: primaryColor,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );

  static final TextStyle labelTextStyle = TextStyle(
    color: Colors.white70,
  );

  // 👇 Add a ThemeData configuration for your app
  static final ThemeData lightTheme = ThemeData(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: Colors.transparent,
    fontFamily: 'Roboto',
    textTheme: TextTheme(
      headlineLarge: headerTextStyle,
      titleMedium: subHeaderTextStyle,
      labelLarge: buttonTextStyle,
      labelSmall: labelTextStyle,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: buttonTextStyle,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: labelTextStyle,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.white24),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.white),
      ),
    ),
    iconTheme: IconThemeData(color: white70),
  );
}
