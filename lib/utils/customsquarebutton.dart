// ignore_for_file: prefer_const_constructors

import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import 'package:amazon/constants/colors.dart';
import 'package:amazon/utils/costwidget.dart';

class CustomSquareButton extends ConsumerWidget {
  final Widget? child;
  final VoidCallback? onPressed;
  final Color? color;
  final double? dimension;
  const CustomSquareButton({super.key, 
    required this.child,
    required this.onPressed,
    required this.color,
   required this.dimension,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: dimension, 
        width: dimension,
        decoration: ShapeDecoration(
          color: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(2),
            side: BorderSide(
              color: Colors.grey,
              width: 1,
            ),
          ),
        ),
        child: Center(child: child),
      ),
    );
  }
}
