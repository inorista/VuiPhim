package com.dev.vuiphim

import android.view.WindowManager
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "native/brightness"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "setBrightness" -> {
                    val brightness = call.argument<Double>("brightness") ?: 1.0
                    setBrightness(brightness)
                    result.success(null)
                }
                "getBrightness" -> {
                    val brightness = getBrightness()
                    result.success(brightness)
                }
                "resetBrightness" -> {
                    resetBrightness()
                    result.success(null)
                }
                else -> result.notImplemented()
            }
        }
    }

    private fun setBrightness(brightness: Double) {
        val window = this.window
        val layoutParams = window.attributes
        layoutParams.screenBrightness = brightness.toFloat()
        window.attributes = layoutParams
    }

    private fun getBrightness(): Double {
        val window = this.window
        val layoutParams = window.attributes
        return if (layoutParams.screenBrightness < 0) {
            1.0
        } else {
            layoutParams.screenBrightness.toDouble()
        }
    }

    private fun resetBrightness() {
        val window = this.window
        val layoutParams = window.attributes
        layoutParams.screenBrightness = WindowManager.LayoutParams.BRIGHTNESS_OVERRIDE_NONE
        window.attributes = layoutParams
    }
}
