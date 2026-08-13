// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Danish (`da`).
class AppLocalizationsDa extends AppLocalizations {
  AppLocalizationsDa([String locale = 'da']) : super(locale);

  @override
  String get welcomeLoading => 'Indlæser...';

  @override
  String get welcomeAutoLogin => 'Automatisk login...';

  @override
  String get login => 'Log ind';

  @override
  String get register => 'Registrer';

  @override
  String get becomeMember => 'Bliv medlem';

  @override
  String get memberNumber => 'Medlemsnummer';

  @override
  String get memberNumberHint => 'Indtast medlemsnummer';

  @override
  String get confirmPassword => 'Bekræft adgangskode';

  @override
  String get confirmPasswordHint => 'Bekræft adgangskode';

  @override
  String get newPassword => 'Ny adgangskode';

  @override
  String get newPasswordHint => 'Indtast ny adgangskode';

  @override
  String get firstName => 'Fornavn og efternavn';

  @override
  String get firstNameHint => 'Indtast for- og efternavn';

  @override
  String get nameMinLength => 'Navnet skal have mindst 2 tegn';

  @override
  String get nameOnlyLetters => 'Kun bogstaver og bindestreger tilladt';

  @override
  String get email => 'E-mailadresse';

  @override
  String get emailHint => 'Indtast e-mail';

  @override
  String get emailInvalid => 'Indtast en gyldig e-mailadresse';

  @override
  String get passwordMinLength => 'Adgangskoden skal have mindst 6 tegn';

  @override
  String get passwordsNotMatch => 'Adgangskoderne matcher ikke';

  @override
  String get registrationFailed => 'Registrering mislykkedes';

  @override
  String connectionError(String error) {
    return 'Forbindelsesfejl: $error';
  }

  @override
  String registrationSuccess(String memberNumber) {
    return 'Registrering lykkedes!\n\nDit medlemsnummer: $memberNumber\n\nHusk dette nummer til login.';
  }

  @override
  String get unknown => 'Ukendt';

  @override
  String error(String error) {
    return 'Fejl: $error';
  }

  @override
  String get cancel => 'Annuller';

  @override
  String get resetPassword => 'Nulstil adgangskode';

  @override
  String get imprint => 'Impressum';

  @override
  String get privacy => 'Privatlivspolitik';

  @override
  String get statutes => 'Vedtægter';

  @override
  String get revocation => 'Fortrydelsesret';

  @override
  String get appointments => 'Aftaler';

  @override
  String get tickets => 'Sager';

  @override
  String get liveChat => 'Live Chat';

  @override
  String get notifications => 'Notifikationer';

  @override
  String get myProfile => 'Min Profil';

  @override
  String get logout => 'Log ud';

  @override
  String get goodMorning => 'God morgen';

  @override
  String get goodDay => 'God dag';

  @override
  String get goodEvening => 'God aften';

  @override
  String get goodNight => 'Godnat';

  @override
  String get welcomeToICD => 'Velkommen til ICD360S e.V!';

  @override
  String get accountCreatedSuccessfully => 'Din konto er blevet oprettet.';

  @override
  String get today => 'I dag';

  @override
  String get membershipFeeDue => 'Medlemskontingent forfalden';

  @override
  String get pleaseTransferAnnualFee =>
      'Vær venlig at overføre det årlige kontingent.';

  @override
  String get newBadge => 'Ny';

  @override
  String get close => 'Luk';

  @override
  String get myAppointments => 'Mine aftaler';

  @override
  String get priority => 'Prioritet';

  @override
  String get messageLabel => 'Besked';

  @override
  String get reportProblems => 'Rapporter problemer';

  @override
  String get weRespondIn24Hours =>
      'Vi svarer dig inden for maksimalt 24 timer!';

  @override
  String get everythingOk => 'Alt OK!';

  @override
  String get haveProblemWeHelp => 'Har du et problem?\nVi tager os af det!';

  @override
  String get myMembership => 'Mit medlemskab';

  @override
  String get managePersonalDataAndFee =>
      'Administrer personlige data og kontingent';

  @override
  String get myAppointmentsTitle => 'Mine aftaler';

  @override
  String get appointmentsDescription =>
      'Her kan du se dine kommende aftaler.\nDu kan bekræfte din deltagelse eller afvise.';

  @override
  String get loadAppointments => 'Indlæs aftaler';

  @override
  String get myTickets => 'Mine sager';

  @override
  String get low => 'Lav';

  @override
  String get high => 'Høj';

  @override
  String get submit => 'Send';

  @override
  String get errorCreatingTicket => 'Fejl ved oprettelse af sag';

  @override
  String get verified => 'Verificeret';

  @override
  String get account => 'Konto';

  @override
  String get myDevices => 'Mine enheder';

  @override
  String get changeEmail => 'Skift e-mail';

  @override
  String get changePassword => 'Skift adgangskode';

  @override
  String get saveEmail => 'Gem e-mail';

  @override
  String get savePassword => 'Gem adgangskode';

  @override
  String get deviceLoggedOut => 'Enhed logget ud';

  @override
  String get emailChangedSuccessfully => 'E-mail ændret';

  @override
  String get errorChangingPassword => 'Fejl ved ændring af adgangskode';

  @override
  String get errorChangingEmail => 'Fejl ved ændring af e-mail';

  @override
  String get validEmailRequired => 'Angiv en gyldig e-mailadresse';

  @override
  String get confirmLogoutDevice => 'Log ud fra enhed?';

  @override
  String get confirmLogoutMessage =>
      'Vil du logge ud fra denne enhed?\n\nDu skal logge ind igen for at bruge denne enhed.';

  @override
  String get ipAddress => 'IP';

  @override
  String get platform => 'Platform';

