import 'center.dart';

class Departament {
  int _idDepartament;
  Center _center;
  String _name;

  Departament({required int idDepartament, required Center center, required String name}) : _idDepartament = idDepartament, _center = center, _name = name;
}