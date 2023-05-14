import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:http/http.dart';
import 'package:medical/network/api/url_api.dart';
import 'package:medical/network/model/cart_model.dart';
import 'package:medical/network/model/login_model.dart';
import 'package:medical/pages/main_page.dart';
import 'package:medical/theme.dart';
import 'package:medical/widget/button_primary.dart';
import 'package:medical/widget/widget_ilustration.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final price = NumberFormat('#,##0', "EN_US");
  bool loadingnya = false;
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
    cartTotalPrice();
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

  updateQty(String tipe, String model) async {
    var urlUpdateQty = Uri.parse(BASEURL.updateQTYCart);
    final Response =
        await http.post(urlUpdateQty, body: {"cartID": model, "tipe": tipe});
    final data = jsonDecode(Response.body);
    int value = data['value'];
    String message = data['message'];
    if (value == 1) {
      print(message);
      setState(() {
        loadingnya = true;
        getPref();
      });
      await Future.delayed(Duration(seconds: 1));
      setState(() {
        loadingnya = false;
      });
    } else {
      print(message);
      setState(() {
        loadingnya = true;
        getPref();
      });
      await Future.delayed(Duration(seconds: 1));
      setState(() {
        loadingnya = false;
      });
    }
  }

  var sumPrice = "0";
  int totalPay = 0;
  int delivery = 0;
  cartTotalPrice() async {
    var urlTotalPrice = Uri.parse(BASEURL.totalQTYCart + '$userID');
    final Response = await http.get(urlTotalPrice);
    if (Response.statusCode == 200) {
      final data = jsonDecode(Response.body);
      if (data['Total'] == null) {
        setState(() {});
      } else {
        String total = data['Total'];
        setState(() {
          sumPrice = total;
          totalPay = sumPrice == null ? 0 : int.parse(sumPrice) + delivery;
        });
        print(sumPrice);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    return loadingnya
        ? animasiLoading()
        : Scaffold(
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: listCart.length == 0
                ? SizedBox()
                : Container(
                    padding: EdgeInsets.all(24),
                    height: 220,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 236, 243, 233),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30))),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total Item",
                              style: regulerTextStyle.copyWith(
                                  fontSize: 16, color: greyBoldColor),
                            ),
                            Text(
                              "IDR " + price.format(int.parse(sumPrice)),
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
                              "IDR " + price.format(delivery),
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
                              "IDR " + price.format(totalPay),
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
                          child:
                              ButtonPrimary(text: "Checkout Now", onTap: () {}),
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
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MainPage()),
                              (route) => false);
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
                listCart.length == 0 || listCart.length == null
                    ? Container(
                        padding: EdgeInsets.all(24),
                        margin: EdgeInsets.only(top: 30),
                        child: WidgetIlustration(
                          image: "assets/empty_cart_ilustration.png",
                          title: "Oops, there are no product in your cart",
                          title2: "Your cars is strill empty, browser the",
                          subtitle1: "atractive product from",
                          subtitle2: "MEDHEALT",
                          child: Container(
                            margin: EdgeInsets.only(top: 5),
                            width: MediaQuery.of(context).size.width,
                            child: ButtonPrimary(
                                text: "Shopping Now",
                                onTap: () {
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MainPage()),
                                      (route) => false);
                                }),
                          ),
                        ),
                      )
                    : Container(
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
                                  style:
                                      regulerTextStyle.copyWith(fontSize: 16),
                                ),
                                Text(
                                  '$fullName',
                                  style:
                                      regulerTextStyle.copyWith(fontSize: 16),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Address",
                                  style:
                                      regulerTextStyle.copyWith(fontSize: 16),
                                ),
                                Text(
                                  '$address',
                                  style:
                                      regulerTextStyle.copyWith(fontSize: 16),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Phone",
                                  style:
                                      regulerTextStyle.copyWith(fontSize: 16),
                                ),
                                Text(
                                  '$phone',
                                  style:
                                      regulerTextStyle.copyWith(fontSize: 16),
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
                                    width:
                                        MediaQuery.of(context).size.width - 200,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          x.name,
                                          style: regulerTextStyle.copyWith(
                                              fontSize: 16),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            IconButton(
                                              onPressed: () {
                                                updateQty("tambah", x.id_cart);
                                              },
                                              icon: Icon(
                                                Icons.add_circle,
                                                color: greenColor,
                                              ),
                                            ),
                                            Text(x.quantity),
                                            IconButton(
                                              onPressed: () {
                                                updateQty("kurang", x.id_cart);
                                              },
                                              icon: Icon(
                                                Icons.remove_circle,
                                                color: Colors.redAccent,
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                updateQty("kurang", x.id_cart);
                                              },
                                              icon: Icon(
                                                Icons.restore_from_trash,
                                                color: Colors.redAccent,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          "IDR " +
                                              price.format(int.parse(x.price)),
                                          style: boldTextStyle.copyWith(
                                              fontSize: 16),
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

class animasiLoading extends StatelessWidget {
  const animasiLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: LoadingAnimationWidget.halfTriangleDot(
          // leftDotColor: const Color(0xFF1A1A3F),
          // rightDotColor: const Color(0xFFEA3799),
          color: greenColor,
          size: 50,
        ),
      ),
    );
  }
}
