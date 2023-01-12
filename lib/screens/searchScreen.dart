// ignore_for_file: prefer_const_constructors

import 'package:amazon/utils/searchbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchScreen extends ConsumerWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: SearchBar(
        isReadonly: false,
        hasBackButton: true,
      ),
    );
  }
}
