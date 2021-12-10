import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hybrid_assistance/models/admin.dart';
import 'package:hybrid_assistance/models/student.dart';
import 'package:hybrid_assistance/models/teacher.dart';
import 'package:hybrid_assistance/config/app_pages.dart';
import 'package:line_icons/line_icons.dart';

class SessionService extends GetxService {
  static SessionService get to => Get.find<SessionService>();

  Student? student;
  Teacher? teacher;
  Admin? admin;

  String get loggedIn {
    final userType = GetStorage().read<String>('userType');
    if (userType != null) {
      switch (userType) {
        case "UserTypes.admin":
          return Routes.ADMINHOME;
        case "UserTypes.student":
          return Routes.HOME;
        case "UserTypes.teacher":
          return Routes.HOME;
      }
    }
    return Routes.LOGIN;
  }

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
        if (isTrue) {
          admin = await Admin.findById(int.parse(userId));
        }
        break;
      case UserTypes.student:
        isTrue = await Student.logIn(int.parse(userId), password);
        if (isTrue) {
          student = await Student.findById(int.parse(userId));
        }
        break;
      case UserTypes.teacher:
        isTrue = await Teacher.logIn(int.parse(userId), password);
        if (isTrue) {
          teacher = await Teacher.getById(int.parse(userId));
        }
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

enum UserTypes {
  student,
  teacher,
  admin,
}

extension UserTypesExtenssion on UserTypes {
  String get name {
    switch (this) {
      case UserTypes.admin:
        return 'Administrativo';
      case UserTypes.student:
        return 'Estudiante';
      case UserTypes.teacher:
        return 'Profesor';
    }
  }

  IconData get icon {
    switch (this) {
      case UserTypes.admin:
        return LineIcons.cog;
      case UserTypes.student:
        return LineIcons.book;
      case UserTypes.teacher:
        return LineIcons.coffee;
    }
  }
}
