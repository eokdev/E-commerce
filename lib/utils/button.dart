// ignore_for_file: unused_local_variable, prefer_const_constructors

import 'package:amazon/constants/colors.dart';
import 'package:flutter/material.dart';

class ButtonCard extends StatefulWidget {
  final String? title;
  final Color? color;
  final bool? isLoading;
  const ButtonCard(
      {super.key,
      required this.title,
      required this.color,
      this.isLoading = false});

  @override
  State<ButtonCard> createState() => _ButtonCardState();
}

class _ButtonCardState extends State<ButtonCard> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: 30,
      width: size.width * 0.5,
      color: widget.color,
      child: widget.isLoading!
          ? Transform.scale(
              scale: 0.5,
              child: CircularProgressIndicator(
                color: AppColor.white,
              ),
            )
          : Center(
              child: Text(
                widget.title.toString(),
                textAlign: TextAlign.center,
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
              ),
            ),
    );
  }
}
