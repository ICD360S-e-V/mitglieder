// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Norwegian Bokmål (`nb`).
class AppLocalizationsNb extends AppLocalizations {
  AppLocalizationsNb([String locale = 'nb']) : super(locale);

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
  String get confirmPassword => 'Bekreft passord';

  @override
  String get confirmPasswordHint => 'Bekreft passord';

  @override
  String get newPassword => 'Nytt passord';

  @override
  String get newPasswordHint => 'Skriv inn nytt passord';

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
  String get unknown => 'Ukjent';

  @override
  String error(String error) {
    return 'Feil: $error';
  }

  @override
  String get cancel => 'Avbryt';

  @override
  String get resetPassword => 'Tilbakestill passord';

  @override
  String get imprint => 'Impressum';

  @override
  String get privacy => 'Personvernpolicy';

  @override
  String get statutes => 'Vedtekter';

  @override
  String get revocation => 'Angrerett';

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
  String get myAppointments => 'Mine avtaler';

  @override
  String get priority => 'Prioritet';

  @override
  String get messageLabel => 'Melding';

  @override
  String get reportProblems => 'Rapporter problemer';

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
  String get low => 'Lav';

  @override
  String get high => 'Høy';

  @override
  String get submit => 'Send inn';

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
  String get saveEmail => 'Lagre e-post';

  @override
  String get savePassword => 'Lagre passord';

  @override
  String get deviceLoggedOut => 'Enhet logget ut';

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
  String get reasonLabel2 => 'Årsak';

  @override
  String get downloadFailed2 => 'Nedlasting mislyktes';

  @override
  String get downloadTooltip => 'Last ned';

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
  String logEntries(int count) {
    return '$count oppføringer';
  }

  @override
  String get noLogs => 'Ingen logger';

  @override
  String get newLoginDetected => 'Ny innlogging oppdaget';

  @override
  String get errorNoInternet =>
      'Ingen internettforbindelse. Vennligst sjekk nettverket ditt.';

  @override
  String get errorTimeout =>
      'Serveren svarer ikke. Vennligst prøv igjen senere.';

  @override
  String get errorServer => 'Serverfeil. Vennligst prøv igjen senere.';

  @override
  String get errorConnection => 'Tilkoblingsfeil. Vennligst prøv igjen senere.';

  @override
  String get errorUnexpected =>
      'En uventet feil oppstod. Vennligst prøv igjen senere.';

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
  String get claudiuWelcomeMorning => 'God morgen';

  @override
  String get claudiuWelcomeDay => 'Hei';

  @override
  String get claudiuWelcomeEvening => 'God kveld';

  @override
  String get claudiuWelcomeNight => 'God kveld';

  @override
  String get claudiuWelcomeVisitor => 'kjære besøkende';

  @override
  String get claudiuWelcomeAsk => 'Hvordan kan jeg hjelpe?';

  @override
  String get claudiuWelcomeBecomeMember => 'Jeg vil bli medlem';

  @override
  String get claudiuWelcomeLogin => 'Jeg er allerede medlem og vil logge inn';

  @override
  String get claudiuWelcomeProblem => 'Jeg har et problem med appen';

  @override
  String get claudiuWelcomeEmergency => 'Nødssituasjon — ring oss';

  @override
  String get claudiuWelcomeMascotName => 'Claudiu';

  @override
  String get claudiuWelcomeEmergencyIntro =>
      'Før du ringer — våre åpningstider:';

  @override
  String get claudiuWelcomeScheduleOffice => 'På kontoret';

  @override
  String get claudiuWelcomeScheduleField => 'På feltet med kunder';

  @override
  String get claudiuWelcomeOutsideHoursNote =>
      'Utenfor disse tidene tar vi bare nødssaker. Du kan også sende SMS til samme nummer — vi ringer tilbake.';

  @override
  String get claudiuWelcomeCallNow => 'Ring nå';

  @override
  String get claudiuWelcomeSendSms => 'Send SMS';

  @override
  String get claudiuWelcomeSmsBody =>
      'Nødssituasjon ICD360S e.V. — vennligst kontakt meg snarest.';

  @override
  String get claudiuWelcomeCloseButton => 'Lukk';

  @override
  String get claudiuLoginWelcome => 'Velkommen tilbake, kjære medlem!';

  @override
  String get claudiuLoginAsk => 'Fortell meg medlemsnummeret ditt.';

  @override
  String get claudiuLoginProgress => 'Nesten… fortsett å skrive.';

  @override
  String get claudiuLoginReady => 'Perfekt! Trykk på knappen under.';

  @override
  String get claudiuLoginLoading => 'Sjekker identitet… 🔍';

  @override
  String get claudiuLoginFoundPlain => 'Fant deg! Logger inn…';

  @override
  String claudiuLoginFoundNamed(String name) {
    return 'Fant deg, $name! Logger inn…';
  }

  @override
  String get claudiuLoginError =>
      'Hm, jeg finner ikke det nummeret. Skrev du det riktig?';

  @override
  String get claudiuLoginForgotHeader => 'Glemt medlemsnummeret?';

  @override
  String get claudiuLoginNoSms =>
      'Vi sender ikke nummeret på e-post eller SMS.';

  @override
  String get claudiuLoginOnlyWay =>
      'Den eneste måten: et personlig møte på foreningens kontor, etter ID-kontroll.';

