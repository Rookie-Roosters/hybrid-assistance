import 'package:mysql1/mysql1.dart';

class DBConnection {
  static var settings = ConnectionSettings(
    host: '192.168.1.70', //ip local
    port: 3306,
    user: 'root',
    // password: '',
    db: 'hybrid_assistance'
  );

  static Future<MySqlConnection> getMySQLConn() async {
    return MySqlConnection.connect(settings);
  }
}