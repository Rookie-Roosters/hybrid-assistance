import 'package:hybrid_assistance/services/database_service.dart';
import 'package:hybrid_assistance/utils/validate_utils.dart';
import 'package:intl/intl.dart';

import 'course.dart';
import 'classroom.dart';

enum WeekDay { monday, tuesday, wednesday, thursday, friday, saturday, sunday }

String spanishWeekDay(WeekDay weekDay) {
  switch (weekDay) {
    case WeekDay.monday:
      return 'Lunes';
    case WeekDay.tuesday:
      return 'Martes';
    case WeekDay.wednesday:
      return 'Miércoles';
    case WeekDay.thursday:
      return 'Jueves';
    case WeekDay.friday:
      return 'Viernes';
    case WeekDay.saturday:
      return 'Sábado';
    case WeekDay.sunday:
      return 'Domingo';
  }
}

class Schedule with ValidateUtils {
  int id;
  Course? course;
  Classroom? classroom;
  WeekDay weekDay;
  DateTime startTime;
  DateTime endTime;

  //Constructor
  Schedule({
    required this.id,
    required this.course,
    required this.classroom,
    required this.weekDay,
    required this.startTime,
    required this.endTime,
  });

  //Validaciones
  bool validate() {
    return validateNumber(id.toString());
  }

  //CRUD
  static Future<bool> exist(int id) async {
    final result = await DatabaseService.to.connection.query(
      '''
      SELECT * FROM `schedule` WHERE `id`=?;
      ''',
      [id],
    );
    if (result.isNotEmpty) return true;
    return false;
  }

  static Future<int> getId() async {
    final result = await DatabaseService.to.connection.query(
      '''
      SELECT MAX(`id`)
      FROM `schedule`
      ''',
    );
    if (result.length == 1) {
      for (var row in result) {
        return (row[0] ?? 0) + 1;
      }
    }
    throw Exception('Bad consult');
  }

  static Future<Schedule> getById(int id) async {
    final result = await DatabaseService.to.connection.query(
      '''
      SELECT `id`, `id_course`, `id_classroom`, `weekday`, `start_time`, `end_time`
      FROM `schedule`
      WHERE `id`=?;
      ''',
      [id],
    );
    if (result.length == 1) {
      for (var row in result) {
        return Schedule(
          id: row[0],
          course: await Course.getById(row[1]),
          classroom: await Classroom.getById(row[2]),
          weekDay: WeekDay.values[row[3]],
          startTime: DateFormat("hh:mm")
              .parse(row[4].toString())
              .subtract(const Duration(hours: 6)),
          endTime: DateFormat("hh:mm")
              .parse(row[5].toString())
              .subtract(const Duration(hours: 6)),
        );
      }
    }
    throw Exception(
        'Query returned more than one academic load or no academic load.');
  }

  static Future<List<Schedule>> getByCourse(int id) async {
    final result = await DatabaseService.to.connection.query(
      '''
      SELECT `id`, `id_course`, `id_classroom`, `weekday`, `start_time`, `end_time`
      FROM `schedule`
      WHERE `id_course`=?;
      ''',
      [id],
    );
    List<Schedule> schedules = [];
    for (var row in result) {
      schedules.add(Schedule(
        id: row[0],
        course: await Course.getById(row[1]),
        classroom: await Classroom.getById(row[2]),
        weekDay: WeekDay.values[row[3]],
        startTime: DateFormat("hh:mm")
            .parse(row[4].toString())
            .subtract(const Duration(hours: 6)),
        endTime: DateFormat("hh:mm")
            .parse(row[5].toString())
            .subtract(const Duration(hours: 6)),
      ));
    }
    return schedules;
  }

  Future<void> add() async {
    if (validate() && !await exist(id)) {
      await DatabaseService.to.connection.query(
        '''
        INSERT INTO `schedule`
        (`id`, `id_course`, `id_classroom`, `weekday`, `start_time`, `end_time`)
        VALUES (?,?,?,?,?,?)
        ''',
        [
          id,
          course!.id,
          classroom!.id,
          weekDay.index,
          startTime.toUtc(),
          endTime.toUtc()
        ],
      );
    } else {
      throw Exception('Invalid Data or academic load already exist');
    }
  }

  Future<void> update({int? lastId}) async {
    if (validate() && await exist(id)) {
      await DatabaseService.to.connection.query(
        '''
        UPDATE `schedule`
        SET `id`=?,`id_course`=?,`id_classroom`=?,`weekday`=?,`start_time`=?,`end_time`=?
        WHERE `id`=?;
        ''',
        [
          id,
          course!.id,
          classroom!.id,
          weekDay.index,
          startTime.toUtc(),
          endTime.toUtc(),
          lastId ?? id
        ],
      );
    } else {
      throw Exception('Invalid Data or academi load doesn\'t exist');
    }
  }

  Future<void> delete() async {
    if (await exist(id)) {
      await DatabaseService.to.connection.query('''
      DELETE FROM `schedule` WHERE `id` = ?;
      ''', [id]);
    } else {
      throw Exception('Schedule doesn\'t exist');
    }
  }
}
