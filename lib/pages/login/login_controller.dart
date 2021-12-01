import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hybrid_assistance/components/worthy/worthy_button.dart';
import 'package:line_icons/line_icons.dart';

class LogInController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final userIdField = TextEditingController();
  final passwordField = TextEditingController();
  final logInButtonKey = GlobalKey<WorthyButtonState>();

  UserTypes selectedUserType = UserTypes.student;

  var loading = false.obs;
  Future<void> logIn() async {
    if (formKey.currentState?.validate() ?? false) {
      logInButtonKey.currentState?.setStatus(WorthyButtonStatus.LOADING);
      await 2.seconds.delay();
      // final loggedIn = await SessionService.to.logIn(userIdField.text, passwordField.text);
      // if (loggedIn) {
      //   Get.offAllNamed(Routes.HOME);
      // }
      logInButtonKey.currentState?.setStatus(WorthyButtonStatus.IDLE);
    }
  }
}

enum UserTypes {
  admin,
  student,
  teacher,
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
