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
            'neu_nur_vorstand' => 'Einen neuen Link zum Unterschreiben schickt nur der Verein. Er wurde benachrichtigt.',
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
            'neu_nur_vorstand' => 'Un link nou pentru semnare îl trimite doar asociația. A fost înștiințată.',
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
            'neu_nur_vorstand' => 'Only the association can send a new link for signing. It has been notified.',
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
            'neu_nur_vorstand' => 'Новую ссылку для подписи отправляет только объединение. Оно уведомлено.',
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
            'neu_nur_vorstand' => 'Нове посилання для підпису надсилає лише об’єднання. Його повідомлено.',
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
            'neu_nur_vorstand' => 'İmza için yeni bağlantıyı yalnızca dernek gönderir. Bilgilendirildi.',
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
            'neu_nur_vorstand' => 'الرابط الجديد للتوقيع ترسله الجمعية فقط. وقد تم إبلاغها.',
        ],
        'fr' => [
            'titel_lesen' => 'Procuration à lire',
            'titel_sig' => 'Signer la procuration',
            'hallo' => 'Bonjour',
            'gilt_noch' => 'Ce lien est encore valable',
            'abgelaufen_t' => 'Ce lien a expiré.',
            'abgelaufen_x' => 'Il était valable 30 minutes. Le document est inchangé — seule cette adresse n\'est plus valable.',
            'neuer_link' => 'Envoyer un nouveau lien par SMS',
            'neuer_hinweis' => 'Il ira au même numéro que tout à l\'heure.',
            'unbekannt_t' => 'Nous ne connaissons pas cette adresse.',
            'unbekannt_x' => 'Veuillez vérifier le lien dans le SMS.',
            'ansehen' => 'Voir le document',
            'seiten_n' => 'Pages',
            'von' => 'sur',
            'bis_ende' => 'Veuillez faire défiler jusqu\'à la fin.',
            'gelesen' => 'Lu — continuer',
            'herunterladen' => 'Télécharger',
            'bestaetigen' => 'J\'ai lu le document',
            'danke_t' => 'Merci.',
            'danke_gelesen' => 'L\'association a été informée.',
            'unterschreiben' => 'Veuillez signer avec le doigt dans le champ blanc.',
            'loeschen' => 'Effacer',
            'weiter_code' => 'Continuer vers le code',
            'code_t' => 'Nous vous avons envoyé un code au',
            'code_gilt' => 'Le code est valable 5 minutes.',
            'code_neu' => 'Envoyer un nouveau code',
            'jetzt_sig' => 'Signer maintenant',
            'fertig_t' => 'Merci.',
            'fertig_x' => 'Votre signature nous est parvenue.',
            'pruefcode' => 'Code de vérification',
            'schliessen' => 'Vous pouvez fermer cette page.',
            'erledigt_t' => 'C\'est déjà fait.',
            'fehler' => 'Quelque chose s\'est mal passé. Veuillez réessayer.',
            'leer' => 'Veuillez d\'abord signer.',
            'code_leer' => 'Veuillez saisir le code.',
            'neu_nur_vorstand' => 'Seule l\'association peut envoyer un nouveau lien de signature. Elle a été informée.',
        ],
        'es' => [
            'titel_lesen' => 'Poder para leer',
            'titel_sig' => 'Firmar el poder',
            'hallo' => 'Buenos días',
            'gilt_noch' => 'Este enlace aún es válido',
            'abgelaufen_t' => 'Este enlace ha caducado.',
            'abgelaufen_x' => 'Fue válido durante 30 minutos. El documento no ha cambiado — solo esta dirección ya no vale.',
            'neuer_link' => 'Enviar un enlace nuevo por SMS',
            'neuer_hinweis' => 'Irá al mismo número que antes.',
            'unbekannt_t' => 'No conocemos esta dirección.',
            'unbekannt_x' => 'Compruebe el enlace del SMS.',
            'ansehen' => 'Ver el documento',
            'seiten_n' => 'Páginas',
            'von' => 'de',
            'bis_ende' => 'Desplácese hasta el final, por favor.',
            'gelesen' => 'Leído — continuar',
            'herunterladen' => 'Descargar',
            'bestaetigen' => 'He leído el documento',
            'danke_t' => 'Gracias.',
            'danke_gelesen' => 'Se ha informado a la asociación.',
            'unterschreiben' => 'Firme con el dedo en el campo blanco, por favor.',
            'loeschen' => 'Borrar',
            'weiter_code' => 'Continuar al código',
            'code_t' => 'Le hemos enviado un código al',
            'code_gilt' => 'El código es válido 5 minutos.',
            'code_neu' => 'Enviar un código nuevo',
            'jetzt_sig' => 'Firmar ahora',
            'fertig_t' => 'Gracias.',
            'fertig_x' => 'Su firma ha llegado.',
            'pruefcode' => 'Código de verificación',
            'schliessen' => 'Puede cerrar esta página.',
            'erledigt_t' => 'Esto ya está hecho.',
            'fehler' => 'Algo ha salido mal. Inténtelo de nuevo.',
            'leer' => 'Firme primero, por favor.',
            'code_leer' => 'Introduzca el código, por favor.',
            'neu_nur_vorstand' => 'Un nuevo enlace para firmar solo lo envía la asociación. Ha sido informada.',
        ],
        'it' => [
            'titel_lesen' => 'Procura da leggere',
            'titel_sig' => 'Firmare la procura',
            'hallo' => 'Buongiorno',
            'gilt_noch' => 'Questo link è ancora valido',
            'abgelaufen_t' => 'Questo link è scaduto.',
            'abgelaufen_x' => 'Era valido 30 minuti. Il documento è invariato — solo questo indirizzo non vale più.',
            'neuer_link' => 'Inviare un nuovo link per SMS',
            'neuer_hinweis' => 'Andrà allo stesso numero di prima.',
            'unbekannt_t' => 'Non conosciamo questo indirizzo.',
            'unbekannt_x' => 'Controlli il link nell\'SMS.',
            'ansehen' => 'Vedere il documento',
            'seiten_n' => 'Pagine',
            'von' => 'di',
            'bis_ende' => 'Scorra fino alla fine, per favore.',
            'gelesen' => 'Letto — avanti',
            'herunterladen' => 'Scaricare',
            'bestaetigen' => 'Ho letto il documento',
            'danke_t' => 'Grazie.',
            'danke_gelesen' => 'L\'associazione è stata informata.',
            'unterschreiben' => 'Firmi con il dito nel campo bianco, per favore.',
            'loeschen' => 'Cancellare',
            'weiter_code' => 'Avanti al codice',
            'code_t' => 'Le abbiamo inviato un codice al',
            'code_gilt' => 'Il codice è valido 5 minuti.',
            'code_neu' => 'Inviare un nuovo codice',
            'jetzt_sig' => 'Firmare ora',
            'fertig_t' => 'Grazie.',
            'fertig_x' => 'La Sua firma è arrivata.',
            'pruefcode' => 'Codice di verifica',
            'schliessen' => 'Può chiudere questa pagina.',
            'erledigt_t' => 'Questo è già stato fatto.',
            'fehler' => 'Qualcosa è andato storto. Riprovi.',
            'leer' => 'Firmi prima, per favore.',
            'code_leer' => 'Inserisca il codice, per favore.',
            'neu_nur_vorstand' => 'Un nuovo link per firmare lo invia solo l\'associazione. È stata informata.',
        ],
        'pt' => [
            'titel_lesen' => 'Procuração para ler',
            'titel_sig' => 'Assinar a procuração',
            'hallo' => 'Bom dia',
            'gilt_noch' => 'Esta ligação ainda é válida',
            'abgelaufen_t' => 'Esta ligação expirou.',
            'abgelaufen_x' => 'Foi válida durante 30 minutos. O documento está inalterado — apenas este endereço já não vale.',
            'neuer_link' => 'Enviar uma nova ligação por SMS',
            'neuer_hinweis' => 'Vai para o mesmo número de antes.',
            'unbekannt_t' => 'Não conhecemos este endereço.',
            'unbekannt_x' => 'Verifique a ligação na mensagem.',
            'ansehen' => 'Ver o documento',
            'seiten_n' => 'Páginas',
            'von' => 'de',
            'bis_ende' => 'Percorra até ao fim, por favor.',
            'gelesen' => 'Lido — continuar',
            'herunterladen' => 'Transferir',
            'bestaetigen' => 'Li o documento',
            'danke_t' => 'Obrigado.',
            'danke_gelesen' => 'A associação foi informada.',
            'unterschreiben' => 'Assine com o dedo no campo branco, por favor.',
            'loeschen' => 'Apagar',
            'weiter_code' => 'Continuar para o código',
            'code_t' => 'Enviámos-lhe um código para',
            'code_gilt' => 'O código é válido 5 minutos.',
            'code_neu' => 'Enviar um novo código',
            'jetzt_sig' => 'Assinar agora',
            'fertig_t' => 'Obrigado.',
            'fertig_x' => 'A sua assinatura chegou.',
            'pruefcode' => 'Código de verificação',
            'schliessen' => 'Pode fechar esta página.',
            'erledigt_t' => 'Isto já foi feito.',
            'fehler' => 'Algo correu mal. Tente novamente.',
            'leer' => 'Assine primeiro, por favor.',
            'code_leer' => 'Introduza o código, por favor.',
            'neu_nur_vorstand' => 'Uma nova ligação para assinar só a associação a envia. Foi informada.',
        ],
        'pl' => [
            'titel_lesen' => 'Pełnomocnictwo do przeczytania',
            'titel_sig' => 'Podpisz pełnomocnictwo',
            'hallo' => 'Dzień dobry',
            'gilt_noch' => 'Ten link jest ważny jeszcze',
            'abgelaufen_t' => 'Ten link wygasł.',
            'abgelaufen_x' => 'Był ważny 30 minut. Dokument jest niezmieniony — tylko ten adres już nie działa.',
            'neuer_link' => 'Wyślij nowy link SMS-em',
            'neuer_hinweis' => 'Trafi na ten sam numer co poprzednio.',
            'unbekannt_t' => 'Nie znamy tego adresu.',
            'unbekannt_x' => 'Proszę sprawdzić link w SMS-ie.',
            'ansehen' => 'Zobacz dokument',
            'seiten_n' => 'Stron',
            'von' => 'z',
            'bis_ende' => 'Proszę przewinąć do końca.',
            'gelesen' => 'Przeczytane — dalej',
            'herunterladen' => 'Pobierz',
            'bestaetigen' => 'Przeczytałem dokument',
            'danke_t' => 'Dziękujemy.',
            'danke_gelesen' => 'Stowarzyszenie zostało powiadomione.',
            'unterschreiben' => 'Proszę podpisać palcem w białym polu.',
            'loeschen' => 'Wyczyść',
            'weiter_code' => 'Dalej do kodu',
            'code_t' => 'Wysłaliśmy Państwu kod na',
            'code_gilt' => 'Kod jest ważny 5 minut.',
            'code_neu' => 'Wyślij nowy kod',
            'jetzt_sig' => 'Podpisz teraz',
            'fertig_t' => 'Dziękujemy.',
            'fertig_x' => 'Państwa podpis dotarł.',
            'pruefcode' => 'Kod weryfikacyjny',
            'schliessen' => 'Tę stronę można zamknąć.',
            'erledigt_t' => 'To już zostało zrobione.',
            'fehler' => 'Coś poszło nie tak. Proszę spróbować ponownie.',
            'leer' => 'Proszę najpierw podpisać.',
            'code_leer' => 'Proszę wpisać kod.',
            'neu_nur_vorstand' => 'Nowy link do podpisu wysyła tylko stowarzyszenie. Zostało powiadomione.',
        ],
        'cs' => [
            'titel_lesen' => 'Plná moc ke čtení',
            'titel_sig' => 'Podepsat plnou moc',
            'hallo' => 'Dobrý den',
            'gilt_noch' => 'Tento odkaz je platný ještě',
            'abgelaufen_t' => 'Platnost tohoto odkazu vypršela.',
            'abgelaufen_x' => 'Byl platný 30 minut. Dokument se nezměnil — neplatí už jen tato adresa.',
            'neuer_link' => 'Poslat nový odkaz SMS zprávou',
            'neuer_hinweis' => 'Přijde na stejné číslo jako předtím.',
            'unbekannt_t' => 'Tuto adresu neznáme.',
            'unbekannt_x' => 'Zkontrolujte prosím odkaz v SMS.',
            'ansehen' => 'Zobrazit dokument',
            'seiten_n' => 'Stran',
            'von' => 'z',
            'bis_ende' => 'Přejděte prosím až na konec.',
            'gelesen' => 'Přečteno — dále',
            'herunterladen' => 'Stáhnout',
            'bestaetigen' => 'Dokument jsem přečetl',
            'danke_t' => 'Děkujeme.',
            'danke_gelesen' => 'Sdružení bylo informováno.',
            'unterschreiben' => 'Podepište se prosím prstem do bílého pole.',
            'loeschen' => 'Smazat',
            'weiter_code' => 'Dále ke kódu',
            'code_t' => 'Poslali jsme vám kód na',
            'code_gilt' => 'Kód platí 5 minut.',
            'code_neu' => 'Poslat nový kód',
            'jetzt_sig' => 'Podepsat',
            'fertig_t' => 'Děkujeme.',
            'fertig_x' => 'Váš podpis dorazil.',
            'pruefcode' => 'Ověřovací kód',
            'schliessen' => 'Tuto stránku můžete zavřít.',
            'erledigt_t' => 'To už je hotové.',
            'fehler' => 'Něco se pokazilo. Zkuste to prosím znovu.',
            'leer' => 'Nejprve se prosím podepište.',
            'code_leer' => 'Zadejte prosím kód.',
            'neu_nur_vorstand' => 'Nový odkaz k podpisu posílá jen sdružení. Bylo informováno.',
        ],
        'sk' => [
            'titel_lesen' => 'Plná moc na prečítanie',
            'titel_sig' => 'Podpísať plnú moc',
            'hallo' => 'Dobrý deň',
            'gilt_noch' => 'Tento odkaz je platný ešte',
            'abgelaufen_t' => 'Platnosť tohto odkazu vypršala.',
            'abgelaufen_x' => 'Bol platný 30 minút. Dokument sa nezmenil — neplatí už len táto adresa.',
            'neuer_link' => 'Poslať nový odkaz SMS správou',
            'neuer_hinweis' => 'Príde na rovnaké číslo ako predtým.',
            'unbekannt_t' => 'Túto adresu nepoznáme.',
            'unbekannt_x' => 'Skontrolujte prosím odkaz v SMS.',
            'ansehen' => 'Zobraziť dokument',
            'seiten_n' => 'Strán',
            'von' => 'z',
            'bis_ende' => 'Prejdite prosím až na koniec.',
            'gelesen' => 'Prečítané — ďalej',
            'herunterladen' => 'Stiahnuť',
            'bestaetigen' => 'Dokument som prečítal',
            'danke_t' => 'Ďakujeme.',
            'danke_gelesen' => 'Združenie bolo informované.',
            'unterschreiben' => 'Podpíšte sa prosím prstom do bieleho poľa.',
            'loeschen' => 'Vymazať',
            'weiter_code' => 'Ďalej ku kódu',
            'code_t' => 'Poslali sme vám kód na',
            'code_gilt' => 'Kód platí 5 minút.',
            'code_neu' => 'Poslať nový kód',
            'jetzt_sig' => 'Podpísať',
            'fertig_t' => 'Ďakujeme.',
            'fertig_x' => 'Váš podpis dorazil.',
            'pruefcode' => 'Overovací kód',
            'schliessen' => 'Túto stránku môžete zavrieť.',
            'erledigt_t' => 'To už je hotové.',
            'fehler' => 'Niečo sa pokazilo. Skúste to prosím znova.',
            'leer' => 'Najprv sa prosím podpíšte.',
            'code_leer' => 'Zadajte prosím kód.',
            'neu_nur_vorstand' => 'Nový odkaz na podpis posiela len združenie. Bolo informované.',
        ],
        'sl' => [
            'titel_lesen' => 'Pooblastilo za branje',
            'titel_sig' => 'Podpišite pooblastilo',
            'hallo' => 'Dober dan',
            'gilt_noch' => 'Ta povezava velja še',
            'abgelaufen_t' => 'Ta povezava je potekla.',
            'abgelaufen_x' => 'Veljala je 30 minut. Dokument je nespremenjen — le ta naslov ne velja več.',
            'neuer_link' => 'Pošlji novo povezavo po SMS',
            'neuer_hinweis' => 'Prišla bo na isto številko kot prej.',
            'unbekannt_t' => 'Tega naslova ne poznamo.',
            'unbekannt_x' => 'Preverite povezavo v sporočilu SMS.',
            'ansehen' => 'Poglej dokument',
            'seiten_n' => 'Strani',
            'von' => 'od',
            'bis_ende' => 'Pomaknite se prosim do konca.',
            'gelesen' => 'Prebrano — naprej',
            'herunterladen' => 'Prenesi',
            'bestaetigen' => 'Dokument sem prebral',
            'danke_t' => 'Hvala.',
            'danke_gelesen' => 'Društvo je bilo obveščeno.',
            'unterschreiben' => 'Podpišite se prosim s prstom v belo polje.',
            'loeschen' => 'Izbriši',
            'weiter_code' => 'Naprej na kodo',
            'code_t' => 'Poslali smo vam kodo na',
            'code_gilt' => 'Koda velja 5 minut.',
            'code_neu' => 'Pošlji novo kodo',
            'jetzt_sig' => 'Podpiši zdaj',
            'fertig_t' => 'Hvala.',
            'fertig_x' => 'Vaš podpis je prispel.',
            'pruefcode' => 'Koda za preverjanje',
            'schliessen' => 'To stran lahko zaprete.',
            'erledigt_t' => 'To je že opravljeno.',
            'fehler' => 'Nekaj je šlo narobe. Poskusite znova.',
            'leer' => 'Najprej se prosim podpišite.',
            'code_leer' => 'Vnesite prosim kodo.',
            'neu_nur_vorstand' => 'Novo povezavo za podpis pošlje le društvo. Obveščeno je bilo.',
        ],
        'hr' => [
            'titel_lesen' => 'Punomoć za čitanje',
            'titel_sig' => 'Potpišite punomoć',
            'hallo' => 'Dobar dan',
            'gilt_noch' => 'Ova poveznica vrijedi još',
            'abgelaufen_t' => 'Ova poveznica je istekla.',
            'abgelaufen_x' => 'Vrijedila je 30 minuta. Dokument je nepromijenjen — samo ova adresa više ne vrijedi.',
            'neuer_link' => 'Pošalji novu poveznicu SMS-om',
            'neuer_hinweis' => 'Ići će na isti broj kao i prije.',
            'unbekannt_t' => 'Ne poznajemo ovu adresu.',
            'unbekannt_x' => 'Provjerite poveznicu u SMS-u.',
            'ansehen' => 'Pogledaj dokument',
            'seiten_n' => 'Stranica',
            'von' => 'od',
            'bis_ende' => 'Pomaknite se molimo do kraja.',
            'gelesen' => 'Pročitano — dalje',
            'herunterladen' => 'Preuzmi',
            'bestaetigen' => 'Pročitao sam dokument',
            'danke_t' => 'Hvala.',
            'danke_gelesen' => 'Udruga je obaviještena.',
            'unterschreiben' => 'Potpišite se molimo prstom u bijelo polje.',
            'loeschen' => 'Obriši',
            'weiter_code' => 'Dalje na kod',
            'code_t' => 'Poslali smo vam kod na',
            'code_gilt' => 'Kod vrijedi 5 minuta.',
            'code_neu' => 'Pošalji novi kod',
            'jetzt_sig' => 'Potpiši sada',
            'fertig_t' => 'Hvala.',
            'fertig_x' => 'Vaš potpis je stigao.',
            'pruefcode' => 'Kod za provjeru',
            'schliessen' => 'Ovu stranicu možete zatvoriti.',
            'erledigt_t' => 'To je već obavljeno.',
            'fehler' => 'Nešto je pošlo po zlu. Pokušajte ponovno.',
            'leer' => 'Molimo najprije se potpišite.',
            'code_leer' => 'Molimo unesite kod.',
            'neu_nur_vorstand' => 'Novu poveznicu za potpis šalje samo udruga. Obaviještena je.',
        ],
        'sr' => [
            'titel_lesen' => 'Punomoćje za čitanje',
            'titel_sig' => 'Potpišite punomoćje',
            'hallo' => 'Dobar dan',
            'gilt_noch' => 'Ovaj link važi još',
            'abgelaufen_t' => 'Ovaj link je istekao.',
            'abgelaufen_x' => 'Važio je 30 minuta. Dokument je nepromenjen — samo ova adresa više ne važi.',
            'neuer_link' => 'Pošalji novi link SMS-om',
            'neuer_hinweis' => 'Ići će na isti broj kao i pre.',
            'unbekannt_t' => 'Ne poznajemo ovu adresu.',
            'unbekannt_x' => 'Proverite link u SMS-u.',
            'ansehen' => 'Pogledaj dokument',
            'seiten_n' => 'Strana',
            'von' => 'od',
            'bis_ende' => 'Pomerite molimo do kraja.',
            'gelesen' => 'Pročitano — dalje',
            'herunterladen' => 'Preuzmi',
            'bestaetigen' => 'Pročitao sam dokument',
            'danke_t' => 'Hvala.',
            'danke_gelesen' => 'Udruženje je obavešteno.',
            'unterschreiben' => 'Potpišite se molimo prstom u belo polje.',
            'loeschen' => 'Obriši',
            'weiter_code' => 'Dalje na kod',
            'code_t' => 'Poslali smo vam kod na',
            'code_gilt' => 'Kod važi 5 minuta.',
            'code_neu' => 'Pošalji novi kod',
            'jetzt_sig' => 'Potpiši sada',
            'fertig_t' => 'Hvala.',
            'fertig_x' => 'Vaš potpis je stigao.',
            'pruefcode' => 'Kod za proveru',
            'schliessen' => 'Ovu stranicu možete zatvoriti.',
            'erledigt_t' => 'To je već urađeno.',
            'fehler' => 'Nešto je pošlo naopako. Pokušajte ponovo.',
            'leer' => 'Molimo najpre se potpišite.',
            'code_leer' => 'Molimo unesite kod.',
            'neu_nur_vorstand' => 'Novi link za potpis šalje samo udruženje. Obavešteno je.',
        ],
        'bg' => [
            'titel_lesen' => 'Пълномощно за четене',
            'titel_sig' => 'Подпишете пълномощното',
            'hallo' => 'Добър ден',
            'gilt_noch' => 'Тази връзка е валидна още',
            'abgelaufen_t' => 'Тази връзка изтече.',
            'abgelaufen_x' => 'Беше валидна 30 минути. Документът е непроменен — само този адрес вече не важи.',
            'neuer_link' => 'Изпрати нова връзка по SMS',
            'neuer_hinweis' => 'Ще отиде на същия номер както преди.',
            'unbekannt_t' => 'Не познаваме този адрес.',
            'unbekannt_x' => 'Моля, проверете връзката в съобщението.',
            'ansehen' => 'Виж документа',
            'seiten_n' => 'Страници',
            'von' => 'от',
            'bis_ende' => 'Моля, превъртете до края.',
            'gelesen' => 'Прочетено — напред',
            'herunterladen' => 'Изтегли',
            'bestaetigen' => 'Прочетох документа',
            'danke_t' => 'Благодарим.',
            'danke_gelesen' => 'Сдружението беше уведомено.',
            'unterschreiben' => 'Моля, подпишете се с пръст в бялото поле.',
            'loeschen' => 'Изчисти',
            'weiter_code' => 'Напред към кода',
            'code_t' => 'Изпратихме ви код на',
            'code_gilt' => 'Кодът важи 5 минути.',
            'code_neu' => 'Изпрати нов код',
            'jetzt_sig' => 'Подпиши сега',
            'fertig_t' => 'Благодарим.',
            'fertig_x' => 'Вашият подпис пристигна.',
            'pruefcode' => 'Код за проверка',
            'schliessen' => 'Можете да затворите тази страница.',
            'erledigt_t' => 'Това вече е направено.',
            'fehler' => 'Нещо се обърка. Моля, опитайте отново.',
            'leer' => 'Моля, първо се подпишете.',
            'code_leer' => 'Моля, въведете кода.',
            'neu_nur_vorstand' => 'Нова връзка за подпис изпраща само сдружението. То беше уведомено.',
        ],
        'hu' => [
            'titel_lesen' => 'Meghatalmazás olvasásra',
            'titel_sig' => 'Írja alá a meghatalmazást',
            'hallo' => 'Jó napot',
            'gilt_noch' => 'Ez a link még érvényes',
            'abgelaufen_t' => 'Ez a link lejárt.',
            'abgelaufen_x' => '30 percig volt érvényes. A dokumentum változatlan — csak ez a cím nem érvényes többé.',
            'neuer_link' => 'Új link küldése SMS-ben',
            'neuer_hinweis' => 'Ugyanarra a számra megy, mint korábban.',
            'unbekannt_t' => 'Ezt a címet nem ismerjük.',
            'unbekannt_x' => 'Kérjük, ellenőrizze a linket az SMS-ben.',
            'ansehen' => 'Dokumentum megtekintése',
            'seiten_n' => 'Oldal',
            'von' => '/',
            'bis_ende' => 'Kérjük, görgessen a végéig.',
            'gelesen' => 'Elolvastam — tovább',
            'herunterladen' => 'Letöltés',
            'bestaetigen' => 'Elolvastam a dokumentumot',
            'danke_t' => 'Köszönjük.',
            'danke_gelesen' => 'Az egyesületet értesítettük.',
            'unterschreiben' => 'Kérjük, írja alá az ujjával a fehér mezőben.',
            'loeschen' => 'Törlés',
            'weiter_code' => 'Tovább a kódhoz',
            'code_t' => 'Kódot küldtünk Önnek erre a számra:',
            'code_gilt' => 'A kód 5 percig érvényes.',
            'code_neu' => 'Új kód küldése',
            'jetzt_sig' => 'Aláírás most',
            'fertig_t' => 'Köszönjük.',
            'fertig_x' => 'Az aláírása megérkezett.',
            'pruefcode' => 'Ellenőrző kód',
            'schliessen' => 'Ezt az oldalt bezárhatja.',
            'erledigt_t' => 'Ez már megtörtént.',
            'fehler' => 'Valami hiba történt. Kérjük, próbálja újra.',
            'leer' => 'Kérjük, először írja alá.',
            'code_leer' => 'Kérjük, adja meg a kódot.',
            'neu_nur_vorstand' => 'Új aláírási linket csak az egyesület küld. Értesítettük.',
        ],
        'fi' => [
            'titel_lesen' => 'Valtakirja luettavaksi',
            'titel_sig' => 'Allekirjoita valtakirja',
            'hallo' => 'Hyvää päivää',
            'gilt_noch' => 'Tämä linkki on voimassa vielä',
            'abgelaufen_t' => 'Tämä linkki on vanhentunut.',
            'abgelaufen_x' => 'Se oli voimassa 30 minuuttia. Asiakirja on ennallaan — vain tämä osoite ei enää toimi.',
            'neuer_link' => 'Lähetä uusi linkki tekstiviestillä',
            'neuer_hinweis' => 'Se menee samaan numeroon kuin aiemmin.',
            'unbekannt_t' => 'Emme tunne tätä osoitetta.',
            'unbekannt_x' => 'Tarkista linkki tekstiviestistä.',
            'ansehen' => 'Näytä asiakirja',
            'seiten_n' => 'Sivuja',
            'von' => '/',
            'bis_ende' => 'Vieritä loppuun asti.',
            'gelesen' => 'Luettu — jatka',
            'herunterladen' => 'Lataa',
            'bestaetigen' => 'Olen lukenut asiakirjan',
            'danke_t' => 'Kiitos.',
            'danke_gelesen' => 'Yhdistykselle on ilmoitettu.',
            'unterschreiben' => 'Allekirjoita sormella valkoiseen kenttään.',
            'loeschen' => 'Tyhjennä',
            'weiter_code' => 'Jatka koodiin',
            'code_t' => 'Lähetimme sinulle koodin numeroon',
            'code_gilt' => 'Koodi on voimassa 5 minuuttia.',
            'code_neu' => 'Lähetä uusi koodi',
            'jetzt_sig' => 'Allekirjoita nyt',
            'fertig_t' => 'Kiitos.',
            'fertig_x' => 'Allekirjoituksesi on saapunut.',
            'pruefcode' => 'Tarkistuskoodi',
            'schliessen' => 'Voit sulkea tämän sivun.',
            'erledigt_t' => 'Tämä on jo tehty.',
            'fehler' => 'Jokin meni pieleen. Yritä uudelleen.',
            'leer' => 'Allekirjoita ensin.',
            'code_leer' => 'Syötä koodi.',
            'neu_nur_vorstand' => 'Uuden allekirjoituslinkin lähettää vain yhdistys. Sille on ilmoitettu.',
        ],
        'et' => [
            'titel_lesen' => 'Volikiri lugemiseks',
            'titel_sig' => 'Allkirjastage volikiri',
            'hallo' => 'Tere päevast',
            'gilt_noch' => 'See link kehtib veel',
            'abgelaufen_t' => 'See link on aegunud.',
            'abgelaufen_x' => 'See kehtis 30 minutit. Dokument on muutumatu — ainult see aadress enam ei kehti.',
            'neuer_link' => 'Saada uus link SMS-iga',
            'neuer_hinweis' => 'See läheb samale numbrile nagu enne.',
            'unbekannt_t' => 'Me ei tunne seda aadressi.',
            'unbekannt_x' => 'Palun kontrollige linki SMS-is.',
            'ansehen' => 'Vaata dokumenti',
            'seiten_n' => 'Lehekülgi',
            'von' => '/',
            'bis_ende' => 'Palun kerige lõpuni.',
            'gelesen' => 'Loetud — edasi',
            'herunterladen' => 'Laadi alla',
            'bestaetigen' => 'Lugesin dokumendi läbi',
            'danke_t' => 'Aitäh.',
            'danke_gelesen' => 'Ühingut on teavitatud.',
            'unterschreiben' => 'Palun kirjutage sõrmega alla valgele väljale.',
            'loeschen' => 'Kustuta',
            'weiter_code' => 'Edasi koodi juurde',
            'code_t' => 'Saatsime teile koodi numbrile',
            'code_gilt' => 'Kood kehtib 5 minutit.',
            'code_neu' => 'Saada uus kood',
            'jetzt_sig' => 'Allkirjasta nüüd',
            'fertig_t' => 'Aitäh.',
            'fertig_x' => 'Teie allkiri on kohal.',
            'pruefcode' => 'Kontrollkood',
            'schliessen' => 'Selle lehe võite sulgeda.',
            'erledigt_t' => 'See on juba tehtud.',
            'fehler' => 'Midagi läks valesti. Palun proovige uuesti.',
            'leer' => 'Palun kirjutage kõigepealt alla.',
            'code_leer' => 'Palun sisestage kood.',
            'neu_nur_vorstand' => 'Uue allkirjastamislingi saadab ainult ühing. Teda on teavitatud.',
        ],
        'lt' => [
            'titel_lesen' => 'Įgaliojimas perskaityti',
            'titel_sig' => 'Pasirašykite įgaliojimą',
            'hallo' => 'Laba diena',
            'gilt_noch' => 'Ši nuoroda galioja dar',
            'abgelaufen_t' => 'Ši nuoroda nebegalioja.',
            'abgelaufen_x' => 'Ji galiojo 30 minučių. Dokumentas nepakitęs — tik šis adresas nebegalioja.',
            'neuer_link' => 'Siųsti naują nuorodą SMS žinute',
            'neuer_hinweis' => 'Ji ateis tuo pačiu numeriu kaip anksčiau.',
            'unbekannt_t' => 'Šio adreso nežinome.',
            'unbekannt_x' => 'Patikrinkite nuorodą SMS žinutėje.',
            'ansehen' => 'Peržiūrėti dokumentą',
            'seiten_n' => 'Puslapių',
            'von' => 'iš',
            'bis_ende' => 'Prašome slinkti iki galo.',
            'gelesen' => 'Perskaityta — toliau',
            'herunterladen' => 'Atsisiųsti',
            'bestaetigen' => 'Perskaičiau dokumentą',
            'danke_t' => 'Ačiū.',
            'danke_gelesen' => 'Asociacija informuota.',
            'unterschreiben' => 'Prašome pasirašyti pirštu baltame lauke.',
            'loeschen' => 'Išvalyti',
            'weiter_code' => 'Toliau prie kodo',
            'code_t' => 'Išsiuntėme jums kodą numeriu',
            'code_gilt' => 'Kodas galioja 5 minutes.',
            'code_neu' => 'Siųsti naują kodą',
            'jetzt_sig' => 'Pasirašyti dabar',
            'fertig_t' => 'Ačiū.',
            'fertig_x' => 'Jūsų parašas gautas.',
            'pruefcode' => 'Patikros kodas',
            'schliessen' => 'Šį puslapį galite uždaryti.',
            'erledigt_t' => 'Tai jau padaryta.',
            'fehler' => 'Kažkas nepavyko. Bandykite dar kartą.',
            'leer' => 'Pirmiausia pasirašykite.',
            'code_leer' => 'Įveskite kodą.',
            'neu_nur_vorstand' => 'Naują pasirašymo nuorodą siunčia tik asociacija. Ji informuota.',
        ],
        'lv' => [
            'titel_lesen' => 'Pilnvara lasīšanai',
            'titel_sig' => 'Parakstiet pilnvaru',
            'hallo' => 'Labdien',
            'gilt_noch' => 'Šī saite ir derīga vēl',
            'abgelaufen_t' => 'Šī saite ir beigusies.',
            'abgelaufen_x' => 'Tā bija derīga 30 minūtes. Dokuments nav mainīts — tikai šī adrese vairs nav derīga.',
            'neuer_link' => 'Nosūtīt jaunu saiti ar SMS',
            'neuer_hinweis' => 'Tā nonāks uz to pašu numuru kā iepriekš.',
            'unbekannt_t' => 'Šo adresi mēs nezinām.',
            'unbekannt_x' => 'Lūdzu, pārbaudiet saiti SMS.',
            'ansehen' => 'Skatīt dokumentu',
            'seiten_n' => 'Lappuses',
            'von' => 'no',
            'bis_ende' => 'Lūdzu, ritiniet līdz beigām.',
            'gelesen' => 'Izlasīts — tālāk',
            'herunterladen' => 'Lejupielādēt',
            'bestaetigen' => 'Es izlasīju dokumentu',
            'danke_t' => 'Paldies.',
            'danke_gelesen' => 'Biedrība ir informēta.',
            'unterschreiben' => 'Lūdzu, parakstieties ar pirkstu baltajā laukā.',
            'loeschen' => 'Notīrīt',
            'weiter_code' => 'Tālāk uz kodu',
            'code_t' => 'Mēs nosūtījām jums kodu uz',
            'code_gilt' => 'Kods ir derīgs 5 minūtes.',
            'code_neu' => 'Nosūtīt jaunu kodu',
            'jetzt_sig' => 'Parakstīt tagad',
            'fertig_t' => 'Paldies.',
            'fertig_x' => 'Jūsu paraksts ir saņemts.',
            'pruefcode' => 'Pārbaudes kods',
            'schliessen' => 'Šo lapu varat aizvērt.',
            'erledigt_t' => 'Tas jau ir izdarīts.',
            'fehler' => 'Kaut kas nogāja greizi. Lūdzu, mēģiniet vēlreiz.',
            'leer' => 'Lūdzu, vispirms parakstieties.',
            'code_leer' => 'Lūdzu, ievadiet kodu.',
            'neu_nur_vorstand' => 'Jaunu parakstīšanas saiti sūta tikai biedrība. Tā ir informēta.',
        ],
        'nl' => [
            'titel_lesen' => 'Volmacht om te lezen',
            'titel_sig' => 'Onderteken de volmacht',
            'hallo' => 'Goedendag',
            'gilt_noch' => 'Deze link is nog geldig',
            'abgelaufen_t' => 'Deze link is verlopen.',
            'abgelaufen_x' => 'Hij was 30 minuten geldig. Het document is ongewijzigd — alleen dit adres geldt niet meer.',
            'neuer_link' => 'Nieuwe link per sms sturen',
            'neuer_hinweis' => 'Hij gaat naar hetzelfde nummer als daarnet.',
            'unbekannt_t' => 'Wij kennen dit adres niet.',
            'unbekannt_x' => 'Controleer de link in de sms.',
            'ansehen' => 'Document bekijken',
            'seiten_n' => 'Pagina\'s',
            'von' => 'van',
            'bis_ende' => 'Scrol alstublieft tot het einde.',
            'gelesen' => 'Gelezen — verder',
            'herunterladen' => 'Downloaden',
            'bestaetigen' => 'Ik heb het document gelezen',
            'danke_t' => 'Dank u wel.',
            'danke_gelesen' => 'De vereniging is op de hoogte gebracht.',
            'unterschreiben' => 'Onderteken alstublieft met uw vinger in het witte veld.',
            'loeschen' => 'Wissen',
            'weiter_code' => 'Verder naar de code',
            'code_t' => 'Wij hebben u een code gestuurd naar',
            'code_gilt' => 'De code is 5 minuten geldig.',
            'code_neu' => 'Nieuwe code sturen',
            'jetzt_sig' => 'Nu ondertekenen',
            'fertig_t' => 'Dank u wel.',
            'fertig_x' => 'Uw handtekening is aangekomen.',
            'pruefcode' => 'Controlecode',
            'schliessen' => 'U kunt deze pagina sluiten.',
            'erledigt_t' => 'Dit is al gedaan.',
            'fehler' => 'Er is iets misgegaan. Probeer het opnieuw.',
            'leer' => 'Onderteken eerst, alstublieft.',
            'code_leer' => 'Voer de code in, alstublieft.',
            'neu_nur_vorstand' => 'Een nieuwe link om te ondertekenen stuurt alleen de vereniging. Die is op de hoogte gebracht.',
        ],
        'da' => [
            'titel_lesen' => 'Fuldmagt til gennemlæsning',
            'titel_sig' => 'Underskriv fuldmagten',
            'hallo' => 'Goddag',
            'gilt_noch' => 'Dette link er gyldigt endnu',
            'abgelaufen_t' => 'Dette link er udløbet.',
            'abgelaufen_x' => 'Det var gyldigt i 30 minutter. Dokumentet er uændret — kun denne adresse gælder ikke længere.',
            'neuer_link' => 'Send et nyt link med sms',
            'neuer_hinweis' => 'Det går til det samme nummer som før.',
            'unbekannt_t' => 'Vi kender ikke denne adresse.',
            'unbekannt_x' => 'Kontrollér venligst linket i sms\'en.',
            'ansehen' => 'Se dokumentet',
            'seiten_n' => 'Sider',
            'von' => 'af',
            'bis_ende' => 'Rul venligst til slutningen.',
            'gelesen' => 'Læst — videre',
            'herunterladen' => 'Hent',
            'bestaetigen' => 'Jeg har læst dokumentet',
            'danke_t' => 'Tak.',
            'danke_gelesen' => 'Foreningen er blevet underrettet.',
            'unterschreiben' => 'Skriv venligst under med fingeren i det hvide felt.',
            'loeschen' => 'Ryd',
            'weiter_code' => 'Videre til koden',
            'code_t' => 'Vi har sendt dig en kode til',
            'code_gilt' => 'Koden er gyldig i 5 minutter.',
            'code_neu' => 'Send en ny kode',
            'jetzt_sig' => 'Underskriv nu',
            'fertig_t' => 'Tak.',
            'fertig_x' => 'Din underskrift er kommet frem.',
            'pruefcode' => 'Kontrolkode',
            'schliessen' => 'Du kan lukke denne side.',
            'erledigt_t' => 'Det er allerede gjort.',
            'fehler' => 'Noget gik galt. Prøv venligst igen.',
            'leer' => 'Skriv venligst under først.',
            'code_leer' => 'Indtast venligst koden.',
            'neu_nur_vorstand' => 'Kun foreningen kan sende et nyt link til underskrift. Den er blevet underrettet.',
        ],
        'sv' => [
            'titel_lesen' => 'Fullmakt att läsa',
            'titel_sig' => 'Skriv under fullmakten',
            'hallo' => 'God dag',
            'gilt_noch' => 'Den här länken gäller ännu',
            'abgelaufen_t' => 'Den här länken har gått ut.',
            'abgelaufen_x' => 'Den gällde i 30 minuter. Dokumentet är oförändrat — bara den här adressen gäller inte längre.',
            'neuer_link' => 'Skicka en ny länk via sms',
            'neuer_hinweis' => 'Den går till samma nummer som förut.',
            'unbekannt_t' => 'Vi känner inte till den här adressen.',
            'unbekannt_x' => 'Kontrollera länken i sms:et.',
            'ansehen' => 'Visa dokumentet',
            'seiten_n' => 'Sidor',
            'von' => 'av',
            'bis_ende' => 'Bläddra ända till slutet, tack.',
            'gelesen' => 'Läst — vidare',
            'herunterladen' => 'Ladda ner',
            'bestaetigen' => 'Jag har läst dokumentet',
            'danke_t' => 'Tack.',
            'danke_gelesen' => 'Föreningen har underrättats.',
            'unterschreiben' => 'Skriv under med fingret i det vita fältet, tack.',
            'loeschen' => 'Rensa',
            'weiter_code' => 'Vidare till koden',
            'code_t' => 'Vi har skickat en kod till',
            'code_gilt' => 'Koden gäller i 5 minuter.',
            'code_neu' => 'Skicka en ny kod',
            'jetzt_sig' => 'Skriv under nu',
            'fertig_t' => 'Tack.',
            'fertig_x' => 'Din underskrift har kommit fram.',
            'pruefcode' => 'Kontrollkod',
            'schliessen' => 'Du kan stänga den här sidan.',
            'erledigt_t' => 'Det är redan gjort.',
            'fehler' => 'Något gick fel. Försök igen.',
            'leer' => 'Skriv under först, tack.',
            'code_leer' => 'Ange koden, tack.',
            'neu_nur_vorstand' => 'Bara föreningen kan skicka en ny länk för underskrift. Den har underrättats.',
        ],
        'nb' => [
            'titel_lesen' => 'Fullmakt til gjennomlesing',
            'titel_sig' => 'Signer fullmakten',
            'hallo' => 'God dag',
            'gilt_noch' => 'Denne lenken er gyldig ennå',
            'abgelaufen_t' => 'Denne lenken er utløpt.',
            'abgelaufen_x' => 'Den var gyldig i 30 minutter. Dokumentet er uendret — bare denne adressen gjelder ikke lenger.',
            'neuer_link' => 'Send en ny lenke på SMS',
            'neuer_hinweis' => 'Den går til samme nummer som før.',
            'unbekannt_t' => 'Vi kjenner ikke denne adressen.',
            'unbekannt_x' => 'Kontroller lenken i SMS-en.',
            'ansehen' => 'Se dokumentet',
            'seiten_n' => 'Sider',
            'von' => 'av',
            'bis_ende' => 'Bla helt til slutten.',
            'gelesen' => 'Lest — videre',
            'herunterladen' => 'Last ned',
            'bestaetigen' => 'Jeg har lest dokumentet',
            'danke_t' => 'Takk.',
            'danke_gelesen' => 'Foreningen er varslet.',
            'unterschreiben' => 'Signer med fingeren i det hvite feltet.',
            'loeschen' => 'Tøm',
            'weiter_code' => 'Videre til koden',
            'code_t' => 'Vi har sendt deg en kode til',
            'code_gilt' => 'Koden er gyldig i 5 minutter.',
            'code_neu' => 'Send en ny kode',
            'jetzt_sig' => 'Signer nå',
            'fertig_t' => 'Takk.',
            'fertig_x' => 'Signaturen din er kommet fram.',
            'pruefcode' => 'Kontrollkode',
            'schliessen' => 'Du kan lukke denne siden.',
            'erledigt_t' => 'Dette er allerede gjort.',
            'fehler' => 'Noe gikk galt. Prøv igjen.',
            'leer' => 'Signer først.',
            'code_leer' => 'Skriv inn koden.',
            'neu_nur_vorstand' => 'Bare foreningen kan sende en ny lenke til signering. Den er varslet.',
        ],
        'el' => [
            'titel_lesen' => 'Πληρεξούσιο για ανάγνωση',
            'titel_sig' => 'Υπογράψτε το πληρεξούσιο',
            'hallo' => 'Καλημέρα',
            'gilt_noch' => 'Αυτός ο σύνδεσμος ισχύει ακόμη',
            'abgelaufen_t' => 'Αυτός ο σύνδεσμος έληξε.',
            'abgelaufen_x' => 'Ίσχυε για 30 λεπτά. Το έγγραφο είναι αμετάβλητο — μόνο αυτή η διεύθυνση δεν ισχύει πια.',
            'neuer_link' => 'Αποστολή νέου συνδέσμου με SMS',
            'neuer_hinweis' => 'Θα σταλεί στον ίδιο αριθμό όπως πριν.',
            'unbekannt_t' => 'Δεν γνωρίζουμε αυτή τη διεύθυνση.',
            'unbekannt_x' => 'Ελέγξτε τον σύνδεσμο στο SMS.',
            'ansehen' => 'Δείτε το έγγραφο',
            'seiten_n' => 'Σελίδες',
            'von' => 'από',
            'bis_ende' => 'Παρακαλούμε κυλήστε ως το τέλος.',
            'gelesen' => 'Διαβάστηκε — συνέχεια',
            'herunterladen' => 'Λήψη',
            'bestaetigen' => 'Διάβασα το έγγραφο',
            'danke_t' => 'Ευχαριστούμε.',
            'danke_gelesen' => 'Ο σύλλογος ενημερώθηκε.',
            'unterschreiben' => 'Παρακαλούμε υπογράψτε με το δάχτυλο στο λευκό πεδίο.',
            'loeschen' => 'Καθαρισμός',
            'weiter_code' => 'Συνέχεια στον κωδικό',
            'code_t' => 'Σας στείλαμε έναν κωδικό στο',
            'code_gilt' => 'Ο κωδικός ισχύει 5 λεπτά.',
            'code_neu' => 'Αποστολή νέου κωδικού',
            'jetzt_sig' => 'Υπογραφή τώρα',
            'fertig_t' => 'Ευχαριστούμε.',
            'fertig_x' => 'Η υπογραφή σας παρελήφθη.',
            'pruefcode' => 'Κωδικός επαλήθευσης',
            'schliessen' => 'Μπορείτε να κλείσετε αυτή τη σελίδα.',
            'erledigt_t' => 'Αυτό έχει ήδη γίνει.',
            'fehler' => 'Κάτι πήγε στραβά. Δοκιμάστε ξανά.',
            'leer' => 'Παρακαλούμε υπογράψτε πρώτα.',
            'code_leer' => 'Παρακαλούμε εισαγάγετε τον κωδικό.',
            'neu_nur_vorstand' => 'Νέο σύνδεσμο για υπογραφή στέλνει μόνο ο σύλλογος. Έχει ενημερωθεί.',
        ],
    ];
    if (isset($t[$sprache])) {
        return $t[$sprache];
    }

    // ⚠️ Der Rueckfall auf Deutsch ist RICHTIG — eine halb uebersetzte Seite
    // waere schlimmer als eine ganz deutsche —, aber er darf nicht STILL
    // geschehen.
    //
    // `users.preferred_language` ist ein ENUM mit 28 Werten; diese Seite
    // kennt die sieben, die die Mitglieder am 19.08.2026 tatsaechlich
    // benutzen (de ro ru en uk tr ar). Setzt jemand ein Mitglied auf
    // Polnisch, bekommt es ab sofort eine deutsche Seite — und niemand
    // erfaehrt es. Diese Zeile ist die einzige Spur, an der das auffaellt.
    error_log('vollmacht_link: keine Oberflaeche fuer Sprache "' . $sprache
            . '" — es wurde Deutsch ausgeliefert');
    return $t['de'];
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

        // 🔴 EINEN SIGNIER-LINK SCHICKT NUR DER VORSTAND.
        //
        // Entscheidung des Vorsitzenden, 19.08.2026, und sie ist die richtige:
        // wer unterschreiben soll, entscheidet der Verein, nicht der
        // Unterzeichner. Duerfte sich das Mitglied selbst einen neuen Link
        // holen, waere die Gelegenheit zu unterschreiben unbegrenzt haltbar —
        // die 30 Minuten waeren dann keine Frist mehr, sondern eine
        // Unannehmlichkeit, die sich wegdruecken laesst.
        //
        // ⚠️ Beim LESE-Link ist es umgekehrt richtig: dort wird nichts
        // erklaert, es wird nur gelesen. Wer den Vorstand anrufen muesste, um
        // ein Dokument noch einmal angezeigt zu bekommen, liest es eben nicht.
        if (($link['zweck'] ?? '') === 'signieren') {
            vlVorstandWecken($pdo, $link, 'Ein Signier-Link ist abgelaufen — '
                . 'das Mitglied wartet auf einen neuen.');
            vlAntwort(false, ['grund' => 'nur_vorstand'], $T['neu_nur_vorstand'], 403);
        }

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
    <?php /* 🔴 Nur beim Leseexemplar darf sich das Mitglied selbst einen
             neuen Link holen. Beim Unterschreiben entscheidet der Verein,
             wann jemand unterschreiben soll — sonst waeren die 30 Minuten
             keine Frist, sondern eine Unannehmlichkeit zum Wegdruecken.
             Der Vorstand ist benachrichtigt; hier steht, dass er es ist. */ ?>
    <?php if (($link['zweck'] ?? '') === 'signieren'): ?>
      <p class="leise"><?= h($T['neu_nur_vorstand']) ?></p>
    <?php else: ?>
      <button class="knopf" id="neuerLink"><?= h($T['neuer_link']) ?></button>
      <p class="leise"><?= h($T['neuer_hinweis']) ?></p>
    <?php endif; ?>
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
