package de.icd360s.icd_installer

import android.app.Activity
import android.app.PendingIntent
import android.content.Context
import android.content.Intent
import android.content.IntentSender
import android.content.pm.PackageInstaller
import android.content.pm.PackageManager
import android.os.Build
import android.os.Handler
import android.os.Looper
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.PluginRegistry
import java.io.File
import java.io.FileInputStream

/**
 * APK-Installation über die PackageInstaller-Session-API — die App aktualisiert
 * sich damit selbst.
 *
 * Kopie von `packages/icd_installer` der Vorsitzer-App (17.10.2026, Wunsch des
 * Vorsitzenden: die Selbstaktualisierung „ca pe vorsitzer"). Angepasst:
 * - minSdk 24 statt 29: alles Neuere steht hinter `Build.VERSION.SDK_INT`;
 * - das Paket (122 MB) wird NICHT auf dem Hauptfaden in die Session
 *   geschrieben — sonst stünde die Oberfläche, bis es drin ist (dasselbe tut
 *   `UpdateFenster` der Vorsitzer-App);
 * - [kannOhneNachfrage]: ob Android das Update ohne Rückfrage einspielen würde.
 *
 * Ablauf: Session anlegen → APK hineinschreiben → commit mit einem
 * PendingIntent auf die eigene Activity. Android meldet sich dann über
 * onNewIntent (MainActivity ist `singleTop`): erst STATUS_PENDING_USER_ACTION
 * mit dem Bestätigungsdialog, den wir starten; nach der Entscheidung des
 * Nutzers der Endstatus, den wir an Dart zurückgeben.
 *
 * ⚠️ Bei einer Selbst-Aktualisierung kommt der Erfolgsstatus NIE an — Android
 * beendet den Prozess, während es das Paket ersetzt. Dart darf auf diese
 * Antwort deshalb nichts Wichtiges aufbauen; ein Abbruch durch den Nutzer
 * (STATUS_FAILURE_ABORTED) kommt dagegen sehr wohl.
 *
 * Kern übernommen aus android_package_installer 0.0.3 (BSD-3-Clause,
 * Copyright (c) 2022, Rovshan Gurbanov). Geändert: kein statisches
 * `lateinit`-Result mehr (zweiter Aufruf → „Reply already submitted"-Absturz),
 * Fehler gehen als Fehler zurück statt als Status „unbekannt", Datei wird vor
 * dem Anlegen der Session geprüft, PACKAGE_SOURCE_OTHER ab Android 13.
 */
