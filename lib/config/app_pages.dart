// ignore_for_file: constant_identifier_names
import 'package:get/get.dart';
import 'package:hybrid_assistance/components/calendar_controller.dart';
import 'package:hybrid_assistance/pages/admin/adm_home_controller.dart';
import 'package:hybrid_assistance/pages/admin/admin_home.dart';
import 'package:hybrid_assistance/pages/center/center_form.dart';
import 'package:hybrid_assistance/pages/departament/department_form.dart';
import 'package:hybrid_assistance/pages/home/home_controller.dart';
import 'package:hybrid_assistance/pages/home/home_page.dart';
import 'package:hybrid_assistance/pages/login/login_page.dart';
import 'package:hybrid_assistance/pages/student/class_details.dart';
import 'package:hybrid_assistance/pages/student/class_details_controller.dart';
import 'package:hybrid_assistance/pages/student/student_form.dart';
import 'package:hybrid_assistance/pages/teacher/list_controller.dart';
import 'package:hybrid_assistance/pages/teacher/student_list.dart';
import 'package:hybrid_assistance/pages/classroom/classroom_form.dart';
import 'package:hybrid_assistance/pages/teacher/teacher_form.dart';

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
        Get.lazyPut<TheCalendarController>(() => TheCalendarController());
      }),
    ),
    GetPage(
      name: Routes.STUDENTLIST,
      page: () => const StudentList(),
      binding: BindingsBuilder<dynamic>(() {
        Get.lazyPut<ListController>(() => ListController());
      }),
    ),
    GetPage(
      name: Routes.CLASSDETAILS, 
      page: () => const ClassDetails(),
      binding: BindingsBuilder<dynamic>(() {
        Get.lazyPut<ClassDetailsController>(() => ClassDetailsController());
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
    GetPage(
      name: Routes.CENTERFORM,
      page: () => const CenterForm(),
      binding: BindingsBuilder<dynamic>(() {
        Get.lazyPut<CenterController>(() => CenterController());
      }),
    ),
    GetPage(
      name: Routes.CLASSROOMFORM,
      page: () => const ClassroomForm(),
      binding: BindingsBuilder<dynamic>(() {
        Get.lazyPut<ClassroomController>(() => ClassroomController());
      }),
    ),
    GetPage(
      name: Routes.TEACHERFORM,
      page: () => const TeacherForm(),
      binding: BindingsBuilder<dynamic>(() {
        Get.lazyPut<TeacherController>(() => TeacherController());
      }),
    ),
    GetPage(
      name: Routes.DEPARTMENTFORM,
      page: () => const DepartmentForm(),
      binding: BindingsBuilder<dynamic>(() {
        Get.lazyPut<DepartmentController>(() => DepartmentController());
      }),
    ),
  ];
}

abstract class Routes {
  static const HOME = '/';
  static const LOGIN = '/login';
  static const STUDENTHOME = '/student_home';
  static const TEACHERHOME = '/teacher_home';
  static const STUDENTLIST = '/student_list';
  static const CLASSDETAILS = '/class_details';
  static const ADMINHOME = '/admin_home';
  static const STUDENTFORM = '/student_form';
  static const CENTERFORM = '/center_form';
  static const CLASSROOMFORM = '/classroom_form';
  static const TEACHERFORM = '/teacher_form';
  static const DEPARTMENTFORM = '/department_form';
}
