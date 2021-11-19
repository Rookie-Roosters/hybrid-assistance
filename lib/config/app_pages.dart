// ignore_for_file: constant_identifier_names
import 'package:get/get.dart';
import 'package:hybrid_assistance/pages/login/login_controller.dart';
import 'package:hybrid_assistance/pages/main_page.dart';
import 'package:hybrid_assistance/pages/login/login.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: Routes.HOME,
      page: () => const MainPage(),
      binding: BindingsBuilder<dynamic>(() {
        Get.lazyPut<MainController>(() => MainController());
      }),
    ),
    GetPage(
      name: Routes.LOGIN, 
      page: () => const Login(),
      binding: BindingsBuilder<dynamic>(() {
        Get.lazyPut<LoginController>(() => LoginController());
      }),
      )
  ];
}

abstract class Routes {
  static const HOME = '/';
  static const LOGIN = '/login';
}