import 'dart:convert';
import 'dart:async';
import 'dart:core';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:medical/network/api/url_api.dart';
import 'package:medical/network/model/product_model.dart';
import 'package:medical/theme.dart';
import 'package:medical/widget/card_category.dart';
import 'package:medical/widget/card_product.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int? index;
  bool filter = false;
  List<CatergoryWithProduct> listCategory = [];
  getCategory() async {
    listCategory.clear();
    var urlCategory = Uri.parse(BASEURL.apiCategory);
    final response = await http.get(urlCategory);
    if (response.statusCode == 200) {
      setState(() {
        final data = json.decode(response.body);
        for (Map<String, dynamic> item in data) {
          listCategory.add(CatergoryWithProduct.fromJson(item));
        }
      });
      getProduct();
    }
  }

  List<ProductModel> listProduct = [];
  getProduct() async {
    listProduct.clear();
    var urlProduct = Uri.parse(BASEURL.apiProduct);
    final response = await http.get(urlProduct);
    if (response.statusCode == 200) {
      setState(() {
        final data = jsonDecode(response.body);
        for (Map<String, dynamic> items in data) {
          listProduct.add(ProductModel.fromJson(items));
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getCategory();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ListView(
        padding: EdgeInsets.fromLTRB(24, 30, 24, 30),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Image.asset(
                    'assets/logo.png',
                    width: 155,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    "Find a medicine or\n vitamins with MEDHEALT!",
                    style: regulerTextStyle.copyWith(
                        fontSize: 15, color: greyBoldColor),
                  )
                ],
              ),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.shopping_cart_outlined,
                    color: greenColor,
                  ))
            ],
          ),
          SizedBox(
            height: 24,
          ),
          Container(
            height: 55,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color(0xffe4faf0)),
            child: TextField(
              decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(
                    Icons.search,
                    color: Color(0xffb1d8b2),
                  ),
                  hintText: "Search medicine...?",
                  hintStyle:
                      regulerTextStyle.copyWith(color: Color(0xffb0d8b2))),
            ),
          ),
          SizedBox(
            height: 32,
          ),
          Text(
            "Medicine & vitamins by Category",
            style: regulerTextStyle.copyWith(fontSize: 16),
          ),
          SizedBox(
            height: 14,
          ),
          GridView.builder(
              physics: ClampingScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4, mainAxisSpacing: 10),
              itemCount: listCategory.length,
              shrinkWrap: true,
              itemBuilder: (context, i) {
                final x = listCategory[i];
                return InkWell(
                  onTap: () {
                    setState(() {
                      index = i;
                      filter = true;
                      print("$index, $filter");
                    });
                  },
                  child: CardCategory(
                    imageCategory: x.image,
                    nameCategory: x.category,
                  ),
                );
              }),
          SizedBox(
            height: 30,
          ),
          filter
              ? index == 7
                  ? Text("featrue on progress")
                  : GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16),
                      itemCount: listCategory[index!].product.length,
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemBuilder: (context, i) {
                        final y = listCategory[index!].product[i];
                        return CardProduct(
                          image: y.image,
                          name: y.name,
                          price: y.price,
                        );
                      })
              : GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16),
                  itemCount: listProduct.length,
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemBuilder: (context, i) {
                    final y = listProduct[i];
                    return CardProduct(
                      image: y.image,
                      name: y.name,
                      price: y.price,
                    );
                  }),
        ],
      )),
    );
  }
}
