// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hungarian (`hu`).
class AppLocalizationsHu extends AppLocalizations {
  AppLocalizationsHu([String locale = 'hu']) : super(locale);

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
  String get confirmPassword => 'Jelszó megerősítése';

  @override
  String get confirmPasswordHint => 'Erősítse meg a jelszót';

  @override
  String get newPassword => 'Új jelszó';

  @override
  String get newPasswordHint => 'Adja meg az új jelszót';

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
  String get unknown => 'Ismeretlen';

  @override
  String error(String error) {
    return 'Hiba: $error';
  }

  @override
  String get cancel => 'Mégse';

  @override
  String get resetPassword => 'Jelszó visszaállítása';

  @override
  String get imprint => 'Impresszum';

  @override
  String get privacy => 'Adatvédelmi nyilatkozat';

  @override
  String get statutes => 'Alapszabály';

  @override
  String get revocation => 'Elállási jog';

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
  String get myAppointments => 'Találkozóim';

  @override
  String get priority => 'Prioritás';

  @override
  String get messageLabel => 'Üzenet';

  @override
  String get reportProblems => 'Problémák jelentése';

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
  String get low => 'Alacsony';

  @override
  String get high => 'Magas';

  @override
  String get submit => 'Küldés';

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
  String get saveEmail => 'E-mail mentése';

  @override
  String get savePassword => 'Jelszó mentése';

  @override
  String get deviceLoggedOut => 'Eszköz kijelentkeztetve';

  @override
  String get emailChangedSuccessfully => 'E-mail sikeresen módosítva';

  @override
  String get errorChangingPassword => 'Hiba a jelszó módosításakor';

  @override
  String get errorChangingEmail => 'Hiba az e-mail módosításakor';

  @override
  String get validEmailRequired => 'Kérjük, adjon meg érvényes e-mail címet';

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
  String get autoUpdateEnableTitle => 'Install future updates automatically';

  @override
  String get autoUpdateEnableHint =>
      'The app downloads and installs updates on its own and restarts briefly. No further prompts.';

  @override
  String autoUpdateInstalling(String version) {
    return 'Version $version is being installed in the background. The app will restart shortly.';
  }

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
  String get reasonLabel2 => 'Ok';

  @override
  String get downloadFailed2 => 'Letöltés sikertelen';

  @override
  String get downloadTooltip => 'Letöltés';

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
  String logEntries(int count) {
    return '$count bejegyzés';
  }

  @override
  String get noLogs => 'Nincsenek naplók';

  @override
  String get newLoginDetected => 'Új bejelentkezés észlelve';

  @override
  String get errorNoInternet =>
      'Nincs internetkapcsolat. Kérjük, ellenőrizze a hálózatát.';

  @override
  String get errorTimeout => 'A szerver nem válaszol. Kérjük, próbálja később.';

  @override
  String get errorServer => 'Szerverhiba. Kérjük, próbálja később.';

  @override
  String get errorConnection => 'Kapcsolódási hiba. Kérjük, próbálja később.';

  @override
  String get errorUnexpected =>
      'Váratlan hiba történt. Kérjük, próbálja később.';

  @override
  String get securityBannerTlsInterception =>
      'Your network is intercepting secure connections. Switch networks or disable VPN/antivirus.';

  @override
  String get securityBannerDnsFailure =>
      'DNS problem detected. Check your connection or try another network.';

  @override
  String get securityBannerSlowNetwork => 'Slow connection.';

  @override
  String get securityPermissionDialogTitle =>
      'Possible network attack detected';

  @override
  String get securityPermissionDialogBody =>
      'Something on your network may be intercepting connections. To identify the network and protect you, we need permission to read the WiFi name. No location tracking.';

  @override
  String get securityPermissionDialogAllow => 'Allow';

  @override
  String get securityPermissionDialogDeny => 'Not now';

  @override
  String get callErrorMicPermissionDenied =>
      'Microphone access is blocked. Enable it in Windows Settings → Privacy → Microphone (or your system\'s privacy settings), then try again.';

  @override
  String get callErrorMicNotFound =>
      'No microphone was found. Connect a headset or microphone and try again.';

  @override
  String get claudiuWelcomeMorning => 'Jó reggelt';

  @override
  String get claudiuWelcomeDay => 'Jó napot';

  @override
  String get claudiuWelcomeEvening => 'Jó estét';

  @override
  String get claudiuWelcomeNight => 'Jó estét';

  @override
  String get claudiuWelcomeVisitor => 'kedves látogató';

  @override
  String get claudiuWelcomeAsk => 'Hogyan segíthetek?';

  @override
  String get claudiuWelcomeBecomeMember => 'Tag szeretnék lenni';

  @override
  String get claudiuWelcomeLogin =>
      'Már tag vagyok és be szeretnék jelentkezni';

  @override
  String get claudiuWelcomeProblem => 'Problémám van az alkalmazással';

  @override
  String get claudiuWelcomeEmergency => 'Sürgős — hívjon minket';

  @override
  String get claudiuWelcomeMascotName => 'Claudiu';

  @override
  String get claudiuWelcomeEmergencyIntro =>
      'Mielőtt felhívnál — nyitvatartásunk:';

  @override
  String get claudiuWelcomeScheduleOffice => 'Az irodában';

  @override
  String get claudiuWelcomeScheduleField => 'Terepen ügyfelekkel';

  @override
  String get claudiuWelcomeOutsideHoursNote =>
      'Ezen időszakon kívül csak sürgős ügyeket intézünk. SMS-t is küldhetsz ugyanerre a számra — visszahívunk.';

  @override
  String get claudiuWelcomeCallNow => 'Hívj most';

  @override
  String get claudiuWelcomeSendSms => 'SMS küldése';

  @override
  String get claudiuWelcomeSmsBody =>
      'Sürgős ICD360S e.V. — kérem, vegye fel velem a kapcsolatot mielőbb.';

  @override
  String get claudiuWelcomeCloseButton => 'Bezárás';

