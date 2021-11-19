import 'package:flutter/material.dart';
import 'package:hybrid_assistance/models/attendance.dart';
import 'package:hybrid_assistance/models/schedule.dart';
import 'package:hybrid_assistance/utils/ui_utils.dart';

class AttendanceCalendar extends StatelessWidget {
  final List<Schedule>? schedule;
  final List<Attendance>? attendanceList;
  const AttendanceCalendar.student(this.attendanceList, {Key? key}) // Marca las asistencias/faltas del alumno
      : schedule = null,
        super(key: key);
  const AttendanceCalendar.teacher(this.schedule, {Key? key}) // Marca los días en los que hubo clase
      : attendanceList = null,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: const Text('Calendario de asistencia').p3,
    );
  }
}
