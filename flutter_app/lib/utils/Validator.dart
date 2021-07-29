extension exString on String {
  bool get isValidEmail {
    final emailRegEx = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return emailRegEx.hasMatch(this);
  }
}