  @override
  String trialWarningUrgentTitle(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days dage',
      one: '1 dag',
    );
    return 'Advarsel: Kun $_temp0 tilbage til kontosuspension!';
  }

  @override
  String get trialWarningTitle => 'Din konto er endnu ikke verificeret';

  @override
  String get trialWarningDescription =>
      'Udfyld venligst dine oplysninger i \"Min profil\". Efter 30 dage vil din konto automatisk blive suspenderet.';

  @override
  String trialDaysRemaining(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days dage',
      one: '1 dag',
    );
    return '$_temp0';
  }

  @override
  String get overview => 'Oversigt';

  @override
  String get member => 'Medlem';

  @override
  String get memberManagement => 'Medlemsstyring';

  @override
  String get reportProblemTooltip => 'Rapporter problem';

  @override
  String get newAppointmentsTitle => 'Nye aftaler';

  @override
  String get youHaveNewAppointment => 'Du har en ny aftale.';

  @override
  String youHaveNewAppointments(int count) {
    return 'Du har $count nye aftaler.';
  }

  @override
  String get appointmentReminderTomorrow => 'Påmindelse: Aftale i morgen';

  @override
  String tomorrowAppointment(String title) {
    return 'I morgen: $title';
  }

  @override
  String youHaveTomorrowAppointments(int count) {
    return 'Du har $count aftaler i morgen.';
  }

  @override
  String get appointmentsToday => 'Aftaler i dag';

  @override
  String todayAppointment(String title) {
    return 'I dag: $title';
  }

  @override
  String youHaveTodayAppointments(int count) {
    return 'Du har $count aftaler i dag.';
  }

  @override
  String get paymentReminder => 'Betalingspåmindelse';

  @override
  String paymentReminderMessage(int day, String method) {
    return 'I dag er den $day. i måneden – gennemfør venligst $method.';
  }

  @override
  String get paymentDayLabel => 'Betalingsdag (månedlig påmindelse)';

  @override
  String get updateAvailable => 'Opdatering tilgængelig';

  @override
  String newVersionAvailable(String version) {
    return 'En ny version er tilgængelig: $version';
  }

  @override
  String currentVersionLabel(String version) {
    return 'Nuværende version: $version';
  }

  @override
  String get changes => 'Ændringer:';

  @override
  String downloadProgress(String percent) {
    return 'Download: $percent%';
  }

  @override
  String get installationStarting => 'Installation starter...';

  @override
  String get appWillRestart => 'Appen genstartes automatisk.';

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
  String get later => 'Senere';

  @override
  String get updateNow => 'Opdater nu';

  @override
  String get downloading => 'Downloader...';

  @override
  String get downloadFailed => 'Download mislykkedes. Prøv igen senere.';

  @override
  String get searchingForUpdates => 'Søger efter opdateringer...';

  @override
  String get appUpToDate => 'Appen er opdateret';

  @override
  String get updateCheckError => 'Fejl ved søgning efter opdateringer';

  @override
  String get changelog => 'Ændringslog';

  @override
  String get terminConfirmed => 'Aftale bekræftet';

  @override
  String get terminDeclined => 'Aftale afvist';

  @override
  String get terminRescheduleRequested => 'Flytning anmodet';

  @override
  String get statusConfirmed => 'Bekræftet';

  @override
  String get statusDeclined => 'Afvist';

  @override
  String get statusRescheduling => 'Flytning';

  @override
  String get statusPending => 'Afventer';

  @override
  String get categoryVorstandssitzung => 'Bestyrelsesmøde';

  @override
  String get categoryMitgliederversammlung => 'Generalforsamling';

  @override
  String get categorySchulung => 'Uddannelse';

  @override
  String get categorySonstiges => 'Andet';

  @override
  String openCount(int count) {
    return '$count åbne';
  }

  @override
  String get refresh => 'Opdater';

  @override
  String get filterUpcoming => 'Kommende';

  @override
  String get filterPast => 'Tidligere';

  @override
  String get filterAll => 'Alle';

  @override
  String get noUpcomingAppointments => 'Ingen kommende aftaler';

  @override
  String get noPastAppointments => 'Ingen tidligere aftaler';

  @override
  String get noAppointmentsAvailable => 'Ingen aftaler';

  @override
  String get appointmentsShownHere => 'Dine aftaler vises her';

  @override
  String get dateLabel => 'Dato';

  @override
  String get timeLabel => 'Tid';

  @override
  String get locationLabel => 'Sted';

  @override
  String get createdByLabel => 'Oprettet af';

  @override
  String get descriptionLabel => 'Beskrivelse';

  @override
  String get ticketLabel => 'Sag';

  @override
  String get yourStatus => 'Din status: ';

  @override
  String reasonLabel(String reason) {
    return 'Årsag: $reason';
  }

  @override
  String durationMinutes(int minutes) {
    return '$minutes min';
  }

  @override
  String get confirm => 'Bekræft';

  @override
  String get decline => 'Afvis';

  @override
  String get reschedule => 'Flyt';

  @override
  String get requestReschedule => 'Anmod om flytning';

  @override
  String appointmentLabel(String title) {
    return 'Aftale: $title';
  }

  @override
  String get rescheduleReason => 'Årsag til flytning *';

  @override
  String get rescheduleReasonHint => 'Angiv en årsag...';

  @override
  String get pleaseProvideReason => 'Angiv en årsag';

  @override
  String get request => 'Anmod';

  @override
  String get ticketStatusOpen => 'Åben';

  @override
  String get ticketStatusInProgress => 'Under behandling';

  @override
  String get ticketStatusWaitingMember => 'Venter på medlem';

  @override
  String get ticketStatusWaitingStaff => 'Venter på medarbejder';

  @override
  String get ticketStatusWaitingAuthority => 'Venter på myndighed';

  @override
  String get ticketStatusDone => 'Afsluttet';

  @override
  String get ticketPriorityHigh => 'Høj';

  @override
  String get ticketPriorityMedium => 'Middel';

  @override
  String get ticketPriorityLow => 'Lav';

  @override
  String get comments => 'Kommentarer';

  @override
  String get documents => 'Dokumenter';

  @override
  String get details => 'Detaljer';

  @override
  String get replySent => 'Svar sendt';

  @override
  String get sendError => 'Fejl ved afsendelse';

  @override
  String get uploading => 'Uploader...';

  @override
  String fileUploaded(String filename) {
    return '$filename uploadet';
  }

  @override
  String get uploadFailed => 'Upload mislykkedes';

  @override
  String get openError => 'Fejl ved åbning';

  @override
  String get noRepliesYet => 'Ingen svar endnu';

  @override
  String get waitingForSupport => 'Venter på svar fra support';

  @override
  String get writeReply => 'Skriv et svar...';

  @override
  String get attachFile => 'Vedhæft fil';

  @override
  String documentsCount(int count) {
    return 'Dokumenter ($count)';
  }

  @override
  String get upload => 'Upload';

  @override
  String get noDocuments => 'Ingen dokumenter';

  @override
  String get allowedFormats => 'Tilladte formater: PDF, JPEG, JPG, TXT, ZIP';

  @override
  String get yourMessage => 'Din besked:';

  @override
  String get translation => 'Oversættelse';

  @override
  String get original => 'Original';

  @override
  String get originalText => 'Originaltekst';

  @override
  String get autoTranslated => 'Automatisk oversat';

  @override
  String get originalTapTranslation => 'Original · Tryk for oversættelse';

  @override
  String get translatedTapOriginal => 'Oversat · Tryk for original';

  @override
  String get justNow => 'Lige nu';

  @override
  String minutesAgo(int minutes) {
    return '$minutes min siden';
  }

  @override
  String hoursAgo(int hours) {
    return '$hours timer siden';
  }

  @override
  String daysAgo(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'dage',
      one: 'dag',
    );
    return '$days $_temp0 siden';
  }

  @override
  String get createdLabel => 'Oprettet';

  @override
  String get updatedLabel => 'Opdateret';

  @override
  String get handlerLabel => 'Behandler';

  @override
  String get doneLabel => 'Afsluttet';

  @override
  String get newTicketTitle => 'Ny sag';

  @override
  String get categoryOptional => 'Kategori (valgfri)';

  @override
  String get selectCategory => 'Vælg';

  @override
  String get subjectLabel => 'Emne';

  @override
  String get fillAllFields => 'Udfyld alle felter';

  @override
  String ticketCreatedId(int id) {
    return 'Sag #$id oprettet';
  }

  @override
  String get priorityLabel => 'Prioritet: ';

  @override
  String get supportOffline => 'Support offline';

  @override
  String get lastSeenSeconds => 'Aktiv for få sekunder siden';

  @override
  String lastSeenMinutes(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: 'minutter',
      one: 'minut',
    );
    return 'Aktiv for $minutes $_temp0 siden';
  }

  @override
  String lastSeenHours(int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: 'timer',
      one: 'time',
    );
    return 'Aktiv for $hours $_temp0 siden';
  }

  @override
  String lastSeenDays(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'dage',
      one: 'dag',
    );
    return 'Aktiv for $days $_temp0 siden';
  }

  @override
  String get online => 'Online';

  @override
  String get callSupport => 'Ring';

  @override
  String get typeMessage => 'Skriv en besked...';

  @override
  String get callBusy => 'Support er optaget';

  @override
  String get callRejected => 'Opkald afvist';

  @override
  String get callFailed => 'Opkald kunne ikke forbindes';

  @override
  String get callEnded => 'Opkald afsluttet';

  @override
  String get callSupportBusy => 'Support er allerede i et andet opkald';

  @override
  String get errorStartingChat => 'Fejl ved start af chat';

  @override
  String get errorStartingCall => 'Fejl ved start af opkald';

  @override
  String get errorConnecting => 'Forbindelsesfejl';

  @override
  String get errorDownloading => 'Fejl ved download';

  @override
  String get errorUploading => 'Fejl ved upload';

  @override
  String get errorSending => 'Fejl ved afsendelse';

  @override
  String get errorPickingPhotos => 'Fejl ved valg af fotos';

  @override
  String get errorPickingFiles => 'Fejl ved valg af filer';

  @override
  String get errorTakingPhoto => 'Fejl ved optagelse af foto';

  @override
  String get fileNotLoaded => 'Filen kunne ikke indlæses';

  @override
  String get attachmentIdMissing => 'Vedhæftnings-ID mangler';

  @override
  String get camera => 'Kamera';

  @override
  String get gallery => 'Galleri';

  @override
  String get file => 'Fil';

  @override
  String get notifNewMessageFrom => 'Ny besked fra';

  @override
  String get notifUrgentPrefix => 'HASTENDE';

  @override
  String get notifUrgentMessage => 'HASTENDE BESKED';

  @override
  String get notifIncomingCall => 'Indgående opkald';

  @override
  String get notifCallingYou => 'ringer...';

  @override
  String get notifUpdateAvailable => 'Opdatering tilgængelig';

  @override
  String get notifVersionAvailable => 'er nu tilgængelig';

  @override
  String get notifConnected => 'Forbundet';

  @override
  String get notifDisconnected => 'Afbrudt';

  @override
  String get notifConnectedBody => 'Du er nu forbundet til serveren.';

  @override
  String get notifDisconnectedBody => 'Forbindelsen til serveren blev afbrudt.';

  @override
  String get notifError => 'Fejl';

  @override
  String get retry => 'Prøv igen';

  @override
  String get save => 'Gem';

  @override
  String get accept => 'Accepter';

  @override
  String get selectFile => 'Vælg fil';

  @override
  String get dataLoadingText => 'Indlæser data...';

  @override
  String get dataSavedSuccess => 'Data gemt';

  @override
  String get errorSaving => 'Fejl ved gemning';

  @override
  String get errorLoading => 'Fejl ved indlæsning';

  @override
  String savedFilename(String filename) {
    return 'Gemt: $filename';
  }

  @override
  String get logsCopied => 'Logs kopieret!';

  @override
  String get passwordMinEightChars => 'Adgangskoden skal være mindst 8 tegn';

  @override
  String get passwordChangeSuccess => 'Adgangskode ændret';

  @override
  String get emailChangeError => 'Fejl ved ændring af e-mail';

  @override
  String get acceptDocumentCheckbox => 'Jeg har læst og accepterer dokumentet.';

  @override
  String loadingErrorGeneric(String details) {
    return 'Indlæsningsfejl: $details';
  }

  @override
  String get incomingCallTitle => 'Indgående opkald';

  @override
  String ringingFor(int seconds) {
    return 'Ringer i ${seconds}s';
  }

  @override
  String get rejectCall => 'Afvis';

  @override
  String get acceptCall => 'Besvar';

  @override
  String get unmute => 'Slå lyd til';

  @override
  String get mute => 'Slå lyd fra';

  @override
  String get hangUp => 'Læg på';

  @override
  String get calling => 'Ringer...';

  @override
  String autoRejectIn(int seconds) {
    return 'Automatisk afvisning om $seconds sekunder';
  }

  @override
  String get speakerOn => 'Højttaler';

  @override
  String get speakerOff => 'Ørestykke';

  @override
  String get micMuted => 'Slået fra';

  @override
  String get micOn => 'Mikrofon';

  @override
  String get connectionExcellent => 'Fremragende';

  @override
  String get connectionGood => 'God';

  @override
  String get connectionWeak => 'Svag';

  @override
  String get connectionLost => 'Afbrudt';

  @override
  String get personalData => 'Personlige data';

  @override
  String get personalDataSubtitle => 'Fornavn, efternavn, adresse';

  @override
  String get membershipFee => 'Kontingent';

  @override
  String annualFeeYear(String year) {
    return 'Årskontingent $year';
  }

  @override
  String get amount => 'Beløb:';

  @override
  String get dueBy => 'Forfald:';

  @override
  String get paid => 'Betalt';

  @override
  String get versionHistory => 'Versionshistorik';

  @override
  String lastUpdated(String date) {
    return 'Sidst opdateret: $date';
  }

  @override
  String get noVersionHistory => 'Ingen versionshistorik tilgængelig';

  @override
  String get failedLoadChangelog => 'Kunne ikke indlæse ændringslog';

  @override
  String get callMember => 'Ring til medlem';

  @override
  String get closeConversation => 'Luk samtale';

  @override
  String get chatOffline => 'Offline';

  @override
  String get attachFiles => 'Vedhæft filer (maks. 10, 50MB)';

  @override
  String get conversationClosed => 'Denne samtale er lukket';

  @override
  String get noMessages => 'Ingen beskeder';

  @override
  String get goBack => 'Tilbage';

  @override
  String get goForward => 'Frem';

  @override
  String get homePage => 'Hjem';

  @override
  String get firstNameLabel => 'Fornavn';

  @override
  String get lastNameLabel => 'Efternavn';

  @override
  String get streetLabel => 'Gade';

  @override
  String get houseNumberLabel => 'Nr.';

  @override
  String get postalCodeLabel => 'Postnummer';

  @override
  String get cityLabel => 'By';

  @override
  String get phoneMobileLabel => 'Telefon (Mobil)';

  @override
  String get phoneLandlineLabel => 'Telefon (Fastnet)';

  @override
  String get newEmailLabel => 'Ny e-mailadresse';

  @override
  String get currentPasswordLabel => 'Nuværende adgangskode';

  @override
  String get newPasswordLabel => 'Ny adgangskode';

  @override
  String get confirmPasswordLabel => 'Bekræft adgangskode';

  @override
  String get emailChangedSuccess => 'E-mail ændret';

  @override
  String get reasonLabel2 => 'Årsag';

  @override
  String get downloadFailed2 => 'Download mislykkedes';

  @override
  String get downloadTooltip => 'Download';

  @override
  String get copyLogs => 'Kopiér logfiler';

  @override
  String get deleteLogs => 'Slet logfiler';

  @override
  String get autoScrollOn => 'Automatisk rulning TIL';

  @override
  String get autoScrollOff => 'Automatisk rulning FRA';

  @override
  String get unknownValue => 'Ukendt';

  @override
  String get payment => 'Betaling';

  @override
  String get warningType_ermahnung => 'Advarsel';

  @override
  String get warningType_abmahnung => 'Påmindelse';

  @override
  String get warningType_letzte => 'Sidste advarsel';

  @override
  String warningsTotal(int count) {
    return 'I alt: $count';
  }

  @override
  String warningsErmahnung(int count) {
    return 'Advarsler: $count';
  }

  @override
  String warningsAbmahnung(int count) {
    return 'Påmindelser: $count';
  }

  @override
  String warningsLetzte(int count) {
    return 'Sidste: $count';
  }

  @override
  String get noWarnings => 'Ingen advarsler';

  @override
  String get noWarningsDescription => 'Du har ingen advarsler i øjeblikket.';

  @override
  String createdBy(String name) {
    return 'Oprettet af: $name';
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
  String get stufe1_name => 'Personlige data';

  @override
  String get stufe2_name => 'Medlemstype';

  @override
  String get stufe3_name => 'Økonomisk situation';

  @override
  String get stufe4_name => 'Betalingsmetode';

  @override
  String get stufe5_name => 'Medlemskabets start';

  @override
  String get stufe6_name => 'Vedtægter';

  @override
  String get stufe7_name => 'Privatlivspolitik';

  @override
  String get stufe8_name => 'Fortrydelsesret';

  @override
  String get memberType_ordentlich => 'Ordinært medlem';

  @override
  String get memberType_foerder => 'Støttemedlem';

  @override
  String get memberType_ehren => 'Æresmedlem';

  @override
  String get memberDesc_ordentlich =>
      'Aktivt medlem med stemmeret. Deltager i foreningens tjenester (email, cloud, bureaukratisk støtte).';

  @override
  String get memberDesc_foerder =>
      'Støtter foreningen med bidrag. Kan deltage i generalforsamlingen med rådgivende stemme, uden stemmeret eller valgbarhed til bestyrelsen.';

  @override
  String get memberDesc_ehren =>
      'Har rettighederne som et ordinært medlem uden pligt til at betale kontingent. Udnævnt af generalforsamlingen eller bestyrelsen.';

  @override
  String get payMethod_ueberweisung => 'Bankoverførsel';

  @override
  String get payMethod_dauerauftrag => 'Fast overførsel';

  @override
  String get verifyStatus_geprueft => 'Verificeret';

  @override
  String get verifyStatus_ausgefuellt => 'Udfyldt';

  @override
  String get verifyStatus_abgelehnt => 'Afvist';

  @override
  String get verifyStatus_offen => 'Åben';

  @override
  String get fillRequiredFields => 'Udfyld alle påkrævede felter.';

  @override
  String get personalDataSaved => 'Personlige data gemt';

  @override
  String get selectMemberType => 'Vælg en medlemstype.';

  @override
  String get memberTypeSaved => 'Medlemstype gemt';

  @override
  String get selectOption => 'Vælg en mulighed.';

  @override
  String get financialSaved => 'Økonomisk situation gemt';

  @override
  String get selectPaymentMethod => 'Vælg en betalingsmetode.';

  @override
  String get paymentDataSaved => 'Betalingsdata gemt';

  @override
  String get selectDate => 'Vælg en dato.';

  @override
  String get membershipStartSaved => 'Medlemskabets start gemt';

  @override
  String get fileTooLarge => 'Filen er for stor (maks. 10 MB).';

  @override
  String get leistungsbescheidUploaded => 'Ydelsesattest uploadet';

  @override
  String get verificationProgress => 'Verificeringsfremskridt';

  @override
  String get notApplicable => 'Ikke relevant';

  @override
  String get socialBenefitsExempt =>
      'Betalingsmetode ikke påkrævet for modtagere af sociale ydelser.';

  @override
  String get locked => 'Låst';

  @override
  String completePreviousStep(int step) {
    return 'Gennemfør venligst trin $step først.';
  }

  @override
  String rejectedNote(String note) {
    return 'Afvist: $note';
  }

  @override
  String get waitingForReview => 'Afventer gennemgang af bestyrelsen.';

  @override
  String get stepApproved => 'Dette trin er gennemgået og godkendt.';

  @override
  String get changesViaChat => 'Ændringer kun mulige via chat.';

  @override
  String get firstNameRequired => 'Fornavn *';

  @override
  String get lastNameRequired => 'Efternavn *';

  @override
  String get birthDateLabel => 'Fødselsdato *';

  @override
  String get streetRequired => 'Gade *';

  @override
  String get houseNumberRequired => 'Nr. *';

  @override
  String get cityRequired => 'By *';

  @override
  String get phoneRequired => 'Telefonnummer *';

  @override
  String get phonePurpose => 'Formål: Kontakt når ikke tilgængelig via appen';

  @override
  String get selectMemberTypePrompt => 'Vælg den ønskede medlemstype:';

  @override
  String get financialExplanation =>
      'For at kontrollere, om du er berettiget til reduktion af kontingent, har vi brug for følgende oplysninger. De bruges udelukkende til at fastsætte dit kontingent.';

  @override
  String get socialBenefitsQuestion =>
      'Modtager du i øjeblikket sociale ydelser?';

  @override
  String get optionBuergergeld => 'Ja, borgerydelse (Job Center)';

  @override
  String get optionSozialamt => 'Ja, sociale ydelser (Socialforvaltningen)';

  @override
  String get optionNoBenefits => 'Nej, jeg modtager ikke sociale ydelser';

  @override
  String get feeExempt => 'Dit månedlige kontingent er: 0,00 €/måned';

  @override
  String get uploadLeistungsbescheid => 'Upload ydelsesattest';

  @override
  String get uploadLeistungsbescheidHint =>
      'Upload en aktuel ydelsesattest inden for 14 dage for at bekræfte kontingentfritagelsen.';

  @override
  String get allowedFormatsUpload =>
      'Tilladte formater: PDF, JPG, PNG (maks. 10 MB)';

  @override
  String get feeRegular => 'Dit månedlige kontingent er: 25,00 €/måned';

  @override
  String paymentDayReminder(int day) {
    return 'Du vil blive mindet den $day. i hver måned.';
  }

  @override
  String get membershipStartPrompt =>
      'Vælg hvornår dit medlemskab skal starte.';

  @override
  String get optionAfterVerification => 'Efter verificering';

  @override
  String get optionAfterVerificationDesc =>
      'Medlemskabet begynder fra dagen for bestyrelsens bekræftelse.';

  @override
  String get optionRetroFoundation =>
      'Tilbagevirkende til stiftelsesdatoen (01.08.2025)';

  @override
  String get optionRetroFoundationDesc =>
      'Du bliver tilbagevirkende medlem fra foreningens stiftelse.';

  @override
  String get optionRetroCustom => 'Tilbagevirkende til en anden dato';

  @override
  String get optionRetroCustomDesc =>
      'Vælg en dato mellem 01.08.2025 og i dag.';

  @override
  String get selectDateLabel => 'Vælg dato';

  @override
  String get selectDateHint => 'Vælg dato...';

  @override
  String get dateNotBefore => 'Ikke før 01.08.2025 (stiftelsesdato)';

  @override
  String get feeExemptRetro =>
      'Kontingentfritagelse: 0,00 € tilbagevirkende.\nKun medlemskabsdatoen sættes tilbagevirkende.';

  @override
  String get retroactiveFees => 'Tilbagevirkende kontingenter';

  @override
  String retroFeeCalculation(
      String from, String to, String months, String total) {
    return 'Periode: $from – $to\nMåneder: $months\nKontingent: $months × 25,00 € = $total €';
  }

  @override
  String get pleaseReadSatzung => 'Læs foreningens vedtægter.';

  @override
  String get pleaseReadDatenschutz => 'Læs privatlivspolitikken.';

  @override
  String get pleaseReadWiderruf => 'Læs fortrydelsesretten.';

  @override
  String get acceptedAtRegistration => 'Accepteret ved registrering';

  @override
  String get confirmedByBoard => 'Bekræftes efter bestyrelsens gennemgang.';

  @override
  String get docSatzung => 'Vedtægter';

  @override
  String get docDatenschutz => 'Privatlivspolitik';

  @override
  String get docWiderruf => 'Fortrydelsesret';

  @override
  String acceptedAtRegCount(int count) {
    return 'Accepteret ved registrering ($count/3)';
  }

  @override
  String acceptedOn(String date) {
    return 'Accepteret den $date';
  }

  @override
  String get notAccepted => 'Ikke accepteret';

  @override
  String get statusAccepted => 'Accepteret';

  @override
  String get nameTooLong => 'Navn for langt (maks. 100 tegn)';

  @override
  String get emailTooLong => 'E-mail for lang (maks. 255 tegn)';

  @override
  String get legalAcknowledgePrefix => 'Jeg har læst ';

  @override
  String get legalAcknowledgeSuffix => '.';

  @override
  String get legalStatutesSuffix =>
      ' for ICD360S e.V. og anerkender dem som bindende.';

  @override
  String get legalPleaseReadFirst => '(læs venligst først)';

  @override
  String get statusActive => 'Aktiv';

  @override
  String get statusSuspended => 'Suspenderet';

  @override
  String get statusNew => 'Ny';

  @override
  String get statusCancelled => 'Opsagt';

  @override
  String get statusDeleted => 'Slettet';

  @override
  String get roleMitglied => 'Medlem';

  @override
  String get roleVorsitzer => 'Formand';

  @override
  String get roleStellvertreter => 'Stedfortræder';

  @override
  String get roleSchatzmeister => 'Kasserer';

  @override
  String get roleSchriftfuehrer => 'Sekretær';

  @override
  String get roleBeisitzer => 'Bisidder';

  @override
  String get roleKassierer => 'Kasserer';

  @override
  String get roleKassenpruefer => 'Revisor';

  @override
  String get roleEhrenamtlich => 'Frivillig';

  @override
  String get roleMitgliedergruender => 'Stiftende Medlem';

  @override
  String get roleEhrenmitglied => 'Æresmedlem';

  @override
  String get roleFoerdermitglied => 'Støttemedlem';

  @override
  String get memberTypeNotSet => 'Endnu ikke fastsat';

  @override
  String get payMethodSepa => 'SEPA-betalingsservice';

  @override
  String get labelStatus => 'Status';

  @override
  String get labelMemberNumber => 'Medlemsnummer';

  @override
  String get labelRole => 'Rolle';

  @override
  String get labelMemberType => 'Medlemstype';

  @override
  String get labelPaymentMethod => 'Betalingsmetode';

  @override
  String get labelRegisteredOn => 'Registreret den';

  @override
  String get labelLastLogin => 'Sidste login';

  @override
  String get labelMemberSince => 'Medlem siden';

  @override
  String get neverLoggedIn => 'Aldrig';

  @override
  String get notActivatedYet => 'Endnu ikke aktiveret';

  @override
  String get tabVerification => 'Verifikation';

  @override
  String get tabWarnings => 'Advarsler';

  @override
  String get tabDocuments => 'Dokumenter';

  @override
  String get tabMembership => 'Medlemskab';

  @override
  String get pleaseEnterFirstName => 'Indtast fornavn';

  @override
  String get pleaseEnterLastName => 'Indtast efternavn';

  @override
  String get noFileDataReceived => 'Ingen data modtaget';

  @override
  String get openFile => 'Åbn';

  @override
  String get noMicrophoneError =>
      'Ingen mikrofon fundet. Tilslut en mikrofon og prøv igen.';

  @override
  String get startConversation => 'Start en samtale!';

  @override
  String get staffWillReply => 'En medarbejder vil snart svare dig.';

  @override
  String get inCall => 'I opkald...';

  @override
  String get registration => 'Registrering';

  @override
  String get deactivation => 'Deaktivering';

  @override
  String get deactivatedOn => 'Deaktiveret den';

  @override
  String get accountAutoSuspend =>
      'Konti, der ikke verificeres inden for 30 dage, vil automatisk blive suspenderet.';

  @override
  String get documentsProvidedByBoard => 'Dokumenter leveres af bestyrelsen.';

  @override
  String get noDocumentsAvailable => 'Ingen dokumenter';

  @override
  String get noDocumentsDescription =>
      'Der er endnu ikke leveret dokumenter til dig.';

  @override
  String uploadedBy(String name) {
    return 'Uploadet af: $name';
  }

  @override
  String stepsCompleted(int completed, int total) {
    return '$completed/$total trin gennemført';
  }

  @override
  String dayOfMonth(int day) {
    return '$day. i måneden';
  }

  @override
  String changeField(String field) {
    return 'Ændre $field';
  }

  @override
  String openDocument(String name) {
    return 'Åbn $name';
  }

  @override
  String logEntries(int count) {
    return '$count poster';
  }

  @override
  String get noLogs => 'Ingen logfiler';

  @override
  String get newLoginDetected => 'Nyt login registreret';

  @override
  String get errorNoInternet =>
      'Ingen internetforbindelse. Kontrollér venligst dit netværk.';

  @override
  String get errorTimeout => 'Serveren svarer ikke. Prøv venligst igen senere.';

  @override
  String get errorServer => 'Serverfejl. Prøv venligst igen senere.';

  @override
  String get errorConnection => 'Forbindelsesfejl. Prøv venligst igen senere.';

  @override
  String get errorUnexpected =>
      'Der opstod en uventet fejl. Prøv venligst igen senere.';

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
  String get claudiuWelcomeMorning => 'Godmorgen';

  @override
  String get claudiuWelcomeDay => 'Goddag';

  @override
  String get claudiuWelcomeEvening => 'Godaften';

  @override
  String get claudiuWelcomeNight => 'Godaften';

  @override
  String get claudiuWelcomeVisitor => 'kære besøgende';

  @override
  String get claudiuWelcomeAsk => 'Hvordan kan jeg hjælpe?';

  @override
  String get claudiuWelcomeBecomeMember => 'Jeg vil gerne blive medlem';

  @override
  String get claudiuWelcomeLogin => 'Jeg er allerede medlem og vil logge ind';

  @override
  String get claudiuWelcomeProblem => 'Jeg har et problem med appen';

  @override
  String get claudiuWelcomeEmergency => 'Nødstilfælde — ring til os';

  @override
  String get claudiuWelcomeMascotName => 'Claudiu';

  @override
  String get claudiuWelcomeEmergencyIntro =>
      'Før du ringer — vores åbningstider:';

  @override
  String get claudiuWelcomeScheduleOffice => 'På kontoret';

  @override
  String get claudiuWelcomeScheduleField => 'I felten med klienter';

  @override
  String get claudiuWelcomeOutsideHoursNote =>
      'Uden for disse tider tager vi kun nødstilfælde. Du kan også sende sms til samme nummer — vi vender tilbage.';

  @override
  String get claudiuWelcomeCallNow => 'Ring nu';

  @override
  String get claudiuWelcomeSendSms => 'Send SMS';

  @override
  String get claudiuWelcomeSmsBody =>
      'Nødstilfælde ICD360S e.V. — kontakt mig venligst hurtigst muligt.';

  @override
  String get claudiuWelcomeCloseButton => 'Luk';

  @override
  String get claudiuLoginWelcome => 'Velkommen tilbage, kære medlem!';

  @override
  String get claudiuLoginAsk => 'Fortæl mig venligst dit medlemsnummer.';

  @override
  String get claudiuLoginProgress => 'Næsten… bliv ved med at skrive.';

  @override
  String get claudiuLoginReady => 'Perfekt! Tryk på knappen nedenfor.';

  @override
  String get claudiuLoginLoading => 'Tjekker identitet… 🔍';

  @override
  String get claudiuLoginFoundPlain => 'Fandt dig! Logger ind…';

  @override
  String claudiuLoginFoundNamed(String name) {
    return 'Fandt dig, $name! Logger ind…';
  }

  @override
  String get claudiuLoginError =>
      'Hm, jeg kan ikke finde det nummer. Skrev du det rigtigt?';

  @override
  String get claudiuLoginForgotHeader => 'Glemt dit medlemsnummer?';

  @override
  String get claudiuLoginNoSms =>
      'Vi sender ikke nummeret via e-mail eller sms.';

  @override
  String get claudiuLoginOnlyWay =>
      'Den eneste vej: et personligt møde på foreningens kontor, efter ID-kontrol.';

  @override
  String get claudiuLoginContactUs => 'Ring for at aftale tid:';

  @override
  String get claudiuDiagnosticGreeting =>
      'Før du går ind, et hurtigt spørgsmål';

  @override
  String get claudiuDiagnosticAsk =>
      'Må jeg sende anonyme rapporter, så udviklerne kan forbedre appen?';

  @override
  String get claudiuDiagnosticYes => 'Ja, jeg vil gerne hjælpe';

  @override
  String get claudiuDiagnosticNo => 'Nej, jeg kigger bare';

  @override
  String get claudiuDiagnosticTellMore => 'Fortæl mig mere';

  @override
  String get claudiuDiagnosticSendsHeader => '📤 Hvad vi SENDER (anonymt):';

  @override
  String get claudiuDiagnosticSends1 =>
      'En anonym enhedskode (IKKE dit medlemsnummer)';

  @override
  String get claudiuDiagnosticSends2 => 'Din rolle (medlem / bestyrelse)';

  @override
  String get claudiuDiagnosticSends3 =>
      'Operativsystem (Linux / Android / iOS / Windows)';

  @override
  String get claudiuDiagnosticSends4 => 'Valgt sprog';

  @override
  String get claudiuDiagnosticSends5 => 'Batteriniveau + tilstand';

  @override
  String get claudiuDiagnosticSends6 => 'Nuværende skærm';

  @override
  String get claudiuDiagnosticSends7 => 'Sessionens varighed (sekunder)';

  @override
  String get claudiuDiagnosticSends8 => 'Fejl hvis nogen (sidste 10)';

  @override
  String get claudiuDiagnosticSends9 => 'Navigation (sidste 20 skærme)';

  @override
  String get claudiuDiagnosticNeverHeader => '🛡️ Hvad vi ALDRIG sender:';

  @override
  String get claudiuDiagnosticNever1 => 'Dit rigtige navn';

  @override
  String get claudiuDiagnosticNever2 => 'E-mailadresse';

  @override
  String get claudiuDiagnosticNever3 => 'Telefonnummer';

  @override
  String get claudiuDiagnosticNever4 => 'Adgangskode';

  @override
  String get claudiuDiagnosticNever5 => 'Indhold af chatbeskeder';

  @override
  String get claudiuDiagnosticNever6 => 'Indhold af tickets';

  @override
  String get claudiuDiagnosticNever7 => 'Dokumenter eller vedhæftninger';

  @override
  String get claudiuDiagnosticTechHeader => '📡 Tekniske detaljer:';

  @override
  String get claudiuDiagnosticTech1 => 'Sendes hvert 2. minut';

  @override
  String get claudiuDiagnosticTech2 =>
      'TLS-krypteret forbindelse, fastlåst certifikat';

  @override
  String get claudiuDiagnosticTech3 =>
      'Du kan slå det fra når som helst i Indstillinger';

  @override
  String get claudiuProblemHelpTitle => 'Hvordan kan jeg hjælpe?';

  @override
  String get claudiuProblemHelpGreeting => 'Hvad skete der?';

  @override
  String get claudiuProblemHelpAsk => 'Hvordan vil du fortælle mig det?';

  @override
  String get claudiuProblemHelpWriteTitle => 'Skriv en rapport';

  @override
  String get claudiuProblemHelpWriteBody =>
      'Med trin-for-trin detaljer. Teamet får teksten og løser det senere.';

  @override
  String get claudiuProblemHelpChatTitle => 'Lad os tale nu';

  @override
  String get claudiuProblemHelpChatBody =>
      'Anonym chat med en operatør. Svar i realtid hvis nogen er online.';

  @override
  String get claudiuProblemHelpAltCallHeader => 'Eller, hvis det haster:';

  @override
  String get claudiuProblemHelpAltCallLabel => 'Ring til os';

  @override
  String get claudiuAnonymousChatTitle => 'Anonym chat';

  @override
  String get claudiuAnonymousChatGreeting => 'Hej!';

  @override
  String get claudiuAnonymousChatWelcome =>
      'Jeg lytter. Skriv hvad du vil — intet navn nødvendigt. Jeg svarer så snart jeg er her.';

  @override
  String get claudiuAnonymousChatHint => 'Skriv en besked…';

  @override
  String get claudiuAnonymousChatWaitingOperator =>
      'Venter på at en operatør svarer…';

  @override
  String get claudiuVorsitzerConnectedTitle => 'Hej!';

  @override
  String get claudiuVorsitzerConnectedBody =>
      'Tak fordi du skrev — du er nu forbundet med en Vorsitzer. Fortæl os, hvordan vi kan hjælpe med din medlemsansøgning.';

  @override
  String get claudiuVorsitzerConnectedSender => 'Vorsitzer';

  @override
  String get claudiuQuickReplyValidationTime =>
      'Hvor lang tid tager godkendelsen?';

  @override
  String get claudiuQuickReplyDocuments => 'Hvilke dokumenter skal jeg bruge?';

  @override
  String get claudiuQuickReplyStepProblem => 'Jeg er kørt fast i et trin';

  @override
  String get claudiuQuickReplyHuman => 'Kan jeg tale med nogen lige nu?';

  @override
  String get claudiuAnonymousChatConnecting => 'Forbinder…';

  @override
  String get claudiuAnonymousChatConnectionFailed =>
      'Kunne ikke åbne chatten. Prøv igen eller ring til os.';

  @override
  String get claudiuAnonymousChatRetry => 'Prøv igen';

  @override
  String get claudiuAnonymousChatOnline => 'Forbundet';

  @override
  String get claudiuAnonymousChatOffline => 'Genopretter forbindelse…';

  @override
  String get claudiuAnonymousChatAdminTyping => 'Operatøren skriver…';

  @override
  String get claudiuProblemReportTitle => 'Rapportér et problem';

  @override
  String get claudiuProblemReportGreeting => 'Hvad skete der?';

  @override
  String get claudiuProblemReportAsk =>
      'Fortæl detaljeret, og jeg sender rapporten videre til teamet.';

  @override
  String get claudiuProblemReportIncludeHeader => 'Inkluder venligst:';

  @override
  String get claudiuProblemReportIncludeBullets1 =>
      'Hvad du gjorde, da problemet opstod';

  @override
  String get claudiuProblemReportIncludeBullets2 =>
      'Eventuelle fejlmeddelelser du så';

  @override
  String get claudiuProblemReportIncludeBullets3 => 'Hvilken skærm du var på';

  @override
  String get claudiuProblemReportIncludeBullets4 =>
      'Crasher appen, lukker den, eller viser den en blank skærm?';

  @override
  String get claudiuProblemReportIncludeBullets5 =>
      'Sker det hver gang eller kun en gang?';

  @override
  String get claudiuProblemReportDescriptionLabel => 'Din beskrivelse';

  @override
  String get claudiuProblemReportDescriptionHint =>
      'F.eks.: Når jeg åbner chatten, får jeg en \"Connection error\"-besked og appen reagerer ikke…';

  @override
  String claudiuProblemReportTooShort(int count) {
    return 'Lidt flere detaljer, tak (mindst $count tegn)';
  }

  @override
  String get claudiuProblemReportSubmit => 'Send rapport';

  @override
  String get claudiuProblemReportSubmitting => 'Sender…';

  @override
  String get claudiuProblemReportSentTitle => 'Tak!';

  @override
  String get claudiuProblemReportSentBody =>
      'Rapporten er sendt. Vores team kigger på det hurtigst muligt.';

  @override
  String get claudiuProblemReportSentClose => 'Forstået';

  @override
  String get claudiuProblemReportSendFailed =>
      'Kunne ikke sende rapporten. Ring til os for akut hjælp.';

  @override
  String get claudiuProblemReportAlt => 'Eller, hvis det haster:';

  @override
  String get claudiuProblemReportCallLabel => 'Ring til os';

  @override
  String claudiuApprovalGreeting(String name) {
    return 'Hej, $name! 👋';
  }

  @override
  String get claudiuApprovalGreetingNoName => 'Hej! 👋';

  @override
  String get claudiuApprovalGladToSeeYou => 'Jeg er glad for, at du er her!';

  @override
  String get claudiuApprovalCheckingForSafety =>
      'For din sikkerhed tjekker en Vorsitzer nu din login-anmodning. 🛡️';

  @override
  String get claudiuApprovalMonthlyExplain =>
      '💡 Vi gør dette hver 30. dag for at sikre, at det virkelig er dig. Det er som et sikkerhedstjek — tager maks 5 minutter.';

  @override
  String get claudiuApprovalSuccess =>
      'Færdig! 🎉 Vorsitzer genkendte dig. Logger dig ind…';

  @override
  String get claudiuApprovalDenied => 'Hm, Vorsitzer afviste din anmodning. 😔';

  @override
  String get claudiuApprovalDeniedHelp =>
      'Hvis du tror, det er en fejl, så ring til os, så vi kan løse det.';

  @override
  String get claudiuApprovalExpired =>
      'De 5 minutter er gået, og vi hørte ikke fra Vorsitzer.';

  @override
  String get claudiuApprovalExpiredHelp =>
      'Ring til os, og vi kan godkende din anmodning direkte. 📞';

  @override
  String get claudiuApprovalCallUs => 'Ring til os';

  @override
  String get claudiuApprovalTryAgain => 'Prøv igen';

  @override
  String get claudiuApprovalCancel => 'Annullér';

  @override
  String get claudiuApprovalClose => 'Luk';

  @override
  String get wizardIntroBubble1 =>
      'Hej, besøgende! 👋 Tak, fordi du vil blive en del af vores familie.';

  @override
  String get wizardIntroBubble2 =>
      'Jeg hedder Claudiu. I foråret 2025 havde jeg en klar vision: at skabe en forening, der hjælper mennesker i nød — frivilligt, fra hjertet, uden unødigt bureaukrati. ❤️';

  @override
  String get wizardIntroBubble3 =>
      'Jeg begyndte at tale med klienterne, jeg besøgte. Jeg fortalte dem min drøm. Og hver eneste sagde: \"Ja, lad os gøre det!\" I juli 2025 mødtes vi — 6 beslutsomme mennesker. Vi besluttede at grundlægge **ICD360S e.V.** i Neu-Ulm. 📍';

  @override
  String get wizardIntroBubble4 =>
      'Den **1. august 2025** kom foreningen officielt til live — i foreningsregistret. Min smukkeste gave. 🎂';

  @override
  String get wizardIntroBubble5 =>
      'Hvad gør vi? Vi hjælper flygtninge, mennesker med handicap, økonomisk ugunstigt stillede, **børn og unge** — med administrative forhold, tysk, bolig, indkøb, sociale ydelser. Vores Vorstand består hovedsageligt af mennesker med handicap — så beslutninger kommer fra ægte livserfaring. 🤝';

  @override
  String get wizardIntroBubble6 =>
      'Nu er det din tur. Lad os tilmelde dig — tager cirka 5 minutter. Vi går trin for trin, jeg lader dig ikke i stikken. ✨';

  @override
  String get wizardIntroStart => 'Lad os starte';

  @override
  String get wizardBack => 'Tilbage';

  @override
  String get wizardNext => 'Næste';

  @override
  String wizardStepLabel(int step, int total, String title) {
    return 'Trin $step af $total · $title';
  }

  @override
  String get wizardErrRequired => 'Dette felt er påkrævet';

  @override
  String wizardErrTooShort(int count) {
    return 'For kort (mindst $count tegn)';
  }

  @override
  String get wizardErrOnlyLetters =>
      'Kun bogstaver, mellemrum, bindestreger og apostroffer';

  @override
  String get wizardErrSaveFailed =>
      'Kunne ikke gemme. Tjek forbindelsen og prøv igen.';

  @override
  String get wizardStufe1aTitle => 'Identitet';

  @override
  String get wizardStufe1aPrompt =>
      'Lad os lære dig officielt at kende. Skriv dit navn præcis som det står på Personalausweis, Reisepass eller Aufenthaltstitel — så det matcher dine dokumenter.';

  @override
  String get wizardStufe1aVornameLabel => 'Vornamen (fornavne)';

  @override
  String get wizardStufe1aVornameHelper =>
      'Alle dine fornavne, præcis som på dokumentet. Med mellemrum eller bindestreg (fx Hans-Peter, Maria Anna).';

  @override
  String get wizardStufe1aNachnameLabel => 'Familienname (efternavn)';

  @override
  String get wizardStufe1aNachnameHelper => 'Dit nuværende efternavn.';

  @override
  String get wizardStufe1aGeburtsnameLabel =>
      'Geburtsname (fødenavn) — valgfri';

  @override
  String get wizardStufe1aGeburtsnameHelper =>
      'Kun hvis det adskiller sig fra Familienname — fx før ægteskab.';

  @override
  String get wizardStufe1bTitle => 'Fødselsdag';

  @override
  String get wizardStufe1bPrompt =>
      'Vi vil gerne fejre din fødselsdag sammen med dig! 🎂 Det hjælper os også at vide, at du er mindst 16 — sådan står der i vores Satzung.';

  @override
  String get wizardStufe1bGeburtsdatumLabel => 'Fødselsdato';

  @override
  String get wizardStufe1bGeburtsdatumHelper => 'Tryk for at vælge en dato';

  @override
  String get wizardStufe1bGeburtsortLabel => 'Fødested';

  @override
  String get wizardStufe1bGeburtsortHelper => 'By / sted hvor du blev født.';

  @override
  String get wizardAgeGatePrompt => 'Det er jeg ked af… 😔';

  @override
  String wizardAgeGateBody1(int age, int years) {
    return 'Vores Satzung siger, at du skal være mindst 16 for at blive medlem. Du er $age — jeg håber vi ses igen om $years år! 🌱';
  }

  @override
  String get wizardAgeGateBody2 =>
      'Hvis du vil hjælpe lejlighedsvis som frivillig (enhver alder, med forældres samtykke), ring til os — vi støtter gerne unge, der vil forandre verden.';

  @override
  String get wizardAgeGateBackHome => 'Tilbage til velkomstskærm';

  @override
  String get wizardErrInvalidPhone => 'Ugyldigt telefonnummer';

  @override
  String get wizardStufe1b1Title => 'Forældresamtykke';

  @override
  String get wizardStufe1b1Prompt =>
      'Du er mindreårig (16-17) — i henhold til §106 BGB skal vi have samtykke fra en forælder eller værge. Fortæl mig navn og telefonnummer. En Vorsitzer ringer og aftaler et møde (personligt eller videoopkald). Ingen e-mail — vi vil være sikre på, at vi taler med den rigtige person.';

  @override
  String get wizardStufe1b1VornameLabel => 'Forælders fornavn';

  @override
  String get wizardStufe1b1VornameHelper =>
      'Som det står på forælderens Personalausweis.';

  @override
  String get wizardStufe1b1NachnameLabel => 'Forælders efternavn';

  @override
  String get wizardStufe1b1NachnameHelper =>
      'Som det står på forælderens Personalausweis.';

  @override
  String get wizardStufe1b1TelefonLabel => 'Forælders mobilnummer';

  @override
  String get wizardStufe1b1TelefonHelper =>
      'En Vorsitzer ringer til dette nummer.';

  @override
  String get wizardStufe1b1RelationLabel => 'Forhold til barnet:';

  @override
  String get wizardStufe1b1RelationMutter => 'Mor';

  @override
  String get wizardStufe1b1RelationVater => 'Far';

  @override
  String get wizardStufe1b1RelationSorgeberechtigter => 'Værge';

  @override
  String get wizardStufe1b1RelationAndere => 'Anden værge';

  @override
  String get wizardStufe1cTitle => 'Personlige detaljer';

  @override
  String get wizardStufe1cPrompt =>
      'Bare så jeg lærer dig lidt bedre at kende. Det her bliver mellem os og vises ikke offentligt nogen steder.';

  @override
  String get wizardStufe1cGeschlechtLabel => 'Køn';

  @override
  String get wizardStufe1cGeschlechtMaennlich => 'Mand';

  @override
  String get wizardStufe1cGeschlechtWeiblich => 'Kvinde';

  @override
  String get wizardStufe1cGeschlechtDivers => 'Diverse';

  @override
  String get wizardStufe1cGeschlechtKeineAngabe => 'Foretrækker ikke at sige';

  @override
  String get wizardStufe1cFamilienstandLabel => 'Civilstand';

  @override
  String get wizardStufe1cFamilienstandLedig => 'Ugift';

  @override
  String get wizardStufe1cFamilienstandVerheiratet => 'Gift';

  @override
  String get wizardStufe1cFamilienstandGeschieden => 'Skilt';

  @override
  String get wizardStufe1cFamilienstandVerwitwet => 'Enkemand/Enke';

  @override
  String get wizardStufe1dTitle => 'Din baggrund';

  @override
  String get wizardStufe1dPrompt =>
      'Det hjælper os med at tilbyde dig den rigtige støtte — for eksempel rådgivning om Aufenthalt eller at finde dit sprogfællesskab.';

  @override
  String get wizardStufe1dStaatLabel => 'Statsborgerskab';

  @override
  String get wizardStufe1dStaatHelper =>
      'F.eks. deutsch, rumänisch, ukrainisch. Flere adskilt med komma.';

  @override
  String get wizardStufe1dAufenthaltLabel =>
      'Opholdsstatus (Aufenthaltsstatus) — valgfri';

  @override
  String get wizardStufe1dAufenthaltHelper =>
      'Vælg titlen fra din Aufenthaltskarte / afgørelse. Vorstand sammenligner med dine dokumenter.';

  @override
  String get wizardStufe1dAufenthaltAwaitingCitizenship =>
      'Udfyld statsborgerskab ovenfor først — vi viser kun de relevante muligheder.';

  @override
  String get wizardStufe1dAufenthaltGerman =>
      'Ingen Aufenthaltstitel nødvendig — tysk statsborger.';

  @override
  String get wizardStufe1dAufenthaltEuEea =>
      'EU/EØS/CH-borger — fri bevægelighed (Freizügigkeit).';

  @override
  String get wizardStufe1dAufenthaltTempHint => 'midlertidig';

  @override
  String get wizardStufe1dAufenthaltPermHint => 'permanent ophold';

  @override
  String get wizardStufe1dAufenthaltAsylumProcessHint => 'asylprocedure';

  @override
  String get wizardStufe1dAufenthaltOther => 'Andet (angiv venligst i chatten)';

  @override
  String get wizardStufe1dAufenthaltRequired =>
      'Vælg venligst en Aufenthaltstitel.';

  @override
  String get wizardStufe1dMutterspracheLabel => 'Modersmål';

  @override
  String get wizardStufe1dMutterspracheHelper =>
      'Forhåndsudfyldt med app-sprog — ændre hvis andet.';

  @override
  String get wizardStufe1eTitle => 'Adresse';

  @override
  String get wizardStufe1ePrompt =>
      'Din postadresse — vi bruger den til officielle dokumenter (Satzung, medlemskontrakter, meddelelser).';

  @override
  String get wizardStufe1eStrasseLabel => 'Gade';

  @override
  String get wizardStufe1eStrasseHelper =>
      'Kun gadenavnet — husnummer i feltet ved siden af.';

  @override
  String get wizardStufe1eHausnummerLabel => 'Nr.';

  @override
  String get wizardStufe1ePlzLabel => 'PLZ (postnr.)';

  @override
  String get wizardStufe1eOrtLabel => 'By';

  @override
  String get wizardStufe1eLandLabel => 'Land';

  @override
  String get wizardStufe1eLandHelper => 'Forhåndsudfyldt: Deutschland.';

  @override
  String get wizardErrInvalidStreet => 'Ugyldigt gadenavn';

  @override
  String get wizardErrInvalidHausnummer =>
      'Ugyldigt nummer (f.eks. 12, 12a, 12/3)';

  @override
  String get wizardErrInvalidPlz => 'Ugyldigt postnummer (kun cifre)';

  @override
  String get wizardStufe1fTitle => 'Kontakt';

  @override
  String get wizardStufe1fPrompt =>
      'Hvordan kontakter vi dig? Telefonen er kun til nødstilfælde — alt andet sker via vores egen end-to-end krypterede kanal i appen. Din medlems-e-mail tildeles automatisk og vises nedenfor.';

  @override
  String get wizardStufe1fTelefonLabel => 'Mobilnummer';

  @override
  String get wizardStufe1fTelefonHelper =>
      'Lover at jeg kun ringer hvis det er vigtigt. 📱';

  @override
  String get wizardStufe2Title => 'Medlemstype';

  @override
  String get wizardStufe2Prompt =>
      'Hvilken slags medlem vil du være? Lad mig forklare hver mulighed.';

  @override
  String get wizardStufe2OrdentlichTitle => 'Ordinært medlem (ordentlich)';

  @override
  String get wizardStufe2OrdentlichBody =>
      'Fulde rettigheder. Du betaler månedligt kontingent, stemmer i Mitgliederversammlung, kan vælges til Vorstand. Standardvalg.';

  @override
  String get wizardStufe2FoerderTitle => 'Støttemedlem (Fördermitglied)';

  @override
  String get wizardStufe2FoerderBody =>
      'Du støtter foreningen økonomisk, men deltager ikke aktivt i beslutninger. Ingen stemmeret. Godt hvis du vil hjælpe på afstand.';

  @override
  String get wizardStufe2EhrenTitle => 'Æresmedlem (Ehrenmitglied)';

  @override
  String get wizardStufe2EhrenBody =>
      'Tildeles af Vorstand for særlige fortjenester. Du vælger det ikke selv — det tildeles som anerkendelse. Vælg kun hvis du allerede er blevet hædret.';

  @override
  String get wizardStufe3Title => 'Økonomisk situation';

  @override
  String get wizardStufe3Prompt =>
      'Nu om din økonomiske situation. Ikke for at dømme — bare så vi kan fritage dig fra kontingent, hvis du modtager sociale ydelser.';

  @override
  String get wizardStufe3OptionBuergergeld => 'Jeg modtager Bürgergeld';

  @override
  String get wizardStufe3OptionSozialamt =>
      'Jeg modtager ydelser fra Sozialamt';

  @override
  String get wizardStufe3OptionNein => 'Jeg modtager ingen af disse';

  @override
  String get wizardStufe3FeeExemptTitle => 'Kontingent: 0 € / måned 🎉';

  @override
  String get wizardStufe3FeeExemptBody =>
      'Med Bürgergeld, Sozialamt, ALG I eller Krankengeld er du helt fritaget for kontingent efter Satzung §6. Vi har kun brug for et bevis (Leistungsbescheid eller bekræftelse fra myndigheden / sygekassen).';

  @override
  String get wizardStufe3UploadTitle => 'Upload Leistungsbescheid';

  @override
  String get wizardStufe3UploadHint => 'PDF / JPG / PNG, maks. 10 MB.';

  @override
  String get wizardStufe3UploadRequired =>
      'Upload venligst Leistungsbescheid før du fortsætter.';

  @override
  String get wizardStufe3FileTooLarge => 'Filen er for stor. Maks. 10 MB.';

  @override
  String get wizardStufe3UploadFailed =>
      'Filen kunne ikke uploades. Prøv igen.';

  @override
  String get wizardStufe3RegularFeeTitle => 'Kontingent: 25 € / måned';

  @override
  String get wizardStufe3RegularFeeBody =>
      'Standardkontingent for ordinære medlemmer ifølge Satzung.';

  @override
  String get wizardStufe4Title => 'Betaling';

  @override
  String get wizardStufe4Prompt =>
      'Hvordan vil du betale kontingent? Og hvilken dag i måneden skal det trækkes?';

  @override
  String get wizardStufe4MethodUeberweisungTitle =>
      'Bankoverførsel (Überweisung)';

  @override
  String get wizardStufe4MethodUeberweisungBody =>
      'Du starter selv betalingen hver måned fra din konto.';

  @override
  String get wizardStufe4MethodSepaTitle =>
      'SEPA-Lastschrift (direkte debitering)';

  @override
  String get wizardStufe4MethodSepaBody =>
      'Vi trækker beløbet automatisk fra din konto. Mest praktisk, men vi har brug for IBAN og et underskrevet mandat.';

  @override
  String get wizardStufe4MethodDauerauftragTitle =>
      'Dauerauftrag (fast overførsel)';

  @override
  String get wizardStufe4MethodDauerauftragBody =>
      'Du opretter en fast overførsel i din bank. Banken overfører beløbet automatisk hver måned.';

  @override
  String get wizardStufe4DayLabel => 'Betalingsdag';

  @override
  String get wizardStufe4DayHint => 'Vælg en dag mellem 1 og 31';

  @override
  String wizardStufe4DayItem(int day) {
    return 'Dag $day';
  }

  @override
  String wizardStufe4DayReminder(int day) {
    return 'Kontingentet trækkes den $day. i hver måned.';
  }

  @override
  String get wizardStufe5Title => 'Startdato';

  @override
  String get wizardStufe5Prompt =>
      'Hvornår vil du officielt være ICD360S-medlem? Fra godkendelsen eller bagudrettet.';

  @override
  String get wizardStufe5OptionAbVerifizierungTitle =>
      'Fra Vorstand-godkendelsen';

  @override
  String get wizardStufe5OptionAbVerifizierungBody =>
      'Det enkleste valg. Intet bagudrettet kontingent.';

  @override
  String get wizardStufe5OptionGruendungsdatumTitle =>
      'Bagudrettet fra 01.08.2025 (stiftelse)';

  @override
  String get wizardStufe5OptionGruendungsdatumBody =>
      'Du regnes som medlem fra foreningens første dag.';

  @override
  String get wizardStufe5OptionAnderesDatumTitle => 'Anden dato';

  @override
  String get wizardStufe5OptionAnderesDatumBody =>
      'Du vælger en dato mellem 01.08.2025 og i dag.';

  @override
  String get wizardStufe5PickDate => 'Tryk for at vælge dato';

  @override
  String get wizardStufe5PickDateFirst => 'Vælg venligst en dato først.';

  @override
  String get wizardStufe5DatePickerHelp => 'Medlemskabets start';

  @override
  String wizardStufe5DateRange(String start) {
    return 'Mellem $start og i dag';
  }

  @override
  String get wizardStufe5RetroactiveTitle => 'Bagudrettet kontingent';

  @override
  String wizardStufe5RetroactiveBody(
      String start, String end, int months, String amount) {
    return 'Fra $start til $end er det $months måneder. Ved 25 €/måned giver det $amount € at betale bagudrettet, oven i det løbende månedlige kontingent.';
  }

  @override
  String get wizardStufe5FeeExemptTitle => 'Bagudrettet kontingent: 0 € 🎉';

  @override
  String get wizardStufe5FeeExemptBody =>
      'Med Bürgergeld eller Sozialamt er du helt fritaget — også bagudrettet skylder du intet.';

  @override
  String wizardDocumentPrompt(String doc) {
    return 'Inden vi runder af, læs venligst $doc grundigt. Det er vigtigt at vide, hvad du underskriver.';
  }

  @override
  String get wizardDocumentScrollHint => 'Scroll til bunden for at fortsætte.';

  @override
  String get wizardDocumentScrolledOk => 'Du har læst til slutningen ✓';

  @override
  String wizardDocumentOpenButton(String doc) {
    return 'Åbn $doc i browseren';
  }

  @override
  String get wizardDocumentExternalHint =>
      'På denne platform åbner vi dokumentet i din standardbrowser.';

  @override
  String get wizardDocumentOpenedOk => 'Dokumentet er åbnet. Læs det grundigt.';

  @override
  String wizardDocumentConfirm(String doc) {
    return 'Jeg bekræfter, at jeg har læst og accepterer $doc.';
  }

  @override
  String get wizardFinalAdultTitle => 'Færdig! Du er meldt ind 🎉';

  @override
  String get wizardFinalMinorTitle => 'Din anmodning er sendt 📨';

  @override
  String get wizardFinalMinorBody =>
      'Vi kontakter din forælder og aftaler et møde (personligt eller videoopkald). Vær venligst tålmodig — processen kan tage op til 7 dage. Du får en notifikation i appen, så snart din forælder har godkendt.';

  @override
  String get wizardFinalMitgliedernummerLabel => 'Dit medlemsnummer';

  @override
  String get wizardStufe4MethodComingSoon => 'Snart tilgængelig';

  @override
  String get wizardStufe4StreichungWarning =>
      'Hvis du er mere end 6 måneder bagud med kontingentet, sletter vi dig automatisk (Satzung §6 Abs. 3).';

  @override
  String get wizardStufe5KuendigungInfo =>
      'For at melde dig ud: send os din opsigelse skriftligt 3 måneder før 31. december (senest 30. september for at træde i kraft ved årets udgang). Ingen minimumsperiode (Satzung §6 Abs. 3).';

  @override
  String get wizardStufe1fEmailLabel => 'Din medlems-e-mail';

  @override
  String get wizardStufe1fEmailHelper =>
      'Tildeles automatisk ud fra dit medlemsnummer. Aktiveres i samme øjeblik, som bestyrelsen (Vorstand) godkender din ansøgning. Vi har vores egen e-mail-app — send og modtag krypterede e-mails, enkelt og gratis.';

  @override
  String get wizardErrInvalidEmail => 'Ugyldig e-mailadresse';

  @override
  String get wizardStufe3OptionAlg1 =>
      'Jeg modtager Arbeitslosengeld I (ALG I, arbejdsløshedsdagpenge)';

  @override
  String get wizardStufe3OptionKrankengeld =>
      'Jeg modtager Krankengeld (sygedagpenge)';

  @override
  String get wizardStufe3UploadAddMore => 'Tilføj et dokument til';

  @override
  String get wizardStufe3UploadLimitCount =>
      'Grænse nået: højst 20 dokumenter.';

  @override
  String get wizardStufe3UploadLimitTotal =>
      'Samlet grænse 100 MB nået. Slet en eksisterende fil først.';

  @override
  String get wizardStufe3UploadDeleteTooltip => 'Slet';

  @override
  String wizardStufe3UploadCounter(int count, int max) {
    return '$count / $max dokumenter';
  }

  @override
  String get wizardDocumentExternalOpenFailed =>
      'Kunne ikke åbne browseren. Linket er kopieret til udklipsholderen — indsæt det i en browser for at fortsætte.';

  @override
  String get wizardFinalTimelineProcessing =>
      'Vorstand gennemgår · normalt 1 hverdag, maks. 7';

  @override
  String get wizardFinalTimelineActivated => 'Konto aktiveret';

  @override
  String get wizardFinalAdultThank =>
      'Tak fordi du udfyldte registreringsformularen! 🎉';

  @override
  String get wizardFinalAdultUsual =>
      'Din ansøgning er nu hos os. Vi godkender den normalt inden for én hverdag.';

  @override
  String get wizardFinalAdultExceptional =>
      'Nogle gange kan det tage op til 7 hverdage. Og hvis noget ikke stemmer, sender vi dig tilbage til formularen, så du kan rette det 🙂';

  @override
  String get wizardFinalStatusTitle => 'ANSØGNINGSSTATUS';

  @override
  String wizardFinalStatusStepsValidated(int reviewed, int total) {
    return '$reviewed/$total trin valideret af Vorstand';
  }

  @override
  String get wizardFinalStufeSheetTitle => 'Ansøgningsdetaljer';

  @override
  String get wizardFinalStufeSheetHint =>
      'De 8 trin du har udfyldt. Vorstand gennemgår dem ét ad gangen — du ser i realtid, hvad der er godkendt.';

  @override
  String get wizardFinalStufeStatusPending => 'Afventer gennemgang';

  @override
  String get wizardFinalStufeStatusApproved => 'Godkendt';

  @override
  String get wizardFinalStufeStatusRejected => 'Afvist';

  @override
  String wizardFinalStatusRejectionCount(int count) {
    return '$count trin kræver rettelse';
  }

  @override
  String get wizardFinalStufeRejectionReason => 'Begrundelse fra Vorstand:';

  @override
  String get wizardFinalStufeCorrectNow => 'Ret nu';

  @override
  String wizardFinalApprovalsHeader(int current, int total) {
    return 'Vorstand-godkendelser ($current/$total)';
  }

  @override
  String get wizardFinalApprovalAwaiting => 'Afventer 2. Vorstand';

  @override
  String get wizardFinalApprovalRejected => 'AFVIST';

  @override
  String get wizardFinalStufeNoDataYet => 'Data er endnu ikke tilgængelige.';

  @override
  String get wizardFinalStufeReadAt => 'Læst den:';

  @override
  String get wizardFinalStufeBeitragsfrei => 'Kontingentfri (ingen betaling)';

  @override
  String get wizardFinalStufeNotExempt => 'Ingen sociale ydelser';

  @override
  String get wizardFinalStufeBeginAtVerification => 'Starter ved verificering';

  @override
  String get wizardFinalStufeBeginAtFoundation =>
      'Stiftelsesdato (med tilbagevirkende kraft)';

  @override
  String get wizardFinalStufeBeginAtCustom => 'Anden dato';

  @override
  String get wizardFinalStufeStatusSkipped => 'Sprunget over';

  @override
  String get wizardFinalStufeFilledAt => 'Udfyldt:';

  @override
  String get wizardFinalStufeReviewedAt => 'Gennemgået:';

  @override
  String get wizardFinalWithdrawLink => 'Træk ansøgning tilbage';

  @override
  String get wizardFinalWithdrawDialogTitle => 'Trække ansøgningen tilbage?';

  @override
  String get wizardFinalWithdrawDialogBody =>
      'Din ansøgning markeres som tilbagetrukket af dig. Dataene bliver i databasen til revision (GDPR), men kontoen aktiveres ikke. Du kan starte registreringen forfra når som helst med et nyt medlemsnummer.';

  @override
  String get wizardFinalWithdrawKeep => 'Nej, jeg venter';

  @override
  String get wizardFinalWithdrawConfirm => 'Ja, træk tilbage';

  @override
  String get wizardErrTooManyWithdrawals =>
      'Din ansøgning kan ikke behandles automatisk. Ring til os eller kom personligt forbi Vorstand for at fortsætte registreringen.';

  @override
  String get wizardDuplicateLoginTitle =>
      'Det ser ud til, at du allerede er medlem';

  @override
  String get wizardDuplicateLoginBody =>
      'Med dit navn og fødselsdato finder vi allerede en aktiv konto. Brug venligst \"Jeg er allerede medlem\" på startskærmen for at logge ind. Hvis du ikke har adgang, så ring til os.';

  @override
  String get wizardDuplicatePendingTitle => 'Din ansøgning er allerede hos os';

  @override
  String get wizardDuplicatePendingBody =>
      'Vi har allerede en ansøgning til behandling under dit navn og fødselsdato. Vorstand er i gang — vi giver besked i appen, så snart din konto er aktiv. Ring, hvis du vil tale om det.';

  @override
  String get wizardDuplicateRecentlyWithdrawnTitle =>
      'Vi kan ikke behandle denne ansøgning nu';

  @override
  String get wizardDuplicateRecentlyWithdrawnBody =>
      'Dit navn og fødselsdato matcher en nyligt tilbagetrukket ansøgning. Ring til os for at tale med Vorstand, før du går videre.';

  @override
  String get wizardDuplicatePreviouslyWithdrawnTitle => 'Du har søgt før';

  @override
  String get wizardDuplicatePreviouslyWithdrawnBody =>
      'Dit navn og fødselsdato matcher en ældre ansøgning, som du trak tilbage. Velkommen tilbage — ring til os, før du fortsætter, så Vorstand kan beslutte, hvordan vi går videre.';

  @override
  String get wizardDuplicateCallUsTitle => 'Ring venligst til os';

  @override
  String get wizardDuplicateCallUsBody =>
      'Dit navn og fødselsdato findes allerede hos os, men vi kan ikke dele detaljerne via appen. Ring til os — Vorstand forklarer situationen direkte.';

  @override
  String get wizardChatHelp => 'Lad os snakke';

  @override
  String get wizardChatHelpSubtitle => 'Livechat med Vorstand · hurtigt svar';

  @override
  String get benachrichtigungTitel => 'SMS-påmindelser';

  @override
  String get benachrichtigungIntro =>
      'For at du ikke går glip af en aftale, kan foreningen sende dig en SMS. Du bestemmer, om og hvad — og du kan altid ændre det.';

  @override
  String get benachrichtigungTermineFrage =>
      'Vil du modtage påmindelser om dine aftaler via SMS?';

  @override
  String get benachrichtigungTermineDetail =>
      'Beskeden indeholder dato, tidspunkt, sted og emne for aftalen.';

  @override
  String get benachrichtigungMedikamenteFrage =>
      'Vil du også mindes om din medicin?';

  @override
  String get benachrichtigungMedikamenteDetail =>
      'Så står medicinens navn i beskeden. Det er en helbredsoplysning — derfor spørger vi særskilt.';

  @override
  String get benachrichtigungHinweis =>
      'Påmindelsen er en hjælp og ingen garanti: stol venligst ikke på den alene. Du kan altid ændre dette i din profil.';

  @override
  String get benachrichtigungJa => 'Ja';

  @override
  String get benachrichtigungNein => 'Nej';

  @override
  String get benachrichtigungSpaeter => 'Beslut senere';

  @override
  String get benachrichtigungSpeichern => 'Gem';

  @override
  String get benachrichtigungGespeichert => 'Tak, gemt.';

  @override
  String get benachrichtigungenLeer => 'Ingen notifikationer';

  @override
  String get benachrichtigungenAlleGelesen => 'Markér alle som læst';

  @override
  String get benachrichtigungWetterFrage =>
      'Vil du advares om farligt vejr, hvor du bor?';

  @override
  String get benachrichtigungWetterDetail =>
      'Kun officielle advarsler fra den tyske vejrtjeneste fra niveauet „kraftig“ og opefter — ikke ved hver regnbyge.';

  @override
  String get signaturTitel => 'Underskrifter';

  @override
  String get signaturNichtsOffen =>
      'Der er i øjeblikket intet til underskrift.';

  @override
  String get signaturStatusOffen => 'Venter på din underskrift';

  @override
  String get signaturStatusSigniert => 'Underskrevet af dig';

  @override
  String get signaturStatusAbgelehnt => 'Afvist af dig';

  @override
  String get signaturStatusWiderrufen => 'Trukket tilbage af foreningen';

  @override
  String get signaturStatusAbgelaufen => 'Fristen er udløbet';

  @override
  String signaturBitteGanzLesen(int gelesen, int gesamt) {
    return 'Læs venligst dokumentet helt til ende (side $gelesen af $gesamt).';
  }

  @override
  String get signaturWeiterZurUnterschrift => 'Videre til underskrift';

  @override
  String get signaturAblehnen => 'Afvis';

  @override
  String get signaturAblehnenHinweis =>
      'Foreningen får besked. Du kan angive en begrundelse.';

  @override
  String get signaturAblehnenGrund => 'Begrundelse (valgfri)';

  @override
  String get signaturMitFingerHinweis =>
      'Skriv under med fingeren i det hvide felt.';

  @override
  String get signaturNochmal => 'Skriv igen';

  @override
  String get signaturZurueckZumDokument => 'Tilbage til dokumentet';

  @override
  String get signaturCodeAnfordern => 'Send kode via SMS';

  @override
  String get signaturCodeUnterwegs => 'Koden er på vej.';

  @override
  String signaturCodeGesendetAn(String nummer) {
    return 'Vi har sendt dig en kode til $nummer.';
  }

  @override
  String get signaturCodeErneutSenden => 'Send koden igen';

  @override
  String get signaturJetztUnterschreiben => 'Skriv under nu';

  @override
  String get signaturCodeFalsch => 'Koden er forkert.';

  @override
  String get signaturCodeAbgelaufen =>
      'Koden er udløbet. Bed venligst om en ny.';

  @override
  String get signaturZuVieleVersuche =>
      'For mange forkerte forsøg. Bed venligst om en ny kode.';

  @override
  String get signaturKeineRufnummer =>
      'Der er ikke registreret noget mobilnummer på din konto. Uden et mobilnummer kan vi ikke sende dig en kode — kontakt venligst formanden.';

  @override
  String get signaturCodeFehlgeschlagen => 'Koden kunne ikke sendes.';

  @override
  String get signaturLeer => 'Skriv venligst under først.';

  @override
  String get signaturErfolg => 'Tak — vi har modtaget din underskrift.';

  @override
  String get signaturFehlgeschlagen => 'Det lykkedes ikke. Prøv venligst igen.';

  @override
  String get signaturSiegelInArbeit =>
      'Det signerede dokument er ved at blive oprettet. Prøv venligst igen om et minut.';

  @override
  String get signaturWartetZweiteUnterschrift =>
      'Venter på den anden underskrift';

  @override
  String get signaturWartenHinweis =>
      'Du har skrevet under. Det signerede dokument bliver oprettet, så snart den anden person også har skrevet under.';

  @override
  String get kontaktNochAktuell => 'Er disse oplysninger stadig korrekte?';

  @override
  String get kontaktWarumFragen =>
      'For at du ikke går glip af noget, spørger vi kort hver tredje måned. Du får en sekscifret kode.';

  @override
  String kontaktBestaetigtAm(Object datum) {
    return 'bekræftet den $datum';
  }

  @override
  String get kontaktFestnetzKeinSms =>
      'Dette er et fastnetnummer — der kan ikke leveres sms.';

  @override
  String get kontaktIstAndersGeworden => 'Det er ændret';
}
