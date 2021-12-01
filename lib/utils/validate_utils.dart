class ValidateUtils {
  bool validateId6(String? value) {
    final RegExp regExp = RegExp(r"^\d{6}$");
    return value != null ? regExp.hasMatch(value) : false;
  }

  bool validateId5(String? value) {
    final RegExp regExp = RegExp(r"^\d{5}$");
    return value != null ? regExp.hasMatch(value) : false;
  }

  bool validateName(String? value) {
    final RegExp regExp = RegExp(r"[a-zA-ZáéíóúüÁÉÍÓÚÜ ]{3,100}");
    return value != null ? regExp.hasMatch(value) : false;
  }

  bool validateGenericName(String? value) {
    final RegExp regExp = RegExp(r"[a-zA-ZáéíóúüÁÉÍÓÚÜ ]{3,50}");
    return value != null ? regExp.hasMatch(value) : false;
  }

  bool validatePassword(String? value) {
    final RegExp regExp = RegExp(r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$");
    return value != null ? regExp.hasMatch(value) : false;
  }

  bool validateNumber(String? value) {
    final RegExp regExp = RegExp(r"\d");
    return value != null ? regExp.hasMatch(value) : false;
  }
}