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

  static Future<int> getId() async {
    final result = await DatabaseService.to.connection.query('''
      SELECT MAX(`id`)
      FROM `academic_load`
      ''');
    if (result.length == 1) {
      for (var row in result) {
        return (row[0] ?? 0) + 1;
      }
    }
    throw Exception('Bad consult.');
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
    throw Exception(
        'Query returned more than one academic load or no academic load.');
  }

  static Future<List<AcademicLoad>> getByCourse(int id) async {
    final result = await DatabaseService.to.connection.query(
      '''
      SELECT `id`, `id_student`, `id_course`
      FROM `academic_load`
      WHERE `id_course`=?;
      ''',
      [id],
    );
    List<AcademicLoad> academicLoads = [];
    for (var row in result) {
      academicLoads.add(AcademicLoad(
        id: row[0],
        student: await Student.getById(row[1]),
        course: await Course.getById(row[2]),
      ));
    }
    return academicLoads;
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
        ''', [id, student!.id, course!.id, lastId ?? id]);
    } else {
      throw Exception('Invalid Data or academi load doesn\'t exist');
    }
  }

  Future<void> delete() async {
    if (await exist(id)) {
      await DatabaseService.to.connection.query('''
      DELETE FROM `academic_load` WHERE `id` = ?;
      ''', [id]);
    } else {
      throw Exception('Academic Load doesn\'t exist');
    }
  }
}