  @override
  String get claudiuLoginContactUs => 'Ring for å avtale tid:';

  @override
  String get claudiuDiagnosticGreeting => 'Før du går inn, et raskt spørsmål';

  @override
  String get claudiuDiagnosticAsk =>
      'Kan jeg sende anonyme rapporter slik at utviklerne kan forbedre appen?';

  @override
  String get claudiuDiagnosticYes => 'Ja, jeg vil hjelpe';

  @override
  String get claudiuDiagnosticNo => 'Nei, jeg ser meg bare omkring';

  @override
  String get claudiuDiagnosticTellMore => 'Fortell meg mer';

  @override
  String get claudiuDiagnosticSendsHeader => '📤 Hva vi SENDER (anonymt):';

  @override
  String get claudiuDiagnosticSends1 =>
      'En anonym enhetskode (IKKE medlemsnummeret)';

  @override
  String get claudiuDiagnosticSends2 => 'Din rolle (medlem / styre)';

  @override
  String get claudiuDiagnosticSends3 =>
      'Operativsystem (Linux / Android / iOS / Windows)';

  @override
  String get claudiuDiagnosticSends4 => 'Valgt språk';

  @override
  String get claudiuDiagnosticSends5 => 'Batterinivå og tilstand';

  @override
  String get claudiuDiagnosticSends6 => 'Nåværende skjerm';

  @override
  String get claudiuDiagnosticSends7 => 'Varigheten av økten (sekunder)';

  @override
  String get claudiuDiagnosticSends8 => 'Feil hvis noen (siste 10)';

  @override
  String get claudiuDiagnosticSends9 => 'Navigasjon (siste 20 skjermer)';

  @override
  String get claudiuDiagnosticNeverHeader => '🛡️ Hva vi ALDRI sender:';

  @override
  String get claudiuDiagnosticNever1 => 'Det ekte navnet ditt';

  @override
  String get claudiuDiagnosticNever2 => 'E-postadresse';

  @override
  String get claudiuDiagnosticNever3 => 'Telefonnummer';

  @override
  String get claudiuDiagnosticNever4 => 'Passord';

  @override
  String get claudiuDiagnosticNever5 => 'Innholdet i chatmeldinger';

  @override
  String get claudiuDiagnosticNever6 => 'Innholdet i ticketer';

  @override
  String get claudiuDiagnosticNever7 => 'Dokumenter eller vedlegg';

  @override
  String get claudiuDiagnosticTechHeader => '📡 Tekniske detaljer:';

  @override
  String get claudiuDiagnosticTech1 => 'Sendt hvert 2. minutt';

  @override
  String get claudiuDiagnosticTech2 =>
      'TLS-kryptert tilkobling med festet sertifikat';

  @override
  String get claudiuDiagnosticTech3 =>
      'Du kan slå av når som helst i Innstillinger';

  @override
  String get claudiuProblemHelpTitle => 'Hvordan kan jeg hjelpe?';

  @override
  String get claudiuProblemHelpGreeting => 'Hva skjedde?';

  @override
  String get claudiuProblemHelpAsk => 'Hvordan vil du fortelle meg det?';

  @override
  String get claudiuProblemHelpWriteTitle => 'Skriv en rapport';

  @override
  String get claudiuProblemHelpWriteBody =>
      'Med detaljer trinn for trinn. Teamet får teksten og løser det senere.';

  @override
  String get claudiuProblemHelpChatTitle => 'La oss snakke nå';

  @override
  String get claudiuProblemHelpChatBody =>
      'Anonym chat med en operatør. Sanntidssvar hvis noen er på nett.';

  @override
  String get claudiuProblemHelpAltCallHeader => 'Eller, hvis det haster:';

  @override
  String get claudiuProblemHelpAltCallLabel => 'Ring oss';

  @override
  String get claudiuAnonymousChatTitle => 'Anonym chat';

  @override
  String get claudiuAnonymousChatGreeting => 'Hei!';

  @override
  String get claudiuAnonymousChatWelcome =>
      'Jeg lytter. Skriv hva du vil — ingen navn nødvendig. Jeg svarer så snart jeg er her.';

  @override
  String get claudiuAnonymousChatHint => 'Skriv en melding…';

  @override
  String get claudiuAnonymousChatWaitingOperator =>
      'Venter på at en operatør svarer…';

  @override
  String get claudiuVorsitzerConnectedTitle => 'Hei!';

  @override
  String get claudiuVorsitzerConnectedBody =>
      'Takk for at du tok kontakt — du er nå koblet til en Vorsitzer. Fortell oss hvordan vi kan hjelpe deg med medlemssøknaden.';

  @override
  String get claudiuVorsitzerConnectedSender => 'Vorsitzer';

  @override
  String get claudiuQuickReplyValidationTime =>
      'Hvor lang tid tar valideringen?';

  @override
  String get claudiuQuickReplyDocuments => 'Hvilke dokumenter trenger jeg?';

  @override
  String get claudiuQuickReplyStepProblem =>
      'Jeg har kjørt meg fast på et trinn';

  @override
  String get claudiuQuickReplyHuman => 'Kan jeg snakke med noen nå?';

  @override
  String get claudiuAnonymousChatConnecting => 'Kobler til…';

