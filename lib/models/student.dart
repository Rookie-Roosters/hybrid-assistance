import 'package:hybrid_assistance/services/database_service.dart';
import 'package:hybrid_assistance/utils/validate_utils.dart';

class Student extends ValidateUtils {
  int? id;
  String name;
  String? password;
  String firstLastName;
  String secondLastName;
  String? nickname;
  String? picture;

  //Constructor
  Student({
    this.id,
    required this.name,
    this.password,
    required this.firstLastName,
    required this.secondLastName,
    this.nickname,
    this.picture,
  });

  //validaciones
  bool validate({bool update = false}) {
    return validateId6(id.toString()) &&
        validateName(name) &&
        validatePassword(password) &&
        validateName(firstLastName) &&
        validateName(secondLastName);
  }

  //CRUD
  static Future<Student> getById(int id) async {
    final result = await DatabaseService.to.connection.query(
      '''
      SELECT id, name, firstLastName, secondLastName, nickname, picture 
      FROM student
      WHERE id=?
      ''',
      [id],
    );
    if (result.length == 1) {
      for (var row in result) {
        return Student(
          id: row[0],
          name: row[1],
          firstLastName: row[2],
          secondLastName: row[3],
          nickname: row[4],
          picture: row[5],
        );
      }
    }
    throw Exception('Query returned more than one student or no students.');
  }

  Future<bool> exist(int id) async {
    final result = await DatabaseService.to.connection.query(
      '''
      SELECT * FROM student WHERE `id` = ?;
      ''',
      [id],
    );
    if (result.isNotEmpty) return true;
    return false;
  }

  static Future<Student> findById(int id) async {
    final result = await DatabaseService.to.connection.query(
      '''
      SELECT id, name, firstLastName, secondLastName, nickname, picture 
      FROM student
      WHERE id=?
      ''',
      [id],
    );
    if (result.length == 1) {
      for (var row in result) {
        return Student(
          id: row[0],
          name: row[1],
          firstLastName: row[2],
          secondLastName: row[3],
          nickname: row[4],
          picture: row[5],
        );
      }
    }
    throw Exception('Query returned more than one student or no students.');
  }

  Future<void> add() async {
    if (validate() && (id != null ? !(await exist(id!)) : true)) {
      //Cambiar por las validaciones
      await DatabaseService.to.connection.query('''
        INSERT INTO `student`
        (`id`, `name`, `password`, `firstLastName`, `secondLastName`, `nickname`, `picture`)
        VALUES (?,?,?,?,?,?,?);
        ''', [id, name, password, firstLastName, secondLastName, nickname, picture]);
    } else {
      throw Exception('Invalid Data or Student already exist');
    }
  }

  Future<void> update({int? lastId}) async {
    if (validate(update: true) && (await exist(id!))) {
      await DatabaseService.to.connection.query('''
      UPDATE `student` SET
      `id`=?,`name`=?,`password`=?,`firstLastName`=?,`secondLastName`=?,`nickname`=?,`picture`=?
      WHERE `id` = ?;
      ''', [id, name, password, firstLastName, secondLastName, nickname, picture, (lastId ?? id)]);
    } else {
      throw Exception('Invalid Data or Student doesn\'t exist');
    }
  }

  Future<void> delete() async {
    if (await exist(id!)) {
      await DatabaseService.to.connection.query('''
      DELETE FROM `student` WHERE `id` = ?;
      ''', [id]);
    } else {
      throw Exception('Student doesn\'t exist');
    }
  }

  static Future<bool> logIn(int id, String password) async {
    final result = await DatabaseService.to.connection.query(
      '''
      SELECT id 
      FROM student
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
