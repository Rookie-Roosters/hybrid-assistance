import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hybrid_assistance/models/subject.dart';

class SubjectController {
  final GlobalKey<FormState> formStateKey = GlobalKey<FormState>();
  Subject subject = Subject(id: 0, department: null, name: '');

  Future<void> add() async {
    if(formStateKey.currentState!.validate()){
      formStateKey.currentState!.save();
      subject.add();
      Get.back();
    }
  }

  Future<void> update() async {
    final int lastId = subject.id;
    if (formStateKey.currentState!.validate()) {
      formStateKey.currentState!.save();
      subject.update(lastId: lastId);
      Get.back();
    }
  }
}