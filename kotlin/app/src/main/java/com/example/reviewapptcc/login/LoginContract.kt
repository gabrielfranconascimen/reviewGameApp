package com.example.reviewapptcc.login

import android.content.Context
import android.content.Intent
import com.example.reviewapptcc.common.CommonContract

interface LoginContract {

    interface View : CommonContract.View {
        fun launchHome()
        fun loginError(message: String)
        fun loginError(idMessage: Int)

    }

    interface Presenter : CommonContract.Presenter {
        fun submitForm(email: String, password: String)
        fun loginWithGoogle(data: Intent?)
        fun createGoogleClient(context: Context) : Intent
    }
}