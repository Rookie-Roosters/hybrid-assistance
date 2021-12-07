import 'dart:math';

import 'package:hybrid_assistance/services/database_service.dart';
import 'package:hybrid_assistance/utils/format_utils.dart';
import 'package:intl/intl.dart';

enum AttendanceStatus { absent, present, online }

class StudentAttendance {
  int? id;
  String name;
  String firstLastName;
  String secondLastName;
  String? nickname;
  String? picture;
  int? schedule;
  DateTime? dateTime;
  AttendanceStatus status;
  int? attendanceId;

  StudentAttendance({
    this.id,
    required this.name,
    required this.firstLastName,
    required this.secondLastName,
    this.nickname,
    this.picture,
    this.schedule,
    this.dateTime,
    required this.status,
    this.attendanceId,
  });

  static Future<bool> checkCode(int scheduleId) async {
    DateTime today = DateTime.now().toUtc();
    DateTime lastDate = DateTime.now().toUtc();
    final query = await DatabaseService.to.connection.query(
      '''
    SELECT att.date_time FROM attendance att
    JOIN schedule sch ON sch.id = att.id_schedule
    WHERE sch.id = ?
    ORDER BY att.date_time DESC LIMIT 1;
    ''',
      [scheduleId],
    );
    if (query.isNotEmpty) {
      for (var row in query) {
        lastDate = (row[0]);
      }
    } else {
      lastDate = today.subtract(const Duration(days: 1));
    }
    if (today.day == lastDate.day) {
      return true; //ya hay codigo
    } else {
      return false; //nuevo codigo (si es la primera vez)
    }
  }

  static Future<String> generateCodeNList(int scheduleId, int courseId) async {
    int code = -1;
    Random rand = Random();
    code = rand.nextInt(900000) + 100000;
    final updateCode = await DatabaseService.to.connection.query('''
      UPDATE `course` SET
      `attendance_code` = ?
      WHERE `id`= ?;
    ''', [code, courseId]);
    //if(updateCode.isNotEmpty){
    List<int> studentIds = []; //obtener los alumnos que asisten a esa clase
    final query = await DatabaseService.to.connection.query(
      '''
    SELECT stn.id FROM schedule sch
    JOIN academic_load al ON sch.id_course = al.id_course
    JOIN student stn ON al.id_student = stn.id 
    WHERE sch.id = ?
    ''',
      [scheduleId],
    );
    if (query.isNotEmpty) {
      for (var row in query) {
        studentIds.add(row[0]);
      }
      for (var studentId in studentIds) {
        //usar el método del modelo attendance (o moverlo ahí)

        final result = await DatabaseService.to.connection.query('''
          INSERT INTO `attendance`
          (`id`,`id_student`,`id_schedule`,`date_time`,`status`)
          VALUES (NULL,?,?,?,?);
          ''', [studentId, scheduleId, DateTime.now().subtract(const Duration(hours:2)).toUtc(), 0]);
        if (result.isEmpty) {
          code = 2;
        }
      }
    }
    return code.toString();
  }

  static Future<List<StudentAttendance>> getAttendanceList(
      int scheduleId, DateTime date) async {
      List<String> targetDay = date.subtract(const Duration(hours:6)).toString().split('.');
      List<String> nextDay = date.add(const Duration(days:1)).subtract(const Duration(hours:6)).toString().split('.');
    List<StudentAttendance>? attendanceList = [];
    final result = await DatabaseService.to.connection.query(
      '''
      SELECT stn.id, stn.name, stn.firstLastName, stn.secondLastName, att.status, att.id FROM schedule sch
      JOIN academic_load al ON sch.id_course = al.id_course
      JOIN student stn ON al.id_student = stn.id 
      LEFT JOIN attendance att ON att.id_student = stn.id AND att.id_schedule = sch.id
      WHERE sch.id = ? AND att.date_time >= ? AND att.date_time < ?
      ORDER BY stn.firstLastName 
      ''',
      [scheduleId, DateFormat('yyyy-MM-dd hh:mm:ss').parse(targetDay[0]).toUtc(), DateFormat('yyyy-MM-dd hh:mm:ss').parse(nextDay[0]).toUtc()],
    );
    if (result.isNotEmpty) {
      for (var row in result) {
        attendanceList.add(StudentAttendance(
            id: row[0],
            name: row[1],
            firstLastName: row[2],
            secondLastName: row[3],
            status: AttendanceStatus.values[row[4]],
            attendanceId: row[5]));
      }
    }
    return attendanceList;
  }

  static Future<void> updateList(List<StudentAttendance> attendanceList) async {
    for (var item in attendanceList) {
      final result = await DatabaseService.to.connection.query('''
      UPDATE `attendance` SET
      `status` = ?
      WHERE `id`= ?;
    ''', [item.status.index, item.attendanceId]);
    }
  }
}


extension AttendanceExtension on AttendanceStatus {
  String get statusName {
    switch (this) {
      case AttendanceStatus.absent:
        return 'Falta';
      case AttendanceStatus.online:
        return 'En línea';
      case AttendanceStatus.present:
        return 'Presente';
    }
  }
}
