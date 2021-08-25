package com.example.reviewapptcc

import androidx.annotation.Keep

@Keep
data class User(
    val name: String,
    val nickname: String,
    val birthDate: String
)