// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Slovak (`sk`).
class AppLocalizationsSk extends AppLocalizations {
  AppLocalizationsSk([String locale = 'sk']) : super(locale);

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
  String get confirmPassword => 'Potvrďte heslo';

  @override
  String get confirmPasswordHint => 'Potvrďte heslo';

  @override
  String get newPassword => 'Nové heslo';

  @override
  String get newPasswordHint => 'Zadajte nové heslo';

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
  String get unknown => 'Neznáme';

  @override
  String error(String error) {
    return 'Chyba: $error';
  }

  @override
  String get cancel => 'Zrušiť';

  @override
  String get resetPassword => 'Obnoviť heslo';

  @override
  String get imprint => 'Impressum';

  @override
  String get privacy => 'Ochrana osobných údajov';

  @override
  String get statutes => 'Stanovy';

  @override
  String get revocation => 'Právo na odstúpenie';

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
  String get myAppointments => 'Moje stretnutia';

  @override
  String get priority => 'Priorita';

  @override
  String get messageLabel => 'Správa';

  @override
  String get reportProblems => 'Nahlásiť problémy';

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
  String get low => 'Nízka';

  @override
  String get high => 'Vysoká';

  @override
  String get submit => 'Odoslať';

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
  String get saveEmail => 'Uložiť email';

  @override
  String get savePassword => 'Uložiť heslo';

  @override
  String get deviceLoggedOut => 'Zariadenie odhlásené';

  @override
  String get emailChangedSuccessfully => 'Email úspešne zmenený';

  @override
  String get errorChangingPassword => 'Chyba pri zmene hesla';

  @override
  String get errorChangingEmail => 'Chyba pri zmene emailu';

  @override
  String get validEmailRequired => 'Zadajte platnú emailovú adresu';

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
  String get autoUpdateEnableTitle => 'Install future updates automatically';

  @override
  String get autoUpdateEnableHint =>
      'The app downloads and installs updates on its own and restarts briefly. No further prompts.';

  @override
  String autoUpdateInstalling(String version) {
    return 'Version $version is being installed in the background. The app will restart shortly.';
  }

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
  String get reasonLabel2 => 'Dôvod';

  @override
  String get downloadFailed2 => 'Sťahovanie zlyhalo';

  @override
  String get downloadTooltip => 'Stiahnuť';

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
  String logEntries(int count) {
    return '$count záznamov';
  }

  @override
  String get noLogs => 'Žiadne záznamy';

  @override
  String get newLoginDetected => 'Zistené nové prihlásenie';

  @override
  String get errorNoInternet =>
      'Žiadne pripojenie na internet. Skontrolujte svoju sieť.';

  @override
  String get errorTimeout => 'Server neodpovedá. Skúste to prosím neskôr.';

  @override
  String get errorServer => 'Chyba servera. Skúste to prosím neskôr.';

  @override
  String get errorConnection => 'Chyba pripojenia. Skúste to prosím neskôr.';

  @override
  String get errorUnexpected =>
      'Vyskytla sa neočakávaná chyba. Skúste to prosím neskôr.';

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
  String get claudiuWelcomeMorning => 'Dobré ráno';

  @override
  String get claudiuWelcomeDay => 'Dobrý deň';

  @override
  String get claudiuWelcomeEvening => 'Dobrý večer';

  @override
  String get claudiuWelcomeNight => 'Dobrý večer';

  @override
  String get claudiuWelcomeVisitor => 'milý návštevník';

  @override
  String get claudiuWelcomeAsk => 'Ako ti môžem pomôcť?';

  @override
  String get claudiuWelcomeBecomeMember => 'Chcem sa stať členom';

  @override
  String get claudiuWelcomeLogin => 'Už som členom a chcem sa prihlásiť';

  @override
  String get claudiuWelcomeProblem => 'Mám problém s aplikáciou';

  @override
  String get claudiuWelcomeEmergency => 'Súrne — zavolajte nám';

  @override
  String get claudiuWelcomeMascotName => 'Claudiu';

  @override
  String get claudiuWelcomeEmergencyIntro =>
      'Skôr než zavoláš — naše pracovné hodiny:';

  @override
  String get claudiuWelcomeScheduleOffice => 'V kancelárii';

  @override
  String get claudiuWelcomeScheduleField => 'V teréne s klientmi';

  @override
  String get claudiuWelcomeOutsideHoursNote =>
      'Mimo týchto hodín riešime len naliehavé prípady. Môžeš nám aj poslať SMS na rovnaké číslo — ozveme sa.';

  @override
  String get claudiuWelcomeCallNow => 'Zavolať teraz';

  @override
  String get claudiuWelcomeSendSms => 'Poslať SMS';

  @override
  String get claudiuWelcomeSmsBody =>
      'Naliehavé ICD360S e.V. — prosím, kontaktujte ma čo najskôr.';

  @override
  String get claudiuWelcomeCloseButton => 'Zavrieť';

  @override
  String get claudiuLoginWelcome => 'Vitaj späť, milý člen!';

  @override
  String get claudiuLoginAsk => 'Prosím, povedz mi svoje členské číslo.';

  @override
  String get claudiuLoginProgress => 'Skoro… píš ďalej.';

  @override
  String get claudiuLoginReady => 'Perfektné! Stlač tlačidlo nižšie.';

  @override
  String get claudiuLoginLoading => 'Overujem identitu… 🔍';

  @override
  String get claudiuLoginFoundPlain => 'Našiel som ťa! Prihlasujem…';

  @override
  String claudiuLoginFoundNamed(String name) {
    return 'Našiel som ťa, $name! Prihlasujem…';
  }

  @override
  String get claudiuLoginError =>
      'Hm, to číslo neviem nájsť. Napísal si ho správne?';

  @override
  String get claudiuLoginForgotHeader => 'Zabudol si členské číslo?';

  @override
  String get claudiuLoginNoSms => 'Číslo neposielame e-mailom ani SMS.';

