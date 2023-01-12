// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:amazon/constants/colors.dart';
import 'package:amazon/constants/widgets.dart';
import 'package:amazon/state/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ScreenLayout extends ConsumerStatefulWidget {
  const ScreenLayout({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ScreenLayoutState();
}

class _ScreenLayoutState extends ConsumerState<ScreenLayout> {
  PageController _pageController = PageController();
  int currentpage = 0;
  changePage(int page) {
    _pageController.jumpToPage(page);
    setState(() {
      currentpage = page;
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
   // ref.read(user_details_provider.notifier).getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        body: PageView(
          controller: _pageController,
          children: Screens().screenList,
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
              border:
                  Border(top: BorderSide(color: Colors.grey[400]!, width: 1))),
          child: TabBar(
            indicator: BoxDecoration(
                border: Border(
              top: BorderSide(
                color: AppColor.activeCyanColor,
                width: 4,
              ),
            )),
            onTap: (int page) {
              changePage(page);
            },
            indicatorSize: TabBarIndicatorSize.label,
            tabs: [
              Tab(
                child: Icon(
                  Icons.home_outlined,
                  color: currentpage == 0
                      ? AppColor.activeCyanColor
                      : Colors.black,
                ),
              ),
              Tab(
                child: Icon(
                  Icons.account_circle_outlined,
                  color: currentpage == 1
                      ? AppColor.activeCyanColor
                      : Colors.black,
                ),
              ),
              Tab(
                child: Icon(
                  Icons.shopping_cart_outlined,
                  color: currentpage == 2
                      ? AppColor.activeCyanColor
                      : Colors.black,
                ),
              ),
              Tab(
                child: Icon(Icons.menu,
                    color: currentpage == 3
                        ? AppColor.activeCyanColor
                        : Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
