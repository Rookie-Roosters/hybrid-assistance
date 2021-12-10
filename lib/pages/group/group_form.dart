import 'package:flutter/material.dart' hide Center;
import 'package:get/get.dart';
import 'package:hybrid_assistance/components/worthy/worthy_button.dart';
import 'package:hybrid_assistance/config/app_themes.dart';
import 'package:hybrid_assistance/models/group.dart';
import 'package:hybrid_assistance/utils/ui_utils.dart';
import 'package:hybrid_assistance/widgets/career_dropdown.dart';
import 'group_controller.dart';
export 'group_controller.dart';

class GroupForm extends GetView<GroupController> {
  const GroupForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Group? update = Get.arguments['update'];
    if (update != null) controller.group = update;

    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        title: update == null ? const Text('Agregar Grupo') : const Text('Editar Grupo'),
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
                    initialValue: update == null ? Get.arguments['initialId'].toString() : controller.group.id.toString(),
                    enabled: false,
                    validator: (value) => controller.group.validateNumber(value) ? null : 'ID no válido',
                    onSaved: (value) => controller.group.id = value == null ? 0 : int.tryParse(value)!,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  CareerDropdownButton(
                      update: update == null ? Get.arguments['initialValues'] : update.career,
                      onSaved: (newValue) => controller.group.career = newValue,
                      onChanged: (value) {}),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Generación', hintText: 'Ej. 2000-2005'),
                    initialValue: update == null ? '' : controller.group.generation,
                    validator: (value) => controller.group.validateGeneration(value) ? null : 'Generación no válida',
                    onSaved: (value) => controller.group.generation = value ?? '',
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Letra',
                    ),
                    initialValue: update == null ? '' : controller.group.letter,
                    validator: (value) => controller.group.validateLetter(value) ? null : 'Letra no válida',
                    onSaved: (value) => controller.group.letter = value ?? '',
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
