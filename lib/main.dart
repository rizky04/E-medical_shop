import 'package:flutter/material.dart';
import 'package:medical/pages/splash_screen.dart';
import 'package:medical/theme.dart';

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
      // home: MainPage(),
      // home: RegisterPages(),
      // home: LoginPages(),
      home: const SplashScreen(),
    );
  }
}
