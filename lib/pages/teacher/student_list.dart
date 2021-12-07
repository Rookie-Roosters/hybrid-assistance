import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:hybrid_assistance/components/worthy/worthy_button.dart';
import 'package:hybrid_assistance/components/worthy/worthy_text.dart';
import 'package:hybrid_assistance/config/app_themes.dart';
import 'package:hybrid_assistance/models/view_models/student_attendance.dart';

import 'package:hybrid_assistance/pages/teacher/list_controller.dart';
import 'package:hybrid_assistance/utils/ui_utils.dart';
import 'package:line_icons/line_icons.dart';

class StudentList extends GetView<ListController> {
  const StudentList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return controller.obx((state) {
      return Scaffold(
          body: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
            kSpacer,
            WorthyText.body(controller.selectedDate.toString()),
            IconButton(
              icon: const Icon(LineIcons.arrowLeft),
              onPressed: () => controller.returnHome(),
            ),
            WorthyText.heading2(controller.selectedClass.subject),
            WorthyText.body(controller.selectedClass.startTime
                    .toString()
                    .substring(11, 16) +
                " - " +
                controller.selectedClass.endTime.toString().substring(11, 16)),
            WorthyText.body("Edificio " + controller.selectedClass.classroom!),
            //boton para generar el codigo del dia
            Visibility( //stat: muestra si los status ya son visibles 
                visible: !controller.stat,
                child: WorthyButton.elevated(
                  key: controller.codeButtonKey,
                  child: const Text('GENERAR CÓDIGO'),
                  prefix: const Icon(LineIcons.stickyNote),
                  color: kSecondaryColor,
                  onPressed: () => controller.getCode(),
                )),
            Visibility( //hide: esconde lo relacionado a la edicion
              visible: !controller.hide,
              child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                    WorthyText.heading3("Código: " + controller.code),
                    kSpacerY5,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        if (!controller.editMode)
                          Column(children: [
                            kSpacerX5,
                            WorthyButton.elevated(
                              key: controller.cancelEditButtonKey,
                              child: const Text('CANCELAR'),
                              prefix: const Icon(LineIcons.stickyNote),
                              color: kInfoColor,
                              onPressed: () => controller.intoEditMode(),
                            ),
                            WorthyButton.elevated(
                              key: controller.saveEditButtonKey,
                              child: const Text('GUARDAR'),
                              prefix: const Icon(LineIcons.stickyNote),
                              color: kSecondaryColor,
                              onPressed: () => controller.editList(),
                            )
                          ])
                        else
                          Column(children: [
                            WorthyButton.elevated(
                              key: controller.editButtonKey,
                              child: const Text('EDITAR'),
                              prefix: const Icon(LineIcons.stickyNote),
                              color: kSecondaryColor,
                              onPressed: () => controller.intoEditMode(),
                            ),
                            kSpacerX5
                          ]),
                        kSpacerX5,
                      ],
                    )
                  ]),
            ),
            //Lista de alumnos
            if (controller.attendanceList.isNotEmpty)
              Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                      WorthyText.body('F  P  L'),
                      kSpacerX5,
                    ]),
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: controller.attendanceList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            //leading: Icon(Icons.list),
                            trailing: SizedBox(
                              width: 100,
                              child: Row(children: [
                                Transform.scale(
                                    scale: 0.9,
                                    child: Obx(
                                      () => Radio<AttendanceStatus>(
                                        materialTapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                        visualDensity: const VisualDensity(
                                          horizontal:
                                              VisualDensity.minimumDensity,
                                          vertical:
                                              VisualDensity.minimumDensity,
                                        ),
                                        value: AttendanceStatus.absent,
                                        activeColor: Colors.red,
                                        groupValue: controller
                                            .attendanceList[index].status,
                                        onChanged: controller.editMode
                                            ? null
                                            : (value) {
                                                controller.changeStatus(
                                                    value!, index);
                                              },
                                      ),
                                    )),
                                Transform.scale(
                                    scale: 0.9,
                                    child: Obx(
                                      () => Radio<AttendanceStatus>(
                                        materialTapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                        visualDensity: const VisualDensity(
                                          horizontal:
                                              VisualDensity.minimumDensity,
                                          vertical:
                                              VisualDensity.minimumDensity,
                                        ),
                                        value: AttendanceStatus.present,
                                        activeColor: Colors.green,
                                        groupValue: controller
                                            .attendanceList[index].status,
                                        onChanged: controller.editMode
                                            ? null
                                            : (value) {
                                                controller.changeStatus(
                                                    value!, index);
                                              },
                                      ),
                                    )),
                                Transform.scale(
                                  scale: 0.9,
                                  child: Obx(
                                    () => Radio<AttendanceStatus>(
                                      materialTapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                      visualDensity: const VisualDensity(
                                        horizontal:
                                            VisualDensity.minimumDensity,
                                        vertical: VisualDensity.minimumDensity,
                                      ),
                                      value: AttendanceStatus.online,
                                      groupValue: controller
                                          .attendanceList[index].status,
                                      onChanged: controller.editMode
                                          ? null
                                          : (value) {
                                              controller.changeStatus(
                                                  value!, index);
                                            },
                                    ),
                                  ),
                                )
                              ]),
                            ),

                            title: WorthyText.bodyLarge(controller
                                    .attendanceList[index].name +
                                " " +
                                controller.attendanceList[index].firstLastName +
                                " " +
                                controller
                                    .attendanceList[index].secondLastName),
                          );
                        })
                  ])
            else if (controller.stat)
              Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  kSpacerY5,
                  WorthyText.heading3('No hay lista para este día')
                ],
              ),
            kSpacer,
          ]));
    }, onLoading: const Scaffold( body: CircularProgressIndicator()));
  }
}
