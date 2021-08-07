import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/utils/AppAssets.dart';
import 'package:flutter_app/utils/AppStrings.dart';
import 'package:flutter_app/utils/Routes.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double widthScreen = MediaQuery.of(context).size.width;

    return Scaffold(
        body: SafeArea(
            child: Container(
                width: widthScreen,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(AppAssets.background),
                      fit: BoxFit.cover),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
                  child: Container(
                    color: Colors.black.withOpacity(0.3),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(
                          fit: FlexFit.tight,
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                            alignment: Alignment.center,
                            child: const Text(
                              AppStrings.WelcomePageTitle,
                              style:
                                  TextStyle(fontSize: 46, color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        Container(
                          width: widthScreen,
                          margin: const EdgeInsets.symmetric(horizontal: 12),
                          child: ElevatedButton(
                              child: const Text(
                                AppStrings.LogIn,
                              ),
                              onPressed: () => Navigator.pushNamed(
                                  context, Routes.LoginView)),
                        ),
                        Container(
                          width: widthScreen,
                          margin: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 12),
                          child: ElevatedButton(
                              child: const Text(
                                AppStrings.SignUp,
                              ),
                              onPressed: () => Navigator.pushNamed(
                                  context, Routes.SignUpView)),
                        )
                      ],
                    ),
                  ),
                ))));
  }
}
