import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hybrid_assistance/models/student.dart';
import 'package:hybrid_assistance/models/teacher.dart';

class SessionService extends GetxService {
  static SessionService get to => Get.find<SessionService>();

  Student? student;
  Teacher? teacher;
  bool get loggedIn => student != null || teacher != null;

  Future<SessionService> init() async {
    final userId = GetStorage().read<int>('userId');
    if (userId != null) {
      // Consulta base de datos
      student = Student(id: userId, name: 'Joaquín', firstLastName: 'Piedroza', secondLastName: 'Godtierres');
    }
    return this;
  }

  Future<bool> logIn(String userId, String password) async {
    await 1.seconds.delay(); // Consulta base de datos
    // Si las credenciales coinciden
    if (true) {
      await GetStorage().write('userId', userId);
      return true;
    }
    return false;
  }

  Future<void> logOut() async {
    await GetStorage().remove('userId');
    student = null;
    teacher = null;
  }
}
