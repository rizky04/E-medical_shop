import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart';
import 'package:medical/network/api/url_api.dart';
import 'package:medical/pages/main_page.dart';
import 'package:medical/pages/register_page.dart';
import 'package:medical/theme.dart';
import 'package:medical/widget/button_primary.dart';
import 'package:medical/widget/general_logo.dart';
import 'package:http/http.dart' as http;

class LoginPages extends StatefulWidget {
  const LoginPages({super.key});

  @override
  State<LoginPages> createState() => _LoginPagesState();
}

class _LoginPagesState extends State<LoginPages> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  loginSubmit() async {
    var loginURl = Uri.parse(BASEURL.apiLogin);
    final Response = await http.post(loginURl, body: {
      "email": emailController.text,
      "password": passwordController.text
    });
    final data = jsonDecode(Response.body);
    int value = data['value'];
    String message = data['message'];
    if (value == 1) {
      showDialog(
          context: context,
          builder: ((context) => AlertDialog(
                title: Text(message),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => MainPage()),
                            (route) => false);
                      },
                      child: Text("oke"))
                ],
              )));
    } else {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text("information"),
                content: Text(message),
                actions: [TextButton(onPressed: () {}, child: Text("oke"))],
              ));
    }
  }

  bool _isOke = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(
            height: 150,
          ),
          Container(
            child: GeneralLogoSpace(),
          ),
          Container(
            padding: EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Login",
                  style: regulerTextStyle.copyWith(fontSize: 25),
                ),
                Text(
                  "Login into your account",
                  style: regulerTextStyle.copyWith(
                      fontSize: 15, color: greyLightColor),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  padding: EdgeInsets.only(left: 16),
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                            color: Color(0x40000000),
                            offset: Offset(0, 1),
                            blurRadius: 4,
                            spreadRadius: 0)
                      ],
                      color: whtiteColor),
                  width: MediaQuery.of(context).size.width,
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Email',
                        hintStyle: lightTextStyle.copyWith(
                            fontSize: 15, color: greyLightColor)),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.only(left: 16),
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                            color: Color(0x40000000),
                            offset: Offset(0, 1),
                            blurRadius: 4,
                            spreadRadius: 0)
                      ],
                      color: whtiteColor),
                  width: MediaQuery.of(context).size.width,
                  child: TextField(
                    controller: passwordController,
                    obscureText: _isOke,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Password',
                        hintStyle: lightTextStyle.copyWith(
                            fontSize: 15, color: greyLightColor),
                        suffixIcon: IconButton(
                          icon: Icon(
                              _isOke ? Icons.visibility : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              _isOke = !_isOke;
                            });
                          },
                        )),
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(24),
            child: ButtonPrimary(
                text: "Login",
                onTap: () {
                  if (emailController.text.isEmpty ||
                      passwordController.text.isEmpty) {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: Text("warning !!"),
                              content: Text('please, enter the field'),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text("oke"))
                              ],
                            ));
                  } else {
                    loginSubmit();
                  }
                }),
          ),
          SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Dont have an account ?"),
              SizedBox(
                width: 5,
              ),
              InkWell(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterPages()),
                      (route) => false);
                },
                child: Text(
                  "Register Now",
                  style:
                      boldTextStyle.copyWith(color: greenColor, fontSize: 15),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
