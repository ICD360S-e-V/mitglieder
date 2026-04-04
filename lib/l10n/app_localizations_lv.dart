// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Latvian (`lv`).
class AppLocalizationsLv extends AppLocalizations {
  AppLocalizationsLv([String locale = 'lv']) : super(locale);

  @override
  String get appTitle => 'ICD360S e.V - Biedru portāls';

  @override
  String get memberPortal => 'Biedru portāls';

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
  String get password => 'Parole';

  @override
  String get passwordHint => 'Ievadiet paroli';

  @override
  String get confirmPassword => 'Apstiprināt paroli';

  @override
  String get confirmPasswordHint => 'Apstipriniet paroli';

  @override
  String get newPassword => 'Jauna parole';

  @override
  String get newPasswordHint => 'Ievadiet jaunu paroli';

  @override
  String get saveCredentials => 'Saglabāt pieteikšanās datus';

  @override
  String get autoLogin => 'Automātiska pieteikšanās';

  @override
  String get forgotPassword => 'Aizmirsāt paroli?';

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
  String get recoveryCode => 'Atjaunošanas kods (6 cipari)';

  @override
  String get recoveryCodeHelper => 'Atcerieties šo kodu paroles atjaunošanai';

  @override
  String get recoveryCodeHint => 'Ievadiet atjaunošanas kodu';

  @override
  String get recoveryCodeInvalid => 'Kodam jābūt tieši 6 cipariem';

  @override
  String get loginFailed => 'Pieteikšanās neizdevās';

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
  String get tooManyDevices => 'Pārāk daudz ierīču';

  @override
  String get maxDevicesMessage =>
      'Jūs jau esat pieteicies 3 ierīcēs.\nIzvēlieties ierīci izrakstīšanai:';

  @override
  String get unknownDevice => 'Nezināma ierīce';

  @override
  String get unknown => 'Nezināms';

  @override
  String get logoutError => 'Izrakstīšanās kļūda';

  @override
  String error(String error) {
    return 'Kļūda: $error';
  }

  @override
  String get cancel => 'Atcelt';

  @override
  String get resetPassword => 'Atiestatīt paroli';

  @override
  String get forgotPasswordTitle => 'Aizmirsta parole';

  @override
  String get forgotPasswordDescription =>
      'Ievadiet savu biedra numuru un reģistrācijas laikā izveidoto atjaunošanas kodu.';

  @override
  String get passwordResetSuccess =>
      'Parole atiestatīta!\n\nTagad varat pieteikties ar jauno paroli.';

  @override
  String get passwordResetFailed => 'Paroles atiestatīšana neizdevās';

  @override
  String get needHelp => 'Nepieciešama palīdzība?';

  @override
  String get helpQuestion => 'Problēmas ar pieteikšanos vai reģistrāciju?';

  @override
  String get helpDescription =>
      'Sazinieties ar mums caur WhatsApp un aprakstiet, kas nedarbojas. Atbildēsim pēc iespējas ātrāk!';

  @override
  String get whatsapp => 'WhatsApp';

  @override
  String get emailSubject => 'Pieprasījums caur ICD360S lietotni';

  @override
  String get whatsappMessage => 'Sveiki, man ir problēma ar ICD360S lietotni. ';

  @override
  String get imprint => 'Impressum';

  @override
  String get privacy => 'Privātuma politika';

  @override
  String get statutes => 'Statūti';

  @override
  String get revocation => 'Atteikuma tiesības';

  @override
  String get cancellation => 'Atcelšana';

  @override
  String get allRightsReserved => 'Visas tiesības aizsargātas.';

  @override
  String get enterCredentials => 'Ievadiet biedra numuru un paroli';

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
  String get membership => 'Dalība';

  @override
  String get myAppointments => 'Mani tikšanās';

  @override
  String get appointmentsLoadingReady => 'Ielādē tikšanās - API gatavs!';

  @override
  String get priority => 'Prioritāte';

  @override
  String get messageLabel => 'Ziņojums';

  @override
  String get createdOn => 'Izveidots';

  @override
  String get handler => 'Apstrādātājs';

  @override
  String get reportProblems => 'Ziņot par problēmām';

  @override
  String get reportProblem => 'Ziņot par problēmu';

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
  String get newTicket => 'Jauns pieteikums';

  @override
  String get noOpenTickets => 'Nav atvērtu pieteikumu';

