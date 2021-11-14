import 'departament.dart';

class Subject {
  int _idSubject;
  String _name;
  Departament _departament;

  Subject({required int idSubject, required String name, required Departament departament}) : _idSubject = idSubject, _name = name, _departament = departament;
}