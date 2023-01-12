// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:amazon/backend/firestore.dart';
import 'package:amazon/constants/colors.dart';
import 'package:amazon/models/productmodel.dart';
import 'package:amazon/screens/productscreen.dart';
import 'package:amazon/utils/CustomRoundedButton.dart';
import 'package:amazon/utils/customsquarebutton.dart';
import 'package:amazon/utils/productinfo.dart';
import 'package:amazon/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

class CartItem extends ConsumerWidget {
  final ProductModels? product;
  const CartItem({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(25),
      height: size.height / 2,
      width: size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: AppColor.grey, width: 1),
        ),
      ),
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: ((context) =>
                        ProductScreen(productModels: product)),
                  ),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: size.width / 3,
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Image.network(
                        product!.url.toString(),
                      ),
                    ),
                  ),
                  ProductInfo(
                      name: product!.productName,
                      cost: product!.cost,
                      seller: product!.sellerName)
                ],
              ),
            ),
          ),
          Expanded(
              flex: 1,
              child: Row(
                children: [
                  CustomSquareButton(
                    onPressed: () {},
                    color: AppColor.backgroundColor,
                    dimension: 25,
                    child: Icon(Icons.remove),
                  ),
                  CustomSquareButton(
                    onPressed: () {},
                    color: Colors.white,
                    dimension: 25,
                    child: Text(
                      "0",
                      style: TextStyle(
                        color: AppColor.activeCyanColor,
                      ),
                    ),
                  ),
                  CustomSquareButton(
                    onPressed: () async {
                      await CloudFireStore().addProductToCart(
                        models: ProductModels(
                            url: product!.url,
                            productName: product!.productName,
                            cost: product!.cost,
                            discount: product!.discount,
                            uid: Utils().getUid(),
                            sellerName: product!.sellerName,
                            sellerUid: product!.sellerName,
                            rating: product!.rating,
                            numberOfRating: product!.numberOfRating),
                      );
                    },
                    color: AppColor.backgroundColor,
                    dimension: 25,
                    child: Icon(Icons.add),
                  ),
                ],
              )),
          Expanded(
              flex: 2,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Row(
                      children: [
                        CustomRoundedButton(
                          onPressed: () async {
                            CloudFireStore()
                                .deleteProductFromCart(uid: product!.uid);
                          },
                          text: "Delete",
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        CustomRoundedButton(
                          onPressed: () {},
                          text: "Save for later",
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 3),
                    child: Text(
                      "See more of this",
                      style: TextStyle(
                        color: AppColor.activeCyanColor,
                      ),
                    ),
                  )
                ],
              )),
        ],
      ),
    );
  }
}
