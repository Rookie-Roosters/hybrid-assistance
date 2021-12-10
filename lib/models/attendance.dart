import 'package:hybrid_assistance/services/database_service.dart';
import 'package:intl/intl.dart';

enum AttendanceStatus { absent, present, online }

class Attendance {
  int id;
  int? student;
  int? schedule;
  DateTime dateTime;
  AttendanceStatus status;

  Attendance({
    required this.id,
    this.student,
    this.schedule,
    required this.dateTime,
    required this.status,
  });

  static Future<bool> checkCode(int scheduleId, int userId) async {
    DateTime today = DateTime.now().toUtc();
    DateTime lastDate = DateTime.now().toUtc();
    final query = await DatabaseService.to.connection.query(
      '''
    SELECT att.date_time FROM attendance att
    JOIN schedule sch ON sch.id = att.id_schedule
    JOIN student stn ON stn.id = att.id_student
    WHERE sch.id = ? AND stn.id = ?
    ORDER BY att.date_time DESC LIMIT 1;
    ''',
      [scheduleId, userId],
    );
    if (query.isNotEmpty) {
      for (var row in query) {
        lastDate = (row[0]);
      }
    }
    if (today.day == lastDate.day) {
      return true; //ya hay codigo
    } else {
      return false; //aun no hay codigo
    }
  }

  static Future<Attendance> getAttendance(int scheduleId, int userId, DateTime date) async {
    List<String> targetDay = date.subtract(const Duration(hours: 6)).toString().split('.');
    List<String> nextDay = date.add(const Duration(days: 1)).subtract(const Duration(hours: 6)).toString().split('.');
    final result = await DatabaseService.to.connection.query(
      '''
    SELECT att.id, att.id_schedule, att.id_student, att.date_time, att.status FROM attendance att
    JOIN schedule sch ON sch.id = att.id_schedule
    JOIN student stn ON stn.id = att.id_student
    WHERE sch.id = ? AND stn.id = ? AND att.date_time >= ? AND att.date_time < ?
    ''',
      [scheduleId, userId, DateFormat('yyyy-MM-dd hh:mm:ss').parse(targetDay[0]).toUtc(), DateFormat('yyyy-MM-dd hh:mm:ss').parse(nextDay[0]).toUtc()],
    );
    if (result.length == 1) {
      for (var row in result) {
        return Attendance(
          id: row[0],
          schedule: row[1],
          student: row[2],
          dateTime: row[3],
          status: AttendanceStatus.values[row[4]],
        );
      }
    }
    throw Exception('No attendance found');
  }

  static Future<String> update(int id, int scheduleId, String code, AttendanceStatus status) async {
    String realCode = '';
    final codeCheck = await DatabaseService.to.connection.query('''
      SELECT cou.attendance_code FROM course cou
      JOIN schedule sch ON cou.id = sch.id_course
      WHERE sch.id = ?
      ''', [scheduleId]);
    if (codeCheck.length == 1) {
      for (var row in codeCheck) {
        realCode = row[0].toString();
      }
    }
    if (realCode == code) {
      final result = await DatabaseService.to.connection.query('''
      UPDATE `attendance` SET
      `status` = ?
      WHERE `id`= ?;
    ''', [status.index, id]);
      return '';
    } else {
      return 'Código incorrecto';
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