  @override
  String get claudiuLoginOnlyWay =>
      'Jediná cesta: osobné stretnutie v kancelárii združenia, po overení občianskeho preukazu.';

  @override
  String get claudiuLoginContactUs => 'Zavolaj a dohodni si stretnutie:';

  @override
  String get claudiuDiagnosticGreeting =>
      'Skôr než vojdeš, jedna rýchla otázka';

  @override
  String get claudiuDiagnosticAsk =>
      'Môžem posielať anonymné správy, aby vývojári mohli zlepšiť aplikáciu?';

  @override
  String get claudiuDiagnosticYes => 'Áno, rád pomôžem';

  @override
  String get claudiuDiagnosticNo => 'Nie, len sa rozhliadam';

  @override
  String get claudiuDiagnosticTellMore => 'Povedz mi viac';

  @override
  String get claudiuDiagnosticSendsHeader => '📤 Čo POSIELAME (anonymne):';

  @override
  String get claudiuDiagnosticSends1 =>
      'Anonymný kód zariadenia (NIE členské číslo)';

  @override
  String get claudiuDiagnosticSends2 => 'Tvoja rola (člen / predstavenstvo)';

  @override
  String get claudiuDiagnosticSends3 =>
      'Operačný systém (Linux / Android / iOS / Windows)';

  @override
  String get claudiuDiagnosticSends4 => 'Zvolený jazyk';

  @override
  String get claudiuDiagnosticSends5 => 'Stav batérie a nabitie';

  @override
  String get claudiuDiagnosticSends6 => 'Aktuálna obrazovka';

  @override
  String get claudiuDiagnosticSends7 => 'Dĺžka relácie (sekundy)';

  @override
  String get claudiuDiagnosticSends8 => 'Chyby, ak nejaké sú (posledných 10)';

  @override
  String get claudiuDiagnosticSends9 => 'Navigácia (posledných 20 obrazoviek)';

  @override
  String get claudiuDiagnosticNeverHeader => '🛡️ Čo NIKDY neposielame:';

  @override
  String get claudiuDiagnosticNever1 => 'Tvoje skutočné meno';

  @override
  String get claudiuDiagnosticNever2 => 'E-mailová adresa';

  @override
  String get claudiuDiagnosticNever3 => 'Telefónne číslo';

  @override
  String get claudiuDiagnosticNever4 => 'Heslo';

  @override
  String get claudiuDiagnosticNever5 => 'Obsah chatových správ';

  @override
  String get claudiuDiagnosticNever6 => 'Obsah tikiet';

  @override
  String get claudiuDiagnosticNever7 => 'Dokumenty alebo prílohy';

  @override
  String get claudiuDiagnosticTechHeader => '📡 Technické detaily:';

  @override
  String get claudiuDiagnosticTech1 => 'Odosielané každé 2 minúty';

  @override
  String get claudiuDiagnosticTech2 =>
      'TLS-šifrované spojenie s pripnutým certifikátom';

  @override
  String get claudiuDiagnosticTech3 =>
      'Kedykoľvek to môžeš vypnúť v Nastaveniach';

  @override
  String get claudiuProblemHelpTitle => 'Ako môžem pomôcť?';

  @override
  String get claudiuProblemHelpGreeting => 'Čo sa stalo?';

  @override
  String get claudiuProblemHelpAsk => 'Ako mi to chceš povedať?';

  @override
  String get claudiuProblemHelpWriteTitle => 'Napísať správu';

  @override
  String get claudiuProblemHelpWriteBody =>
      'S podrobnosťami krok za krokom. Tím dostane text a vyrieši to neskôr.';

  @override
  String get claudiuProblemHelpChatTitle => 'Porozprávajme sa teraz';

  @override
  String get claudiuProblemHelpChatBody =>
      'Anonymný chat s operátorom. Odpoveď v reálnom čase, ak je niekto online.';

  @override
  String get claudiuProblemHelpAltCallHeader => 'Alebo, ak je to naliehavé:';

  @override
  String get claudiuProblemHelpAltCallLabel => 'Zavolajte nám';

  @override
  String get claudiuAnonymousChatTitle => 'Anonymný chat';

  @override
  String get claudiuAnonymousChatGreeting => 'Ahoj!';

  @override
  String get claudiuAnonymousChatWelcome =>
      'Počúvam. Napíš čokoľvek — meno netreba. Odpoviem hneď, ako budem.';

  @override
  String get claudiuAnonymousChatHint => 'Napíš správu…';

  @override
  String get claudiuAnonymousChatWaitingOperator =>
      'Čakáme na odpoveď operátora…';

  @override
  String get claudiuVorsitzerConnectedTitle => 'Ahoj!';

  @override
  String get claudiuVorsitzerConnectedBody =>
      'Ďakujeme, že si nám napísal — teraz si v spojení s Vorsitzerom. Napíš, s čím ti môžeme pomôcť ohľadom prihlášky o členstvo.';

  @override
  String get claudiuVorsitzerConnectedSender => 'Vorsitzer';

  @override
  String get claudiuQuickReplyValidationTime => 'Ako dlho trvá overenie?';

  @override
  String get claudiuQuickReplyDocuments => 'Aké dokumenty potrebujem?';

  @override
  String get claudiuQuickReplyStepProblem => 'Zasekol som sa pri jednom kroku';

  @override
  String get claudiuQuickReplyHuman => 'Môžem teraz s niekým hovoriť?';

  @override
  String get claudiuAnonymousChatConnecting => 'Pripájanie…';

  @override
  String get claudiuAnonymousChatConnectionFailed =>
      'Nepodarilo sa otvoriť chat. Skús znova alebo zavolaj.';

  @override
  String get claudiuAnonymousChatRetry => 'Skúsiť znova';

  @override
  String get claudiuAnonymousChatOnline => 'Pripojené';

  @override
  String get claudiuAnonymousChatOffline => 'Opätovné pripájanie…';

  @override
  String get claudiuAnonymousChatAdminTyping => 'Operátor píše…';

