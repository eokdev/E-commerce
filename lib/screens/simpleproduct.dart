// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:amazon/models/productmodel.dart';
import 'package:amazon/screens/productscreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SimpleProduct extends StatelessWidget {
  final ProductModels? productModels;
  const SimpleProduct({super.key, required this.productModels});

  @override
  Widget build(BuildContext context) {
  
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
              builder: (context) =>
                  ProductScreen(productModels: productModels!)),
        );
      },
      child: AspectRatio(
        aspectRatio: 1 / 1,
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Image.network(
              productModels!.url.toString(),
            ),
          ),
        ),
      ),
    );
  }
}
