import 'package:hybrid_assistance/services/database_service.dart';
import 'package:hybrid_assistance/utils/validate_utils.dart';

class Teacher extends ValidateUtils {
  int id;
  String name;
  String? password;
  String firstLastName;
  String secondLastName;
  String? picture;

  //Constructor
  Teacher({
    required this.id,
    this.password,
    required this.name,
    required this.firstLastName,
    required this.secondLastName,
    this.picture,
  });

  //Validaciones
  bool validate({bool update = false}) {
    return validateId5(id.toString()) &&
        validateName(name) &&
        validateName(firstLastName) &&
        validateName(secondLastName) &&
        validatePassword(password);
  }

  //CRUD
  Future<bool> exist(int id) async {
    final result = await DatabaseService.to.connection.query(
      '''
      SELECT * FROM teacher WHERE `id` = ?;
      ''',
      [id],
    );
    if (result.isNotEmpty) return false;
    return true;
  }

  static Future<Teacher> getById(int id) async {
    final result = await DatabaseService.to.connection.query(
      '''
      SELECT id, name, firstLastName, secondLastName, picture 
      FROM teacher
      WHERE id=?
      ''',
      [id],
    );
    if (result.length == 1) {
      for (var row in result) {
        return Teacher(
          id: row[0],
          name: row[1],
          firstLastName: row[2],
          secondLastName: row[3],
          picture: row[4],
        );
      }
    }
    throw Exception('Query returned more than one teacher or no teachers.');
  }

  Future<void> add() async {
    if (validate() && (await exist(id))) {
      //Cambiar por las validaciones
      await DatabaseService.to.connection.query('''
        INSERT INTO `teacher`
        (`id`, `name`, `password`, `firstLastName`, `secondLastName`, `picture`)
        VALUES (?,?,?,?,?,?);
        ''', [id, name, password, firstLastName, secondLastName, picture]);
    } else {
      throw Exception('Invalid Data or Teacher already exists');
    }
  }

  Future<void> update({int? lastId}) async {
    if (validate(update: true) && !(await exist(id))) {
      await DatabaseService.to.connection.query('''
      UPDATE `teacher` SET
      `id`=?,`name`=?,`password`=?,`firstLastName`=?,`secondLastName`=?,`picture`=?
      WHERE `id` = ?;
      ''', [id, name, password, firstLastName, secondLastName, picture, (lastId ?? id)]);
    } else {
      throw Exception('Invalid Data or Teacher doesn\'t exist');
    }
  }

  Future<void> delete() async {
    if (!await exist(id)) {
      await DatabaseService.to.connection.query('''
      DELETE FROM `teacher` WHERE `id` = ?;
      ''', [id]);
    } else {
      throw Exception('Teacher doesn\'t exist');
    }
  }
  
  static Future<bool> logIn(int id, String password) async {
    final result = await DatabaseService.to.connection.query(
      '''
      SELECT id 
      FROM teacher
      WHERE `id` = ? AND `password` = ?
      ''',
      [id, password],
    );
    if (result.length == 1) {
        return true;
    }else{
      return false;
    }
  }

}
