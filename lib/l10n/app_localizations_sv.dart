// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Swedish (`sv`).
class AppLocalizationsSv extends AppLocalizations {
  AppLocalizationsSv([String locale = 'sv']) : super(locale);

  @override
  String get welcomeLoading => 'Laddar...';

  @override
  String get welcomeAutoLogin => 'Automatisk inloggning...';

  @override
  String get login => 'Logga in';

  @override
  String get register => 'Registrera';

  @override
  String get becomeMember => 'Bli medlem';

  @override
  String get memberNumber => 'Medlemsnummer';

  @override
  String get memberNumberHint => 'Ange medlemsnummer';

  @override
  String get confirmPassword => 'Bekräfta lösenord';

  @override
  String get confirmPasswordHint => 'Bekräfta lösenord';

  @override
  String get newPassword => 'Nytt lösenord';

  @override
  String get newPasswordHint => 'Ange nytt lösenord';

  @override
  String get firstName => 'Förnamn och efternamn';

  @override
  String get firstNameHint => 'Ange för- och efternamn';

  @override
  String get nameMinLength => 'Namnet måste ha minst 2 tecken';

  @override
  String get nameOnlyLetters => 'Endast bokstäver och bindestreck tillåtna';

  @override
  String get email => 'E-postadress';

  @override
  String get emailHint => 'Ange e-post';

  @override
  String get emailInvalid => 'Ange en giltig e-postadress';

  @override
  String get passwordMinLength => 'Lösenordet måste ha minst 6 tecken';

  @override
  String get passwordsNotMatch => 'Lösenorden matchar inte';

  @override
  String get registrationFailed => 'Registreringen misslyckades';

  @override
  String connectionError(String error) {
    return 'Anslutningsfel: $error';
  }

  @override
  String registrationSuccess(String memberNumber) {
    return 'Registrering lyckades!\n\nDitt medlemsnummer: $memberNumber\n\nKom ihåg detta nummer för inloggning.';
  }

  @override
  String get unknown => 'Okänd';

  @override
  String error(String error) {
    return 'Fel: $error';
  }

  @override
  String get cancel => 'Avbryt';

  @override
  String get resetPassword => 'Återställ lösenord';

  @override
  String get imprint => 'Impressum';

  @override
  String get privacy => 'Integritetspolicy';

  @override
  String get statutes => 'Stadgar';

  @override
  String get revocation => 'Ångerrätt';

  @override
  String get appointments => 'Möten';

  @override
  String get tickets => 'Ärenden';

  @override
  String get liveChat => 'Livechatt';

  @override
  String get notifications => 'Aviseringar';

  @override
  String get myProfile => 'Min Profil';

  @override
  String get logout => 'Logga ut';

  @override
  String get goodMorning => 'God morgon';

  @override
  String get goodDay => 'God dag';

  @override
  String get goodEvening => 'God kväll';

  @override
  String get goodNight => 'God natt';

  @override
  String get welcomeToICD => 'Välkommen till ICD360S e.V!';

  @override
  String get accountCreatedSuccessfully =>
      'Ditt konto har skapats framgångsrikt.';

  @override
  String get today => 'Idag';

  @override
  String get membershipFeeDue => 'Medlemsavgift förfaller';

  @override
  String get pleaseTransferAnnualFee => 'Vänligen överför årsavgiften.';

  @override
  String get newBadge => 'Ny';

  @override
  String get close => 'Stäng';

  @override
  String get myAppointments => 'Mina möten';

  @override
  String get priority => 'Prioritet';

  @override
  String get messageLabel => 'Meddelande';

  @override
  String get reportProblems => 'Rapportera problem';

  @override
  String get weRespondIn24Hours => 'Vi svarar dig inom maximalt 24 timmar!';

  @override
  String get everythingOk => 'Allt OK!';

  @override
  String get haveProblemWeHelp => 'Har du problem?\nVi tar hand om det!';

  @override
  String get myMembership => 'Mitt medlemskap';

  @override
  String get managePersonalDataAndFee => 'Hantera personuppgifter och avgift';

  @override
  String get myAppointmentsTitle => 'Mina möten';

  @override
  String get appointmentsDescription =>
      'Här kan du se dina kommande möten.\nDu kan bekräfta ditt deltagande eller avböja.';

  @override
  String get loadAppointments => 'Ladda möten';

  @override
  String get myTickets => 'Mina ärenden';

  @override
  String get low => 'Låg';

  @override
  String get high => 'Hög';

  @override
  String get submit => 'Skicka';

  @override
  String get errorCreatingTicket => 'Fel vid skapande av ärende';

  @override
  String get verified => 'Verifierad';

  @override
  String get account => 'Konto';

  @override
  String get myDevices => 'Mina enheter';

  @override
  String get changeEmail => 'Ändra e-post';

  @override
  String get changePassword => 'Ändra lösenord';

  @override
  String get saveEmail => 'Spara e-post';

  @override
  String get savePassword => 'Spara lösenord';

  @override
  String get deviceLoggedOut => 'Enheten utloggad';

  @override
  String get emailChangedSuccessfully => 'E-post ändrad';

  @override
  String get errorChangingPassword => 'Fel vid ändring av lösenord';

  @override
  String get errorChangingEmail => 'Fel vid ändring av e-post';

  @override
  String get validEmailRequired => 'Vänligen ange en giltig e-postadress';

  @override
  String get confirmLogoutDevice => 'Logga ut enhet?';

  @override
  String get confirmLogoutMessage =>
      'Vill du logga ut från denna enhet?\n\nDu måste logga in igen för att använda denna enhet.';

  @override
  String get ipAddress => 'IP';

  @override
  String get platform => 'Plattform';

