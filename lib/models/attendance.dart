import 'schedule.dart';
import 'student.dart';

enum AttendanceStatus { absent, present, online }

class Attendance {
  int id;
  Student student;
  Schedule schedule;
  DateTime dateTime;
  AttendanceStatus status;

  Attendance({
    required this.id,
    required this.student,
    required this.schedule,
    required this.dateTime,
    required this.status,
  });
}
