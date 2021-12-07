import 'package:flutter/material.dart' hide Center;
import 'package:get/get.dart';
import 'package:hybrid_assistance/config/app_pages.dart';
import 'package:hybrid_assistance/utils/ui_utils.dart';
import 'package:line_icons/line_icons.dart';
import 'adm_home_controller.dart';

class AdminHome extends GetView<AdmHomeController> {
  const AdminHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              IconButton(
                icon: const Icon(LineIcons.sign),
                onPressed: () => controller.logOut(),
              ),
              const Text('Inicio'),
              const TestDB(),
            ]).p3.safeArea(),
      ),
    );
  }
}

class TestDB extends StatelessWidget {
  const TestDB({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElevatedButton(
          onPressed: () {
            Get.toNamed(Routes.CENTERS);
          },
          child: const Text('Centros'),
        ),
        const SizedBox(height: 10.0,),
        ElevatedButton(
          onPressed: () {
            Get.toNamed(Routes.CLASSROOMS);
          },
          child: const Text('Salones'),
        ),
        const SizedBox(height: 10.0,),
        ElevatedButton(
          onPressed: () {
            Get.toNamed(Routes.STUDENTS);
          },
          child: const Text('Estudiantes'),
        ),
        const SizedBox(height: 10.0,),
        ElevatedButton(
          onPressed: () {
            Get.toNamed(Routes.TEACHERS);
          },
          child: const Text('Maestros'),
        ),
        const SizedBox(height: 10.0,),
        ElevatedButton(
          onPressed: () {
            Get.toNamed(Routes.DEPARTMENTS);
          },
          child: const Text('Departamentos'),
        ),
        const SizedBox(height: 10.0,),
        ElevatedButton(
          onPressed: () {
            Get.toNamed(Routes.CAREERS);
          },
          child: const Text('Carreras'),
        ),
        const SizedBox(height: 10.0,),
        ElevatedButton(
          onPressed: () {
            Get.toNamed(Routes.SUBJECTS);
          },
          child: const Text('Materias'),
        ),
        const SizedBox(height: 10.0,),
        ElevatedButton(
          onPressed: () {
            Get.toNamed(Routes.GROUPS);
          },
          child: const Text('Grupos'),
        ),
      ],
    );
  }
}