// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Slovak (`sk`).
class AppLocalizationsSk extends AppLocalizations {
  AppLocalizationsSk([String locale = 'sk']) : super(locale);

  @override
  String get appTitle => 'ICD360S e.V - Portál členov';

  @override
  String get memberPortal => 'Portál členov';

  @override
  String get welcomeLoading => 'Načítava sa...';

  @override
  String get welcomeAutoLogin => 'Automatické prihlásenie...';

  @override
  String get login => 'Prihlásiť sa';

  @override
  String get register => 'Zaregistrovať sa';

  @override
  String get becomeMember => 'Staňte sa členom';

  @override
  String get memberNumber => 'Číslo člena';

  @override
  String get memberNumberHint => 'Zadajte číslo člena';

  @override
  String get password => 'Heslo';

  @override
  String get passwordHint => 'Zadajte heslo';

  @override
  String get confirmPassword => 'Potvrďte heslo';

  @override
  String get confirmPasswordHint => 'Potvrďte heslo';

  @override
  String get newPassword => 'Nové heslo';

  @override
  String get newPasswordHint => 'Zadajte nové heslo';

  @override
  String get saveCredentials => 'Uložiť prihlasovacie údaje';

  @override
  String get autoLogin => 'Automatické prihlásenie';

  @override
  String get forgotPassword => 'Zabudli ste heslo?';

  @override
  String get firstName => 'Meno a priezvisko';

  @override
  String get firstNameHint => 'Zadajte meno a priezvisko';

  @override
  String get nameMinLength => 'Meno musí mať aspoň 2 znaky';

  @override
  String get nameOnlyLetters => 'Povolené iba písmená a pomlčky';

  @override
  String get email => 'E-mailová adresa';

  @override
  String get emailHint => 'Zadajte e-mail';

  @override
  String get emailInvalid => 'Zadajte platný e-mail';

  @override
  String get passwordMinLength => 'Heslo musí mať aspoň 6 znakov';

  @override
  String get passwordsNotMatch => 'Heslá sa nezhodujú';

  @override
  String get recoveryCode => 'Kód na obnovenie (6 číslic)';

  @override
  String get recoveryCodeHelper =>
      'Zapamätajte si tento kód na obnovenie hesla';

  @override
  String get recoveryCodeHint => 'Zadajte kód na obnovenie';

  @override
  String get recoveryCodeInvalid => 'Kód musí mať presne 6 číslic';

  @override
  String get loginFailed => 'Prihlásenie zlyhalo';

  @override
  String get registrationFailed => 'Registrácia zlyhala';

  @override
  String connectionError(String error) {
    return 'Chyba pripojenia: $error';
  }

  @override
  String registrationSuccess(String memberNumber) {
    return 'Registrácia úspešná!\n\nVaše číslo člena: $memberNumber\n\nZapamätajte si toto číslo na prihlásenie.';
  }

  @override
  String get tooManyDevices => 'Príliš veľa zariadení';

  @override
  String get maxDevicesMessage =>
      'Ste už prihlásení na 3 zariadeniach.\nVyberte zariadenie na odhlásenie:';

  @override
  String get unknownDevice => 'Neznáme zariadenie';

  @override
  String get unknown => 'Neznáme';

  @override
  String get logoutError => 'Chyba pri odhlásení';

  @override
  String error(String error) {
    return 'Chyba: $error';
  }

  @override
  String get cancel => 'Zrušiť';

  @override
  String get resetPassword => 'Obnoviť heslo';

  @override
  String get forgotPasswordTitle => 'Zabudnuté heslo';

  @override
  String get forgotPasswordDescription =>
      'Zadajte číslo člena a kód na obnovenie vytvorený pri registrácii.';

  @override
  String get passwordResetSuccess =>
      'Heslo bolo úspešne obnovené!\n\nTeraz sa môžete prihlásiť novým heslom.';

  @override
  String get passwordResetFailed => 'Obnovenie hesla zlyhalo';

  @override
  String get needHelp => 'Potrebujete pomoc?';

  @override
  String get helpQuestion => 'Problémy s prihlásením alebo registráciou?';

  @override
  String get helpDescription =>
      'Kontaktujte nás cez WhatsApp a opíšte presne, čo nefunguje. Odpovieme čo najskôr!';

  @override
  String get whatsapp => 'WhatsApp';

  @override
  String get emailSubject => 'Dopyt cez aplikáciu ICD360S';

  @override
  String get whatsappMessage => 'Dobrý deň, mám problém s aplikáciou ICD360S. ';

  @override
  String get imprint => 'Impressum';

  @override
  String get privacy => 'Ochrana osobných údajov';

  @override
  String get statutes => 'Stanovy';

  @override
  String get revocation => 'Právo na odstúpenie';

  @override
  String get cancellation => 'Zrušenie';

  @override
  String get allRightsReserved => 'Všetky práva vyhradené.';

  @override
  String get enterCredentials => 'Zadajte číslo člena a heslo';

  @override
  String get appointments => 'Stretnutia';

  @override
  String get tickets => 'Tikety';

  @override
  String get liveChat => 'Live Chat';

  @override
  String get notifications => 'Oznámenia';

  @override
  String get myProfile => 'Môj Profil';

  @override
  String get logout => 'Odhlásiť';

  @override
  String get goodMorning => 'Dobré ráno';

