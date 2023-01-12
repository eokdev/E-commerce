// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:ui';

import 'package:amazon/constants/colors.dart';
import 'package:amazon/constants/widgets.dart';
import 'package:amazon/models/productmodel.dart';
import 'package:amazon/models/userDetailsModel.dart';
import 'package:amazon/screens/productscreen.dart';
import 'package:amazon/screens/userDetailsBar.dart';
import 'package:amazon/utils/button.dart';
import 'package:amazon/utils/cartitem.dart';
import 'package:amazon/utils/costwidget.dart';
import 'package:amazon/utils/ratingstar.dart';
import 'package:amazon/utils/searchbar.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

class ResultWidget extends ConsumerWidget {
  final ProductModels? product;
  const ResultWidget({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
              builder: (context) => ProductScreen(productModels: product)),
        );
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: size.width / 3,
              child: Image.network(product!.url!),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 5),
              child: Text(product!.productName!),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 5),
              child: Row(
                children: [
                  SizedBox(
                    width: size.width / 5,
                    child: FittedBox(
                      child: RatingStar(rating: product!.rating),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      product!.numberOfRating.toString(),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: AppColor.activeCyanColor,
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
              child: FittedBox(
                child: CostWidget(
                  color: Color.fromARGB(255, 68, 6, 2),
                  cost: product!.cost,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
