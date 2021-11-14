import 'student.dart';
import 'schedule.dart';

enum State { present, absent, online }

class Attendance {
  int _idAttendance;
  DateTime _dateTime;
  Schedule _schedule;
  Student _student;
  State _state;

  Attendance({required int idAttendance, required DateTime dateTime, required Schedule schedule, required Student student, required State state}) : _idAttendance = idAttendance, _dateTime = dateTime, _schedule = schedule, _student = student, _state = state;
}