  @override
  String get claudiuProblemReportTitle => 'Nahlásiť problém';

  @override
  String get claudiuProblemReportGreeting => 'Čo sa stalo?';

  @override
  String get claudiuProblemReportAsk =>
      'Povedz mi to podrobne a ja pošlem správu tímu.';

  @override
  String get claudiuProblemReportIncludeHeader => 'Prosím uveď:';

  @override
  String get claudiuProblemReportIncludeBullets1 =>
      'Čo si robil, keď sa problém objavil';

  @override
  String get claudiuProblemReportIncludeBullets2 =>
      'Akékoľvek chybové hlásenie, ktoré si videl';

  @override
  String get claudiuProblemReportIncludeBullets3 =>
      'Na ktorej obrazovke si bol';

  @override
  String get claudiuProblemReportIncludeBullets4 =>
      'Aplikácia padá, zatvára sa alebo ukazuje biele okno?';

  @override
  String get claudiuProblemReportIncludeBullets5 =>
      'Stáva sa to zakaždým alebo len raz?';

  @override
  String get claudiuProblemReportDescriptionLabel => 'Tvoj popis';

  @override
  String get claudiuProblemReportDescriptionHint =>
      'Napr.: Po otvorení chatu sa objaví „Connection error\" a aplikácia prestane reagovať…';

  @override
  String claudiuProblemReportTooShort(int count) {
    return 'Trochu viac detailov, prosím (aspoň $count znakov)';
  }

  @override
  String get claudiuProblemReportSubmit => 'Odoslať správu';

  @override
  String get claudiuProblemReportSubmitting => 'Odosiela sa…';

  @override
  String get claudiuProblemReportSentTitle => 'Ďakujem!';

  @override
  String get claudiuProblemReportSentBody =>
      'Správa bola odoslaná. Náš tím sa na to pozrie čo najskôr.';

  @override
  String get claudiuProblemReportSentClose => 'Rozumiem';

  @override
  String get claudiuProblemReportSendFailed =>
      'Správu sa nepodarilo odoslať. Zavolaj nám pre naliehavú pomoc.';

  @override
  String get claudiuProblemReportAlt => 'Alebo, ak je to naliehavé:';

  @override
  String get claudiuProblemReportCallLabel => 'Zavolajte nám';

  @override
  String claudiuApprovalGreeting(String name) {
    return 'Ahoj, $name! 👋';
  }

  @override
  String get claudiuApprovalGreetingNoName => 'Ahoj! 👋';

  @override
  String get claudiuApprovalGladToSeeYou => 'Rád ťa vidím!';

  @override
  String get claudiuApprovalCheckingForSafety =>
      'Pre tvoju bezpečnosť Vorsitzer práve kontroluje tvoju žiadosť o prihlásenie. 🛡️';

  @override
  String get claudiuApprovalMonthlyExplain =>
      '💡 Robíme to každých 30 dní, aby sme sa uistili, že si to naozaj ty. Je to ako bezpečnostná kontrola — maximálne 5 minút.';

  @override
  String get claudiuApprovalSuccess =>
      'Hotovo! 🎉 Vorsitzer ťa rozpoznal. Prihlasujem ťa…';

  @override
  String get claudiuApprovalDenied =>
      'Hm, Vorsitzer odmietol tvoju žiadosť. 😔';

  @override
  String get claudiuApprovalDeniedHelp =>
      'Ak si myslíš, že je to omyl, zavolaj nám, aby sme to vyriešili.';

  @override
  String get claudiuApprovalExpired =>
      '5 minút uplynulo a od Vorsitzera neprišla odpoveď.';

  @override
  String get claudiuApprovalExpiredHelp =>
      'Zavolaj nám a môžeme tvoju žiadosť schváliť priamo. 📞';

  @override
  String get claudiuApprovalCallUs => 'Zavolajte nám';

  @override
  String get claudiuApprovalTryAgain => 'Skúsiť znova';

  @override
  String get claudiuApprovalCancel => 'Zrušiť';

  @override
  String get claudiuApprovalClose => 'Zavrieť';

  @override
  String get wizardIntroBubble1 =>
      'Ahoj, návštevník! 👋 Ďakujem, že sa chceš stať súčasťou našej rodiny.';

  @override
  String get wizardIntroBubble2 =>
      'Volám sa Claudiu. Na jar 2025 som mal jasnú víziu: vytvoriť združenie, ktoré pomáha ľuďom v núdzi — dobrovoľne, zo srdca, bez zbytočnej byrokracie. ❤️';

  @override
  String get wizardIntroBubble3 =>
      'Začal som hovoriť s klientmi, ktorých som navštevoval. Povedal som im svoj sen. A každý povedal: „Áno, ideme do toho!\" V júli 2025 sme sa stretli — 6 odhodlaných ľudí. Rozhodli sme sa založiť **ICD360S e.V.** v Neu-Ulme. 📍';

  @override
  String get wizardIntroBubble4 =>
      '**1. augusta 2025** sa združenie oficiálne narodilo — v Registri združení. Môj najkrajší darček. 🎂';

  @override
  String get wizardIntroBubble5 =>
      'Čo robíme? Pomáhame utečencom, ľuďom so zdravotným postihnutím, ekonomicky znevýhodneným, **deťom a mladým** — s úradnými záležitosťami, nemčinou, bývaním, nákupmi, sociálnymi dávkami. Náš Vorstand tvoria väčšinou ľudia so zdravotným postihnutím — rozhodnutia tak vychádzajú z reálnej životnej skúsenosti. 🤝';

  @override
  String get wizardIntroBubble6 =>
      'Teraz si na rade ty. Poďme ťa zaregistrovať — trvá to asi 5 minút. Pôjdeme krok za krokom, nenechám ťa v tom samého. ✨';

  @override
  String get wizardIntroStart => 'Začnime';

  @override
  String get wizardBack => 'Späť';

  @override
  String get wizardNext => 'Ďalej';

  @override
  String wizardStepLabel(int step, int total, String title) {
    return 'Krok $step z $total · $title';
  }

