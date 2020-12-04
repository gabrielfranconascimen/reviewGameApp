package com.example.reviewapptcc.utils

import com.example.reviewapptcc.home.GameModel
import com.google.firebase.firestore.FieldValue
import com.google.firebase.firestore.SetOptions
import com.google.firebase.firestore.ktx.firestore
import com.google.firebase.ktx.Firebase
import java.lang.Exception
import kotlin.collections.HashMap

class RemoteDataGames {

    companion object {
        private val fireStore = Firebase.firestore

        fun getConsole(consoleEnum: ConsoleEnum, callback: (message: String?, games: List<GameModel>? ) -> Unit ) {
            val path = "consoles/${consoleEnum.path}/games"
            fireStore.collection(path).get()
                .addOnSuccessListener { document ->

                    try {
                        if (!document.isEmpty) {
                            val gamesList = document.documents.map {
                                it.toObject(GameModel::class.java) ?: GameModel()
                            }
                            callback.invoke(null, gamesList)
                        }

                    } catch (e: Exception) {
                        e.message?.let {
                            callback.invoke(it, null)
                        }
                    }
                }
                .addOnFailureListener { error ->
                    error.message?.let {
                        callback.invoke(it, null)
                    }
                }
        }

        fun getScore(path: String, callback: (game: GameModel?) -> Unit) {
            fireStore.document(path).get().addOnSuccessListener { documentSnapshot ->
                try {
                    val game = documentSnapshot.toObject(GameModel::class.java)
                    callback.invoke(game)
                }catch (e: Exception) {
                    callback.invoke(null)
                }
            }.addOnFailureListener {
                callback.invoke(null)
            }
        }

        fun updateReviewGame(path: String, valueReview: List<Double>, callback: (message: String?) -> Unit) {
            val map = hashMapOf(
                "score" to valueReview
            )
            fireStore.document(path).update(map as Map<String, Any>)
                .addOnSuccessListener {
                    callback.invoke(null)
                }.addOnFailureListener {error ->
                    error.message?.let {
                        callback.invoke(it)
                    }
                }
        }
    }
}

