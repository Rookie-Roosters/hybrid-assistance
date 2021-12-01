import 'package:hybrid_assistance/services/database_service.dart';

class Classroom {
  int id;
  String name;

  Classroom({
    required this.id,
    required this.name,
  });

   bool validate({bool update = false}) {
    return (update ? id != null : true) &&
        name.length > 3;
  }

  Future<bool> exist(int id) async {
    final result = await DatabaseService.to.connection.query(
      '''
      SELECT * FROM classroom WHERE `id` = ?;
      ''',
      [id],
    );
    if (result.isNotEmpty) return true;
    return false;
  }

  static Future<Classroom> findById(int id) async {
    final result = await DatabaseService.to.connection.query(
      '''
      SELECT id, name 
      FROM classroom
      WHERE id=?
      ''',
      [id],
    );
    if (result.length == 1) {
      for (var row in result) {
        return Classroom(
          id: row[0],
          name: row[1],
        );
      }
    }
    throw Exception('Query returned more than one classroom or no classrooms.');
  }

  Future<void> add() async {
    if (validate() && (id != null ? !(await exist(id!)) : true)) {
      //Cambiar por las validaciones
      await DatabaseService.to.connection.query('''
        INSERT INTO `classroom`
        (`id`, `name`)
        VALUES (?,?);
        ''', [
        id,
        name,
      ]);
    } else {
      throw Exception('Invalid Data or classroom already exists');
    }
  }

  Future<void> update({int? lastId}) async {
    if (validate(update: true) && (await exist(id!))) {
      await DatabaseService.to.connection.query('''
      UPDATE `classroom` SET
      `id`=?,`name`=?
      WHERE `id` = ?;
      ''', [
        id,
        name,
        (lastId ?? id)
      ]);
    } else {
      throw Exception('Invalid Data or classroom doesn\'t exist');
    }
  }

  Future<void> delete() async {
    if (await exist(id!)) {
      await DatabaseService.to.connection.query('''
      DELETE FROM `classroom` WHERE `id` = ?;
      ''', [id]);
    } else {
      throw Exception('classroom doesn\'t exist');
    }
  }

}
