class Teacher {
  int id;
  String name;
  String lastName;
  String? picture;

  Teacher({
    required this.id,
    required this.name,
    required this.lastName,
    this.picture,
  });
}
