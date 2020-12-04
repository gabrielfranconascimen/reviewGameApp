package com.example.reviewapptcc.home

class ConsoleType
private constructor(idConsole: Consoles, nameConsole: String) {

    companion object {
        val PLAYSTATION = ConsoleType(Consoles.Playstation, "playstation")
        val XBOX = ConsoleType(Consoles.Xbox, "xbox")
        val SWITCH = ConsoleType(Consoles.Switch, "switch")
        val COMPUTER = ConsoleType(Consoles.Computer, "computador")
    }

    enum class Consoles {
        Playstation,
        Xbox,
        Switch,
        Computer
    }
}