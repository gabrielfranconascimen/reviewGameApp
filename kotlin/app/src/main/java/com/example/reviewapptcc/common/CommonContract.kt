package com.example.reviewapptcc.common


interface CommonContract {

    interface View {
        fun showLoading()
        fun hiddenLoading()
        fun showError(messageResource: Int)
        fun showError(message: String)
    }

    interface Presenter {

    }
}