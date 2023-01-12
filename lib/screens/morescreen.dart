// ignore_for_file: prefer_const_constructors

import 'package:amazon/constants/colors.dart';
import 'package:amazon/constants/widgets.dart';
import 'package:amazon/models/productmodel.dart';
import 'package:amazon/models/userDetailsModel.dart';
import 'package:amazon/screens/userDetailsBar.dart';
import 'package:amazon/utils/button.dart';
import 'package:amazon/utils/cartitem.dart';
import 'package:amazon/utils/categoryWidget.dart';
import 'package:amazon/utils/searchbar.dart';
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

class MoreScreen extends ConsumerStatefulWidget {
  const MoreScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MoreScreenState();
}

class _MoreScreenState extends ConsumerState<MoreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchBar(isReadonly: true, hasBackButton: false),
      body: Padding(
        padding:  EdgeInsets.all(8.0),
        child: GridView.builder(
          itemCount: Screens.categoryText.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 2.2 / 3.5,
            mainAxisSpacing: 15,
            crossAxisSpacing: 15,
          ),
          itemBuilder: ((context, index) {
            return CategoryWidget(index: index);
          }),
        ),
      ),
    );
  }
}
