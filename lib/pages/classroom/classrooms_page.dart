import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hybrid_assistance/config/app_pages.dart';
import 'package:hybrid_assistance/models/classroom.dart';

class ClassroomsPage extends StatefulWidget {
  const ClassroomsPage({Key? key}) : super(key: key);

  @override
  _ClassroomsPageState createState() => _ClassroomsPageState();
}

class _ClassroomsPageState extends State<ClassroomsPage> {
  List<Classroom> classrooms = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    final a = await Classroom.getAll();
    setState(() {
      classrooms = a;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Salones'),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              await Get.toNamed(Routes.CLASSROOMFORM, arguments: {
                "update": null,
                "initialId": await Classroom.getId()
              });
              loadData();
            },
          ),
        ],
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: classrooms.length,
          itemBuilder: (context, index) {
            return ClassroomCard(
              classroom: classrooms[index],
              onChanged: loadData,
            );
          },
        ),
      ),
    );
  }
}

class ClassroomCard extends StatelessWidget {
  final Classroom classroom;
  final void Function() onChanged;
  const ClassroomCard({Key? key, required this.classroom, required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
          title: Text(classroom.name),
          trailing: IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () async {
              await classroom.delete();
              onChanged();
            },
          ),
          onTap: () async {
            await Get.toNamed(Routes.CLASSROOMFORM,
                arguments: {"update": classroom, "initialId": null});
            onChanged();
          }),
    );
  }
}