  @override
  String get claudiuAnonymousChatConnectionFailed =>
      'Kunne ikke åpne chatten. Prøv igjen eller ring oss.';

  @override
  String get claudiuAnonymousChatRetry => 'Prøv igjen';

  @override
  String get claudiuAnonymousChatOnline => 'Tilkoblet';

  @override
  String get claudiuAnonymousChatOffline => 'Kobler til igjen…';

  @override
  String get claudiuAnonymousChatAdminTyping => 'Operatøren skriver…';

  @override
  String get claudiuProblemReportTitle => 'Rapporter et problem';

  @override
  String get claudiuProblemReportGreeting => 'Hva skjedde?';

  @override
  String get claudiuProblemReportAsk =>
      'Fortell detaljert, så videresender jeg rapporten til teamet.';

  @override
  String get claudiuProblemReportIncludeHeader => 'Vennligst inkluder:';

  @override
  String get claudiuProblemReportIncludeBullets1 =>
      'Hva du gjorde da problemet oppstod';

  @override
  String get claudiuProblemReportIncludeBullets2 =>
      'Eventuelle feilmeldinger du så';

  @override
  String get claudiuProblemReportIncludeBullets3 => 'Hvilken skjerm du var på';

  @override
  String get claudiuProblemReportIncludeBullets4 =>
      'Krasjer appen, lukker den, eller viser blank skjerm?';

  @override
  String get claudiuProblemReportIncludeBullets5 =>
      'Skjer det hver gang eller bare én gang?';

  @override
  String get claudiuProblemReportDescriptionLabel => 'Din beskrivelse';

  @override
  String get claudiuProblemReportDescriptionHint =>
      'F.eks.: Når jeg åpner chatten får jeg \"Connection error\" og appen svarer ikke…';

  @override
  String claudiuProblemReportTooShort(int count) {
    return 'Litt mer detaljer, takk (minst $count tegn)';
  }

  @override
  String get claudiuProblemReportSubmit => 'Send rapport';

  @override
  String get claudiuProblemReportSubmitting => 'Sender…';

  @override
  String get claudiuProblemReportSentTitle => 'Takk!';

  @override
  String get claudiuProblemReportSentBody =>
      'Rapporten er sendt. Teamet vårt ser på det så snart som mulig.';

  @override
  String get claudiuProblemReportSentClose => 'Forstått';

  @override
  String get claudiuProblemReportSendFailed =>
      'Kunne ikke sende rapporten. Ring oss for akutt hjelp.';

  @override
  String get claudiuProblemReportAlt => 'Eller, hvis det haster:';

  @override
  String get claudiuProblemReportCallLabel => 'Ring oss';

  @override
  String claudiuApprovalGreeting(String name) {
    return 'Hei, $name! 👋';
  }

  @override
  String get claudiuApprovalGreetingNoName => 'Hei! 👋';

  @override
  String get claudiuApprovalGladToSeeYou => 'Hyggelig at du er her!';

  @override
  String get claudiuApprovalCheckingForSafety =>
      'For din sikkerhet sjekker en Vorsitzer nå login-forespørselen din. 🛡️';

  @override
  String get claudiuApprovalMonthlyExplain =>
      '💡 Vi gjør dette hver 30. dag for å være sikre på at det virkelig er deg. Det er som en sikkerhetssjekk — maks 5 minutter.';

  @override
  String get claudiuApprovalSuccess =>
      'Ferdig! 🎉 Vorsitzer kjente deg igjen. Logger deg inn…';

  @override
  String get claudiuApprovalDenied =>
      'Hm, Vorsitzer avviste forespørselen din. 😔';

  @override
  String get claudiuApprovalDeniedHelp =>
      'Hvis du tror dette er en feil, ring oss så vi kan ordne det.';

  @override
  String get claudiuApprovalExpired =>
      'De 5 minuttene gikk og Vorsitzer svarte ikke.';

  @override
  String get claudiuApprovalExpiredHelp =>
      'Ring oss, så kan vi godkjenne forespørselen din direkte. 📞';

  @override
  String get claudiuApprovalCallUs => 'Ring oss';

  @override
  String get claudiuApprovalTryAgain => 'Prøv igjen';

  @override
  String get claudiuApprovalCancel => 'Avbryt';

  @override
  String get claudiuApprovalClose => 'Lukk';

  @override
  String get wizardIntroBubble1 =>
      'Hei, besøkende! 👋 Takk for at du vil bli en del av familien vår.';

  @override
  String get wizardIntroBubble2 =>
      'Jeg heter Claudiu. Våren 2025 hadde jeg en klar visjon: å skape en forening som hjelper mennesker i nød — frivillig, fra hjertet, uten unødvendig byråkrati. ❤️';

  @override
  String get wizardIntroBubble3 =>
      'Jeg begynte å snakke med klientene jeg besøkte. Jeg fortalte dem drømmen min. Og hver eneste sa: \"Ja, kom igjen!\" I juli 2025 møttes vi — 6 bestemte mennesker. Vi bestemte oss for å grunnlegge **ICD360S e.V.** i Neu-Ulm. 📍';

  @override
  String get wizardIntroBubble4 =>
      '**1. august 2025** kom foreningen offisielt til live — i foreningsregisteret. Min vakreste gave. 🎂';

