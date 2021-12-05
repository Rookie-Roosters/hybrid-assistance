import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hybrid_assistance/models/academic_load.dart';

class AcademicLoadController {
  final GlobalKey<FormState> formStateKey = GlobalKey<FormState>();
  AcademicLoad academicLoad = AcademicLoad(id: 0, course: null, student: null);

  Future<void> add() async {
    if(formStateKey.currentState!.validate()) {
      formStateKey.currentState!.save();
      academicLoad.add();
      Get.back();
    }
  }

  Future<void> update() async {
    final int lastId = academicLoad.id;
    if(formStateKey.currentState!.validate()) {
      formStateKey.currentState!.save();
      academicLoad.update(lastId: lastId);
      Get.back();
    }
  }
}