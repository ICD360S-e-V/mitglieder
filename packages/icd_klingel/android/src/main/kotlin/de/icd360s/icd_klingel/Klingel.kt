package de.icd360s.icd_klingel

import android.app.Activity
import android.app.KeyguardManager
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.content.Context
import android.content.Intent
import android.media.AudioAttributes
import android.media.AudioManager
import android.media.MediaPlayer
import android.media.RingtoneManager
import android.net.Uri
import android.os.Build
import android.os.VibrationEffect
import android.os.Vibrator
import android.os.VibratorManager
import android.provider.Settings
import android.util.Log
import androidx.core.app.NotificationCompat
import androidx.core.app.NotificationManagerCompat
import androidx.core.app.Person

/**
 * Der eingehende Anruf: Benachrichtigung mit Annehmen/Ablehnen plus
 * Vollbild-Intent auf [KlingelActivity], damit der Schirm bei ruhendem,
 * gesperrtem Gerät überhaupt erscheint.
 *
 * ⚠️ ZWEI WEGE, ABSICHTLICH. Der Vollbild-Intent ist der gewünschte, aber er
 * ist nicht garantiert: ab Android 14 entzieht der Play Store die Berechtigung
 * `USE_FULL_SCREEN_INTENT` bei Installation jeder App, die er nicht als
 * Telefonie- oder Weckerapp einordnet. Bleibt er aus, ist die Meldung mit
 * ihren zwei Knöpfen alles, was das Mitglied hat — und damit lässt sich der
 * Anruf immer noch annehmen. Wäre der Vollbild-Intent der einzige Weg, wäre
 * die App auf solchen Geräten stumm kaputt.
 */
object Klingel {

    /**
     * ⚠️ NEUE Kanalkennung, nicht die alte `voice_calls`. Die Einstellungen
     * eines Benachrichtigungskanals sind nach dem Anlegen UNVERÄNDERLICH:
     * `voice_calls` steht auf dem gewöhnlichen Meldungston und liesse sich
     * nicht mehr auf Klingeln umstellen. Wer hier je Ton, Wichtigkeit oder
     * Vibration ändert, braucht wieder eine neue Kennung.
     */
    const val KANAL_ID = "anruf_eingehend_v2"
    const val NOTIF_ID = 4713

    const val AKTION_ABLEHNEN = "de.icd360s.icd_klingel.ABLEHNEN"
    const val EXTRA_GESPRAECH = "gespraech"
    const val EXTRA_NAME = "name"
    const val EXTRA_VIDEO = "video"
    const val EXTRA_TITEL = "titel"
    const val EXTRA_ANNEHMEN = "annehmen"
    const val EXTRA_ABLEHNEN = "ablehnen"
    const val EXTRA_DIREKT = "direkt"

    private const val TAG = "IcdKlingel"

    // Flutters klassischer SharedPreferences-Speicher. Die Entscheidung muss
    // auch dann ankommen, wenn in diesem Augenblick GAR KEIN Dart-Isolat lebt
    // — der Ereigniskanal erreicht dann niemanden.
    private const val PREFS = "FlutterSharedPreferences"
    private const val SCHLUESSEL_ENTSCHEIDUNG = "flutter.anruf_entscheidung"

    private var spieler: MediaPlayer? = null

    // Anwendungskontext, damit [tonStoppen] ohne Kontext auskommt.
    private var gemerkterKontext: Context? = null

    // ------------------------------------------------------------------ zeigen

