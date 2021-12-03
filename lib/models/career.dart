import 'package:hybrid_assistance/services/database_service.dart';
import 'package:hybrid_assistance/utils/validate_utils.dart';

import 'department.dart';

class Career extends ValidateUtils {
  int id;
  Department? department;
  String name;

  //Constructor
  Career({
    required this.id,
    required this.department,
    required this.name,
  });

  //Validation
  bool validate() {
    return validateNumber(id.toString()) && validateGenericName(name);
  }

  //Crud
  Future<bool> exist(int id) async {
    final result = await DatabaseService.to.connection.query(
      '''
      SELECT * FROM career WHERE `id` = ?;
      ''',
      [id],
    );
    if (result.isNotEmpty) return true;
    return false;
  }

  static Future<Career> getById(int id) async {
    final result = await DatabaseService.to.connection.query(
      '''
      SELECT id, id_department, name 
      FROM career
      WHERE id=?
      ''',
      [id],
    );
    if (result.length == 1) {
      for (var row in result) {
        return Career(
          id: row[0],
          department: await Department.getById(row[1]),
          name: row[2],
        );
      }
    }
    throw Exception('Query returned more than one career or no careers.');
  }

  static Future<List<Career>> getByDepartment(int idDepartment) async {
    List<Career> careers = [];
    final result = await DatabaseService.to.connection.query(
      '''
      SELECT id, id_department, name 
      FROM career
      WHERE id_department=?
      ''',
      [idDepartment],
    );
    for (var row in result) {
      Career career = Career(
        id: row[0],
        department: await Department.getById(row[1]),
        name: row[2],
      );
      careers.add(career);
    }
    return careers;
  }

  Future<void> add() async {
    if (validate() && !await exist(id)) {
      await DatabaseService.to.connection.query('''
        INSERT INTO `career`
        (`id`, `id_department`, `name`)
        VALUES (?,?,?);
        ''', [
        id,
        department!.id,
        name,
      ]);
    } else {
      throw Exception('Invalid Data or career already exists');
    }
  }

  Future<void> update({int? lastId}) async {
    if (validate() && await exist(id)) {
      await DatabaseService.to.connection.query('''
      UPDATE `career` SET
      `id`=?,`id_department`=?,`name`=?
      WHERE `id` = ?;
      ''', [id, department!.id, name, (lastId ?? id)]);
    } else {
      throw Exception('Invalid Data or career doesn\'t exist');
    }
  }

  Future<void> delete() async {
    if (await exist(id)) {
      await DatabaseService.to.connection.query('''
      DELETE FROM `career` WHERE `id` = ?;
      ''', [id]);
    } else {
      throw Exception('Career doesn\'t exist');
    }
  }
}