  @override
  String get wizardErrRequired => 'Toto pole je povinné';

  @override
  String wizardErrTooShort(int count) {
    return 'Príliš krátke (aspoň $count znakov)';
  }

  @override
  String get wizardErrOnlyLetters =>
      'Iba písmená, medzery, pomlčky a apostrofy';

  @override
  String get wizardErrSaveFailed =>
      'Uloženie zlyhalo. Skontroluj pripojenie a skús znova.';

  @override
  String get wizardStufe1aTitle => 'Identita';

  @override
  String get wizardStufe1aPrompt =>
      'Spoznajme sa oficiálne. Napíš svoje meno presne tak, ako je na Personalausweis, Reisepass alebo Aufenthaltstitel — aby sedelo s dokladmi.';

  @override
  String get wizardStufe1aVornameLabel => 'Vornamen (krstné mená)';

  @override
  String get wizardStufe1aVornameHelper =>
      'Všetky tvoje krstné mená presne ako na doklade. S medzerou alebo pomlčkou (napr. Hans-Peter, Maria Anna).';

  @override
  String get wizardStufe1aNachnameLabel => 'Familienname (priezvisko)';

  @override
  String get wizardStufe1aNachnameHelper => 'Tvoje súčasné priezvisko.';

  @override
  String get wizardStufe1aGeburtsnameLabel =>
      'Geburtsname (rodné priezvisko) — voliteľné';

  @override
  String get wizardStufe1aGeburtsnameHelper =>
      'Iba ak sa líši od Familienname — napr. pred svadbou.';

  @override
  String get wizardStufe1bTitle => 'Narodeniny';

  @override
  String get wizardStufe1bPrompt =>
      'Radi by sme s tebou oslávili tvoje narodeniny! 🎂 A pomáha nám overiť, že máš aspoň 16 — tak to hovoria naše stanovy.';

  @override
  String get wizardStufe1bGeburtsdatumLabel => 'Dátum narodenia';

  @override
  String get wizardStufe1bGeburtsdatumHelper => 'Klepnutím vyber dátum';

  @override
  String get wizardStufe1bGeburtsortLabel => 'Miesto narodenia';

  @override
  String get wizardStufe1bGeburtsortHelper =>
      'Mesto / miesto, kde si sa narodil.';

  @override
  String get wizardAgeGatePrompt => 'Mrzí ma to… 😔';

  @override
  String wizardAgeGateBody1(int age, int years) {
    return 'Naše stanovy hovoria, že musíš mať aspoň 16 rokov, aby si bol členom. Máš $age — dúfam, že sa uvidíme o $years rokov! 🌱';
  }

  @override
  String get wizardAgeGateBody2 =>
      'Ak chceš príležitostne pomáhať ako dobrovoľník (akýkoľvek vek, so súhlasom rodičov), zavolaj — radi podporujeme mladých, ktorí chcú meniť svet.';

  @override
  String get wizardAgeGateBackHome => 'Späť na úvod';

  @override
  String get wizardErrInvalidPhone => 'Neplatné telefónne číslo';

  @override
  String get wizardStufe1b1Title => 'Súhlas rodiča';

  @override
  String get wizardStufe1b1Prompt =>
      'Si maloletý (16-17) — podľa §106 BGB potrebujeme súhlas rodiča alebo zákonného zástupcu. Povedz mi meno a telefónne číslo. Vorsitzer zavolá a dohodne stretnutie (osobne alebo videohovorom). Žiadny e-mail — chceme mať istotu, že hovoríme so správnou osobou.';

  @override
  String get wizardStufe1b1VornameLabel => 'Meno rodiča';

  @override
  String get wizardStufe1b1VornameHelper => 'Ako na Personalausweis rodiča.';

  @override
  String get wizardStufe1b1NachnameLabel => 'Priezvisko rodiča';

  @override
  String get wizardStufe1b1NachnameHelper => 'Ako na Personalausweis rodiča.';

  @override
  String get wizardStufe1b1TelefonLabel => 'Mobilné číslo rodiča';

  @override
  String get wizardStufe1b1TelefonHelper => 'Na toto číslo zavolá Vorsitzer.';

  @override
  String get wizardStufe1b1RelationLabel => 'Vzťah k dieťaťu:';

  @override
  String get wizardStufe1b1RelationMutter => 'Matka';

  @override
  String get wizardStufe1b1RelationVater => 'Otec';

  @override
  String get wizardStufe1b1RelationSorgeberechtigter => 'Zákonný zástupca';

  @override
  String get wizardStufe1b1RelationAndere => 'Iný zástupca';

  @override
  String get wizardStufe1cTitle => 'Osobné údaje';

  @override
  String get wizardStufe1cPrompt =>
      'Len aby som ťa trochu lepšie spoznal. Toto zostáva medzi nami a nezobrazí sa nikde verejne.';

  @override
  String get wizardStufe1cGeschlechtLabel => 'Pohlavie';

  @override
  String get wizardStufe1cGeschlechtMaennlich => 'Muž';

  @override
  String get wizardStufe1cGeschlechtWeiblich => 'Žena';

  @override
  String get wizardStufe1cGeschlechtDivers => 'Iné';

  @override
  String get wizardStufe1cGeschlechtKeineAngabe => 'Neuvedené';

  @override
  String get wizardStufe1cFamilienstandLabel => 'Rodinný stav';

  @override
  String get wizardStufe1cFamilienstandLedig => 'Slobodný/á';

  @override
  String get wizardStufe1cFamilienstandVerheiratet => 'Ženatý / Vydatá';

  @override
  String get wizardStufe1cFamilienstandGeschieden => 'Rozvedený/á';

  @override
  String get wizardStufe1cFamilienstandVerwitwet => 'Vdovec / Vdova';

  @override
  String get wizardStufe1dTitle => 'Tvoj pôvod';

  @override
  String get wizardStufe1dPrompt =>
      'Pomáha nám to ponúknuť ti tú pravú podporu — napríklad poradenstvo k pobytu (Aufenthalt) alebo nájsť tvoju jazykovú komunitu.';

