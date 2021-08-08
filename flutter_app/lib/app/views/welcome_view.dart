import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_app/utils/AppAssets.dart';
import 'package:flutter_app/utils/AppDimens.dart';
import 'package:flutter_app/utils/AppStrings.dart';
import 'package:flutter_app/utils/Routes.dart';

class WelcomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final widthWindow = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
          child: Container(
              width: widthWindow,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(AppAssets.background), fit: BoxFit.cover),
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
                          margin: const EdgeInsets.symmetric(
                              horizontal: AppDimens.sMediumMargin),
                          alignment: Alignment.center,
                          child: const Text(
                            AppStrings.WelcomeViewTitle,
                            style: TextStyle(
                                fontSize: AppDimens.bigLargeText,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Container(
                        width: widthWindow,
                        margin: const EdgeInsets.symmetric(
                            horizontal: AppDimens.mediumMargin),
                        child: ElevatedButton(
                            child: const Text(AppStrings.LogIn),
                            onPressed: () => Navigator.pushNamed(
                                  context,
                                  Routes.LoginView,
                                )),
                      ),
                      Container(
                        width: widthWindow,
                        margin: const EdgeInsets.symmetric(
                          vertical: AppDimens.sMediumMargin,
                          horizontal: AppDimens.mediumMargin,
                        ),
                        child: ElevatedButton(
                            child: const Text(AppStrings.SignUp),
                            onPressed: () => Navigator.pushNamed(
                                context, Routes.SignUpView)),
                      )
                    ],
                  ),
                ),
              ))),
    );
  }
}
