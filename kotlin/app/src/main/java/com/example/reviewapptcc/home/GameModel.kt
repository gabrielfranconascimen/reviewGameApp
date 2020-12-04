package com.example.reviewapptcc.home

import android.os.Parcelable
import kotlinx.android.parcel.Parcelize

@Parcelize
data class GameModel(var gameReference: String = "",
                     var description: String = "",
                     var image: String = "",
                     var link: String = "",
                     var name: String = "",
                     var thumbnail: String = "",
                     var score: List<Double> = listOf()): Parcelable