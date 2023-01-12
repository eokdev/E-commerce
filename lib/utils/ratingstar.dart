// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:amazon/constants/colors.dart';
import 'package:amazon/constants/widgets.dart';
import 'package:amazon/models/productmodel.dart';
import 'package:amazon/models/userDetailsModel.dart';
import 'package:amazon/screens/userDetailsBar.dart';
import 'package:amazon/utils/button.dart';
import 'package:amazon/utils/cartitem.dart';
import 'package:amazon/utils/resultswidget.dart';
import 'package:amazon/utils/searchbar.dart';
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

class RatingStar extends ConsumerWidget {
  final int? rating;
  const RatingStar({super.key, required this.rating});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Widget> children = [];
    for (int i = 0; i < 5; i++) {
      children.add(
        i < rating!
            ? Icon(
                Icons.star,
                color: Colors.orange,
              )
            : Icon(
                Icons.star_border,
                color: Colors.orange,
              ),
      );
    }
    return Row(
      children: children,
    );
  }
}
