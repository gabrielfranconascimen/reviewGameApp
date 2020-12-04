package com.example.reviewapptcc.home

import android.content.Intent
import android.os.Bundle
import android.widget.ImageView
import androidx.recyclerview.widget.GridLayoutManager
import com.bumptech.glide.Glide
import com.example.reviewapptcc.R
import com.example.reviewapptcc.common.CommonActivity
import com.example.reviewapptcc.detail.GameDetailActivity
import com.example.reviewapptcc.intro.IntroActivity
import com.example.reviewapptcc.utils.RemoteAuthUser
import com.example.reviewapptcc.utils.RemoteCloudStorage
import com.google.firebase.ktx.Firebase
import com.google.firebase.storage.ktx.storage
import com.squareup.picasso.Picasso
import kotlinx.android.synthetic.main.activity_home.*

class HomeActivity : CommonActivity(), HomeContract.View {

    private val _presenter = HomePresenter(this)
    private val _adapter = GamesListAdapter() {
        startActivity(GameDetailActivity.getInstance(this, it))
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_home)

        rvGameList.apply {
            setHasFixedSize(false)
            layoutManager = GridLayoutManager(context, 2)
            adapter = _adapter
        }

        rgConsoles.setOnCheckedChangeListener { _, idConsoleSelected ->
            _presenter.fetchData(idConsoleSelected)
        }

        _presenter.fetchData(rgConsoles.checkedRadioButtonId)
    }

    override fun showGames(games: List<GameModel>) {
        _adapter.setGames(games)
    }

}