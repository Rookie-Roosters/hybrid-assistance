import 'package:flutter/material.dart';
import 'package:hybrid_assistance/models/career.dart';
import 'package:hybrid_assistance/models/group.dart';
import 'package:hybrid_assistance/widgets/career_dropdown.dart';

class GroupDropdownButton extends StatefulWidget {
  final Group? update;
  final void Function(Group?) onSaved;
  final void Function(Group?) onChanged;
  const GroupDropdownButton(
      {Key? key,
      required this.update,
      required this.onSaved,
      required this.onChanged})
      : super(key: key);

  @override
  _GroupDropdownButtonState createState() => _GroupDropdownButtonState();
}

class _GroupDropdownButtonState extends State<GroupDropdownButton> {
  List<Career> careers = [];
  List<Group> groups = [];
  Career? careerValue;
  Group? groupValue;
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
    careers = widget.update == null
        ? await Career.getByDepartment(0)
        : await Career.getByDepartment(widget.update!.career!.department!.id);
    if (careers.isNotEmpty) {
      careerValue = careers[0];
      if (widget.update != null) {
        final index = careers.indexWhere(
            (element) => element.id == widget.update!.career!.id);
        if (index != -1) careerValue = careers[index];
      }
      groups = await Group.getByCareer(careerValue!.id);
      if (groups.isNotEmpty) {
        groupValue = groups[0];
        if (widget.update != null) {
          final index =
              groups.indexWhere((element) => element.id == widget.update!.id);
          if (index != -1) groupValue = groups[index];
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!show) {
      return const Text('No se encontró ningún Grupo');
    }
    return Column(
      children: [
        CareerDropdownButton(
          onSaved: (newValue) {},
          update: careerValue,
          onChanged: (newValue) async {
            careerValue = newValue;
            groups = await Group.getByCareer(careerValue!.id);
            setState(() {
              if (groups.isNotEmpty) {
                groupValue = groups[0];
                if (widget.update != null) {
                  final index = groups
                      .indexWhere((element) => element.id == widget.update!.id);
                  if (index != -1) groupValue = groups[index];
                }
              } else {
                groupValue = null;
              }
              widget.onChanged(groupValue);
            });
          },
        ),
        const SizedBox(
          height: 20.0,
        ),
        DropdownButtonFormField<Group?>(
            decoration: const InputDecoration(labelText: 'Grupo'),
            items: groups.map<DropdownMenuItem<Group?>>((Group? value) {
              return DropdownMenuItem<Group?>(
                value: value,
                child: value == null ? const Text('') : Text(value.generation + " " + value.letter),
              );
            }).toList(),
            value: groupValue,
            onChanged: (Group? newValue) {
              setState(() {
                groupValue = newValue;
                widget.onChanged(newValue);
              });
            },
            validator: (value) =>
                value != null ? null : 'Grupo no válido',
            onSaved: (value) {
              widget.onSaved(value);
            }),
      ],
    );
  }
}
