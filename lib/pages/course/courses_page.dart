import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hybrid_assistance/config/app_pages.dart';
import 'package:hybrid_assistance/config/app_themes.dart';
import 'package:hybrid_assistance/models/group.dart';
import 'package:hybrid_assistance/models/course.dart';
import 'package:hybrid_assistance/models/subject.dart';
import 'package:hybrid_assistance/utils/ui_utils.dart';
import 'package:hybrid_assistance/widgets/group_dropdown.dart';
import 'package:hybrid_assistance/widgets/subject_dropdown.dart';

class CoursesPage extends StatefulWidget {
  const CoursesPage({Key? key}) : super(key: key);

  @override
  _CoursesPageState createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> {
  List<Course> courses = [];
  Group? group;
  Subject? subject;

  @override
  void initState() {
    super.initState();
    loadData(init: true);
  }

  Future<void> loadData({bool init = false}) async {
    if (init) {
      final List<Group> groups = await Group.getByCareer(1);
      final List<Subject> subjects = await Subject.getByDepartment(1);
      if (groups.isNotEmpty) {
        group = groups[0];
      }
      if (subjects.isNotEmpty) {
        subject = subjects[0];
      }
    }
    List<Course> a = [];
    if (group != null && subject != null) {
      a = await Course.getByGroupAndSubject(group!.id, subject!.id);
    }
    setState(() {
      courses = a;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        title: const Text('Cursos'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              await Get.toNamed(Routes.COURSEFORM, arguments: {
                "update": null,
                "initialId": await Course.getId(),
                "initialValues": {
                  "group": group,
                  "subject": subject,
                },
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
              const SizedBox(
                height: 20.0,
              ),
              const Text('Grupo'),
              GroupDropdownButton(
                onSaved: (value) {},
                update: null,
                onChanged: (value) {
                  setState(() {
                    group = value;
                    loadData();
                  });
                },
              ),
              const SizedBox(
                height: 20.0,
              ),
              const Text('Materia'),
              SubjectDropdownButton(
                onSaved: (value) {},
                update: null,
                onChanged: (value) {
                  setState(() {
                    subject = value;
                    loadData();
                  });
                },
              ),
              const SizedBox(
                height: 20.0,
              ),
              courses.isNotEmpty
                  ? ListView.builder(
                      itemCount: courses.length,
                      shrinkWrap: true,
                      physics: kNeverScroll,
                      itemBuilder: (context, index) {
                        return CourseCard(
                          course: courses[index],
                          onChanged: loadData,
                        ).pb2;
                      },
                    )
                  : const Text('No se encontró ningún Curso'),
            ],
          ).scrollable(padding: kPadding).aligned(Alignment.topCenter),
        ),
      ),
    );
  }
}

class CourseCard extends StatelessWidget {
  final Course course;
  final void Function() onChanged;
  const CourseCard({Key? key, required this.course, required this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
          title: Text(course.group!.generation + ' ' + course.group!.letter + ' ' + course.subject!.name + ' ' + course.teacher!.id.toString()),
          trailing: IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () async {
              await course.delete();
              onChanged();
            },
          ),
          onTap: () async {
            await Get.toNamed(Routes.COURSEFORM, arguments: {"update": course, "initialId": null, "initialValues": null});
            onChanged();
          }),
    );
  }
}
