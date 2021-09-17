package com.simplytranslate

import android.app.Activity
import android.content.Context
import android.content.Intent
import android.hardware.Sensor
import android.hardware.SensorEvent
import android.hardware.SensorEventListener
import android.hardware.SensorManager
import android.os.Bundle
import android.os.Messenger
import android.widget.Toast
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel
import org.jetbrains.annotations.NotNull
import java.lang.reflect.Method

class MainActivity: FlutterActivity() {

    private val TRANSLATE_CHANNEL_NAME = "com.simplytranslate/translate"
    private var translateChannel: MethodChannel? = null

    override fun configureFlutterEngine(@NotNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        // Setup Channels
        setupChannels(this,flutterEngine.dartExecutor.binaryMessenger)

    }

    override fun onDestroy() {
        teardownChannels()
        super.onDestroy()
    }

    private fun setupChannels(context:Context, messenger: BinaryMessenger){
        translateChannel = MethodChannel(messenger, TRANSLATE_CHANNEL_NAME)
        translateChannel!!.setMethodCallHandler{
            call, result ->
            if (call.method == "getText"){
                result.success(text)
                text = ""
            } else {
                result.notImplemented()
            }
        }
    }
    private fun teardownChannels(){
        teardownChannels()
        translateChannel!!.setMethodCallHandler(null)
    }
}
var text = ""
class UppercaseActivity : Activity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

       text = intent.getCharSequenceExtra(Intent.EXTRA_PROCESS_TEXT).toString()

        val launchIntent = packageManager.getLaunchIntentForPackage("com.simplytranslate")
        launchIntent?.let { startActivity(it) }

        finish()
    }
}