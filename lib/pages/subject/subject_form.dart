import 'package:flutter/material.dart' hide Center;
import 'package:get/get.dart';
import 'package:hybrid_assistance/models/subject.dart';
import 'package:hybrid_assistance/widgets/department_dropdown.dart';
import 'subject_controller.dart';
export 'subject_controller.dart';

class SubjectForm extends GetView<SubjectController> {
  const SubjectForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Subject? update = Get.arguments;
    if (update != null) controller.subject = update;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: update == null
            ? const Text('Agregar Materia')
            : const Text('Editar Materia'),
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
                    initialValue:
                        update == null ? '' : controller.subject.id.toString(),
                    enabled: update == null,
                    validator: (value) =>
                        controller.subject.validateNumber(value)
                            ? null
                            : 'ID no válido',
                    onSaved: (value) => controller.subject.id =
                        value == null ? 0 : int.tryParse(value)!,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  DepartmentDropdownButton(
                      update: update?.department,
                      onSaved: (newValue) =>
                          controller.subject.department = newValue,
                      onChanged: (value) {}),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Nombre',
                    ),
                    initialValue: controller.subject.name,
                    validator: (value) =>
                        controller.subject.validateGenericName(value)
                            ? null
                            : 'Nombre no válido',
                    onSaved: (value) => controller.subject.name = value ?? '',
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
