import 'package:flutter/material.dart';
import 'package:flutter_app/utils/AppAssets.dart';
import 'package:flutter_app/utils/Routes.dart';
import 'package:flutter_app/utils/Validator.dart';
import 'package:flutter_app/utils/Utils.dart';
import 'package:flutter_app/utils/AppStrings.dart';
import 'package:flutter_app/utils/firebase/MyFirebaseAuth.dart';

class SignUpScreen extends StatelessWidget {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _validateForm(BuildContext context) {
    if (_nameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _confirmPasswordController.text.isEmpty) {
      showMyDialog(context, "Todos os campos são obrigatórios.");
      return false;
    }
    if (!_emailController.text.isValidEmail) {
      showMyDialog(context, "Por favor insira um email válido.");
      return false;
    }
    if (_passwordController.text != _confirmPasswordController.text) {
      showMyDialog(context, "As senhas devem ser iguais.");
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(AppStrings.SignUp),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(child: Image.asset(AppAssets.iconApp)),
                    Expanded(
                      child: Text(
                        AppStrings.NameApp,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 34),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: TextFormField(
                          controller: _nameController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: AppStrings.Name)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: AppStrings.Email)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: TextFormField(
                          controller: _passwordController,
                          keyboardType: TextInputType.emailAddress,
                          obscureText: true,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: AppStrings.Password)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: TextFormField(
                        controller: _confirmPasswordController,
                        obscureText: true,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: AppStrings.ConfirmPassword),
                      ),
                    )
                  ],
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  padding: const EdgeInsets.only(top: 16),
                  child: ElevatedButton(
                    child: Text(AppStrings.Submit),
                    onPressed: () async {
                      if (_validateForm(context)) {
                        Future<bool> createUser =
                            Authentication.signInWithEmail(
                                _emailController.text,
                                _passwordController.text);

                        createUser.then((value) => {
                              if (value)
                                Navigator.pushNamedAndRemoveUntil(context,
                                    Routes.GameListScreen, (routes) => false)
                              else
                                showMyDialog(context,
                                    "Falha ao criar a conta, por favor tentar novamente!")
                            });
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
