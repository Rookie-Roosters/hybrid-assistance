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
      ''', [id],
    );
    if(result.isNotEmpty) return true;
    return false;
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

  Future<void> add() async {
    if (validate() && !await exist(id)) {
      await DatabaseService.to.connection.query(
        '''
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
      await DatabaseService.to.connection.query(
        '''
        UPDATE `course`
        SET `id`=?,`id_group`=?,`id_subject`=?,`id_teacher`=?,`attendance_code`=?
        WHERE `id`=?;
        ''', [id, group!.id, subject!.id, teacher!.id, attendanceCode, lastId ?? id]);
    } else {
      throw Exception('Invalid Data or Group doesn\'t exist');
    }
  }
}
