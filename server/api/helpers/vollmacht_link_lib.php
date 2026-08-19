<?php
/**
 * Vollmacht per SMS-Link — fuer Mitglieder OHNE App.
 *
 * Gemessen am 18.08.2026: von 44 aktiven Mitgliedern haben 20 die App und 24
 * eine Mobilnummer. ZWOELF haben eine Nummer, aber keine App — die koennen
 * heute ueberhaupt nichts unterschreiben. (Acht weitere haben die App, aber
 * keine Nummer; die erreicht auch dieser Weg nicht, denn ohne Rufnummer gibt
 * es keinen Code. Das ist eine andere Luecke.)
 *
 * ZWEI Links, nacheinander:
 *
 *   lesen      → Leseexemplar in der Sprache des Mitglieds, ohne Unterschrift.
 *                Darf heruntergeladen werden; der Download wird protokolliert.
 *   signieren  → die deutsche Fassung, die bindet. Finger + Code per SMS.
 *
 * Der zweite Link geht von Hand, nachdem das Mitglied bestaetigt hat.
 *
 * ⚠️ Diese Datei erzeugt KEINE zweite Beweisklasse. Unterschrieben wird
 * weiterhin ueber dokument_signaturen mit derselben Hash-Kette und demselben
 * Siegel; hier steht nur der WEG dorthin.
 */

declare(strict_types=1);

if (!defined('API_ACCESS')) {
    http_response_code(403);
    exit('Direct access not permitted');
}

/** Wie lange ein Link gilt. Entscheidung des Vorsitzenden, 18.08.2026. */
const VL_GUELTIG_MINUTEN = 30;

/** Wie oft ueber EINEN Link ein Code angefordert werden darf. */
const VL_MAX_CODES = 3;

/**
 * Die Basis der Adresse, die in der SMS steht.
 *
 * ⚠️ Kurz halten. Jedes Zeichen zaehlt gegen die 160 eines GSM-7-Segments,
 * und ein zweites Segment kostet doppelt — bei einem Link, der ohnehin schon
 * 22 Zeichen Zufall traegt.
 */
const VL_BASIS = 'https://icd360sev.icd360s.de/u/';

/**
 * Die beiden Vollmacht-Arten, die diesen Weg benutzen duerfen.
 *
 * ⚠️ Absichtlich eine Liste und kein freier Parameter: `quelle_tabelle`
 * landet in einer Abfrage. Eine unbekannte Tabelle wird abgelehnt, nicht
 * durchgereicht.
 */
const VL_QUELLEN = [
    'member_vollmachten'   => true,   // Gericht und Insolvenzverwaltung
    'vertrag_ra_vollmacht' => true,   // Kanzlei im Inkasso-Zweig
];

/**
 * Ein Token, das in eine SMS passt und sich nicht erraten laesst.
 *
 * 22 Zeichen aus einem 62er-Alphabet sind rund 131 Bit — mehr als genug,
 * und ohne die Zeichen, die beim Abtippen verwechselt werden koennten,
 * falls doch einmal jemand tippt statt tippt-auf-den-Link.
 */
function vlTokenErzeugen(): string
{
    $alphabet = '23456789abcdefghijkmnpqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ';
    $max = strlen($alphabet) - 1;
    $out = '';
    for ($i = 0; $i < 22; $i++) {
        $out .= $alphabet[random_int(0, $max)];
    }
    return $out;
}

/**
 * ⚠️ Gesalzen mit dem Zweck, damit derselbe Zufall nicht zweimal denselben
 * Hash ergibt, falls er je wiederverwendet wuerde.
 */
function vlTokenHash(string $token): string
{
    return hash('sha256', 'vollmacht_link|' . $token);
}

