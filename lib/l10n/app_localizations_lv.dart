// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Latvian (`lv`).
class AppLocalizationsLv extends AppLocalizations {
  AppLocalizationsLv([String locale = 'lv']) : super(locale);

  @override
  String get welcomeLoading => 'Ielādē...';

  @override
  String get welcomeAutoLogin => 'Automātiska pieteikšanās...';

  @override
  String get login => 'Pieteikties';

  @override
  String get register => 'Reģistrēties';

  @override
  String get becomeMember => 'Kļūt par biedru';

  @override
  String get memberNumber => 'Biedra numurs';

  @override
  String get memberNumberHint => 'Ievadiet biedra numuru';

  @override
  String get confirmPassword => 'Apstiprināt paroli';

  @override
  String get confirmPasswordHint => 'Apstipriniet paroli';

  @override
  String get newPassword => 'Jauna parole';

  @override
  String get newPasswordHint => 'Ievadiet jaunu paroli';

  @override
  String get firstName => 'Vārds un uzvārds';

  @override
  String get firstNameHint => 'Ievadiet vārdu un uzvārdu';

  @override
  String get nameMinLength => 'Vārdam jābūt vismaz 2 rakstzīmēm';

  @override
  String get nameOnlyLetters => 'Atļauti tikai burti un defises';

  @override
  String get email => 'E-pasta adrese';

  @override
  String get emailHint => 'Ievadiet e-pastu';

  @override
  String get emailInvalid => 'Ievadiet derīgu e-pasta adresi';

  @override
  String get passwordMinLength => 'Parolei jābūt vismaz 6 rakstzīmēm';

  @override
  String get passwordsNotMatch => 'Paroles nesakrīt';

  @override
  String get registrationFailed => 'Reģistrācija neizdevās';

  @override
  String connectionError(String error) {
    return 'Savienojuma kļūda: $error';
  }

  @override
  String registrationSuccess(String memberNumber) {
    return 'Reģistrācija veiksmīga!\n\nJūsu biedra numurs: $memberNumber\n\nAtcerieties šo numuru pieteikšanai.';
  }

  @override
  String get unknown => 'Nezināms';

  @override
  String error(String error) {
    return 'Kļūda: $error';
  }

  @override
  String get cancel => 'Atcelt';

  @override
  String get resetPassword => 'Atiestatīt paroli';

  @override
  String get imprint => 'Impressum';

  @override
  String get privacy => 'Privātuma politika';

  @override
  String get statutes => 'Statūti';

  @override
  String get revocation => 'Atteikuma tiesības';

  @override
  String get appointments => 'Tikšanās';

  @override
  String get tickets => 'Pieteikumi';

  @override
  String get liveChat => 'Tiešsaistes čats';

  @override
  String get notifications => 'Paziņojumi';

  @override
  String get myProfile => 'Mans Profils';

  @override
  String get logout => 'Izrakstīties';

  @override
  String get goodMorning => 'Labrīt';

  @override
  String get goodDay => 'Labdien';

  @override
  String get goodEvening => 'Labvakar';

  @override
  String get goodNight => 'Ar labu nakti';

  @override
  String get welcomeToICD => 'Laipni lūdzam ICD360S e.V!';

  @override
  String get accountCreatedSuccessfully => 'Jūsu konts ir veiksmīgi izveidots.';

  @override
  String get today => 'Šodien';

  @override
  String get membershipFeeDue => 'Biedru nauda jāmaksā';

  @override
  String get pleaseTransferAnnualFee => 'Lūdzu, pārskaitiet gada maksu.';

  @override
  String get newBadge => 'Jauns';

  @override
  String get close => 'Aizvērt';

  @override
  String get myAppointments => 'Mani tikšanās';

  @override
  String get priority => 'Prioritāte';

  @override
  String get messageLabel => 'Ziņojums';

  @override
  String get reportProblems => 'Ziņot par problēmām';

  @override
  String get weRespondIn24Hours =>
      'Mēs jums atbildēsim maksimāli 24 stundu laikā!';

  @override
  String get everythingOk => 'Viss kārtībā!';

  @override
  String get haveProblemWeHelp => 'Ir problēma?\nMēs par to parūpēsimies!';

  @override
  String get myMembership => 'Mana dalība';

  @override
  String get managePersonalDataAndFee => 'Pārvaldīt personas datus un maksu';

  @override
  String get myAppointmentsTitle => 'Mani tikšanās';

  @override
  String get appointmentsDescription =>
      'Šeit varat redzēt savus gaidāmos tikšanās.\nVarat apstiprināt savu dalību vai atteikties.';

  @override
  String get loadAppointments => 'Ielādēt tikšanās';

  @override
  String get myTickets => 'Manas pieteikumi';

  @override
  String get low => 'Zems';

  @override
  String get high => 'Augsts';

  @override
  String get submit => 'Iesniegt';

  @override
  String get errorCreatingTicket => 'Kļūda, izveidojot pieteikumu';

  @override
  String get verified => 'Pārbaudīts';

  @override
  String get account => 'Konts';

  @override
  String get myDevices => 'Manas ierīces';

  @override
  String get changeEmail => 'Mainīt e-pastu';

  @override
  String get changePassword => 'Mainīt paroli';

  @override
  String get saveEmail => 'Saglabāt e-pastu';

  @override
  String get savePassword => 'Saglabāt paroli';

  @override
  String get deviceLoggedOut => 'Ierīce atteikta';

  @override
  String get emailChangedSuccessfully => 'E-pasts veiksmīgi mainīts';

  @override
  String get errorChangingPassword => 'Kļūda, mainot paroli';

  @override
  String get errorChangingEmail => 'Kļūda, mainot e-pastu';

  @override
  String get validEmailRequired => 'Lūdzu, ievadiet derīgu e-pasta adresi';

  @override
  String get confirmLogoutDevice => 'Iziet no ierīces?';

  @override
  String get confirmLogoutMessage =>
      'Vai vēlaties iziet no šīs ierīces?\n\nJums būs jāpiesakās vēlreiz, lai izmantotu šo ierīci.';

  @override
  String get ipAddress => 'IP';

  @override
  String get platform => 'Platforma';

