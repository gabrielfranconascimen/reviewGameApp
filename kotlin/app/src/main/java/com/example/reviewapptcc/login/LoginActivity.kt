package com.example.reviewapptcc.login

import android.app.AlertDialog
import android.content.Context
import android.content.Intent
import android.os.Bundle
import com.example.reviewapptcc.R
import com.example.reviewapptcc.common.CommonActivity
import com.example.reviewapptcc.home.HomeActivity
import com.google.android.gms.auth.api.signin.GoogleSignIn
import com.google.android.gms.auth.api.signin.GoogleSignInClient
import com.google.android.gms.auth.api.signin.GoogleSignInOptions
import com.google.android.gms.common.api.ApiException
import com.google.firebase.auth.FirebaseAuth
import com.google.firebase.auth.GoogleAuthProvider
import kotlinx.android.synthetic.main.activity_login.*

class LoginActivity : CommonActivity(), LoginContract.View {
    private val presenter : LoginContract.Presenter = LoginPresenter(this, FirebaseAuth.getInstance())

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_login)

        btnSubmit.setOnClickListener {
            presenter.submitForm(usernameEditText.text.toString(), passwordEditText.text.toString())
        }

        btnLoginGoogle.setOnClickListener {
            startActivityForResult(
                presenter.createGoogleClient(this),
                RC_SIGN_IN)
        }
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)

        if (requestCode == RC_SIGN_IN) {
            presenter.loginWithGoogle(data)
        }
    }

    override fun launchHome() {
        startActivity(Intent(this, HomeActivity::class.java))
        finish()
    }

    override fun loginError(message: String) {
        showDialog(message)
    }

    override fun loginError(idMessage: Int) {
        showDialog(getString(idMessage))
    }

    private fun showDialog(message: String) {
        val dialog = AlertDialog.Builder(this)
        dialog.setTitle(R.string.dialog_alert_title)
        dialog.setMessage(message)

        dialog.show()
    }

    companion object {
        private const val RC_SIGN_IN = 9001
    }

}