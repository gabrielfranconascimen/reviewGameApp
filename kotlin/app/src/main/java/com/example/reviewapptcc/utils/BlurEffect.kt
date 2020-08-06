package com.example.reviewapptcc.utils

import android.content.Context
import android.graphics.Bitmap
import android.renderscript.Allocation
import android.renderscript.Element
import android.renderscript.RenderScript
import android.renderscript.ScriptIntrinsicBlur
import kotlin.math.roundToInt

class BlurEffect {
    companion object {
        var BITMAP_SCALE = 0.6f
        var BLUR_RADIUS = 15f

        fun blur(context: Context, image: Bitmap) : Bitmap {

            val width = (image.width * BITMAP_SCALE).roundToInt()
            val height = (image.height * BITMAP_SCALE).roundToInt()

            val inputBitmap = Bitmap.createScaledBitmap(image, width, height, false)
            val outputBitmap = Bitmap.createBitmap(inputBitmap)

            val renderScript = RenderScript.create(context)

            val intrinsicBlur = ScriptIntrinsicBlur.create(renderScript, Element.U8_4(renderScript))
            val tempInput = Allocation.createFromBitmap(renderScript, inputBitmap)
            val tempOutput = Allocation.createFromBitmap(renderScript, outputBitmap)

            intrinsicBlur.setRadius(BLUR_RADIUS)
            intrinsicBlur.setInput(tempInput)
            intrinsicBlur.forEach(tempOutput)

            tempOutput.copyTo(outputBitmap)

            return outputBitmap
        }

    }
}