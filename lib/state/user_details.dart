import 'dart:developer';

import 'package:amazon/backend/firestore.dart';
import 'package:amazon/models/userDetailsModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserDetails extends StateNotifier<UserDetailModels> {
  UserDetailModels? userDetails;
  UserDetails() : super(UserDetailModels(name: "loading", address: "loading"));

  Future<UserDetailModels?> getData() async {
    userDetails = await CloudFireStore().getNandA();
    log(userDetails!.name!);
    return userDetails;
  }
}



//  UserDetails()
//       : userDetails = UserDetailModels(
//           name: "loading",
//           address: "loading",
//         );