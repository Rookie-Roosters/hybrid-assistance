import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hybrid_assistance/config/app_pages.dart';
import 'package:hybrid_assistance/config/app_themes.dart';
import 'package:hybrid_assistance/models/department.dart';
import 'package:hybrid_assistance/models/career.dart';
import 'package:hybrid_assistance/utils/ui_utils.dart';
import 'package:hybrid_assistance/widgets/department_dropdown.dart';

class CareersPage extends StatefulWidget {
  const CareersPage({Key? key}) : super(key: key);

  @override
  _CareersPageState createState() => _CareersPageState();
}

class _CareersPageState extends State<CareersPage> {
  List<Career> careers = [];
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
    List<Career> a = [];
    if (department != null) {
      a = await Career.getByDepartment(department!.id);
    }
    setState(() {
      careers = a;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        title: const Text('Carreras'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              await Get.toNamed(Routes.CAREERFORM, arguments: {
                "update": null,
                "initialId": await Career.getId(),
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
              careers.isNotEmpty
                  ? ListView.builder(
                      itemCount: careers.length,
                      shrinkWrap: true,
                      physics: kNeverScroll,
                      itemBuilder: (context, index) {
                        return CareerCard(
                          career: careers[index],
                          onChanged: loadData,
                        ).pb2;
                      },
                    )
                  : const Text('No se encontró ningúna Carrera'),
            ],
          ).scrollable(padding: kPadding).aligned(Alignment.topCenter),
        ),
      ),
    );
  }
}

class CareerCard extends StatelessWidget {
  final Career career;
  final void Function() onChanged;
  const CareerCard({Key? key, required this.career, required this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
          title: Text(career.name),
          trailing: IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () async {
              await career.delete();
              onChanged();
            },
          ),
          onTap: () async {
            await Get.toNamed(Routes.CAREERFORM, arguments: {"update": career, "initialId": null, "initialValues": null});
            onChanged();
          }),
    );
  }
}
