import 'package:hybrid_assistance/services/database_service.dart';

class Admin {
  int id;
  String? password;
  String name;

  Admin({
    required this.id,
    this.password,
    required this.name
  });

  Future<bool> exist(int id) async {
    final result = await DatabaseService.to.connection.query(
      '''
      SELECT * FROM admin WHERE `id` = ?;
      ''',
      [id],
    );
    if (result.isNotEmpty) return true;
    return false;
  }

   static Future<Admin> findById(int id) async {
    final result = await DatabaseService.to.connection.query(
      '''
      SELECT id, name
      FROM admin
      WHERE id=?
      ''',
      [id],
    );
    if (result.length == 1) {
      for (var row in result) {
        return Admin(
          id: row[0],
          name: row[1],
        );
      }
    }
    throw Exception('Query returned more than one student or no students.');
  }

  static Future<bool> logIn(int id, String password) async {
    final result = await DatabaseService.to.connection.query(
      '''
      SELECT id 
      FROM admin
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
