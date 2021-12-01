import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'classroom_controller.dart';
export 'classroom_controller.dart';

class ClassroomForm extends GetView<ClassroomController> {
  const ClassroomForm({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final update = Get.arguments;
    if (update != null) controller.classroom = update;
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: update == null ? const Text('Agregar Salón de Clases') : const Text('Editar Salón de Clases'),
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
                    initialValue: update == null ? '' : controller.classroom.id.toString(),
                    enabled: update == null,
                    validator: (value) => controller.classroom.validateNumber(value) ? null : 'ID no válido',
                    onSaved: (value) => controller.classroom.id = value == null ? 0 : int.tryParse(value)!,
                  ),
                  const SizedBox(height: 20.0,),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Nombre',
                    ),
                    initialValue: controller.classroom.name,
                    onSaved: (value) => controller.classroom.name = value ?? '',
                  ),
                  const Divider(
                    height: 32.0,
                  ),
                  ElevatedButton(
                    child: update == null ? const Text('Agregar') : const Text('Editar'),
                    onPressed: () {
                      if(update == null) {
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