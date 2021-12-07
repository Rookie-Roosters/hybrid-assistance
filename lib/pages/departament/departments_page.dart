import 'package:flutter/material.dart' hide Center;
import 'package:get/get.dart';
import 'package:hybrid_assistance/config/app_pages.dart';
import 'package:hybrid_assistance/models/center.dart';
import 'package:hybrid_assistance/models/department.dart';
import 'package:hybrid_assistance/widgets/center_dropdown.dart';

class DepartmentsPage extends StatefulWidget {
  const DepartmentsPage({Key? key}) : super(key: key);

  @override
  _DepartmentsPageState createState() => _DepartmentsPageState();
}

class _DepartmentsPageState extends State<DepartmentsPage> {
  List<Department> departments = [];
  Center? center;

  @override
  void initState() {
    super.initState();
    loadData(init: true);
  }

  Future<void> loadData({bool init = false}) async {
    if (init) {
      final List<Center> centers = await Center.getAll();
      if (centers.isNotEmpty) {
        center = centers[0];
      }
    }
    List<Department> a = [];
    if (center != null) {
      a = await Department.getByCenter(center!.id);
    }
    setState(() {
      departments = a;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Departamentos'),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              await Get.toNamed(Routes.DEPARTMENTFORM, arguments: {
                "update": null,
                "initialId": await Department.getId(),
                "initialValues": center,
              });
              loadData();
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20.0),
            CenterDropdownButton(
              onSaved: (value) {},
              update: null,
              onChanged: (value) {
                setState(() {
                  center = value;
                  loadData();
                });
              },
            ),
            const SizedBox(
              height: 20.0,
            ),
            departments.isNotEmpty
                ? Expanded(
                    child: ListView.builder(
                      itemCount: departments.length,
                      itemBuilder: (context, index) {
                        return DepartmentCard(
                          department: departments[index],
                          onChanged: loadData,
                        );
                      },
                    ),
                  )
                : const Text('No se encontró ningún Departamento'),
          ],
        ),
      ),
    );
  }
}

class DepartmentCard extends StatelessWidget {
  final Department department;
  final void Function() onChanged;
  const DepartmentCard(
      {Key? key, required this.department, required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
          title: Text(department.name),
          trailing: IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () async {
              await department.delete();
              onChanged();
            },
          ),
          onTap: () async {
            await Get.toNamed(Routes.DEPARTMENTFORM,
                arguments: {"update": department, "initialId": null, "initialValues": null});
            onChanged();
          }),
    );
  }
}