  @override
  String get goodDay => 'Dobrý deň';

  @override
  String get goodEvening => 'Dobrý večer';

  @override
  String get goodNight => 'Dobrú noc';

  @override
  String get welcomeToICD => 'Vitajte v ICD360S e.V!';

  @override
  String get accountCreatedSuccessfully => 'Váš účet bol úspešne vytvorený.';

  @override
  String get today => 'Dnes';

  @override
  String get membershipFeeDue => 'Členský príspevok splatný';

  @override
  String get pleaseTransferAnnualFee => 'Prosím, preveste ročný príspevok.';

  @override
  String get newBadge => 'Nový';

  @override
  String get close => 'Zavrieť';

  @override
  String get membership => 'Členstvo';

  @override
  String get myAppointments => 'Moje stretnutia';

  @override
  String get appointmentsLoadingReady =>
      'Načítanie stretnutí - API pripravené!';

  @override
  String get priority => 'Priorita';

  @override
  String get messageLabel => 'Správa';

  @override
  String get createdOn => 'Vytvorené';

  @override
  String get handler => 'Správca';

  @override
  String get reportProblems => 'Nahlásiť problémy';

  @override
  String get reportProblem => 'Nahlásiť problém';

  @override
  String get weRespondIn24Hours => 'Odpovieme vám do maximálne 24 hodín!';

  @override
  String get everythingOk => 'Všetko v poriadku!';

  @override
  String get haveProblemWeHelp => 'Máte problém?\nPostaráme sa o to!';

  @override
  String get myMembership => 'Moje členstvo';

  @override
  String get managePersonalDataAndFee =>
      'Spravujte svoje osobné údaje a príspevok';

  @override
  String get myAppointmentsTitle => 'Moje stretnutia';

  @override
  String get appointmentsDescription =>
      'Tu môžete vidieť svoje nadchádzajúce stretnutia.\nMôžete potvrdiť svoju účasť alebo odmietnuť.';

  @override
  String get loadAppointments => 'Načítať stretnutia';

  @override
  String get myTickets => 'Moje tikety';

  @override
  String get newTicket => 'Nový tiket';

  @override
  String get noOpenTickets => 'Žiadne otvorené tikety';

  @override
  String get haveQuestionCreateTicket =>
      'Máte otázku alebo problém?\nVytvorte nový tiket.';

  @override
  String get whatIsTheProblem => 'Aký je problém?';

  @override
  String get describeTheProblem => 'Popíšte problém';

  @override
  String get howUrgentIsIt => 'Ako naliehavé?';

  @override
  String get low => 'Nízka';

  @override
  String get medium => 'Stredná';

  @override
  String get high => 'Vysoká';

  @override
  String get submit => 'Odoslať';

  @override
  String get fillSubjectAndMessage => 'Vyplňte predmet a správu';

  @override
  String get ticketCreated => 'Tiket vytvorený';

  @override
  String get errorCreatingTicket => 'Chyba pri vytváraní tiketu';

  @override
  String get verified => 'Overené';

  @override
  String get account => 'Účet';

  @override
  String get myDevices => 'Moje zariadenia';

  @override
  String get changeEmail => 'Zmeniť email';

  @override
  String get changePassword => 'Zmeniť heslo';

  @override
  String get newEmailAddress => 'Nová emailová adresa';

  @override
  String get currentPassword => 'Aktuálne heslo';

  @override
  String get saveEmail => 'Uložiť email';

  @override
  String get savePassword => 'Uložiť heslo';

  @override
  String get deviceLoggedOut => 'Zariadenie odhlásené';

  @override
  String get passwordChangedSuccessfully => 'Heslo úspešne zmenené';

  @override
  String get emailChangedSuccessfully => 'Email úspešne zmenený';

  @override
  String get errorChangingPassword => 'Chyba pri zmene hesla';

  @override
  String get errorChangingEmail => 'Chyba pri zmene emailu';

  @override
  String get validEmailRequired => 'Zadajte platnú emailovú adresu';

  @override
  String get passwordTooShort => 'Heslo musí mať aspoň 6 znakov';

  @override
  String get maxDevicesReached =>
      'Ste prihlásení na maximálnom počte 3 zariadení.';

  @override
  String loggedInOnDevices(int count) {
    return 'Ste prihlásení na $count z 3 zariadení.';
  }

  @override
  String get noActiveSessions => 'Žiadne aktívne relácie';

  @override
  String get logoutFromDevice => 'Odhlásiť z tohto zariadenia';

  @override
  String get confirmLogoutDevice => 'Odhlásiť zariadenie?';

  @override
  String get confirmLogoutMessage =>
      'Chcete sa odhlásiť z tohto zariadenia?\n\nBudete sa musieť znova prihlásiť, aby ste mohli toto zariadenie používať.';

  @override
  String get ipAddress => 'IP';

  @override
  String get platform => 'Platforma';

