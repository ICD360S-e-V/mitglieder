package de.icd360s.icd_klingel

import android.app.Activity
import android.content.Intent
import android.graphics.Color
import android.graphics.drawable.GradientDrawable
import android.os.Build
import android.os.Bundle
import android.util.Log
import android.util.TypedValue
import android.view.Gravity
import android.view.View
import android.view.ViewGroup
import android.view.WindowManager
import android.widget.LinearLayout
import android.widget.TextView
import java.lang.ref.WeakReference

/**
 * Der Klingelschirm über dem Sperrbildschirm.
 *
 * ⚠️ Die Oberfläche entsteht IM CODE, nicht in `res/layout` — wie
 * [AnrufSystemfenster] der App. Ein zweiter Ort für Beschriftungen wäre
 * `res/values-xx/strings.xml`, also eine zweite Übersetzungsquelle neben den
 * 28 ARB-Dateien; die beiden liefen beim ersten geänderten Wort auseinander.
 * Alle Texte kommen deshalb von Dart durch den Kanal.
 *
 * ⚠️ Diese Activity startet KEIN Flutter. Sie muss in Millisekunden stehen,
 * und ein Flutter-Kaltstart auf einem ruhenden Tablet dauert Sekunden.
 */
class KlingelActivity : Activity() {

    companion object {
        private const val TAG = "IcdKlingelSchirm"

        // Damit ein aufgelegter Anruf den Schirm mitnimmt. ⚠️ Ohne das bliebe
        // er nach dem Aufgeben des Anrufers auf dem Sperrbildschirm stehen —
        // genau der Fehler, der am 11.09.2026 im Flutter-Dialog behoben wurde.
        private var aktuelle: WeakReference<KlingelActivity>? = null

        fun schliessen() {
            val a = aktuelle?.get() ?: return
            aktuelle = null
            try {
                a.runOnUiThread { if (!a.isFinishing) a.finish() }
            } catch (e: Throwable) {
                Log.w(TAG, "schliessen: $e")
            }
        }
    }

    private var gespraechId = 0
    private var entschieden = false

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        aktuelle = WeakReference(this)

