package com.example.reviewapptcc.singIn

import com.example.reviewapptcc.common.CommonContract

interface SigInContract {

    interface View : CommonContract.View {
        fun launchHome()
    }

    interface Presenter : CommonContract.Presenter {
        fun submitForm(siginRequest: SiginRequest)
    }
}