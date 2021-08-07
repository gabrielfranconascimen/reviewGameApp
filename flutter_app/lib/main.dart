import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/app/views/login_view.dart';
import 'package:flutter_app/app/views/signup_view.dart';
import 'package:flutter_app/screens/game_detail_screen.dart';
import 'package:flutter_app/screens/game_list_screen.dart';
import 'package:flutter_app/app/views/welcome_view.dart';
import 'package:flutter_app/utils/AppColors.dart';
import 'package:flutter_app/utils/AppStrings.dart';
import 'package:flutter_app/utils/Routes.dart';
import 'package:flutter_app/utils/firebase/MyFirebaseAuth.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primaryColor: AppColors.primaryColor,
          textButtonTheme: TextButtonThemeData(
            style: ElevatedButton.styleFrom(
                textStyle: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
          ),
          textTheme: TextTheme(
              button:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
      home: FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              body: SafeArea(
                child: Container(
                    alignment: Alignment.center,
                    child: Text(ErrorStrings.MessageErrorOpenApp)),
              ),
            );
          }

          if (snapshot.hasData) {
            if (Authentication.userLogged()) {
              return GameListScreen();
            } else {
              return WelcomeView();
            }
          }

          return Container(
            alignment: Alignment.center,
            child: CircularProgressIndicator(),
          );
        },
      ),
      routes: {
        Routes.WelcomeView: (context) => WelcomeView(),
        Routes.LoginView: (context) => LoginView(),
        Routes.SignUpView: (context) => SignUpView(),
        Routes.GameListView: (context) => GameListScreen(),
        Routes.GameDetailView: (context) => GameDetailScreen(),
      },
    );
  }
}
