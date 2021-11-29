import 'package:get/get.dart';
import 'package:hybrid_assistance/utils/printer.dart';
import 'package:mysql1/mysql1.dart';

class DatabaseService extends GetxService {
  static DatabaseService get to => Get.find<DatabaseService>();

  late final MySqlConnection connection;

  final _settings = ConnectionSettings(
    host: '192.168.0.13', //ip local
    port: 3306,
    user: 'root',
    // password: '',
    db: 'hybrid_assistance',
  );

  Future<DatabaseService> init() async {
    try {
      connection = await MySqlConnection.connect(_settings);
    } catch (error) {
      Printer.error(error);
    }
    return this;
  }
}

// class DBConnection {
//   static var settings = ConnectionSettings(
//     host: '192.168.1.70', //ip local
//     port: 3306,
//     user: 'root',
//     // password: '',
//     db: 'hybrid_assistance'
//   );

//   static Future<MySqlConnection> getMySQLConn() async {
//     return MySqlConnection.connect(settings);
//   }
// }