import 'package:get/get.dart';
import 'package:hybrid_assistance/services/session_sevice.dart';

class HomeController extends GetxController {
  Future<void> logOut() async {
    SessionService.to.logOut();
  }
}