  @override
  String get haveQuestionCreateTicket =>
      'Vai jums ir jautājums vai problēma?\nIzveidojiet jaunu pieteikumu.';

  @override
  String get whatIsTheProblem => 'Kāda ir problēma?';

  @override
  String get describeTheProblem => 'Aprakstiet problēmu';

  @override
  String get howUrgentIsIt => 'Cik steidzami?';

  @override
  String get low => 'Zems';

  @override
  String get medium => 'Vidējs';

  @override
  String get high => 'Augsts';

  @override
  String get submit => 'Iesniegt';

  @override
  String get fillSubjectAndMessage => 'Lūdzu, aizpildiet tēmu un ziņojumu';

  @override
  String get ticketCreated => 'Pieteikums izveidots';

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
  String get newEmailAddress => 'Jauna e-pasta adrese';

  @override
  String get currentPassword => 'Pašreizējā parole';

  @override
  String get saveEmail => 'Saglabāt e-pastu';

  @override
  String get savePassword => 'Saglabāt paroli';

  @override
  String get deviceLoggedOut => 'Ierīce atteikta';

  @override
  String get passwordChangedSuccessfully => 'Parole veiksmīgi mainīta';

  @override
  String get emailChangedSuccessfully => 'E-pasts veiksmīgi mainīts';

  @override
  String get errorChangingPassword => 'Kļūda, mainot paroli';

  @override
  String get errorChangingEmail => 'Kļūda, mainot e-pastu';

  @override
  String get validEmailRequired => 'Lūdzu, ievadiet derīgu e-pasta adresi';

  @override
  String get passwordTooShort => 'Parolei jābūt vismaz 6 rakstzīmēm';

  @override
  String get maxDevicesReached => 'Esat pieteicies maksimāli 3 ierīcēs.';

  @override
  String loggedInOnDevices(int count) {
    return 'Esat pieteicies $count no 3 ierīcēm.';
  }

  @override
  String get noActiveSessions => 'Nav aktīvu sesiju';

  @override
  String get logoutFromDevice => 'Iziet no šīs ierīces';

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
  String get errorAcceptingCall => 'Kļūda pieņemot zvanu';

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
  String typingIndicator(String name) {
    return '$name raksta...';
  }

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
  String get diagnosticDataTitle => 'Diagnostikas dati';

  @override
  String get diagnosticDescription =>
      'Vai vēlaties sūtīt anonīmus diagnostikas datus lietotnes uzlabošanai?';

  @override
  String get noThanks => 'Nē, paldies';

  @override
  String get yesEnable => 'Jā, iespējot';

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
  String get newPasswordMinChars => 'Jauna parole (min. 6 rakstzīmes)';

  @override
  String get reasonLabel2 => 'Iemesls';

  @override
  String get downloadFailed2 => 'Lejupielāde neizdevās';

  @override
  String get downloadTooltip => 'Lejupielādēt';

  @override
  String get connectionErrorGeneric => 'Savienojuma kļūda';

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
  String get bankTransfer => 'Bankas pārskaitījums';

  @override
  String get standingOrder => 'Pastāvīgais maksājums';

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
  String get memberNumberTooLong =>
      'Biedra numurs pārāk garš (maks. 20 rakstzīmes)';

  @override
  String get onlyUppercaseAndNumbers => 'Atļauti tikai lielie burti un cipari';

  @override
  String get passwordTooLong => 'Parole pārāk gara (maks. 100 rakstzīmes)';

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
  String get diagnosticErrors => 'Kļūdu ziņojumi uzlabošanai';

  @override
  String get diagnosticAnonymousStats => 'Anonīma lietošanas statistika';

  @override
  String get diagnosticPerformance => 'Lietotnes veiktspējas dati';

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
  String get ipClean => 'IP tīra - nav sarakstā';

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
  String get helpImproveApp => 'Vai vēlaties palīdzēt mums uzlabot lietotni?';

  @override
  String get noPersonalDataCollected =>
      'Personas dati netiek vākti. Šo iestatījumu var mainīt jebkurā laikā.';

  @override
  String logEntries(int count) {
    return '$count ieraksti';
  }

  @override
  String get noLogs => 'Nav žurnālu';

  @override
  String get newLoginDetected => 'Konstatēta jauna pieslēgšanās';

  @override
  String get waitingForMember => 'Gaida biedru';

  @override
  String get waitingForStaff => 'Gaida darbinieku';

  @override
  String get waitingForAuthority => 'Gaida iestādi';
}
