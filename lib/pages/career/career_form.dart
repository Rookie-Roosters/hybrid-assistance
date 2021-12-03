import 'package:flutter/material.dart' hide Center;
import 'package:get/get.dart';
import 'package:hybrid_assistance/models/center.dart';
import 'package:hybrid_assistance/models/department.dart';
import 'package:hybrid_assistance/models/career.dart';
import 'career_controller.dart';
export 'career_controller.dart';

class CareerForm extends GetView<CareerController> {
  const CareerForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final update = Get.arguments;
    if (update != null) controller.career = update;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: update == null
            ? const Text('Agregar Carrera')
            : const Text('Editar Carrera'),
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
                        update == null ? '' : controller.career.id.toString(),
                    enabled: update == null,
                    validator: (value) =>
                        controller.career.validateNumber(value)
                            ? null
                            : 'ID no válido',
                    onSaved: (value) => controller.career.id =
                        value == null ? 0 : int.tryParse(value)!,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  CareerDropdownButtons(
                    controller: controller,
                    update: update,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Nombre',
                    ),
                    initialValue: controller.career.name,
                    validator: (value) =>
                        controller.career.validateGenericName(value)
                            ? null
                            : 'Nombre no válido',
                    onSaved: (value) => controller.career.name = value ?? '',
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

class CareerDropdownButtons extends StatefulWidget {
  final CareerController controller;
  final Career? update;

  const CareerDropdownButtons(
      {Key? key, required this.controller, required this.update})
      : super(key: key);

  @override
  _CareerDropdownButtonsState createState() => _CareerDropdownButtonsState();
}

class _CareerDropdownButtonsState extends State<CareerDropdownButtons> {
  List<Center> centers = [];
  List<Department> departments = [];
  Center? centerValue;
  Department? departmentValue;
  bool show = false;

  @override
  void initState() {
    super.initState();

    loadData().then((value) {
      setState(() {
        show = true;
      });
    });
  }

  Future<void> loadData() async {
    centers = await Center.getAll();
    if (centers.isNotEmpty) {
      centerValue = centers[0];
      if (widget.update != null) {
        final index = centers.indexWhere(
            (element) => element.id == widget.update!.department!.center!.id);
        if (index != -1) centerValue = centers[index];
      }
      departments = await Department.getByCenter(centerValue!.id);
      if (departments.isNotEmpty) {
        departmentValue = departments[0];
        if (widget.update != null) {
          final index = departments.indexWhere(
              (element) => element.id == widget.update!.department!.id);
          if (index != -1) departmentValue = departments[index];
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!show) {
      return const Text('No se encontró ningún Centro y Departamento');
    } else {
      return Column(
        children: [
          DropdownButtonFormField<Center>(
            decoration: const InputDecoration(labelText: 'Centro'),
            items: centers.map<DropdownMenuItem<Center>>((Center value) {
              return DropdownMenuItem<Center>(
                value: value,
                child: Text(value.name),
              );
            }).toList(),
            value: centerValue,
            onChanged: (Center? newValue) async {
              centerValue = newValue;
              if (centerValue != null) {
                departments = await Department.getByCenter(centerValue!.id);
                if (departments.isNotEmpty) {
                  departmentValue = departments[0];
                } else {
                  departmentValue = null;
                }
              }
              setState(() {});
            },
            validator: (value) => value == null ? 'Centro no válido' : null,
          ),
          const SizedBox(height: 20.0),
          DropdownButtonFormField<Department?>(
            decoration: const InputDecoration(labelText: 'Departamento'),
            items: departments
                .map<DropdownMenuItem<Department?>>((Department? value) {
              return DropdownMenuItem<Department?>(
                value: value,
                child: value == null ? const Text('') : Text(value.name),
              );
            }).toList(),
            value: departmentValue,
            onChanged: (Department? newValue) {
              setState(() {
                departmentValue = newValue;
              });
            },
            validator: (value) =>
                value != null ? null : 'Departamento no válido',
            onSaved: (value) => widget.controller.career.department = value,
          ),
        ],
      );
    }
  }
}
