// ignore_for_file: prefer_const_constructors
import 'dart:math';

import 'package:image_picker/image_picker.dart';
import 'package:amazon/constants/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Utils {
  snackBar({required BuildContext context, required String err}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: AppColor.orange,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(err),
        ],
      ),
    ));
  }
  Future<Uint8List?> pickImage()async{
ImagePicker imagePicker=ImagePicker();
XFile? file=await imagePicker.pickImage(source: ImageSource.gallery);
if(file!=null){
  return file.readAsBytes();
}
  }
  String getUid(){
    return (100000+ Random().nextInt(10000)).toString();
  }
}
