import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hybrid_assistance/config/app_pages.dart';
import 'package:hybrid_assistance/services/session_sevice.dart';

class LogInController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final userIdField = TextEditingController();
  final passwordField = TextEditingController();

  var loading = false.obs;
  Future<void> logIn() async {
    if (formKey.currentState?.validate() ?? false) {
      loading(true);
      final loggedIn = await SessionService.to.logIn(userIdField.text, passwordField.text);
      if (loggedIn) {
        Get.offAllNamed(Routes.HOME);
      }
      loading(false);
    }
  }
}
