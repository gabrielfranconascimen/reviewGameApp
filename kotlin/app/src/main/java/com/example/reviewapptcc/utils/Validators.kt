package com.example.reviewapptcc.utils

import androidx.core.util.PatternsCompat.EMAIL_ADDRESS
import java.util.regex.Pattern

class Validators {
    companion object {
        private val PASSWORD_PATTERN = Pattern.compile("[a-zA-Z0-9\\!\\@\\#\\$]{6,24}")

        fun validatePasswordField(password: String): Boolean {
            return PASSWORD_PATTERN.matcher(password).matches()
        }

        fun validateNewPassword(password: String, confirmPassword: String): Boolean {
            return validatePasswordField(password) && password == confirmPassword
        }

        fun validateEmailField(email: String): Boolean {
            return EMAIL_ADDRESS.matcher(email).matches()
        }
    }
}