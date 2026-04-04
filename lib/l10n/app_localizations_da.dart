// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Danish (`da`).
class AppLocalizationsDa extends AppLocalizations {
  AppLocalizationsDa([String locale = 'da']) : super(locale);

  @override
  String get appTitle => 'ICD360S e.V - Medlemsportal';

  @override
  String get memberPortal => 'Medlemsportal';

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
  String get password => 'Adgangskode';

  @override
  String get passwordHint => 'Indtast adgangskode';

  @override
  String get confirmPassword => 'Bekræft adgangskode';

  @override
  String get confirmPasswordHint => 'Bekræft adgangskode';

  @override
  String get newPassword => 'Ny adgangskode';

  @override
  String get newPasswordHint => 'Indtast ny adgangskode';

  @override
  String get saveCredentials => 'Gem loginoplysninger';

  @override
  String get autoLogin => 'Automatisk login';

  @override
  String get forgotPassword => 'Glemt adgangskode?';

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
  String get recoveryCode => 'Gendannelseskode (6 cifre)';

  @override
  String get recoveryCodeHelper =>
      'Husk denne kode til gendannelse af adgangskode';

  @override
  String get recoveryCodeHint => 'Indtast gendannelseskode';

  @override
  String get recoveryCodeInvalid => 'Koden skal have præcis 6 cifre';

  @override
  String get loginFailed => 'Login mislykkedes';

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
  String get tooManyDevices => 'For mange enheder';

  @override
  String get maxDevicesMessage =>
      'Du er allerede logget ind på 3 enheder.\nVælg en enhed at logge ud fra:';

  @override
  String get unknownDevice => 'Ukendt enhed';

  @override
  String get unknown => 'Ukendt';

  @override
  String get logoutError => 'Logud-fejl';

  @override
  String error(String error) {
    return 'Fejl: $error';
  }

  @override
  String get cancel => 'Annuller';

  @override
  String get resetPassword => 'Nulstil adgangskode';

  @override
  String get forgotPasswordTitle => 'Glemt adgangskode';

  @override
  String get forgotPasswordDescription =>
      'Indtast dit medlemsnummer og gendannelseskoden, du oprettede ved registrering.';

  @override
  String get passwordResetSuccess =>
      'Adgangskode nulstillet!\n\nDu kan nu logge ind med din nye adgangskode.';

  @override
  String get passwordResetFailed => 'Nulstilling af adgangskode mislykkedes';

  @override
  String get needHelp => 'Brug for hjælp?';

  @override
  String get helpQuestion => 'Problemer med login eller registrering?';

  @override
  String get helpDescription =>
      'Kontakt os via WhatsApp og beskriv, hvad der ikke virker. Vi svarer hurtigst muligt!';

  @override
  String get whatsapp => 'WhatsApp';

  @override
  String get emailSubject => 'Forespørgsel via ICD360S-appen';

  @override
  String get whatsappMessage => 'Hej, jeg har et problem med ICD360S-appen. ';

  @override
  String get imprint => 'Impressum';

  @override
  String get privacy => 'Privatlivspolitik';

  @override
  String get statutes => 'Vedtægter';

  @override
  String get revocation => 'Fortrydelsesret';

  @override
  String get cancellation => 'Opsigelse';

  @override
  String get allRightsReserved => 'Alle rettigheder forbeholdes.';

  @override
  String get enterCredentials => 'Indtast medlemsnummer og adgangskode';

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
  String get membership => 'Medlemskab';

  @override
  String get myAppointments => 'Mine aftaler';

  @override
  String get appointmentsLoadingReady => 'Indlæser aftaler - API klar!';

  @override
  String get priority => 'Prioritet';

  @override
  String get messageLabel => 'Besked';

  @override
  String get createdOn => 'Oprettet';

  @override
  String get handler => 'Håndterer';

  @override
  String get reportProblems => 'Rapporter problemer';

  @override
  String get reportProblem => 'Rapporter problem';

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
  String get newTicket => 'Ny sag';

  @override
  String get noOpenTickets => 'Ingen åbne sager';

