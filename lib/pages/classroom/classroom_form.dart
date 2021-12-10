import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hybrid_assistance/components/worthy/worthy_button.dart';
import 'package:hybrid_assistance/config/app_themes.dart';
import 'package:hybrid_assistance/utils/ui_utils.dart';
import 'classroom_controller.dart';
export 'classroom_controller.dart';

class ClassroomForm extends GetView<ClassroomController> {
  const ClassroomForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final update = Get.arguments['update'];
    if (update != null) controller.classroom = update;

    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        //backgroundColor: Colors.blue,
        title: update == null ? const Text('Agregar Salón de Clases') : const Text('Editar Salón de Clases'),
      ),
      body: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(kBorderRadius)),
        child: Container(
          color: kSurfaceColor,
          alignment: Alignment.center,
          child: Container(
            alignment: Alignment.topCenter,
            child: Form(
              key: controller.formStateKey,
              autovalidateMode: AutovalidateMode.always,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'ID',
                    ),
                    initialValue: update == null ? Get.arguments['initialId'].toString() : controller.classroom.id.toString(),
                    enabled: false,
                    validator: (value) => controller.classroom.validateNumber(value) ? null : 'ID no válido',
                    onSaved: (value) => controller.classroom.id = value == null ? 0 : int.tryParse(value)!,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Nombre',
                    ),
                    initialValue: controller.classroom.name,
                    onSaved: (value) => controller.classroom.name = value ?? '',
                  ),
                  const Divider(
                    height: 32.0,
                  ),
                  WorthyButton.elevated(
                      child: update == null ? const Text('Agregar') : const Text('Editar'),
                      color: kSecondaryColor,
                      onPressed: () {
                        if (update == null) {
                          controller.add();
                        } else {
                          controller.update();
                        }
                      }),
                ],
              ).scrollable(padding: kPadding),
            ),
          ),
        ),
      ),
    );
  }
}
