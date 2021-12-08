import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hybrid_assistance/models/academic_load.dart';
import 'package:hybrid_assistance/models/student.dart';

class AcademicLoadController {
  final GlobalKey<FormState> formStateKey = GlobalKey<FormState>();
  AcademicLoad academicLoad = AcademicLoad(id: 0, course: null, student: null);
  int? idStudent;

  Future<void> add() async {
    if (formStateKey.currentState!.validate()) {
      formStateKey.currentState!.save();
      academicLoad.student = await Student.getById(idStudent!);
      await academicLoad.add();
      Get.back();
    }
  }

  Future<void> update() async {
    final int lastId = academicLoad.id;
    if (formStateKey.currentState!.validate()) {
      formStateKey.currentState!.save();
      academicLoad.student = await Student.getById(idStudent!);
      await academicLoad.update(lastId: lastId);
      Get.back();
    }
  }
}
