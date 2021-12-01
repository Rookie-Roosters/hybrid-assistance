import 'package:hybrid_assistance/services/database_service.dart';
import 'package:hybrid_assistance/utils/validate_utils.dart';

class Center extends ValidateUtils {
  int id;
  String name;

  //Constructor
  Center({
    required this.id,
    required this.name,
  });

  //Validaciones
  bool validate({bool update = false}) {
    return validateGenericName(name) && validateNumber(id.toString());
  }

  Future<bool> exist(int id) async {
    final result = await DatabaseService.to.connection.query(
      '''
      SELECT * FROM center WHERE `id` = ?;
      ''',
      [id],
    );
    if (result.isEmpty) return true;
    return false;
  }

  //CRUD
  static Future<List<Center>> getAll() async {
    final List<Center> centers = [];
    final result = await DatabaseService.to.connection.query('''
      SELECT id, name 
      FROM center
      ''');
    for (var row in result) {
      Center center = Center(
        id: row[0],
        name: row[1],
      );
      centers.add(center);
    }
    return centers;
  }

  static Future<Center> getById(int id) async {
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
    if (validate() && (await exist(id))) {
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
    if (validate(update: true) && !(await exist(id))) {
      await DatabaseService.to.connection.query('''
      UPDATE `center` SET
      `id`=?,`name`=?
      WHERE `id` = ?;
      ''', [id, name, (lastId ?? id)]);
    } else {
      throw Exception('Invalid Data or Center doesn\'t exist');
    }
  }

  Future<void> delete() async {
    if (await exist(id)) {
      await DatabaseService.to.connection.query('''
      DELETE FROM `center` WHERE `id` = ?;
      ''', [id]);
    } else {
      throw Exception('Center doesn\'t exist');
    }
  }
}
