import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hybrid_assistance/components/calendar.dart';
import 'package:hybrid_assistance/components/worthy/worthy_text.dart';
import 'package:hybrid_assistance/config/app_themes.dart';
import 'package:hybrid_assistance/pages/home/home_controller.dart';
import 'package:hybrid_assistance/services/session_sevice.dart';
import 'package:hybrid_assistance/utils/ui_utils.dart';
import 'package:line_icons/line_icons.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Column(children: [
        Row(children: [
          Icon(SessionService.to.teacher != null ? UserTypes.teacher.icon : UserTypes.student.icon, color: kPrimaryColor.onColor, size: 40).pr2,
          WorthyText.heading2(
            SessionService.to.teacher?.name ?? SessionService.to.student?.name ?? 'Usuario',
            overflow: true,
            color: kPrimaryColor.onColor,
          ).bottom([
            WorthyText.body(
              SessionService.to.teacher != null ? 'Maestro' : 'Estudiante',
              color: kPrimaryColor.onColor,
            )
          ]).expanded(),
          kSpacerX,
          IconButton(icon: Icon(LineIcons.alternateSignOut, color: kPrimaryColor.onColor), onPressed: () => controller.logOut())
        ]).p3,
        ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(kBorderRadius)),
          child: Container(
            color: kSurfaceColor,
            child: const Calendar(),
          ),
        ).expanded(),
      ]).safeArea(),
    ).overlayStyle(statusBar: kPrimaryColor, navigationBar: kSurfaceColor);
  }
}
