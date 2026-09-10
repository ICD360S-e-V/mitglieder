package de.icd360s.mitglieder

import android.app.Notification
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.app.Service
import android.content.Intent
import android.content.pm.ServiceInfo
import android.os.Build
import android.os.IBinder
import android.util.Log

/**
 * Vordergrunddienst fuer einen LAUFENDEN Anruf.
 *
 * Ohne ihn ist ein Anruf beendet, sobald die App aus dem Blick geraet: seit
 * Android 12 darf eine App, die nicht im Vordergrund ist, weder Mikrofon noch
 * Kamera halten, und seit Android 14 (API 34) verlangt jeder
 * Vordergrunddienst einen TYP plus die dazu passende Berechtigung.
 * flutter_webrtc bringt keinen solchen Dienst mit — deshalb dieser hier.
 *
 * ⚠️ DER TYP KOMMT AUS DEM AUFRUF, NICHT FEST AUS DEM CODE. Wird
 * `FOREGROUND_SERVICE_TYPE_CAMERA` angemeldet, verlangt Android 14+ die
 * Berechtigung CAMERA — und bei einem reinen Sprachanruf hat der Mensch sie
 * vielleicht nie erteilt. Fest angemeldet wuerde `startForeground()` dort mit
 * einer SecurityException abbrechen und der Anruf waere schlechter dran als
 * ohne diesen Dienst. Sprachanruf → nur `microphone`, Videoanruf →
 * `microphone or camera`.
 *
 * ⚠️ Der Typ im Manifest ERLAUBT nur; angemeldet wird er hier zur Laufzeit.
 * Dieselbe Aufteilung wie bei [ScreenCaptureService] der Fernwartung, an dem
 * dieser Dienst sich bewusst orientiert statt ein zweites Muster zu erfinden.
 *
 * ⚠️ START_NOT_STICKY: wird die App weggewischt, ist der Anruf vorbei. Ein von
 * Android wiederbelebter Dienst haette keine Gegenstelle mehr und wuerde nur
 * eine Benachrichtigung ueber ein Gespraech zeigen, das es nicht gibt.
 */
class AnrufDienst : Service() {
    companion object {
        const val CHANNEL_ID = "anruf_laufend"
        const val NOTIF_ID = 4712
        const val EXTRA_VIDEO = "video"
        const val EXTRA_NAME = "name"
        private const val TAG = "AnrufDienst"
    }

    override fun onBind(intent: Intent?): IBinder? = null

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        val video = intent?.getBooleanExtra(EXTRA_VIDEO, false) ?: false
        val name = intent?.getStringExtra(EXTRA_NAME)
        kanalAnlegen()

        // Antippen fuehrt in die App zurueck. Ohne das waere ein Anruf, aus dem
        // man herausgewischt hat, nur noch ueber Umwege erreichbar.
        val zurueck = PendingIntent.getActivity(
            this,
            0,
            Intent(this, MainActivity::class.java).apply {
                addFlags(Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_SINGLE_TOP)
            },
            PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE,
        )

        val titel = if (video) "Videoanruf laeuft" else "Anruf laeuft"
        val text = if (name.isNullOrBlank()) {
            "Zum Anruf zurueckkehren"
        } else {
            "Mit $name \u2014 zum Anruf zurueckkehren"
        }

        val meldung: Notification = Notification.Builder(this, CHANNEL_ID)
            .setContentTitle(titel)
            .setContentText(text)
            .setSmallIcon(applicationInfo.icon)
            .setOngoing(true)
            .setUsesChronometer(true)
            .setCategory(Notification.CATEGORY_CALL)
            .setContentIntent(zurueck)
            .build()

        try {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
                var typ = ServiceInfo.FOREGROUND_SERVICE_TYPE_MICROPHONE
                if (video) typ = typ or ServiceInfo.FOREGROUND_SERVICE_TYPE_CAMERA
                startForeground(NOTIF_ID, meldung, typ)
            } else {
                startForeground(NOTIF_ID, meldung)
            }
            Log.d(TAG, "gestartet (video=$video)")
        } catch (e: Throwable) {
            // ⚠️ Hier NICHT weiterwerfen. Verweigert Android den Dienst (fehlende
            // Berechtigung, Start aus dem Hintergrund), soll der Anruf trotzdem
            // laufen — er ueberlebt dann nur das Verlassen der App nicht. Ein
            // Absturz waere schlimmer als die fehlende Verbesserung.
            Log.e(TAG, "startForeground abgelehnt: $e")
            stopSelf()
            return START_NOT_STICKY
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
        Log.d(TAG, "beendet")
        super.onDestroy()
    }

    private fun kanalAnlegen() {
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.O) return
        val mgr = getSystemService(NotificationManager::class.java) ?: return
        if (mgr.getNotificationChannel(CHANNEL_ID) != null) return
        // IMPORTANCE_LOW: die Benachrichtigung ist ein Rueckweg, kein Alarm.
        // Sie darf waehrend eines Gespraechs nicht auch noch klingeln.
        val kanal = NotificationChannel(
            CHANNEL_ID,
            "Laufender Anruf",
            NotificationManager.IMPORTANCE_LOW,
        ).apply {
            setShowBadge(false)
            enableVibration(false)
            setSound(null, null)
        }
        mgr.createNotificationChannel(kanal)
    }
}
