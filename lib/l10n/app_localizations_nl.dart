// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Dutch Flemish (`nl`).
class AppLocalizationsNl extends AppLocalizations {
  AppLocalizationsNl([String locale = 'nl']) : super(locale);

  @override
  String get welcomeLoading => 'Laden...';

  @override
  String get welcomeAutoLogin => 'Automatisch inloggen...';

  @override
  String get login => 'Inloggen';

  @override
  String get register => 'Registreren';

  @override
  String get becomeMember => 'Word Lid';

  @override
  String get memberNumber => 'Lidnummer';

  @override
  String get memberNumberHint => 'Voer lidnummer in';

  @override
  String get confirmPassword => 'Bevestig Wachtwoord';

  @override
  String get confirmPasswordHint => 'Bevestig wachtwoord';

  @override
  String get newPassword => 'Nieuw Wachtwoord';

  @override
  String get newPasswordHint => 'Voer nieuw wachtwoord in';

  @override
  String get firstName => 'Voornaam en Achternaam';

  @override
  String get firstNameHint => 'Voer voor- en achternaam in';

  @override
  String get nameMinLength => 'Naam moet minimaal 2 tekens hebben';

  @override
  String get nameOnlyLetters => 'Alleen letters en koppeltekens toegestaan';

  @override
  String get email => 'E-mailadres';

  @override
  String get emailHint => 'Voer e-mail in';

  @override
  String get emailInvalid => 'Voer een geldig e-mailadres in';

  @override
  String get passwordMinLength => 'Wachtwoord moet minimaal 6 tekens hebben';

  @override
  String get passwordsNotMatch => 'Wachtwoorden komen niet overeen';

  @override
  String get registrationFailed => 'Registratie mislukt';

  @override
  String connectionError(String error) {
    return 'Verbindingsfout: $error';
  }

  @override
  String registrationSuccess(String memberNumber) {
    return 'Registratie geslaagd!\n\nUw lidnummer: $memberNumber\n\nOnthoud dit nummer om in te loggen.';
  }

  @override
  String get unknown => 'Onbekend';

  @override
  String error(String error) {
    return 'Fout: $error';
  }

  @override
  String get cancel => 'Annuleren';

  @override
  String get resetPassword => 'Wachtwoord Resetten';

  @override
  String get imprint => 'Colofon';

  @override
  String get privacy => 'Privacybeleid';

  @override
  String get statutes => 'Statuten';

  @override
  String get revocation => 'Herroepingsrecht';

  @override
  String get appointments => 'Afspraken';

  @override
  String get tickets => 'Tickets';

  @override
  String get liveChat => 'Live Chat';

  @override
  String get notifications => 'Meldingen';

  @override
  String get myProfile => 'Mijn Profiel';

  @override
  String get logout => 'Uitloggen';

  @override
  String get goodMorning => 'Goedemorgen';

  @override
  String get goodDay => 'Goedendag';

  @override
  String get goodEvening => 'Goedenavond';

  @override
  String get goodNight => 'Goedenacht';

  @override
  String get welcomeToICD => 'Welkom bij ICD360S e.V!';

  @override
  String get accountCreatedSuccessfully =>
      'Uw account is succesvol aangemaakt.';

  @override
  String get today => 'Vandaag';

  @override
  String get membershipFeeDue => 'Lidmaatschapsbijdrage verschuldigd';

  @override
  String get pleaseTransferAnnualFee =>
      'Gelieve de jaarlijkse bijdrage over te maken.';

  @override
  String get newBadge => 'Nieuw';

  @override
  String get close => 'Sluiten';

  @override
  String get myAppointments => 'Mijn afspraken';

  @override
  String get priority => 'Prioriteit';

  @override
  String get messageLabel => 'Bericht';

  @override
  String get reportProblems => 'Problemen melden';

  @override
  String get weRespondIn24Hours => 'We antwoorden binnen maximaal 24 uur!';

  @override
  String get everythingOk => 'Alles OK!';

  @override
  String get haveProblemWeHelp => 'Een probleem?\nWij regelen het!';

  @override
  String get myMembership => 'Mijn lidmaatschap';

  @override
  String get managePersonalDataAndFee =>
      'Beheer uw persoonlijke gegevens en bijdrage';

  @override
  String get myAppointmentsTitle => 'Mijn afspraken';

  @override
  String get appointmentsDescription =>
      'Hier kunt u uw aankomende afspraken zien.\nU kunt uw deelname bevestigen of afwijzen.';

  @override
  String get loadAppointments => 'Afspraken laden';

  @override
  String get myTickets => 'Mijn tickets';

  @override
  String get low => 'Laag';

  @override
  String get high => 'Hoog';

  @override
  String get submit => 'Verzenden';

  @override
  String get errorCreatingTicket => 'Fout bij aanmaken ticket';

  @override
  String get verified => 'Geverifieerd';

  @override
  String get account => 'Account';

  @override
  String get myDevices => 'Mijn apparaten';

  @override
  String get changeEmail => 'Email wijzigen';

  @override
  String get changePassword => 'Wachtwoord wijzigen';

  @override
  String get saveEmail => 'Email opslaan';

  @override
  String get savePassword => 'Wachtwoord opslaan';

  @override
  String get deviceLoggedOut => 'Apparaat afgemeld';

  @override
  String get emailChangedSuccessfully => 'Email succesvol gewijzigd';

  @override
  String get errorChangingPassword => 'Fout bij wijzigen wachtwoord';

  @override
  String get errorChangingEmail => 'Fout bij wijzigen email';

  @override
  String get validEmailRequired => 'Voer een geldig emailadres in';

  @override
  String get confirmLogoutDevice => 'Apparaat afmelden?';

  @override
  String get confirmLogoutMessage =>
      'Wilt u afmelden van dit apparaat?\n\nU moet opnieuw inloggen om dit apparaat te gebruiken.';

  @override
  String get ipAddress => 'IP';

  @override
  String get platform => 'Platform';