  @override
  String get wizardIntroBubble5 =>
      'Hva gjør vi? Vi hjelper flyktninger, mennesker med funksjonsnedsettelser, økonomisk vanskeligstilte, **barn og ungdom** — med administrative spørsmål, tysk språk, bolig, innkjøp, sosiale ytelser. Vorstand vårt består hovedsakelig av mennesker med funksjonsnedsettelser — slik kommer beslutninger fra ekte livserfaring. 🤝';

  @override
  String get wizardIntroBubble6 =>
      'Nå er det din tur. La oss melde deg inn — tar omtrent 5 minutter. Vi går steg for steg, jeg lar deg ikke være alene. ✨';

  @override
  String get wizardIntroStart => 'La oss starte';

  @override
  String get wizardBack => 'Tilbake';

  @override
  String get wizardNext => 'Neste';

  @override
  String wizardStepLabel(int step, int total, String title) {
    return 'Steg $step av $total · $title';
  }

  @override
  String get wizardErrRequired => 'Dette feltet er obligatorisk';

  @override
  String wizardErrTooShort(int count) {
    return 'For kort (minst $count tegn)';
  }

  @override
  String get wizardErrOnlyLetters =>
      'Kun bokstaver, mellomrom, bindestreker og apostrofer';

  @override
  String get wizardErrSaveFailed =>
      'Kunne ikke lagre. Sjekk tilkoblingen og prøv igjen.';

  @override
  String get wizardStufe1aTitle => 'Identitet';

  @override
  String get wizardStufe1aPrompt =>
      'La oss bli kjent offisielt. Skriv navnet ditt nøyaktig som det står på Personalausweis, Reisepass eller Aufenthaltstitel — så stemmer det med dokumentene dine.';

  @override
  String get wizardStufe1aVornameLabel => 'Vornamen (fornavn)';

  @override
  String get wizardStufe1aVornameHelper =>
      'Alle fornavnene dine, nøyaktig som på dokumentet. Med mellomrom eller bindestrek (f.eks. Hans-Peter, Maria Anna).';

  @override
  String get wizardStufe1aNachnameLabel => 'Familienname (etternavn)';

  @override
  String get wizardStufe1aNachnameHelper => 'Etternavnet ditt nå.';

  @override
  String get wizardStufe1aGeburtsnameLabel =>
      'Geburtsname (fødselsnavn) — valgfritt';

  @override
  String get wizardStufe1aGeburtsnameHelper =>
      'Bare hvis det avviker fra Familienname — f.eks. før ekteskap.';

  @override
  String get wizardStufe1bTitle => 'Bursdag';

  @override
  String get wizardStufe1bPrompt =>
      'Vi vil gjerne feire bursdagen din sammen med deg! 🎂 Det hjelper oss også å bekrefte at du er minst 16 — slik står det i vedtektene våre.';

  @override
  String get wizardStufe1bGeburtsdatumLabel => 'Fødselsdato';

  @override
  String get wizardStufe1bGeburtsdatumHelper => 'Trykk for å velge en dato';

  @override
  String get wizardStufe1bGeburtsortLabel => 'Fødested';

  @override
  String get wizardStufe1bGeburtsortHelper => 'By / sted der du ble født.';

  @override
  String get wizardAgeGatePrompt => 'Beklager… 😔';

  @override
  String wizardAgeGateBody1(int age, int years) {
    return 'Vedtektene våre sier at du må være minst 16 for å bli medlem. Du er $age — jeg håper vi ses igjen om $years år! 🌱';
  }

  @override
  String get wizardAgeGateBody2 =>
      'Hvis du vil bidra som frivillig av og til (uansett alder, med foreldres samtykke), ring oss — vi støtter gjerne unge som vil forandre verden.';

  @override
  String get wizardAgeGateBackHome => 'Tilbake til velkomstskjermen';

  @override
  String get wizardErrInvalidPhone => 'Ugyldig telefonnummer';

  @override
  String get wizardStufe1b1Title => 'Foreldresamtykke';

  @override
  String get wizardStufe1b1Prompt =>
      'Du er mindreårig (16-17) — i henhold til §106 BGB trenger vi samtykke fra en forelder eller verge. Si meg navnet og telefonnummeret. En Vorsitzer ringer og avtaler et møte (personlig eller videosamtale). Ingen e-post — vi vil være sikre på at vi snakker med rett person.';

  @override
  String get wizardStufe1b1VornameLabel => 'Forelders fornavn';

  @override
  String get wizardStufe1b1VornameHelper =>
      'Som det står på forelderens Personalausweis.';

  @override
  String get wizardStufe1b1NachnameLabel => 'Forelders etternavn';

  @override
  String get wizardStufe1b1NachnameHelper =>
      'Som det står på forelderens Personalausweis.';

  @override
  String get wizardStufe1b1TelefonLabel => 'Forelders mobilnummer';

  @override
  String get wizardStufe1b1TelefonHelper =>
      'En Vorsitzer ringer dette nummeret.';

  @override
  String get wizardStufe1b1RelationLabel => 'Forhold til barnet:';

  @override
  String get wizardStufe1b1RelationMutter => 'Mor';

  @override
  String get wizardStufe1b1RelationVater => 'Far';

  @override
  String get wizardStufe1b1RelationSorgeberechtigter => 'Verge';

