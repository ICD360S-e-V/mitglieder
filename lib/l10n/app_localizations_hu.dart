// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hungarian (`hu`).
class AppLocalizationsHu extends AppLocalizations {
  AppLocalizationsHu([String locale = 'hu']) : super(locale);

  @override
  String get appTitle => 'ICD360S e.V - Tagportál';

  @override
  String get memberPortal => 'Tagportál';

  @override
  String get welcomeLoading => 'Betöltés...';

  @override
  String get welcomeAutoLogin => 'Automatikus bejelentkezés...';

  @override
  String get login => 'Bejelentkezés';

  @override
  String get register => 'Regisztráció';

  @override
  String get becomeMember => 'Legyen tag';

  @override
  String get memberNumber => 'Tagsági szám';

  @override
  String get memberNumberHint => 'Adja meg a tagsági számot';

  @override
  String get password => 'Jelszó';

  @override
  String get passwordHint => 'Adja meg a jelszót';

  @override
  String get confirmPassword => 'Jelszó megerősítése';

  @override
  String get confirmPasswordHint => 'Erősítse meg a jelszót';

  @override
  String get newPassword => 'Új jelszó';

  @override
  String get newPasswordHint => 'Adja meg az új jelszót';

  @override
  String get saveCredentials => 'Bejelentkezési adatok mentése';

  @override
  String get autoLogin => 'Automatikus bejelentkezés';

  @override
  String get forgotPassword => 'Elfelejtette jelszavát?';

  @override
  String get firstName => 'Keresztnév és vezetéknév';

  @override
  String get firstNameHint => 'Adja meg a nevét';

  @override
  String get nameMinLength => 'A név legalább 2 karakter legyen';

  @override
  String get nameOnlyLetters => 'Csak betűk és kötőjelek engedélyezettek';

  @override
  String get email => 'E-mail cím';

  @override
  String get emailHint => 'Adja meg az e-mail címet';

  @override
  String get emailInvalid => 'Adjon meg érvényes e-mail címet';

  @override
  String get passwordMinLength => 'A jelszó legalább 6 karakter legyen';

  @override
  String get passwordsNotMatch => 'A jelszavak nem egyeznek';

  @override
  String get recoveryCode => 'Helyreállítási kód (6 számjegy)';

  @override
  String get recoveryCodeHelper =>
      'Jegyezze meg ezt a kódot a jelszó helyreállításához';

  @override
  String get recoveryCodeHint => 'Adja meg a helyreállítási kódot';

  @override
  String get recoveryCodeInvalid => 'A kód pontosan 6 számjegyből álljon';

  @override
  String get loginFailed => 'Bejelentkezés sikertelen';

  @override
  String get registrationFailed => 'Regisztráció sikertelen';

  @override
  String connectionError(String error) {
    return 'Kapcsolódási hiba: $error';
  }

  @override
  String registrationSuccess(String memberNumber) {
    return 'Sikeres regisztráció!\n\nTagsági száma: $memberNumber\n\nJegyezze meg ezt a számot a bejelentkezéshez.';
  }

  @override
  String get tooManyDevices => 'Túl sok eszköz';

  @override
  String get maxDevicesMessage =>
      'Már 3 eszközön van bejelentkezve.\nVálasszon egy eszközt a kijelentkezéshez:';

  @override
  String get unknownDevice => 'Ismeretlen eszköz';

  @override
  String get unknown => 'Ismeretlen';

  @override
  String get logoutError => 'Kijelentkezési hiba';

  @override
  String error(String error) {
    return 'Hiba: $error';
  }

  @override
  String get cancel => 'Mégse';

  @override
  String get resetPassword => 'Jelszó visszaállítása';

  @override
  String get forgotPasswordTitle => 'Elfelejtett jelszó';

  @override
  String get forgotPasswordDescription =>
      'Adja meg tagsági számát és a regisztrációkor létrehozott helyreállítási kódot.';

  @override
  String get passwordResetSuccess =>
      'Jelszó sikeresen visszaállítva!\n\nMost bejelentkezhet új jelszavával.';

  @override
  String get passwordResetFailed => 'Jelszó visszaállítása sikertelen';

  @override
  String get needHelp => 'Segítségre van szüksége?';

  @override
  String get helpQuestion =>
      'Probléma a bejelentkezéssel vagy regisztrációval?';

  @override
  String get helpDescription =>
      'Lépjen kapcsolatba velünk WhatsApp-on és írja le pontosan, mi nem működik. Amint lehet, válaszolunk!';

  @override
  String get whatsapp => 'WhatsApp';

  @override
  String get emailSubject => 'Kérdés az ICD360S alkalmazáson keresztül';

  @override
  String get whatsappMessage =>
      'Üdvözlöm, problémám van az ICD360S alkalmazással. ';

  @override
  String get imprint => 'Impresszum';

  @override
  String get privacy => 'Adatvédelmi nyilatkozat';

  @override
  String get statutes => 'Alapszabály';

  @override
  String get revocation => 'Elállási jog';

  @override
  String get cancellation => 'Lemondás';

  @override
  String get allRightsReserved => 'Minden jog fenntartva.';

  @override
  String get enterCredentials => 'Adja meg a tagsági számot és jelszót';

  @override
  String get appointments => 'Találkozók';

  @override
  String get tickets => 'Jegyek';

  @override
  String get liveChat => 'Élő Chat';

  @override
  String get notifications => 'Értesítések';

