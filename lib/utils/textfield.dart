// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, sized_box_for_whitespace

import 'package:amazon/constants/colors.dart';
import 'package:flutter/material.dart';

class TextFieldd extends StatelessWidget {
  final TextEditingController? controller;
  final String? title;
  final bool? obscure;
final String? hintText;
  const TextFieldd(
      {super.key,
      required this.controller,
      required this.title,
      required this.hintText,
      this.obscure = false, });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title.toString(),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          height: 40,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: AppColor.grey,
            ),
          ),
          child: TextFormField(
            controller: controller,
            obscureText: obscure!,
            decoration: InputDecoration(border: InputBorder.none),
         
          ),
        )
      ],
    );
  }
}