  @override
  String get wizardStufe1b1RelationAndere => 'Annen verge';

  @override
  String get wizardStufe1cTitle => 'Personlige opplysninger';

  @override
  String get wizardStufe1cPrompt =>
      'Bare så jeg blir litt bedre kjent med deg. Dette blir mellom oss og vises ikke offentlig noe sted.';

  @override
  String get wizardStufe1cGeschlechtLabel => 'Kjønn';

  @override
  String get wizardStufe1cGeschlechtMaennlich => 'Mann';

  @override
  String get wizardStufe1cGeschlechtWeiblich => 'Kvinne';

  @override
  String get wizardStufe1cGeschlechtDivers => 'Annet';

  @override
  String get wizardStufe1cGeschlechtKeineAngabe => 'Foretrekker å ikke si';

  @override
  String get wizardStufe1cFamilienstandLabel => 'Sivilstand';

  @override
  String get wizardStufe1cFamilienstandLedig => 'Ugift';

  @override
  String get wizardStufe1cFamilienstandVerheiratet => 'Gift';

  @override
  String get wizardStufe1cFamilienstandGeschieden => 'Skilt';

  @override
  String get wizardStufe1cFamilienstandVerwitwet => 'Enkemann/Enke';

  @override
  String get wizardStufe1dTitle => 'Din bakgrunn';

  @override
  String get wizardStufe1dPrompt =>
      'Dette hjelper oss å tilby deg riktig støtte — for eksempel rådgivning om Aufenthalt eller å finne ditt språkfellesskap.';

  @override
  String get wizardStufe1dStaatLabel => 'Statsborgerskap';

  @override
  String get wizardStufe1dStaatHelper =>
      'F.eks. deutsch, rumänisch, ukrainisch. Flere adskilt med komma.';

  @override
  String get wizardStufe1dAufenthaltLabel =>
      'Oppholdsstatus (Aufenthaltsstatus) — valgfritt';

  @override
  String get wizardStufe1dAufenthaltHelper =>
      'Velg tittelen fra din Aufenthaltskarte / vedtak. Vorstand sammenligner med dokumentene dine.';

  @override
  String get wizardStufe1dAufenthaltAwaitingCitizenship =>
      'Fyll ut statsborgerskap over først — vi viser bare relevante valg.';

  @override
  String get wizardStufe1dAufenthaltGerman =>
      'Ingen Aufenthaltstitel nødvendig — tysk statsborger.';

  @override
  String get wizardStufe1dAufenthaltEuEea =>
      'EU/EØS/CH-borger — fri bevegelse (Freizügigkeit).';

  @override
  String get wizardStufe1dAufenthaltTempHint => 'midlertidig';

  @override
  String get wizardStufe1dAufenthaltPermHint => 'permanent opphold';

  @override
  String get wizardStufe1dAufenthaltAsylumProcessHint => 'asylprosedyre';

  @override
  String get wizardStufe1dAufenthaltOther => 'Annet (spesifiser i chatten)';

  @override
  String get wizardStufe1dAufenthaltRequired => 'Velg en Aufenthaltstitel.';

  @override
  String get wizardStufe1dMutterspracheLabel => 'Morsmål';

  @override
  String get wizardStufe1dMutterspracheHelper =>
      'Forhåndsutfylt med app-språk — endre om annet.';

  @override
  String get wizardStufe1eTitle => 'Adresse';

  @override
  String get wizardStufe1ePrompt =>
      'Postadressen din — vi bruker den til offisielle dokumenter (vedtekter, medlemskontrakter, varsler).';

  @override
  String get wizardStufe1eStrasseLabel => 'Gate';

  @override
  String get wizardStufe1eStrasseHelper =>
      'Bare gatenavnet — husnummer i feltet ved siden av.';

  @override
  String get wizardStufe1eHausnummerLabel => 'Nr.';

  @override
  String get wizardStufe1ePlzLabel => 'PLZ (postnr.)';

  @override
  String get wizardStufe1eOrtLabel => 'By';

  @override
  String get wizardStufe1eLandLabel => 'Land';

  @override
  String get wizardStufe1eLandHelper => 'Forhåndsutfylt: Deutschland.';

  @override
  String get wizardErrInvalidStreet => 'Ugyldig gatenavn';

  @override
  String get wizardErrInvalidHausnummer =>
      'Ugyldig nummer (f.eks. 12, 12a, 12/3)';

  @override
  String get wizardErrInvalidPlz => 'Ugyldig postnummer (kun siffer)';

  @override
  String get wizardStufe1fTitle => 'Kontakt';

  @override
  String get wizardStufe1fPrompt =>
      'Hvordan får vi kontakt med deg? Telefonen er kun for nødstilfeller — alt annet går via vår egen ende-til-ende-krypterte kanal i appen. Medlems-e-posten din tildeles automatisk og vises nedenfor.';

  @override
  String get wizardStufe1fTelefonLabel => 'Mobilnummer';

  @override
  String get wizardStufe1fTelefonHelper =>
      'Lover at jeg bare ringer hvis det er viktig. 📱';

  @override
  String get wizardStufe2Title => 'Medlemskapstype';

  @override
  String get wizardStufe2Prompt =>
      'Hva slags medlem vil du være? La meg forklare hvert alternativ.';

