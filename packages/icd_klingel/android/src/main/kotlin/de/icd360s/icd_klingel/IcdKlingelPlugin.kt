package de.icd360s.icd_klingel

import android.content.Context
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/**
 * Die Naht zwischen Dart und dem Klingelschirm.
 *
 * ⚠️ Als PLUGIN und nicht als Kanal in MainActivity: der Anruf trifft im
 * Isolat des Vordergrunddienstes ein, und dort gibt es nur, was im
 * GeneratedPluginRegistrant steht. Ein Kanal aus MainActivity existiert dort
 * nicht — dieselbe Lehre wie bei icd_sms, icd_anruf und icd_netinfo.
 *
 * ⚠️ Es gibt MEHRERE Instanzen gleichzeitig: eine je Engine (Oberfläche und
 * Hintergrunddienst). Der Melder ist deshalb statisch und schreibt an ALLE
 * angemeldeten Empfänger. Wer nur die letzte Instanz behielte, würde beim
 * Öffnen der App den Hintergrunddienst abklemmen — also genau das Isolat, das
 * die WebSocket-Verbindung hält und eine Absage hinausschicken kann.
 */
class IcdKlingelPlugin : FlutterPlugin, MethodCallHandler {

    companion object {
        private const val KANAL = "de.icd360s.mitglied/klingel"
        private const val EREIGNISSE = "de.icd360s.mitglied/klingel_ereignisse"

        private val senken = mutableListOf<EventChannel.EventSink>()

        /**
         * Klopft bei jedem lebenden Isolat an: „es liegt eine Entscheidung".
         *
         * ⚠️ Das Ereignis trägt die Entscheidung NICHT mit sich. Sie steht im
         * Speicher, und Dart holt sie dort ab. Zwei Isolate bekämen sonst
         * beide eine Kopie und handelten beide — einmal Absage senden ist
         * richtig, zweimal ist eine Absage auf ein Gespräch, das es nicht
         * mehr gibt.
         */
        @JvmStatic
        fun anklopfen() {
            // Kopie: eine Senke darf sich beim Melden abmelden.
            val jetzt = synchronized(senken) { senken.toList() }
            for (s in jetzt) {
                try {
                    s.success("entscheidung")
                } catch (e: Throwable) {
                    // Eine taube Senke darf die übrigen nicht aufhalten.
                }
            }
        }
    }

    private var kanal: MethodChannel? = null
    private var ereignisse: EventChannel? = null
    private var ctx: Context? = null
    private var eigeneSenke: EventChannel.EventSink? = null

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        ctx = binding.applicationContext
        kanal = MethodChannel(binding.binaryMessenger, KANAL).also {
            it.setMethodCallHandler(this)
        }
        ereignisse = EventChannel(binding.binaryMessenger, EREIGNISSE).also {
            it.setStreamHandler(object : EventChannel.StreamHandler {
                override fun onListen(arguments: Any?, sink: EventChannel.EventSink?) {
                    if (sink == null) return
                    eigeneSenke = sink
                    synchronized(senken) { senken.add(sink) }
                }

                override fun onCancel(arguments: Any?) {
                    val s = eigeneSenke ?: return
                    synchronized(senken) { senken.remove(s) }
                    eigeneSenke = null
                }
            })
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        kanal?.setMethodCallHandler(null)
        kanal = null
        ereignisse?.setStreamHandler(null)
        ereignisse = null
        eigeneSenke?.let { s -> synchronized(senken) { senken.remove(s) } }
        eigeneSenke = null
        ctx = null
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        val c = ctx
        if (c == null) {
            result.success(false)
            return
        }
        when (call.method) {
            "zeigen" -> {
                val ok = Klingel.zeigen(
                    c,
                    name = call.argument<String>("name") ?: "",
                    video = call.argument<Boolean>("video") ?: false,
                    gespraechId = call.argument<Int>("gespraech") ?: 0,
                    titel = call.argument<String>("titel") ?: "",
                    annehmenText = call.argument<String>("annehmen") ?: "",
                    ablehnenText = call.argument<String>("ablehnen") ?: "",
                )
                result.success(ok)
            }
            "verbergen" -> {
                Klingel.verbergen(c)
                result.success(true)
            }
            "erlaubt" -> result.success(Klingel.erlaubt(c))
            "einstellungOeffnen" -> result.success(Klingel.einstellungOeffnen(c))
            "entscheidungAnsehen" -> result.success(Klingel.entscheidungAnsehen(c))
            "entscheidungQuittieren" -> {
                Klingel.entscheidungQuittieren(c)
                result.success(true)
            }
            else -> result.notImplemented()
        }
    }
}
