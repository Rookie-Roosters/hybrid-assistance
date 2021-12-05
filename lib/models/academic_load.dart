import 'package:hybrid_assistance/utils/validate_utils.dart';

import 'course.dart';
import 'student.dart';

class AcademicLoad with ValidateUtils {
  int id;
  Student? student;
  Course? course;

  //Constructor
  AcademicLoad({
    required this.id,
    required this.student,
    required this.course,
  });

  //Validaciones

  //CRUD
  Future<void> add() async {}
  Future<void> update({int? lastId}) async {}
}
