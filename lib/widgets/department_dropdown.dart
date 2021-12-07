import 'package:flutter/material.dart' hide Center;
import 'package:hybrid_assistance/models/center.dart';
import 'package:hybrid_assistance/models/department.dart';
import 'package:hybrid_assistance/widgets/center_dropdown.dart';

class DepartmentDropdownButton extends StatefulWidget {
  final Department? update;
  final void Function(Department?) onSaved;
  final void Function(Department?) onChanged;
  const DepartmentDropdownButton(
      {Key? key,
      required this.update,
      required this.onSaved,
      required this.onChanged})
      : super(key: key);

  @override
  _DepartmentDropdownButtonState createState() =>
      _DepartmentDropdownButtonState();
}

class _DepartmentDropdownButtonState extends State<DepartmentDropdownButton> {
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
        final index = centers
            .indexWhere((element) => element.id == widget.update!.center!.id);
        if (index != -1) centerValue = centers[index];
      }
      departments = await Department.getByCenter(centerValue!.id);
      if (departments.isNotEmpty) {
        departmentValue = departments[0];
        if (widget.update != null) {
          final index = departments
              .indexWhere((element) => element.id == widget.update!.id);
          if (index != -1) departmentValue = departments[index];
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!show) {
      return const Text('No se encontró ningún Departamento');
    }
    return Column(
      children: [
        CenterDropdownButton(
          onSaved: (newValue) {},
          update: centerValue,
          onChanged: (newValue) async {
            centerValue = newValue;
            departments = await Department.getByCenter(centerValue!.id);
            setState(() {
              if (departments.isNotEmpty) {
                departmentValue = departments[0];
                if (widget.update != null) {
                  final index = departments
                      .indexWhere((element) => element.id == widget.update!.id);
                  if (index != -1) departmentValue = departments[index];
                }
              } else {
                departmentValue = null;
              }
              widget.onChanged(departmentValue);
            });
          },
        ),
        const SizedBox(
          height: 20.0,
        ),
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
                widget.onChanged(newValue);
              });
            },
            validator: (value) =>
                value != null ? null : 'Departamento no válido',
            onSaved: (value) {
              widget.onSaved(value);
            }),
      ],
    );
  }
}