class IcdInstallerPlugin : FlutterPlugin, ActivityAware, MethodChannel.MethodCallHandler,
    PluginRegistry.NewIntentListener {

    private lateinit var kanal: MethodChannel
    private lateinit var context: Context
    private var activity: Activity? = null
    private var binding: ActivityPluginBinding? = null
    private val haupt = Handler(Looper.getMainLooper())

    /** Das Result des laufenden Aufrufs — genau eines, nie statisch. */
    private var offen: MethodChannel.Result? = null

    /**
     * Schreibt gerade ein Aufruf sein Paket in die Session? Ein zweiter würde
     * die noch nicht übergebene Session als Rest ansehen und verwerfen
     * ([wartetSchon]) — dann scheiterte der erste beim Übergeben.
     */
    private var schreibt = false

    override fun onAttachedToEngine(b: FlutterPlugin.FlutterPluginBinding) {
        context = b.applicationContext
        kanal = MethodChannel(b.binaryMessenger, KANAL)
        kanal.setMethodCallHandler(this)
    }

    override fun onDetachedFromEngine(b: FlutterPlugin.FlutterPluginBinding) {
        kanal.setMethodCallHandler(null)
    }

    override fun onAttachedToActivity(b: ActivityPluginBinding) {
        activity = b.activity
        binding = b
        b.addOnNewIntentListener(this)
    }

    override fun onDetachedFromActivityForConfigChanges() = onDetachedFromActivity()
    override fun onReattachedToActivityForConfigChanges(b: ActivityPluginBinding) = onAttachedToActivity(b)

    override fun onDetachedFromActivity() {
        binding?.removeOnNewIntentListener(this)
        binding = null
        activity = null
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "installApk" -> installieren(
                call.argument<String>("pfad"),
                call.argument<Boolean>("ohneNachfrage") == true,
                result,
            )
            "kannOhneNachfrage" -> result.success(kannOhneNachfrage(context))
            else -> result.notImplemented()
        }
    }

    private fun installieren(pfad: String?, ohneNachfrage: Boolean, result: MethodChannel.Result) {
        if (activity == null) {
            result.error("KEINE_ACTIVITY", "Installation braucht eine sichtbare Activity", null)
            return
        }
        if (pfad.isNullOrEmpty() || !File(pfad).isFile) {
            result.error("DATEI_FEHLT", "APK nicht gefunden: $pfad", null)
            return
        }
        if (schreibt) {
            result.success(STATUS_LAEUFT)
            return
        }
        schreibt = true
        Thread({
            val id = try {
                sessionSchreiben(context, pfad, ohneNachfrage)
            } catch (e: Exception) {
                haupt.post {
                    schreibt = false
                    result.error("SESSION", e.message ?: e.javaClass.simpleName, null)
                }
                return@Thread
            }
            haupt.post {
                schreibt = false
                uebergebenAn(id, result)
            }
        }, "update-schreiben").start()
    }

    /** Auf dem Hauptfaden: die geschriebene Session [id] an Android geben. */
    private fun uebergebenAn(id: Int, result: MethodChannel.Result) {
        if (id == STATUS_LAEUFT) {
            result.success(STATUS_LAEUFT)
            return
        }
        val act = activity
        if (act == null) {
            // Die App ging zu, während geschrieben wurde: der Stand hätte kein
            // Ziel mehr. Nicht übergeben — beim nächsten Mal von vorn.
            try {
                context.packageManager.packageInstaller.abandonSession(id)
            } catch (e: Exception) {
                // Schon weg.
            }
            result.error("KEINE_ACTIVITY", "Die App ging zu, bevor das Paket übergeben war", null)
            return
        }
        // Ein noch offener Aufruf bekommt eine Antwort, bevor er ersetzt wird —
        // sonst hinge sein Future für immer, und das zweite Result stürzte
        // beim Doppel-Reply ab.
        offen?.error("ERSETZT", "Neuer Installationsaufruf hat den vorigen ersetzt", null)
        offen = result
        try {
            val intent = Intent(context, act.javaClass).setAction(AKTION)
            // Android trägt den Stand als Extras ein — ab Android 12 also
            // ausdrücklich veränderlich.
            val flags = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
                PendingIntent.FLAG_MUTABLE or PendingIntent.FLAG_UPDATE_CURRENT
            } else {
                PendingIntent.FLAG_UPDATE_CURRENT
            }
            val pi = PendingIntent.getActivity(context, id, intent, flags)
            uebergeben(context, id, pi.intentSender)
        } catch (e: Exception) {
            offen = null
            result.error("SESSION", e.message ?: e.javaClass.simpleName, null)
        }
    }

    override fun onNewIntent(intent: Intent): Boolean {
        if (intent.action != AKTION) return false
        val extras = intent.extras ?: return false
        when (val status = extras.getInt(PackageInstaller.EXTRA_STATUS, STATUS_UNBEKANNT)) {
            PackageInstaller.STATUS_PENDING_USER_ACTION -> {
                @Suppress("DEPRECATION")
                val bestaetigen = extras.get(Intent.EXTRA_INTENT) as? Intent
                if (bestaetigen == null) {
                    offen?.success(PackageInstaller.STATUS_FAILURE)
                    offen = null
                } else {
                    bestaetigen.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TOP)
                    activity?.startActivity(bestaetigen)
                }
            }
            else -> {
                offen?.success(status)
                offen = null
            }
        }
        return true
    }

    companion object {
        /**
         * Würde Android ein Update DIESER App jetzt ohne Rückfrage einspielen?
         *
         * Die Bedingungen aus `PackageInstaller.SessionParams.setRequireUserAction`:
         * ab Android 12; „Apps aus unbekannten Quellen installieren" ist für die
         * App erlaubt; `UPDATE_PACKAGES_WITHOUT_USER_ACTION` steht im Manifest;
         * und kein Store hat sich die Updates vorbehalten (Update-Besitzer, ab
         * Android 14 — der ginge sogar vor der Selbstaktualisierung). Die
         * Zielversion (targetSdk) prüft erst Android selbst; reicht sie nicht,
         * fragt es eben (STATUS_PENDING_USER_ACTION).
         */
        @JvmStatic
        fun kannOhneNachfrage(ctx: Context): Boolean {
            if (Build.VERSION.SDK_INT < Build.VERSION_CODES.S) return false
            val pm = ctx.packageManager
            if (!pm.canRequestPackageInstalls()) return false
            val erklaert = try {
                @Suppress("DEPRECATION")
                pm.getPackageInfo(ctx.packageName, PackageManager.GET_PERMISSIONS).requestedPermissions
            } catch (e: Exception) {
                null
            }
            if (erklaert?.contains(UPDATE_OHNE_NACHFRAGE) != true) return false
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.UPSIDE_DOWN_CAKE) {
                val besitzer = try {
                    pm.getInstallSourceInfo(ctx.packageName).updateOwnerPackageName
                } catch (e: Exception) {
                    null
                }
                if (besitzer != null && besitzer != ctx.packageName) return false
            }
            return true
        }

        /**
         * Legt eine Session für [pfad] an und schreibt das APK hinein — übergibt
         * sie aber NICHT (das tut [uebergeben]). Liefert die Nummer der Session
         * oder [STATUS_LAEUFT], wenn schon eine Installation dieses Pakets
         * wartet. Wirft, wenn Anlegen oder Schreiben scheitert; die Session ist
         * dann schon verworfen.
         */
        @JvmStatic
        fun sessionSchreiben(ctx: Context, pfad: String, ohneNachfrage: Boolean): Int {
            val installer = ctx.packageManager.packageInstaller
            val ziel = zielpaket(ctx.packageManager, pfad)
            // ⚠️ EINE Installation je Paket auf einmal (Vorsitzer-App, 14.10.2026:
            // zwei Bestätigungsdialoge, zwei Installationen derselben Fassung,
            // die App zweimal binnen Sekunden beendet).
            if (ziel != null && wartetSchon(installer, ziel)) return STATUS_LAEUFT

            var session: PackageInstaller.Session? = null
            try {
                val params = PackageInstaller.SessionParams(PackageInstaller.SessionParams.MODE_FULL_INSTALL)
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                    params.setInstallReason(PackageManager.INSTALL_REASON_USER)
                }
                // Damit [wartetSchon] die Session schon vor dem Prüfen des APK
                // dem Paket zuordnen kann.
                if (ziel != null) params.setAppPackageName(ziel)
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
                    params.setPackageSource(PackageInstaller.PACKAGE_SOURCE_OTHER)
                }
                // Nur ein UPDATE, mit dem die App sich selbst ersetzt, und nur mit
                // UPDATE_PACKAGES_WITHOUT_USER_ACTION im Manifest der App läuft
                // ohne Dialog. Fehlt eins davon, fragt das System wie immer
                // (STATUS_PENDING_USER_ACTION).
                if (ohneNachfrage && Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
                    params.setRequireUserAction(PackageInstaller.SessionParams.USER_ACTION_NOT_REQUIRED)
                }
                val id = installer.createSession(params)
                val s = installer.openSession(id)
                session = s
                s.openWrite("package", 0, -1).use { out ->
                    FileInputStream(pfad).use { inp ->
                        val puffer = ByteArray(64 * 1024)
                        var n: Int
                        while (inp.read(puffer).also { n = it } >= 0) out.write(puffer, 0, n)
                        s.fsync(out)
                    }
                }
                s.close()
                return id
            } catch (e: Exception) {
                session?.abandon()
                throw e
            }
        }

        /**
         * Übergibt die geschriebene Session [id] ([sessionSchreiben]); Android
         * meldet den Stand an [status]. Wirft — und verwirft die Session —,
         * wenn das Übergeben scheitert.
         */
        @JvmStatic
        fun uebergeben(ctx: Context, id: Int, status: IntentSender) {
            val session = ctx.packageManager.packageInstaller.openSession(id)
            try {
                session.commit(status)
                session.close()
            } catch (e: Exception) {
                session.abandon()
                throw e
            }
        }

        /** Das Paket im APK, ohne es zu installieren — `null`, wenn unlesbar. */
        private fun zielpaket(pm: PackageManager, pfad: String): String? = try {
            @Suppress("DEPRECATION")
            pm.getPackageArchiveInfo(pfad, 0)?.packageName
        } catch (e: Exception) {
            null
        }

        /**
         * Wartet schon eine Installation von [ziel] — übergeben, der
         * Bestätigungsdialog offen oder die Installation unterwegs?
         *
         * Aufgeräumt wird dabei, nur für [ziel] (und Reste ohne Paketnamen):
         * - nicht übergebene Sessions: Reste eines Prozesses, der beim Schreiben
         *   starb ([schreibt] hält die eigene, noch schreibende fern);
         * - übergebene, die älter als [HAENGT_NACH_MS] sind: deren Dialog kam nie
         *   (oder steht vergessen irgendwo). Sonst sperrte eine solche Session
         *   jedes weitere Update bis zum Neustart des Telefons;
         * - vor Android 10 jede: ob eine Session übergeben ist, verrät Android
         *   dort nicht — lieber neu anfangen als für immer warten.
         */
        private fun wartetSchon(installer: PackageInstaller, ziel: String): Boolean {
            var wartet = false
            for (s in installer.mySessions) {
                val fremd = s.appPackageName != null && s.appPackageName != ziel
                val uebergeben = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) s.isCommitted else false
                val haengt = Build.VERSION.SDK_INT >= Build.VERSION_CODES.R &&
                    System.currentTimeMillis() - s.createdMillis > HAENGT_NACH_MS
                val weg = !fremd && (!uebergeben || haengt)
                if (!fremd && !weg) wartet = true
                if (weg) {
                    try {
                        installer.abandonSession(s.sessionId)
                    } catch (e: Exception) {
                        // Schon fertig oder nicht mehr unsere — dann ist sie ohnehin weg.
                    }
                }
            }
            return wartet
        }

        const val KANAL = "de.icd360s.mitglied/installer"
        const val AKTION = "de.icd360s.icd_installer.SESSION_STATUS"
        const val STATUS_UNBEKANNT = -2

        /** Eine Installation dieses Pakets wartet schon — keine zweite. */
        const val STATUS_LAEUFT = -3

        /** Ab wann eine übergebene Session als hängengeblieben gilt. */
        const val HAENGT_NACH_MS = 10 * 60 * 1000L

        private const val UPDATE_OHNE_NACHFRAGE = "android.permission.UPDATE_PACKAGES_WITHOUT_USER_ACTION"
    }
}
