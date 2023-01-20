import 'package:flutter/material.dart';
import 'package:medical/widget/button_primary.dart';
import 'package:medical/widget/general_logo.dart';
import 'package:medical/widget/widget_ilustration.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GeneralLogoSpace(
          child: Column(
        children: [
          SizedBox(
            height: 45,
          ),
          WidgetIlustration(
            image: "assets/splash_ilustration.png",
            title: "title",
            subtitle1: "subtitle",
            subtitle2: 'subtitle2',
            child: ButtonPrimary(
              text: "Get Started",
              onTap: () {},
            ),
          ),
        ],
      )),
    );
  }
}
