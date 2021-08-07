import 'package:flutter/material.dart';
import 'package:flutter_app/app/models/base/error_model.dart';
import 'package:flutter_app/utils/AppStrings.dart';
import 'package:flutter_app/utils/Validator.dart';
import 'package:flutter_app/utils/firebase/MyFirebaseAuth.dart';

class SignUpController {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  SignUpController(
      {required this.nameController,
      required this.emailController,
      required this.passwordController,
      required this.confirmPasswordController});

  Future<ErrorModel?> sigUpUser() async {
    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      return ErrorModel(message: ErrorStrings.RequiredAllFields);
    }
    if (!emailController.text.isValidEmail) {
      return ErrorModel(message: ErrorStrings.InvalidEmail);
    }
    if (passwordController.text != confirmPasswordController.text) {
      return ErrorModel(message: ErrorStrings.InvalidConfirmPassword);
    }

    return await Authentication.signInWithEmail(
            emailController.text, passwordController.text)
        .then((successLogin) {
      if (successLogin) {
        return null;
      } else {
        return ErrorModel(message: ErrorStrings.FailedToSignUp);
      }
    });
  }
}
