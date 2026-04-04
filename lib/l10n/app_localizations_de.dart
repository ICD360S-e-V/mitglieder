// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'ICD360S e.V - Mitgliederportal';

  @override
  String get memberPortal => 'Mitgliederportal';

  @override
  String get welcomeLoading => 'Wird geladen...';

  @override
  String get welcomeAutoLogin => 'Automatische Anmeldung...';

  @override
  String get login => 'Anmelden';

  @override
  String get register => 'Registrieren';

  @override
  String get becomeMember => 'Mitglied werden';

  @override
  String get memberNumber => 'Mitgliedernummer';

  @override
  String get memberNumberHint => 'Bitte Mitgliedernummer eingeben';

  @override
  String get password => 'Passwort';

  @override
  String get passwordHint => 'Bitte Passwort eingeben';

  @override
  String get confirmPassword => 'Passwort bestätigen';

  @override
  String get confirmPasswordHint => 'Bitte Passwort bestätigen';

  @override
  String get newPassword => 'Neues Passwort';

  @override
  String get newPasswordHint => 'Bitte neues Passwort eingeben';

  @override
  String get saveCredentials => 'Anmeldedaten speichern';

  @override
  String get autoLogin => 'Automatisch anmelden';

  @override
  String get forgotPassword => 'Passwort vergessen?';

  @override
  String get firstName => 'Vorname und Nachname';

  @override
  String get firstNameHint => 'Bitte Vorname und Nachname eingeben';

  @override
  String get nameMinLength => 'Name muss mindestens 2 Zeichen haben';

  @override
  String get nameOnlyLetters => 'Nur Buchstaben und Bindestrich erlaubt';

  @override
  String get email => 'E-Mail-Adresse';

  @override
  String get emailHint => 'Bitte E-Mail eingeben';

  @override
  String get emailInvalid => 'Bitte gültige E-Mail eingeben';

  @override
  String get passwordMinLength => 'Passwort muss mindestens 6 Zeichen haben';

  @override
  String get passwordsNotMatch => 'Passwörter stimmen nicht überein';

  @override
  String get recoveryCode => 'Wiederherstellungscode (6 Ziffern)';

  @override
  String get recoveryCodeHelper =>
      'Merken Sie sich diesen Code für Passwort-Wiederherstellung';

  @override
  String get recoveryCodeHint => 'Bitte Wiederherstellungscode eingeben';

  @override
  String get recoveryCodeInvalid => 'Code muss genau 6 Ziffern haben';

  @override
  String get loginFailed => 'Anmeldung fehlgeschlagen';

  @override
  String get registrationFailed => 'Registrierung fehlgeschlagen';

  @override
  String connectionError(String error) {
    return 'Verbindungsfehler: $error';
  }

  @override
  String registrationSuccess(String memberNumber) {
    return 'Registrierung erfolgreich!\n\nIhre Mitgliedernummer: $memberNumber\n\nBitte merken Sie sich diese Nummer für die Anmeldung.';
  }

  @override
  String get tooManyDevices => 'Zu viele Geräte';

  @override
  String get maxDevicesMessage =>
      'Sie sind bereits auf 3 Geräten angemeldet.\nWählen Sie ein Gerät zum Abmelden:';

  @override
  String get unknownDevice => 'Unbekanntes Gerät';

  @override
  String get unknown => 'Unbekannt';

  @override
  String get logoutError => 'Fehler beim Abmelden';

  @override
  String error(String error) {
    return 'Fehler: $error';
  }

  @override
  String get cancel => 'Abbrechen';

  @override
  String get resetPassword => 'Passwort zurücksetzen';

  @override
  String get forgotPasswordTitle => 'Passwort vergessen';

  @override
  String get forgotPasswordDescription =>
      'Geben Sie Ihre Mitgliedernummer und den Wiederherstellungscode ein, den Sie bei der Registrierung erstellt haben.';

  @override
  String get passwordResetSuccess =>
      'Passwort erfolgreich zurückgesetzt!\n\nSie können sich jetzt mit Ihrem neuen Passwort anmelden.';

  @override
  String get passwordResetFailed => 'Passwort-Zurücksetzung fehlgeschlagen';

  @override
  String get needHelp => 'Hilfe benötigt?';

  @override
  String get helpQuestion =>
      'Haben Sie Probleme bei der Anmeldung oder Registrierung?';

  @override
  String get helpDescription =>
      'Kontaktieren Sie uns über WhatsApp und beschreiben Sie uns genau, was nicht funktioniert. Wir antworten Ihnen schnellstmöglich!';

  @override
  String get whatsapp => 'WhatsApp';

  @override
  String get emailSubject => 'Anfrage über die ICD360S App';

  @override
  String get whatsappMessage =>
      'Hallo, ich habe ein Problem mit der ICD360S App. ';

  @override
  String get imprint => 'Impressum';

  @override
  String get privacy => 'Datenschutz';

  @override
  String get statutes => 'Satzung';

  @override
  String get revocation => 'Widerrufsrecht';

  @override
  String get cancellation => 'Kündigung';

  @override
  String get allRightsReserved => 'Alle Rechte vorbehalten.';

  @override
  String get enterCredentials => 'Bitte Mitgliedernummer und Passwort eingeben';

  @override
  String get appointments => 'Termine';

  @override
  String get tickets => 'Tickets';

  @override
  String get liveChat => 'Live Chat';

  @override
  String get notifications => 'Benachrichtigungen';

  @override
  String get myProfile => 'Mein Profil';

  @override
  String get logout => 'Abmelden';

  @override
  String get goodMorning => 'Guten Morgen';

  @override
  String get goodDay => 'Guten Tag';

  @override
  String get goodEvening => 'Guten Abend';

  @override
  String get goodNight => 'Gute Nacht';

  @override
  String get welcomeToICD => 'Willkommen bei ICD360S e.V!';

  @override
  String get accountCreatedSuccessfully =>
      'Ihr Konto wurde erfolgreich erstellt.';

  @override
  String get today => 'Heute';

  @override
  String get membershipFeeDue => 'Mitgliedsbeitrag fällig';

  @override
  String get pleaseTransferAnnualFee =>
      'Bitte überweisen Sie den Jahresbeitrag.';

  @override
  String get newBadge => 'Neu';

  @override
  String get close => 'Schließen';

  @override
  String get membership => 'Mitgliedschaft';

  @override
  String get myAppointments => 'Meine Termine';

  @override
  String get appointmentsLoadingReady => 'Termine laden - API ist bereit!';

  @override
  String get priority => 'Priorität';

  @override
  String get messageLabel => 'Nachricht';

  @override
  String get createdOn => 'Erstellt';

  @override
  String get handler => 'Bearbeiter';

  @override
  String get reportProblems => 'Probleme melden';

  @override
  String get reportProblem => 'Problem melden';

  @override
  String get weRespondIn24Hours => 'Wir antworten Ihnen in maximal 24 Stunden!';

  @override
  String get everythingOk => 'Alles in Ordnung!';

  @override
  String get haveProblemWeHelp =>
      'Haben Sie ein Problem?\nWir kümmern uns darum!';

  @override
  String get myMembership => 'Meine Mitgliedschaft';

  @override
  String get managePersonalDataAndFee =>
      'Verwalten Sie Ihre persönlichen Daten und Mitgliedsbeitrag';

  @override
  String get myAppointmentsTitle => 'Meine Termine';

  @override
  String get appointmentsDescription =>
      'Hier sehen Sie Ihre bevorstehenden Termine.\nSie können Ihre Teilnahme bestätigen oder absagen.';

  @override
  String get loadAppointments => 'Termine laden';

  @override
  String get myTickets => 'Meine Tickets';

  @override
  String get newTicket => 'Neues Ticket';

  @override
  String get noOpenTickets => 'Keine offenen Tickets';

  @override
  String get haveQuestionCreateTicket =>
      'Haben Sie eine Frage oder ein Problem?\nErstellen Sie ein neues Ticket.';

  @override
  String get whatIsTheProblem => 'Was ist das Problem?';

  @override
  String get describeTheProblem => 'Beschreiben Sie das Problem';

  @override
  String get howUrgentIsIt => 'Wie dringend ist es?';

  @override
  String get low => 'Niedrig';

  @override
  String get medium => 'Mittel';

  @override
  String get high => 'Hoch';

  @override
  String get submit => 'Absenden';

  @override
  String get fillSubjectAndMessage => 'Bitte Betreff und Nachricht ausfüllen';

  @override
  String get ticketCreated => 'Ticket wurde erstellt';

  @override
  String get errorCreatingTicket => 'Fehler beim Erstellen des Tickets';

  @override
  String get verified => 'Verifiziert';

  @override
  String get account => 'Konto';

  @override
  String get myDevices => 'Meine Geräte';

  @override
  String get changeEmail => 'E-Mail ändern';

  @override
  String get changePassword => 'Passwort ändern';

  @override
  String get newEmailAddress => 'Neue E-Mail-Adresse';

  @override
  String get currentPassword => 'Aktuelles Passwort';

  @override
  String get saveEmail => 'E-Mail speichern';

  @override
  String get savePassword => 'Passwort speichern';

  @override
  String get deviceLoggedOut => 'Gerät abgemeldet';

  @override
  String get passwordChangedSuccessfully => 'Passwort erfolgreich geändert';

  @override
  String get emailChangedSuccessfully => 'E-Mail erfolgreich geändert';

  @override
  String get errorChangingPassword => 'Fehler beim Ändern des Passworts';

  @override
  String get errorChangingEmail => 'Fehler beim Ändern der E-Mail';

  @override
  String get validEmailRequired =>
      'Bitte geben Sie eine gültige E-Mail-Adresse ein';

  @override
  String get passwordTooShort => 'Passwort muss mindestens 6 Zeichen lang sein';

  @override
  String get maxDevicesReached =>
      'Sie sind auf dem Maximum von 3 Geräten angemeldet.';

  @override
  String loggedInOnDevices(int count) {
    return 'Sie sind auf $count von 3 Geräten angemeldet.';
  }

  @override
  String get noActiveSessions => 'Keine aktiven Sitzungen';

  @override
  String get logoutFromDevice => 'Von diesem Gerät abmelden';

  @override
  String get confirmLogoutDevice => 'Gerät abmelden?';

  @override
  String get confirmLogoutMessage =>
      'Möchten Sie sich von diesem Gerät abmelden?\n\nSie müssen sich erneut anmelden um dieses Gerät wieder zu verwenden.';

  @override
  String get ipAddress => 'IP';

  @override
  String get platform => 'Platform';

  @override
  String trialWarningUrgentTitle(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'Tage',
      one: 'Tag',
    );
    return 'Achtung: Nur noch $days $_temp0 bis zur Kontosperrung!';
  }

  @override
  String get trialWarningTitle => 'Ihr Konto ist noch nicht verifiziert';

  @override
  String get trialWarningDescription =>
      'Bitte vervollständigen Sie Ihre Daten in \"Mein Profil\". Nach 30 Tagen wird Ihr Konto automatisch gesperrt.';

  @override
  String trialDaysRemaining(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days Tage',
      one: '1 Tag',
    );
    return '$_temp0';
  }

  @override
  String get overview => 'Übersicht';

  @override
  String get member => 'Mitglied';

  @override
  String get memberManagement => 'Mitglieder Verwaltung';

  @override
  String get reportProblemTooltip => 'Problem melden';

  @override
  String get newAppointmentsTitle => 'Neue Termine';

  @override
  String get youHaveNewAppointment => 'Sie haben einen neuen Termin.';

  @override
  String youHaveNewAppointments(int count) {
    return 'Sie haben $count neue Termine.';
  }

  @override
  String get appointmentReminderTomorrow => 'Erinnerung: Termin morgen';

  @override
  String tomorrowAppointment(String title) {
    return 'Morgen: $title';
  }

  @override
  String youHaveTomorrowAppointments(int count) {
    return 'Sie haben morgen $count Termine.';
  }

  @override
  String get appointmentsToday => 'Termine heute';

  @override
  String todayAppointment(String title) {
    return 'Heute: $title';
  }

  @override
  String youHaveTodayAppointments(int count) {
    return 'Sie haben heute $count Termine.';
  }

  @override
  String get paymentReminder => 'Zahlungserinnerung';

  @override
  String paymentReminderMessage(int day, String method) {
    return 'Heute ist der $day. des Monats – bitte $method durchführen.';
  }

  @override
  String get paymentDayLabel => 'Zahlungstag (monatliche Erinnerung)';

  @override
  String get updateAvailable => 'Update verfügbar';

  @override
  String newVersionAvailable(String version) {
    return 'Eine neue Version ist verfügbar: $version';
  }

  @override
  String currentVersionLabel(String version) {
    return 'Aktuelle Version: $version';
  }

  @override
  String get changes => 'Änderungen:';

  @override
  String downloadProgress(String percent) {
    return 'Download: $percent%';
  }

  @override
  String get installationStarting => 'Installation wird gestartet...';

  @override
  String get appWillRestart => 'Die Anwendung wird automatisch neu gestartet.';

  @override
  String get later => 'Später';

  @override
  String get updateNow => 'Jetzt aktualisieren';

  @override
  String get downloading => 'Wird heruntergeladen...';

  @override
  String get downloadFailed =>
      'Download fehlgeschlagen. Bitte versuchen Sie es später erneut.';

  @override
  String get searchingForUpdates => 'Suche nach Updates...';

  @override
  String get appUpToDate => 'Die App ist auf dem neuesten Stand';

  @override
  String get updateCheckError => 'Fehler bei der Update-Prüfung';

  @override
  String get changelog => 'Änderungsprotokoll';

  @override
  String get terminConfirmed => 'Termin bestätigt';

  @override
  String get terminDeclined => 'Termin abgelehnt';

  @override
  String get terminRescheduleRequested => 'Verschiebung angefragt';

  @override
  String get statusConfirmed => 'Bestätigt';

  @override
  String get statusDeclined => 'Abgelehnt';

  @override
  String get statusRescheduling => 'Verschiebung';

  @override
  String get statusPending => 'Ausstehend';

  @override
  String get categoryVorstandssitzung => 'Vorstandssitzung';

  @override
  String get categoryMitgliederversammlung => 'Mitgliederversammlung';

  @override
  String get categorySchulung => 'Schulung';

  @override
  String get categorySonstiges => 'Sonstiges';

  @override
  String openCount(int count) {
    return '$count offen';
  }

  @override
  String get refresh => 'Aktualisieren';

  @override
  String get filterUpcoming => 'Anstehend';

  @override
  String get filterPast => 'Vergangen';

  @override
  String get filterAll => 'Alle';

  @override
  String get noUpcomingAppointments => 'Keine anstehenden Termine';

  @override
  String get noPastAppointments => 'Keine vergangenen Termine';

  @override
  String get noAppointmentsAvailable => 'Keine Termine vorhanden';

  @override
  String get appointmentsShownHere => 'Ihre Termine werden hier angezeigt';

  @override
  String get dateLabel => 'Datum';

  @override
  String get timeLabel => 'Uhrzeit';

  @override
  String get locationLabel => 'Ort';

  @override
  String get createdByLabel => 'Erstellt von';

  @override
  String get descriptionLabel => 'Beschreibung';

  @override
  String get ticketLabel => 'Ticket';

  @override
  String get yourStatus => 'Ihr Status: ';

  @override
  String reasonLabel(String reason) {
    return 'Grund: $reason';
  }

  @override
  String durationMinutes(int minutes) {
    return '$minutes Min';
  }

  @override
  String get confirm => 'Bestätigen';

  @override
  String get decline => 'Ablehnen';

  @override
  String get reschedule => 'Verschieben';

  @override
  String get requestReschedule => 'Verschiebung anfragen';

  @override
  String appointmentLabel(String title) {
    return 'Termin: $title';
  }

  @override
  String get rescheduleReason => 'Grund für Verschiebung *';

  @override
  String get rescheduleReasonHint => 'Bitte geben Sie einen Grund an...';

  @override
  String get pleaseProvideReason => 'Bitte geben Sie einen Grund an';

  @override
  String get request => 'Anfragen';

  @override
  String get ticketStatusOpen => 'Offen';

  @override
  String get ticketStatusInProgress => 'In Bearbeitung';

  @override
  String get ticketStatusWaitingMember => 'Warten auf Mitglied';

  @override
  String get ticketStatusWaitingStaff => 'Warten auf Mitarbeiter';

  @override
  String get ticketStatusWaitingAuthority => 'Warten auf Behörde';

  @override
  String get ticketStatusDone => 'Erledigt';

  @override
  String get ticketPriorityHigh => 'Hoch';

  @override
  String get ticketPriorityMedium => 'Mittel';

  @override
  String get ticketPriorityLow => 'Niedrig';

  @override
  String get comments => 'Kommentare';

  @override
  String get documents => 'Dokumente';

  @override
  String get details => 'Details';

  @override
  String get replySent => 'Antwort gesendet';

  @override
  String get sendError => 'Fehler beim Senden';

  @override
  String get uploading => 'Hochladen...';

  @override
  String fileUploaded(String filename) {
    return '$filename hochgeladen';
  }

  @override
  String get uploadFailed => 'Upload fehlgeschlagen';

  @override
  String get openError => 'Fehler beim Öffnen';

  @override
  String get noRepliesYet => 'Noch keine Antworten';

  @override
  String get waitingForSupport => 'Warten Sie auf Antwort vom Support';

  @override
  String get writeReply => 'Antwort schreiben...';

  @override
  String get attachFile => 'Datei anhängen';

  @override
  String documentsCount(int count) {
    return 'Dokumente ($count)';
  }

  @override
  String get upload => 'Hochladen';

  @override
  String get noDocuments => 'Keine Dokumente vorhanden';

  @override
  String get allowedFormats => 'Erlaubte Formate: PDF, JPEG, JPG, TXT, ZIP';

  @override
  String get yourMessage => 'Ihre Nachricht:';

  @override
  String get translation => 'Übersetzung';

  @override
  String get original => 'Original';

  @override
  String get originalText => 'Originaltext';

  @override
  String get autoTranslated => 'Automatisch übersetzt';

  @override
  String get originalTapTranslation => 'Originaltext · Tippen für Übersetzung';

  @override
  String get translatedTapOriginal => 'Übersetzt · Tippen für Original';

  @override
  String get justNow => 'Gerade eben';

  @override
  String minutesAgo(int minutes) {
    return 'vor $minutes Min';
  }

  @override
  String hoursAgo(int hours) {
    return 'vor $hours Std';
  }

  @override
  String daysAgo(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'Tagen',
      one: 'Tag',
    );
    return 'vor $days $_temp0';
  }

  @override
  String get createdLabel => 'Erstellt';

  @override
  String get updatedLabel => 'Aktualisiert';

  @override
  String get handlerLabel => 'Bearbeiter';

  @override
  String get doneLabel => 'Erledigt';

  @override
  String get newTicketTitle => 'Neues Ticket';

  @override
  String get categoryOptional => 'Kategorie (optional)';

  @override
  String get selectCategory => 'Wählen';

  @override
  String get subjectLabel => 'Betreff';

  @override
  String get fillAllFields => 'Bitte füllen Sie alle Felder aus';

  @override
  String ticketCreatedId(int id) {
    return 'Ticket #$id erstellt';
  }

  @override
  String get priorityLabel => 'Priorität: ';

  @override
  String get supportOffline => 'Support offline';

  @override
  String get lastSeenSeconds => 'Zuletzt aktiv vor wenigen Sekunden';

  @override
  String lastSeenMinutes(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: 'Minuten',
      one: 'Minute',
    );
    return 'Zuletzt aktiv vor $minutes $_temp0';
  }

  @override
  String lastSeenHours(int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: 'Stunden',
      one: 'Stunde',
    );
    return 'Zuletzt aktiv vor $hours $_temp0';
  }

  @override
  String lastSeenDays(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'Tagen',
      one: 'Tag',
    );
    return 'Zuletzt aktiv vor $days $_temp0';
  }

  @override
  String get online => 'Online';

  @override
  String get callSupport => 'Anrufen';

  @override
  String get typeMessage => 'Nachricht eingeben...';

  @override
  String get callBusy => 'Support ist beschäftigt';

  @override
  String get callRejected => 'Anruf wurde abgelehnt';

  @override
  String get callFailed => 'Anruf konnte nicht verbunden werden';

  @override
  String get callEnded => 'Anruf beendet';

  @override
  String get callSupportBusy =>
      'Der Support ist bereits in einem anderen Anruf';

  @override
  String get errorStartingChat => 'Fehler beim Starten des Chats';

  @override
  String get errorStartingCall => 'Fehler beim Starten des Anrufs';

  @override
  String get errorConnecting => 'Fehler beim Verbinden';

  @override
  String get errorAcceptingCall => 'Fehler beim Annehmen';

  @override
  String get errorDownloading => 'Fehler beim Herunterladen';

  @override
  String get errorUploading => 'Fehler beim Hochladen';

  @override
  String get errorSending => 'Fehler beim Senden';

  @override
  String get errorPickingPhotos => 'Fehler beim Auswählen der Bilder';

  @override
  String get errorPickingFiles => 'Fehler beim Auswählen der Dateien';

  @override
  String get errorTakingPhoto => 'Fehler beim Aufnehmen des Fotos';

  @override
  String get fileNotLoaded => 'Datei konnte nicht geladen werden';

  @override
  String get attachmentIdMissing => 'Attachment ID fehlt';

  @override
  String get camera => 'Kamera';

  @override
  String get gallery => 'Galerie';

  @override
  String get file => 'Datei';

  @override
  String typingIndicator(String name) {
    return '$name tippt...';
  }

  @override
  String get notifNewMessageFrom => 'Neue Nachricht von';

  @override
  String get notifUrgentPrefix => 'DRINGEND';

  @override
  String get notifUrgentMessage => 'DRINGENDE NACHRICHT';

  @override
  String get notifIncomingCall => 'Eingehender Anruf';

  @override
  String get notifCallingYou => 'ruft an...';

  @override
  String get notifUpdateAvailable => 'Update verfügbar';

  @override
  String get notifVersionAvailable => 'ist jetzt verfügbar';

  @override
  String get notifConnected => 'Verbunden';

  @override
  String get notifDisconnected => 'Verbindung getrennt';

  @override
  String get notifConnectedBody => 'Sie sind jetzt mit dem Server verbunden.';

  @override
  String get notifDisconnectedBody =>
      'Die Verbindung zum Server wurde unterbrochen.';

  @override
  String get notifError => 'Fehler';

  @override
  String get retry => 'Erneut versuchen';

  @override
  String get save => 'Speichern';

  @override
  String get accept => 'Akzeptieren';

  @override
  String get selectFile => 'Datei auswählen';

  @override
  String get dataLoadingText => 'Daten werden geladen...';

  @override
  String get dataSavedSuccess => 'Daten erfolgreich gespeichert';

  @override
  String get errorSaving => 'Fehler beim Speichern';

  @override
  String get errorLoading => 'Fehler beim Laden';

  @override
  String savedFilename(String filename) {
    return 'Gespeichert: $filename';
  }

  @override
  String get logsCopied => 'Logs kopiert!';

  @override
  String get diagnosticDataTitle => 'Diagnose-Daten';

  @override
  String get diagnosticDescription =>
      'Möchten Sie anonyme Diagnosedaten senden, um die App zu verbessern?';

  @override
  String get noThanks => 'Nein, danke';

  @override
  String get yesEnable => 'Ja, aktivieren';

  @override
  String get passwordMinEightChars =>
      'Passwort muss mindestens 8 Zeichen lang sein';

  @override
  String get passwordChangeSuccess => 'Passwort erfolgreich geändert';

  @override
  String get emailChangeError => 'Fehler beim Ändern der E-Mail';

  @override
  String get acceptDocumentCheckbox =>
      'Ich habe das Dokument gelesen und akzeptiere es.';

  @override
  String loadingErrorGeneric(String details) {
    return 'Fehler beim Laden: $details';
  }

  @override
  String get incomingCallTitle => 'Eingehender Anruf';

  @override
  String ringingFor(int seconds) {
    return 'Klingelt seit ${seconds}s';
  }

  @override
  String get rejectCall => 'Ablehnen';

  @override
  String get acceptCall => 'Annehmen';

  @override
  String get unmute => 'Stummschaltung aufheben';

  @override
  String get mute => 'Stummschalten';

  @override
  String get hangUp => 'Auflegen';

  @override
  String get calling => 'Anrufen...';

  @override
  String autoRejectIn(int seconds) {
    return 'Auto-ablehnen in $seconds Sekunden';
  }

  @override
  String get speakerOn => 'Lautsprecher';

  @override
  String get speakerOff => 'Hören';

  @override
  String get micMuted => 'Stumm';

  @override
  String get micOn => 'Mikrofon';

  @override
  String get connectionExcellent => 'Ausgezeichnet';

  @override
  String get connectionGood => 'Gut';

  @override
  String get connectionWeak => 'Schwach';

  @override
  String get connectionLost => 'Getrennt';

  @override
  String get personalData => 'Persönliche Daten';

  @override
  String get personalDataSubtitle => 'Name, Vorname, Anschrift';

  @override
  String get membershipFee => 'Mitgliedsbeitrag';

  @override
  String annualFeeYear(String year) {
    return 'Jahresbeitrag $year';
  }

  @override
  String get amount => 'Betrag:';

  @override
  String get dueBy => 'Fällig bis:';

  @override
  String get paid => 'Bezahlt';

  @override
  String get versionHistory => 'Version History';

  @override
  String lastUpdated(String date) {
    return 'Last updated: $date';
  }

  @override
  String get noVersionHistory => 'No version history available';

  @override
  String get failedLoadChangelog => 'Failed to load changelog';

  @override
  String get callMember => 'Mitglied anrufen';

  @override
  String get closeConversation => 'Konversation schließen';

  @override
  String get chatOffline => 'Offline';

  @override
  String get attachFiles => 'Dateien anhängen (max. 10, 50MB)';

  @override
  String get conversationClosed => 'Diese Konversation wurde geschlossen';

  @override
  String get noMessages => 'Keine Nachrichten';

  @override
  String get goBack => 'Zurück';

  @override
  String get goForward => 'Vorwärts';

  @override
  String get homePage => 'Startseite';

  @override
  String get firstNameLabel => 'Vorname';

  @override
  String get lastNameLabel => 'Nachname';

  @override
  String get streetLabel => 'Straße';

  @override
  String get houseNumberLabel => 'Nr.';

  @override
  String get postalCodeLabel => 'PLZ';

  @override
  String get cityLabel => 'Ort';

  @override
  String get phoneMobileLabel => 'Telefon (Mobil)';

  @override
  String get phoneLandlineLabel => 'Telefon (Festnetz)';

  @override
  String get newEmailLabel => 'Neue E-Mail-Adresse';

  @override
  String get currentPasswordLabel => 'Aktuelles Passwort';

  @override
  String get newPasswordLabel => 'Neues Passwort';

  @override
  String get confirmPasswordLabel => 'Passwort bestätigen';

  @override
  String get emailChangedSuccess => 'E-Mail erfolgreich geändert';

  @override
  String get newPasswordMinChars => 'Neues Passwort (min. 6 Zeichen)';

  @override
  String get reasonLabel2 => 'Grund';

  @override
  String get downloadFailed2 => 'Download fehlgeschlagen';

  @override
  String get downloadTooltip => 'Herunterladen';

  @override
  String get connectionErrorGeneric => 'Verbindungsfehler';

  @override
  String get copyLogs => 'Logs kopieren';

  @override
  String get deleteLogs => 'Logs löschen';

  @override
  String get autoScrollOn => 'Auto-scroll AN';

  @override
  String get autoScrollOff => 'Auto-scroll AUS';

  @override
  String get unknownValue => 'Unbekannt';

  @override
  String get bankTransfer => 'Überweisung';

  @override
  String get standingOrder => 'Dauerauftrag';

  @override
  String get payment => 'Zahlung';

  @override
  String get warningType_ermahnung => 'Ermahnung';

  @override
  String get warningType_abmahnung => 'Abmahnung';

  @override
  String get warningType_letzte => 'Letzte Abmahnung';

  @override
  String warningsTotal(int count) {
    return 'Gesamt: $count';
  }

  @override
  String warningsErmahnung(int count) {
    return 'Ermahnung: $count';
  }

  @override
  String warningsAbmahnung(int count) {
    return 'Abmahnung: $count';
  }

  @override
  String warningsLetzte(int count) {
    return 'Letzte: $count';
  }

  @override
  String get noWarnings => 'Keine Verwarnungen vorhanden';

  @override
  String get noWarningsDescription => 'Sie haben derzeit keine Verwarnungen.';

  @override
  String createdBy(String name) {
    return 'Erstellt von: $name';
  }

  @override
  String get monthJan => 'Jan';

  @override
  String get monthFeb => 'Feb';

  @override
  String get monthMar => 'Mär';

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
  String get monthDec => 'Dez';

  @override
  String get stufe1_name => 'Persönliche Daten';

  @override
  String get stufe2_name => 'Mitgliedsart';

  @override
  String get stufe3_name => 'Finanzielle Situation';

  @override
  String get stufe4_name => 'Zahlungsmethode';

  @override
  String get stufe5_name => 'Mitgliedschaftsbeginn';

  @override
  String get stufe6_name => 'Satzung';

  @override
  String get stufe7_name => 'Datenschutzerklärung';

  @override
  String get stufe8_name => 'Widerrufsbelehrung';

  @override
  String get memberType_ordentlich => 'Ordentliches Mitglied';

  @override
  String get memberType_foerder => 'Fördermitglied';

  @override
  String get memberType_ehren => 'Ehrenmitglied';

  @override
  String get memberDesc_ordentlich =>
      'Aktives Mitglied mit Stimmrecht. Nimmt an den Dienstleistungen des Vereins teil (E-Mail, Cloud, bürokratische Unterstützung).';

  @override
  String get memberDesc_foerder =>
      'Unterstützt den Verein durch Beiträge. Kann an der Mitgliederversammlung mit beratendem Stimmrecht teilnehmen, ohne Wahlrecht oder Recht, in den Vorstand gewählt zu werden.';

  @override
  String get memberDesc_ehren =>
      'Hat die Rechte eines ordentlichen Mitglieds, ohne die Pflicht, Mitgliedsbeiträge zu zahlen. Wird von der Mitgliederversammlung oder dem Vorstand bestimmt.';

  @override
  String get payMethod_ueberweisung => 'Überweisung';

  @override
  String get payMethod_dauerauftrag => 'Dauerauftrag';

  @override
  String get verifyStatus_geprueft => 'Geprüft';

  @override
  String get verifyStatus_ausgefuellt => 'Ausgefüllt';

  @override
  String get verifyStatus_abgelehnt => 'Abgelehnt';

  @override
  String get verifyStatus_offen => 'Offen';

  @override
  String get fillRequiredFields => 'Bitte füllen Sie alle Pflichtfelder aus.';

  @override
  String get personalDataSaved => 'Persönliche Daten gespeichert';

  @override
  String get selectMemberType => 'Bitte wählen Sie eine Mitgliedsart.';

  @override
  String get memberTypeSaved => 'Mitgliedsart gespeichert';

  @override
  String get selectOption => 'Bitte wählen Sie eine Option.';

  @override
  String get financialSaved => 'Finanzielle Situation gespeichert';

  @override
  String get selectPaymentMethod => 'Bitte wählen Sie eine Zahlungsmethode.';

  @override
  String get paymentDataSaved => 'Zahlungsdaten gespeichert';

  @override
  String get selectDate => 'Bitte wählen Sie ein Datum.';

  @override
  String get membershipStartSaved => 'Mitgliedschaftsbeginn gespeichert';

  @override
  String get fileTooLarge => 'Datei zu groß (max. 10 MB).';

  @override
  String get leistungsbescheidUploaded =>
      'Leistungsbescheid erfolgreich hochgeladen';

  @override
  String get verificationProgress => 'Verifizierungsfortschritt';

  @override
  String get notApplicable => 'Entfällt';

  @override
  String get socialBenefitsExempt =>
      'Bei Bürgergeld/Sozialamt entfällt die Zahlungsmethode.';

  @override
  String get locked => 'Gesperrt';

  @override
  String completePreviousStep(int step) {
    return 'Bitte schließen Sie zuerst Stufe $step ab.';
  }

  @override
  String rejectedNote(String note) {
    return 'Abgelehnt: $note';
  }

  @override
  String get waitingForReview => 'Wartet auf Prüfung durch den Vorstand.';

  @override
  String get stepApproved => 'Diese Stufe wurde geprüft und genehmigt.';

  @override
  String get changesViaChat => 'Änderungen nur über Live-Chat möglich.';

  @override
  String get firstNameRequired => 'Vorname *';

  @override
  String get lastNameRequired => 'Nachname *';

  @override
  String get birthDateLabel => 'Geburtsdatum *';

  @override
  String get streetRequired => 'Straße *';

  @override
  String get houseNumberRequired => 'Nr. *';

  @override
  String get cityRequired => 'Ort *';

  @override
  String get phoneRequired => 'Telefonnummer *';

  @override
  String get phonePurpose =>
      'Zweck: Kontaktaufnahme bei Nichterreichbarkeit über die App';

  @override
  String get selectMemberTypePrompt =>
      'Bitte wählen Sie Ihre gewünschte Mitgliedsart:';

  @override
  String get financialExplanation =>
      'Um zu prüfen, ob Sie Anspruch auf eine Beitragsermäßigung haben, benötigen wir folgende Information. Diese Information wird ausschließlich zur Festlegung Ihres Mitgliedsbeitrags verwendet.';

  @override
  String get socialBenefitsQuestion => 'Beziehen Sie derzeit Sozialleistungen?';

  @override
  String get optionBuergergeld => 'Ja, Bürgergeld (Jobcenter)';

  @override
  String get optionSozialamt => 'Ja, Sozialleistungen vom Sozialamt';

  @override
  String get optionNoBenefits => 'Nein, ich beziehe keine Sozialleistungen';

  @override
  String get feeExempt =>
      'Ihr monatlicher Mitgliedsbeitrag beträgt: 0,00 €/Monat';

  @override
  String get uploadLeistungsbescheid => 'Leistungsbescheid hochladen';

  @override
  String get uploadLeistungsbescheidHint =>
      'Bitte laden Sie innerhalb von 14 Tagen einen aktuellen Leistungsbescheid hoch, um die Beitragsbefreiung zu bestätigen.';

  @override
  String get allowedFormatsUpload =>
      'Erlaubte Formate: PDF, JPG, PNG (max. 10 MB)';

  @override
  String get feeRegular =>
      'Ihr monatlicher Mitgliedsbeitrag beträgt: 25,00 €/Monat';

  @override
  String paymentDayReminder(int day) {
    return 'Sie werden jeden $day. des Monats an die Zahlung erinnert.';
  }

  @override
  String get membershipStartPrompt =>
      'Wählen Sie, ab wann Ihre Mitgliedschaft beginnen soll.';

  @override
  String get optionAfterVerification => 'Ab Abschluss der Verifizierung';

  @override
  String get optionAfterVerificationDesc =>
      'Mitgliedschaft beginnt ab dem Tag der Bestätigung durch den Vorstand.';

  @override
  String get optionRetroFoundation =>
      'Rückwirkend zum Gründungsdatum (01.08.2025)';

  @override
  String get optionRetroFoundationDesc =>
      'Sie werden retroaktiv Mitglied ab der Gründung des Vereins.';

  @override
  String get optionRetroCustom => 'Rückwirkend zu einem anderen Datum';

  @override
  String get optionRetroCustomDesc =>
      'Wählen Sie ein Datum zwischen dem 01.08.2025 und heute.';

  @override
  String get selectDateLabel => 'Datum wählen';

  @override
  String get selectDateHint => 'Datum auswählen...';

  @override
  String get dateNotBefore => 'Nicht vor dem 01.08.2025 (Gründungsdatum)';

  @override
  String get feeExemptRetro =>
      'Beitragsbefreit: 0,00 € retroaktiv.\nNur das Mitgliedschaftsdatum wird rückwirkend gesetzt.';

  @override
  String get retroactiveFees => 'Retroaktive Beiträge';

  @override
  String retroFeeCalculation(
      String from, String to, String months, String total) {
    return 'Zeitraum: $from – $to\nMonate: $months\nBeitrag: $months × 25,00 € = $total €';
  }

  @override
  String get pleaseReadSatzung => 'Bitte lesen Sie die Satzung des Vereins.';

  @override
  String get pleaseReadDatenschutz =>
      'Bitte lesen Sie die Datenschutzerklärung.';

  @override
  String get pleaseReadWiderruf => 'Bitte lesen Sie die Widerrufsbelehrung.';

  @override
  String get acceptedAtRegistration => 'Bei der Registrierung akzeptiert';

  @override
  String get confirmedByBoard => 'Wird vom Vorstand nach Prüfung bestätigt.';

  @override
  String get docSatzung => 'Satzung';

  @override
  String get docDatenschutz => 'Datenschutzerklärung';

  @override
  String get docWiderruf => 'Widerrufsbelehrung';

  @override
  String acceptedAtRegCount(int count) {
    return 'Bei der Registrierung akzeptiert ($count/3)';
  }

  @override
  String acceptedOn(String date) {
    return 'Akzeptiert am $date';
  }

  @override
  String get notAccepted => 'Nicht akzeptiert';

  @override
  String get statusAccepted => 'Akzeptiert';

  @override
  String get memberNumberTooLong => 'Mitgliedernummer zu lang (max 20 Zeichen)';

  @override
  String get onlyUppercaseAndNumbers => 'Nur Großbuchstaben und Zahlen erlaubt';

  @override
  String get passwordTooLong => 'Passwort zu lang (max 100 Zeichen)';

  @override
  String get nameTooLong => 'Name zu lang (max 100 Zeichen)';

  @override
  String get emailTooLong => 'E-Mail zu lang (max 255 Zeichen)';

  @override
  String get legalAcknowledgePrefix => 'Ich habe die ';

  @override
  String get legalAcknowledgeSuffix => ' zur Kenntnis genommen.';

  @override
  String get legalStatutesSuffix =>
      ' des ICD360S e.V. zur Kenntnis genommen und erkenne diese als verbindlich an.';

  @override
  String get legalPleaseReadFirst => '(bitte zuerst lesen)';

  @override
  String get statusActive => 'Aktiv';

  @override
  String get statusSuspended => 'Gesperrt';

  @override
  String get statusNew => 'Neu';

  @override
  String get statusCancelled => 'Gekündigt';

  @override
  String get statusDeleted => 'Gelöscht';

  @override
  String get roleMitglied => 'Mitglied';

  @override
  String get roleVorsitzer => 'Vorsitzer';

  @override
  String get roleStellvertreter => 'Stellvertreter';

  @override
  String get roleSchatzmeister => 'Schatzmeister';

  @override
  String get roleSchriftfuehrer => 'Schriftführer';

  @override
  String get roleBeisitzer => 'Beisitzer';

  @override
  String get roleKassierer => 'Kassierer';

  @override
  String get roleKassenpruefer => 'Kassenprüfer';

  @override
  String get roleEhrenamtlich => 'Ehrenamtlich';

  @override
  String get roleMitgliedergruender => 'Mitgliedergründer';

  @override
  String get roleEhrenmitglied => 'Ehrenmitglied';

  @override
  String get roleFoerdermitglied => 'Fördermitglied';

  @override
  String get memberTypeNotSet => 'Noch nicht festgelegt';

  @override
  String get payMethodSepa => 'SEPA-Lastschrift';

  @override
  String get labelStatus => 'Status';

  @override
  String get labelMemberNumber => 'Mitgliedernummer';

  @override
  String get labelRole => 'Rolle';

  @override
  String get labelMemberType => 'Mitgliedsart';

  @override
  String get labelPaymentMethod => 'Zahlungsmethode';

  @override
  String get labelRegisteredOn => 'Registriert am';

  @override
  String get labelLastLogin => 'Letzter Login';

  @override
  String get labelMemberSince => 'Mitglied seit';

  @override
  String get neverLoggedIn => 'Noch nie';

  @override
  String get notActivatedYet => 'Noch nicht aktiviert';

  @override
  String get tabVerification => 'Verifizierung';

  @override
  String get tabWarnings => 'Verwarnungen';

  @override
  String get tabDocuments => 'Dokumente';

  @override
  String get tabMembership => 'Mitgliedschaft';

  @override
  String get pleaseEnterFirstName => 'Bitte Vorname eingeben';

  @override
  String get pleaseEnterLastName => 'Bitte Nachname eingeben';

  @override
  String get noFileDataReceived => 'Keine Dateidaten erhalten';

  @override
  String get openFile => 'Öffnen';

  @override
  String get diagnosticErrors => 'Fehlermeldungen zur Verbesserung';

  @override
  String get diagnosticAnonymousStats => 'Anonyme Nutzungsstatistiken';

  @override
  String get diagnosticPerformance => 'App-Performance-Daten';

  @override
  String get noMicrophoneError =>
      'Kein Mikrofon gefunden. Bitte schließen Sie ein Mikrofon an und versuchen Sie es erneut.';

  @override
  String get startConversation => 'Starten Sie eine Konversation!';

  @override
  String get staffWillReply => 'Ein Mitarbeiter wird Ihnen bald antworten.';

  @override
  String get inCall => 'Im Anruf...';

  @override
  String get registration => 'Registrierung';

  @override
  String get deactivation => 'Deaktivierung';

  @override
  String get deactivatedOn => 'Deaktiviert am';

  @override
  String get accountAutoSuspend =>
      'Konten, die nicht innerhalb von 30 Tagen verifiziert werden, werden automatisch gesperrt.';

  @override
  String get ipClean => 'IP sauber - nicht gelistet';

  @override
  String get documentsProvidedByBoard =>
      'Dokumente werden vom Vorstand bereitgestellt.';

  @override
  String get noDocumentsAvailable => 'Keine Dokumente vorhanden';

  @override
  String get noDocumentsDescription =>
      'Es wurden noch keine Dokumente für Sie bereitgestellt.';

  @override
  String uploadedBy(String name) {
    return 'Hochgeladen von: $name';
  }

  @override
  String stepsCompleted(int completed, int total) {
    return '$completed/$total Stufen erledigt';
  }

  @override
  String dayOfMonth(int day) {
    return '$day. des Monats';
  }

  @override
  String changeField(String field) {
    return '$field ändern';
  }

  @override
  String openDocument(String name) {
    return '$name öffnen';
  }

  @override
  String get helpImproveApp => 'Möchten Sie uns helfen, die App zu verbessern?';

  @override
  String get noPersonalDataCollected =>
      'Keine persönlichen Daten werden gesammelt. Diese Einstellung kann jederzeit geändert werden.';

  @override
  String logEntries(int count) {
    return '$count Einträge';
  }

  @override
  String get noLogs => 'Keine Logs';

  @override
  String get newLoginDetected => 'Neue Anmeldung erkannt';

  @override
  String get waitingForMember => 'Warten auf Mitglied';

  @override
  String get waitingForStaff => 'Warten auf Mitarbeiter';

  @override
  String get waitingForAuthority => 'Warten auf Behörde';
}
