import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hybrid_assistance/components/calendar.dart';
import 'package:hybrid_assistance/components/worthy/worthy_text.dart';
import 'package:hybrid_assistance/pages/home/home_controller.dart';
import 'package:line_icons/line_icons.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:WorthyText.heading2('Clases de la semana'), actions: [IconButton(
          icon: const Icon(LineIcons.arrowLeft),
          onPressed: () => controller.logOut(),
        ),],),
      body:
        const Calendar(),
    );
  }
}