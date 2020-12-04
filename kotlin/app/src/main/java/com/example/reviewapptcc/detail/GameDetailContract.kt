package com.example.reviewapptcc.detail

import android.net.Uri
import android.text.Spannable
import android.text.SpannableString
import com.example.reviewapptcc.common.CommonContract
import com.example.reviewapptcc.home.GameModel

interface GameDetailContract: CommonContract {

    interface View: CommonContract.View {
        fun goToWebSite(uri: Uri)
        fun showRating(rating: SpannableString)
        fun disableReview()
    }

    interface Presenter: CommonContract.Presenter {
        fun visitWebSite(url: String)
        fun updateGameReview(game: GameModel, note: Float)
        fun averageNote(notes: List<Double>)
    }
}