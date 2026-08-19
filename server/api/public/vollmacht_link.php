<?php
/**
 * Die oeffentliche Seite hinter einem SMS-Link.
 *
 * Erreichbar unter https://icd360sev.icd360s.de/u/<token> — nginx leitet
 * alles unter /u/, was keine Datei ist, hierher.
 *
 * KEINE Anmeldung. Der Token IST der Zugang: 22 Zeichen aus einem
 * 62er-Alphabet (rund 131 Bit), 30 Minuten gueltig, nur als Hash gespeichert.
 * Das Mitglied hat keine App — nach einem Passwort zu fragen hiesse, es
 * auszusperren.
 *
 * Zwei Zwecke, und sie sind streng getrennt:
 *   lesen      → Leseexemplar in der Sprache des Mitglieds, kein Unterschreiben
 *   signieren  → deutsche Fassung, Finger + Code per SMS
 *
 * ⚠️ Unterschrieben wird ueber `SignaturHelper::unterschriftEintragen()` —
 * dieselbe Methode wie in der App, nicht eine zweite Fassung davon.
 *
 * ⚠️ Kein Skript und kein Stil in dieser Datei. Der Vhost setzt
 * `Content-Security-Policy: default-src 'self'` OHNE `unsafe-inline`; ein
 * `<style>` oder `onclick=` waere stumm wirkungslos. Alles liegt in
 * /u/app.css und /u/app.js.
 */

declare(strict_types=1);

define('API_ACCESS', true);
require_once __DIR__ . '/../config.php';
require_once __DIR__ . '/../lib/SignaturHelper.php';
require_once __DIR__ . '/../helpers/vollmacht_link_lib.php';

header('Cache-Control: no-store, no-cache, must-revalidate');
header('Referrer-Policy: no-referrer');
// ⚠️ Diese Seite darf NICHT in einen fremden Rahmen. Sonst liesse sich die
// Unterschriftenflaeche unter eine fremde Oberflaeche legen (Clickjacking) —
// und hier wird ein Rechtsgeschaeft unterschrieben.
header('X-Frame-Options: DENY');

$pdo = getDBConnection();

/**
 * Der Token aus der Adresse.
 *
 * ⚠️ Aus REQUEST_URI, nicht aus PATH_INFO: nginx reicht die Anfrage per
 * `try_files` an diese Datei weiter, PATH_INFO ist dabei leer.
 */
function vlTokenAusAdresse(): string
{
    $pfad = parse_url((string)($_SERVER['REQUEST_URI'] ?? ''), PHP_URL_PATH) ?? '';
    if (preg_match('~/u/([A-Za-z0-9]{10,64})~', $pfad, $m)) {
        return $m[1];
    }
    return trim((string)($_GET['t'] ?? ''));
}

