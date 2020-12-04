package com.example.reviewapptcc.utils

import android.text.Editable
import android.text.TextWatcher
import android.widget.EditText
import java.lang.Exception

class Mask {
    companion object {
        private fun replaceChars(textFull: String) : String {
            return textFull.replace(".", "")
                .replace("-", "")
                .replace("(", "")
                .replace(")", "")
                .replace("/", "")
                .replace("*", "")
                .replace(" ", "")

        }
    }

    fun mask(typeMask: String, editText: EditText) : TextWatcher {
        var isUpdating = false
        var oldString = ""

        return object : TextWatcher {
            override fun onTextChanged(charSequence: CharSequence?, start: Int, before: Int, count: Int) {
                val str = replaceChars(charSequence.toString())
                var strWithMask = ""

                if (count == 0) isUpdating = true

                if (isUpdating) {
                    oldString = str
                    isUpdating = false
                    return
                }

                var i = 0
                for (m : Char in typeMask.toCharArray()) {
                    if (m != '#' && str.length > oldString.length) {
                        strWithMask += m
                        continue
                    }
                    try {
                        strWithMask += str.get(i)
                    } catch (e : Exception) {
                        break
                    }
                    i++
                }

                isUpdating = true
                editText.setText(strWithMask)
                editText.setSelection(strWithMask.length)
            }

            override fun afterTextChanged(p0: Editable?) {}
            override fun beforeTextChanged(p0: CharSequence?, p1: Int, p2: Int, p3: Int) {}
        }
    }
}