/**
 * Der Text der SMS.
 *
 * ⚠️ Sieben feste Sprachen, keine Maschinenuebersetzung — dieselbe
 * Entscheidung wie bei den Geburtstagsglueckwuenschen und der
 * Kontakt-Erinnerung. Ein automatisch falsch uebersetzter Satz ueber eine
 * Vollmacht ist schlimmer als einer auf Deutsch. Genau diese sieben kommen
 * in `preferred_language` der Mitglieder vor (geprueft am 18.08.2026).
 *
 * ⚠️ Russisch, Ukrainisch und Arabisch stehen LATEINISCH da. Zwei Gruende,
 * und beide sind gemessen, nicht vermutet: Kyrillisch und Arabisch zwingen
 * die SMS auf UCS-2 (67 Zeichen je Segment statt 160), und der Link allein
 * ist schon 53 Zeichen lang — die Nachricht bekaeme drei Segmente statt
 * einem. Bei Arabisch kommt hinzu, dass eine Rechts-nach-links-Zeile mit
 * einer lateinischen Adresse darin auf vielen Telefonen unvorhersehbar
 * umbricht, und ein zerrissener Link ist kein Link.
 *
 * ⚠️ Die Adresse steht auf einer EIGENEN Zeile, ganz am Ende. Telefone
 * erkennen sie dann zuverlaessig als antippbar; mitten im Satz haengt oft
 * der Satzpunkt mit im Link.
 */
function vlSmsText(string $sprache, string $zweck, string $url, string $nachname): string
{
    $lesen = [
        'de' => "Guten Tag %s,\nder Verein hat eine Vollmacht fuer Sie vorbereitet. Hier koennen Sie sie in Ihrer Sprache lesen und herunterladen. Der Link gilt 30 Minuten.\n%s",
        'ro' => "Buna ziua %s,\nasociatia a pregatit o imputernicire pentru dumneavoastra. Aici o puteti citi si descarca in limba dumneavoastra. Linkul este valabil 30 de minute.\n%s",
        'en' => "Hello %s,\nthe association has prepared a power of attorney for you. Here you can read and download it in your language. The link is valid for 30 minutes.\n%s",
        'ru' => "Dobryy den %s,\nobyedineniye podgotovilo dlya vas doverennost. Zdes vy mozhete prochitat i skachat yeye na vashem yazyke. Ssylka deystvitelna 30 minut.\n%s",
        'uk' => "Dobryy den %s,\nobyednannya pidhotuvalo dlya vas dovirenist. Tut vy mozhete prochytaty i zavantazhyty yiyi vashoyu movoyu. Posylannya diysne 30 khvylyn.\n%s",
        'tr' => "Iyi gunler %s,\ndernek sizin icin bir vekaletname hazirladi. Burada kendi dilinizde okuyup indirebilirsiniz. Baglanti 30 dakika gecerlidir.\n%s",
        'ar' => "Marhaban %s,\nal-jamiyya aadat lak tawkilan. Huna yumkinuka qiraatuhu wa tahmiluhu bilughatik. Ar-rabt salih li 30 daqiqa.\n%s",
    ];
    $signieren = [
        'de' => "Guten Tag %s,\nhier koennen Sie die Vollmacht unterschreiben. Sie unterschreiben mit dem Finger; den Bestaetigungscode bekommen Sie danach per SMS. Der Link gilt 30 Minuten.\n%s",
        'ro' => "Buna ziua %s,\naici puteti semna imputernicirea. Semnati cu degetul; codul de confirmare il primiti apoi prin SMS. Linkul este valabil 30 de minute.\n%s",
        'en' => "Hello %s,\nhere you can sign the power of attorney. You sign with your finger; the confirmation code follows by SMS. The link is valid for 30 minutes.\n%s",
        'ru' => "Dobryy den %s,\nzdes vy mozhete podpisat doverennost. Podpis palcem; kod podtverzhdeniya pridet potom po SMS. Ssylka deystvitelna 30 minut.\n%s",
        'uk' => "Dobryy den %s,\ntut vy mozhete pidpysaty dovirenist. Pidpys palcem; kod pidtverdzhennya pryyde potim po SMS. Posylannya diysne 30 khvylyn.\n%s",
        'tr' => "Iyi gunler %s,\nvekaletnameyi burada imzalayabilirsiniz. Parmaginizla imzalarsiniz; onay kodu ardindan SMS ile gelir. Baglanti 30 dakika gecerlidir.\n%s",
        'ar' => "Marhaban %s,\nhuna yumkinuka tawqi at-tawkil. Tuwaqqi biisbaik; ramz at-taakid yasiluka baada dhalik bi risala. Ar-rabt salih li 30 daqiqa.\n%s",
    ];

    $tabelle = $zweck === 'signieren' ? $signieren : $lesen;
    $vorlage = $tabelle[$sprache] ?? $tabelle['de'];
    return sprintf($vorlage, $nachname, $url);
}