  @override
  String get wizardStufe2OrdentlichTitle => 'Ordinært medlem (ordentlich)';

  @override
  String get wizardStufe2OrdentlichBody =>
      'Fulle rettigheter. Du betaler månedlig kontingent, stemmer på medlemsmøtet, kan velges inn i styret. Standardvalget.';

  @override
  String get wizardStufe2FoerderTitle => 'Støttemedlem (Fördermitglied)';

  @override
  String get wizardStufe2FoerderBody =>
      'Du støtter foreningen økonomisk, men deltar ikke aktivt i beslutninger. Ingen stemmerett. Bra hvis du vil hjelpe på avstand.';

  @override
  String get wizardStufe2EhrenTitle => 'Æresmedlem (Ehrenmitglied)';

  @override
  String get wizardStufe2EhrenBody =>
      'Tildeles av styret for spesielle fortjenester. Du velger det ikke selv — det gis som anerkjennelse. Velg bare hvis du allerede er hedret.';

  @override
  String get wizardStufe3Title => 'Økonomisk situasjon';

  @override
  String get wizardStufe3Prompt =>
      'Nå om din økonomiske situasjon. Ikke for å dømme — bare for å frita deg for kontingent hvis du mottar sosiale ytelser.';

  @override
  String get wizardStufe3OptionBuergergeld => 'Jeg mottar Bürgergeld';

  @override
  String get wizardStufe3OptionSozialamt => 'Jeg mottar ytelser fra Sozialamt';

  @override
  String get wizardStufe3OptionNein => 'Jeg mottar ingen av disse';

  @override
  String get wizardStufe3FeeExemptTitle => 'Kontingent: 0 € / måned 🎉';

  @override
  String get wizardStufe3FeeExemptBody =>
      'Med Bürgergeld, Sozialamt, ALG I eller Krankengeld er du helt fritatt for kontingent etter Satzung §6. Vi trenger bare et bevis (Leistungsbescheid eller attest fra myndigheten / sykekassen).';

  @override
  String get wizardStufe3UploadTitle => 'Last opp Leistungsbescheid';

  @override
  String get wizardStufe3UploadHint => 'PDF / JPG / PNG, maks 10 MB.';

  @override
  String get wizardStufe3UploadRequired =>
      'Last opp Leistungsbescheid før du fortsetter.';

  @override
  String get wizardStufe3FileTooLarge => 'Filen er for stor. Maks 10 MB.';

  @override
  String get wizardStufe3UploadFailed =>
      'Kunne ikke laste opp filen. Prøv igjen.';

  @override
  String get wizardStufe3RegularFeeTitle => 'Kontingent: 25 € / måned';

  @override
  String get wizardStufe3RegularFeeBody =>
      'Standardkontingent for ordinære medlemmer ifølge vedtektene.';

  @override
  String get wizardStufe4Title => 'Betaling';

  @override
  String get wizardStufe4Prompt =>
      'Hvordan vil du betale kontingenten? Og hvilken dag i måneden?';

  @override
  String get wizardStufe4MethodUeberweisungTitle =>
      'Bankoverføring (Überweisung)';

  @override
  String get wizardStufe4MethodUeberweisungBody =>
      'Du starter betalingen selv hver måned fra kontoen din.';

  @override
  String get wizardStufe4MethodSepaTitle => 'SEPA-Lastschrift (avtalegiro)';

  @override
  String get wizardStufe4MethodSepaBody =>
      'Vi trekker beløpet automatisk fra kontoen din. Mest praktisk, men vi trenger IBAN og et signert mandat.';

  @override
  String get wizardStufe4MethodDauerauftragTitle =>
      'Dauerauftrag (fast oppdrag)';

  @override
  String get wizardStufe4MethodDauerauftragBody =>
      'Du oppretter en fast overføring i banken din. Banken overfører beløpet automatisk hver måned.';

  @override
  String get wizardStufe4DayLabel => 'Betalingsdag';

  @override
  String get wizardStufe4DayHint => 'Velg en dag mellom 1 og 31';

  @override
  String wizardStufe4DayItem(int day) {
    return 'Dag $day';
  }

  @override
  String wizardStufe4DayReminder(int day) {
    return 'Kontingentet trekkes den $day. hver måned.';
  }

  @override
  String get wizardStufe5Title => 'Startdato';

  @override
  String get wizardStufe5Prompt =>
      'Når vil du være offisielt ICD360S-medlem? Fra godkjenningen eller med tilbakevirkende kraft.';

  @override
  String get wizardStufe5OptionAbVerifizierungTitle =>
      'Fra Vorstand-godkjenningen';

  @override
  String get wizardStufe5OptionAbVerifizierungBody =>
      'Det enkleste valget. Ingen tilbakevirkende kontingent.';

  @override
  String get wizardStufe5OptionGruendungsdatumTitle =>
      'Tilbakevirkende fra 01.08.2025 (stiftelse)';

  @override
  String get wizardStufe5OptionGruendungsdatumBody =>
      'Du regnes som medlem fra foreningens første dag.';

  @override
  String get wizardStufe5OptionAnderesDatumTitle => 'En annen dato';

  @override
  String get wizardStufe5OptionAnderesDatumBody =>
      'Du velger en dato mellom 01.08.2025 og i dag.';

