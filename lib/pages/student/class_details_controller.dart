import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hybrid_assistance/components/calendar_controller.dart';
import 'package:hybrid_assistance/components/worthy/worthy_button.dart';
import 'package:hybrid_assistance/config/app_pages.dart';
import 'package:hybrid_assistance/models/attendance.dart';
import 'package:hybrid_assistance/models/schedule_view_model.dart';
import 'package:get/get.dart';
import 'package:hybrid_assistance/pages/teacher/list_controller.dart';

class ClassDetailsController extends GetxController with StateMixin {
  final GlobalKey<FormState> formStateKey = GlobalKey<FormState>();
  final code = TextEditingController();
  final buttonKey = GlobalKey<WorthyButtonState>();
  bool stat = false.obs();
  final userId = GetStorage().read<String>('userId');
  VMSchedule selectedClass = Get.find<TheCalendarController>().selectedClass;
  DateTime selectedDate = Get.find<TheCalendarController>().selectedDate;
  AttendanceStatus selectedStatus = AttendanceStatus.present;
  Attendance todaysAttendance = Attendance(id: 0, dateTime: DateTime.now(), status: AttendanceStatus.present).obs();
  String message = 'Aun no se genera un código para esta clase'.obs();

  @override
  void onInit() {
    checkCode();
    super.onInit();
  }

  void checkCode() async {
    change(null, status: RxStatus.loading());
    if ((daysBetween(selectedDate, DateTime.now()) == 0) && (checkTime())){
      stat = await Attendance.checkCode(selectedClass.id, int.parse(userId!));
      if (stat) {
        await getStatus();
      }
    } else {
      if (daysBetween(selectedDate, DateTime.now()) > 0) {
        await getStatus();
      }
    }
    change(null, status: RxStatus.success());
  }

  Future<void> getStatus() async {
    try{
    todaysAttendance = await Attendance.getAttendance(
        selectedClass.id, int.parse(userId!), selectedDate);
    }on Exception catch(_){
      message = 'No hubo asistencia este dia';
      stat = false;
    }
  }

void changeStatus(AttendanceStatus value) {
  selectedStatus = value;
    update();
  }

  void returnHome() async {
    Get.offAllNamed(Routes.HOME);
  }

  Future<void> edit() async {
    if (formStateKey.currentState?.validate() ?? false) {
      buttonKey.currentState?.setStatus(WorthyButtonStatus.LOADING);
    message = await Attendance.update(todaysAttendance.id, todaysAttendance.schedule!, code.text, selectedStatus);
    if(message == ''){
      stat = true;
      todaysAttendance.status = selectedStatus;
    }else{
      stat = false;
    }
    update();
    buttonKey.currentState?.setStatus(WorthyButtonStatus.IDLE);
    }
  }
  bool checkTime(){
    if((DateTime.now().hour == selectedClass.startTime.hour)||((DateTime.now().hour+1 == selectedClass.endTime.hour)&&(DateTime.now().minute < selectedClass.endTime.minute+15))){
      return true;
    }
    else{
      return false;
    }
  }

    int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
  return (to.difference(from).inHours / 24).round();
}
}
