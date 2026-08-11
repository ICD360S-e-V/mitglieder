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
    /** Steht als Signatur UNTER jeder TAN-SMS, wie unter einem Brief. */
    public const ABSENDER = 'ICD360S e.V.';

    /** Wie lange eine TAN gilt.
     *
     *  Fünf Minuten: kurz genug, dass ein abgefangener oder mitgelesener Code
     *  schnell wertlos wird, und lang genug für den Weg Server → Weckruf →
     *  Tablet → Mobilfunknetz, der im Normalfall in Sekunden durch ist.
     *
     *  Diese Zahl steht auch in der SMS (siehe [smsText]) und begrenzt, wie
     *  lange eine hängende Warteschlangenzeile überhaupt noch Sinn hat — wer
     *  sie ändert, muss das Zeitfenster in signatur_queue.php mitziehen,
     *  sonst werden Zeilen erst wieder freigegeben, wenn ihr Code längst
     *  tot ist. */
    public const TAN_GUELTIG_MINUTEN = 5;

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
     * Land und Netzbetreiber zu einer IP.
     *
     * Die IP allein ist eine Zahl, die im Streitfall niemand einordnen kann.
     * Land und Betreiber machen daraus eine Aussage, die jemand nachvollziehen
     * kann — und der Betreiber ist dabei der wertvollere der beiden: er
     * unterscheidet eine gewöhnliche Anschlussleitung („1&1 Versatel GmbH",
     * „Vodafone") von einem Rechenzentrum („OVH SAS"). Zweiteres heißt VPN
     * oder Server, also genau der Fall, in dem die IP über den Aufenthaltsort
     * NICHTS aussagt. Das gehört sichtbar ins Bündel, statt dass es die
     * Gegenseite später herausfindet.
     *
     * BEWUSST KEINE STADT. IP-Ortung auf Stadtebene zeigt bei Mobilfunk
     * regelmäßig den Standort des Betreiber-Gateways, nicht den des Menschen —
     * oft hunderte Kilometer daneben. Eine Angabe, die sich widerlegen lässt,
     * schwächt das ganze Bündel: wer einen Eintrag als falsch nachweist, stellt
     * alle übrigen in Frage.
     *
     * Die Tabellen füllt api/cron/ip_datenbank_aktualisieren.php monatlich.
     * Fehlen sie oder ist die IP unbekannt, bleibt es bei null — lieber keine
     * Angabe als eine erfundene.
     *
     * @return array{land: ?string, netz: ?string}
     */
    public static function ipHerkunft(PDO $pdo, ?string $ip): array
    {
        $leer = ['land' => null, 'netz' => null];
        if ($ip === null || !filter_var($ip, FILTER_VALIDATE_IP)) {
            return $leer;
        }

        try {
            // ORDER BY start_ip DESC LIMIT 1 nutzt den Primärschlüssel: der
            // letzte Bereich, der nicht hinter der Adresse beginnt.
            $stmt = $pdo->prepare(
                "SELECT
                   (SELECT land FROM ip_land
                     WHERE start_ip <= INET6_ATON(:ip) AND end_ip >= INET6_ATON(:ip)
                     ORDER BY start_ip DESC LIMIT 1) AS land,
                   (SELECT netz FROM ip_netz
                     WHERE start_ip <= INET6_ATON(:ip) AND end_ip >= INET6_ATON(:ip)
                     ORDER BY start_ip DESC LIMIT 1) AS netz"
            );
            $stmt->execute([':ip' => $ip]);
            $z = $stmt->fetch(PDO::FETCH_ASSOC) ?: $leer;

            // „ZZ" ist der Platzhalter der Datenbank für unbekannt.
            if (($z['land'] ?? '') === 'ZZ') {
                $z['land'] = null;
            }
            return ['land' => $z['land'] ?: null, 'netz' => $z['netz'] ?: null];
        } catch (Throwable $e) {
            // Fehlende Tabellen dürfen eine Unterschrift nicht berühren.
            error_log('SignaturHelper::ipHerkunft: ' . $e->getMessage());
            return $leer;
        }
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
     * Das letzte Glied der Kette: seine Position und sein full_hash.
     *
     * Sortiert wird über ketten_nr, NICHT über die id. Die id ist die
     * Reihenfolge der Anforderung; wann jemand unterschreibt, entscheidet er
     * selbst. Bei zwei offenen Anfragen konnten deshalb zwei Zeilen denselben
     * Vorgänger bekommen — eine Gabel, die niemandem auffällt, weil jede Zeile
     * beim Prüfen nur ihren eigenen Hash nachrechnet. Siehe die Migration
     * 2026_08_11_kettenposition.sql für den vollständigen Ablauf.
     *
     * Über signed_at_utc zu sortieren würde nicht reichen: die Spalte ist
     * DATETIME, zwei Unterschriften in derselben Sekunde wären gleichrangig.
     *
     * `FOR UPDATE` hält die Position fest, bis die laufende Unterschrift
     * geschrieben ist — sonst holen sich zwei gleichzeitige Unterzeichner
     * dieselbe Nummer. Der UNIQUE-Index auf ketten_nr fängt das zusätzlich ab.
     *
     * @return array{nr:int, hash:?string} nr 0 = die Kette ist noch leer
     */
    public static function vorherigesGlied(PDO $pdo): array
    {
        $stmt = $pdo->query(
            "SELECT ketten_nr, full_hash FROM dokument_signaturen
             WHERE status = 'signiert' AND full_hash IS NOT NULL
               AND ketten_nr IS NOT NULL
             ORDER BY ketten_nr DESC LIMIT 1 FOR UPDATE"
        );
        $zeile = $stmt->fetch(PDO::FETCH_ASSOC);
        return $zeile === false
            ? ['nr' => 0, 'hash' => null]
            : ['nr' => (int)$zeile['ketten_nr'], 'hash' => (string)$zeile['full_hash']];
    }

    /**
     * @deprecated Nur noch für die Umstellung da. Bitte vorherigesGlied()
     *             benutzen — diese Fassung liefert den Hash, aber nicht die
     *             Position, und ohne Position ist die Verkettung später nicht
     *             mehr nachprüfbar.
     *
     * Warum sie überhaupt stehen bleibt: OPcache übernimmt geänderte Dateien
     * erst nach `opcache.revalidate_freq`, und die drei Dateien dieser Änderung
     * werden nicht in derselben Sekunde übernommen. In diesem Fenster läuft der
     * neue Helfer neben dem alten member-Endpunkt. Ohne diesen Wrapper wäre das
     * ein Fatal Error mitten in einer Unterschrift — ausgerechnet an der Stelle,
     * an der ein Mitglied gerade seine TAN eingegeben hat.
     *
     * Sie ist dabei nicht bloß Attrappe: sie sortiert bereits über ketten_nr,
     * gibt also den RICHTIGEN Vorgänger zurück. Eine in diesem Fenster
     * geleistete Unterschrift bekommt lediglich keine Positionsnummer und gilt
     * damit als „nicht prüfbar" statt als bestätigt — die ehrliche Auskunft.
     *
     * Entfernen, sobald member/signatur_manage.php sicher live ist.
     */
    public static function letzterKettenHash(PDO $pdo): ?string
    {
        return self::vorherigesGlied($pdo)['hash'];
    }

    /**
     * Hängt die Zeile wirklich an ihrem Vorgänger, oder steht ihr Hash nur für
     * sich allein?
     *
     * Das ist die Prüfung, die bisher fehlte. `kettenHash()` beweist, dass EINE
     * Zeile seit dem Unterschreiben unverändert ist. Erst der Vergleich mit dem
     * full_hash des Vorgängers beweist, dass die Kette keine Lücke hat — dass
     * also niemand ein Glied entfernt hat. Ohne sie meldet auch eine zerlegte
     * Kette Zeile für Zeile „in Ordnung".
     *
     * @return bool|null null = nicht prüfbar (nicht unterschrieben, oder vor
     *                   der Einführung von ketten_nr geleistet)
     */
    public static function verkettungPruefen(PDO $pdo, array $zeile): ?bool
    {
        if (($zeile['status'] ?? '') !== 'signiert'
            || ($zeile['full_hash'] ?? null) === null
            || ($zeile['ketten_nr'] ?? null) === null) {
            return null;
        }

        $nr   = (int)$zeile['ketten_nr'];
        $prev = (string)($zeile['prev_hash'] ?? '');

        // Das erste Glied hat keinen Vorgänger — dann MUSS prev_hash leer sein.
        if ($nr <= 1) {
            return $prev === '';
        }

        $stmt = $pdo->prepare(
            "SELECT full_hash FROM dokument_signaturen WHERE ketten_nr = ?"
        );
        $stmt->execute([$nr - 1]);
        $vorgaenger = $stmt->fetchColumn();

        // Kein Vorgänger auf der Position: das Glied wurde entfernt. Genau der
        // Fall, den diese Prüfung sichtbar machen soll.
        if ($vorgaenger === false) {
            return false;
        }

        return hash_equals((string)$vorgaenger, $prev);
    }

    /**
     * Zufälliger, nicht durchprobierbarer Code für die öffentliche Prüfseite.
     */
    public static function verifyCode(): string
    {
        return bin2hex(random_bytes(16));
    }

    /**
     * Anrede aus dem Geschlecht — wie [anredeform] auf der Client-Seite.
     *
     * 20 der 52 Mitglieder haben in Stufe 1 kein Geschlecht hinterlegt. Für sie
     * MUSS es eine neutrale Form geben: lieber „Guten Tag" als geraten und die
     * Hälfte falsch angesprochen.
     */
    private static function anrede(?string $geschlecht): string
    {
        $g = strtolower(trim((string)$geschlecht));
        if (in_array($g, ['w', 'f', 'weiblich', 'frau', 'female', 'feminin'], true)) {
            return 'frau';
        }
        if (in_array($g, ['m', 'maennlich', 'männlich', 'mann', 'herr', 'male'], true)) {
            return 'herr';
        }
        return 'neutral';
    }

    /**
     * Bausteine der TAN-SMS je Sprache.
     *
     * Genau die sieben Sprachen, die in `users.preferred_language` tatsächlich
     * vorkommen (de 23, ro 11, ru 10, en 4, uk 2, tr 1, ar 1) — dieselben, für
     * die es auch bei den Wetter- und Termin-SMS schon Formeln gibt. Die
     * ENUM-Spalte kennt 28 Werte; alles Übrige fällt auf Deutsch zurück, statt
     * eine Sprache vorzutäuschen, die niemand geprüft hat.
     *
     * `%anrede%` trägt bereits den Namen, `%code%` die TAN, `%min%` die Frist.
     */
    private static function bausteine(string $sprache): array
    {
        $tabelle = [
            'de' => [
                'frau' => 'Sehr geehrte Frau', 'herr' => 'Sehr geehrter Herr',
                'neutral' => 'Guten Tag',
                'text' => "%anrede%,\nIhr Code zum Unterschreiben: %code%\n"
                        . "Gueltig %min% Minuten. Nicht weitergeben.\n"
                        . "Nicht angefordert? Bitte ignorieren.",
            ],
            'en' => [
                'frau' => 'Dear Ms', 'herr' => 'Dear Mr', 'neutral' => 'Hello',
                'text' => "%anrede%,\nYour code for signing: %code%\n"
                        . "Valid %min% minutes. Do not share it.\n"
                        . "Did not request it? Please ignore.",
            ],
            'ro' => [
                'frau' => 'Stimata doamna', 'herr' => 'Stimate domnule',
                'neutral' => 'Buna ziua',
                'text' => "%anrede%,\nCodul pentru semnare: %code%\n"
                        . "Valabil %min% minute. Nu il transmiteti nimanui.\n"
                        . "Nu l-ati cerut? Ignorati acest mesaj.",
            ],
            'tr' => [
                'frau' => 'Sayin', 'herr' => 'Sayin', 'neutral' => 'Merhaba',
                'text' => "%anrede%,\nImzalama kodunuz: %code%\n"
                        . "%min% dakika gecerli. Kimseyle paylasmayin.\n"
                        . "Talep etmediyseniz dikkate almayin.",
            ],
            'ru' => [
                'frau' => 'Уважаемая г-жа', 'herr' => 'Уважаемый г-н',
                'neutral' => 'Здравствуйте',
                'text' => "%anrede%,\nВаш код для подписи: %code%\n"
                        . "Действует %min% минут. Никому не сообщайте.\n"
                        . "Не запрашивали? Игнорируйте.",
            ],
            'uk' => [
                'frau' => 'Шановна пані', 'herr' => 'Шановний пане',
                'neutral' => 'Доброго дня',
                'text' => "%anrede%,\nВаш код для підпису: %code%\n"
                        . "Дійсний %min% хвилин. Нікому не повідомляйте.\n"
                        . "Не запитували? Проігноруйте.",
            ],
            'ar' => [
                'frau' => 'السيدة المحترمة', 'herr' => 'السيد المحترم',
                'neutral' => 'مرحبا',
                'text' => "%anrede%،\nرمز التوقيع الخاص بك: %code%\n"
                        . "صالح %min% دقائق. لا تشاركه مع أحد.\n"
                        . "لم تطلبه؟ يرجى تجاهل الرسالة.",
            ],
        ];

        return $tabelle[$sprache] ?? $tabelle['de'];
    }

    /**
     * Text der TAN-SMS, in der Sprache des Mitglieds und mit seiner Anrede.
     *
     * WAS BEWUSST NICHT DRINSTEHT: der Titel des Dokuments. Die SMS läuft über
     * das Mobilfunknetz und liegt auf dem Sperrbildschirm — dass jemand etwas
     * unterschreibt, und was, ist seine Sache.
     *
     * WAS NEU DRINSTEHT: der Hinweis „nicht angefordert? ignorieren". Das ist
     * die einzige Stelle, an der ein Mitglied merken kann, dass jemand anderes
     * gerade versucht, in seinem Namen zu unterschreiben. Die Empfehlungen zu
     * Einmalcodes (u. a. NIST) nennen genau vier Bestandteile — Dienst, Code,
     * Zweck, Warnhinweis — und der vierte fehlte bisher.
     *
     * Der Name steht bewusst nur als Nachname nach der Anrede, nicht mit
     * Vornamen: kürzer, und auf einem fremden Sperrbildschirm verrät er weniger.
     *
     * @param array $empfaenger nachname, geschlecht, preferred_language
     */
    public static function smsText(string $tan, array $empfaenger = []): string
    {
        $sprache = strtolower(trim((string)($empfaenger['preferred_language'] ?? 'de')));
        $b = self::bausteine($sprache);

        $nachname = trim((string)($empfaenger['nachname'] ?? ''));
        $form = self::anrede($empfaenger['geschlecht'] ?? null);

        // Ohne Namen ergibt „Sehr geehrter Herr ," Unsinn — dann die neutrale
        // Form, die auch allein trägt.
        $anrede = ($nachname === '' || $form === 'neutral')
            ? $b['neutral']
            : $b[$form] . ' ' . $nachname;

        $text = strtr($b['text'], [
            '%anrede%' => $anrede,
            '%code%'   => $tan,
            '%min%'    => (string)self::TAN_GUELTIG_MINUTEN,
        ]);

        // Der Absender steht UNTER der Nachricht, wie die Unterschrift unter
        // einem Brief. Einmal hier angehaengt und nicht in jede der sieben
        // Vorlagen geschrieben — sonst gaebe es sieben Gelegenheiten, ihn
        // unterschiedlich zu schreiben oder zu vergessen.
        //
        // Preis dieser Anordnung: in der Vorschau auf dem Sperrbildschirm,
        // die nach wenigen Zeilen abschneidet, ist der Absender nicht mehr
        // zu sehen. Wer die SMS ganz oeffnet, sieht ihn.
        return $text . "\n" . self::ABSENDER;
    }
}
