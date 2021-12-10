import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hybrid_assistance/config/app_pages.dart';
import 'package:hybrid_assistance/config/app_themes.dart';
import 'package:hybrid_assistance/models/department.dart';
import 'package:hybrid_assistance/models/subject.dart';
import 'package:hybrid_assistance/utils/ui_utils.dart';
import 'package:hybrid_assistance/widgets/department_dropdown.dart';

class SubjectsPage extends StatefulWidget {
  const SubjectsPage({Key? key}) : super(key: key);

  @override
  _SubjectsPageState createState() => _SubjectsPageState();
}

class _SubjectsPageState extends State<SubjectsPage> {
  List<Subject> subjects = [];
  Department? department;

  @override
  void initState() {
    super.initState();
    loadData(init: true);
  }

  Future<void> loadData({bool init = false}) async {
    if (init) {
      final List<Department> departments = await Department.getByCenter(1);
      if (departments.isNotEmpty) {
        department = departments[0];
      }
    }
    List<Subject> a = [];
    if (department != null) {
      a = await Subject.getByDepartment(department!.id);
    }
    setState(() {
      subjects = a;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        title: const Text('Materias'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              await Get.toNamed(Routes.SUBJECTFORM, arguments: {
                "update": null,
                "initialId": await Subject.getId(),
                "initialValues": department,
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
              DepartmentDropdownButton(
                onSaved: (value) {},
                update: null,
                onChanged: (value) {
                  setState(() {
                    department = value;
                    loadData();
                  });
                },
              ),
              const SizedBox(
                height: 20.0,
              ),
              subjects.isNotEmpty
                  ? ListView.builder(
                      itemCount: subjects.length,
                      shrinkWrap: true,
                      physics: kNeverScroll,
                      itemBuilder: (context, index) {
                        return SubjectCard(
                          subject: subjects[index],
                          onChanged: loadData,
                        ).pb2;
                      },
                    )
                  : const Text('No se encontró ningúna Materia'),
            ],
          ).scrollable(padding: kPadding).aligned(Alignment.topCenter),
        ),
      ),
    );
  }
}

class SubjectCard extends StatelessWidget {
  final Subject subject;
  final void Function() onChanged;
  const SubjectCard({Key? key, required this.subject, required this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
          title: Text(subject.name),
          trailing: IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () async {
              await subject.delete();
              onChanged();
            },
          ),
          onTap: () async {
            await Get.toNamed(Routes.SUBJECTFORM, arguments: {"update": subject, "initialId": null, "initialValues": null});
            onChanged();
          }),
    );
  }
}
