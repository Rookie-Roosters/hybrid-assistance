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
    final RegExp regExp = RegExp(r"[a-zA-ZáéíóúüñÁÉÍÓÚÜÑ ]{3,100}");
    return value != null ? regExp.hasMatch(value) : false;
  }

  bool validateGenericName(String? value) {
    final RegExp regExp = RegExp(r"[a-zA-ZáéíóúüñÁÉÍÓÚÜÑ ]{3,50}");
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

  bool validateGeneration(String? value) {
    final RegExp regExp = RegExp(r"^20\d\d-20\d\d$");
    return value != null ? regExp.hasMatch(value) : false;
  }

  bool validateLetter(String? value) {
    final RegExp regExp = RegExp(r"^[A-Z]$");
    return value != null ? regExp.hasMatch(value) : false;
  }

  bool validateTime(String? value) {
    final RegExp regExp = RegExp(r"^([0-1]?[0-9]|2[0-3]):[0-5][0-9]$");
    return value != null ? regExp.hasMatch(value) : false;
  }
}
