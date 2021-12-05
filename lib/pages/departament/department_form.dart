import 'package:flutter/material.dart' hide Center;
import 'package:get/get.dart';
import 'package:hybrid_assistance/models/department.dart';
import 'package:hybrid_assistance/widgets/center_dropdown.dart';
import 'department_controller.dart';
export 'department_controller.dart';

class DepartmentForm extends GetView<DepartmentController> {
  const DepartmentForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Department? update = Get.arguments;
    if (update != null) controller.department = update;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: update == null
            ? const Text('Agregar Departamento')
            : const Text('Editar Departamento'),
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
                        ? ''
                        : controller.department.id.toString(),
                    enabled: update == null,
                    validator: (value) =>
                        controller.department.validateNumber(value)
                            ? null
                            : 'ID no válido',
                    onSaved: (value) => controller.department.id =
                        value == null ? 0 : int.tryParse(value)!,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  CenterDropdownButton(
                    update: update?.center,
                    onSaved: (value) => controller.department.center = value,
                    onChanged: (value) {}
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Nombre',
                    ),
                    initialValue: controller.department.name,
                    validator: (value) =>
                        controller.department.validateGenericName(value)
                            ? null
                            : 'Nombre no válido',
                    onSaved: (value) =>
                        controller.department.name = value ?? '',
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
