<?php
/**
 * Gemeinsame Bausteine der digitalen Unterschrift.
 *
 * Getrennt von den Endpunkten, weil dieselben Regeln an drei Stellen gelten
 * müssen: beim Anfordern (Vorsitzer), beim Unterschreiben (Mitglied) und beim
 * öffentlichen Nachprüfen. Läge das dreimal parallel im Code, würde eine
 * Änderung an der Beweiskette irgendwann nur an zwei Stellen ankommen — und
 * genau das würde man erst merken, wenn jemand die Unterschrift bestreitet.
 */

if (!defined('API_ACCESS')) {
    http_response_code(403);
    exit;
}

class SignaturHelper
{
    /** Wie lange eine TAN gilt. Kurz genug, dass ein abgefangener Code nichts
     *  mehr nützt; lang genug, dass eine SMS auch mal zwei Minuten braucht. */
    public const TAN_GUELTIG_MINUTEN = 10;

    /** Nach so vielen Fehleingaben ist die TAN verbrannt und muss neu
     *  angefordert werden. Verhindert das Durchprobieren von 10^6 Codes. */
    public const TAN_MAX_VERSUCHE = 3;

    /**
     * Sechsstellige TAN aus kryptografisch sicherem Zufall.
     *
     * `random_int` statt `rand`: letzteres ist vorhersagbar, und eine
     * vorhersagbare TAN ist keine.
     */
    public static function tanErzeugen(): string
    {
        return str_pad((string)random_int(0, 999999), 6, '0', STR_PAD_LEFT);
    }

    /**
     * Hash einer TAN, gesalzen mit der Vorgangs-ID.
     *
     * Ohne Salz hätten dieselben sechs Ziffern in jedem Vorgang denselben
     * Hash — eine Regenbogentabelle über 10^6 Einträge wäre in Sekunden
     * gebaut. Mit der ID im Salz nützt sie nichts.
     */
    public static function tanHash(string $tan, int $signaturId): string
    {
        return hash('sha256', $signaturId . ':' . $tan . ':' . self::salz());
    }

    /**
     * Serverseitiges Salz. Kommt aus derselben Quelle wie die übrigen
     * Geheimnisse; fehlt es, wird nicht still auf einen festen Wert
     * ausgewichen — dann wäre der Hash wertlos und niemand würde es merken.
     */
    private static function salz(): string
    {
        $key = getenv('ENC_MASTER_KEY');
        if (!is_string($key) || $key === '') {
            throw new RuntimeException('ENC_MASTER_KEY not configured');
        }
        return $key;
    }

    /**
     * Maskierte Rufnummer für die Anzeige: +4917•••••4567.
     *
     * Das Mitglied soll erkennen, an welches seiner Geräte die TAN ging,
     * ohne dass die vollständige Nummer über den Bildschirm wandert.
     */
    public static function telefonMaskieren(string $nummer): string
    {
        $clean = preg_replace('/\s+/', '', $nummer) ?? $nummer;
        $len = strlen($clean);
        if ($len <= 8) {
            return $clean;
        }
        return substr($clean, 0, 5) . str_repeat('•', max(1, $len - 9)) . substr($clean, -4);
    }

    /**
     * Reverse-DNS zur IP.
     *
     * `gethostbyaddr` fällt bei fehlendem PTR auf die IP selbst zurück — das
     * wäre in der Spalte eine Verdopplung ohne Aussage, also wird es zu null.
     * Der DNS-Umweg kann hängen; deshalb steht er bewusst NICHT im kritischen
     * Pfad des Unterschreibens, sondern läuft danach.
     */
    public static function reverseDns(?string $ip): ?string
    {
        if ($ip === null || $ip === '') {
            return null;
        }
        $host = @gethostbyaddr($ip);
        if ($host === false || $host === $ip) {
            return null;
        }
        return substr($host, 0, 255);
    }

    /**
     * Die echte Client-IP hinter nginx.
     *
     * REMOTE_ADDR ist hier immer der Proxy selbst. X-Forwarded-For darf ein
     * Client aber auch frei setzen — verlässlich ist nur der LETZTE Eintrag,
     * den unser eigener nginx angehängt hat.
     */
    public static function clientIp(): ?string
    {
        $xff = $_SERVER['HTTP_X_FORWARDED_FOR'] ?? '';
        if ($xff !== '') {
            $teile = array_map('trim', explode(',', $xff));
            $letzte = end($teile);
            if ($letzte !== false && filter_var($letzte, FILTER_VALIDATE_IP)) {
                return $letzte;
            }
        }
        $remote = $_SERVER['REMOTE_ADDR'] ?? '';
        return filter_var($remote, FILTER_VALIDATE_IP) ? $remote : null;
    }

    /**
     * Der Hash über die gesamte Beweiszeile, verkettet mit der vorherigen
     * Unterschrift.
     *
     * Damit ist nicht nur die einzelne Zeile geschützt, sondern ihre Stellung
     * in der Reihe: wer eine alte Unterschrift nachträglich ändert, müsste
     * jede spätere neu berechnen, und die liegen bereits in signierten PDFs.
     *
     * Die Feldreihenfolge ist Teil des Beweises und darf sich nie ändern —
     * sonst rechnen alte und neue Zeilen verschieden und die Kette bricht,
     * ohne dass jemand manipuliert hätte.
     */
    public static function kettenHash(array $zeile, ?string $prevHash): string
    {
        $teile = [
            (string)$zeile['id'],
            (string)$zeile['user_id'],
            (string)$zeile['dokument_typ'],
            (string)$zeile['pdf_hash'],
            (string)($zeile['signature_svg'] ?? ''),
            (string)($zeile['signed_at_utc'] ?? ''),
            (string)($zeile['ip_address'] ?? ''),
            (string)($zeile['device_id'] ?? ''),
            (string)($zeile['tan_verified_at'] ?? ''),
            (string)($prevHash ?? ''),
        ];
        return hash('sha256', implode('|', $teile));
    }

    /**
     * Der full_hash der zuletzt unterschriebenen Zeile — das vorherige Glied
     * der Kette. `FOR UPDATE`, damit zwei gleichzeitige Unterschriften nicht
     * beide auf dasselbe Glied zeigen und die Kette sich gabelt.
     */
    public static function letzterKettenHash(PDO $pdo): ?string
    {
        $stmt = $pdo->query(
            "SELECT full_hash FROM dokument_signaturen
             WHERE status = 'signiert' AND full_hash IS NOT NULL
             ORDER BY id DESC LIMIT 1 FOR UPDATE"
        );
        $hash = $stmt->fetchColumn();
        return $hash === false ? null : (string)$hash;
    }

    /**
     * Zufälliger, nicht durchprobierbarer Code für die öffentliche Prüfseite.
     */
    public static function verifyCode(): string
    {
        return bin2hex(random_bytes(16));
    }

    /**
     * Text der TAN-SMS.
     *
     * Bewusst ohne Dokumenttitel: die SMS geht über das Mobilfunknetz und
     * durch die Hände des Providers. Dass jemand etwas unterschreibt, ist
     * seine Sache — in der SMS steht nur, wofür der Code gilt.
     */
    public static function smsText(string $tan): string
    {
        return "ICD360S: Ihr Bestaetigungscode zum Unterschreiben lautet $tan. "
             . "Gueltig " . self::TAN_GUELTIG_MINUTEN . " Minuten. "
             . "Geben Sie den Code niemals weiter.";
    }
}
