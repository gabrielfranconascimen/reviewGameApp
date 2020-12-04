package com.example.reviewapptcc.home

import com.example.reviewapptcc.common.CommonContract

interface HomeContract {

    interface View : CommonContract.View {
        fun showGames(games: List<GameModel>)
    }

    interface Presenter : CommonContract.Presenter {
        fun fetchData(selectedConsoleId: Int)
    }
}