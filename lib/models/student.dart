class Student {
  int id;
  String name;
  String firstLastName;
  String secondLastName;
  String? nickname;
  String? picture;

  Student({
    required this.id,
    required this.name,
    required this.firstLastName,
    required this.secondLastName,
    this.nickname,
    this.picture,
  });
}
