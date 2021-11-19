import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hybrid_assistance/pages/login/login_controller.dart';
import 'package:hybrid_assistance/utils/ui_utils.dart';

class Login extends GetView<LoginController> {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Column(crossAxisAlignment: CrossAxisAlignment.stretch, mainAxisAlignment: MainAxisAlignment.center, children: [
        const Text('Login').centered(),
      ]),
    );
  }
}
