import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:medical/network/api/url_api.dart';
import 'package:medical/network/model/login_model.dart';
import 'package:medical/network/model/product_model.dart';
import 'package:medical/pages/main_page.dart';
import 'package:medical/pages/cart_page.dart';
import 'package:medical/theme.dart';
import 'package:medical/widget/button_primary.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DetailProduct extends StatefulWidget {
  final ProductModel productModel;
  const DetailProduct({super.key, required this.productModel});

  @override
  State<DetailProduct> createState() => _DetailProductState();
}

class _DetailProductState extends State<DetailProduct> {
  final priceFormat = NumberFormat("#,##0", "EN_US");

  String? userID;
  getPref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      userID = pref.getString(PrefProfile.idUser);
    });
  }

  addToCart() async {
    var addCart = Uri.parse(BASEURL.addToCart);
    final Response = await http.post(addCart, body: {
      "id_user": userID, //ini hasilnya null
      "id_product": widget.productModel.id_product, // ini juga null
    });
    final data = jsonDecode(Response.body);
    int value = data['value'];
    String message = data['message'];
    if (value == 1) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text("Information"),
                content: Text(message),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => CartPage()),
                            (route) => false);
                      },
                      child: Text("OK"))
                ],
              ));
      setState(() {});
    } else {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text("Information"),
                content: Text(message),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("oke"))
                ],
              ));
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    getPref();
  }

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
                  "Detail Product ",
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
                  onTap: () {
                    addToCart();
                  },
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