/** Die Oberflaeche in der Sprache des Mitglieds. Sieben, wie ueberall sonst. */
function vlText(string $sprache): array
{
    $t = [
        'de' => [
            'titel_lesen' => 'Vollmacht zum Lesen', 'titel_sig' => 'Vollmacht unterschreiben',
            'hallo' => 'Guten Tag', 'gilt_noch' => 'Dieser Link gilt noch',
            'abgelaufen_t' => 'Dieser Link ist abgelaufen.',
            'abgelaufen_x' => 'Er galt 30 Minuten. Das Dokument ist unveraendert da — nur diese Adresse gilt nicht mehr.',
            'neuer_link' => 'Neuen Link per SMS schicken',
            'neuer_hinweis' => 'Er geht an dieselbe Nummer wie vorhin.',
            'unbekannt_t' => 'Diese Adresse kennen wir nicht.',
            'unbekannt_x' => 'Bitte pruefen Sie den Link in der SMS.',
            'ansehen' => 'Dokument ansehen', 'seiten_n' => 'Seiten', 'von' => 'von',
            'bis_ende' => 'Bitte bis zum Ende blaettern.',
            'gelesen' => 'Gelesen — weiter', 'herunterladen' => 'Herunterladen',
            'bestaetigen' => 'Ich habe es gelesen',
            'danke_t' => 'Vielen Dank.', 'danke_gelesen' => 'Der Verein wurde benachrichtigt.',
            'unterschreiben' => 'Bitte unterschreiben Sie mit dem Finger im weissen Feld.',
            'loeschen' => 'Loeschen', 'weiter_code' => 'Weiter zum Code',
            'code_t' => 'Wir haben Ihnen einen Code geschickt an',
            'code_gilt' => 'Der Code gilt 5 Minuten.',
            'code_neu' => 'Neuen Code senden', 'jetzt_sig' => 'Jetzt unterschreiben',
            'fertig_t' => 'Vielen Dank.', 'fertig_x' => 'Ihre Unterschrift ist angekommen.',
            'pruefcode' => 'Pruefcode', 'schliessen' => 'Diese Seite koennen Sie schliessen.',
            'erledigt_t' => 'Das ist bereits erledigt.',
            'fehler' => 'Etwas ist schiefgegangen. Bitte versuchen Sie es noch einmal.',
            'leer' => 'Bitte unterschreiben Sie zuerst.',
            'code_leer' => 'Bitte geben Sie den Code ein.',
        ],
        'ro' => [
            'titel_lesen' => 'Împuternicire spre citire', 'titel_sig' => 'Semnați împuternicirea',
            'hallo' => 'Bună ziua', 'gilt_noch' => 'Acest link mai este valabil',
            'abgelaufen_t' => 'Acest link a expirat.',
            'abgelaufen_x' => 'A fost valabil 30 de minute. Documentul este neschimbat — doar adresa nu mai este validă.',
            'neuer_link' => 'Trimite un link nou prin SMS',
            'neuer_hinweis' => 'Merge la același număr ca înainte.',
            'unbekannt_t' => 'Nu cunoaștem această adresă.',
            'unbekannt_x' => 'Vă rugăm verificați linkul din SMS.',
            'ansehen' => 'Vezi documentul', 'seiten_n' => 'Pagini', 'von' => 'din',
            'bis_ende' => 'Vă rugăm derulați până la sfârșit.',
            'gelesen' => 'Am citit — mai departe', 'herunterladen' => 'Descarcă',
            'bestaetigen' => 'Am citit documentul',
            'danke_t' => 'Vă mulțumim.', 'danke_gelesen' => 'Asociația a fost înștiințată.',
            'unterschreiben' => 'Vă rugăm semnați cu degetul în câmpul alb.',
            'loeschen' => 'Șterge', 'weiter_code' => 'Mai departe la cod',
            'code_t' => 'V-am trimis un cod la',
            'code_gilt' => 'Codul este valabil 5 minute.',
            'code_neu' => 'Trimite cod nou', 'jetzt_sig' => 'Semnează acum',
            'fertig_t' => 'Vă mulțumim.', 'fertig_x' => 'Semnătura dumneavoastră a ajuns.',
            'pruefcode' => 'Cod de verificare', 'schliessen' => 'Puteți închide această pagină.',
            'erledigt_t' => 'Acest lucru este deja rezolvat.',
            'fehler' => 'Ceva nu a mers. Vă rugăm încercați din nou.',
            'leer' => 'Vă rugăm semnați mai întâi.',
            'code_leer' => 'Vă rugăm introduceți codul.',
        ],
        'en' => [
            'titel_lesen' => 'Power of attorney to read', 'titel_sig' => 'Sign the power of attorney',
            'hallo' => 'Hello', 'gilt_noch' => 'This link is valid for another',
            'abgelaufen_t' => 'This link has expired.',
            'abgelaufen_x' => 'It was valid for 30 minutes. The document is unchanged — only this address no longer works.',
            'neuer_link' => 'Send a new link by SMS',
            'neuer_hinweis' => 'It goes to the same number as before.',
            'unbekannt_t' => 'We do not know this address.',
            'unbekannt_x' => 'Please check the link in the text message.',
            'ansehen' => 'View document', 'seiten_n' => 'Pages', 'von' => 'of',
            'bis_ende' => 'Please scroll to the end.',
            'gelesen' => 'Read — continue', 'herunterladen' => 'Download',
            'bestaetigen' => 'I have read it',
            'danke_t' => 'Thank you.', 'danke_gelesen' => 'The association has been notified.',
            'unterschreiben' => 'Please sign with your finger in the white field.',
            'loeschen' => 'Clear', 'weiter_code' => 'Continue to the code',
            'code_t' => 'We sent you a code to',
            'code_gilt' => 'The code is valid for 5 minutes.',
            'code_neu' => 'Send a new code', 'jetzt_sig' => 'Sign now',
            'fertig_t' => 'Thank you.', 'fertig_x' => 'Your signature has arrived.',
            'pruefcode' => 'Verification code', 'schliessen' => 'You can close this page.',
            'erledigt_t' => 'This has already been done.',
            'fehler' => 'Something went wrong. Please try again.',
            'leer' => 'Please sign first.',
            'code_leer' => 'Please enter the code.',
        ],
        'ru' => [
            'titel_lesen' => 'Доверенность для чтения', 'titel_sig' => 'Подписать доверенность',
            'hallo' => 'Добрый день', 'gilt_noch' => 'Ссылка действительна ещё',
            'abgelaufen_t' => 'Срок действия ссылки истёк.',
            'abgelaufen_x' => 'Она действовала 30 минут. Документ не изменился — недействителен только этот адрес.',
            'neuer_link' => 'Прислать новую ссылку по SMS',
            'neuer_hinweis' => 'Она придёт на тот же номер.',
            'unbekannt_t' => 'Такой адрес нам неизвестен.',
            'unbekannt_x' => 'Пожалуйста, проверьте ссылку в SMS.',
            'ansehen' => 'Посмотреть документ', 'seiten_n' => 'Страниц', 'von' => 'из',
            'bis_ende' => 'Пожалуйста, пролистайте до конца.',
            'gelesen' => 'Прочитано — далее', 'herunterladen' => 'Скачать',
            'bestaetigen' => 'Я прочитал документ',
            'danke_t' => 'Спасибо.', 'danke_gelesen' => 'Объединение уведомлено.',
            'unterschreiben' => 'Пожалуйста, распишитесь пальцем в белом поле.',
            'loeschen' => 'Очистить', 'weiter_code' => 'Далее к коду',
            'code_t' => 'Мы отправили вам код на',
            'code_gilt' => 'Код действителен 5 минут.',
            'code_neu' => 'Отправить новый код', 'jetzt_sig' => 'Подписать',
            'fertig_t' => 'Спасибо.', 'fertig_x' => 'Ваша подпись получена.',
            'pruefcode' => 'Код проверки', 'schliessen' => 'Эту страницу можно закрыть.',
            'erledigt_t' => 'Это уже сделано.',
            'fehler' => 'Что-то пошло не так. Попробуйте ещё раз.',
            'leer' => 'Сначала распишитесь.',
            'code_leer' => 'Введите код.',
        ],
        'uk' => [
            'titel_lesen' => 'Довіреність для читання', 'titel_sig' => 'Підписати довіреність',
            'hallo' => 'Добрий день', 'gilt_noch' => 'Посилання дійсне ще',
            'abgelaufen_t' => 'Термін дії посилання минув.',
            'abgelaufen_x' => 'Воно діяло 30 хвилин. Документ не змінився — недійсна лише ця адреса.',
            'neuer_link' => 'Надіслати нове посилання через SMS',
            'neuer_hinweis' => 'Воно надійде на той самий номер.',
            'unbekannt_t' => 'Ця адреса нам невідома.',
            'unbekannt_x' => 'Будь ласка, перевірте посилання в SMS.',
            'ansehen' => 'Переглянути документ', 'seiten_n' => 'Сторінок', 'von' => 'з',
            'bis_ende' => 'Будь ласка, гортайте до кінця.',
            'gelesen' => 'Прочитано — далі', 'herunterladen' => 'Завантажити',
            'bestaetigen' => 'Я прочитав документ',
            'danke_t' => 'Дякуємо.', 'danke_gelesen' => 'Об’єднання повідомлено.',
            'unterschreiben' => 'Будь ласка, підпишіться пальцем у білому полі.',
            'loeschen' => 'Очистити', 'weiter_code' => 'Далі до коду',
            'code_t' => 'Ми надіслали вам код на',
            'code_gilt' => 'Код дійсний 5 хвилин.',
            'code_neu' => 'Надіслати новий код', 'jetzt_sig' => 'Підписати',
            'fertig_t' => 'Дякуємо.', 'fertig_x' => 'Ваш підпис надійшов.',
            'pruefcode' => 'Код перевірки', 'schliessen' => 'Цю сторінку можна закрити.',
            'erledigt_t' => 'Це вже зроблено.',
            'fehler' => 'Щось пішло не так. Спробуйте ще раз.',
            'leer' => 'Спочатку підпишіться.',
            'code_leer' => 'Введіть код.',
        ],
        'tr' => [
            'titel_lesen' => 'Okumak için vekaletname', 'titel_sig' => 'Vekaletnameyi imzalayın',
            'hallo' => 'İyi günler', 'gilt_noch' => 'Bu bağlantı hâlâ geçerli',
            'abgelaufen_t' => 'Bu bağlantının süresi doldu.',
            'abgelaufen_x' => '30 dakika geçerliydi. Belge değişmedi — yalnızca bu adres artık geçerli değil.',
            'neuer_link' => 'SMS ile yeni bağlantı gönder',
            'neuer_hinweis' => 'Aynı numaraya gider.',
            'unbekannt_t' => 'Bu adresi tanımıyoruz.',
            'unbekannt_x' => 'Lütfen SMS’teki bağlantıyı kontrol edin.',
            'ansehen' => 'Belgeyi görüntüle', 'seiten_n' => 'Sayfa', 'von' => '/',
            'bis_ende' => 'Lütfen sonuna kadar kaydırın.',
            'gelesen' => 'Okundu — devam', 'herunterladen' => 'İndir',
            'bestaetigen' => 'Belgeyi okudum',
            'danke_t' => 'Teşekkür ederiz.', 'danke_gelesen' => 'Dernek bilgilendirildi.',
            'unterschreiben' => 'Lütfen beyaz alana parmağınızla imzalayın.',
            'loeschen' => 'Temizle', 'weiter_code' => 'Koda devam',
            'code_t' => 'Size bir kod gönderdik',
            'code_gilt' => 'Kod 5 dakika geçerlidir.',
            'code_neu' => 'Yeni kod gönder', 'jetzt_sig' => 'Şimdi imzala',
            'fertig_t' => 'Teşekkür ederiz.', 'fertig_x' => 'İmzanız ulaştı.',
            'pruefcode' => 'Doğrulama kodu', 'schliessen' => 'Bu sayfayı kapatabilirsiniz.',
            'erledigt_t' => 'Bu zaten tamamlandı.',
            'fehler' => 'Bir şeyler ters gitti. Lütfen tekrar deneyin.',
            'leer' => 'Lütfen önce imzalayın.',
            'code_leer' => 'Lütfen kodu girin.',
        ],
        'ar' => [
            'titel_lesen' => 'توكيل للقراءة', 'titel_sig' => 'توقيع التوكيل',
            'hallo' => 'مرحباً', 'gilt_noch' => 'هذا الرابط صالح لمدة',
            'abgelaufen_t' => 'انتهت صلاحية هذا الرابط.',
            'abgelaufen_x' => 'كان صالحاً 30 دقيقة. المستند لم يتغير — العنوان فقط لم يعد صالحاً.',
            'neuer_link' => 'إرسال رابط جديد برسالة',
            'neuer_hinweis' => 'سيصل إلى الرقم نفسه.',
            'unbekannt_t' => 'هذا العنوان غير معروف لدينا.',
            'unbekannt_x' => 'يرجى التحقق من الرابط في الرسالة.',
            'ansehen' => 'عرض المستند', 'seiten_n' => 'الصفحات', 'von' => 'من',
            'bis_ende' => 'يرجى التمرير حتى النهاية.',
            'gelesen' => 'تمت القراءة — متابعة', 'herunterladen' => 'تنزيل',
            'bestaetigen' => 'لقد قرأت المستند',
            'danke_t' => 'شكراً لك.', 'danke_gelesen' => 'تم إبلاغ الجمعية.',
            'unterschreiben' => 'يرجى التوقيع بإصبعك في الحقل الأبيض.',
            'loeschen' => 'مسح', 'weiter_code' => 'متابعة إلى الرمز',
            'code_t' => 'أرسلنا لك رمزاً إلى',
            'code_gilt' => 'الرمز صالح 5 دقائق.',
            'code_neu' => 'إرسال رمز جديد', 'jetzt_sig' => 'وقّع الآن',
            'fertig_t' => 'شكراً لك.', 'fertig_x' => 'وصل توقيعك.',
            'pruefcode' => 'رمز التحقق', 'schliessen' => 'يمكنك إغلاق هذه الصفحة.',
            'erledigt_t' => 'تم هذا بالفعل.',
            'fehler' => 'حدث خطأ ما. يرجى المحاولة مرة أخرى.',
            'leer' => 'يرجى التوقيع أولاً.',
            'code_leer' => 'يرجى إدخال الرمز.',
        ],
    ];
    return $t[$sprache] ?? $t['de'];
}