    fun zeigen(
        ctx: Context,
        name: String,
        video: Boolean,
        gespraechId: Int,
        titel: String,
        annehmenText: String,
        ablehnenText: String,
    ): Boolean {
        kanalAnlegen(ctx)

        val schirm = Intent(ctx, KlingelActivity::class.java).apply {
            addFlags(Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TOP)
            putExtra(EXTRA_GESPRAECH, gespraechId)
            putExtra(EXTRA_NAME, name)
            putExtra(EXTRA_VIDEO, video)
            putExtra(EXTRA_TITEL, titel)
            putExtra(EXTRA_ANNEHMEN, annehmenText)
            putExtra(EXTRA_ABLEHNEN, ablehnenText)
        }
        val vollbild = PendingIntent.getActivity(
            ctx, 1, schirm,
            PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE,
        )

        // Annehmen führt über die Activity, NICHT über den Empfänger: ein
        // BroadcastReceiver darf seit Android 10 keine Activity aus dem
        // Hintergrund starten, und genau das müsste er tun, um die App zu
        // öffnen. Ein PendingIntent.getActivity aus einer Meldung ist dagegen
        // ein vom System vermittelter Start mit Nutzergeste.
        val annehmen = PendingIntent.getActivity(
            ctx, 2,
            Intent(ctx, KlingelActivity::class.java).apply {
                addFlags(Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TOP)
                putExtras(schirm)
                putExtra(EXTRA_DIREKT, "annehmen")
            },
            PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE,
        )
        val ablehnen = PendingIntent.getBroadcast(
            ctx, 3,
            Intent(ctx, KlingelEmpfaenger::class.java).apply {
                action = AKTION_ABLEHNEN
                putExtra(EXTRA_GESPRAECH, gespraechId)
            },
            PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE,
        )

        val wer = Person.Builder().setName(name).setImportant(true).build()

        val bau = NotificationCompat.Builder(ctx, KANAL_ID)
            .setSmallIcon(ctx.applicationInfo.icon)
            .setContentTitle(titel)
            .setContentText(name)
            .setCategory(NotificationCompat.CATEGORY_CALL)
            .setPriority(NotificationCompat.PRIORITY_MAX)
            // Auf dem Sperrbildschirm muss der Name lesbar sein, sonst weiss
            // niemand, ob sich das Annehmen lohnt.
            .setVisibility(NotificationCompat.VISIBILITY_PUBLIC)
            .setOngoing(true)
            .setAutoCancel(false)
            // ⚠️ Unter API 31 gibt CallStyle keinen hohen Rang. `setColorized`
            // ist der von Android dafür genannte Ersatz.
            .setColorized(true)
            .setStyle(NotificationCompat.CallStyle.forIncomingCall(wer, ablehnen, annehmen))
            .setFullScreenIntent(vollbild, true)
            // ⚠️ Eine liegengebliebene Klingelmeldung muss von selbst
            // verschwinden. Der Anrufer gibt nach ~45 s auf; ohne diese Grenze
            // stünde „Eingehender Anruf" morgen noch da.
            .setTimeoutAfter(90_000L)

        // Der Ton wird SELBST gespielt und nicht dem Kanal überlassen: ein
        // Kanalton spielt genau EINMAL. Ein Anruf muss klingeln, bis jemand
        // abnimmt.
        return try {
            NotificationManagerCompat.from(ctx).notify(NOTIF_ID, bau.build())
            tonStarten(ctx)
            true
        } catch (e: Throwable) {
            // Fehlt POST_NOTIFICATIONS, wirft notify(). Der Anruf soll daran
            // nicht sterben — ohne Meldung bleibt der Weg über die offene App.
            Log.e(TAG, "Klingelmeldung abgelehnt: $e")
            false
        }
    }

    fun verbergen(ctx: Context) {
        tonStoppen()
        // ⚠️ Der Schirm MUSS mit. Legt der Anrufer auf, raeumt Dart die
        // Meldung ab — bliebe die Activity stehen, klebte „Eingehender Anruf"
        // auf dem Sperrbildschirm und ein spaeteres „Annehmen" fuehrte ins
        // Leere. Genau der Fehler vom 11.09.2026, eine Ebene tiefer.
        KlingelActivity.schliessen()
        try {
            NotificationManagerCompat.from(ctx).cancel(NOTIF_ID)
        } catch (e: Throwable) {
            Log.w(TAG, "cancel: $e")
        }
    }

