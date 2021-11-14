import 'group.dart';
import 'subject.dart';
import 'teacher.dart';

class CClass {
  int _idCClass;
  Group _group;
  Subject _subject;
  Teacher _teacher;
  int _code;

  CClass({required int idCClass, required Group group, required Subject subject, required Teacher teacher, required int code}) : _idCClass = idCClass, _group = group, _subject = subject, _teacher = teacher, _code = code;
}