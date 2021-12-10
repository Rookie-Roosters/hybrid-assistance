import 'package:flutter/material.dart' hide Center;
import 'package:get/get.dart';
import 'package:hybrid_assistance/components/worthy/worthy_button.dart';
import 'package:hybrid_assistance/config/app_themes.dart';
import 'package:line_icons/line_icons.dart';

import 'package:hybrid_assistance/components/worthy/worthy_text.dart';
import 'package:hybrid_assistance/config/app_pages.dart';
import 'package:hybrid_assistance/services/session_sevice.dart';
import 'package:hybrid_assistance/utils/ui_utils.dart';

import 'adm_home_controller.dart';

class AdminHome extends GetView<AdmHomeController> {
  const AdminHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Column(children: [
        Row(children: [
          Icon(UserTypes.admin.icon, color: kPrimaryColor.onColor, size: 40).pr2,
          WorthyText.heading2(
            SessionService.to.admin?.name ?? 'Usuario',
            overflow: true,
            color: kPrimaryColor.onColor,
          ).bottom([
            WorthyText.body(
              'Administrativo',
              color: kPrimaryColor.onColor,
            )
          ]).expanded(),
          kSpacerX,
          IconButton(icon: Icon(LineIcons.alternateSignOut, color: kPrimaryColor.onColor), onPressed: () => controller.logOut())
        ]).p3,
        Container(
          decoration: const BoxDecoration(
            color: kSurfaceColor,
            borderRadius: BorderRadius.vertical(top: Radius.circular(kBorderRadius)),
          ),
          child: GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 2 / 1,
            padding: kPadding,
            crossAxisSpacing: kSpacing2,
            mainAxisSpacing: kSpacing2,
            physics: kBouncyScroll,
            shrinkWrap: true,
            children: [
              _CrudButton(name: 'Centros', icon: LineIcons.objectUngroup, route: Routes.CENTERS),
              _CrudButton(name: 'Salones', icon: LineIcons.warehouse, route: Routes.CLASSROOMS),
              _CrudButton(name: 'Estudiantes', icon: UserTypes.student.icon, route: Routes.STUDENTS),
              _CrudButton(name: 'Maestros', icon: UserTypes.teacher.icon, route: Routes.TEACHERS),
              _CrudButton(name: 'Departamentos', icon: LineIcons.building, route: Routes.DEPARTMENTS),
              _CrudButton(name: 'Carreras', icon: LineIcons.school, route: Routes.CAREERS),
              _CrudButton(name: 'Materias', icon: LineIcons.bookOpen, route: Routes.SUBJECTS),
              _CrudButton(name: 'Grupos', icon: LineIcons.users, route: Routes.GROUPS),
              _CrudButton(name: 'Cursos', icon: LineIcons.chalkboard, route: Routes.COURSES),
              _CrudButton(name: 'Cargas Académicas', icon: LineIcons.alternateListAlt, route: Routes.ACADEMICLOADS),
              _CrudButton(name: 'Horarios', icon: LineIcons.calendarWithWeekFocus, route: Routes.SCHEDULES),
            ].map((e) {
              return WorthyButton.elevated(
                prefix: Icon(e.icon),
                child: Text(
                  e.name,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                ).expanded(),
                color: kPrimaryColor.variants.light,
                onPressed: () => Get.toNamed(e.route),
              );
            }).toList(),
          ),
        ).expanded()
      ]).safeArea(),

      // SingleChildScrollView(
      //   child: Column(
      //       crossAxisAlignment: CrossAxisAlignment.stretch,
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       mainAxisSize: MainAxisSize.max,
      //       children: [
      //         IconButton(
      //           icon: const Icon(LineIcons.sign),
      //           onPressed: () => controller.logOut(),
      //         ),
      //         const Text('Inicio'),
      //         const TestDB(),
      //       ]).p3.safeArea(),
    ).overlayStyle(statusBar: kPrimaryColor, navigationBar: kSurfaceColor);
  }
}

class _CrudButton {
  final String name;
  final IconData icon;
  final String route;
  _CrudButton({
    required this.name,
    required this.icon,
    required this.route,
  });
}

class TestDB extends StatelessWidget {
  const TestDB({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElevatedButton(
          onPressed: () {
            Get.toNamed(Routes.CENTERS);
          },
          child: const Text('Centros'),
        ),
        const SizedBox(
          height: 10.0,
        ),
        ElevatedButton(
          onPressed: () {
            Get.toNamed(Routes.CLASSROOMS);
          },
          child: const Text('Salones'),
        ),
        const SizedBox(
          height: 10.0,
        ),
        ElevatedButton(
          onPressed: () {
            Get.toNamed(Routes.STUDENTS);
          },
          child: const Text('Estudiantes'),
        ),
        const SizedBox(
          height: 10.0,
        ),
        ElevatedButton(
          onPressed: () {
            Get.toNamed(Routes.TEACHERS);
          },
          child: const Text('Maestros'),
        ),
        const SizedBox(
          height: 10.0,
        ),
        ElevatedButton(
          onPressed: () {
            Get.toNamed(Routes.DEPARTMENTS);
          },
          child: const Text('Departamentos'),
        ),
        const SizedBox(
          height: 10.0,
        ),
        ElevatedButton(
          onPressed: () {
            Get.toNamed(Routes.CAREERS);
          },
          child: const Text('Carreras'),
        ),
        const SizedBox(
          height: 10.0,
        ),
        ElevatedButton(
          onPressed: () {
            Get.toNamed(Routes.SUBJECTS);
          },
          child: const Text('Materias'),
        ),
        const SizedBox(
          height: 10.0,
        ),
        ElevatedButton(
          onPressed: () {
            Get.toNamed(Routes.GROUPS);
          },
          child: const Text('Grupos'),
        ),
        const SizedBox(
          height: 10.0,
        ),
        ElevatedButton(
          onPressed: () {
            Get.toNamed(Routes.COURSES);
          },
          child: const Text('Cursos'),
        ),
        const SizedBox(
          height: 10.0,
        ),
        ElevatedButton(
          onPressed: () {
            Get.toNamed(Routes.ACADEMICLOADS);
          },
          child: const Text('Cargas Académicas'),
        ),
        const SizedBox(
          height: 10.0,
        ),
        ElevatedButton(
          onPressed: () {
            Get.toNamed(Routes.SCHEDULES);
          },
          child: const Text('Horario'),
        ),
      ],
    );
  }
}
