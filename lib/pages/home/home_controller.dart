import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hybrid_assistance/config/app_pages.dart';
import 'package:hybrid_assistance/pages/login/login_controller.dart';
import 'package:hybrid_assistance/services/session_sevice.dart';

class HomeController extends GetxController {
  final formKey = GlobalKey<FormState>();

  Future<void> logOut() async {
    SessionService.to.logOut();
    Get.offAllNamed(Routes.LOGIN);
  }
}
