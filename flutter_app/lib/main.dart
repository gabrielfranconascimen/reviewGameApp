import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/game_detail_screen.dart';
import 'package:flutter_app/screens/game_list_screen.dart';
import 'package:flutter_app/screens/login_screen.dart';
import 'package:flutter_app/screens/signup_screen.dart';
import 'package:flutter_app/screens/welcome_page.dart';
import 'package:flutter_app/utils/AppColors.dart';
import 'package:flutter_app/utils/Routes.dart';
import 'package:flutter_app/utils/firebase/MyFirebaseAuth.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  String _getFirstPage() {
    if(Authentication.userLogged()) {
      return Routes.GameListScreen;
    } else {
      return Routes.firstPage;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          if(snapshot.hasError) {
            // todo return screen error
          }

          if(snapshot.connectionState == ConnectionState.done) {
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
              initialRoute: _getFirstPage(),
              home: WelcomePage(),
              routes: {
                Routes.firstPage: (context) => WelcomePage(),
                Routes.LoginScreen: (context) => LogInScreen(),
                Routes.SignUpScreen: (context) => SignUpScreen(),
                Routes.GameListScreen: (context) => GameListScreen(),
                Routes.GameDetailScreen: (context) => GameDetailScreen(),
              },
            );
          }

          return Container(
            child: CircularProgressIndicator(),
          );
        }
    );
  }
}
