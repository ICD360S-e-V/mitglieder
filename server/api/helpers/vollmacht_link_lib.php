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
        'fr' => 'Bonjour %s,
l\'association a prepare une procuration pour vous. Ici vous pouvez la lire et la telecharger dans votre langue. Le lien est valable 30 minutes.
%s',
        'es' => 'Buenos dias %s,
la asociacion ha preparado un poder para usted. Aqui puede leerlo y descargarlo en su idioma. El enlace es valido 30 minutos.
%s',
        'it' => 'Buongiorno %s,
l\'associazione ha preparato una procura per Lei. Qui puo leggerla e scaricarla nella Sua lingua. Il link e valido 30 minuti.
%s',
        'pt' => 'Bom dia %s,
a associacao preparou uma procuracao para si. Aqui pode le-la e transferi-la na sua lingua. A ligacao e valida 30 minutos.
%s',
        'pl' => 'Dzien dobry %s,
stowarzyszenie przygotowalo dla Panstwa pelnomocnictwo. Tutaj mozna je przeczytac i pobrac w swoim jezyku. Link jest wazny 30 minut.
%s',
        'cs' => 'Dobry den %s,
sdruzeni pro vas pripravilo plnou moc. Zde si ji muzete precist a stahnout ve svem jazyce. Odkaz plati 30 minut.
%s',
        'sk' => 'Dobry den %s,
zdruzenie pre vas pripravilo plnu moc. Tu si ju mozete precitat a stiahnut vo svojom jazyku. Odkaz plati 30 minut.
%s',
        'sl' => 'Dober dan %s,
drustvo je za vas pripravilo pooblastilo. Tukaj ga lahko preberete in prenesete v svojem jeziku. Povezava velja 30 minut.
%s',
        'hr' => 'Dobar dan %s,
udruga je za vas pripremila punomoc. Ovdje je mozete procitati i preuzeti na svom jeziku. Poveznica vrijedi 30 minuta.
%s',
        'sr' => 'Dobar dan %s,
udruzenje je za vas pripremilo punomocje. Ovde ga mozete procitati i preuzeti na svom jeziku. Link vazi 30 minuta.
%s',
        'bg' => 'Dobar den %s,
sdruzhenieto podgotvi za vas palnomoshtno. Tuk mozhete da go prochetete i izteglite na vashiya ezik. Vrazkata e validna 30 minuti.
%s',
        'hu' => 'Jo napot %s,
az egyesulet meghatalmazast keszitett Onnek. Itt elolvashatja es letoltheti a sajat nyelven. A link 30 percig ervenyes.
%s',
        'fi' => 'Hyvaa paivaa %s,
yhdistys on valmistellut sinulle valtakirjan. Taalla voit lukea ja ladata sen omalla kielellasi. Linkki on voimassa 30 minuuttia.
%s',
        'et' => 'Tere paevast %s,
uhing on teile volikirja ette valmistanud. Siin saate seda lugeda ja alla laadida oma keeles. Link kehtib 30 minutit.
%s',
        'lt' => 'Laba diena %s,
asociacija paruose jums igaliojima. Cia galite ji perskaityti ir atsisiusti savo kalba. Nuoroda galioja 30 minuciu.
%s',
        'lv' => 'Labdien %s,
biedriba ir sagatavojusi jums pilnvaru. Seit varat to izlasit un lejupieladet sava valoda. Saite ir deriga 30 minutes.
%s',
        'nl' => 'Goedendag %s,
de vereniging heeft een volmacht voor u voorbereid. Hier kunt u die in uw taal lezen en downloaden. De link is 30 minuten geldig.
%s',
        'da' => 'Goddag %s,
foreningen har forberedt en fuldmagt til dig. Her kan du laese og hente den paa dit sprog. Linket er gyldigt i 30 minutter.
%s',
        'sv' => 'God dag %s,
foreningen har forberett en fullmakt at dig. Har kan du lasa och ladda ner den pa ditt sprak. Lanken galler i 30 minuter.
%s',
        'nb' => 'God dag %s,
foreningen har forberedt en fullmakt til deg. Her kan du lese og laste den ned pa ditt sprak. Lenken er gyldig i 30 minutter.
%s',
        'el' => 'Kalimera %s,
