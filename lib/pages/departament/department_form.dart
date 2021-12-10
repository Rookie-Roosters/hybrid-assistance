import 'package:flutter/material.dart' hide Center;
import 'package:get/get.dart';
import 'package:hybrid_assistance/components/worthy/worthy_button.dart';
import 'package:hybrid_assistance/config/app_themes.dart';
import 'package:hybrid_assistance/models/department.dart';
import 'package:hybrid_assistance/utils/ui_utils.dart';
import 'package:hybrid_assistance/widgets/center_dropdown.dart';
import 'department_controller.dart';
export 'department_controller.dart';

class DepartmentForm extends GetView<DepartmentController> {
  const DepartmentForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Department? update = Get.arguments['update'];
    if (update != null) controller.department = update;

    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        title: update == null ? const Text('Agregar Departamento') : const Text('Editar Departamento'),
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
                    initialValue: update == null ? Get.arguments['initialId'].toString() : controller.department.id.toString(),
                    enabled: false,
                    validator: (value) => controller.department.validateNumber(value) ? null : 'ID no válido',
                    onSaved: (value) => controller.department.id = value == null ? 0 : int.tryParse(value)!,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  CenterDropdownButton(
                      update: update == null ? Get.arguments['initialValues'] : update.center,
                      onSaved: (value) => controller.department.center = value,
                      onChanged: (value) {}),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Nombre',
                    ),
                    initialValue: controller.department.name,
                    validator: (value) => controller.department.validateGenericName(value) ? null : 'Nombre no válido',
                    onSaved: (value) => controller.department.name = value ?? '',
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
