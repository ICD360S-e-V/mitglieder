<?php
/**
 * Gemeinsame Regel fuer selbst zurueckgezogene Antraege.
 *
 * Getrennt von den Endpunkten, weil dieselbe Regel an drei Stellen gilt:
 * check_age.php entscheidet damit am Anfang, ob der Besucher ueberhaupt
 * weitermachen darf, finalize.php prueft sie noch einmal am Ende, und
 * withdraw.php schreibt den Schluessel, auf dem beide zaehlen.
 *
 * Dass das vorher parallel im Code lag, hat genau den Schaden angerichtet,
 * vor dem SignaturHelper warnt: check_age.php sperrte schon beim ERSTEN
 * Rueckzug, finalize.php erst beim dritten. Die drei im Dialogtext
 * versprochenen Versuche gab es also nie — die erste Zahl, die zaehlte, war
 * eine ganz andere als die, die dort stand. Ab hier gibt es nur noch eine.
 */

if (!defined('API_ACCESS')) {
    http_response_code(403);
    exit;
}

class RueckzugFenster
{
    /**
     * So viele eigene Rueckzuege darf derselbe Antragsteller im Fenster
     * haben, bevor die Anmeldung nicht mehr allein durchlaeuft und der
     * Vorstand entscheidet.
     *
     * Diese Zahl steht auch im Dialog, mit dem der Besucher den Abbruch
     * bestaetigt (l10n-Schluessel `wizardAbandonDialogBody`, in 28
     * Sprachen). Wer sie aendert, muss die Texte mitziehen — sonst
     * verspricht die App eine Zahl und der Server haelt eine andere.
     */
    public const GRENZE = 10;

    /** Laenge des Fensters in Tagen. Steht ebenfalls im Dialogtext. */
    public const FENSTER_TAGE = 90;

    /**
     * Stabiler, nicht umkehrbarer Schluessel eines Antragstellers.
     *
     * Absichtlich aus Vorname + Nachname + Geburtsdatum und nicht aus der
     * Mitgliedsnummer: wer erneut anfaengt, bekommt eine neue Nummer, und
     * eine Grenze, die man durch Neuanfangen umgeht, ist keine.
     *
     * Gibt null zurueck, wenn ein Teil fehlt — dann gibt es nichts zu
     * zaehlen, und null darf NIE wie ein Treffer behandelt werden.
     */
    public static function hash(
        string $vorname,
        string $nachname,
        string $geburtsdatum
    ): ?string {
        $v = trim(mb_strtolower($vorname, 'UTF-8'));
        $n = trim(mb_strtolower($nachname, 'UTF-8'));
        $g = trim($geburtsdatum);
        if ($v === '' || $n === '' || $g === '') {
            return null;
        }
        return hash('sha256', $v . '|' . $n . '|' . $g);
    }

    /**
     * Wie viele eigene Rueckzuege dieser Antragsteller im Fenster hat.
     *
     * Ein fehlender Schluessel ergibt 0: wir wissen dann nichts und sperren
     * niemanden auf Verdacht.
     */
    public static function zaehleRueckzuege(PDO $pdo, ?string $hash): int
    {
        if ($hash === null) {
            return 0;
        }
        $stmt = $pdo->prepare(
            'SELECT COUNT(*) FROM users
              WHERE abuse_hash = ?
                AND status = \'gekuendigt_selbst\'
                AND deactivated_at > DATE_SUB(NOW(), INTERVAL ' .
            self::FENSTER_TAGE . ' DAY)'
        );
        $stmt->execute([$hash]);
        return (int)$stmt->fetchColumn();
    }

    /** True, sobald der Vorstand entscheiden muss statt der Automatik. */
    public static function grenzeErreicht(PDO $pdo, ?string $hash): bool
    {
        return self::zaehleRueckzuege($pdo, $hash) >= self::GRENZE;
    }
}
