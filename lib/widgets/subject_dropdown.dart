import 'package:flutter/material.dart';
import 'package:hybrid_assistance/models/department.dart';
import 'package:hybrid_assistance/models/subject.dart';
import 'package:hybrid_assistance/widgets/department_dropdown.dart';

class SubjectDropdownButton extends StatefulWidget {
  final Subject? update;
  final void Function(Subject?) onSaved;
  final void Function(Subject?) onChanged;
  const SubjectDropdownButton(
      {Key? key,
      required this.update,
      required this.onSaved,
      required this.onChanged})
      : super(key: key);

  @override
  _SubjectDropdownButtonState createState() => _SubjectDropdownButtonState();
}

class _SubjectDropdownButtonState extends State<SubjectDropdownButton> {
  List<Department> departments = [];
  List<Subject> subjects = [];
  Department? departmentValue;
  Subject? subjectValue;
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
      subjects = await Subject.getByDepartment(departmentValue!.id);
      if (subjects.isNotEmpty) {
        subjectValue = subjects[0];
        if (widget.update != null) {
          final index =
              subjects.indexWhere((element) => element.id == widget.update!.id);
          if (index != -1) subjectValue = subjects[index];
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!show) {
      return const Text('No se encontró ningúna Materia');
    }
    return Column(
      children: [
        DepartmentDropdownButton(
          onSaved: (newValue) {},
          update: departmentValue,
          onChanged: (newValue) async {
            departmentValue = newValue;
            if(subjectValue != null) {
              subjects = await Subject.getByDepartment(departmentValue!.id);
            } else {
              subjects = [];
            }
            setState(() {
              if (subjects.isNotEmpty) {
                subjectValue = subjects[0];
                if (widget.update != null) {
                  final index = subjects
                      .indexWhere((element) => element.id == widget.update!.id);
                  if (index != -1) subjectValue = subjects[index];
                }
              } else {
                subjectValue = null;
              }
              widget.onChanged(subjectValue);
            });
          },
        ),
        const SizedBox(
          height: 20.0,
        ),
        DropdownButtonFormField<Subject?>(
            decoration: const InputDecoration(labelText: 'Materia'),
            items: subjects.map<DropdownMenuItem<Subject?>>((Subject? value) {
              return DropdownMenuItem<Subject?>(
                value: value,
                child: value == null ? const Text('') : Text(value.name),
              );
            }).toList(),
            value: subjectValue,
            onChanged: (Subject? newValue) {
              setState(() {
                subjectValue = newValue;
                widget.onChanged(newValue);
              });
            },
            validator: (value) =>
                value != null ? null : 'Materia no válida',
            onSaved: (value) {
              widget.onSaved(value);
            }),
      ],
    );
  }
}
