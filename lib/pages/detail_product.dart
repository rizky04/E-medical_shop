import 'package:flutter/material.dart';
import 'package:medical/network/model/product_model.dart';
import 'package:medical/theme.dart';
import 'package:medical/widget/button_primary.dart';
import 'package:intl/intl.dart';

class DetailProduct extends StatefulWidget {
  final ProductModel productModel;
  const DetailProduct({super.key, required this.productModel});

  @override
  State<DetailProduct> createState() => _DetailProductState();
}

class _DetailProductState extends State<DetailProduct> {
  final priceFormat = NumberFormat("#,##0", "EN_US");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ListView(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
        children: [
          SizedBox(
            height: 80,
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back_rounded,
                    size: 32,
                    color: greenColor,
                  ),
                ),
                const SizedBox(
                  width: 30,
                ),
                Text(
                  "Detail Product",
                  style: regulerTextStyle.copyWith(fontSize: 25),
                )
              ],
            ),
          ),
          Container(
            height: 200,
            color: whtiteColor,
            child: Image.network(widget.productModel.image),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                widget.productModel.name,
                style: regulerTextStyle.copyWith(fontSize: 20),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                widget.productModel.description,
                style: regulerTextStyle.copyWith(
                    fontSize: 14, color: greyLightColor),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(
                height: 64,
              ),
              Row(
                children: [
                  const Spacer(),
                  Text(
                    "Rp " +
                        priceFormat
                            .format(int.parse(widget.productModel.price)),
                    // "Rp.${widget.productModel.price}",
                    style: boldTextStyle.copyWith(fontSize: 20),
                  ),
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ButtonPrimary(
                  onTap: () {},
                  text: "ADD TO CART",
                ),
              )
            ]),
          ),
        ],
      )),
    );
  }
}
