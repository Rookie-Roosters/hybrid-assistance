import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hybrid_assistance/models/group.dart';

class GroupController {
  final GlobalKey<FormState> formStateKey = GlobalKey<FormState>();
  Group group = Group(id: 0, career: null, generation: '', letter: '', turn: Turn.morning);

  Future<void> add() async {
    if(formStateKey.currentState!.validate()){
      formStateKey.currentState!.save();
      //group.add();
      Get.back();
    }
  }

  Future<void> update() async {
    final int lastId = group.id;
    if (formStateKey.currentState!.validate()) {
      formStateKey.currentState!.save();
      //group.update(lastId: lastId);
      Get.back();
    }
  }
}