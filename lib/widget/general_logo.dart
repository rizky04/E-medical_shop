import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class GeneralLogoSpace extends StatelessWidget {
  final Widget? child;
  GeneralLogoSpace({this.child});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: [
        SizedBox(
          height: 50,
        ),
        Image.asset(
          "assets/logo.png",
          width: 150,
        ),
        child ?? SizedBox()
      ],
    ));
  }
}
