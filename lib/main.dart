import 'package:flutter/material.dart';
import 'package:medical/pages/login_page.dart';
import 'package:medical/pages/main_page.dart';
import 'package:medical/pages/register_page.dart';
import 'package:medical/pages/splash_screen.dart';
import 'package:medical/theme.dart';
import 'package:medical/widget/button_primary.dart';
import 'package:medical/widget/general_logo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: greenColor),
      home: MainPage(),
      // home: RegisterPages(),
      // home: LoginPages(),
      // home: SplashScreen(),
    );
  }
}
