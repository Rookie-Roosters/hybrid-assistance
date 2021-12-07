import 'package:hybrid_assistance/services/database_service.dart';
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
  bool validate() {
    return validateNumber(id.toString());
  }

  //CRUD
  static Future<bool> exist(int id) async {
    final result = await DatabaseService.to.connection.query(
      '''
      SELECT * FROM `academic_load` WHERE `id`=?;
      ''',
      [id],
    );
    if (result.isNotEmpty) return true;
    return false;
  }

  static Future<AcademicLoad> getById(int id) async {
    final result = await DatabaseService.to.connection.query(
      '''
      SELECT `id`, `id_student`, `id_course`
      FROM `academic_load`
      WHERE `id`=?;
      ''',
      [id],
    );
    if (result.length == 1) {
      for (var row in result) {
        return AcademicLoad(
          id: row[0],
          student: await Student.getById(row[1]),
          course: await Course.getById(row[2]),
        );
      }
    }
    throw Exception('Query returned more than one academic load or no academic load.');
  }

  Future<void> add() async {
    if (validate() && !await exist(id)) {
      await DatabaseService.to.connection.query('''
        INSERT INTO `academic_load`
        (`id`, `id_student`, `id_course`)
        VALUES (?,?,?)
        ''', [id, student!.id, course!.id]);
    } else {
      throw Exception('Invalid Data or academic load already exist');
    }
  }

  Future<void> update({int? lastId}) async {
    if (validate() && await exist(id)) {
      await DatabaseService.to.connection.query('''
        UPDATE `academic_load`
        SET `id`=?,`id_student`=?,`id_course`=?
        WHERE `id`=?;
        ''', [
        id,
        student!.id,
        course!.id,
        lastId ?? id
      ]);
    } else {
      throw Exception('Invalid Data or academi load doesn\'t exist');
    }
  }
}
