package de.icd360s.mitglieder

import android.annotation.SuppressLint
import android.content.Context
import android.content.Intent
import android.graphics.Color
import android.graphics.Typeface
import android.graphics.drawable.GradientDrawable
import android.os.Build
import android.os.Handler
import android.os.Looper
import android.provider.Settings
import android.util.Log
import android.util.TypedValue
import android.view.Gravity
import android.view.MotionEvent
import android.view.View
import android.view.WindowManager
import android.widget.ImageView
import android.widget.LinearLayout
import android.widget.TextView

/**
 * PORTIERT aus der Vorsitzer-App (PR #702/#707) am 12.09.2026. Zwei bewusste
 * Unterschiede, beide wegen der 28 Sprachen dieser App:
 *   - der Titel kommt als Parameter aus Dart, nicht aus einer String-Ressource
 *   - der Hinweis auf die fehlende Berechtigung ist ein Flutter-Dialog
 *
 * Kleines Fenster ÜBER ANDEREN APPS, solange ein Chat-Anruf läuft und unsere
 * App nicht im Vordergrund ist.
 *
 * WOFÜR
 * Die schwebende Karte in der App ([AnrufOverlay]) ist weg, sobald der Mensch
 * die App verlässt — und seit dem Vordergrunddienst läuft der Anruf dort
 * weiter. Es blieb die dauerhafte Benachrichtigung; die sieht man aber nur,
 * wenn man die Leiste herunterzieht. Dies ist der sichtbare Rückweg, wie ihn
 * Messenger mit seinen Blasen hat.
 *
 * ⚠️ NUR MIT ERTEILTER BERECHTIGUNG. „Über anderen Apps anzeigen" muss einmal
 * von Hand gegeben werden; ohne sie wirft `WindowManager.addView` eine
 * `BadTokenException`. Deshalb wird IMMER [Settings.canDrawOverlays] gefragt
 * und bei Nein schweigend nichts getan — der Anruf läuft weiter, es fehlt nur
 * dieses Fenster. Ein Absturz wäre schlimmer als die fehlende Verbesserung.
 *
 * ⚠️ KEIN `FLAG_NOT_TOUCHABLE`, aber `FLAG_NOT_FOCUSABLE`: das Fenster muss
 * Tipper annehmen (Auflegen, Rückweg), darf aber der App darunter nicht die
 * Tastatur wegnehmen. Und es ist nur so gross wie das, was es zeichnet —
 * dieselbe Regel wie beim In-App-Overlay, aus demselben Grund.
 */
object AnrufSystemfenster {
    private const val TAG = "AnrufSystemfenster"

    private var wm: WindowManager? = null
    private var sicht: View? = null
    private var params: WindowManager.LayoutParams? = null

    // Die Teile der unteren Zeile, damit `stand()` sie auffrischen kann.
    private var dauerSicht: TextView? = null
    private var balkenSicht: LinearLayout? = null
    private var untenSicht: View? = null
    private var startzeitMs: Long = -1L
    private var gueteStufe: Int = 0

    // ⚠️ Der Sekundentakt laeuft HIER, nicht in Dart. Ein Kanalaufruf je
    // Sekunde waere Funk und Rechenzeit fuer eine Zahl, die sich aus einem
    // einzigen Zeitstempel ergibt — und die Karte bliebe stehen, sobald Dart
    // gerade beschaeftigt ist.
    private val takt = Handler(Looper.getMainLooper())
    private var taktLaeuft = false
    private val tick = object : Runnable {
        override fun run() {
            dauerAnzeigen()
            if (taktLaeuft) takt.postDelayed(this, 1000L)
        }
    }

