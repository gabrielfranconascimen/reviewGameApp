import 'package:flutter/material.dart';
import 'package:flutter_app/app/components/dialog_rating.dart';
import 'package:flutter_app/app/models/game_model.dart';
import 'package:flutter_app/utils/AppDimens.dart';
import 'package:flutter_app/utils/AppStrings.dart';
import 'package:flutter_app/utils/AppExtensions.dart';
import 'package:flutter_app/utils/Routes.dart';
import 'package:flutter_app/utils/firebase/MyFirebaseAuth.dart';
import 'package:url_launcher/url_launcher.dart';

class GameDetailView extends StatelessWidget {

  _showReviewDialog(BuildContext context) {
    return showDialog(context: context, builder: (context) {
      return AlertDialog(
        content: DialogRating(),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(), child: Text("Send")),
          TextButton(onPressed: () => Navigator.of(context).pop(), child: Text("Cancel")),
        ],
      );
    }).then((value) => print("Valor do Rating $value"));
  }

  @override
  Widget build(BuildContext context) {
    final widthWindow = MediaQuery.of(context).size.width;
    final gameModel = ModalRoute.of(context)?.settings.arguments as GameModel;

    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.NameApp),
        actions: [
          Container(
            padding: const EdgeInsets.only(right: AppDimens.sMediumMargin),
            child: TextButton(
              style: TextButton.styleFrom(primary: Colors.white),
              child: Text(AppStrings.Logout),
              onPressed: () {
                Authentication.signOut();
                Navigator.pushNamedAndRemoveUntil(
                    context, Routes.WelcomeView, (route) => false);
              },
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: widthWindow,
              alignment: Alignment.center,
              child: Image.network(gameModel.image),
            ),
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppDimens.mediumMargin),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                        top: AppDimens.xLargeMargin,
                        bottom: AppDimens.xLargeMargin),
                    width: widthWindow,
                    alignment: Alignment.centerRight,
                    child: Text(
                        // "Rating: ${gameModel.getRating().toStringAsFixed(2)}"
                      ""
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(bottom: AppDimens.xLargeMargin),
                    child: Text(gameModel.description),
                  ),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () => _showReviewDialog(context),
                        child: Text(AppStrings.ReviewGame),
                      ),
                      Spacer(),
                      ElevatedButton(
                        onPressed: () async {
                          if (await canLaunch(gameModel.link))
                            await launch(gameModel.link, forceSafariVC: false);
                          else
                            context
                                .showMyDialog(ErrorStrings.FailedOpenBrowser);
                        },
                        child: Text(AppStrings.OfficialSite),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
