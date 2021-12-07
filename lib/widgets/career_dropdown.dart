import 'package:flutter/material.dart';
import 'package:hybrid_assistance/models/department.dart';
import 'package:hybrid_assistance/models/career.dart';
import 'package:hybrid_assistance/widgets/department_dropdown.dart';

class CareerDropdownButton extends StatefulWidget {
  final Career? update;
  final void Function(Career?) onSaved;
  final void Function(Career?) onChanged;
  const CareerDropdownButton(
      {Key? key,
      required this.update,
      required this.onSaved,
      required this.onChanged})
      : super(key: key);

  @override
  _CareerDropdownButtonState createState() => _CareerDropdownButtonState();
}

class _CareerDropdownButtonState extends State<CareerDropdownButton> {
  List<Department> departments = [];
  List<Career> careers = [];
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
    departments = widget.update == null
        ? await Department.getByCenter(1)
        : await Department.getByCenter(widget.update!.department!.center!.id);
    if (departments.isNotEmpty) {
      departmentValue = departments[0];
      if (widget.update != null) {
        final index = departments.indexWhere(
            (element) => element.id == widget.update!.department!.id);
        if (index != -1) departmentValue = departments[index];
      }
      careers = await Career.getByDepartment(departmentValue!.id);
      if (careers.isNotEmpty) {
        careerValue = careers[0];
        if (widget.update != null) {
          final index =
              careers.indexWhere((element) => element.id == widget.update!.id);
          if (index != -1) careerValue = careers[index];
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!show) {
      return const Text('No se encontró ningúna Carrera');
    }
    return Column(
      children: [
        DepartmentDropdownButton(
          onSaved: (newValue) {},
          update: departmentValue,
          onChanged: (newValue) async {
            departmentValue = newValue;
            if(departmentValue != null) {
              careers = await Career.getByDepartment(departmentValue!.id);
            } else {
              careers = [];
            }
            setState(() {
              if (careers.isNotEmpty) {
                careerValue = careers[0];
                if (widget.update != null) {
                  final index = careers
                      .indexWhere((element) => element.id == widget.update!.id);
                  if (index != -1) careerValue = careers[index];
                }
              } else {
                careerValue = null;
              }
              widget.onChanged(careerValue);
            });
          },
        ),
        const SizedBox(
          height: 20.0,
        ),
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
                widget.onChanged(newValue);
              });
            },
            validator: (value) =>
                value != null ? null : 'Carrera no válida',
            onSaved: (value) {
              widget.onSaved(value);
            }),
      ],
    );
  }
}
