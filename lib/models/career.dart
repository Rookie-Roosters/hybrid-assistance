import 'departament.dart';

class Career {
  int _idCareer;
  String _name;
  Departament _departament;

  Career({required int idCareer, required String name, required Departament departament}) : _idCareer = idCareer, _name = name, _departament = departament;
}