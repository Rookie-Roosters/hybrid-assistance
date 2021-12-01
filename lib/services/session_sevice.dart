import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hybrid_assistance/models/admin.dart';
import 'package:hybrid_assistance/models/student.dart';
import 'package:hybrid_assistance/models/teacher.dart';
import 'package:hybrid_assistance/pages/login/login_page.dart';

class SessionService extends GetxService {
  static SessionService get to => Get.find<SessionService>();

  Student? student;
  Teacher? teacher;
  Admin? admin;
  bool get loggedIn => student != null || teacher != null || admin != null;

  Future<SessionService> init() async {
    final userId = GetStorage().read<String>('userId');
    final userType = GetStorage().read<String>('userType');
    if (userId != null) {
      switch (userType) {
        case "UserTypes.admin":
          admin = await Admin.findById(int.parse(userId));
          break;
        case "UserTypes.student":
          student = await Student.findById(int.parse(userId));
          break;
        case "UserTypes.teacher":
          teacher = await Teacher.getById(int.parse(userId));
          break;
      }
    }
    return this;
  }

  Future<bool> logIn(String userId, String password, UserTypes userType) async {
    bool isTrue = false;
    switch (userType) {
      case UserTypes.admin:
        isTrue = await Admin.logIn(int.parse(userId), password);
        break;
      case UserTypes.student:
        isTrue = await Student.logIn(int.parse(userId), password);
        break;
      case UserTypes.teacher:
        isTrue = await Teacher.logIn(int.parse(userId), password);
        break;
    }
    // Si las credenciales coinciden
    if (isTrue) {
      await GetStorage().write('userId', userId);
      await GetStorage().write('userType', userType.toString());
      return true;
    }
    return false;
  }

  Future<void> logOut() async {
    await GetStorage().remove('userId');
    await GetStorage().remove('userType');
    student = null;
    teacher = null;
    admin = null;
  }
}
