import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hybrid_assistance/models/group.dart';

class GroupController {
  final GlobalKey<FormState> formStateKey = GlobalKey<FormState>();
  Group group = Group(id: 0, career: null, generation: '', letter: '');

  Future<void> add() async {
    if (formStateKey.currentState!.validate()) {
      formStateKey.currentState!.save();
      await group.add();
      Get.back();
    }
  }

  Future<void> update() async {
    final int lastId = group.id;
    if (formStateKey.currentState!.validate()) {
      formStateKey.currentState!.save();
      await group.update(lastId: lastId);
      Get.back();
    }
  }
}
