import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hybrid_assistance/components/calendar_controller.dart';
import 'package:hybrid_assistance/components/worthy/worthy_button.dart';
import 'package:hybrid_assistance/config/app_pages.dart';
import 'package:hybrid_assistance/models/schedule_view_model.dart';
import 'package:hybrid_assistance/models/view_models/student_attendance.dart';

class ListController extends GetxController with StateMixin {
  String code = '2'.obs(); //añade los demas alumnos
  bool stat = false.obs();
  bool hide = true.obs();
  bool editMode = true.obs();
  VMSchedule selectedClass = Get.find<TheCalendarController>().selectedClass;
  DateTime selectedDate = Get.find<TheCalendarController>().selectedDate;

  final codeButtonKey = GlobalKey<WorthyButtonState>();
  final editButtonKey = GlobalKey<WorthyButtonState>();
  final saveEditButtonKey = GlobalKey<WorthyButtonState>();
  final cancelEditButtonKey = GlobalKey<WorthyButtonState>();
  final attendanceList = <StudentAttendance>[].obs;
  void returnHome() async {
    Get.offAllNamed(Routes.HOME);
  }

  @override
  void onInit() {
      checkCode();
    super.onInit();
  }

  void checkCode() async {
    change(null, status: RxStatus.loading());
    if ((daysBetween(selectedDate, DateTime.now()) == 0) && ((checkTime()))){
      stat = await StudentAttendance.checkCode(selectedClass.id);
    if (stat) {
      hide=false;
      code = selectedClass.attendanceCode.toString();
      await getList();
    }
    }else{
      stat=true;
      if(daysBetween(selectedDate, DateTime.now()) >= 0){
        await getList();
      }
    }
    
    change(null, status: RxStatus.success());
  }

  void getCode() async {
    change(null, status: RxStatus.loading());
    code = await StudentAttendance.generateCodeNList(
        selectedClass.id, selectedClass.course!);
    selectedClass.attendanceCode = code;
     if (code != '2') {
      await getList();
      stat = false;
      hide = false;
     }
    change(null, status: RxStatus.success());
  }

  Future<void> getList() async {
    change(null, status: RxStatus.loading());
      attendanceList.assignAll(await StudentAttendance.getAttendanceList(selectedClass.id, selectedDate));
    change(null, status: RxStatus.success());
  }

  void changeStatus(AttendanceStatus value, int index) {
    attendanceList[index].status = value;
    update();
  }

  void intoEditMode() {
    editMode = !editMode;
    update();
  }

  Future<void> editList() async {
    change(null, status: RxStatus.loading());
    await StudentAttendance.updateList(attendanceList);
    change(null, status: RxStatus.success());
  }

  bool checkTime(){
    if((DateTime.now().hour == selectedClass.startTime.hour)||((DateTime.now().hour+1 == selectedClass.endTime.hour)&&(DateTime.now().minute < selectedClass.endTime.minute+2))){
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


