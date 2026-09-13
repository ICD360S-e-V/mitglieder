package de.icd360s.icd_klingel

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.util.Log

/**
 * „Ablehnen" aus der Benachrichtigung.
 *
 * ⚠️ NUR Ablehnen. Annehmen muss die App nach vorne holen, und ein
 * BroadcastReceiver darf seit Android 10 keine Activity aus dem Hintergrund
 * starten — dort wäre der Start stumm verworfen worden, mit einem Knopf, der
 * nichts tut. Annehmen läuft deshalb über [KlingelActivity].
 */
class KlingelEmpfaenger : BroadcastReceiver() {
    override fun onReceive(context: Context?, intent: Intent?) {
        val ctx = context ?: return
        if (intent?.action != Klingel.AKTION_ABLEHNEN) return
        val id = intent.getIntExtra(Klingel.EXTRA_GESPRAECH, 0)
        Log.d("IcdKlingelEmpf", "Ablehnen für Gespräch $id")
        Klingel.verbergen(ctx)
        Klingel.entscheidungSetzen(ctx, "ablehnen", id)
    }
}
