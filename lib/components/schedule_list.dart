import 'package:flutter/material.dart';
import 'package:hybrid_assistance/models/schedule.dart';
import 'package:hybrid_assistance/utils/ui_utils.dart';

class ScheduleList extends StatelessWidget {
  final List<Schedule> schedule;
  const ScheduleList(this.schedule, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: const Text('Clases de hoy').p3,
    );
  }
}
