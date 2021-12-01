import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hybrid_assistance/config/app_pages.dart';
import 'package:hybrid_assistance/services/session_sevice.dart';

class AdmHomeController extends GetxController {
    Future<void> logOut() async {
    SessionService.to.logOut();
    Get.offAllNamed(Routes.LOGIN);
  }
}