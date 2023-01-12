// ignore_for_file: annotate_overrides, unused_local_variable, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:amazon/constants/colors.dart';
import 'package:amazon/constants/widgets.dart';
import 'package:amazon/screens/searchScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AccountScreenAppbar extends ConsumerWidget with PreferredSizeWidget {
  const AccountScreenAppbar({super.key})
      : preferredSize = const Size.fromHeight(80);
  final Size preferredSize;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: 80,
      width: size.width,
      decoration: BoxDecoration(
          gradient: LinearGradient(
        colors: AppColor.backgroundGradient,
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Image.network(
              Screens.amazonLogoUrl,
              height: 80 * 0.7,
            ),
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.notifications_outlined,
                ),
                color: Colors.black,
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(context, CupertinoPageRoute(builder: (context)=> SearchScreen()));
                },
                icon: Icon(
                  Icons.search_outlined,
                ),
                color: Colors.black,
              ),
            ],
          )
        ],
      ),
    );
  }
}
