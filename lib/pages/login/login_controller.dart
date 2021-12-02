import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hybrid_assistance/components/worthy/worthy_button.dart';
import 'package:hybrid_assistance/config/app_pages.dart';
import 'package:hybrid_assistance/services/session_sevice.dart';
import 'package:line_icons/line_icons.dart';

class LogInController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final userIdField = TextEditingController();
  final passwordField = TextEditingController();
  final logInButtonKey = GlobalKey<WorthyButtonState>();
  var errorMessage = ''.obs;
  UserTypes selectedUserType = UserTypes.student;

  var loading = false.obs;
  Future<void> logIn() async {
    if (formKey.currentState?.validate() ?? false) {
      logInButtonKey.currentState?.setStatus(WorthyButtonStatus.LOADING);
      //await 2.seconds.delay();
      final loggedIn = await SessionService.to.logIn(userIdField.text, passwordField.text, selectedUserType);
       if (loggedIn) {
         Get.offAllNamed(SessionService.to.loggedIn);
       }else{
         errorMessage.value = 'Usuario o contraseña incorrectos';
       }
      logInButtonKey.currentState?.setStatus(WorthyButtonStatus.IDLE);
    }
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
