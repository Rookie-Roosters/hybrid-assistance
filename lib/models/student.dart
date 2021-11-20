import 'package:hybrid_assistance/services/db_connection.dart';

class Student {
  int id;
  String name;
  String firstLastName;
  String secondLastName;
  String? nickname;
  String? picture;

  Student({
    required this.id,
    required this.name,
    required this.firstLastName,
    required this.secondLastName,
    this.nickname,
    this.picture,
  });

  static Future<Student> findById(int id) async {
    var conn = await DBConnection.getMySQLConn();
    var result = await conn.query(
        "SELECT id, name, firstLastName, secondLastName, nickname, picture FROM student WHERE id=?",
        [id]);
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
}
