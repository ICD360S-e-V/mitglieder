package de.icd360s.mitglieder

import android.content.Intent
import android.os.Build
import android.os.Bundle
import android.util.Log
import android.view.WindowManager
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

/**
 * MainActivity that starts the RestartService on app launch.
 * The RestartService monitors when the app is closed (swiped away)
 * and schedules a restart of the background WebSocket service.
 */
class MainActivity : FlutterActivity() {
    companion object {
        const val TAG = "MainActivity"
        const val SECURE_CHANNEL = "de.icd360sev.mitglied/secure_screen"
        const val CAPTURE_CHANNEL = "de.icd360sev.mitglied/screen_capture"
    }

    // Fernwartung: FLAG_SECURE blocks the app from being screen-recorded — which
    // also blocks MediaProjection during a consented remote-support session, so
    // the shared screen would be black. Toggle it off only while sharing, then
    // restore it. Called from Dart (RemoteAgentService) on session start/stop.
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, SECURE_CHANNEL)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "setSecure" -> {
                        val secure = call.argument<Boolean>("secure") ?: true
                        runOnUiThread {
                            if (secure) {
                                window.addFlags(WindowManager.LayoutParams.FLAG_SECURE)
                            } else {
                                window.clearFlags(WindowManager.LayoutParams.FLAG_SECURE)
                            }
                            Log.d(TAG, "FLAG_SECURE set to $secure")
                        }
                        result.success(null)
                    }
                    else -> result.notImplemented()
                }
            }

        // Fernwartung: start/stop the mediaProjection foreground service around a
        // screen-capture session (RemoteAgentService calls start before
        // getDisplayMedia and stop on cleanup).
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CAPTURE_CHANNEL)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "start" -> {
                        val i = Intent(this, ScreenCaptureService::class.java)
                        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                            startForegroundService(i)
                        } else {
                            startService(i)
                        }
                        Log.d(TAG, "ScreenCaptureService started")
                        result.success(null)
                    }
                    "stop" -> {
                        stopService(Intent(this, ScreenCaptureService::class.java))
                        Log.d(TAG, "ScreenCaptureService stopped")
                        result.success(null)
                    }
                    else -> result.notImplemented()
                }
            }
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        // Security: Prevent screenshots and screen recording
        window.setFlags(
            WindowManager.LayoutParams.FLAG_SECURE,
            WindowManager.LayoutParams.FLAG_SECURE
        )
        Log.d(TAG, "FLAG_SECURE enabled - screenshots blocked")

        // Start the RestartService which will monitor onTaskRemoved
        startRestartService()
    }

    /**
     * Start the RestartService that monitors app closure.
     */
    private fun startRestartService() {
        try {
            val serviceIntent = Intent(this, RestartService::class.java)
            startService(serviceIntent)
            Log.d(TAG, "RestartService started")
        } catch (e: Exception) {
            Log.e(TAG, "Failed to start RestartService: ${e.message}")
        }
    }
}
