// ignore_for_file: unused_import, depend_on_referenced_packages, unused_local_variable, empty_catches

import 'dart:developer';

import 'package:amazon/backend/firestore.dart';
import 'package:amazon/models/userDetailsModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Authentication {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  CloudFireStore cloudFireStore = CloudFireStore();
  Future<String> signUp({
    required String name,
    required String address,
    required String email,
    required String password,
  }) async {
    name.trim();
    address.trim();
    password.trim();
    email.trim();
    String output = "Something went Wrong";
    if (name.isNotEmpty &&
        address.isNotEmpty &&
        password.isNotEmpty &&
        email.isNotEmpty) {
      try {
        await firebaseAuth.createUserWithEmailAndPassword(
            email: email, password: password);
        UserDetailModels userDetails =
            UserDetailModels(name: name, address: address);
        await cloudFireStore.NAtoDb(user: userDetails);
        output = "success";
      } on FirebaseAuthException catch (e) {
        output = e.message.toString();
      }
    } else {
      output = "Please fill up all fields";
    }
    return output;
  }

  Future<String> signIn({
    required String email,
    required String password,
  }) async {
    password.trim();
    email.trim();
    String output = "Something went Wrong";
    if (password.isNotEmpty && email.isNotEmpty) {
      try {
        await firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);
        output = "success";
      } on FirebaseAuthException catch (e) {
        output = e.message.toString();
      }
    } else {
      output = "Please fill up all fields";
    }
    return output;
  }

  Future signout() async {
    return await firebaseAuth.signOut();
  }
}
