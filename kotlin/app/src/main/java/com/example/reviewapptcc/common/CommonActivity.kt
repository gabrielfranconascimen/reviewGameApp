package com.example.reviewapptcc.common

import android.content.Intent
import android.view.Menu
import android.view.MenuItem
import android.view.View
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import com.example.reviewapptcc.R
import com.example.reviewapptcc.intro.IntroActivity
import com.example.reviewapptcc.utils.RemoteAuthUser
import kotlinx.android.synthetic.main.activity_login.*

open class CommonActivity : AppCompatActivity(), CommonContract.View {

    override fun onCreateOptionsMenu(menu: Menu?): Boolean {
        menuInflater.inflate(R.menu.menu_toolbar, menu)
        return true
    }

    override fun onOptionsItemSelected(item: MenuItem): Boolean {
        return when(item.itemId) {
            R.id.logout_item -> {
                logout()
                true
            }
            else -> super.onOptionsItemSelected(item)
        }
    }

    override fun showLoading() {
        progressCircular.visibility = View.VISIBLE
    }

    override fun hiddenLoading() {
        progressCircular.visibility = View.GONE
    }

    override fun showError(message: String) {
        showToast(message)
    }

    override fun showError(messageResource: Int) {
        showToast(resources.getString(messageResource))
    }

    private fun showToast(message: String) {
        Toast
            .makeText(this, message, Toast.LENGTH_SHORT)
            .show()
    }

    private fun logout() {
        RemoteAuthUser.logoutUser()
        val intent = Intent(this, IntroActivity::class.java)
        startActivity(intent)
        finish()
    }
}