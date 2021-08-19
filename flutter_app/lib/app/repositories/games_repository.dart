import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/app/models/game_model.dart';
import 'package:flutter_app/utils/firebase/MyFirebaseFirestore.dart';
import 'package:flutter_app/utils/firebase/MyFirebaseStorage.dart';

class GamesRepository {
  final MyFirebaseFirestore _firestore = MyFirebaseFirestore();
  final MyFirebaseStorage _storage = MyFirebaseStorage();

  Future<List<GameModel>> fetchGames(String selectedConsole) async {
    CollectionReference<GameModel> gameReference =
        _firestore.getCollectionReferenceGames(selectedConsole);

    return await gameReference.get().then((snapshot) =>
        snapshot.docs.map((gameItemQuery) => gameItemQuery.data()).toList());
  }

  Future<String> getImageUrlFromStorage(String path) async {
    return await _storage.getUrlImage(path).then((value) => value);
  }
}
