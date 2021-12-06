import 'package:flutter/material.dart';
import 'package:hybrid_assistance/models/course.dart';
import 'package:hybrid_assistance/models/group.dart';
import 'package:hybrid_assistance/models/subject.dart';
import 'package:hybrid_assistance/widgets/group_dropdown.dart';
import 'package:hybrid_assistance/widgets/subject_dropdown.dart';

class CourseDropdownButton extends StatefulWidget {
  final Course? update;
  final void Function(Course?) onSaved;
  final void Function(Course?) onChanged;
  const CourseDropdownButton(
      {Key? key,
      required this.update,
      required this.onSaved,
      required this.onChanged})
      : super(key: key);

  @override
  _CourseDropdownButtonState createState() => _CourseDropdownButtonState();
}

class _CourseDropdownButtonState extends State<CourseDropdownButton> {
  Course? courseValue;
  Group? groupValue;
  Subject? subjectValue;

  List<Course> courses = [];
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
    if(widget.update != null) {
      groupValue = widget.update!.group;
      subjectValue = widget.update!.subject;
      courses = await Course.getByGroupAndSubject(groupValue!.id, subjectValue!.id);
      final index = courses.indexWhere((element) => element.id == widget.update!.id);
      if(index != -1) courseValue = courses[index];
    } else {
      courses = await Course.getByGroupAndSubject(0, 0);
      if(courses.isNotEmpty) {
        courseValue = courses[0];
        groupValue = courseValue!.group;
        subjectValue = courseValue!.subject;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!show) {
      return const Text('No se encontró ningún Curso');
    }
    return Column(
      children: [
        const Text('Grupo'),
        GroupDropdownButton(
          update: widget.update?.group,
          onSaved: (newValue) {},
          onChanged: (value) async {
            groupValue = value;
            if (groupValue != null && subjectValue != null) {
              courses = await Course.getByGroupAndSubject(
                  groupValue!.id, subjectValue!.id);
              if (courses.isNotEmpty) {
                courseValue = courses[0];
              } else {
                courseValue = null;
              }
            } else {
              courses = [];
              courseValue = null;
            }
            setState(() {});
          },
        ),
        const SizedBox(
          height: 20.0,
        ),
        const Text('Materia'),
        SubjectDropdownButton(
          update: widget.update?.subject,
          onSaved: (newValue) {},
          onChanged: (value) async {
            subjectValue = value;
            if (groupValue != null && subjectValue != null) {
              courses = await Course.getByGroupAndSubject(
                  groupValue!.id, subjectValue!.id);
              if (courses.isNotEmpty) {
                courseValue = courses[0];
              } else {
                courseValue = null;
              }
            } else {
              courses = [];
              courseValue = null;
            }
            setState(() {});
          },
        ),
        const SizedBox(
          height: 20.0,
        ),
        const Text('Curso'),
        DropdownButtonFormField<Course?>(
          decoration: const InputDecoration(labelText: 'Curso'),
          items: courses.map<DropdownMenuItem<Course?>>((Course? value) {
            return DropdownMenuItem<Course?>(
              value: value,
              child: value == null
                  ? const Text('')
                  : Text(value.group!.generation +
                      ' ' +
                      value.group!.letter +
                      ' ' +
                      value.subject!.name),
            );
          }).toList(),
          value: courseValue,
          onChanged: (Course? newValue) {
            setState(() {
              courseValue = newValue;
              widget.onChanged(newValue);
            });
          },
          validator: (value) => value != null ? null : 'Curso no válido',
          onSaved: (value) {
            widget.onSaved(value);
          },
        ),
      ],
    );
  }
}
