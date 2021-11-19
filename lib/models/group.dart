import 'career.dart';

enum Turn { morning, evening }

class Group {
  int id;
  Career career;
  String generation;
  String letter;
  Turn turn;

  Group({
    required this.id,
    required this.career,
    required this.generation,
    required this.letter,
    required this.turn,
  });
}
