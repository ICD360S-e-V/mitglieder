// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Norwegian Bokmål (`nb`).
class AppLocalizationsNb extends AppLocalizations {
  AppLocalizationsNb([String locale = 'nb']) : super(locale);

  @override
  String get appTitle => 'ICD360S e.V - Medlemsportal';

  @override
  String get memberPortal => 'Medlemsportal';

  @override
  String get welcomeLoading => 'Laster...';

  @override
  String get welcomeAutoLogin => 'Automatisk innlogging...';

  @override
  String get login => 'Logg inn';

  @override
  String get register => 'Registrer';

  @override
  String get becomeMember => 'Bli medlem';

  @override
  String get memberNumber => 'Medlemsnummer';

  @override
  String get memberNumberHint => 'Skriv inn medlemsnummer';

  @override
  String get password => 'Passord';

  @override
  String get passwordHint => 'Skriv inn passord';

  @override
  String get confirmPassword => 'Bekreft passord';

  @override
  String get confirmPasswordHint => 'Bekreft passord';

  @override
  String get newPassword => 'Nytt passord';

  @override
  String get newPasswordHint => 'Skriv inn nytt passord';

  @override
  String get saveCredentials => 'Lagre påloggingsinformasjon';

  @override
  String get autoLogin => 'Automatisk innlogging';

  @override
  String get forgotPassword => 'Glemt passord?';

  @override
  String get firstName => 'Fornavn og etternavn';

  @override
  String get firstNameHint => 'Skriv inn for- og etternavn';

  @override
  String get nameMinLength => 'Navnet må ha minst 2 tegn';

  @override
  String get nameOnlyLetters => 'Kun bokstaver og bindestreker tillatt';

  @override
  String get email => 'E-postadresse';

  @override
  String get emailHint => 'Skriv inn e-post';

  @override
  String get emailInvalid => 'Skriv inn en gyldig e-postadresse';

  @override
  String get passwordMinLength => 'Passordet må ha minst 6 tegn';

  @override
  String get passwordsNotMatch => 'Passordene stemmer ikke overens';

  @override
  String get recoveryCode => 'Gjenopprettingskode (6 sifre)';

  @override
  String get recoveryCodeHelper => 'Husk denne koden for passordgjenoppretting';

  @override
  String get recoveryCodeHint => 'Skriv inn gjenopprettingskode';

  @override
  String get recoveryCodeInvalid => 'Koden må ha nøyaktig 6 sifre';

  @override
  String get loginFailed => 'Innlogging mislyktes';

  @override
  String get registrationFailed => 'Registrering mislyktes';

  @override
  String connectionError(String error) {
    return 'Tilkoblingsfeil: $error';
  }

  @override
  String registrationSuccess(String memberNumber) {
    return 'Registrering vellykket!\n\nDitt medlemsnummer: $memberNumber\n\nHusk dette nummeret for innlogging.';
  }

  @override
  String get tooManyDevices => 'For mange enheter';

  @override
  String get maxDevicesMessage =>
      'Du er allerede logget inn på 3 enheter.\nVelg en enhet å logge ut fra:';

  @override
  String get unknownDevice => 'Ukjent enhet';

  @override
  String get unknown => 'Ukjent';

  @override
  String get logoutError => 'Utloggingsfeil';

  @override
  String error(String error) {
    return 'Feil: $error';
  }

  @override
  String get cancel => 'Avbryt';

  @override
  String get resetPassword => 'Tilbakestill passord';

  @override
  String get forgotPasswordTitle => 'Glemt passord';

  @override
  String get forgotPasswordDescription =>
      'Skriv inn medlemsnummeret ditt og gjenopprettingskoden du opprettet ved registrering.';

  @override
  String get passwordResetSuccess =>
      'Passord tilbakestilt!\n\nDu kan nå logge inn med ditt nye passord.';

  @override
  String get passwordResetFailed => 'Tilbakestilling av passord mislyktes';

  @override
  String get needHelp => 'Trenger du hjelp?';

  @override
  String get helpQuestion => 'Problemer med innlogging eller registrering?';

  @override
  String get helpDescription =>
      'Kontakt oss via WhatsApp og beskriv hva som ikke fungerer. Vi svarer så snart som mulig!';

  @override
  String get whatsapp => 'WhatsApp';

  @override
  String get emailSubject => 'Henvendelse via ICD360S-appen';

  @override
  String get whatsappMessage => 'Hei, jeg har et problem med ICD360S-appen. ';

  @override
  String get imprint => 'Impressum';

  @override
  String get privacy => 'Personvernpolicy';

  @override
  String get statutes => 'Vedtekter';

  @override
  String get revocation => 'Angrerett';

  @override
  String get cancellation => 'Oppsigelse';

  @override
  String get allRightsReserved => 'Alle rettigheter forbeholdt.';

  @override
  String get enterCredentials => 'Skriv inn medlemsnummer og passord';

  @override
  String get appointments => 'Avtaler';

  @override
  String get tickets => 'Saker';

