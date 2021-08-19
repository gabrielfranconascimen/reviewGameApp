import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app/app/controllers/games_controller.dart';
import 'package:flutter_app/app/models/game_model.dart';
import 'package:flutter_app/utils/AppDimens.dart';
import 'package:flutter_app/utils/AppStrings.dart';
import 'package:flutter_app/utils/Routes.dart';
import 'package:flutter_app/utils/firebase/MyFirebaseAuth.dart';
import 'package:flutter_app/utils/firebase/MyFirebaseFirestore.dart';

class GamesView extends StatefulWidget {
  final Map<int, Widget> segmentControlItems = <int, Widget>{
    0: Text(AppStrings.Playstation),
    1: Text(AppStrings.Xbox),
    2: Text(AppStrings.Switch),
    3: Text(AppStrings.Computer)
  };

  @override
  _GamesViewState createState() => _GamesViewState();
}

class _GamesViewState extends State<GamesView> {
  int selectedIndex = 0;
  final GamesController _gamesController = GamesController();

  @override
  void initState() {
    super.initState();
    _gamesController.init(ConsolesType.values[selectedIndex]);
  }

  void _updateSelectedIndex(int newIndex) {
    setState(() {
      selectedIndex = newIndex;
      _gamesController
          .updateSelectedConsoleType(ConsolesType.values[selectedIndex]);
    });
  }

  void onClickItemListener(int index) {
    GameModel model = _gamesController.getGameWithIndex(index);
    Navigator.pushNamed(context, Routes.GameDetailView, arguments: model);
  }

  _stateManagement(GamesState state) {
    switch (state) {
      case GamesState.start:
        return Container();
      case GamesState.loading:
        return Center(child: CircularProgressIndicator());
      case GamesState.success:
        return _newTes();
      case GamesState.error:
        return Center(child: Text(ErrorStrings.FailedFetchGames));
    }
  }

  _newTes() {
    return GridView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(
          horizontal: AppDimens.sMediumMargin,
          vertical: AppDimens.mediumMargin),
      itemCount: _gamesController.getGameSize(),
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (context, index) {
        GameModel game = _gamesController.getGameWithIndex(index);
        return Container(
          padding: const EdgeInsets.only(top: AppDimens.smallMargin),
          child: Stack(
            alignment: AlignmentDirectional.bottomCenter,
            clipBehavior: Clip.hardEdge,
            children: [
              FutureBuilder(
                  future: _gamesController.getImage(game),
                  builder: (context, AsyncSnapshot<String> snapshot) {
                    if (snapshot.hasData) {
                      return Image.network(
                        snapshot.data!,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      );
                    } else {
                      return Container(
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
              Container(
                alignment: Alignment.center,
                width: double.infinity,
                height: 42.0,
                color: Colors.black.withOpacity(0.75),
                child: Text(
                  game.name,
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
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
      body: Column(
        children: [
          Container(
            alignment: Alignment.topCenter,
            padding: const EdgeInsets.only(
                top: AppDimens.sMediumMargin, bottom: AppDimens.sMediumMargin),
            child: CupertinoSegmentedControl(
              children: widget.segmentControlItems,
              groupValue: selectedIndex,
              onValueChanged: (int index) {
                _updateSelectedIndex(index);
              },
            ),
          ),
          Expanded(
            child: AnimatedBuilder(
              animation: _gamesController.state,
              builder: (context, child) {
                return _stateManagement(_gamesController.state.value);
              },
            ),
          )
        ],
      ),
    );
  }
}
