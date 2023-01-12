// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:amazon/constants/colors.dart';
import 'package:amazon/utils/costwidget.dart';
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

class ProductInfo extends ConsumerWidget {
  final String? name;
  final double? cost;
  final String? seller;
  ProductInfo({
    super.key,
    required this.name,
    required this.cost,
    required this.seller,
  });
  SizedBox space = SizedBox(
    height: 7,
  );
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width / 2,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name!,
            maxLines: 2,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15,
              letterSpacing: 0.7,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          space,
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 7),
              child: CostWidget(color: Colors.black, cost: cost),
            ),
          ),
          space,
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "Sold by ",
                  style: TextStyle(color: Colors.grey[700], fontSize: 14),
                ),
                TextSpan(
                  text: seller,
                  style:
                      TextStyle(color: AppColor.activeCyanColor, fontSize: 14),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
