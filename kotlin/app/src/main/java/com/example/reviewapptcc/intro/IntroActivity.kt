package com.example.reviewapptcc.intro

import android.content.Intent
import android.graphics.BitmapFactory
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.view.View
import com.example.reviewapptcc.R
import com.example.reviewapptcc.home.HomeActivity
import com.example.reviewapptcc.login.LoginActivity
import com.example.reviewapptcc.singIn.SignInActivity
import com.example.reviewapptcc.utils.BlurEffect
import com.example.reviewapptcc.utils.RemoteAuthUser
import kotlinx.android.synthetic.main.activity_intro.*

class IntroActivity : AppCompatActivity() {

    private val launchLoginActivity = View.OnClickListener {
        launchActivity(Intent(this, LoginActivity::class.java))
    }

    private val launchSignInActivity = View.OnClickListener {
        launchActivity(Intent(this, SignInActivity::class.java))
    }

    private val launchHomeActivity = View.OnClickListener {
        launchActivity(Intent(this, HomeActivity::class.java))
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_intro)

        val result = BlurEffect.blur(this, BitmapFactory.decodeResource(resources, R.drawable.background_intro))
        ivBackground.setImageBitmap(result)

        btnLogin.setOnClickListener(launchLoginActivity)
        btnSignIn.setOnClickListener(launchSignInActivity)
        btnHome.setOnClickListener(launchHomeActivity)

        if (RemoteAuthUser.isLogged()) {
            launchActivity(Intent(this, HomeActivity::class.java))
            finish()
        }
    }

    private fun launchActivity(intent: Intent) {
        startActivity(intent)
    }

}