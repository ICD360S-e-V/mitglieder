// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get appTitle => 'ICD360S e.V - Portale Membri';

  @override
  String get memberPortal => 'Portale Membri';

  @override
  String get welcomeLoading => 'Caricamento...';

  @override
  String get welcomeAutoLogin => 'Accesso automatico...';

  @override
  String get login => 'Accedi';

  @override
  String get register => 'Registrati';

  @override
  String get becomeMember => 'Diventa Membro';

  @override
  String get memberNumber => 'Numero Membro';

  @override
  String get memberNumberHint => 'Inserisci il numero membro';

  @override
  String get password => 'Password';

  @override
  String get passwordHint => 'Inserisci la password';

  @override
  String get confirmPassword => 'Conferma Password';

  @override
  String get confirmPasswordHint => 'Conferma la password';

  @override
  String get newPassword => 'Nuova Password';

  @override
  String get newPasswordHint => 'Inserisci la nuova password';

  @override
  String get saveCredentials => 'Salva credenziali';

  @override
  String get autoLogin => 'Accesso automatico';

  @override
  String get forgotPassword => 'Password dimenticata?';

  @override
  String get firstName => 'Nome e Cognome';

  @override
  String get firstNameHint => 'Inserisci nome e cognome';

  @override
  String get nameMinLength => 'Il nome deve avere almeno 2 caratteri';

  @override
  String get nameOnlyLetters => 'Sono ammesse solo lettere e trattini';

  @override
  String get email => 'Indirizzo Email';

  @override
  String get emailHint => 'Inserisci l\'email';

  @override
  String get emailInvalid => 'Inserisci un\'email valida';

  @override
  String get passwordMinLength => 'La password deve avere almeno 6 caratteri';

  @override
  String get passwordsNotMatch => 'Le password non corrispondono';

  @override
  String get recoveryCode => 'Codice di Recupero (6 cifre)';

  @override
  String get recoveryCodeHelper =>
      'Ricorda questo codice per recuperare la password';

  @override
  String get recoveryCodeHint => 'Inserisci il codice di recupero';

  @override
  String get recoveryCodeInvalid => 'Il codice deve avere esattamente 6 cifre';

  @override
  String get loginFailed => 'Accesso fallito';

  @override
  String get registrationFailed => 'Registrazione fallita';

  @override
  String connectionError(String error) {
    return 'Errore di connessione: $error';
  }

  @override
  String registrationSuccess(String memberNumber) {
    return 'Registrazione riuscita!\n\nIl tuo numero membro: $memberNumber\n\nRicorda questo numero per l\'accesso.';
  }

  @override
  String get tooManyDevices => 'Troppi dispositivi';

  @override
  String get maxDevicesMessage =>
      'Sei già connesso su 3 dispositivi.\nSeleziona un dispositivo da disconnettere:';

  @override
  String get unknownDevice => 'Dispositivo sconosciuto';

  @override
  String get unknown => 'Sconosciuto';

  @override
  String get logoutError => 'Errore di disconnessione';

  @override
  String error(String error) {
    return 'Errore: $error';
  }

  @override
  String get cancel => 'Annulla';

  @override
  String get resetPassword => 'Reimposta Password';

  @override
  String get forgotPasswordTitle => 'Password Dimenticata';

  @override
  String get forgotPasswordDescription =>
      'Inserisci il numero membro e il codice di recupero creato durante la registrazione.';

  @override
  String get passwordResetSuccess =>
      'Password reimpostata con successo!\n\nOra puoi accedere con la nuova password.';

  @override
  String get passwordResetFailed => 'Reimpostazione password fallita';

  @override
  String get needHelp => 'Hai bisogno di aiuto?';

  @override
  String get helpQuestion => 'Problemi con l\'accesso o la registrazione?';

  @override
  String get helpDescription =>
      'Contattaci su WhatsApp e descrivi esattamente cosa non funziona. Risponderemo il prima possibile!';

  @override
  String get whatsapp => 'WhatsApp';

  @override
  String get emailSubject => 'Richiesta tramite app ICD360S';

  @override
  String get whatsappMessage => 'Ciao, ho un problema con l\'app ICD360S. ';

  @override
  String get imprint => 'Note Legali';

  @override
  String get privacy => 'Informativa Privacy';

  @override
  String get statutes => 'Statuto';

  @override
  String get revocation => 'Diritto di Recesso';

  @override
  String get cancellation => 'Cancellazione';

  @override
  String get allRightsReserved => 'Tutti i diritti riservati.';

  @override
  String get enterCredentials => 'Inserisci numero membro e password';

  @override
  String get appointments => 'Appuntamenti';

  @override
  String get tickets => 'Ticket';

  @override
  String get liveChat => 'Chat dal Vivo';

  @override
  String get notifications => 'Notifiche';

  @override
  String get myProfile => 'Il Mio Profilo';

  @override
  String get logout => 'Esci';

  @override
  String get goodMorning => 'Buongiorno';

  @override
  String get goodDay => 'Buona giornata';

  @override
  String get goodEvening => 'Buonasera';

  @override
  String get goodNight => 'Buonanotte';

  @override
  String get welcomeToICD => 'Benvenuto a ICD360S e.V!';

  @override
  String get accountCreatedSuccessfully =>
      'Il tuo account è stato creato con successo.';

  @override
  String get today => 'Oggi';

  @override
  String get membershipFeeDue => 'Quota associativa dovuta';

  @override
  String get pleaseTransferAnnualFee =>
      'Si prega di trasferire la quota annuale.';

  @override
  String get newBadge => 'Nuovo';

  @override
  String get close => 'Chiudi';

  @override
  String get membership => 'Iscrizione';

  @override
  String get myAppointments => 'I miei appuntamenti';

  @override
  String get appointmentsLoadingReady =>
      'Caricamento appuntamenti - API pronto!';

  @override
  String get priority => 'Priorità';

  @override
  String get messageLabel => 'Messaggio';

  @override
  String get createdOn => 'Creato';

  @override
  String get handler => 'Gestore';

  @override
  String get reportProblems => 'Segnala problemi';

  @override
  String get reportProblem => 'Segnala problema';

  @override
  String get weRespondIn24Hours =>
      'Ti risponderemo entro un massimo di 24 ore!';

  @override
  String get everythingOk => 'Tutto OK!';

  @override
  String get haveProblemWeHelp => 'Hai un problema?\nCe ne occupiamo noi!';

  @override
  String get myMembership => 'La mia iscrizione';

  @override
  String get managePersonalDataAndFee =>
      'Gestisci i tuoi dati personali e la quota';

  @override
  String get myAppointmentsTitle => 'I miei appuntamenti';

  @override
  String get appointmentsDescription =>
      'Qui puoi vedere i tuoi prossimi appuntamenti.\nPuoi confermare la tua partecipazione o rifiutare.';

  @override
  String get loadAppointments => 'Carica appuntamenti';

  @override
  String get myTickets => 'I miei ticket';

  @override
  String get newTicket => 'Nuovo ticket';

  @override
  String get noOpenTickets => 'Nessun ticket aperto';

  @override
  String get haveQuestionCreateTicket =>
      'Hai una domanda o un problema?\nCrea un nuovo ticket.';

  @override
  String get whatIsTheProblem => 'Qual è il problema?';

  @override
  String get describeTheProblem => 'Descrivi il problema';

  @override
  String get howUrgentIsIt => 'Quanto è urgente?';

  @override
  String get low => 'Bassa';

  @override
  String get medium => 'Media';

  @override
  String get high => 'Alta';

  @override
  String get submit => 'Invia';

  @override
  String get fillSubjectAndMessage => 'Compila oggetto e messaggio';

  @override
  String get ticketCreated => 'Ticket creato';

  @override
  String get errorCreatingTicket => 'Errore durante la creazione del ticket';

  @override
  String get verified => 'Verificato';

  @override
  String get account => 'Account';

  @override
  String get myDevices => 'I miei dispositivi';

  @override
  String get changeEmail => 'Cambia email';

  @override
  String get changePassword => 'Cambia password';

  @override
  String get newEmailAddress => 'Nuovo indirizzo email';

  @override
  String get currentPassword => 'Password attuale';

  @override
  String get saveEmail => 'Salva email';

  @override
  String get savePassword => 'Salva password';

  @override
  String get deviceLoggedOut => 'Dispositivo disconnesso';

  @override
  String get passwordChangedSuccessfully => 'Password modificata con successo';

  @override
  String get emailChangedSuccessfully => 'Email modificata con successo';

  @override
  String get errorChangingPassword =>
      'Errore durante la modifica della password';

  @override
  String get errorChangingEmail => 'Errore durante la modifica dell\'email';

  @override
  String get validEmailRequired => 'Inserisci un indirizzo email valido';

  @override
  String get passwordTooShort =>
      'La password deve essere di almeno 6 caratteri';

  @override
  String get maxDevicesReached => 'Sei connesso al massimo di 3 dispositivi.';

  @override
  String loggedInOnDevices(int count) {
    return 'Sei connesso su $count di 3 dispositivi.';
  }

  @override
  String get noActiveSessions => 'Nessuna sessione attiva';

  @override
  String get logoutFromDevice => 'Disconnetti da questo dispositivo';

  @override
  String get confirmLogoutDevice => 'Disconnettere dispositivo?';

  @override
  String get confirmLogoutMessage =>
      'Vuoi disconnetterti da questo dispositivo?\n\nDovrai accedere nuovamente per utilizzare questo dispositivo.';

  @override
  String get ipAddress => 'IP';

  @override
  String get platform => 'Piattaforma';

  @override
  String trialWarningUrgentTitle(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'Mancano solo $days giorni',
      one: 'Manca solo 1 giorno',
    );
    return 'Attenzione: $_temp0 alla sospensione dell\'account!';
  }

  @override
  String get trialWarningTitle => 'Il tuo account non è ancora verificato';

  @override
  String get trialWarningDescription =>
      'Completa i tuoi dati in \"Il Mio Profilo\". Dopo 30 giorni il tuo account verrà sospeso automaticamente.';

  @override
  String trialDaysRemaining(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days giorni',
      one: '1 giorno',
    );
    return '$_temp0';
  }

  @override
  String get overview => 'Panoramica';

  @override
  String get member => 'Membro';

  @override
  String get memberManagement => 'Gestione membri';

  @override
  String get reportProblemTooltip => 'Segnala problema';

  @override
  String get newAppointmentsTitle => 'Nuovi appuntamenti';

  @override
  String get youHaveNewAppointment => 'Hai un nuovo appuntamento.';

  @override
  String youHaveNewAppointments(int count) {
    return 'Hai $count nuovi appuntamenti.';
  }

  @override
  String get appointmentReminderTomorrow => 'Promemoria: Appuntamento domani';

  @override
  String tomorrowAppointment(String title) {
    return 'Domani: $title';
  }

  @override
  String youHaveTomorrowAppointments(int count) {
    return 'Hai $count appuntamenti domani.';
  }

  @override
  String get appointmentsToday => 'Appuntamenti oggi';

  @override
  String todayAppointment(String title) {
    return 'Oggi: $title';
  }

  @override
  String youHaveTodayAppointments(int count) {
    return 'Hai $count appuntamenti oggi.';
  }

  @override
  String get paymentReminder => 'Promemoria pagamento';

  @override
  String paymentReminderMessage(int day, String method) {
    return 'Oggi è il $day del mese – completa $method.';
  }

  @override
  String get paymentDayLabel => 'Giorno di pagamento (promemoria mensile)';

  @override
  String get updateAvailable => 'Aggiornamento disponibile';

  @override
  String newVersionAvailable(String version) {
    return 'È disponibile una nuova versione: $version';
  }

  @override
  String currentVersionLabel(String version) {
    return 'Versione attuale: $version';
  }

  @override
  String get changes => 'Modifiche:';

  @override
  String downloadProgress(String percent) {
    return 'Download: $percent%';
  }

  @override
  String get installationStarting => 'Installazione in corso...';

  @override
  String get appWillRestart => 'L\'applicazione si riavvierà automaticamente.';

  @override
  String get later => 'Più tardi';

  @override
  String get updateNow => 'Aggiorna ora';

  @override
  String get downloading => 'Download in corso...';

  @override
  String get downloadFailed => 'Download fallito. Riprova più tardi.';

  @override
  String get searchingForUpdates => 'Ricerca aggiornamenti...';

  @override
  String get appUpToDate => 'L\'app è aggiornata';

  @override
  String get updateCheckError => 'Errore nel controllo aggiornamenti';

  @override
  String get changelog => 'Registro delle modifiche';

  @override
  String get terminConfirmed => 'Appuntamento confermato';

  @override
  String get terminDeclined => 'Appuntamento rifiutato';

  @override
  String get terminRescheduleRequested => 'Riprogrammazione richiesta';

  @override
  String get statusConfirmed => 'Confermato';

  @override
  String get statusDeclined => 'Rifiutato';

  @override
  String get statusRescheduling => 'Riprogrammazione';

  @override
  String get statusPending => 'In attesa';

  @override
  String get categoryVorstandssitzung => 'Riunione del consiglio';

  @override
  String get categoryMitgliederversammlung => 'Assemblea generale';

  @override
  String get categorySchulung => 'Formazione';

  @override
  String get categorySonstiges => 'Altro';

  @override
  String openCount(int count) {
    return '$count aperti';
  }

  @override
  String get refresh => 'Aggiorna';

  @override
  String get filterUpcoming => 'Prossimi';

  @override
  String get filterPast => 'Passati';

  @override
  String get filterAll => 'Tutti';

  @override
  String get noUpcomingAppointments => 'Nessun appuntamento imminente';

  @override
  String get noPastAppointments => 'Nessun appuntamento passato';

  @override
  String get noAppointmentsAvailable => 'Nessun appuntamento disponibile';

  @override
  String get appointmentsShownHere =>
      'I tuoi appuntamenti saranno mostrati qui';

  @override
  String get dateLabel => 'Data';

  @override
  String get timeLabel => 'Ora';

  @override
  String get locationLabel => 'Luogo';

  @override
  String get createdByLabel => 'Creato da';

  @override
  String get descriptionLabel => 'Descrizione';

  @override
  String get ticketLabel => 'Ticket';

  @override
  String get yourStatus => 'Il tuo stato: ';

  @override
  String reasonLabel(String reason) {
    return 'Motivo: $reason';
  }

  @override
  String durationMinutes(int minutes) {
    return '$minutes min';
  }

  @override
  String get confirm => 'Conferma';

  @override
  String get decline => 'Rifiuta';

  @override
  String get reschedule => 'Riprogramma';

  @override
  String get requestReschedule => 'Richiedi riprogrammazione';

  @override
  String appointmentLabel(String title) {
    return 'Appuntamento: $title';
  }

  @override
  String get rescheduleReason => 'Motivo della riprogrammazione *';

  @override
  String get rescheduleReasonHint => 'Indica un motivo...';

  @override
  String get pleaseProvideReason => 'Indica un motivo';

  @override
  String get request => 'Richiedi';

  @override
  String get ticketStatusOpen => 'Aperto';

  @override
  String get ticketStatusInProgress => 'In corso';

  @override
  String get ticketStatusWaitingMember => 'In attesa del membro';

  @override
  String get ticketStatusWaitingStaff => 'In attesa del personale';

  @override
  String get ticketStatusWaitingAuthority => 'In attesa dell\'autorità';

  @override
  String get ticketStatusDone => 'Completato';

  @override
  String get ticketPriorityHigh => 'Alta';

  @override
  String get ticketPriorityMedium => 'Media';

  @override
  String get ticketPriorityLow => 'Bassa';

  @override
  String get comments => 'Commenti';

  @override
  String get documents => 'Documenti';

  @override
  String get details => 'Dettagli';

  @override
  String get replySent => 'Risposta inviata';

  @override
  String get sendError => 'Errore nell\'invio';

  @override
  String get uploading => 'Caricamento...';

  @override
  String fileUploaded(String filename) {
    return '$filename caricato';
  }

  @override
  String get uploadFailed => 'Caricamento fallito';

  @override
  String get openError => 'Errore nell\'apertura';

  @override
  String get noRepliesYet => 'Ancora nessuna risposta';

  @override
  String get waitingForSupport => 'In attesa di risposta dal supporto';

  @override
  String get writeReply => 'Scrivi una risposta...';

  @override
  String get attachFile => 'Allega file';

  @override
  String documentsCount(int count) {
    return 'Documenti ($count)';
  }

  @override
  String get upload => 'Carica';

  @override
  String get noDocuments => 'Nessun documento disponibile';

  @override
  String get allowedFormats => 'Formati consentiti: PDF, JPEG, JPG, TXT, ZIP';

  @override
  String get yourMessage => 'Il tuo messaggio:';

  @override
  String get translation => 'Traduzione';

  @override
  String get original => 'Originale';

  @override
  String get originalText => 'Testo originale';

  @override
  String get autoTranslated => 'Tradotto automaticamente';

  @override
  String get originalTapTranslation => 'Testo originale · Tocca per traduzione';

  @override
  String get translatedTapOriginal => 'Tradotto · Tocca per originale';

  @override
  String get justNow => 'Adesso';

  @override
  String minutesAgo(int minutes) {
    return '$minutes min fa';
  }

  @override
  String hoursAgo(int hours) {
    return '$hours ore fa';
  }

  @override
  String daysAgo(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'giorni',
      one: 'giorno',
    );
    return '$days $_temp0 fa';
  }

  @override
  String get createdLabel => 'Creato';

  @override
  String get updatedLabel => 'Aggiornato';

  @override
  String get handlerLabel => 'Responsabile';

  @override
  String get doneLabel => 'Completato';

  @override
  String get newTicketTitle => 'Nuovo ticket';

  @override
  String get categoryOptional => 'Categoria (opzionale)';

  @override
  String get selectCategory => 'Seleziona';

  @override
  String get subjectLabel => 'Oggetto';

  @override
  String get fillAllFields => 'Compila tutti i campi';

  @override
  String ticketCreatedId(int id) {
    return 'Ticket #$id creato';
  }

  @override
  String get priorityLabel => 'Priorità: ';

  @override
  String get supportOffline => 'Supporto offline';

  @override
  String get lastSeenSeconds => 'Attivo pochi secondi fa';

  @override
  String lastSeenMinutes(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: 'minuti',
      one: 'minuto',
    );
    return 'Attivo $minutes $_temp0 fa';
  }

  @override
  String lastSeenHours(int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: 'ore',
      one: 'ora',
    );
    return 'Attivo $hours $_temp0 fa';
  }

  @override
  String lastSeenDays(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'giorni',
      one: 'giorno',
    );
    return 'Attivo $days $_temp0 fa';
  }

  @override
  String get online => 'Online';

  @override
  String get callSupport => 'Chiama';

  @override
  String get typeMessage => 'Scrivi un messaggio...';

  @override
  String get callBusy => 'Supporto occupato';

  @override
  String get callRejected => 'Chiamata rifiutata';

  @override
  String get callFailed => 'Chiamata non riuscita';

  @override
  String get callEnded => 'Chiamata terminata';

  @override
  String get callSupportBusy => 'Il supporto è già in un\'altra chiamata';

  @override
  String get errorStartingChat => 'Errore avvio chat';

  @override
  String get errorStartingCall => 'Errore avvio chiamata';

  @override
  String get errorConnecting => 'Errore di connessione';

  @override
  String get errorAcceptingCall => 'Errore accettazione chiamata';

  @override
  String get errorDownloading => 'Errore download';

  @override
  String get errorUploading => 'Errore caricamento';

  @override
  String get errorSending => 'Errore invio';

  @override
  String get errorPickingPhotos => 'Errore selezione foto';

  @override
  String get errorPickingFiles => 'Errore selezione file';

  @override
  String get errorTakingPhoto => 'Errore scatto foto';

  @override
  String get fileNotLoaded => 'File non caricabile';

  @override
  String get attachmentIdMissing => 'ID allegato mancante';

  @override
  String get camera => 'Fotocamera';

  @override
  String get gallery => 'Galleria';

  @override
  String get file => 'File';

  @override
  String typingIndicator(String name) {
    return '$name sta scrivendo...';
  }

  @override
  String get notifNewMessageFrom => 'Nuovo messaggio da';

  @override
  String get notifUrgentPrefix => 'URGENTE';

  @override
  String get notifUrgentMessage => 'MESSAGGIO URGENTE';

  @override
  String get notifIncomingCall => 'Chiamata in arrivo';

  @override
  String get notifCallingYou => 'sta chiamando...';

  @override
  String get notifUpdateAvailable => 'Aggiornamento disponibile';

  @override
  String get notifVersionAvailable => 'è ora disponibile';

  @override
  String get notifConnected => 'Connesso';

  @override
  String get notifDisconnected => 'Disconnesso';

  @override
  String get notifConnectedBody => 'Sei ora connesso al server.';

  @override
  String get notifDisconnectedBody => 'La connessione al server è stata persa.';

  @override
  String get notifError => 'Errore';

  @override
  String get retry => 'Riprova';

  @override
  String get save => 'Salva';

  @override
  String get accept => 'Accetta';

  @override
  String get selectFile => 'Seleziona file';

  @override
  String get dataLoadingText => 'Caricamento dati...';

  @override
  String get dataSavedSuccess => 'Dati salvati con successo';

  @override
  String get errorSaving => 'Errore nel salvataggio';

  @override
  String get errorLoading => 'Errore nel caricamento';

  @override
  String savedFilename(String filename) {
    return 'Salvato: $filename';
  }

  @override
  String get logsCopied => 'Log copiati!';

  @override
  String get diagnosticDataTitle => 'Dati diagnostici';

  @override
  String get diagnosticDescription =>
      'Vuoi inviare dati diagnostici anonimi per migliorare l\'app?';

  @override
  String get noThanks => 'No, grazie';

  @override
  String get yesEnable => 'Sì, attiva';

  @override
  String get passwordMinEightChars =>
      'La password deve avere almeno 8 caratteri';

  @override
  String get passwordChangeSuccess => 'Password modificata con successo';

  @override
  String get emailChangeError => 'Errore nel cambio email';

  @override
  String get acceptDocumentCheckbox => 'Ho letto e accetto il documento.';

  @override
  String loadingErrorGeneric(String details) {
    return 'Errore di caricamento: $details';
  }

  @override
  String get incomingCallTitle => 'Chiamata in arrivo';

  @override
  String ringingFor(int seconds) {
    return 'Squilla da ${seconds}s';
  }

  @override
  String get rejectCall => 'Rifiuta';

  @override
  String get acceptCall => 'Accetta';

  @override
  String get unmute => 'Riattiva audio';

  @override
  String get mute => 'Disattiva audio';

  @override
  String get hangUp => 'Riaggancia';

  @override
  String get calling => 'Chiamata in corso...';

  @override
  String autoRejectIn(int seconds) {
    return 'Rifiuto automatico tra $seconds secondi';
  }

  @override
  String get speakerOn => 'Altoparlante';

  @override
  String get speakerOff => 'Auricolare';

  @override
  String get micMuted => 'Disattivato';

  @override
  String get micOn => 'Microfono';

  @override
  String get connectionExcellent => 'Eccellente';

  @override
  String get connectionGood => 'Buona';

  @override
  String get connectionWeak => 'Debole';

  @override
  String get connectionLost => 'Disconnesso';

  @override
  String get personalData => 'Dati personali';

  @override
  String get personalDataSubtitle => 'Nome, cognome, indirizzo';

  @override
  String get membershipFee => 'Quota associativa';

  @override
  String annualFeeYear(String year) {
    return 'Quota annuale $year';
  }

  @override
  String get amount => 'Importo:';

  @override
  String get dueBy => 'Scadenza:';

  @override
  String get paid => 'Pagato';

  @override
  String get versionHistory => 'Cronologia versioni';

  @override
  String lastUpdated(String date) {
    return 'Ultimo aggiornamento: $date';
  }

  @override
  String get noVersionHistory => 'Nessuna cronologia disponibile';

  @override
  String get failedLoadChangelog =>
      'Impossibile caricare il registro modifiche';

  @override
  String get callMember => 'Chiama membro';

  @override
  String get closeConversation => 'Chiudi conversazione';

  @override
  String get chatOffline => 'Offline';

  @override
  String get attachFiles => 'Allega file (max. 10, 50MB)';

  @override
  String get conversationClosed => 'Questa conversazione è stata chiusa';

  @override
  String get noMessages => 'Nessun messaggio';

  @override
  String get goBack => 'Indietro';

  @override
  String get goForward => 'Avanti';

  @override
  String get homePage => 'Home';

  @override
  String get firstNameLabel => 'Nome';

  @override
  String get lastNameLabel => 'Cognome';

  @override
  String get streetLabel => 'Via';

  @override
  String get houseNumberLabel => 'N.';

  @override
  String get postalCodeLabel => 'CAP';

  @override
  String get cityLabel => 'Città';

  @override
  String get phoneMobileLabel => 'Telefono (Cellulare)';

  @override
  String get phoneLandlineLabel => 'Telefono (Fisso)';

  @override
  String get newEmailLabel => 'Nuovo indirizzo email';

  @override
  String get currentPasswordLabel => 'Password attuale';

  @override
  String get newPasswordLabel => 'Nuova password';

  @override
  String get confirmPasswordLabel => 'Conferma password';

  @override
  String get emailChangedSuccess => 'Email modificata con successo';

  @override
  String get newPasswordMinChars => 'Nuova password (min. 6 caratteri)';

  @override
  String get reasonLabel2 => 'Motivo';

  @override
  String get downloadFailed2 => 'Download fallito';

  @override
  String get downloadTooltip => 'Scarica';

  @override
  String get connectionErrorGeneric => 'Errore di connessione';

  @override
  String get errorNoInternet => 'Nessuna connessione Internet. Controllare la rete.';

  @override
  String get errorTimeout => 'Il server non risponde. Riprovare più tardi.';

  @override
  String get errorServer => 'Errore del server. Riprovare più tardi.';

  @override
  String get errorConnection => 'Errore di connessione. Riprovare più tardi.';

  @override
  String get errorUnexpected => 'Si è verificato un errore imprevisto. Riprovare più tardi.';

  @override
  String get copyLogs => 'Copia log';

  @override
  String get deleteLogs => 'Elimina log';

  @override
  String get autoScrollOn => 'Scorrimento automatico ON';

  @override
  String get autoScrollOff => 'Scorrimento automatico OFF';

  @override
  String get unknownValue => 'Sconosciuto';

  @override
  String get bankTransfer => 'Bonifico bancario';

  @override
  String get standingOrder => 'Ordine permanente';

  @override
  String get payment => 'Pagamento';

  @override
  String get warningType_ermahnung => 'Ammonimento';

  @override
  String get warningType_abmahnung => 'Diffida';

  @override
  String get warningType_letzte => 'Ultima diffida';

  @override
  String warningsTotal(int count) {
    return 'Totale: $count';
  }

  @override
  String warningsErmahnung(int count) {
    return 'Ammonimenti: $count';
  }

  @override
  String warningsAbmahnung(int count) {
    return 'Diffide: $count';
  }

  @override
  String warningsLetzte(int count) {
    return 'Ultime: $count';
  }

  @override
  String get noWarnings => 'Nessun ammonimento';

  @override
  String get noWarningsDescription => 'Al momento non hai ammonimenti.';

  @override
  String createdBy(String name) {
    return 'Creato da: $name';
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
  String get monthMay => 'May';

  @override
  String get monthJun => 'Jun';

  @override
  String get monthJul => 'Jul';

  @override
  String get monthAug => 'Aug';

  @override
  String get monthSep => 'Sep';

  @override
  String get monthOct => 'Oct';

  @override
  String get monthNov => 'Nov';

  @override
  String get monthDec => 'Dec';

  @override
  String get stufe1_name => 'Dati personali';

  @override
  String get stufe2_name => 'Tipo di iscrizione';

  @override
  String get stufe3_name => 'Situazione finanziaria';

  @override
  String get stufe4_name => 'Metodo di pagamento';

  @override
  String get stufe5_name => 'Inizio iscrizione';

  @override
  String get stufe6_name => 'Statuto';

  @override
  String get stufe7_name => 'Informativa sulla privacy';

  @override
  String get stufe8_name => 'Diritto di recesso';

  @override
  String get memberType_ordentlich => 'Membro ordinario';

  @override
  String get memberType_foerder => 'Membro sostenitore';

  @override
  String get memberType_ehren => 'Membro onorario';

  @override
  String get memberDesc_ordentlich =>
      'Membro attivo con diritto di voto. Partecipa ai servizi dell\'associazione (email, cloud, supporto burocratico).';

  @override
  String get memberDesc_foerder =>
      'Sostiene l\'associazione con contributi. Può partecipare all\'assemblea generale con voto consultivo, senza diritto di voto o di elezione nel consiglio.';

  @override
  String get memberDesc_ehren =>
      'Ha i diritti di un membro ordinario senza obbligo di pagare la quota associativa. Nominato dall\'assemblea generale o dal consiglio.';

  @override
  String get payMethod_ueberweisung => 'Bonifico bancario';

  @override
  String get payMethod_dauerauftrag => 'Ordine permanente';

  @override
  String get verifyStatus_geprueft => 'Verificato';

  @override
  String get verifyStatus_ausgefuellt => 'Completato';

  @override
  String get verifyStatus_abgelehnt => 'Rifiutato';

  @override
  String get verifyStatus_offen => 'Aperto';

  @override
  String get fillRequiredFields => 'Compila tutti i campi obbligatori.';

  @override
  String get personalDataSaved => 'Dati personali salvati';

  @override
  String get selectMemberType => 'Seleziona un tipo di iscrizione.';

  @override
  String get memberTypeSaved => 'Tipo di iscrizione salvato';

  @override
  String get selectOption => 'Seleziona un\'opzione.';

  @override
  String get financialSaved => 'Situazione finanziaria salvata';

  @override
  String get selectPaymentMethod => 'Seleziona un metodo di pagamento.';

  @override
  String get paymentDataSaved => 'Dati di pagamento salvati';

  @override
  String get selectDate => 'Seleziona una data.';

  @override
  String get membershipStartSaved => 'Inizio iscrizione salvato';

  @override
  String get fileTooLarge => 'File troppo grande (max. 10 MB).';

  @override
  String get leistungsbescheidUploaded =>
      'Certificato delle prestazioni caricato con successo';

  @override
  String get verificationProgress => 'Progresso della verifica';

  @override
  String get notApplicable => 'Non applicabile';

  @override
  String get socialBenefitsExempt =>
      'Metodo di pagamento non richiesto per beneficiari di prestazioni sociali.';

  @override
  String get locked => 'Bloccato';

  @override
  String completePreviousStep(int step) {
    return 'Completa prima il passaggio $step.';
  }

  @override
  String rejectedNote(String note) {
    return 'Rifiutato: $note';
  }

  @override
  String get waitingForReview =>
      'In attesa di revisione da parte del consiglio.';

  @override
  String get stepApproved => 'Questo passaggio è stato verificato e approvato.';

  @override
  String get changesViaChat => 'Modifiche possibili solo tramite chat.';

  @override
  String get firstNameRequired => 'Nome *';

  @override
  String get lastNameRequired => 'Cognome *';

  @override
  String get birthDateLabel => 'Data di nascita *';

  @override
  String get streetRequired => 'Via *';

  @override
  String get houseNumberRequired => 'N. *';

  @override
  String get cityRequired => 'Città *';

  @override
  String get phoneRequired => 'Numero di telefono *';

  @override
  String get phonePurpose =>
      'Scopo: Contatto quando non raggiungibile tramite l\'app';

  @override
  String get selectMemberTypePrompt =>
      'Seleziona il tipo di iscrizione desiderato:';

  @override
  String get financialExplanation =>
      'Per verificare se hai diritto a una riduzione della quota, necessitiamo delle seguenti informazioni. Queste saranno utilizzate esclusivamente per determinare la tua quota associativa.';

  @override
  String get socialBenefitsQuestion =>
      'Ricevi attualmente prestazioni sociali?';

  @override
  String get optionBuergergeld => 'Sì, sussidio cittadino (Job Center)';

  @override
  String get optionSozialamt => 'Sì, assistenza sociale (Servizi Sociali)';

  @override
  String get optionNoBenefits => 'No, non ricevo prestazioni sociali';

  @override
  String get feeExempt => 'La tua quota mensile è: 0,00 €/mese';

  @override
  String get uploadLeistungsbescheid => 'Carica certificato delle prestazioni';

  @override
  String get uploadLeistungsbescheidHint =>
      'Carica un certificato delle prestazioni attuale entro 14 giorni per confermare l\'esenzione dalla quota.';

  @override
  String get allowedFormatsUpload =>
      'Formati consentiti: PDF, JPG, PNG (max. 10 MB)';

  @override
  String get feeRegular => 'La tua quota mensile è: 25,00 €/mese';

  @override
  String paymentDayReminder(int day) {
    return 'Riceverai un promemoria il $day di ogni mese.';
  }

  @override
  String get membershipStartPrompt =>
      'Scegli quando deve iniziare la tua iscrizione.';

  @override
  String get optionAfterVerification => 'Dopo il completamento della verifica';

  @override
  String get optionAfterVerificationDesc =>
      'L\'iscrizione inizia dal giorno della conferma del consiglio.';

  @override
  String get optionRetroFoundation =>
      'Retroattivo alla data di fondazione (01.08.2025)';

  @override
  String get optionRetroFoundationDesc =>
      'Diventi membro retroattivo dalla fondazione dell\'associazione.';

  @override
  String get optionRetroCustom => 'Retroattivo a un\'altra data';

  @override
  String get optionRetroCustomDesc =>
      'Scegli una data tra il 01.08.2025 e oggi.';

  @override
  String get selectDateLabel => 'Seleziona data';

  @override
  String get selectDateHint => 'Seleziona data...';

  @override
  String get dateNotBefore => 'Non prima del 01.08.2025 (data di fondazione)';

  @override
  String get feeExemptRetro =>
      'Esenzione dalla quota: 0,00 € retroattivo.\nSolo la data di iscrizione viene impostata retroattivamente.';

  @override
  String get retroactiveFees => 'Quote retroattive';

  @override
  String retroFeeCalculation(
      String from, String to, String months, String total) {
    return 'Periodo: $from – $to\nMesi: $months\nQuota: $months × 25,00 € = $total €';
  }

  @override
  String get pleaseReadSatzung => 'Leggi lo statuto dell\'associazione.';

  @override
  String get pleaseReadDatenschutz => 'Leggi l\'informativa sulla privacy.';

  @override
  String get pleaseReadWiderruf => 'Leggi il diritto di recesso.';

  @override
  String get acceptedAtRegistration => 'Accettato alla registrazione';

  @override
  String get confirmedByBoard =>
      'Sarà confermato dopo la revisione del consiglio.';

  @override
  String get docSatzung => 'Statuto';

  @override
  String get docDatenschutz => 'Informativa sulla privacy';

  @override
  String get docWiderruf => 'Diritto di recesso';

  @override
  String acceptedAtRegCount(int count) {
    return 'Accettato alla registrazione ($count/3)';
  }

  @override
  String acceptedOn(String date) {
    return 'Accettato il $date';
  }

  @override
  String get notAccepted => 'Non accettato';

  @override
  String get statusAccepted => 'Accettato';

  @override
  String get memberNumberTooLong =>
      'Numero di membro troppo lungo (max 20 caratteri)';

  @override
  String get onlyUppercaseAndNumbers =>
      'Sono consentite solo lettere maiuscole e numeri';

  @override
  String get passwordTooLong => 'Password troppo lunga (max 100 caratteri)';

  @override
  String get nameTooLong => 'Nome troppo lungo (max 100 caratteri)';

  @override
  String get emailTooLong => 'Email troppo lunga (max 255 caratteri)';

  @override
  String get legalAcknowledgePrefix => 'Ho preso visione della ';

  @override
  String get legalAcknowledgeSuffix => '.';

  @override
  String get legalStatutesSuffix =>
      ' dell\'ICD360S e.V. e li riconosco come vincolanti.';

  @override
  String get legalPleaseReadFirst => '(si prega di leggere prima)';

  @override
  String get statusActive => 'Attivo';

  @override
  String get statusSuspended => 'Sospeso';

  @override
  String get statusNew => 'Nuovo';

  @override
  String get statusCancelled => 'Cancellato';

  @override
  String get statusDeleted => 'Eliminato';

  @override
  String get roleMitglied => 'Membro';

  @override
  String get roleVorsitzer => 'Presidente';

  @override
  String get roleStellvertreter => 'Vicepresidente';

  @override
  String get roleSchatzmeister => 'Tesoriere';

  @override
  String get roleSchriftfuehrer => 'Segretario';

  @override
  String get roleBeisitzer => 'Assessore';

  @override
  String get roleKassierer => 'Cassiere';

  @override
  String get roleKassenpruefer => 'Revisore';

  @override
  String get roleEhrenamtlich => 'Volontario';

  @override
  String get roleMitgliedergruender => 'Membro Fondatore';

  @override
  String get roleEhrenmitglied => 'Membro Onorario';

  @override
  String get roleFoerdermitglied => 'Membro Sostenitore';

  @override
  String get memberTypeNotSet => 'Non ancora definito';

  @override
  String get payMethodSepa => 'Addebito diretto SEPA';

  @override
  String get labelStatus => 'Stato';

  @override
  String get labelMemberNumber => 'Numero di membro';

  @override
  String get labelRole => 'Ruolo';

  @override
  String get labelMemberType => 'Tipo di membro';

  @override
  String get labelPaymentMethod => 'Metodo di pagamento';

  @override
  String get labelRegisteredOn => 'Registrato il';

  @override
  String get labelLastLogin => 'Ultimo accesso';

  @override
  String get labelMemberSince => 'Membro dal';

  @override
  String get neverLoggedIn => 'Mai';

  @override
  String get notActivatedYet => 'Non ancora attivato';

  @override
  String get tabVerification => 'Verifica';

  @override
  String get tabWarnings => 'Avvertimenti';

  @override
  String get tabDocuments => 'Documenti';

  @override
  String get tabMembership => 'Iscrizione';

  @override
  String get pleaseEnterFirstName => 'Inserisci il nome';

  @override
  String get pleaseEnterLastName => 'Inserisci il cognome';

  @override
  String get noFileDataReceived => 'Nessun dato ricevuto';

  @override
  String get openFile => 'Apri';

  @override
  String get diagnosticErrors => 'Segnalazioni errori per miglioramento';

  @override
  String get diagnosticAnonymousStats => 'Statistiche di utilizzo anonime';

  @override
  String get diagnosticPerformance => 'Dati sulle prestazioni dell\'app';

  @override
  String get noMicrophoneError =>
      'Nessun microfono trovato. Collegare un microfono e riprovare.';

  @override
  String get startConversation => 'Avvia una conversazione!';

  @override
  String get staffWillReply => 'Un collaboratore ti risponderà presto.';

  @override
  String get inCall => 'In chiamata...';

  @override
  String get registration => 'Registrazione';

  @override
  String get deactivation => 'Disattivazione';

  @override
  String get deactivatedOn => 'Disattivato il';

  @override
  String get accountAutoSuspend =>
      'Gli account non verificati entro 30 giorni verranno sospesi automaticamente.';

  @override
  String get ipClean => 'IP pulito - non elencato';

  @override
  String get documentsProvidedByBoard =>
      'I documenti sono forniti dal consiglio direttivo.';

  @override
  String get noDocumentsAvailable => 'Nessun documento disponibile';

  @override
  String get noDocumentsDescription =>
      'Non sono ancora stati forniti documenti per te.';

  @override
  String uploadedBy(String name) {
    return 'Caricato da: $name';
  }

  @override
  String stepsCompleted(int completed, int total) {
    return '$completed/$total passaggi completati';
  }

  @override
  String dayOfMonth(int day) {
    return '$day del mese';
  }

  @override
  String changeField(String field) {
    return 'Modifica $field';
  }

  @override
  String openDocument(String name) {
    return 'Apri $name';
  }

  @override
  String get helpImproveApp => 'Vuoi aiutarci a migliorare l\'app?';

  @override
  String get noPersonalDataCollected =>
      'Nessun dato personale viene raccolto. Questa impostazione può essere modificata in qualsiasi momento.';

  @override
  String logEntries(int count) {
    return '$count voci';
  }

  @override
  String get noLogs => 'Nessun registro';

  @override
  String get newLoginDetected => 'Nuovo accesso rilevato';

  @override
  String get waitingForMember => 'In attesa del membro';

  @override
  String get waitingForStaff => 'In attesa del personale';

  @override
  String get waitingForAuthority => 'In attesa dell\'autorità';
}
