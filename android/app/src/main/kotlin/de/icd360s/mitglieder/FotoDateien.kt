package de.icd360s.mitglieder

import android.annotation.TargetApi
import android.app.Activity
import android.content.Context
import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.graphics.ImageDecoder
import android.graphics.Point
import android.net.Uri
import android.os.Build
import android.os.Handler
import android.os.Looper
import android.provider.DocumentsContract
import android.provider.MediaStore
import android.util.Log
import android.util.Size
import io.flutter.plugin.common.MethodChannel
import java.io.ByteArrayOutputStream
import java.nio.ByteBuffer
import java.util.concurrent.ExecutorService
import java.util.concurrent.Executors

/**
 * Lesen, Vorschau und Loeschen von Fotos fuer „Foto bearbeiten" -- gemeinsam
 * fuer den gewaehlten Ordner ([OrdnerAblage]) und das einzelne Foto
 * ([FotoQuelle]).
 *
 * Geloescht wird zuerst ueber den Anbieter (DocumentsContract.deleteDocument,
 * wenn das Dokument FLAG_SUPPORTS_DELETE hat -- der amtliche Weg im Storage
 * Access Framework). Kann der Anbieter es nicht, ab Android 11 ueber die
 * Mediathek: MediaStore.createDeleteRequest. Dann fragt Android selbst noch
 * einmal nach -- Regel des Systems fuer Fotos, die die App nicht angelegt hat.
 *
 * WARNUNG Im Protokoll stehen nie Datei- oder Ordnernamen: es sind private
 * Fotos der Mitglieder.
 */
internal object FotoDateien {
    private const val TAG = "FotoDateien"

    /** Anfragekennung fuer die Loesch-Rueckfrage von Android. */
    const val LOESCHEN = 0x464C

    private val haupt = Handler(Looper.getMainLooper())

    /** Lesen und Vorschauen nebeneinander: die Uebersicht laedt viele kleine Bilder. */
    val leser: ExecutorService = Executors.newFixedThreadPool(3)

    /** Loeschen eins nach dem anderen. */
    private val loescher = Executors.newSingleThreadExecutor()

    /** Die Antwort auf die offene Rueckfrage von Android. */
    private var offen: MethodChannel.Result? = null

    private val FOTO_MIME = setOf(
        "image/jpeg", "image/png", "image/webp", "image/heic", "image/heif",
        "image/bmp", "image/x-ms-bmp", "image/gif",
    )
    private val FOTO_ENDUNG = setOf("jpg", "jpeg", "png", "webp", "heic", "heif", "bmp", "gif")

    /** Dieselbe Liste wie `fotoEndungen` in lib/utils/foto_bearbeiten.dart. */
    fun istFoto(mime: String?, name: String): Boolean =
        (mime != null && mime in FOTO_MIME) || endung(name) in FOTO_ENDUNG

    private fun endung(name: String): String = name.substringAfterLast('.', "").lowercase()

    private fun istHeic(mime: String?, name: String): Boolean =
        mime == "image/heic" || mime == "image/heif" || endung(name) == "heic" || endung(name) == "heif"

    fun anzeigeName(c: Context, uri: Uri): String? =
        try {
            c.contentResolver.query(
                uri,
                arrayOf(DocumentsContract.Document.COLUMN_DISPLAY_NAME),
                null,
                null,
                null,
            )?.use { z -> if (z.moveToFirst()) z.getString(0) else null }
        } catch (_: Throwable) {
            null
        }

    /**
     * Die Bytes des Fotos. HEIC kommt als JPG: Flutter kann es nicht auf jedem
     * Geraet dekodieren, ImageDecoder ab Android 9 schon -- und dreht dabei
     * gleich aufrecht.
     */
    fun lesen(c: Context, uri: Uri): ByteArray {
        val r = c.contentResolver
        val roh = r.openInputStream(uri)?.use { it.readBytes() }
            ?: throw IllegalStateException("kein Eingabestrom")
        val heic = istHeic(r.getType(uri), anzeigeName(c, uri) ?: "")
        if (!heic || Build.VERSION.SDK_INT < Build.VERSION_CODES.P) return roh
        return heicAlsJpg(roh) ?: roh
    }

