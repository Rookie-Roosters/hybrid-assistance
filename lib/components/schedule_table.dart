import 'package:flutter/material.dart';
import 'package:hybrid_assistance/models/schedule.dart';
import 'package:hybrid_assistance/utils/ui_utils.dart';

class ScheduleTable extends StatelessWidget {
  final List<Schedule> schedule;
  const ScheduleTable(this.schedule, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(mainAxisSize: MainAxisSize.max, crossAxisAlignment: CrossAxisAlignment.stretch, 
      children: [const Text('Clases de toda la semana').p3,
      Row(
        children: [
          Column()
        ],
      )
      ],
      )
    );
  }
}
