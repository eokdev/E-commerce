// ignore_for_file: unused_local_variable, prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:amazon/constants/colors.dart';
import 'package:amazon/constants/widgets.dart';
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";



class BannerAd extends ConsumerStatefulWidget {
  const BannerAd({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BannerAdState();
}

class _BannerAdState extends ConsumerState<BannerAd> {
  int currentAd = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
double smalladdheight = size.width/5;
    return GestureDetector(
      onHorizontalDragEnd: (_) {
        if (currentAd == (Screens.largeAds.length - 1)) {
          currentAd = -1;
        }
        setState(() {
          currentAd++;
        });
      },
      child: Column(
        children: [
          Stack(
            children: [
              Image.network(
                Screens.largeAds[currentAd],
                width: double.infinity,
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  width: size.width,
                  height: 100,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColor.backgroundColor,
                        AppColor.backgroundColor.withOpacity(0),
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                ),
              )
            ],
          ),
          Container(
            color: Colors.white,
            width: size.width,
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                getsmalladsfromindex(0, smalladdheight),
                getsmalladsfromindex(1, smalladdheight),
                getsmalladsfromindex(2, smalladdheight),
                getsmalladsfromindex(3, smalladdheight),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget getsmalladsfromindex(int index, double height) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: Container(
      height:120,
      width: height,
      decoration: ShapeDecoration(
        color: Colors.white,
        shadows: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 5,
            spreadRadius: 1,
          )
        ],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Image.network(
            Screens.smallAds[index],
          ),
          SizedBox(
            height: 5,
          ),
          Text(Screens.adItemNames[index]),
        ]),
      ),
    ),
  );
}