function vlAntwort(bool $ok, array $daten = [], string $meldung = '', int $code = 200): void
{
    http_response_code($code);
    header('Content-Type: application/json; charset=utf-8');
    echo json_encode(['success' => $ok, 'message' => $meldung] + $daten,
                     JSON_UNESCAPED_UNICODE);
    exit;
}

/** Kurzform fuers Markup. */
function h($s): string { return htmlspecialchars((string)$s, ENT_QUOTES, 'UTF-8'); }

// ═══════════════════════════════════════════════════════════════════
$token = vlTokenAusAdresse();
$auf   = vlAufloesen($pdo, $token);
$link  = $auf['link'] ?? null;
$istPost = ($_SERVER['REQUEST_METHOD'] ?? 'GET') === 'POST';
$eingang = $istPost ? (json_decode((string)file_get_contents('php://input'), true) ?: []) : [];
$aktion  = $istPost ? (string)($eingang['action'] ?? '') : (string)($_GET['a'] ?? '');

// Sprache und Anrede, sobald der Link bekannt ist.
$sprache = 'de'; $nachname = ''; $mitgliedId = 0;
if ($link !== null) {
    $mitgliedId = (int)$link['user_id'];
    $u = $pdo->prepare('SELECT nachname, preferred_language FROM users WHERE id = ?');
    $u->execute([$mitgliedId]);
    if ($m = $u->fetch(PDO::FETCH_ASSOC)) {
        $sprache  = (string)($m['preferred_language'] ?? 'de');
        $nachname = trim((string)($m['nachname'] ?? ''));
    }
}
$T = vlText($sprache);
$rtl = $sprache === 'ar';

