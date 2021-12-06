import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hybrid_assistance/models/teacher.dart';

class TeacherController {
  final GlobalKey<FormState> formStateKey = GlobalKey<FormState>();
  Teacher teacher = Teacher(
      id: 0,
      name: '',
      firstLastName: '',
      secondLastName: '',
      password: '',
      picture: '');

  Future<void> add() async {
    if (formStateKey.currentState!.validate()) {
      formStateKey.currentState!.save();
      await teacher.add();
      Get.back();
    }
  }

  Future<void> update() async {
    final int lastId = teacher.id;
    if (formStateKey.currentState!.validate()) {
      formStateKey.currentState!.save();
      await teacher.update(lastId: lastId);
      Get.back();
    }
  }
}
