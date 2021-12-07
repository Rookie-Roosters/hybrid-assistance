import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hybrid_assistance/models/career.dart';

class CareerController {
  final GlobalKey<FormState> formStateKey = GlobalKey<FormState>();
  Career career = Career(id: 0, department: null, name: '');

  Future<void> add() async {
    if(formStateKey.currentState!.validate()){
      formStateKey.currentState!.save();
      await career.add();
      Get.back();
    }
  }

  Future<void> update() async {
    final int lastId = career.id;
    if (formStateKey.currentState!.validate()) {
      formStateKey.currentState!.save();
      await career.update(lastId: lastId);
      Get.back();
    }
  }
}