import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hybrid_assistance/components/worthy/worthy_button.dart';
import 'package:hybrid_assistance/config/app_themes.dart';
import 'package:hybrid_assistance/utils/ui_utils.dart';
import 'student_controller.dart';
export 'student_controller.dart';

class StudentForm extends GetView<StudentController> {
  const StudentForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final update = Get.arguments['update'];
    if (update != null) controller.student = update;

    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        title: update == null ? const Text('Agregar estudiante') : const Text('Modificar estudiante'),
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
                    initialValue: update == null ? '' : controller.student.id.toString(),
                    enabled: update == null,
                    validator: (value) => controller.student.validateId6(value) ? null : 'ID no válido',
                    onSaved: (value) => controller.student.id = value == null ? 0 : int.tryParse(value),
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Nombre',
                    ),
                    initialValue: controller.student.name,
                    validator: (value) => controller.student.validateName(value) ? null : 'Nombre no válido',
                    onSaved: (value) => controller.student.name = value ?? '',
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Apellido Paterno',
                    ),
                    initialValue: controller.student.firstLastName,
                    validator: (value) => controller.student.validateName(value) ? null : 'Apellido Paterno no válido',
                    onSaved: (value) => controller.student.firstLastName = value ?? '',
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Apellido Materno',
                    ),
                    initialValue: controller.student.secondLastName,
                    validator: (value) => controller.student.validateName(value) ? null : 'Apellido Materno no válido',
                    onSaved: (value) => controller.student.secondLastName = value ?? '',
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Contraseña',
                    ),
                    initialValue: controller.student.password,
                    obscureText: true,
                    validator: (value) =>
                        controller.student.validatePassword(value) ? null : 'Contraseña no válida, debe contener al menos 8 caracteres, 1 letra y 1 número',
                    onSaved: (value) => controller.student.password = value ?? '',
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
                    },
                  ),
                ],
              ).scrollable(padding: kPadding),
            ),
          ),
        ),
      ),
    );
  }
}
