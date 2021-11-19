import 'package:get/get.dart';
import 'dart:html' as html;
import 'package:http/http.dart' as http;
import 'package:hybrid_assistance/config/app_pages.dart';
import 'package:hybrid_assistance/pages/login/login.dart';
import 'package:hybrid_assistance/services/session_store.dart';

class AuthController extends GetxController{
  static AuthController instance = Get.find();
  String? _id = '';

  @override
  void onReady() {
    _id = html.window.localStorage['_id'];
    if(_id == null){
      Get.toNamed(Routes.LOGIN);
    }
    else{
      //SessionStore.setUser(_id!, isProf);
      Get.toNamed(Routes.HOME);
    }
  }


}
