import 'package:flutter/material.dart';
import 'package:hybrid_assistance/models/student.dart';
import 'package:get/get.dart';

class StudentController {
  final GlobalKey<FormState> formStateKey = GlobalKey<FormState>();
  Student student =
      Student(name: '', firstLastName: '', secondLastName: '', password: '');

  Future<void> add() async {
    if (formStateKey.currentState!.validate()) {
      formStateKey.currentState!.save();
      student.add();
      Get.back();
    }
  }

  Future<void> update() async {
    final int lastId = student.id!;
    if (formStateKey.currentState!.validate()) {
      formStateKey.currentState!.save();
      student.update(lastId: lastId);
      Get.back();
    }
  }
}
