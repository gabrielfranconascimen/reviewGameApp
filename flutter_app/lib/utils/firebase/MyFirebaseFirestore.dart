import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/app/models/game_model.dart';

enum ConsolesType { playstation, xbox, nintendo, computer }

class MyFirebaseFirestore {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CollectionReference<GameModel> getCollectionReferenceGames(String console) {
    return _firestore
        .collection("consoles/$console/games/")
        .withConverter<GameModel>(
        fromFirestore: (snapshot, _) => GameModel.fromJson(snapshot.data()!),
        toFirestore: (game, _) => game.toJson());
  }
}