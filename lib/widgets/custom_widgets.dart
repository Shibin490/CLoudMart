// ignore_for_file: unnecessary_import
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final Icon prefixIcon;
  final bool obscureText;
  final VoidCallback? onSuffixIconPressed;
  final Widget? suffixIcon;
  final Color borderColor;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.prefixIcon,
    this.obscureText = false,
    this.onSuffixIconPressed,
    this.suffixIcon,
    this.borderColor = Colors.white24,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      obscureText: obscureText,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.transparent, 
        prefixIcon: prefixIcon,
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white70),
        suffixIcon: suffixIcon,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: borderColor),
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final TextStyle textStyle;
  final Widget? icon;
  final double? width; // ⬅️ Optional width
  final double? height; // ⬅️ Optional height

  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.color = Colors.white,
    required this.textStyle,
    this.icon,
    this.width, // ⬅️ Added here
    this.height, // ⬅️ Added here
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? 56,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[icon!, const SizedBox(width: 10)],
            Text(text, style: textStyle),
          ],
        ),
      ),
    );
  }
}
