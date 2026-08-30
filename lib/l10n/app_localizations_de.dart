// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

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
  String get confirmPassword => 'Passwort bestätigen';

  @override
  String get confirmPasswordHint => 'Bitte Passwort bestätigen';

  @override
  String get newPassword => 'Neues Passwort';

  @override
  String get newPasswordHint => 'Bitte neues Passwort eingeben';

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
  String get unknown => 'Unbekannt';

  @override
  String error(String error) {
    return 'Fehler: $error';
  }

  @override
  String get cancel => 'Abbrechen';

  @override
  String get resetPassword => 'Passwort zurücksetzen';

  @override
  String get imprint => 'Impressum';

  @override
  String get privacy => 'Datenschutz';

  @override
  String get statutes => 'Satzung';

  @override
  String get revocation => 'Widerrufsrecht';

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
  String get myAppointments => 'Meine Termine';

  @override
  String get priority => 'Priorität';

  @override
  String get messageLabel => 'Nachricht';

  @override
  String get reportProblems => 'Probleme melden';

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
  String get low => 'Niedrig';

  @override
  String get high => 'Hoch';

  @override
  String get submit => 'Absenden';

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
  String get saveEmail => 'E-Mail speichern';

  @override
  String get savePassword => 'Passwort speichern';

  @override
  String get deviceLoggedOut => 'Gerät abgemeldet';

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
  String get autoUpdateEnableTitle =>
      'Zukünftige Updates automatisch installieren';

  @override
  String get autoUpdateEnableHint =>
      'Die App lädt Updates selbständig herunter, installiert sie und startet kurz neu. Ohne weitere Rückfragen.';

  @override
  String autoUpdateInstalling(String version) {
    return 'Version $version wird im Hintergrund installiert. Die App startet gleich neu.';
  }

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
  String get reasonLabel2 => 'Grund';

  @override
  String get downloadFailed2 => 'Download fehlgeschlagen';

  @override
  String get downloadTooltip => 'Herunterladen';

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
  String logEntries(int count) {
    return '$count Einträge';
  }

  @override
  String get noLogs => 'Keine Logs';

  @override
  String get newLoginDetected => 'Neue Anmeldung erkannt';

  @override
  String get errorNoInternet =>
      'Keine Internetverbindung. Bitte überprüfen Sie Ihr Netzwerk.';

  @override
  String get errorTimeout =>
      'Server antwortet nicht. Bitte versuchen Sie es später erneut.';

  @override
  String get errorServer =>
      'Serverfehler. Bitte versuchen Sie es später erneut.';

  @override
  String get errorConnection =>
      'Verbindungsfehler. Bitte versuchen Sie es später erneut.';

  @override
  String get errorUnexpected =>
      'Ein unerwarteter Fehler ist aufgetreten. Bitte versuchen Sie es später erneut.';

  @override
  String get securityBannerTlsInterception =>
      'Ihr Netzwerk fängt sichere Verbindungen ab. Bitte wechseln Sie das Netzwerk oder deaktivieren Sie VPN/Antivirus.';

  @override
  String get securityBannerDnsFailure =>
      'DNS-Problem erkannt. Prüfen Sie Ihre Verbindung oder wechseln Sie das Netzwerk.';

  @override
  String get securityBannerSlowNetwork => 'Langsame Verbindung.';

  @override
  String get securityPermissionDialogTitle =>
      'Möglicher Netzwerkangriff erkannt';

  @override
  String get securityPermissionDialogBody =>
      'Etwas in Ihrem Netzwerk fängt möglicherweise Verbindungen ab. Um das Netzwerk zu identifizieren und Sie zu schützen, benötigen wir die Berechtigung, den WLAN-Namen zu lesen. Keine Standortverfolgung.';

  @override
  String get securityPermissionDialogAllow => 'Erlauben';

  @override
  String get securityPermissionDialogDeny => 'Jetzt nicht';

  @override
  String get callErrorMicPermissionDenied =>
      'Mikrofonzugriff ist blockiert. Aktivieren Sie ihn in Windows-Einstellungen → Datenschutz → Mikrofon (oder den Datenschutz-Einstellungen Ihres Systems) und versuchen Sie es erneut.';

  @override
  String get callErrorMicNotFound =>
      'Kein Mikrofon gefunden. Schließen Sie ein Headset oder Mikrofon an und versuchen Sie es erneut.';

  @override
  String get claudiuWelcomeMorning => 'Guten Morgen';

  @override
  String get claudiuWelcomeDay => 'Hallo';

  @override
  String get claudiuWelcomeEvening => 'Guten Abend';

  @override
  String get claudiuWelcomeNight => 'Guten Abend';

  @override
  String get claudiuWelcomeVisitor => 'lieber Besucher';

  @override
  String get claudiuWelcomeAsk => 'Wie kann ich dir helfen?';

  @override
  String get claudiuWelcomeBecomeMember => 'Ich möchte Mitglied werden';

  @override
  String get claudiuWelcomeLogin =>
      'Ich bin bereits Mitglied und möchte mich anmelden';

  @override
  String get claudiuWelcomeProblem => 'Ich habe ein Problem mit der App';

  @override
  String get claudiuWelcomeEmergency => 'Notfall — ruf uns an';

  @override
  String get claudiuWelcomeMascotName => 'Claudiu';

  @override
  String get claudiuWelcomeEmergencyIntro =>
      'Bevor du anrufst — unsere Geschäftszeiten:';

  @override
  String get claudiuWelcomeScheduleOffice => 'Im Büro';

  @override
  String get claudiuWelcomeScheduleField => 'Beim Klienten vor Ort';

  @override
  String get claudiuWelcomeOutsideHoursNote =>
      'Außerhalb dieser Zeiten nehmen wir nur Notfälle entgegen. Du kannst uns auch eine SMS schicken — wir melden uns zurück.';

  @override
  String get claudiuWelcomeCallNow => 'Jetzt anrufen';

  @override
  String get claudiuWelcomeSendSms => 'SMS senden';

  @override
  String get claudiuWelcomeSmsBody =>
      'Notfall ICD360S e.V. — bitte ruft mich so schnell wie möglich zurück.';

  @override
  String get claudiuWelcomeCloseButton => 'Schließen';

  @override
  String get claudiuLoginWelcome => 'Willkommen zurück, liebes Mitglied!';

  @override
  String get claudiuLoginAsk => 'Bitte gib mir deine Mitgliedsnummer.';

  @override
  String get claudiuLoginProgress => 'Fast geschafft… tippe weiter.';

  @override
  String get claudiuLoginReady => 'Perfekt! Drück jetzt den Anmelden-Knopf.';

  @override
  String get claudiuLoginLoading => 'Ich prüfe die Identität… 🔍';

  @override
  String get claudiuLoginFoundPlain => 'Gefunden! Du wirst jetzt eingeloggt…';

  @override
  String claudiuLoginFoundNamed(String name) {
    return 'Gefunden, $name! Du wirst jetzt eingeloggt…';
  }

  @override
  String get claudiuLoginError =>
      'Hm, die Nummer finde ich nicht. Hast du dich vielleicht vertippt?';

  @override
  String get claudiuLoginForgotHeader => 'Mitgliedsnummer vergessen?';

  @override
  String get claudiuLoginNoSms =>
      'Wir verschicken die Nummer nicht per E-Mail oder SMS.';

  @override
  String get claudiuLoginOnlyWay =>
      'Der einzige Weg: ein persönlicher Termin im Vereinsbüro, mit Personalausweis.';

  @override
  String get claudiuLoginContactUs => 'Ruf uns an für einen Termin:';

  @override
  String get claudiuDiagnosticGreeting => 'Bevor du loslegst, eine Frage';

  @override
  String get claudiuDiagnosticAsk =>
      'Darf ich anonyme Berichte senden, damit die Entwickler die App verbessern können?';

  @override
  String get claudiuDiagnosticYes => 'Ja, ich helfe gerne';

  @override
  String get claudiuDiagnosticNo => 'Nein, ich schaue mich nur um';

  @override
  String get claudiuDiagnosticTellMore => 'Mehr Details';

  @override
  String get claudiuDiagnosticSendsHeader => '📤 Was wir SENDEN (anonym):';

  @override
  String get claudiuDiagnosticSends1 =>
      'Ein anonymer Gerätecode (NICHT die Mitgliedsnummer)';

  @override
  String get claudiuDiagnosticSends2 => 'Deine Rolle (Mitglied / Vorstand)';

  @override
  String get claudiuDiagnosticSends3 =>
      'Betriebssystem (Linux / Android / iOS / Windows)';

  @override
  String get claudiuDiagnosticSends4 => 'Gewählte Sprache';

  @override
  String get claudiuDiagnosticSends5 => 'Akkustand + Status';

  @override
  String get claudiuDiagnosticSends6 => 'Aktueller Bildschirm';

  @override
  String get claudiuDiagnosticSends7 => 'Sitzungsdauer (Sekunden)';

  @override
  String get claudiuDiagnosticSends8 => 'Fehler falls vorhanden (letzte 10)';

  @override
  String get claudiuDiagnosticSends9 => 'Navigation (letzte 20 Bildschirme)';

  @override
  String get claudiuDiagnosticSends10 =>
      'Wie oft die App Daten gesendet hat (nur Anzahl, kein Inhalt)';

  @override
  String get claudiuDiagnosticSends11 =>
      'Wie das System die App einstuft und wie schnell sich der Akku entlädt';

  @override
  String get claudiuDiagnosticNeverHeader => '🛡️ Was wir NIE senden:';

  @override
  String get claudiuDiagnosticNever1 => 'Dein echter Name';

  @override
  String get claudiuDiagnosticNever2 => 'E-Mail-Adresse';

  @override
  String get claudiuDiagnosticNever3 => 'Telefonnummer';

  @override
  String get claudiuDiagnosticNever4 => 'Passwort';

  @override
  String get claudiuDiagnosticNever5 => 'Inhalte deiner Chat-Nachrichten';

  @override
  String get claudiuDiagnosticNever6 => 'Inhalte deiner Tickets';

  @override
  String get claudiuDiagnosticNever7 => 'Dokumente oder Anhänge';

  @override
  String get claudiuDiagnosticTechHeader => '📡 Technische Details:';

  @override
  String get claudiuDiagnosticTech1 => 'Wird alle 15 Minuten gesendet';

  @override
  String get claudiuDiagnosticTech2 =>
      'TLS-verschlüsselte Verbindung mit Pinned-Zertifikat';

  @override
  String get claudiuDiagnosticTech3 =>
      'Du kannst es jederzeit in den Einstellungen abschalten';

  @override
  String get claudiuProblemHelpTitle => 'Wie kann ich helfen?';

  @override
  String get claudiuProblemHelpGreeting => 'Was ist passiert?';

  @override
  String get claudiuProblemHelpAsk => 'Wie möchtest du es mir mitteilen?';

  @override
  String get claudiuProblemHelpWriteTitle => 'Bericht schreiben';

  @override
  String get claudiuProblemHelpWriteBody =>
      'Mit Schritt-für-Schritt-Details. Das Team erhält den Text und kümmert sich später darum.';

  @override
  String get claudiuProblemHelpChatTitle => 'Jetzt sprechen';

  @override
  String get claudiuProblemHelpChatBody =>
      'Anonymer Chat mit einem Mitarbeiter. Antwort in Echtzeit, falls jemand online ist.';

  @override
  String get claudiuProblemHelpAltCallHeader => 'Oder bei dringenden Anliegen:';

  @override
  String get claudiuProblemHelpAltCallLabel => 'Ruf uns an';

  @override
  String get claudiuAnonymousChatTitle => 'Anonymer Chat';

  @override
  String get claudiuAnonymousChatGreeting => 'Hallo!';

  @override
  String get claudiuAnonymousChatWelcome =>
      'Ich höre dir zu. Schreib alles, was dich bewegt — ich brauche keinen Namen. Ich antworte, sobald ich da bin.';

  @override
  String get claudiuAnonymousChatHint => 'Nachricht schreiben…';

  @override
  String get claudiuAnonymousChatWaitingOperator =>
      'Wir warten, bis ein Mitarbeiter antwortet…';

  @override
  String get claudiuVorsitzerConnectedTitle => 'Hallo!';

  @override
  String get claudiuVorsitzerConnectedBody =>
      'Danke, dass du dich gemeldet hast — du bist jetzt mit einem Vorsitzer verbunden. Schreib uns, wie wir dir bei deinem Mitgliedsantrag helfen können.';

  @override
  String get claudiuVorsitzerConnectedSender => 'Vorsitzer';

  @override
  String get claudiuQuickReplyValidationTime => 'Wie lange dauert die Prüfung?';

  @override
  String get claudiuQuickReplyDocuments => 'Welche Dokumente brauche ich?';

  @override
  String get claudiuQuickReplyStepProblem =>
      'Ich komme bei einem Schritt nicht weiter';

  @override
  String get claudiuQuickReplyHuman => 'Kann ich jetzt mit jemandem sprechen?';

  @override
  String get claudiuAnonymousChatConnecting => 'Verbinde…';

  @override
  String get claudiuAnonymousChatConnectionFailed =>
      'Chat konnte nicht geöffnet werden. Versuch erneut oder ruf an.';

  @override
  String get claudiuAnonymousChatRetry => 'Erneut versuchen';

  @override
  String get claudiuAnonymousChatOnline => 'Verbunden';

  @override
  String get claudiuAnonymousChatOffline => 'Wiederverbindung…';

  @override
  String get claudiuAnonymousChatAdminTyping => 'Mitarbeiter schreibt…';

  @override
  String get claudiuProblemReportTitle => 'Problem melden';

  @override
  String get claudiuProblemReportGreeting => 'Was ist passiert?';

  @override
  String get claudiuProblemReportAsk =>
      'Beschreibe es im Detail, und ich leite den Bericht weiter.';

  @override
  String get claudiuProblemReportIncludeHeader => 'Bitte mit angeben:';

  @override
  String get claudiuProblemReportIncludeBullets1 =>
      'Was du gerade gemacht hast';

  @override
  String get claudiuProblemReportIncludeBullets2 =>
      'Welche Fehlermeldung erschien';

  @override
  String get claudiuProblemReportIncludeBullets3 =>
      'Auf welchem Bildschirm du warst';

  @override
  String get claudiuProblemReportIncludeBullets4 =>
      'Stürzt die App ab? Wird sie weiß? Schließt sie sich?';

  @override
  String get claudiuProblemReportIncludeBullets5 =>
      'Passiert es einmalig oder wiederholt';

  @override
  String get claudiuProblemReportDescriptionLabel => 'Deine Beschreibung';

  @override
  String get claudiuProblemReportDescriptionHint =>
      'Z.B.: Beim Öffnen des Chat-Bildschirms erscheint „Connection error\" und die App reagiert nicht mehr…';

  @override
  String claudiuProblemReportTooShort(int count) {
    return 'Bitte etwas ausführlicher (mind. $count Zeichen)';
  }

  @override
  String get claudiuProblemReportSubmit => 'Bericht senden';

  @override
  String get claudiuProblemReportSubmitting => 'Wird gesendet…';

  @override
  String get claudiuProblemReportSentTitle => 'Danke!';

  @override
  String get claudiuProblemReportSentBody =>
      'Der Bericht wurde gesendet. Unser Team schaut so schnell wie möglich darauf.';

  @override
  String get claudiuProblemReportSentClose => 'Verstanden';

  @override
  String get claudiuProblemReportSendFailed =>
      'Bericht konnte nicht gesendet werden. Ruf uns bei dringenden Anliegen an.';

  @override
  String get claudiuProblemReportAlt => 'Oder bei dringenden Anliegen:';

  @override
  String get claudiuProblemReportCallLabel => 'Ruf uns an';

  @override
  String claudiuApprovalGreeting(String name) {
    return 'Hallo, $name! 👋';
  }

  @override
  String get claudiuApprovalGreetingNoName => 'Hallo! 👋';

  @override
  String get claudiuApprovalGladToSeeYou => 'Schön, dass du da bist!';

  @override
  String get claudiuApprovalCheckingForSafety =>
      'Zu deiner Sicherheit prüft ein Vorsitzer gerade deine Anmeldeanfrage. 🛡️';

  @override
  String get claudiuApprovalMonthlyExplain =>
      '💡 Wir machen das alle 30 Tage, um sicher zu sein, dass du es bist. Es ist wie ein Sicherheits-Check-up — dauert maximal 5 Minuten.';

  @override
  String get claudiuApprovalSuccess =>
      'Fertig! 🎉 Der Vorsitzer hat dich erkannt. Du wirst jetzt eingeloggt…';

  @override
  String get claudiuApprovalDenied =>
      'Hm, der Vorsitzer hat deine Anfrage abgelehnt. 😔';

  @override
  String get claudiuApprovalDeniedHelp =>
      'Wenn du denkst, das ist ein Fehler, ruf uns bitte an, damit wir es klären.';

  @override
  String get claudiuApprovalExpired =>
      'Die 5 Minuten sind vorbei und wir haben keine Antwort vom Vorsitzer erhalten.';

  @override
  String get claudiuApprovalExpiredHelp =>
      'Ruf uns an und wir können deine Anfrage direkt vor Ort genehmigen. 📞';

  @override
  String get claudiuApprovalCallUs => 'Ruf uns an';

  @override
  String get claudiuApprovalTryAgain => 'Erneut versuchen';

  @override
  String get claudiuApprovalCancel => 'Abbrechen';

  @override
  String get claudiuApprovalClose => 'Schließen';

  @override
  String get wizardIntroBubble1 =>
      'Hallo, Besucher! 👋 Danke, dass du Teil unserer Familie werden möchtest.';

  @override
  String get wizardIntroBubble2 =>
      'Ich heiße Claudiu. Im Frühjahr 2025 hatte ich eine klare Vision: einen Verein zu gründen, der Menschen in Not hilft — ehrenamtlich, von Herzen, ohne unnötige Bürokratie. ❤️';

  @override
  String get wizardIntroBubble3 =>
      'Ich fing an, mit den Klienten zu sprechen, die ich besuchte. Ich erzählte ihnen meinen Traum. Und jeder sagte: „Ja, los!\" Im Juli 2025 trafen wir uns — 6 entschlossene Menschen. Wir beschlossen, **ICD360S e.V.** in Neu-Ulm zu gründen. 📍';

  @override
  String get wizardIntroBubble4 =>
      'Am **1. August 2025** wurde der Verein offiziell ins Vereinsregister eingetragen — mein schönstes Geschenk. 🎂';

  @override
  String get wizardIntroBubble5 =>
      'Was machen wir? Wir helfen Geflüchteten, Menschen mit Behinderung, wirtschaftlich Benachteiligten, **Kindern und Jugendlichen** — bei Behördengängen, Deutsch lernen, Wohnungssuche, Einkäufen, Sozialleistungen. Unser Vorstand besteht mehrheitlich aus Menschen mit Behinderung — so kommen die Entscheidungen aus echter Lebenserfahrung. 🤝';

  @override
  String get wizardIntroBubble6 =>
      'Jetzt bist du dran. Lass uns dich anmelden — dauert ca. 5 Minuten. Wir gehen Schritt für Schritt, ich lasse dich nicht allein. ✨';

  @override
  String get wizardIntroStart => 'Lass uns anfangen';

  @override
  String get wizardBack => 'Zurück';

  @override
  String get wizardNext => 'Weiter';

  @override
  String wizardStepLabel(int step, int total, String title) {
    return 'Schritt $step von $total · $title';
  }

  @override
  String get wizardErrRequired => 'Dieses Feld ist erforderlich';

  @override
  String wizardErrTooShort(int count) {
    return 'Zu kurz (mindestens $count Zeichen)';
  }

  @override
  String get wizardErrOnlyLetters =>
      'Nur Buchstaben, Leerzeichen, Bindestriche und Apostroph';

  @override
  String get wizardErrSaveFailed =>
      'Speichern fehlgeschlagen. Verbindung prüfen und erneut versuchen.';

  @override
  String get wizardStufe1aTitle => 'Identität';

  @override
  String get wizardStufe1aPrompt =>
      'Wir lernen dich offiziell kennen. Bitte schreib deinen Namen genau so, wie er auf Personalausweis, Reisepass oder Aufenthaltstitel steht — dann passt es zu deinen Dokumenten.';

  @override
  String get wizardStufe1aVornameLabel => 'Vornamen';

  @override
  String get wizardStufe1aVornameHelper =>
      'Alle deine Vornamen, genau wie auf dem Ausweis. Mit Leerzeichen oder Bindestrich (z.B. Hans-Peter, Maria Anna).';

  @override
  String get wizardStufe1aNachnameLabel => 'Familienname';

  @override
  String get wizardStufe1aNachnameHelper => 'Dein aktueller Familienname.';

  @override
  String get wizardStufe1aGeburtsnameLabel => 'Geburtsname (optional)';

  @override
  String get wizardStufe1aGeburtsnameHelper =>
      'Nur wenn er vom Familiennamen abweicht — z.B. vor der Heirat.';

  @override
  String get wizardStufe1bTitle => 'Geburtstag';

  @override
  String get wizardStufe1bPrompt =>
      'Wir möchten deinen Geburtstag mit dir feiern! 🎂 Und es hilft uns zu wissen, dass du mindestens 16 bist — so steht es in unserer Satzung.';

  @override
  String get wizardStufe1bGeburtsdatumLabel => 'Geburtsdatum';

  @override
  String get wizardStufe1bGeburtsdatumHelper => 'Tippen zum Auswählen';

  @override
  String get wizardStufe1bGeburtsortLabel => 'Geburtsort';

  @override
  String get wizardStufe1bGeburtsortHelper =>
      'Stadt / Ort, wo du geboren wurdest.';

  @override
  String get wizardAgeGatePrompt => 'Es tut mir leid… 😔';

  @override
  String wizardAgeGateBody1(int age, int years) {
    return 'Unsere Satzung sagt, du musst mindestens 16 sein, um Mitglied zu werden. Du bist $age — ich hoffe, wir sehen uns in $years Jahren wieder! 🌱';
  }

  @override
  String get wizardAgeGateBody2 =>
      'Wenn du dich punktuell als Ehrenamtliche*r engagieren möchtest (jedes Alter, mit Erlaubnis der Eltern), ruf uns an — wir freuen uns, junge Menschen zu unterstützen, die die Welt verändern wollen.';

  @override
  String get wizardAgeGateBackHome => 'Zurück zum Start';

  @override
  String get wizardErrInvalidPhone => 'Ungültige Telefonnummer';

  @override
  String get wizardStufe1b1Title => 'Einwilligung Eltern';

  @override
  String get wizardStufe1b1Prompt =>
      'Du bist minderjährig (16-17) — gemäß §106 BGB brauchen wir die Zustimmung eines Elternteils oder gesetzlichen Vertreters. Gib mir Namen und Telefonnummer. Ein Vorsitzer ruft an und vereinbart ein Treffen (persönlich oder per Videoanruf). Keine E-Mail — wir wollen sicher sein, dass wir mit der richtigen Person sprechen.';

  @override
  String get wizardStufe1b1VornameLabel => 'Vorname Erziehungsberechtigter';

  @override
  String get wizardStufe1b1VornameHelper =>
      'Wie auf dem Personalausweis des Elternteils.';

  @override
  String get wizardStufe1b1NachnameLabel =>
      'Familienname Erziehungsberechtigter';

  @override
  String get wizardStufe1b1NachnameHelper =>
      'Wie auf dem Personalausweis des Elternteils.';

  @override
  String get wizardStufe1b1TelefonLabel => 'Mobilnummer Erziehungsberechtigter';

  @override
  String get wizardStufe1b1TelefonHelper =>
      'An diese Nummer ruft ein Vorsitzer an.';

  @override
  String get wizardStufe1b1RelationLabel => 'Verhältnis zum Kind:';

  @override
  String get wizardStufe1b1RelationMutter => 'Mutter';

  @override
  String get wizardStufe1b1RelationVater => 'Vater';

  @override
  String get wizardStufe1b1RelationSorgeberechtigter => 'Sorgeberechtigter';

  @override
  String get wizardStufe1b1RelationAndere => 'Andere/r Erziehungsberechtigte/r';

  @override
  String get wizardStufe1cTitle => 'Persönliche Details';

  @override
  String get wizardStufe1cPrompt =>
      'Nur damit ich dich etwas besser kennenlerne. Diese Angaben bleiben unter uns und erscheinen nirgendwo öffentlich.';

  @override
  String get wizardStufe1cGeschlechtLabel => 'Geschlecht';

  @override
  String get wizardStufe1cGeschlechtMaennlich => 'Männlich';

  @override
  String get wizardStufe1cGeschlechtWeiblich => 'Weiblich';

  @override
  String get wizardStufe1cGeschlechtDivers => 'Divers';

  @override
  String get wizardStufe1cGeschlechtKeineAngabe => 'Keine Angabe';

  @override
  String get wizardStufe1cFamilienstandLabel => 'Familienstand';

  @override
  String get wizardStufe1cFamilienstandLedig => 'Ledig';

  @override
  String get wizardStufe1cFamilienstandVerheiratet => 'Verheiratet';

  @override
  String get wizardStufe1cFamilienstandGeschieden => 'Geschieden';

  @override
  String get wizardStufe1cFamilienstandVerwitwet => 'Verwitwet';

  @override
  String get wizardStufe1dTitle => 'Herkunft';

  @override
  String get wizardStufe1dPrompt =>
      'Das hilft uns, dir die richtige Unterstützung anzubieten — zum Beispiel Beratung beim Aufenthalt oder das Finden deiner Sprachcommunity.';

  @override
  String get wizardStufe1dStaatLabel => 'Staatsangehörigkeit';

  @override
  String get wizardStufe1dStaatHelper =>
      'Z.B. deutsch, rumänisch, ukrainisch. Mehrere mit Komma getrennt.';

  @override
  String get wizardStufe1dAufenthaltLabel => 'Aufenthaltsstatus (optional)';

  @override
  String get wizardStufe1dAufenthaltHelper =>
      'Wähle den Titel aus deinem Aufenthaltskarte / Bescheid. Der Vorstand gleicht mit den Dokumenten ab.';

  @override
  String get wizardStufe1dAufenthaltAwaitingCitizenship =>
      'Bitte oben zuerst die Staatsangehörigkeit eintragen — wir zeigen nur die passenden Optionen.';

  @override
  String get wizardStufe1dAufenthaltGerman =>
      'Kein Aufenthaltstitel erforderlich — Deutscher Staatsangehöriger.';

  @override
  String get wizardStufe1dAufenthaltEuEea =>
      'EU-/EWR-/CH-Bürger — Freizügigkeit.';

  @override
  String get wizardStufe1dAufenthaltTempHint => 'befristet';

  @override
  String get wizardStufe1dAufenthaltPermHint => 'unbefristet';

  @override
  String get wizardStufe1dAufenthaltAsylumProcessHint => 'Asylverfahren';

  @override
  String get wizardStufe1dAufenthaltOther => 'Sonstige (bitte im Chat angeben)';

  @override
  String get wizardStufe1dAufenthaltRequired =>
      'Bitte einen Aufenthaltstitel auswählen.';

  @override
  String get wizardStufe1dMutterspracheLabel => 'Muttersprache';

  @override
  String get wizardStufe1dMutterspracheHelper =>
      'Vorausgefüllt mit der App-Sprache — ändere falls anders.';

  @override
  String get wizardStufe1eTitle => 'Adresse';

  @override
  String get wizardStufe1ePrompt =>
      'Deine Postanschrift — wir nutzen sie für offizielle Unterlagen (Satzung, Mitgliedsverträge, Mitteilungen).';

  @override
  String get wizardStufe1eStrasseLabel => 'Straße';

  @override
  String get wizardStufe1eStrasseHelper =>
      'Nur der Straßenname — Hausnummer ins Feld daneben.';

  @override
  String get wizardStufe1eHausnummerLabel => 'Hausnummer';

  @override
  String get wizardStufe1ePlzLabel => 'PLZ';

  @override
  String get wizardStufe1eOrtLabel => 'Ort';

  @override
  String get wizardStufe1eLandLabel => 'Land';

  @override
  String get wizardStufe1eLandHelper => 'Vorausgefüllt mit Deutschland.';

  @override
  String get wizardErrInvalidStreet => 'Ungültiger Straßenname';

  @override
  String get wizardErrInvalidHausnummer =>
      'Ungültige Hausnummer (z.B. 12, 12a, 12/3)';

  @override
  String get wizardErrInvalidPlz => 'Ungültige PLZ (nur Ziffern)';

  @override
  String get wizardStufe1fTitle => 'Kontakt';

  @override
  String get wizardStufe1fPrompt =>
      'Wie erreichen wir dich? Das Telefon nur für Notfälle — alles andere läuft über unseren Ende-zu-Ende-verschlüsselten In-App-Kanal. Deine Mitglieder-E-Mail wird automatisch zugewiesen und unten angezeigt.';

  @override
  String get wizardStufe1fTelefonLabel => 'Mobilnummer';

  @override
  String get wizardStufe1fTelefonHelper =>
      'Versprochen — wir rufen nur an, wenn es wirklich wichtig ist. 📱';

  @override
  String get wizardStufe2Title => 'Mitgliedsart';

  @override
  String get wizardStufe2Prompt =>
      'Welche Art von Mitglied möchtest du sein? Lass mich dir jede Option erklären.';

  @override
  String get wizardStufe2OrdentlichTitle => 'Ordentliches Mitglied';

  @override
  String get wizardStufe2OrdentlichBody =>
      'Volle Rechte. Du zahlst monatlich Beitrag, stimmst in der Mitgliederversammlung ab und kannst in den Vorstand gewählt werden. Standardwahl.';

  @override
  String get wizardStufe2FoerderTitle => 'Fördermitglied';

  @override
  String get wizardStufe2FoerderBody =>
      'Du unterstützt den Verein finanziell, nimmst aber nicht aktiv an Entscheidungen teil. Kein Stimmrecht. Gut, wenn du aus der Ferne helfen willst.';

  @override
  String get wizardStufe2EhrenTitle => 'Ehrenmitglied';

  @override
  String get wizardStufe2EhrenBody =>
      'Wird vom Vorstand für besondere Verdienste verliehen. Du wählst es nicht selbst — es wird als Anerkennung gewährt. Wähle nur, wenn dir bereits diese Ehre zuteilwurde.';

  @override
  String get wizardStufe3Title => 'Finanzielle Situation';

  @override
  String get wizardStufe3Prompt =>
      'Jetzt zu deiner finanziellen Situation. Nicht um zu urteilen — sondern um dich vom Beitrag zu befreien, falls du Sozialleistungen beziehst.';

  @override
  String get wizardStufe3OptionBuergergeld => 'Ich beziehe Bürgergeld';

  @override
  String get wizardStufe3OptionSozialamt => 'Ich beziehe Sozialamt-Leistungen';

  @override
  String get wizardStufe3OptionNein => 'Ich beziehe keine dieser Leistungen';

  @override
  String get wizardStufe3FeeExemptTitle => 'Beitrag: 0 € / Monat 🎉';

  @override
  String get wizardStufe3FeeExemptBody =>
      'Mit Bürgergeld, Sozialamt, ALG I oder Krankengeld bist du nach Satzung §6 vollständig beitragsbefreit. Wir brauchen nur einen Nachweis (Leistungsbescheid oder Bescheinigung der Behörde / Krankenkasse).';

  @override
  String get wizardStufe3UploadTitle => 'Leistungsbescheid hochladen';

  @override
  String get wizardStufe3UploadHint => 'PDF / JPG / PNG, maximal 10 MB.';

  @override
  String get wizardStufe3UploadRequired =>
      'Bitte lade den Leistungsbescheid hoch, bevor es weitergeht.';

  @override
  String get wizardStufe3FileTooLarge => 'Datei zu groß. Maximal 10 MB.';

  @override
  String get wizardStufe3UploadFailed =>
      'Datei konnte nicht hochgeladen werden. Bitte erneut versuchen.';

  @override
  String get wizardStufe3RegularFeeTitle => 'Beitrag: 25 € / Monat';

  @override
  String get wizardStufe3RegularFeeBody =>
      'Regulärer Beitrag für ordentliche Mitglieder laut Satzung.';

  @override
  String get wizardStufe4Title => 'Zahlung';

  @override
  String get wizardStufe4Prompt =>
      'Wie möchtest du den Beitrag zahlen? Und an welchem Tag im Monat soll abgebucht werden?';

  @override
  String get wizardStufe4MethodUeberweisungTitle => 'Überweisung';

  @override
  String get wizardStufe4MethodUeberweisungBody =>
      'Du löst die Zahlung jeden Monat manuell von deinem Konto aus.';

  @override
  String get wizardStufe4MethodSepaTitle => 'SEPA-Lastschrift';

  @override
  String get wizardStufe4MethodSepaBody =>
      'Wir ziehen den Betrag automatisch von deinem Konto ein. Am bequemsten, aber wir brauchen IBAN und ein Mandat.';

  @override
  String get wizardStufe4MethodDauerauftragTitle => 'Dauerauftrag';

  @override
  String get wizardStufe4MethodDauerauftragBody =>
      'Du richtest einen Dauerauftrag bei deiner Bank ein. Deine Bank überweist den Betrag jeden Monat automatisch.';

  @override
  String get wizardStufe4DayLabel => 'Zahlungstag';

  @override
  String get wizardStufe4DayHint => 'Wähle einen Tag zwischen 1 und 31';

  @override
  String wizardStufe4DayItem(int day) {
    return 'Tag $day';
  }

  @override
  String wizardStufe4DayReminder(int day) {
    return 'Der Beitrag wird am $day. jedes Monats abgebucht.';
  }

  @override
  String get wizardStufe5Title => 'Beginn';

  @override
  String get wizardStufe5Prompt =>
      'Ab wann möchtest du offiziell ICD360S-Mitglied sein? Ab der Freigabe oder rückwirkend.';

  @override
  String get wizardStufe5OptionAbVerifizierungTitle =>
      'Ab Freigabe durch den Vorstand';

  @override
  String get wizardStufe5OptionAbVerifizierungBody =>
      'Die einfachste Wahl. Kein rückwirkender Beitrag.';

  @override
  String get wizardStufe5OptionGruendungsdatumTitle =>
      'Rückwirkend ab 01.08.2025 (Gründungsdatum)';

  @override
  String get wizardStufe5OptionGruendungsdatumBody =>
      'Du zählst als Mitglied seit dem ersten Tag des Vereins.';

  @override
  String get wizardStufe5OptionAnderesDatumTitle => 'Anderes Datum';

  @override
  String get wizardStufe5OptionAnderesDatumBody =>
      'Du wählst ein Datum zwischen 01.08.2025 und heute.';

  @override
  String get wizardStufe5PickDate => 'Tippen, um Datum zu wählen';

  @override
  String get wizardStufe5PickDateFirst => 'Bitte wähle zuerst ein Datum.';

  @override
  String get wizardStufe5DatePickerHelp => 'Mitgliedschaftsbeginn';

  @override
  String wizardStufe5DateRange(String start) {
    return 'Zwischen $start und heute';
  }

  @override
  String get wizardStufe5RetroactiveTitle => 'Rückwirkender Beitrag';

  @override
  String wizardStufe5RetroactiveBody(
      String start, String end, int months, String amount) {
    return 'Vom $start bis $end sind das $months Monate. Bei 25 €/Monat ergibt das eine rückwirkende Zahlung von $amount €, zusätzlich zum laufenden Monatsbeitrag.';
  }

  @override
  String get wizardStufe5FeeExemptTitle => 'Rückwirkender Beitrag: 0 € 🎉';

  @override
  String get wizardStufe5FeeExemptBody =>
      'Mit Bürgergeld oder Sozialamt bist du komplett befreit — auch rückwirkend nichts zu zahlen.';

  @override
  String wizardDocumentPrompt(String doc) {
    return 'Bevor wir abschließen, lies bitte sorgfältig die $doc. Es ist wichtig zu wissen, was du unterschreibst.';
  }

  @override
  String get wizardDocumentScrollHint =>
      'Scroll bis zum Ende, um fortzufahren.';

  @override
  String get wizardDocumentScrolledOk => 'Du hast bis zum Ende gelesen ✓';

  @override
  String wizardDocumentOpenButton(String doc) {
    return '$doc im Browser öffnen';
  }

  @override
  String get wizardDocumentExternalHint =>
      'Auf dieser Plattform öffnen wir das Dokument in deinem Standard-Browser.';

  @override
  String get wizardDocumentOpenedOk =>
      'Das Dokument wurde geöffnet. Bitte lies es sorgfältig.';

  @override
  String wizardDocumentConfirm(String doc) {
    return 'Ich bestätige, dass ich $doc gelesen habe und damit einverstanden bin.';
  }

  @override
  String get wizardFinalAdultTitle => 'Geschafft! Du bist angemeldet 🎉';

  @override
  String get wizardFinalMinorTitle => 'Deine Anfrage wurde verschickt 📨';

  @override
  String get wizardFinalMinorBody =>
      'Wir kontaktieren deinen Elternteil und vereinbaren ein Treffen (persönlich oder per Videoanruf). Bitte hab Geduld — der Vorgang kann bis zu 7 Tage dauern. Du bekommst eine In-App-Benachrichtigung, sobald dein Elternteil zugestimmt hat.';

  @override
  String get wizardFinalMitgliedernummerLabel => 'Deine Mitgliedsnummer';

  @override
  String get wizardStufe4MethodComingSoon => 'Bald verfügbar';

  @override
  String get wizardStufe4StreichungWarning =>
      'Wenn du mit dem Beitrag mehr als 6 Monate im Rückstand bist, werden wir dich automatisch streichen (Satzung §6 Abs. 3).';

  @override
  String get wizardStufe5KuendigungInfo =>
      'Zum Austritt: schicke uns deine Kündigung schriftlich 3 Monate vor dem 31. Dezember (also bis 30. September für Wirksamkeit zum Jahresende). Keine Mindestlaufzeit (Satzung §6 Abs. 3).';

  @override
  String get wizardStufe1fEmailLabel => 'Deine Mitglieder-E-Mail';

  @override
  String get wizardStufe1fEmailHelper =>
      'Wird automatisch aus deiner Mitgliedsnummer abgeleitet. Wird aktiviert, sobald der Vorstand deinen Antrag bestätigt. Wir haben eine eigene E-Mail-App — verschlüsselte E-Mails senden und empfangen, einfach und kostenlos.';

  @override
  String get wizardErrInvalidEmail => 'Ungültige E-Mail-Adresse';

  @override
  String get wizardStufe3OptionAlg1 => 'Ich beziehe Arbeitslosengeld I (ALG I)';

  @override
  String get wizardStufe3OptionKrankengeld => 'Ich beziehe Krankengeld';

  @override
  String get wizardStufe3UploadAddMore => 'Weiteres Dokument hinzufügen';

  @override
  String get wizardStufe3UploadLimitCount =>
      'Limit erreicht: maximal 20 Dokumente.';

  @override
  String get wizardStufe3UploadLimitTotal =>
      'Gesamtlimit 100 MB erreicht. Lösche eine bestehende Datei.';

  @override
  String get wizardStufe3UploadDeleteTooltip => 'Löschen';

  @override
  String wizardStufe3UploadCounter(int count, int max) {
    return '$count / $max Dokumente';
  }

  @override
  String get wizardDocumentExternalOpenFailed =>
      'Konnte den Browser nicht öffnen. Der Link wurde in die Zwischenablage kopiert — füge ihn in einen Browser ein, um fortzufahren.';

  @override
  String get wizardFinalTimelineProcessing =>
      'Vorstand prüft · meist 1 Werktag, max. 7';

  @override
  String get wizardFinalTimelineActivated => 'Konto aktiviert';

  @override
  String get wizardFinalAdultThank =>
      'Vielen Dank, dass du das Anmeldeformular ausgefüllt hast! 🎉';

  @override
  String get wizardFinalAdultUsual =>
      'Dein Antrag ist bei uns angekommen. Normalerweise prüfen wir ihn innerhalb von einem Werktag.';

  @override
  String get wizardFinalAdultExceptional =>
      'Manchmal kann es bis zu 7 Werktage dauern. Falls etwas nicht passt, schicken wir dich zurück ins Formular, damit du es korrigieren kannst 🙂';

  @override
  String get wizardFinalStatusTitle => 'ANTRAGSSTATUS';

  @override
  String wizardFinalStatusStepsValidated(int reviewed, int total) {
    return '$reviewed/$total Schritte vom Vorstand geprüft';
  }

  @override
  String get wizardFinalStufeSheetTitle => 'Antragsdetails';

  @override
  String get wizardFinalStufeSheetHint =>
      'Die 8 Stufen, die du ausgefüllt hast. Der Vorstand prüft sie nacheinander — du siehst in Echtzeit, was schon geprüft wurde.';

  @override
  String get wizardFinalStufeStatusPending => 'Wartet auf Prüfung';

  @override
  String get wizardFinalStufeStatusApproved => 'Geprüft';

  @override
  String get wizardFinalStufeStatusRejected => 'Abgelehnt';

  @override
  String wizardFinalStatusRejectionCount(int count) {
    return '$count Schritt braucht eine Korrektur';
  }

  @override
  String get wizardFinalStufeRejectionReason => 'Begründung vom Vorstand:';

  @override
  String get wizardFinalStufeCorrectNow => 'Jetzt korrigieren';

  @override
  String wizardFinalApprovalsHeader(int current, int total) {
    return 'Vorstand-Bestätigungen ($current/$total)';
  }

  @override
  String get wizardFinalApprovalAwaiting => 'Warten auf 2. Vorstand';

  @override
  String get wizardFinalApprovalRejected => 'ABGELEHNT';

  @override
  String get wizardFinalStufeNoDataYet => 'Daten sind noch nicht verfügbar.';

  @override
  String get wizardFinalStufeReadAt => 'Gelesen am:';

  @override
  String get wizardFinalStufeBeitragsfrei =>
      'Beitragsfrei (kein Beitrag erforderlich)';

  @override
  String get wizardFinalStufeNotExempt => 'Keine Sozialleistungen';

  @override
  String get wizardFinalStufeBeginAtVerification => 'Beginn ab Verifizierung';

  @override
  String get wizardFinalStufeBeginAtFoundation =>
      'Gründungsdatum (rückwirkend)';

  @override
  String get wizardFinalStufeBeginAtCustom => 'Anderes Datum';

  @override
  String get wizardFinalStufeStatusSkipped => 'Übersprungen';

  @override
  String get wizardFinalStufeFilledAt => 'Ausgefüllt am:';

  @override
  String get wizardFinalStufeReviewedAt => 'Geprüft am:';

  @override
  String get wizardFinalWithdrawLink => 'Antrag zurückziehen';

  @override
  String get wizardFinalWithdrawDialogTitle => 'Antrag zurückziehen?';

  @override
  String get wizardFinalWithdrawDialogBody =>
      'Dein Antrag wird als von dir zurückgezogen markiert. Die Daten bleiben aus Auditgründen (DSGVO) in der Datenbank, dein Konto wird jedoch nicht aktiviert. Du kannst die Anmeldung jederzeit mit einer neuen Mitgliedernummer neu starten.';

  @override
  String get wizardFinalWithdrawKeep => 'Nein, ich warte';

  @override
  String get wizardFinalWithdrawConfirm => 'Ja, zurückziehen';

  @override
  String get wizardErrTooManyWithdrawals =>
      'Dein Antrag kann nicht automatisch bearbeitet werden. Bitte ruf uns an oder komm persönlich beim Vorstand vorbei, um die Anmeldung fortzusetzen.';

  @override
  String get wizardDuplicateLoginTitle =>
      'Du scheinst bereits Mitglied zu sein';

  @override
  String get wizardDuplicateLoginBody =>
      'Mit deinem Namen und Geburtsdatum finden wir bereits ein aktives Konto. Bitte nutze „Ich bin bereits Mitglied\" auf dem Startbildschirm, um dich anzumelden. Wenn du keinen Zugang mehr hast, ruf uns an.';

  @override
  String get wizardDuplicatePendingTitle => 'Dein Antrag ist bereits bei uns';

  @override
  String get wizardDuplicatePendingBody =>
      'Mit deinem Namen und Geburtsdatum finden wir bereits einen laufenden Antrag. Der Vorstand prüft ihn gerade — wir benachrichtigen dich in der App, sobald dein Konto aktiv ist. Wenn du sprechen möchtest, ruf uns an.';

  @override
  String get wizardDuplicateRecentlyWithdrawnTitle =>
      'Wir können den Antrag jetzt nicht bearbeiten';

  @override
  String get wizardDuplicateRecentlyWithdrawnBody =>
      'Dein Name und dein Geburtsdatum stimmen mit einem kürzlich zurückgezogenen Antrag überein. Bitte ruf uns an, um vor dem Weitermachen mit dem Vorstand zu sprechen.';

  @override
  String get wizardDuplicatePreviouslyWithdrawnTitle =>
      'Du hattest schon einmal einen Antrag';

  @override
  String get wizardDuplicatePreviouslyWithdrawnBody =>
      'Dein Name und dein Geburtsdatum stimmen mit einem älteren Antrag überein, den du zurückgezogen hattest. Willkommen zurück — bitte ruf uns vor dem Fortfahren an, damit der Vorstand entscheiden kann, wie wir weitermachen.';

  @override
  String get wizardDuplicateCallUsTitle => 'Bitte ruf uns an';

  @override
  String get wizardDuplicateCallUsBody =>
      'Dein Name und Geburtsdatum sind bei uns bereits vorhanden, aber wir können dir die Details nicht über die App mitteilen. Bitte ruf uns an — der Vorstand erklärt dir die Situation direkt.';

  @override
  String get wizardChatHelp => 'Lass uns reden';

  @override
  String get wizardChatHelpSubtitle =>
      'Live-Chat mit dem Vorstand · schnelle Antwort';

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

  @override
  String get signaturWartetZweiteUnterschrift =>
      'Warten auf die zweite Unterschrift';

  @override
  String get signaturWartenHinweis =>
      'Sie haben unterschrieben. Das Dokument wird gesiegelt, sobald auch die zweite Person unterschrieben hat.';

  @override
  String get kontaktNochAktuell => 'Stimmen diese Angaben noch?';

  @override
  String get kontaktWarumFragen =>
      'Damit Sie nichts verpassen, fragen wir alle drei Monate kurz nach. Sie bekommen einen sechsstelligen Code.';

  @override
  String kontaktBestaetigtAm(Object datum) {
    return 'bestätigt am $datum';
  }

  @override
  String get kontaktFestnetzKeinSms =>
      'Das ist eine Festnetznummer — dorthin kommt keine SMS an.';

  @override
  String get kontaktIstAndersGeworden => 'Ist anders geworden';

  @override
  String get themeTitle => 'Darstellung';

  @override
  String get themeLight => 'Hell';

  @override
  String get themeDark => 'Dunkel';

  @override
  String get themeSystem => 'Gerät folgen';

  @override
  String get themeSchedule => 'Automatisch (20:00–06:00)';

  @override
  String get themeScheduleHint =>
      'Von 20 Uhr bis 6 Uhr dunkel, den Rest des Tages hell.';
}
