// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, unused_local_variable, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables

import 'package:amazon/constants/colors.dart';
import 'package:amazon/constants/widgets.dart';
import 'package:amazon/screens/resultscreen.dart';
import 'package:amazon/screens/searchScreen.dart';
import 'package:amazon/state/providers.dart';
import 'package:amazon/utils/button.dart';
import 'package:amazon/utils/textfield.dart';
import 'package:amazon/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../backend/firestore.dart';

class SellScreen extends ConsumerStatefulWidget {
  const SellScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SellScreenState();
}

class _SellScreenState extends ConsumerState<SellScreen> {
  bool isLoading = false;
  int selected = 1;
  Uint8List? image;
  List<int> keysofdiscount = [
    0,
    70,
    60,
    50,
  ];
  SizedBox sizedBox = SizedBox(
    height: 10,
  );

  final _nameController = TextEditingController();
  final _costController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _costController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final data = ref.watch(getNameAndAddress);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: !isLoading
            ? SingleChildScrollView(
                child: SizedBox(
                  height: size.height,
                  width: size.width,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 20,
                    ),
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              image == null
                                  ? Image.network(
                                      "https://img.freepik.com/free-icon/user_318-804790.jpg?w=2000",
                                      height: size.height / 10,
                                    )
                                  : Image.memory(
                                      image!,
                                      height: size.height / 10,
                                    ),
                              IconButton(
                                onPressed: () async {
                                  Uint8List? temp = await Utils().pickImage();
                                  if (temp != null) {
                                    setState(() {
                                      image = temp;
                                    });
                                  }
                                },
                                icon: Icon(Icons.file_upload),
                              ),
                            ],
                          ),
                          sizedBox,
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 35, vertical: 10),
                            height: size.height * 0.7,
                            width: size.width * 0.7,
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1,
                                color: Colors.grey,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "Item Details",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24),
                                ),
                                TextFieldd(
                                  controller: _nameController,
                                  title: "Name",
                                  obscure: false,
                                  hintText: "Enter the name of the item",
                                ),
                                TextFieldd(
                                  controller: _costController,
                                  title: "Cost",
                                  obscure: false,
                                  hintText: "Enter the cost of the item",
                                ),
                                Text(
                                  "Discount",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                                ListTile(
                                  title: Text("None"),
                                  leading: Radio(
                                      value: 1,
                                      groupValue: selected,
                                      onChanged: (int? i) {
                                        setState(() {
                                          selected = i!;
                                        });
                                      }),
                                ),
                                ListTile(
                                  title: Text("70%"),
                                  leading: Radio(
                                      value: 2,
                                      groupValue: selected,
                                      onChanged: (int? i) {
                                        setState(() {
                                          selected = i!;
                                        });
                                      }),
                                ),
                                ListTile(
                                  title: Text("60%"),
                                  leading: Radio(
                                      value: 3,
                                      groupValue: selected,
                                      onChanged: (int? i) {
                                        setState(() {
                                          selected = i!;
                                        });
                                      }),
                                ),
                                ListTile(
                                  title: Text("50%"),
                                  leading: Radio(
                                      value: 4,
                                      groupValue: selected,
                                      onChanged: (int? i) {
                                        setState(() {
                                          selected = i!;
                                        });
                                      }),
                                ),
                              ],
                            ),
                          ),
                          sizedBox,
                          GestureDetector(
                            onTap: () async {
                              String output =
                                  await CloudFireStore().uploadProduct(
                                image: image,
                                productName: _nameController.text,
                                rawCost: _costController.text,
                                discount: keysofdiscount[selected - 1],
                                sellerName: data.asData!.value!.name,
                                sellerUid:
                                    FirebaseAuth.instance.currentUser!.uid,
                              );
                              if (output == "success") {
                                Utils().snackBar(
                                    context: context, err: "product posted");
                              } else {
                                Utils().snackBar(context: context, err: output);
                              }
                            },
                            child: ButtonCard(
                              title: "Sell",
                              color: Colors.orange,
                              isLoading: isLoading,
                            ),
                          ),
                          sizedBox,
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: ButtonCard(
                              title: "Back",
                              color: Colors.grey[300],
                              isLoading: false,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            : Screens.loadingWidget,
      ),
    );
  }
}
