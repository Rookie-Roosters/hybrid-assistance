import 'package:flutter/material.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hybrid_assistance/config/app_pages.dart';
import 'package:hybrid_assistance/models/schedule_view_model.dart';
import 'package:hybrid_assistance/pages/login/login_page.dart';
import 'package:intl/intl.dart';

class TheCalendarController extends GetxController with StateMixin {
  final schedule = <VMSchedule>[].obs;
  final events = <CalendarEventData<dynamic>>[].obs;
  final userId = GetStorage().read<String>('userId');
  final userType = GetStorage().read<String>('userType');
  late DateTime selectedDate;
  late VMSchedule selectedClass;
  String startOfSemester = '2021-08-09';
  String endOfSemester = '2021-12-11';

  @override
  void onInit() {
    getSchedule();
    super.onInit();
  }

  void getSchedule() async {
    change(null, status: RxStatus.loading());
    schedule.assignAll(await VMSchedule.getClasses(userId!, userType!));
    for (var event in schedule) {
      events.add(CalendarEventData(
        title: event.subject,
        startTime: event.startTime,
        endTime: event.endTime.subtract(const Duration(minutes: 1)),
        date: DateFormat('yyyy-MM-dd').parse(startOfSemester),
        endDate: DateFormat('yyyy-MM-dd').parse(endOfSemester),
        event: event,
      ));
    }
    change(null, status: RxStatus.success());
  }

  void goToClass(List<CalendarEventData<dynamic>> events, DateTime date) {
    selectedDate = date;
    selectedClass = events[0].event;
    if (userType == UserTypes.teacher.toString()) {
      Get.offAllNamed(Routes.STUDENTLIST);
    } else {
      Get.offAllNamed(Routes.CLASSDETAILS);
    }
  }
}     /*if(schedule!.isNotEmpty){
      //return schedule!.where((e) =>e.weekDay.name == DateTime.now().weekday.toString().split('.').last).toList(); 
      return schedule!;
    }*/
        /*VMSchedule findClass(int id) => schedule.firstWhere((item) => item.id == id);
    for(var item in events){
      selectedClass = findClass(int.parse(item.event.toString()));
    }*/