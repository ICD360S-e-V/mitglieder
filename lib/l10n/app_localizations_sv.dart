// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Swedish (`sv`).
class AppLocalizationsSv extends AppLocalizations {
  AppLocalizationsSv([String locale = 'sv']) : super(locale);

  @override
  String get appTitle => 'ICD360S e.V - Medlemsportal';

  @override
  String get memberPortal => 'Medlemsportal';

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
  String get password => 'Lösenord';

  @override
  String get passwordHint => 'Ange lösenord';

  @override
  String get confirmPassword => 'Bekräfta lösenord';

  @override
  String get confirmPasswordHint => 'Bekräfta lösenord';

  @override
  String get newPassword => 'Nytt lösenord';

  @override
  String get newPasswordHint => 'Ange nytt lösenord';

  @override
  String get saveCredentials => 'Spara inloggningsuppgifter';

  @override
  String get autoLogin => 'Automatisk inloggning';

  @override
  String get forgotPassword => 'Glömt lösenord?';

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
  String get recoveryCode => 'Återställningskod (6 siffror)';

  @override
  String get recoveryCodeHelper =>
      'Kom ihåg denna kod för lösenordsåterställning';

  @override
  String get recoveryCodeHint => 'Ange återställningskod';

  @override
  String get recoveryCodeInvalid => 'Koden måste ha exakt 6 siffror';

  @override
  String get loginFailed => 'Inloggningen misslyckades';

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
  String get tooManyDevices => 'För många enheter';

  @override
  String get maxDevicesMessage =>
      'Du är redan inloggad på 3 enheter.\nVälj en enhet att logga ut från:';

  @override
  String get unknownDevice => 'Okänd enhet';

  @override
  String get unknown => 'Okänd';

  @override
  String get logoutError => 'Utloggningsfel';

  @override
  String error(String error) {
    return 'Fel: $error';
  }

  @override
  String get cancel => 'Avbryt';

  @override
  String get resetPassword => 'Återställ lösenord';

  @override
  String get forgotPasswordTitle => 'Glömt lösenord';

  @override
  String get forgotPasswordDescription =>
      'Ange ditt medlemsnummer och återställningskoden som du skapade vid registreringen.';

  @override
  String get passwordResetSuccess =>
      'Lösenordet har återställts!\n\nDu kan nu logga in med ditt nya lösenord.';

  @override
  String get passwordResetFailed => 'Återställning av lösenord misslyckades';

  @override
  String get needHelp => 'Behöver du hjälp?';

  @override
  String get helpQuestion => 'Problem med inloggning eller registrering?';

  @override
  String get helpDescription =>
      'Kontakta oss via WhatsApp och beskriv vad som inte fungerar. Vi svarar så snart som möjligt!';

  @override
  String get whatsapp => 'WhatsApp';

  @override
  String get emailSubject => 'Förfrågan via ICD360S-appen';

  @override
  String get whatsappMessage => 'Hej, jag har ett problem med ICD360S-appen. ';

  @override
  String get imprint => 'Impressum';

  @override
  String get privacy => 'Integritetspolicy';

  @override
  String get statutes => 'Stadgar';

  @override
  String get revocation => 'Ångerrätt';

  @override
  String get cancellation => 'Uppsägning';

  @override
  String get allRightsReserved => 'Alla rättigheter förbehållna.';

  @override
  String get enterCredentials => 'Ange medlemsnummer och lösenord';

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
  String get membership => 'Medlemskap';

  @override
  String get myAppointments => 'Mina möten';

  @override
  String get appointmentsLoadingReady => 'Laddar möten - API redo!';

  @override
  String get priority => 'Prioritet';

  @override
  String get messageLabel => 'Meddelande';

  @override
  String get createdOn => 'Skapad';

  @override
  String get handler => 'Hanterare';

  @override
  String get reportProblems => 'Rapportera problem';

  @override
  String get reportProblem => 'Rapportera problem';

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
  String get newTicket => 'Nytt ärende';

  @override
  String get noOpenTickets => 'Inga öppna ärenden';

