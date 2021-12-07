import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hybrid_assistance/models/classroom.dart';
import 'package:hybrid_assistance/models/schedule.dart';

class ScheduleController {
  final GlobalKey<FormState> formStateKey = GlobalKey<FormState>();
  Schedule schedule = Schedule(id: 0, course: null, classroom: null, weekDay: WeekDay.monday, startTime: DateTime.now(), endTime: DateTime.now());
  int? idClassroom;

  Future<void> add() async {
    if (formStateKey.currentState!.validate()) {
      formStateKey.currentState!.save();
      schedule.classroom = await Classroom.getById(idClassroom!);
      schedule.add();
      Get.back();
    }
  }

  Future<void> update() async {
    final int lastId = schedule.id;
    if (formStateKey.currentState!.validate()) {
      formStateKey.currentState!.save();
      schedule.classroom = await Classroom.getById(idClassroom!);
      schedule.update(lastId: lastId);
      Get.back();
    }
  }
}