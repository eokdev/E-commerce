// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors

import 'package:amazon/constants/widgets.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../screens/resultscreen.dart';

class CategoryHLVB extends ConsumerWidget {
  const CategoryHLVB({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 80,
      width: double.infinity,
      color: Colors.white,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: Screens.categoryLogos.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                     Navigator.push(
          context,
          CupertinoPageRoute(
            builder: ((context) =>
                ResultScreen(query: Screens.categoryText[index])),
          ),
        );
              },
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          child: Image(
                            image: NetworkImage(
                              Screens.categoryLogos[index],
                            ),
                          )),
                    ),
                    Text(Screens.categoryText[index])
                  ],
                ),
              ),
            );
          }),
    );
  }
}
