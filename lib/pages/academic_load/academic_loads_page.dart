import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hybrid_assistance/config/app_pages.dart';
import 'package:hybrid_assistance/config/app_themes.dart';
import 'package:hybrid_assistance/models/course.dart';
import 'package:hybrid_assistance/models/academic_load.dart';
import 'package:hybrid_assistance/utils/ui_utils.dart';
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
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        title: const Text('Cargas Académicas'),
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
      body: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(kBorderRadius)),
        child: Container(
          color: kSurfaceColor,
          alignment: Alignment.center,
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
                  ? ListView.builder(
                      itemCount: academicLoads.length,
                      shrinkWrap: true,
                      physics: kNeverScroll,
                      itemBuilder: (context, index) {
                        return AcademicLoadCard(
                          academicLoad: academicLoads[index],
                          onChanged: loadData,
                        ).pb2;
                      },
                    )
                  : const Text('No se encontró ningún Carga Académica'),
            ],
          ).scrollable(padding: kPadding).aligned(Alignment.topCenter),
        ),
      ),
    );
  }
}

class AcademicLoadCard extends StatelessWidget {
  final AcademicLoad academicLoad;
  final void Function() onChanged;
  const AcademicLoadCard({Key? key, required this.academicLoad, required this.onChanged}) : super(key: key);

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
            await Get.toNamed(Routes.ACADEMICLOADFORM, arguments: {"update": academicLoad, "initialId": null, "initialValues": null});
            onChanged();
          }),
    );
  }
}