  @override
  String trialWarningUrgentTitle(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days dagen',
      one: '1 dag',
    );
    return 'Let op: Nog maar $_temp0 tot accountopschorting!';
  }

  @override
  String get trialWarningTitle => 'Uw account is nog niet geverifieerd';

  @override
  String get trialWarningDescription =>
      'Vul uw gegevens in bij \"Mijn Profiel\". Na 30 dagen wordt uw account automatisch opgeschort.';

  @override
  String trialDaysRemaining(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days dagen',
      one: '1 dag',
    );
    return '$_temp0';
  }

  @override
  String get overview => 'Overzicht';

  @override
  String get member => 'Lid';

  @override
  String get memberManagement => 'Ledenbeheer';

  @override
  String get reportProblemTooltip => 'Probleem melden';

  @override
  String get newAppointmentsTitle => 'Nieuwe afspraken';

  @override
  String get youHaveNewAppointment => 'U heeft een nieuwe afspraak.';

  @override
  String youHaveNewAppointments(int count) {
    return 'U heeft $count nieuwe afspraken.';
  }

  @override
  String get appointmentReminderTomorrow => 'Herinnering: Afspraak morgen';

  @override
  String tomorrowAppointment(String title) {
    return 'Morgen: $title';
  }

  @override
  String youHaveTomorrowAppointments(int count) {
    return 'U heeft $count afspraken morgen.';
  }

  @override
  String get appointmentsToday => 'Afspraken vandaag';

  @override
  String todayAppointment(String title) {
    return 'Vandaag: $title';
  }

  @override
  String youHaveTodayAppointments(int count) {
    return 'U heeft $count afspraken vandaag.';
  }

  @override
  String get paymentReminder => 'Betalingsherinnering';

  @override
  String paymentReminderMessage(int day, String method) {
    return 'Vandaag is de ${day}e van de maand – voltooi $method.';
  }

  @override
  String get paymentDayLabel => 'Betalingsdag (maandelijkse herinnering)';

  @override
  String get updateAvailable => 'Update beschikbaar';

  @override
  String newVersionAvailable(String version) {
    return 'Er is een nieuwe versie beschikbaar: $version';
  }

  @override
  String currentVersionLabel(String version) {
    return 'Huidige versie: $version';
  }

  @override
  String get changes => 'Wijzigingen:';

  @override
  String downloadProgress(String percent) {
    return 'Download: $percent%';
  }

  @override
  String get installationStarting => 'Installatie wordt gestart...';

  @override
  String get appWillRestart => 'De app wordt automatisch opnieuw gestart.';

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
  String get later => 'Later';

  @override
  String get updateNow => 'Nu bijwerken';

  @override
  String get downloading => 'Downloaden...';

  @override
  String get downloadFailed => 'Download mislukt. Probeer het later opnieuw.';

  @override
  String get searchingForUpdates => 'Zoeken naar updates...';

  @override
  String get appUpToDate => 'De app is up-to-date';

  @override
  String get updateCheckError => 'Fout bij het controleren op updates';

  @override
  String get changelog => 'Wijzigingslogboek';

  @override
  String get terminConfirmed => 'Afspraak bevestigd';

  @override
  String get terminDeclined => 'Afspraak geweigerd';

  @override
  String get terminRescheduleRequested => 'Verplaatsing aangevraagd';

  @override
  String get statusConfirmed => 'Bevestigd';

  @override
  String get statusDeclined => 'Geweigerd';

  @override
  String get statusRescheduling => 'Verplaatsing';

  @override
  String get statusPending => 'In afwachting';

  @override
  String get categoryVorstandssitzung => 'Bestuursvergadering';

  @override
  String get categoryMitgliederversammlung => 'Ledenvergadering';

  @override
  String get categorySchulung => 'Training';

  @override
  String get categorySonstiges => 'Overig';

  @override
  String openCount(int count) {
    return '$count open';
  }

  @override
  String get refresh => 'Vernieuwen';

  @override
  String get filterUpcoming => 'Aankomend';

  @override
  String get filterPast => 'Voorbij';

  @override
  String get filterAll => 'Alle';

  @override
  String get noUpcomingAppointments => 'Geen aankomende afspraken';

  @override
  String get noPastAppointments => 'Geen eerdere afspraken';

  @override
  String get noAppointmentsAvailable => 'Geen afspraken beschikbaar';

  @override
  String get appointmentsShownHere => 'Uw afspraken worden hier getoond';

  @override
  String get dateLabel => 'Datum';

  @override
  String get timeLabel => 'Tijd';

  @override
  String get locationLabel => 'Locatie';

  @override
  String get createdByLabel => 'Aangemaakt door';

  @override
  String get descriptionLabel => 'Beschrijving';

  @override
  String get ticketLabel => 'Ticket';

  @override
  String get yourStatus => 'Uw status: ';

  @override
  String reasonLabel(String reason) {
    return 'Reden: $reason';
  }

  @override
  String durationMinutes(int minutes) {
    return '$minutes min';
  }

  @override
  String get confirm => 'Bevestigen';

  @override
  String get decline => 'Weigeren';

  @override
  String get reschedule => 'Verplaatsen';

  @override
  String get requestReschedule => 'Verplaatsing aanvragen';

  @override
  String appointmentLabel(String title) {
    return 'Afspraak: $title';
  }

  @override
  String get rescheduleReason => 'Reden voor verplaatsing *';

  @override
  String get rescheduleReasonHint => 'Geef een reden op...';

  @override
  String get pleaseProvideReason => 'Geef een reden op';

  @override
  String get request => 'Aanvragen';

  @override
  String get ticketStatusOpen => 'Open';

  @override
  String get ticketStatusInProgress => 'In behandeling';

  @override
  String get ticketStatusWaitingMember => 'Wachten op lid';

  @override
  String get ticketStatusWaitingStaff => 'Wachten op medewerker';

  @override
  String get ticketStatusWaitingAuthority => 'Wachten op instantie';

  @override
  String get ticketStatusDone => 'Afgehandeld';

  @override
  String get ticketPriorityHigh => 'Hoog';

  @override
  String get ticketPriorityMedium => 'Gemiddeld';

  @override
  String get ticketPriorityLow => 'Laag';

  @override
  String get comments => 'Reacties';

  @override
  String get documents => 'Documenten';

  @override
  String get details => 'Details';

  @override
  String get replySent => 'Antwoord verzonden';

  @override
  String get sendError => 'Fout bij verzenden';

  @override
  String get uploading => 'Uploaden...';

  @override
  String fileUploaded(String filename) {
    return '$filename geüpload';
  }

  @override
  String get uploadFailed => 'Upload mislukt';

  @override
  String get openError => 'Fout bij openen';

  @override
  String get noRepliesYet => 'Nog geen reacties';

  @override
  String get waitingForSupport => 'Wachten op antwoord van support';

  @override
  String get writeReply => 'Schrijf een antwoord...';

  @override
  String get attachFile => 'Bestand bijvoegen';

  @override
  String documentsCount(int count) {
    return 'Documenten ($count)';
  }

  @override
  String get upload => 'Uploaden';

  @override
  String get noDocuments => 'Geen documenten beschikbaar';

  @override
  String get allowedFormats => 'Toegestane formaten: PDF, JPEG, JPG, TXT, ZIP';

  @override
  String get yourMessage => 'Uw bericht:';

  @override
  String get translation => 'Vertaling';

  @override
  String get original => 'Origineel';

  @override
  String get originalText => 'Originele tekst';

  @override
  String get autoTranslated => 'Automatisch vertaald';

  @override
  String get originalTapTranslation => 'Origineel · Tik voor vertaling';

  @override
  String get translatedTapOriginal => 'Vertaald · Tik voor origineel';

  @override
  String get justNow => 'Zojuist';

  @override
  String minutesAgo(int minutes) {
    return '$minutes min geleden';
  }

  @override
  String hoursAgo(int hours) {
    return '$hours uur geleden';
  }

  @override
  String daysAgo(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'dagen',
      one: 'dag',
    );
    return '$days $_temp0 geleden';
  }

  @override
  String get createdLabel => 'Aangemaakt';

  @override
  String get updatedLabel => 'Bijgewerkt';

  @override
  String get handlerLabel => 'Behandelaar';

  @override
  String get doneLabel => 'Afgehandeld';

  @override
  String get newTicketTitle => 'Nieuw ticket';

  @override
  String get categoryOptional => 'Categorie (optioneel)';

  @override
  String get selectCategory => 'Kies';

  @override
  String get subjectLabel => 'Onderwerp';

  @override
  String get fillAllFields => 'Vul alle velden in';

  @override
  String ticketCreatedId(int id) {
    return 'Ticket #$id aangemaakt';
  }

  @override
  String get priorityLabel => 'Prioriteit: ';

  @override
  String get supportOffline => 'Support offline';

  @override
  String get lastSeenSeconds => 'Laatst actief enkele seconden geleden';

  @override
  String lastSeenMinutes(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: 'minuten',
      one: 'minuut',
    );
    return 'Laatst actief $minutes $_temp0 geleden';
  }

  @override
  String lastSeenHours(int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: 'uur',
      one: 'uur',
    );
    return 'Laatst actief $hours $_temp0 geleden';
  }

  @override
  String lastSeenDays(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'dagen',
      one: 'dag',
    );
    return 'Laatst actief $days $_temp0 geleden';
  }

  @override
  String get online => 'Online';

  @override
  String get callSupport => 'Bellen';

  @override
  String get typeMessage => 'Typ een bericht...';

  @override
  String get callBusy => 'Support is bezet';

  @override
  String get callRejected => 'Oproep geweigerd';

  @override
  String get callFailed => 'Oproep kon niet verbinden';

  @override
  String get callEnded => 'Oproep beëindigd';

  @override
  String get callSupportBusy => 'Support is al in een ander gesprek';

  @override
  String get errorStartingChat => 'Fout bij starten chat';

  @override
  String get errorStartingCall => 'Fout bij starten oproep';

  @override
  String get errorConnecting => 'Verbindingsfout';

  @override
  String get errorDownloading => 'Fout bij downloaden';

  @override
  String get errorUploading => 'Fout bij uploaden';

  @override
  String get errorSending => 'Fout bij verzenden';

  @override
  String get errorPickingPhotos => 'Fout bij selecteren foto\'s';

  @override
  String get errorPickingFiles => 'Fout bij selecteren bestanden';

  @override
  String get errorTakingPhoto => 'Fout bij maken foto';

  @override
  String get fileNotLoaded => 'Bestand kon niet geladen worden';

  @override
  String get attachmentIdMissing => 'Bijlage-ID ontbreekt';

  @override
  String get camera => 'Camera';

  @override
  String get gallery => 'Galerij';

  @override
  String get file => 'Bestand';

  @override
  String get notifNewMessageFrom => 'Nieuw bericht van';

  @override
  String get notifUrgentPrefix => 'DRINGEND';

  @override
  String get notifUrgentMessage => 'DRINGEND BERICHT';

  @override
  String get notifIncomingCall => 'Inkomend gesprek';

  @override
  String get notifCallingYou => 'belt...';

  @override
  String get notifUpdateAvailable => 'Update beschikbaar';

  @override
  String get notifVersionAvailable => 'is nu beschikbaar';

  @override
  String get notifConnected => 'Verbonden';

  @override
  String get notifDisconnected => 'Verbinding verbroken';

  @override
  String get notifConnectedBody => 'U bent nu verbonden met de server.';

  @override
  String get notifDisconnectedBody =>
      'De verbinding met de server is verbroken.';

  @override
  String get notifError => 'Fout';

  @override
  String get retry => 'Opnieuw proberen';

  @override
  String get save => 'Opslaan';

  @override
  String get accept => 'Accepteren';

  @override
  String get selectFile => 'Bestand selecteren';

  @override
  String get dataLoadingText => 'Gegevens laden...';

  @override
  String get dataSavedSuccess => 'Gegevens succesvol opgeslagen';

  @override
  String get errorSaving => 'Fout bij opslaan';

  @override
  String get errorLoading => 'Fout bij laden';

  @override
  String savedFilename(String filename) {
    return 'Opgeslagen: $filename';
  }

  @override
  String get logsCopied => 'Logs gekopieerd!';

  @override
  String get passwordMinEightChars =>
      'Wachtwoord moet minimaal 8 tekens bevatten';

  @override
  String get passwordChangeSuccess => 'Wachtwoord succesvol gewijzigd';

  @override
  String get emailChangeError => 'Fout bij wijzigen e-mail';

  @override
  String get acceptDocumentCheckbox =>
      'Ik heb het document gelezen en accepteer het.';

  @override
  String loadingErrorGeneric(String details) {
    return 'Laadfout: $details';
  }

  @override
  String get incomingCallTitle => 'Inkomend gesprek';

  @override
  String ringingFor(int seconds) {
    return 'Belt al ${seconds}s';
  }

  @override
  String get rejectCall => 'Weigeren';

  @override
  String get acceptCall => 'Beantwoorden';

  @override
  String get unmute => 'Dempen opheffen';

  @override
  String get mute => 'Dempen';

  @override
  String get hangUp => 'Ophangen';

  @override
  String get calling => 'Bellen...';

  @override
  String autoRejectIn(int seconds) {
    return 'Automatisch weigeren over $seconds seconden';
  }

  @override
  String get speakerOn => 'Luidspreker';

  @override
  String get speakerOff => 'Oortelefoon';

  @override
  String get micMuted => 'Gedempt';

  @override
  String get micOn => 'Microfoon';

  @override
  String get connectionExcellent => 'Uitstekend';

  @override
  String get connectionGood => 'Goed';

  @override
  String get connectionWeak => 'Zwak';

  @override
  String get connectionLost => 'Verbroken';

  @override
  String get personalData => 'Persoonlijke gegevens';

  @override
  String get personalDataSubtitle => 'Voornaam, achternaam, adres';

  @override
  String get membershipFee => 'Lidmaatschapsbijdrage';

  @override
  String annualFeeYear(String year) {
    return 'Jaarlijkse bijdrage $year';
  }

  @override
  String get amount => 'Bedrag:';

  @override
  String get dueBy => 'Vervaldatum:';

  @override
  String get paid => 'Betaald';

  @override
  String get versionHistory => 'Versiegeschiedenis';

  @override
  String lastUpdated(String date) {
    return 'Laatst bijgewerkt: $date';
  }

  @override
  String get noVersionHistory => 'Geen versiegeschiedenis beschikbaar';

  @override
  String get failedLoadChangelog => 'Kan wijzigingslogboek niet laden';

  @override
  String get callMember => 'Lid bellen';

  @override
  String get closeConversation => 'Gesprek sluiten';

  @override
  String get chatOffline => 'Offline';

  @override
  String get attachFiles => 'Bestanden bijvoegen (max. 10, 50MB)';

  @override
  String get conversationClosed => 'Dit gesprek is gesloten';

  @override
  String get noMessages => 'Geen berichten';

  @override
  String get goBack => 'Terug';

  @override
  String get goForward => 'Vooruit';

  @override
  String get homePage => 'Startpagina';

  @override
  String get firstNameLabel => 'Voornaam';

  @override
  String get lastNameLabel => 'Achternaam';

  @override
  String get streetLabel => 'Straat';

  @override
  String get houseNumberLabel => 'Nr.';

  @override
  String get postalCodeLabel => 'Postcode';

  @override
  String get cityLabel => 'Stad';

  @override
  String get phoneMobileLabel => 'Telefoon (Mobiel)';

  @override
  String get phoneLandlineLabel => 'Telefoon (Vast)';

  @override
  String get newEmailLabel => 'Nieuw e-mailadres';

  @override
  String get currentPasswordLabel => 'Huidig wachtwoord';

  @override
  String get newPasswordLabel => 'Nieuw wachtwoord';

  @override
  String get confirmPasswordLabel => 'Wachtwoord bevestigen';

  @override
  String get emailChangedSuccess => 'E-mail succesvol gewijzigd';

  @override
  String get reasonLabel2 => 'Reden';

  @override
  String get downloadFailed2 => 'Download mislukt';

  @override
  String get downloadTooltip => 'Downloaden';

  @override
  String get copyLogs => 'Logs kopiëren';

  @override
  String get deleteLogs => 'Logs verwijderen';

  @override
  String get autoScrollOn => 'Automatisch scrollen AAN';

  @override
  String get autoScrollOff => 'Automatisch scrollen UIT';

  @override
  String get unknownValue => 'Onbekend';

  @override
  String get payment => 'Betaling';

  @override
  String get warningType_ermahnung => 'Waarschuwing';

  @override
  String get warningType_abmahnung => 'Vermaning';

  @override
  String get warningType_letzte => 'Laatste waarschuwing';

  @override
  String warningsTotal(int count) {
    return 'Totaal: $count';
  }

  @override
  String warningsErmahnung(int count) {
    return 'Waarschuwingen: $count';
  }

  @override
  String warningsAbmahnung(int count) {
    return 'Vermaningen: $count';
  }

  @override
  String warningsLetzte(int count) {
    return 'Laatste: $count';
  }

  @override
  String get noWarnings => 'Geen waarschuwingen';

  @override
  String get noWarningsDescription => 'U heeft momenteel geen waarschuwingen.';

  @override
  String createdBy(String name) {
    return 'Aangemaakt door: $name';
  }

  @override
  String get monthJan => 'Jan';

  @override
  String get monthFeb => 'Feb';

  @override
  String get monthMar => 'Mrt';

  @override
  String get monthApr => 'Apr';

  @override
  String get monthMay => 'Mei';

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
  String get stufe1_name => 'Persoonlijke gegevens';

  @override
  String get stufe2_name => 'Lidmaatschapstype';

  @override
  String get stufe3_name => 'Financiële situatie';

  @override
  String get stufe4_name => 'Betaalmethode';

  @override
  String get stufe5_name => 'Aanvang lidmaatschap';

  @override
  String get stufe6_name => 'Statuten';

  @override
  String get stufe7_name => 'Privacybeleid';

  @override
  String get stufe8_name => 'Herroepingsrecht';

  @override
  String get memberType_ordentlich => 'Gewoon lid';

  @override
  String get memberType_foerder => 'Steunend lid';

  @override
  String get memberType_ehren => 'Erelid';

  @override
  String get memberDesc_ordentlich =>
      'Actief lid met stemrecht. Neemt deel aan de diensten van de vereniging (e-mail, cloud, bureaucratische ondersteuning).';

  @override
  String get memberDesc_foerder =>
      'Ondersteunt de vereniging door bijdragen. Kan de algemene vergadering bijwonen met raadgevend stemrecht, zonder stemrecht of verkiesbaarheid in het bestuur.';

  @override
  String get memberDesc_ehren =>
      'Heeft de rechten van een gewoon lid zonder de verplichting om lidmaatschapsbijdragen te betalen. Benoemd door de algemene vergadering of het bestuur.';

  @override
  String get payMethod_ueberweisung => 'Bankoverschrijving';

  @override
  String get payMethod_dauerauftrag => 'Doorlopende opdracht';

  @override
  String get verifyStatus_geprueft => 'Geverifieerd';

  @override
  String get verifyStatus_ausgefuellt => 'Ingevuld';

  @override
  String get verifyStatus_abgelehnt => 'Afgewezen';

  @override
  String get verifyStatus_offen => 'Open';

  @override
  String get fillRequiredFields => 'Vul alle verplichte velden in.';

  @override
  String get personalDataSaved => 'Persoonlijke gegevens opgeslagen';

  @override
  String get selectMemberType => 'Selecteer een lidmaatschapstype.';

  @override
  String get memberTypeSaved => 'Lidmaatschapstype opgeslagen';

  @override
  String get selectOption => 'Selecteer een optie.';

  @override
  String get financialSaved => 'Financiële situatie opgeslagen';

  @override
  String get selectPaymentMethod => 'Selecteer een betaalmethode.';

  @override
  String get paymentDataSaved => 'Betalingsgegevens opgeslagen';

  @override
  String get selectDate => 'Selecteer een datum.';

  @override
  String get membershipStartSaved => 'Aanvangsdatum opgeslagen';

  @override
  String get fileTooLarge => 'Bestand te groot (max. 10 MB).';

  @override
  String get leistungsbescheidUploaded =>
      'Uitkeringsbeschikking succesvol geüpload';

  @override
  String get verificationProgress => 'Voortgang verificatie';

  @override
  String get notApplicable => 'Niet van toepassing';

  @override
  String get socialBenefitsExempt =>
      'Betaalmethode niet vereist voor ontvangers van sociale uitkeringen.';

  @override
  String get locked => 'Vergrendeld';

  @override
  String completePreviousStep(int step) {
    return 'Voltooi eerst stap $step.';
  }

  @override
  String rejectedNote(String note) {
    return 'Afgewezen: $note';
  }

  @override
  String get waitingForReview => 'Wacht op beoordeling door het bestuur.';

  @override
  String get stepApproved => 'Deze stap is beoordeeld en goedgekeurd.';

  @override
  String get changesViaChat => 'Wijzigingen alleen mogelijk via chat.';

  @override
  String get firstNameRequired => 'Voornaam *';

  @override
  String get lastNameRequired => 'Achternaam *';

  @override
  String get birthDateLabel => 'Geboortedatum *';

  @override
  String get streetRequired => 'Straat *';

  @override
  String get houseNumberRequired => 'Nr. *';

  @override
  String get cityRequired => 'Stad *';

  @override
  String get phoneRequired => 'Telefoonnummer *';

  @override
  String get phonePurpose => 'Doel: Contact wanneer niet bereikbaar via de app';

  @override
  String get selectMemberTypePrompt =>
      'Selecteer het gewenste lidmaatschapstype:';

  @override
  String get financialExplanation =>
      'Om te controleren of u in aanmerking komt voor korting op de bijdrage, hebben wij de volgende informatie nodig. Deze wordt uitsluitend gebruikt om uw lidmaatschapsbijdrage te bepalen.';

  @override
  String get socialBenefitsQuestion =>
      'Ontvangt u momenteel sociale uitkeringen?';

  @override
  String get optionBuergergeld => 'Ja, burgergeld (Jobcenter)';

  @override
  String get optionSozialamt => 'Ja, sociale bijstand (Sociale Dienst)';

  @override
  String get optionNoBenefits => 'Nee, ik ontvang geen sociale uitkeringen';

  @override
  String get feeExempt => 'Uw maandelijkse bijdrage is: € 0,00/maand';

  @override
  String get uploadLeistungsbescheid => 'Uitkeringsbeschikking uploaden';

  @override
  String get uploadLeistungsbescheidHint =>
      'Upload een actuele uitkeringsbeschikking binnen 14 dagen om de vrijstelling te bevestigen.';

  @override
  String get allowedFormatsUpload =>
      'Toegestane formaten: PDF, JPG, PNG (max. 10 MB)';

  @override
  String get feeRegular => 'Uw maandelijkse bijdrage is: € 25,00/maand';

  @override
  String paymentDayReminder(int day) {
    return 'U wordt herinnerd op de ${day}e van elke maand.';
  }

  @override
  String get membershipStartPrompt =>
      'Kies wanneer uw lidmaatschap moet beginnen.';

  @override
  String get optionAfterVerification => 'Na voltooiing van verificatie';

  @override
  String get optionAfterVerificationDesc =>
      'Lidmaatschap begint vanaf de dag van bestuursbevestiging.';

  @override
  String get optionRetroFoundation =>
      'Terugwerkend tot oprichtingsdatum (01.08.2025)';

  @override
  String get optionRetroFoundationDesc =>
      'U wordt een retroactief lid vanaf de oprichting van de vereniging.';

  @override
  String get optionRetroCustom => 'Terugwerkend tot een andere datum';

  @override
  String get optionRetroCustomDesc =>
      'Kies een datum tussen 01.08.2025 en vandaag.';

  @override
  String get selectDateLabel => 'Datum selecteren';

  @override
  String get selectDateHint => 'Datum selecteren...';

  @override
  String get dateNotBefore => 'Niet voor 01.08.2025 (oprichtingsdatum)';

  @override
  String get feeExemptRetro =>
      'Vrijstelling: € 0,00 terugwerkend.\nAlleen de lidmaatschapsdatum wordt terugwerkend ingesteld.';

  @override
  String get retroactiveFees => 'Terugwerkende bijdragen';

  @override
  String retroFeeCalculation(
      String from, String to, String months, String total) {
    return 'Periode: $from – $to\nMaanden: $months\nBijdrage: $months × € 25,00 = € $total';
  }

  @override
  String get pleaseReadSatzung => 'Lees de statuten van de vereniging.';

  @override
  String get pleaseReadDatenschutz => 'Lees het privacybeleid.';

  @override
  String get pleaseReadWiderruf => 'Lees het herroepingsrecht.';

  @override
  String get acceptedAtRegistration => 'Geaccepteerd bij registratie';

  @override
  String get confirmedByBoard =>
      'Wordt bevestigd na beoordeling door het bestuur.';

  @override
  String get docSatzung => 'Statuten';

  @override
  String get docDatenschutz => 'Privacybeleid';

  @override
  String get docWiderruf => 'Herroepingsrecht';

  @override
  String acceptedAtRegCount(int count) {
    return 'Geaccepteerd bij registratie ($count/3)';
  }

  @override
  String acceptedOn(String date) {
    return 'Geaccepteerd op $date';
  }

  @override
  String get notAccepted => 'Niet geaccepteerd';

  @override
  String get statusAccepted => 'Geaccepteerd';

  @override
  String get nameTooLong => 'Naam te lang (max 100 tekens)';

  @override
  String get emailTooLong => 'E-mail te lang (max 255 tekens)';

  @override
  String get legalAcknowledgePrefix => 'Ik heb het ';

  @override
  String get legalAcknowledgeSuffix => ' gelezen.';

  @override
  String get legalStatutesSuffix =>
      ' van ICD360S e.V. gelezen en erken deze als bindend.';

  @override
  String get legalPleaseReadFirst => '(lees eerst a.u.b.)';

  @override
  String get statusActive => 'Actief';

  @override
  String get statusSuspended => 'Geschorst';

  @override
  String get statusNew => 'Nieuw';

  @override
  String get statusCancelled => 'Opgezegd';

  @override
  String get statusDeleted => 'Verwijderd';

  @override
  String get roleMitglied => 'Lid';

  @override
  String get roleVorsitzer => 'Voorzitter';

  @override
  String get roleStellvertreter => 'Plaatsvervanger';

  @override
  String get roleSchatzmeister => 'Penningmeester';

  @override
  String get roleSchriftfuehrer => 'Secretaris';

  @override
  String get roleBeisitzer => 'Bijzitter';

  @override
  String get roleKassierer => 'Kassier';

  @override
  String get roleKassenpruefer => 'Kascommissaris';

  @override
  String get roleEhrenamtlich => 'Vrijwilliger';

  @override
  String get roleMitgliedergruender => 'Oprichtend Lid';

  @override
  String get roleEhrenmitglied => 'Erelid';

  @override
  String get roleFoerdermitglied => 'Steunend Lid';

  @override
  String get memberTypeNotSet => 'Nog niet ingesteld';

  @override
  String get payMethodSepa => 'SEPA-incasso';

  @override
  String get labelStatus => 'Status';

  @override
  String get labelMemberNumber => 'Lidnummer';

  @override
  String get labelRole => 'Rol';

  @override
  String get labelMemberType => 'Type lidmaatschap';

  @override
  String get labelPaymentMethod => 'Betaalmethode';

  @override
  String get labelRegisteredOn => 'Geregistreerd op';

  @override
  String get labelLastLogin => 'Laatst ingelogd';

  @override
  String get labelMemberSince => 'Lid sinds';

  @override
  String get neverLoggedIn => 'Nooit';

  @override
  String get notActivatedYet => 'Nog niet geactiveerd';

  @override
  String get tabVerification => 'Verificatie';

  @override
  String get tabWarnings => 'Waarschuwingen';

  @override
  String get tabDocuments => 'Documenten';

  @override
  String get tabMembership => 'Lidmaatschap';

  @override
  String get pleaseEnterFirstName => 'Voer voornaam in';

  @override
  String get pleaseEnterLastName => 'Voer achternaam in';

  @override
  String get noFileDataReceived => 'Geen gegevens ontvangen';

  @override
  String get openFile => 'Openen';

  @override
  String get noMicrophoneError =>
      'Geen microfoon gevonden. Sluit een microfoon aan en probeer opnieuw.';

  @override
  String get startConversation => 'Start een gesprek!';

  @override
  String get staffWillReply => 'Een medewerker zal u snel antwoorden.';

  @override
  String get inCall => 'In gesprek...';

  @override
  String get registration => 'Registratie';

  @override
  String get deactivation => 'Deactivering';

  @override
  String get deactivatedOn => 'Gedeactiveerd op';

  @override
  String get accountAutoSuspend =>
      'Accounts die niet binnen 30 dagen worden geverifieerd, worden automatisch opgeschort.';

  @override
  String get documentsProvidedByBoard =>
      'Documenten worden door het bestuur verstrekt.';

  @override
  String get noDocumentsAvailable => 'Geen documenten beschikbaar';

  @override
  String get noDocumentsDescription =>
      'Er zijn nog geen documenten voor u beschikbaar gesteld.';

  @override
  String uploadedBy(String name) {
    return 'Geüpload door: $name';
  }

  @override
  String stepsCompleted(int completed, int total) {
    return '$completed/$total stappen voltooid';
  }

  @override
  String dayOfMonth(int day) {
    return '${day}e van de maand';
  }

  @override
  String changeField(String field) {
    return '$field wijzigen';
  }

  @override
  String openDocument(String name) {
    return '$name openen';
  }

  @override
  String logEntries(int count) {
    return '$count vermeldingen';
  }

  @override
  String get noLogs => 'Geen logs';

  @override
  String get newLoginDetected => 'Nieuwe aanmelding gedetecteerd';

  @override
  String get errorNoInternet =>
      'Geen internetverbinding. Controleer uw netwerk.';

  @override
  String get errorTimeout => 'Server reageert niet. Probeer het later opnieuw.';

  @override
  String get errorServer => 'Serverfout. Probeer het later opnieuw.';

  @override
  String get errorConnection => 'Verbindingsfout. Probeer het later opnieuw.';

  @override
  String get errorUnexpected =>
      'Er is een onverwachte fout opgetreden. Probeer het later opnieuw.';

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
  String get claudiuWelcomeMorning => 'Goedemorgen';

  @override
  String get claudiuWelcomeDay => 'Hallo';

  @override
  String get claudiuWelcomeEvening => 'Goedenavond';

  @override
  String get claudiuWelcomeNight => 'Goedenavond';

  @override
  String get claudiuWelcomeVisitor => 'beste bezoeker';

  @override
  String get claudiuWelcomeAsk => 'Hoe kan ik je helpen?';

  @override
  String get claudiuWelcomeBecomeMember => 'Ik wil lid worden';

  @override
  String get claudiuWelcomeLogin => 'Ik ben al lid en wil inloggen';

  @override
  String get claudiuWelcomeProblem => 'Ik heb een probleem met de app';

  @override
  String get claudiuWelcomeEmergency => 'Spoed — bel ons';

  @override
  String get claudiuWelcomeMascotName => 'Claudiu';

  @override
  String get claudiuWelcomeEmergencyIntro =>
      'Voor je belt — onze openingstijden:';

  @override
  String get claudiuWelcomeScheduleOffice => 'Op kantoor';

  @override
  String get claudiuWelcomeScheduleField => 'In het veld met cliënten';

  @override
  String get claudiuWelcomeOutsideHoursNote =>
      'Buiten deze tijden behandelen we alleen spoedgevallen. Je kunt ook een sms naar hetzelfde nummer sturen — we bellen je terug.';

  @override
  String get claudiuWelcomeCallNow => 'Bel nu';

  @override
  String get claudiuWelcomeSendSms => 'Stuur sms';

  @override
  String get claudiuWelcomeSmsBody =>
      'Spoed ICD360S e.V. — neem alstublieft zo snel mogelijk contact op.';

  @override
  String get claudiuWelcomeCloseButton => 'Sluiten';

  @override
  String get claudiuLoginWelcome => 'Welkom terug, beste lid!';

  @override
  String get claudiuLoginAsk => 'Vertel me je lidnummer.';

  @override
  String get claudiuLoginProgress => 'Bijna… blijf typen.';

  @override
  String get claudiuLoginReady => 'Perfect! Druk op de knop hieronder.';

  @override
  String get claudiuLoginLoading => 'Identiteit controleren… 🔍';

  @override
  String get claudiuLoginFoundPlain => 'Gevonden! Je wordt ingelogd…';

  @override
  String claudiuLoginFoundNamed(String name) {
    return 'Gevonden, $name! Je wordt ingelogd…';
  }

  @override
  String get claudiuLoginError =>
      'Hm, ik kan dat nummer niet vinden. Klopt het wel?';

  @override
  String get claudiuLoginForgotHeader => 'Lidnummer vergeten?';

  @override
  String get claudiuLoginNoSms =>
      'We versturen het nummer niet via e-mail of sms.';

  @override
  String get claudiuLoginOnlyWay =>
      'De enige manier: een persoonlijke afspraak op het verenigingskantoor, na ID-controle.';

  @override
  String get claudiuLoginContactUs => 'Bel ons voor een afspraak:';

  @override
  String get claudiuDiagnosticGreeting =>
      'Voor je naar binnen gaat, één snelle vraag';

  @override
  String get claudiuDiagnosticAsk =>
      'Mag ik anonieme rapporten sturen zodat de ontwikkelaars de app kunnen verbeteren?';

  @override
  String get claudiuDiagnosticYes => 'Ja, ik wil helpen';

  @override
  String get claudiuDiagnosticNo => 'Nee, ik kijk alleen rond';

  @override
  String get claudiuDiagnosticTellMore => 'Vertel me meer';

  @override
  String get claudiuDiagnosticSendsHeader => '📤 Wat we VERSTUREN (anoniem):';

  @override
  String get claudiuDiagnosticSends1 =>
      'Een anonieme apparaatcode (NIET je lidnummer)';

  @override
  String get claudiuDiagnosticSends2 => 'Je rol (lid / bestuur)';

  @override
  String get claudiuDiagnosticSends3 =>
      'Besturingssysteem (Linux / Android / iOS / Windows)';

  @override
  String get claudiuDiagnosticSends4 => 'Gekozen taal';

  @override
  String get claudiuDiagnosticSends5 => 'Batterijniveau en -status';

  @override
  String get claudiuDiagnosticSends6 => 'Huidig scherm';

  @override
  String get claudiuDiagnosticSends7 => 'Sessieduur (seconden)';

  @override
  String get claudiuDiagnosticSends8 => 'Eventuele fouten (laatste 10)';

  @override
  String get claudiuDiagnosticSends9 => 'Navigatie (laatste 20 schermen)';

  @override
  String get claudiuDiagnosticNeverHeader => '🛡️ Wat we NOOIT versturen:';

  @override
  String get claudiuDiagnosticNever1 => 'Je echte naam';

  @override
  String get claudiuDiagnosticNever2 => 'E-mailadres';

  @override
  String get claudiuDiagnosticNever3 => 'Telefoonnummer';

  @override
  String get claudiuDiagnosticNever4 => 'Wachtwoord';

  @override
  String get claudiuDiagnosticNever5 => 'Inhoud van chatberichten';

  @override
  String get claudiuDiagnosticNever6 => 'Inhoud van tickets';

  @override
  String get claudiuDiagnosticNever7 => 'Documenten of bijlagen';

  @override
  String get claudiuDiagnosticTechHeader => '📡 Technische details:';

  @override
  String get claudiuDiagnosticTech1 => 'Elke 2 minuten verzonden';

  @override
  String get claudiuDiagnosticTech2 =>
      'TLS-versleutelde verbinding, vastgepinned certificaat';

  @override
  String get claudiuDiagnosticTech3 =>
      'Je kunt het op elk moment uitzetten in Instellingen';

  @override
  String get claudiuProblemHelpTitle => 'Hoe kan ik helpen?';

  @override
  String get claudiuProblemHelpGreeting => 'Wat is er gebeurd?';

  @override
  String get claudiuProblemHelpAsk => 'Hoe wil je het me vertellen?';

  @override
  String get claudiuProblemHelpWriteTitle => 'Schrijf een rapport';

  @override
  String get claudiuProblemHelpWriteBody =>
      'Met stap-voor-stap details. Het team ontvangt de tekst en lost het later op.';

  @override
  String get claudiuProblemHelpChatTitle => 'Laten we nu praten';

  @override
  String get claudiuProblemHelpChatBody =>
      'Anonieme chat met een medewerker. Realtime antwoord als iemand online is.';

  @override
  String get claudiuProblemHelpAltCallHeader => 'Of, als het urgent is:';

  @override
  String get claudiuProblemHelpAltCallLabel => 'Bel ons';

  @override
  String get claudiuAnonymousChatTitle => 'Anonieme chat';

  @override
  String get claudiuAnonymousChatGreeting => 'Hoi!';

  @override
  String get claudiuAnonymousChatWelcome =>
      'Ik luister. Schrijf wat je wilt — geen naam nodig. Ik antwoord zodra ik er ben.';

  @override
  String get claudiuAnonymousChatHint => 'Schrijf een bericht…';

  @override
  String get claudiuAnonymousChatWaitingOperator =>
      'Wachten op antwoord van een medewerker…';

  @override
  String get claudiuVorsitzerConnectedTitle => 'Hoi!';

  @override
  String get claudiuVorsitzerConnectedBody =>
      'Bedankt dat je contact opneemt — je hebt nu een Vorsitzer aan de lijn. Vertel ons hoe we je kunnen helpen met je lidmaatschapsaanvraag.';

  @override
  String get claudiuVorsitzerConnectedSender => 'Vorsitzer';

  @override
  String get claudiuQuickReplyValidationTime => 'Hoe lang duurt de controle?';

  @override
  String get claudiuQuickReplyDocuments => 'Welke documenten heb ik nodig?';

  @override
  String get claudiuQuickReplyStepProblem => 'Ik loop vast bij een stap';

  @override
  String get claudiuQuickReplyHuman => 'Kan ik nu iemand spreken?';

  @override
  String get claudiuAnonymousChatConnecting => 'Verbinden…';

  @override
  String get claudiuAnonymousChatConnectionFailed =>
      'Kon de chat niet openen. Probeer opnieuw of bel ons.';

  @override
  String get claudiuAnonymousChatRetry => 'Opnieuw proberen';

  @override
  String get claudiuAnonymousChatOnline => 'Verbonden';

  @override
  String get claudiuAnonymousChatOffline => 'Opnieuw verbinden…';

  @override
  String get claudiuAnonymousChatAdminTyping => 'Medewerker is aan het typen…';

  @override
  String get claudiuProblemReportTitle => 'Meld een probleem';

  @override
  String get claudiuProblemReportGreeting => 'Wat is er gebeurd?';

  @override
  String get claudiuProblemReportAsk =>
      'Vertel het in detail en ik stuur het rapport door naar het team.';

  @override
  String get claudiuProblemReportIncludeHeader => 'Vermeld a.u.b.:';

  @override
  String get claudiuProblemReportIncludeBullets1 =>
      'Wat je deed toen het probleem optrad';

  @override
  String get claudiuProblemReportIncludeBullets2 =>
      'Eventuele foutmelding die je zag';

  @override
  String get claudiuProblemReportIncludeBullets3 => 'Op welk scherm je was';

  @override
  String get claudiuProblemReportIncludeBullets4 =>
      'Crasht de app, sluit hij, of toont een wit scherm?';

  @override
  String get claudiuProblemReportIncludeBullets5 =>
      'Gebeurt het elke keer of slechts één keer?';

  @override
  String get claudiuProblemReportDescriptionLabel => 'Jouw beschrijving';

  @override
  String get claudiuProblemReportDescriptionHint =>
      'Bv.: Als ik het chatscherm open krijg ik \'Connection error\' en de app reageert niet meer…';

  @override
  String claudiuProblemReportTooShort(int count) {
    return 'Iets meer details alstublieft (minimaal $count tekens)';
  }

  @override
  String get claudiuProblemReportSubmit => 'Verzend rapport';

  @override
  String get claudiuProblemReportSubmitting => 'Versturen…';

  @override
  String get claudiuProblemReportSentTitle => 'Bedankt!';

  @override
  String get claudiuProblemReportSentBody =>
      'Het rapport is verzonden. Ons team kijkt er zo snel mogelijk naar.';

  @override
  String get claudiuProblemReportSentClose => 'Begrepen';

  @override
  String get claudiuProblemReportSendFailed =>
      'Kon het rapport niet versturen. Bel ons voor dringende hulp.';

  @override
  String get claudiuProblemReportAlt => 'Of, als het urgent is:';

  @override
  String get claudiuProblemReportCallLabel => 'Bel ons';

  @override
  String claudiuApprovalGreeting(String name) {
    return 'Hoi, $name! 👋';
  }

  @override
  String get claudiuApprovalGreetingNoName => 'Hoi! 👋';

  @override
  String get claudiuApprovalGladToSeeYou => 'Fijn dat je er bent!';

  @override
  String get claudiuApprovalCheckingForSafety =>
      'Voor jouw veiligheid controleert een Vorsitzer nu je inlogverzoek. 🛡️';

  @override
  String get claudiuApprovalMonthlyExplain =>
      '💡 We doen dit elke 30 dagen om zeker te weten dat jij het bent. Het is als een veiligheidscheck — duurt maximaal 5 minuten.';

  @override
  String get claudiuApprovalSuccess =>
      'Klaar! 🎉 De Vorsitzer heeft je herkend. Je wordt ingelogd…';

  @override
  String get claudiuApprovalDenied =>
      'Hm, de Vorsitzer heeft je verzoek afgewezen. 😔';

  @override
  String get claudiuApprovalDeniedHelp =>
      'Als je denkt dat dit een vergissing is, bel ons dan om het op te helderen.';

  @override
  String get claudiuApprovalExpired =>
      'De 5 minuten zijn voorbij en we hebben niets van de Vorsitzer gehoord.';

  @override
  String get claudiuApprovalExpiredHelp =>
      'Bel ons en we kunnen je verzoek direct goedkeuren. 📞';

  @override
  String get claudiuApprovalCallUs => 'Bel ons';

  @override
  String get claudiuApprovalTryAgain => 'Opnieuw proberen';

  @override
  String get claudiuApprovalCancel => 'Annuleren';

  @override
  String get claudiuApprovalClose => 'Sluiten';

  @override
  String get wizardIntroBubble1 =>
      'Hoi, bezoeker! 👋 Bedankt dat je deel wilt uitmaken van onze familie.';

  @override
  String get wizardIntroBubble2 =>
      'Mijn naam is Claudiu. In het voorjaar van 2025 had ik een duidelijke visie: een vereniging oprichten die mensen in nood helpt — vrijwillig, vanuit het hart, zonder onnodige bureaucratie. ❤️';

  @override
  String get wizardIntroBubble3 =>
      'Ik begon te praten met de cliënten die ik bezocht. Ik vertelde hen mijn droom. En iedereen zei: \"Ja, doe het!\" In juli 2025 kwamen we bij elkaar — 6 vastberaden mensen. We besloten **ICD360S e.V.** in Neu-Ulm op te richten. 📍';

  @override
  String get wizardIntroBubble4 =>
      'Op **1 augustus 2025** kwam de vereniging officieel tot leven — in het verenigingenregister. Mijn mooiste cadeau. 🎂';

  @override
  String get wizardIntroBubble5 =>
      'Wat doen we? We helpen vluchtelingen, mensen met een beperking, economisch achtergestelden, **kinderen en jongeren** — met administratieve zaken, Duits, huisvesting, boodschappen, sociale uitkeringen. Onze Vorstand bestaat grotendeels uit mensen met een beperking — zo komen beslissingen voort uit echte levenservaring. 🤝';

  @override
  String get wizardIntroBubble6 =>
      'Nu is het jouw beurt. Laten we je inschrijven — duurt zo\'n 5 minuten. We gaan stap voor stap, ik laat je niet alleen. ✨';

  @override
  String get wizardIntroStart => 'Laten we beginnen';

  @override
  String get wizardBack => 'Terug';

  @override
  String get wizardNext => 'Verder';

  @override
  String wizardStepLabel(int step, int total, String title) {
    return 'Stap $step van $total · $title';
  }

  @override
  String get wizardErrRequired => 'Dit veld is verplicht';

  @override
  String wizardErrTooShort(int count) {
    return 'Te kort (minimaal $count tekens)';
  }

  @override
  String get wizardErrOnlyLetters =>
      'Alleen letters, spaties, koppeltekens en apostrofs';

  @override
  String get wizardErrSaveFailed =>
      'Opslaan mislukt. Controleer je verbinding en probeer opnieuw.';

  @override
  String get wizardStufe1aTitle => 'Identiteit';

  @override
  String get wizardStufe1aPrompt =>
      'Laten we officieel kennismaken. Schrijf je naam precies zoals hij op je Personalausweis, Reisepass of Aufenthaltstitel staat — zo blijft het consistent met je documenten.';

  @override
  String get wizardStufe1aVornameLabel => 'Vornamen (voornamen)';

  @override
  String get wizardStufe1aVornameHelper =>
      'Al je voornamen, precies zoals op het document. Met spatie of koppelteken (bv. Hans-Peter, Maria Anna).';

  @override
  String get wizardStufe1aNachnameLabel => 'Familienname (achternaam)';

  @override
  String get wizardStufe1aNachnameHelper => 'Je huidige achternaam.';

  @override
  String get wizardStufe1aGeburtsnameLabel =>
      'Geburtsname (geboortenaam) — optioneel';

  @override
  String get wizardStufe1aGeburtsnameHelper =>
      'Alleen als het verschilt van Familienname — bv. vóór het huwelijk.';

  @override
  String get wizardStufe1bTitle => 'Verjaardag';

  @override
  String get wizardStufe1bPrompt =>
      'We willen je verjaardag graag samen vieren! 🎂 En het helpt ons te bevestigen dat je minstens 16 bent — dat staat in onze statuten.';

  @override
  String get wizardStufe1bGeburtsdatumLabel => 'Geboortedatum';

  @override
  String get wizardStufe1bGeburtsdatumHelper => 'Tik om een datum te kiezen';

  @override
  String get wizardStufe1bGeburtsortLabel => 'Geboorteplaats';

  @override
  String get wizardStufe1bGeburtsortHelper =>
      'Stad / plaats waar je geboren bent.';

  @override
  String get wizardAgeGatePrompt => 'Het spijt me… 😔';

  @override
  String wizardAgeGateBody1(int age, int years) {
    return 'Onze statuten zeggen dat je minstens 16 moet zijn om lid te worden. Je bent $age — ik hoop dat we elkaar over $years jaar weerzien! 🌱';
  }

  @override
  String get wizardAgeGateBody2 =>
      'Wil je af en toe vrijwilligerswerk doen (elke leeftijd, met toestemming van je ouders), bel ons — we steunen graag jongeren die de wereld willen veranderen.';

  @override
  String get wizardAgeGateBackHome => 'Terug naar welkom';

  @override
  String get wizardErrInvalidPhone => 'Ongeldig telefoonnummer';

  @override
  String get wizardStufe1b1Title => 'Toestemming ouder';

  @override
  String get wizardStufe1b1Prompt =>
      'Je bent minderjarig (16-17) — volgens §106 BGB hebben we toestemming van een ouder of wettelijke voogd nodig. Geef me de naam en telefoonnummer. Een Vorsitzer belt en regelt een afspraak (in persoon of videogesprek). Geen e-mail — we willen zeker weten dat we de juiste persoon spreken.';

  @override
  String get wizardStufe1b1VornameLabel => 'Voornaam ouder';

  @override
  String get wizardStufe1b1VornameHelper =>
      'Zoals op de Personalausweis van de ouder.';

  @override
  String get wizardStufe1b1NachnameLabel => 'Achternaam ouder';

  @override
  String get wizardStufe1b1NachnameHelper =>
      'Zoals op de Personalausweis van de ouder.';

  @override
  String get wizardStufe1b1TelefonLabel => 'Mobiel ouder';

  @override
  String get wizardStufe1b1TelefonHelper => 'Een Vorsitzer belt dit nummer.';

  @override
  String get wizardStufe1b1RelationLabel => 'Relatie tot het kind:';

  @override
  String get wizardStufe1b1RelationMutter => 'Moeder';

  @override
  String get wizardStufe1b1RelationVater => 'Vader';

  @override
  String get wizardStufe1b1RelationSorgeberechtigter => 'Wettelijke voogd';

  @override
  String get wizardStufe1b1RelationAndere => 'Andere voogd';

  @override
  String get wizardStufe1cTitle => 'Persoonlijke gegevens';

  @override
  String get wizardStufe1cPrompt =>
      'Gewoon om je iets beter te leren kennen. Dit blijft tussen ons en wordt nergens openbaar getoond.';

  @override
  String get wizardStufe1cGeschlechtLabel => 'Geslacht';

  @override
  String get wizardStufe1cGeschlechtMaennlich => 'Man';

  @override
  String get wizardStufe1cGeschlechtWeiblich => 'Vrouw';

  @override
  String get wizardStufe1cGeschlechtDivers => 'Divers';

  @override
  String get wizardStufe1cGeschlechtKeineAngabe => 'Liever niet zeggen';

  @override
  String get wizardStufe1cFamilienstandLabel => 'Burgerlijke staat';

  @override
  String get wizardStufe1cFamilienstandLedig => 'Ongehuwd';

  @override
  String get wizardStufe1cFamilienstandVerheiratet => 'Gehuwd';

  @override
  String get wizardStufe1cFamilienstandGeschieden => 'Gescheiden';

  @override
  String get wizardStufe1cFamilienstandVerwitwet => 'Weduwe/Weduwnaar';

  @override
  String get wizardStufe1dTitle => 'Je achtergrond';

  @override
  String get wizardStufe1dPrompt =>
      'Dit helpt ons je de juiste ondersteuning te bieden — bijvoorbeeld advies over Aufenthalt of je taalgemeenschap vinden.';

  @override
  String get wizardStufe1dStaatLabel => 'Nationaliteit';

  @override
  String get wizardStufe1dStaatHelper =>
      'Bv. deutsch, rumänisch, ukrainisch. Meerdere met komma.';

  @override
  String get wizardStufe1dAufenthaltLabel =>
      'Verblijfsstatus (Aufenthaltsstatus) — optioneel';

  @override
  String get wizardStufe1dAufenthaltHelper =>
      'Kies de titel uit je Aufenthaltskarte / beslissing. De Vorstand vergelijkt met je documenten.';

  @override
  String get wizardStufe1dAufenthaltAwaitingCitizenship =>
      'Vul eerst de nationaliteit hierboven in — we tonen alleen de relevante opties.';

  @override
  String get wizardStufe1dAufenthaltGerman =>
      'Geen Aufenthaltstitel nodig — Duits staatsburger.';

  @override
  String get wizardStufe1dAufenthaltEuEea =>
      'EU/EER/CH-burger — vrij verkeer (Freizügigkeit).';

  @override
  String get wizardStufe1dAufenthaltTempHint => 'tijdelijk';

  @override
  String get wizardStufe1dAufenthaltPermHint => 'permanent verblijf';

  @override
  String get wizardStufe1dAufenthaltAsylumProcessHint => 'asielprocedure';

  @override
  String get wizardStufe1dAufenthaltOther => 'Anders (geef aan in de chat)';

  @override
  String get wizardStufe1dAufenthaltRequired => 'Kies een Aufenthaltstitel.';

  @override
  String get wizardStufe1dMutterspracheLabel => 'Moedertaal';

  @override
  String get wizardStufe1dMutterspracheHelper =>
      'Vooraf ingevuld met de app-taal — wijzig indien anders.';

  @override
  String get wizardStufe1eTitle => 'Adres';

  @override
  String get wizardStufe1ePrompt =>
      'Je postadres — we gebruiken het voor officiële documenten (statuten, lidcontracten, kennisgevingen).';

  @override
  String get wizardStufe1eStrasseLabel => 'Straat';

  @override
  String get wizardStufe1eStrasseHelper =>
      'Alleen de straatnaam — het huisnummer in het veld ernaast.';

  @override
  String get wizardStufe1eHausnummerLabel => 'Nr.';

  @override
  String get wizardStufe1ePlzLabel => 'PLZ (postcode)';

  @override
  String get wizardStufe1eOrtLabel => 'Plaats';

  @override
  String get wizardStufe1eLandLabel => 'Land';

  @override
  String get wizardStufe1eLandHelper => 'Vooraf ingevuld: Deutschland.';

  @override
  String get wizardErrInvalidStreet => 'Ongeldige straatnaam';

  @override
  String get wizardErrInvalidHausnummer =>
      'Ongeldig nummer (bv. 12, 12a, 12/3)';

  @override
  String get wizardErrInvalidPlz => 'Ongeldige postcode (alleen cijfers)';

  @override
  String get wizardStufe1fTitle => 'Contact';

  @override
  String get wizardStufe1fPrompt =>
      'Hoe bereiken we je? De telefoon is alleen voor noodgevallen — al het andere gaat via ons eigen end-to-end versleutelde kanaal in de app. Je lid-e-mail wordt automatisch toegekend en zie je hieronder.';

  @override
  String get wizardStufe1fTelefonLabel => 'Mobiel';

  @override
  String get wizardStufe1fTelefonHelper =>
      'Beloof dat ik alleen bel als het belangrijk is. 📱';

  @override
  String get wizardStufe2Title => 'Type lidmaatschap';

  @override
  String get wizardStufe2Prompt =>
      'Wat voor lid wil je zijn? Laat me elke optie uitleggen.';

  @override
  String get wizardStufe2OrdentlichTitle => 'Gewoon lid (ordentlich)';

  @override
  String get wizardStufe2OrdentlichBody =>
      'Volledige rechten. Je betaalt de maandelijkse contributie, stemt op de ledenvergadering, kunt in het bestuur worden gekozen. De standaardkeuze.';

  @override
  String get wizardStufe2FoerderTitle => 'Steunend lid (Fördermitglied)';

  @override
  String get wizardStufe2FoerderBody =>
      'Je steunt de vereniging financieel maar neemt geen actief deel aan beslissingen. Geen stemrecht. Goed als je van afstand wilt helpen.';

  @override
  String get wizardStufe2EhrenTitle => 'Erelid (Ehrenmitglied)';

  @override
  String get wizardStufe2EhrenBody =>
      'Wordt door het bestuur toegekend voor bijzondere verdiensten. Je kiest het niet zelf — het wordt verleend als erkenning. Kies alleen als je al geëerd bent.';

  @override
  String get wizardStufe3Title => 'Financiële situatie';

  @override
  String get wizardStufe3Prompt =>
      'Nu over je financiële situatie. Niet om te oordelen — alleen om je vrij te stellen van contributie als je sociale uitkeringen ontvangt.';

  @override
  String get wizardStufe3OptionBuergergeld => 'Ik ontvang Bürgergeld';

  @override
  String get wizardStufe3OptionSozialamt =>
      'Ik ontvang uitkeringen van Sozialamt';

  @override
  String get wizardStufe3OptionNein => 'Ik ontvang geen van deze';

  @override
  String get wizardStufe3FeeExemptTitle => 'Contributie: € 0 / maand 🎉';

  @override
  String get wizardStufe3FeeExemptBody =>
      'Met Bürgergeld, Sozialamt, ALG I of Krankengeld ben je volgens Satzung §6 volledig vrijgesteld van contributie. We hebben alleen een bewijs nodig (Leistungsbescheid of verklaring van de instantie / zorgverzekeraar).';

  @override
  String get wizardStufe3UploadTitle => 'Leistungsbescheid uploaden';

  @override
  String get wizardStufe3UploadHint => 'PDF / JPG / PNG, max 10 MB.';

  @override
  String get wizardStufe3UploadRequired =>
      'Upload de Leistungsbescheid voordat je verder gaat.';

  @override
  String get wizardStufe3FileTooLarge => 'Bestand te groot. Maximaal 10 MB.';

  @override
  String get wizardStufe3UploadFailed =>
      'Bestand uploaden mislukt. Probeer opnieuw.';

  @override
  String get wizardStufe3RegularFeeTitle => 'Contributie: € 25 / maand';

  @override
  String get wizardStufe3RegularFeeBody =>
      'De standaardcontributie voor gewone leden volgens onze statuten.';

  @override
  String get wizardStufe4Title => 'Betaling';

  @override
  String get wizardStufe4Prompt =>
      'Hoe wil je de contributie betalen? En op welke dag van de maand?';

  @override
  String get wizardStufe4MethodUeberweisungTitle =>
      'Overschrijving (Überweisung)';

  @override
  String get wizardStufe4MethodUeberweisungBody =>
      'Je begint elke maand zelf de betaling vanaf je rekening.';

  @override
  String get wizardStufe4MethodSepaTitle =>
      'SEPA-Lastschrift (automatische incasso)';

  @override
  String get wizardStufe4MethodSepaBody =>
      'We schrijven het bedrag automatisch van je rekening af. Het handigst, maar we hebben je IBAN en een ondertekend mandaat nodig.';

  @override
  String get wizardStufe4MethodDauerauftragTitle =>
      'Dauerauftrag (vaste opdracht)';

  @override
  String get wizardStufe4MethodDauerauftragBody =>
      'Je stelt een vaste opdracht in bij je bank. Je bank maakt het bedrag elke maand automatisch over.';

  @override
  String get wizardStufe4DayLabel => 'Betalingsdag';

  @override
  String get wizardStufe4DayHint => 'Kies een dag tussen 1 en 31';

  @override
  String wizardStufe4DayItem(int day) {
    return 'Dag $day';
  }

  @override
  String wizardStufe4DayReminder(int day) {
    return 'De contributie wordt op de ${day}e van elke maand afgeschreven.';
  }

  @override
  String get wizardStufe5Title => 'Begin';

  @override
  String get wizardStufe5Prompt =>
      'Vanaf wanneer wil je officieel ICD360S-lid zijn? Vanaf de goedkeuring of met terugwerkende kracht.';

  @override
  String get wizardStufe5OptionAbVerifizierungTitle =>
      'Vanaf de goedkeuring van het Vorstand';

  @override
  String get wizardStufe5OptionAbVerifizierungBody =>
      'De eenvoudigste keuze. Geen contributie met terugwerkende kracht.';

  @override
  String get wizardStufe5OptionGruendungsdatumTitle =>
      'Met terugwerkende kracht vanaf 01.08.2025 (oprichting)';

  @override
  String get wizardStufe5OptionGruendungsdatumBody =>
      'Je telt als lid vanaf de eerste dag van de vereniging.';

  @override
  String get wizardStufe5OptionAnderesDatumTitle => 'Een andere datum';

  @override
  String get wizardStufe5OptionAnderesDatumBody =>
      'Je kiest zelf een datum tussen 01.08.2025 en vandaag.';

  @override
  String get wizardStufe5PickDate => 'Tik om een datum te kiezen';

  @override
  String get wizardStufe5PickDateFirst => 'Kies eerst een datum.';

  @override
  String get wizardStufe5DatePickerHelp => 'Begin van het lidmaatschap';

  @override
  String wizardStufe5DateRange(String start) {
    return 'Tussen $start en vandaag';
  }

  @override
  String get wizardStufe5RetroactiveTitle =>
      'Contributie met terugwerkende kracht';

  @override
  String wizardStufe5RetroactiveBody(
      String start, String end, int months, String amount) {
    return 'Van $start tot $end zijn dat $months maanden. Bij € 25/maand komt dat op € $amount met terugwerkende kracht te betalen, bovenop de huidige maandcontributie.';
  }

  @override
  String get wizardStufe5FeeExemptTitle =>
      'Contributie met terugwerkende kracht: € 0 🎉';

  @override
  String get wizardStufe5FeeExemptBody =>
      'Met Bürgergeld of Sozialamt ben je volledig vrijgesteld — ook met terugwerkende kracht ben je niets verschuldigd.';

  @override
  String wizardDocumentPrompt(String doc) {
    return 'Voor we afronden, lees alsjeblieft de $doc aandachtig. Het is belangrijk dat je weet wat je tekent.';
  }

  @override
  String get wizardDocumentScrollHint => 'Scroll naar beneden om door te gaan.';

  @override
  String get wizardDocumentScrolledOk => 'Je hebt tot het einde gelezen ✓';

  @override
  String wizardDocumentOpenButton(String doc) {
    return '$doc openen in browser';
  }

  @override
  String get wizardDocumentExternalHint =>
      'Op dit platform openen we het document in je standaardbrowser.';

  @override
  String get wizardDocumentOpenedOk =>
      'Het document is geopend. Lees het aandachtig.';

  @override
  String wizardDocumentConfirm(String doc) {
    return 'Ik bevestig dat ik $doc heb gelezen en ermee akkoord ga.';
  }

  @override
  String get wizardFinalAdultTitle => 'Klaar! Je bent ingeschreven 🎉';

  @override
  String get wizardFinalMinorTitle => 'Je verzoek is verzonden 📨';

  @override
  String get wizardFinalMinorBody =>
      'We nemen contact op met je ouder en regelen een afspraak (in persoon of videogesprek). Heb geduld — het proces kan tot 7 dagen duren. Je krijgt een melding in de app zodra je ouder heeft goedgekeurd.';

  @override
  String get wizardFinalMitgliedernummerLabel => 'Je lidnummer';

  @override
  String get wizardStufe4MethodComingSoon => 'Binnenkort beschikbaar';

  @override
  String get wizardStufe4StreichungWarning =>
      'Als je meer dan 6 maanden achterloopt met de contributie, schrappen we je automatisch (Satzung §6 Abs. 3).';

  @override
  String get wizardStufe5KuendigungInfo =>
      'Om je af te melden: stuur de opzegging schriftelijk 3 maanden vóór 31 december (uiterlijk 30 september voor ingang aan het einde van het jaar). Geen minimale duur (Satzung §6 Abs. 3).';

  @override
  String get wizardStufe1fEmailLabel => 'Je lid-e-mail';

  @override
  String get wizardStufe1fEmailHelper =>
      'Wordt automatisch toegekend op basis van je lidnummer. Wordt geactiveerd zodra het bestuur (Vorstand) je aanvraag goedkeurt. We hebben onze eigen e-mailapp — verstuur en ontvang versleutelde e-mails, eenvoudig en gratis.';

  @override
  String get wizardErrInvalidEmail => 'Ongeldig e-mailadres';

  @override
  String get wizardStufe3OptionAlg1 =>
      'Ik ontvang Arbeitslosengeld I (ALG I, WW-uitkering)';

  @override
  String get wizardStufe3OptionKrankengeld =>
      'Ik ontvang Krankengeld (langdurige ziekteuitkering)';

  @override
  String get wizardStufe3UploadAddMore => 'Nog een document toevoegen';

  @override
  String get wizardStufe3UploadLimitCount =>
      'Limiet bereikt: maximaal 20 documenten.';

  @override
  String get wizardStufe3UploadLimitTotal =>
      'Totale limiet van 100 MB bereikt. Verwijder een bestaand bestand.';

  @override
  String get wizardStufe3UploadDeleteTooltip => 'Verwijderen';

  @override
  String wizardStufe3UploadCounter(int count, int max) {
    return '$count / $max documenten';
  }

  @override
  String get wizardDocumentExternalOpenFailed =>
      'De browser kon niet worden geopend. De link staat op het klembord — plak hem in een browser om verder te gaan.';

  @override
  String get wizardFinalTimelineProcessing =>
      'Vorstand controleert · meestal 1 werkdag, tot 7';

  @override
  String get wizardFinalTimelineActivated => 'Account geactiveerd';

  @override
  String get wizardFinalAdultThank =>
      'Bedankt dat je het inschrijfformulier hebt ingevuld! 🎉';

  @override
  String get wizardFinalAdultUsual =>
      'Je aanvraag is binnen. We valideren hem meestal binnen één werkdag.';

  @override
  String get wizardFinalAdultExceptional =>
      'Soms kan het tot 7 werkdagen duren. En als iets niet klopt, sturen we je terug naar het formulier om het aan te passen 🙂';

  @override
  String get wizardFinalStatusTitle => 'STATUS AANVRAAG';

  @override
  String wizardFinalStatusStepsValidated(int reviewed, int total) {
    return '$reviewed/$total stappen gevalideerd door het Vorstand';
  }

  @override
  String get wizardFinalStufeSheetTitle => 'Details aanvraag';

  @override
  String get wizardFinalStufeSheetHint =>
      'De 8 fases die je hebt ingevuld. Vorstand controleert ze één voor één — je ziet in real time wat goedgekeurd is.';

  @override
  String get wizardFinalStufeStatusPending => 'Wacht op controle';

  @override
  String get wizardFinalStufeStatusApproved => 'Goedgekeurd';

  @override
  String get wizardFinalStufeStatusRejected => 'Afgewezen';

  @override
  String wizardFinalStatusRejectionCount(int count) {
    return '$count stap vereist correctie';
  }

  @override
  String get wizardFinalStufeRejectionReason => 'Reden van het Vorstand:';

  @override
  String get wizardFinalStufeCorrectNow => 'Nu corrigeren';

  @override
  String wizardFinalApprovalsHeader(int current, int total) {
    return 'Vorstand-goedkeuringen ($current/$total)';
  }

  @override
  String get wizardFinalApprovalAwaiting => 'Wachten op 2e Vorstand';

  @override
  String get wizardFinalApprovalRejected => 'AFGEWEZEN';

  @override
  String get wizardFinalStufeNoDataYet => 'Gegevens nog niet beschikbaar.';

  @override
  String get wizardFinalStufeReadAt => 'Gelezen op:';

  @override
  String get wizardFinalStufeBeitragsfrei =>
      'Contributievrij (geen betaling vereist)';

  @override
  String get wizardFinalStufeNotExempt => 'Geen sociale uitkering';

  @override
  String get wizardFinalStufeBeginAtVerification => 'Start bij verificatie';

  @override
  String get wizardFinalStufeBeginAtFoundation =>
      'Oprichtingsdatum (met terugwerkende kracht)';

  @override
  String get wizardFinalStufeBeginAtCustom => 'Andere datum';

  @override
  String get wizardFinalStufeStatusSkipped => 'Overgeslagen';

  @override
  String get wizardFinalStufeFilledAt => 'Ingevuld:';

  @override
  String get wizardFinalStufeReviewedAt => 'Gecontroleerd:';

  @override
  String get wizardFinalWithdrawLink => 'Aanvraag intrekken';

  @override
  String get wizardFinalWithdrawDialogTitle => 'Aanvraag intrekken?';

  @override
  String get wizardFinalWithdrawDialogBody =>
      'Je aanvraag wordt gemarkeerd als ingetrokken-door-jou. De gegevens blijven in de database voor audit (AVG), maar het account wordt niet geactiveerd. Je kunt de registratie altijd opnieuw beginnen met een nieuw lidnummer.';

  @override
  String get wizardFinalWithdrawKeep => 'Nee, ik wacht';

  @override
  String get wizardFinalWithdrawConfirm => 'Ja, intrekken';

  @override
  String get wizardErrTooManyWithdrawals =>
      'Je aanvraag kan niet automatisch worden verwerkt. Bel ons of kom persoonlijk langs bij de Vorstand om je registratie voort te zetten.';

  @override
  String get wizardDuplicateLoginTitle => 'Het lijkt erop dat je al lid bent';

  @override
  String get wizardDuplicateLoginBody =>
      'Met je naam en geboortedatum vinden we al een actief account. Gebruik \"Ik ben al lid\" op het startscherm om in te loggen. Lukt dat niet meer, bel ons dan.';

  @override
  String get wizardDuplicatePendingTitle => 'Je aanvraag is al bij ons';

  @override
  String get wizardDuplicatePendingBody =>
      'Met je naam en geboortedatum is er al een aanvraag in behandeling. Vorstand werkt eraan — we sturen je een melding in de app zodra je account actief is. Bel ons als je wilt overleggen.';

  @override
  String get wizardDuplicateRecentlyWithdrawnTitle =>
      'We kunnen deze aanvraag nu niet verwerken';

  @override
  String get wizardDuplicateRecentlyWithdrawnBody =>
      'Je naam en geboortedatum komen overeen met een onlangs ingetrokken aanvraag. Bel ons om eerst met de Vorstand te overleggen voordat je verdergaat.';

  @override
  String get wizardDuplicatePreviouslyWithdrawnTitle =>
      'Je hebt eerder al een aanvraag gedaan';

  @override
  String get wizardDuplicatePreviouslyWithdrawnBody =>
      'Je naam en geboortedatum komen overeen met een oudere aanvraag die je destijds had ingetrokken. Welkom terug — bel ons voordat je verdergaat, zodat de Vorstand kan beslissen hoe we het aanpakken.';

  @override
  String get wizardDuplicateCallUsTitle => 'Bel ons';

  @override
  String get wizardDuplicateCallUsBody =>
      'Je naam en geboortedatum staan al bij ons, maar de details kunnen we niet via de app delen. Bel ons — de Vorstand legt de situatie persoonlijk uit.';

  @override
  String get wizardChatHelp => 'Even praten';

  @override
  String get wizardChatHelpSubtitle =>
      'Live chat met de Vorstand · snel antwoord';

  @override
  String get benachrichtigungTitel => 'Sms-herinneringen';

  @override
  String get benachrichtigungIntro =>
      'Zodat u geen afspraak mist, kan de vereniging u een sms sturen. U bepaalt of en waarvoor — en u kunt dit altijd wijzigen.';

  @override
  String get benachrichtigungTermineFrage =>
      'Wilt u herinneringen aan uw afspraken per sms ontvangen?';

  @override
  String get benachrichtigungTermineDetail =>
      'Het bericht bevat datum, tijd, plaats en onderwerp van de afspraak.';

  @override
  String get benachrichtigungMedikamenteFrage =>
      'Wilt u ook aan uw medicijnen herinnerd worden?';

  @override
  String get benachrichtigungMedikamenteDetail =>
      'Dan staat de naam van het medicijn in het bericht. Dat is een gezondheidsgegeven — daarom vragen we het apart.';

  @override
  String get benachrichtigungHinweis =>
      'De herinnering is een hulp en geen garantie: vertrouw er alstublieft niet alleen op. U kunt dit altijd wijzigen in uw profiel.';

  @override
  String get benachrichtigungJa => 'Ja';

  @override
  String get benachrichtigungNein => 'Nee';

  @override
  String get benachrichtigungSpaeter => 'Later beslissen';

  @override
  String get benachrichtigungSpeichern => 'Opslaan';

  @override
  String get benachrichtigungGespeichert => 'Bedankt, opgeslagen.';

  @override
  String get benachrichtigungenLeer => 'Geen meldingen';

  @override
  String get benachrichtigungenAlleGelesen => 'Alles als gelezen markeren';

  @override
  String get benachrichtigungWetterFrage =>
      'Wilt u gewaarschuwd worden bij noodweer op uw woonplaats?';

  @override
  String get benachrichtigungWetterDetail =>
      'Alleen officiële waarschuwingen van de Duitse weerdienst vanaf niveau „zwaar“ — niet bij elke regenbui.';

  @override
  String get signaturTitel => 'Handtekeningen';

  @override
  String get signaturNichtsOffen =>
      'Er ligt op dit moment niets klaar om te ondertekenen.';

  @override
  String get signaturStatusOffen => 'Wacht op uw handtekening';

  @override
  String get signaturStatusSigniert => 'Door u ondertekend';

  @override
  String get signaturStatusAbgelehnt => 'Door u geweigerd';

  @override
  String get signaturStatusWiderrufen => 'Door de vereniging ingetrokken';

  @override
  String get signaturStatusAbgelaufen => 'Termijn verstreken';

  @override
  String signaturBitteGanzLesen(int gelesen, int gesamt) {
    return 'Lees het document alstublieft helemaal door (pagina $gelesen van $gesamt).';
  }

  @override
  String get signaturWeiterZurUnterschrift => 'Verder naar de handtekening';

  @override
  String get signaturAblehnen => 'Weigeren';

  @override
  String get signaturAblehnenHinweis =>
      'De vereniging krijgt hiervan bericht. U kunt uw reden opgeven.';

  @override
  String get signaturAblehnenGrund => 'Reden (niet verplicht)';

  @override
  String get signaturMitFingerHinweis =>
      'Zet uw handtekening met uw vinger in het witte vak.';

  @override
  String get signaturNochmal => 'Opnieuw';

  @override
  String get signaturZurueckZumDokument => 'Terug naar het document';

  @override
  String get signaturCodeAnfordern => 'Code per sms aanvragen';

  @override
  String get signaturCodeUnterwegs => 'De code is onderweg.';

  @override
  String signaturCodeGesendetAn(String nummer) {
    return 'We hebben een code naar $nummer gestuurd.';
  }

  @override
  String get signaturCodeErneutSenden => 'Code opnieuw versturen';

  @override
  String get signaturJetztUnterschreiben => 'Nu ondertekenen';

  @override
  String get signaturCodeFalsch => 'De code klopt niet.';

  @override
  String get signaturCodeAbgelaufen =>
      'De code is verlopen. Vraag een nieuwe code aan.';

  @override
  String get signaturZuVieleVersuche =>
      'Te veel mislukte pogingen. Vraag een nieuwe code aan.';

  @override
  String get signaturKeineRufnummer =>
      'Bij uw account is geen mobiel nummer bekend. Zonder dat nummer kunnen wij u geen code sturen — neem alstublieft contact op met de voorzitter.';

  @override
  String get signaturCodeFehlgeschlagen => 'De code kon niet worden verstuurd.';

  @override
  String get signaturLeer => 'Zet eerst uw handtekening.';

  @override
  String get signaturErfolg => 'Bedankt — uw handtekening is ontvangen.';

  @override
  String get signaturFehlgeschlagen =>
      'Dat is niet gelukt. Probeer het opnieuw.';

  @override
  String get signaturSiegelInArbeit =>
      'Het zegel wordt nog aangemaakt. Probeer het over een minuut opnieuw.';
}
