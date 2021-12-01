import 'package:hybrid_assistance/services/database_service.dart';

import 'center.dart';

class Department {
  int id;
  Center center;
  String name;

  Department({
    required this.id,
    required this.center,
    required this.name,
  });

  bool validate({bool update = false}) {
    return (update ? id != null : true) &&
        //center?
        name.length > 3;
  }

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

  static Future<Department> findById(int id) async {
    final result = await DatabaseService.to.connection.query(
      '''
      SELECT id, center, name 
      FROM department
      WHERE id=?
      ''',
      [id],
    );
    if (result.length == 1) {
      for (var row in result) {
        return Department(
          id: row[0],
          center: row[1],
          name: row[2],
        );
      }
    }
    throw Exception('Query returned more than one department or no departments.');
  }

  Future<void> add() async {
    if (validate() && (id != null ? !(await exist(id!)) : true)) {
      //Cambiar por las validaciones
      await DatabaseService.to.connection.query('''
        INSERT INTO `department`
        (`id`, `center`, `name`)
        VALUES (?,?,?);
        ''', [
        id,
        center,
        name,
      ]);
    } else {
      throw Exception('Invalid Data or Department already exists');
    }
  }

  Future<void> update({int? lastId}) async {
    if (validate(update: true) && (await exist(id!))) {
      await DatabaseService.to.connection.query('''
      UPDATE `department` SET
      `id`=?,`center`=?,`name`=?
      WHERE `id` = ?;
      ''', [
        id,
        center,
        name,
        (lastId ?? id)
      ]);
    } else {
      throw Exception('Invalid Data or Department doesn\'t exist');
    }
  }

  Future<void> delete() async {
    if (await exist(id!)) {
      await DatabaseService.to.connection.query('''
      DELETE FROM `department` WHERE `id` = ?;
      ''', [id]);
    } else {
      throw Exception('Department doesn\'t exist');
    }
  }

}
