import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hybrid_assistance/config/app_pages.dart';
import 'package:hybrid_assistance/utils/ui_utils.dart';
import 'package:line_icons/line_icons.dart';
import 'home_controller.dart';
export 'home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(crossAxisAlignment: CrossAxisAlignment.stretch, mainAxisAlignment: MainAxisAlignment.center, mainAxisSize: MainAxisSize.max, children: [
        IconButton(
          icon: const Icon(LineIcons.sign),
          onPressed: () => controller.logOut(),
        ),
        const Text('Inicio'),
        const TestDB(),
      ]).p3.safeArea(),
    );
  }
}

class TestDB extends StatelessWidget {
  const TestDB({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Get.toNamed(Routes.STUDENTFORM);
      },
      child: const Text('Formulario de estudiantes'),
    );
  }
}