  @override
  String get claudiuLoginWelcome => 'Üdv újra, kedves tag!';

  @override
  String get claudiuLoginAsk => 'Kérlek, mondd a tagsági számodat.';

  @override
  String get claudiuLoginProgress => 'Mindjárt… írj tovább.';

  @override
  String get claudiuLoginReady => 'Tökéletes! Nyomd meg az alábbi gombot.';

  @override
  String get claudiuLoginLoading => 'Ellenőrzöm a személyazonosságot… 🔍';

  @override
  String get claudiuLoginFoundPlain => 'Megtaláltalak! Bejelentkezés…';

  @override
  String claudiuLoginFoundNamed(String name) {
    return 'Megtaláltalak, $name! Bejelentkezés…';
  }

  @override
  String get claudiuLoginError =>
      'Hm, ezt a számot nem találom. Helyesen írtad be?';

  @override
  String get claudiuLoginForgotHeader => 'Elfelejtetted a tagsági számodat?';

  @override
  String get claudiuLoginNoSms =>
      'A számot nem küldjük e-mailben vagy SMS-ben.';

  @override
  String get claudiuLoginOnlyWay =>
      'Egyetlen mód: személyes találkozó az egyesület irodájában, személyi igazolvány ellenőrzésével.';

  @override
  String get claudiuLoginContactUs => 'Hívj minket időpontért:';

  @override
  String get claudiuDiagnosticGreeting => 'Mielőtt belépnél, egy gyors kérdés';

  @override
  String get claudiuDiagnosticAsk =>
      'Küldhetek névtelen jelentéseket, hogy a fejlesztők javíthassák az alkalmazást?';

  @override
  String get claudiuDiagnosticYes => 'Igen, segíteni szeretnék';

  @override
  String get claudiuDiagnosticNo => 'Nem, csak nézelődöm';

  @override
  String get claudiuDiagnosticTellMore => 'Mondj többet';

  @override
  String get claudiuDiagnosticSendsHeader => '📤 Amit KÜLDÜNK (anonim):';

  @override
  String get claudiuDiagnosticSends1 => 'Anonim eszközkód (NEM a tagsági szám)';

  @override
  String get claudiuDiagnosticSends2 => 'Szereped (tag / elnökség)';

  @override
  String get claudiuDiagnosticSends3 =>
      'Operációs rendszer (Linux / Android / iOS / Windows)';

  @override
  String get claudiuDiagnosticSends4 => 'Választott nyelv';

  @override
  String get claudiuDiagnosticSends5 => 'Akkumulátor szintje és állapota';

  @override
  String get claudiuDiagnosticSends6 => 'Aktuális képernyő';

  @override
  String get claudiuDiagnosticSends7 => 'Munkamenet hossza (másodperc)';

  @override
  String get claudiuDiagnosticSends8 => 'Hibák, ha vannak (utolsó 10)';

  @override
  String get claudiuDiagnosticSends9 => 'Navigáció (utolsó 20 képernyő)';

  @override
  String get claudiuDiagnosticNeverHeader => '🛡️ Amit SOHA nem küldünk:';

  @override
  String get claudiuDiagnosticNever1 => 'Az igazi neved';

  @override
  String get claudiuDiagnosticNever2 => 'E-mail cím';

  @override
  String get claudiuDiagnosticNever3 => 'Telefonszám';

  @override
  String get claudiuDiagnosticNever4 => 'Jelszó';

  @override
  String get claudiuDiagnosticNever5 => 'Csevegő üzenetek tartalma';

  @override
  String get claudiuDiagnosticNever6 => 'Jegyek tartalma';

  @override
  String get claudiuDiagnosticNever7 => 'Dokumentumok vagy mellékletek';

  @override
  String get claudiuDiagnosticTechHeader => '📡 Technikai részletek:';

  @override
  String get claudiuDiagnosticTech1 => '2 percenként küldve';

  @override
  String get claudiuDiagnosticTech2 =>
      'TLS-titkosított kapcsolat, rögzített tanúsítvánnyal';

  @override
  String get claudiuDiagnosticTech3 =>
      'Bármikor kikapcsolhatod a Beállításokban';

  @override
  String get claudiuProblemHelpTitle => 'Hogyan segíthetek?';

  @override
  String get claudiuProblemHelpGreeting => 'Mi történt?';

  @override
  String get claudiuProblemHelpAsk => 'Hogyan szeretnéd elmondani?';

  @override
  String get claudiuProblemHelpWriteTitle => 'Jelentés írása';

  @override
  String get claudiuProblemHelpWriteBody =>
      'Lépésről lépésre részletekkel. A csapat megkapja a szöveget és később megoldja.';

  @override
  String get claudiuProblemHelpChatTitle => 'Beszéljünk most';

  @override
  String get claudiuProblemHelpChatBody =>
      'Anonim csevegés egy ügyintézővel. Valós idejű válasz, ha valaki online.';

  @override
  String get claudiuProblemHelpAltCallHeader => 'Vagy, ha sürgős:';

  @override
  String get claudiuProblemHelpAltCallLabel => 'Hívj minket';

  @override
  String get claudiuAnonymousChatTitle => 'Anonim csevegés';

  @override
  String get claudiuAnonymousChatGreeting => 'Szia!';

  @override
  String get claudiuAnonymousChatWelcome =>
      'Hallgatlak. Írj bármit — név sem kell. Válaszolok, amint itt vagyok.';

  @override
  String get claudiuAnonymousChatHint => 'Írj egy üzenetet…';

  @override
  String get claudiuAnonymousChatWaitingOperator =>
      'Várjuk, hogy egy ügyintéző válaszoljon…';

  @override
  String get claudiuVorsitzerConnectedTitle => 'Szia!';

  @override
  String get claudiuVorsitzerConnectedBody =>
      'Köszönjük, hogy írtál — most egy Vorsitzerrel vagy kapcsolatban. Mondd el, miben segíthetünk a tagsági kérelmeddel.';

