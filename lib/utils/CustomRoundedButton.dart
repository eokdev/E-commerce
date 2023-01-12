// ignore_for_file: prefer_const_constructors

import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import 'package:amazon/constants/colors.dart';
import 'package:amazon/utils/customsquarebutton.dart';
import 'package:amazon/utils/productinfo.dart';

class CustomRoundedButton extends ConsumerWidget {
  final VoidCallback? onPressed;
  final String? text;

  const CustomRoundedButton({
    super.key,
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
          border: Border.all(
            color: Colors.grey,
            width: 1,
          ),
        ),
        child: Text(text!),
      ),
    );
  }
}
