package de.icd360s.mitglieder

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.os.Build
import android.util.Log

/**
 * BroadcastReceiver to restart the background service when the app is closed.
 * Listens for:
 * - Custom RESTART_SERVICE action (from onTaskRemoved)
 * - BOOT_COMPLETED (device restart)
 * - MY_PACKAGE_REPLACED (app update)
 */
class RestartReceiver : BroadcastReceiver() {
    companion object {
        const val TAG = "RestartReceiver"
        const val ACTION_RESTART_SERVICE = "de.icd360s.mitglieder.RESTART_SERVICE"
    }

    override fun onReceive(context: Context, intent: Intent) {
        Log.d(TAG, "Received intent: ${intent.action}")

        when (intent.action) {
            ACTION_RESTART_SERVICE,
            Intent.ACTION_BOOT_COMPLETED,
            Intent.ACTION_MY_PACKAGE_REPLACED -> {
                Log.d(TAG, "Starting background service...")
                startBackgroundService(context)
            }
        }
    }

    private fun startBackgroundService(context: Context) {
        try {
            val serviceIntent = Intent(context, Class.forName("id.flutter.flutter_background_service.BackgroundService"))

            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                context.startForegroundService(serviceIntent)
            } else {
                context.startService(serviceIntent)
            }
            Log.d(TAG, "Background service started successfully")
        } catch (e: Exception) {
            Log.e(TAG, "Failed to start background service: ${e.message}")
        }
    }
}
