import 'package:flutter/material.dart' hide Center;
import 'package:get/get.dart';
import 'package:hybrid_assistance/components/worthy/worthy_button.dart';
import 'package:hybrid_assistance/config/app_themes.dart';
import 'package:hybrid_assistance/models/course.dart';
import 'package:hybrid_assistance/models/teacher.dart';
import 'package:hybrid_assistance/utils/ui_utils.dart';
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
    final Course? update = Get.arguments['update'];
    if (update != null) controller.course = update;

    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        title: update == null ? const Text('Agregar Curso') : const Text('Modificar Curso'),
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
                    enabled: false,
                    initialValue: update == null ? Get.arguments['initialId'].toString() : controller.course.id.toString(),
                    validator: (value) => controller.course.validateNumber(value) ? null : 'ID no válido',
                    onSaved: (value) => controller.course.id = value == null ? 0 : int.tryParse(value)!,
                  ),
                  const SizedBox(height: 20.0),
                  const Text('Grupo'),
                  GroupDropdownButton(
                    update: update == null ? Get.arguments['initialValues']['group'] : update.group,
                    onSaved: (newValue) => controller.course.group = newValue,
                    onChanged: (value) {},
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  const Text('Materia'),
                  SubjectDropdownButton(
                    update: update == null ? Get.arguments['initialValues']['subject'] : update.subject,
                    onSaved: (newValue) => controller.course.subject = newValue,
                    onChanged: (value) {},
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'ID Maestro'),
                    initialValue: update == null ? '' : controller.course.teacher!.id.toString(),
                    validator: validateTeacher, //Validar si el profesor existe
                    onSaved: (value) => controller.idTeacher = int.tryParse(value!)!,
                  ),
                  const Divider(
                    height: 36.0,
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
