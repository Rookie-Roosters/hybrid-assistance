import 'package:flutter/material.dart' hide Center;
import 'package:get/get.dart';
import 'package:hybrid_assistance/components/worthy/worthy_button.dart';
import 'package:hybrid_assistance/config/app_themes.dart';
import 'package:hybrid_assistance/models/academic_load.dart';
import 'package:hybrid_assistance/models/student.dart';
import 'package:hybrid_assistance/utils/ui_utils.dart';
import 'package:hybrid_assistance/widgets/course_dropdown.dart';
import 'academic_load_controller.dart';
export 'academic_load_controller.dart';

class AcademicLoadForm extends GetView<AcademicLoadController> {
  const AcademicLoadForm({Key? key}) : super(key: key);

  String? validateStudent(String? value) {
    if (!controller.academicLoad.validateId6(value)) {
      return 'ID no válido';
    } else {
      Student.exist(int.tryParse(value!)!).then((value) {
        if (value) {
          return null;
        } else {
          return 'No existe ningún estudiante con ese ID';
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final AcademicLoad? update = Get.arguments['update'];
    if (update != null) controller.academicLoad = update;

    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        title: update == null ? const Text('Agregar Carga Académica') : const Text('Modificar Carga Académica'),
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
                    initialValue: update == null ? Get.arguments['initialId'].toString() : controller.academicLoad.id.toString(),
                    validator: (value) => controller.academicLoad.validateNumber(value) ? null : 'ID no válido',
                    onSaved: (value) => controller.academicLoad.id = value == null ? 0 : int.tryParse(value)!,
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'ID Estudiante',
                    ),
                    initialValue: update == null ? '' : controller.academicLoad.student!.id.toString(),
                    validator: validateStudent,
                    onSaved: (value) => controller.idStudent = int.tryParse(value!)!,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  CourseDropdownButton(
                    update: update == null ? Get.arguments['initialValues'] : update.course,
                    onSaved: (newValue) => controller.academicLoad.course = newValue,
                    onChanged: (value) {},
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
