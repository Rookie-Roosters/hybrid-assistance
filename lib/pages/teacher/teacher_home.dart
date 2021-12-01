import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hybrid_assistance/components/attendance_calendar.dart';
import 'package:hybrid_assistance/components/worthy/worthy_text.dart';
import 'package:hybrid_assistance/services/session_sevice.dart';
import 'package:hybrid_assistance/pages/teacher/tch_home_controller.dart';
import 'package:hybrid_assistance/utils/ui_utils.dart';
import 'package:line_icons/line_icons.dart';

class TeacherHome extends GetView<TchHomeController> {
  const TeacherHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(mainAxisSize: MainAxisSize.max, crossAxisAlignment: CrossAxisAlignment.center, children: [
        kSpacer,
        WorthyText.heading2('Maestro'),
         IconButton(
          icon: const Icon(LineIcons.sign),
          onPressed: () => controller.logOut(),
        ),
        kSpacer,
        //const AttendanceCalendar()
      ],)
    );
  }
}
