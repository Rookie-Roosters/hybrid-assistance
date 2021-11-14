import 'student.dart';
import 'class.dart';

class AcademicLoad {
  int _idAcademicLoad;
  Student _student;
  CClass _cclass;

  AcademicLoad({required int idAcademicLoad, required CClass cclass, required Student student}) : _idAcademicLoad = idAcademicLoad, _student = student, _cclass = cclass;
}