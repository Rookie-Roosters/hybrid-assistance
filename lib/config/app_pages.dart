// ignore_for_file: constant_identifier_names
import 'package:get/get.dart';
import 'package:hybrid_assistance/pages/home/home_page.dart';
import 'package:hybrid_assistance/pages/login/login_page.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: Routes.LOGIN,
      page: () => const LogInPage(),
      binding: BindingsBuilder<dynamic>(() {
        Get.lazyPut<LogInController>(() => LogInController());
      }),
    ),
    GetPage(
      name: Routes.HOME,
      page: () => const HomePage(),
      binding: BindingsBuilder<dynamic>(() {
        Get.lazyPut<HomeController>(() => HomeController());
      }),
    ),
  ];
}

abstract class Routes {
  static const HOME = '/';
  static const LOGIN = '/login';
}
