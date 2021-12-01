import 'package:hybrid_assistance/services/database_service.dart';
import 'package:hybrid_assistance/utils/validate_utils.dart';

class Classroom extends ValidateUtils {
  int id;
  String name;

  //Constructor
  Classroom({
    required this.id,
    required this.name,
  });

  //Validaciones
  bool validate() {
    return validateNumber(id.toString());
  }

  //CRUD
  Future<bool> exist(int id) async {
    final result = await DatabaseService.to.connection.query(
      '''
      SELECT * FROM classroom WHERE `id` = ?;
      ''',
      [id],
    );
    if (result.isNotEmpty) return false;
    return true;
  }

  static Future<Classroom> getById(int id) async {
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
    if (validate() && (await exist(id))) {
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
    if (validate() && !(await exist(id))) {
      await DatabaseService.to.connection.query('''
      UPDATE `classroom` SET
      `id`=?,`name`=?
      WHERE `id` = ?;
      ''', [id, name, (lastId ?? id)]);
    } else {
      throw Exception('Invalid Data or classroom doesn\'t exist');
    }
  }

  Future<void> delete() async {
    if (!await exist(id)) {
      await DatabaseService.to.connection.query('''
      DELETE FROM `classroom` WHERE `id` = ?;
      ''', [id]);
    } else {
      throw Exception('classroom doesn\'t exist');
    }
  }
}
