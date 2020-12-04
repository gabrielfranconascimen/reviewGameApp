package com.example.reviewapptcc.detail

import android.content.Context
import android.content.Intent
import android.net.Uri
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.text.SpannableString
import androidx.core.os.bundleOf
import com.example.reviewapptcc.R
import com.example.reviewapptcc.common.CommonActivity
import com.example.reviewapptcc.home.GameModel
import com.example.reviewapptcc.utils.RemoteCloudStorage
import com.squareup.picasso.Picasso
import kotlinx.android.synthetic.main.activity_game_detail.*

class GameDetailActivity : CommonActivity(), GameDetailContract.View {

    private val _presenter = GameDetailPresenter(this)
    private lateinit var gameModel: GameModel

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_game_detail)

        gameModel = intent.getParcelableExtra(EXTRA_GAME) ?: GameModel()
    }

    override fun onResume() {
        super.onResume()
        RemoteCloudStorage.getImage(gameModel.image) {
            Picasso.get()
                .load(it)
                .into(imgBanner)
        }

        tvGameName.text = gameModel.name
        tvGameDescription.text = gameModel.description
        btnSite.setOnClickListener {
            _presenter.visitWebSite(gameModel.link)
        }

        btnReviewGame.setOnClickListener {
            ReviewDialogFragment.getInstance {note ->
                _presenter.updateGameReview(gameModel, note)
            }.show(supportFragmentManager.beginTransaction(), "gameReview")
        }

        _presenter.averageNote(gameModel.score)
    }

    companion object {
        const val EXTRA_GAME = "game_extra"
        fun getInstance(context: Context, game: GameModel): Intent {
            return Intent(context, GameDetailActivity::class.java).apply {
                putExtra(EXTRA_GAME, game)
            }
        }
    }

    override fun goToWebSite(uri: Uri) {
        val intent = Intent(Intent.ACTION_VIEW, uri)
        startActivity(intent)
    }

    override fun showRating(rating: SpannableString) {
        tvRatingGame.text = rating
    }

    override fun disableReview() {
        btnReviewGame.isEnabled = false
    }
}