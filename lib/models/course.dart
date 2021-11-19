import 'group.dart';
import 'subject.dart';
import 'teacher.dart';

class Course {
  int id;
  Group group;
  Subject subject;
  Teacher teacher;
  String attendanceCode;

  Course({
    required this.id,
    required this.group,
    required this.subject,
    required this.teacher,
    required this.attendanceCode,
  });
}