  @override
  String get claudiuVorsitzerConnectedSender => 'Vorsitzer';

  @override
  String get claudiuQuickReplyValidationTime =>
      'Mennyi ideig tart az ellenőrzés?';

  @override
  String get claudiuQuickReplyDocuments =>
      'Milyen dokumentumokra van szükségem?';

  @override
  String get claudiuQuickReplyStepProblem => 'Elakadtam egy lépésnél';

  @override
  String get claudiuQuickReplyHuman => 'Beszélhetek most valakivel?';

  @override
  String get claudiuAnonymousChatConnecting => 'Csatlakozás…';

  @override
  String get claudiuAnonymousChatConnectionFailed =>
      'Nem sikerült megnyitni a csevegést. Próbáld újra vagy hívj minket.';

  @override
  String get claudiuAnonymousChatRetry => 'Próbáld újra';

  @override
  String get claudiuAnonymousChatOnline => 'Csatlakozva';

  @override
  String get claudiuAnonymousChatOffline => 'Újracsatlakozás…';

  @override
  String get claudiuAnonymousChatAdminTyping => 'Az ügyintéző gépel…';

  @override
  String get claudiuProblemReportTitle => 'Probléma jelentése';

  @override
  String get claudiuProblemReportGreeting => 'Mi történt?';

  @override
  String get claudiuProblemReportAsk =>
      'Mondd el részletesen, és továbbítom a jelentést a csapatnak.';

  @override
  String get claudiuProblemReportIncludeHeader => 'Kérlek, tartalmazza:';

  @override
  String get claudiuProblemReportIncludeBullets1 =>
      'Mit csináltál, amikor a probléma jelentkezett';

  @override
  String get claudiuProblemReportIncludeBullets2 =>
      'Bármilyen hibaüzenet, amit láttál';

  @override
  String get claudiuProblemReportIncludeBullets3 => 'Melyik képernyőn voltál';

  @override
  String get claudiuProblemReportIncludeBullets4 =>
      'Az alkalmazás összeomlik, bezárul vagy üres képernyőt mutat?';

  @override
  String get claudiuProblemReportIncludeBullets5 =>
      'Mindig megtörténik vagy csak egyszer?';

  @override
  String get claudiuProblemReportDescriptionLabel => 'Leírásod';

  @override
  String get claudiuProblemReportDescriptionHint =>
      'Pl.: Amikor megnyitom a csevegő képernyőt, „Connection error\" üzenet jön és az alkalmazás nem válaszol…';

  @override
  String claudiuProblemReportTooShort(int count) {
    return 'Egy kicsit részletesebben kérlek (legalább $count karakter)';
  }

  @override
  String get claudiuProblemReportSubmit => 'Jelentés küldése';

  @override
  String get claudiuProblemReportSubmitting => 'Küldés…';

  @override
  String get claudiuProblemReportSentTitle => 'Köszönöm!';

  @override
  String get claudiuProblemReportSentBody =>
      'A jelentést elküldtük. Csapatunk a lehető leghamarabb megnézi.';

  @override
  String get claudiuProblemReportSentClose => 'Értem';

  @override
  String get claudiuProblemReportSendFailed =>
      'Nem sikerült elküldeni a jelentést. Hívj minket sürgős segítségért.';

  @override
  String get claudiuProblemReportAlt => 'Vagy, ha sürgős:';

  @override
  String get claudiuProblemReportCallLabel => 'Hívj minket';

  @override
  String claudiuApprovalGreeting(String name) {
    return 'Szia, $name! 👋';
  }

  @override
  String get claudiuApprovalGreetingNoName => 'Szia! 👋';

  @override
  String get claudiuApprovalGladToSeeYou => 'Örülök, hogy itt vagy!';

  @override
  String get claudiuApprovalCheckingForSafety =>
      'A biztonságod érdekében egy Vorsitzer most ellenőrzi a bejelentkezési kérésedet. 🛡️';

  @override
  String get claudiuApprovalMonthlyExplain =>
      '💡 Ezt 30 naponta megtesszük, hogy biztosak legyünk, hogy tényleg te vagy. Olyan, mint egy biztonsági ellenőrzés — maximum 5 perc.';

  @override
  String get claudiuApprovalSuccess =>
      'Kész! 🎉 A Vorsitzer felismert. Bejelentkezés…';

  @override
  String get claudiuApprovalDenied =>
      'Hm, a Vorsitzer elutasította a kérésedet. 😔';

  @override
  String get claudiuApprovalDeniedHelp =>
      'Ha úgy gondolod, ez tévedés, kérlek hívj minket, hogy tisztázzuk.';

  @override
  String get claudiuApprovalExpired =>
      'Az 5 perc letelt, és a Vorsitzer nem válaszolt.';

  @override
  String get claudiuApprovalExpiredHelp =>
      'Hívj minket és helyben jóváhagyhatjuk a kérésedet. 📞';

  @override
  String get claudiuApprovalCallUs => 'Hívj minket';

  @override
  String get claudiuApprovalTryAgain => 'Próbáld újra';

  @override
  String get claudiuApprovalCancel => 'Mégse';

  @override
  String get claudiuApprovalClose => 'Bezárás';

  @override
  String get wizardIntroBubble1 =>
      'Szia, látogató! 👋 Köszönöm, hogy csatlakozni szeretnél a családunkhoz.';

  @override
  String get wizardIntroBubble2 =>
      'A nevem Claudiu. 2025 tavaszán világos vízióm volt: létrehozni egy egyesületet, amely segít a rászorulóknak — önkéntesen, szívből, felesleges bürokrácia nélkül. ❤️';

  @override
  String get wizardIntroBubble3 =>
      'Elkezdtem beszélni az ügyfelekkel, akiket meglátogattam. Elmondtam nekik az álmomat. És mindenki azt mondta: „Igen, csináljuk!\" 2025 júliusában találkoztunk — hat elszánt ember. Úgy döntöttünk, megalapítjuk az **ICD360S e.V.**-t Neu-Ulmban. 📍';

