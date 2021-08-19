import 'package:flutter/material.dart';
import 'package:flutter_app/app/components/my_text_form_field.dart';
import 'package:flutter_app/app/controllers/login_controller.dart';
import 'package:flutter_app/utils/AppAssets.dart';
import 'package:flutter_app/utils/AppDimens.dart';
import 'package:flutter_app/utils/AppStrings.dart';
import 'package:flutter_app/utils/Routes.dart';
import 'package:flutter_app/utils/AppExtensions.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class LoginView extends StatelessWidget {
  final LoginController _loginController = LoginController(
    login: TextEditingController(),
    password: TextEditingController(),
  );

  _validateLogin(BuildContext context, String? errorMessage) {
    if (errorMessage != null) {
      context.showMyDialog(errorMessage);
    } else {
      Navigator.pushNamedAndRemoveUntil(
        context,
        Routes.GameListView,
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final double widthComponentSize = MediaQuery.of(context).size.width * 0.7;

    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.LogIn),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(top: AppDimens.sMediumMargin),
                child: Text(
                  AppStrings.NameApp,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: AppDimens.bigLargeText,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: AppDimens.sMediumMargin),
                width: widthComponentSize,
                child: Image.asset(AppAssets.iconApp),
              ),
              MyTextFormField(
                textController: _loginController.login,
                hint: AppStrings.Email,
                keyboardType: TextInputType.emailAddress,
              ),
              MyTextFormField(
                textController: _loginController.password,
                hint: AppStrings.Password,
                isObscureText: true,
              ),
              Container(
                padding: const EdgeInsets.only(top: AppDimens.sMediumMargin),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: widthComponentSize,
                      child: ElevatedButton(
                        child: Text(AppStrings.Submit),
                        onPressed: () async {
                          await _loginController.loginWithEmailPassword().then(
                              (errorLogin) {
                                _validateLogin(context, errorLogin?.message);
                              });
                        },
                      ),
                    ),
                    const Text(AppStrings.Or),
                    Container(
                      width: widthComponentSize,
                      child: SignInButton(
                        Buttons.Google,
                        onPressed: () async {
                          await _loginController
                              .loginWithGoogle()
                              .then((errorLogin) {
                            _validateLogin(context, errorLogin?.message);
                          });
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
