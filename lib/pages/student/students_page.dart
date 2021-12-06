import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hybrid_assistance/config/app_pages.dart';
import 'package:hybrid_assistance/models/student.dart';

class StudentsPage extends StatefulWidget {
  const StudentsPage({Key? key}) : super(key: key);

  @override
  _StudentsPageState createState() => _StudentsPageState();
}

class _StudentsPageState extends State<StudentsPage> {
  List<Student> students = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    final a = await Student.getAll();
    setState(() {
      students = a;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Estudiantes'),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              await Get.toNamed(Routes.STUDENTFORM, arguments: {
                "update": null,
                "initialId": null
              });
              loadData();
            },
          ),
        ],
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: students.length,
          itemBuilder: (context, index) {
            return StudentCard(
              student: students[index],
              onChanged: loadData,
            );
          },
        ),
      ),
    );
  }
}

class StudentCard extends StatelessWidget {
  final Student student;
  final void Function() onChanged;
  const StudentCard({Key? key, required this.student, required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
          title: Text(student.id.toString()),
          trailing: IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () async {
              await student.delete();
              onChanged();
            },
          ),
          onTap: () async {
            await Get.toNamed(Routes.STUDENTFORM,
                arguments: {"update": student, "initialId": null});
            onChanged();
          }),
    );
  }
}