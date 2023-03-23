// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables
import 'package:flutter/material.dart';
import 'package:medical/network/model/login_model.dart';
import 'package:medical/pages/login_page.dart';
import 'package:medical/pages/main_page.dart';
import 'package:medical/widget/button_primary.dart';
import 'package:medical/widget/general_logo.dart';
import 'package:medical/widget/widget_ilustration.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? userID;
  getPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      userID = sharedPreferences.getString(PrefProfile.idUser);
      userID == null ? sessionLogout() : sessionLogin();
    });
  }

  sessionLogin() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const MainPage()));
  }

  sessionLogout() {}

  @override
  void initState() {
    super.initState();
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GeneralLogoSpace(
          child: Column(
        children: [
          const SizedBox(
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
                      builder: (context) => const LoginPages(),
                    ));
              },
            ),
          ),
        ],
      )),
    );
  }
}
