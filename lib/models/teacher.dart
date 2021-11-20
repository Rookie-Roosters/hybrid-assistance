class Teacher {
  int id;
  String name;
  String firstLastName;
  String secondLastName;
  String? picture;

  Teacher({
    required this.id,
    required this.name,
    required this.firstLastName,
    required this.secondLastName,
    this.picture,
  });
}