  @override
  String get wizardStufe1dStaatLabel => 'Štátne občianstvo';

  @override
  String get wizardStufe1dStaatHelper =>
      'Napr. deutsch, rumänisch, ukrainisch. Viaceré oddeliť čiarkou.';

  @override
  String get wizardStufe1dAufenthaltLabel =>
      'Status pobytu (Aufenthaltsstatus) — voliteľné';

  @override
  String get wizardStufe1dAufenthaltHelper =>
      'Vyber titul zo svojej Aufenthaltskarte / rozhodnutia. Vorstand to porovná s tvojimi dokumentmi.';

  @override
  String get wizardStufe1dAufenthaltAwaitingCitizenship =>
      'Najprv vyplň štátnu príslušnosť vyššie — zobrazíme len vhodné možnosti.';

  @override
  String get wizardStufe1dAufenthaltGerman =>
      'Aufenthaltstitel netreba — nemecký občan.';

  @override
  String get wizardStufe1dAufenthaltEuEea =>
      'Občan EÚ/EHP/CH — voľný pohyb (Freizügigkeit).';

  @override
  String get wizardStufe1dAufenthaltTempHint => 'dočasný';

  @override
  String get wizardStufe1dAufenthaltPermHint => 'trvalý pobyt';

  @override
  String get wizardStufe1dAufenthaltAsylumProcessHint => 'azylové konanie';

  @override
  String get wizardStufe1dAufenthaltOther => 'Iné (upresni v chate)';

  @override
  String get wizardStufe1dAufenthaltRequired =>
      'Vyber prosím Aufenthaltstitel.';

  @override
  String get wizardStufe1dMutterspracheLabel => 'Materinský jazyk';

  @override
  String get wizardStufe1dMutterspracheHelper =>
      'Predvyplnené jazykom aplikácie — zmeň ak je iný.';

  @override
  String get wizardStufe1eTitle => 'Adresa';

  @override
  String get wizardStufe1ePrompt =>
      'Tvoja poštová adresa — používame ju pre oficiálne dokumenty (stanovy, členské zmluvy, oznámenia).';

  @override
  String get wizardStufe1eStrasseLabel => 'Ulica';

  @override
  String get wizardStufe1eStrasseHelper =>
      'Iba názov ulice — číslo do vedľajšieho poľa.';

  @override
  String get wizardStufe1eHausnummerLabel => 'Č.';

  @override
  String get wizardStufe1ePlzLabel => 'PLZ (PSČ)';

  @override
  String get wizardStufe1eOrtLabel => 'Mesto';

  @override
  String get wizardStufe1eLandLabel => 'Krajina';

  @override
  String get wizardStufe1eLandHelper => 'Predvyplnené: Deutschland.';

  @override
  String get wizardErrInvalidStreet => 'Neplatný názov ulice';

  @override
  String get wizardErrInvalidHausnummer =>
      'Neplatné číslo (napr. 12, 12a, 12/3)';

  @override
  String get wizardErrInvalidPlz => 'Neplatné PSČ (iba číslice)';

  @override
  String get wizardStufe1fTitle => 'Kontakt';

  @override
  String get wizardStufe1fPrompt =>
      'Ako ťa zastihneme? Telefón je len na naliehavé prípady — všetko ostatné ide cez náš vlastný end-to-end šifrovaný kanál v aplikácii. Tvoj členský e-mail sa priraďuje automaticky a uvidíš ho nižšie.';

  @override
  String get wizardStufe1fTelefonLabel => 'Mobilné číslo';

  @override
  String get wizardStufe1fTelefonHelper =>
      'Sľubujem, zavolám len keď to bude dôležité. 📱';

  @override
  String get wizardStufe2Title => 'Typ členstva';

  @override
  String get wizardStufe2Prompt =>
      'Akým členom chceš byť? Vysvetlím ti každú možnosť.';

  @override
  String get wizardStufe2OrdentlichTitle => 'Riadny člen (ordentlich)';

  @override
  String get wizardStufe2OrdentlichBody =>
      'Plné práva. Platíš mesačný príspevok, hlasuješ na členskej schôdzi, môžeš byť zvolený do predstavenstva. Predvolená voľba.';

  @override
  String get wizardStufe2FoerderTitle => 'Podporujúci člen (Fördermitglied)';

  @override
  String get wizardStufe2FoerderBody =>
      'Podporuješ združenie finančne, ale aktívne sa nezúčastňuješ rozhodovania. Bez hlasovacieho práva. Dobré, ak chceš pomáhať na diaľku.';

  @override
  String get wizardStufe2EhrenTitle => 'Čestný člen (Ehrenmitglied)';

  @override
  String get wizardStufe2EhrenBody =>
      'Udeľuje predstavenstvo za zvláštne zásluhy. Nevyberáš si ho sám — udeľuje sa ako uznanie. Zvoľ len ak ti už táto pocta bola udelená.';

  @override
  String get wizardStufe3Title => 'Finančná situácia';

  @override
  String get wizardStufe3Prompt =>
      'Teraz k tvojej finančnej situácii. Nie aby som súdil — ale aby sme ťa oslobodili od príspevku, ak poberáš sociálne dávky.';

  @override
  String get wizardStufe3OptionBuergergeld => 'Poberám Bürgergeld';

  @override
  String get wizardStufe3OptionSozialamt => 'Dostávam dávky od Sozialamtu';

  @override
  String get wizardStufe3OptionNein => 'Nepoberám žiadne z týchto';

  @override
  String get wizardStufe3FeeExemptTitle => 'Príspevok: 0 € / mesiac 🎉';

  @override
  String get wizardStufe3FeeExemptBody =>
      'S Bürgergeldom, Sozialamtom, ALG I alebo Krankengeldom si podľa Satzung §6 úplne oslobodený od príspevku. Potrebujeme len doklad (Leistungsbescheid alebo potvrdenie od úradu / zdravotnej poisťovne).';

