// ignore_for_file: constant_identifier_names
import 'package:get/get.dart';
import 'package:hybrid_assistance/pages/academic_load/academic_load_form.dart';
import 'package:hybrid_assistance/pages/career/career_form.dart';
import 'package:hybrid_assistance/pages/career/careers_page.dart';
import 'package:hybrid_assistance/pages/center/center_form.dart';
import 'package:hybrid_assistance/pages/center/centers_page.dart';
import 'package:hybrid_assistance/pages/classroom/classrooms_page.dart';
import 'package:hybrid_assistance/pages/course/course_form.dart';
import 'package:hybrid_assistance/pages/departament/department_form.dart';
import 'package:hybrid_assistance/pages/departament/departments_page.dart';
import 'package:hybrid_assistance/pages/group/group_form.dart';
import 'package:hybrid_assistance/pages/group/groups_page.dart';
import 'package:hybrid_assistance/pages/home/home_page.dart';
import 'package:hybrid_assistance/pages/login/login_page.dart';
import 'package:hybrid_assistance/pages/shedule/schedule_form.dart';
import 'package:hybrid_assistance/pages/student/student_form.dart';
import 'package:hybrid_assistance/pages/classroom/classroom_form.dart';
import 'package:hybrid_assistance/pages/student/students_page.dart';
import 'package:hybrid_assistance/pages/subject/subject_form.dart';
import 'package:hybrid_assistance/pages/subject/subjects_page.dart';
import 'package:hybrid_assistance/pages/teacher/teacher_form.dart';
import 'package:hybrid_assistance/pages/teacher/teachers_page.dart';

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
    GetPage(
      name: Routes.CENTERS,
      page: () => const CentersPage(),
    ),
    GetPage(
      name: Routes.CLASSROOMS,
      page: () => const ClassroomsPage(),
    ),
    GetPage(
      name: Routes.STUDENTS,
      page: () => const StudentsPage(),
    ),
    GetPage(
      name: Routes.TEACHERS,
      page: () => const TeachersPage(),
    ),
    GetPage(
      name: Routes.DEPARTMENTS,
      page: () => const DepartmentsPage(),
    ),
    GetPage(
      name: Routes.CAREERS,
      page: () => const CareersPage(),
    ),
    GetPage(
      name: Routes.SUBJECTS,
      page: () => const SubjectsPage(),
    ),
    GetPage(
      name: Routes.GROUPS,
      page: () => const GroupsPage(),
    ),
  ];
}

abstract class Routes {
  static const HOME = '/';
  static const LOGIN = '/login';
  static const STUDENTS = '/students';
  static const STUDENTFORM = '/student_form';
  static const CENTERS = '/centers';
  static const CENTERFORM = '/center_form';
  static const CLASSROOMS = '/classrooms';
  static const CLASSROOMFORM = '/classroom_form';
  static const TEACHERS = '/teachers';
  static const TEACHERFORM = '/teacher_form';
  static const DEPARTMENTS = '/departments';
  static const DEPARTMENTFORM = '/department_form';
  static const CAREERS = '/careers';
  static const CAREERFORM = '/career_form';
  static const SUBJECTS = '/subjects';
  static const SUBJECTFORM = '/subject_form';
  static const GROUPS = '/groups';
  static const GROUPFORM = '/group_form';
  static const COURSEFORM = '/course_form';
  static const ACADEMICLOADFORM = '/academic_load';
  static const SCHEDULEFORM = '/schedule_form';
}
