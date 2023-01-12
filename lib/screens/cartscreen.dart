// ignore_for_file: prefer_const_constructors

import 'package:amazon/backend/firestore.dart';
import 'package:amazon/constants/colors.dart';
import 'package:amazon/constants/widgets.dart';
import 'package:amazon/models/productmodel.dart';
import 'package:amazon/models/userDetailsModel.dart';
import 'package:amazon/screens/userDetailsBar.dart';
import 'package:amazon/state/providers.dart';
import 'package:amazon/utils/button.dart';
import 'package:amazon/utils/cartitem.dart';
import 'package:amazon/utils/searchbar.dart';
import 'package:amazon/utils/utils.dart';
import "package:flutter/material.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import 'package:firebase_auth/firebase_auth.dart';

class CartScreen extends ConsumerStatefulWidget {
  const CartScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchBar(
        isReadonly: true,
        hasBackButton: false,
      ),
      body: Center(
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 80 / 2,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("users")
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .collection("cart")
                          .snapshots(),
                      builder: (context,
                          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                              snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return ButtonCard(
                            title: "Loading",
                            isLoading: true,
                            color: AppColor.yellowColor,
                          );
                        } else {
                          return InkWell(
                            onTap: ()async{
                              await CloudFireStore().buyAllItems( userDetails: ref.watch(user_details_provider.notifier).state);
                              Utils().snackBar(context: context, err: "Done");
                            },
                            child: ButtonCard(
                              title:
                                  "proceed buy (${snapshot.data!.docs.length}) items",
                              color: AppColor.yellowColor,
                              isLoading: false,
                            ),
                          );
                        }
                      }),
                ),
                Expanded(
                    child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection("users")
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .collection("cart")
                            .snapshots(),
                        builder: (context,
                            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                                snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Screens.loadingWidget;
                          } else {
                            return ListView.builder(
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, index) {
                                  ProductModels productModel =
                                      ProductModels.fromMap(
                                          snapshot.data!.docs[index].data());
                                  return CartItem(
                                    product: productModel,
                                  );
                                });
                          }
                        }))
              ],
            ),
            UserDetailBar(
              offset: 0,
            ),
          ],
        ),
      ),
    );
  }
}
