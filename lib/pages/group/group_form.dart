import 'package:flutter/material.dart' hide Center;
import 'package:get/get.dart';
import 'package:hybrid_assistance/models/center.dart';
import 'package:hybrid_assistance/models/department.dart';
import 'package:hybrid_assistance/models/career.dart';
import 'package:hybrid_assistance/models/group.dart';
import 'group_controller.dart';
export 'group_controller.dart';

class GroupForm extends GetView<GroupController> {
  const GroupForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final update = Get.arguments;
    if (update != null) controller.group = update;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: update == null
            ? const Text('Agregar Grupo')
            : const Text('Editar Grupo'),
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
                        update == null ? '' : controller.group.id.toString(),
                    enabled: update == null,
                    validator: (value) => controller.group.validateNumber(value)
                        ? null
                        : 'ID no válido',
                    onSaved: (value) => controller.group.id =
                        value == null ? 0 : int.tryParse(value)!,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  GroupDropdownButtons(
                    controller: controller,
                    update: update,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                        labelText: 'Generación', hintText: 'Ej. 2000-2005'),
                    initialValue:
                        update == null ? '' : controller.group.generation,
                    validator: (value) =>
                        controller.group.validateGeneration(value)
                            ? null
                            : 'Generación no válida',
                    onSaved: (value) =>
                        controller.group.generation = value ?? '',
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Letra',
                    ),
                    initialValue: update == null ? '' : controller.group.letter,
                    validator: (value) => controller.group.validateLetter(value)
                        ? null
                        : 'Letra no válida',
                    onSaved: (value) => controller.group.letter = value ?? '',
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
                    },
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

class GroupDropdownButtons extends StatefulWidget {
  final GroupController controller;
  final Group? update;

  const GroupDropdownButtons(
      {Key? key, required this.controller, required this.update})
      : super(key: key);

  @override
  _GroupDropdownButtonsState createState() => _GroupDropdownButtonsState();
}

class _GroupDropdownButtonsState extends State<GroupDropdownButtons> {
  List<Center> centers = [];
  List<Department> departments = [];
  List<Career> careers = [];
  Center? centerValue;
  Department? departmentValue;
  Career? careerValue;
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
        final index = centers.indexWhere((element) =>
            element.id == widget.update!.career!.department!.center!.id);
        if (index != -1) centerValue = centers[index];
      }
      departments = await Department.getByCenter(centerValue!.id);
      if (departments.isNotEmpty) {
        departmentValue = departments[0];
        if (widget.update != null) {
          final index = departments.indexWhere(
              (element) => element.id == widget.update!.career!.department!.id);
          if (index != -1) departmentValue = departments[index];
        }
        careers = await Career.getByDepartment(departmentValue!.id);
        if (careers.isNotEmpty) {
          careerValue = careers[0];
          if (widget.update != null) {
            final index = careers.indexWhere(
                (element) => element.id == widget.update!.career!.id);
            if (index != -1) careerValue = careers[index];
          }
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
                  careers = await Career.getByDepartment(departmentValue!.id);
                  if (careers.isNotEmpty) {
                    careerValue = careers[0];
                  } else {
                    careerValue = null;
                  }
                } else {
                  departmentValue = null;
                  careerValue = null;
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
            onChanged: (Department? newValue) async {
              departmentValue = newValue;
              if (departmentValue != null) {
                careers = await Career.getByDepartment(departmentValue!.id);
                if (careers.isNotEmpty) {
                  careerValue = careers[0];
                } else {
                  careerValue = null;
                }
              }
              setState(() {});
            },
            validator: (value) =>
                value != null ? null : 'Departamento no válido',
          ),
          const SizedBox(height: 20.0),
          DropdownButtonFormField<Career?>(
            decoration: const InputDecoration(labelText: 'Carrera'),
            items: careers.map<DropdownMenuItem<Career?>>((Career? value) {
              return DropdownMenuItem<Career?>(
                value: value,
                child: value == null ? const Text('') : Text(value.name),
              );
            }).toList(),
            value: careerValue,
            onChanged: (Career? newValue) {
              setState(() {
                careerValue = newValue;
              });
            },
            validator: (value) => value != null ? null : 'Carrera no válida',
            onSaved: (value) => widget.controller.group.career = careerValue,
          ),
        ],
      );
    }
  }
}
