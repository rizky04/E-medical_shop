import 'package:flutter/cupertino.dart';
import 'package:medical/theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CardProduct extends StatelessWidget {
  final String image;
  final String name;
  final String price;
  const CardProduct(
      {super.key, required this.image, required this.name, required this.price});

  @override
  Widget build(BuildContext context) {
    final priceFormat = NumberFormat("#,##0", "EN_US");
    return Container(
      decoration: BoxDecoration(
        color: whtiteColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Image.network(
            image,
            width: 115,
            height: 76,
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            name,
            style: regulerTextStyle,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 14,
          ),
          Text(
            priceFormat.format(int.parse(price)),
            style: boldTextStyle,
          )
        ],
      ),
    );
  }
}
