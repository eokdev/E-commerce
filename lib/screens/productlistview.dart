// ignore_for_file: unused_local_variable, prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:amazon/constants/colors.dart';
import 'package:flutter/material.dart';

class ProductListView extends StatelessWidget {
  final String? title;
  final List<Widget>? children;
  const ProductListView(
      {super.key, required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height / 4;
    double titlewidget = 25;
    return Container(
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(8),
      height: height,
      width: size.width,
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: titlewidget,
            child: Row(
              children: [
                Text(
                  title!,
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 14),
                  child: Text(
                    "Show more",
                    style: TextStyle(color: AppColor.activeCyanColor),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: height - (titlewidget + 26),
            width: size.width,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: children!,
            ),
          )
        ],
      ),
    );
  }
}
