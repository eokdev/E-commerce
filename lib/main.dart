// ignore_for_file: prefer_const_constructors, depend_on_referenced_packages, unused_import, await_only_futures, unused_field

import 'dart:developer';

import 'package:amazon/backend/authentification.dart';
import 'package:amazon/constants/colors.dart';
import 'package:amazon/constants/widgets.dart';
import 'package:amazon/screens/screenlayout.dart';
import 'package:amazon/screens/sellscreen.dart';
import 'package:amazon/screens/signin.dart';
import 'package:flutter/foundation.dart';
import "package:flutter/material.dart";
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _authentication = Authentication();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, AsyncSnapshot<User?> user) {
            if (user.hasData) {
              Screens.loadingWidget;
              return ScreenLayout();
            } else if (user.hasError) {
              return Text('Error loading user data: ${user.error}');
            } else {
              return SignIn();
            }
          }),
    );
  }
}