  @override
  String get wizardIntroBubble4 =>
      '**2025. augusztus 1-jén** az egyesület hivatalosan életre kelt — az Egyesületi Nyilvántartásban. A legszebb ajándékom. 🎂';

  @override
  String get wizardIntroBubble5 =>
      'Mit csinálunk? Segítünk menekülteknek, fogyatékossággal élőknek, gazdaságilag hátrányos helyzetűeknek, **gyermekeknek és fiataloknak** — adminisztrációs ügyekben, német nyelvtanulásban, lakhatásban, bevásárlásban, szociális ellátásokban. Vorstandunkban többségben vannak fogyatékossággal élő emberek — így a döntések valódi élettapasztalatból születnek. 🤝';

  @override
  String get wizardIntroBubble6 =>
      'Most te jössz. Iratkozzunk fel — körülbelül 5 percig tart. Lépésről lépésre megyünk, nem hagylak magadra. ✨';

  @override
  String get wizardIntroStart => 'Kezdjük';

  @override
  String get wizardBack => 'Vissza';

  @override
  String get wizardNext => 'Tovább';

  @override
  String wizardStepLabel(int step, int total, String title) {
    return '$step. lépés / $total · $title';
  }

  @override
  String get wizardErrRequired => 'Ez a mező kötelező';

  @override
  String wizardErrTooShort(int count) {
    return 'Túl rövid (legalább $count karakter)';
  }

  @override
  String get wizardErrOnlyLetters =>
      'Csak betűk, szóközök, kötőjelek és aposztrófok';

  @override
  String get wizardErrSaveFailed =>
      'Mentés sikertelen. Ellenőrizd a kapcsolatot és próbáld újra.';

  @override
  String get wizardStufe1aTitle => 'Személyazonosság';

  @override
  String get wizardStufe1aPrompt =>
      'Ismerkedjünk meg hivatalosan. Írd be a neved pontosan úgy, ahogy a Personalausweis, Reisepass vagy Aufenthaltstitel okiraton szerepel — hogy egyezzen a dokumentumaiddal.';

  @override
  String get wizardStufe1aVornameLabel => 'Vornamen (utónevek)';

  @override
  String get wizardStufe1aVornameHelper =>
      'Minden utóneved pontosan úgy, ahogy a dokumentumon. Szóközzel vagy kötőjellel (pl. Hans-Peter, Maria Anna).';

  @override
  String get wizardStufe1aNachnameLabel => 'Familienname (vezetéknév)';

  @override
  String get wizardStufe1aNachnameHelper => 'A jelenlegi vezetékneved.';

  @override
  String get wizardStufe1aGeburtsnameLabel =>
      'Geburtsname (születési név) — opcionális';

  @override
  String get wizardStufe1aGeburtsnameHelper =>
      'Csak ha eltér a Familiennametől — pl. házasság előtti név.';

  @override
  String get wizardStufe1bTitle => 'Születésnap';

  @override
  String get wizardStufe1bPrompt =>
      'Szeretnénk veled ünnepelni a születésnapod! 🎂 És segít megerősíteni, hogy elmúltál 16 — így szól az alapszabályunk.';

  @override
  String get wizardStufe1bGeburtsdatumLabel => 'Születési dátum';

  @override
  String get wizardStufe1bGeburtsdatumHelper =>
      'Koppints a dátum kiválasztásához';

  @override
  String get wizardStufe1bGeburtsortLabel => 'Születési hely';

  @override
  String get wizardStufe1bGeburtsortHelper =>
      'Város / település, ahol születtél.';

  @override
  String get wizardAgeGatePrompt => 'Sajnálom… 😔';

  @override
  String wizardAgeGateBody1(int age, int years) {
    return 'Az alapszabályunk szerint legalább 16 évesnek kell lenned a tagsághoz. $age éves vagy — remélem találkozunk $years év múlva! 🌱';
  }

  @override
  String get wizardAgeGateBody2 =>
      'Ha alkalmanként önkénteskedni szeretnél (bármilyen kor, szülői engedéllyel), hívj minket — szívesen támogatunk fiatalokat, akik meg akarják változtatni a világot.';

  @override
  String get wizardAgeGateBackHome => 'Vissza a kezdőképernyőre';

  @override
  String get wizardErrInvalidPhone => 'Érvénytelen telefonszám';

  @override
  String get wizardStufe1b1Title => 'Szülői beleegyezés';

  @override
  String get wizardStufe1b1Prompt =>
      'Kiskorú vagy (16-17) — a BGB §106 szerint szükségünk van egy szülő vagy törvényes képviselő beleegyezésére. Mondd a nevét és telefonszámát. Egy Vorsitzer felhívja és megbeszél vele egy találkozót (személyesen vagy videóhíváson). Email nincs — biztosak akarunk lenni, hogy a megfelelő emberrel beszélünk.';

  @override
  String get wizardStufe1b1VornameLabel => 'Szülő keresztneve';

  @override
  String get wizardStufe1b1VornameHelper =>
      'Ahogy a szülő Personalausweisén szerepel.';

  @override
  String get wizardStufe1b1NachnameLabel => 'Szülő vezetékneve';

  @override
  String get wizardStufe1b1NachnameHelper =>
      'Ahogy a szülő Personalausweisén szerepel.';

  @override
  String get wizardStufe1b1TelefonLabel => 'Szülő mobilszáma';

  @override
  String get wizardStufe1b1TelefonHelper => 'Erre a számra hív egy Vorsitzer.';

  @override
  String get wizardStufe1b1RelationLabel => 'Kapcsolat a gyermekkel:';

  @override
  String get wizardStufe1b1RelationMutter => 'Anya';

  @override
  String get wizardStufe1b1RelationVater => 'Apa';

  @override
  String get wizardStufe1b1RelationSorgeberechtigter => 'Törvényes képviselő';

