// ignore_for_file: prefer_const_constructors, unused_local_variable, prefer_const_literals_to_create_immutables

import 'dart:math';

import 'package:amazon/constants/colors.dart';
import 'package:amazon/constants/widgets.dart';
import 'package:amazon/models/orderrequest.dart';
import 'package:amazon/models/productmodel.dart';
import 'package:amazon/screens/productlistview.dart';
import 'package:amazon/screens/sellscreen.dart';
import 'package:amazon/screens/simpleproduct.dart';
import 'package:amazon/state/providers.dart';
import 'package:amazon/utils/accountscreenappbar.dart';
import 'package:amazon/utils/button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:cloud_firestore/cloud_firestore.dart";
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AccountScreen extends ConsumerStatefulWidget {
  const AccountScreen({
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AccountScreenState();
}

class _AccountScreenState extends ConsumerState<AccountScreen> {
  List<Widget>? yourOrders;

  @override

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
        child: Scaffold(
      appBar: AccountScreenAppbar(),
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height - (80 / 2),
          width: size.width,
          child: Column(
            children: [
              introduction(),
              Padding(
                padding: EdgeInsets.all(8),
                child: InkWell(
                  onTap: () {
                    FirebaseAuth.instance.signOut();
                  },
                  child: ButtonCard(
                    title: "Sign Out",
                    color: Colors.orange,
                    isLoading: false,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(builder: (context) => SellScreen()),
                    );
                  },
                  child: ButtonCard(
                    title: "Sell",
                    color: AppColor.yellowColor,
                    isLoading: false,
                  ),
                ),
              ),
              FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection("users")
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .collection("order")
                      .get(),
                  builder: (context,
                      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                          snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Screens.loadingWidget;
                    } else {
                      List<Widget> children = [];
                      for (int i = 0; i < snapshot.data!.docs.length; i++) {
                        ProductModels model = ProductModels.fromMap(
                            snapshot.data!.docs[i].data());
                        children.add(
                          SimpleProduct(productModels: model),
                        );
                      }
                      return ProductListView(
                        title: "Your Orders",
                        children: children,
                      );
                    }
                  }),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Order Requests",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Expanded(
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("users")
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .collection("orderequest")
                      .snapshots(),
                  builder: ((context,
                      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                          snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Screens.loadingWidget;
                    } else {
                      return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            OrderRequest model = OrderRequest.fromMap(
                                snapshot.data!.docs[index].data());
                            return ListTile(
                              title: Text(
                                "Order: ${model.orderName}",
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                              subtitle: Text("Address: ${model.buyersAddress}"),
                              trailing: IconButton(
                                onPressed: () async {
                                  FirebaseFirestore.instance
                                      .collection("users")
                                      .doc(FirebaseAuth
                                          .instance.currentUser!.uid)
                                      .collection("orderequest")
                                      .doc(snapshot.data!.docs[index].id)
                                      .delete();
                                },
                                icon: Icon(Icons.check),
                              ),
                            );
                          });
                    }
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

class introduction extends ConsumerWidget {
  const introduction({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(getNameAndAddress);
    return Container(
      height: 80 / 2,
      decoration: BoxDecoration(
          gradient: LinearGradient(
        colors: AppColor.backgroundGradient,
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      )),
      child: Container(
        height: 80 / 2,
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: [Colors.white, Colors.white.withOpacity(0.00000000001)],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        )),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 17),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Hello, ",
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 27,
                      ),
                    ),
                    TextSpan(
                      text: data.when(data: (data) {
                        return data!.name;
                      }, error: (error, stackTrace) {
                        return error.toString();
                      }, loading: () {
                        return "";
                      }),
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 27,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 20),
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                  "https://m.media-amazon.com/images/I/11iTpTDy6TL._SS70_.png",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
