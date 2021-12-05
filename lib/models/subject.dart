import 'package:hybrid_assistance/services/database_service.dart';
import 'package:hybrid_assistance/utils/validate_utils.dart';

import 'department.dart';

class Subject extends ValidateUtils {
  int id;
  Department? department;
  String name;

  //Constructor
  Subject({
    required this.id,
    required this.department,
    required this.name,
  });

  //Validar
  bool validate() {
    return validateNumber(id.toString()) && validateGenericName(name);
  }

  //CRUD
  Future<bool> exist(int id) async {
    final result = await DatabaseService.to.connection.query(
      '''
      SELECT * FROM subject WHERE `id` = ?;
      ''',
      [id],
    );
    if (result.isNotEmpty) return true;
    return false;
  }

  static Future<Subject> getById(int id) async {
    final result = await DatabaseService.to.connection.query(
      '''
      SELECT id, id_department, name 
      FROM subject
      WHERE id=?
      ''',
      [id],
    );
    if (result.length == 1) {
      for (var row in result) {
        return Subject(
          id: row[0],
          department: await Department.getById(row[1]),
          name: row[2],
        );
      }
    }
    throw Exception('Query returned more than one subject or no subjects.');
  }

  static Future<List<Subject>> getByDepartment(int id) async {
    final result = await DatabaseService.to.connection.query(
      '''
      SELECT id, id_department, name 
      FROM subject
      WHERE id_department=?
      ''',
      [id],
    );
    List<Subject> subjects = [];
    for (var row in result) {
      Subject subject = Subject(
        id: row[0],
        department: await Department.getById(row[1]),
        name: row[2],
      );
      subjects.add(subject);
    }
    return subjects;
  }

  Future<void> add() async {
    if (validate() && !await exist(id)) {
      //Cambiar por las validaciones
      await DatabaseService.to.connection.query('''
        INSERT INTO `subject`
        (`id`, `id_department`, `name`)
        VALUES (?,?,?);
        ''', [
        id,
        department!.id,
        name,
      ]);
    } else {
      throw Exception('Invalid Data or subject already exists');
    }
  }

  Future<void> update({int? lastId}) async {
    if (validate() && await exist(id)) {
      await DatabaseService.to.connection.query('''
      UPDATE `subject` SET
      `id`=?,`id_department`=?,`name`=?
      WHERE `id` = ?;
      ''', [id, department!.id, name, (lastId ?? id)]);
    } else {
      throw Exception('Invalid Data or subject doesn\'t exist');
    }
  }

  Future<void> delete() async {
    if (await exist(id)) {
      await DatabaseService.to.connection.query('''
      DELETE FROM `subject` WHERE `id` = ?;
      ''', [id]);
    } else {
      throw Exception('subject doesn\'t exist');
    }
  }
}