    fun erlaubt(context: Context): Boolean =
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            Settings.canDrawOverlays(context)
        } else {
            true
        }

    @SuppressLint("ClickableViewAccessibility")
    fun zeigen(
        context: Context,
        video: Boolean,
        titel: String,
        auflegen: String,
        startzeit: Long,
        guete: Int,
    ) {
        if (sicht != null) return
        if (!erlaubt(context)) {
            Log.i(TAG, "keine Overlay-Berechtigung — Fenster entfaellt")
            return
        }
        val app = context.applicationContext
        val manager = app.getSystemService(Context.WINDOW_SERVICE) as? WindowManager ?: return

        val typ = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            WindowManager.LayoutParams.TYPE_APPLICATION_OVERLAY
        } else {
            @Suppress("DEPRECATION")
            WindowManager.LayoutParams.TYPE_PHONE
        }
        val p = WindowManager.LayoutParams(
            WindowManager.LayoutParams.WRAP_CONTENT,
            WindowManager.LayoutParams.WRAP_CONTENT,
            typ,
            // NOT_FOCUSABLE: die App darunter behaelt die Tastatur.
            // NICHT NOT_TOUCHABLE: sonst waere der Auflegen-Knopf tot.
            WindowManager.LayoutParams.FLAG_NOT_FOCUSABLE or
                WindowManager.LayoutParams.FLAG_LAYOUT_NO_LIMITS,
            android.graphics.PixelFormat.TRANSLUCENT,
        ).apply {
            gravity = Gravity.TOP or Gravity.START
            x = dp(app, 12)
            y = dp(app, 64)
        }

        startzeitMs = startzeit
        gueteStufe = guete
        val karte = bauen(app, video, titel, auflegen)
        var startX = 0
        var startY = 0
        var fingerX = 0f
        var fingerY = 0f
        var gezogen = false
        karte.setOnTouchListener { _, e ->
            when (e.action) {
                MotionEvent.ACTION_DOWN -> {
                    startX = p.x; startY = p.y
                    fingerX = e.rawX; fingerY = e.rawY
                    gezogen = false
                    true
                }
                MotionEvent.ACTION_MOVE -> {
                    val dx = (e.rawX - fingerX).toInt()
                    val dy = (e.rawY - fingerY).toInt()
                    // Erst ab ein paar Pixeln als Ziehen werten, sonst wird
                    // jeder Tipp zum Verschieben und nichts laesst sich druecken.
                    if (!gezogen && (kotlin.math.abs(dx) > dp(app, 6) ||
                            kotlin.math.abs(dy) > dp(app, 6))) {
                        gezogen = true
                    }
                    if (gezogen) {
                        p.x = startX + dx
                        p.y = startY + dy
                        try { manager.updateViewLayout(karte, p) } catch (_: Throwable) {}
                    }
                    true
                }
                MotionEvent.ACTION_UP -> {
                    if (!gezogen) zurueckInDieApp(app)
                    true
                }
                else -> false
            }
        }

        try {
            manager.addView(karte, p)
        } catch (e: Throwable) {
            // Berechtigung zwischenzeitlich entzogen, oder der Fenstertyp wird
            // vom Hersteller verweigert. Kein Grund, den Anruf zu stoeren.
            Log.e(TAG, "addView abgelehnt: $e")
            return
        }
        wm = manager; sicht = karte; params = p
        Log.d(TAG, "gezeigt (video=$video)")
    }

    fun verbergen() {
        taktStoppen()
        dauerSicht = null; balkenSicht = null; untenSicht = null
        startzeitMs = -1L; gueteStufe = 0
        val v = sicht ?: return
        try { wm?.removeView(v) } catch (_: Throwable) {}
        sicht = null; wm = null; params = null
        Log.d(TAG, "verborgen")
    }

    // Dauer und Guete an der stehenden Karte auffrischen.
    fun stand(startzeit: Long, guete: Int) {
        if (sicht == null) return
        startzeitMs = startzeit
        gueteStufe = guete
        dauerAnzeigen()
        balkenSetzen()
        untenSicht?.visibility =
            if (startzeitMs > 0L || gueteStufe > 0) View.VISIBLE else View.GONE
        if (startzeitMs > 0L) taktStarten() else taktStoppen()
    }

    private fun taktStarten() {
        if (taktLaeuft) return
        taktLaeuft = true
        takt.postDelayed(tick, 1000L)
    }

    private fun taktStoppen() {
        taktLaeuft = false
        takt.removeCallbacks(tick)
    }

    private fun dauerAnzeigen() {
        dauerSicht?.text = dauerText(startzeitMs)
    }

    // `m:ss`, ab einer Stunde `h:mm:ss`.
    //
    // ⚠️ `Locale.US` mit Absicht: die Ziffern sollen ueberall dieselben sein.
    // Mit der Geraete-Sprache lieferte `String.format` etwa auf Arabisch
    // arabisch-indische Ziffern — und die Sprache der Karte kommt ohnehin aus
    // der App-Einstellung, nicht vom Geraet.
    private fun dauerText(start: Long): String {
        if (start <= 0L) return ""
        val s = ((System.currentTimeMillis() - start) / 1000L).coerceAtLeast(0L)
        val h = s / 3600
        val m = (s % 3600) / 60
        val sek = s % 60
        return if (h > 0) String.format(java.util.Locale.US, "%d:%02d:%02d", h, m, sek)
        else String.format(java.util.Locale.US, "%d:%02d", m, sek)
    }

    // Drei Balken. Stufe 0 blendet sie GANZ aus.
    //
    // ⚠️ „Noch nichts gemessen" darf nie aussehen wie „schlecht" — deshalb
    // nicht drei blasse Balken, sondern gar keine. Eine Behauptung ueber die
    // Leitung, die wir noch nicht kennen, waere schlimmer als keine Anzeige.
    private fun balkenSetzen() {
        val b = balkenSicht ?: return
        if (gueteStufe <= 0) { b.visibility = View.GONE; return }
        b.visibility = View.VISIBLE
        val an = if (gueteStufe == 1) Color.parseColor("#FFC107") else Color.WHITE
        val aus = Color.parseColor("#4DFFFFFF")
        for (i in 0 until b.childCount) {
            b.getChildAt(i).setBackgroundColor(if (i < gueteStufe) an else aus)
        }
    }

    private fun zurueckInDieApp(app: Context) {
        val i = Intent(app, MainActivity::class.java).apply {
            addFlags(Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_SINGLE_TOP)
        }
        try { app.startActivity(i) } catch (e: Throwable) { Log.e(TAG, "Rueckweg: $e") }
    }

    private fun bauen(
        app: Context,
        video: Boolean,
        titel: String,
        auflegen: String,
    ): View {
        val reihe = LinearLayout(app).apply {
            orientation = LinearLayout.HORIZONTAL
            gravity = Gravity.CENTER_VERTICAL
            setPadding(dp(app, 14), dp(app, 8), dp(app, 8), dp(app, 8))
            background = GradientDrawable().apply {
                cornerRadius = dp(app, 24).toFloat()
                // ⚠️ Deutlich deckender als die erste Fassung (#E6 -> #F2).
                // Die Karte liegt ueber einer FREMDEN App, deren Hintergrund
                // wir nicht kennen; bei 90 % Deckung stand weisser Text auf
                // einer hellen Webseite und war nicht zu lesen.
                setColor(Color.parseColor("#F2142C17"))
                setStroke(dp(app, 1), Color.parseColor("#40FFFFFF"))
            }
            // Ein Schatten trennt die Karte von dem, was darunter liegt —
            // ohne ihn wirkt sie wie ein Teil der fremden App.
            elevation = dp(app, 6).toFloat()
        }
        reihe.addView(ImageView(app).apply {
            setImageResource(R.drawable.ic_anruf_laeuft)
            setColorFilter(Color.WHITE)
            layoutParams = LinearLayout.LayoutParams(dp(app, 20), dp(app, 20))
        })
        // ⚠️ FESTE Hoechstbreite, nicht nur `maxLines` + Ellipse. Das Fenster
        // laeuft mit WRAP_CONTENT und FLAG_LAYOUT_NO_LIMITS, darf also ueber
        // den Schirmrand hinauswachsen — ohne Grenze griffe die Ellipse nie,
        // und ein langer Titel schoebe den Auflegen-Knopf aus dem Bild.
        val breite = dp(app, 190)
        val spalte = LinearLayout(app).apply {
            orientation = LinearLayout.VERTICAL
            layoutParams = LinearLayout.LayoutParams(
                LinearLayout.LayoutParams.WRAP_CONTENT,
                LinearLayout.LayoutParams.WRAP_CONTENT,
            ).apply { leftMargin = dp(app, 10); rightMargin = dp(app, 12) }
        }
        // 1. Zeile: der Name der App, wie ihn das System kennt.
        // ⚠️ Aus `applicationInfo.loadLabel` und NICHT aus den ARB-Dateien:
        // es ist genau der Name, der im Starter steht, er stimmt in allen
        // fuenf Flavors von selbst, und er kostet keinen 29. Uebersetzungs-
        // string in 28 Sprachen.
        val appName = try {
            app.applicationInfo.loadLabel(app.packageManager).toString()
        } catch (_: Throwable) { "" }
        spalte.addView(TextView(app).apply {
            text = appName
            visibility = if (appName.isEmpty()) View.GONE else View.VISIBLE
            setTextColor(Color.parseColor("#B3FFFFFF"))
            setTextSize(TypedValue.COMPLEX_UNIT_SP, 11f)
            maxLines = 1
            maxWidth = breite
            ellipsize = android.text.TextUtils.TruncateAt.END
        })
        // 2. Zeile: worum es geht.
        spalte.addView(TextView(app).apply {
            text = titel
            setTextColor(Color.WHITE)
            setTextSize(TypedValue.COMPLEX_UNIT_SP, 14f)
            // ⚠️ sans-serif-medium, nicht setTypeface(null, BOLD): fett wird
            // in einer Karte dieser Groesse zur Wand, halbfett bleibt lesbar.
            typeface = Typeface.create("sans-serif-medium", Typeface.NORMAL)
            maxLines = 1
            maxWidth = breite
            ellipsize = android.text.TextUtils.TruncateAt.END
        })
        // 3. Zeile: wie lange schon, und wie gut.
        val unten = LinearLayout(app).apply {
            orientation = LinearLayout.HORIZONTAL
            gravity = Gravity.CENTER_VERTICAL
        }
        val dauer = TextView(app).apply {
            setTextColor(Color.parseColor("#D9FFFFFF"))
            setTextSize(TypedValue.COMPLEX_UNIT_SP, 12f)
            text = dauerText(startzeitMs)
        }
        unten.addView(dauer)
        val balken = LinearLayout(app).apply {
            orientation = LinearLayout.HORIZONTAL
            gravity = Gravity.BOTTOM
            layoutParams = LinearLayout.LayoutParams(
                LinearLayout.LayoutParams.WRAP_CONTENT,
                LinearLayout.LayoutParams.WRAP_CONTENT,
            ).apply { leftMargin = dp(app, 8) }
        }
        for (i in 0 until 3) {
            balken.addView(View(app).apply {
                layoutParams = LinearLayout.LayoutParams(
                    dp(app, 3), dp(app, 5 + i * 3),
                ).apply { if (i > 0) leftMargin = dp(app, 2) }
            })
        }
        unten.addView(balken)
        spalte.addView(unten)
        reihe.addView(spalte)

        dauerSicht = dauer
        balkenSicht = balken
        untenSicht = unten
        balkenSetzen()
        unten.visibility =
            if (startzeitMs > 0L || gueteStufe > 0) View.VISIBLE else View.GONE
        if (startzeitMs > 0L) taktStarten()
        reihe.addView(ImageView(app).apply {
            setImageResource(R.drawable.ic_anruf_auflegen)
            setColorFilter(Color.WHITE)
            // 🔴 Ein ROTER runder Knopf, wie ihn jeder Telefonschirm hat.
            // Vorher war es ein blasser Umriss ohne Flaeche: es sah nach
            // Zierrat aus, nicht nach einem Knopf, den man druecken kann.
            background = GradientDrawable().apply {
                shape = GradientDrawable.OVAL
                setColor(Color.parseColor("#E53935"))
            }
            layoutParams = LinearLayout.LayoutParams(dp(app, 36), dp(app, 36))
            setPadding(dp(app, 8), dp(app, 8), dp(app, 8), dp(app, 8))
            // ⚠️ Fuer den Bildschirmleser: der Knopf ist nur ein Bild, ohne
            // dieses Wort liest er „nicht benannte Schaltflaeche" vor. Der
            // Text kommt aus Dart (`hangUp`, in allen 28 Sprachen vorhanden),
            // damit hier keine zweite Uebersetzungsquelle entsteht.
            contentDescription = auflegen
            // ⚠️ Eigener Zuhoerer, damit der Auflegen-Tipp NICHT beim
            // Zieh-Zuhoerer der Reihe landet. Ohne das legte jeder Tipp auf die
            // Karte auf — oder gar nichts, je nach Reihenfolge.
            setOnClickListener { AnrufDienstBruecke.auflegen(app) }
        })
        return reihe
    }

    private fun dp(c: Context, wert: Int): Int =
        (wert * c.resources.displayMetrics.density).toInt()
}

/**
 * Der Weg vom Systemfenster zurück in den Dart-Anruf.
 *
 * ⚠️ Ein Tipp auf „Auflegen" kommt aus einem Fenster, das über fremden Apps
 * liegt — dort gibt es keinen Flutter-Kanal, auf den man antworten könnte. Der
 * Wunsch wird deshalb in die App getragen, die ihn im laufenden Isolat
 * ausführt; ihn nativ zu beenden ginge nicht, WebRTC lebt in Dart.
 */
object AnrufDienstBruecke {
    /** Setzt [MainActivity] beim Start; ruft `VoiceCallService.endCall()`. */
    @Volatile
    var beimAuflegen: (() -> Unit)? = null

    fun auflegen(app: Context) {
        val f = beimAuflegen
        if (f != null) {
            f()
        } else {
            // Kein Isolat da — dann wenigstens die App holen, damit der Mensch
            // selbst auflegen kann. Schweigend nichts zu tun waere schlimmer.
            val i = Intent(app, MainActivity::class.java).apply {
                addFlags(Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_SINGLE_TOP)
            }
            try { app.startActivity(i) } catch (_: Throwable) {}
        }
    }
}