// ── POST: die Handgriffe ───────────────────────────────────────────
if ($istPost) {
    // Einen neuen Link darf auch ein abgelaufener anfordern — das ist sein
    // einziger Sinn. Alles andere braucht einen gueltigen.
    if ($aktion === 'neuer_link') {
        if ($link === null) vlAntwort(false, [], $T['unbekannt_t'], 404);
        $r = vlNeuSenden($pdo, $link);
        vlAntwort($r['ok'], ['gesendet_an' => $r['gesendet_an'] ?? ''],
                  $r['meldung'] ?? '', $r['ok'] ? 200 : 409);
    }

    if ($auf['status'] !== 'ok') {
        vlAntwort(false, ['grund' => $auf['status']], $T['abgelaufen_t'], 410);
    }

    switch ($aktion) {
        case 'gelesen':
            vlBestaetigt($pdo, (int)$link['id']);
            vlAntwort(true, [], $T['danke_gelesen']);

        case 'code':
            if ($link['zweck'] !== 'signieren') vlAntwort(false, [], 'Nicht vorgesehen', 400);
            $r = vlCodeAnfordern($pdo, $link);
            vlAntwort($r['ok'], ['gesendet_an' => $r['gesendet_an'] ?? '',
                                 'offen' => $r['offen'] ?? 0],
                      $r['meldung'] ?? '', $r['ok'] ? 200 : 409);

        case 'signieren':
            if ($link['zweck'] !== 'signieren') vlAntwort(false, [], 'Nicht vorgesehen', 400);
            // ⚠️ Dieselbe Methode wie in der App. Kein zweiter Ablauf.
            $e = SignaturHelper::unterschriftEintragen(
                $pdo,
                (int)$link['signatur_id'],
                (int)$link['user_id'],
                trim((string)($eingang['tan'] ?? '')),
                (string)($eingang['signature_svg'] ?? ''),
                [
                    // Kein Geraeteschluessel — es gibt keinen. Was das Geraet
                    // beschreibt, steht im user_agent.
                    'device_id'  => '',
                    'zugang_weg' => 'sms_link',
                ]
            );
            if ($e['ok']) vlErledigt($pdo, (int)$link['id']);
            vlAntwort($e['ok'], $e['daten'], $e['meldung'], $e['http']);

        default:
            vlAntwort(false, [], 'Unbekannte Aktion', 400);
    }
}

