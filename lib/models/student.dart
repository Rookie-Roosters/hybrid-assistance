class Student {
  int id;
  String name;
  String lastName;
  String? nickname;
  String? picture;

  Student({
    required this.id,
    required this.name,
    required this.lastName,
    this.nickname,
    this.picture,
  });
}
