package com.example.reviewapptcc.detail

import android.graphics.Typeface
import android.graphics.Typeface.BOLD
import android.graphics.Typeface.BOLD_ITALIC
import android.net.Uri
import android.text.Spannable
import android.text.SpannableString
import android.text.style.StyleSpan
import com.example.reviewapptcc.home.GameModel
import com.example.reviewapptcc.utils.RemoteDataGames
import java.math.RoundingMode
import kotlin.math.roundToInt

class GameDetailPresenter(private val view: GameDetailContract.View): GameDetailContract.Presenter {

    override fun visitWebSite(url: String) {
        if (url.startsWith("https://")) {
            view.goToWebSite(Uri.parse(url))
        } else {
            view.showError("Sorry, don't possible visited website.")
        }
    }

    override fun updateGameReview(game: GameModel, note: Float) {
        val notes = arrayListOf<Double>()
        notes.addAll(game.score)
        notes.add(note.toDouble())

        RemoteDataGames.updateReviewGame(game.gameReference, notes) { message ->
            if (message.isNullOrBlank()) {
                averageNote(game.score)
                RemoteDataGames.getScore(game.gameReference) {
                    if (it != null) {
                        averageNote(it.score)
                        view.disableReview()
                    } else {
                        view.showError("Problem with send review, Try again!")
                    }
                }
            } else {
                view.showError(message)
            }
        }
    }

    override fun averageNote(notes: List<Double>) {
        val note = notes.average().toBigDecimal().setScale(1, RoundingMode.UP).toString()
        val boldSpan = StyleSpan(BOLD)
        val spannableContent = SpannableString("Ratting: $note")
        spannableContent.setSpan(boldSpan,
            (spannableContent.length - note.length - 1),
            spannableContent.length,
            Spannable.SPAN_EXCLUSIVE_EXCLUSIVE)

        view.showRating(spannableContent)
    }


}