  @override
  String get wizardStufe1b1RelationAndere => 'Más gondviselő';

  @override
  String get wizardStufe1cTitle => 'Személyes adatok';

  @override
  String get wizardStufe1cPrompt =>
      'Csak hogy jobban megismerjelek. Ez köztünk marad és sehol nem jelenik meg nyilvánosan.';

  @override
  String get wizardStufe1cGeschlechtLabel => 'Nem';

  @override
  String get wizardStufe1cGeschlechtMaennlich => 'Férfi';

  @override
  String get wizardStufe1cGeschlechtWeiblich => 'Nő';

  @override
  String get wizardStufe1cGeschlechtDivers => 'Egyéb';

  @override
  String get wizardStufe1cGeschlechtKeineAngabe => 'Nem kívánok válaszolni';

  @override
  String get wizardStufe1cFamilienstandLabel => 'Családi állapot';

  @override
  String get wizardStufe1cFamilienstandLedig => 'Nőtlen / Hajadon';

  @override
  String get wizardStufe1cFamilienstandVerheiratet => 'Házas';

  @override
  String get wizardStufe1cFamilienstandGeschieden => 'Elvált';

  @override
  String get wizardStufe1cFamilienstandVerwitwet => 'Özvegy';

  @override
  String get wizardStufe1dTitle => 'Származásod';

  @override
  String get wizardStufe1dPrompt =>
      'Ez segít nekünk a megfelelő támogatást felajánlani — például Aufenthalt-tanácsadás vagy a nyelvi közösséged megtalálása.';

  @override
  String get wizardStufe1dStaatLabel => 'Állampolgárság';

  @override
  String get wizardStufe1dStaatHelper =>
      'Pl. deutsch, rumänisch, ukrainisch. Többet vesszővel.';

  @override
  String get wizardStufe1dAufenthaltLabel =>
      'Tartózkodási státusz (Aufenthaltsstatus) — opcionális';

  @override
  String get wizardStufe1dAufenthaltHelper =>
      'Válaszd ki a címet az Aufenthaltskarte / határozat alapján. A Vorstand összeveti a dokumentumaiddal.';

  @override
  String get wizardStufe1dAufenthaltAwaitingCitizenship =>
      'Először töltsd ki fent az állampolgárságot — csak a megfelelő opciókat mutatjuk.';

  @override
  String get wizardStufe1dAufenthaltGerman =>
      'Nincs szükség Aufenthaltstitelre — német állampolgár.';

  @override
  String get wizardStufe1dAufenthaltEuEea =>
      'EU/EGT/CH állampolgár — szabad mozgás (Freizügigkeit).';

  @override
  String get wizardStufe1dAufenthaltTempHint => 'ideiglenes';

  @override
  String get wizardStufe1dAufenthaltPermHint => 'állandó tartózkodás';

  @override
  String get wizardStufe1dAufenthaltAsylumProcessHint => 'menekültügyi eljárás';

  @override
  String get wizardStufe1dAufenthaltOther =>
      'Egyéb (kérlek pontosítsd a chatben)';

  @override
  String get wizardStufe1dAufenthaltRequired =>
      'Kérlek válassz egy Aufenthaltstitelt.';

  @override
  String get wizardStufe1dMutterspracheLabel => 'Anyanyelv';

  @override
  String get wizardStufe1dMutterspracheHelper =>
      'Az alkalmazás nyelvével előre kitöltve — módosítsd, ha más.';

  @override
  String get wizardStufe1eTitle => 'Cím';

  @override
  String get wizardStufe1ePrompt =>
      'A postacímed — hivatalos dokumentumokhoz használjuk (alapszabály, tagsági szerződések, értesítések).';

  @override
  String get wizardStufe1eStrasseLabel => 'Utca';

  @override
  String get wizardStufe1eStrasseHelper =>
      'Csak az utca neve — a házszám a mellette lévő mezőbe.';

  @override
  String get wizardStufe1eHausnummerLabel => 'Sz.';

  @override
  String get wizardStufe1ePlzLabel => 'PLZ (irányítószám)';

  @override
  String get wizardStufe1eOrtLabel => 'Város';

  @override
  String get wizardStufe1eLandLabel => 'Ország';

  @override
  String get wizardStufe1eLandHelper => 'Előre kitöltve: Deutschland.';

  @override
  String get wizardErrInvalidStreet => 'Érvénytelen utcanév';

  @override
  String get wizardErrInvalidHausnummer =>
      'Érvénytelen szám (pl. 12, 12a, 12/3)';

  @override
  String get wizardErrInvalidPlz =>
      'Érvénytelen irányítószám (csak számjegyek)';

  @override
  String get wizardStufe1fTitle => 'Elérhetőség';

  @override
  String get wizardStufe1fPrompt =>
      'Hogyan érünk el? A telefon csak vészhelyzetre — minden mást a saját, végpontok közötti titkosított csatornánkon intézünk az appban. A tag-e-mailedet automatikusan kapod meg, és lent láthatod.';

  @override
  String get wizardStufe1fTelefonLabel => 'Mobilszám';

  @override
  String get wizardStufe1fTelefonHelper =>
      'Ígérem, csak akkor hívlak, ha tényleg fontos. 📱';

  @override
  String get wizardStufe2Title => 'Tagság típusa';

  @override
  String get wizardStufe2Prompt =>
      'Milyen tag szeretnél lenni? Hadd magyarázzam el a lehetőségeket.';

  @override
  String get wizardStufe2OrdentlichTitle => 'Rendes tag (ordentlich)';

  @override
  String get wizardStufe2OrdentlichBody =>
      'Teljes jogkör. Havi tagdíjat fizetsz, szavazol a közgyűlésen, megválasztható vagy az elnökségbe. Alapértelmezett választás.';

  @override
  String get wizardStufe2FoerderTitle => 'Pártoló tag (Fördermitglied)';

