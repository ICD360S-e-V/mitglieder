package de.icd360s.mitglieder

import android.content.Intent
import android.os.Build
import android.os.Bundle
import android.util.Log
import android.view.WindowManager
import io.flutter.embedding.android.FlutterActivity

/**
 * MainActivity that starts the RestartService on app launch.
 * The RestartService monitors when the app is closed (swiped away)
 * and schedules a restart of the background WebSocket service.
 */
class MainActivity : FlutterActivity() {
    companion object {
        const val TAG = "MainActivity"
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
