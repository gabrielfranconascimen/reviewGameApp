package com.example.reviewapptcc.singIn

data class SiginRequest(val name: String,
                        val email: String,
                        val nickname: String,
                        val birthDate: String,
                        val password: String,
                        val confirmPassword: String )