import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hybrid_assistance/models/classroom.dart';

class ClassroomController {
  final GlobalKey<FormState> formStateKey = GlobalKey<FormState>();
  Classroom classroom = Classroom(id: 0, name: '');

  Future<void> add() async {
    if (formStateKey.currentState!.validate()) {
      formStateKey.currentState!.save();
      classroom.add();
      Get.back();
    }
  }

  Future<void> update() async {
    final int lastId = classroom.id;
    if (formStateKey.currentState!.validate()) {
      formStateKey.currentState!.save();
      classroom.update(lastId: lastId);
      Get.back();
    }
  }
}