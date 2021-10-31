// ignore_for_file: constant_identifier_names
import 'package:get/get.dart';
import 'package:hybrid_assistance/pages/main_page.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: Routes.HOME,
      page: () => const MainPage(),
      binding: BindingsBuilder<dynamic>(() {
        Get.lazyPut<MainController>(() => MainController());
      }),
    ),
  ];
}

abstract class Routes {
  static const HOME = '/';
}
