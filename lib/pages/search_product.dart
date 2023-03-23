// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables
import 'dart:convert';
import 'dart:core';

import 'package:flutter/material.dart';

import 'package:medical/network/api/url_api.dart';
import 'package:medical/network/model/product_model.dart';
import 'package:medical/pages/detail_product.dart';
import 'package:medical/theme.dart';
import 'package:medical/widget/card_product.dart';
import 'package:medical/widget/widget_ilustration.dart';
import 'package:http/http.dart' as http;

class SearchProduct extends StatefulWidget {
  const SearchProduct({Key? key}) : super(key: key);

  @override
  State<SearchProduct> createState() => _SearchProductState();
}

class _SearchProductState extends State<SearchProduct> {
  TextEditingController searchController = TextEditingController();
  List<ProductModel> listProduct = [];
  List<ProductModel> listSearchProduct = [];
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

  SearchProduct(String text) {
    listSearchProduct.clear();
    if (text.isEmpty) {
      setState(() {});
    } else {
      for (var element in listProduct) {
        if (element.name.toLowerCase().contains(text)) {
          listSearchProduct.add(element);
        }
      }
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    getProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
              height: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                    width: MediaQuery.of(context).size.width - 100,
                    height: 55,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xffe4faf0)),
                    child: TextField(
                      onChanged: SearchProduct,
                      controller: searchController,
                      autofocus: true,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: const Icon(
                            Icons.search,
                            color: Color(0xffb1d8b2),
                          ),
                          hintText: "Search medicine...?",
                          hintStyle: regulerTextStyle.copyWith(
                              color: const Color(0xffb0d8b2))),
                    ),
                  ),
                ],
              ),
            ),
            searchController.text.isEmpty || listSearchProduct.isEmpty
                ? const Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 24, vertical: 80),
                    child: WidgetIlustration(
                      image: "assets/no_data_ilustration.png",
                      title: "There is no medicine ",
                      title2: "that is looking for",
                      subtitle1: "please find the product you want",
                      subtitle2: "the product will appear here",
                    ),
                  )
                : Container(
                    padding: const EdgeInsets.all(24),
                    child: GridView.builder(
                        padding: EdgeInsets.zero,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 1.0,
                          crossAxisCount: 2,
                          mainAxisSpacing: 6,
                          crossAxisSpacing: 6,
                        ),
                        itemCount: listSearchProduct.length,
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        itemBuilder: (context, i) {
                          final y = listSearchProduct[i];
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          DetailProduct(productModel: y)));
                            },
                            child: CardProduct(
                                image: y.image, name: y.name, price: y.price),
                          );
                        }),
                  ),
          ],
        ),
      ),
    );
  }
}
