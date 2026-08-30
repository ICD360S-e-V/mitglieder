package de.icd360s.mitglieder

import android.accessibilityservice.AccessibilityService
import android.accessibilityservice.GestureDescription
import android.content.Context
import android.graphics.Path
import android.os.Build
import android.util.Log
import android.view.accessibility.AccessibilityEvent
import android.view.WindowManager

/**
 * Fernsteuerung waehrend einer Fernwartungs-Sitzung.
 *
 * Android laesst eine normale App keine Eingaben in ANDERE Apps schicken —
 * `INJECT_EVENTS` ist signature-only, und der Weg ueber `Instrumentation`
 * endet an derselben Grenze. Der einzige offene Weg ist ein
 * AccessibilityService mit `canPerformGestures`; genau so machen es
 * TeamViewer QuickSupport und RustDesk.
 *
 * ⚠️ BEWUSST OHNE `canRetrieveWindowContent`.
 * Der Dienst kann Gesten AUSFUEHREN und sonst nichts. Er kann den
 * Bildschirminhalt nicht auslesen, keine Texte, keine Passwortfelder, keine
 * Kontonummern — auch dann nicht, wenn keine Sitzung laeuft. Das ist die
 * wichtigste Eigenschaft hier: der Verein verarbeitet Gesundheitsdaten, und
 * ein dauerhaft aktivierter Dienst mit Inhaltszugriff waere ein Mitleser auf
 * jedem Mitgliedsgeraet. `accessibilityEventTypes="typeNone"` sorgt zusaetzlich
 * dafuer, dass das System uns gar keine Ereignisse erst schickt.
 *
 * ⚠️ Folge, die man kennen muss: Tastatureingaben des Vorsitzes lassen sich so
 * NICHT in Textfelder schreiben — dafuer braeuchte es `ACTION_SET_TEXT` auf dem
 * fokussierten Knoten, also Inhaltszugriff. Getippt wird stattdessen auf der
 * Bildschirmtastatur des Mitglieds, die im geteilten Bild ohnehin zu sehen ist.
 * Nur `Escape` und `Home` gehen als globale Aktion durch.
 *
 * ⚠️ Der Dienst laeuft, sobald das Mitglied ihn in den Android-Einstellungen
 * aktiviert hat — unabhaengig von einer Sitzung. Deshalb ist [freigegeben] das
 * zweite Schloss: ohne eine laufende, vom Mitglied zugestimmte Sitzung wird
 * jede Geste verworfen. Das Einschalten allein gibt niemandem Zugriff.
 */
class FernwartungService : AccessibilityService() {

    companion object {
        const val TAG = "FernwartungService"

        /** Gesetzt, sobald das System den Dienst verbunden hat. */
        @Volatile
        var instanz: FernwartungService? = null
            private set

        /**
         * Zweites Schloss: nur waehrend einer laufenden Sitzung werden Gesten
         * ausgefuehrt. Wird von Dart (RemoteAgentService) auf- und zugesperrt.
         */
        @Volatile
        var freigegeben: Boolean = false

        /** Bewegung unter diesem Anteil der Bildschirmbreite gilt als Tipp. */
        private const val TIPP_TOLERANZ = 0.02

        /** Ab dieser Haltedauer wird aus einem Tipp ein langes Tippen. */
        private const val LANG_MS = 500L

        /** Obergrenze fuer eine Wischgeste; laenger nimmt das System nicht an. */
        private const val MAX_GESTE_MS = 60_000L
    }

    override fun onServiceConnected() {
        super.onServiceConnected()
        instanz = this
        Log.d(TAG, "verbunden — Gesten moeglich, Inhalt NICHT lesbar")
    }

    override fun onUnbind(intent: android.content.Intent?): Boolean {
        instanz = null
        freigegeben = false
        Log.d(TAG, "getrennt")
        return super.onUnbind(intent)
    }

    override fun onDestroy() {
        instanz = null
        freigegeben = false
        super.onDestroy()
    }

    // Wir haben typeNone angefordert, hier kommt also nichts an. Der Rumpf ist
    // trotzdem noetig, weil AccessibilityService sie abstrakt vorschreibt.
    override fun onAccessibilityEvent(event: AccessibilityEvent?) {}

    override fun onInterrupt() {}

    // ─── Bildschirmmass ──────────────────────────────────────────────────────
    // Die Normkoordinaten (0..1) kommen vom Vorsitz und werden HIER umgerechnet,
    // nicht in Dart: massgeblich ist die echte Anzeige des Geraets. Wer dafuer
    // die Videomasse nimmt, liegt schief, sobald WebRTC den Strom herunterskaliert.
    private fun masse(): Pair<Int, Int> {
        return try {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) {
                val wm = getSystemService(Context.WINDOW_SERVICE) as WindowManager
                val b = wm.currentWindowMetrics.bounds
                Pair(b.width(), b.height())
            } else {
                val dm = resources.displayMetrics
                Pair(dm.widthPixels, dm.heightPixels)
            }
        } catch (e: Exception) {
            val dm = resources.displayMetrics
            Pair(dm.widthPixels, dm.heightPixels)
        }
    }

    private fun x(nx: Double, breite: Int) =
        (nx.coerceIn(0.0, 1.0) * (breite - 1)).toFloat()

    private fun y(ny: Double, hoehe: Int) =
        (ny.coerceIn(0.0, 1.0) * (hoehe - 1)).toFloat()

    // ─── Gesten ──────────────────────────────────────────────────────────────

    /**
     * Ein Zug von (nx1,ny1) nach (nx2,ny2) ueber [dauerMs]. Deckt Tipp
     * (gleicher Punkt, kurz), langes Tippen (gleicher Punkt, lang) und Wischen
     * (verschiedene Punkte) ab — fuer das System ist alles dasselbe.
     */
    fun zug(nx1: Double, ny1: Double, nx2: Double, ny2: Double, dauerMs: Long): Boolean {
        if (!freigegeben) return false
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.N) return false
        return try {
            val (b, h) = masse()
            val pfad = Path()
            pfad.moveTo(x(nx1, b), y(ny1, h))
            // Ein Pfad ohne lineTo ist leer und wird von dispatchGesture
            // abgelehnt; beim reinen Tipp ist das Ziel derselbe Punkt.
            pfad.lineTo(x(nx2, b), y(ny2, h))
            val dauer = dauerMs.coerceIn(1L, MAX_GESTE_MS)
            val geste = GestureDescription.Builder()
                .addStroke(GestureDescription.StrokeDescription(pfad, 0L, dauer))
                .build()
            dispatchGesture(geste, null, null)
        } catch (e: Exception) {
            Log.w(TAG, "Geste fehlgeschlagen: ${e.message}")
            false
        }
    }

    /** Zurueck / Startbildschirm / Uebersicht — ohne Inhaltszugriff moeglich. */
    fun globaleAktion(name: String): Boolean {
        if (!freigegeben) return false
        val id = when (name) {
            "back" -> GLOBAL_ACTION_BACK
            "home" -> GLOBAL_ACTION_HOME
            "recents" -> GLOBAL_ACTION_RECENTS
            "notifications" -> GLOBAL_ACTION_NOTIFICATIONS
            else -> return false
        }
        return try {
            performGlobalAction(id)
        } catch (e: Exception) {
            Log.w(TAG, "globale Aktion $name fehlgeschlagen: ${e.message}")
            false
        }
    }
}
