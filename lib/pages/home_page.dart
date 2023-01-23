import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:medical/theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ListView(
        padding: EdgeInsets.fromLTRB(24, 30, 24, 30),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Image.asset(
                    'assets/logo.png',
                    width: 155,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    "Find a medicine or\n vitamins with MEDHEALT!",
                    style: regulerTextStyle.copyWith(
                        fontSize: 15, color: greyBoldColor),
                  )
                ],
              )
            ],
          )
        ],
      )),
    );
  }
}