// ── GET mit Aktion: Dokument ausliefern ────────────────────────────
if ($aktion !== '' && $auf['status'] === 'ok') {
    $dok = vlDokument($pdo, $link);
    if ($dok === null) {
        http_response_code(404);
        exit('Dokument nicht verfuegbar');
    }

    if ($aktion === 'download') {
        // Der Griff, um den es dem Vorsitzenden ging: das Mitglied nimmt das
        // Blatt mit, und die Akte weiss es.
        vlGeladen($pdo, (int)$link['id']);
        header('Content-Type: application/pdf');
        header('Content-Disposition: attachment; filename="vollmacht.pdf"');
        header('Content-Length: ' . strlen($dok['inhalt']));
        echo $dok['inhalt'];
        exit;
    }

    if ($aktion === 'seite') {
        $n = max(1, min(60, (int)($_GET['n'] ?? 1)));
        $png = vlSeiteAlsBild($dok['inhalt'], $n);
        if ($png === null) { http_response_code(404); exit('Seite nicht verfuegbar'); }
        header('Content-Type: image/png');
        header('Content-Length: ' . strlen($png));
        echo $png;
        exit;
    }

    http_response_code(400);
    exit('Unbekannt');
}

/**
 * Eine Seite des PDF als PNG.
 *
 * ⚠️ Bewusst als BILD und nicht als eingebettetes PDF. Auf den Telefonen der
 * Zielgruppe — Mitglieder ohne App — oeffnet ein PDF im Rahmen je nach
 * Browser gar nicht, laedt herunter oder springt in eine fremde Anwendung.
 * Ein Bild zeigt jeder. Nebenbei laesst sich so ehrlich pruefen, ob wirklich
 * bis zur letzten Seite geblaettert wurde: die Seitenzahl kennt der Server.
 *
 * ⚠️ pdftoppm schreibt nur in eine Datei, nicht auf die Standardausgabe
 * (gemessen: `- -` liefert 0 Byte). Das PDF liegt verschluesselt auf der
 * Platte und wird hier im Speicher entschluesselt — die Zwischendatei ist
 * also ein kurzzeitiger Klartext. Sie liegt deshalb in einem eigenen
 * Verzeichnis mit 0700, heisst zufaellig und wird sofort wieder entfernt,
 * auch wenn etwas dazwischen schiefgeht.
 */
