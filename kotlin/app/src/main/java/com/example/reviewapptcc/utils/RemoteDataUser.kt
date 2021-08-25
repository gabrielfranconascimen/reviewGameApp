package com.example.reviewapptcc.utils

import android.util.Log
import com.example.reviewapptcc.User
import com.google.firebase.firestore.ktx.firestore
import com.google.firebase.ktx.Firebase

class RemoteDataUser {

    companion object {
        private val firestore = Firebase.firestore
        private val userToken = RemoteAuthUser.getFirebaseToken()

        fun saveUserInfo(user: User,callback: (success: Boolean) -> Unit) {
            firestore.collection("user")
                .document(userToken)
                .set(user)
                .addOnSuccessListener { documentReference ->
                    callback.invoke(true)
                }
                .addOnFailureListener { exception ->
                    Log.e("Error_Set_User", exception.message)
                    callback.invoke(false)
                }

        }

        fun getUserInfo(callback: (user: User?) -> Unit){
            var user: User? = null
            firestore.collection("user")
                .document(userToken)
                .get()
                .addOnSuccessListener { result ->
                    if (result.exists()) {
                        user = User(
                            name = result["name"].toString(),
                            nickname = "",
                            birthDate = ""
                        )
                    }
                    callback.invoke(user)
                }
                .addOnFailureListener { exception ->
                    Log.e("Error_Set_User", exception.message)
                    callback.invoke(user)
                }
        }
    }

}