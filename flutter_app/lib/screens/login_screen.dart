import 'package:flutter/material.dart';
import 'package:flutter_app/utils/AppAssets.dart';
import 'package:flutter_app/utils/AppStrings.dart';
import 'package:flutter_app/utils/firebase/MyFirebaseAuth.dart';
import 'package:flutter_app/utils/Routes.dart';
import 'package:flutter_app/utils/Validator.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class LogInScreen extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  _validateFormLogin(BuildContext context) {
    if (emailController.text.isEmpty && passwordController.text.isEmpty) {
      _showDialog(context, "Por favor preencher os campos e-mail e senha!");
      return false;
    } else if (!emailController.text.isValidEmail) {
      _showDialog(context, "E-mail inválido");
      return false;
    }
    return true;
  }

  _showDialog(BuildContext context, String message) {
    showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: const Text("Atenção"),
              content: Text(message),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context, 'Ok'),
                    child: const Text("Ok"))
              ],
            ));
  }

  _userLogged(BuildContext context, bool isUserLogged) {
    if (isUserLogged)
      Navigator.pushNamedAndRemoveUntil(context, Routes.GameListScreen, (routes) => false);
    else
      _showDialog(context, "Falha no login, por favor tentar novamente!");
  }

  @override
  Widget build(BuildContext context) {
    final double widthScreen = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.LogIn),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text(
                AppStrings.NameApp,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 46, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 8),
              width: widthScreen * 0.7,
              child: Image.asset(AppAssets.iconApp),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: AppStrings.Email,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: AppStrings.Password)),
            ),
            Container(
              width: widthScreen * 0.7,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        child: Text(AppStrings.Submit),
                        onPressed: () async {
                          if (_validateFormLogin(context)) {
                            Future<bool> auth = Authentication.loginWithEmail(
                                emailController.text, passwordController.text);
                            auth.then((value) => _userLogged(context, value));
                          }
                        }),
                    const Text(AppStrings.Or),
                    SignInButton(
                      Buttons.Google,
                      onPressed: () async {
                        Future<bool> auth = Authentication.signInWithGoogle();
                        auth.then((value) => _userLogged(context, value));
                      },
                    ),
                  ]),
            )
          ]),
        ),
      ),
    );
  }
}
