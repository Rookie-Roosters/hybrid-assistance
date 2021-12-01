import 'package:hybrid_assistance/services/database_service.dart';

import 'department.dart';

class Subject {
  int id;
  Department department;
  String name;

  Subject({
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
      SELECT * FROM subject WHERE `id` = ?;
      ''',
      [id],
    );
    if (result.isNotEmpty) return true;
    return false;
  }

  static Future<Subject> findById(int id) async {
    final result = await DatabaseService.to.connection.query(
      '''
      SELECT id, department, name 
      FROM subject
      WHERE id=?
      ''',
      [id],
    );
    if (result.length == 1) {
      for (var row in result) {
        return Subject(
          id: row[0],
          department: row[1],
          name: row[2],
        );
      }
    }
    throw Exception('Query returned more than one subject or no subjects.');
  }

  Future<void> add() async {
    if (validate() && (id != null ? !(await exist(id!)) : true)) {
      //Cambiar por las validaciones
      await DatabaseService.to.connection.query('''
        INSERT INTO `subject`
        (`id`, `department`, `name`)
        VALUES (?,?,?);
        ''', [
        id,
        department,
        name,
      ]);
    } else {
      throw Exception('Invalid Data or subject already exists');
    }
  }

  Future<void> update({int? lastId}) async {
    if (validate(update: true) && (await exist(id!))) {
      await DatabaseService.to.connection.query('''
      UPDATE `subject` SET
      `id`=?,`department`=?,`name`=?
      WHERE `id` = ?;
      ''', [
        id,
        department,
        name,
        (lastId ?? id)
      ]);
    } else {
      throw Exception('Invalid Data or subject doesn\'t exist');
    }
  }

  Future<void> delete() async {
    if (await exist(id!)) {
      await DatabaseService.to.connection.query('''
      DELETE FROM `subject` WHERE `id` = ?;
      ''', [id]);
    } else {
      throw Exception('subject doesn\'t exist');
    }
  }

}