    @TargetApi(Build.VERSION_CODES.P)
    private fun heicAlsJpg(roh: ByteArray): ByteArray? =
        try {
            val bild = ImageDecoder.decodeBitmap(ImageDecoder.createSource(ByteBuffer.wrap(roh))) { d, _, _ ->
                d.allocator = ImageDecoder.ALLOCATOR_SOFTWARE
            }
            jpg(bild, 95)
        } catch (e: Throwable) {
            Log.w(TAG, "HEIC nicht umzuwandeln: ${e.javaClass.simpleName}")
            null
        }

    private fun jpg(bild: Bitmap, qualitaet: Int): ByteArray =
        ByteArrayOutputStream().use { aus ->
            bild.compress(Bitmap.CompressFormat.JPEG, qualitaet, aus)
            bild.recycle()
            aus.toByteArray()
        }

    /** Ein kleines JPG fuer die Uebersicht; `null`, wenn sich keins machen laesst. */
    fun vorschau(c: Context, uri: Uri, kante: Int): ByteArray? {
        val bild = try {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
                // Faellt selbst auf das ganze Bild zurueck, wenn der Anbieter
                // keine Vorschau hat, und dreht aufrecht.
                c.contentResolver.loadThumbnail(uri, Size(kante, kante), null)
            } else {
                DocumentsContract.getDocumentThumbnail(c.contentResolver, uri, Point(kante, kante), null)
            }
        } catch (_: Throwable) {
            null
        } ?: verkleinert(c, uri, kante) ?: return null
        return jpg(bild, 80)
    }

    /** Ohne Vorschau vom Anbieter (vor Android 10): selbst verkleinert dekodieren. */
    private fun verkleinert(c: Context, uri: Uri, kante: Int): Bitmap? =
        try {
            val masse = BitmapFactory.Options().apply { inJustDecodeBounds = true }
            c.contentResolver.openInputStream(uri)?.use { BitmapFactory.decodeStream(it, null, masse) }
            var faktor = 1
            while (masse.outWidth / (faktor * 2) >= kante && masse.outHeight / (faktor * 2) >= kante) {
                faktor *= 2
            }
            val optionen = BitmapFactory.Options().apply { inSampleSize = faktor }
            c.contentResolver.openInputStream(uri)?.use { BitmapFactory.decodeStream(it, null, optionen) }
        } catch (_: Throwable) {
            null
        }

    /** `true` an Dart: das Foto ist weg. */
    fun loeschen(a: Activity, uri: Uri, result: MethodChannel.Result) {
        val c = a.applicationContext
        loescher.execute {
            val geloescht = try {
                DocumentsContract.deleteDocument(c.contentResolver, uri)
            } catch (e: Throwable) {
                Log.w(TAG, "Loeschen ueber den Anbieter: ${e.javaClass.simpleName}")
                false
            }
            if (geloescht) {
                haupt.post { result.success(true) }
                return@execute
            }
            if (Build.VERSION.SDK_INT < Build.VERSION_CODES.R) {
                haupt.post { result.success(false) }
                return@execute
            }
            // Dieselbe Datei als Eintrag der Mediathek -- nur dafuer gibt es
            // die Rueckfrage. Neue Rechte gibt das nicht.
            val media = try {
                MediaStore.getMediaUri(c, uri)
            } catch (e: Throwable) {
                Log.w(TAG, "Kein Eintrag in der Mediathek: ${e.javaClass.simpleName}")
                null
            }
            if (media == null) {
                haupt.post { result.success(false) }
                return@execute
            }
            haupt.post { rueckfrage(a, media, result) }
        }
    }

    @TargetApi(Build.VERSION_CODES.R)
    private fun rueckfrage(a: Activity, media: Uri, result: MethodChannel.Result) {
        // Eine zweite Rueckfrage beendet die erste mit „nicht geloescht" --
        // sonst wartete Dart dort ewig.
        offen?.success(false)
        offen = result
        try {
            val anfrage = MediaStore.createDeleteRequest(a.contentResolver, listOf(media))
            a.startIntentSenderForResult(anfrage.intentSender, LOESCHEN, null, 0, 0, 0)
        } catch (e: Throwable) {
            Log.w(TAG, "Rueckfrage zum Loeschen: ${e.javaClass.simpleName}")
            offen = null
            result.success(false)
        }
    }

    /** Aus [MainActivity.onActivityResult]. `true`: es war unsere Anfrage. */
    fun ergebnis(anfrage: Int, code: Int): Boolean {
        if (anfrage != LOESCHEN) return false
        val r = offen ?: return true
        offen = null
        r.success(code == Activity.RESULT_OK)
        return true
    }
}
