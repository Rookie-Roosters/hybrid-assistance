import 'package:flutter/material.dart' hide Center;
import 'package:get/get.dart';
import 'package:hybrid_assistance/models/center.dart';

class CenterController {
  final GlobalKey<FormState> formStateKey = GlobalKey<FormState>();
  Center center = Center(id: 0, name: '');

  Future<void> add() async {
    if(formStateKey.currentState!.validate()){
      formStateKey.currentState!.save();
      await center.add();
      Get.back();
    }
  }

  Future<void> update() async {
    final int lastId = center.id;
    if (formStateKey.currentState!.validate()) {
      formStateKey.currentState!.save();
      await center.update(lastId: lastId);
      Get.back();
    }
  }
}