function vlSeiteAlsBild(string $pdf, int $seite): ?string
{
    $dir = sys_get_temp_dir() . '/vlrender';
    if (!is_dir($dir)) { @mkdir($dir, 0700, true); }
    $stamm = $dir . '/' . bin2hex(random_bytes(8));
    $quelle = $stamm . '.pdf';
    $ziel   = $stamm;

    try {
        if (file_put_contents($quelle, $pdf) === false) return null;
        @chmod($quelle, 0600);
        $cmd = sprintf(
            'pdftoppm -png -singlefile -r 110 -f %d -l %d %s %s 2>/dev/null',
            $seite, $seite, escapeshellarg($quelle), escapeshellarg($ziel)
        );
        exec($cmd, $aus, $code);
        $png = $ziel . '.png';
        if ($code !== 0 || !is_file($png)) return null;
        $inhalt = file_get_contents($png);
        return $inhalt === false ? null : $inhalt;
    } finally {
        @unlink($quelle);
        @unlink($ziel . '.png');
    }
}

/** Wie viele Seiten hat das Dokument? */
function vlSeitenzahl(string $pdf): int
{
    $d = null;
    $p = proc_open('pdfinfo - 2>/dev/null',
                   [0 => ['pipe','r'], 1 => ['pipe','w'], 2 => ['pipe','w']], $rohr);
    if (!is_resource($p)) return 1;
    fwrite($rohr[0], $pdf);
    fclose($rohr[0]);
    $aus = stream_get_contents($rohr[1]);
    fclose($rohr[1]); fclose($rohr[2]);
    proc_close($p);
    if (preg_match('/^Pages:\s+(\d+)/mi', (string)$aus, $m)) {
        return max(1, min(60, (int)$m[1]));
    }
    return 1;
}