  @override
  String trialWarningUrgentTitle(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days dagar',
      one: '1 dag',
    );
    return 'Varning: Endast $_temp0 kvar till kontospärr!';
  }

  @override
  String get trialWarningTitle => 'Ditt konto är ännu inte verifierat';

  @override
  String get trialWarningDescription =>
      'Vänligen fyll i dina uppgifter i \"Min profil\". Efter 30 dagar kommer ditt konto att spärras automatiskt.';

  @override
  String trialDaysRemaining(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days dagar',
      one: '1 dag',
    );
    return '$_temp0';
  }

  @override
  String get overview => 'Översikt';

  @override
  String get member => 'Medlem';

  @override
  String get memberManagement => 'Medlemshantering';

  @override
  String get reportProblemTooltip => 'Rapportera problem';

  @override
  String get newAppointmentsTitle => 'Nya möten';

  @override
  String get youHaveNewAppointment => 'Du har ett nytt möte.';

  @override
  String youHaveNewAppointments(int count) {
    return 'Du har $count nya möten.';
  }

  @override
  String get appointmentReminderTomorrow => 'Påminnelse: Möte imorgon';

  @override
  String tomorrowAppointment(String title) {
    return 'Imorgon: $title';
  }

  @override
  String youHaveTomorrowAppointments(int count) {
    return 'Du har $count möten imorgon.';
  }

  @override
  String get appointmentsToday => 'Möten idag';

  @override
  String todayAppointment(String title) {
    return 'Idag: $title';
  }

  @override
  String youHaveTodayAppointments(int count) {
    return 'Du har $count möten idag.';
  }

  @override
  String get paymentReminder => 'Betalningspåminnelse';

  @override
  String paymentReminderMessage(int day, String method) {
    return 'Idag är den $day:e i månaden – vänligen slutför $method.';
  }

  @override
  String get paymentDayLabel => 'Betalningsdag (månatlig påminnelse)';

  @override
  String get updateAvailable => 'Uppdatering tillgänglig';

  @override
  String newVersionAvailable(String version) {
    return 'En ny version finns tillgänglig: $version';
  }

  @override
  String currentVersionLabel(String version) {
    return 'Aktuell version: $version';
  }

  @override
  String get changes => 'Ändringar:';

  @override
  String downloadProgress(String percent) {
    return 'Nedladdning: $percent%';
  }

  @override
  String get installationStarting => 'Installationen startar...';

  @override
  String get appWillRestart => 'Appen startas om automatiskt.';

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
  String get later => 'Senare';

  @override
  String get updateNow => 'Uppdatera nu';

  @override
  String get downloading => 'Laddar ner...';

  @override
  String get downloadFailed =>
      'Nedladdningen misslyckades. Försök igen senare.';

  @override
  String get searchingForUpdates => 'Söker efter uppdateringar...';

  @override
  String get appUpToDate => 'Appen är uppdaterad';

  @override
  String get updateCheckError => 'Fel vid sökning efter uppdateringar';

  @override
  String get changelog => 'Ändringslogg';

  @override
  String get terminConfirmed => 'Möte bekräftat';

  @override
  String get terminDeclined => 'Möte avvisat';

  @override
  String get terminRescheduleRequested => 'Ombokning begärd';

  @override
  String get statusConfirmed => 'Bekräftat';

  @override
  String get statusDeclined => 'Avvisat';

  @override
  String get statusRescheduling => 'Ombokning';

  @override
  String get statusPending => 'Väntande';

  @override
  String get categoryVorstandssitzung => 'Styrelsemöte';

  @override
  String get categoryMitgliederversammlung => 'Årsmöte';

  @override
  String get categorySchulung => 'Utbildning';

  @override
  String get categorySonstiges => 'Övrigt';

  @override
  String openCount(int count) {
    return '$count öppna';
  }

  @override
  String get refresh => 'Uppdatera';

  @override
  String get filterUpcoming => 'Kommande';

  @override
  String get filterPast => 'Tidigare';

  @override
  String get filterAll => 'Alla';

  @override
  String get noUpcomingAppointments => 'Inga kommande möten';

  @override
  String get noPastAppointments => 'Inga tidigare möten';

  @override
  String get noAppointmentsAvailable => 'Inga möten';

  @override
  String get appointmentsShownHere => 'Dina möten visas här';

  @override
  String get dateLabel => 'Datum';

  @override
  String get timeLabel => 'Tid';

  @override
  String get locationLabel => 'Plats';

  @override
  String get createdByLabel => 'Skapad av';

  @override
  String get descriptionLabel => 'Beskrivning';

  @override
  String get ticketLabel => 'Ärende';

  @override
  String get yourStatus => 'Din status: ';

  @override
  String reasonLabel(String reason) {
    return 'Anledning: $reason';
  }

  @override
  String durationMinutes(int minutes) {
    return '$minutes min';
  }

  @override
  String get confirm => 'Bekräfta';

  @override
  String get decline => 'Avvisa';

  @override
  String get reschedule => 'Omboka';

  @override
  String get requestReschedule => 'Begär ombokning';

  @override
  String appointmentLabel(String title) {
    return 'Möte: $title';
  }

  @override
  String get rescheduleReason => 'Anledning till ombokning *';

  @override
  String get rescheduleReasonHint => 'Ange en anledning...';

  @override
  String get pleaseProvideReason => 'Ange en anledning';

  @override
  String get request => 'Begär';

  @override
  String get ticketStatusOpen => 'Öppen';

  @override
  String get ticketStatusInProgress => 'Pågående';

  @override
  String get ticketStatusWaitingMember => 'Väntar på medlem';

  @override
  String get ticketStatusWaitingStaff => 'Väntar på personal';

  @override
  String get ticketStatusWaitingAuthority => 'Väntar på myndighet';

  @override
  String get ticketStatusDone => 'Klar';

  @override
  String get ticketPriorityHigh => 'Hög';

  @override
  String get ticketPriorityMedium => 'Medel';

  @override
  String get ticketPriorityLow => 'Låg';

  @override
  String get comments => 'Kommentarer';

  @override
  String get documents => 'Dokument';

  @override
  String get details => 'Detaljer';

  @override
  String get replySent => 'Svar skickat';

  @override
  String get sendError => 'Fel vid sändning';

  @override
  String get uploading => 'Laddar upp...';

  @override
  String fileUploaded(String filename) {
    return '$filename uppladdat';
  }

  @override
  String get uploadFailed => 'Uppladdning misslyckades';

  @override
  String get openError => 'Fel vid öppning';

  @override
  String get noRepliesYet => 'Inga svar ännu';

  @override
  String get waitingForSupport => 'Väntar på svar från support';

  @override
  String get writeReply => 'Skriv ett svar...';

  @override
  String get attachFile => 'Bifoga fil';

  @override
  String documentsCount(int count) {
    return 'Dokument ($count)';
  }

  @override
  String get upload => 'Ladda upp';

  @override
  String get noDocuments => 'Inga dokument';

  @override
  String get allowedFormats => 'Tillåtna format: PDF, JPEG, JPG, TXT, ZIP';

  @override
  String get yourMessage => 'Ditt meddelande:';

  @override
  String get translation => 'Översättning';

  @override
  String get original => 'Original';

  @override
  String get originalText => 'Originaltext';

  @override
  String get autoTranslated => 'Automatiskt översatt';

  @override
  String get originalTapTranslation => 'Original · Tryck för översättning';

  @override
  String get translatedTapOriginal => 'Översatt · Tryck för original';

  @override
  String get justNow => 'Just nu';

  @override
  String minutesAgo(int minutes) {
    return '$minutes min sedan';
  }

  @override
  String hoursAgo(int hours) {
    return '$hours tim sedan';
  }

  @override
  String daysAgo(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'dagar',
      one: 'dag',
    );
    return '$days $_temp0 sedan';
  }

  @override
  String get createdLabel => 'Skapad';

  @override
  String get updatedLabel => 'Uppdaterad';

  @override
  String get handlerLabel => 'Handläggare';

  @override
  String get doneLabel => 'Klar';

  @override
  String get newTicketTitle => 'Nytt ärende';

  @override
  String get categoryOptional => 'Kategori (valfri)';

  @override
  String get selectCategory => 'Välj';

  @override
  String get subjectLabel => 'Ämne';

  @override
  String get fillAllFields => 'Fyll i alla fält';

  @override
  String ticketCreatedId(int id) {
    return 'Ärende #$id skapat';
  }

  @override
  String get priorityLabel => 'Prioritet: ';

  @override
  String get supportOffline => 'Support offline';

  @override
  String get lastSeenSeconds => 'Aktiv för några sekunder sedan';

  @override
  String lastSeenMinutes(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: 'minuter',
      one: 'minut',
    );
    return 'Aktiv för $minutes $_temp0 sedan';
  }

  @override
  String lastSeenHours(int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: 'timmar',
      one: 'timme',
    );
    return 'Aktiv för $hours $_temp0 sedan';
  }

  @override
  String lastSeenDays(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'dagar',
      one: 'dag',
    );
    return 'Aktiv för $days $_temp0 sedan';
  }

  @override
  String get online => 'Online';

  @override
  String get callSupport => 'Ring';

  @override
  String get typeMessage => 'Skriv ett meddelande...';

  @override
  String get callBusy => 'Support är upptagen';

  @override
  String get callRejected => 'Samtal avvisat';

  @override
  String get callFailed => 'Samtalet kunde inte kopplas';

  @override
  String get callEnded => 'Samtal avslutat';

  @override
  String get callSupportBusy => 'Support är redan i ett annat samtal';

  @override
  String get errorStartingChat => 'Fel vid start av chatt';

  @override
  String get errorStartingCall => 'Fel vid start av samtal';

  @override
  String get errorConnecting => 'Anslutningsfel';

  @override
  String get errorDownloading => 'Nedladdningsfel';

  @override
  String get errorUploading => 'Uppladdningsfel';

  @override
  String get errorSending => 'Sändningsfel';

  @override
  String get errorPickingPhotos => 'Fel vid val av foton';

  @override
  String get errorPickingFiles => 'Fel vid val av filer';

  @override
  String get errorTakingPhoto => 'Fel vid fotografering';

  @override
  String get fileNotLoaded => 'Filen kunde inte laddas';

  @override
  String get attachmentIdMissing => 'Bilaga-ID saknas';

  @override
  String get camera => 'Kamera';

  @override
  String get gallery => 'Galleri';

  @override
  String get file => 'Fil';

  @override
  String get notifNewMessageFrom => 'Nytt meddelande från';

  @override
  String get notifUrgentPrefix => 'BRÅDSKANDE';

  @override
  String get notifUrgentMessage => 'BRÅDSKANDE MEDDELANDE';

  @override
  String get notifIncomingCall => 'Inkommande samtal';

  @override
  String get notifCallingYou => 'ringer...';

  @override
  String get notifUpdateAvailable => 'Uppdatering tillgänglig';

  @override
  String get notifVersionAvailable => 'är nu tillgänglig';

  @override
  String get notifConnected => 'Ansluten';

  @override
  String get notifDisconnected => 'Frånkopplad';

  @override
  String get notifConnectedBody => 'Du är nu ansluten till servern.';

  @override
  String get notifDisconnectedBody => 'Anslutningen till servern bröts.';

  @override
  String get notifError => 'Fel';

  @override
  String get retry => 'Försök igen';

  @override
  String get save => 'Spara';

  @override
  String get accept => 'Acceptera';

  @override
  String get selectFile => 'Välj fil';

  @override
  String get dataLoadingText => 'Laddar data...';

  @override
  String get dataSavedSuccess => 'Data sparad';

  @override
  String get errorSaving => 'Fel vid sparande';

  @override
  String get errorLoading => 'Fel vid laddning';

  @override
  String savedFilename(String filename) {
    return 'Sparad: $filename';
  }

  @override
  String get logsCopied => 'Loggar kopierade!';

  @override
  String get passwordMinEightChars => 'Lösenordet måste vara minst 8 tecken';

  @override
  String get passwordChangeSuccess => 'Lösenord ändrat';

  @override
  String get emailChangeError => 'Fel vid ändring av e-post';

  @override
  String get acceptDocumentCheckbox =>
      'Jag har läst och accepterar dokumentet.';

  @override
  String loadingErrorGeneric(String details) {
    return 'Laddningsfel: $details';
  }

  @override
  String get incomingCallTitle => 'Inkommande samtal';

  @override
  String ringingFor(int seconds) {
    return 'Ringer i ${seconds}s';
  }

  @override
  String get rejectCall => 'Avvisa';

  @override
  String get acceptCall => 'Svara';

  @override
  String get unmute => 'Slå på ljud';

  @override
  String get mute => 'Stäng av ljud';

  @override
  String get hangUp => 'Lägg på';

  @override
  String get calling => 'Ringer...';

  @override
  String autoRejectIn(int seconds) {
    return 'Automatiskt avvisande om $seconds sekunder';
  }

  @override
  String get speakerOn => 'Högtalare';

  @override
  String get speakerOff => 'Hörsnäcka';

  @override
  String get micMuted => 'Avstängt';

  @override
  String get micOn => 'Mikrofon';

  @override
  String get connectionExcellent => 'Utmärkt';

  @override
  String get connectionGood => 'Bra';

  @override
  String get connectionWeak => 'Svag';

  @override
  String get connectionLost => 'Frånkopplad';

  @override
  String get personalData => 'Personuppgifter';

  @override
  String get personalDataSubtitle => 'Förnamn, efternamn, adress';

  @override
  String get membershipFee => 'Medlemsavgift';

  @override
  String annualFeeYear(String year) {
    return 'Årsavgift $year';
  }

  @override
  String get amount => 'Belopp:';

  @override
  String get dueBy => 'Förfaller:';

  @override
  String get paid => 'Betald';

  @override
  String get versionHistory => 'Versionshistorik';

  @override
  String lastUpdated(String date) {
    return 'Senast uppdaterad: $date';
  }

  @override
  String get noVersionHistory => 'Ingen versionshistorik tillgänglig';

  @override
  String get failedLoadChangelog => 'Kunde inte ladda ändringslogg';

  @override
  String get callMember => 'Ring medlem';

  @override
  String get closeConversation => 'Stäng konversation';

  @override
  String get chatOffline => 'Offline';

  @override
  String get attachFiles => 'Bifoga filer (max. 10, 50MB)';

  @override
  String get conversationClosed => 'Denna konversation har stängts';

  @override
  String get noMessages => 'Inga meddelanden';

  @override
  String get goBack => 'Tillbaka';

  @override
  String get goForward => 'Framåt';

  @override
  String get homePage => 'Hem';

  @override
  String get firstNameLabel => 'Förnamn';

  @override
  String get lastNameLabel => 'Efternamn';

  @override
  String get streetLabel => 'Gata';

  @override
  String get houseNumberLabel => 'Nr.';

  @override
  String get postalCodeLabel => 'Postnummer';

  @override
  String get cityLabel => 'Stad';

  @override
  String get phoneMobileLabel => 'Telefon (Mobil)';

  @override
  String get phoneLandlineLabel => 'Telefon (Fast)';

  @override
  String get newEmailLabel => 'Ny e-postadress';

  @override
  String get currentPasswordLabel => 'Nuvarande lösenord';

  @override
  String get newPasswordLabel => 'Nytt lösenord';

  @override
  String get confirmPasswordLabel => 'Bekräfta lösenord';

  @override
  String get emailChangedSuccess => 'E-post ändrad';

  @override
  String get reasonLabel2 => 'Anledning';

  @override
  String get downloadFailed2 => 'Nedladdning misslyckades';

  @override
  String get downloadTooltip => 'Ladda ner';

  @override
  String get copyLogs => 'Kopiera loggar';

  @override
  String get deleteLogs => 'Radera loggar';

  @override
  String get autoScrollOn => 'Automatisk rullning PÅ';

  @override
  String get autoScrollOff => 'Automatisk rullning AV';

  @override
  String get unknownValue => 'Okänt';

  @override
  String get payment => 'Betalning';

  @override
  String get warningType_ermahnung => 'Varning';

  @override
  String get warningType_abmahnung => 'Tillrättavisning';

  @override
  String get warningType_letzte => 'Sista varning';

  @override
  String warningsTotal(int count) {
    return 'Totalt: $count';
  }

  @override
  String warningsErmahnung(int count) {
    return 'Varningar: $count';
  }

  @override
  String warningsAbmahnung(int count) {
    return 'Tillrättavisningar: $count';
  }

  @override
  String warningsLetzte(int count) {
    return 'Sista: $count';
  }

  @override
  String get noWarnings => 'Inga varningar';

  @override
  String get noWarningsDescription => 'Du har inga varningar för tillfället.';

  @override
  String createdBy(String name) {
    return 'Skapad av: $name';
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
  String get stufe1_name => 'Personuppgifter';

  @override
  String get stufe2_name => 'Medlemstyp';

  @override
  String get stufe3_name => 'Ekonomisk situation';

  @override
  String get stufe4_name => 'Betalningsmetod';

  @override
  String get stufe5_name => 'Medlemskapets start';

  @override
  String get stufe6_name => 'Stadgar';

  @override
  String get stufe7_name => 'Integritetspolicy';

  @override
  String get stufe8_name => 'Ångerrätt';

  @override
  String get memberType_ordentlich => 'Ordinarie medlem';

  @override
  String get memberType_foerder => 'Stödmedlem';

  @override
  String get memberType_ehren => 'Hedersmedlem';

  @override
  String get memberDesc_ordentlich =>
      'Aktivt medlem med rösträtt. Deltar i föreningens tjänster (e-post, moln, byråkratiskt stöd).';

  @override
  String get memberDesc_foerder =>
      'Stödjer föreningen genom bidrag. Kan delta i årsmötet med rådgivande röst, utan rösträtt eller valbarhet till styrelsen.';

  @override
  String get memberDesc_ehren =>
      'Har samma rättigheter som en ordinarie medlem utan skyldighet att betala medlemsavgift. Utnämnd av årsmötet eller styrelsen.';

  @override
  String get payMethod_ueberweisung => 'Banköverföring';

  @override
  String get payMethod_dauerauftrag => 'Stående överföring';

  @override
  String get verifyStatus_geprueft => 'Verifierad';

  @override
  String get verifyStatus_ausgefuellt => 'Ifylld';

  @override
  String get verifyStatus_abgelehnt => 'Avvisad';

  @override
  String get verifyStatus_offen => 'Öppen';

  @override
  String get fillRequiredFields => 'Fyll i alla obligatoriska fält.';

  @override
  String get personalDataSaved => 'Personuppgifter sparade';

  @override
  String get selectMemberType => 'Välj en medlemstyp.';

  @override
  String get memberTypeSaved => 'Medlemstyp sparad';

  @override
  String get selectOption => 'Välj ett alternativ.';

  @override
  String get financialSaved => 'Ekonomisk situation sparad';

  @override
  String get selectPaymentMethod => 'Välj en betalningsmetod.';

  @override
  String get paymentDataSaved => 'Betalningsuppgifter sparade';

  @override
  String get selectDate => 'Välj ett datum.';

  @override
  String get membershipStartSaved => 'Medlemskapets start sparad';

  @override
  String get fileTooLarge => 'Filen är för stor (max. 10 MB).';

  @override
  String get leistungsbescheidUploaded => 'Bidragsbeslut uppladdat';

  @override
  String get verificationProgress => 'Verifieringsframsteg';

  @override
  String get notApplicable => 'Ej tillämpligt';

  @override
  String get socialBenefitsExempt =>
      'Betalningsmetod krävs inte för mottagare av socialbidrag.';

  @override
  String get locked => 'Låst';

  @override
  String completePreviousStep(int step) {
    return 'Slutför steg $step först.';
  }

  @override
  String rejectedNote(String note) {
    return 'Avvisad: $note';
  }

  @override
  String get waitingForReview => 'Inväntar granskning av styrelsen.';

  @override
  String get stepApproved => 'Detta steg har granskats och godkänts.';

  @override
  String get changesViaChat => 'Ändringar endast möjliga via chatt.';

  @override
  String get firstNameRequired => 'Förnamn *';

  @override
  String get lastNameRequired => 'Efternamn *';

  @override
  String get birthDateLabel => 'Födelsedatum *';

  @override
  String get streetRequired => 'Gata *';

  @override
  String get houseNumberRequired => 'Nr. *';

  @override
  String get cityRequired => 'Stad *';

  @override
  String get phoneRequired => 'Telefonnummer *';

  @override
  String get phonePurpose => 'Syfte: Kontakt när inte tillgänglig via appen';

  @override
  String get selectMemberTypePrompt => 'Välj önskad medlemstyp:';

  @override
  String get financialExplanation =>
      'För att kontrollera om du är berättigad till avgiftsreduktion behöver vi följande information. Den används uteslutande för att fastställa din medlemsavgift.';

  @override
  String get socialBenefitsQuestion => 'Får du för närvarande socialbidrag?';

  @override
  String get optionBuergergeld => 'Ja, medborgarbidrag (Jobcenter)';

  @override
  String get optionSozialamt => 'Ja, socialbidrag (Socialkontoret)';

  @override
  String get optionNoBenefits => 'Nej, jag får inte socialbidrag';

  @override
  String get feeExempt => 'Din månadsavgift är: 0,00 €/månad';

  @override
  String get uploadLeistungsbescheid => 'Ladda upp bidragsbeslut';

  @override
  String get uploadLeistungsbescheidHint =>
      'Ladda upp ett aktuellt bidragsbeslut inom 14 dagar för att bekräfta avgiftsbefrielsen.';

  @override
  String get allowedFormatsUpload =>
      'Tillåtna format: PDF, JPG, PNG (max. 10 MB)';

  @override
  String get feeRegular => 'Din månadsavgift är: 25,00 €/månad';

  @override
  String paymentDayReminder(int day) {
    return 'Du kommer att påminnas den $day:e varje månad.';
  }

  @override
  String get membershipStartPrompt => 'Välj när ditt medlemskap ska börja.';

  @override
  String get optionAfterVerification => 'Efter verifieringens slutförande';

  @override
  String get optionAfterVerificationDesc =>
      'Medlemskapet börjar från dagen för styrelsens bekräftelse.';

  @override
  String get optionRetroFoundation =>
      'Retroaktivt till grundningsdatumet (01.08.2025)';

  @override
  String get optionRetroFoundationDesc =>
      'Du blir retroaktiv medlem från föreningens grundande.';

  @override
  String get optionRetroCustom => 'Retroaktivt till ett annat datum';

  @override
  String get optionRetroCustomDesc =>
      'Välj ett datum mellan 01.08.2025 och idag.';

  @override
  String get selectDateLabel => 'Välj datum';

  @override
  String get selectDateHint => 'Välj datum...';

  @override
  String get dateNotBefore => 'Inte före 01.08.2025 (grundningsdatum)';

  @override
  String get feeExemptRetro =>
      'Avgiftsbefrielse: 0,00 € retroaktivt.\nEndast medlemsdatumet sätts retroaktivt.';

  @override
  String get retroactiveFees => 'Retroaktiva avgifter';

  @override
  String retroFeeCalculation(
      String from, String to, String months, String total) {
    return 'Period: $from – $to\nMånader: $months\nAvgift: $months × 25,00 € = $total €';
  }

  @override
  String get pleaseReadSatzung => 'Läs föreningens stadgar.';

  @override
  String get pleaseReadDatenschutz => 'Läs integritetspolicyn.';

  @override
  String get pleaseReadWiderruf => 'Läs ångerrätten.';

  @override
  String get acceptedAtRegistration => 'Accepterad vid registrering';

  @override
  String get confirmedByBoard => 'Bekräftas efter styrelsens granskning.';

  @override
  String get docSatzung => 'Stadgar';

  @override
  String get docDatenschutz => 'Integritetspolicy';

  @override
  String get docWiderruf => 'Ångerrätt';

  @override
  String acceptedAtRegCount(int count) {
    return 'Accepterad vid registrering ($count/3)';
  }

  @override
  String acceptedOn(String date) {
    return 'Accepterad den $date';
  }

  @override
  String get notAccepted => 'Inte accepterad';

  @override
  String get statusAccepted => 'Accepterad';

  @override
  String get nameTooLong => 'Namn för långt (max 100 tecken)';

  @override
  String get emailTooLong => 'E-post för lång (max 255 tecken)';

  @override
  String get legalAcknowledgePrefix => 'Jag har läst ';

  @override
  String get legalAcknowledgeSuffix => '.';

  @override
  String get legalStatutesSuffix =>
      ' för ICD360S e.V. och erkänner dem som bindande.';

  @override
  String get legalPleaseReadFirst => '(vänligen läs först)';

  @override
  String get statusActive => 'Aktiv';

  @override
  String get statusSuspended => 'Avstängd';

  @override
  String get statusNew => 'Ny';

  @override
  String get statusCancelled => 'Uppsagt';

  @override
  String get statusDeleted => 'Borttagen';

  @override
  String get roleMitglied => 'Medlem';

  @override
  String get roleVorsitzer => 'Ordförande';

  @override
  String get roleStellvertreter => 'Ställföreträdare';

  @override
  String get roleSchatzmeister => 'Kassör';

  @override
  String get roleSchriftfuehrer => 'Sekreterare';

  @override
  String get roleBeisitzer => 'Bisittare';

  @override
  String get roleKassierer => 'Kassör';

  @override
  String get roleKassenpruefer => 'Revisor';

  @override
  String get roleEhrenamtlich => 'Frivillig';

  @override
  String get roleMitgliedergruender => 'Grundande Medlem';

  @override
  String get roleEhrenmitglied => 'Hedersmedlem';

  @override
  String get roleFoerdermitglied => 'Stödmedlem';

  @override
  String get memberTypeNotSet => 'Ännu inte fastställt';

  @override
  String get payMethodSepa => 'SEPA-autogiro';

  @override
  String get labelStatus => 'Status';

  @override
  String get labelMemberNumber => 'Medlemsnummer';

  @override
  String get labelRole => 'Roll';

  @override
  String get labelMemberType => 'Medlemstyp';

  @override
  String get labelPaymentMethod => 'Betalningsmetod';

  @override
  String get labelRegisteredOn => 'Registrerad den';

  @override
  String get labelLastLogin => 'Senaste inloggning';

  @override
  String get labelMemberSince => 'Medlem sedan';

  @override
  String get neverLoggedIn => 'Aldrig';

  @override
  String get notActivatedYet => 'Ännu inte aktiverat';

  @override
  String get tabVerification => 'Verifiering';

  @override
  String get tabWarnings => 'Varningar';

  @override
  String get tabDocuments => 'Dokument';

  @override
  String get tabMembership => 'Medlemskap';

  @override
  String get pleaseEnterFirstName => 'Ange förnamn';

  @override
  String get pleaseEnterLastName => 'Ange efternamn';

  @override
  String get noFileDataReceived => 'Inga data mottagna';

  @override
  String get openFile => 'Öppna';

  @override
  String get noMicrophoneError =>
      'Ingen mikrofon hittades. Anslut en mikrofon och försök igen.';

  @override
  String get startConversation => 'Starta en konversation!';

  @override
  String get staffWillReply => 'En medarbetare kommer snart att svara dig.';

  @override
  String get inCall => 'I samtal...';

  @override
  String get registration => 'Registrering';

  @override
  String get deactivation => 'Avaktivering';

  @override
  String get deactivatedOn => 'Avaktiverad den';

  @override
  String get accountAutoSuspend =>
      'Konton som inte verifieras inom 30 dagar kommer automatiskt att stängas av.';

  @override
  String get documentsProvidedByBoard =>
      'Dokument tillhandahålls av styrelsen.';

  @override
  String get noDocumentsAvailable => 'Inga dokument';

  @override
  String get noDocumentsDescription =>
      'Inga dokument har tillhandahållits för dig ännu.';

  @override
  String uploadedBy(String name) {
    return 'Uppladdat av: $name';
  }

  @override
  String stepsCompleted(int completed, int total) {
    return '$completed/$total steg klara';
  }

  @override
  String dayOfMonth(int day) {
    return '$day:e i månaden';
  }

  @override
  String changeField(String field) {
    return 'Ändra $field';
  }

  @override
  String openDocument(String name) {
    return 'Öppna $name';
  }

  @override
  String logEntries(int count) {
    return '$count poster';
  }

  @override
  String get noLogs => 'Inga loggar';

  @override
  String get newLoginDetected => 'Ny inloggning upptäckt';

  @override
  String get errorNoInternet =>
      'Ingen internetanslutning. Kontrollera ditt nätverk.';

  @override
  String get errorTimeout => 'Servern svarar inte. Försök igen senare.';

  @override
  String get errorServer => 'Serverfel. Försök igen senare.';

  @override
  String get errorConnection => 'Anslutningsfel. Försök igen senare.';

  @override
  String get errorUnexpected => 'Ett oväntat fel uppstod. Försök igen senare.';

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
  String get claudiuWelcomeMorning => 'God morgon';

  @override
  String get claudiuWelcomeDay => 'Hej';

  @override
  String get claudiuWelcomeEvening => 'God kväll';

  @override
  String get claudiuWelcomeNight => 'God kväll';

  @override
  String get claudiuWelcomeVisitor => 'kära besökare';

  @override
  String get claudiuWelcomeAsk => 'Hur kan jag hjälpa?';

  @override
  String get claudiuWelcomeBecomeMember => 'Jag vill bli medlem';

  @override
  String get claudiuWelcomeLogin => 'Jag är redan medlem och vill logga in';

  @override
  String get claudiuWelcomeProblem => 'Jag har problem med appen';

  @override
  String get claudiuWelcomeEmergency => 'Akut — ring oss';

  @override
  String get claudiuWelcomeMascotName => 'Claudiu';

  @override
  String get claudiuWelcomeEmergencyIntro =>
      'Innan du ringer — våra öppettider:';

  @override
  String get claudiuWelcomeScheduleOffice => 'På kontoret';

  @override
  String get claudiuWelcomeScheduleField => 'I fält med kunder';

  @override
  String get claudiuWelcomeOutsideHoursNote =>
      'Utanför dessa tider hanterar vi bara akuta fall. Du kan också sms:a samma nummer — vi hör av oss.';

  @override
  String get claudiuWelcomeCallNow => 'Ring nu';

  @override
  String get claudiuWelcomeSendSms => 'Skicka sms';

  @override
  String get claudiuWelcomeSmsBody =>
      'Akut ICD360S e.V. — vänligen kontakta mig snarast.';

  @override
  String get claudiuWelcomeCloseButton => 'Stäng';

  @override
  String get claudiuLoginWelcome => 'Välkommen tillbaka, kära medlem!';

  @override
  String get claudiuLoginAsk => 'Berätta ditt medlemsnummer.';

  @override
  String get claudiuLoginProgress => 'Nästan… fortsätt skriva.';

  @override
  String get claudiuLoginReady => 'Perfekt! Tryck på knappen nedan.';

  @override
  String get claudiuLoginLoading => 'Verifierar identitet… 🔍';

  @override
  String get claudiuLoginFoundPlain => 'Hittade dig! Loggar in…';

  @override
  String claudiuLoginFoundNamed(String name) {
    return 'Hittade dig, $name! Loggar in…';
  }

  @override
  String get claudiuLoginError =>
      'Hm, jag hittar inte det numret. Skrev du det rätt?';

  @override
  String get claudiuLoginForgotHeader => 'Glömt ditt medlemsnummer?';

  @override
  String get claudiuLoginNoSms =>
      'Vi skickar inte numret via e-post eller sms.';

  @override
  String get claudiuLoginOnlyWay =>
      'Det enda sättet: ett personligt möte på föreningens kontor, efter ID-kontroll.';

  @override
  String get claudiuLoginContactUs => 'Ring för att boka tid:';

  @override
  String get claudiuDiagnosticGreeting => 'Innan du går in, en snabb fråga';

  @override
  String get claudiuDiagnosticAsk =>
      'Får jag skicka anonyma rapporter så att utvecklarna kan förbättra appen?';

  @override
  String get claudiuDiagnosticYes => 'Ja, jag vill hjälpa';

  @override
  String get claudiuDiagnosticNo => 'Nej, jag tittar bara';

  @override
  String get claudiuDiagnosticTellMore => 'Berätta mer';

  @override
  String get claudiuDiagnosticSendsHeader => '📤 Vad vi SKICKAR (anonymt):';

  @override
  String get claudiuDiagnosticSends1 =>
      'En anonym enhetskod (INTE medlemsnumret)';

  @override
  String get claudiuDiagnosticSends2 => 'Din roll (medlem / styrelse)';

  @override
  String get claudiuDiagnosticSends3 =>
      'Operativsystem (Linux / Android / iOS / Windows)';

  @override
  String get claudiuDiagnosticSends4 => 'Valt språk';

  @override
  String get claudiuDiagnosticSends5 => 'Batterinivå och status';

  @override
  String get claudiuDiagnosticSends6 => 'Aktuell skärm';

  @override
  String get claudiuDiagnosticSends7 => 'Sessionslängd (sekunder)';

  @override
  String get claudiuDiagnosticSends8 => 'Fel om några (senaste 10)';

  @override
  String get claudiuDiagnosticSends9 => 'Navigation (senaste 20 skärmar)';

  @override
  String get claudiuDiagnosticNeverHeader => '🛡️ Vad vi ALDRIG skickar:';

  @override
  String get claudiuDiagnosticNever1 => 'Ditt riktiga namn';

  @override
  String get claudiuDiagnosticNever2 => 'E-postadress';

  @override
  String get claudiuDiagnosticNever3 => 'Telefonnummer';

  @override
  String get claudiuDiagnosticNever4 => 'Lösenord';

  @override
  String get claudiuDiagnosticNever5 => 'Innehållet i chattmeddelanden';

  @override
  String get claudiuDiagnosticNever6 => 'Innehållet i ärenden';

  @override
  String get claudiuDiagnosticNever7 => 'Dokument eller bilagor';

  @override
  String get claudiuDiagnosticTechHeader => '📡 Tekniska detaljer:';

  @override
  String get claudiuDiagnosticTech1 => 'Skickas varannan minut';

  @override
  String get claudiuDiagnosticTech2 =>
      'TLS-krypterad anslutning, fäst certifikat';

  @override
  String get claudiuDiagnosticTech3 =>
      'Du kan stänga av när som helst i Inställningar';

  @override
  String get claudiuProblemHelpTitle => 'Hur kan jag hjälpa?';

  @override
  String get claudiuProblemHelpGreeting => 'Vad hände?';

  @override
  String get claudiuProblemHelpAsk => 'Hur vill du berätta?';

  @override
  String get claudiuProblemHelpWriteTitle => 'Skriv en rapport';

  @override
  String get claudiuProblemHelpWriteBody =>
      'Med steg-för-steg-detaljer. Teamet får texten och löser det senare.';

  @override
  String get claudiuProblemHelpChatTitle => 'Låt oss prata nu';

  @override
  String get claudiuProblemHelpChatBody =>
      'Anonym chatt med en operatör. Realtidssvar om någon är online.';

  @override
  String get claudiuProblemHelpAltCallHeader => 'Eller om det är akut:';

  @override
  String get claudiuProblemHelpAltCallLabel => 'Ring oss';

  @override
  String get claudiuAnonymousChatTitle => 'Anonym chatt';

  @override
  String get claudiuAnonymousChatGreeting => 'Hej!';

  @override
  String get claudiuAnonymousChatWelcome =>
      'Jag lyssnar. Skriv vad du vill — inget namn behövs. Jag svarar så snart jag är här.';

  @override
  String get claudiuAnonymousChatHint => 'Skriv ett meddelande…';

  @override
  String get claudiuAnonymousChatWaitingOperator =>
      'Väntar på att en operatör ska svara…';

  @override
  String get claudiuVorsitzerConnectedTitle => 'Hej!';

  @override
  String get claudiuVorsitzerConnectedBody =>
      'Tack för att du hör av dig — du är nu i kontakt med en Vorsitzer. Berätta hur vi kan hjälpa dig med din medlemsansökan.';

  @override
  String get claudiuVorsitzerConnectedSender => 'Vorsitzer';

  @override
  String get claudiuQuickReplyValidationTime =>
      'Hur lång tid tar granskningen?';

  @override
  String get claudiuQuickReplyDocuments => 'Vilka dokument behöver jag?';

  @override
  String get claudiuQuickReplyStepProblem => 'Jag har kört fast på ett steg';

  @override
  String get claudiuQuickReplyHuman => 'Kan jag prata med någon nu?';

  @override
  String get claudiuAnonymousChatConnecting => 'Ansluter…';

  @override
  String get claudiuAnonymousChatConnectionFailed =>
      'Det gick inte att öppna chatten. Försök igen eller ring oss.';

  @override
  String get claudiuAnonymousChatRetry => 'Försök igen';

  @override
  String get claudiuAnonymousChatOnline => 'Ansluten';

  @override
  String get claudiuAnonymousChatOffline => 'Återansluter…';

  @override
  String get claudiuAnonymousChatAdminTyping => 'Operatören skriver…';

  @override
  String get claudiuProblemReportTitle => 'Rapportera ett problem';

  @override
  String get claudiuProblemReportGreeting => 'Vad hände?';

  @override
  String get claudiuProblemReportAsk =>
      'Berätta detaljerat så vidarebefordrar jag rapporten till teamet.';

  @override
  String get claudiuProblemReportIncludeHeader => 'Vänligen inkludera:';

  @override
  String get claudiuProblemReportIncludeBullets1 =>
      'Vad du gjorde när problemet uppstod';

  @override
  String get claudiuProblemReportIncludeBullets2 =>
      'Eventuella felmeddelanden du såg';

  @override
  String get claudiuProblemReportIncludeBullets3 => 'Vilken skärm du var på';

  @override
  String get claudiuProblemReportIncludeBullets4 =>
      'Kraschar appen, stänger den eller visar en tom skärm?';

  @override
  String get claudiuProblemReportIncludeBullets5 =>
      'Händer det varje gång eller bara en gång?';

  @override
  String get claudiuProblemReportDescriptionLabel => 'Din beskrivning';

  @override
  String get claudiuProblemReportDescriptionHint =>
      'T.ex.: När jag öppnar chatten får jag \"Connection error\" och appen svarar inte…';

  @override
  String claudiuProblemReportTooShort(int count) {
    return 'Lite mer detaljer, tack (minst $count tecken)';
  }

  @override
  String get claudiuProblemReportSubmit => 'Skicka rapport';

  @override
  String get claudiuProblemReportSubmitting => 'Skickar…';

  @override
  String get claudiuProblemReportSentTitle => 'Tack!';

  @override
  String get claudiuProblemReportSentBody =>
      'Rapporten har skickats. Vårt team tittar på det så snart som möjligt.';

  @override
  String get claudiuProblemReportSentClose => 'Förstått';

  @override
  String get claudiuProblemReportSendFailed =>
      'Det gick inte att skicka rapporten. Ring oss för akut hjälp.';

  @override
  String get claudiuProblemReportAlt => 'Eller om det är akut:';

  @override
  String get claudiuProblemReportCallLabel => 'Ring oss';

  @override
  String claudiuApprovalGreeting(String name) {
    return 'Hej, $name! 👋';
  }

  @override
  String get claudiuApprovalGreetingNoName => 'Hej! 👋';

  @override
  String get claudiuApprovalGladToSeeYou => 'Roligt att du är här!';

  @override
  String get claudiuApprovalCheckingForSafety =>
      'För din säkerhet kontrollerar en Vorsitzer just nu din inloggningsbegäran. 🛡️';

  @override
  String get claudiuApprovalMonthlyExplain =>
      '💡 Vi gör det här var 30:e dag för att vara säkra på att det verkligen är du. Det är som en säkerhetskontroll — max 5 minuter.';

  @override
  String get claudiuApprovalSuccess =>
      'Klart! 🎉 Vorsitzer kände igen dig. Loggar in dig…';

  @override
  String get claudiuApprovalDenied => 'Hm, Vorsitzer avvisade din begäran. 😔';

  @override
  String get claudiuApprovalDeniedHelp =>
      'Om du tror att det är ett misstag, ring oss så reder vi ut det.';

  @override
  String get claudiuApprovalExpired =>
      '5 minuter har gått och vi hörde inte från Vorsitzer.';

  @override
  String get claudiuApprovalExpiredHelp =>
      'Ring oss så kan vi godkänna din begäran direkt. 📞';

  @override
  String get claudiuApprovalCallUs => 'Ring oss';

  @override
  String get claudiuApprovalTryAgain => 'Försök igen';

  @override
  String get claudiuApprovalCancel => 'Avbryt';

  @override
  String get claudiuApprovalClose => 'Stäng';

  @override
  String get wizardIntroBubble1 =>
      'Hej, besökare! 👋 Tack för att du vill bli en del av vår familj.';

  @override
  String get wizardIntroBubble2 =>
      'Jag heter Claudiu. Våren 2025 hade jag en tydlig vision: att skapa en förening som hjälper människor i nöd — ideellt, från hjärtat, utan onödig byråkrati. ❤️';

  @override
  String get wizardIntroBubble3 =>
      'Jag började prata med klienterna jag besökte. Jag berättade min dröm för dem. Och alla sa: \"Ja, kör!\" I juli 2025 träffades vi sex — beslutsamma människor. Vi bestämde oss för att grunda **ICD360S e.V.** i Neu-Ulm. 📍';

  @override
  String get wizardIntroBubble4 =>
      'Den **1 augusti 2025** föddes föreningen officiellt — i föreningsregistret. Min vackraste gåva. 🎂';

  @override
  String get wizardIntroBubble5 =>
      'Vad gör vi? Vi hjälper flyktingar, personer med funktionsnedsättning, ekonomiskt utsatta, **barn och unga** — med administrativa frågor, tyska, bostad, inköp, sociala förmåner. Vår Vorstand består till största delen av personer med funktionsnedsättning — så besluten kommer från verklig livserfarenhet. 🤝';

  @override
  String get wizardIntroBubble6 =>
      'Nu är det din tur. Låt oss registrera dig — tar ungefär 5 minuter. Vi går steg för steg, jag lämnar dig inte ensam. ✨';

  @override
  String get wizardIntroStart => 'Nu kör vi';

  @override
  String get wizardBack => 'Tillbaka';

  @override
  String get wizardNext => 'Nästa';

  @override
  String wizardStepLabel(int step, int total, String title) {
    return 'Steg $step av $total · $title';
  }

  @override
  String get wizardErrRequired => 'Detta fält är obligatoriskt';

  @override
  String wizardErrTooShort(int count) {
    return 'För kort (minst $count tecken)';
  }

  @override
  String get wizardErrOnlyLetters =>
      'Endast bokstäver, mellanslag, bindestreck och apostrofer';

  @override
  String get wizardErrSaveFailed =>
      'Det gick inte att spara. Kontrollera anslutningen och försök igen.';

  @override
  String get wizardStufe1aTitle => 'Identitet';

  @override
  String get wizardStufe1aPrompt =>
      'Låt oss bli formellt bekanta. Skriv ditt namn precis som det står på Personalausweis, Reisepass eller Aufenthaltstitel — så stämmer det med dina dokument.';

  @override
  String get wizardStufe1aVornameLabel => 'Vornamen (förnamn)';

  @override
  String get wizardStufe1aVornameHelper =>
      'Alla dina förnamn precis som på dokumentet. Med mellanslag eller bindestreck (t.ex. Hans-Peter, Maria Anna).';

  @override
  String get wizardStufe1aNachnameLabel => 'Familienname (efternamn)';

  @override
  String get wizardStufe1aNachnameHelper => 'Ditt nuvarande efternamn.';

  @override
  String get wizardStufe1aGeburtsnameLabel =>
      'Geburtsname (födelsenamn) — frivilligt';

  @override
  String get wizardStufe1aGeburtsnameHelper =>
      'Endast om det skiljer sig från Familienname — t.ex. före äktenskap.';

  @override
  String get wizardStufe1bTitle => 'Födelsedag';

  @override
  String get wizardStufe1bPrompt =>
      'Vi vill gärna fira din födelsedag med dig! 🎂 Det hjälper oss också att bekräfta att du är minst 16 — så står det i våra stadgar.';

  @override
  String get wizardStufe1bGeburtsdatumLabel => 'Födelsedatum';

  @override
  String get wizardStufe1bGeburtsdatumHelper => 'Tryck för att välja ett datum';

  @override
  String get wizardStufe1bGeburtsortLabel => 'Födelseort';

  @override
  String get wizardStufe1bGeburtsortHelper => 'Stad / ort där du föddes.';

  @override
  String get wizardAgeGatePrompt => 'Jag är ledsen… 😔';

  @override
  String wizardAgeGateBody1(int age, int years) {
    return 'Våra stadgar säger att du måste vara minst 16 för att bli medlem. Du är $age — jag hoppas vi ses igen om $years år! 🌱';
  }

  @override
  String get wizardAgeGateBody2 =>
      'Vill du volontära då och då (vilken ålder som helst, med föräldrarnas medgivande), ring oss — vi stöttar gärna unga som vill förändra världen.';

  @override
  String get wizardAgeGateBackHome => 'Tillbaka till start';

  @override
  String get wizardErrInvalidPhone => 'Ogiltigt telefonnummer';

  @override
  String get wizardStufe1b1Title => 'Föräldrasamtycke';

  @override
  String get wizardStufe1b1Prompt =>
      'Du är minderårig (16-17) — enligt §106 BGB behöver vi en förälders eller vårdnadshavares samtycke. Säg mig namnet och telefonnumret. En Vorsitzer ringer och bokar ett möte (personligt eller videosamtal). Ingen e-post — vi vill vara säkra på att vi pratar med rätt person.';

  @override
  String get wizardStufe1b1VornameLabel => 'Förälderns förnamn';

  @override
  String get wizardStufe1b1VornameHelper =>
      'Som på förälderns Personalausweis.';

  @override
  String get wizardStufe1b1NachnameLabel => 'Förälderns efternamn';

  @override
  String get wizardStufe1b1NachnameHelper =>
      'Som på förälderns Personalausweis.';

  @override
  String get wizardStufe1b1TelefonLabel => 'Förälderns mobilnummer';

  @override
  String get wizardStufe1b1TelefonHelper => 'En Vorsitzer ringer detta nummer.';

  @override
  String get wizardStufe1b1RelationLabel => 'Förhållande till barnet:';

  @override
  String get wizardStufe1b1RelationMutter => 'Mor';

  @override
  String get wizardStufe1b1RelationVater => 'Far';

  @override
  String get wizardStufe1b1RelationSorgeberechtigter => 'Vårdnadshavare';

  @override
  String get wizardStufe1b1RelationAndere => 'Annan vårdnadshavare';

  @override
  String get wizardStufe1cTitle => 'Personuppgifter';

  @override
  String get wizardStufe1cPrompt =>
      'Bara så att jag lär känna dig lite bättre. Det här stannar mellan oss och visas inte offentligt någonstans.';

  @override
  String get wizardStufe1cGeschlechtLabel => 'Kön';

  @override
  String get wizardStufe1cGeschlechtMaennlich => 'Man';

  @override
  String get wizardStufe1cGeschlechtWeiblich => 'Kvinna';

  @override
  String get wizardStufe1cGeschlechtDivers => 'Annat';

  @override
  String get wizardStufe1cGeschlechtKeineAngabe => 'Föredrar att inte säga';

  @override
  String get wizardStufe1cFamilienstandLabel => 'Civilstånd';

  @override
  String get wizardStufe1cFamilienstandLedig => 'Ogift';

  @override
  String get wizardStufe1cFamilienstandVerheiratet => 'Gift';

  @override
  String get wizardStufe1cFamilienstandGeschieden => 'Skild';

  @override
  String get wizardStufe1cFamilienstandVerwitwet => 'Änkling/Änka';

  @override
  String get wizardStufe1dTitle => 'Din bakgrund';

  @override
  String get wizardStufe1dPrompt =>
      'Det hjälper oss att erbjuda dig rätt stöd — till exempel rådgivning om Aufenthalt eller att hitta din språkgemenskap.';

  @override
  String get wizardStufe1dStaatLabel => 'Medborgarskap';

  @override
  String get wizardStufe1dStaatHelper =>
      'T.ex. deutsch, rumänisch, ukrainisch. Flera separerade med kommatecken.';

  @override
  String get wizardStufe1dAufenthaltLabel =>
      'Uppehållsstatus (Aufenthaltsstatus) — frivilligt';

  @override
  String get wizardStufe1dAufenthaltHelper =>
      'Välj titeln från din Aufenthaltskarte / beslut. Vorstand jämför med dina dokument.';

  @override
  String get wizardStufe1dAufenthaltAwaitingCitizenship =>
      'Fyll i medborgarskap ovan först — vi visar bara relevanta alternativ.';

  @override
  String get wizardStufe1dAufenthaltGerman =>
      'Ingen Aufenthaltstitel behövs — tysk medborgare.';

  @override
  String get wizardStufe1dAufenthaltEuEea =>
      'EU/EES/CH-medborgare — fri rörlighet (Freizügigkeit).';

  @override
  String get wizardStufe1dAufenthaltTempHint => 'tillfällig';

  @override
  String get wizardStufe1dAufenthaltPermHint => 'permanent vistelse';

  @override
  String get wizardStufe1dAufenthaltAsylumProcessHint => 'asylförfarande';

  @override
  String get wizardStufe1dAufenthaltOther => 'Annat (specificera i chatten)';

  @override
  String get wizardStufe1dAufenthaltRequired => 'Välj en Aufenthaltstitel.';

  @override
  String get wizardStufe1dMutterspracheLabel => 'Modersmål';

  @override
  String get wizardStufe1dMutterspracheHelper =>
      'Förifyllt med appens språk — ändra om annat.';

  @override
  String get wizardStufe1eTitle => 'Adress';

  @override
  String get wizardStufe1ePrompt =>
      'Din postadress — vi använder den för officiella dokument (stadgar, medlemskontrakt, meddelanden).';

  @override
  String get wizardStufe1eStrasseLabel => 'Gata';

  @override
  String get wizardStufe1eStrasseHelper =>
      'Bara gatunamnet — numret i fältet bredvid.';

  @override
  String get wizardStufe1eHausnummerLabel => 'Nr.';

  @override
  String get wizardStufe1ePlzLabel => 'PLZ (postnr.)';

  @override
  String get wizardStufe1eOrtLabel => 'Ort';

  @override
  String get wizardStufe1eLandLabel => 'Land';

  @override
  String get wizardStufe1eLandHelper => 'Förifyllt: Deutschland.';

  @override
  String get wizardErrInvalidStreet => 'Ogiltigt gatunamn';

  @override
  String get wizardErrInvalidHausnummer =>
      'Ogiltigt nummer (t.ex. 12, 12a, 12/3)';

  @override
  String get wizardErrInvalidPlz => 'Ogiltigt postnummer (endast siffror)';

  @override
  String get wizardStufe1fTitle => 'Kontakt';

  @override
  String get wizardStufe1fPrompt =>
      'Hur når vi dig? Telefonen är bara för akuta fall — allt annat sker via vår egen end-to-end-krypterade kanal i appen. Din medlems-e-post tilldelas automatiskt och visas nedan.';

  @override
  String get wizardStufe1fTelefonLabel => 'Mobilnummer';

  @override
  String get wizardStufe1fTelefonHelper =>
      'Lovar att jag bara ringer om det är viktigt. 📱';

  @override
  String get wizardStufe2Title => 'Medlemskapstyp';

  @override
  String get wizardStufe2Prompt =>
      'Vilken typ av medlem vill du vara? Låt mig förklara varje alternativ.';

  @override
  String get wizardStufe2OrdentlichTitle => 'Ordinarie medlem (ordentlich)';

  @override
  String get wizardStufe2OrdentlichBody =>
      'Fulla rättigheter. Du betalar månadsavgift, röstar på medlemsmötet, kan väljas till styrelsen. Standardvalet.';

  @override
  String get wizardStufe2FoerderTitle => 'Stödjande medlem (Fördermitglied)';

  @override
  String get wizardStufe2FoerderBody =>
      'Du stöder föreningen ekonomiskt men deltar inte aktivt i besluten. Ingen rösträtt. Bra om du vill hjälpa på distans.';

  @override
  String get wizardStufe2EhrenTitle => 'Hedersmedlem (Ehrenmitglied)';

  @override
  String get wizardStufe2EhrenBody =>
      'Tilldelas av styrelsen för särskilda meriter. Du väljer det inte själv — det ges som erkännande. Välj bara om du redan blivit hedrad.';

  @override
  String get wizardStufe3Title => 'Ekonomisk situation';

  @override
  String get wizardStufe3Prompt =>
      'Nu om din ekonomiska situation. Inte för att döma — bara för att kunna befria dig från avgiften om du får socialbidrag.';

  @override
  String get wizardStufe3OptionBuergergeld => 'Jag får Bürgergeld';

  @override
  String get wizardStufe3OptionSozialamt => 'Jag får förmåner från Sozialamt';

  @override
  String get wizardStufe3OptionNein => 'Jag får ingen av dessa';

  @override
  String get wizardStufe3FeeExemptTitle => 'Avgift: 0 € / månad 🎉';

  @override
  String get wizardStufe3FeeExemptBody =>
      'Med Bürgergeld, Sozialamt, ALG I eller Krankengeld är du helt befriad från avgiften enligt Satzung §6. Vi behöver bara ett intyg (Leistungsbescheid eller intyg från myndigheten / sjukkassan).';

  @override
  String get wizardStufe3UploadTitle => 'Ladda upp Leistungsbescheid';

  @override
  String get wizardStufe3UploadHint => 'PDF / JPG / PNG, max 10 MB.';

  @override
  String get wizardStufe3UploadRequired =>
      'Ladda upp Leistungsbescheid innan du fortsätter.';

  @override
  String get wizardStufe3FileTooLarge => 'Filen är för stor. Max 10 MB.';

  @override
  String get wizardStufe3UploadFailed =>
      'Det gick inte att ladda upp filen. Försök igen.';

  @override
  String get wizardStufe3RegularFeeTitle => 'Avgift: 25 € / månad';

  @override
  String get wizardStufe3RegularFeeBody =>
      'Standardavgift för ordinarie medlemmar enligt stadgarna.';

  @override
  String get wizardStufe4Title => 'Betalning';

  @override
  String get wizardStufe4Prompt =>
      'Hur vill du betala avgiften? Och vilken dag i månaden?';

  @override
  String get wizardStufe4MethodUeberweisungTitle =>
      'Banköverföring (Überweisung)';

  @override
  String get wizardStufe4MethodUeberweisungBody =>
      'Du startar själv betalningen varje månad från ditt konto.';

  @override
  String get wizardStufe4MethodSepaTitle => 'SEPA-Lastschrift (autogiro)';

  @override
  String get wizardStufe4MethodSepaBody =>
      'Vi drar beloppet automatiskt från ditt konto. Bekvämast, men vi behöver IBAN och ett underskrivet mandat.';

  @override
  String get wizardStufe4MethodDauerauftragTitle =>
      'Dauerauftrag (stående överföring)';

  @override
  String get wizardStufe4MethodDauerauftragBody =>
      'Du sätter upp en stående överföring i banken. Banken överför beloppet automatiskt varje månad.';

  @override
  String get wizardStufe4DayLabel => 'Betaldag';

  @override
  String get wizardStufe4DayHint => 'Välj en dag mellan 1 och 31';

  @override
  String wizardStufe4DayItem(int day) {
    return 'Dag $day';
  }

  @override
  String wizardStufe4DayReminder(int day) {
    return 'Avgiften dras den $day:e varje månad.';
  }

  @override
  String get wizardStufe5Title => 'Startdatum';

  @override
  String get wizardStufe5Prompt =>
      'Från när vill du officiellt vara ICD360S-medlem? Från godkännandet eller retroaktivt.';

  @override
  String get wizardStufe5OptionAbVerifizierungTitle =>
      'Från Vorstand-godkännandet';

  @override
  String get wizardStufe5OptionAbVerifizierungBody =>
      'Det enklaste valet. Ingen retroaktiv avgift.';

  @override
  String get wizardStufe5OptionGruendungsdatumTitle =>
      'Retroaktivt från 01.08.2025 (grundande)';

  @override
  String get wizardStufe5OptionGruendungsdatumBody =>
      'Du räknas som medlem från föreningens första dag.';

  @override
  String get wizardStufe5OptionAnderesDatumTitle => 'Ett annat datum';

  @override
  String get wizardStufe5OptionAnderesDatumBody =>
      'Du väljer ett datum mellan 01.08.2025 och idag.';

  @override
  String get wizardStufe5PickDate => 'Tryck för att välja ett datum';

  @override
  String get wizardStufe5PickDateFirst => 'Välj först ett datum.';

  @override
  String get wizardStufe5DatePickerHelp => 'Medlemskapets början';

  @override
  String wizardStufe5DateRange(String start) {
    return 'Mellan $start och idag';
  }

  @override
  String get wizardStufe5RetroactiveTitle => 'Retroaktiv avgift';

  @override
  String wizardStufe5RetroactiveBody(
      String start, String end, int months, String amount) {
    return 'Från $start till $end är det $months månader. Vid 25 €/månad blir det $amount € att betala retroaktivt, utöver den löpande månadsavgiften.';
  }

  @override
  String get wizardStufe5FeeExemptTitle => 'Retroaktiv avgift: 0 € 🎉';

  @override
  String get wizardStufe5FeeExemptBody =>
      'Med Bürgergeld eller Sozialamt är du helt befriad — inte ens retroaktivt är du skyldig något.';

  @override
  String wizardDocumentPrompt(String doc) {
    return 'Innan vi avslutar, läs $doc noggrant. Det är viktigt att veta vad du skriver under.';
  }

  @override
  String get wizardDocumentScrollHint =>
      'Skrolla till botten för att fortsätta.';

  @override
  String get wizardDocumentScrolledOk => 'Du har läst till slutet ✓';

  @override
  String wizardDocumentOpenButton(String doc) {
    return 'Öppna $doc i webbläsaren';
  }

  @override
  String get wizardDocumentExternalHint =>
      'På den här plattformen öppnar vi dokumentet i din standardwebbläsare.';

  @override
  String get wizardDocumentOpenedOk =>
      'Dokumentet har öppnats. Läs det noggrant.';

  @override
  String wizardDocumentConfirm(String doc) {
    return 'Jag bekräftar att jag har läst och godkänner $doc.';
  }

  @override
  String get wizardFinalAdultTitle => 'Klart! Du är inskriven 🎉';

  @override
  String get wizardFinalMinorTitle => 'Din begäran har skickats 📨';

  @override
  String get wizardFinalMinorBody =>
      'Vi kontaktar din förälder och bokar ett möte (personligt eller videosamtal). Var tålmodig — processen kan ta upp till 7 dagar. Du får en notis i appen så snart din förälder har godkänt.';

  @override
  String get wizardFinalMitgliedernummerLabel => 'Ditt medlemsnummer';

  @override
  String get wizardStufe4MethodComingSoon => 'Kommer snart';

  @override
  String get wizardStufe4StreichungWarning =>
      'Om du ligger mer än 6 månader efter med avgiften stryker vi dig automatiskt (Satzung §6 Abs. 3).';

  @override
  String get wizardStufe5KuendigungInfo =>
      'För att gå ur: skicka oss en skriftlig uppsägning 3 månader före 31 december (senast 30 september för att gälla från årsskiftet). Ingen minimitid (Satzung §6 Abs. 3).';

  @override
  String get wizardStufe1fEmailLabel => 'Din medlems-e-post';

  @override
  String get wizardStufe1fEmailHelper =>
      'Tilldelas automatiskt utifrån ditt medlemsnummer. Aktiveras i det ögonblick då styrelsen (Vorstand) godkänner din ansökan. Vi har vår egen e-postapp — skicka och ta emot krypterade e-postmeddelanden, enkelt och gratis.';

  @override
  String get wizardErrInvalidEmail => 'Ogiltig e-postadress';

  @override
  String get wizardStufe3OptionAlg1 =>
      'Jag får Arbeitslosengeld I (ALG I, arbetslöshetsersättning)';

  @override
  String get wizardStufe3OptionKrankengeld =>
      'Jag får Krankengeld (sjukpenning vid längre sjukdom)';

  @override
  String get wizardStufe3UploadAddMore => 'Lägg till ett dokument till';

  @override
  String get wizardStufe3UploadLimitCount =>
      'Gränsen är nådd: max 20 dokument.';

  @override
  String get wizardStufe3UploadLimitTotal =>
      'Total gräns på 100 MB nådd. Ta bort en befintlig fil.';

  @override
  String get wizardStufe3UploadDeleteTooltip => 'Ta bort';

  @override
  String wizardStufe3UploadCounter(int count, int max) {
    return '$count / $max dokument';
  }

  @override
  String get wizardDocumentExternalOpenFailed =>
      'Det gick inte att öppna webbläsaren. Länken är kopierad till urklipp — klistra in den i en webbläsare för att fortsätta.';

  @override
  String get wizardFinalTimelineProcessing =>
      'Vorstand granskar · vanligtvis 1 arbetsdag, upp till 7';

  @override
  String get wizardFinalTimelineActivated => 'Konto aktiverat';

  @override
  String get wizardFinalAdultThank =>
      'Tack för att du fyllde i registreringsformuläret! 🎉';

  @override
  String get wizardFinalAdultUsual =>
      'Din ansökan är hos oss. Vi validerar den oftast inom en arbetsdag.';

  @override
  String get wizardFinalAdultExceptional =>
      'Ibland kan det ta upp till 7 arbetsdagar. Och om något inte stämmer skickar vi tillbaka dig till formuläret så att du kan rätta till det 🙂';

  @override
  String get wizardFinalStatusTitle => 'ANSÖKNINGSSTATUS';

  @override
  String wizardFinalStatusStepsValidated(int reviewed, int total) {
    return '$reviewed/$total steg validerade av Vorstand';
  }

  @override
  String get wizardFinalStufeSheetTitle => 'Detaljer för ansökan';

  @override
  String get wizardFinalStufeSheetHint =>
      'De 8 stegen du fyllde i. Vorstand granskar dem ett i taget — du ser i realtid vad som godkänts.';

  @override
  String get wizardFinalStufeStatusPending => 'Väntar på granskning';

  @override
  String get wizardFinalStufeStatusApproved => 'Godkänd';

  @override
  String get wizardFinalStufeStatusRejected => 'Avvisad';

  @override
  String wizardFinalStatusRejectionCount(int count) {
    return '$count steg behöver korrigeras';
  }

  @override
  String get wizardFinalStufeRejectionReason => 'Skäl från Vorstand:';

  @override
  String get wizardFinalStufeCorrectNow => 'Rätta nu';

  @override
  String wizardFinalApprovalsHeader(int current, int total) {
    return 'Vorstand-godkännanden ($current/$total)';
  }

  @override
  String get wizardFinalApprovalAwaiting => 'Väntar på 2:a Vorstand';

  @override
  String get wizardFinalApprovalRejected => 'AVVISAD';

  @override
  String get wizardFinalStufeNoDataYet => 'Data ännu inte tillgänglig.';

  @override
  String get wizardFinalStufeReadAt => 'Läst:';

  @override
  String get wizardFinalStufeBeitragsfrei => 'Avgiftsbefriad (ingen betalning)';

  @override
  String get wizardFinalStufeNotExempt => 'Inga socialbidrag';

  @override
  String get wizardFinalStufeBeginAtVerification => 'Startar vid verifiering';

  @override
  String get wizardFinalStufeBeginAtFoundation =>
      'Grundningsdatum (retroaktivt)';

  @override
  String get wizardFinalStufeBeginAtCustom => 'Annat datum';

  @override
  String get wizardFinalStufeStatusSkipped => 'Hoppade över';

  @override
  String get wizardFinalStufeFilledAt => 'Ifylld:';

  @override
  String get wizardFinalStufeReviewedAt => 'Granskad:';

  @override
  String get wizardFinalWithdrawLink => 'Dra tillbaka ansökan';

  @override
  String get wizardFinalWithdrawDialogTitle => 'Dra tillbaka ansökan?';

  @override
  String get wizardFinalWithdrawDialogBody =>
      'Din ansökan markeras som tillbakadragen av dig. Datan stannar i databasen för revision (GDPR), men kontot aktiveras inte. Du kan när som helst börja om registreringen med ett nytt medlemsnummer.';

  @override
  String get wizardFinalWithdrawKeep => 'Nej, jag väntar';

  @override
  String get wizardFinalWithdrawConfirm => 'Ja, dra tillbaka';

  @override
  String get wizardErrTooManyWithdrawals =>
      'Din ansökan kan inte hanteras automatiskt. Ring oss eller kom personligen till Vorstand för att fortsätta registreringen.';

  @override
  String get wizardDuplicateLoginTitle =>
      'Det ser ut som att du redan är medlem';

  @override
  String get wizardDuplicateLoginBody =>
      'Med ditt namn och födelsedatum hittar vi redan ett aktivt konto. Använd \"Jag är redan medlem\" på startskärmen för att logga in. Om du inte har tillgång längre, ring oss.';

  @override
  String get wizardDuplicatePendingTitle => 'Din ansökan är redan hos oss';

  @override
  String get wizardDuplicatePendingBody =>
      'Med ditt namn och födelsedatum har vi redan en ansökan under granskning. Vorstand jobbar med den — vi meddelar dig i appen så snart ditt konto är aktivt. Ring oss om du vill prata.';

  @override
  String get wizardDuplicateRecentlyWithdrawnTitle =>
      'Vi kan inte behandla denna ansökan nu';

  @override
  String get wizardDuplicateRecentlyWithdrawnBody =>
      'Ditt namn och födelsedatum matchar en nyligen tillbakadragen ansökan. Ring oss för att prata med Vorstand innan du går vidare.';

  @override
  String get wizardDuplicatePreviouslyWithdrawnTitle =>
      'Du har ansökt tidigare';

  @override
  String get wizardDuplicatePreviouslyWithdrawnBody =>
      'Ditt namn och födelsedatum matchar en äldre ansökan som du dragit tillbaka. Välkommen tillbaka — ring oss innan du fortsätter så Vorstand kan besluta hur vi går vidare.';

  @override
  String get wizardDuplicateCallUsTitle => 'Vänligen ring oss';

  @override
  String get wizardDuplicateCallUsBody =>
      'Ditt namn och födelsedatum finns redan hos oss, men vi kan inte dela detaljerna via appen. Ring oss — Vorstand förklarar situationen direkt.';

  @override
  String get wizardChatHelp => 'Vi pratar';

  @override
  String get wizardChatHelpSubtitle => 'Livechatt med Vorstand · snabbt svar';

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

  @override
  String get signaturSiegelInArbeit =>
      'Das Siegel wird noch erstellt. Bitte versuchen Sie es in einer Minute noch einmal.';
}
