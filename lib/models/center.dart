import 'package:hybrid_assistance/services/database_service.dart';

class Center {
  int id;
  String name;

  Center({
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
      SELECT * FROM center WHERE `id` = ?;
      ''',
      [id],
    );
    if (result.isNotEmpty) return true;
    return false;
  }

  static Future<Center> findById(int id) async {
    final result = await DatabaseService.to.connection.query(
      '''
      SELECT id, name 
      FROM center
      WHERE id=?
      ''',
      [id],
    );
    if (result.length == 1) {
      for (var row in result) {
        return Center(
          id: row[0],
          name: row[1],
        );
      }
    }
    throw Exception('Query returned more than one center or no centers.');
  }

  Future<void> add() async {
    if (validate() && (id != null ? !(await exist(id!)) : true)) {
      //Cambiar por las validaciones
      await DatabaseService.to.connection.query('''
        INSERT INTO `center`
        (`id`, `name`)
        VALUES (?,?);
        ''', [
        id,
        name,
      ]);
    } else {
      throw Exception('Invalid Data or Center already exists');
    }
  }

  Future<void> update({int? lastId}) async {
    if (validate(update: true) && (await exist(id!))) {
      await DatabaseService.to.connection.query('''
      UPDATE `center` SET
      `id`=?,`name`=?
      WHERE `id` = ?;
      ''', [
        id,
        name,
        (lastId ?? id)
      ]);
    } else {
      throw Exception('Invalid Data or Center doesn\'t exist');
    }
  }

  Future<void> delete() async {
    if (await exist(id!)) {
      await DatabaseService.to.connection.query('''
      DELETE FROM `center` WHERE `id` = ?;
      ''', [id]);
    } else {
      throw Exception('Center doesn\'t exist');
    }
  }
}
