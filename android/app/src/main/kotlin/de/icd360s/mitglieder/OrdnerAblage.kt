package de.icd360s.mitglieder

import android.app.Activity
import android.content.Context
import android.content.Intent
import android.net.Uri
import android.os.Handler
import android.os.Looper
import android.provider.DocumentsContract
import android.util.Log
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.util.concurrent.Executors

/**
 * Mehrere Dateien in einen Ordner, den das Mitglied waehlt -- fuer
 * „PDF in Bilder" (lib/utils/ordner_ablage.dart).
 *
 * Der amtliche Weg dafuer ist das Storage Access Framework: Ordner waehlen
 * mit ACTION_OPEN_DOCUMENT_TREE, Dateien anlegen mit
 * DocumentsContract.createDocument. Ein Pfad und `File` reichen ab Android 11
 * nicht: ohne Sonderrecht darf eine App nur in einige Systemordner schreiben
 * (Download/, Documents/, Pictures/ ...); ein selbst angelegter Ordner im
 * Wurzelverzeichnis oder die SD-Karte scheitern. Ueber den gewaehlten Baum
 * gilt die Freigabe fuer genau diesen Ordner, wo immer er liegt.
 *
 * Gleichnamiges ueberschreibt der Anbieter nicht, er haengt „ (1)" an.
 *
 * WARNUNG Ab Android 11 laesst die Auswahl Download/ selbst, das
 * Wurzelverzeichnis und Android/data nicht zu -- einen Unterordner schon, und
 * den kann man im Auswahlfenster anlegen. Das ist eine Regel des Systems.
 *
 * WARNUNG Im Protokoll stehen nie Datei- oder Ordnernamen: es sind private
 * Dokumente der Mitglieder.
 */
internal object OrdnerAblage {
    const val KANAL = "de.icd360sev.mitglied/ordner_ablage"

    /** Anfragekennung fuer onActivityResult. */
    const val ANFRAGE = 0x4F52

    private const val TAG = "OrdnerAblage"

    private val haupt = Handler(Looper.getMainLooper())

    /** Eine Datei nach der anderen -- nie zwei Schreibvorgaenge zugleich. */
    private val schreiber = Executors.newSingleThreadExecutor()

    /** Die Antwort auf die offene Auswahl, bis das System zurueckkommt. */
    private var offen: MethodChannel.Result? = null

    fun anbinden(a: Activity, engine: FlutterEngine) {
        val app = a.applicationContext
        MethodChannel(engine.dartExecutor.binaryMessenger, KANAL)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "waehlen" -> waehlen(a, result)
                    "schreiben" -> schreiben(
                        app,
                        call.argument<String>("ordner") ?: "",
                        call.argument<String>("name") ?: "",
                        call.argument<String>("mime") ?: "application/octet-stream",
                        call.argument<ByteArray>("bytes") ?: ByteArray(0),
                        result,
                    )
                    // Nichts freizugeben: die Freigabe des Baums endet mit dem
                    // Prozess. Der Aufruf ist da, damit Dart auf beiden
                    // Systemen dasselbe tun kann.
                    "schliessen" -> result.success(null)
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
            val i = Intent(Intent.ACTION_OPEN_DOCUMENT_TREE).addFlags(
                Intent.FLAG_GRANT_READ_URI_PERMISSION or
                    Intent.FLAG_GRANT_WRITE_URI_PERMISSION
            )
            a.startActivityForResult(i, ANFRAGE)
        } catch (e: Throwable) {
            Log.w(TAG, "Ordnerauswahl nicht zu oeffnen: ${e.javaClass.simpleName}")
            offen = null
            result.error("keine_auswahl", e.message, null)
        }
    }

    /** Aus [MainActivity.onActivityResult]. `true`: es war unsere Anfrage. */
    fun ergebnis(a: Activity, anfrage: Int, code: Int, daten: Intent?): Boolean {
        if (anfrage != ANFRAGE) return false
        val r = offen ?: return true
        offen = null
        val baum = daten?.data
        if (code != Activity.RESULT_OK || baum == null) {
            r.success(null)
            return true
        }
        r.success(mapOf("ordner" to baum.toString(), "name" to anzeigeName(a, baum)))
        return true
    }

    /** Das Dokument, fuer das der Baum steht -- der Ordner selbst. */
    private fun ordnerDokument(baum: Uri): Uri =
        DocumentsContract.buildDocumentUriUsingTree(
            baum,
            DocumentsContract.getTreeDocumentId(baum),
        )

    private fun anzeigeName(c: Context, baum: Uri): String =
        try {
            name(c, ordnerDokument(baum))
        } catch (_: Throwable) {
            null
        } ?: ""

    private fun name(c: Context, dokument: Uri): String? =
        c.contentResolver.query(
            dokument,
            arrayOf(DocumentsContract.Document.COLUMN_DISPLAY_NAME),
            null,
            null,
            null,
        )?.use { z -> if (z.moveToFirst()) z.getString(0) else null }

    private fun schreiben(
        c: Context,
        ordner: String,
        name: String,
        mime: String,
        bytes: ByteArray,
        result: MethodChannel.Result,
    ) {
        schreiber.execute {
            try {
                val datei = DocumentsContract.createDocument(
                    c.contentResolver,
                    ordnerDokument(Uri.parse(ordner)),
                    mime,
                    name,
                ) ?: throw IllegalStateException("createDocument ohne Ergebnis")
                try {
                    val aus = c.contentResolver.openOutputStream(datei, "w")
                        ?: throw IllegalStateException("kein Ausgabestrom")
                    aus.use { it.write(bytes) }
                } catch (e: Throwable) {
                    // Eine halb geschriebene Datei saehe im Dateimanager fertig
                    // aus -- lieber gar keine.
                    try {
                        DocumentsContract.deleteDocument(c.contentResolver, datei)
                    } catch (_: Throwable) {
                    }
                    throw e
                }
                val wirklich = try {
                    name(c, datei)
                } catch (_: Throwable) {
                    null
                } ?: name
                haupt.post { result.success(wirklich) }
            } catch (e: Throwable) {
                Log.w(TAG, "Schreiben fehlgeschlagen: ${e.javaClass.simpleName}")
                haupt.post { result.error("schreiben", e.message, null) }
            }
        }
    }
}
