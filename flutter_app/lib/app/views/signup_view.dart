import 'package:flutter/material.dart';
import 'package:flutter_app/app/components/my_text_form_field.dart';
import 'package:flutter_app/app/controllers/signup_controller.dart';
import 'package:flutter_app/utils/AppAssets.dart';
import 'package:flutter_app/utils/AppDimens.dart';
import 'package:flutter_app/utils/AppStrings.dart';
import 'package:flutter_app/utils/AppExtensions.dart';
import 'package:flutter_app/utils/Routes.dart';

class SignUpView extends StatelessWidget {

  final SignUpController _signUpController = SignUpController(
      nameController: TextEditingController(),
      emailController: TextEditingController(),
      passwordController: TextEditingController(),
      confirmPasswordController: TextEditingController());

  @override
  Widget build(BuildContext context) {
    final widthComponentSize = MediaQuery.of(context).size.width * 0.7;
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.SignUp),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding:
              const EdgeInsets.symmetric(horizontal: AppDimens.xMediumMargin),
          child: Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Expanded(child: Image.asset(AppAssets.iconApp)),
                Expanded(
                    child: Text(AppStrings.NameApp,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: AppDimens.largeText))),
              ]),
              Column(children: [
                MyTextFormField(
                    textController: _signUpController.nameController,
                    hint: AppStrings.Name),
                MyTextFormField(
                    textController: _signUpController.emailController,
                    hint: AppStrings.Email,
                    keyboardType: TextInputType.emailAddress),
                MyTextFormField(
                    textController: _signUpController.passwordController,
                    hint: AppStrings.Password,
                    isObscureText: true),
                MyTextFormField(
                    textController: _signUpController.confirmPasswordController,
                    hint: AppStrings.ConfirmPassword,
                    isObscureText: true),
              ]),
              Container(
                width: widthComponentSize,
                padding: const EdgeInsets.only(top: AppDimens.xMediumMargin),
                child: ElevatedButton(
                  child: Text(AppStrings.Submit),
                  onPressed: () async {
                    _signUpController.sigUpUser().then((errorLogin) {
                      if (errorLogin != null) {
                        context.showMyDialog(errorLogin.message);
                      } else {
                        Navigator.pushNamedAndRemoveUntil(
                            context, Routes.GameListView, (route) => false);
                      }
                    });
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