  @override
  String get wizardStufe3UploadTitle => 'Nahrať Leistungsbescheid';

  @override
  String get wizardStufe3UploadHint => 'PDF / JPG / PNG, max 10 MB.';

  @override
  String get wizardStufe3UploadRequired =>
      'Prosím, pred pokračovaním nahraj Leistungsbescheid.';

  @override
  String get wizardStufe3FileTooLarge =>
      'Súbor je príliš veľký. Maximálne 10 MB.';

  @override
  String get wizardStufe3UploadFailed =>
      'Súbor sa nepodarilo nahrať. Skús to znova.';

  @override
  String get wizardStufe3RegularFeeTitle => 'Príspevok: 25 € / mesiac';

  @override
  String get wizardStufe3RegularFeeBody =>
      'Štandardný príspevok pre riadnych členov podľa stanov.';

  @override
  String get wizardStufe4Title => 'Platba';

  @override
  String get wizardStufe4Prompt =>
      'Ako chceš platiť príspevok? A v ktorý deň v mesiaci?';

  @override
  String get wizardStufe4MethodUeberweisungTitle =>
      'Bankový prevod (Überweisung)';

  @override
  String get wizardStufe4MethodUeberweisungBody =>
      'Platbu zadávaš sám každý mesiac zo svojho účtu.';

  @override
  String get wizardStufe4MethodSepaTitle => 'SEPA-Lastschrift (inkaso)';

  @override
  String get wizardStufe4MethodSepaBody =>
      'Strhneme sumu automaticky z tvojho účtu. Najpohodlnejšie, ale potrebujeme IBAN a podpísané poverenie.';

  @override
  String get wizardStufe4MethodDauerauftragTitle =>
      'Dauerauftrag (trvalý príkaz)';

  @override
  String get wizardStufe4MethodDauerauftragBody =>
      'Nastavíš trvalý príkaz vo svojej banke. Banka prevedie sumu automaticky každý mesiac.';

  @override
  String get wizardStufe4DayLabel => 'Deň platby';

  @override
  String get wizardStufe4DayHint => 'Vyber deň medzi 1 a 31';

  @override
  String wizardStufe4DayItem(int day) {
    return '$day. deň';
  }

  @override
  String wizardStufe4DayReminder(int day) {
    return 'Príspevok sa bude strhávať $day. deň každého mesiaca.';
  }

  @override
  String get wizardStufe5Title => 'Začiatok';

  @override
  String get wizardStufe5Prompt =>
      'Odkedy chceš byť oficiálne členom ICD360S? Od schválenia alebo spätne.';

  @override
  String get wizardStufe5OptionAbVerifizierungTitle =>
      'Od schválenia predstavenstvom';

  @override
  String get wizardStufe5OptionAbVerifizierungBody =>
      'Najjednoduchšia voľba. Žiadny spätný príspevok.';

  @override
  String get wizardStufe5OptionGruendungsdatumTitle =>
      'Spätne od 01.08.2025 (založenie)';

  @override
  String get wizardStufe5OptionGruendungsdatumBody =>
      'Budeš sa počítať za člena od prvého dňa združenia.';

  @override
  String get wizardStufe5OptionAnderesDatumTitle => 'Iný dátum';

  @override
  String get wizardStufe5OptionAnderesDatumBody =>
      'Sám si vyberáš dátum medzi 01.08.2025 a dneškom.';

  @override
  String get wizardStufe5PickDate => 'Klepnutím vyber dátum';

  @override
  String get wizardStufe5PickDateFirst => 'Najprv vyber dátum.';

  @override
  String get wizardStufe5DatePickerHelp => 'Začiatok členstva';

  @override
  String wizardStufe5DateRange(String start) {
    return 'Medzi $start a dnešným dňom';
  }

  @override
  String get wizardStufe5RetroactiveTitle => 'Spätný príspevok';

  @override
  String wizardStufe5RetroactiveBody(
      String start, String end, int months, String amount) {
    return 'Od $start do $end je to $months mesiacov. Pri 25 €/mesiac to robí $amount € spätne, navyše k aktuálnemu mesačnému príspevku.';
  }

  @override
  String get wizardStufe5FeeExemptTitle => 'Spätný príspevok: 0 € 🎉';

  @override
  String get wizardStufe5FeeExemptBody =>
      'S Bürgergeld alebo Sozialamtom si úplne oslobodený — ani spätne nič nedlhuješ.';

  @override
  String wizardDocumentPrompt(String doc) {
    return 'Než to uzavrieme, prosím pozorne si prečítaj $doc. Je dôležité vedieť, čo podpisuješ.';
  }

  @override
  String get wizardDocumentScrollHint =>
      'Posuň na koniec, aby si mohol pokračovať.';

  @override
  String get wizardDocumentScrolledOk => 'Prečítal si až do konca ✓';

  @override
  String wizardDocumentOpenButton(String doc) {
    return 'Otvoriť $doc v prehliadači';
  }

  @override
  String get wizardDocumentExternalHint =>
      'Na tejto platforme otvárame dokument vo vašom predvolenom prehliadači.';

  @override
  String get wizardDocumentOpenedOk =>
      'Dokument bol otvorený. Pozorne si ho prečítaj.';

  @override
  String wizardDocumentConfirm(String doc) {
    return 'Potvrdzujem, že som si prečítal(a) $doc a súhlasím s ňou.';
  }

  @override
  String get wizardFinalAdultTitle => 'Hotovo! Si zaregistrovaný 🎉';

  @override
  String get wizardFinalMinorTitle => 'Tvoja žiadosť bola odoslaná 📨';

  @override
  String get wizardFinalMinorBody =>
      'Spojíme sa s tvojím rodičom a dohodneme stretnutie (osobne alebo videohovorom). Prosíme o trpezlivosť — proces môže trvať až 7 dní. Dostaneš upozornenie v aplikácii, len čo rodič schváli.';

  @override
  String get wizardFinalMitgliedernummerLabel => 'Tvoje členské číslo';

