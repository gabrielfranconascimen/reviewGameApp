import 'package:flutter/cupertino.dart';
import 'package:flutter_app/app/models/game_model.dart';
import 'package:flutter_app/app/repositories/games_repository.dart';
import 'package:flutter_app/utils/AppExtensions.dart';
import 'package:flutter_app/utils/firebase/MyFirebaseFirestore.dart';

class GamesController {
  List<GameModel> _games = [];
  late ConsolesType _selectedConsole;
  final GamesRepository _repository = GamesRepository();
  final state = ValueNotifier<GamesState>(GamesState.start);

  void init(ConsolesType consolesType) {
    _selectedConsole = consolesType;
    fetchData();
  }

  void updateSelectedConsoleType(ConsolesType consolesType) async {
    _selectedConsole = consolesType;
    fetchData();
  }

  Future fetchData() async {
    state.value = GamesState.loading;
    try {
      _games = await _repository.fetchGames(_selectedConsole.getConsoleWithType());
      state.value = GamesState.success;
    } catch(exception) {
      state.value = GamesState.error;
    }
  }

  Future<String> getImage(GameModel gameModel) async {
    return await _repository
        .getImageUrlFromStorage(gameModel.thumbnail)
        .then((value) => value);
  }

  int getGameSize() {
    return _games.length;
  }

  GameModel getGameWithIndex(int index) {
    return _games[index];
  }
}

enum GamesState {
  start, loading, success, error
}