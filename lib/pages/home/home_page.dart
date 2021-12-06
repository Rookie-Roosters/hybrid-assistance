import 'package:flutter/material.dart' hide Center;
import 'package:get/get.dart';
import 'package:hybrid_assistance/config/app_pages.dart';
import 'package:hybrid_assistance/models/academic_load.dart';
import 'package:hybrid_assistance/models/career.dart';
import 'package:hybrid_assistance/models/course.dart';
import 'package:hybrid_assistance/models/department.dart';
import 'package:hybrid_assistance/models/group.dart';
import 'package:hybrid_assistance/models/schedule.dart';
import 'package:hybrid_assistance/models/student.dart';
import 'package:hybrid_assistance/models/center.dart';
import 'package:hybrid_assistance/models/classroom.dart';
import 'package:hybrid_assistance/models/subject.dart';
import 'package:hybrid_assistance/models/teacher.dart';
import 'package:hybrid_assistance/utils/ui_utils.dart';
import 'package:line_icons/line_icons.dart';
import 'home_controller.dart';
export 'home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              IconButton(
                icon: const Icon(LineIcons.sign),
                onPressed: () => controller.logOut(),
              ),
              const Text('Inicio'),
              const TestDB(),
            ]).p3.safeArea(),
      ),
    );
  }
}

class TestDB extends StatelessWidget {
  const TestDB({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            Get.toNamed(Routes.STUDENTFORM, arguments: null);
          },
          child: const Text('Agregar Estudiante'),
        ),
        ElevatedButton(
          onPressed: () async {
            Get.toNamed(Routes.STUDENTFORM,
                arguments: (await Student.getById(
                    269547))); //Se debe pasar por la ruta al estudiante que se quiere editar
          },
          child: const Text('Modificar Estudiante'),
        ),
        ElevatedButton(
          onPressed: () {
            Get.toNamed(Routes.CENTERFORM, arguments: null);
          },
          child: const Text('Agregar Centro'),
        ),
        ElevatedButton(
          onPressed: () async {
            Get.toNamed(Routes.CENTERFORM,
                arguments: (await Center.getById(
                    1))); //Se debe pasar por la ruta al centro que se quiere editar
          },
          child: const Text('Modificar Centro'),
        ),
        ElevatedButton(
          onPressed: () {
            Get.toNamed(Routes.CLASSROOMFORM, arguments: null);
          },
          child: const Text('Agregar Salón de Clases'),
        ),
        ElevatedButton(
          onPressed: () async {
            Get.toNamed(Routes.CLASSROOMFORM,
                arguments: (await Classroom.getById(
                    1))); //Se debe pasar por la ruta al centro que se quiere editar
          },
          child: const Text('Modificar Salón de Clases'),
        ),
        ElevatedButton(
          onPressed: () {
            Get.toNamed(Routes.TEACHERFORM, arguments: null);
          },
          child: const Text('Agregar Maestro'),
        ),
        ElevatedButton(
          onPressed: () async {
            Get.toNamed(Routes.TEACHERFORM,
                arguments: (await Teacher.getById(
                    28386))); //Se debe pasar por la ruta al centro que se quiere editar
          },
          child: const Text('Modificar Maestro'),
        ),
        ElevatedButton(
          onPressed: () {
            Get.toNamed(Routes.DEPARTMENTFORM, arguments: null);
          },
          child: const Text('Agregar Departamento'),
        ),
        ElevatedButton(
          onPressed: () async {
            Get.toNamed(Routes.DEPARTMENTFORM,
                arguments: await Department.getById(6));
          },
          child: const Text('Modificar Departamento'),
        ),
        ElevatedButton(
          onPressed: () {
            Get.toNamed(Routes.CAREERFORM, arguments: null);
          },
          child: const Text('Agregar Carrera'),
        ),
        ElevatedButton(
          onPressed: () async {
            Get.toNamed(Routes.CAREERFORM,
                arguments: await Career.getById(1));
          },
          child: const Text('Modificar Carrera'),
        ),
        ElevatedButton(
          onPressed: () {
            Get.toNamed(Routes.SUBJECTFORM, arguments: null);
          },
          child: const Text('Agregar Materia'),
        ),
        ElevatedButton(
          onPressed: () async {
            Get.toNamed(Routes.SUBJECTFORM,
                arguments: await Subject.getById(1));
          },
          child: const Text('Modificar Materia'),
        ),
        ElevatedButton(
          onPressed: () {
            Get.toNamed(Routes.GROUPFORM, arguments: null);
          },
          child: const Text('Agregar Grupo'),
        ),
        ElevatedButton(
          onPressed: () async {
            Get.toNamed(Routes.GROUPFORM,
                arguments: await Group.getById(1));
          },
          child: const Text('Modificar Grupo'),
        ),
        ElevatedButton(
          onPressed: () {
            Get.toNamed(Routes.COURSEFORM, arguments: null);
          },
          child: const Text('Agregar Curso'),
        ),
        ElevatedButton(
          onPressed: () async {
            Get.toNamed(Routes.COURSEFORM,
                arguments: await Course.getById(1));
          },
          child: const Text('Modificar Curso'),
        ),
        ElevatedButton(
          onPressed: () {
            Get.toNamed(Routes.ACADEMICLOADFORM, arguments: null);
          },
          child: const Text('Agregar Carga Académica'),
        ),
        ElevatedButton(
          onPressed: () async {
            Get.toNamed(Routes.ACADEMICLOADFORM,
                arguments: await AcademicLoad.getById(1));
          },
          child: const Text('Modificar Carga Académica'),
        ),
        ElevatedButton(
          onPressed: () {
            Get.toNamed(Routes.SCHEDULEFORM, arguments: null);
          },
          child: const Text('Agregar Horario'),
        ),
        ElevatedButton(
          onPressed: () async {
            Get.toNamed(Routes.SCHEDULEFORM,
                arguments: await Schedule.getById(1));
          },
          child: const Text('Modificar Modificar Horario'),
        ),
        //Schedule -> Vistas
      ],
    );
  }
}