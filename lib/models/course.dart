import 'package:hybrid_assistance/services/database_service.dart';
import 'package:hybrid_assistance/utils/validate_utils.dart';

import 'group.dart';
import 'subject.dart';
import 'teacher.dart';

class Course with ValidateUtils {
  int id;
  Group? group;
  Subject? subject;
  Teacher? teacher;
  int attendanceCode;

  //Constructor
  Course({
    required this.id,
    required this.group,
    required this.subject,
    required this.teacher,
    required this.attendanceCode,
  });

  //Validaciones
  bool validate() {
    return validateNumber(id.toString());
  }

  //CRUD
  static Future<bool> exist(int id) async {
    final result = await DatabaseService.to.connection.query(
      '''
      SELECT * FROM `course` WHERE `id`=?;
      ''',
      [id],
    );
    if (result.isNotEmpty) return true;
    return false;
  }

  static Future<int> getId() async {
    final result = await DatabaseService.to.connection.query(
      '''
      SELECT MAX(`id`)
      FROM `course`
      '''
    );
    if (result.length == 1) {
      for (var row in result) {
        return (row[0] ?? 0) + 1;
      }
    }
    throw Exception('Bad consult.');
  }

  static Future<Course> getById(int id) async {
    final result = await DatabaseService.to.connection.query(
      '''
      SELECT `id`, `id_group`, `id_subject`, `id_teacher`, `attendance_code`
      FROM `course`
      WHERE `id`=?;
      ''',
      [id],
    );
    if (result.length == 1) {
      for (var row in result) {
        return Course(
          id: row[0],
          group: await Group.getById(row[1]),
          subject: await Subject.getById(row[2]),
          teacher: await Teacher.getById(row[3]),
          attendanceCode: row[4],
        );
      }
    }
    throw Exception('Query returned more than one group or no groups.');
  }

  static Future<List<Course>> getByGroupAndSubject(
      int idGroup, int idSubject) async {
    final result = await DatabaseService.to.connection.query(
      '''
      SELECT `id`, `id_group`, `id_subject`, `id_teacher`, `attendance_code`
      FROM `course`
      WHERE `id_group`=? AND `id_subject`=?;
      ''',
      [idGroup, idSubject],
    );
    List<Course> courses = [];
    for (var row in result) {
      Course course = Course(
        id: row[0],
        group: await Group.getById(row[1]),
        subject: await Subject.getById(row[2]),
        teacher: await Teacher.getById(row[3]),
        attendanceCode: row[4],
      );
      courses.add(course);
    }
    return courses;
  }

  Future<void> add() async {
    if (validate() && !await exist(id)) {
      await DatabaseService.to.connection.query('''
        INSERT INTO `course`
        (`id`, `id_group`, `id_subject`, `id_teacher`, `attendance_code`)
        VALUES (?,?,?,?,?);
        ''', [id, group!.id, subject!.id, teacher!.id, attendanceCode]);
    } else {
      throw Exception('Invalid Data or Group already exist');
    }
  }

  Future<void> update({int? lastId}) async {
    if (validate() && await exist(id)) {
      await DatabaseService.to.connection.query('''
        UPDATE `course`
        SET `id`=?,`id_group`=?,`id_subject`=?,`id_teacher`=?,`attendance_code`=?
        WHERE `id`=?;
        ''', [
        id,
        group!.id,
        subject!.id,
        teacher!.id,
        attendanceCode,
        lastId ?? id
      ]);
    } else {
      throw Exception('Invalid Data or Group doesn\'t exist');
    }
  }

  Future<void> delete() async {
    if (await exist(id)) {
      await DatabaseService.to.connection.query('''
      DELETE FROM `course` WHERE `id` = ?;
      ''', [id]);
    } else {
      throw Exception('Course doesn\'t exist');
    }
  }
}
