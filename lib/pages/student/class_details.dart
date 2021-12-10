import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hybrid_assistance/components/worthy/worthy_button.dart';
import 'package:hybrid_assistance/components/worthy/worthy_container.dart';
import 'package:hybrid_assistance/components/worthy/worthy_text.dart';
import 'package:hybrid_assistance/components/worthy/worthy_text_field.dart';
import 'package:hybrid_assistance/models/attendance.dart';
import 'package:hybrid_assistance/utils/format_utils.dart';
import 'package:hybrid_assistance/utils/ui_utils.dart';
import 'package:line_icons/line_icons.dart';
import 'class_details_controller.dart';

class ClassDetails extends GetView<ClassDetailsController> {
  const ClassDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return controller.obx((state) {
      return Scaffold(
          body: Column(mainAxisSize: MainAxisSize.max, crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        kSpacer,
        WorthyText.body(controller.selectedDate.toString().substring(0,10), textAlign: TextAlign.center),
        IconButton(
          icon: const Icon(LineIcons.arrowLeft),
          onPressed: () => controller.returnHome(),
        ),
        WorthyText.heading2(controller.selectedClass.subject, textAlign: TextAlign.center),
        WorthyText.body(
            controller.selectedClass.startTime.toString().substring(11, 16) + " - " + controller.selectedClass.endTime.toString().substring(11, 16), textAlign: TextAlign.center),
        WorthyText.body("Edificio " + controller.selectedClass.classroom!, textAlign: TextAlign.center),
        kSpacerY5,
        Visibility(
          visible: (controller.todaysAttendance.status.index == 0),
          child: Column(mainAxisSize: MainAxisSize.max, crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            WorthyText.heading3('Confirmar asistencia'),
            Form(
                key: controller.formStateKey,
                child: WorthyContainer(
                  child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                    RadioListTile<AttendanceStatus>(
                      title: WorthyText.bodyLarge(AttendanceStatus.present.statusName),
                      value: AttendanceStatus.present,
                      groupValue: controller.selectedStatus,
                      onChanged: (value) => controller.changeStatus(value!),
                    ),
                    RadioListTile<AttendanceStatus>(
                      title: WorthyText.bodyLarge(AttendanceStatus.online.statusName),
                      value: AttendanceStatus.online,
                      groupValue: controller.selectedStatus,
                      onChanged: (value) => controller.changeStatus(value!),
                    ),
                    WorthyTextField(
                      label: 'Código',
                      prefix: const Icon(LineIcons.hashtag),
                      validator: Validator.requiredField,
                      keyboardType: TextInputType.number,
                      controller: controller.code,
                    ),
                    WorthyButton.elevated(
                      key: controller.buttonKey,
                      child: const Text('ENVIAR'),
                      prefix: const Icon(LineIcons.alternateSignIn),
                      onPressed: () => controller.edit(),
                    ).p2,
                  ]),
                )),
          ]),
        ),
        if (controller.todaysAttendance.id != 0 && (controller.todaysAttendance.status.index != 0))
          Column(mainAxisSize: MainAxisSize.max, crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            WorthyText.heading3('Asistencia de hoy', textAlign: TextAlign.center),
            WorthyText.heading2(controller.todaysAttendance.status.statusName, textAlign: TextAlign.center),
          ])
        else if (!controller.stat)
          WorthyText.heading3(controller.message, textAlign: TextAlign.center),
        kSpacer,
      ]));
    }, onLoading: const Scaffold(body: CircularProgressIndicator()));
    //}
  }
}
