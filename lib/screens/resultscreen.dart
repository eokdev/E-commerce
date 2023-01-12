// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables


import 'package:amazon/constants/colors.dart';
import 'package:amazon/constants/widgets.dart';
import 'package:amazon/models/productmodel.dart';
import 'package:amazon/models/userDetailsModel.dart';
import 'package:amazon/screens/userDetailsBar.dart';
import 'package:amazon/utils/button.dart';
import 'package:amazon/utils/cartitem.dart';
import 'package:amazon/utils/resultswidget.dart';
import 'package:amazon/utils/searchbar.dart';
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import 'package:firebase_auth/firebase_auth.dart';
import "package:cloud_firestore/cloud_firestore.dart";

class ResultScreen extends ConsumerWidget {
  final String? query;
  const ResultScreen({super.key, required this.query});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: SearchBar(isReadonly: false, hasBackButton: true),
      body: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Showing results for ",
                      style: TextStyle(fontSize: 17, color: Colors.black),
                    ),
                    TextSpan(
                      text: query,
                      style: TextStyle(
                          fontSize: 17,
                          fontStyle: FontStyle.italic,
                          color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
              child: FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection("products")
                      .where("productName", isEqualTo: query)
                      .get(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Screens.loadingWidget;
                    } else {
                      return GridView.builder(
                          itemCount: snapshot.data!.docs.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2, childAspectRatio: 1),
                          itemBuilder: (context, index) {
                            ProductModels product = ProductModels.fromMap(
                                snapshot.data!.docs[index].data());
                            return ResultWidget(product: product);
                          });
                    }
                  }))
        ],
      ),
    );
  }
}
