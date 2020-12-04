package com.example.reviewapptcc.utils

import com.google.firebase.auth.FirebaseAuth

class RemoteAuthUser {
    companion object {
        private val auth = FirebaseAuth.getInstance()

        fun isLogged(): Boolean {
            return auth.currentUser != null
        }

        fun getFirebaseToken(): String {
            return auth.currentUser?.uid ?: ""
        }

        fun logoutUser() {
            auth.signOut()
        }

    }
}