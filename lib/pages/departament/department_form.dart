import 'package:flutter/material.dart' hide Center;
import 'package:get/get.dart';
import 'package:hybrid_assistance/models/center.dart';
import 'department_controller.dart';
export 'department_controller.dart';

class DepartmentForm extends GetView<DepartmentController> {
  const DepartmentForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final update = Get.arguments;
    if (update != null) controller.department = update;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: update == null
            ? const Text('Agregar Departamento')
            : const Text('Editar Departamento'),
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
                    initialValue: update == null
                        ? ''
                        : controller.department.id.toString(),
                    enabled: update == null,
                    validator: (value) =>
                        controller.department.validateNumber(value)
                            ? null
                            : 'ID no válido',
                    onSaved: (value) => controller.department.id =
                        value == null ? 0 : int.tryParse(value)!,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  DepartmentDropdownButton(
                    controller: controller,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Nombre',
                    ),
                    initialValue: controller.department.name,
                    validator: (value) =>
                        controller.department.validateGenericName(value)
                            ? null
                            : 'Nombre no válido',
                    onSaved: (value) =>
                        controller.department.name = value ?? '',
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

class DepartmentDropdownButton extends StatefulWidget {
  final DepartmentController controller;

  const DepartmentDropdownButton({Key? key, required this.controller})
      : super(key: key);

  @override
  _DepartmentDropdownButtonState createState() =>
      _DepartmentDropdownButtonState();
}

class _DepartmentDropdownButtonState extends State<DepartmentDropdownButton> {
  List<Center> centers = [];
  Center? dropdownValue;

  @override
  void initState() {
    super.initState();

    Center.getAll().then((data) {
      setState(() {
        centers = data;
        if (centers.isNotEmpty) dropdownValue = centers[0];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (centers.isEmpty) {
      return const Text('No se encontró ningún Centro');
    } else {
      return DropdownButtonFormField<Center>(
        decoration: const InputDecoration(labelText: 'Centro'),
        items: centers.map<DropdownMenuItem<Center>>((Center value) {
          return DropdownMenuItem<Center>(
            value: value,
            child: Text(value.name),
          );
        }).toList(),
        value: dropdownValue,
        onChanged: (Center? newValue) {
          setState(() {
            dropdownValue = newValue!;
          });
        },
        validator: (value) => dropdownValue != null ? null : 'Centro no válido',
        onSaved: (value) => widget.controller.department.center = value,
      );
    }
  }
}