// ── GET: die Seite ─────────────────────────────────────────────────
$zustand = $auf['status'];              // ok | abgelaufen | unbekannt | erledigt
$seiten  = 0;
$restSek = 0;

if ($zustand === 'ok') {
    vlGeoeffnet($pdo, (int)$link['id']);
    $dok = vlDokument($pdo, $link);
    $seiten = $dok === null ? 0 : vlSeitenzahl($dok['inhalt']);
    $rs = $pdo->prepare('SELECT TIMESTAMPDIFF(SECOND, UTC_TIMESTAMP(), gueltig_bis)
                           FROM vollmacht_link WHERE id = ?');
    $rs->execute([(int)$link['id']]);
    $restSek = max(0, (int)$rs->fetchColumn());
}

$zweck = $link['zweck'] ?? 'lesen';
$titel = $zweck === 'signieren' ? $T['titel_sig'] : $T['titel_lesen'];

header('Content-Type: text/html; charset=utf-8');
?><!DOCTYPE html>
<html lang="<?= h($sprache) ?>"<?= $rtl ? ' dir="rtl"' : '' ?>>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">
<meta name="robots" content="noindex, nofollow">
<title><?= h($titel) ?> — ICD360S e.V.</title>
<link rel="stylesheet" href="/u/app.css">
</head>
<body class="z-<?= h($zustand) ?>">
<header class="kopf">
  <span class="marke">ICD360S e.V.</span>
  <?php if ($zustand === 'ok'): ?>
    <span class="uhr" id="uhr" data-rest="<?= (int)$restSek ?>"
          data-label="<?= h($T['gilt_noch']) ?>"></span>
  <?php endif; ?>
</header>

<main class="huelle">
<?php if ($zustand === 'unbekannt'): ?>
  <section class="karte mitte">
    <p class="gross"><?= h($T['unbekannt_t']) ?></p>
    <p class="leise"><?= h($T['unbekannt_x']) ?></p>
  </section>

<?php elseif ($zustand === 'erledigt'): ?>
  <section class="karte mitte">
    <p class="haken">✓</p>
    <p class="gross"><?= h($T['erledigt_t']) ?></p>
    <p class="leise"><?= h($T['schliessen']) ?></p>
  </section>

<?php elseif ($zustand === 'abgelaufen'): ?>
  <section class="karte mitte">
    <p class="gross"><?= h($T['abgelaufen_t']) ?></p>
    <p class="leise"><?= h($T['abgelaufen_x']) ?></p>
    <button class="knopf" id="neuerLink"><?= h($T['neuer_link']) ?></button>
    <p class="leise"><?= h($T['neuer_hinweis']) ?></p>
    <p class="meldung" id="meldung" role="status"></p>
  </section>

<?php else: ?>
  <!-- 1. Was und fuer wen -->
  <section class="karte schritt" id="s-start">
    <h1><?= h($titel) ?></h1>
    <p><?= h($T['hallo']) ?><?= $nachname !== '' ? ' ' . h($nachname) : '' ?>,</p>
    <?php /* ⚠️ „Seiten: 3", nicht „3 Seite". Beim Ansehen der gerenderten
             Seite stand auf Russisch „3 Страница" — Singular nach einem
             Zahlwort. Russisch, Ukrainisch und Arabisch verlangen je nach
             Zahl eine andere Form; mit Doppelpunkt braucht es gar keine
             Uebereinstimmung, und es liest sich in allen sieben Sprachen
             richtig. */ ?>
    <p class="leise" id="seitenzahl" data-seiten="<?= (int)$seiten ?>"><?= h($T['seiten_n']) ?>: <?= (int)$seiten ?></p>
    <button class="knopf" id="zumDokument"><?= h($T['ansehen']) ?></button>
  </section>

  <!-- 2. Lesen -->
  <section class="karte schritt aus" id="s-lesen">
    <div class="blatt" id="blatt"></div>
    <p class="leise hinweis"><?= h($T['bis_ende']) ?></p>
    <div class="reihe">
      <a class="knopf zweit" id="download" href="?a=download" download><?= h($T['herunterladen']) ?></a>
      <button class="knopf" id="gelesen" disabled><?= h($T['gelesen']) ?></button>
    </div>
  </section>

<?php if ($zweck === 'lesen'): ?>
  <!-- 3a. Bestaetigen (nur Leselink) -->
  <section class="karte schritt aus mitte" id="s-danke">
    <p class="haken">✓</p>
    <p class="gross"><?= h($T['danke_t']) ?></p>
    <p class="leise" id="dankeText"><?= h($T['danke_gelesen']) ?></p>
    <p class="leise"><?= h($T['schliessen']) ?></p>
  </section>
<?php else: ?>
  <!-- 3b. Unterschreiben -->
  <section class="karte schritt aus" id="s-sig">
    <p><?= h($T['unterschreiben']) ?></p>
    <canvas id="pad" class="pad"></canvas>
    <div class="reihe">
      <button class="knopf zweit" id="leeren"><?= h($T['loeschen']) ?></button>
      <button class="knopf" id="zumCode"><?= h($T['weiter_code']) ?></button>
    </div>
  </section>

  <!-- 4. Code -->
  <section class="karte schritt aus" id="s-code">
    <p><?= h($T['code_t']) ?> <strong id="codeZiel"></strong></p>
    <input class="code" id="tan" inputmode="numeric" autocomplete="one-time-code"
           maxlength="8" aria-label="<?= h($T['code_t']) ?>">
    <p class="leise"><?= h($T['code_gilt']) ?></p>
    <div class="reihe">
      <button class="knopf zweit" id="codeNeu"><?= h($T['code_neu']) ?></button>
      <button class="knopf" id="signieren"><?= h($T['jetzt_sig']) ?></button>
    </div>
    <p class="meldung" id="meldung" role="status"></p>
  </section>

  <!-- 5. Fertig -->
  <section class="karte schritt aus mitte" id="s-fertig">
    <p class="haken">✓</p>
    <p class="gross"><?= h($T['fertig_t']) ?></p>
    <p><?= h($T['fertig_x']) ?></p>
    <p class="leise"><?= h($T['pruefcode']) ?>: <strong id="pruefcode"></strong></p>
    <p class="leise"><?= h($T['schliessen']) ?></p>
  </section>
<?php endif; ?>
<?php endif; ?>
</main>

<script src="/u/app.js"
        data-zweck="<?= h($zweck) ?>"
        data-seiten="<?= (int)$seiten ?>"
        data-fehler="<?= h($T['fehler']) ?>"
        data-leer="<?= h($T['leer']) ?>"
        data-codeleer="<?= h($T['code_leer']) ?>"></script>
</body>
</html>
