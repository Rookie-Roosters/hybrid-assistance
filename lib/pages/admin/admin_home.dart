import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hybrid_assistance/components/worthy/worthy_text.dart';
import 'package:hybrid_assistance/config/app_pages.dart';
import 'package:hybrid_assistance/models/student.dart';
import 'package:hybrid_assistance/services/session_sevice.dart';
import 'package:hybrid_assistance/utils/ui_utils.dart';
import 'package:line_icons/line_icons.dart';
import 'adm_home_controller.dart';

class AdminHome extends GetView<AdmHomeController> {
  const AdminHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(mainAxisSize: MainAxisSize.max, crossAxisAlignment: CrossAxisAlignment.center, children: [
        kSpacer,
        WorthyText.heading2('Admin'),
         IconButton(
          icon: const Icon(LineIcons.sign),
          onPressed: () => controller.logOut(),
        ),
        const TestDB(),
        kSpacer,
      ],)
    );
  }
}


class TestDB extends StatelessWidget {
  const TestDB({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            Get.toNamed(Routes.STUDENTFORM, arguments: null);
          },
          child: const Text('Agregar Estudiante'),
        ),
        ElevatedButton(
          onPressed: () async {
            Get.toNamed(Routes.STUDENTFORM, arguments: (await Student.getById(269547))); //Se debe pasar por la ruta al estudiante que se quiere editar
          },
          child: const Text('Editar Estudiante'),
        ),
      ],
    );
  }
}