        // Belt und Hosenträger neben den Manifest-Attributen: auf API < 27 gibt
        // es showWhenLocked/turnScreenOn als Attribut noch nicht, dort tragen
        // die Fenster-Flags.
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O_MR1) {
            setShowWhenLocked(true)
            setTurnScreenOn(true)
        } else {
            @Suppress("DEPRECATION")
            window.addFlags(
                WindowManager.LayoutParams.FLAG_SHOW_WHEN_LOCKED or
                    WindowManager.LayoutParams.FLAG_TURN_SCREEN_ON,
            )
        }
        window.addFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON)

        verarbeiten(intent)
    }

    override fun onNewIntent(intent: Intent?) {
        super.onNewIntent(intent)
        // launchMode=singleInstance: ein zweiter Anruf landet hier, nicht in
        // einer neuen Instanz.
        if (intent != null) verarbeiten(intent)
    }

    private fun verarbeiten(intent: Intent) {
        gespraechId = intent.getIntExtra(Klingel.EXTRA_GESPRAECH, 0)

        // Aus der Aktion „Annehmen" der Benachrichtigung: nichts zeigen,
        // sofort annehmen. Der Weg führt über diese Activity und nicht über
        // den Empfänger, weil ein BroadcastReceiver keine Activity aus dem
        // Hintergrund starten darf.
        if (intent.getStringExtra(Klingel.EXTRA_DIREKT) == "annehmen") {
            annehmen()
            return
        }

        setContentView(schirmBauen(intent))
    }

    // ------------------------------------------------------------------ Ansicht

    private fun dp(wert: Float): Int = TypedValue.applyDimension(
        TypedValue.COMPLEX_UNIT_DIP, wert, resources.displayMetrics,
    ).toInt()

    private fun schirmBauen(intent: Intent): View {
        val name = intent.getStringExtra(Klingel.EXTRA_NAME).orEmpty()
        val titel = intent.getStringExtra(Klingel.EXTRA_TITEL).orEmpty()
        val annehmenText = intent.getStringExtra(Klingel.EXTRA_ANNEHMEN).orEmpty()
        val ablehnenText = intent.getStringExtra(Klingel.EXTRA_ABLEHNEN).orEmpty()

        val wurzel = LinearLayout(this).apply {
            orientation = LinearLayout.VERTICAL
            gravity = Gravity.CENTER_HORIZONTAL
            // Dunkler, deckender Grund: der Schirm liegt über einem
            // Hintergrundbild, das wir nicht kennen.
            setBackgroundColor(Color.parseColor("#FF101418"))
            setPadding(dp(28f), dp(64f), dp(28f), dp(48f))
        }

        // Der Name der App kommt vom SYSTEM. Er stimmt damit in allen fünf
        // Varianten von selbst und kostet keine 29. Übersetzung.
        val appName = try {
            applicationInfo.loadLabel(packageManager).toString()
        } catch (e: Throwable) {
            ""
        }
        if (appName.isNotEmpty()) wurzel.addView(zeile(appName, 13f, "#FF8A9099", false))
        if (titel.isNotEmpty()) {
            wurzel.addView(zeile(titel, 17f, "#FFC8CDD4", false).apply {
                (layoutParams as LinearLayout.LayoutParams).topMargin = dp(10f)
            })
        }
        if (name.isNotEmpty()) {
            wurzel.addView(zeile(name, 30f, "#FFFFFFFF", true).apply {
                (layoutParams as LinearLayout.LayoutParams).topMargin = dp(14f)
            })
        }

        // Schiebt die Knöpfe an den unteren Rand — dort erwartet sie die Hand.
        wurzel.addView(View(this).apply {
            layoutParams = LinearLayout.LayoutParams(0, 0, 1f)
        })

        val reihe = LinearLayout(this).apply {
            orientation = LinearLayout.HORIZONTAL
            layoutParams = LinearLayout.LayoutParams(
                ViewGroup.LayoutParams.MATCH_PARENT,
                ViewGroup.LayoutParams.WRAP_CONTENT,
            )
        }
        reihe.addView(knopf(ablehnenText, "#FFE53935") { ablehnen() })
        reihe.addView(View(this).apply { layoutParams = LinearLayout.LayoutParams(dp(14f), 1) })
        reihe.addView(knopf(annehmenText, "#FF2E9E55") { annehmen() })
        wurzel.addView(reihe)
        return wurzel
    }

    private fun zeile(text: String, groesse: Float, farbe: String, fett: Boolean): TextView =
        TextView(this).apply {
            layoutParams = LinearLayout.LayoutParams(
                ViewGroup.LayoutParams.MATCH_PARENT,
                ViewGroup.LayoutParams.WRAP_CONTENT,
            )
            this.text = text
            setTextSize(TypedValue.COMPLEX_UNIT_SP, groesse)
            setTextColor(Color.parseColor(farbe))
            gravity = Gravity.CENTER_HORIZONTAL
            if (fett) typeface = android.graphics.Typeface.create("sans-serif-medium", 0)
            // ⚠️ Ein langer Name darf den Schirm nicht sprengen, aber auch
            // nichts verdecken: zwei Zeilen, dann Auslassung.
            maxLines = 2
            ellipsize = android.text.TextUtils.TruncateAt.END
        }

    private fun knopf(text: String, farbe: String, beiTipp: () -> Unit): View =
        TextView(this).apply {
            layoutParams = LinearLayout.LayoutParams(0, dp(60f), 1f)
            this.text = text
            setTextSize(TypedValue.COMPLEX_UNIT_SP, 17f)
            setTextColor(Color.WHITE)
            gravity = Gravity.CENTER
            typeface = android.graphics.Typeface.create("sans-serif-medium", 0)
            background = GradientDrawable().apply {
                shape = GradientDrawable.RECTANGLE
                cornerRadius = dp(30f).toFloat()
                setColor(Color.parseColor(farbe))
            }
            isClickable = true
            contentDescription = text
            setOnClickListener { beiTipp() }
        }

    // ---------------------------------------------------------- Entscheidungen

    private fun annehmen() {
        if (entschieden) return
        entschieden = true
        Klingel.verbergen(this)
        Klingel.entscheidungSetzen(this, "annehmen", gespraechId)
        // Erst die Sperre beiseite bitten, dann die App holen: ohne das käme
        // das Gespräch hinter dem Sperrbildschirm zu liegen.
        Klingel.sperreBeiseite(this)
        if (!Klingel.appStarten(this, gespraechId)) {
            Log.e(TAG, "App liess sich nicht starten — Anruf bleibt unbeantwortet")
        }
        finish()
    }

    private fun ablehnen() {
        if (entschieden) return
        entschieden = true
        Klingel.verbergen(this)
        Klingel.entscheidungSetzen(this, "ablehnen", gespraechId)
        // ⚠️ Beim Ablehnen wird die App NICHT geholt. Wer ablehnt, will das
        // Gerät nicht in der Hand haben.
        finish()
    }

    /**
     * ⚠️ Die Zurück-Taste darf NICHT als Ablehnen gelten und den Schirm auch
     * nicht einfach wegnehmen: dann klingelte es weiter, ohne dass etwas
     * sichtbar wäre. Sie tut nichts — entschieden wird mit einem der beiden
     * Knöpfe.
     */
    @Deprecated("Zurück-Taste absichtlich ohne Wirkung")
    override fun onBackPressed() {
        // absichtlich leer
    }

    override fun onDestroy() {
        if (aktuelle?.get() === this) aktuelle = null
        super.onDestroy()
    }
}
