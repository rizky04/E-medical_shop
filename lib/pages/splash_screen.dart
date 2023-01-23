import 'package:flutter/material.dart';
import 'package:medical/pages/register_page.dart';
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
            title: "Find your medical ",
            title2: "solution",
            subtitle1: "Consult with a doctor",
            subtitle2: 'Whereever adn whenever you want',
            child: ButtonPrimary(
              text: "Get Started",
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegisterPages(),
                    ));
              },
            ),
          ),
        ],
      )),
    );
  }
}
