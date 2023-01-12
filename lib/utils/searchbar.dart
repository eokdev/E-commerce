// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, unused_local_variable, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables

import 'package:amazon/constants/colors.dart';
import 'package:amazon/screens/resultscreen.dart';
import 'package:amazon/screens/searchScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchBar extends StatelessWidget with PreferredSizeWidget {
  final bool? isReadonly;
  final bool? hasBackButton;
  SearchBar({Key? key, required this.isReadonly, required this.hasBackButton})
      : preferredSize = const Size.fromHeight(80);
  @override
  final Size preferredSize;
  OutlineInputBorder border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(7),
    borderSide: BorderSide(color: AppColor.grey, width: 1),
  );
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: AppColor.backgroundgradient,
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            hasBackButton!
                ? IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back),
                  )
                : Container(),
            SizedBox(
              width: size.width * 0.7,
              child: Container(
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 8,
                    spreadRadius: 1,
                    offset: Offset(0, 5),
                  )
                ]),
                child: TextField(
                  onSubmitted: ((String query) {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: ((context) => ResultScreen(query: query)),
                      ),
                    );
                  }),
                  readOnly: isReadonly!,
                  onTap: () {
                    if (isReadonly!) {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => SearchScreen()),
                      );
                    }
                  },
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: "Search for something in amazon",
                      border: border,
                      focusedBorder: border),
                ),
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.mic_none_outlined),
            )
          ],
        ),
      ),
    );
  }
}