  @override
  String get wizardStufe2FoerderBody =>
      'Anyagilag támogatod az egyesületet, de nem veszel részt aktívan a döntésekben. Nincs szavazati jog. Jó választás, ha távolról szeretnél segíteni.';

  @override
  String get wizardStufe2EhrenTitle => 'Tiszteletbeli tag (Ehrenmitglied)';

  @override
  String get wizardStufe2EhrenBody =>
      'Az elnökség adományozza különleges érdemekért. Nem te választod — elismerésként kapod. Csak akkor jelöld, ha már megkaptad ezt a kitüntetést.';

  @override
  String get wizardStufe3Title => 'Anyagi helyzet';

  @override
  String get wizardStufe3Prompt =>
      'Most az anyagi helyzetedről. Nem ítélkezni — csak hogy mentesíthessünk a tagdíj alól, ha szociális ellátást kapsz.';

  @override
  String get wizardStufe3OptionBuergergeld => 'Bürgergeldet kapok';

  @override
  String get wizardStufe3OptionSozialamt => 'Sozialamt-támogatást kapok';

  @override
  String get wizardStufe3OptionNein => 'Egyiket sem kapom';

  @override
  String get wizardStufe3FeeExemptTitle => 'Tagdíj: 0 € / hó 🎉';

  @override
  String get wizardStufe3FeeExemptBody =>
      'Bürgergelddel, Sozialamttal, ALG I-vel vagy Krankengelddel a Satzung §6 szerint teljesen mentes vagy a tagdíj alól. Csak egy igazolás kell (Leistungsbescheid vagy igazolás a hatóságtól / egészségbiztosítótól).';

  @override
  String get wizardStufe3UploadTitle => 'Leistungsbescheid feltöltése';

  @override
  String get wizardStufe3UploadHint => 'PDF / JPG / PNG, max. 10 MB.';

  @override
  String get wizardStufe3UploadRequired =>
      'Kérlek töltsd fel a Leistungsbescheidet, mielőtt továbblépsz.';

  @override
  String get wizardStufe3FileTooLarge => 'A fájl túl nagy. Maximum 10 MB.';

  @override
  String get wizardStufe3UploadFailed =>
      'Nem sikerült feltölteni a fájlt. Próbáld újra.';

  @override
  String get wizardStufe3RegularFeeTitle => 'Tagdíj: 25 € / hó';

  @override
  String get wizardStufe3RegularFeeBody =>
      'A rendes tagok szokásos tagdíja az alapszabály szerint.';

  @override
  String get wizardStufe4Title => 'Fizetés';

  @override
  String get wizardStufe4Prompt =>
      'Hogyan szeretnéd fizetni a tagdíjat? És a hónap melyik napján?';

  @override
  String get wizardStufe4MethodUeberweisungTitle =>
      'Banki átutalás (Überweisung)';

  @override
  String get wizardStufe4MethodUeberweisungBody =>
      'A fizetést te indítod minden hónapban a számládról.';

  @override
  String get wizardStufe4MethodSepaTitle =>
      'SEPA-Lastschrift (közvetlen beszedés)';

  @override
  String get wizardStufe4MethodSepaBody =>
      'Az összeget automatikusan levonjuk a számládról. A legkényelmesebb, de IBAN és aláírt megbízás kell.';

  @override
  String get wizardStufe4MethodDauerauftragTitle =>
      'Dauerauftrag (állandó megbízás)';

  @override
  String get wizardStufe4MethodDauerauftragBody =>
      'Bankodnál állandó megbízást állítasz be. A bank minden hónapban automatikusan átutalja az összeget.';

  @override
  String get wizardStufe4DayLabel => 'Fizetési nap';

  @override
  String get wizardStufe4DayHint => 'Válassz egy napot 1 és 31 között';

  @override
  String wizardStufe4DayItem(int day) {
    return '$day. nap';
  }

  @override
  String wizardStufe4DayReminder(int day) {
    return 'A tagdíjat minden hónap $day-én vonjuk le.';
  }

  @override
  String get wizardStufe5Title => 'Kezdet';

  @override
  String get wizardStufe5Prompt =>
      'Mikortól szeretnél hivatalosan ICD360S-tag lenni? A jóváhagyástól vagy visszamenőleg.';

  @override
  String get wizardStufe5OptionAbVerifizierungTitle =>
      'A Vorstand jóváhagyásától';

  @override
  String get wizardStufe5OptionAbVerifizierungBody =>
      'A legegyszerűbb választás. Nincs visszamenőleges tagdíj.';

  @override
  String get wizardStufe5OptionGruendungsdatumTitle =>
      'Visszamenőleg 2025.08.01-től (alapítás)';

  @override
  String get wizardStufe5OptionGruendungsdatumBody =>
      'Tagnak számítasz az egyesület első napjától.';

  @override
  String get wizardStufe5OptionAnderesDatumTitle => 'Más dátum';

  @override
  String get wizardStufe5OptionAnderesDatumBody =>
      'Te választasz egy dátumot 2025.08.01. és ma között.';

  @override
  String get wizardStufe5PickDate => 'Koppints a dátum kiválasztásához';

  @override
  String get wizardStufe5PickDateFirst => 'Először válassz egy dátumot.';

  @override
  String get wizardStufe5DatePickerHelp => 'Tagság kezdete';

  @override
  String wizardStufe5DateRange(String start) {
    return '$start és ma között';
  }

  @override
  String get wizardStufe5RetroactiveTitle => 'Visszamenőleges tagdíj';

  @override
  String wizardStufe5RetroactiveBody(
      String start, String end, int months, String amount) {
    return '$start-tól $end-ig $months hónap. 25 €/hó esetén ez $amount € visszamenőlegesen fizetendő, a folyó havi tagdíjon felül.';
  }

  @override
  String get wizardStufe5FeeExemptTitle => 'Visszamenőleges tagdíj: 0 € 🎉';