  @override
  String get wizardStufe5PickDate => 'Trykk for å velge dato';

  @override
  String get wizardStufe5PickDateFirst => 'Vennligst velg en dato først.';

  @override
  String get wizardStufe5DatePickerHelp => 'Start på medlemskap';

  @override
  String wizardStufe5DateRange(String start) {
    return 'Mellom $start og i dag';
  }

  @override
  String get wizardStufe5RetroactiveTitle => 'Tilbakevirkende kontingent';

  @override
  String wizardStufe5RetroactiveBody(
      String start, String end, int months, String amount) {
    return 'Fra $start til $end er det $months måneder. Ved 25 €/måned gir det $amount € tilbakevirkende, i tillegg til løpende månedlig kontingent.';
  }

  @override
  String get wizardStufe5FeeExemptTitle => 'Tilbakevirkende kontingent: 0 € 🎉';

  @override
  String get wizardStufe5FeeExemptBody =>
      'Med Bürgergeld eller Sozialamt er du helt fritatt — heller ikke tilbakevirkende skylder du noe.';

  @override
  String wizardDocumentPrompt(String doc) {
    return 'Før vi avslutter, vennligst les $doc grundig. Det er viktig å vite hva du signerer.';
  }

  @override
  String get wizardDocumentScrollHint => 'Bla til bunnen for å fortsette.';

  @override
  String get wizardDocumentScrolledOk => 'Du har lest til slutten ✓';

  @override
  String wizardDocumentOpenButton(String doc) {
    return 'Åpne $doc i nettleseren';
  }

  @override
  String get wizardDocumentExternalHint =>
      'På denne plattformen åpner vi dokumentet i din standardnettleser.';

  @override
  String get wizardDocumentOpenedOk =>
      'Dokumentet er åpnet. Vennligst les det nøye.';

  @override
  String wizardDocumentConfirm(String doc) {
    return 'Jeg bekrefter at jeg har lest og godtar $doc.';
  }

  @override
  String get wizardFinalAdultTitle => 'Ferdig! Du er meldt inn 🎉';

  @override
  String get wizardFinalMinorTitle => 'Forespørselen din er sendt 📨';

  @override
  String get wizardFinalMinorBody =>
      'Vi kontakter forelderen din og avtaler et møte (personlig eller videosamtale). Vær tålmodig — prosessen kan ta opptil 7 dager. Du får et varsel i appen så snart forelderen din har godkjent.';

  @override
  String get wizardFinalMitgliedernummerLabel => 'Medlemsnummeret ditt';

  @override
  String get wizardStufe4MethodComingSoon => 'Kommer snart';

  @override
  String get wizardStufe4StreichungWarning =>
      'Hvis du er mer enn 6 måneder på etterskudd med kontingenten, stryker vi deg automatisk (Satzung §6 Abs. 3).';

  @override
  String get wizardStufe5KuendigungInfo =>
      'For å melde deg ut: send oss oppsigelsen skriftlig 3 måneder før 31. desember (senest 30. september for å gjelde ved årsslutt). Ingen minimumstid (Satzung §6 Abs. 3).';

  @override
  String get wizardStufe1fEmailLabel => 'Medlems-e-posten din';

  @override
  String get wizardStufe1fEmailHelper =>
      'Tildeles automatisk fra medlemsnummeret ditt. Aktiveres i det øyeblikket styret (Vorstand) godkjenner søknaden din. Vi har vår egen e-postapp — send og motta krypterte e-poster, enkelt og gratis.';

  @override
  String get wizardErrInvalidEmail => 'Ugyldig e-postadresse';

  @override
  String get wizardStufe3OptionAlg1 =>
      'Jeg mottar Arbeitslosengeld I (ALG I, dagpenger ved arbeidsledighet)';

  @override
  String get wizardStufe3OptionKrankengeld =>
      'Jeg mottar Krankengeld (sykepenger ved langtidssykmelding)';

  @override
  String get wizardStufe3UploadAddMore => 'Legg til et dokument til';

  @override
  String get wizardStufe3UploadLimitCount =>
      'Grensen er nådd: maks 20 dokumenter.';

  @override
  String get wizardStufe3UploadLimitTotal =>
      'Total grense på 100 MB nådd. Slett en eksisterende fil.';

  @override
  String get wizardStufe3UploadDeleteTooltip => 'Slett';

  @override
  String wizardStufe3UploadCounter(int count, int max) {
    return '$count / $max dokumenter';
  }

  @override
  String get wizardDocumentExternalOpenFailed =>
      'Kunne ikke åpne nettleseren. Lenken er kopiert til utklippstavlen — lim den inn i en nettleser for å fortsette.';

  @override
  String get wizardFinalTimelineProcessing =>
      'Vorstand gjennomgår · vanligvis 1 virkedag, opptil 7';

  @override
  String get wizardFinalTimelineActivated => 'Konto aktivert';

  @override
  String get wizardFinalAdultThank =>
      'Takk for at du fylte ut registreringsskjemaet! 🎉';

  @override
  String get wizardFinalAdultUsual =>
      'Søknaden din er hos oss. Vi godkjenner den vanligvis innen én virkedag.';

  @override
  String get wizardFinalAdultExceptional =>
      'Iblant kan det ta opptil 7 virkedager. Og hvis noe ikke stemmer, sender vi deg tilbake til skjemaet for å rette opp 🙂';

