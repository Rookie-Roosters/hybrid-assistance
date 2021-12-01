// ignore_for_file: constant_identifier_names
import 'package:get/get.dart';
import 'package:hybrid_assistance/pages/admin/adm_home_controller.dart';
import 'package:hybrid_assistance/pages/admin/admin_home.dart';
import 'package:hybrid_assistance/pages/home/home_page.dart';
import 'package:hybrid_assistance/pages/login/login_page.dart';
import 'package:hybrid_assistance/pages/student/std_home_controller.dart';
import 'package:hybrid_assistance/pages/student/student_form.dart';
import 'package:hybrid_assistance/pages/student/student_home.dart';
import 'package:hybrid_assistance/pages/teacher/tch_home_controller.dart';
import 'package:hybrid_assistance/pages/teacher/teacher_home.dart';

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
    GetPage(
      name: Routes.STUDENTHOME,
      page: () => const StudentHome(),
      binding: BindingsBuilder<dynamic>(() {
        Get.lazyPut<StdHomeController>(() => StdHomeController());
      }),
    ),
    GetPage(
      name: Routes.TEACHERHOME,
      page: () => const TeacherHome(),
      binding: BindingsBuilder<dynamic>(() {
        Get.lazyPut<TchHomeController>(() => TchHomeController());
      }),
    ),
    GetPage(
      name: Routes.ADMINHOME,
      page: () => const AdminHome(),
      binding: BindingsBuilder<dynamic>(() {
        Get.lazyPut<AdmHomeController>(() => AdmHomeController());
      }),
    ),
    GetPage(
      name: Routes.STUDENTFORM,
      page: () => const StudentForm(),
      binding: BindingsBuilder<dynamic>(() {
        Get.lazyPut<StudentController>(() => StudentController());
      }),
    ),
  ];
}

abstract class Routes {
  static const HOME = '/';
  static const LOGIN = '/login';
  static const STUDENTHOME = '/student_home';
  static const TEACHERHOME = '/teacher_home';
  static const ADMINHOME = '/admin_home';
  static const STUDENTFORM = '/student_form';
}
