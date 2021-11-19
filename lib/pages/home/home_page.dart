import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:hybrid_assistance/utils/ui_utils.dart';
import 'home_controller.dart';
export 'home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BootstrapContainer(children: [
        const Text('Inicio').centered(),
      ]).safeArea(),
    );
  }
}
