package com.example.reviewapptcc.singIn

import com.example.reviewapptcc.R
import com.example.reviewapptcc.User
import com.example.reviewapptcc.utils.RemoteDataUser
import com.example.reviewapptcc.utils.Validators
import com.google.firebase.auth.FirebaseAuth

class SigInPresenter(private val view: SigInContract.View,
                     private val auth: FirebaseAuth) : SigInContract.Presenter {

    override fun submitForm(siginRequest: SiginRequest) {

        if (validateCreateUser(siginRequest.email, siginRequest.password, siginRequest.confirmPassword)) {
            createUser(siginRequest)
        } else {
            view.showError(R.string.problem_validate_user)
        }
    }

    private fun createUser(sigInRequest: SiginRequest) {
        view.showLoading()
        auth.createUserWithEmailAndPassword(sigInRequest.email, sigInRequest.password)
            .addOnCompleteListener { task ->
                view.hiddenLoading()
                if (task.isSuccessful) {
                    registerNewUser(sigInRequest, task.result?.user?.uid.toString())
                } else {
                    val message = task.exception?.message ?: "Problem wit connection"
                    view.showError(message)
                }
            }
    }

    private fun registerNewUser(sigInRequest: SiginRequest, tokenUser: String) {
        val user = User(
            sigInRequest.name,
            sigInRequest.nickname,
            sigInRequest.birthDate
        )

        RemoteDataUser.saveUserInfo(user) { userSaved ->
            if (userSaved) {
                view.launchHome()
            } else {
                view.showError(R.string.problem_save_user)
            }
        }
    }

    private fun validateCreateUser(email: String, password: String, confirmPassword: String) : Boolean {
        return Validators.validateEmailField(email) && Validators.validateNewPassword(password, confirmPassword)
    }
}