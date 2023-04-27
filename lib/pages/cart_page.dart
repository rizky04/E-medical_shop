import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:http/http.dart';
import 'package:medical/network/api/url_api.dart';
import 'package:medical/network/model/cart_model.dart';
import 'package:medical/network/model/login_model.dart';
import 'package:medical/theme.dart';
import 'package:medical/widget/button_primary.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  String? userID, fullName, address, phone;
  getPref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      userID = pref.getString(PrefProfile.idUser);
      fullName = pref.getString(PrefProfile.name);
      address = pref.getString(PrefProfile.address);
      phone = pref.getString(PrefProfile.phone);
    });
    getCartes();
  }

  List<CartModel> listCart = [];
  getCartes() async {
    listCart.clear();
    var getCartss = Uri.parse(BASEURL.getCart + '$userID');
    final Response = await http.get(getCartss);
    if (Response.statusCode == 200) {
      setState(() {
        final data = jsonDecode(Response.body);
        for (Map<String, dynamic> item in data) {
          listCart.add(CartModel.fromJson(item));
        }
      });
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        padding: EdgeInsets.all(24),
        height: 220,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 236, 243, 233),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total Itemsss",
                  style: regulerTextStyle.copyWith(
                      fontSize: 16, color: greyBoldColor),
                ),
                Text(
                  "total",
                  style: boldTextStyle.copyWith(
                      fontSize: 16, color: greyBoldColor),
                )
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Delivery Fee",
                  style: regulerTextStyle.copyWith(
                      fontSize: 16, color: greyBoldColor),
                ),
                Text(
                  "total",
                  style: boldTextStyle.copyWith(
                      fontSize: 16, color: greyBoldColor),
                )
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total Payment",
                  style: regulerTextStyle.copyWith(
                      fontSize: 16, color: greyBoldColor),
                ),
                Text(
                  "total",
                  style: boldTextStyle.copyWith(
                      fontSize: 16, color: greyBoldColor),
                )
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: ButtonPrimary(text: "Checkout Now", onTap: () {}),
            )
          ],
        ),
      ),
      body: SafeArea(
          child: ListView(
        padding: EdgeInsets.only(bottom: 220),
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(24, 24, 24, 0),
            height: 70,
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
                SizedBox(
                  width: 30,
                ),
                Text(
                  "My Cart",
                  style: regulerTextStyle.copyWith(fontSize: 25),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(24),
            height: 166,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Delivery Destination",
                  style: regulerTextStyle.copyWith(fontSize: 18),
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Name",
                      style: regulerTextStyle.copyWith(fontSize: 16),
                    ),
                    Text(
                      '$fullName',
                      style: regulerTextStyle.copyWith(fontSize: 16),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Address",
                      style: regulerTextStyle.copyWith(fontSize: 16),
                    ),
                    Text(
                      '$address',
                      style: regulerTextStyle.copyWith(fontSize: 16),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Phone",
                      style: regulerTextStyle.copyWith(fontSize: 16),
                    ),
                    Text(
                      '$phone',
                      style: regulerTextStyle.copyWith(fontSize: 16),
                    ),
                  ],
                )
              ],
            ),
          ),
          ListView.builder(
              itemCount: listCart.length,
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemBuilder: (context, i) {
                final x = listCart[i];
                return Container(
                  padding: EdgeInsets.all(24),
                  color: whtiteColor,
                  child: Column(children: [
                    Row(
                      children: [
                        Row(
                          children: [
                            Image.network(
                              x.image,
                              width: 100,
                              height: 75,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width - 200,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    x.name,
                                    style:
                                        regulerTextStyle.copyWith(fontSize: 16),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.add_circle,
                                          color: greenColor,
                                        ),
                                      ),
                                      Text(x.quantity),
                                      IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.remove_circle,
                                          color: Colors.redAccent,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    x.price,
                                    style: boldTextStyle.copyWith(fontSize: 16),
                                  ),
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    Divider(),
                  ]),
                );
              })
        ],
      )),
    );
  }
}
