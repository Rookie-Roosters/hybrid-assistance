import 'package:hybrid_assistance/utils/validate_utils.dart';
import 'package:hybrid_assistance/services/database_service.dart';
import 'career.dart';

class Group with ValidateUtils {
  int id;
  Career? career;
  String generation;
  String letter;

  //Constructor
  Group({
    required this.id,
    required this.career,
    required this.generation,
    required this.letter,
  });

  //Validation
  bool validate() {
    return validateNumber(id.toString()) &&
        validateGeneration(generation) &&
        validateLetter(letter);
  }

  //CRUD
  Future<bool> exist() async {
    final result = await DatabaseService.to.connection.query(
      '''
      SELECT * FROM `group` WHERE `id`=?;
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
      FROM `group`
      '''
    );
    if (result.length == 1) {
      for (var row in result) {
        return (row[0] ?? 0) + 1;
      }
    }
    throw Exception('Query returned more than one group or no groups.');
  }

  static Future<Group> getById(int id) async {
    final result = await DatabaseService.to.connection.query(
      '''
      SELECT `id`, `id_career`, `generation`, `letter`
      FROM `group`
      WHERE `id`=?;
      ''',
      [id],
    );
    if (result.length == 1) {
      for (var row in result) {
        return Group(
            id: row[0],
            career: await Career.getById(row[1]),
            generation: row[2],
            letter: row[3]);
      }
    }
    throw Exception('Query returned more than one group or no groups.');
  }

  static Future<List<Group>> getByCareer(int id) async {
    final result = await DatabaseService.to.connection.query(
      '''
      SELECT `id`, `id_career`, `generation`, `letter`
      FROM `group`
      WHERE `id_career`=?;
      ''',
      [id],
    );
    List<Group> groups = [];
    for (var row in result) {
      Group group = Group(
          id: row[0],
          career: await Career.getById(row[1]),
          generation: row[2],
          letter: row[3]);
      groups.add(group);
    }
    return groups;
  }

  Future<void> add() async {
    if (validate() && !await exist()) {
      await DatabaseService.to.connection.query('''
        INSERT INTO
        `group`(`id`, `id_career`, `generation`, `letter`)
        VALUES (?,?,?,?);
        ''', [id, career!.id, generation, letter]);
    } else {
      throw Exception('Invalid Data or Group already exist');
    }
  }

  Future<void> update({int? lastId}) async {
    if (validate() && await exist()) {
      await DatabaseService.to.connection.query('''
        UPDATE `group` SET
        `id`=?,`id_career`=?,`generation`=?,`letter`=?
        WHERE `id`=?;
        ''', [id, career!.id, generation, letter, lastId ?? id]);
    } else {
      throw Exception('Invalid Data or Group doesn\'t exist');
    }
  }

  Future<void> delete() async {
    if (await exist()) {
      await DatabaseService.to.connection.query('''
      DELETE FROM `group` WHERE `id` = ?;
      ''', [id]);
    } else {
      throw Exception('Group doesn\'t exist');
    }
  }
}
