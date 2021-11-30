import 'package:hybrid_assistance/services/database_service.dart';

import 'department.dart';

class Career {
  int id;
  Department department;
  String name;

  Career({
    required this.id,
    required this.department,
    required this.name,
  });

  bool validate({bool update = false}) {
    return (update ? id != null : true) &&
        //department?
        name.length > 3;
  }

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

  static Future<Career> findById(int id) async {
    final result = await DatabaseService.to.connection.query(
      '''
      SELECT id, department, name 
      FROM career
      WHERE id=?
      ''',
      [id],
    );
    if (result.length == 1) {
      for (var row in result) {
        return Career(
          id: row[0],
          department: row[1],
          name: row[2],
        );
      }
    }
    throw Exception('Query returned more than one career or no careers.');
  }

  Future<void> add() async {
    if (validate() && (id != null ? !(await exist(id!)) : true)) {
      //Cambiar por las validaciones
      await DatabaseService.to.connection.query('''
        INSERT INTO `career`
        (`id`, `department`, `name`)
        VALUES (?,?,?);
        ''', [
        id,
        department,
        name,
      ]);
    } else {
      throw Exception('Invalid Data or career already exists');
    }
  }

  Future<void> update({int? lastId}) async {
    if (validate(update: true) && (await exist(id!))) {
      await DatabaseService.to.connection.query('''
      UPDATE `career` SET
      `id`=?,`department`=?,`name`=?
      WHERE `id` = ?;
      ''', [id, department, name, (lastId ?? id)]);
    } else {
      throw Exception('Invalid Data or career doesn\'t exist');
    }
  }

  Future<void> delete() async {
    if (await exist(id!)) {
      await DatabaseService.to.connection.query('''
      DELETE FROM `career` WHERE `id` = ?;
      ''', [id]);
    } else {
      throw Exception('Career doesn\'t exist');
    }
  }
}