  @override
  String get myProfile => 'Profilom';

  @override
  String get logout => 'Kijelentkezés';

  @override
  String get goodMorning => 'Jó reggelt';

  @override
  String get goodDay => 'Jó napot';

  @override
  String get goodEvening => 'Jó estét';

  @override
  String get goodNight => 'Jó éjszakát';

  @override
  String get welcomeToICD => 'Üdvözöljük az ICD360S e.V-nél!';

  @override
  String get accountCreatedSuccessfully => 'Fiókja sikeresen létrehozva.';

  @override
  String get today => 'Ma';

  @override
  String get membershipFeeDue => 'Tagsági díj esedékes';

  @override
  String get pleaseTransferAnnualFee => 'Kérjük, utalja át az éves díjat.';

  @override
  String get newBadge => 'Új';

  @override
  String get close => 'Bezár';

  @override
  String get membership => 'Tagság';

  @override
  String get myAppointments => 'Találkozóim';

  @override
  String get appointmentsLoadingReady => 'Találkozók betöltése - API kész!';

  @override
  String get priority => 'Prioritás';

  @override
  String get messageLabel => 'Üzenet';

  @override
  String get createdOn => 'Létrehozva';

  @override
  String get handler => 'Kezelő';

  @override
  String get reportProblems => 'Problémák jelentése';

  @override
  String get reportProblem => 'Probléma jelentése';

  @override
  String get weRespondIn24Hours => 'Legfeljebb 24 órán belül válaszolunk!';

  @override
  String get everythingOk => 'Minden rendben!';

  @override
  String get haveProblemWeHelp => 'Van problémája?\nMi megoldjuk!';

  @override
  String get myMembership => 'Tagságom';

  @override
  String get managePersonalDataAndFee => 'Személyes adatok és díj kezelése';

  @override
  String get myAppointmentsTitle => 'Találkozóim';

  @override
  String get appointmentsDescription =>
      'Itt láthatja a közelgő találkozóit.\nMegerősítheti részvételét vagy elutasíthatja.';

  @override
  String get loadAppointments => 'Találkozók betöltése';

  @override
  String get myTickets => 'Jegyeim';

  @override
  String get newTicket => 'Új jegy';

  @override
  String get noOpenTickets => 'Nincsenek nyitott jegyek';

  @override
  String get haveQuestionCreateTicket =>
      'Van kérdése vagy problémája?\nHozzon létre egy új jegyet.';

  @override
  String get whatIsTheProblem => 'Mi a probléma?';

  @override
  String get describeTheProblem => 'Írja le a problémát';

  @override
  String get howUrgentIsIt => 'Mennyire sürgős?';

  @override
  String get low => 'Alacsony';

  @override
  String get medium => 'Közepes';

  @override
  String get high => 'Magas';

  @override
  String get submit => 'Küldés';

  @override
  String get fillSubjectAndMessage =>
      'Kérjük, töltse ki a tárgyat és az üzenetet';

  @override
  String get ticketCreated => 'Jegy létrehozva';

  @override
  String get errorCreatingTicket => 'Hiba a jegy létrehozásakor';

  @override
  String get verified => 'Ellenőrizve';

  @override
  String get account => 'Fiók';

  @override
  String get myDevices => 'Eszközeim';

  @override
  String get changeEmail => 'E-mail módosítása';

  @override
  String get changePassword => 'Jelszó módosítása';

  @override
  String get newEmailAddress => 'Új e-mail cím';

  @override
  String get currentPassword => 'Jelenlegi jelszó';

  @override
  String get saveEmail => 'E-mail mentése';

  @override
  String get savePassword => 'Jelszó mentése';

  @override
  String get deviceLoggedOut => 'Eszköz kijelentkeztetve';

  @override
  String get passwordChangedSuccessfully => 'Jelszó sikeresen módosítva';

  @override
  String get emailChangedSuccessfully => 'E-mail sikeresen módosítva';

  @override
  String get errorChangingPassword => 'Hiba a jelszó módosításakor';

  @override
  String get errorChangingEmail => 'Hiba az e-mail módosításakor';

  @override
  String get validEmailRequired => 'Kérjük, adjon meg érvényes e-mail címet';

  @override
  String get passwordTooShort =>
      'A jelszónak legalább 6 karakter hosszúnak kell lennie';

  @override
  String get maxDevicesReached =>
      'Ön a maximális 3 eszközön van bejelentkezve.';

  @override
  String loggedInOnDevices(int count) {
    return 'Ön $count eszközön van bejelentkezve a 3-ból.';
  }

  @override
  String get noActiveSessions => 'Nincsenek aktív munkamenetek';

  @override
  String get logoutFromDevice => 'Kijelentkezés erről az eszközről';

  @override
  String get confirmLogoutDevice => 'Kijelentkezik az eszközről?';

  @override
  String get confirmLogoutMessage =>
      'Ki szeretne jelentkezni erről az eszközről?\n\nÚjra be kell jelentkeznie, hogy használja ezt az eszközt.';

  @override
  String get ipAddress => 'IP';

  @override
  String get platform => 'Platform';

