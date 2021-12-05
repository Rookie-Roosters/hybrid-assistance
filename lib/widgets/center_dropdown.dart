import 'package:flutter/material.dart' hide Center;
import 'package:hybrid_assistance/models/center.dart';

class CenterDropdownButton extends StatefulWidget {
  final Center? update;
  final void Function(Center?) onSaved;
  final void Function(Center?) onChanged;
  const CenterDropdownButton({ Key? key, required this.onSaved, required this.update, required this.onChanged }) : super(key: key);

  @override
  _CenterDropdownButtonState createState() => _CenterDropdownButtonState();
}

class _CenterDropdownButtonState extends State<CenterDropdownButton> {
  List<Center> centers = [];
  Center? centerValue;
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
            element.id == widget.update!.id);
        if (index != -1) centerValue = centers[index];
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!show) {
      return const Text('No se encontró ningún Centro');
    } else {
      return DropdownButtonFormField<Center?>(
        decoration: const InputDecoration(labelText: 'Centro'),
        items: centers.map<DropdownMenuItem<Center?>>((Center? value) {
          return DropdownMenuItem<Center?>(
            value: value,
            child: Text(value!.name),
          );
        }).toList(),
        value: centerValue,
        onChanged: (Center? newValue) {
          setState(() {
            centerValue = newValue!;
            widget.onChanged(newValue);
          });
        },
        validator: (value) => centerValue != null ? null : 'Centro no válido',
        onSaved: (value) {
          widget.onSaved(value);
        }
      );
    }
  }
}