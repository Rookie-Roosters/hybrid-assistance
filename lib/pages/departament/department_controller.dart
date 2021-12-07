import 'package:flutter/material.dart' hide Center;
import 'package:get/get.dart';
import 'package:hybrid_assistance/models/department.dart';

class DepartmentController {
  final GlobalKey<FormState> formStateKey = GlobalKey<FormState>();
  Department department = Department(id: 0, center: null, name: '');

  Future<void> add() async {
    if(formStateKey.currentState!.validate()){
      formStateKey.currentState!.save();
      await department.add();
      Get.back();
    }
  }

  Future<void> update() async {
    final int lastId = department.id;
    if (formStateKey.currentState!.validate()) {
      formStateKey.currentState!.save();
      await department.update(lastId: lastId);
      Get.back();
    }
  }
}