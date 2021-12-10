import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hybrid_assistance/components/worthy/worthy_button.dart';
import 'package:hybrid_assistance/config/app_themes.dart';
import 'package:hybrid_assistance/utils/ui_utils.dart';
import 'teacher_controller.dart';
export 'teacher_controller.dart';

class TeacherForm extends GetView<TeacherController> {
  const TeacherForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final update = Get.arguments['update'];
    if (update != null) controller.teacher = update;

    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        title: update == null ? const Text('Agregar Maestro') : const Text('Editar Maestro'),
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
                    initialValue: update == null ? '' : controller.teacher.id.toString(),
                    enabled: update == null,
                    validator: (value) => controller.teacher.validateId5(value) ? null : 'El ID no es válido',
                    onSaved: (value) => controller.teacher.id = value == null ? 0 : int.tryParse(value)!,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Nombre',
                    ),
                    initialValue: controller.teacher.name,
                    validator: (value) => controller.teacher.validateName(value) ? null : 'Nombre no válido',
                    onSaved: (value) => controller.teacher.name = value ?? '',
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Apellido Paterno',
                    ),
                    initialValue: controller.teacher.firstLastName,
                    validator: (value) => controller.teacher.validateName(value) ? null : 'Apellido Paterno no válido',
                    onSaved: (value) => controller.teacher.firstLastName = value ?? '',
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Apellido Materno',
                    ),
                    initialValue: controller.teacher.secondLastName,
                    validator: (value) => controller.teacher.validateName(value) ? null : 'Apellido Materno no válido',
                    onSaved: (value) => controller.teacher.secondLastName = value ?? '',
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Contraseña',
                    ),
                    obscureText: true,
                    initialValue: controller.teacher.password,
                    validator: (value) =>
                        controller.teacher.validatePassword(value) ? null : 'Contraseña no válida, debe contener al menos 8 caracteres, 1 letra y 1 número',
                    onSaved: (value) => controller.teacher.password = value ?? '',
                  ),
                  const Divider(
                    height: 32.0,
                  ),
                  WorthyButton.elevated(
                      child: update == null ? const Text('Agregar') : const Text('Modificar'),
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
