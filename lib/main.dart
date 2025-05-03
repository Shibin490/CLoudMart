import 'package:cloud_mart/providers/home_provider.dart';
import 'package:cloud_mart/providers/login_provider.dart';
import 'package:cloud_mart/providers/signup_provider.dart';
import 'package:cloud_mart/providers/add_product_provider.dart';
import 'package:cloud_mart/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'services/auth_service.dart';
import 'themes/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => AuthService()),
            ChangeNotifierProvider(create: (_) => SignUpProvider()),
            ChangeNotifierProvider(create: (_) => LoginProvider()),
            ChangeNotifierProvider(create: (_) => AddProductProvider()),
            ChangeNotifierProvider(create: (_) => HomeProvider()),
            
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Cloud Mart',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.lightTheme,
            themeMode: ThemeMode.dark,
            initialRoute: '/',
            routes: AppRoutes.routes,
          ),
        );
      },
    );
  }
}
