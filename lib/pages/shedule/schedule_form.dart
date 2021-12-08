import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hybrid_assistance/models/classroom.dart';
import 'package:hybrid_assistance/models/schedule.dart';
import 'package:hybrid_assistance/widgets/course_dropdown.dart';
import 'package:intl/intl.dart';
import 'schedule_controller.dart';
export 'schedule_controller.dart';

class ScheduleForm extends GetView<ScheduleController> {
  const ScheduleForm({Key? key}) : super(key: key);

  String? validateClassroom(String? value) {
    if (!controller.schedule.validateNumber(value)) {
      return 'ID no válido';
    } else {
      Classroom.exist(int.tryParse(value!)!).then((value) {
        if (value) {
          return null;
        } else {
          return 'No existe ningún estudiante con ese ID';
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Schedule? update = Get.arguments['update'];
    if (update != null) controller.schedule = update;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: update == null
            ? const Text('Agregar Carga Académica')
            : const Text('Modificar Carga Académica'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: controller.formStateKey,
            autovalidateMode: AutovalidateMode.always,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'ID',
                    ),
                    enabled: false,
                    initialValue: update == null
                        ? Get.arguments['initialId'].toString()
                        : controller.schedule.id.toString(),
                    validator: (value) =>
                        controller.schedule.validateNumber(value)
                            ? null
                            : 'ID no válido',
                    onSaved: (value) => controller.schedule.id =
                        value == null ? 0 : int.tryParse(value)!,
                  ),
                  const SizedBox(height: 20.0),
                  CourseDropdownButton(
                    update: update == null
                        ? Get.arguments['initialValues']
                        : update.course,
                    onSaved: (newValue) =>
                        controller.schedule.course = newValue,
                    onChanged: (value) {},
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  WeekDayDropdownButton(controller: controller),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Hora de Inicio',
                      hintText: 'Ej. 18:30',
                    ),
                    initialValue: update == null
                        ? ''
                        : DateFormat('HH:mm')
                            .format(controller.schedule.startTime),
                    validator: (value) =>
                        controller.schedule.validateTime(value)
                            ? null
                            : 'Hora no válida',
                    onSaved: (value) => controller.schedule.startTime =
                        DateFormat("hh:mm").parse(value!),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Hora de Finalización',
                      hintText: 'Ej. 18:30',
                    ),
                    initialValue: update == null
                        ? ''
                        : DateFormat('HH:mm')
                            .format(controller.schedule.endTime),
                    validator: (value) =>
                        controller.schedule.validateTime(value)
                            ? null
                            : 'Hora no válida',
                    onSaved: (value) => controller.schedule.endTime =
                        DateFormat("hh:mm").parse(value!),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'ID Salón',
                    ),
                    initialValue: update == null
                        ? ''
                        : controller.schedule.classroom!.id.toString(),
                    validator: validateClassroom,
                    onSaved: (value) =>
                        controller.idClassroom = int.tryParse(value!)!,
                  ),
                  const Divider(
                    height: 36.0,
                  ),
                  ElevatedButton(
                    child: update == null
                        ? const Text('Agregar')
                        : const Text('Modificar'),
                    onPressed: () {
                      if (update == null) {
                        controller.add();
                      } else {
                        controller.update();
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class WeekDayDropdownButton extends StatefulWidget {
  final ScheduleController controller;
  const WeekDayDropdownButton({Key? key, required this.controller})
      : super(key: key);

  @override
  _WeekDayDropdownButtonState createState() => _WeekDayDropdownButtonState();
}

class _WeekDayDropdownButtonState extends State<WeekDayDropdownButton> {
  WeekDay weekDay = WeekDay.monday;

  @override
  Widget build(BuildContext context) {
    weekDay = widget.controller.schedule.weekDay;
    return DropdownButtonFormField<WeekDay>(
      decoration: const InputDecoration(
        labelText: 'Día de la semana',
      ),
      value: weekDay,
      onChanged: (WeekDay? newValue) {
        setState(() {
          weekDay = newValue!;
        });
      },
      items: WeekDay.values.map((WeekDay weekDay) {
        return DropdownMenuItem<WeekDay>(
          value: weekDay,
          child: Text(spanishWeekDay(weekDay)),
        );
      }).toList(),
      onSaved: (value) => widget.controller.schedule.weekDay = value!,
    );
  }
}
