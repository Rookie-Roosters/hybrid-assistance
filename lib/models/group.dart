import 'career.dart';

enum Turn { morning, evening }

class Group {
  int _idGroup;
  Career _career;
  int _generation;
  String _letter;
  Turn _turn;

  Group({required int idGroup, required Career career, required int generation, required String letter, required Turn turn}) : _idGroup = idGroup, _career = career, _generation = generation, _letter = letter, _turn = turn;
}