  @override
  String trialWarningUrgentTitle(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days dní',
      few: '$days dni',
      one: '1 deň',
    );
    return 'Pozor: Zostáva $_temp0 do pozastavenia účtu!';
  }

  @override
  String get trialWarningTitle => 'Váš účet ešte nebol overený';

  @override
  String get trialWarningDescription =>
      'Vyplňte prosím svoje údaje v \"Môj profil\". Po 30 dňoch bude váš účet automaticky pozastavený.';

  @override
  String trialDaysRemaining(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days dní',
      few: '$days dni',
      one: '1 deň',
    );
    return '$_temp0';
  }

  @override
  String get overview => 'Prehľad';

  @override
  String get member => 'Člen';

  @override
  String get memberManagement => 'Správa členov';

  @override
  String get reportProblemTooltip => 'Nahlásiť problém';

  @override
  String get newAppointmentsTitle => 'Nové stretnutia';

  @override
  String get youHaveNewAppointment => 'Máte nové stretnutie.';

  @override
  String youHaveNewAppointments(int count) {
    return 'Máte $count nových stretnutí.';
  }

  @override
  String get appointmentReminderTomorrow => 'Pripomienka: Stretnutie zajtra';

  @override
  String tomorrowAppointment(String title) {
    return 'Zajtra: $title';
  }

  @override
  String youHaveTomorrowAppointments(int count) {
    return 'Máte $count stretnutí zajtra.';
  }

  @override
  String get appointmentsToday => 'Stretnutia dnes';

  @override
  String todayAppointment(String title) {
    return 'Dnes: $title';
  }

  @override
  String youHaveTodayAppointments(int count) {
    return 'Máte $count stretnutí dnes.';
  }

  @override
  String get paymentReminder => 'Pripomienka platby';

  @override
  String paymentReminderMessage(int day, String method) {
    return 'Dnes je $day. deň v mesiaci – dokončite prosím $method.';
  }

  @override
  String get paymentDayLabel => 'Deň platby (mesačná pripomienka)';

  @override
  String get updateAvailable => 'Aktualizácia k dispozícii';

  @override
  String newVersionAvailable(String version) {
    return 'Je k dispozícii nová verzia: $version';
  }

  @override
  String currentVersionLabel(String version) {
    return 'Aktuálna verzia: $version';
  }

  @override
  String get changes => 'Zmeny:';

  @override
  String downloadProgress(String percent) {
    return 'Sťahovanie: $percent%';
  }

  @override
  String get installationStarting => 'Spúšťanie inštalácie...';

  @override
  String get appWillRestart => 'Aplikácia sa automaticky reštartuje.';

  @override
  String get later => 'Neskôr';

  @override
  String get updateNow => 'Aktualizovať teraz';

  @override
  String get downloading => 'Sťahuje sa...';

  @override
  String get downloadFailed => 'Sťahovanie zlyhalo. Skúste to neskôr.';

  @override
  String get searchingForUpdates => 'Hľadanie aktualizácií...';

  @override
  String get appUpToDate => 'Aplikácia je aktuálna';

  @override
  String get updateCheckError => 'Chyba pri kontrole aktualizácií';

  @override
  String get changelog => 'Zoznam zmien';

  @override
  String get terminConfirmed => 'Stretnutie potvrdené';

  @override
  String get terminDeclined => 'Stretnutie odmietnuté';

  @override
  String get terminRescheduleRequested => 'Preloženie vyžiadané';

  @override
  String get statusConfirmed => 'Potvrdené';

  @override
  String get statusDeclined => 'Odmietnuté';

  @override
  String get statusRescheduling => 'Preloženie';

  @override
  String get statusPending => 'Čakajúce';

  @override
  String get categoryVorstandssitzung => 'Zasadnutie predstavenstva';

  @override
  String get categoryMitgliederversammlung => 'Valné zhromaždenie';

  @override
  String get categorySchulung => 'Školenie';

  @override
  String get categorySonstiges => 'Ostatné';

  @override
  String openCount(int count) {
    return '$count otvorených';
  }

  @override
  String get refresh => 'Obnoviť';

  @override
  String get filterUpcoming => 'Nadchádzajúce';

  @override
  String get filterPast => 'Minulé';

  @override
  String get filterAll => 'Všetky';

  @override
  String get noUpcomingAppointments => 'Žiadne nadchádzajúce stretnutia';

  @override
  String get noPastAppointments => 'Žiadne minulé stretnutia';

  @override
  String get noAppointmentsAvailable => 'Žiadne stretnutia';

  @override
  String get appointmentsShownHere => 'Vaše stretnutia sa zobrazia tu';

  @override
  String get dateLabel => 'Dátum';

  @override
  String get timeLabel => 'Čas';

  @override
  String get locationLabel => 'Miesto';

  @override
  String get createdByLabel => 'Vytvoril';

  @override
  String get descriptionLabel => 'Popis';

  @override
  String get ticketLabel => 'Ticket';

  @override
  String get yourStatus => 'Váš stav: ';

  @override
  String reasonLabel(String reason) {
    return 'Dôvod: $reason';
  }

  @override
  String durationMinutes(int minutes) {
    return '$minutes min';
  }

  @override
  String get confirm => 'Potvrdiť';

  @override
  String get decline => 'Odmietnuť';

  @override
  String get reschedule => 'Preložiť';

  @override
  String get requestReschedule => 'Požiadať o preloženie';

  @override
  String appointmentLabel(String title) {
    return 'Stretnutie: $title';
  }

  @override
  String get rescheduleReason => 'Dôvod preloženia *';

  @override
  String get rescheduleReasonHint => 'Uveďte dôvod...';

  @override
  String get pleaseProvideReason => 'Uveďte dôvod';

  @override
  String get request => 'Požiadať';

  @override
  String get ticketStatusOpen => 'Otvorené';

  @override
  String get ticketStatusInProgress => 'Spracováva sa';

  @override
  String get ticketStatusWaitingMember => 'Čaká sa na člena';

  @override
  String get ticketStatusWaitingStaff => 'Čaká sa na pracovníka';

  @override
  String get ticketStatusWaitingAuthority => 'Čaká sa na úrad';

  @override
  String get ticketStatusDone => 'Vybavené';

  @override
  String get ticketPriorityHigh => 'Vysoká';

  @override
  String get ticketPriorityMedium => 'Stredná';

  @override
  String get ticketPriorityLow => 'Nízka';

  @override
  String get comments => 'Komentáre';

  @override
  String get documents => 'Dokumenty';

  @override
  String get details => 'Podrobnosti';

  @override
  String get replySent => 'Odpoveď odoslaná';

  @override
  String get sendError => 'Chyba pri odosielaní';

  @override
  String get uploading => 'Nahrávanie...';

  @override
  String fileUploaded(String filename) {
    return '$filename nahraté';
  }

  @override
  String get uploadFailed => 'Nahrávanie zlyhalo';

  @override
  String get openError => 'Chyba pri otváraní';

  @override
  String get noRepliesYet => 'Zatiaľ žiadne odpovede';

  @override
  String get waitingForSupport => 'Čakanie na odpoveď podpory';

  @override
  String get writeReply => 'Napísať odpoveď...';

  @override
  String get attachFile => 'Priložiť súbor';

  @override
  String documentsCount(int count) {
    return 'Dokumenty ($count)';
  }

  @override
  String get upload => 'Nahrať';

  @override
  String get noDocuments => 'Žiadne dokumenty';

  @override
  String get allowedFormats => 'Povolené formáty: PDF, JPEG, JPG, TXT, ZIP';

  @override
  String get yourMessage => 'Vaša správa:';

  @override
  String get translation => 'Preklad';

  @override
  String get original => 'Originál';

  @override
  String get originalText => 'Pôvodný text';

  @override
  String get autoTranslated => 'Automaticky preložené';

  @override
  String get originalTapTranslation => 'Originál · Ťuknite pre preklad';

  @override
  String get translatedTapOriginal => 'Preložené · Ťuknite pre originál';

  @override
  String get justNow => 'Práve teraz';

  @override
  String minutesAgo(int minutes) {
    return 'pred $minutes min';
  }

  @override
  String hoursAgo(int hours) {
    return 'pred $hours hod';
  }

  @override
  String daysAgo(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'dňami',
      one: 'dňom',
    );
    return 'pred $days $_temp0';
  }

  @override
  String get createdLabel => 'Vytvorené';

  @override
  String get updatedLabel => 'Aktualizované';

  @override
  String get handlerLabel => 'Spracovateľ';

  @override
  String get doneLabel => 'Vybavené';

  @override
  String get newTicketTitle => 'Nový ticket';

  @override
  String get categoryOptional => 'Kategória (voliteľné)';

  @override
  String get selectCategory => 'Vybrať';

  @override
  String get subjectLabel => 'Predmet';

  @override
  String get fillAllFields => 'Vyplňte všetky polia';

  @override
  String ticketCreatedId(int id) {
    return 'Ticket #$id vytvorený';
  }

  @override
  String get priorityLabel => 'Priorita: ';

  @override
  String get supportOffline => 'Podpora offline';

  @override
  String get lastSeenSeconds => 'Aktívny pred niekoľkými sekundami';

  @override
  String lastSeenMinutes(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: 'minútami',
      one: 'minútou',
    );
    return 'Aktívny pred $minutes $_temp0';
  }

  @override
  String lastSeenHours(int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: 'hodinami',
      one: 'hodinou',
    );
    return 'Aktívny pred $hours $_temp0';
  }

  @override
  String lastSeenDays(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'dňami',
      one: 'dňom',
    );
    return 'Aktívny pred $days $_temp0';
  }

  @override
  String get online => 'Online';

  @override
  String get callSupport => 'Zavolať';

  @override
  String get typeMessage => 'Napíšte správu...';

  @override
  String get callBusy => 'Podpora je zaneprázdnená';

  @override
  String get callRejected => 'Hovor bol odmietnutý';

  @override
  String get callFailed => 'Hovor sa nepodarilo spojiť';

  @override
  String get callEnded => 'Hovor ukončený';

  @override
  String get callSupportBusy => 'Podpora je už v inom hovore';

  @override
  String get errorStartingChat => 'Chyba pri spustení chatu';

  @override
  String get errorStartingCall => 'Chyba pri spustení hovoru';

  @override
  String get errorConnecting => 'Chyba pripojenia';

  @override
  String get errorAcceptingCall => 'Chyba pri prijímaní hovoru';

  @override
  String get errorDownloading => 'Chyba sťahovania';

  @override
  String get errorUploading => 'Chyba nahrávania';

  @override
  String get errorSending => 'Chyba odosielania';

  @override
  String get errorPickingPhotos => 'Chyba výberu fotiek';

  @override
  String get errorPickingFiles => 'Chyba výberu súborov';

  @override
  String get errorTakingPhoto => 'Chyba fotenia';

  @override
  String get fileNotLoaded => 'Súbor sa nepodarilo načítať';

  @override
  String get attachmentIdMissing => 'ID prílohy chýba';

  @override
  String get camera => 'Fotoaparát';

  @override
  String get gallery => 'Galéria';

  @override
  String get file => 'Súbor';

  @override
  String typingIndicator(String name) {
    return '$name píše...';
  }

  @override
  String get notifNewMessageFrom => 'Nová správa od';

  @override
  String get notifUrgentPrefix => 'NALIEHAVÉ';

  @override
  String get notifUrgentMessage => 'NALIEHAVÁ SPRÁVA';

  @override
  String get notifIncomingCall => 'Prichádzajúci hovor';

  @override
  String get notifCallingYou => 'volá...';

  @override
  String get notifUpdateAvailable => 'Aktualizácia k dispozícii';

  @override
  String get notifVersionAvailable => 'je teraz k dispozícii';

  @override
  String get notifConnected => 'Pripojené';

  @override
  String get notifDisconnected => 'Odpojené';

  @override
  String get notifConnectedBody => 'Ste pripojení k serveru.';

  @override
  String get notifDisconnectedBody => 'Spojenie so serverom bolo prerušené.';

  @override
  String get notifError => 'Chyba';

  @override
  String get retry => 'Skúsiť znova';

  @override
  String get save => 'Uložiť';

  @override
  String get accept => 'Prijať';

  @override
  String get selectFile => 'Vybrať súbor';

  @override
  String get dataLoadingText => 'Načítavanie dát...';

  @override
  String get dataSavedSuccess => 'Dáta úspešne uložené';

  @override
  String get errorSaving => 'Chyba pri ukladaní';

  @override
  String get errorLoading => 'Chyba pri načítaní';

  @override
  String savedFilename(String filename) {
    return 'Uložené: $filename';
  }

  @override
  String get logsCopied => 'Logy skopírované!';

  @override
  String get diagnosticDataTitle => 'Diagnostické dáta';

  @override
  String get diagnosticDescription =>
      'Chcete odosielať anonymné diagnostické dáta na zlepšenie aplikácie?';

  @override
  String get noThanks => 'Nie, ďakujem';

  @override
  String get yesEnable => 'Áno, povoliť';

  @override
  String get passwordMinEightChars => 'Heslo musí mať aspoň 8 znakov';

  @override
  String get passwordChangeSuccess => 'Heslo úspešne zmenené';

  @override
  String get emailChangeError => 'Chyba pri zmene e-mailu';

  @override
  String get acceptDocumentCheckbox => 'Prečítal som a prijímam dokument.';

  @override
  String loadingErrorGeneric(String details) {
    return 'Chyba načítania: $details';
  }

  @override
  String get incomingCallTitle => 'Prichádzajúci hovor';

  @override
  String ringingFor(int seconds) {
    return 'Zvoní ${seconds}s';
  }

  @override
  String get rejectCall => 'Odmietnuť';

  @override
  String get acceptCall => 'Prijať';

  @override
  String get unmute => 'Zapnúť zvuk';

  @override
  String get mute => 'Stlmiť';

  @override
  String get hangUp => 'Zavesiť';

  @override
  String get calling => 'Volanie...';

  @override
  String autoRejectIn(int seconds) {
    return 'Automatické odmietnutie za $seconds sekúnd';
  }

  @override
  String get speakerOn => 'Reproduktor';

  @override
  String get speakerOff => 'Slúchadlo';

  @override
  String get micMuted => 'Stlmené';

  @override
  String get micOn => 'Mikrofón';

  @override
  String get connectionExcellent => 'Výborné';

  @override
  String get connectionGood => 'Dobré';

  @override
  String get connectionWeak => 'Slabé';

  @override
  String get connectionLost => 'Odpojené';

  @override
  String get personalData => 'Osobné údaje';

  @override
  String get personalDataSubtitle => 'Meno, priezvisko, adresa';

  @override
  String get membershipFee => 'Členský príspevok';

  @override
  String annualFeeYear(String year) {
    return 'Ročný príspevok $year';
  }

  @override
  String get amount => 'Suma:';

  @override
  String get dueBy => 'Splatnosť:';

  @override
  String get paid => 'Zaplatené';

  @override
  String get versionHistory => 'História verzií';

  @override
  String lastUpdated(String date) {
    return 'Posledná aktualizácia: $date';
  }

  @override
  String get noVersionHistory => 'Žiadna história verzií';

  @override
  String get failedLoadChangelog => 'Nepodarilo sa načítať zoznam zmien';

  @override
  String get callMember => 'Zavolať členovi';

  @override
  String get closeConversation => 'Zavrieť konverzáciu';

  @override
  String get chatOffline => 'Offline';

  @override
  String get attachFiles => 'Priložiť súbory (max. 10, 50MB)';

  @override
  String get conversationClosed => 'Táto konverzácia bola uzavretá';

  @override
  String get noMessages => 'Žiadne správy';

  @override
  String get goBack => 'Späť';

  @override
  String get goForward => 'Dopredu';

  @override
  String get homePage => 'Domov';

  @override
  String get firstNameLabel => 'Meno';

  @override
  String get lastNameLabel => 'Priezvisko';

  @override
  String get streetLabel => 'Ulica';

  @override
  String get houseNumberLabel => 'Č.';

  @override
  String get postalCodeLabel => 'PSČ';

  @override
  String get cityLabel => 'Mesto';

  @override
  String get phoneMobileLabel => 'Telefón (Mobil)';

  @override
  String get phoneLandlineLabel => 'Telefón (Pevná linka)';

  @override
  String get newEmailLabel => 'Nová e-mailová adresa';

  @override
  String get currentPasswordLabel => 'Aktuálne heslo';

  @override
  String get newPasswordLabel => 'Nové heslo';

  @override
  String get confirmPasswordLabel => 'Potvrdiť heslo';

  @override
  String get emailChangedSuccess => 'E-mail úspešne zmenený';

  @override
  String get newPasswordMinChars => 'Nové heslo (min. 6 znakov)';

  @override
  String get reasonLabel2 => 'Dôvod';

  @override
  String get downloadFailed2 => 'Sťahovanie zlyhalo';

  @override
  String get downloadTooltip => 'Stiahnuť';

  @override
  String get connectionErrorGeneric => 'Chyba pripojenia';

  @override
  String get copyLogs => 'Kopírovať logy';

  @override
  String get deleteLogs => 'Vymazať logy';

  @override
  String get autoScrollOn => 'Automatické posúvanie ZAP';

  @override
  String get autoScrollOff => 'Automatické posúvanie VYP';

  @override
  String get unknownValue => 'Neznáme';

  @override
  String get bankTransfer => 'Bankový prevod';

  @override
  String get standingOrder => 'Trvalý príkaz';

  @override
  String get payment => 'Platba';

  @override
  String get warningType_ermahnung => 'Napomenutie';

  @override
  String get warningType_abmahnung => 'Výstraha';

  @override
  String get warningType_letzte => 'Posledná výstraha';

  @override
  String warningsTotal(int count) {
    return 'Celkom: $count';
  }

  @override
  String warningsErmahnung(int count) {
    return 'Napomenutia: $count';
  }

  @override
  String warningsAbmahnung(int count) {
    return 'Výstrahy: $count';
  }

  @override
  String warningsLetzte(int count) {
    return 'Posledné: $count';
  }

  @override
  String get noWarnings => 'Žiadne napomenutia';

  @override
  String get noWarningsDescription => 'Momentálne nemáte žiadne napomenutia.';

  @override
  String createdBy(String name) {
    return 'Vytvoril: $name';
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
  String get monthSep => 'Sep';

  @override
  String get monthOct => 'Okt';

  @override
  String get monthNov => 'Nov';

  @override
  String get monthDec => 'Dec';

  @override
  String get stufe1_name => 'Osobné údaje';

  @override
  String get stufe2_name => 'Typ členstva';

  @override
  String get stufe3_name => 'Finančná situácia';

  @override
  String get stufe4_name => 'Platobná metóda';

  @override
  String get stufe5_name => 'Začiatok členstva';

  @override
  String get stufe6_name => 'Stanovy';

  @override
  String get stufe7_name => 'Zásady ochrany osobných údajov';

  @override
  String get stufe8_name => 'Právo na odstúpenie';

  @override
  String get memberType_ordentlich => 'Riadny člen';

  @override
  String get memberType_foerder => 'Podporný člen';

  @override
  String get memberType_ehren => 'Čestný člen';

  @override
  String get memberDesc_ordentlich =>
      'Aktívny člen s hlasovacím právom. Zúčastňuje sa služieb spolku (email, cloud, úradná podpora).';

  @override
  String get memberDesc_foerder =>
      'Podporuje spolok príspevkami. Môže sa zúčastniť valného zhromaždenia s poradným hlasom, bez hlasovacieho práva alebo voliteľnosti do predstavenstva.';

  @override
  String get memberDesc_ehren =>
      'Má práva riadneho člena bez povinnosti platiť členské príspevky. Menovaný valným zhromaždením alebo predstavenstvom.';

  @override
  String get payMethod_ueberweisung => 'Bankový prevod';

  @override
  String get payMethod_dauerauftrag => 'Trvalý príkaz';

  @override
  String get verifyStatus_geprueft => 'Overené';

  @override
  String get verifyStatus_ausgefuellt => 'Vyplnené';

  @override
  String get verifyStatus_abgelehnt => 'Zamietnuté';

  @override
  String get verifyStatus_offen => 'Otvorené';

  @override
  String get fillRequiredFields => 'Vyplňte všetky povinné polia.';

  @override
  String get personalDataSaved => 'Osobné údaje uložené';

  @override
  String get selectMemberType => 'Vyberte typ členstva.';

  @override
  String get memberTypeSaved => 'Typ členstva uložený';

  @override
  String get selectOption => 'Vyberte možnosť.';

  @override
  String get financialSaved => 'Finančná situácia uložená';

  @override
  String get selectPaymentMethod => 'Vyberte platobnú metódu.';

  @override
  String get paymentDataSaved => 'Platobné údaje uložené';

  @override
  String get selectDate => 'Vyberte dátum.';

  @override
  String get membershipStartSaved => 'Začiatok členstva uložený';

  @override
  String get fileTooLarge => 'Súbor je príliš veľký (max. 10 MB).';

  @override
  String get leistungsbescheidUploaded =>
      'Rozhodnutie o dávkach úspešne nahrané';

  @override
  String get verificationProgress => 'Priebeh overenia';

  @override
  String get notApplicable => 'Nepoužiteľné';

  @override
  String get socialBenefitsExempt =>
      'Platobná metóda nie je potrebná pre príjemcov sociálnych dávok.';

  @override
  String get locked => 'Zamknuté';

  @override
  String completePreviousStep(int step) {
    return 'Najprv dokončite krok $step.';
  }

  @override
  String rejectedNote(String note) {
    return 'Zamietnuté: $note';
  }

  @override
  String get waitingForReview => 'Čaká na posúdenie predstavenstvom.';

  @override
  String get stepApproved => 'Tento krok bol skontrolovaný a schválený.';

  @override
  String get changesViaChat => 'Zmeny možné len cez chat.';

  @override
  String get firstNameRequired => 'Meno *';

  @override
  String get lastNameRequired => 'Priezvisko *';

  @override
  String get birthDateLabel => 'Dátum narodenia *';

  @override
  String get streetRequired => 'Ulica *';

  @override
  String get houseNumberRequired => 'Č. *';

  @override
  String get cityRequired => 'Mesto *';

  @override
  String get phoneRequired => 'Telefónne číslo *';

  @override
  String get phonePurpose =>
      'Účel: Kontakt, keď nie ste dostupní cez aplikáciu';

  @override
  String get selectMemberTypePrompt => 'Vyberte požadovaný typ členstva:';

  @override
  String get financialExplanation =>
      'Na overenie nároku na zníženie príspevku potrebujeme nasledujúce informácie. Budú použité výhradne na stanovenie vášho členského príspevku.';

  @override
  String get socialBenefitsQuestion => 'Poberáte v súčasnosti sociálne dávky?';

  @override
  String get optionBuergergeld => 'Áno, občiansky príspevok (Job Center)';

  @override
  String get optionSozialamt => 'Áno, sociálna pomoc (Sociálny úrad)';

  @override
  String get optionNoBenefits => 'Nie, nepoberám sociálne dávky';

  @override
  String get feeExempt => 'Váš mesačný príspevok je: 0,00 €/mesiac';

  @override
  String get uploadLeistungsbescheid => 'Nahrať rozhodnutie o dávkach';

  @override
  String get uploadLeistungsbescheidHint =>
      'Nahrajte aktuálne rozhodnutie o dávkach do 14 dní na potvrdenie oslobodenia od príspevku.';

  @override
  String get allowedFormatsUpload =>
      'Povolené formáty: PDF, JPG, PNG (max. 10 MB)';

  @override
  String get feeRegular => 'Váš mesačný príspevok je: 25,00 €/mesiac';

  @override
  String paymentDayReminder(int day) {
    return 'Budete upozornení $day. deň každého mesiaca.';
  }

  @override
  String get membershipStartPrompt => 'Zvoľte, kedy má začať vaše členstvo.';

  @override
  String get optionAfterVerification => 'Po dokončení overenia';

  @override
  String get optionAfterVerificationDesc =>
      'Členstvo začína odo dňa potvrdenia predstavenstvom.';

  @override
  String get optionRetroFoundation => 'Spätne k dátumu založenia (01.08.2025)';

  @override
  String get optionRetroFoundationDesc =>
      'Stanete sa spätným členom od založenia spolku.';

  @override
  String get optionRetroCustom => 'Spätne k inému dátumu';

  @override
  String get optionRetroCustomDesc => 'Zvoľte dátum medzi 01.08.2025 a dnes.';

  @override
  String get selectDateLabel => 'Vybrať dátum';

  @override
  String get selectDateHint => 'Vyberte dátum...';

  @override
  String get dateNotBefore => 'Nie skôr ako 01.08.2025 (dátum založenia)';

  @override
  String get feeExemptRetro =>
      'Oslobodenie od príspevku: 0,00 € spätne.\nLen dátum členstva je nastavený spätne.';

  @override
  String get retroactiveFees => 'Spätné príspevky';

  @override
  String retroFeeCalculation(
      String from, String to, String months, String total) {
    return 'Obdobie: $from – $to\nMesiace: $months\nPríspevok: $months × 25,00 € = $total €';
  }

  @override
  String get pleaseReadSatzung => 'Prečítajte si stanovy spolku.';

  @override
  String get pleaseReadDatenschutz =>
      'Prečítajte si zásady ochrany osobných údajov.';

  @override
  String get pleaseReadWiderruf => 'Prečítajte si právo na odstúpenie.';

  @override
  String get acceptedAtRegistration => 'Prijaté pri registrácii';

  @override
  String get confirmedByBoard => 'Bude potvrdené po posúdení predstavenstvom.';

  @override
  String get docSatzung => 'Stanovy';

  @override
  String get docDatenschutz => 'Zásady ochrany osobných údajov';

  @override
  String get docWiderruf => 'Právo na odstúpenie';

  @override
  String acceptedAtRegCount(int count) {
    return 'Prijaté pri registrácii ($count/3)';
  }

  @override
  String acceptedOn(String date) {
    return 'Prijaté dňa $date';
  }

  @override
  String get notAccepted => 'Neprijaté';

  @override
  String get statusAccepted => 'Prijaté';

  @override
  String get memberNumberTooLong => 'Číslo člena príliš dlhé (max 20 znakov)';

  @override
  String get onlyUppercaseAndNumbers => 'Povolené sú iba veľké písmená a čísla';

  @override
  String get passwordTooLong => 'Heslo príliš dlhé (max 100 znakov)';

  @override
  String get nameTooLong => 'Meno príliš dlhé (max 100 znakov)';

  @override
  String get emailTooLong => 'E-mail príliš dlhý (max 255 znakov)';

  @override
  String get legalAcknowledgePrefix => 'Oboznámil/a som sa s ';

  @override
  String get legalAcknowledgeSuffix => '.';

  @override
  String get legalStatutesSuffix => ' ICD360S e.V. a uznávam ich za záväzné.';

  @override
  String get legalPleaseReadFirst => '(prosím prečítajte si najskôr)';

  @override
  String get statusActive => 'Aktívny';

  @override
  String get statusSuspended => 'Pozastavený';

  @override
  String get statusNew => 'Nový';

  @override
  String get statusCancelled => 'Zrušený';

  @override
  String get statusDeleted => 'Vymazaný';

  @override
  String get roleMitglied => 'Člen';

  @override
  String get roleVorsitzer => 'Predseda';

  @override
  String get roleStellvertreter => 'Zástupca';

  @override
  String get roleSchatzmeister => 'Pokladník';

  @override
  String get roleSchriftfuehrer => 'Tajomník';

  @override
  String get roleBeisitzer => 'Prísediaci';

  @override
  String get roleKassierer => 'Pokladník';

  @override
  String get roleKassenpruefer => 'Revízor';

  @override
  String get roleEhrenamtlich => 'Dobrovoľník';

  @override
  String get roleMitgliedergruender => 'Zakladajúci člen';

  @override
  String get roleEhrenmitglied => 'Čestný člen';

  @override
  String get roleFoerdermitglied => 'Podporný člen';

  @override
  String get memberTypeNotSet => 'Zatiaľ nenastavené';

  @override
  String get payMethodSepa => 'SEPA inkaso';

  @override
  String get labelStatus => 'Stav';

  @override
  String get labelMemberNumber => 'Číslo člena';

  @override
  String get labelRole => 'Rola';

  @override
  String get labelMemberType => 'Typ členstva';

  @override
  String get labelPaymentMethod => 'Platobná metóda';

  @override
  String get labelRegisteredOn => 'Registrované';

  @override
  String get labelLastLogin => 'Posledné prihlásenie';

  @override
  String get labelMemberSince => 'Členom od';

  @override
  String get neverLoggedIn => 'Nikdy';

  @override
  String get notActivatedYet => 'Zatiaľ neaktivované';

  @override
  String get tabVerification => 'Overenie';

  @override
  String get tabWarnings => 'Varovania';

  @override
  String get tabDocuments => 'Dokumenty';

  @override
  String get tabMembership => 'Členstvo';

  @override
  String get pleaseEnterFirstName => 'Zadajte meno';

  @override
  String get pleaseEnterLastName => 'Zadajte priezvisko';

  @override
  String get noFileDataReceived => 'Žiadne dáta neboli prijaté';

  @override
  String get openFile => 'Otvoriť';

  @override
  String get diagnosticErrors => 'Hlásenia chýb na vylepšenie';

  @override
  String get diagnosticAnonymousStats => 'Anonymné štatistiky používania';

  @override
  String get diagnosticPerformance => 'Údaje o výkone aplikácie';

  @override
  String get noMicrophoneError =>
      'Mikrofón nebol nájdený. Pripojte mikrofón a skúste to znova.';

  @override
  String get startConversation => 'Začnite konverzáciu!';

  @override
  String get staffWillReply => 'Pracovník vám čoskoro odpovie.';

  @override
  String get inCall => 'V hovore...';

  @override
  String get registration => 'Registrácia';

  @override
  String get deactivation => 'Deaktivácia';

  @override
  String get deactivatedOn => 'Deaktivované dňa';

  @override
  String get accountAutoSuspend =>
      'Účty neoverené do 30 dní budú automaticky pozastavené.';

  @override
  String get ipClean => 'IP čistá - neuvedená';

  @override
  String get documentsProvidedByBoard => 'Dokumenty poskytuje predstavenstvo.';

  @override
  String get noDocumentsAvailable => 'Žiadne dokumenty';

  @override
  String get noDocumentsDescription =>
      'Zatiaľ pre vás neboli poskytnuté žiadne dokumenty.';

  @override
  String uploadedBy(String name) {
    return 'Nahrané: $name';
  }

  @override
  String stepsCompleted(int completed, int total) {
    return '$completed/$total krokov dokončených';
  }

  @override
  String dayOfMonth(int day) {
    return '$day. deň v mesiaci';
  }

  @override
  String changeField(String field) {
    return 'Zmeniť $field';
  }

  @override
  String openDocument(String name) {
    return 'Otvoriť $name';
  }

  @override
  String get helpImproveApp => 'Chcete nám pomôcť vylepšiť aplikáciu?';

  @override
  String get noPersonalDataCollected =>
      'Žiadne osobné údaje sa nezhromažďujú. Toto nastavenie je možné kedykoľvek zmeniť.';

  @override
  String logEntries(int count) {
    return '$count záznamov';
  }

  @override
  String get noLogs => 'Žiadne záznamy';

  @override
  String get newLoginDetected => 'Zistené nové prihlásenie';

  @override
  String get waitingForMember => 'Čakanie na člena';

  @override
  String get waitingForStaff => 'Čakanie na pracovníka';

  @override
  String get waitingForAuthority => 'Čakanie na úrad';
}
