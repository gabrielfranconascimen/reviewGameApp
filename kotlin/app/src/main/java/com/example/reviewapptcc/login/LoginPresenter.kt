package com.example.reviewapptcc.login

import android.content.Context
import android.content.Intent
import com.example.reviewapptcc.R
import com.example.reviewapptcc.User
import com.example.reviewapptcc.utils.RemoteDataUser
import com.example.reviewapptcc.utils.Validators
import com.google.android.gms.auth.api.signin.GoogleSignIn
import com.google.android.gms.auth.api.signin.GoogleSignInOptions
import com.google.android.gms.common.api.ApiException
import com.google.firebase.auth.FirebaseAuth
import com.google.firebase.auth.GoogleAuthProvider

class LoginPresenter(private val view: LoginContract.View,
                     private val auth: FirebaseAuth) : LoginContract.Presenter  {

    override fun submitForm(email: String, password: String) {
        if (validateForm(email, password)) {
            view.showLoading()
            auth.signInWithEmailAndPassword(email, password).addOnCompleteListener { task ->
                view.hiddenLoading()
                if (task.isSuccessful) {
                    view.launchHome()
                } else {
                    val message = task.exception?.message ?: "Problem connection"
                    view.loginError(message)
                }
            }
        } else {
            view.loginError(R.string.message_invalid_field)
        }
    }

    override fun loginWithGoogle(data: Intent?) {
        val task = GoogleSignIn.getSignedInAccountFromIntent(data)

        val credential = task.getResult(ApiException::class.java).let { account ->
            account?.idToken.let {
                GoogleAuthProvider.getCredential(it, null)
            }
        }

        auth.signInWithCredential(credential).addOnCompleteListener {
            if (task.isSuccessful) {
                task.result?.let {googleSignInAccount ->
                    val user = User(
                        googleSignInAccount.displayName ?: "",
                        "",
                        ""
                    )
                    registerNewUserWithoutExist(user)
                }
            } else {
                val message = task.exception?.message ?: "Problem connection"
                view.loginError(message)
            }
        }
    }

    private fun registerNewUserWithoutExist(user : User) {

        RemoteDataUser.getUserInfo { userLogged ->
            if (userLogged != null) {
                view.launchHome()
            } else {
                RemoteDataUser.saveUserInfo(user) { userSaved ->
                    if (userSaved) {
                        view.launchHome()
                    } else {
                        view.loginError(R.string.problem_save_user)
                    }
                }
            }
        }
    }

    private fun validateForm(email: String, password: String) : Boolean {
        return Validators.validateEmailField(email) && Validators.validatePasswordField(password)
    }

    override fun createGoogleClient(context: Context): Intent {
        val gso = GoogleSignInOptions.Builder(GoogleSignInOptions.DEFAULT_SIGN_IN)
            .requestIdToken("766209976148-81qsstln9f7m7hrgrusttmmgn0huhj9p.apps.googleusercontent.com")
            .requestEmail()
            .build()

        val googleSignInClient = GoogleSignIn.getClient(context, gso)

        return googleSignInClient.signInIntent
    }
}