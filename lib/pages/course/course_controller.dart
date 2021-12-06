import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hybrid_assistance/models/course.dart';
import 'package:hybrid_assistance/models/teacher.dart';

class CourseController {
  final GlobalKey<FormState> formStateKey = GlobalKey<FormState>();
  Course course = Course(id: 0, group: null, subject: null, teacher: null, attendanceCode: 0);
  int? idTeacher;

  Future<void> add() async {
    if(formStateKey.currentState!.validate()) {
      formStateKey.currentState!.save();
      course.teacher = await Teacher.getById(idTeacher!);
      course.add();
      Get.back();
    }
  }

  Future<void> update() async {
    final int lastId = course.id;
    if(formStateKey.currentState!.validate()) {
      formStateKey.currentState!.save();
      course.teacher = await Teacher.getById(idTeacher!);
      course.update(lastId: lastId);
      Get.back();
    }
  }
}