  @override
  String get wizardStufe4MethodComingSoon => 'Čoskoro';

  @override
  String get wizardStufe4StreichungWarning =>
      'Ak budeš v meškaní s príspevkom viac ako 6 mesiacov, automaticky ťa vyškrtneme (Satzung §6 Abs. 3).';

  @override
  String get wizardStufe5KuendigungInfo =>
      'Na vystúpenie: pošli nám výpoveď písomne 3 mesiace pred 31. decembrom (do 30. septembra, aby bola účinná na konci roka). Žiadna minimálna doba (Satzung §6 Abs. 3).';

  @override
  String get wizardStufe1fEmailLabel => 'Tvoj členský e-mail';

  @override
  String get wizardStufe1fEmailHelper =>
      'Priraďuje sa automaticky podľa tvojho členského čísla. Aktivuje sa vo chvíli, keď predstavenstvo (Vorstand) schváli tvoju prihlášku. Máme vlastnú e-mailovú aplikáciu — posielaj a prijímaj šifrované e-maily, jednoducho a zadarmo.';

  @override
  String get wizardErrInvalidEmail => 'Neplatná e-mailová adresa';

  @override
  String get wizardStufe3OptionAlg1 =>
      'Poberám Arbeitslosengeld I (ALG I, podpora v nezamestnanosti)';

  @override
  String get wizardStufe3OptionKrankengeld =>
      'Poberám Krankengeld (nemocenské po dlhšej PN)';

  @override
  String get wizardStufe3UploadAddMore => 'Pridať ďalší dokument';

  @override
  String get wizardStufe3UploadLimitCount =>
      'Dosiahnutý limit: najviac 20 dokumentov.';

  @override
  String get wizardStufe3UploadLimitTotal =>
      'Dosiahnutý celkový limit 100 MB. Vymaž existujúci súbor.';

  @override
  String get wizardStufe3UploadDeleteTooltip => 'Vymazať';

  @override
  String wizardStufe3UploadCounter(int count, int max) {
    return '$count / $max dokumentov';
  }

  @override
  String get wizardDocumentExternalOpenFailed =>
      'Nepodarilo sa otvoriť prehliadač. Odkaz bol skopírovaný do schránky — vlož ho do prehliadača, aby si pokračoval.';

  @override
  String get wizardFinalTimelineProcessing =>
      'Vorstand kontroluje · zvyčajne 1 pracovný deň, max. 7';

  @override
  String get wizardFinalTimelineActivated => 'Účet aktivovaný';

  @override
  String get wizardFinalAdultThank =>
      'Ďakujeme, že si vyplnil registračný formulár! 🎉';

  @override
  String get wizardFinalAdultUsual =>
      'Tvoja žiadosť je u nás. Zvyčajne ju overujeme do jedného pracovného dňa.';

  @override
  String get wizardFinalAdultExceptional =>
      'Niekedy to môže trvať až 7 pracovných dní. A ak niečo nesedí, pošleme ťa späť do formulára, aby si to opravil 🙂';

  @override
  String get wizardFinalStatusTitle => 'STAV ŽIADOSTI';

  @override
  String wizardFinalStatusStepsValidated(int reviewed, int total) {
    return '$reviewed/$total krokov overených predstavenstvom Vorstand';
  }

  @override
  String get wizardFinalStufeSheetTitle => 'Detaily žiadosti';

  @override
  String get wizardFinalStufeSheetHint =>
      'Osem fáz, ktoré si vyplnil. Vorstand ich kontroluje jednu po druhej — vidíš v reálnom čase, čo už bolo schválené.';

  @override
  String get wizardFinalStufeStatusPending => 'Čaká na kontrolu';

  @override
  String get wizardFinalStufeStatusApproved => 'Schválené';

  @override
  String get wizardFinalStufeStatusRejected => 'Zamietnuté';

  @override
  String wizardFinalStatusRejectionCount(int count) {
    return '$count krok vyžaduje opravu';
  }

  @override
  String get wizardFinalStufeRejectionReason => 'Dôvod od Vorstandu:';

  @override
  String get wizardFinalStufeCorrectNow => 'Opraviť teraz';

  @override
  String wizardFinalApprovalsHeader(int current, int total) {
    return 'Schválenia Vorstandu ($current/$total)';
  }

  @override
  String get wizardFinalApprovalAwaiting => 'Čaká sa na 2. Vorstand';

  @override
  String get wizardFinalApprovalRejected => 'ZAMIETNUTÉ';

  @override
  String get wizardFinalStufeNoDataYet => 'Údaje zatiaľ nie sú k dispozícii.';

  @override
  String get wizardFinalStufeReadAt => 'Prečítané:';

  @override
  String get wizardFinalStufeBeitragsfrei =>
      'Oslobodené od príspevku (bez platby)';

  @override
  String get wizardFinalStufeNotExempt => 'Bez sociálnych dávok';

  @override
  String get wizardFinalStufeBeginAtVerification => 'Začína overením';

  @override
  String get wizardFinalStufeBeginAtFoundation => 'Dátum založenia (spätne)';

  @override
  String get wizardFinalStufeBeginAtCustom => 'Iný dátum';

  @override
  String get wizardFinalStufeStatusSkipped => 'Preskočené';

  @override
  String get wizardFinalStufeFilledAt => 'Vyplnené:';

  @override
  String get wizardFinalStufeReviewedAt => 'Skontrolované:';

  @override
  String get wizardFinalWithdrawLink => 'Zrušiť žiadosť';

  @override
  String get wizardFinalWithdrawDialogTitle => 'Zrušiť žiadosť?';

  @override
  String get wizardFinalWithdrawDialogBody =>
      'Tvoja žiadosť bude označená ako zrušená tebou. Údaje zostávajú v databáze na audit (GDPR), ale účet nebude aktivovaný. Registráciu môžeš kedykoľvek začať odznova s novým členským číslom.';

  @override
  String get wizardFinalWithdrawKeep => 'Nie, počkám';

