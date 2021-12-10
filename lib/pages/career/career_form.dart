import 'package:flutter/material.dart' hide Center;
import 'package:get/get.dart';
import 'package:hybrid_assistance/components/worthy/worthy_button.dart';
import 'package:hybrid_assistance/config/app_themes.dart';
import 'package:hybrid_assistance/models/career.dart';
import 'package:hybrid_assistance/utils/ui_utils.dart';
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
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        title: update == null ? const Text('Agregar Carrera') : const Text('Modificar Carrera'),
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
                    initialValue: update == null ? Get.arguments['initialId'].toString() : controller.career.id.toString(),
                    enabled: false,
                    validator: (value) => controller.career.validateNumber(value) ? null : 'ID no válido',
                    onSaved: (value) => controller.career.id = value == null ? 0 : int.tryParse(value)!,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  DepartmentDropdownButton(
                      update: update == null ? Get.arguments['initialValues'] : update.department,
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
                    validator: (value) => controller.career.validateGenericName(value) ? null : 'Nombre no válido',
                    onSaved: (value) => controller.career.name = value ?? '',
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
