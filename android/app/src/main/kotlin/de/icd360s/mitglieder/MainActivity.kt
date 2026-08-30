package de.icd360s.mitglieder

import android.app.usage.UsageStatsManager
import android.content.Context
import android.content.Intent
import android.os.BatteryManager
import android.os.Build
import android.os.Bundle
import android.os.PowerManager
import android.provider.Settings
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
        const val BATTERY_CHANNEL = "de.icd360sev.mitglied/battery_state"
        const val STEUERUNG_CHANNEL = "de.icd360sev.mitglied/fernsteuerung"
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

        // Fernwartung: Fernsteuerung ueber den AccessibilityService.
        //
        // ⚠️ Im App-Modul und nicht in einem Plugin — dieselbe Begruendung wie
        // beim Untertitel-Kanal des Vorsitzer-Projekts: Plugins braucht, wer im
        // HINTERGRUND-Isolat arbeitet. Fernwartung laeuft ausschliesslich im
        // Vordergrund, und der Dienst liegt ohnehin in diesem Modul.
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, STEUERUNG_CHANNEL)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    // Grundwahrheit statt Settings.Secure-Stringsuche: der Dienst
                    // setzt seine Instanz, sobald das System ihn verbunden hat.
                    // Die Einstellungszeile kann veraltet sein, die Instanz nicht.
                    "verfuegbar" -> result.success(FernwartungService.instanz != null)

                    // Zweites Schloss. Wird nur fuer die Dauer einer vom Mitglied
                    // zugestimmten Sitzung aufgesperrt.
                    "freigeben" -> {
                        FernwartungService.freigegeben = call.argument<Boolean>("frei") ?: false
                        Log.d(TAG, "Fernsteuerung freigegeben=${FernwartungService.freigegeben}")
                        result.success(null)
                    }

                    "zug" -> {
                        val d = FernwartungService.instanz
                        if (d == null) {
                            result.success(false)
                        } else {
                            result.success(
                                d.zug(
                                    call.argument<Double>("x1") ?: 0.0,
                                    call.argument<Double>("y1") ?: 0.0,
                                    call.argument<Double>("x2") ?: 0.0,
                                    call.argument<Double>("y2") ?: 0.0,
                                    (call.argument<Number>("ms") ?: 60).toLong()
                                )
                            )
                        }
                    }

                    "aktion" -> {
                        val d = FernwartungService.instanz
                        result.success(
                            d?.globaleAktion(call.argument<String>("name") ?: "") ?: false
                        )
                    }

                    // Das Mitglied schaltet den Dienst selbst ein; eine App kann
                    // sich diese Berechtigung nicht erteilen. Wir koennen nur die
                    // Systemseite oeffnen.
                    "einstellungenOeffnen" -> {
                        try {
                            startActivity(
                                Intent(Settings.ACTION_ACCESSIBILITY_SETTINGS)
                                    .addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                            )
                            result.success(true)
                        } catch (e: Exception) {
                            Log.w(TAG, "Bedienungshilfen nicht zu oeffnen: ${e.message}")
                            result.success(false)
                        }
                    }

                    else -> result.notImplemented()
                }
            }

        // Akku-Messung: liefert den Energiezustand, den battery_plus nicht
        // kennt. Alles rein lokal — nur Binder-Aufrufe, kein Funkmodem.
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, BATTERY_CHANNEL)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "read" -> result.success(readBatteryState())
                    else -> result.notImplemented()
                }
            }
    }

    /**
     * Energiezustand für die Verbrauchsmessung.
     *
     * Bewusst NICHT dabei: der Verbrauch dieser App allein. Android hält die
     * Zuordnung pro UID in BatteryStatsManager.getUidStats bzw. HealthStats,
     * beides @SystemApi und nur für Systemanwendungen zugänglich. Was hier
     * zurückkommt, ist Gerätezustand plus die Einstufung, die Android dieser
     * App gegeben hat — mehr gibt die Plattform einer normalen App nicht.
     *
     * Jeder Block fängt einzeln ab: Hersteller-ROMs liefern für einzelne
     * Properties gern eine Exception oder Int.MIN_VALUE, und ein fehlendes
     * Feld ist besser als eine fehlgeschlagene Messung.
     */
    private fun readBatteryState(): Map<String, Any?> {
        val out = HashMap<String, Any?>()

        try {
            val pm = getSystemService(Context.POWER_SERVICE) as PowerManager
            out["power_save_mode"] = pm.isPowerSaveMode
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                out["doze_exempt"] = pm.isIgnoringBatteryOptimizations(packageName)
            }
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
                out["thermal_status"] = pm.currentThermalStatus
            }
        } catch (e: Exception) {
            Log.w(TAG, "PowerManager nicht lesbar: ${e.message}")
        }

        // Standby-Bucket der eigenen App: 10 active, 20 working_set,
        // 30 frequent, 40 rare, 45 restricted. Für die eigene App ohne
        // Berechtigung lesbar. Rutscht der Wert auf 40+, hat Android die App
        // bereits gedrosselt — das erklärt Messwerte, die sonst unerklärlich
        // gut aussehen.
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.P) {
            try {
                val usm = getSystemService(Context.USAGE_STATS_SERVICE) as UsageStatsManager
                out["standby_bucket"] = usm.appStandbyBucket
            } catch (e: Exception) {
                Log.w(TAG, "Standby-Bucket nicht lesbar: ${e.message}")
            }
        }

        try {
            val bm = getSystemService(Context.BATTERY_SERVICE) as BatteryManager

            // Momentanstrom in µA. Vorzeichen ist herstellerabhängig (manche
            // melden Entladung negativ, manche positiv), Betrag ist die
            // brauchbare Grösse. Nicht implementierte Properties kommen als
            // Int.MIN_VALUE oder 0 zurück.
            val current = bm.getIntProperty(BatteryManager.BATTERY_PROPERTY_CURRENT_NOW)
            if (current != Int.MIN_VALUE && current != 0) {
                out["current_now_ua"] = current
            }

            // Verbleibende Ladung in µAh. Das ist der wichtigste Wert hier:
            // der Akkustand in Prozent ist ganzzahlig, was über ein kurzes
            // Fenster einen Messfehler von mehreren %/h bedeutet. CHARGE_
            // COUNTER löst dieselbe Entladung um Grössenordnungen feiner auf
            // und macht Vorher/Nachher-Vergleiche auf Android überhaupt erst
            // belastbar.
            val charge = bm.getIntProperty(BatteryManager.BATTERY_PROPERTY_CHARGE_COUNTER)
            if (charge > 0) {
                out["charge_counter_uah"] = charge
            }
        } catch (e: Exception) {
            Log.w(TAG, "BatteryManager nicht lesbar: ${e.message}")
        }

        return out
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
