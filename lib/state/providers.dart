// ignore_for_file: non_constant_identifier_names

import 'package:amazon/models/userDetailsModel.dart';
import 'package:amazon/state/user_details.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final user_details_provider =
    StateNotifierProvider((ref) {
  return UserDetails();
});

final getNameAndAddress = FutureProvider((ref) async {
  return ref.watch(user_details_provider.notifier).getData();
});