  @override
  String get wizardFinalWithdrawConfirm => 'Áno, zrušiť';

  @override
  String get wizardErrTooManyWithdrawals =>
      'Tvoju žiadosť nemožno spracovať automaticky. Zavolaj nám alebo príď osobne k Vorstandu, aby si pokračoval v registrácii.';

  @override
  String get wizardDuplicateLoginTitle => 'Vyzerá to, že si už naším členom';

  @override
  String get wizardDuplicateLoginBody =>
      'Podľa tvojho mena a dátumu narodenia už nájdeme aktívny účet. Použi \"Som už členom\" na úvodnej obrazovke, aby si sa prihlásil. Ak nemáš prístup, zavolaj nám.';

  @override
  String get wizardDuplicatePendingTitle => 'Tvoja žiadosť je už u nás';

  @override
  String get wizardDuplicatePendingBody =>
      'Podľa tvojho mena a dátumu narodenia už máme žiadosť v posudzovaní. Vorstand na nej pracuje — pošleme ti oznámenie v aplikácii, hneď ako bude tvoj účet aktívny. Zavolaj, ak chceš pokecať.';

  @override
  String get wizardDuplicateRecentlyWithdrawnTitle =>
      'Túto žiadosť teraz nemôžeme spracovať';

  @override
  String get wizardDuplicateRecentlyWithdrawnBody =>
      'Tvoje meno a dátum narodenia sa zhodujú s nedávno zrušenou žiadosťou. Zavolaj nám, aby si pred pokračovaním hovoril s Vorstandom.';

  @override
  String get wizardDuplicatePreviouslyWithdrawnTitle =>
      'Už si v minulosti žiadosť podal';

  @override
  String get wizardDuplicatePreviouslyWithdrawnBody =>
      'Tvoje meno a dátum narodenia sa zhodujú so staršou žiadosťou, ktorú si zrušil. Vitaj späť — zavolaj nám pred pokračovaním, aby Vorstand rozhodol, ako pôjdeme ďalej.';

  @override
  String get wizardDuplicateCallUsTitle => 'Prosím, zavolaj nám';

  @override
  String get wizardDuplicateCallUsBody =>
      'Tvoje meno a dátum narodenia sa už nachádzajú u nás, ale detaily cez aplikáciu zdieľať nemôžeme. Zavolaj nám — Vorstand ti situáciu vysvetlí osobne.';

  @override
  String get wizardChatHelp => 'Pohovorme si';

  @override
  String get wizardChatHelpSubtitle =>
      'Živý chat s Vorstandom · rýchla odpoveď';

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

  @override
  String get benachrichtigungWetterFrage =>
      'Möchten Sie bei Unwetter an Ihrem Wohnort gewarnt werden?';

  @override
  String get benachrichtigungWetterDetail =>
      'Nur amtliche Warnungen des Deutschen Wetterdienstes ab Stufe „schwer“ — nicht bei jedem Regen.';

  @override
  String get signaturTitel => 'Unterschriften';

  @override
  String get signaturNichtsOffen =>
      'Zurzeit liegt nichts zur Unterschrift vor.';

  @override
  String get signaturStatusOffen => 'Wartet auf Ihre Unterschrift';

  @override
  String get signaturStatusSigniert => 'Von Ihnen unterschrieben';

  @override
  String get signaturStatusAbgelehnt => 'Von Ihnen abgelehnt';

  @override
  String get signaturStatusWiderrufen => 'Vom Verein zurückgezogen';

  @override
  String get signaturStatusAbgelaufen => 'Frist abgelaufen';

  @override
  String signaturBitteGanzLesen(int gelesen, int gesamt) {
    return 'Bitte lesen Sie das Dokument bis zum Ende (Seite $gelesen von $gesamt).';
  }

  @override
  String get signaturWeiterZurUnterschrift => 'Weiter zur Unterschrift';

  @override
  String get signaturAblehnen => 'Ablehnen';

  @override
  String get signaturAblehnenHinweis =>
      'Der Verein wird darüber benachrichtigt. Sie können Ihre Gründe angeben.';

  @override
  String get signaturAblehnenGrund => 'Grund (freiwillig)';

  @override
  String get signaturMitFingerHinweis =>
      'Unterschreiben Sie mit dem Finger im weißen Feld.';

  @override
  String get signaturNochmal => 'Noch einmal';

  @override
  String get signaturZurueckZumDokument => 'Zurück zum Dokument';

  @override
  String get signaturCodeAnfordern => 'Code per SMS anfordern';

  @override
  String get signaturCodeUnterwegs => 'Der Code ist unterwegs.';

  @override
  String signaturCodeGesendetAn(String nummer) {
    return 'Wir haben Ihnen einen Code an $nummer geschickt.';
  }

  @override
  String get signaturCodeErneutSenden => 'Code erneut senden';

  @override
  String get signaturJetztUnterschreiben => 'Jetzt unterschreiben';

  @override
  String get signaturCodeFalsch => 'Der Code stimmt nicht.';

  @override
  String get signaturCodeAbgelaufen =>
      'Der Code ist abgelaufen. Bitte fordern Sie einen neuen an.';

  @override
  String get signaturZuVieleVersuche =>
      'Zu viele Fehlversuche. Bitte fordern Sie einen neuen Code an.';

  @override
  String get signaturKeineRufnummer =>
      'Für Ihr Konto ist keine Mobilnummer hinterlegt. Ohne sie können wir Ihnen keinen Code schicken — bitte wenden Sie sich an den Vorsitzenden.';

  @override
  String get signaturCodeFehlgeschlagen =>
      'Der Code konnte nicht verschickt werden.';

  @override
  String get signaturLeer => 'Bitte unterschreiben Sie zuerst.';

  @override
  String get signaturErfolg => 'Danke — Ihre Unterschrift ist eingegangen.';

  @override
  String get signaturFehlgeschlagen =>
      'Das hat nicht geklappt. Bitte versuchen Sie es noch einmal.';
}
