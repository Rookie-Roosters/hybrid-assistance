import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'center_controller.dart';
export 'center_controller.dart';

class CenterForm extends GetView<CenterController> {
  const CenterForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final update = Get.arguments['update'];
    if (update != null) controller.center = update;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: update == null
            ? const Text('Agregar Centro')
            : const Text('Editar Centro'),
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
                        update == null ? Get.arguments['initialId'].toString() : controller.center.id.toString(),
                    enabled: false,
                    validator: (value) =>
                        controller.center.validateNumber(value)
                            ? null
                            : 'ID no válido',
                    onSaved: (value) => controller.center.id =
                        value == null ? 0 : int.tryParse(value)!,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Nombre',
                    ),
                    initialValue: controller.center.name,
                    validator: (value) =>
                        controller.center.validateGenericName(value)
                            ? null
                            : 'Nombre no válido',
                    onSaved: (value) => controller.center.name = value ?? '',
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
                    }
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
