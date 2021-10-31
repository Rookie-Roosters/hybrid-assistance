import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hybrid_assistance/utils/ui_utils.dart';
import 'package:line_icons/line_icons.dart';
import 'main_controller.dart';
export 'main_controller.dart';

class MainPage extends GetView<MainController> {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(crossAxisAlignment: CrossAxisAlignment.stretch, mainAxisAlignment: MainAxisAlignment.center, children: [
        const Text('Inicio').centered(),
      ]),
      floatingActionButton: FloatingActionButton(
        child: const Icon(LineIcons.plus),
        onPressed: () {},
      ).safeArea(),
    );
  }
}
