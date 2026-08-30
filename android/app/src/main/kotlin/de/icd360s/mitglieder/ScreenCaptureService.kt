package de.icd360s.mitglieder

import android.app.Notification
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.Service
import android.content.Context
import android.content.Intent
import android.content.pm.ServiceInfo
import android.os.Build
import android.os.IBinder

/**
 * Fernwartung mediaProjection foreground service.
 *
 * Android 14+ (API 34) refuses MediaProjection.getMediaProjection() unless an
 * active foreground service of type mediaProjection exists, and any Android 10+
 * capture dies once the app is backgrounded without one. flutter_webrtc 1.5.2
 * does NOT run such a service, so we run this one for the duration of a consented
 * remote-support session (started/stopped from Dart via RemoteAgentService).
 */
class ScreenCaptureService : Service() {
    companion object {
        const val CHANNEL_ID = "fernwartung_capture"
        const val NOTIF_ID = 4711
    }

    override fun onBind(intent: Intent?): IBinder? = null

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        createChannel()
        val notification: Notification = Notification.Builder(this, CHANNEL_ID)
            .setContentTitle("Fernwartung aktiv")
            .setContentText("Ihr Bildschirm wird gerade geteilt.")
            .setSmallIcon(applicationInfo.icon)
            .setOngoing(true)
            .build()
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
            // ⚠️ Beide Typen. Der Typ im Manifest erlaubt es nur; angemeldet
            // wird er HIER. Ohne `MICROPHONE` schneidet Android 14+ den Ton ab,
            // sobald das Mitglied die App verlaesst — also genau dann, wenn ihm
            // geholfen wird und es zuhoert statt zu tippen.
            startForeground(
                NOTIF_ID,
                notification,
                ServiceInfo.FOREGROUND_SERVICE_TYPE_MEDIA_PROJECTION
                    or ServiceInfo.FOREGROUND_SERVICE_TYPE_MICROPHONE
            )
        } else {
            startForeground(NOTIF_ID, notification)
        }
        return START_NOT_STICKY
    }

    override fun onDestroy() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
            stopForeground(STOP_FOREGROUND_REMOVE)
        } else {
            @Suppress("DEPRECATION")
            stopForeground(true)
        }
        super.onDestroy()
    }

    private fun createChannel() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val nm = getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
            if (nm.getNotificationChannel(CHANNEL_ID) == null) {
                val ch = NotificationChannel(
                    CHANNEL_ID, "Fernwartung", NotificationManager.IMPORTANCE_LOW
                )
                ch.setShowBadge(false)
                nm.createNotificationChannel(ch)
            }
        }
    }
}
