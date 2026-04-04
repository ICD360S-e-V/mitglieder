// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Dutch Flemish (`nl`).
class AppLocalizationsNl extends AppLocalizations {
  AppLocalizationsNl([String locale = 'nl']) : super(locale);

  @override
  String get appTitle => 'ICD360S e.V - Ledenportaal';

  @override
  String get memberPortal => 'Ledenportaal';

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
  String get password => 'Wachtwoord';

  @override
  String get passwordHint => 'Voer wachtwoord in';

  @override
  String get confirmPassword => 'Bevestig Wachtwoord';

  @override
  String get confirmPasswordHint => 'Bevestig wachtwoord';

  @override
  String get newPassword => 'Nieuw Wachtwoord';

  @override
  String get newPasswordHint => 'Voer nieuw wachtwoord in';

  @override
  String get saveCredentials => 'Inloggegevens opslaan';

  @override
  String get autoLogin => 'Automatisch inloggen';

  @override
  String get forgotPassword => 'Wachtwoord vergeten?';

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
  String get recoveryCode => 'Herstelcode (6 cijfers)';

  @override
  String get recoveryCodeHelper => 'Onthoud deze code voor wachtwoordherstel';

  @override
  String get recoveryCodeHint => 'Voer herstelcode in';

  @override
  String get recoveryCodeInvalid => 'Code moet precies 6 cijfers hebben';

  @override
  String get loginFailed => 'Inloggen mislukt';

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
  String get tooManyDevices => 'Te veel apparaten';

  @override
  String get maxDevicesMessage =>
      'U bent al ingelogd op 3 apparaten.\nSelecteer een apparaat om uit te loggen:';

  @override
  String get unknownDevice => 'Onbekend apparaat';

  @override
  String get unknown => 'Onbekend';

  @override
  String get logoutError => 'Uitlogfout';

  @override
  String error(String error) {
    return 'Fout: $error';
  }

  @override
  String get cancel => 'Annuleren';

  @override
  String get resetPassword => 'Wachtwoord Resetten';

  @override
  String get forgotPasswordTitle => 'Wachtwoord Vergeten';

  @override
  String get forgotPasswordDescription =>
      'Voer uw lidnummer en de herstelcode in die u bij registratie hebt aangemaakt.';

  @override
  String get passwordResetSuccess =>
      'Wachtwoord succesvol gereset!\n\nU kunt nu inloggen met uw nieuwe wachtwoord.';

  @override
  String get passwordResetFailed => 'Wachtwoord resetten mislukt';

  @override
  String get needHelp => 'Hulp nodig?';

  @override
  String get helpQuestion => 'Problemen met inloggen of registreren?';

  @override
  String get helpDescription =>
      'Neem contact op via WhatsApp en beschrijf precies wat er niet werkt. We antwoorden zo snel mogelijk!';

  @override
  String get whatsapp => 'WhatsApp';

  @override
  String get emailSubject => 'Vraag via ICD360S App';

  @override
  String get whatsappMessage =>
      'Hallo, ik heb een probleem met de ICD360S App. ';

  @override
  String get imprint => 'Colofon';

  @override
  String get privacy => 'Privacybeleid';

  @override
  String get statutes => 'Statuten';

  @override
  String get revocation => 'Herroepingsrecht';

  @override
  String get cancellation => 'Opzegging';

  @override
  String get allRightsReserved => 'Alle rechten voorbehouden.';

  @override
  String get enterCredentials => 'Voer lidnummer en wachtwoord in';

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
  String get membership => 'Lidmaatschap';

  @override
  String get myAppointments => 'Mijn afspraken';

  @override
  String get appointmentsLoadingReady => 'Afspraken laden - API gereed!';

  @override
  String get priority => 'Prioriteit';

  @override
  String get messageLabel => 'Bericht';

  @override
  String get createdOn => 'Aangemaakt';

  @override
  String get handler => 'Beheerder';

  @override
  String get reportProblems => 'Problemen melden';

  @override
  String get reportProblem => 'Probleem melden';

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
  String get newTicket => 'Nieuw ticket';

  @override
  String get noOpenTickets => 'Geen open tickets';

  @override
  String get haveQuestionCreateTicket =>
      'Heeft u een vraag of probleem?\nMaak een nieuw ticket aan.';

