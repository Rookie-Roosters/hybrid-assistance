import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hybrid_assistance/config/app_pages.dart';
import 'package:hybrid_assistance/config/app_themes.dart';
import 'package:hybrid_assistance/models/course.dart';
import 'package:hybrid_assistance/models/schedule.dart';
import 'package:hybrid_assistance/utils/ui_utils.dart';
import 'package:hybrid_assistance/widgets/course_dropdown.dart';
import 'package:intl/intl.dart';

class SchedulesPage extends StatefulWidget {
  const SchedulesPage({Key? key}) : super(key: key);

  @override
  _SchedulesPageState createState() => _SchedulesPageState();
}

class _SchedulesPageState extends State<SchedulesPage> {
  List<Schedule> schedules = [];
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
    List<Schedule> a = [];
    if (course != null) {
      a = await Schedule.getByCourse(course!.id);
    }
    setState(() {
      schedules = a;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        title: const Text('Horario'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              await Get.toNamed(Routes.SCHEDULEFORM, arguments: {
                "update": null,
                "initialId": await Schedule.getId(),
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
              schedules.isNotEmpty
                  ? ListView.builder(
                      itemCount: schedules.length,
                      shrinkWrap: true,
                      physics: kNeverScroll,
                      itemBuilder: (context, index) {
                        return ScheduleCard(
                          schedule: schedules[index],
                          onChanged: loadData,
                        );
                      },
                    )
                  : const Text('No se encontró ningúna Hora'),
            ],
          ).scrollable(padding: kPadding).aligned(Alignment.topCenter),
        ),
      ),
    );
  }
}

class ScheduleCard extends StatelessWidget {
  final Schedule schedule;
  final void Function() onChanged;
  const ScheduleCard({Key? key, required this.schedule, required this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
          title: Text(schedule.course!.group!.generation +
              ' ' +
              schedule.course!.group!.letter +
              ' ' +
              schedule.course!.subject!.name +
              ' ' +
              schedule.classroom!.name +
              ' ' +
              spanishWeekDay(schedule.weekDay) +
              ' ' +
              DateFormat('HH:mm').format(schedule.startTime) +
              '-' +
              DateFormat('HH:mm').format(schedule.endTime)),
          trailing: IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () async {
              await schedule.delete();
              onChanged();
            },
          ),
          onTap: () async {
            await Get.toNamed(Routes.SCHEDULEFORM, arguments: {"update": schedule, "initialId": null, "initialValues": null});
            onChanged();
          }),
    );
  }
}
