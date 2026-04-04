package de.icd360s.mitglieder

import android.app.AlarmManager
import android.app.PendingIntent
import android.app.Service
import android.content.Context
import android.content.Intent
import android.os.Build
import android.os.IBinder
import android.os.SystemClock
import android.util.Log

/**
 * A lightweight service that monitors when the app task is removed (user swipes away).
 * When the task is removed, it schedules a restart of the background service via AlarmManager.
 */
class RestartService : Service() {
    companion object {
        const val TAG = "RestartService"
        const val RESTART_DELAY_MS = 1000L // 1 second delay before restart
    }

    override fun onBind(intent: Intent?): IBinder? = null

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        Log.d(TAG, "RestartService started")
        // Return START_STICKY so the service is restarted if killed
        return START_STICKY
    }

    /**
     * Called when the user removes the app from recent tasks (swipe away).
     * Schedules the background service to restart after a short delay.
     */
    override fun onTaskRemoved(rootIntent: Intent?) {
        Log.d(TAG, "onTaskRemoved called - scheduling background service restart")

        scheduleServiceRestart()

        super.onTaskRemoved(rootIntent)
    }

    /**
     * Schedule the background service to restart using AlarmManager.
     */
    private fun scheduleServiceRestart() {
        try {
            val alarmManager = getSystemService(Context.ALARM_SERVICE) as AlarmManager

            // Create intent for RestartReceiver
            val restartIntent = Intent(this, RestartReceiver::class.java).apply {
                action = RestartReceiver.ACTION_RESTART_SERVICE
            }

            // Create PendingIntent
            val pendingIntent = PendingIntent.getBroadcast(
                this,
                0,
                restartIntent,
                PendingIntent.FLAG_ONE_SHOT or PendingIntent.FLAG_IMMUTABLE
            )

            // Schedule restart after delay
            val triggerTime = SystemClock.elapsedRealtime() + RESTART_DELAY_MS

            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                // Use setExactAndAllowWhileIdle for more reliable restart on Android 6+
                alarmManager.setExactAndAllowWhileIdle(
                    AlarmManager.ELAPSED_REALTIME_WAKEUP,
                    triggerTime,
                    pendingIntent
                )
            } else {
                alarmManager.setExact(
                    AlarmManager.ELAPSED_REALTIME_WAKEUP,
                    triggerTime,
                    pendingIntent
                )
            }

            Log.d(TAG, "Background service restart scheduled in ${RESTART_DELAY_MS}ms")
        } catch (e: Exception) {
            Log.e(TAG, "Failed to schedule service restart: ${e.message}")
        }
    }
}