  @override
  String get whatIsTheProblem => 'Wat is het probleem?';

  @override
  String get describeTheProblem => 'Beschrijf het probleem';

  @override
  String get howUrgentIsIt => 'Hoe dringend is het?';

  @override
  String get low => 'Laag';

  @override
  String get medium => 'Gemiddeld';

  @override
  String get high => 'Hoog';

  @override
  String get submit => 'Verzenden';

  @override
  String get fillSubjectAndMessage => 'Vul het onderwerp en bericht in';

  @override
  String get ticketCreated => 'Ticket aangemaakt';

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
  String get newEmailAddress => 'Nieuw emailadres';

  @override
  String get currentPassword => 'Huidig wachtwoord';

  @override
  String get saveEmail => 'Email opslaan';

  @override
  String get savePassword => 'Wachtwoord opslaan';

  @override
  String get deviceLoggedOut => 'Apparaat afgemeld';

  @override
  String get passwordChangedSuccessfully => 'Wachtwoord succesvol gewijzigd';

  @override
  String get emailChangedSuccessfully => 'Email succesvol gewijzigd';

  @override
  String get errorChangingPassword => 'Fout bij wijzigen wachtwoord';

  @override
  String get errorChangingEmail => 'Fout bij wijzigen email';

  @override
  String get validEmailRequired => 'Voer een geldig emailadres in';

  @override
  String get passwordTooShort => 'Wachtwoord moet minimaal 6 tekens bevatten';

  @override
  String get maxDevicesReached =>
      'U bent aangemeld op het maximum van 3 apparaten.';

  @override
  String loggedInOnDevices(int count) {
    return 'U bent aangemeld op $count van 3 apparaten.';
  }

  @override
  String get noActiveSessions => 'Geen actieve sessies';

  @override
  String get logoutFromDevice => 'Afmelden van dit apparaat';

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
  String get errorAcceptingCall => 'Fout bij accepteren oproep';

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
  String typingIndicator(String name) {
    return '$name typt...';
  }

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
  String get diagnosticDataTitle => 'Diagnostische gegevens';

  @override
  String get diagnosticDescription =>
      'Wilt u anonieme diagnostische gegevens versturen om de app te verbeteren?';

  @override
  String get noThanks => 'Nee, bedankt';

  @override
  String get yesEnable => 'Ja, inschakelen';

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
  String get newPasswordMinChars => 'Nieuw wachtwoord (min. 6 tekens)';

  @override
  String get reasonLabel2 => 'Reden';

  @override
  String get downloadFailed2 => 'Download mislukt';

  @override
  String get downloadTooltip => 'Downloaden';

  @override
  String get connectionErrorGeneric => 'Verbindingsfout';

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
  String get bankTransfer => 'Bankoverschrijving';

  @override
  String get standingOrder => 'Doorlopende opdracht';

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
  String get memberNumberTooLong => 'Lidnummer te lang (max 20 tekens)';

  @override
  String get onlyUppercaseAndNumbers =>
      'Alleen hoofdletters en cijfers toegestaan';

  @override
  String get passwordTooLong => 'Wachtwoord te lang (max 100 tekens)';

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
  String get diagnosticErrors => 'Foutmeldingen voor verbetering';

  @override
  String get diagnosticAnonymousStats => 'Anonieme gebruiksstatistieken';

  @override
  String get diagnosticPerformance => 'App-prestatiegegevens';

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
  String get ipClean => 'IP schoon - niet vermeld';

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
  String get helpImproveApp => 'Wilt u ons helpen de app te verbeteren?';

  @override
  String get noPersonalDataCollected =>
      'Er worden geen persoonlijke gegevens verzameld. Deze instelling kan op elk moment worden gewijzigd.';

  @override
  String logEntries(int count) {
    return '$count vermeldingen';
  }

  @override
  String get noLogs => 'Geen logs';

  @override
  String get newLoginDetected => 'Nieuwe aanmelding gedetecteerd';

  @override
  String get waitingForMember => 'Wachten op lid';

  @override
  String get waitingForStaff => 'Wachten op medewerker';

  @override
  String get waitingForAuthority => 'Wachten op instantie';
}
