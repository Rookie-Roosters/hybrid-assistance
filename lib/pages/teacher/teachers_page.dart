import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hybrid_assistance/config/app_pages.dart';
import 'package:hybrid_assistance/config/app_themes.dart';
import 'package:hybrid_assistance/models/teacher.dart';
import 'package:hybrid_assistance/utils/ui_utils.dart';

class TeachersPage extends StatefulWidget {
  const TeachersPage({Key? key}) : super(key: key);

  @override
  _TeachersPageState createState() => _TeachersPageState();
}

class _TeachersPageState extends State<TeachersPage> {
  List<Teacher> teachers = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    final a = await Teacher.getAll();
    setState(() {
      teachers = a;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        title: const Text('Maestros'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              await Get.toNamed(Routes.TEACHERFORM, arguments: {"update": null, "initialId": null});
              loadData();
            },
          ),
        ],
      ),
      body: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(kBorderRadius)),
        child: Container(
          color: kSurfaceColor,
          child: ListView.builder(
            padding: kPadding,
            physics: kBouncyScroll,
            itemCount: teachers.length,
            itemBuilder: (context, index) {
              return TeacherCard(
                teacher: teachers[index],
                onChanged: loadData,
              );
            },
          ),
        ),
      ),
    );
  }
}

class TeacherCard extends StatelessWidget {
  final Teacher teacher;
  final void Function() onChanged;
  const TeacherCard({Key? key, required this.teacher, required this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
          title: Text(teacher.id.toString()),
          trailing: IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () async {
              await teacher.delete();
              onChanged();
            },
          ),
          onTap: () async {
            await Get.toNamed(Routes.TEACHERFORM, arguments: {"update": teacher, "initialId": null});
            onChanged();
          }),
    );
  }
}
