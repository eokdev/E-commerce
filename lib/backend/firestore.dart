// ignore_for_file: non_constant_identifier_names
import 'dart:developer';

import 'package:amazon/models/orderrequest.dart';
import 'package:amazon/models/reviewmodel.dart';
import 'package:amazon/models/userDetailsModel.dart';
import 'package:amazon/screens/simpleproduct.dart';
import 'package:amazon/state/user_details.dart';
import 'package:amazon/utils/utils.dart';
import "package:firebase_auth/firebase_auth.dart";
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import '../models/productmodel.dart';

class CloudFireStore {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  Future NAtoDb({required UserDetailModels user}) async {
    await firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .set(user.getJson());
  }

  Future getNandA() async {
    DocumentSnapshot snap = await firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .get();

    UserDetailModels userModels = UserDetailModels.getModelFromJson(
      snap.data() as dynamic,
    );
    return userModels;
  }

  Future<String> uploadProduct({
    required Uint8List? image,
    required String? productName,
    required String? rawCost,
    required int? discount,
    required String? sellerName,
    required String? sellerUid,
  }) async {
    productName!.trim();
    rawCost!.trim();
    String output = "something went wrong";
    if (image != null && productName.isNotEmpty && rawCost.isNotEmpty) {
      try {
        String uiid = Utils().getUid();
        String url = await uploadImage(
          image: image,
          uid: uiid,
        );
        double cost = double.parse(rawCost);
        cost = cost - (cost * (discount! / 100));
        ProductModels product = ProductModels(
            url: url,
            productName: productName,
            cost: cost,
            discount: discount,
            uid: uiid,
            sellerName: sellerName,
            sellerUid: sellerUid,
            rating: 5,
            numberOfRating: 0);
        await firebaseFirestore
            .collection("products")
            .doc(uiid)
            .set(product.getjson());
        output = "success";
      } catch (e) {
        output = e.toString();
      }
    } else {
      output = "Please fill up all the fields";
    }
    return output;
  }

  Future<String> uploadImage({
    required Uint8List? image,
    required String? uid,
  }) async {
    Reference storageRef =
        FirebaseStorage.instance.ref().child("products").child(uid!);
    UploadTask uploadTask = storageRef.putData(image!);
    TaskSnapshot task = await uploadTask;
    return task.ref.getDownloadURL();
  }

  Future<List<Widget>> getProductFromDiscount({
    int? discount,
  }) async {
    List<Widget> children = [];
    QuerySnapshot<Map<String, dynamic>> snap = await firebaseFirestore
        .collection("products")
        .where("discount", isEqualTo: discount)
        .get();
    for (int i = 0; i < snap.docs.length; i++) {
      DocumentSnapshot docsnap = snap.docs[i];

      ProductModels model =
          ProductModels.getModelFromJson(json: (docsnap.data() as dynamic));
      children.add(
        SimpleProduct(productModels: model),
      );
    }
    return children;
  }

  Future uploadReview({
    required String? productUid,
    required ReviewModel reviewModel,
  }) async {
    await firebaseFirestore
        .collection("products")
        .doc(productUid)
        .collection("reviews")
        .add(reviewModel.toMap());
    await changeAverageRating(
        productUid: productUid!, reviewModel: reviewModel);
  }

  Future addProductToCart({
    required ProductModels? models,
  }) async {
    await firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .collection("cart")
        .doc(models!.uid)
        .set(models.getjson());
  }

  Future deleteProductFromCart({
    required String? uid,
  }) async {
    firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .collection("cart")
        .doc(uid)
        .delete();
  }

  Future buyAllItems({
    required UserDetailModels userDetails,
  }) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .collection("cart")
        .get();

    for (int i = 0; i < snapshot.docs.length; i++) {
      ProductModels model = ProductModels.fromMap(snapshot.docs[i].data());
      addProductToOrders(productModels: model, userDetails: userDetails);
      await deleteProductFromCart(uid: model.uid);
    }
  }

  Future addProductToOrders(
      {required ProductModels productModels,
      required UserDetailModels userDetails}) async {
    await firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .collection("order")
        .add(productModels.toMap());
    await sendOrderRequest(models: productModels, userDetails: userDetails);
  }

  Future sendOrderRequest(
      {required ProductModels models,
      required UserDetailModels userDetails}) async {
    OrderRequest model = OrderRequest(
      orderName: models.productName,
      buyersAddress: userDetails.address,
    );
    await firebaseFirestore
        .collection("users")
        .doc(models.sellerUid)
        .collection("orderequest")
        .add(model.toMap());
  }

  Future changeAverageRating({
    required String productUid,
    required ReviewModel reviewModel,
  }) async {
    DocumentSnapshot snapshot =
        await firebaseFirestore.collection("products").doc(productUid).get();
    ProductModels productModels =
        ProductModels.fromMap(snapshot.data() as dynamic);
    int currentRating = productModels.rating!;
    int rawRating = ((currentRating + reviewModel.rating!) / 2).toInt();
    await firebaseFirestore.collection("products").doc(productUid).update({
      "rating": rawRating,
    });
  }
}
