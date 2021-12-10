import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hybrid_assistance/components/calendar_controller.dart';
import 'package:hybrid_assistance/components/worthy/worthy_text.dart';

class Calendar extends GetView<TheCalendarController> {
  const Calendar({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return controller.obx(
      (state) {
        return CalendarControllerProvider(
            // ¯\_(ツ)_/¯ el package funciona asi
            controller: EventController()..addAll(controller.events),
            child: WeekView(
              eventTileBuilder: (date, events, boundry, start, end) {
                // Metanle bustra
                return Container(
                  constraints: const BoxConstraints(maxHeight: 55),
                  child: WorthyText.bodySmall(
                    events[0].title,
                    style: const TextStyle(overflow: TextOverflow.fade),
                  ),
                );
              },
              showLiveTimeLineInAllDays: true,
              width: Get.width, // que sea dinamico
              initialDay: DateTime.now(),
              heightPerMinute: 1,
              eventArranger: const SideEventArranger(),
              onEventTap: (events, date) => controller.goToClass(events, date),
            ));
      },
      onLoading: const Scaffold(body: CircularProgressIndicator()),
    );
  }
}
