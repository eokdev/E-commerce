// ignore_for_file: unused_local_variable, prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:developer';

import 'package:amazon/backend/firestore.dart';
import 'package:amazon/constants/colors.dart';
import 'package:amazon/constants/widgets.dart';
import 'package:amazon/models/reviewmodel.dart';
import 'package:amazon/state/providers.dart';
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import 'package:rating_dialog/rating_dialog.dart';

class ReviewDialog extends ConsumerWidget {
  final String? productUid;
  const ReviewDialog({super.key, required this.productUid});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return RatingDialog(
      title: Text(
        'Type Review',
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),

      // your app's logo?
      // encourage your user to leave a high rating?
      submitButtonText: 'Send',
      commentHint: 'Type here',
      onCancelled: () => log('cancelled'),
      onSubmitted: (response) async {
        CloudFireStore().uploadReview(
          productUid: productUid,
          reviewModel: ReviewModel(
            senderName: ref.watch(getNameAndAddress).asData!.value!.name,
            description: response.comment,
            rating: response.rating.toInt(),
          ),
        );
      },
    );
  }
}
