import 'classroom.dart';
import 'class.dart';

enum WeekDay {
  none,
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday,
  sunday
}

class Schedule {
  int _idSchedule;
  WeekDay _weekDay;
  int _startHour;
  int _endHour;
  ClassRoom _classRoom;
  CClass _cclass;

  Schedule(
      {required int idSchedule,
      required WeekDay weekDay,
      required int startHour,
      required int endHour,
      required ClassRoom classRoom,
      required CClass cclass})
      : _idSchedule = idSchedule,
        _weekDay = weekDay,
        _startHour = startHour,
        _endHour = endHour,
        _classRoom = classRoom,
        _cclass = cclass;
}
