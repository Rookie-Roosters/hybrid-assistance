import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hybrid_assistance/config/app_pages.dart';
import 'package:hybrid_assistance/models/career.dart';
import 'package:hybrid_assistance/models/group.dart';
import 'package:hybrid_assistance/widgets/career_dropdown.dart';

class GroupsPage extends StatefulWidget {
  const GroupsPage({Key? key}) : super(key: key);

  @override
  _GroupsPageState createState() => _GroupsPageState();
}

class _GroupsPageState extends State<GroupsPage> {
  List<Group> groups = [];
  Career? career;

  @override
  void initState() {
    super.initState();
    loadData(init: true);
  }

  Future<void> loadData({bool init = false}) async {
    if (init) {
      final List<Career> careers = await Career.getByDepartment(1);
      if (careers.isNotEmpty) {
        career = careers[0];
      }
    }
    List<Group> a = [];
    if (career != null) {
      a = await Group.getByCareer(career!.id);
    }
    setState(() {
      groups = a;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Grupos'),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              await Get.toNamed(Routes.GROUPFORM, arguments: {
                "update": null,
                "initialId": await Group.getId(),
                "initialValues": career,
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
            CareerDropdownButton(
              onSaved: (value) {},
              update: null,
              onChanged: (value) {
                setState(() {
                  career = value;
                  loadData();
                });
              },
            ),
            const SizedBox(
              height: 20.0,
            ),
            groups.isNotEmpty
                ? Expanded(
                    child: ListView.builder(
                      itemCount: groups.length,
                      itemBuilder: (context, index) {
                        return GroupCard(
                          group: groups[index],
                          onChanged: loadData,
                        );
                      },
                    ),
                  )
                : const Text('No se encontró ningún Grupo'),
          ],
        ),
      ),
    );
  }
}

class GroupCard extends StatelessWidget {
  final Group group;
  final void Function() onChanged;
  const GroupCard(
      {Key? key, required this.group, required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
          title: Text(group.generation + ' ' + group.letter),
          trailing: IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () async {
              await group.delete();
              onChanged();
            },
          ),
          onTap: () async {
            await Get.toNamed(Routes.GROUPFORM,
                arguments: {"update": group, "initialId": null, "initialValues": null});
            onChanged();
          }),
    );
  }
}
