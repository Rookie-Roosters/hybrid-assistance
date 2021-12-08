import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hybrid_assistance/config/app_pages.dart';
import 'package:hybrid_assistance/models/course.dart';
import 'package:hybrid_assistance/models/academic_load.dart';
import 'package:hybrid_assistance/widgets/course_dropdown.dart';

class AcademicLoadsPage extends StatefulWidget {
  const AcademicLoadsPage({Key? key}) : super(key: key);

  @override
  _AcademicLoadsPageState createState() => _AcademicLoadsPageState();
}

class _AcademicLoadsPageState extends State<AcademicLoadsPage> {
  List<AcademicLoad> academicLoads = [];
  Course? course;

  @override
  void initState() {
    super.initState();
    loadData(init: true);
  }

  Future<void> loadData({bool init = false}) async {
    if (init) {
      final List<Course> courses = await Course.getByGroupAndSubject(1, 1);
      if (courses.isNotEmpty) {
        course = courses[0];
      }
    }
    List<AcademicLoad> a = [];
    if (course != null) {
      a = await AcademicLoad.getByCourse(course!.id);
    }
    setState(() {
      academicLoads = a;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cargas Académicas'),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              await Get.toNamed(Routes.ACADEMICLOADFORM, arguments: {
                "update": null,
                "initialId": await AcademicLoad.getId(),
                "initialValues": course,
              });
              loadData();
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20.0),
              CourseDropdownButton(
                onSaved: (value) {},
                update: null,
                onChanged: (value) {
                  setState(() {
                    course = value;
                    loadData();
                  });
                },
              ),
              const SizedBox(
                height: 20.0,
              ),
              academicLoads.isNotEmpty
                  ? SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: Expanded(
                        child: ListView.builder(
                          itemCount: academicLoads.length,
                          itemBuilder: (context, index) {
                            return AcademicLoadCard(
                              academicLoad: academicLoads[index],
                              onChanged: loadData,
                            );
                          },
                        ),
                      ),
                  )
                  : const Text('No se encontró ningún Carga Académica'),
            ],
          ),
        ),
      ),
    );
  }
}

class AcademicLoadCard extends StatelessWidget {
  final AcademicLoad academicLoad;
  final void Function() onChanged;
  const AcademicLoadCard(
      {Key? key, required this.academicLoad, required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
          title: Text(academicLoad.course!.group!.generation +
              ' ' +
              academicLoad.course!.group!.letter +
              ' ' +
              academicLoad.course!.subject!.name +
              ' ' +
              academicLoad.student!.id.toString()),
          trailing: IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () async {
              await academicLoad.delete();
              onChanged();
            },
          ),
          onTap: () async {
            await Get.toNamed(Routes.ACADEMICLOADFORM, arguments: {
              "update": academicLoad,
              "initialId": null,
              "initialValues": null
            });
            onChanged();
          }),
    );
  }
}
