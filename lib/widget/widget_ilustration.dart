import 'package:flutter/cupertino.dart';
import 'package:medical/theme.dart';

class WidgetIlustration extends StatelessWidget {
  final Widget? child;
  final String? image;
  final String? title;
  final String? title2;
  final String? subtitle1;
  final String? subtitle2;
  const WidgetIlustration(
      {super.key, this.child,
      this.image,
      this.title,
      this.title2,
      this.subtitle1,
      this.subtitle2});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          image!,
          width: 250,
        ),
        const SizedBox(
          height: 100,
        ),
        Text(
          title!,
          style: regulerTextStyle.copyWith(fontSize: 25),
          textAlign: TextAlign.center,
        ),
        Text(
          title2!,
          style: regulerTextStyle.copyWith(fontSize: 25),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 16,
        ),
        Column(
          children: [
            Text(
              subtitle1!,
              style: regulerTextStyle.copyWith(
                  fontSize: 15, color: greyLightColor),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              subtitle2!,
              style: regulerTextStyle.copyWith(
                  fontSize: 15, color: greyLightColor),
            ),
            const SizedBox(
              height: 100,
            ),
            child ?? const SizedBox(),
          ],
        )
      ],
    );
  }
}