  @override
  String get wizardFinalStatusTitle => 'SØKNADSSTATUS';

  @override
  String wizardFinalStatusStepsValidated(int reviewed, int total) {
    return '$reviewed/$total trinn validert av Vorstand';
  }

  @override
  String get wizardFinalStufeSheetTitle => 'Detaljer for søknaden';

  @override
  String get wizardFinalStufeSheetHint =>
      'De 8 trinnene du fylte ut. Vorstand gjennomgår dem ett etter ett — du ser i sanntid hva som er godkjent.';

  @override
  String get wizardFinalStufeStatusPending => 'Venter på gjennomgang';

  @override
  String get wizardFinalStufeStatusApproved => 'Godkjent';

  @override
  String get wizardFinalStufeStatusRejected => 'Avvist';

  @override
  String wizardFinalStatusRejectionCount(int count) {
    return '$count trinn må rettes';
  }

  @override
  String get wizardFinalStufeRejectionReason => 'Begrunnelse fra Vorstand:';

  @override
  String get wizardFinalStufeCorrectNow => 'Rett nå';

  @override
  String wizardFinalApprovalsHeader(int current, int total) {
    return 'Vorstand-godkjenninger ($current/$total)';
  }

  @override
  String get wizardFinalApprovalAwaiting => 'Venter på 2. Vorstand';

  @override
  String get wizardFinalApprovalRejected => 'AVVIST';

  @override
  String get wizardFinalStufeNoDataYet => 'Data er ikke tilgjengelig ennå.';

  @override
  String get wizardFinalStufeReadAt => 'Lest:';

  @override
  String get wizardFinalStufeBeitragsfrei => 'Kontingentfri (ingen betaling)';

  @override
  String get wizardFinalStufeNotExempt => 'Ingen sosiale ytelser';

  @override
  String get wizardFinalStufeBeginAtVerification => 'Starter ved verifisering';

  @override
  String get wizardFinalStufeBeginAtFoundation =>
      'Stiftelsesdato (tilbakevirkende)';

  @override
  String get wizardFinalStufeBeginAtCustom => 'Annen dato';

  @override
  String get wizardFinalStufeStatusSkipped => 'Hoppet over';

  @override
  String get wizardFinalStufeFilledAt => 'Utfylt:';

  @override
  String get wizardFinalStufeReviewedAt => 'Gjennomgått:';

  @override
  String get wizardFinalWithdrawLink => 'Trekk søknad tilbake';

  @override
  String get wizardFinalWithdrawDialogTitle => 'Trekke søknaden tilbake?';

  @override
  String get wizardFinalWithdrawDialogBody =>
      'Søknaden din blir markert som trukket tilbake av deg. Dataene blir værende i databasen for revisjon (GDPR), men kontoen aktiveres ikke. Du kan starte registreringen på nytt når som helst med et nytt medlemsnummer.';

  @override
  String get wizardFinalWithdrawKeep => 'Nei, jeg venter';

  @override
  String get wizardFinalWithdrawConfirm => 'Ja, trekk tilbake';

  @override
  String get wizardErrTooManyWithdrawals =>
      'Søknaden din kan ikke behandles automatisk. Ring oss eller kom personlig innom Vorstand for å fortsette registreringen.';

  @override
  String get wizardDuplicateLoginTitle =>
      'Det ser ut til at du allerede er medlem';

  @override
  String get wizardDuplicateLoginBody =>
      'Med navnet og fødselsdatoen din finner vi allerede en aktiv konto. Bruk \"Jeg er allerede medlem\" på startskjermen for å logge inn. Hvis du ikke har tilgang lenger, ring oss.';

  @override
  String get wizardDuplicatePendingTitle => 'Søknaden din er allerede hos oss';

  @override
  String get wizardDuplicatePendingBody =>
      'Med navnet og fødselsdatoen din har vi allerede en søknad til behandling. Vorstand jobber med den — vi varsler deg i appen så snart kontoen er aktiv. Ring oss om du vil prate.';

  @override
  String get wizardDuplicateRecentlyWithdrawnTitle =>
      'Vi kan ikke behandle denne søknaden nå';

  @override
  String get wizardDuplicateRecentlyWithdrawnBody =>
      'Navnet og fødselsdatoen din matcher en nylig tilbaketrukket søknad. Ring oss for å snakke med Vorstand før du går videre.';

  @override
  String get wizardDuplicatePreviouslyWithdrawnTitle => 'Du har søkt tidligere';

  @override
  String get wizardDuplicatePreviouslyWithdrawnBody =>
      'Navnet og fødselsdatoen din matcher en eldre søknad du trakk tilbake. Velkommen tilbake — ring oss før du fortsetter, så Vorstand kan bestemme hvordan vi går videre.';

  @override
  String get wizardDuplicateCallUsTitle => 'Ring oss';

  @override
  String get wizardDuplicateCallUsBody =>
      'Navnet og fødselsdatoen din finnes allerede i registrene våre, men vi kan ikke dele detaljene gjennom appen. Ring oss — Vorstand forklarer situasjonen direkte.';

  @override
  String get wizardChatHelp => 'La oss prate';

  @override
  String get wizardChatHelpSubtitle => 'Live chat med Vorstand · raskt svar';

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