  @override
  String get haveQuestionCreateTicket =>
      'Har du en fråga eller problem?\nSkapa ett nytt ärende.';

  @override
  String get whatIsTheProblem => 'Vad är problemet?';

  @override
  String get describeTheProblem => 'Beskriv problemet';

  @override
  String get howUrgentIsIt => 'Hur brådskande är det?';

  @override
  String get low => 'Låg';

  @override
  String get medium => 'Medel';

  @override
  String get high => 'Hög';

  @override
  String get submit => 'Skicka';

  @override
  String get fillSubjectAndMessage => 'Vänligen fyll i ämne och meddelande';

  @override
  String get ticketCreated => 'Ärende skapat';

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
  String get newEmailAddress => 'Ny e-postadress';

  @override
  String get currentPassword => 'Nuvarande lösenord';

  @override
  String get saveEmail => 'Spara e-post';

  @override
  String get savePassword => 'Spara lösenord';

  @override
  String get deviceLoggedOut => 'Enheten utloggad';

  @override
  String get passwordChangedSuccessfully => 'Lösenord ändrat';

  @override
  String get emailChangedSuccessfully => 'E-post ändrad';

  @override
  String get errorChangingPassword => 'Fel vid ändring av lösenord';

  @override
  String get errorChangingEmail => 'Fel vid ändring av e-post';

  @override
  String get validEmailRequired => 'Vänligen ange en giltig e-postadress';

  @override
  String get passwordTooShort => 'Lösenordet måste vara minst 6 tecken';

  @override
  String get maxDevicesReached => 'Du är inloggad på maximalt 3 enheter.';

  @override
  String loggedInOnDevices(int count) {
    return 'Du är inloggad på $count av 3 enheter.';
  }

  @override
  String get noActiveSessions => 'Inga aktiva sessioner';

  @override
  String get logoutFromDevice => 'Logga ut från denna enhet';

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
  String get errorAcceptingCall => 'Fel vid acceptering av samtal';

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
  String typingIndicator(String name) {
    return '$name skriver...';
  }

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
  String get diagnosticDataTitle => 'Diagnostikdata';

  @override
  String get diagnosticDescription =>
      'Vill du skicka anonym diagnostikdata för att förbättra appen?';

  @override
  String get noThanks => 'Nej tack';

  @override
  String get yesEnable => 'Ja, aktivera';

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
  String get newPasswordMinChars => 'Nytt lösenord (min. 6 tecken)';

  @override
  String get reasonLabel2 => 'Anledning';

  @override
  String get downloadFailed2 => 'Nedladdning misslyckades';

  @override
  String get downloadTooltip => 'Ladda ner';

  @override
  String get connectionErrorGeneric => 'Anslutningsfel';

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
  String get bankTransfer => 'Banköverföring';

  @override
  String get standingOrder => 'Stående överföring';

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
  String get memberNumberTooLong => 'Medlemsnummer för långt (max 20 tecken)';

  @override
  String get onlyUppercaseAndNumbers => 'Endast versaler och siffror tillåtna';

  @override
  String get passwordTooLong => 'Lösenord för långt (max 100 tecken)';

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
  String get diagnosticErrors => 'Felrapporter för förbättring';

  @override
  String get diagnosticAnonymousStats => 'Anonym användningsstatistik';

  @override
  String get diagnosticPerformance => 'Appprestandadata';

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
  String get ipClean => 'IP ren - inte listad';

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
  String get helpImproveApp => 'Vill du hjälpa oss att förbättra appen?';

  @override
  String get noPersonalDataCollected =>
      'Inga personuppgifter samlas in. Denna inställning kan ändras när som helst.';

  @override
  String logEntries(int count) {
    return '$count poster';
  }

  @override
  String get noLogs => 'Inga loggar';

  @override
  String get newLoginDetected => 'Ny inloggning upptäckt';

  @override
  String get waitingForMember => 'Väntar på medlem';

  @override
  String get waitingForStaff => 'Väntar på personal';

  @override
  String get waitingForAuthority => 'Väntar på myndighet';
}
