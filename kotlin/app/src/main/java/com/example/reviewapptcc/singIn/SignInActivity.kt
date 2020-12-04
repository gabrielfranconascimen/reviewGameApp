package com.example.reviewapptcc.singIn

import android.content.Intent
import android.os.Bundle
import com.example.reviewapptcc.R
import com.example.reviewapptcc.common.CommonActivity
import com.example.reviewapptcc.home.HomeActivity
import com.example.reviewapptcc.utils.Mask
import com.google.firebase.auth.FirebaseAuth
import kotlinx.android.synthetic.main.activity_sign_in.*

class SignInActivity : CommonActivity(), SigInContract.View {

    private val presenter: SigInContract.Presenter = SigInPresenter(this, FirebaseAuth.getInstance())

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_sign_in)

        etBirthDate.addTextChangedListener(Mask().mask("##/##/####", etBirthDate))
        btnSubmitForm.setOnClickListener { sendForm() }
    }

    private fun sendForm() {
        val email = etEmail.text.toString()
        val password = etPassword.text.toString()
        val confirmPassword = etConfirmPassword.text.toString()
        val birthDate = etBirthDate.text.toString()
        val name = etUserName.text.toString()
        val nickname = etNickName.text.toString()

        val sigInRequest = SiginRequest(name, email, nickname, birthDate, password, confirmPassword)

        presenter.submitForm(sigInRequest)
    }

    override fun launchHome() {
        startActivity(Intent(this, HomeActivity::class.java))
        finish()
    }

}