o syllogos etoimase gia esas ena plirexousio. Edo borite na to diavasete kai na to katevasete sti glossa sas. O syndesmos ischyei 30 lepta.
%s',
    ];
    $signieren = [
        'de' => "Guten Tag %s,\nhier koennen Sie die Vollmacht unterschreiben. Sie unterschreiben mit dem Finger; den Bestaetigungscode bekommen Sie danach per SMS. Der Link gilt 30 Minuten.\n%s",
        'ro' => "Buna ziua %s,\naici puteti semna imputernicirea. Semnati cu degetul; codul de confirmare il primiti apoi prin SMS. Linkul este valabil 30 de minute.\n%s",
        'en' => "Hello %s,\nhere you can sign the power of attorney. You sign with your finger; the confirmation code follows by SMS. The link is valid for 30 minutes.\n%s",
        'ru' => "Dobryy den %s,\nzdes vy mozhete podpisat doverennost. Podpis palcem; kod podtverzhdeniya pridet potom po SMS. Ssylka deystvitelna 30 minut.\n%s",
        'uk' => "Dobryy den %s,\ntut vy mozhete pidpysaty dovirenist. Pidpys palcem; kod pidtverdzhennya pryyde potim po SMS. Posylannya diysne 30 khvylyn.\n%s",
        'tr' => "Iyi gunler %s,\nvekaletnameyi burada imzalayabilirsiniz. Parmaginizla imzalarsiniz; onay kodu ardindan SMS ile gelir. Baglanti 30 dakika gecerlidir.\n%s",
        'ar' => "Marhaban %s,\nhuna yumkinuka tawqi at-tawkil. Tuwaqqi biisbaik; ramz at-taakid yasiluka baada dhalik bi risala. Ar-rabt salih li 30 daqiqa.\n%s",
        'fr' => 'Bonjour %s,
ici vous pouvez signer la procuration. Vous signez avec le doigt; le code de confirmation suit par SMS. Le lien est valable 30 minutes.
%s',
        'es' => 'Buenos dias %s,
aqui puede firmar el poder. Firma con el dedo; el codigo de confirmacion llega despues por SMS. El enlace es valido 30 minutos.
%s',
        'it' => 'Buongiorno %s,
qui puo firmare la procura. Firma con il dito; il codice di conferma arriva poi per SMS. Il link e valido 30 minuti.
%s',
        'pt' => 'Bom dia %s,
aqui pode assinar a procuracao. Assina com o dedo; o codigo de confirmacao chega depois por SMS. A ligacao e valida 30 minutos.
%s',
        'pl' => 'Dzien dobry %s,
tutaj mozna podpisac pelnomocnictwo. Podpis palcem; kod potwierdzenia przyjdzie potem SMS-em. Link jest wazny 30 minut.
%s',
        'cs' => 'Dobry den %s,
zde muzete plnou moc podepsat. Podepisujete prstem; overovaci kod prijde potom SMS zpravou. Odkaz plati 30 minut.
%s',
        'sk' => 'Dobry den %s,
tu mozete plnu moc podpisat. Podpisujete prstom; overovaci kod pride potom SMS spravou. Odkaz plati 30 minut.
%s',
        'sl' => 'Dober dan %s,
tukaj lahko pooblastilo podpisete. Podpisete se s prstom; kodo za potrditev prejmete nato po SMS. Povezava velja 30 minut.
%s',
        'hr' => 'Dobar dan %s,
ovdje mozete potpisati punomoc. Potpisujete prstom; kod za potvrdu stize zatim SMS-om. Poveznica vrijedi 30 minuta.
%s',
        'sr' => 'Dobar dan %s,
ovde mozete potpisati punomocje. Potpisujete prstom; kod za potvrdu stize zatim SMS-om. Link vazi 30 minuta.
%s',
        'bg' => 'Dobar den %s,
tuk mozhete da podpishete palnomoshtnoto. Podpisvate s prast; kodat za potvarzhdenie shte pristigne sled tova s SMS. Vrazkata e validna 30 minuti.
%s',
        'hu' => 'Jo napot %s,
itt irhatja ala a meghatalmazast. Az ujjaval ir ala; a megerosito kodot utana SMS-ben kapja meg. A link 30 percig ervenyes.
%s',
        'fi' => 'Hyvaa paivaa %s,
taalla voit allekirjoittaa valtakirjan. Allekirjoitat sormella; vahvistuskoodi tulee sen jalkeen tekstiviestilla. Linkki on voimassa 30 minuuttia.
%s',
        'et' => 'Tere paevast %s,
siin saate volikirja allkirjastada. Allkirjastate sormega; kinnituskood tuleb seejarel SMS-iga. Link kehtib 30 minutit.
%s',
        'lt' => 'Laba diena %s,
cia galite pasirasyti igaliojima. Pasirasote pirstu; patvirtinimo koda gausite paskui SMS zinute. Nuoroda galioja 30 minuciu.
%s',
        'lv' => 'Labdien %s,
seit varat parakstit pilnvaru. Parakstaties ar pirkstu; apstiprinajuma kodu sanemsiet pec tam ar SMS. Saite ir deriga 30 minutes.
%s',
        'nl' => 'Goedendag %s,
hier kunt u de volmacht ondertekenen. U ondertekent met uw vinger; de bevestigingscode volgt daarna per sms. De link is 30 minuten geldig.
%s',
        'da' => 'Goddag %s,
her kan du underskrive fuldmagten. Du skriver under med fingeren; bekraeftelseskoden kommer derefter med sms. Linket er gyldigt i 30 minutter.
%s',
        'sv' => 'God dag %s,
har kan du skriva under fullmakten. Du skriver under med fingret; bekraftelsekoden kommer sedan via sms. Lanken galler i 30 minuter.
%s',
        'nb' => 'God dag %s,
her kan du signere fullmakten. Du signerer med fingeren; bekreftelseskoden kommer deretter pa SMS. Lenken er gyldig i 30 minutter.
%s',
        'el' => 'Kalimera %s,
edo borite na ypograpsete to plirexousio. Ypografete me to dachtylo; o kodikos epivevaiosis tha erthei meta me SMS. O syndesmos ischyei 30 lepta.
%s',
    ];

    $tabelle = $zweck === 'signieren' ? $signieren : $lesen;
    if (!isset($tabelle[$sprache])) {
        // ⚠️ Nicht still. Dieselbe Ueberlegung wie bei der Seite: der
        // Rueckfall auf Deutsch ist richtig, aber ein Mitglied, das seine
        // SMS auf Deutsch bekommt, obwohl eine andere Sprache hinterlegt
        // ist, faellt sonst niemandem auf.
        error_log('vollmacht_link: keine SMS-Vorlage fuer Sprache "' . $sprache
                . '" — es wurde Deutsch verschickt');
    }
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

    // ── Woran haengt die Unterschrift? ──────────────────────────────
    //
    // ⚠️ Der Link unterschreibt nicht selbst — er fuehrt zu einer bereits
    // OFFENEN Zeile in dokument_signaturen. Legte er sie an, gaebe es zwei
    // Wege, eine Unterschrift anzufordern, und der zweite umginge alles, was
    // am ersten haengt: Frist, Gruppe, Titel, die Zeile des Vorstands.
    //
    // Fehlt sie, ist der Vorgang schlicht noch nicht gestellt — und das ist
    // eine Aussage, die der Bildschirm treffen kann, statt eine Zeile zu
    // erfinden.
    $signaturId = null;
    if ($zweck === 'signieren') {
        $sg = $pdo->prepare(
            "SELECT id FROM dokument_signaturen
              WHERE quelle_tabelle = ? AND quelle_id = ? AND user_id = ?
                AND status = 'offen'
           ORDER BY id DESC LIMIT 1");
        $sg->execute([$tabelle, $quelleId, (int)$mitglied['id']]);
        $signaturId = (int)($sg->fetchColumn() ?: 0);
        if ($signaturId <= 0) {
            return ['ok' => false, 'grund' => 'nicht_gestellt',
                    'meldung' => 'Diese Vollmacht steht fuer das Mitglied nicht zur '
                               . 'Unterschrift. Erst „Zur Unterschrift stellen", dann '
                               . 'laesst sich der Link schicken.'];
        }
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
                token_hash, gueltig_bis, gesendet_an, gesendet_von, signatur_id)
             VALUES (?, ?, ?, ?, ?, ?, ?, DATE_ADD(UTC_TIMESTAMP(), INTERVAL ? MINUTE), ?, ?, ?)');
        $ins->execute([
            $tabelle, $quelleId, (int)$mitglied['id'], $zweck, $fassung,
            $sprache !== '' ? $sprache : null,
            vlTokenHash($token), VL_GUELTIG_MINUTEN, $telefon, $absender,
            $signaturId ?: null,
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

/**
 * Fordert ueber einen Signier-Link einen Code an.
 *
 * ⚠️ Die Rufnummer kommt aus der LINK-Zeile, nicht aus dem Aufruf und auch
 * nicht aus der Seite. Dort steht die Nummer, an die der Link ging — dieselbe,
 * die in Verifizierung Stufe 1 hinterlegt ist. Liesse man sie sich uebergeben,
 * koennte jeder, der einen Link hat, den Code auf sein eigenes Telefon holen.
 *
 * ⚠️ Hoechstens VL_MAX_CODES pro Link. Jeder, der die Adresse hat, kann eine
 * SMS ausloesen; ohne Deckel waere das ein Knopf, mit dem sich ein fremdes
 * Telefon beliebig oft anklingeln laesst.
 */
function vlCodeAnfordern(PDO $pdo, array $link): array
{
    $signaturId = (int)($link['signatur_id'] ?? 0);
    if ($signaturId <= 0) {
        return ['ok' => false, 'meldung' => 'Zu diesem Link gehoert kein Unterschriftsvorgang.'];
    }
    if ((int)$link['codes_gesendet'] >= VL_MAX_CODES) {
        return ['ok' => false, 'grund' => 'zu_oft',
                'meldung' => 'Es wurden bereits ' . VL_MAX_CODES . ' Codes angefordert. '
                           . 'Bitte wenden Sie sich an den Verein.'];
    }

    $st = $pdo->prepare("SELECT s.status, u.nachname, u.geschlecht, u.preferred_language
                           FROM dokument_signaturen s
                           JOIN users u ON u.id = s.user_id
                          WHERE s.id = ?");
    $st->execute([$signaturId]);
    $z = $st->fetch(PDO::FETCH_ASSOC);
    if (!$z) {
        return ['ok' => false, 'meldung' => 'Der Vorgang wurde nicht gefunden.'];
    }
    if ($z['status'] !== 'offen') {
        return ['ok' => false, 'grund' => 'erledigt',
                'meldung' => 'Dieser Vorgang ist nicht mehr offen.'];
    }

    $telefon = (string)$link['gesendet_an'];

    try {
        $pdo->beginTransaction();

        // Frueher ausgegebene Codes verfallen — sonst waeren nach dreimaligem
        // „nochmal senden" drei gueltig, und keiner wuesste welcher.
        $pdo->prepare("UPDATE signatur_tan SET verbraucht_at = UTC_TIMESTAMP()
                        WHERE signatur_id = ? AND verbraucht_at IS NULL")
            ->execute([$signaturId]);

        $tan = SignaturHelper::tanErzeugen();
        $pdo->prepare(
            "INSERT INTO signatur_tan (signatur_id, tan_hash, telefon, gueltig_bis)
             VALUES (?, ?, ?, DATE_ADD(UTC_TIMESTAMP(), INTERVAL ? MINUTE))"
        )->execute([$signaturId, SignaturHelper::tanHash($tan, $signaturId), $telefon,
                    SignaturHelper::TAN_GUELTIG_MINUTEN]);
        $tanId = (int)$pdo->lastInsertId();

        // Derselbe Text wie in der App — er kommt aus SignaturHelper, damit
        // nicht zwei Fassungen desselben Satzes entstehen.
        $pdo->prepare('INSERT INTO signatur_sms_queue (tan_id, link_id, signatur_id, telefon, body)
                       VALUES (?, NULL, ?, ?, ?)')
            ->execute([$tanId, $signaturId, $telefon, SignaturHelper::smsText($tan, $z)]);

        $pdo->prepare('UPDATE vollmacht_link SET codes_gesendet = codes_gesendet + 1
                        WHERE id = ?')->execute([(int)$link['id']]);

        $pdo->commit();
    } catch (Throwable $e) {
        if ($pdo->inTransaction()) $pdo->rollBack();
        error_log('vlCodeAnfordern: ' . $e->getMessage());
        return ['ok' => false, 'meldung' => 'Der Code konnte nicht erzeugt werden.'];
    }

    vlTabletWecken($pdo);

    return [
        'ok' => true,
        'gesendet_an' => vlNummerMaskieren($telefon),
        'gueltig_minuten' => SignaturHelper::TAN_GUELTIG_MINUTEN,
        'offen' => VL_MAX_CODES - ((int)$link['codes_gesendet'] + 1),
    ];
}

/**
 * Haelt fest, dass ueber diesen Link unterschrieben wurde.
 *
 * ⚠️ Das eigentliche Eintragen macht `SignaturHelper::unterschriftEintragen()`
 * — dieselbe Methode wie in der App. Hier wird nur der Link geschlossen.
 */
function vlErledigt(PDO $pdo, int $linkId): void
{
    try {
        $pdo->prepare("UPDATE vollmacht_link SET erledigt_am = UTC_TIMESTAMP()
                        WHERE id = ? AND erledigt_am IS NULL")->execute([$linkId]);
    } catch (Throwable $e) {
        error_log('vlErledigt: ' . $e->getMessage());
    }
}

/**
 * Schickt zu einem abgelaufenen Link einen neuen — an DIESELBE Nummer.
 *
 * ⚠️ Die Nummer wird aus der alten Zeile uebernommen und nicht neu erfragt.
 * Sonst waere der abgelaufene Link ein Formular, mit dem sich eine Vollmacht
 * an ein beliebiges Telefon schicken laesst.
 *
 * ⚠️ Als Absender steht der urspruengliche Vorstand in der neuen Zeile: die
 * Sendung geht auf seine Veranlassung zurueck, auch wenn das Mitglied den
 * Knopf gedrueckt hat. Der Vermerk sagt es dazu.
 */
function vlNeuSenden(PDO $pdo, array $alt): array
{
    return vlErzeugen($pdo, [
        'quelle_tabelle' => (string)$alt['quelle_tabelle'],
        'quelle_id'      => (int)$alt['quelle_id'],
        'zweck'          => (string)$alt['zweck'],
        'gesendet_von'   => (int)$alt['gesendet_von'],
    ]);
}

/**
 * Sagt dem Vorstand Bescheid, dass jemand vor einem toten Signier-Link steht.
 *
 * ⚠️ Ohne diese Nachricht waere die Regel „einen neuen Link schickt nur der
 * Vorstand" eine Sackgasse: das Mitglied liest, dass sich jemand meldet, und
 * niemand weiss davon. Wer eine Selbstbedienung wegnimmt, muss den Weg
 * daneben oeffnen.
 */
function vlVorstandWecken(PDO $pdo, array $link, string $text): void
{
    try {
        require_once __DIR__ . '/NtfyService.php';
        $u = $pdo->prepare('SELECT mitgliedernummer, nachname FROM users WHERE id = ?');
        $u->execute([(int)$link['user_id']]);
        $m = $u->fetch(PDO::FETCH_ASSOC) ?: [];
        $wer = trim((string)($m['nachname'] ?? '')) !== ''
            ? trim((string)$m['nachname']) . ' (' . (string)($m['mitgliedernummer'] ?? '') . ')'
            : (string)($m['mitgliedernummer'] ?? 'Mitglied');

        $ntfy = new NtfyService();
        $st = $pdo->query("SELECT mitgliedernummer FROM users
                            WHERE role IN ('vorsitzer','stellvertreter')
                              AND deactivated_at IS NULL");
        foreach ($st->fetchAll(PDO::FETCH_COLUMN) as $nummer) {
            $ntfy->send(
                'vorsitzer_' . strtolower((string)$nummer),
                'Vollmacht: Link abgelaufen',
                $wer . ' — ' . $text,
                ['priority' => 4, 'tags' => ['vollmacht']]
            );
        }
    } catch (Throwable $e) {
        error_log('vlVorstandWecken: ' . $e->getMessage());
    }
}