  @override
  String get wizardStufe5FeeExemptBody =>
      'Bürgergelddel vagy Sozialamttal teljesen mentes vagy — visszamenőleg sem tartozol semmivel.';

  @override
  String wizardDocumentPrompt(String doc) {
    return 'Mielőtt befejezzük, kérlek olvasd el figyelmesen a $doc-t. Fontos tudnod, mit írsz alá.';
  }

  @override
  String get wizardDocumentScrollHint => 'Görgess a végéig a folytatáshoz.';

  @override
  String get wizardDocumentScrolledOk => 'Végigolvastad ✓';

  @override
  String wizardDocumentOpenButton(String doc) {
    return '$doc megnyitása a böngészőben';
  }

  @override
  String get wizardDocumentExternalHint =>
      'Ezen a platformon az alapértelmezett böngészőben nyitjuk meg a dokumentumot.';

  @override
  String get wizardDocumentOpenedOk =>
      'A dokumentum megnyílt. Olvasd el figyelmesen.';

  @override
  String wizardDocumentConfirm(String doc) {
    return 'Megerősítem, hogy elolvastam és elfogadom a $doc-t.';
  }

  @override
  String get wizardFinalAdultTitle => 'Kész! Beiratkoztál 🎉';

  @override
  String get wizardFinalMinorTitle => 'A kérésedet elküldtük 📨';

  @override
  String get wizardFinalMinorBody =>
      'Felvesszük a kapcsolatot a szülőddel és megbeszélünk egy találkozót (személyesen vagy videóhíváson). Légy türelemmel — a folyamat akár 7 napig is tarthat. Értesítést kapsz az alkalmazásban, amint a szülőd jóváhagyta.';

  @override
  String get wizardFinalMitgliedernummerLabel => 'Tagsági számod';

  @override
  String get wizardStufe4MethodComingSoon => 'Hamarosan';

  @override
  String get wizardStufe4StreichungWarning =>
      'Ha több mint 6 hónapja vagy elmaradásban a tagdíjjal, automatikusan töröljük (Satzung §6 Abs. 3).';

  @override
  String get wizardStufe5KuendigungInfo =>
      'Kilépéshez: küldd el a felmondást írásban 3 hónappal december 31. előtt (legkésőbb szeptember 30-ig, hogy év végén lépjen hatályba). Nincs minimális tagsági idő (Satzung §6 Abs. 3).';

  @override
  String get wizardStufe1fEmailLabel => 'A tag-e-mailed';

  @override
  String get wizardStufe1fEmailHelper =>
      'Automatikusan a tagsági számodból generálódik. Abban a pillanatban aktiválódik, amikor az elnökség (Vorstand) jóváhagyja a jelentkezésedet. Saját e-mail-alkalmazásunk van — küldj és fogadj titkosított e-maileket, egyszerűen és ingyen.';

  @override
  String get wizardErrInvalidEmail => 'Érvénytelen e-mail cím';

  @override
  String get wizardStufe3OptionAlg1 =>
      'Arbeitslosengeld I-et (ALG I, álláskeresési járadék) kapok';

  @override
  String get wizardStufe3OptionKrankengeld =>
      'Krankengeldet kapok (hosszabb betegség idejére)';

  @override
  String get wizardStufe3UploadAddMore => 'Még egy dokumentum hozzáadása';

  @override
  String get wizardStufe3UploadLimitCount =>
      'Elérted a határt: legfeljebb 20 dokumentum.';

  @override
  String get wizardStufe3UploadLimitTotal =>
      'Elérted az összesen 100 MB határt. Törölj egy meglévő fájlt.';

  @override
  String get wizardStufe3UploadDeleteTooltip => 'Törlés';

  @override
  String wizardStufe3UploadCounter(int count, int max) {
    return '$count / $max dokumentum';
  }

  @override
  String get wizardDocumentExternalOpenFailed =>
      'Nem sikerült megnyitni a böngészőt. A link a vágólapra került — illeszd be egy böngészőbe a folytatáshoz.';

  @override
  String get wizardFinalTimelineProcessing =>
      'Vorstand ellenőriz · általában 1 munkanap, max. 7';

  @override
  String get wizardFinalTimelineActivated => 'Fiók aktiválva';

  @override
  String get wizardFinalAdultThank =>
      'Köszönjük, hogy kitöltötted a regisztrációs űrlapot! 🎉';

  @override
  String get wizardFinalAdultUsual =>
      'A kérelmed nálunk van. Általában egy munkanapon belül érvényesítjük.';

  @override
  String get wizardFinalAdultExceptional =>
      'Néha akár 7 munkanapig is eltarthat. És ha valami nem stimmel, visszaküldünk az űrlapra, hogy javíthasd 🙂';

  @override
  String get wizardFinalStatusTitle => 'KÉRELEM ÁLLAPOTA';

  @override
  String wizardFinalStatusStepsValidated(int reviewed, int total) {
    return '$reviewed/$total lépést hagyott jóvá a Vorstand';
  }

  @override
  String get wizardFinalStufeSheetTitle => 'Kérelem részletei';

  @override
  String get wizardFinalStufeSheetHint =>
      'A 8 fázis, amit kitöltöttél. A Vorstand egyenként ellenőrzi — valós időben látod, mi lett jóváhagyva.';

  @override
  String get wizardFinalStufeStatusPending => 'Ellenőrzésre vár';

  @override
  String get wizardFinalStufeStatusApproved => 'Jóváhagyva';

  @override
  String get wizardFinalStufeStatusRejected => 'Elutasítva';

  @override
  String wizardFinalStatusRejectionCount(int count) {
    return '$count lépés javításra szorul';
  }

  @override
  String get wizardFinalStufeRejectionReason => 'A Vorstand indoklása:';

  @override
  String get wizardFinalStufeCorrectNow => 'Javítás most';

  @override
  String wizardFinalApprovalsHeader(int current, int total) {
    return 'Vorstand jóváhagyások ($current/$total)';
  }

