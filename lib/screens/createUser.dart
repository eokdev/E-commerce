// ignore_for_file: depend_on_referenced_packages, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, unused_field, unnecessary_import, file_names, unused_import, use_build_context_synchronously, prefer_final_fields

import 'dart:developer';

import 'package:amazon/constants/colors.dart';
import 'package:amazon/screens/signin.dart';
import 'package:amazon/utils/button.dart';
import 'package:amazon/utils/textfield.dart';
import 'package:amazon/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../backend/authentification.dart';

class CreateUser extends ConsumerStatefulWidget {
  const CreateUser({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CreateUserState();
}

class _CreateUserState extends ConsumerState<CreateUser> {
  final _emailcontroller = TextEditingController();
  final _passwordcontroller = TextEditingController();
  final _addresscontroller = TextEditingController();
  final _namecontroller = TextEditingController();
  final _authentication = Authentication();
  bool _isLoading = false;
  @override
  void dispose() {
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
    _addresscontroller.dispose();
    _namecontroller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColor.white,
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Image(
                  image: AssetImage("images/amazon.png"),
                  fit: BoxFit.cover,
                  height: 100,
                  width: 150,
                ),
              ),
              Container(
                height: size.height * 0.6,
                width: size.width * 0.8,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1.5),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Sign-Up",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      TextFieldd(
                        controller: _namecontroller,
                        title: "Name",
                        hintText: "Enter your name",
                      ),
                      TextFieldd(
                        controller: _addresscontroller,
                        title: "Adress",
                        hintText: "Enter your Address",
                      ),
                      TextFieldd(
                        controller: _emailcontroller,
                        title: "Email",
                        hintText: "Enter your email",
                      ),
                      TextFieldd(
                        controller: _passwordcontroller,
                        title: "Password",
                        obscure: true,
                        hintText: "Enter your pass",
                      ),
                      Center(
                        child: GestureDetector(
                          onTap: () async {
                            setState(() {
                              _isLoading = true;
                            });
                            String output = await _authentication.signUp(
                              name: _namecontroller.text,
                              address: _addresscontroller.text,
                              email: _emailcontroller.text,
                              password: _passwordcontroller.text,
                            );
                            setState(() {
                              _isLoading = false;
                            });
                            if (output == "success") {
                              await Navigator.pushReplacement(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => SignIn(),
                                ),
                              );
                            } else {
                              Utils().snackBar(context: context, err: output);
                            }
                          },
                          child: ButtonCard(
                            title: "Sign Up",
                            color: AppColor.orange,
                            isLoading: _isLoading,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: ButtonCard(
                  title: "Back",
                  color: AppColor.grey,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
