// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:ui';

import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import 'package:amazon/constants/colors.dart';

class CostWidget extends ConsumerWidget {
  final Color? color;
  final double? cost;
  const CostWidget({
    super.key,
    required this.color,
    required this.cost,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "₦",
          style: TextStyle(
            fontSize: 10,
            color: color,
            fontFeatures: [
              FontFeature.subscripts(),
            ],
          ),
        ),
        Text(
          
          cost!.toInt().toString(),
          textAlign: TextAlign.center,
          style: TextStyle(
            color: color,
            fontSize: 25,
            fontWeight: FontWeight.w800,
          ),
        ),
        Text(
          (cost! - cost!.truncate()).toString(),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 10,
            fontFeatures: [
              FontFeature.subscripts(),
            ],
          ),
        ),
      ],
    );
  }
}