/**
 * Legt einen Link an, reiht die SMS ein und weckt das Tablet.
 *
 * Gibt `['ok'=>bool, 'meldung'=>string, 'link_id'=>?int, 'gesendet_an'=>string]`
 * zurueck. Der Klartext-Token verlaesst diese Funktion NICHT — er steht nur
 * in der SMS.
 *
 * ⚠️ Die Rufnummer kommt aus Verifizierung Stufe 1, niemals aus dem Aufruf.
 * Sonst liesse sich ein Link an ein fremdes Telefon schicken, und mit ihm
 * spaeter der Code — der ganze Weg waere offen.
 */
function vlErzeugen(PDO $pdo, array $a): array
{
    $tabelle = (string)($a['quelle_tabelle'] ?? '');
    $quelleId = (int)($a['quelle_id'] ?? 0);
    $zweck    = (string)($a['zweck'] ?? '');
    $absender = (int)($a['gesendet_von'] ?? 0);

    if (!isset(VL_QUELLEN[$tabelle]) || $quelleId <= 0) {
        return ['ok' => false, 'meldung' => 'Unbekannte Vollmacht'];
    }
    if (!in_array($zweck, ['lesen', 'signieren'], true)) {
        return ['ok' => false, 'meldung' => 'Unbekannter Zweck'];
    }

    $vm = vlVollmacht($pdo, $tabelle, $quelleId);
    if ($vm === null) {
        return ['ok' => false, 'meldung' => 'Vollmacht nicht gefunden'];
    }
    if ($vm['widerrufen']) {
        // Dieselbe Regel wie beim Fax- und Mailversand.
        return ['ok' => false, 'meldung' => 'Diese Vollmacht ist widerrufen und darf nicht '
            . 'mehr hinausgehen.'];
    }

    $u = $pdo->prepare('SELECT id, nachname, telefon_mobil, preferred_language
                          FROM users WHERE id = ?');
    $u->execute([(int)$vm['user_id']]);
    $mitglied = $u->fetch(PDO::FETCH_ASSOC);
    if (!$mitglied) {
        return ['ok' => false, 'meldung' => 'Mitglied nicht gefunden'];
    }

    $telefon = trim((string)($mitglied['telefon_mobil'] ?? ''));
    if ($telefon === '') {
        // Eigener, benennbarer Grund — „geht nicht" ohne Warum ist hier das
        // Schlimmste, was der Bildschirm sagen koennte.
        return ['ok' => false, 'grund' => 'keine_rufnummer',
                'meldung' => 'Fuer dieses Mitglied ist keine Mobilnummer hinterlegt. '
                           . 'Ohne Nummer gibt es weder Link noch Code.'];
    }

    // ── Welche Fassung haengt an diesem Link? ────────────────────────
    if ($zweck === 'lesen') {
        $sprache = (string)($vm['uebersetzung_sprache'] ?? '');
        if ($sprache === '' || !$vm['hat_uebersetzung']) {
            return ['ok' => false, 'grund' => 'keine_uebersetzung',
                    'meldung' => 'Fuer diese Vollmacht gibt es kein Leseexemplar. '
                               . 'Erst eine Uebersetzung erzeugen, dann laesst sie sich '
                               . 'zum Lesen schicken.'];
        }
        $fassung = 'uebersetzung';
    } else {
        // ⚠️ Unterschrieben wird IMMER die deutsche Fassung. Das Leseexemplar
        // traegt kein Unterschriftsfeld und bindet nicht.
        $fassung = 'original';
        $sprache = 'de';
    }

    $token = vlTokenErzeugen();

    try {
        $pdo->beginTransaction();

        // ⚠️ Frueher verschickte, noch offene Links desselben Zwecks
        // verfallen. Sonst waeren nach dreimaligem „nochmal schicken" drei
        // Adressen gueltig, und im Protokoll stuende dreimal dasselbe, ohne
        // dass erkennbar waere, welche der drei benutzt wurde.
        $pdo->prepare("UPDATE vollmacht_link
                          SET gueltig_bis = UTC_TIMESTAMP()
                        WHERE quelle_tabelle = ? AND quelle_id = ? AND zweck = ?
                          AND gueltig_bis > UTC_TIMESTAMP()
                          AND erledigt_am IS NULL")
            ->execute([$tabelle, $quelleId, $zweck]);

        $ins = $pdo->prepare(
            'INSERT INTO vollmacht_link
               (quelle_tabelle, quelle_id, user_id, zweck, fassung, sprache,
                token_hash, gueltig_bis, gesendet_an, gesendet_von)
             VALUES (?, ?, ?, ?, ?, ?, ?, DATE_ADD(UTC_TIMESTAMP(), INTERVAL ? MINUTE), ?, ?)');
        $ins->execute([
            $tabelle, $quelleId, (int)$mitglied['id'], $zweck, $fassung,
            $sprache !== '' ? $sprache : null,
            vlTokenHash($token), VL_GUELTIG_MINUTEN, $telefon, $absender,
        ]);
        $linkId = (int)$pdo->lastInsertId();

        $text = vlSmsText(
            (string)($mitglied['preferred_language'] ?? 'de'),
            $zweck,
            VL_BASIS . $token,
            trim((string)($mitglied['nachname'] ?? ''))
        );

        // Dieselbe Warteschlange wie die TAN: das Tablet liest daraus nur id,
        // telefon und body — deshalb braucht dieser Weg keinen App-Release.
        $pdo->prepare('INSERT INTO signatur_sms_queue
                         (tan_id, link_id, signatur_id, telefon, body)
                       VALUES (NULL, ?, 0, ?, ?)')
            ->execute([$linkId, $telefon, mb_substr($text, 0, 320)]);

        $pdo->commit();
    } catch (Throwable $e) {
        if ($pdo->inTransaction()) $pdo->rollBack();
        error_log('vlErzeugen: ' . $e->getMessage());
        return ['ok' => false, 'meldung' => 'Der Link konnte nicht erzeugt werden'];
    }

    vlTabletWecken($pdo);

    return [
        'ok' => true,
        'link_id' => $linkId,
        'gesendet_an' => vlNummerMaskieren($telefon),
        'gueltig_minuten' => VL_GUELTIG_MINUTEN,
        'meldung' => 'Der Link ist unterwegs an ' . vlNummerMaskieren($telefon)
                   . ' und gilt ' . VL_GUELTIG_MINUTEN . ' Minuten.',
    ];
}

/**
 * Die Vollmacht, unabhaengig davon, aus welcher der beiden Tabellen sie
 * stammt. Vereinheitlicht nur das, was dieser Weg braucht.
 */
function vlVollmacht(PDO $pdo, string $tabelle, int $id): ?array
{
    if ($tabelle === 'member_vollmachten') {
        $st = $pdo->prepare('SELECT id, user_id, status, pdf_filename, pdf_sha256,
                                    pdf_translation_filename, translation_language
                               FROM member_vollmachten WHERE id = ?');
        $st->execute([$id]);
        $r = $st->fetch(PDO::FETCH_ASSOC);
        if (!$r) return null;
        return [
            'user_id'              => (int)$r['user_id'],
            'widerrufen'           => (string)$r['status'] === 'revoked',
            'hat_uebersetzung'     => trim((string)($r['pdf_translation_filename'] ?? '')) !== '',
            'uebersetzung_sprache' => (string)($r['translation_language'] ?? ''),
        ];
    }

    $st = $pdo->prepare('SELECT id, user_id, status, pdf_filename,
                                pdf_uebersetzung_filename, uebersetzung_sprache
                           FROM vertrag_ra_vollmacht WHERE id = ?');
    $st->execute([$id]);
    $r = $st->fetch(PDO::FETCH_ASSOC);
    if (!$r) return null;
    return [
        'user_id'              => (int)$r['user_id'],
        'widerrufen'           => (string)$r['status'] === 'widerrufen',
        'hat_uebersetzung'     => trim((string)($r['pdf_uebersetzung_filename'] ?? '')) !== '',
        'uebersetzung_sprache' => (string)($r['uebersetzung_sprache'] ?? ''),
    ];
}

/**
 * Loest einen Token auf.
 *
 * ⚠️ Nennt den Grund, statt pauschal „ungueltig" zu sagen: „abgelaufen" darf
 * einen neuen Link anbieten, „unbekannt" nicht. Wer beides gleich behandelt,
 * laesst den Menschen mit einem toten Link stehen, obwohl ihm zu helfen waere.
 */
function vlAufloesen(PDO $pdo, string $token): array
{
    $token = trim($token);
    if ($token === '' || strlen($token) > 64) {
        return ['status' => 'unbekannt'];
    }
    $st = $pdo->prepare('SELECT * FROM vollmacht_link WHERE token_hash = ?');
    $st->execute([vlTokenHash($token)]);
    $l = $st->fetch(PDO::FETCH_ASSOC);
    if (!$l) return ['status' => 'unbekannt'];

    if ($l['erledigt_am'] !== null) {
        return ['status' => 'erledigt', 'link' => $l];
    }
    $ab = $pdo->prepare('SELECT gueltig_bis <= UTC_TIMESTAMP() FROM vollmacht_link WHERE id = ?');
    $ab->execute([(int)$l['id']]);
    if ((int)$ab->fetchColumn() === 1) {
        return ['status' => 'abgelaufen', 'link' => $l];
    }
    return ['status' => 'ok', 'link' => $l];
}

/**
 * Haelt fest, dass der Link geoeffnet wurde.
 *
 * ⚠️ Nur beim ERSTEN Mal. Das Feld beantwortet „wann hat er ihn aufgemacht",
 * nicht „wie oft" — und jede Aktualisierung wuerde den ersten Zeitpunkt
 * ueberschreiben, also genau die Angabe, die zaehlt.
 */
function vlGeoeffnet(PDO $pdo, int $linkId): void
{
    try {
        $pdo->prepare("UPDATE vollmacht_link
                          SET geoeffnet_am = UTC_TIMESTAMP(),
                              ip_address = ?, user_agent = ?
                        WHERE id = ? AND geoeffnet_am IS NULL")
            ->execute([
                vlClientIp(),
                mb_substr((string)($_SERVER['HTTP_USER_AGENT'] ?? ''), 0, 500),
                $linkId,
            ]);
    } catch (Throwable $e) {
        error_log('vlGeoeffnet: ' . $e->getMessage());
    }
}

/** Wie [vlGeoeffnet], nur fuer den Download. Ebenfalls nur das erste Mal. */
function vlGeladen(PDO $pdo, int $linkId): void
{
    try {
        $pdo->prepare("UPDATE vollmacht_link SET geladen_am = UTC_TIMESTAMP()
                        WHERE id = ? AND geladen_am IS NULL")->execute([$linkId]);
    } catch (Throwable $e) {
        error_log('vlGeladen: ' . $e->getMessage());
    }
}

/** „Ich habe es gelesen" auf der Leseseite. Keine Schranke, nur ein Vermerk. */
function vlBestaetigt(PDO $pdo, int $linkId): void
{
    try {
        $pdo->prepare("UPDATE vollmacht_link SET bestaetigt_am = UTC_TIMESTAMP()
                        WHERE id = ? AND bestaetigt_am IS NULL")->execute([$linkId]);
    } catch (Throwable $e) {
        error_log('vlBestaetigt: ' . $e->getMessage());
    }
}

/**
 * Das PDF, das an diesem Link haengt — entschluesselt, im Speicher.
 *
 * ⚠️ Die beiden Vollmacht-Arten liegen VERSCHIEDEN auf der Platte:
 * `member_vollmachten` unter uploads/vollmachten mit eigener Dateiverschlues-
 * selung (`vm_dec_file`), `vertrag_ra_vollmacht` unter uploads/ra_vollmacht
 * als `.enc` (`raDateiLesen`). Wer das uebersieht, bekommt Bytes, die kein
 * PDF sind — und der Browser zeigt eine leere Seite statt einer Meldung.
 */
function vlDokument(PDO $pdo, array $link): ?array
{
    $tabelle  = (string)$link['quelle_tabelle'];
    $quelleId = (int)$link['quelle_id'];
    $fassung  = (string)$link['fassung'];

    if ($tabelle === 'member_vollmachten') {
        $st = $pdo->prepare('SELECT pdf_filename, pdf_translation_filename
                               FROM member_vollmachten WHERE id = ?');
        $st->execute([$quelleId]);
        $r = $st->fetch(PDO::FETCH_ASSOC);
        if (!$r) return null;
        $rel = $fassung === 'uebersetzung'
            ? (string)($r['pdf_translation_filename'] ?? '')
            : (string)($r['pdf_filename'] ?? '');
        if ($rel === '') return null;
        $abs = realpath(__DIR__ . '/../../uploads/vollmachten') . '/' . basename($rel);
        if (!is_file($abs)) return null;
        $roh = file_get_contents($abs);
        if ($roh === false) return null;
        $klar = vlBehoerdeDateiEntschluesseln($roh);
        if ($klar === false || $klar === '') return null;
        return ['inhalt' => $klar, 'name' => basename($rel)];
    }

    require_once __DIR__ . '/ra_datei_krypto.php';
    $st = $pdo->prepare('SELECT pdf_filename, pdf_uebersetzung_filename
                           FROM vertrag_ra_vollmacht WHERE id = ?');
    $st->execute([$quelleId]);
    $r = $st->fetch(PDO::FETCH_ASSOC);
    if (!$r) return null;
    $name = $fassung === 'uebersetzung'
        ? (string)($r['pdf_uebersetzung_filename'] ?? '')
        : (string)($r['pdf_filename'] ?? '');
    if ($name === '') return null;
    $abs = realpath(__DIR__ . '/../../uploads') . '/ra_vollmacht/' . basename($name) . '.enc';
    if (!is_file($abs)) return null;
    $klar = function_exists('raDateiLesen') ? raDateiLesen($abs) : null;
    if ($klar === null || $klar === false || $klar === '') return null;
    return ['inhalt' => $klar, 'name' => basename($name)];
}

/**
 * Alle Links einer Vollmacht — das, was im Versandprotokoll unter den
 * Sendungen steht.
 *
 * ⚠️ Der Token kommt NICHT mit. Das Protokoll ist eine Ansicht fuer den
 * Vorstand, kein Weg, einen fremden Link noch einmal zu oeffnen.
 */
function vlProtokoll(PDO $pdo, string $tabelle, int $quelleId): array
{
    if (!isset(VL_QUELLEN[$tabelle])) return [];
    $st = $pdo->prepare(
        "SELECT l.id, l.zweck, l.fassung, l.sprache, l.gesendet_an, l.gesendet_am,
                l.gueltig_bis, l.geoeffnet_am, l.geladen_am, l.bestaetigt_am,
                l.erledigt_am, l.codes_gesendet,
                l.gueltig_bis <= UTC_TIMESTAMP() AS abgelaufen,
                TRIM(CONCAT(COALESCE(u.vorname,''), ' ', COALESCE(u.nachname,''))) AS gesendet_von_name
           FROM vollmacht_link l
      LEFT JOIN users u ON u.id = l.gesendet_von
          WHERE l.quelle_tabelle = ? AND l.quelle_id = ?
       ORDER BY l.gesendet_am DESC");
    $st->execute([$tabelle, $quelleId]);
    $zeilen = $st->fetchAll(PDO::FETCH_ASSOC) ?: [];
    foreach ($zeilen as &$z) {
        $z['gesendet_an'] = vlNummerMaskieren((string)$z['gesendet_an']);
        $z['abgelaufen']  = (int)$z['abgelaufen'] === 1;
    }
    unset($z);
    return $zeilen;
}

/**
 * Entschluesselt eine Datei aus uploads/vollmachten.
 *
 * ⚠️ Bewusst hier noch einmal und nicht eingebunden: `vm_dec_file()` steht
 * MITTEN IN `api/admin/vollmacht_pdf.php`, also in einem Endpunkt, der beim
 * Einbinden sofort `requireAuth()` und `requireAdminRole()` ausfuehren wuerde
 * — auf einer Seite, die gerade ohne Anmeldung aufgerufen wird. Der Aufruf
 * endete mit „Admin access required" statt mit einem PDF.
 *
 * ⚠️ Die Passphrase ist dieselbe wie dort, und sie steht im OEFFENTLICHEN
 * Repo. Sie schuetzt gegen einen Blick auf die Platte, nicht gegen jemanden,
 * der den Quelltext gelesen hat. Der eigentliche Schutz dieses Weges ist der
 * Token: 131 Bit Zufall, 30 Minuten gueltig.
 */
function vlBehoerdeDateiEntschluesseln(string $enc)
{
    static $key = null;
    if ($key === null) {
        $key = hash('sha256', 'ICD360S_BehoerdeData_2026_SecureKey!', true);
    }
    $ivl = openssl_cipher_iv_length('aes-256-cbc');
    if (strlen($enc) <= $ivl) return false;
    return openssl_decrypt(substr($enc, $ivl), 'aes-256-cbc', $key,
                           OPENSSL_RAW_DATA, substr($enc, 0, $ivl));
}

/**
 * +4917•••••4567 — wie in der App.
 *
 * ⚠️ Auch im Protokoll des Vorstands. Die Nummer steht ohnehin in Stufe 1;
 * sie hier noch einmal vollstaendig auszuschreiben bringt nichts und macht
 * jeden Bildschirmabzug des Protokolls zu einem Datenblatt.
 */
function vlNummerMaskieren(string $nummer): string
{
    $n = preg_replace('/\s+/', '', $nummer) ?? $nummer;
    if (strlen($n) < 8) return $n;
    return substr($n, 0, 5) . str_repeat('•', 5) . substr($n, -4);
}

function vlClientIp(): string
{
    return (string)($_SERVER['REMOTE_ADDR'] ?? '');
}

/**
 * Weckt das Tablet.
 *
 * ⚠️ Kein Beiwerk: der regulaere Takt des Gateways liegt bei 30 Minuten, und
 * genau so lange gilt der Link. Ohne Weckruf waere er beim Eintreffen der SMS
 * im Zweifel schon tot. Dieselbe Ueberlegung wie bei der TAN.
 */
function vlTabletWecken(PDO $pdo): void
{
    try {
        require_once __DIR__ . '/NtfyService.php';
        $ntfy = new NtfyService();
        $st = $pdo->query("SELECT mitgliedernummer FROM users
                            WHERE role IN ('vorsitzer','stellvertreter')
                              AND deactivated_at IS NULL");
        foreach ($st->fetchAll(PDO::FETCH_COLUMN) as $nummer) {
            $ntfy->send(
                'vorsitzer_' . strtolower((string)$nummer),
                'Vollmacht-Link',
                'Warteschlange pruefen',
                ['priority' => 5, 'tags' => ['sms_gateway']]
            );
        }
    } catch (Throwable $e) {
        error_log('vlTabletWecken: ' . $e->getMessage());
    }
}