  @override
  String get haveQuestionCreateTicket =>
      'Har du et spørgsmål eller problem?\nOpret en ny sag.';

  @override
  String get whatIsTheProblem => 'Hvad er problemet?';

  @override
  String get describeTheProblem => 'Beskriv problemet';

  @override
  String get howUrgentIsIt => 'Hvor hastende er det?';

  @override
  String get low => 'Lav';

  @override
  String get medium => 'Mellem';

  @override
  String get high => 'Høj';

  @override
  String get submit => 'Send';

  @override
  String get fillSubjectAndMessage => 'Udfyld emne og besked';

  @override
  String get ticketCreated => 'Sag oprettet';

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
  String get newEmailAddress => 'Ny e-mailadresse';

  @override
  String get currentPassword => 'Nuværende adgangskode';

  @override
  String get saveEmail => 'Gem e-mail';

  @override
  String get savePassword => 'Gem adgangskode';

  @override
  String get deviceLoggedOut => 'Enhed logget ud';

  @override
  String get passwordChangedSuccessfully => 'Adgangskode ændret';

  @override
  String get emailChangedSuccessfully => 'E-mail ændret';

  @override
  String get errorChangingPassword => 'Fejl ved ændring af adgangskode';

  @override
  String get errorChangingEmail => 'Fejl ved ændring af e-mail';

  @override
  String get validEmailRequired => 'Angiv en gyldig e-mailadresse';

  @override
  String get passwordTooShort => 'Adgangskoden skal være mindst 6 tegn';

  @override
  String get maxDevicesReached => 'Du er logget ind på maksimalt 3 enheder.';

  @override
  String loggedInOnDevices(int count) {
    return 'Du er logget ind på $count ud af 3 enheder.';
  }

  @override
  String get noActiveSessions => 'Ingen aktive sessioner';

  @override
  String get logoutFromDevice => 'Log ud fra denne enhed';

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
  String get errorAcceptingCall => 'Fejl ved accept af opkald';

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
  String typingIndicator(String name) {
    return '$name skriver...';
  }

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
  String get diagnosticDataTitle => 'Diagnosticeringsdata';

  @override
  String get diagnosticDescription =>
      'Vil du sende anonyme diagnosticeringsdata for at forbedre appen?';

  @override
  String get noThanks => 'Nej tak';

  @override
  String get yesEnable => 'Ja, aktiver';

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
  String get newPasswordMinChars => 'Ny adgangskode (min. 6 tegn)';

  @override
  String get reasonLabel2 => 'Årsag';

  @override
  String get downloadFailed2 => 'Download mislykkedes';

  @override
  String get downloadTooltip => 'Download';

  @override
  String get connectionErrorGeneric => 'Forbindelsesfejl';

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
  String get bankTransfer => 'Bankoverførsel';

  @override
  String get standingOrder => 'Fast overførsel';

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
  String get memberNumberTooLong => 'Medlemsnummer for langt (maks. 20 tegn)';

  @override
  String get onlyUppercaseAndNumbers => 'Kun store bogstaver og tal er tilladt';

  @override
  String get passwordTooLong => 'Adgangskode for lang (maks. 100 tegn)';

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
  String get diagnosticErrors => 'Fejlrapporter til forbedring';

  @override
  String get diagnosticAnonymousStats => 'Anonyme brugsstatistikker';

  @override
  String get diagnosticPerformance => 'App-ydeevnedata';

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
  String get ipClean => 'IP ren - ikke opført';

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
  String get helpImproveApp => 'Vil du hjælpe os med at forbedre appen?';

  @override
  String get noPersonalDataCollected =>
      'Ingen personlige data indsamles. Denne indstilling kan ændres når som helst.';

  @override
  String logEntries(int count) {
    return '$count poster';
  }

  @override
  String get noLogs => 'Ingen logfiler';

  @override
  String get newLoginDetected => 'Nyt login registreret';

  @override
  String get waitingForMember => 'Venter på medlem';

  @override
  String get waitingForStaff => 'Venter på medarbejder';

  @override
  String get waitingForAuthority => 'Venter på myndighed';
}
