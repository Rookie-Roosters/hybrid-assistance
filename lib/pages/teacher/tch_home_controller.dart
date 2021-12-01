import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hybrid_assistance/config/app_pages.dart';
import 'package:hybrid_assistance/services/session_sevice.dart';

class TchHomeController extends GetxController {
    Future<void> logOut() async {
    SessionService.to.logOut();
    Get.offAllNamed(Routes.LOGIN);
  }
}
//select from course where teacher =
//select from schedule where course = 
// (inner join)
// select materia.nombre, grupo.nombre schedule start time end time weekday