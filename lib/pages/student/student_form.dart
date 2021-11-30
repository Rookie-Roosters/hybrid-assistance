import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'student_controller.dart';
export 'student_controller.dart';

class StudentForm extends GetView<StudentController> {
  const StudentForm({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Formulario estudiantes'),
      ),
      body: const Text('Joakin c la come'),
    );
  }
}