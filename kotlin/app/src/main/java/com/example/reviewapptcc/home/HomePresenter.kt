package com.example.reviewapptcc.home

import com.example.reviewapptcc.utils.ConsolesType
import com.example.reviewapptcc.utils.RemoteCloudStorage
import com.example.reviewapptcc.utils.RemoteDataGames

class HomePresenter(private val view: HomeContract.View) :  HomeContract.Presenter {

    override fun fetchData(selectedConsoleId: Int) {
        view.showLoading()
        RemoteDataGames.getConsole(ConsolesType.getConsoleFromId(selectedConsoleId)) { message, games ->
            view.hiddenLoading()
            message?.let{
                view.showError(it)
            }
            games?.let {
                view.showGames(it)
            }
        }
    }
}