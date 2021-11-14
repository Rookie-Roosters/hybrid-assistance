import 'group.dart';

class Student {
  int _idStudent;
  String _name;
  String _firstLastName;
  String _secondLastName;
  String _photo;
  String _nickname;

  Student(
      {required int idStudent,
      required String name,
      required String firstLastName,
      required String secondLastName,
      required String photo,
      required String nickname})
      : _idStudent = idStudent,
        _name = name,
        _firstLastName = firstLastName,
        _secondLastName = secondLastName,
        _photo = photo,
        _nickname = nickname;
  

}