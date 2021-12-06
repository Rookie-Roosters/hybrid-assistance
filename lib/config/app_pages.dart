// ignore_for_file: constant_identifier_names
import 'package:get/get.dart';
import 'package:hybrid_assistance/pages/academic_load/academic_load_form.dart';
import 'package:hybrid_assistance/pages/career/career_form.dart';
import 'package:hybrid_assistance/pages/center/center_form.dart';
import 'package:hybrid_assistance/pages/course/course_form.dart';
import 'package:hybrid_assistance/pages/departament/department_form.dart';
import 'package:hybrid_assistance/pages/group/group_form.dart';
import 'package:hybrid_assistance/pages/home/home_page.dart';
import 'package:hybrid_assistance/pages/login/login_page.dart';
import 'package:hybrid_assistance/pages/shedule/schedule_form.dart';
import 'package:hybrid_assistance/pages/student/student_form.dart';
import 'package:hybrid_assistance/pages/classroom/classroom_form.dart';
import 'package:hybrid_assistance/pages/subject/subject_form.dart';
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
    GetPage(
      name: Routes.CAREERFORM,
      page: () => const CareerForm(),
      binding: BindingsBuilder<dynamic>(() {
        Get.lazyPut<CareerController>(() => CareerController());
      }),
    ),
    GetPage(
      name: Routes.SUBJECTFORM,
      page: () => const SubjectForm(),
      binding: BindingsBuilder<dynamic>(() {
        Get.lazyPut<SubjectController>(() => SubjectController());
      }),
    ),
    GetPage(
      name: Routes.GROUPFORM,
      page: () => const GroupForm(),
      binding: BindingsBuilder<dynamic>(() {
        Get.lazyPut<GroupController>(() => GroupController());
      }),
    ),
    GetPage(
      name: Routes.COURSEFORM,
      page: () => const CourseForm(),
      binding: BindingsBuilder<dynamic>(() {
        Get.lazyPut<CourseController>(() => CourseController());
      }),
    ),
    GetPage(
      name: Routes.ACADEMICLOADFORM,
      page: () => const AcademicLoadForm(),
      binding: BindingsBuilder<dynamic>(() {
        Get.lazyPut<AcademicLoadController>(() => AcademicLoadController());
      }),
    ),
    GetPage(
      name: Routes.SCHEDULEFORM,
      page: () => const ScheduleForm(),
      binding: BindingsBuilder<dynamic>(() {
        Get.lazyPut<ScheduleController>(() => ScheduleController());
      }),
    ),
  ];
}

abstract class Routes {
  static const HOME = '/';
  static const LOGIN = '/login';
  static const STUDENTFORM = '/student_form';
  static const CENTERFORM = '/center_form';
  static const CLASSROOMFORM = '/classroom_form';
  static const TEACHERFORM = '/teacher_form';
  static const DEPARTMENTFORM = '/department_form';
  static const CAREERFORM = '/career_form';
  static const SUBJECTFORM = '/subject_form';
  static const GROUPFORM = '/group_form';
  static const COURSEFORM = '/course_form';
  static const ACADEMICLOADFORM = '/academic_load';
  static const SCHEDULEFORM = '/schedule_form';
}