    private fun kanalAnlegen(ctx: Context) {
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.O) return
        val mgr = ctx.getSystemService(NotificationManager::class.java) ?: return
        if (mgr.getNotificationChannel(KANAL_ID) != null) return
        val kanal = NotificationChannel(
            KANAL_ID,
            "Eingehende Anrufe",
            NotificationManager.IMPORTANCE_HIGH,
        ).apply {
            description = "Klingeln bei einem eingehenden Anruf"
            // Kein Kanalton: wir spielen selbst in Schleife (siehe oben).
            setSound(null, null)
            enableVibration(false)
            enableLights(true)
            lockscreenVisibility = android.app.Notification.VISIBILITY_PUBLIC
            setShowBadge(false)
        }
        mgr.createNotificationChannel(kanal)
    }

    // --------------------------------------------------------------------- Ton

    private fun tonStarten(ctx: Context) {
        gemerkterKontext = ctx.applicationContext
        tonStoppen()
        val am = ctx.getSystemService(Context.AUDIO_SERVICE) as? AudioManager
        val modus = am?.ringerMode ?: AudioManager.RINGER_MODE_NORMAL

        // ⚠️ Der Klingelmodus des Geräts wird RESPEKTIERT. Auf „lautlos" zu
        // klingeln ist kein Dienst am Mitglied, sondern ein Fehler — es hat
        // den Schalter aus einem Grund umgelegt.
        if (modus != AudioManager.RINGER_MODE_SILENT) vibrieren(ctx)
        if (modus != AudioManager.RINGER_MODE_NORMAL) return

        val ton: Uri = RingtoneManager.getActualDefaultRingtoneUri(ctx, RingtoneManager.TYPE_RINGTONE)
            ?: RingtoneManager.getDefaultUri(RingtoneManager.TYPE_RINGTONE)
            ?: return
        try {
            spieler = MediaPlayer().apply {
                setAudioAttributes(
                    AudioAttributes.Builder()
                        // USAGE_NOTIFICATION_RINGTONE: hängt an der
                        // KLINGEL-Lautstärke und am „Nicht stören" des Geräts,
                        // nicht an der Medienlautstärke.
                        .setUsage(AudioAttributes.USAGE_NOTIFICATION_RINGTONE)
                        .setContentType(AudioAttributes.CONTENT_TYPE_SONIFICATION)
                        .build(),
                )
                setDataSource(ctx, ton)
                isLooping = true
                prepare()
                start()
            }
        } catch (e: Throwable) {
            Log.w(TAG, "Klingelton nicht spielbar: $e")
            spieler = null
        }
    }

    /**
     * Stoppt Ton UND Vibration.
     *
     * ⚠️ Der Anwendungskontext wird beim Starten gemerkt, damit das Stoppen
     * ohne Kontext auskommt: gestoppt wird aus dem Empfänger, aus der Activity
     * und aus Dart, und jeder dieser Aufrufer hätte einen anderen Kontext zur
     * Hand. Ein Anwendungskontext lebt so lange wie der Prozess, ist also kein
     * Leck.
     */
    fun tonStoppen() {
        try {
            spieler?.let {
                if (it.isPlaying) it.stop()
                it.release()
            }
        } catch (e: Throwable) {
            Log.w(TAG, "Ton stoppen: $e")
        }
        spieler = null
        try {
            gemerkterKontext?.let { vibrator(it)?.cancel() }
        } catch (e: Throwable) {
            Log.w(TAG, "Vibration stoppen: $e")
        }
    }

    private fun vibrator(ctx: Context): Vibrator? =
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
            (ctx.getSystemService(Context.VIBRATOR_MANAGER_SERVICE) as? VibratorManager)
                ?.defaultVibrator
        } else {
            @Suppress("DEPRECATION")
            ctx.getSystemService(Context.VIBRATOR_SERVICE) as? Vibrator
        }

    private fun vibrieren(ctx: Context) {
        val v = vibrator(ctx) ?: return
        // Eine Sekunde brummen, eine Sekunde Pause — wie ein Telefon.
        val muster = longArrayOf(0, 1000, 1000)
        try {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                // repeat = 0: von vorn, also endlos bis zum Abbrechen.
                v.vibrate(VibrationEffect.createWaveform(muster, 0))
            } else {
                @Suppress("DEPRECATION")
                v.vibrate(muster, 0)
            }
        } catch (e: Throwable) {
            Log.w(TAG, "Vibration: $e")
        }
    }

    // ------------------------------------------------------------ Entscheidung

    /**
     * Hält die Entscheidung fest UND weckt jedes lebende Dart-Isolat.
     *
     * ⚠️ Beides, nicht nur das Ereignis: tippt jemand „Ablehnen", während
     * kein Isolat läuft, erreicht der Ereigniskanal niemanden. Der Speicher
     * ist die Wahrheit, das Ereignis nur das Anklopfen.
     */
    fun entscheidungSetzen(ctx: Context, art: String, gespraechId: Int) {
        try {
            ctx.getSharedPreferences(PREFS, Context.MODE_PRIVATE)
                .edit()
                .putString(SCHLUESSEL_ENTSCHEIDUNG, "$art:$gespraechId:${System.currentTimeMillis()}")
                .apply()
        } catch (e: Throwable) {
            Log.e(TAG, "Entscheidung nicht speicherbar: $e")
        }
        IcdKlingelPlugin.anklopfen()
    }

    /**
     * Liest die Entscheidung, OHNE sie zu löschen.
     *
     * 🔴 Lesen und Löschen sind getrennt, weil ZWEI Isolate anklopfen hören:
     * das des Hintergrunddienstes und das der Oberfläche. Ein Lesen, das
     * löscht, hätte dem anderen die Entscheidung gestohlen — und weil jedes
     * nur seinen Teil erledigt (Absage braucht die stehende Verbindung,
     * Annehmen braucht WebRTC), wäre je nach Reihenfolge der eine oder der
     * andere Weg stumm ausgefallen.
     */
    fun entscheidungAnsehen(ctx: Context): String? =
        ctx.getSharedPreferences(PREFS, Context.MODE_PRIVATE)
            .getString(SCHLUESSEL_ENTSCHEIDUNG, null)

    /** Quittiert die Entscheidung — erst danach ist sie weg. */
    fun entscheidungQuittieren(ctx: Context) {
        ctx.getSharedPreferences(PREFS, Context.MODE_PRIVATE)
            .edit()
            .remove(SCHLUESSEL_ENTSCHEIDUNG)
            .apply()
    }

    // ------------------------------------------------------------ Berechtigung

    /**
     * Darf die App einen Vollbild-Intent zeigen?
     *
     * ⚠️ Erst ab Android 14 (API 34) gibt es überhaupt etwas zu prüfen. Davor
     * ist `USE_FULL_SCREEN_INTENT` eine gewöhnliche Berechtigung, die bei der
     * Installation erteilt wird — dort ist die Antwort immer „ja".
     */
    fun erlaubt(ctx: Context): Boolean {
        if (Build.VERSION.SDK_INT < 34) return true
        val mgr = ctx.getSystemService(NotificationManager::class.java) ?: return false
        return try {
            mgr.canUseFullScreenIntent()
        } catch (e: Throwable) {
            Log.w(TAG, "canUseFullScreenIntent: $e")
            false
        }
    }

    /**
     * Öffnet die Einstellung. Drei Versuche, wie beim Fenster über anderen
     * Apps: die Seite dieser App, dann die Liste, dann die App-Info.
     *
     * ⚠️ BEWUSST KEIN `resolveActivity` davor. Seit Android 11 filtert die
     * Paket-Sichtbarkeit diese Abfragen; sie kann `null` liefern, obwohl der
     * Start gelingen würde — dann hätten wir es gar nicht erst versucht.
     */
    fun einstellungOeffnen(ctx: Context): Boolean {
        val versuche = mutableListOf<Intent>()
        if (Build.VERSION.SDK_INT >= 34) {
            versuche.add(
                Intent(Settings.ACTION_MANAGE_APP_USE_FULL_SCREEN_INTENT)
                    .setData(Uri.parse("package:${ctx.packageName}")),
            )
            versuche.add(Intent(Settings.ACTION_MANAGE_APP_USE_FULL_SCREEN_INTENT))
        }
        versuche.add(
            Intent(Settings.ACTION_APPLICATION_DETAILS_SETTINGS)
                .setData(Uri.parse("package:${ctx.packageName}")),
        )
        for (i in versuche) {
            try {
                i.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                ctx.startActivity(i)
                return true
            } catch (e: Throwable) {
                Log.w(TAG, "Einstellweg fehlgeschlagen: $e")
            }
        }
        return false
    }

    // ------------------------------------------------------------------- App

    /** Holt die App nach vorne. `null`, wenn es keinen Startpunkt gibt. */
    fun appStarten(ctx: Context, gespraechId: Int): Boolean {
        // ⚠️ Über den Startpunkt des PAKETS, nicht über einen festen
        // Klassennamen: das Plugin kennt MainActivity nicht, und ein
        // abgeschriebener Name bricht bei jeder Umbenennung stumm.
        val start = try {
            ctx.packageManager.getLaunchIntentForPackage(ctx.packageName)
        } catch (e: Throwable) {
            null
        } ?: return false
        start.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_SINGLE_TOP)
        start.putExtra(EXTRA_GESPRAECH, gespraechId)
        return try {
            ctx.startActivity(start)
            true
        } catch (e: Throwable) {
            Log.e(TAG, "App nicht startbar: $e")
            false
        }
    }

    /** Bittet, den Sperrbildschirm beiseitezuschieben (nur aus einer Activity). */
    fun sperreBeiseite(act: Activity) {
        try {
            val km = act.getSystemService(Context.KEYGUARD_SERVICE) as? KeyguardManager ?: return
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                km.requestDismissKeyguard(act, null)
            }
        } catch (e: Throwable) {
            Log.w(TAG, "requestDismissKeyguard: $e")
        }
    }
}
