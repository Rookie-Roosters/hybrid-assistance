import 'package:get/get.dart';
import 'package:hybrid_assistance/utils/printer.dart';
import 'package:mysql1/mysql1.dart';

class DatabaseService extends GetxService {
  static DatabaseService get to => Get.find<DatabaseService>();

  late final MySqlConnection connection;

  final _settings = ConnectionSettings(
    db: 'hybrid_assistance',
    host: '192.168.0.10',
    port: 3306,
    user: 'root', 
  );

  Future<DatabaseService> init() async {
    try {
      connection = await MySqlConnection.connect(_settings);
      Printer.info('Database connected: ${_settings.db}');
    } catch (error) {
      Printer.error(error);
    }
    return this;
  }
}
