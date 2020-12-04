package com.example.reviewapptcc.utils

import com.example.reviewapptcc.R

object ConsolesType {

    fun getConsoleFromId(consoleId: Int): ConsoleEnum {
        return when(consoleId) {
            R.id.rbXbox -> ConsoleEnum.XBOX
            R.id.rbWii -> ConsoleEnum.Wii
            R.id.rbComputer -> ConsoleEnum.COMPUTADOR
            else -> ConsoleEnum.PLAYSTATION
        }
    }
}

enum class ConsoleEnum(val path: String) {
    COMPUTADOR("computador"),
    PLAYSTATION("playstation"),
    XBOX("xbox"),
    Wii("switch")
}