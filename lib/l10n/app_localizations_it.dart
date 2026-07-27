// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

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
  String get confirmPassword => 'Conferma Password';

  @override
  String get confirmPasswordHint => 'Conferma la password';

  @override
  String get newPassword => 'Nuova Password';

  @override
  String get newPasswordHint => 'Inserisci la nuova password';

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
  String get unknown => 'Sconosciuto';

  @override
  String error(String error) {
    return 'Errore: $error';
  }

  @override
  String get cancel => 'Annulla';

  @override
  String get resetPassword => 'Reimposta Password';

  @override
  String get imprint => 'Note Legali';

  @override
  String get privacy => 'Informativa Privacy';

  @override
  String get statutes => 'Statuto';

  @override
  String get revocation => 'Diritto di Recesso';

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
  String get myAppointments => 'I miei appuntamenti';

  @override
  String get priority => 'Priorità';

  @override
  String get messageLabel => 'Messaggio';

  @override
  String get reportProblems => 'Segnala problemi';

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
  String get low => 'Bassa';

  @override
  String get high => 'Alta';

  @override
  String get submit => 'Invia';

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
  String get saveEmail => 'Salva email';

  @override
  String get savePassword => 'Salva password';

  @override
  String get deviceLoggedOut => 'Dispositivo disconnesso';

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
  String get autoUpdateEnableTitle => 'Install future updates automatically';

  @override
  String get autoUpdateEnableHint =>
      'The app downloads and installs updates on its own and restarts briefly. No further prompts.';

  @override
  String autoUpdateInstalling(String version) {
    return 'Version $version is being installed in the background. The app will restart shortly.';
  }

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
  String get reasonLabel2 => 'Motivo';

  @override
  String get downloadFailed2 => 'Download fallito';

  @override
  String get downloadTooltip => 'Scarica';

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
  String logEntries(int count) {
    return '$count voci';
  }

  @override
  String get noLogs => 'Nessun registro';

  @override
  String get newLoginDetected => 'Nuovo accesso rilevato';

  @override
  String get errorNoInternet =>
      'Nessuna connessione Internet. Controllare la rete.';

  @override
  String get errorTimeout => 'Il server non risponde. Riprovare più tardi.';

  @override
  String get errorServer => 'Errore del server. Riprovare più tardi.';

  @override
  String get errorConnection => 'Errore di connessione. Riprovare più tardi.';

  @override
  String get errorUnexpected =>
      'Si è verificato un errore imprevisto. Riprovare più tardi.';

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
  String get claudiuWelcomeMorning => 'Buongiorno';

  @override
  String get claudiuWelcomeDay => 'Salve';

  @override
  String get claudiuWelcomeEvening => 'Buonasera';

  @override
  String get claudiuWelcomeNight => 'Buonasera';

  @override
  String get claudiuWelcomeVisitor => 'caro visitatore';

  @override
  String get claudiuWelcomeAsk => 'Come posso aiutarti?';

  @override
  String get claudiuWelcomeBecomeMember => 'Voglio diventare socio';

  @override
  String get claudiuWelcomeLogin => 'Sono già socio e voglio accedere';

  @override
  String get claudiuWelcomeProblem => 'Ho un problema con l\'app';

  @override
  String get claudiuWelcomeEmergency => 'Emergenza — chiamaci';

  @override
  String get claudiuWelcomeMascotName => 'Claudiu';

  @override
  String get claudiuWelcomeEmergencyIntro =>
      'Prima di chiamare — i nostri orari:';

  @override
  String get claudiuWelcomeScheduleOffice => 'In ufficio';

  @override
  String get claudiuWelcomeScheduleField => 'Sul campo con i clienti';

  @override
  String get claudiuWelcomeOutsideHoursNote =>
      'Fuori da questi orari gestiamo solo le emergenze. Puoi anche inviarci un SMS allo stesso numero — ti ricontatteremo.';

  @override
  String get claudiuWelcomeCallNow => 'Chiama ora';

  @override
  String get claudiuWelcomeSendSms => 'Invia SMS';

  @override
  String get claudiuWelcomeSmsBody =>
      'Emergenza ICD360S e.V. — vi prego di contattarmi al più presto.';

  @override
  String get claudiuWelcomeCloseButton => 'Chiudi';

  @override
  String get claudiuLoginWelcome => 'Bentornato, caro socio!';

  @override
  String get claudiuLoginAsk => 'Dimmi il tuo numero di socio, per favore.';

  @override
  String get claudiuLoginProgress => 'Quasi… continua a digitare.';

  @override
  String get claudiuLoginReady => 'Perfetto! Premi il pulsante qui sotto.';

  @override
  String get claudiuLoginLoading => 'Sto verificando l\'identità… 🔍';

  @override
  String get claudiuLoginFoundPlain => 'Ti ho trovato! Accesso in corso…';

  @override
  String claudiuLoginFoundNamed(String name) {
    return 'Ti ho trovato, $name! Accesso in corso…';
  }

  @override
  String get claudiuLoginError =>
      'Hm, non trovo questo numero. L\'hai scritto correttamente?';

  @override
  String get claudiuLoginForgotHeader => 'Hai dimenticato il numero di socio?';

  @override
  String get claudiuLoginNoSms => 'Non inviamo il numero via email o SMS.';

  @override
  String get claudiuLoginOnlyWay =>
      'L\'unico modo: incontrarci di persona presso l\'ufficio dell\'associazione, dopo verifica del documento.';

  @override
  String get claudiuLoginContactUs => 'Chiamaci per un appuntamento:';

  @override
  String get claudiuDiagnosticGreeting =>
      'Prima di entrare, una domanda veloce';

  @override
  String get claudiuDiagnosticAsk =>
      'Posso inviare report anonimi affinché gli sviluppatori migliorino l\'app?';

  @override
  String get claudiuDiagnosticYes => 'Sì, voglio aiutare';

  @override
  String get claudiuDiagnosticNo => 'No, sto solo guardando';

  @override
  String get claudiuDiagnosticTellMore => 'Dimmi di più';

  @override
  String get claudiuDiagnosticSendsHeader => '📤 Cosa INVIAMO (anonimo):';

  @override
  String get claudiuDiagnosticSends1 =>
      'Un codice anonimo del dispositivo (NON il numero socio)';

  @override
  String get claudiuDiagnosticSends2 => 'Il tuo ruolo (socio / direttivo)';

  @override
  String get claudiuDiagnosticSends3 =>
      'Sistema operativo (Linux / Android / iOS / Windows)';

  @override
  String get claudiuDiagnosticSends4 => 'Lingua scelta';

  @override
  String get claudiuDiagnosticSends5 => 'Livello e stato batteria';

  @override
  String get claudiuDiagnosticSends6 => 'Schermata attuale';

  @override
  String get claudiuDiagnosticSends7 => 'Durata sessione (secondi)';

  @override
  String get claudiuDiagnosticSends8 => 'Eventuali errori (ultimi 10)';

  @override
  String get claudiuDiagnosticSends9 => 'Navigazione (ultime 20 schermate)';

  @override
  String get claudiuDiagnosticNeverHeader => '🛡️ Cosa non inviamo MAI:';

  @override
  String get claudiuDiagnosticNever1 => 'Il tuo nome reale';

  @override
  String get claudiuDiagnosticNever2 => 'Indirizzo email';

  @override
  String get claudiuDiagnosticNever3 => 'Numero di telefono';

  @override
  String get claudiuDiagnosticNever4 => 'Password';

  @override
  String get claudiuDiagnosticNever5 => 'Contenuto dei messaggi di chat';

  @override
  String get claudiuDiagnosticNever6 => 'Contenuto dei ticket';

  @override
  String get claudiuDiagnosticNever7 => 'Documenti o allegati';

  @override
  String get claudiuDiagnosticTechHeader => '📡 Dettagli tecnici:';

  @override
  String get claudiuDiagnosticTech1 => 'Inviato ogni 2 minuti';

  @override
  String get claudiuDiagnosticTech2 =>
      'Connessione cifrata TLS con certificato pinned';

  @override
  String get claudiuDiagnosticTech3 =>
      'Puoi disattivarlo in qualsiasi momento dalle Impostazioni';

  @override
  String get claudiuProblemHelpTitle => 'Come posso aiutare?';

  @override
  String get claudiuProblemHelpGreeting => 'Cosa è successo?';

  @override
  String get claudiuProblemHelpAsk => 'Come vuoi raccontarmelo?';

  @override
  String get claudiuProblemHelpWriteTitle => 'Scrivere un report';

  @override
  String get claudiuProblemHelpWriteBody =>
      'Con dettagli passo dopo passo. Il team riceve il testo e lo risolve più tardi.';

  @override
  String get claudiuProblemHelpChatTitle => 'Parliamone ora';

  @override
  String get claudiuProblemHelpChatBody =>
      'Chat anonima con un operatore. Risposta in tempo reale se qualcuno è online.';

  @override
  String get claudiuProblemHelpAltCallHeader => 'Oppure, se è urgente:';

  @override
  String get claudiuProblemHelpAltCallLabel => 'Chiamaci';

  @override
  String get claudiuAnonymousChatTitle => 'Chat anonima';

  @override
  String get claudiuAnonymousChatGreeting => 'Ciao!';

  @override
  String get claudiuAnonymousChatWelcome =>
      'Ti ascolto. Scrivi qualunque cosa — niente nome. Risponderò appena sono qui.';

  @override
  String get claudiuAnonymousChatHint => 'Scrivi un messaggio…';

  @override
  String get claudiuAnonymousChatWaitingOperator =>
      'In attesa della risposta di un operatore…';

  @override
  String get claudiuVorsitzerConnectedTitle => 'Ciao!';

  @override
  String get claudiuVorsitzerConnectedBody =>
      'Grazie per averci scritto — ora sei in contatto con un Vorsitzer. Dicci come possiamo aiutarti con la tua domanda di iscrizione.';

  @override
  String get claudiuVorsitzerConnectedSender => 'Vorsitzer';

  @override
  String get claudiuQuickReplyValidationTime => 'Quanto dura la verifica?';

  @override
  String get claudiuQuickReplyDocuments => 'Quali documenti mi servono?';

  @override
  String get claudiuQuickReplyStepProblem => 'Sono bloccato su un passaggio';

  @override
  String get claudiuQuickReplyHuman => 'Posso parlare con qualcuno adesso?';

  @override
  String get claudiuAnonymousChatConnecting => 'Connessione…';

  @override
  String get claudiuAnonymousChatConnectionFailed =>
      'Impossibile aprire la chat. Riprova o chiamaci.';

  @override
  String get claudiuAnonymousChatRetry => 'Riprova';

  @override
  String get claudiuAnonymousChatOnline => 'Connesso';

  @override
  String get claudiuAnonymousChatOffline => 'Riconnessione…';

  @override
  String get claudiuAnonymousChatAdminTyping => 'L\'operatore sta scrivendo…';

  @override
  String get claudiuProblemReportTitle => 'Segnala un problema';

  @override
  String get claudiuProblemReportGreeting => 'Cosa è successo?';

  @override
  String get claudiuProblemReportAsk =>
      'Dimmi nei dettagli e inoltro il report al team.';

  @override
  String get claudiuProblemReportIncludeHeader => 'Per favore includi:';

  @override
  String get claudiuProblemReportIncludeBullets1 =>
      'Cosa stavi facendo quando è apparso il problema';

  @override
  String get claudiuProblemReportIncludeBullets2 =>
      'Qualsiasi messaggio di errore visto';

  @override
  String get claudiuProblemReportIncludeBullets3 => 'Su quale schermata eri';

  @override
  String get claudiuProblemReportIncludeBullets4 =>
      'L\'app si blocca, si chiude o mostra schermo bianco?';

  @override
  String get claudiuProblemReportIncludeBullets5 =>
      'Succede ogni volta o solo una volta?';

  @override
  String get claudiuProblemReportDescriptionLabel => 'La tua descrizione';

  @override
  String get claudiuProblemReportDescriptionHint =>
      'Es.: Quando apro la schermata chat compare \'Connection error\' e l\'app non risponde…';

  @override
  String claudiuProblemReportTooShort(int count) {
    return 'Un po\' più di dettagli, per favore (almeno $count caratteri)';
  }

  @override
  String get claudiuProblemReportSubmit => 'Invia report';

  @override
  String get claudiuProblemReportSubmitting => 'Invio…';

  @override
  String get claudiuProblemReportSentTitle => 'Grazie!';

  @override
  String get claudiuProblemReportSentBody =>
      'Il report è stato inviato. Il nostro team lo esaminerà il prima possibile.';

  @override
  String get claudiuProblemReportSentClose => 'Capito';

  @override
  String get claudiuProblemReportSendFailed =>
      'Impossibile inviare il report. Chiamaci per assistenza urgente.';

  @override
  String get claudiuProblemReportAlt => 'Oppure, se è urgente:';

  @override
  String get claudiuProblemReportCallLabel => 'Chiamaci';

  @override
  String claudiuApprovalGreeting(String name) {
    return 'Ciao, $name! 👋';
  }

  @override
  String get claudiuApprovalGreetingNoName => 'Ciao! 👋';

  @override
  String get claudiuApprovalGladToSeeYou => 'Sono contento che sei qui!';

  @override
  String get claudiuApprovalCheckingForSafety =>
      'Per la tua sicurezza, un Vorsitzer sta controllando la tua richiesta di accesso. 🛡️';

  @override
  String get claudiuApprovalMonthlyExplain =>
      '💡 Lo facciamo ogni 30 giorni per essere sicuri che sei davvero tu. È come un check-up di sicurezza — massimo 5 minuti.';

  @override
  String get claudiuApprovalSuccess =>
      'Fatto! 🎉 Il Vorsitzer ti ha riconosciuto. Accesso in corso…';

  @override
  String get claudiuApprovalDenied =>
      'Hm, il Vorsitzer ha rifiutato la tua richiesta. 😔';

  @override
  String get claudiuApprovalDeniedHelp =>
      'Se pensi che sia un errore, ti prego chiamaci per chiarire.';

  @override
  String get claudiuApprovalExpired =>
      'Sono passati 5 minuti e il Vorsitzer non ha risposto.';

  @override
  String get claudiuApprovalExpiredHelp =>
      'Chiamaci e possiamo approvare la tua richiesta sul momento. 📞';

  @override
  String get claudiuApprovalCallUs => 'Chiamaci';

  @override
  String get claudiuApprovalTryAgain => 'Riprova';

  @override
  String get claudiuApprovalCancel => 'Annulla';

  @override
  String get claudiuApprovalClose => 'Chiudi';

  @override
  String get wizardIntroBubble1 =>
      'Ciao, visitatore! 👋 Grazie per voler entrare nella nostra famiglia.';

  @override
  String get wizardIntroBubble2 =>
      'Mi chiamo Claudiu. Nella primavera del 2025 avevo una visione chiara: creare un\'associazione che aiuti le persone in difficoltà — volontariamente, di cuore, senza burocrazia inutile. ❤️';

  @override
  String get wizardIntroBubble3 =>
      'Ho iniziato a parlare con i clienti che visitavo. Ho raccontato loro il mio sogno. E ognuno ha detto: «Sì, andiamo!». Nel luglio 2025 ci siamo incontrati — 6 persone determinate. Abbiamo deciso di fondare **ICD360S e.V.** a Neu-Ulm. 📍';

  @override
  String get wizardIntroBubble4 =>
      'Il **1° agosto 2025**, l\'associazione è ufficialmente nata — nel Registro delle Associazioni. Il regalo più bello per me. 🎂';

  @override
  String get wizardIntroBubble5 =>
      'Cosa facciamo? Aiutiamo rifugiati, persone con disabilità, persone economicamente svantaggiate, **bambini e giovani** — con pratiche burocratiche, lingua tedesca, casa, spesa, prestazioni sociali. Il nostro Vorstand è composto in maggioranza da persone con disabilità — così le decisioni nascono dall\'esperienza vissuta. 🤝';

  @override
  String get wizardIntroBubble6 =>
      'Ora tocca a te. Iscriviamoti — ci vogliono circa 5 minuti. Andiamo passo dopo passo, non ti lascio solo. ✨';

  @override
  String get wizardIntroStart => 'Iniziamo';

  @override
  String get wizardBack => 'Indietro';

  @override
  String get wizardNext => 'Avanti';

  @override
  String wizardStepLabel(int step, int total, String title) {
    return 'Passo $step di $total · $title';
  }

  @override
  String get wizardErrRequired => 'Questo campo è obbligatorio';

  @override
  String wizardErrTooShort(int count) {
    return 'Troppo corto (almeno $count caratteri)';
  }

  @override
  String get wizardErrOnlyLetters =>
      'Solo lettere, spazi, trattini e apostrofi';

  @override
  String get wizardErrSaveFailed =>
      'Salvataggio non riuscito. Controlla la connessione e riprova.';

  @override
  String get wizardStufe1aTitle => 'Identità';

  @override
  String get wizardStufe1aPrompt =>
      'Conosciamoci ufficialmente. Per favore scrivi il tuo nome esattamente come compare sul Personalausweis, Reisepass o Aufenthaltstitel — così resta coerente con i tuoi documenti.';

  @override
  String get wizardStufe1aVornameLabel => 'Vornamen (nomi)';

  @override
  String get wizardStufe1aVornameHelper =>
      'Tutti i tuoi nomi, esattamente come sul documento. Con spazio o trattino (es. Hans-Peter, Maria Anna).';

  @override
  String get wizardStufe1aNachnameLabel => 'Familienname (cognome)';

  @override
  String get wizardStufe1aNachnameHelper => 'Il tuo cognome attuale.';

  @override
  String get wizardStufe1aGeburtsnameLabel =>
      'Geburtsname (nome di nascita) — facoltativo';

  @override
  String get wizardStufe1aGeburtsnameHelper =>
      'Solo se diverso dal Familienname — per esempio prima del matrimonio.';

  @override
  String get wizardStufe1bTitle => 'Compleanno';

  @override
  String get wizardStufe1bPrompt =>
      'Vorremmo festeggiare il tuo compleanno con te! 🎂 E ci aiuta a confermare che hai almeno 16 anni — così dice il nostro Satzung.';

  @override
  String get wizardStufe1bGeburtsdatumLabel => 'Data di nascita';

  @override
  String get wizardStufe1bGeburtsdatumHelper => 'Tocca per scegliere una data';

  @override
  String get wizardStufe1bGeburtsortLabel => 'Luogo di nascita';

  @override
  String get wizardStufe1bGeburtsortHelper => 'Città / località dove sei nato.';

  @override
  String get wizardAgeGatePrompt => 'Mi dispiace… 😔';

  @override
  String wizardAgeGateBody1(int age, int years) {
    return 'Il nostro Satzung dice che devi avere almeno 16 anni per diventare socio. Hai $age anni — spero di rivederti tra $years anni! 🌱';
  }

  @override
  String get wizardAgeGateBody2 =>
      'Se vuoi fare volontariato occasionalmente (qualsiasi età, con il consenso dei genitori), chiamaci — ci piace sostenere i giovani che vogliono cambiare il mondo.';

  @override
  String get wizardAgeGateBackHome => 'Torna alla home';

  @override
  String get wizardErrInvalidPhone => 'Numero di telefono non valido';

  @override
  String get wizardStufe1b1Title => 'Consenso del genitore';

  @override
  String get wizardStufe1b1Prompt =>
      'Sei minorenne (16-17) — secondo §106 BGB ci serve il consenso di un genitore o tutore legale. Dimmi il nome e il telefono. Un Vorsitzer chiamerà e fisserà un incontro (di persona o videochiamata). Niente email — vogliamo essere sicuri di parlare con la persona giusta.';

  @override
  String get wizardStufe1b1VornameLabel => 'Nome del genitore';

  @override
  String get wizardStufe1b1VornameHelper =>
      'Come sul Personalausweis del genitore.';

  @override
  String get wizardStufe1b1NachnameLabel => 'Cognome del genitore';

  @override
  String get wizardStufe1b1NachnameHelper =>
      'Come sul Personalausweis del genitore.';

  @override
  String get wizardStufe1b1TelefonLabel => 'Cellulare del genitore';

  @override
  String get wizardStufe1b1TelefonHelper =>
      'Un Vorsitzer chiamerà questo numero.';

  @override
  String get wizardStufe1b1RelationLabel => 'Rapporto con il/la minore:';

  @override
  String get wizardStufe1b1RelationMutter => 'Madre';

  @override
  String get wizardStufe1b1RelationVater => 'Padre';

  @override
  String get wizardStufe1b1RelationSorgeberechtigter => 'Tutore legale';

  @override
  String get wizardStufe1b1RelationAndere => 'Altro tutore';

  @override
  String get wizardStufe1cTitle => 'Dettagli personali';

  @override
  String get wizardStufe1cPrompt =>
      'Solo per conoscerti un po\' meglio. Resta tra noi e non viene mostrato pubblicamente da nessuna parte.';

  @override
  String get wizardStufe1cGeschlechtLabel => 'Genere';

  @override
  String get wizardStufe1cGeschlechtMaennlich => 'Uomo';

  @override
  String get wizardStufe1cGeschlechtWeiblich => 'Donna';

  @override
  String get wizardStufe1cGeschlechtDivers => 'Altro';

  @override
  String get wizardStufe1cGeschlechtKeineAngabe => 'Preferisco non dirlo';

  @override
  String get wizardStufe1cFamilienstandLabel => 'Stato civile';

  @override
  String get wizardStufe1cFamilienstandLedig => 'Celibe / Nubile';

  @override
  String get wizardStufe1cFamilienstandVerheiratet => 'Sposato/a';

  @override
  String get wizardStufe1cFamilienstandGeschieden => 'Divorziato/a';

  @override
  String get wizardStufe1cFamilienstandVerwitwet => 'Vedovo/a';

  @override
  String get wizardStufe1dTitle => 'Le tue origini';

  @override
  String get wizardStufe1dPrompt =>
      'Ci aiuta a offrirti il supporto giusto — per esempio consigli sull\'Aufenthalt o trovare la tua comunità linguistica.';

  @override
  String get wizardStufe1dStaatLabel => 'Cittadinanza';

  @override
  String get wizardStufe1dStaatHelper =>
      'Es. deutsch, rumänisch, ukrainisch. Più separate da virgola.';

  @override
  String get wizardStufe1dAufenthaltLabel =>
      'Stato di soggiorno (Aufenthaltsstatus) — facoltativo';

  @override
  String get wizardStufe1dAufenthaltHelper =>
      'Scegli il titolo dalla tua Aufenthaltskarte / decisione. Il Vorstand controlla con i tuoi documenti.';

  @override
  String get wizardStufe1dAufenthaltAwaitingCitizenship =>
      'Compila prima la cittadinanza sopra — mostriamo solo le opzioni pertinenti.';

  @override
  String get wizardStufe1dAufenthaltGerman =>
      'Nessun Aufenthaltstitel necessario — cittadino tedesco.';

  @override
  String get wizardStufe1dAufenthaltEuEea =>
      'Cittadino UE/SEE/CH — libera circolazione (Freizügigkeit).';

  @override
  String get wizardStufe1dAufenthaltTempHint => 'temporaneo';

  @override
  String get wizardStufe1dAufenthaltPermHint => 'soggiorno permanente';

  @override
  String get wizardStufe1dAufenthaltAsylumProcessHint => 'procedura di asilo';

  @override
  String get wizardStufe1dAufenthaltOther =>
      'Altro (per favore specifica in chat)';

  @override
  String get wizardStufe1dAufenthaltRequired =>
      'Per favore scegli un Aufenthaltstitel.';

  @override
  String get wizardStufe1dMutterspracheLabel => 'Lingua madre';

  @override
  String get wizardStufe1dMutterspracheHelper =>
      'Precompilato con la lingua dell\'app — modifica se diversa.';

  @override
  String get wizardStufe1eTitle => 'Indirizzo';

  @override
  String get wizardStufe1ePrompt =>
      'Il tuo indirizzo postale — lo usiamo per documenti ufficiali (Satzung, contratti di socio, avvisi).';

  @override
  String get wizardStufe1eStrasseLabel => 'Via';

  @override
  String get wizardStufe1eStrasseHelper =>
      'Solo il nome della via — il numero nel campo accanto.';

  @override
  String get wizardStufe1eHausnummerLabel => 'N°';

  @override
  String get wizardStufe1ePlzLabel => 'PLZ (CAP)';

  @override
  String get wizardStufe1eOrtLabel => 'Città';

  @override
  String get wizardStufe1eLandLabel => 'Paese';

  @override
  String get wizardStufe1eLandHelper => 'Precompilato: Deutschland.';

  @override
  String get wizardErrInvalidStreet => 'Nome della via non valido';

  @override
  String get wizardErrInvalidHausnummer =>
      'Numero non valido (es. 12, 12a, 12/3)';

  @override
  String get wizardErrInvalidPlz => 'CAP non valido (solo cifre)';

  @override
  String get wizardStufe1fTitle => 'Contatto';

  @override
  String get wizardStufe1fPrompt =>
      'Come ti contattiamo? Il telefono solo per le emergenze — tutto il resto passa dal nostro canale cifrato end-to-end nell\'app. La tua email da socio viene assegnata in automatico e la vedi qui sotto.';

  @override
  String get wizardStufe1fTelefonLabel => 'Cellulare';

  @override
  String get wizardStufe1fTelefonHelper =>
      'Promesso, non chiamo se non è importante. 📱';

  @override
  String get wizardStufe2Title => 'Tipo di socio';

  @override
  String get wizardStufe2Prompt =>
      'Che tipo di socio vuoi essere? Lascia che ti spieghi ogni opzione.';

  @override
  String get wizardStufe2OrdentlichTitle => 'Socio ordinario (ordentlich)';

  @override
  String get wizardStufe2OrdentlichBody =>
      'Pieni diritti. Paghi la quota mensile, voti in assemblea, puoi essere eletto nel Vorstand. La scelta standard.';

  @override
  String get wizardStufe2FoerderTitle => 'Socio sostenitore (Fördermitglied)';

  @override
  String get wizardStufe2FoerderBody =>
      'Sostieni l\'associazione economicamente ma non partecipi attivamente alle decisioni. Senza diritto di voto. Buona scelta se vuoi aiutare da lontano.';

  @override
  String get wizardStufe2EhrenTitle => 'Socio onorario (Ehrenmitglied)';

  @override
  String get wizardStufe2EhrenBody =>
      'Conferito dal Vorstand per meriti speciali. Non lo scegli tu — viene assegnato come riconoscimento. Seleziona solo se sei già stato onorato.';

  @override
  String get wizardStufe3Title => 'Situazione finanziaria';

  @override
  String get wizardStufe3Prompt =>
      'Ora la tua situazione finanziaria. Non per giudicarti — solo per esonerarti dalla quota se ricevi sussidi sociali.';

  @override
  String get wizardStufe3OptionBuergergeld => 'Ricevo Bürgergeld';

  @override
  String get wizardStufe3OptionSozialamt => 'Ricevo aiuti dal Sozialamt';

  @override
  String get wizardStufe3OptionNein => 'Non ricevo nessuna di queste';

  @override
  String get wizardStufe3FeeExemptTitle => 'Quota: 0 € / mese 🎉';

  @override
  String get wizardStufe3FeeExemptBody =>
      'Con Bürgergeld, Sozialamt, ALG I o Krankengeld sei completamente esente dalla quota secondo lo Statuto §6. Ci serve solo un giustificativo (Leistungsbescheid o attestato dell\'ente / cassa malattia).';

  @override
  String get wizardStufe3UploadTitle => 'Carica Leistungsbescheid';

  @override
  String get wizardStufe3UploadHint => 'PDF / JPG / PNG, massimo 10 MB.';

  @override
  String get wizardStufe3UploadRequired =>
      'Per favore carica il Leistungsbescheid prima di continuare.';

  @override
  String get wizardStufe3FileTooLarge => 'File troppo grande. Massimo 10 MB.';

  @override
  String get wizardStufe3UploadFailed =>
      'Impossibile caricare il file. Riprova.';

  @override
  String get wizardStufe3RegularFeeTitle => 'Quota: 25 € / mese';

  @override
  String get wizardStufe3RegularFeeBody =>
      'La quota standard per i soci ordinari secondo il Satzung.';

  @override
  String get wizardStufe4Title => 'Pagamento';

  @override
  String get wizardStufe4Prompt =>
      'Come vuoi pagare la quota? E in che giorno del mese preferisci l\'addebito?';

  @override
  String get wizardStufe4MethodUeberweisungTitle => 'Bonifico (Überweisung)';

  @override
  String get wizardStufe4MethodUeberweisungBody =>
      'Avvii il pagamento manualmente ogni mese dal tuo conto.';

  @override
  String get wizardStufe4MethodSepaTitle =>
      'SEPA-Lastschrift (addebito diretto)';

  @override
  String get wizardStufe4MethodSepaBody =>
      'Preleviamo l\'importo automaticamente dal tuo conto. Più comodo, ma serve IBAN e un mandato firmato.';

  @override
  String get wizardStufe4MethodDauerauftragTitle =>
      'Dauerauftrag (ordine permanente)';

  @override
  String get wizardStufe4MethodDauerauftragBody =>
      'Imposti un ordine permanente nella tua banca. La banca trasferisce l\'importo automaticamente ogni mese.';

  @override
  String get wizardStufe4DayLabel => 'Giorno di pagamento';

  @override
  String get wizardStufe4DayHint => 'Scegli un giorno tra 1 e 31';

  @override
  String wizardStufe4DayItem(int day) {
    return 'Giorno $day';
  }

  @override
  String wizardStufe4DayReminder(int day) {
    return 'La quota verrà addebitata il giorno $day di ogni mese.';
  }

  @override
  String get wizardStufe5Title => 'Inizio';

  @override
  String get wizardStufe5Prompt =>
      'Da quando vuoi essere ufficialmente socio ICD360S? Dall\'approvazione o retroattivamente.';

  @override
  String get wizardStufe5OptionAbVerifizierungTitle =>
      'Dall\'approvazione del Vorstand';

  @override
  String get wizardStufe5OptionAbVerifizierungBody =>
      'La scelta più semplice. Nessuna quota retroattiva.';

  @override
  String get wizardStufe5OptionGruendungsdatumTitle =>
      'Retroattivo dal 01.08.2025 (fondazione)';

  @override
  String get wizardStufe5OptionGruendungsdatumBody =>
      'Conterai come socio sin dal primo giorno dell\'associazione.';

  @override
  String get wizardStufe5OptionAnderesDatumTitle => 'Un\'altra data';

  @override
  String get wizardStufe5OptionAnderesDatumBody =>
      'Scegli tu una data tra il 01.08.2025 e oggi.';

  @override
  String get wizardStufe5PickDate => 'Tocca per scegliere una data';

  @override
  String get wizardStufe5PickDateFirst => 'Per favore scegli prima una data.';

  @override
  String get wizardStufe5DatePickerHelp => 'Inizio dell\'adesione';

  @override
  String wizardStufe5DateRange(String start) {
    return 'Tra il $start e oggi';
  }

  @override
  String get wizardStufe5RetroactiveTitle => 'Quota retroattiva';

  @override
  String wizardStufe5RetroactiveBody(
      String start, String end, int months, String amount) {
    return 'Da $start a $end sono $months mesi. A 25 €/mese fa $amount € da pagare retroattivamente, oltre alla quota mensile corrente.';
  }

  @override
  String get wizardStufe5FeeExemptTitle => 'Quota retroattiva: 0 € 🎉';

  @override
  String get wizardStufe5FeeExemptBody =>
      'Con Bürgergeld o Sozialamt sei totalmente esonerato — anche retroattivamente non devi nulla.';

  @override
  String wizardDocumentPrompt(String doc) {
    return 'Prima di chiudere, leggi attentamente il $doc. È importante sapere cosa firmi.';
  }

  @override
  String get wizardDocumentScrollHint => 'Scorri fino in fondo per continuare.';

  @override
  String get wizardDocumentScrolledOk => 'Hai letto fino in fondo ✓';

  @override
  String wizardDocumentOpenButton(String doc) {
    return 'Apri $doc nel browser';
  }

  @override
  String get wizardDocumentExternalHint =>
      'Su questa piattaforma apriamo il documento nel tuo browser predefinito.';

  @override
  String get wizardDocumentOpenedOk =>
      'Il documento è stato aperto. Leggilo con attenzione.';

  @override
  String wizardDocumentConfirm(String doc) {
    return 'Confermo di aver letto e di accettare il $doc.';
  }

  @override
  String get wizardFinalAdultTitle => 'Fatto! Sei iscritto 🎉';

  @override
  String get wizardFinalMinorTitle => 'La tua richiesta è stata inviata 📨';

  @override
  String get wizardFinalMinorBody =>
      'Contatteremo il tuo genitore e fisseremo un incontro (di persona o videochiamata). Ti chiediamo pazienza — il processo può richiedere fino a 7 giorni. Riceverai una notifica nell\'app appena il genitore avrà approvato.';

  @override
  String get wizardFinalMitgliedernummerLabel => 'Il tuo numero di socio';

  @override
  String get wizardStufe4MethodComingSoon => 'Prossimamente';

  @override
  String get wizardStufe4StreichungWarning =>
      'Se accumuli più di 6 mesi di arretrato sulla quota, ti cancelliamo automaticamente (Satzung §6 Abs. 3).';

  @override
  String get wizardStufe5KuendigungInfo =>
      'Per uscire: inviaci la disdetta per iscritto 3 mesi prima del 31 dicembre (entro il 30 settembre per essere efficace a fine anno). Nessuna durata minima (Satzung §6 Abs. 3).';

  @override
  String get wizardStufe1fEmailLabel => 'La tua email da socio';

  @override
  String get wizardStufe1fEmailHelper =>
      'Assegnata automaticamente in base al tuo numero di socio. Viene attivata nel momento in cui il consiglio direttivo (Vorstand) convalida la tua domanda. Abbiamo la nostra app email dedicata — invia e ricevi email crittografate, semplice e gratis.';

  @override
  String get wizardErrInvalidEmail => 'Indirizzo email non valido';

  @override
  String get wizardStufe3OptionAlg1 =>
      'Ricevo Arbeitslosengeld I (ALG I, indennità di disoccupazione)';

  @override
  String get wizardStufe3OptionKrankengeld =>
      'Ricevo Krankengeld (indennità di malattia di lunga durata)';

  @override
  String get wizardStufe3UploadAddMore => 'Aggiungi un altro documento';

  @override
  String get wizardStufe3UploadLimitCount =>
      'Limite raggiunto: massimo 20 documenti.';

  @override
  String get wizardStufe3UploadLimitTotal =>
      'Limite totale di 100 MB raggiunto. Elimina un file esistente.';

  @override
  String get wizardStufe3UploadDeleteTooltip => 'Elimina';

  @override
  String wizardStufe3UploadCounter(int count, int max) {
    return '$count / $max documenti';
  }

  @override
  String get wizardDocumentExternalOpenFailed =>
      'Impossibile aprire il browser. Il link è negli appunti — incollalo in un browser per continuare.';

  @override
  String get wizardFinalTimelineProcessing =>
      'Vorstand sta verificando · di solito 1 giorno lavorativo, fino a 7';

  @override
  String get wizardFinalTimelineActivated => 'Account attivato';

  @override
  String get wizardFinalAdultThank =>
      'Grazie per aver completato il modulo di registrazione! 🎉';

  @override
  String get wizardFinalAdultUsual =>
      'La tua richiesta è ora da noi. Di solito la convalidiamo entro un giorno lavorativo.';

  @override
  String get wizardFinalAdultExceptional =>
      'A volte può richiedere fino a 7 giorni lavorativi. E se qualcosa non torna, ti rimandiamo al modulo per correggerlo 🙂';

  @override
  String get wizardFinalStatusTitle => 'STATO DELLA RICHIESTA';

  @override
  String wizardFinalStatusStepsValidated(int reviewed, int total) {
    return '$reviewed/$total passaggi convalidati dal Vorstand';
  }

  @override
  String get wizardFinalStufeSheetTitle => 'Dettagli della richiesta';

  @override
  String get wizardFinalStufeSheetHint =>
      'Le 8 fasi che hai completato. Il Vorstand le verifica una per una — vedi in tempo reale cosa è stato validato.';

  @override
  String get wizardFinalStufeStatusPending => 'In attesa di revisione';

  @override
  String get wizardFinalStufeStatusApproved => 'Approvato';

  @override
  String get wizardFinalStufeStatusRejected => 'Respinto';

  @override
  String wizardFinalStatusRejectionCount(int count) {
    return '$count passaggio richiede correzione';
  }

  @override
  String get wizardFinalStufeRejectionReason => 'Motivo del Vorstand:';

  @override
  String get wizardFinalStufeCorrectNow => 'Correggi ora';

  @override
  String wizardFinalApprovalsHeader(int current, int total) {
    return 'Approvazioni del Vorstand ($current/$total)';
  }

  @override
  String get wizardFinalApprovalAwaiting => 'In attesa del 2° Vorstand';

  @override
  String get wizardFinalApprovalRejected => 'RIFIUTATO';

  @override
  String get wizardFinalStufeNoDataYet => 'Dati non ancora disponibili.';

  @override
  String get wizardFinalStufeReadAt => 'Letto il:';

  @override
  String get wizardFinalStufeBeitragsfrei =>
      'Esente da quota (nessun pagamento)';

  @override
  String get wizardFinalStufeNotExempt => 'Senza aiuti sociali';

  @override
  String get wizardFinalStufeBeginAtVerification => 'Inizia con la verifica';

  @override
  String get wizardFinalStufeBeginAtFoundation =>
      'Data di fondazione (retroattivo)';

  @override
  String get wizardFinalStufeBeginAtCustom => 'Altra data';

  @override
  String get wizardFinalStufeStatusSkipped => 'Saltato';

  @override
  String get wizardFinalStufeFilledAt => 'Compilato:';

  @override
  String get wizardFinalStufeReviewedAt => 'Revisionato:';

  @override
  String get wizardFinalWithdrawLink => 'Ritira la richiesta';

  @override
  String get wizardFinalWithdrawDialogTitle => 'Vuoi ritirare la richiesta?';

  @override
  String get wizardFinalWithdrawDialogBody =>
      'La tua richiesta verrà segnata come ritirata da te. I dati restano nel database per audit (GDPR), ma l\'account non verrà attivato. Puoi ricominciare la registrazione quando vuoi con un nuovo numero socio.';

  @override
  String get wizardFinalWithdrawKeep => 'No, aspetto';

  @override
  String get wizardFinalWithdrawConfirm => 'Sì, ritira';

  @override
  String get wizardErrTooManyWithdrawals =>
      'La tua richiesta non può essere elaborata automaticamente. Chiamaci o vieni di persona dal Vorstand per proseguire la registrazione.';

  @override
  String get wizardDuplicateLoginTitle => 'Sembra che tu sia già un socio';

  @override
  String get wizardDuplicateLoginBody =>
      'Con il tuo nome e la tua data di nascita troviamo già un account attivo. Per favore, usa \'Sono già socio\' nella schermata principale per accedere. Se non hai più accesso, chiamaci.';

  @override
  String get wizardDuplicatePendingTitle => 'La tua richiesta è già da noi';

  @override
  String get wizardDuplicatePendingBody =>
      'Con il tuo nome e la tua data di nascita abbiamo già una richiesta in valutazione. Il Vorstand ci sta lavorando — ti avviseremo nell\'app non appena il tuo account sarà attivo. Chiamaci se vuoi parlarne.';

  @override
  String get wizardDuplicateRecentlyWithdrawnTitle =>
      'Non possiamo elaborare questa richiesta adesso';

  @override
  String get wizardDuplicateRecentlyWithdrawnBody =>
      'Il tuo nome e la tua data di nascita corrispondono a una richiesta ritirata di recente. Chiamaci per parlare con il Vorstand prima di continuare.';

  @override
  String get wizardDuplicatePreviouslyWithdrawnTitle =>
      'Hai già fatto richiesta in passato';

  @override
  String get wizardDuplicatePreviouslyWithdrawnBody =>
      'Il tuo nome e la tua data di nascita corrispondono a una richiesta più vecchia che avevi ritirato. Bentornato — chiamaci prima di continuare così il Vorstand decide come procedere.';

  @override
  String get wizardDuplicateCallUsTitle => 'Per favore, chiamaci';

  @override
  String get wizardDuplicateCallUsBody =>
      'Il tuo nome e la tua data di nascita risultano già nei nostri archivi, ma non possiamo condividere i dettagli tramite l\'app. Chiamaci — il Vorstand ti spiegherà la situazione direttamente.';

  @override
  String get wizardChatHelp => 'Parliamone';

  @override
  String get wizardChatHelpSubtitle =>
      'Chat live con il Vorstand · risposta veloce';

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
}