  @override
  String get wizardFinalApprovalAwaiting => 'Várjuk a 2. Vorstandot';

  @override
  String get wizardFinalApprovalRejected => 'ELUTASÍTVA';

  @override
  String get wizardFinalStufeNoDataYet => 'Az adatok még nem érhetők el.';

  @override
  String get wizardFinalStufeReadAt => 'Olvasva:';

  @override
  String get wizardFinalStufeBeitragsfrei => 'Tagdíjmentes (nincs fizetés)';

  @override
  String get wizardFinalStufeNotExempt => 'Nincs szociális juttatás';

  @override
  String get wizardFinalStufeBeginAtVerification => 'Verifikációkor kezdődik';

  @override
  String get wizardFinalStufeBeginAtFoundation =>
      'Alapítás dátuma (visszamenőleg)';

  @override
  String get wizardFinalStufeBeginAtCustom => 'Egyéni dátum';

  @override
  String get wizardFinalStufeStatusSkipped => 'Kihagyva';

  @override
  String get wizardFinalStufeFilledAt => 'Kitöltve:';

  @override
  String get wizardFinalStufeReviewedAt => 'Ellenőrizve:';

  @override
  String get wizardFinalWithdrawLink => 'Kérelem visszavonása';

  @override
  String get wizardFinalWithdrawDialogTitle => 'Visszavonod a kérelmet?';

  @override
  String get wizardFinalWithdrawDialogBody =>
      'A kérelmedet visszavontnak jelöljük. Az adatok auditálás céljából (GDPR) az adatbázisban maradnak, de a fiók nem lesz aktiválva. Bármikor újrakezdheted a regisztrációt új tagsági számmal.';

  @override
  String get wizardFinalWithdrawKeep => 'Nem, várok';

  @override
  String get wizardFinalWithdrawConfirm => 'Igen, visszavonom';

  @override
  String get wizardErrTooManyWithdrawals =>
      'A kérelmedet nem tudjuk automatikusan feldolgozni. Hívj fel minket vagy gyere be személyesen a Vorstandhoz a regisztráció folytatásához.';

  @override
  String get wizardDuplicateLoginTitle => 'Úgy tűnik, már a tagunk vagy';

  @override
  String get wizardDuplicateLoginBody =>
      'A neveddel és születési idődddel már találunk egy aktív fiókot. Kérlek, használd a \"Már tag vagyok\" gombot a kezdőképernyőn a bejelentkezéshez. Ha nincs hozzáférésed, hívj minket.';

  @override
  String get wizardDuplicatePendingTitle => 'A kérelmed már nálunk van';

  @override
  String get wizardDuplicatePendingBody =>
      'A neveddel és születési idődddel már van egy folyamatban lévő kérelmünk. A Vorstand dolgozik rajta — értesítünk az appban, amint a fiókod aktívvá válik. Hívj, ha beszélnél velünk.';

  @override
  String get wizardDuplicateRecentlyWithdrawnTitle =>
      'Most nem tudjuk feldolgozni ezt a kérelmet';

  @override
  String get wizardDuplicateRecentlyWithdrawnBody =>
      'A neved és születési időd egyezik egy nemrég visszavont kérelemmel. Kérjük, hívj minket, hogy a folytatás előtt beszélj a Vorstanddal.';

  @override
  String get wizardDuplicatePreviouslyWithdrawnTitle =>
      'Korábban már jelentkeztél';

  @override
  String get wizardDuplicatePreviouslyWithdrawnBody =>
      'A neved és születési időd egyezik egy régebbi kérelemmel, amit visszavontál. Üdv újra — kérjük, hívj minket a folytatás előtt, hogy a Vorstand eldönthesse, hogyan tovább.';

  @override
  String get wizardDuplicateCallUsTitle => 'Kérjük, hívj minket';

  @override
  String get wizardDuplicateCallUsBody =>
      'A neved és születési időd már szerepel a nyilvántartásunkban, de a részleteket nem oszthatjuk meg az appon keresztül. Hívj minket — a Vorstand közvetlenül elmagyarázza a helyzetet.';

  @override
  String get wizardChatHelp => 'Beszéljünk';

  @override
  String get wizardChatHelpSubtitle => 'Élő chat a Vorstanddal · gyors válasz';

  @override
  String get benachrichtigungTitel => 'SMS-Erinnerungen';

  @override
  String get benachrichtigungIntro =>
      'Damit Sie keinen Termin verpassen, kann der Verein Ihnen eine SMS schicken. Sie entscheiden, ob und wofür — und können es jederzeit ändern.';

  @override
  String get benachrichtigungTermineFrage =>
      'Möchten Sie Erinnerungen an Ihre Termine per SMS erhalten?';

  @override
  String get benachrichtigungTermineDetail =>
      'Die SMS enthält Datum, Uhrzeit, Ort und Betreff des Termins.';

  @override
  String get benachrichtigungMedikamenteFrage =>
      'Möchten Sie auch an Ihre Medikamente erinnert werden?';

  @override
  String get benachrichtigungMedikamenteDetail =>
      'Dabei steht der Name des Medikaments in der SMS. Das ist eine Gesundheitsangabe — deshalb fragen wir getrennt.';

  @override
  String get benachrichtigungHinweis =>
      'Die Erinnerung ist eine Hilfe und keine Garantie: bitte verlassen Sie sich nicht allein darauf. Ändern können Sie das jederzeit in Ihrem Profil.';

  @override
  String get benachrichtigungJa => 'Ja';

  @override
  String get benachrichtigungNein => 'Nein';

  @override
  String get benachrichtigungSpaeter => 'Später entscheiden';

  @override
  String get benachrichtigungSpeichern => 'Speichern';

  @override
  String get benachrichtigungGespeichert => 'Danke, gespeichert.';

  @override
  String get benachrichtigungenLeer => 'Keine Benachrichtigungen';

  @override
  String get benachrichtigungenAlleGelesen => 'Alle als gelesen markieren';
}