  @override
  String get liveChat => 'Live Chat';

  @override
  String get notifications => 'Varsler';

  @override
  String get myProfile => 'Min Profil';

  @override
  String get logout => 'Logg ut';

  @override
  String get goodMorning => 'God morgen';

  @override
  String get goodDay => 'God dag';

  @override
  String get goodEvening => 'God kveld';

  @override
  String get goodNight => 'God natt';

  @override
  String get welcomeToICD => 'Velkommen til ICD360S e.V!';

  @override
  String get accountCreatedSuccessfully => 'Kontoen din er opprettet.';

  @override
  String get today => 'I dag';

  @override
  String get membershipFeeDue => 'Medlemskontingent forfaller';

  @override
  String get pleaseTransferAnnualFee => 'Vennligst overfør årlig kontingent.';

  @override
  String get newBadge => 'Ny';

  @override
  String get close => 'Lukk';

  @override
  String get membership => 'Medlemskap';

  @override
  String get myAppointments => 'Mine avtaler';

  @override
  String get appointmentsLoadingReady => 'Laster avtaler - API klar!';

  @override
  String get priority => 'Prioritet';

  @override
  String get messageLabel => 'Melding';

  @override
  String get createdOn => 'Opprettet';

  @override
  String get handler => 'Behandler';

  @override
  String get reportProblems => 'Rapporter problemer';

  @override
  String get reportProblem => 'Rapporter problem';

  @override
  String get weRespondIn24Hours => 'Vi svarer deg innen maksimalt 24 timer!';

  @override
  String get everythingOk => 'Alt OK!';

  @override
  String get haveProblemWeHelp => 'Har du et problem?\nVi tar oss av det!';

  @override
  String get myMembership => 'Mitt medlemskap';

  @override
  String get managePersonalDataAndFee =>
      'Administrer personlige data og kontingent';

  @override
  String get myAppointmentsTitle => 'Mine avtaler';

  @override
  String get appointmentsDescription =>
      'Her kan du se dine kommende avtaler.\nDu kan bekrefte din deltakelse eller avslå.';

  @override
  String get loadAppointments => 'Last inn avtaler';

  @override
  String get myTickets => 'Mine saker';

  @override
  String get newTicket => 'Ny sak';

  @override
  String get noOpenTickets => 'Ingen åpne saker';

  @override
  String get haveQuestionCreateTicket =>
      'Har du et spørsmål eller problem?\nOpprett en ny sak.';

  @override
  String get whatIsTheProblem => 'Hva er problemet?';

  @override
  String get describeTheProblem => 'Beskriv problemet';

  @override
  String get howUrgentIsIt => 'Hvor hastende er det?';

  @override
  String get low => 'Lav';

  @override
  String get medium => 'Middels';

  @override
  String get high => 'Høy';

  @override
  String get submit => 'Send inn';

  @override
  String get fillSubjectAndMessage => 'Fyll ut emne og melding';

  @override
  String get ticketCreated => 'Sak opprettet';

  @override
  String get errorCreatingTicket => 'Feil ved oppretting av sak';

  @override
  String get verified => 'Verifisert';

  @override
  String get account => 'Konto';

  @override
  String get myDevices => 'Mine enheter';

  @override
  String get changeEmail => 'Endre e-post';

  @override
  String get changePassword => 'Endre passord';

  @override
  String get newEmailAddress => 'Ny e-postadresse';

  @override
  String get currentPassword => 'Nåværende passord';

  @override
  String get saveEmail => 'Lagre e-post';

  @override
  String get savePassword => 'Lagre passord';

  @override
  String get deviceLoggedOut => 'Enhet logget ut';

  @override
  String get passwordChangedSuccessfully => 'Passord endret';

  @override
  String get emailChangedSuccessfully => 'E-post endret';

  @override
  String get errorChangingPassword => 'Feil ved endring av passord';

  @override
  String get errorChangingEmail => 'Feil ved endring av e-post';

  @override
  String get validEmailRequired =>
      'Vennligst skriv inn en gyldig e-postadresse';

  @override
  String get passwordTooShort => 'Passordet må være minst 6 tegn';

  @override
  String get maxDevicesReached => 'Du er logget inn på maksimalt 3 enheter.';

  @override
  String loggedInOnDevices(int count) {
    return 'Du er logget inn på $count av 3 enheter.';
  }

  @override
  String get noActiveSessions => 'Ingen aktive økter';

  @override
  String get logoutFromDevice => 'Logg ut fra denne enheten';

  @override
  String get confirmLogoutDevice => 'Logge ut enhet?';

  @override
  String get confirmLogoutMessage =>
      'Vil du logge ut fra denne enheten?\n\nDu må logge inn igjen for å bruke denne enheten.';

  @override
  String get ipAddress => 'IP';

  @override
  String get platform => 'Plattform';

