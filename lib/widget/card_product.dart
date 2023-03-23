import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:medical/theme.dart';
import 'package:flutter/material.dart';
import 'package:medical/network/model/product_model.dart';

class CardProduct extends StatelessWidget {
  final String image;
  final String name;
  final String price;
  const CardProduct(
      {required this.image, required this.name, required this.price});

  @override
  Widget build(BuildContext context) {
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
          SizedBox(
            height: 16,
          ),
          Text(
            name,
            style: regulerTextStyle,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 14,
          ),
          Text(
            price,
            style: boldTextStyle,
          )
        ],
      ),
    );
  }
}
