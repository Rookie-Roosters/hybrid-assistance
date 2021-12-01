import 'package:flutter/material.dart';
import 'package:hybrid_assistance/config/app_pages.dart';
import 'package:hybrid_assistance/models/student.dart';
import 'package:get/get.dart';
import 'package:hybrid_assistance/services/session_sevice.dart';

class StdHomeController {
  final GlobalKey<FormState> formStateKey = GlobalKey<FormState>();
    Future<void> logOut() async {
    SessionService.to.logOut();
    Get.offAllNamed(Routes.LOGIN);
    
  }
}
