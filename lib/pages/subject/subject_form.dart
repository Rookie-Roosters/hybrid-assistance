import 'package:flutter/material.dart' hide Center;
import 'package:get/get.dart';
import 'package:hybrid_assistance/components/worthy/worthy_button.dart';
import 'package:hybrid_assistance/config/app_themes.dart';
import 'package:hybrid_assistance/models/subject.dart';
import 'package:hybrid_assistance/utils/ui_utils.dart';
import 'package:hybrid_assistance/widgets/department_dropdown.dart';
import 'subject_controller.dart';
export 'subject_controller.dart';

class SubjectForm extends GetView<SubjectController> {
  const SubjectForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Subject? update = Get.arguments['update'];
    if (update != null) controller.subject = update;

    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        title: update == null ? const Text('Agregar Materia') : const Text('Editar Materia'),
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
                    initialValue: update == null ? Get.arguments['initialId'].toString() : controller.subject.id.toString(),
                    enabled: false,
                    validator: (value) => controller.subject.validateNumber(value) ? null : 'ID no válido',
                    onSaved: (value) => controller.subject.id = value == null ? 0 : int.tryParse(value)!,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  DepartmentDropdownButton(
                      update: update == null ? Get.arguments['initialValues'] : update.department,
                      onSaved: (newValue) => controller.subject.department = newValue,
                      onChanged: (value) {}),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Nombre',
                    ),
                    initialValue: controller.subject.name,
                    validator: (value) => controller.subject.validateGenericName(value) ? null : 'Nombre no válido',
                    onSaved: (value) => controller.subject.name = value ?? '',
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
