import 'package:flutter/material.dart' hide Center;
import 'package:get/get.dart';
import 'package:hybrid_assistance/models/course.dart';
import 'package:hybrid_assistance/models/teacher.dart';
import 'package:hybrid_assistance/widgets/group_dropdown.dart';
import 'package:hybrid_assistance/widgets/subject_dropdown.dart';
import 'course_controller.dart';
export 'course_controller.dart';

class CourseForm extends GetView<CourseController> {
  const CourseForm({Key? key}) : super(key: key);

  String? validateTeacher(String? value) {
    if (!controller.course.validateId5(value)) {
      return 'ID no válido';
    } else {
      Teacher.exist(int.tryParse(value!)!).then((value) {
        if (value) {
          return null;
        } else {
          return 'No existe ningún maestro con ese ID';
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Course? update = Get.arguments;
    if (update != null) controller.course = update;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: update == null
            ? const Text('Agregar Curso')
            : const Text('Modificar Curso'),
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
                        update == null ? '' : controller.course.id.toString(),
                    validator: (value) =>
                        controller.course.validateNumber(value)
                            ? null
                            : 'ID no válido',
                    onSaved: (value) => controller.course.id =
                        value == null ? 0 : int.tryParse(value)!,
                  ),
                  const SizedBox(height: 20.0),
                  const Text('Grupo'),
                  GroupDropdownButton(
                      update: update?.group,
                      onSaved: (newValue) => controller.course.group = newValue,
                      onChanged: (value) {}),
                  const SizedBox(
                    height: 20.0,
                  ),
                  const Text('Materia'),
                  SubjectDropdownButton(
                      update: update?.subject,
                      onSaved: (newValue) =>
                          controller.course.subject = newValue,
                      onChanged: (value) {}),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'ID Maestro'),
                    initialValue: update == null
                        ? ''
                        : controller.course.teacher!.id.toString(),
                    validator: validateTeacher, //Validar si el profesor existe
                    onSaved: (value) =>
                        controller.idTeacher = int.tryParse(value!)!,
                  ),
                  const Divider(
                    height: 36.0,
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
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
