import 'package:flutter/material.dart';
import 'package:hybrid_assistance/services/database_service.dart';
import 'package:intl/intl.dart';

import 'course.dart';
import 'classroom.dart';

enum WeekDay { monday, tuesday, wednesday, thursday, friday, saturday, sunday }

class VMSchedule{
  int id;
  String subject;
  WeekDay? weekDay;
  DateTime startTime;
  DateTime endTime;
  String? classroom;
  int? course;
  String? attendanceCode;

  VMSchedule({
    required this.id,
    required this.subject,
    this.weekDay,
    required this.startTime,
    required this.endTime,
    this.classroom,
    this.course,
    this.attendanceCode,
  });

  

static DateTime duration2datetime (Duration time){
  DateTime today =DateTime.now();
  List<String> yyyyMMdd = today.toString().split(' ');
  List<String> hhmmss = time.toString().split('.');
  String date = yyyyMMdd[0] + " " + hhmmss[0];
  DateTime dummy = DateFormat("yyyy-MM-dd hh:mm:ss").parse(date);
  return dummy;
}

  static Future<List<VMSchedule>> getClasses(String userId, String userType) async {
    List<VMSchedule>? schedule = [];
    if(userType == "UserTypes.student"){
    final result = await DatabaseService.to.connection.query(
      '''
      SELECT sch.id, sub.name AS 'subject', sch.weekday, sch.start_time, sch.end_time, cla.name AS 'classroom', cou.id FROM schedule sch
      JOIN course cou ON sch.id_course = cou.id
      JOIN classroom cla ON sch.id_classroom = cla.id
      JOIN subject sub ON cou.id_subject = sub.id
      JOIN academic_load al ON cou.id = al.id_course
      WHERE al.id_student = ?
      ''',
      [userId],
    );
    if (result.isNotEmpty) {
      for (var row in result) {
        schedule.add(VMSchedule(
          id: row[0],
          subject: row[1],
          weekDay: WeekDay.values[row[2]],
          startTime: duration2datetime(row[3]),
          endTime: duration2datetime(row[4]),
          classroom: row[5],
          course: row[6])
        );
      }
    }
    }else if(userType == "UserTypes.teacher"){
    final result = await DatabaseService.to.connection.query(
      '''
      SELECT sch.id, sub.name AS 'subject', sch.weekday, sch.start_time, sch.end_time, cla.name AS 'classroom', cou.id, cou.attendance_code FROM schedule sch
      JOIN course cou ON sch.id_course = cou.id
      JOIN classroom cla ON sch.id_classroom = cla.id
      JOIN subject sub ON cou.id_subject = sub.id
      WHERE cou.id_teacher =?
      ''',
      [userId],
    );
    if (result.isNotEmpty) {
      
      for (var row in result) {
        schedule.add(VMSchedule(
          id: row[0],
          subject: row[1],
          weekDay: WeekDay.values[row[2]],
          startTime: duration2datetime(row[3]),
          endTime: duration2datetime(row[4]),
          classroom: row[5],
          course: row[6],
          attendanceCode: row[7].toString())
        );
      }
    }
    } 
    
      return schedule;
  }
}
