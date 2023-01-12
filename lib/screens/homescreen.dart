// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:developer';

import 'package:amazon/backend/firestore.dart';
import 'package:amazon/constants/widgets.dart';
import 'package:amazon/models/productmodel.dart';
import 'package:amazon/models/userDetailsModel.dart';
import 'package:amazon/screens/banneradscreen.dart';
import 'package:amazon/screens/productlistview.dart';
import 'package:amazon/screens/simpleproduct.dart';
import 'package:amazon/screens/userDetailsBar.dart';
import 'package:amazon/utils/categories.dart';
import 'package:amazon/utils/searchbar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  ScrollController _scrollController = ScrollController();
  double offset = 0;
  List<Widget>? discount70;
  List<Widget>? discount60;
  List<Widget>? discount50;
  List<Widget>? discount0;

  @override
  void initState() {
    getData();
    _scrollController.addListener(() {
      setState(() {
        offset = _scrollController.position.pixels;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void getData() async {
    List<Widget>? temp70 =
        await CloudFireStore().getProductFromDiscount(discount: 70);
    List<Widget>? temp60 =
        await CloudFireStore().getProductFromDiscount(discount: 60);
    List<Widget>? temp50 =
        await CloudFireStore().getProductFromDiscount(discount: 50);
    List<Widget>? temp0 =
        await CloudFireStore().getProductFromDiscount(discount: 0);
    setState(() {
      discount70 = temp70;
      discount60 = temp60;
      discount50 = temp50;
      discount0 = temp0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: SearchBar(
          isReadonly: true,
          hasBackButton: false,
        ),
        body: discount70 != null &&
                discount60 != null &&
                discount50 != null &&
                discount0 != null
            ? Stack(
                children: [
                  SingleChildScrollView(
                    controller: _scrollController,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 80 / 2,
                        ),
                        CategoryHLVB(),
                        BannerAd(),
                        ProductListView(
                          title: "Upto 70% OFF",
                          children: discount70!,
                        ),
                        ProductListView(
                          title: "Upto 60% OFF",
                          children: discount60!,
                        ),
                        ProductListView(
                          title: "Upto 50% OFF",
                          children: discount50!,
                        ),
                        ProductListView(
                          title: "Explore",
                          children: discount0!,
                        ),
                      ],
                    ),
                  ),
                  UserDetailBar(
                    offset: offset,
                  ),
                ],
              )
            : Screens.loadingWidget);
  }
}
