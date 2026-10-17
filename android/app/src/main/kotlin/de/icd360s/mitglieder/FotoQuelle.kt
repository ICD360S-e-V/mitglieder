package de.icd360s.mitglieder

import android.app.Activity
import android.content.Context
import android.content.Intent
import android.net.Uri
import android.os.Handler
import android.os.Looper
import android.provider.OpenableColumns
import android.util.Log
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

/**
 * Ein einzelnes Foto fuer „Foto bearbeiten" (lib/utils/foto_quelle.dart).
 *
 * WARNUNG Bewusst die Dateiauswahl des Systems (ACTION_OPEN_DOCUMENT) und
 * NICHT die Fotoauswahl: nach dem Speichern fragt die App, ob das Original
 * weg soll. Fuer ein Dokument aus ACTION_OPEN_DOCUMENT beschreibt Android
 * genau das (Lese- und Schreibrecht, DocumentsContract.deleteDocument); fuer
 * die Adressen der Fotoauswahl gibt es keinen dokumentierten Weg zum Loeschen.
 * Die Dateiauswahl zeigt trotzdem „Bilder", „Zuletzt" und „Downloads".
 *
 * WARNUNG Im Protokoll stehen nie Dateinamen.
 */
internal object FotoQuelle {
    const val KANAL = "de.icd360sev.mitglied/foto_quelle"

    /** Anfragekennung fuer onActivityResult. */
    const val ANFRAGE = 0x4651

    private const val TAG = "FotoQuelle"

    private val haupt = Handler(Looper.getMainLooper())

    /** Die Antwort auf die offene Auswahl, bis das System zurueckkommt. */
    private var offen: MethodChannel.Result? = null

    fun anbinden(a: Activity, engine: FlutterEngine) {
        val app = a.applicationContext
        MethodChannel(engine.dartExecutor.binaryMessenger, KANAL)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "waehlen" -> waehlen(a, result)
                    "lesen" -> lesen(app, call.argument<String>("datei") ?: "", result)
                    "loeschen" -> FotoDateien.loeschen(
                        a,
                        Uri.parse(call.argument<String>("datei") ?: ""),
                        result,
                    )
                    else -> result.notImplemented()
                }
            }
    }

    private fun waehlen(a: Activity, result: MethodChannel.Result) {
        // Eine zweite Auswahl, solange die erste noch offen ist, beendet die
        // erste mit „abgebrochen" -- sonst wartete Dart dort ewig.
        offen?.success(null)
        offen = result
        try {
            val i = Intent(Intent.ACTION_OPEN_DOCUMENT)
                .addCategory(Intent.CATEGORY_OPENABLE)
                .setType("image/*")
                .putExtra(
                    Intent.EXTRA_MIME_TYPES,
                    arrayOf(
                        "image/jpeg", "image/png", "image/webp", "image/heic",
                        "image/heif", "image/bmp", "image/gif",
                    ),
                )
                .addFlags(
                    Intent.FLAG_GRANT_READ_URI_PERMISSION or
                        Intent.FLAG_GRANT_WRITE_URI_PERMISSION
                )
            a.startActivityForResult(i, ANFRAGE)
        } catch (e: Throwable) {
            Log.w(TAG, "Dateiauswahl nicht zu oeffnen: ${e.javaClass.simpleName}")
            offen = null
            result.error("keine_auswahl", e.message, null)
        }
    }

    /** Aus [MainActivity.onActivityResult]. `true`: es war unsere Anfrage. */
    fun ergebnis(a: Activity, anfrage: Int, code: Int, daten: Intent?): Boolean {
        if (anfrage != ANFRAGE) return false
        val r = offen ?: return true
        offen = null
        val uri = daten?.data
        if (code != Activity.RESULT_OK || uri == null) {
            r.success(null)
            return true
        }
        r.success(
            mapOf(
                "schluessel" to uri.toString(),
                "name" to (FotoDateien.anzeigeName(a, uri) ?: ""),
                "groesse" to groesse(a, uri),
                "fotosApp" to false,
            )
        )
        return true
    }

    private fun groesse(c: Context, uri: Uri): Long? =
        try {
            c.contentResolver.query(uri, arrayOf(OpenableColumns.SIZE), null, null, null)
                ?.use { z -> if (z.moveToFirst() && !z.isNull(0)) z.getLong(0) else null }
        } catch (_: Throwable) {
            null
        }

    private fun lesen(c: Context, datei: String, result: MethodChannel.Result) {
        FotoDateien.leser.execute {
            try {
                val bytes = FotoDateien.lesen(c, Uri.parse(datei))
                haupt.post { result.success(bytes) }
            } catch (e: Throwable) {
                Log.w(TAG, "Lesen fehlgeschlagen: ${e.javaClass.simpleName}")
                haupt.post { result.error("lesen", e.message, null) }
            }
        }
    }
}
