// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:amazon/backend/firestore.dart';
import 'package:amazon/constants/colors.dart';
import 'package:amazon/constants/widgets.dart';
import 'package:amazon/models/productmodel.dart';
import 'package:amazon/models/reviewmodel.dart';
import 'package:amazon/models/userDetailsModel.dart';
import 'package:amazon/screens/userDetailsBar.dart';
import 'package:amazon/utils/CustomRoundedButton.dart';
import 'package:amazon/utils/button.dart';
import 'package:amazon/utils/utils.dart';
import "package:cloud_firestore/cloud_firestore.dart";
import 'package:amazon/utils/cartitem.dart';
import 'package:amazon/utils/costwidget.dart';
import 'package:amazon/utils/ratingstar.dart';
import 'package:amazon/utils/resultswidget.dart';
import 'package:amazon/utils/reviewdialog.dart';
import 'package:amazon/utils/reviewwidget.dart';
import 'package:amazon/utils/searchbar.dart';
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import '../state/providers.dart';

class ProductScreen extends ConsumerStatefulWidget {
  final ProductModels? productModels;
  const ProductScreen({super.key, required this.productModels});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProductScreenState();
}

class _ProductScreenState extends ConsumerState<ProductScreen> {
  SizedBox space = SizedBox(
    height: 20,
  );
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: SearchBar(
          isReadonly: true,
          hasBackButton: true,
          // encourage your user to
        ),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: 80 / 2,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 5),
                                    child: Text(
                                      widget.productModels!.sellerName
                                          .toString(),
                                      style: TextStyle(
                                          color: AppColor.activeCyanColor,
                                          fontSize: 16),
                                    ),
                                  ),
                                  Text(widget.productModels!.productName
                                      .toString()),
                                ],
                              ),
                              RatingStar(
                                rating: widget.productModels!.rating,
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Container(
                            height: MediaQuery.of(context).size.height / 4,
                            constraints: BoxConstraints(
                                maxHeight:
                                    MediaQuery.of(context).size.height / 3),
                            child: Image.network(
                              widget.productModels!.url.toString(),
                            ),
                          ),
                        ),
                        space,
                        CostWidget(
                            color: Colors.black,
                            cost: widget.productModels!.cost),
                        space,
                        InkWell(
                          onTap: () async {
                            await CloudFireStore().addProductToOrders(
                                productModels: widget.productModels!,
                                userDetails: ref
                                    .watch(user_details_provider.notifier)
                                    .state);
                            Utils().snackBar(context: context, err: "Done");
                          },
                          child: ButtonCard(
                            title: "Buy Now",
                            color: AppColor.orange,
                            isLoading: false,
                          ),
                        ),
                        space,
                        InkWell(
                          onTap: () async {
                            await CloudFireStore()
                                .addProductToCart(models: widget.productModels);
                            Utils().snackBar(
                                context: context, err: "Added to Cart");
                          },
                          child: ButtonCard(
                            title: "Add to Cart",
                            color: AppColor.yellowColor,
                            isLoading: false,
                          ),
                        ),
                        space,
                        CustomRoundedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: ((context) => ReviewDialog(
                                    productUid: widget.productModels!.uid,
                                  )),
                            );
                          },
                          text: "Add review for this product",
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height / 2,
                            child: StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection("products")
                                  .doc(widget.productModels!.uid)
                                  .collection("reviews")
                                  .snapshots(),
                              builder: ((context,
                                  AsyncSnapshot<
                                          QuerySnapshot<Map<String, dynamic>>>
                                      snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Container();
                                } else {
                                  return ListView.builder(
                                    itemCount: snapshot.data!.docs.length,
                                    itemBuilder: ((context, index) {
                                      ReviewModel reviewModel =
                                          ReviewModel.fromMap(snapshot
                                              .data!.docs[index]
                                              .data());
                                      return ReviewWidget(
                                        review: reviewModel,
                                      );
                                    }),
                                  );
                                }
                              }),
                            )),
                      ],
                    ),
                  ],
                ),
              ),
              UserDetailBar(
                offset: 0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