  @override
  String trialWarningUrgentTitle(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days dager',
      one: '1 dag',
    );
    return 'Advarsel: Bare $_temp0 igjen til kontosuspensjon!';
  }

  @override
  String get trialWarningTitle => 'Kontoen din er ikke verifisert ennå';

  @override
  String get trialWarningDescription =>
      'Vennligst fyll ut opplysningene dine i \"Min profil\". Etter 30 dager vil kontoen din automatisk bli suspendert.';

  @override
  String trialDaysRemaining(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days dager',
      one: '1 dag',
    );
    return '$_temp0';
  }

  @override
  String get overview => 'Oversikt';

  @override
  String get member => 'Medlem';

  @override
  String get memberManagement => 'Medlemsadministrasjon';

  @override
  String get reportProblemTooltip => 'Rapporter problem';

  @override
  String get newAppointmentsTitle => 'Nye avtaler';

  @override
  String get youHaveNewAppointment => 'Du har en ny avtale.';

  @override
  String youHaveNewAppointments(int count) {
    return 'Du har $count nye avtaler.';
  }

  @override
  String get appointmentReminderTomorrow => 'Påminnelse: Avtale i morgen';

  @override
  String tomorrowAppointment(String title) {
    return 'I morgen: $title';
  }

  @override
  String youHaveTomorrowAppointments(int count) {
    return 'Du har $count avtaler i morgen.';
  }

  @override
  String get appointmentsToday => 'Avtaler i dag';

  @override
  String todayAppointment(String title) {
    return 'I dag: $title';
  }

  @override
  String youHaveTodayAppointments(int count) {
    return 'Du har $count avtaler i dag.';
  }

  @override
  String get paymentReminder => 'Betalingspåminnelse';

  @override
  String paymentReminderMessage(int day, String method) {
    return 'I dag er den $day. i måneden – vennligst fullfør $method.';
  }

  @override
  String get paymentDayLabel => 'Betalingsdag (månedlig påminnelse)';

  @override
  String get updateAvailable => 'Oppdatering tilgjengelig';

  @override
  String newVersionAvailable(String version) {
    return 'En ny versjon er tilgjengelig: $version';
  }

  @override
  String currentVersionLabel(String version) {
    return 'Nåværende versjon: $version';
  }

  @override
  String get changes => 'Endringer:';

  @override
  String downloadProgress(String percent) {
    return 'Nedlasting: $percent%';
  }

  @override
  String get installationStarting => 'Installasjon starter...';

  @override
  String get appWillRestart => 'Appen startes automatisk på nytt.';

  @override
  String get later => 'Senere';

  @override
  String get updateNow => 'Oppdater nå';

  @override
  String get downloading => 'Laster ned...';

  @override
  String get downloadFailed => 'Nedlasting mislyktes. Prøv igjen senere.';

  @override
  String get searchingForUpdates => 'Søker etter oppdateringer...';

  @override
  String get appUpToDate => 'Appen er oppdatert';

  @override
  String get updateCheckError => 'Feil ved søk etter oppdateringer';

  @override
  String get changelog => 'Endringslogg';

  @override
  String get terminConfirmed => 'Avtale bekreftet';

  @override
  String get terminDeclined => 'Avtale avvist';

  @override
  String get terminRescheduleRequested => 'Flytting forespurt';

  @override
  String get statusConfirmed => 'Bekreftet';

  @override
  String get statusDeclined => 'Avvist';

  @override
  String get statusRescheduling => 'Flytting';

  @override
  String get statusPending => 'Venter';

  @override
  String get categoryVorstandssitzung => 'Styremøte';

  @override
  String get categoryMitgliederversammlung => 'Generalforsamling';

  @override
  String get categorySchulung => 'Opplæring';

  @override
  String get categorySonstiges => 'Annet';

  @override
  String openCount(int count) {
    return '$count åpne';
  }

  @override
  String get refresh => 'Oppdater';

  @override
  String get filterUpcoming => 'Kommende';

  @override
  String get filterPast => 'Tidligere';

  @override
  String get filterAll => 'Alle';

  @override
  String get noUpcomingAppointments => 'Ingen kommende avtaler';

  @override
  String get noPastAppointments => 'Ingen tidligere avtaler';

  @override
  String get noAppointmentsAvailable => 'Ingen avtaler';

  @override
  String get appointmentsShownHere => 'Avtalene dine vises her';

  @override
  String get dateLabel => 'Dato';

  @override
  String get timeLabel => 'Tid';

  @override
  String get locationLabel => 'Sted';

  @override
  String get createdByLabel => 'Opprettet av';

  @override
  String get descriptionLabel => 'Beskrivelse';

  @override
  String get ticketLabel => 'Sak';

  @override
  String get yourStatus => 'Din status: ';

  @override
  String reasonLabel(String reason) {
    return 'Grunn: $reason';
  }

  @override
  String durationMinutes(int minutes) {
    return '$minutes min';
  }

  @override
  String get confirm => 'Bekreft';

  @override
  String get decline => 'Avvis';

  @override
  String get reschedule => 'Flytt';

  @override
  String get requestReschedule => 'Be om flytting';

  @override
  String appointmentLabel(String title) {
    return 'Avtale: $title';
  }

  @override
  String get rescheduleReason => 'Grunn til flytting *';

  @override
  String get rescheduleReasonHint => 'Oppgi en grunn...';

  @override
  String get pleaseProvideReason => 'Oppgi en grunn';

  @override
  String get request => 'Be om';

  @override
  String get ticketStatusOpen => 'Åpen';

  @override
  String get ticketStatusInProgress => 'Under behandling';

  @override
  String get ticketStatusWaitingMember => 'Venter på medlem';

  @override
  String get ticketStatusWaitingStaff => 'Venter på ansatt';

  @override
  String get ticketStatusWaitingAuthority => 'Venter på myndighet';

  @override
  String get ticketStatusDone => 'Fullført';

  @override
  String get ticketPriorityHigh => 'Høy';

  @override
  String get ticketPriorityMedium => 'Middels';

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
  String get sendError => 'Feil ved sending';

  @override
  String get uploading => 'Laster opp...';

  @override
  String fileUploaded(String filename) {
    return '$filename lastet opp';
  }

  @override
  String get uploadFailed => 'Opplasting mislyktes';

  @override
  String get openError => 'Feil ved åpning';

  @override
  String get noRepliesYet => 'Ingen svar ennå';

  @override
  String get waitingForSupport => 'Venter på svar fra support';

  @override
  String get writeReply => 'Skriv et svar...';

  @override
  String get attachFile => 'Legg ved fil';

  @override
  String documentsCount(int count) {
    return 'Dokumenter ($count)';
  }

  @override
  String get upload => 'Last opp';

  @override
  String get noDocuments => 'Ingen dokumenter';

  @override
  String get allowedFormats => 'Tillatte formater: PDF, JPEG, JPG, TXT, ZIP';

  @override
  String get yourMessage => 'Din melding:';

  @override
  String get translation => 'Oversettelse';

  @override
  String get original => 'Original';

  @override
  String get originalText => 'Originaltekst';

  @override
  String get autoTranslated => 'Automatisk oversatt';

  @override
  String get originalTapTranslation => 'Original · Trykk for oversettelse';

  @override
  String get translatedTapOriginal => 'Oversatt · Trykk for original';

  @override
  String get justNow => 'Akkurat nå';

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
      other: 'dager',
      one: 'dag',
    );
    return '$days $_temp0 siden';
  }

  @override
  String get createdLabel => 'Opprettet';

  @override
  String get updatedLabel => 'Oppdatert';

  @override
  String get handlerLabel => 'Saksbehandler';

  @override
  String get doneLabel => 'Fullført';

  @override
  String get newTicketTitle => 'Ny sak';

  @override
  String get categoryOptional => 'Kategori (valgfri)';

  @override
  String get selectCategory => 'Velg';

  @override
  String get subjectLabel => 'Emne';

  @override
  String get fillAllFields => 'Fyll ut alle felt';

  @override
  String ticketCreatedId(int id) {
    return 'Sak #$id opprettet';
  }

  @override
  String get priorityLabel => 'Prioritet: ';

  @override
  String get supportOffline => 'Support frakoblet';

  @override
  String get lastSeenSeconds => 'Aktiv for noen sekunder siden';

  @override
  String lastSeenMinutes(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: 'minutter',
      one: 'minutt',
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
      other: 'dager',
      one: 'dag',
    );
    return 'Aktiv for $days $_temp0 siden';
  }

  @override
  String get online => 'Pålogget';

  @override
  String get callSupport => 'Ring';

  @override
  String get typeMessage => 'Skriv en melding...';

  @override
  String get callBusy => 'Support er opptatt';

  @override
  String get callRejected => 'Anrop avvist';

  @override
  String get callFailed => 'Anrop kunne ikke kobles';

  @override
  String get callEnded => 'Anrop avsluttet';

  @override
  String get callSupportBusy => 'Support er allerede i et annet anrop';

  @override
  String get errorStartingChat => 'Feil ved start av chat';

  @override
  String get errorStartingCall => 'Feil ved start av anrop';

  @override
  String get errorConnecting => 'Tilkoblingsfeil';

  @override
  String get errorAcceptingCall => 'Feil ved aksept av anrop';

  @override
  String get errorDownloading => 'Nedlastingsfeil';

  @override
  String get errorUploading => 'Opplastingsfeil';

  @override
  String get errorSending => 'Sendefeil';

  @override
  String get errorPickingPhotos => 'Feil ved valg av bilder';

  @override
  String get errorPickingFiles => 'Feil ved valg av filer';

  @override
  String get errorTakingPhoto => 'Feil ved fotografering';

  @override
  String get fileNotLoaded => 'Filen kunne ikke lastes';

  @override
  String get attachmentIdMissing => 'Vedleggs-ID mangler';

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
  String get notifNewMessageFrom => 'Ny melding fra';

  @override
  String get notifUrgentPrefix => 'HASTER';

  @override
  String get notifUrgentMessage => 'HASTEMELDING';

  @override
  String get notifIncomingCall => 'Innkommende anrop';

  @override
  String get notifCallingYou => 'ringer...';

  @override
  String get notifUpdateAvailable => 'Oppdatering tilgjengelig';

  @override
  String get notifVersionAvailable => 'er nå tilgjengelig';

  @override
  String get notifConnected => 'Tilkoblet';

  @override
  String get notifDisconnected => 'Frakoblet';

  @override
  String get notifConnectedBody => 'Du er nå koblet til serveren.';

  @override
  String get notifDisconnectedBody => 'Tilkoblingen til serveren ble brutt.';

  @override
  String get notifError => 'Feil';

  @override
  String get retry => 'Prøv igjen';

  @override
  String get save => 'Lagre';

  @override
  String get accept => 'Aksepter';

  @override
  String get selectFile => 'Velg fil';

  @override
  String get dataLoadingText => 'Laster data...';

  @override
  String get dataSavedSuccess => 'Data lagret';

  @override
  String get errorSaving => 'Feil ved lagring';

  @override
  String get errorLoading => 'Feil ved lasting';

  @override
  String savedFilename(String filename) {
    return 'Lagret: $filename';
  }

  @override
  String get logsCopied => 'Logger kopiert!';

  @override
  String get diagnosticDataTitle => 'Diagnostikkdata';

  @override
  String get diagnosticDescription =>
      'Vil du sende anonyme diagnostikkdata for å forbedre appen?';

  @override
  String get noThanks => 'Nei takk';

  @override
  String get yesEnable => 'Ja, aktiver';

  @override
  String get passwordMinEightChars => 'Passordet må være minst 8 tegn';

  @override
  String get passwordChangeSuccess => 'Passord endret';

  @override
  String get emailChangeError => 'Feil ved endring av e-post';

  @override
  String get acceptDocumentCheckbox => 'Jeg har lest og godtar dokumentet.';

  @override
  String loadingErrorGeneric(String details) {
    return 'Lastefeil: $details';
  }

  @override
  String get incomingCallTitle => 'Innkommende anrop';

  @override
  String ringingFor(int seconds) {
    return 'Ringer i ${seconds}s';
  }

  @override
  String get rejectCall => 'Avvis';

  @override
  String get acceptCall => 'Svar';

  @override
  String get unmute => 'Slå på lyd';

  @override
  String get mute => 'Slå av lyd';

  @override
  String get hangUp => 'Legg på';

  @override
  String get calling => 'Ringer...';

  @override
  String autoRejectIn(int seconds) {
    return 'Automatisk avvisning om $seconds sekunder';
  }

  @override
  String get speakerOn => 'Høyttaler';

  @override
  String get speakerOff => 'Ørestykke';

  @override
  String get micMuted => 'Dempet';

  @override
  String get micOn => 'Mikrofon';

  @override
  String get connectionExcellent => 'Utmerket';

  @override
  String get connectionGood => 'God';

  @override
  String get connectionWeak => 'Svak';

  @override
  String get connectionLost => 'Frakoblet';

  @override
  String get personalData => 'Personopplysninger';

  @override
  String get personalDataSubtitle => 'Fornavn, etternavn, adresse';

  @override
  String get membershipFee => 'Medlemsavgift';

  @override
  String annualFeeYear(String year) {
    return 'Årsavgift $year';
  }

  @override
  String get amount => 'Beløp:';

  @override
  String get dueBy => 'Forfaller:';

  @override
  String get paid => 'Betalt';

  @override
  String get versionHistory => 'Versjonshistorikk';

  @override
  String lastUpdated(String date) {
    return 'Sist oppdatert: $date';
  }

  @override
  String get noVersionHistory => 'Ingen versjonshistorikk tilgjengelig';

  @override
  String get failedLoadChangelog => 'Kunne ikke laste endringslogg';

  @override
  String get callMember => 'Ring medlem';

  @override
  String get closeConversation => 'Lukk samtale';

  @override
  String get chatOffline => 'Frakoblet';

  @override
  String get attachFiles => 'Legg ved filer (maks. 10, 50MB)';

  @override
  String get conversationClosed => 'Denne samtalen er lukket';

  @override
  String get noMessages => 'Ingen meldinger';

  @override
  String get goBack => 'Tilbake';

  @override
  String get goForward => 'Fremover';

  @override
  String get homePage => 'Hjem';

  @override
  String get firstNameLabel => 'Fornavn';

  @override
  String get lastNameLabel => 'Etternavn';

  @override
  String get streetLabel => 'Gate';

  @override
  String get houseNumberLabel => 'Nr.';

  @override
  String get postalCodeLabel => 'Postnummer';

  @override
  String get cityLabel => 'By';

  @override
  String get phoneMobileLabel => 'Telefon (Mobil)';

  @override
  String get phoneLandlineLabel => 'Telefon (Fasttelefon)';

  @override
  String get newEmailLabel => 'Ny e-postadresse';

  @override
  String get currentPasswordLabel => 'Nåværende passord';

  @override
  String get newPasswordLabel => 'Nytt passord';

  @override
  String get confirmPasswordLabel => 'Bekreft passord';

  @override
  String get emailChangedSuccess => 'E-post endret';

  @override
  String get newPasswordMinChars => 'Nytt passord (min. 6 tegn)';

  @override
  String get reasonLabel2 => 'Årsak';

  @override
  String get downloadFailed2 => 'Nedlasting mislyktes';

  @override
  String get downloadTooltip => 'Last ned';

  @override
  String get connectionErrorGeneric => 'Tilkoblingsfeil';

  @override
  String get errorNoInternet => 'Ingen internettforbindelse. Vennligst sjekk nettverket ditt.';

  @override
  String get errorTimeout => 'Serveren svarer ikke. Vennligst prøv igjen senere.';

  @override
  String get errorServer => 'Serverfeil. Vennligst prøv igjen senere.';

  @override
  String get errorConnection => 'Tilkoblingsfeil. Vennligst prøv igjen senere.';

  @override
  String get errorUnexpected => 'En uventet feil oppstod. Vennligst prøv igjen senere.';

  @override
  String get copyLogs => 'Kopier logger';

  @override
  String get deleteLogs => 'Slett logger';

  @override
  String get autoScrollOn => 'Automatisk rulling PÅ';

  @override
  String get autoScrollOff => 'Automatisk rulling AV';

  @override
  String get unknownValue => 'Ukjent';

  @override
  String get bankTransfer => 'Bankoverføring';

  @override
  String get standingOrder => 'Fast overføring';

  @override
  String get payment => 'Betaling';

  @override
  String get warningType_ermahnung => 'Advarsel';

  @override
  String get warningType_abmahnung => 'Påminnelse';

  @override
  String get warningType_letzte => 'Siste advarsel';

  @override
  String warningsTotal(int count) {
    return 'Totalt: $count';
  }

  @override
  String warningsErmahnung(int count) {
    return 'Advarsler: $count';
  }

  @override
  String warningsAbmahnung(int count) {
    return 'Påminnelser: $count';
  }

  @override
  String warningsLetzte(int count) {
    return 'Siste: $count';
  }

  @override
  String get noWarnings => 'Ingen advarsler';

  @override
  String get noWarningsDescription => 'Du har ingen advarsler for øyeblikket.';

  @override
  String createdBy(String name) {
    return 'Opprettet av: $name';
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
  String get monthDec => 'Des';

  @override
  String get stufe1_name => 'Personopplysninger';

  @override
  String get stufe2_name => 'Medlemstype';

  @override
  String get stufe3_name => 'Økonomisk situasjon';

  @override
  String get stufe4_name => 'Betalingsmetode';

  @override
  String get stufe5_name => 'Medlemskapets start';

  @override
  String get stufe6_name => 'Vedtekter';

  @override
  String get stufe7_name => 'Personvernerklæring';

  @override
  String get stufe8_name => 'Angrerett';

  @override
  String get memberType_ordentlich => 'Ordinært medlem';

  @override
  String get memberType_foerder => 'Støttemedlem';

  @override
  String get memberType_ehren => 'Æresmedlem';

  @override
  String get memberDesc_ordentlich =>
      'Aktivt medlem med stemmerett. Deltar i foreningens tjenester (e-post, sky, byråkratisk støtte).';

  @override
  String get memberDesc_foerder =>
      'Støtter foreningen med bidrag. Kan delta på generalforsamlingen med rådgivende stemme, uten stemmerett eller valgbarhet til styret.';

  @override
  String get memberDesc_ehren =>
      'Har rettighetene til et ordinært medlem uten plikt til å betale medlemsavgift. Utnevnt av generalforsamlingen eller styret.';

  @override
  String get payMethod_ueberweisung => 'Bankoverføring';

  @override
  String get payMethod_dauerauftrag => 'Fast overføring';

  @override
  String get verifyStatus_geprueft => 'Verifisert';

  @override
  String get verifyStatus_ausgefuellt => 'Utfylt';

  @override
  String get verifyStatus_abgelehnt => 'Avvist';

  @override
  String get verifyStatus_offen => 'Åpen';

  @override
  String get fillRequiredFields => 'Fyll ut alle obligatoriske felt.';

  @override
  String get personalDataSaved => 'Personopplysninger lagret';

  @override
  String get selectMemberType => 'Velg en medlemstype.';

  @override
  String get memberTypeSaved => 'Medlemstype lagret';

  @override
  String get selectOption => 'Velg et alternativ.';

  @override
  String get financialSaved => 'Økonomisk situasjon lagret';

  @override
  String get selectPaymentMethod => 'Velg en betalingsmetode.';

  @override
  String get paymentDataSaved => 'Betalingsdata lagret';

  @override
  String get selectDate => 'Velg en dato.';

  @override
  String get membershipStartSaved => 'Medlemskapets start lagret';

  @override
  String get fileTooLarge => 'Filen er for stor (maks. 10 MB).';

  @override
  String get leistungsbescheidUploaded => 'Ytelsesvedtak lastet opp';

  @override
  String get verificationProgress => 'Verifiseringsfremdrift';

  @override
  String get notApplicable => 'Ikke aktuelt';

  @override
  String get socialBenefitsExempt =>
      'Betalingsmetode er ikke påkrevd for mottakere av sosiale ytelser.';

  @override
  String get locked => 'Låst';

  @override
  String completePreviousStep(int step) {
    return 'Fullfør steg $step først.';
  }

  @override
  String rejectedNote(String note) {
    return 'Avvist: $note';
  }

  @override
  String get waitingForReview => 'Venter på gjennomgang av styret.';

  @override
  String get stepApproved => 'Dette steget er gjennomgått og godkjent.';

  @override
  String get changesViaChat => 'Endringer kun mulig via chat.';

  @override
  String get firstNameRequired => 'Fornavn *';

  @override
  String get lastNameRequired => 'Etternavn *';

  @override
  String get birthDateLabel => 'Fødselsdato *';

  @override
  String get streetRequired => 'Gate *';

  @override
  String get houseNumberRequired => 'Nr. *';

  @override
  String get cityRequired => 'By *';

  @override
  String get phoneRequired => 'Telefonnummer *';

  @override
  String get phonePurpose => 'Formål: Kontakt når ikke tilgjengelig via appen';

  @override
  String get selectMemberTypePrompt => 'Velg ønsket medlemstype:';

  @override
  String get financialExplanation =>
      'For å sjekke om du har rett til redusert avgift, trenger vi følgende informasjon. Den brukes utelukkende til å fastsette din medlemsavgift.';

  @override
  String get socialBenefitsQuestion => 'Mottar du for tiden sosiale ytelser?';

  @override
  String get optionBuergergeld => 'Ja, borgerytelse (Job Center)';

  @override
  String get optionSozialamt => 'Ja, sosialhjelp (Sosialkontoret)';

  @override
  String get optionNoBenefits => 'Nei, jeg mottar ikke sosiale ytelser';

  @override
  String get feeExempt => 'Din månedlige avgift er: 0,00 €/måned';

  @override
  String get uploadLeistungsbescheid => 'Last opp ytelsesvedtak';

  @override
  String get uploadLeistungsbescheidHint =>
      'Last opp et gjeldende ytelsesvedtak innen 14 dager for å bekrefte avgiftsfritaket.';

  @override
  String get allowedFormatsUpload =>
      'Tillatte formater: PDF, JPG, PNG (maks. 10 MB)';

  @override
  String get feeRegular => 'Din månedlige avgift er: 25,00 €/måned';

  @override
  String paymentDayReminder(int day) {
    return 'Du vil bli påminnet den $day. hver måned.';
  }

  @override
  String get membershipStartPrompt => 'Velg når medlemskapet ditt skal starte.';

  @override
  String get optionAfterVerification => 'Etter fullført verifisering';

  @override
  String get optionAfterVerificationDesc =>
      'Medlemskapet begynner fra dagen for styrets bekreftelse.';

  @override
  String get optionRetroFoundation =>
      'Tilbakevirkende til stiftelsesdatoen (01.08.2025)';

  @override
  String get optionRetroFoundationDesc =>
      'Du blir tilbakevirkende medlem fra foreningens stiftelse.';

  @override
  String get optionRetroCustom => 'Tilbakevirkende til en annen dato';

  @override
  String get optionRetroCustomDesc =>
      'Velg en dato mellom 01.08.2025 og i dag.';

  @override
  String get selectDateLabel => 'Velg dato';

  @override
  String get selectDateHint => 'Velg dato...';

  @override
  String get dateNotBefore => 'Ikke før 01.08.2025 (stiftelsesdato)';

  @override
  String get feeExemptRetro =>
      'Avgiftsfritak: 0,00 € tilbakevirkende.\nKun medlemskapsdatoen settes tilbakevirkende.';

  @override
  String get retroactiveFees => 'Tilbakevirkende avgifter';

  @override
  String retroFeeCalculation(
      String from, String to, String months, String total) {
    return 'Periode: $from – $to\nMåneder: $months\nAvgift: $months × 25,00 € = $total €';
  }

  @override
  String get pleaseReadSatzung => 'Les foreningens vedtekter.';

  @override
  String get pleaseReadDatenschutz => 'Les personvernerklæringen.';

  @override
  String get pleaseReadWiderruf => 'Les angreretten.';

  @override
  String get acceptedAtRegistration => 'Akseptert ved registrering';

  @override
  String get confirmedByBoard => 'Bekreftes etter styrets gjennomgang.';

  @override
  String get docSatzung => 'Vedtekter';

  @override
  String get docDatenschutz => 'Personvernerklæring';

  @override
  String get docWiderruf => 'Angrerett';

  @override
  String acceptedAtRegCount(int count) {
    return 'Akseptert ved registrering ($count/3)';
  }

  @override
  String acceptedOn(String date) {
    return 'Akseptert den $date';
  }

  @override
  String get notAccepted => 'Ikke akseptert';

  @override
  String get statusAccepted => 'Akseptert';

  @override
  String get memberNumberTooLong => 'Medlemsnummer for langt (maks. 20 tegn)';

  @override
  String get onlyUppercaseAndNumbers =>
      'Kun store bokstaver og tall er tillatt';

  @override
  String get passwordTooLong => 'Passord for langt (maks. 100 tegn)';

  @override
  String get nameTooLong => 'Navn for langt (maks. 100 tegn)';

  @override
  String get emailTooLong => 'E-post for lang (maks. 255 tegn)';

  @override
  String get legalAcknowledgePrefix => 'Jeg har lest ';

  @override
  String get legalAcknowledgeSuffix => '.';

  @override
  String get legalStatutesSuffix =>
      ' for ICD360S e.V. og anerkjenner dem som bindende.';

  @override
  String get legalPleaseReadFirst => '(vennligst les først)';

  @override
  String get statusActive => 'Aktiv';

  @override
  String get statusSuspended => 'Suspendert';

  @override
  String get statusNew => 'Ny';

  @override
  String get statusCancelled => 'Oppsagt';

  @override
  String get statusDeleted => 'Slettet';

  @override
  String get roleMitglied => 'Medlem';

  @override
  String get roleVorsitzer => 'Leder';

  @override
  String get roleStellvertreter => 'Stedfortreder';

  @override
  String get roleSchatzmeister => 'Kasserer';

  @override
  String get roleSchriftfuehrer => 'Sekretær';

  @override
  String get roleBeisitzer => 'Bisitter';

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
  String get memberTypeNotSet => 'Ennå ikke fastsatt';

  @override
  String get payMethodSepa => 'SEPA-avtalegiro';

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
  String get labelRegisteredOn => 'Registrert den';

  @override
  String get labelLastLogin => 'Siste innlogging';

  @override
  String get labelMemberSince => 'Medlem siden';

  @override
  String get neverLoggedIn => 'Aldri';

  @override
  String get notActivatedYet => 'Ennå ikke aktivert';

  @override
  String get tabVerification => 'Verifisering';

  @override
  String get tabWarnings => 'Advarsler';

  @override
  String get tabDocuments => 'Dokumenter';

  @override
  String get tabMembership => 'Medlemskap';

  @override
  String get pleaseEnterFirstName => 'Skriv inn fornavn';

  @override
  String get pleaseEnterLastName => 'Skriv inn etternavn';

  @override
  String get noFileDataReceived => 'Ingen data mottatt';

  @override
  String get openFile => 'Åpne';

  @override
  String get diagnosticErrors => 'Feilrapporter for forbedring';

  @override
  String get diagnosticAnonymousStats => 'Anonym bruksstatistikk';

  @override
  String get diagnosticPerformance => 'App-ytelsesdata';

  @override
  String get noMicrophoneError =>
      'Ingen mikrofon funnet. Koble til en mikrofon og prøv igjen.';

  @override
  String get startConversation => 'Start en samtale!';

  @override
  String get staffWillReply => 'En medarbeider vil snart svare deg.';

  @override
  String get inCall => 'I samtale...';

  @override
  String get registration => 'Registrering';

  @override
  String get deactivation => 'Deaktivering';

  @override
  String get deactivatedOn => 'Deaktivert den';

  @override
  String get accountAutoSuspend =>
      'Kontoer som ikke verifiseres innen 30 dager, vil automatisk bli suspendert.';

  @override
  String get ipClean => 'IP ren - ikke oppført';

  @override
  String get documentsProvidedByBoard => 'Dokumenter leveres av styret.';

  @override
  String get noDocumentsAvailable => 'Ingen dokumenter';

  @override
  String get noDocumentsDescription =>
      'Det er ennå ikke levert dokumenter til deg.';

  @override
  String uploadedBy(String name) {
    return 'Lastet opp av: $name';
  }

  @override
  String stepsCompleted(int completed, int total) {
    return '$completed/$total trinn fullført';
  }

  @override
  String dayOfMonth(int day) {
    return '$day. i måneden';
  }

  @override
  String changeField(String field) {
    return 'Endre $field';
  }

  @override
  String openDocument(String name) {
    return 'Åpne $name';
  }

  @override
  String get helpImproveApp => 'Vil du hjelpe oss med å forbedre appen?';

  @override
  String get noPersonalDataCollected =>
      'Ingen personlige data samles inn. Denne innstillingen kan endres når som helst.';

  @override
  String logEntries(int count) {
    return '$count oppføringer';
  }

  @override
  String get noLogs => 'Ingen logger';

  @override
  String get newLoginDetected => 'Ny innlogging oppdaget';

  @override
  String get waitingForMember => 'Venter på medlem';

  @override
  String get waitingForStaff => 'Venter på medarbeider';

  @override
  String get waitingForAuthority => 'Venter på myndighet';
}