  @override
  String trialWarningUrgentTitle(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days nap',
      one: '1 nap',
    );
    return 'Figyelem: Már csak $_temp0 van hátra a fiók felfüggesztéséig!';
  }

  @override
  String get trialWarningTitle => 'Fiókja még nincs ellenőrizve';

  @override
  String get trialWarningDescription =>
      'Kérjük, töltse ki adatait a \"Profilom\" menüpontban. 30 nap után fiókja automatikusan felfüggesztésre kerül.';

  @override
  String trialDaysRemaining(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days nap',
      one: '1 nap',
    );
    return '$_temp0';
  }

  @override
  String get overview => 'Áttekintés';

  @override
  String get member => 'Tag';

  @override
  String get memberManagement => 'Tagok kezelése';

  @override
  String get reportProblemTooltip => 'Probléma jelentése';

  @override
  String get newAppointmentsTitle => 'Új találkozók';

  @override
  String get youHaveNewAppointment => 'Új találkozója van.';

  @override
  String youHaveNewAppointments(int count) {
    return '$count új találkozója van.';
  }

  @override
  String get appointmentReminderTomorrow => 'Emlékeztető: Találkozó holnap';

  @override
  String tomorrowAppointment(String title) {
    return 'Holnap: $title';
  }

  @override
  String youHaveTomorrowAppointments(int count) {
    return '$count találkozója van holnap.';
  }

  @override
  String get appointmentsToday => 'Mai találkozók';

  @override
  String todayAppointment(String title) {
    return 'Ma: $title';
  }

  @override
  String youHaveTodayAppointments(int count) {
    return '$count találkozója van ma.';
  }

  @override
  String get paymentReminder => 'Fizetési emlékeztető';

  @override
  String paymentReminderMessage(int day, String method) {
    return 'Ma van a hónap $day. napja – kérjük, teljesítse $method.';
  }

  @override
  String get paymentDayLabel => 'Fizetési nap (havi emlékeztető)';

  @override
  String get updateAvailable => 'Frissítés elérhető';

  @override
  String newVersionAvailable(String version) {
    return 'Új verzió érhető el: $version';
  }

  @override
  String currentVersionLabel(String version) {
    return 'Jelenlegi verzió: $version';
  }

  @override
  String get changes => 'Változások:';

  @override
  String downloadProgress(String percent) {
    return 'Letöltés: $percent%';
  }

  @override
  String get installationStarting => 'Telepítés indítása...';

  @override
  String get appWillRestart => 'Az alkalmazás automatikusan újraindul.';

  @override
  String get later => 'Később';

  @override
  String get updateNow => 'Frissítés most';

  @override
  String get downloading => 'Letöltés...';

  @override
  String get downloadFailed =>
      'A letöltés sikertelen. Kérjük, próbálja újra később.';

  @override
  String get searchingForUpdates => 'Frissítések keresése...';

  @override
  String get appUpToDate => 'Az alkalmazás naprakész';

  @override
  String get updateCheckError => 'Hiba a frissítés ellenőrzésekor';

  @override
  String get changelog => 'Változásnapló';

  @override
  String get terminConfirmed => 'Időpont megerősítve';

  @override
  String get terminDeclined => 'Időpont elutasítva';

  @override
  String get terminRescheduleRequested => 'Átütemezés kérve';

  @override
  String get statusConfirmed => 'Megerősítve';

  @override
  String get statusDeclined => 'Elutasítva';

  @override
  String get statusRescheduling => 'Átütemezés';

  @override
  String get statusPending => 'Függőben';

  @override
  String get categoryVorstandssitzung => 'Igazgatósági ülés';

  @override
  String get categoryMitgliederversammlung => 'Közgyűlés';

  @override
  String get categorySchulung => 'Képzés';

  @override
  String get categorySonstiges => 'Egyéb';

  @override
  String openCount(int count) {
    return '$count nyitott';
  }

  @override
  String get refresh => 'Frissítés';

  @override
  String get filterUpcoming => 'Közelgő';

  @override
  String get filterPast => 'Elmúlt';

  @override
  String get filterAll => 'Összes';

  @override
  String get noUpcomingAppointments => 'Nincsenek közelgő időpontok';

  @override
  String get noPastAppointments => 'Nincsenek elmúlt időpontok';

  @override
  String get noAppointmentsAvailable => 'Nincsenek időpontok';

  @override
  String get appointmentsShownHere => 'Időpontjai itt jelennek meg';

  @override
  String get dateLabel => 'Dátum';

  @override
  String get timeLabel => 'Idő';

  @override
  String get locationLabel => 'Helyszín';

  @override
  String get createdByLabel => 'Létrehozta';

  @override
  String get descriptionLabel => 'Leírás';

  @override
  String get ticketLabel => 'Jegy';

  @override
  String get yourStatus => 'Az Ön állapota: ';

  @override
  String reasonLabel(String reason) {
    return 'Ok: $reason';
  }

  @override
  String durationMinutes(int minutes) {
    return '$minutes perc';
  }

  @override
  String get confirm => 'Megerősítés';

  @override
  String get decline => 'Elutasítás';

  @override
  String get reschedule => 'Átütemezés';

  @override
  String get requestReschedule => 'Átütemezés kérése';

  @override
  String appointmentLabel(String title) {
    return 'Időpont: $title';
  }

  @override
  String get rescheduleReason => 'Átütemezés oka *';

  @override
  String get rescheduleReasonHint => 'Kérjük adja meg az okot...';

  @override
  String get pleaseProvideReason => 'Kérjük adja meg az okot';

  @override
  String get request => 'Kérés';

  @override
  String get ticketStatusOpen => 'Nyitott';

  @override
  String get ticketStatusInProgress => 'Folyamatban';

  @override
  String get ticketStatusWaitingMember => 'Tagra vár';

  @override
  String get ticketStatusWaitingStaff => 'Munkatársra vár';

  @override
  String get ticketStatusWaitingAuthority => 'Hatóságra vár';

  @override
  String get ticketStatusDone => 'Kész';

  @override
  String get ticketPriorityHigh => 'Magas';

  @override
  String get ticketPriorityMedium => 'Közepes';

  @override
  String get ticketPriorityLow => 'Alacsony';

  @override
  String get comments => 'Hozzászólások';

  @override
  String get documents => 'Dokumentumok';

  @override
  String get details => 'Részletek';

  @override
  String get replySent => 'Válasz elküldve';

  @override
  String get sendError => 'Küldési hiba';

  @override
  String get uploading => 'Feltöltés...';

  @override
  String fileUploaded(String filename) {
    return '$filename feltöltve';
  }

  @override
  String get uploadFailed => 'Feltöltés sikertelen';

  @override
  String get openError => 'Megnyitási hiba';

  @override
  String get noRepliesYet => 'Még nincs válasz';

  @override
  String get waitingForSupport => 'Várakozás a támogatás válaszára';

  @override
  String get writeReply => 'Válasz írása...';

  @override
  String get attachFile => 'Fájl csatolása';

  @override
  String documentsCount(int count) {
    return 'Dokumentumok ($count)';
  }

  @override
  String get upload => 'Feltöltés';

  @override
  String get noDocuments => 'Nincsenek dokumentumok';

  @override
  String get allowedFormats =>
      'Engedélyezett formátumok: PDF, JPEG, JPG, TXT, ZIP';

  @override
  String get yourMessage => 'Az Ön üzenete:';

  @override
  String get translation => 'Fordítás';

  @override
  String get original => 'Eredeti';

  @override
  String get originalText => 'Eredeti szöveg';

  @override
  String get autoTranslated => 'Automatikusan fordítva';

  @override
  String get originalTapTranslation => 'Eredeti · Koppintson a fordításhoz';

  @override
  String get translatedTapOriginal => 'Fordítva · Koppintson az eredetihez';

  @override
  String get justNow => 'Most';

  @override
  String minutesAgo(int minutes) {
    return '$minutes perce';
  }

  @override
  String hoursAgo(int hours) {
    return '$hours órája';
  }

  @override
  String daysAgo(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'napja',
      one: 'napja',
    );
    return '$days $_temp0';
  }

  @override
  String get createdLabel => 'Létrehozva';

  @override
  String get updatedLabel => 'Frissítve';

  @override
  String get handlerLabel => 'Felelős';

  @override
  String get doneLabel => 'Kész';

  @override
  String get newTicketTitle => 'Új jegy';

  @override
  String get categoryOptional => 'Kategória (opcionális)';

  @override
  String get selectCategory => 'Válasszon';

  @override
  String get subjectLabel => 'Tárgy';

  @override
  String get fillAllFields => 'Töltse ki az összes mezőt';

  @override
  String ticketCreatedId(int id) {
    return 'Jegy #$id létrehozva';
  }

  @override
  String get priorityLabel => 'Prioritás: ';

  @override
  String get supportOffline => 'Támogatás offline';

  @override
  String get lastSeenSeconds => 'Néhány másodperce aktív';

  @override
  String lastSeenMinutes(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: 'perce',
      one: 'perce',
    );
    return '$minutes $_temp0 aktív';
  }

  @override
  String lastSeenHours(int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: 'órája',
      one: 'órája',
    );
    return '$hours $_temp0 aktív';
  }

  @override
  String lastSeenDays(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'napja',
      one: 'napja',
    );
    return '$days $_temp0 aktív';
  }

  @override
  String get online => 'Online';

  @override
  String get callSupport => 'Hívás';

  @override
  String get typeMessage => 'Írjon üzenetet...';

  @override
  String get callBusy => 'A támogatás foglalt';

  @override
  String get callRejected => 'Hívás elutasítva';

  @override
  String get callFailed => 'Hívás sikertelen';

  @override
  String get callEnded => 'Hívás befejeződött';

  @override
  String get callSupportBusy => 'A támogatás már másik hívásban van';

  @override
  String get errorStartingChat => 'Hiba a chat indításakor';

  @override
  String get errorStartingCall => 'Hiba a hívás indításakor';

  @override
  String get errorConnecting => 'Csatlakozási hiba';

  @override
  String get errorAcceptingCall => 'Hiba a hívás fogadásakor';

  @override
  String get errorDownloading => 'Letöltési hiba';

  @override
  String get errorUploading => 'Feltöltési hiba';

  @override
  String get errorSending => 'Küldési hiba';

  @override
  String get errorPickingPhotos => 'Hiba a fotók kiválasztásakor';

  @override
  String get errorPickingFiles => 'Hiba a fájlok kiválasztásakor';

  @override
  String get errorTakingPhoto => 'Hiba a fotó készítésekor';

  @override
  String get fileNotLoaded => 'A fájl nem tölthető be';

  @override
  String get attachmentIdMissing => 'Melléklet ID hiányzik';

  @override
  String get camera => 'Kamera';

  @override
  String get gallery => 'Galéria';

  @override
  String get file => 'Fájl';

  @override
  String typingIndicator(String name) {
    return '$name gépel...';
  }

  @override
  String get notifNewMessageFrom => 'Új üzenet tőle:';

  @override
  String get notifUrgentPrefix => 'SÜRGŐS';

  @override
  String get notifUrgentMessage => 'SÜRGŐS ÜZENET';

  @override
  String get notifIncomingCall => 'Bejövő hívás';

  @override
  String get notifCallingYou => 'hív...';

  @override
  String get notifUpdateAvailable => 'Frissítés elérhető';

  @override
  String get notifVersionAvailable => 'már elérhető';

  @override
  String get notifConnected => 'Csatlakozva';

  @override
  String get notifDisconnected => 'Szétkapcsolva';

  @override
  String get notifConnectedBody => 'Csatlakozva a szerverhez.';

  @override
  String get notifDisconnectedBody => 'A szerverrel való kapcsolat megszakadt.';

  @override
  String get notifError => 'Hiba';

  @override
  String get retry => 'Újra';

  @override
  String get save => 'Mentés';

  @override
  String get accept => 'Elfogadás';

  @override
  String get selectFile => 'Fájl kiválasztása';

  @override
  String get dataLoadingText => 'Adatok betöltése...';

  @override
  String get dataSavedSuccess => 'Adatok sikeresen mentve';

  @override
  String get errorSaving => 'Mentési hiba';

  @override
  String get errorLoading => 'Betöltési hiba';

  @override
  String savedFilename(String filename) {
    return 'Mentve: $filename';
  }

  @override
  String get logsCopied => 'Naplók másolva!';

  @override
  String get diagnosticDataTitle => 'Diagnosztikai adatok';

  @override
  String get diagnosticDescription =>
      'Szeretne névtelen diagnosztikai adatokat küldeni az alkalmazás javítása érdekében?';

  @override
  String get noThanks => 'Nem, köszönöm';

  @override
  String get yesEnable => 'Igen, engedélyezés';

  @override
  String get passwordMinEightChars =>
      'A jelszónak legalább 8 karakterből kell állnia';

  @override
  String get passwordChangeSuccess => 'Jelszó sikeresen módosítva';

  @override
  String get emailChangeError => 'Hiba az e-mail módosításakor';

  @override
  String get acceptDocumentCheckbox =>
      'Elolvastam és elfogadom a dokumentumot.';

  @override
  String loadingErrorGeneric(String details) {
    return 'Betöltési hiba: $details';
  }

  @override
  String get incomingCallTitle => 'Bejövő hívás';

  @override
  String ringingFor(int seconds) {
    return 'Csörög ${seconds}mp';
  }

  @override
  String get rejectCall => 'Elutasítás';

  @override
  String get acceptCall => 'Fogadás';

  @override
  String get unmute => 'Némítás feloldása';

  @override
  String get mute => 'Némítás';

  @override
  String get hangUp => 'Letesz';

  @override
  String get calling => 'Hívás...';

  @override
  String autoRejectIn(int seconds) {
    return 'Automatikus elutasítás $seconds másodperc múlva';
  }

  @override
  String get speakerOn => 'Hangszóró';

  @override
  String get speakerOff => 'Fülhallgató';

  @override
  String get micMuted => 'Némítva';

  @override
  String get micOn => 'Mikrofon';

  @override
  String get connectionExcellent => 'Kiváló';

  @override
  String get connectionGood => 'Jó';

  @override
  String get connectionWeak => 'Gyenge';

  @override
  String get connectionLost => 'Megszakadt';

  @override
  String get personalData => 'Személyes adatok';

  @override
  String get personalDataSubtitle => 'Név, vezetéknév, cím';

  @override
  String get membershipFee => 'Tagsági díj';

  @override
  String annualFeeYear(String year) {
    return 'Éves díj $year';
  }

  @override
  String get amount => 'Összeg:';

  @override
  String get dueBy => 'Határidő:';

  @override
  String get paid => 'Fizetve';

  @override
  String get versionHistory => 'Verziótörténet';

  @override
  String lastUpdated(String date) {
    return 'Utolsó frissítés: $date';
  }

  @override
  String get noVersionHistory => 'Nincs verziótörténet';

  @override
  String get failedLoadChangelog => 'A változásnapló betöltése sikertelen';

  @override
  String get callMember => 'Tag hívása';

  @override
  String get closeConversation => 'Beszélgetés lezárása';

  @override
  String get chatOffline => 'Offline';

  @override
  String get attachFiles => 'Fájlok csatolása (max. 10, 50MB)';

  @override
  String get conversationClosed => 'Ez a beszélgetés lezárásra került';

  @override
  String get noMessages => 'Nincs üzenet';

  @override
  String get goBack => 'Vissza';

  @override
  String get goForward => 'Előre';

  @override
  String get homePage => 'Főoldal';

  @override
  String get firstNameLabel => 'Keresztnév';

  @override
  String get lastNameLabel => 'Vezetéknév';

  @override
  String get streetLabel => 'Utca';

  @override
  String get houseNumberLabel => 'Hsz.';

  @override
  String get postalCodeLabel => 'Irányítószám';

  @override
  String get cityLabel => 'Város';

  @override
  String get phoneMobileLabel => 'Telefon (Mobil)';

  @override
  String get phoneLandlineLabel => 'Telefon (Vezetékes)';

  @override
  String get newEmailLabel => 'Új e-mail cím';

  @override
  String get currentPasswordLabel => 'Jelenlegi jelszó';

  @override
  String get newPasswordLabel => 'Új jelszó';

  @override
  String get confirmPasswordLabel => 'Jelszó megerősítése';

  @override
  String get emailChangedSuccess => 'E-mail sikeresen módosítva';

  @override
  String get newPasswordMinChars => 'Új jelszó (min. 6 karakter)';

  @override
  String get reasonLabel2 => 'Ok';

  @override
  String get downloadFailed2 => 'Letöltés sikertelen';

  @override
  String get downloadTooltip => 'Letöltés';

  @override
  String get connectionErrorGeneric => 'Kapcsolódási hiba';

  @override
  String get copyLogs => 'Naplók másolása';

  @override
  String get deleteLogs => 'Naplók törlése';

  @override
  String get autoScrollOn => 'Automatikus görgetés BE';

  @override
  String get autoScrollOff => 'Automatikus görgetés KI';

  @override
  String get unknownValue => 'Ismeretlen';

  @override
  String get bankTransfer => 'Banki átutalás';

  @override
  String get standingOrder => 'Állandó megbízás';

  @override
  String get payment => 'Fizetés';

  @override
  String get warningType_ermahnung => 'Figyelmeztetés';

  @override
  String get warningType_abmahnung => 'Megrovás';

  @override
  String get warningType_letzte => 'Utolsó figyelmeztetés';

  @override
  String warningsTotal(int count) {
    return 'Összesen: $count';
  }

  @override
  String warningsErmahnung(int count) {
    return 'Figyelmeztetések: $count';
  }

  @override
  String warningsAbmahnung(int count) {
    return 'Megrovások: $count';
  }

  @override
  String warningsLetzte(int count) {
    return 'Utolsó: $count';
  }

  @override
  String get noWarnings => 'Nincs figyelmeztetés';

  @override
  String get noWarningsDescription => 'Jelenleg nincs figyelmeztetése.';

  @override
  String createdBy(String name) {
    return 'Létrehozta: $name';
  }

  @override
  String get monthJan => 'Jan';

  @override
  String get monthFeb => 'Feb';

  @override
  String get monthMar => 'Mar';

  @override
  String get monthApr => 'Apr';

  @override
  String get monthMay => 'Maj';

  @override
  String get monthJun => 'Jun';

  @override
  String get monthJul => 'Jul';

  @override
  String get monthAug => 'Aug';

  @override
  String get monthSep => 'Sze';

  @override
  String get monthOct => 'Okt';

  @override
  String get monthNov => 'Nov';

  @override
  String get monthDec => 'Dec';

  @override
  String get stufe1_name => 'Személyes adatok';

  @override
  String get stufe2_name => 'Tagság típusa';

  @override
  String get stufe3_name => 'Pénzügyi helyzet';

  @override
  String get stufe4_name => 'Fizetési mód';

  @override
  String get stufe5_name => 'Tagság kezdete';

  @override
  String get stufe6_name => 'Alapszabály';

  @override
  String get stufe7_name => 'Adatvédelmi irányelvek';

  @override
  String get stufe8_name => 'Elállási jog';

  @override
  String get memberType_ordentlich => 'Rendes tag';

  @override
  String get memberType_foerder => 'Támogató tag';

  @override
  String get memberType_ehren => 'Tiszteletbeli tag';

  @override
  String get memberDesc_ordentlich =>
      'Aktív tag szavazati joggal. Részt vesz az egyesület szolgáltatásaiban (email, felhő, ügyintézési támogatás).';

  @override
  String get memberDesc_foerder =>
      'Hozzájárulásokkal támogatja az egyesületet. Részt vehet a közgyűlésen tanácskozási joggal, szavazati jog vagy választhatóság nélkül.';

  @override
  String get memberDesc_ehren =>
      'Rendes tag jogaival rendelkezik tagdíjfizetési kötelezettség nélkül. A közgyűlés vagy az elnökség nevezi ki.';

  @override
  String get payMethod_ueberweisung => 'Banki átutalás';

  @override
  String get payMethod_dauerauftrag => 'Állandó megbízás';

  @override
  String get verifyStatus_geprueft => 'Ellenőrizve';

  @override
  String get verifyStatus_ausgefuellt => 'Kitöltve';

  @override
  String get verifyStatus_abgelehnt => 'Elutasítva';

  @override
  String get verifyStatus_offen => 'Nyitott';

  @override
  String get fillRequiredFields => 'Töltse ki az összes kötelező mezőt.';

  @override
  String get personalDataSaved => 'Személyes adatok mentve';

  @override
  String get selectMemberType => 'Válasszon tagsági típust.';

  @override
  String get memberTypeSaved => 'Tagsági típus mentve';

  @override
  String get selectOption => 'Válasszon egy lehetőséget.';

  @override
  String get financialSaved => 'Pénzügyi helyzet mentve';

  @override
  String get selectPaymentMethod => 'Válasszon fizetési módot.';

  @override
  String get paymentDataSaved => 'Fizetési adatok mentve';

  @override
  String get selectDate => 'Válasszon dátumot.';

  @override
  String get membershipStartSaved => 'Tagság kezdete mentve';

  @override
  String get fileTooLarge => 'A fájl túl nagy (max. 10 MB).';

  @override
  String get leistungsbescheidUploaded =>
      'Juttatási határozat sikeresen feltöltve';

  @override
  String get verificationProgress => 'Ellenőrzés haladása';

  @override
  String get notApplicable => 'Nem alkalmazható';

  @override
  String get socialBenefitsExempt =>
      'Fizetési mód nem szükséges szociális juttatásban részesülők számára.';

  @override
  String get locked => 'Zárolva';

  @override
  String completePreviousStep(int step) {
    return 'Először végezze el a(z) $step. lépést.';
  }

  @override
  String rejectedNote(String note) {
    return 'Elutasítva: $note';
  }

  @override
  String get waitingForReview => 'Elnökségi felülvizsgálatra vár.';

  @override
  String get stepApproved => 'Ez a lépés ellenőrizve és jóváhagyva.';

  @override
  String get changesViaChat => 'Módosítások csak chaten keresztül.';

  @override
  String get firstNameRequired => 'Keresztnév *';

  @override
  String get lastNameRequired => 'Vezetéknév *';

  @override
  String get birthDateLabel => 'Születési dátum *';

  @override
  String get streetRequired => 'Utca *';

  @override
  String get houseNumberRequired => 'Hsz. *';

  @override
  String get cityRequired => 'Város *';

  @override
  String get phoneRequired => 'Telefonszám *';

  @override
  String get phonePurpose =>
      'Cél: Kapcsolatfelvétel, ha az alkalmazáson keresztül nem elérhető';

  @override
  String get selectMemberTypePrompt => 'Válassza ki a kívánt tagsági típust:';

  @override
  String get financialExplanation =>
      'A díjcsökkentésre való jogosultság ellenőrzéséhez a következő információkra van szükségünk. Ezek kizárólag a tagsági díj meghatározásához kerülnek felhasználásra.';

  @override
  String get socialBenefitsQuestion => 'Jelenleg kap szociális juttatásokat?';

  @override
  String get optionBuergergeld => 'Igen, állampolgári juttatás (Job Center)';

  @override
  String get optionSozialamt => 'Igen, szociális segély (Szociális Hivatal)';

  @override
  String get optionNoBenefits => 'Nem, nem kapok szociális juttatásokat';

  @override
  String get feeExempt => 'Az Ön havi díja: 0,00 €/hó';

  @override
  String get uploadLeistungsbescheid => 'Juttatási határozat feltöltése';

  @override
  String get uploadLeistungsbescheidHint =>
      'Töltse fel az aktuális juttatási határozatot 14 napon belül a díjmentesség megerősítéséhez.';

  @override
  String get allowedFormatsUpload =>
      'Engedélyezett formátumok: PDF, JPG, PNG (max. 10 MB)';

  @override
  String get feeRegular => 'Az Ön havi díja: 25,00 €/hó';

  @override
  String paymentDayReminder(int day) {
    return 'Emlékeztetőt kap minden hónap $day. napján.';
  }

  @override
  String get membershipStartPrompt => 'Válassza ki, mikor kezdődjön tagsága.';

  @override
  String get optionAfterVerification => 'Az ellenőrzés befejezése után';

  @override
  String get optionAfterVerificationDesc =>
      'A tagság az elnökségi jóváhagyás napjától kezdődik.';

  @override
  String get optionRetroFoundation =>
      'Visszamenőleg az alapítás dátumáig (2025.08.01.)';

  @override
  String get optionRetroFoundationDesc =>
      'Visszamenőleges taggá válik az egyesület alapításától.';

  @override
  String get optionRetroCustom => 'Visszamenőleg egy másik dátumig';

  @override
  String get optionRetroCustomDesc =>
      'Válasszon dátumot 2025.08.01. és a mai nap között.';

  @override
  String get selectDateLabel => 'Dátum kiválasztása';

  @override
  String get selectDateHint => 'Válasszon dátumot...';

  @override
  String get dateNotBefore => 'Nem korábbi, mint 2025.08.01. (alapítási dátum)';

  @override
  String get feeExemptRetro =>
      'Díjmentesség: 0,00 € visszamenőleg.\nCsak a tagsági dátum kerül visszamenőlegesen beállításra.';

  @override
  String get retroactiveFees => 'Visszamenőleges díjak';

  @override
  String retroFeeCalculation(
      String from, String to, String months, String total) {
    return 'Időszak: $from – $to\nHónapok: $months\nDíj: $months × 25,00 € = $total €';
  }

  @override
  String get pleaseReadSatzung => 'Olvassa el az egyesület alapszabályát.';

  @override
  String get pleaseReadDatenschutz => 'Olvassa el az adatvédelmi irányelveket.';

  @override
  String get pleaseReadWiderruf => 'Olvassa el az elállási jogot.';

  @override
  String get acceptedAtRegistration => 'Regisztrációkor elfogadva';

  @override
  String get confirmedByBoard =>
      'Az elnökség felülvizsgálata után kerül megerősítésre.';

  @override
  String get docSatzung => 'Alapszabály';

  @override
  String get docDatenschutz => 'Adatvédelmi irányelvek';

  @override
  String get docWiderruf => 'Elállási jog';

  @override
  String acceptedAtRegCount(int count) {
    return 'Regisztrációkor elfogadva ($count/3)';
  }

  @override
  String acceptedOn(String date) {
    return 'Elfogadva: $date';
  }

  @override
  String get notAccepted => 'Nem elfogadva';

  @override
  String get statusAccepted => 'Elfogadva';

  @override
  String get memberNumberTooLong => 'Tagsági szám túl hosszú (max 20 karakter)';

  @override
  String get onlyUppercaseAndNumbers =>
      'Csak nagybetűk és számok engedélyezettek';

  @override
  String get passwordTooLong => 'Jelszó túl hosszú (max 100 karakter)';

  @override
  String get nameTooLong => 'Név túl hosszú (max 100 karakter)';

  @override
  String get emailTooLong => 'E-mail túl hosszú (max 255 karakter)';

  @override
  String get legalAcknowledgePrefix => 'Megismertem az ';

  @override
  String get legalAcknowledgeSuffix => '.';

  @override
  String get legalStatutesSuffix =>
      ' az ICD360S e.V. alapszabályát és kötelező érvényűnek ismerem el.';

  @override
  String get legalPleaseReadFirst => '(kérjük, először olvassa el)';

  @override
  String get statusActive => 'Aktív';

  @override
  String get statusSuspended => 'Felfüggesztve';

  @override
  String get statusNew => 'Új';

  @override
  String get statusCancelled => 'Felmondva';

  @override
  String get statusDeleted => 'Törölve';

  @override
  String get roleMitglied => 'Tag';

  @override
  String get roleVorsitzer => 'Elnök';

  @override
  String get roleStellvertreter => 'Helyettes';

  @override
  String get roleSchatzmeister => 'Kincstárnok';

  @override
  String get roleSchriftfuehrer => 'Titkár';

  @override
  String get roleBeisitzer => 'Ülnök';

  @override
  String get roleKassierer => 'Pénztáros';

  @override
  String get roleKassenpruefer => 'Könyvvizsgáló';

  @override
  String get roleEhrenamtlich => 'Önkéntes';

  @override
  String get roleMitgliedergruender => 'Alapító Tag';

  @override
  String get roleEhrenmitglied => 'Tiszteletbeli Tag';

  @override
  String get roleFoerdermitglied => 'Támogató Tag';

  @override
  String get memberTypeNotSet => 'Még nincs meghatározva';

  @override
  String get payMethodSepa => 'SEPA beszedés';

  @override
  String get labelStatus => 'Állapot';

  @override
  String get labelMemberNumber => 'Tagsági szám';

  @override
  String get labelRole => 'Szerep';

  @override
  String get labelMemberType => 'Tagság típusa';

  @override
  String get labelPaymentMethod => 'Fizetési mód';

  @override
  String get labelRegisteredOn => 'Regisztrálva';

  @override
  String get labelLastLogin => 'Utolsó bejelentkezés';

  @override
  String get labelMemberSince => 'Tag azóta';

  @override
  String get neverLoggedIn => 'Soha';

  @override
  String get notActivatedYet => 'Még nincs aktiválva';

  @override
  String get tabVerification => 'Ellenőrzés';

  @override
  String get tabWarnings => 'Figyelmeztetések';

  @override
  String get tabDocuments => 'Dokumentumok';

  @override
  String get tabMembership => 'Tagság';

  @override
  String get pleaseEnterFirstName => 'Adja meg a keresztnevet';

  @override
  String get pleaseEnterLastName => 'Adja meg a vezetéknevet';

  @override
  String get noFileDataReceived => 'Nem érkeztek adatok';

  @override
  String get openFile => 'Megnyitás';

  @override
  String get diagnosticErrors => 'Hibajelentések fejlesztéshez';

  @override
  String get diagnosticAnonymousStats => 'Névtelen használati statisztikák';

  @override
  String get diagnosticPerformance => 'Alkalmazás teljesítményadatok';

  @override
  String get noMicrophoneError =>
      'Nem található mikrofon. Csatlakoztasson egy mikrofont és próbálja újra.';

  @override
  String get startConversation => 'Kezdjen egy beszélgetést!';

  @override
  String get staffWillReply => 'Egy munkatárs hamarosan válaszol.';

  @override
  String get inCall => 'Hívásban...';

  @override
  String get registration => 'Regisztráció';

  @override
  String get deactivation => 'Deaktiválás';

  @override
  String get deactivatedOn => 'Deaktiválva';

  @override
  String get accountAutoSuspend =>
      'A 30 napon belül nem ellenőrzött fiókok automatikusan felfüggesztésre kerülnek.';

  @override
  String get ipClean => 'IP tiszta - nem listázott';

  @override
  String get documentsProvidedByBoard =>
      'A dokumentumokat az elnökség biztosítja.';

  @override
  String get noDocumentsAvailable => 'Nincsenek dokumentumok';

  @override
  String get noDocumentsDescription =>
      'Még nem állítottak rendelkezésre dokumentumokat.';

  @override
  String uploadedBy(String name) {
    return 'Feltöltötte: $name';
  }

  @override
  String stepsCompleted(int completed, int total) {
    return '$completed/$total lépés kész';
  }

  @override
  String dayOfMonth(int day) {
    return 'Hónap $day. napja';
  }

  @override
  String changeField(String field) {
    return '$field módosítása';
  }

  @override
  String openDocument(String name) {
    return '$name megnyitása';
  }

  @override
  String get helpImproveApp =>
      'Szeretne segíteni az alkalmazás fejlesztésében?';

  @override
  String get noPersonalDataCollected =>
      'Személyes adatok nem kerülnek gyűjtésre. Ez a beállítás bármikor módosítható.';

  @override
  String logEntries(int count) {
    return '$count bejegyzés';
  }

  @override
  String get noLogs => 'Nincsenek naplók';

  @override
  String get newLoginDetected => 'Új bejelentkezés észlelve';

  @override
  String get waitingForMember => 'Tagra várakozás';

  @override
  String get waitingForStaff => 'Munkatársra várakozás';

  @override
  String get waitingForAuthority => 'Hatóságra várakozás';
}
