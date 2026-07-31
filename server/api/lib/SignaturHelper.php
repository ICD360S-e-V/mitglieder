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
