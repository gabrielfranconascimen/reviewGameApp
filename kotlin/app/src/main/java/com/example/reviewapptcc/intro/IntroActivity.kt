package com.example.reviewapptcc.intro

import android.graphics.BitmapFactory
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.ImageView
import com.example.reviewapptcc.R
import com.example.reviewapptcc.utils.BlurEffect

class IntroActivity : AppCompatActivity() {

    var ivBackground : ImageView = findViewById(R.id.ivBackground)

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_intro)

        val result = BlurEffect.blur(this, BitmapFactory.decodeResource(resources, R.drawable.background_intro))
        ivBackground.setImageBitmap(result)
    }
}