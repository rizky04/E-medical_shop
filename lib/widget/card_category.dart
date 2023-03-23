// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:medical/theme.dart';

class CardCategory extends StatelessWidget {
  final String imageCategory;
  final String nameCategory;

  const CardCategory({super.key, 
    required this.imageCategory,
    required this.nameCategory,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          imageCategory,
          width: 65,
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          nameCategory,
          style: mediumTextStyle.copyWith(fontSize: 10),
        )
      ],
    );
  }
}
