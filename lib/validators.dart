// String? validateEmail(String? value) {
//   if (value == null || value.isEmpty) {
//     return 'Email is required';
//   }
//   final RegExp emailRegExp = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
//   if (!emailRegExp.hasMatch(value)) {
//     return 'Enter a valid email';
//   }
//   return null;
// }

// String? validatePassword(String? value) {
//   if (value == null || value.isEmpty) {
//     return 'Password is required';
//   }
//   if (value.length < 6) {
//     return 'Password should be at least 6 characters';
//   }
//   return null;
// }
