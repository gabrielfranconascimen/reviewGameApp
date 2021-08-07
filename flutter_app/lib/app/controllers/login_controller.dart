import 'package:flutter/cupertino.dart';
import 'package:flutter_app/app/models/base/error_model.dart';
import 'package:flutter_app/utils/AppStrings.dart';
import 'package:flutter_app/utils/firebase/MyFirebaseAuth.dart';
import 'package:flutter_app/utils/Validator.dart';

class LoginController {
  final TextEditingController login;
  final TextEditingController password;

  @override
  LoginController({required this.login, required this.password});

  Future<ErrorModel?> loginWithEmailPassword() async {
    if (login.text.isEmpty) {
      return ErrorModel(message: ErrorStrings.EmptyEmailField);
    }
    if (password.text.isEmpty) {
      return ErrorModel(message: ErrorStrings.EmptyPasswordField);
    }
    if (!login.text.isValidEmail) {
      return ErrorModel(message: ErrorStrings.InvalidEmail);
    }

    return await Authentication.loginWithEmail(
        login.text, password.text).then((successLogin) {
          print("Entrou no response do login");
          print(successLogin);
          if (successLogin) {
            return null;
          } else {
            return ErrorModel(message: ErrorStrings.FailedToLogin);
          }
    });
  }

  Future<ErrorModel?> loginWithGoogle() async{
    return await Authentication.loginWithGoogle().then((successLogin) {
      if(successLogin) {
        return null;
      } else {
        return ErrorModel(message: ErrorStrings.FailedToLogin);
      }
    });
  }

}