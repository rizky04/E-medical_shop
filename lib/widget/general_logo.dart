import 'package:flutter/cupertino.dart';

class GeneralLogoSpace extends StatelessWidget {
  final Widget? child;
  const GeneralLogoSpace({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: [
        const SizedBox(
          height: 50,
        ),
        Image.asset(
          "assets/logo.png",
          width: 150,
        ),
        child ?? const SizedBox()
      ],
    ));
  }
}
