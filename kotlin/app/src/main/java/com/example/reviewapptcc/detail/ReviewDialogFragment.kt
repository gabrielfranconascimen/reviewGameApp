package com.example.reviewapptcc.detail

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.DialogFragment
import androidx.recyclerview.widget.LinearLayoutManager
import com.example.reviewapptcc.R
import kotlinx.android.synthetic.main.custom_dialog_fragment.view.*

class ReviewDialogFragment private constructor() : DialogFragment() {

    private lateinit var _click: (note: Float) -> Unit

    companion object {

        fun getInstance(clickListener: (note: Float) -> Unit): ReviewDialogFragment {
            val dialogFragment = ReviewDialogFragment()
            dialogFragment._click = clickListener

            return dialogFragment
        }
    }

    override fun onCreateView(inflater: LayoutInflater,
                              container: ViewGroup?,
                              savedInstanceState: Bundle?): View? {

        val view = inflater.inflate(R.layout.custom_dialog_fragment, container, false)

        view.btnConfirmVote.setOnClickListener {
            _click.invoke(view.rbGameReview.rating)
            dismiss()
        }

        return view
    }
}