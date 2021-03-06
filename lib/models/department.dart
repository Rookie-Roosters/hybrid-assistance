import 'package:hybrid_assistance/services/database_service.dart';
import 'package:hybrid_assistance/utils/validate_utils.dart';

import 'center.dart';

class Department extends ValidateUtils {
  int id;
  Center? center;
  String name;

  //Constructor
  Department({
    required this.id,
    required this.center,
    required this.name,
  });

  //Validación
  Future<bool> validate() async {
    if (center != null) {
      return validateNumber(id.toString()) && validateGenericName(name);
    }
    return false;
  }

  //CRUD
  Future<bool> exist(int id) async {
    final result = await DatabaseService.to.connection.query(
      '''
      SELECT * FROM department WHERE `id` = ?;
      ''',
      [id],
    );
    if (result.isNotEmpty) return true;
    return false;
  }

  static Future<int> getId() async {
    final result = await DatabaseService.to.connection.query(
      '''
      SELECT MAX(id)
      FROM department
      '''
    );
    if (result.length == 1) {
      for (var row in result) {
        return (row[0] ?? 0) + 1;
      }
    }
    throw Exception(
        'Bad consult.');
  }

  static Future<Department> getById(int id) async {
    final result = await DatabaseService.to.connection.query(
      '''
      SELECT id, id_center, name 
      FROM department
      WHERE id=?
      ''',
      [id],
    );
    if (result.length == 1) {
      for (var row in result) {
        return Department(
          id: row[0],
          center: await Center.getById(row[1]),
          name: row[2],
        );
      }
    }
    throw Exception(
        'Query returned more than one department or no departments.');
  }

  static Future<List<Department>> getByCenter(int idCenter) async {
    List<Department> departments = [];
    final result = await DatabaseService.to.connection.query(
      '''
      SELECT id, id_center, name 
      FROM department
      WHERE id_center=?
      ''',
      [idCenter],
    );
    for (var row in result) {
      Department department = Department(
        id: row[0],
        center: await Center.getById(row[1]),
        name: row[2],
      );
      departments.add(department);
    }
    return departments;
  }

  Future<void> add() async {
    if ((await validate()) && !(await exist(id))) {
      await DatabaseService.to.connection.query('''
        INSERT INTO `department`
        (`id`, `id_center`, `name`)
        VALUES (?,?,?);
        ''', [
        id,
        center!.id,
        name,
      ]);
    } else {
      throw Exception('Invalid Data or Department already exists');
    }
  }

  Future<void> update({int? lastId}) async {
    if (await validate() && await exist(id)) {
      await DatabaseService.to.connection.query('''
      UPDATE `department` SET
      `id`=?,`id_center`=?,`name`=?
      WHERE `id` = ?;
      ''', [id, center!.id, name, (lastId ?? id)]);
    } else {
      throw Exception('Invalid Data or Department doesn\'t exist');
    }
  }

  Future<void> delete() async {
    if (await exist(id)) {
      await DatabaseService.to.connection.query('''
      DELETE FROM `department` WHERE `id` = ?;
      ''', [id]);
    } else {
      throw Exception('Department doesn\'t exist');
    }
  }
}
