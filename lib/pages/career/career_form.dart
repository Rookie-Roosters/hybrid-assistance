import 'package:flutter/material.dart' hide Center;
import 'package:get/get.dart';
import 'package:hybrid_assistance/models/career.dart';
import 'package:hybrid_assistance/widgets/department_dropdown.dart';
import 'career_controller.dart';
export 'career_controller.dart';

class CareerForm extends GetView<CareerController> {
  const CareerForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Career? update = Get.arguments['update'];
    if (update != null) controller.career = update;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: update == null
            ? const Text('Agregar Carrera')
            : const Text('Modificar Carrera'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: controller.formStateKey,
            autovalidateMode: AutovalidateMode.always,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'ID',
                    ),
                    initialValue: update == null
                        ? Get.arguments['initialId'].toString()
                        : controller.career.id.toString(),
                    enabled: false,
                    validator: (value) =>
                        controller.career.validateNumber(value)
                            ? null
                            : 'ID no válido',
                    onSaved: (value) => controller.career.id =
                        value == null ? 0 : int.tryParse(value)!,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  DepartmentDropdownButton(
                      update: update == null
                          ? Get.arguments['initialValues']
                          : update.department,
                      onChanged: (value) {},
                      onSaved: (newValue) {
                        controller.career.department = newValue;
                      }),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Nombre',
                    ),
                    initialValue: controller.career.name,
                    validator: (value) =>
                        controller.career.validateGenericName(value)
                            ? null
                            : 'Nombre no válido',
                    onSaved: (value) => controller.career.name = value ?? '',
                  ),
                  const Divider(
                    height: 32.0,
                  ),
                  ElevatedButton(
                      child: update == null
                          ? const Text('Agregar')
                          : const Text('Modificar'),
                      onPressed: () {
                        if (update == null) {
                          controller.add();
                        } else {
                          controller.update();
                        }
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
