import 'course.dart';
import 'classroom.dart';

enum WeekDay { monday, tuesday, wednesday, thursday, friday, saturday, sunday }

class Schedule {
  int id;
  Course course;
  Classroom classroom;
  WeekDay weekDay;
  DateTime startTime;
  DateTime endTime;

  Schedule({
    required this.id,
    required this.course,
    required this.classroom,
    required this.weekDay,
    required this.startTime,
    required this.endTime,
  });
}
