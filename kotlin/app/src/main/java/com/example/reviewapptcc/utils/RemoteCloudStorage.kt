package com.example.reviewapptcc.utils

import com.google.firebase.ktx.Firebase
import com.google.firebase.storage.ktx.storage

class RemoteCloudStorage {

    companion object {
        private val storage = Firebase.storage

        fun getImage(reference: String,callback: (url: String) -> Unit) {
            storage.reference.child(reference).downloadUrl
                .addOnSuccessListener {uri ->
                    callback.invoke(uri.toString())
                }
                .addOnFailureListener {
                    callback.invoke(" ")
                }
        }
    }

}