  @override
  String trialWarningUrgentTitle(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'Atlikušas $days dienas',
      one: 'Atlicis 1 diena',
    );
    return 'Uzmanību: $_temp0 līdz konta apturēšanai!';
  }

  @override
  String get trialWarningTitle => 'Jūsu konts vēl nav verificēts';

  @override
  String get trialWarningDescription =>
      'Lūdzu, aizpildiet savus datus sadaļā \"Mans profils\". Pēc 30 dienām jūsu konts tiks automātiski apturēts.';

  @override
  String trialDaysRemaining(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days dienas',
      one: '1 diena',
    );
    return '$_temp0';
  }

  @override
  String get overview => 'Pārskats';

  @override
  String get member => 'Biedrs';

  @override
  String get memberManagement => 'Biedru pārvaldība';

  @override
  String get reportProblemTooltip => 'Ziņot par problēmu';

  @override
  String get newAppointmentsTitle => 'Jaunas tikšanās';

  @override
  String get youHaveNewAppointment => 'Jums ir jauna tikšanās.';

  @override
  String youHaveNewAppointments(int count) {
    return 'Jums ir $count jaunas tikšanās.';
  }

  @override
  String get appointmentReminderTomorrow => 'Atgādinājums: Tikšanās rīt';

  @override
  String tomorrowAppointment(String title) {
    return 'Rīt: $title';
  }

  @override
  String youHaveTomorrowAppointments(int count) {
    return 'Jums ir $count tikšanās rīt.';
  }

  @override
  String get appointmentsToday => 'Tikšanās šodien';

  @override
  String todayAppointment(String title) {
    return 'Šodien: $title';
  }

  @override
  String youHaveTodayAppointments(int count) {
    return 'Jums ir $count tikšanās šodien.';
  }

  @override
  String get paymentReminder => 'Maksājuma atgādinājums';

  @override
  String paymentReminderMessage(int day, String method) {
    return 'Šodien ir mēneša $day. datums – lūdzu, pabeidziet $method.';
  }

  @override
  String get paymentDayLabel => 'Maksājuma diena (ikmēneša atgādinājums)';

  @override
  String get updateAvailable => 'Pieejams atjauninājums';

  @override
  String newVersionAvailable(String version) {
    return 'Pieejama jauna versija: $version';
  }

  @override
  String currentVersionLabel(String version) {
    return 'Pašreizējā versija: $version';
  }

  @override
  String get changes => 'Izmaiņas:';

  @override
  String downloadProgress(String percent) {
    return 'Lejupielāde: $percent%';
  }

  @override
  String get installationStarting => 'Sākas instalēšana...';

  @override
  String get appWillRestart => 'Lietotne tiks automātiski restartēta.';

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
  String get later => 'Vēlāk';

  @override
  String get updateNow => 'Atjaunināt tagad';

  @override
  String get downloading => 'Lejupielādē...';

  @override
  String get downloadFailed => 'Lejupielāde neizdevās. Lūdzu, mēģiniet vēlāk.';

  @override
  String get searchingForUpdates => 'Meklē atjauninājumus...';

  @override
  String get appUpToDate => 'Lietotne ir atjaunināta';

  @override
  String get updateCheckError => 'Kļūda pārbaudot atjauninājumus';

  @override
  String get changelog => 'Izmaiņu žurnāls';

  @override
  String get terminConfirmed => 'Tikšanās apstiprināta';

  @override
  String get terminDeclined => 'Tikšanās noraidīta';

  @override
  String get terminRescheduleRequested => 'Pieprasīta pārcelšana';

  @override
  String get statusConfirmed => 'Apstiprināts';

  @override
  String get statusDeclined => 'Noraidīts';

  @override
  String get statusRescheduling => 'Pārcelšana';

  @override
  String get statusPending => 'Gaida';

  @override
  String get categoryVorstandssitzung => 'Valdes sēde';

  @override
  String get categoryMitgliederversammlung => 'Kopsapulce';

  @override
  String get categorySchulung => 'Apmācība';

  @override
  String get categorySonstiges => 'Cits';

  @override
  String openCount(int count) {
    return '$count atvērti';
  }

  @override
  String get refresh => 'Atjaunināt';

  @override
  String get filterUpcoming => 'Gaidāmie';

  @override
  String get filterPast => 'Pagātnes';

  @override
  String get filterAll => 'Visi';

  @override
  String get noUpcomingAppointments => 'Nav gaidāmu tikšanos';

  @override
  String get noPastAppointments => 'Nav pagātnes tikšanos';

  @override
  String get noAppointmentsAvailable => 'Nav tikšanos';

  @override
  String get appointmentsShownHere => 'Jūsu tikšanās tiks parādītas šeit';

  @override
  String get dateLabel => 'Datums';

  @override
  String get timeLabel => 'Laiks';

  @override
  String get locationLabel => 'Vieta';

  @override
  String get createdByLabel => 'Izveidoja';

  @override
  String get descriptionLabel => 'Apraksts';

  @override
  String get ticketLabel => 'Pieteikums';

  @override
  String get yourStatus => 'Jūsu statuss: ';

  @override
  String reasonLabel(String reason) {
    return 'Iemesls: $reason';
  }

  @override
  String durationMinutes(int minutes) {
    return '$minutes min';
  }

  @override
  String get confirm => 'Apstiprināt';

  @override
  String get decline => 'Noraidīt';

  @override
  String get reschedule => 'Pārcelt';

  @override
  String get requestReschedule => 'Pieprasīt pārcelšanu';

  @override
  String appointmentLabel(String title) {
    return 'Tikšanās: $title';
  }

  @override
  String get rescheduleReason => 'Pārcelšanas iemesls *';

  @override
  String get rescheduleReasonHint => 'Norādiet iemeslu...';

  @override
  String get pleaseProvideReason => 'Norādiet iemeslu';

  @override
  String get request => 'Pieprasīt';

  @override
  String get ticketStatusOpen => 'Atvērts';

  @override
  String get ticketStatusInProgress => 'Apstrādē';

  @override
  String get ticketStatusWaitingMember => 'Gaida biedru';

  @override
  String get ticketStatusWaitingStaff => 'Gaida darbinieku';

  @override
  String get ticketStatusWaitingAuthority => 'Gaida iestādi';

  @override
  String get ticketStatusDone => 'Pabeigts';

  @override
  String get ticketPriorityHigh => 'Augsta';

  @override
  String get ticketPriorityMedium => 'Vidēja';

  @override
  String get ticketPriorityLow => 'Zema';

  @override
  String get comments => 'Komentāri';

  @override
  String get documents => 'Dokumenti';

  @override
  String get details => 'Detaļas';

  @override
  String get replySent => 'Atbilde nosūtīta';

  @override
  String get sendError => 'Sūtīšanas kļūda';

  @override
  String get uploading => 'Augšupielāde...';

  @override
  String fileUploaded(String filename) {
    return '$filename augšupielādēts';
  }

  @override
  String get uploadFailed => 'Augšupielāde neizdevās';

  @override
  String get openError => 'Atvēršanas kļūda';

  @override
  String get noRepliesYet => 'Vēl nav atbilžu';

  @override
  String get waitingForSupport => 'Gaida atbalsta atbildi';

  @override
  String get writeReply => 'Rakstīt atbildi...';

  @override
  String get attachFile => 'Pievienot failu';

  @override
  String documentsCount(int count) {
    return 'Dokumenti ($count)';
  }

  @override
  String get upload => 'Augšupielādēt';

  @override
  String get noDocuments => 'Nav dokumentu';

  @override
  String get allowedFormats => 'Atļautie formāti: PDF, JPEG, JPG, TXT, ZIP';

  @override
  String get yourMessage => 'Jūsu ziņojums:';

  @override
  String get translation => 'Tulkojums';

  @override
  String get original => 'Oriģināls';

  @override
  String get originalText => 'Oriģinālais teksts';

  @override
  String get autoTranslated => 'Automātiski tulkots';

  @override
  String get originalTapTranslation => 'Oriģināls · Pieskarieties tulkojumam';

  @override
  String get translatedTapOriginal => 'Tulkots · Pieskarieties oriģinālam';

  @override
  String get justNow => 'Tikko';

  @override
  String minutesAgo(int minutes) {
    return 'pirms $minutes min';
  }

  @override
  String hoursAgo(int hours) {
    return 'pirms $hours stundām';
  }

  @override
  String daysAgo(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'dienām',
      one: 'dienas',
    );
    return 'pirms $days $_temp0';
  }

  @override
  String get createdLabel => 'Izveidots';

  @override
  String get updatedLabel => 'Atjaunināts';

  @override
  String get handlerLabel => 'Apstrādātājs';

  @override
  String get doneLabel => 'Pabeigts';

  @override
  String get newTicketTitle => 'Jauns pieteikums';

  @override
  String get categoryOptional => 'Kategorija (neobligāti)';

  @override
  String get selectCategory => 'Izvēlēties';

  @override
  String get subjectLabel => 'Tēma';

  @override
  String get fillAllFields => 'Aizpildiet visus laukus';

  @override
  String ticketCreatedId(int id) {
    return 'Pieteikums #$id izveidots';
  }

  @override
  String get priorityLabel => 'Prioritāte: ';

  @override
  String get supportOffline => 'Atbalsts bezsaistē';

  @override
  String get lastSeenSeconds => 'Aktīvs pirms dažām sekundēm';

  @override
  String lastSeenMinutes(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: 'minūtēm',
      one: 'minūtes',
    );
    return 'Aktīvs pirms $minutes $_temp0';
  }

  @override
  String lastSeenHours(int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: 'stundām',
      one: 'stundas',
    );
    return 'Aktīvs pirms $hours $_temp0';
  }

  @override
  String lastSeenDays(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'dienām',
      one: 'dienas',
    );
    return 'Aktīvs pirms $days $_temp0';
  }

  @override
  String get online => 'Tiešsaistē';

  @override
  String get callSupport => 'Zvanīt';

  @override
  String get typeMessage => 'Rakstiet ziņojumu...';

  @override
  String get callBusy => 'Atbalsts ir aizņemts';

  @override
  String get callRejected => 'Zvans noraidīts';

  @override
  String get callFailed => 'Zvanu neizdevās savienot';

  @override
  String get callEnded => 'Zvans beidzies';

  @override
  String get callSupportBusy => 'Atbalsts jau ir citā zvanā';

  @override
  String get errorStartingChat => 'Kļūda sākot tērzēšanu';

  @override
  String get errorStartingCall => 'Kļūda sākot zvanu';

  @override
  String get errorConnecting => 'Savienojuma kļūda';

  @override
  String get errorDownloading => 'Lejupielādes kļūda';

  @override
  String get errorUploading => 'Augšupielādes kļūda';

  @override
  String get errorSending => 'Sūtīšanas kļūda';

  @override
  String get errorPickingPhotos => 'Kļūda izvēloties fotogrāfijas';

  @override
  String get errorPickingFiles => 'Kļūda izvēloties failus';

  @override
  String get errorTakingPhoto => 'Kļūda fotografējot';

  @override
  String get fileNotLoaded => 'Failu neizdevās ielādēt';

  @override
  String get attachmentIdMissing => 'Trūkst pielikuma ID';

  @override
  String get camera => 'Kamera';

  @override
  String get gallery => 'Galerija';

  @override
  String get file => 'Fails';

  @override
  String get notifNewMessageFrom => 'Jauna ziņa no';

  @override
  String get notifUrgentPrefix => 'STEIDZAMI';

  @override
  String get notifUrgentMessage => 'STEIDZAMS ZIŅOJUMS';

  @override
  String get notifIncomingCall => 'Ienākošais zvans';

  @override
  String get notifCallingYou => 'zvana...';

  @override
  String get notifUpdateAvailable => 'Pieejams atjauninājums';

  @override
  String get notifVersionAvailable => 'tagad ir pieejama';

  @override
  String get notifConnected => 'Savienots';

  @override
  String get notifDisconnected => 'Atvienots';

  @override
  String get notifConnectedBody => 'Esat savienots ar serveri.';

  @override
  String get notifDisconnectedBody => 'Savienojums ar serveri tika pārtraukts.';

  @override
  String get notifError => 'Kļūda';

  @override
  String get retry => 'Mēģināt vēlreiz';

  @override
  String get save => 'Saglabāt';

  @override
  String get accept => 'Pieņemt';

  @override
  String get selectFile => 'Izvēlēties failu';

  @override
  String get dataLoadingText => 'Datu ielāde...';

  @override
  String get dataSavedSuccess => 'Dati veiksmīgi saglabāti';

  @override
  String get errorSaving => 'Saglabāšanas kļūda';

  @override
  String get errorLoading => 'Ielādes kļūda';

  @override
  String savedFilename(String filename) {
    return 'Saglabāts: $filename';
  }

  @override
  String get logsCopied => 'Žurnāli nokopēti!';

  @override
  String get passwordMinEightChars => 'Parolei jābūt vismaz 8 rakstzīmēm';

  @override
  String get passwordChangeSuccess => 'Parole veiksmīgi nomainīta';

  @override
  String get emailChangeError => 'Kļūda mainot e-pastu';

  @override
  String get acceptDocumentCheckbox => 'Esmu izlasījis un pieņemu dokumentu.';

  @override
  String loadingErrorGeneric(String details) {
    return 'Ielādes kļūda: $details';
  }

  @override
  String get incomingCallTitle => 'Ienākošais zvans';

  @override
  String ringingFor(int seconds) {
    return 'Zvana ${seconds}s';
  }

  @override
  String get rejectCall => 'Noraidīt';

  @override
  String get acceptCall => 'Atbildēt';

  @override
  String get unmute => 'Ieslēgt skaņu';

  @override
  String get mute => 'Izslēgt skaņu';

  @override
  String get hangUp => 'Nolikt klausuli';

  @override
  String get calling => 'Zvana...';

  @override
  String autoRejectIn(int seconds) {
    return 'Automātiska noraidīšana pēc $seconds sekundēm';
  }

  @override
  String get speakerOn => 'Skaļrunis';

  @override
  String get speakerOff => 'Austiņa';

  @override
  String get micMuted => 'Izslēgts';

  @override
  String get micOn => 'Mikrofons';

  @override
  String get connectionExcellent => 'Izcils';

  @override
  String get connectionGood => 'Labs';

  @override
  String get connectionWeak => 'Vājš';

  @override
  String get connectionLost => 'Atvienots';

  @override
  String get personalData => 'Personas dati';

  @override
  String get personalDataSubtitle => 'Vārds, uzvārds, adrese';

  @override
  String get membershipFee => 'Biedra maksa';

  @override
  String annualFeeYear(String year) {
    return 'Gada maksa $year';
  }

  @override
  String get amount => 'Summa:';

  @override
  String get dueBy => 'Termiņš:';

  @override
  String get paid => 'Samaksāts';

  @override
  String get versionHistory => 'Versiju vēsture';

  @override
  String lastUpdated(String date) {
    return 'Pēdējoreiz atjaunināts: $date';
  }

  @override
  String get noVersionHistory => 'Versiju vēsture nav pieejama';

  @override
  String get failedLoadChangelog => 'Neizdevās ielādēt izmaiņu žurnālu';

  @override
  String get callMember => 'Zvanīt biedram';

  @override
  String get closeConversation => 'Aizvērt sarunu';

  @override
  String get chatOffline => 'Bezsaistē';

  @override
  String get attachFiles => 'Pievienot failus (maks. 10, 50MB)';

  @override
  String get conversationClosed => 'Šī saruna ir aizvērta';

  @override
  String get noMessages => 'Nav ziņojumu';

  @override
  String get goBack => 'Atpakaļ';

  @override
  String get goForward => 'Uz priekšu';

  @override
  String get homePage => 'Sākumlapa';

  @override
  String get firstNameLabel => 'Vārds';

  @override
  String get lastNameLabel => 'Uzvārds';

  @override
  String get streetLabel => 'Iela';

  @override
  String get houseNumberLabel => 'Nr.';

  @override
  String get postalCodeLabel => 'Pasta indekss';

  @override
  String get cityLabel => 'Pilsēta';

  @override
  String get phoneMobileLabel => 'Tālrunis (Mobilais)';

  @override
  String get phoneLandlineLabel => 'Tālrunis (Fiksētais)';

  @override
  String get newEmailLabel => 'Jauna e-pasta adrese';

  @override
  String get currentPasswordLabel => 'Pašreizējā parole';

  @override
  String get newPasswordLabel => 'Jauna parole';

  @override
  String get confirmPasswordLabel => 'Apstiprināt paroli';

  @override
  String get emailChangedSuccess => 'E-pasts nomainīts';

  @override
  String get reasonLabel2 => 'Iemesls';

  @override
  String get downloadFailed2 => 'Lejupielāde neizdevās';

  @override
  String get downloadTooltip => 'Lejupielādēt';

  @override
  String get copyLogs => 'Kopēt žurnālus';

  @override
  String get deleteLogs => 'Dzēst žurnālus';

  @override
  String get autoScrollOn => 'Automātiskā ritināšana IESL';

  @override
  String get autoScrollOff => 'Automātiskā ritināšana IZSL';

  @override
  String get unknownValue => 'Nezināms';

  @override
  String get payment => 'Maksājums';

  @override
  String get warningType_ermahnung => 'Brīdinājums';

  @override
  String get warningType_abmahnung => 'Aizrādījums';

  @override
  String get warningType_letzte => 'Pēdējais brīdinājums';

  @override
  String warningsTotal(int count) {
    return 'Kopā: $count';
  }

  @override
  String warningsErmahnung(int count) {
    return 'Brīdinājumi: $count';
  }

  @override
  String warningsAbmahnung(int count) {
    return 'Aizrādījumi: $count';
  }

  @override
  String warningsLetzte(int count) {
    return 'Pēdējie: $count';
  }

  @override
  String get noWarnings => 'Nav brīdinājumu';

  @override
  String get noWarningsDescription => 'Jums pašlaik nav brīdinājumu.';

  @override
  String createdBy(String name) {
    return 'Izveidoja: $name';
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
  String get monthMay => 'Mai';

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
  String get stufe1_name => 'Personas dati';

  @override
  String get stufe2_name => 'Dalības veids';

  @override
  String get stufe3_name => 'Finansiālā situācija';

  @override
  String get stufe4_name => 'Maksājuma veids';

  @override
  String get stufe5_name => 'Dalības sākums';

  @override
  String get stufe6_name => 'Statūti';

  @override
  String get stufe7_name => 'Privātuma politika';

  @override
  String get stufe8_name => 'Atteikuma tiesības';

  @override
  String get memberType_ordentlich => 'Parastais biedrs';

  @override
  String get memberType_foerder => 'Atbalstītājs biedrs';

  @override
  String get memberType_ehren => 'Goda biedrs';

  @override
  String get memberDesc_ordentlich =>
      'Aktīvs biedrs ar balsstiesībām. Piedalās biedrības pakalpojumos (e-pasts, mākonis, birokrātiskais atbalsts).';

  @override
  String get memberDesc_foerder =>
      'Atbalsta biedrību ar iemaksām. Var piedalīties biedru sapulcē ar padomdevēja balsi, bez balsstiesībām vai tiesībām tikt ievēlētam valdē.';

  @override
  String get memberDesc_ehren =>
      'Ir parastā biedra tiesības bez pienākuma maksāt biedra naudu. Iecelts no biedru sapulces vai valdes.';

  @override
  String get payMethod_ueberweisung => 'Bankas pārskaitījums';

  @override
  String get payMethod_dauerauftrag => 'Pastāvīgais maksājums';

  @override
  String get verifyStatus_geprueft => 'Pārbaudīts';

  @override
  String get verifyStatus_ausgefuellt => 'Aizpildīts';

  @override
  String get verifyStatus_abgelehnt => 'Noraidīts';

  @override
  String get verifyStatus_offen => 'Atvērts';

  @override
  String get fillRequiredFields => 'Aizpildiet visus obligātos laukus.';

  @override
  String get personalDataSaved => 'Personas dati saglabāti';

  @override
  String get selectMemberType => 'Izvēlieties dalības veidu.';

  @override
  String get memberTypeSaved => 'Dalības veids saglabāts';

  @override
  String get selectOption => 'Izvēlieties variantu.';

  @override
  String get financialSaved => 'Finansiālā situācija saglabāta';

  @override
  String get selectPaymentMethod => 'Izvēlieties maksājuma veidu.';

  @override
  String get paymentDataSaved => 'Maksājuma dati saglabāti';

  @override
  String get selectDate => 'Izvēlieties datumu.';

  @override
  String get membershipStartSaved => 'Dalības sākums saglabāts';

  @override
  String get fileTooLarge => 'Fails ir pārāk liels (maks. 10 MB).';

  @override
  String get leistungsbescheidUploaded =>
      'Pabalstu apliecība veiksmīgi augšupielādēta';

  @override
  String get verificationProgress => 'Verifikācijas progress';

  @override
  String get notApplicable => 'Nav piemērojams';

  @override
  String get socialBenefitsExempt =>
      'Maksājuma veids nav nepieciešams sociālo pabalstu saņēmējiem.';

  @override
  String get locked => 'Bloķēts';

  @override
  String completePreviousStep(int step) {
    return 'Vispirms pabeidziet soli $step.';
  }

  @override
  String rejectedNote(String note) {
    return 'Noraidīts: $note';
  }

  @override
  String get waitingForReview => 'Gaida valdes pārskatu.';

  @override
  String get stepApproved => 'Šis solis ir pārskatīts un apstiprināts.';

  @override
  String get changesViaChat => 'Izmaiņas iespējamas tikai caur čatu.';

  @override
  String get firstNameRequired => 'Vārds *';

  @override
  String get lastNameRequired => 'Uzvārds *';

  @override
  String get birthDateLabel => 'Dzimšanas datums *';

  @override
  String get streetRequired => 'Iela *';

  @override
  String get houseNumberRequired => 'Nr. *';

  @override
  String get cityRequired => 'Pilsēta *';

  @override
  String get phoneRequired => 'Tālruņa numurs *';

  @override
  String get phonePurpose =>
      'Mērķis: Kontakts, kad nav sasniedzams caur lietotni';

  @override
  String get selectMemberTypePrompt => 'Izvēlieties vēlamo dalības veidu:';

  @override
  String get financialExplanation =>
      'Lai pārbaudītu, vai jums pienākas maksas samazinājums, mums nepieciešama šāda informācija. Tā tiks izmantota tikai jūsu biedra naudas noteikšanai.';

  @override
  String get socialBenefitsQuestion =>
      'Vai jūs pašlaik saņemat sociālos pabalstus?';

  @override
  String get optionBuergergeld => 'Jā, pilsoņu pabalsts (Job Center)';

  @override
  String get optionSozialamt => 'Jā, sociālā palīdzība (Sociālais dienests)';

  @override
  String get optionNoBenefits => 'Nē, es nesaņemu sociālos pabalstus';

  @override
  String get feeExempt => 'Jūsu ikmēneša maksa ir: 0,00 €/mēnesī';

  @override
  String get uploadLeistungsbescheid => 'Augšupielādēt pabalstu apliecību';

  @override
  String get uploadLeistungsbescheidHint =>
      'Augšupielādējiet aktuālu pabalstu apliecību 14 dienu laikā, lai apstiprinātu atbrīvojumu no maksas.';

  @override
  String get allowedFormatsUpload =>
      'Atļautie formāti: PDF, JPG, PNG (maks. 10 MB)';

  @override
  String get feeRegular => 'Jūsu ikmēneša maksa ir: 25,00 €/mēnesī';

  @override
  String paymentDayReminder(int day) {
    return 'Jums tiks atgādināts katra mēneša $day. datumā.';
  }

  @override
  String get membershipStartPrompt => 'Izvēlieties, kad jāsākas jūsu dalībai.';

  @override
  String get optionAfterVerification => 'Pēc verifikācijas pabeigšanas';

  @override
  String get optionAfterVerificationDesc =>
      'Dalība sākas no valdes apstiprināšanas dienas.';

  @override
  String get optionRetroFoundation =>
      'Ar atpakaļejošu spēku līdz dibināšanas datumam (01.08.2025)';

  @override
  String get optionRetroFoundationDesc =>
      'Jūs kļūstat par biedru ar atpakaļejošu spēku no biedrības dibināšanas.';

  @override
  String get optionRetroCustom => 'Ar atpakaļejošu spēku līdz citam datumam';

  @override
  String get optionRetroCustomDesc =>
      'Izvēlieties datumu no 01.08.2025 līdz šodienai.';

  @override
  String get selectDateLabel => 'Izvēlieties datumu';

  @override
  String get selectDateHint => 'Izvēlieties datumu...';

  @override
  String get dateNotBefore => 'Ne agrāk par 01.08.2025 (dibināšanas datums)';

  @override
  String get feeExemptRetro =>
      'Atbrīvojums no maksas: 0,00 € ar atpakaļejošu spēku.\nTikai dalības datums tiek iestatīts ar atpakaļejošu spēku.';

  @override
  String get retroactiveFees => 'Atpakaļejošas maksas';

  @override
  String retroFeeCalculation(
      String from, String to, String months, String total) {
    return 'Periods: $from – $to\nMēneši: $months\nMaksa: $months × 25,00 € = $total €';
  }

  @override
  String get pleaseReadSatzung => 'Izlasiet biedrības statūtus.';

  @override
  String get pleaseReadDatenschutz => 'Izlasiet privātuma politiku.';

  @override
  String get pleaseReadWiderruf => 'Izlasiet atteikuma tiesības.';

  @override
  String get acceptedAtRegistration => 'Pieņemts reģistrācijā';

  @override
  String get confirmedByBoard => 'Tiks apstiprināts pēc valdes pārskata.';

  @override
  String get docSatzung => 'Statūti';

  @override
  String get docDatenschutz => 'Privātuma politika';

  @override
  String get docWiderruf => 'Atteikuma tiesības';

  @override
  String acceptedAtRegCount(int count) {
    return 'Pieņemts reģistrācijā ($count/3)';
  }

  @override
  String acceptedOn(String date) {
    return 'Pieņemts $date';
  }

  @override
  String get notAccepted => 'Nav pieņemts';

  @override
  String get statusAccepted => 'Pieņemts';

  @override
  String get nameTooLong => 'Vārds pārāk garš (maks. 100 rakstzīmes)';

  @override
  String get emailTooLong => 'E-pasts pārāk garš (maks. 255 rakstzīmes)';

  @override
  String get legalAcknowledgePrefix => 'Esmu iepazinies ar ';

  @override
  String get legalAcknowledgeSuffix => '.';

  @override
  String get legalStatutesSuffix =>
      ' ICD360S e.V. un atzīstu tos par saistošiem.';

  @override
  String get legalPleaseReadFirst => '(lūdzu, vispirms izlasiet)';

  @override
  String get statusActive => 'Aktīvs';

  @override
  String get statusSuspended => 'Apturēts';

  @override
  String get statusNew => 'Jauns';

  @override
  String get statusCancelled => 'Atcelts';

  @override
  String get statusDeleted => 'Dzēsts';

  @override
  String get roleMitglied => 'Biedrs';

  @override
  String get roleVorsitzer => 'Priekšsēdētājs';

  @override
  String get roleStellvertreter => 'Vietnieks';

  @override
  String get roleSchatzmeister => 'Kasieris';

  @override
  String get roleSchriftfuehrer => 'Sekretārs';

  @override
  String get roleBeisitzer => 'Piesēdētājs';

  @override
  String get roleKassierer => 'Kasieris';

  @override
  String get roleKassenpruefer => 'Revidents';

  @override
  String get roleEhrenamtlich => 'Brīvprātīgais';

  @override
  String get roleMitgliedergruender => 'Dibinātājs biedrs';

  @override
  String get roleEhrenmitglied => 'Goda biedrs';

  @override
  String get roleFoerdermitglied => 'Atbalstītājs biedrs';

  @override
  String get memberTypeNotSet => 'Vēl nav noteikts';

  @override
  String get payMethodSepa => 'SEPA tiešais debets';

  @override
  String get labelStatus => 'Statuss';

  @override
  String get labelMemberNumber => 'Biedra numurs';

  @override
  String get labelRole => 'Loma';

  @override
  String get labelMemberType => 'Biedra tips';

  @override
  String get labelPaymentMethod => 'Maksājuma veids';

  @override
  String get labelRegisteredOn => 'Reģistrēts';

  @override
  String get labelLastLogin => 'Pēdējā pieslēgšanās';

  @override
  String get labelMemberSince => 'Biedrs kopš';

  @override
  String get neverLoggedIn => 'Nekad';

  @override
  String get notActivatedYet => 'Vēl nav aktivizēts';

  @override
  String get tabVerification => 'Verifikācija';

  @override
  String get tabWarnings => 'Brīdinājumi';

  @override
  String get tabDocuments => 'Dokumenti';

  @override
  String get tabMembership => 'Dalība';

  @override
  String get pleaseEnterFirstName => 'Ievadiet vārdu';

  @override
  String get pleaseEnterLastName => 'Ievadiet uzvārdu';

  @override
  String get noFileDataReceived => 'Dati nav saņemti';

  @override
  String get openFile => 'Atvērt';

  @override
  String get noMicrophoneError =>
      'Mikrofons nav atrasts. Pievienojiet mikrofonu un mēģiniet vēlreiz.';

  @override
  String get startConversation => 'Sāciet sarunu!';

  @override
  String get staffWillReply => 'Darbinieks jums drīz atbildēs.';

  @override
  String get inCall => 'Zvanā...';

  @override
  String get registration => 'Reģistrācija';

  @override
  String get deactivation => 'Deaktivācija';

  @override
  String get deactivatedOn => 'Deaktivizēts';

  @override
  String get accountAutoSuspend =>
      'Konti, kas nav verificēti 30 dienu laikā, tiks automātiski apturēti.';

  @override
  String get documentsProvidedByBoard => 'Dokumentus nodrošina valde.';

  @override
  String get noDocumentsAvailable => 'Nav dokumentu';

  @override
  String get noDocumentsDescription => 'Jums vēl nav nodrošināti dokumenti.';

  @override
  String uploadedBy(String name) {
    return 'Augšupielādēja: $name';
  }

  @override
  String stepsCompleted(int completed, int total) {
    return '$completed/$total soļi pabeigti';
  }

  @override
  String dayOfMonth(int day) {
    return 'Mēneša $day. diena';
  }

  @override
  String changeField(String field) {
    return 'Mainīt $field';
  }

  @override
  String openDocument(String name) {
    return 'Atvērt $name';
  }

  @override
  String logEntries(int count) {
    return '$count ieraksti';
  }

  @override
  String get noLogs => 'Nav žurnālu';

  @override
  String get newLoginDetected => 'Konstatēta jauna pieslēgšanās';

  @override
  String get errorNoInternet =>
      'Nav interneta savienojuma. Lūdzu, pārbaudiet tīklu.';

  @override
  String get errorTimeout => 'Serveris neatbild. Lūdzu, mēģiniet vēlāk.';

  @override
  String get errorServer => 'Servera kļūda. Lūdzu, mēģiniet vēlāk.';

  @override
  String get errorConnection => 'Savienojuma kļūda. Lūdzu, mēģiniet vēlāk.';

  @override
  String get errorUnexpected =>
      'Radās neparedzēta kļūda. Lūdzu, mēģiniet vēlāk.';

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
  String get claudiuWelcomeMorning => 'Labrīt';

  @override
  String get claudiuWelcomeDay => 'Sveiki';

  @override
  String get claudiuWelcomeEvening => 'Labvakar';

  @override
  String get claudiuWelcomeNight => 'Labvakar';

  @override
  String get claudiuWelcomeVisitor => 'mīļais apmeklētāj';

  @override
  String get claudiuWelcomeAsk => 'Kā varu palīdzēt?';

  @override
  String get claudiuWelcomeBecomeMember => 'Vēlos kļūt par biedru';

  @override
  String get claudiuWelcomeLogin => 'Jau esmu biedrs un vēlos pieteikties';

  @override
  String get claudiuWelcomeProblem => 'Man ir problēma ar lietotni';

  @override
  String get claudiuWelcomeEmergency => 'Steidzami — zvaniet mums';

  @override
  String get claudiuWelcomeMascotName => 'Claudiu';

  @override
  String get claudiuWelcomeEmergencyIntro => 'Pirms zvanāt — mūsu darba laiks:';

  @override
  String get claudiuWelcomeScheduleOffice => 'Birojā';

  @override
  String get claudiuWelcomeScheduleField => 'Pie klientiem';

  @override
  String get claudiuWelcomeOutsideHoursNote =>
      'Ārpus šī laika izskatām tikai steidzamus gadījumus. Variet arī sūtīt SMS uz to pašu numuru — sazināsimies.';

  @override
  String get claudiuWelcomeCallNow => 'Zvanīt tagad';

  @override
  String get claudiuWelcomeSendSms => 'Sūtīt SMS';

  @override
  String get claudiuWelcomeSmsBody =>
      'Steidzami ICD360S e.V. — lūdzu, sazinieties pēc iespējas ātrāk.';

  @override
  String get claudiuWelcomeCloseButton => 'Aizvērt';

  @override
  String get claudiuLoginWelcome => 'Laipni lūdzam atpakaļ, dārgais biedr!';

  @override
  String get claudiuLoginAsk => 'Lūdzu, pasaki savu biedra numuru.';

  @override
  String get claudiuLoginProgress => 'Gandrīz… raksti tālāk.';

  @override
  String get claudiuLoginReady => 'Lieliski! Nospied pogu zemāk.';

  @override
  String get claudiuLoginLoading => 'Pārbaudu identitāti… 🔍';

  @override
  String get claudiuLoginFoundPlain => 'Atradu tevi! Pieslēdzu…';

  @override
  String claudiuLoginFoundNamed(String name) {
    return 'Atradu tevi, $name! Pieslēdzu…';
  }

  @override
  String get claudiuLoginError =>
      'Hmm, šo numuru neatrodu. Vai pareizi ievadīji?';

  @override
  String get claudiuLoginForgotHeader => 'Aizmirsi biedra numuru?';

  @override
  String get claudiuLoginNoSms => 'Numuru nesūtām pa e-pastu vai SMS.';

  @override
  String get claudiuLoginOnlyWay =>
      'Vienīgais veids: personiska tikšanās biedrības birojā, pēc personas dokumenta pārbaudes.';

  @override
  String get claudiuLoginContactUs => 'Zvani, lai rezervētu tikšanos:';

  @override
  String get claudiuDiagnosticGreeting =>
      'Pirms ieiešanas, viens ātrs jautājums';

  @override
  String get claudiuDiagnosticAsk =>
      'Vai drīkstu sūtīt anonīmus ziņojumus, lai izstrādātāji uzlabotu lietotni?';

  @override
  String get claudiuDiagnosticYes => 'Jā, vēlos palīdzēt';

  @override
  String get claudiuDiagnosticNo => 'Nē, tikai apskatos';

  @override
  String get claudiuDiagnosticTellMore => 'Pastāsti vairāk';

  @override
  String get claudiuDiagnosticSendsHeader => '📤 Ko mēs SŪTĀM (anonīmi):';

  @override
  String get claudiuDiagnosticSends1 =>
      'Anonīms ierīces kods (NEVIS biedra numurs)';

  @override
  String get claudiuDiagnosticSends2 => 'Tava loma (biedrs / valde)';

  @override
  String get claudiuDiagnosticSends3 =>
      'Operētājsistēma (Linux / Android / iOS / Windows)';

  @override
  String get claudiuDiagnosticSends4 => 'Izvēlētā valoda';

  @override
  String get claudiuDiagnosticSends5 => 'Akumulatora līmenis un stāvoklis';

  @override
  String get claudiuDiagnosticSends6 => 'Pašreizējais ekrāns';

  @override
  String get claudiuDiagnosticSends7 => 'Sesijas ilgums (sekundes)';

  @override
  String get claudiuDiagnosticSends8 => 'Kļūdas, ja ir (pēdējās 10)';

  @override
  String get claudiuDiagnosticSends9 => 'Navigācija (pēdējie 20 ekrāni)';

  @override
  String get claudiuDiagnosticNeverHeader => '🛡️ Ko mēs NEKAD nesūtām:';

  @override
  String get claudiuDiagnosticNever1 => 'Tavs īstais vārds';

  @override
  String get claudiuDiagnosticNever2 => 'E-pasta adrese';

  @override
  String get claudiuDiagnosticNever3 => 'Tālruņa numurs';

  @override
  String get claudiuDiagnosticNever4 => 'Parole';

  @override
  String get claudiuDiagnosticNever5 => 'Tērzēšanas ziņojumu saturs';

  @override
  String get claudiuDiagnosticNever6 => 'Biļešu saturs';

  @override
  String get claudiuDiagnosticNever7 => 'Dokumenti vai pielikumi';

  @override
  String get claudiuDiagnosticTechHeader => '📡 Tehniskā informācija:';

  @override
  String get claudiuDiagnosticTech1 => 'Sūta ik pēc 2 minūtēm';

  @override
  String get claudiuDiagnosticTech2 =>
      'TLS-šifrēts savienojums ar piesprausto sertifikātu';

  @override
  String get claudiuDiagnosticTech3 =>
      'Variet to izslēgt jebkurā laikā Iestatījumos';

  @override
  String get claudiuProblemHelpTitle => 'Kā varu palīdzēt?';

  @override
  String get claudiuProblemHelpGreeting => 'Kas notika?';

  @override
  String get claudiuProblemHelpAsk => 'Kā vēlies man pastāstīt?';

  @override
  String get claudiuProblemHelpWriteTitle => 'Rakstīt ziņojumu';

  @override
  String get claudiuProblemHelpWriteBody =>
      'Ar soli pa solim informāciju. Komanda saņem tekstu un atrisina vēlāk.';

  @override
  String get claudiuProblemHelpChatTitle => 'Parunāsim tūlīt';

  @override
  String get claudiuProblemHelpChatBody =>
      'Anonīma saruna ar operatoru. Atbilde reāllaikā, ja kāds ir tiešsaistē.';

  @override
  String get claudiuProblemHelpAltCallHeader => 'Vai, ja steidzami:';

  @override
  String get claudiuProblemHelpAltCallLabel => 'Zvanīt';

  @override
  String get claudiuAnonymousChatTitle => 'Anonīma saruna';

  @override
  String get claudiuAnonymousChatGreeting => 'Sveiki!';

  @override
  String get claudiuAnonymousChatWelcome =>
      'Es klausos. Raksti ko vēlies — vārds nav vajadzīgs. Atbildēšu, tiklīdz būšu klāt.';

  @override
  String get claudiuAnonymousChatHint => 'Uzraksti ziņu…';

  @override
  String get claudiuAnonymousChatWaitingOperator => 'Gaidām operatora atbildi…';

  @override
  String get claudiuVorsitzerConnectedTitle => 'Sveiki!';

  @override
  String get claudiuVorsitzerConnectedBody =>
      'Paldies, ka uzrakstīji — tagad esi kontaktā ar Vorsitzer. Pastāsti, kā varam palīdzēt ar tavu dalības pieteikumu.';

  @override
  String get claudiuVorsitzerConnectedSender => 'Vorsitzer';

  @override
  String get claudiuQuickReplyValidationTime =>
      'Cik ilgs ir pārbaudes process?';

  @override
  String get claudiuQuickReplyDocuments => 'Kādi dokumenti man ir vajadzīgi?';

  @override
  String get claudiuQuickReplyStepProblem => 'Esmu iestrēdzis pie viena soļa';

  @override
  String get claudiuQuickReplyHuman => 'Vai varu tagad parunāt ar kādu?';

  @override
  String get claudiuAnonymousChatConnecting => 'Savienojas…';

  @override
  String get claudiuAnonymousChatConnectionFailed =>
      'Sarunu nevarēja atvērt. Mēģini vēlreiz vai zvani mums.';

  @override
  String get claudiuAnonymousChatRetry => 'Mēģināt vēlreiz';

  @override
  String get claudiuAnonymousChatOnline => 'Savienots';

  @override
  String get claudiuAnonymousChatOffline => 'Atjauno savienojumu…';

  @override
  String get claudiuAnonymousChatAdminTyping => 'Operators raksta…';

  @override
  String get claudiuProblemReportTitle => 'Ziņot par problēmu';

  @override
  String get claudiuProblemReportGreeting => 'Kas notika?';

  @override
  String get claudiuProblemReportAsk =>
      'Pastāsti detalizēti, un es nodošu ziņojumu komandai.';

  @override
  String get claudiuProblemReportIncludeHeader => 'Lūdzu, ietver:';

  @override
  String get claudiuProblemReportIncludeBullets1 =>
      'Ko tu darīji, kad problēma parādījās';

  @override
  String get claudiuProblemReportIncludeBullets2 =>
      'Jebkurš kļūdas paziņojums, ko redzēji';

  @override
  String get claudiuProblemReportIncludeBullets3 => 'Kurā ekrānā biji';

  @override
  String get claudiuProblemReportIncludeBullets4 =>
      'Vai lietotne avarē, aizveras vai parāda baltu ekrānu?';

  @override
  String get claudiuProblemReportIncludeBullets5 =>
      'Vai tas notiek katru reizi vai tikai vienreiz?';

  @override
  String get claudiuProblemReportDescriptionLabel => 'Tavs apraksts';

  @override
  String get claudiuProblemReportDescriptionHint =>
      'Piem.: Atverot sarunas ekrānu, parādās ziņojums \"Connection error\" un lietotne pārstāj reaģēt…';

  @override
  String claudiuProblemReportTooShort(int count) {
    return 'Mazliet vairāk detaļu, lūdzu (vismaz $count rakstzīmes)';
  }

  @override
  String get claudiuProblemReportSubmit => 'Sūtīt ziņojumu';

  @override
  String get claudiuProblemReportSubmitting => 'Sūta…';

  @override
  String get claudiuProblemReportSentTitle => 'Paldies!';

  @override
  String get claudiuProblemReportSentBody =>
      'Ziņojums ir nosūtīts. Mūsu komanda to izskatīs pēc iespējas ātrāk.';

  @override
  String get claudiuProblemReportSentClose => 'Sapratu';

  @override
  String get claudiuProblemReportSendFailed =>
      'Ziņojumu nevarēja nosūtīt. Zvani mums steidzamai palīdzībai.';

  @override
  String get claudiuProblemReportAlt => 'Vai, ja steidzami:';

  @override
  String get claudiuProblemReportCallLabel => 'Zvanīt';

  @override
  String claudiuApprovalGreeting(String name) {
    return 'Sveiks, $name! 👋';
  }

  @override
  String get claudiuApprovalGreetingNoName => 'Sveiks! 👋';

  @override
  String get claudiuApprovalGladToSeeYou => 'Priecājos, ka atnāci!';

  @override
  String get claudiuApprovalCheckingForSafety =>
      'Tavas drošības labad Vorsitzer šobrīd pārbauda tavu pieteikšanās pieprasījumu. 🛡️';

  @override
  String get claudiuApprovalMonthlyExplain =>
      '💡 Mēs to darām reizi 30 dienās, lai pārliecinātos, ka tas tiešām esi tu. Tas ir kā drošības pārbaude — ne ilgāk par 5 minūtēm.';

  @override
  String get claudiuApprovalSuccess =>
      'Gatavs! 🎉 Vorsitzer tevi atpazina. Pieslēdzu…';

  @override
  String get claudiuApprovalDenied =>
      'Hmm, Vorsitzer noraidīja tavu pieprasījumu. 😔';

  @override
  String get claudiuApprovalDeniedHelp =>
      'Ja domā, ka tā ir kļūda, lūdzu zvani, lai noskaidrojam.';

  @override
  String get claudiuApprovalExpired =>
      '5 minūtes ir pagājušas un Vorsitzer neatbildēja.';

  @override
  String get claudiuApprovalExpiredHelp =>
      'Zvani mums un mēs varam apstiprināt tavu pieprasījumu uz vietas. 📞';

  @override
  String get claudiuApprovalCallUs => 'Zvanīt';

  @override
  String get claudiuApprovalTryAgain => 'Mēģināt vēlreiz';

  @override
  String get claudiuApprovalCancel => 'Atcelt';

  @override
  String get claudiuApprovalClose => 'Aizvērt';

  @override
  String get wizardIntroBubble1 =>
      'Sveiks, apmeklētāj! 👋 Paldies, ka vēlies pievienoties mūsu ģimenei.';

  @override
  String get wizardIntroBubble2 =>
      'Mani sauc Klaudio. 2025. gada pavasarī man bija skaidra vīzija: izveidot biedrību, kas palīdz cilvēkiem nelaimē — brīvprātīgi, no sirds, bez liekas birokrātijas. ❤️';

  @override
  String get wizardIntroBubble3 =>
      'Sāku runāt ar klientiem, kurus apmeklēju. Pastāstīju viņiem savu sapni. Un katrs teica: \"Jā, ejam!\" 2025. gada jūlijā mēs sešatā satikāmies — apņēmīgi cilvēki. Nolēmām dibināt **ICD360S e.V.** Neu-Ulmā. 📍';

  @override
  String get wizardIntroBubble4 =>
      '**2025. gada 1. augustā** biedrība oficiāli atdzima — Biedrību reģistrā. Mana visskaistākā dāvana. 🎂';

  @override
  String get wizardIntroBubble5 =>
      'Ko mēs darām? Palīdzam bēgļiem, cilvēkiem ar invaliditāti, ekonomiski neaizsargātajiem, **bērniem un jauniešiem** — administratīvajos jautājumos, vācu valodā, mājoklī, iepirkumos, sociālajos pabalstos. Mūsu Vorstand veido galvenokārt cilvēki ar invaliditāti — tā lēmumi nāk no reālas dzīves pieredzes. 🤝';

  @override
  String get wizardIntroBubble6 =>
      'Tagad ir tava kārta. Reģistrēsim tevi — aizņem apmēram 5 minūtes. Iesim soli pa solim, neatstāšu tevi vienu. ✨';

  @override
  String get wizardIntroStart => 'Sāksim';

  @override
  String get wizardBack => 'Atpakaļ';

  @override
  String get wizardNext => 'Tālāk';

  @override
  String wizardStepLabel(int step, int total, String title) {
    return '$step. solis no $total · $title';
  }

  @override
  String get wizardErrRequired => 'Šis lauks ir obligāts';

  @override
  String wizardErrTooShort(int count) {
    return 'Pārāk īss (vismaz $count rakstzīmes)';
  }

  @override
  String get wizardErrOnlyLetters =>
      'Tikai burti, atstarpes, defises un apostrofi';

  @override
  String get wizardErrSaveFailed =>
      'Saglabāt neizdevās. Pārbaudi savienojumu un mēģini vēlreiz.';

  @override
  String get wizardStufe1aTitle => 'Identitāte';

  @override
  String get wizardStufe1aPrompt =>
      'Iepazīsimies oficiāli. Lūdzu, ieraksti savu vārdu tieši tā, kā tas redzams Personalausweis, Reisepass vai Aufenthaltstitel — lai atbilstu dokumentiem.';

  @override
  String get wizardStufe1aVornameLabel => 'Vornamen (vārdi)';

  @override
  String get wizardStufe1aVornameHelper =>
      'Visi tavi vārdi tieši kā dokumentā. Ar atstarpi vai defisi (piem., Hans-Peter, Maria Anna).';

  @override
  String get wizardStufe1aNachnameLabel => 'Familienname (uzvārds)';

  @override
  String get wizardStufe1aNachnameHelper => 'Tavs pašreizējais uzvārds.';

  @override
  String get wizardStufe1aGeburtsnameLabel =>
      'Geburtsname (dzimšanas vārds) — pēc izvēles';

  @override
  String get wizardStufe1aGeburtsnameHelper =>
      'Tikai ja atšķiras no Familienname — piem., pirms laulības.';

  @override
  String get wizardStufe1bTitle => 'Dzimšanas diena';

  @override
  String get wizardStufe1bPrompt =>
      'Mēs vēlamies svinēt tavu dzimšanas dienu kopā! 🎂 Tas arī palīdz mums apstiprināt, ka tev ir vismaz 16 — tā teikts mūsu statūtos.';

  @override
  String get wizardStufe1bGeburtsdatumLabel => 'Dzimšanas datums';

  @override
  String get wizardStufe1bGeburtsdatumHelper =>
      'Pieskaries, lai izvēlētos datumu';

  @override
  String get wizardStufe1bGeburtsortLabel => 'Dzimšanas vieta';

  @override
  String get wizardStufe1bGeburtsortHelper => 'Pilsēta / vieta, kur tu dzimi.';

  @override
  String get wizardAgeGatePrompt => 'Man žēl… 😔';

  @override
  String wizardAgeGateBody1(int age, int years) {
    return 'Mūsu statūti saka, ka biedrim jābūt vismaz 16. Tev ir $age — ceru tikties pēc $years gadiem! 🌱';
  }

  @override
  String get wizardAgeGateBody2 =>
      'Ja vēlies brīvprātīgi palīdzēt laiku pa laikam (jebkurā vecumā, ar vecāku piekrišanu), piezvani — mums patīk atbalstīt jauniešus, kuri vēlas mainīt pasauli.';

  @override
  String get wizardAgeGateBackHome => 'Atpakaļ uz sākumu';

  @override
  String get wizardErrInvalidPhone => 'Nederīgs tālruņa numurs';

  @override
  String get wizardStufe1b1Title => 'Vecāku piekrišana';

  @override
  String get wizardStufe1b1Prompt =>
      'Esi nepilngadīgs (16-17) — saskaņā ar §106 BGB mums vajadzīga vecāku vai aizbildņa piekrišana. Pasaki vārdu un tālruņa numuru. Vorsitzer piezvanīs un norunās tikšanos (klātienē vai video zvanā). Bez e-pasta — vēlamies pārliecināties, ka runājam ar īsto personu.';

  @override
  String get wizardStufe1b1VornameLabel => 'Vecāka vārds';

  @override
  String get wizardStufe1b1VornameHelper => 'Kā vecāka Personalausweisā.';

  @override
  String get wizardStufe1b1NachnameLabel => 'Vecāka uzvārds';

  @override
  String get wizardStufe1b1NachnameHelper => 'Kā vecāka Personalausweisā.';

  @override
  String get wizardStufe1b1TelefonLabel => 'Vecāka mobilais';

  @override
  String get wizardStufe1b1TelefonHelper => 'Šim numuram piezvanīs Vorsitzer.';

  @override
  String get wizardStufe1b1RelationLabel => 'Attiecības ar bērnu:';

  @override
  String get wizardStufe1b1RelationMutter => 'Māte';

  @override
  String get wizardStufe1b1RelationVater => 'Tēvs';

  @override
  String get wizardStufe1b1RelationSorgeberechtigter => 'Likumīgais aizbildnis';

  @override
  String get wizardStufe1b1RelationAndere => 'Cits aizbildnis';

  @override
  String get wizardStufe1cTitle => 'Personas dati';

  @override
  String get wizardStufe1cPrompt =>
      'Vienkārši lai labāk tevi iepazītu. Tas paliek starp mums un netiek nekur publiski rādīts.';

  @override
  String get wizardStufe1cGeschlechtLabel => 'Dzimums';

  @override
  String get wizardStufe1cGeschlechtMaennlich => 'Vīrietis';

  @override
  String get wizardStufe1cGeschlechtWeiblich => 'Sieviete';

  @override
  String get wizardStufe1cGeschlechtDivers => 'Cits';

  @override
  String get wizardStufe1cGeschlechtKeineAngabe => 'Nevēlos atklāt';

  @override
  String get wizardStufe1cFamilienstandLabel => 'Ģimenes stāvoklis';

  @override
  String get wizardStufe1cFamilienstandLedig => 'Neprecējies/usies';

  @override
  String get wizardStufe1cFamilienstandVerheiratet => 'Precējies/usies';

  @override
  String get wizardStufe1cFamilienstandGeschieden => 'Šķīries/usies';

  @override
  String get wizardStufe1cFamilienstandVerwitwet => 'Atraitnis/e';

  @override
  String get wizardStufe1dTitle => 'Tava izcelsme';

  @override
  String get wizardStufe1dPrompt =>
      'Tas mums palīdz piedāvāt tev pareizo atbalstu — piemēram, konsultāciju par Aufenthalt vai atrast tavu valodas kopienu.';

  @override
  String get wizardStufe1dStaatLabel => 'Pilsonība';

  @override
  String get wizardStufe1dStaatHelper =>
      'Piem. deutsch, rumänisch, ukrainisch. Vairākas atdalītas ar komatu.';

  @override
  String get wizardStufe1dAufenthaltLabel =>
      'Uzturēšanās statuss (Aufenthaltsstatus) — pēc izvēles';

  @override
  String get wizardStufe1dAufenthaltHelper =>
      'Izvēlies titulu no savas Aufenthaltskarte / lēmuma. Vorstand to salīdzina ar taviem dokumentiem.';

  @override
  String get wizardStufe1dAufenthaltAwaitingCitizenship =>
      'Vispirms augšā aizpildi pilsonību — rādīsim tikai atbilstošās opcijas.';

  @override
  String get wizardStufe1dAufenthaltGerman =>
      'Aufenthaltstitel nav nepieciešams — Vācijas pilsonis.';

  @override
  String get wizardStufe1dAufenthaltEuEea =>
      'ES/EEZ/CH pilsonis — pārvietošanās brīvība (Freizügigkeit).';

  @override
  String get wizardStufe1dAufenthaltTempHint => 'pagaidu';

  @override
  String get wizardStufe1dAufenthaltPermHint => 'pastāvīga uzturēšanās';

  @override
  String get wizardStufe1dAufenthaltAsylumProcessHint => 'patvēruma procedūra';

  @override
  String get wizardStufe1dAufenthaltOther => 'Cits (lūdzu norādi čatā)';

  @override
  String get wizardStufe1dAufenthaltRequired =>
      'Lūdzu izvēlies Aufenthaltstitel.';

  @override
  String get wizardStufe1dMutterspracheLabel => 'Dzimtā valoda';

  @override
  String get wizardStufe1dMutterspracheHelper =>
      'Iepriekš aizpildīts ar lietotnes valodu — maini, ja atšķiras.';

  @override
  String get wizardStufe1eTitle => 'Adrese';

  @override
  String get wizardStufe1ePrompt =>
      'Tava pasta adrese — izmantojam to oficiāliem dokumentiem (statūti, biedru līgumi, paziņojumi).';

  @override
  String get wizardStufe1eStrasseLabel => 'Iela';

  @override
  String get wizardStufe1eStrasseHelper =>
      'Tikai ielas nosaukums — numurs blakus laukā.';

  @override
  String get wizardStufe1eHausnummerLabel => 'Nr.';

  @override
  String get wizardStufe1ePlzLabel => 'PLZ (pasta indekss)';

  @override
  String get wizardStufe1eOrtLabel => 'Pilsēta';

  @override
  String get wizardStufe1eLandLabel => 'Valsts';

  @override
  String get wizardStufe1eLandHelper => 'Iepriekš aizpildīts: Deutschland.';

  @override
  String get wizardErrInvalidStreet => 'Nederīgs ielas nosaukums';

  @override
  String get wizardErrInvalidHausnummer =>
      'Nederīgs numurs (piem. 12, 12a, 12/3)';

  @override
  String get wizardErrInvalidPlz => 'Nederīgs pasta indekss (tikai cipari)';

  @override
  String get wizardStufe1fTitle => 'Kontakts';

  @override
  String get wizardStufe1fPrompt =>
      'Kā tev sazināties? Tālrunis ir tikai ārkārtas gadījumiem — viss pārējais notiek mūsu pašu galapunktu šifrētajā kanālā lietotnē. Tavs biedra e-pasts tiek piešķirts automātiski un parādīts zemāk.';

  @override
  String get wizardStufe1fTelefonLabel => 'Mobilais';

  @override
  String get wizardStufe1fTelefonHelper =>
      'Solu, zvanīšu tikai tad, ja būs svarīgi. 📱';

  @override
  String get wizardStufe2Title => 'Biedra tips';

  @override
  String get wizardStufe2Prompt =>
      'Kāds biedrs vēlies būt? Ļauj man paskaidrot katru variantu.';

  @override
  String get wizardStufe2OrdentlichTitle => 'Pilntiesīgs biedrs (ordentlich)';

  @override
  String get wizardStufe2OrdentlichBody =>
      'Pilnas tiesības. Maksā ikmēneša biedru maksu, balso kopsapulcē, vari tikt ievēlēts valdē. Standarta izvēle.';

  @override
  String get wizardStufe2FoerderTitle => 'Atbalsta biedrs (Fördermitglied)';

  @override
  String get wizardStufe2FoerderBody =>
      'Atbalsti biedrību finansiāli, bet aktīvi nepiedalies lēmumos. Bez balsstiesībām. Labi, ja vēlies palīdzēt no attāluma.';

  @override
  String get wizardStufe2EhrenTitle => 'Goda biedrs (Ehrenmitglied)';

  @override
  String get wizardStufe2EhrenBody =>
      'Piešķir valde par īpašiem nopelniem. Pats to neizvēlies — to piešķir kā atzinību. Izvēlies tikai, ja jau esi pagodināts.';

  @override
  String get wizardStufe3Title => 'Finansiālā situācija';

  @override
  String get wizardStufe3Prompt =>
      'Tagad par tavu finansiālo situāciju. Ne lai vērtētu — bet lai atbrīvotu no biedru maksas, ja saņem sociālos pabalstus.';

  @override
  String get wizardStufe3OptionBuergergeld => 'Saņemu Bürgergeld';

  @override
  String get wizardStufe3OptionSozialamt => 'Saņemu pabalstus no Sozialamt';

  @override
  String get wizardStufe3OptionNein => 'Nesaņemu nevienu no šiem';

  @override
  String get wizardStufe3FeeExemptTitle => 'Biedru maksa: 0 € / mēn. 🎉';

  @override
  String get wizardStufe3FeeExemptBody =>
      'Ar Bürgergeld, Sozialamt, ALG I vai Krankengeld saskaņā ar Satzung §6 esi pilnībā atbrīvots no biedru maksas. Mums vajadzīgs tikai pierādījums (Leistungsbescheid vai izziņa no iestādes / veselības apdrošināšanas).';

  @override
  String get wizardStufe3UploadTitle => 'Augšupielādēt Leistungsbescheid';

  @override
  String get wizardStufe3UploadHint => 'PDF / JPG / PNG, līdz 10 MB.';

  @override
  String get wizardStufe3UploadRequired =>
      'Lūdzu augšupielādē Leistungsbescheid pirms turpināt.';

  @override
  String get wizardStufe3FileTooLarge =>
      'Fails ir pārāk liels. Maksimums 10 MB.';

  @override
  String get wizardStufe3UploadFailed =>
      'Faila augšupielāde neizdevās. Mēģini vēlreiz.';

  @override
  String get wizardStufe3RegularFeeTitle => 'Biedru maksa: 25 € / mēn.';

  @override
  String get wizardStufe3RegularFeeBody =>
      'Standarta biedru maksa pilntiesīgiem biedriem saskaņā ar statūtiem.';

  @override
  String get wizardStufe4Title => 'Maksājums';

  @override
  String get wizardStufe4Prompt =>
      'Kā vēlies maksāt biedru maksu? Un kurā mēneša dienā?';

  @override
  String get wizardStufe4MethodUeberweisungTitle =>
      'Bankas pārskaitījums (Überweisung)';

  @override
  String get wizardStufe4MethodUeberweisungBody =>
      'Maksājumu uzsāc pats katru mēnesi no sava konta.';

  @override
  String get wizardStufe4MethodSepaTitle => 'SEPA-Lastschrift (tiešais debets)';

  @override
  String get wizardStufe4MethodSepaBody =>
      'Summu automātiski noņemam no tava konta. Visērtāk, bet vajag IBAN un parakstītu pilnvarojumu.';

  @override
  String get wizardStufe4MethodDauerauftragTitle =>
      'Dauerauftrag (pastāvīgais rīkojums)';

  @override
  String get wizardStufe4MethodDauerauftragBody =>
      'Bankā iestati pastāvīgo rīkojumu. Banka summu pārskaita automātiski katru mēnesi.';

  @override
  String get wizardStufe4DayLabel => 'Maksājuma diena';

  @override
  String get wizardStufe4DayHint => 'Izvēlies dienu no 1 līdz 31';

  @override
  String wizardStufe4DayItem(int day) {
    return '$day. diena';
  }

  @override
  String wizardStufe4DayReminder(int day) {
    return 'Biedru maksa tiks ieturēta katra mēneša $day. datumā.';
  }

  @override
  String get wizardStufe5Title => 'Sākums';

  @override
  String get wizardStufe5Prompt =>
      'No kura brīža vēlies oficiāli būt ICD360S biedrs? No apstiprināšanas vai ar atpakaļejošu spēku.';

  @override
  String get wizardStufe5OptionAbVerifizierungTitle =>
      'No Vorstand apstiprināšanas';

  @override
  String get wizardStufe5OptionAbVerifizierungBody =>
      'Vienkāršākais izvēles veids. Bez atpakaļejoša maksājuma.';

  @override
  String get wizardStufe5OptionGruendungsdatumTitle =>
      'Ar atpakaļejošu spēku no 01.08.2025 (dibināšana)';

  @override
  String get wizardStufe5OptionGruendungsdatumBody =>
      'Tu skaitīsies biedrs jau no biedrības pirmās dienas.';

  @override
  String get wizardStufe5OptionAnderesDatumTitle => 'Cits datums';

  @override
  String get wizardStufe5OptionAnderesDatumBody =>
      'Pats izvēlies datumu starp 01.08.2025 un šodien.';

  @override
  String get wizardStufe5PickDate => 'Pieskaries, lai izvēlētos datumu';

  @override
  String get wizardStufe5PickDateFirst => 'Lūdzu, vispirms izvēlies datumu.';

  @override
  String get wizardStufe5DatePickerHelp => 'Dalības sākums';

  @override
  String wizardStufe5DateRange(String start) {
    return 'Starp $start un šodien';
  }

  @override
  String get wizardStufe5RetroactiveTitle => 'Atpakaļejošā maksa';

  @override
  String wizardStufe5RetroactiveBody(
      String start, String end, int months, String amount) {
    return 'No $start līdz $end ir $months mēneši. Pie 25 €/mēn. tas ir $amount € apmaksai ar atpakaļejošu spēku, papildus pašreizējai mēneša biedru maksai.';
  }

  @override
  String get wizardStufe5FeeExemptTitle => 'Atpakaļejošā maksa: 0 € 🎉';

  @override
  String get wizardStufe5FeeExemptBody =>
      'Ar Bürgergeld vai Sozialamt esi pilnībā atbrīvots — pat ar atpakaļejošu spēku neko nav jāmaksā.';

  @override
  String wizardDocumentPrompt(String doc) {
    return 'Pirms pabeigt, lūdzu rūpīgi izlasi $doc. Ir svarīgi zināt, ko paraksti.';
  }

  @override
  String get wizardDocumentScrollHint => 'Ritini līdz beigām, lai turpinātu.';

  @override
  String get wizardDocumentScrolledOk => 'Tu izlasīji līdz galam ✓';

  @override
  String wizardDocumentOpenButton(String doc) {
    return 'Atvērt $doc pārlūkprogrammā';
  }

  @override
  String get wizardDocumentExternalHint =>
      'Šajā platformā atveram dokumentu tavā noklusētajā pārlūkprogrammā.';

  @override
  String get wizardDocumentOpenedOk =>
      'Dokuments tika atvērts. Lūdzu, izlasi to rūpīgi.';

  @override
  String wizardDocumentConfirm(String doc) {
    return 'Apstiprinu, ka esmu izlasījis(usi) un piekrītu $doc.';
  }

  @override
  String get wizardFinalAdultTitle => 'Gatavs! Esi reģistrēts 🎉';

  @override
  String get wizardFinalMinorTitle => 'Tavs pieprasījums ir nosūtīts 📨';

  @override
  String get wizardFinalMinorBody =>
      'Sazināsimies ar tavu vecāku un norunāsim tikšanos (klātienē vai video zvanā). Lūdzu, esi pacietīgs — process var ilgt līdz 7 dienām. Saņemsi paziņojumu lietotnē, tiklīdz vecāks apstiprinās.';

  @override
  String get wizardFinalMitgliedernummerLabel => 'Tavs biedra numurs';

  @override
  String get wizardStufe4MethodComingSoon => 'Drīzumā';

  @override
  String get wizardStufe4StreichungWarning =>
      'Ja kavēsi biedru maksu vairāk nekā 6 mēnešus, automātiski tevi izsvītrosim (Satzung §6 Abs. 3).';

  @override
  String get wizardStufe5KuendigungInfo =>
      'Lai izstātos: nosūti mums uzteikumu rakstiski 3 mēnešus pirms 31. decembra (līdz 30. septembrim, lai stātos spēkā gada beigās). Minimālā ilguma nav (Satzung §6 Abs. 3).';

  @override
  String get wizardStufe1fEmailLabel => 'Tavs biedra e-pasts';

  @override
  String get wizardStufe1fEmailHelper =>
      'Tiek piešķirts automātiski, balstoties uz tavu biedra numuru. Tiek aktivizēts brīdī, kad valde (Vorstand) apstiprina tavu pieteikumu. Mums ir sava e-pasta lietotne — sūti un saņem šifrētus e-pastus, vienkārši un bez maksas.';

  @override
  String get wizardErrInvalidEmail => 'Nederīga e-pasta adrese';

  @override
  String get wizardStufe3OptionAlg1 =>
      'Saņemu Arbeitslosengeld I (ALG I, bezdarbnieka pabalstu)';

  @override
  String get wizardStufe3OptionKrankengeld =>
      'Saņemu Krankengeld (ilgstošas slimības pabalstu)';

  @override
  String get wizardStufe3UploadAddMore => 'Pievienot vēl dokumentu';

  @override
  String get wizardStufe3UploadLimitCount =>
      'Sasniegts limits: ne vairāk kā 20 dokumenti.';

  @override
  String get wizardStufe3UploadLimitTotal =>
      'Sasniegts kopējais limits 100 MB. Dzēs esošo failu.';

  @override
  String get wizardStufe3UploadDeleteTooltip => 'Dzēst';

  @override
  String wizardStufe3UploadCounter(int count, int max) {
    return '$count / $max dokumenti';
  }

  @override
  String get wizardDocumentExternalOpenFailed =>
      'Pārlūku neizdevās atvērt. Saite ir kopēta starpliktuvē — ielīmē to pārlūkā, lai turpinātu.';

  @override
  String get wizardFinalTimelineProcessing =>
      'Vorstand pārbauda · parasti 1 darba diena, līdz 7';

  @override
  String get wizardFinalTimelineActivated => 'Konts aktivizēts';

  @override
  String get wizardFinalAdultThank =>
      'Paldies, ka aizpildīji reģistrācijas formu! 🎉';

  @override
  String get wizardFinalAdultUsual =>
      'Tavs pieteikums ir pie mums. Parasti to apstiprinām vienas darba dienas laikā.';

  @override
  String get wizardFinalAdultExceptional =>
      'Dažreiz tas var aizņemt līdz 7 darba dienām. Un, ja kaut kas neatbilst, mēs nosūtīsim tevi atpakaļ pie formas, lai labotu 🙂';

  @override
  String get wizardFinalStatusTitle => 'PIETEIKUMA STATUSS';

  @override
  String wizardFinalStatusStepsValidated(int reviewed, int total) {
    return '$reviewed/$total soļus apstiprinājis Vorstand';
  }

  @override
  String get wizardFinalStufeSheetTitle => 'Pieteikuma informācija';

  @override
  String get wizardFinalStufeSheetHint =>
      '8 posmi, ko aizpildīji. Vorstand pārbauda tos pa vienam — reālajā laikā redzi, kas ir apstiprināts.';

  @override
  String get wizardFinalStufeStatusPending => 'Gaida pārbaudi';

  @override
  String get wizardFinalStufeStatusApproved => 'Apstiprināts';

  @override
  String get wizardFinalStufeStatusRejected => 'Noraidīts';

  @override
  String wizardFinalStatusRejectionCount(int count) {
    return '$count solis prasa labojumu';
  }

  @override
  String get wizardFinalStufeRejectionReason => 'Vorstanda iemesls:';

  @override
  String get wizardFinalStufeCorrectNow => 'Labot tagad';

  @override
  String wizardFinalApprovalsHeader(int current, int total) {
    return 'Vorstanda apstiprinājumi ($current/$total)';
  }

  @override
  String get wizardFinalApprovalAwaiting => 'Gaida 2. Vorstandu';

  @override
  String get wizardFinalApprovalRejected => 'NORAIDĪTS';

  @override
  String get wizardFinalStufeNoDataYet => 'Dati vēl nav pieejami.';

  @override
  String get wizardFinalStufeReadAt => 'Izlasīts:';

  @override
  String get wizardFinalStufeBeitragsfrei =>
      'Atbrīvots no biedra naudas (nav jāmaksā)';

  @override
  String get wizardFinalStufeNotExempt => 'Bez sociāliem pabalstiem';

  @override
  String get wizardFinalStufeBeginAtVerification => 'Sākas pēc verifikācijas';

  @override
  String get wizardFinalStufeBeginAtFoundation =>
      'Dibināšanas datums (ar atpakaļejošu spēku)';

  @override
  String get wizardFinalStufeBeginAtCustom => 'Cits datums';

  @override
  String get wizardFinalStufeStatusSkipped => 'Izlaists';

  @override
  String get wizardFinalStufeFilledAt => 'Aizpildīts:';

  @override
  String get wizardFinalStufeReviewedAt => 'Pārbaudīts:';

  @override
  String get wizardFinalWithdrawLink => 'Atsaukt pieteikumu';

  @override
  String get wizardFinalWithdrawDialogTitle => 'Atsaukt pieteikumu?';

  @override
  String get wizardFinalWithdrawDialogBody =>
      'Tavs pieteikums tiks atzīmēts kā tevis atsaukts. Dati paliek datubāzē auditam (GDPR), bet konts netiks aktivizēts. Reģistrāciju vari sākt no jauna jebkurā brīdī ar jaunu biedru numuru.';

  @override
  String get wizardFinalWithdrawKeep => 'Nē, gaidīšu';

  @override
  String get wizardFinalWithdrawConfirm => 'Jā, atsaukt';

  @override
  String get wizardErrTooManyWithdrawals =>
      'Tavu pieteikumu nevar apstrādāt automātiski. Piezvani mums vai atnāc personīgi pie Vorstand, lai turpinātu reģistrāciju.';

  @override
  String get wizardDuplicateLoginTitle => 'Šķiet, ka jau esi mūsu biedrs';

  @override
  String get wizardDuplicateLoginBody =>
      'Pēc tava vārda un dzimšanas datuma jau atrodam aktīvu kontu. Lūdzu, izmanto \"Es jau esmu biedrs\" sākuma ekrānā, lai pieteiktos. Ja vairs nav piekļuves, zvani mums.';

  @override
  String get wizardDuplicatePendingTitle => 'Tavs pieteikums jau ir pie mums';

  @override
  String get wizardDuplicatePendingBody =>
      'Pēc tava vārda un dzimšanas datuma mums jau ir pieteikums izskatīšanā. Vorstand pie tā strādā — paziņosim lietotnē, kad konts būs aktīvs. Zvani, ja vēlies parunāt.';

  @override
  String get wizardDuplicateRecentlyWithdrawnTitle =>
      'Šobrīd nevaram apstrādāt šo pieteikumu';

  @override
  String get wizardDuplicateRecentlyWithdrawnBody =>
      'Tavs vārds un dzimšanas datums sakrīt ar nesen atsauktu pieteikumu. Lūdzu, zvani mums, lai pirms turpināšanas runātu ar Vorstand.';

  @override
  String get wizardDuplicatePreviouslyWithdrawnTitle =>
      'Esi jau iepriekš iesniedzis pieteikumu';

  @override
  String get wizardDuplicatePreviouslyWithdrawnBody =>
      'Tavs vārds un dzimšanas datums sakrīt ar vecāku pieteikumu, ko biji atsaucis. Laipni atpakaļ — pirms turpināšanas zvani mums, lai Vorstand izlemtu, kā rīkojamies.';

  @override
  String get wizardDuplicateCallUsTitle => 'Lūdzu, zvani mums';

  @override
  String get wizardDuplicateCallUsBody =>
      'Tavs vārds un dzimšanas datums jau ir mūsu uzskaitē, bet detaļas caur lietotni nevaram dalīt. Lūdzu, zvani — Vorstand izskaidros situāciju tieši.';

  @override
  String get wizardChatHelp => 'Parunāsim';

  @override
  String get wizardChatHelpSubtitle =>
      'Tiešsaistes čats ar Vorstand · ātra atbilde';

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
}
