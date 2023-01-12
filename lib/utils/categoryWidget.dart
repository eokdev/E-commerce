// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:amazon/constants/colors.dart';
import 'package:amazon/constants/widgets.dart';
import 'package:amazon/models/productmodel.dart';
import 'package:amazon/models/userDetailsModel.dart';
import 'package:amazon/screens/resultscreen.dart';
import 'package:amazon/screens/userDetailsBar.dart';
import 'package:amazon/utils/button.dart';
import 'package:amazon/utils/cartitem.dart';
import 'package:amazon/utils/searchbar.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

class CategoryWidget extends ConsumerWidget {
  final int? index;
  const CategoryWidget({super.key, required this.index});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: ((context) =>
                ResultScreen(query: Screens.categoryText[index!])),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 8,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.network(
                Screens.categoryLogos[index!],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  Screens.categoryText[index!].toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.w500, letterSpacing: 0.5),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
