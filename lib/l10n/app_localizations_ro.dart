// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Romanian Moldavian Moldovan (`ro`).
class AppLocalizationsRo extends AppLocalizations {
  AppLocalizationsRo([String locale = 'ro']) : super(locale);

  @override
  String get welcomeLoading => 'Se încarcă...';

  @override
  String get welcomeAutoLogin => 'Autentificare automată...';

  @override
  String get login => 'Autentificare';

  @override
  String get register => 'Înregistrare';

  @override
  String get becomeMember => 'Devino Membru';

  @override
  String get memberNumber => 'Număr de Membru';

  @override
  String get memberNumberHint => 'Introduceți numărul de membru';

  @override
  String get confirmPassword => 'Confirmați Parola';

  @override
  String get confirmPasswordHint => 'Confirmați parola';

  @override
  String get newPassword => 'Parolă Nouă';

  @override
  String get newPasswordHint => 'Introduceți parola nouă';

  @override
  String get firstName => 'Prenume și Nume';

  @override
  String get firstNameHint => 'Introduceți prenumele și numele';

  @override
  String get nameMinLength => 'Numele trebuie să aibă minim 2 caractere';

  @override
  String get nameOnlyLetters => 'Sunt permise doar litere și cratimă';

  @override
  String get email => 'Adresă de Email';

  @override
  String get emailHint => 'Introduceți email-ul';

  @override
  String get emailInvalid => 'Introduceți un email valid';

  @override
  String get passwordMinLength => 'Parola trebuie să aibă minim 6 caractere';

  @override
  String get passwordsNotMatch => 'Parolele nu coincid';

  @override
  String get registrationFailed => 'Înregistrare eșuată';

  @override
  String connectionError(String error) {
    return 'Eroare de conexiune: $error';
  }

  @override
  String registrationSuccess(String memberNumber) {
    return 'Înregistrare reușită!\n\nNumărul dvs. de membru: $memberNumber\n\nMemorați acest număr pentru autentificare.';
  }

  @override
  String get unknown => 'Necunoscut';

  @override
  String error(String error) {
    return 'Eroare: $error';
  }

  @override
  String get cancel => 'Anulare';

  @override
  String get resetPassword => 'Resetare Parolă';

  @override
  String get imprint => 'Impressum';

  @override
  String get privacy => 'Politica de Confidențialitate';

  @override
  String get statutes => 'Statut';

  @override
  String get revocation => 'Drept de Retragere';

  @override
  String get appointments => 'Programări';

  @override
  String get tickets => 'Tichete';

  @override
  String get liveChat => 'Chat Live';

  @override
  String get notifications => 'Notificări';

  @override
  String get myProfile => 'Profilul Meu';

  @override
  String get logout => 'Deconectare';

  @override
  String get goodMorning => 'Bună dimineața';

  @override
  String get goodDay => 'Bună ziua';

  @override
  String get goodEvening => 'Bună seara';

  @override
  String get goodNight => 'Noapte bună';

  @override
  String get welcomeToICD => 'Bun venit la ICD360S e.V!';

  @override
  String get accountCreatedSuccessfully =>
      'Contul dvs. a fost creat cu succes.';

  @override
  String get today => 'Astăzi';

  @override
  String get membershipFeeDue => 'Taxa de membru este scadentă';

  @override
  String get pleaseTransferAnnualFee =>
      'Vă rugăm să transferați cotizația anuală.';

  @override
  String get newBadge => 'Nou';

  @override
  String get close => 'Închide';

  @override
  String get myAppointments => 'Programările mele';

  @override
  String get priority => 'Prioritate';

  @override
  String get messageLabel => 'Mesaj';

  @override
  String get reportProblems => 'Raportați probleme';

  @override
  String get weRespondIn24Hours => 'Vom răspunde în maxim 24 de ore!';

  @override
  String get everythingOk => 'Totul în regulă!';

  @override
  String get haveProblemWeHelp => 'Aveți o problemă?\nNe ocupăm noi!';

  @override
  String get myMembership => 'Calitatea mea de membru';

  @override
  String get managePersonalDataAndFee =>
      'Gestionați datele personale și cotizația';

  @override
  String get myAppointmentsTitle => 'Programările mele';

  @override
  String get appointmentsDescription =>
      'Aici puteți vedea programările viitoare.\nPuteți confirma participarea sau refuza.';

  @override
  String get loadAppointments => 'Încarcă programări';

  @override
  String get myTickets => 'Ticketele mele';

  @override
  String get low => 'Scăzut';

  @override
  String get high => 'Ridicat';

  @override
  String get submit => 'Trimite';

  @override
  String get errorCreatingTicket => 'Eroare la crearea ticketului';

  @override
  String get verified => 'Verificat';

  @override
  String get account => 'Cont';

  @override
  String get myDevices => 'Dispozitivele mele';

  @override
  String get changeEmail => 'Schimbă email';

  @override
  String get changePassword => 'Schimbă parola';

  @override
  String get saveEmail => 'Salvează email';

  @override
  String get savePassword => 'Salvează parola';

  @override
  String get deviceLoggedOut => 'Dispozitiv deconectat';

  @override
  String get emailChangedSuccessfully => 'Email-ul a fost schimbat cu succes';

  @override
  String get errorChangingPassword => 'Eroare la schimbarea parolei';

  @override
  String get errorChangingEmail => 'Eroare la schimbarea email-ului';

  @override
  String get validEmailRequired =>
      'Vă rugăm să introduceți o adresă email validă';

  @override
  String get confirmLogoutDevice => 'Deconectare dispozitiv?';

  @override
  String get confirmLogoutMessage =>
      'Doriți să vă deconectați de pe acest dispozitiv?\n\nVa trebui să vă conectați din nou pentru a folosi acest dispozitiv.';

  @override
  String get ipAddress => 'IP';

  @override
  String get platform => 'Platformă';

  @override
  String trialWarningUrgentTitle(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'sunt $days zile',
      one: 'este 1 zi',
    );
    return 'Atenție: Mai $_temp0 până la suspendarea contului!';
  }

  @override
  String get trialWarningTitle => 'Contul dvs. nu este încă verificat';

  @override
  String get trialWarningDescription =>
      'Vă rugăm să completați datele în \"Profilul meu\". După 30 de zile, contul va fi suspendat automat.';

  @override
  String trialDaysRemaining(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days zile',
      one: '1 zi',
    );
    return '$_temp0';
  }

  @override
  String get overview => 'Prezentare generală';

  @override
  String get member => 'Membru';

  @override
  String get memberManagement => 'Administrare membri';

  @override
  String get reportProblemTooltip => 'Raportează problemă';

  @override
  String get newAppointmentsTitle => 'Programări noi';

  @override
  String get youHaveNewAppointment => 'Aveți o programare nouă.';

  @override
  String youHaveNewAppointments(int count) {
    return 'Aveți $count programări noi.';
  }

  @override
  String get appointmentReminderTomorrow => 'Memento: Programare mâine';

  @override
  String tomorrowAppointment(String title) {
    return 'Mâine: $title';
  }

  @override
  String youHaveTomorrowAppointments(int count) {
    return 'Aveți mâine $count programări.';
  }

  @override
  String get appointmentsToday => 'Programări astăzi';

  @override
  String todayAppointment(String title) {
    return 'Astăzi: $title';
  }

  @override
  String youHaveTodayAppointments(int count) {
    return 'Aveți astăzi $count programări.';
  }

  @override
  String get paymentReminder => 'Memento plată';

  @override
  String paymentReminderMessage(int day, String method) {
    return 'Astăzi este ziua $day a lunii – vă rugăm efectuați $method.';
  }

  @override
  String get paymentDayLabel => 'Ziua de plată (memento lunar)';

  @override
  String get updateAvailable => 'Actualizare disponibilă';

  @override
  String newVersionAvailable(String version) {
    return 'O nouă versiune este disponibilă: $version';
  }

  @override
  String currentVersionLabel(String version) {
    return 'Versiunea curentă: $version';
  }

  @override
  String get changes => 'Modificări:';

  @override
  String downloadProgress(String percent) {
    return 'Descărcare: $percent%';
  }

  @override
  String get installationStarting => 'Instalarea se inițiază...';

  @override
  String get appWillRestart => 'Aplicația se va reporni automat.';

  @override
  String get autoUpdateEnableTitle =>
      'Instalează automat actualizările viitoare';

  @override
  String get autoUpdateEnableHint =>
      'Aplicația descarcă și instalează actualizările singură și repornește pentru scurt timp. Fără alte întrebări.';

  @override
  String autoUpdateInstalling(String version) {
    return 'Versiunea $version se instalează în fundal. Aplicația va reporni imediat.';
  }

  @override
  String get later => 'Mai târziu';

  @override
  String get updateNow => 'Actualizează acum';

  @override
  String get downloading => 'Se descarcă...';

  @override
  String get downloadFailed =>
      'Descărcarea a eșuat. Vă rugăm încercați mai târziu.';

  @override
  String get searchingForUpdates => 'Se caută actualizări...';

  @override
  String get appUpToDate => 'Aplicația este la zi';

  @override
  String get updateCheckError => 'Eroare la verificarea actualizării';

  @override
  String get changelog => 'Jurnal de modificări';

  @override
  String get terminConfirmed => 'Programare confirmată';

  @override
  String get terminDeclined => 'Programare refuzată';

  @override
  String get terminRescheduleRequested => 'Reprogramare solicitată';

  @override
  String get statusConfirmed => 'Confirmat';

  @override
  String get statusDeclined => 'Refuzat';

  @override
  String get statusRescheduling => 'Reprogramare';

  @override
  String get statusPending => 'În așteptare';

  @override
  String get categoryVorstandssitzung => 'Ședință de conducere';

  @override
  String get categoryMitgliederversammlung => 'Adunare generală';

  @override
  String get categorySchulung => 'Instruire';

  @override
  String get categorySonstiges => 'Altele';

  @override
  String openCount(int count) {
    return '$count deschise';
  }

  @override
  String get refresh => 'Actualizare';

  @override
  String get filterUpcoming => 'Viitoare';

  @override
  String get filterPast => 'Trecute';

  @override
  String get filterAll => 'Toate';

  @override
  String get noUpcomingAppointments => 'Nu sunt programări viitoare';

  @override
  String get noPastAppointments => 'Nu sunt programări trecute';

  @override
  String get noAppointmentsAvailable => 'Nu există programări';

  @override
  String get appointmentsShownHere => 'Programările dvs. vor fi afișate aici';

  @override
  String get dateLabel => 'Data';

  @override
  String get timeLabel => 'Ora';

  @override
  String get locationLabel => 'Locație';

  @override
  String get createdByLabel => 'Creat de';

  @override
  String get descriptionLabel => 'Descriere';

  @override
  String get ticketLabel => 'Tichet';

  @override
  String get yourStatus => 'Statusul dvs.: ';

  @override
  String reasonLabel(String reason) {
    return 'Motiv: $reason';
  }

  @override
  String durationMinutes(int minutes) {
    return '$minutes min';
  }

  @override
  String get confirm => 'Confirmă';

  @override
  String get decline => 'Refuză';

  @override
  String get reschedule => 'Reprogramează';

  @override
  String get requestReschedule => 'Solicită reprogramare';

  @override
  String appointmentLabel(String title) {
    return 'Programare: $title';
  }

  @override
  String get rescheduleReason => 'Motiv pentru reprogramare *';

  @override
  String get rescheduleReasonHint => 'Vă rugăm indicați un motiv...';

  @override
  String get pleaseProvideReason => 'Vă rugăm indicați un motiv';

  @override
  String get request => 'Solicită';

  @override
  String get ticketStatusOpen => 'Deschis';

  @override
  String get ticketStatusInProgress => 'În lucru';

  @override
  String get ticketStatusWaitingMember => 'Se așteaptă membru';

  @override
  String get ticketStatusWaitingStaff => 'Se așteaptă personal';

  @override
  String get ticketStatusWaitingAuthority => 'Se așteaptă autoritate';

  @override
  String get ticketStatusDone => 'Rezolvat';

  @override
  String get ticketPriorityHigh => 'Ridicată';

  @override
  String get ticketPriorityMedium => 'Medie';

  @override
  String get ticketPriorityLow => 'Scăzută';

  @override
  String get comments => 'Comentarii';

  @override
  String get documents => 'Documente';

  @override
  String get details => 'Detalii';

  @override
  String get replySent => 'Răspuns trimis';

  @override
  String get sendError => 'Eroare la trimitere';

  @override
  String get uploading => 'Se încarcă...';

  @override
  String fileUploaded(String filename) {
    return '$filename încărcat';
  }

  @override
  String get uploadFailed => 'Încărcare eșuată';

  @override
  String get openError => 'Eroare la deschidere';

  @override
  String get noRepliesYet => 'Încă nu sunt răspunsuri';

  @override
  String get waitingForSupport => 'Se așteaptă răspuns de la suport';

  @override
  String get writeReply => 'Scrieți un răspuns...';

  @override
  String get attachFile => 'Atașați fișier';

  @override
  String documentsCount(int count) {
    return 'Documente ($count)';
  }

  @override
  String get upload => 'Încarcă';

  @override
  String get noDocuments => 'Nu există documente';

  @override
  String get allowedFormats => 'Formate permise: PDF, JPEG, JPG, TXT, ZIP';

  @override
  String get yourMessage => 'Mesajul dvs.:';

  @override
  String get translation => 'Traducere';

  @override
  String get original => 'Original';

  @override
  String get originalText => 'Text original';

  @override
  String get autoTranslated => 'Tradus automat';

  @override
  String get originalTapTranslation =>
      'Text original · Atingeți pentru traducere';

  @override
  String get translatedTapOriginal => 'Tradus · Atingeți pentru original';

  @override
  String get justNow => 'Chiar acum';

  @override
  String minutesAgo(int minutes) {
    return 'acum $minutes min';
  }

  @override
  String hoursAgo(int hours) {
    return 'acum $hours ore';
  }

  @override
  String daysAgo(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'zile',
      one: 'zi',
    );
    return 'acum $days $_temp0';
  }

  @override
  String get createdLabel => 'Creat';

  @override
  String get updatedLabel => 'Actualizat';

  @override
  String get handlerLabel => 'Responsabil';

  @override
  String get doneLabel => 'Rezolvat';

  @override
  String get newTicketTitle => 'Tichet nou';

  @override
  String get categoryOptional => 'Categorie (opțional)';

  @override
  String get selectCategory => 'Alegeți';

  @override
  String get subjectLabel => 'Subiect';

  @override
  String get fillAllFields => 'Vă rugăm completați toate câmpurile';

  @override
  String ticketCreatedId(int id) {
    return 'Tichet #$id creat';
  }

  @override
  String get priorityLabel => 'Prioritate: ';

  @override
  String get supportOffline => 'Suport offline';

  @override
  String get lastSeenSeconds => 'Activ acum câteva secunde';

  @override
  String lastSeenMinutes(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: 'minute',
      one: 'minut',
    );
    return 'Activ acum $minutes $_temp0';
  }

  @override
  String lastSeenHours(int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: 'ore',
      one: 'oră',
    );
    return 'Activ acum $hours $_temp0';
  }

  @override
  String lastSeenDays(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'zile',
      one: 'zi',
    );
    return 'Activ acum $days $_temp0';
  }

  @override
  String get online => 'Online';

  @override
  String get callSupport => 'Apelează';

  @override
  String get typeMessage => 'Scrieți un mesaj...';

  @override
  String get callBusy => 'Suportul este ocupat';

  @override
  String get callRejected => 'Apelul a fost respins';

  @override
  String get callFailed => 'Apelul nu s-a putut conecta';

  @override
  String get callEnded => 'Apel încheiat';

  @override
  String get callSupportBusy => 'Suportul este deja într-un alt apel';

  @override
  String get errorStartingChat => 'Eroare la pornirea chat-ului';

  @override
  String get errorStartingCall => 'Eroare la pornirea apelului';

  @override
  String get errorConnecting => 'Eroare de conectare';

  @override
  String get errorDownloading => 'Eroare la descărcare';

  @override
  String get errorUploading => 'Eroare la încărcare';

  @override
  String get errorSending => 'Eroare la trimitere';

  @override
  String get errorPickingPhotos => 'Eroare la selectarea pozelor';

  @override
  String get errorPickingFiles => 'Eroare la selectarea fișierelor';

  @override
  String get errorTakingPhoto => 'Eroare la fotografiere';

  @override
  String get fileNotLoaded => 'Fișierul nu a putut fi încărcat';

  @override
  String get attachmentIdMissing => 'ID atașament lipsă';

  @override
  String get camera => 'Cameră';

  @override
  String get gallery => 'Galerie';

  @override
  String get file => 'Fișier';

  @override
  String get notifNewMessageFrom => 'Mesaj nou de la';

  @override
  String get notifUrgentPrefix => 'URGENT';

  @override
  String get notifUrgentMessage => 'MESAJ URGENT';

  @override
  String get notifIncomingCall => 'Apel primit';

  @override
  String get notifCallingYou => 'vă sună...';

  @override
  String get notifUpdateAvailable => 'Actualizare disponibilă';

  @override
  String get notifVersionAvailable => 'este acum disponibilă';

  @override
  String get notifConnected => 'Conectat';

  @override
  String get notifDisconnected => 'Deconectat';

  @override
  String get notifConnectedBody => 'Sunteți conectat la server.';

  @override
  String get notifDisconnectedBody => 'Conexiunea la server a fost întreruptă.';

  @override
  String get notifError => 'Eroare';

  @override
  String get retry => 'Încearcă din nou';

  @override
  String get save => 'Salvează';

  @override
  String get accept => 'Acceptă';

  @override
  String get selectFile => 'Selectează fișier';

  @override
  String get dataLoadingText => 'Se încarcă datele...';

  @override
  String get dataSavedSuccess => 'Datele au fost salvate cu succes';

  @override
  String get errorSaving => 'Eroare la salvare';

  @override
  String get errorLoading => 'Eroare la încărcare';

  @override
  String savedFilename(String filename) {
    return 'Salvat: $filename';
  }

  @override
  String get logsCopied => 'Loguri copiate!';

  @override
  String get passwordMinEightChars =>
      'Parola trebuie să aibă cel puțin 8 caractere';

  @override
  String get passwordChangeSuccess => 'Parola a fost schimbată cu succes';

  @override
  String get emailChangeError => 'Eroare la schimbarea emailului';

  @override
  String get acceptDocumentCheckbox => 'Am citit și accept documentul.';

  @override
  String loadingErrorGeneric(String details) {
    return 'Eroare la încărcare: $details';
  }

  @override
  String get incomingCallTitle => 'Apel primit';

  @override
  String ringingFor(int seconds) {
    return 'Sună de ${seconds}s';
  }

  @override
  String get rejectCall => 'Respinge';

  @override
  String get acceptCall => 'Acceptă';

  @override
  String get unmute => 'Activează sunetul';

  @override
  String get mute => 'Dezactivează sunetul';

  @override
  String get hangUp => 'Închide';

  @override
  String get calling => 'Se apelează...';

  @override
  String autoRejectIn(int seconds) {
    return 'Respingere automată în $seconds secunde';
  }

  @override
  String get speakerOn => 'Difuzor';

  @override
  String get speakerOff => 'Cască';

  @override
  String get micMuted => 'Mut';

  @override
  String get micOn => 'Microfon';

  @override
  String get connectionExcellent => 'Excelentă';

  @override
  String get connectionGood => 'Bună';

  @override
  String get connectionWeak => 'Slabă';

  @override
  String get connectionLost => 'Deconectat';

  @override
  String get personalData => 'Date personale';

  @override
  String get personalDataSubtitle => 'Nume, prenume, adresă';

  @override
  String get membershipFee => 'Cotizație';

  @override
  String annualFeeYear(String year) {
    return 'Cotizație anuală $year';
  }

  @override
  String get amount => 'Sumă:';

  @override
  String get dueBy => 'Scadent până la:';

  @override
  String get paid => 'Plătit';

  @override
  String get versionHistory => 'Istoricul versiunilor';

  @override
  String lastUpdated(String date) {
    return 'Ultima actualizare: $date';
  }

  @override
  String get noVersionHistory => 'Nu există istoric de versiuni';

  @override
  String get failedLoadChangelog => 'Nu s-a putut încărca istoricul';

  @override
  String get callMember => 'Apelează membrul';

  @override
  String get closeConversation => 'Închide conversația';

  @override
  String get chatOffline => 'Offline';

  @override
  String get attachFiles => 'Atașează fișiere (max. 10, 50MB)';

  @override
  String get conversationClosed => 'Această conversație a fost închisă';

  @override
  String get noMessages => 'Fără mesaje';

  @override
  String get goBack => 'Înapoi';

  @override
  String get goForward => 'Înainte';

  @override
  String get homePage => 'Pagina principală';

  @override
  String get firstNameLabel => 'Prenume';

  @override
  String get lastNameLabel => 'Nume';

  @override
  String get streetLabel => 'Strada';

  @override
  String get houseNumberLabel => 'Nr.';

  @override
  String get postalCodeLabel => 'Cod poștal';

  @override
  String get cityLabel => 'Localitate';

  @override
  String get phoneMobileLabel => 'Telefon (Mobil)';

  @override
  String get phoneLandlineLabel => 'Telefon (Fix)';

  @override
  String get newEmailLabel => 'Adresă email nouă';

  @override
  String get currentPasswordLabel => 'Parola curentă';

  @override
  String get newPasswordLabel => 'Parola nouă';

  @override
  String get confirmPasswordLabel => 'Confirmă parola';

  @override
  String get emailChangedSuccess => 'Email schimbat cu succes';

  @override
  String get reasonLabel2 => 'Motiv';

  @override
  String get downloadFailed2 => 'Descărcare eșuată';

  @override
  String get downloadTooltip => 'Descarcă';

  @override
  String get copyLogs => 'Copiază loguri';

  @override
  String get deleteLogs => 'Șterge loguri';

  @override
  String get autoScrollOn => 'Derulare automată ACTIVATĂ';

  @override
  String get autoScrollOff => 'Derulare automată DEZACTIVATĂ';

  @override
  String get unknownValue => 'Necunoscut';

  @override
  String get payment => 'Plată';

  @override
  String get warningType_ermahnung => 'Avertisment';

  @override
  String get warningType_abmahnung => 'Somație';

  @override
  String get warningType_letzte => 'Ultima somație';

  @override
  String warningsTotal(int count) {
    return 'Total: $count';
  }

  @override
  String warningsErmahnung(int count) {
    return 'Avertismente: $count';
  }

  @override
  String warningsAbmahnung(int count) {
    return 'Somații: $count';
  }

  @override
  String warningsLetzte(int count) {
    return 'Ultimele: $count';
  }

  @override
  String get noWarnings => 'Nu există avertismente';

  @override
  String get noWarningsDescription => 'Nu aveți avertismente în acest moment.';

  @override
  String createdBy(String name) {
    return 'Creat de: $name';
  }

  @override
  String get monthJan => 'Ian';

  @override
  String get monthFeb => 'Feb';

  @override
  String get monthMar => 'Mar';

  @override
  String get monthApr => 'Apr';

  @override
  String get monthMay => 'Mai';

  @override
  String get monthJun => 'Iun';

  @override
  String get monthJul => 'Iul';

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
  String get stufe1_name => 'Date personale';

  @override
  String get stufe2_name => 'Tip de membru';

  @override
  String get stufe3_name => 'Situație financiară';

  @override
  String get stufe4_name => 'Metoda de plată';

  @override
  String get stufe5_name => 'Începutul membriei';

  @override
  String get stufe6_name => 'Statut';

  @override
  String get stufe7_name => 'Politica de confidențialitate';

  @override
  String get stufe8_name => 'Dreptul de retragere';

  @override
  String get memberType_ordentlich => 'Membru ordinar';

  @override
  String get memberType_foerder => 'Membru susținător';

  @override
  String get memberType_ehren => 'Membru de onoare';

  @override
  String get memberDesc_ordentlich =>
      'Membru activ cu drept de vot. Participă la serviciile asociației.';

  @override
  String get memberDesc_foerder =>
      'Susține asociația prin contribuții. Poate participa la adunarea generală cu vot consultativ.';

  @override
  String get memberDesc_ehren =>
      'Are drepturile unui membru ordinar fără obligația de a plăti cotizații.';

  @override
  String get payMethod_ueberweisung => 'Transfer bancar';

  @override
  String get payMethod_dauerauftrag => 'Ordin permanent';

  @override
  String get verifyStatus_geprueft => 'Verificat';

  @override
  String get verifyStatus_ausgefuellt => 'Completat';

  @override
  String get verifyStatus_abgelehnt => 'Respins';

  @override
  String get verifyStatus_offen => 'Deschis';

  @override
  String get fillRequiredFields =>
      'Vă rugăm completați toate câmpurile obligatorii.';

  @override
  String get personalDataSaved => 'Date personale salvate';

  @override
  String get selectMemberType => 'Selectați un tip de membru.';

  @override
  String get memberTypeSaved => 'Tip de membru salvat';

  @override
  String get selectOption => 'Selectați o opțiune.';

  @override
  String get financialSaved => 'Situație financiară salvată';

  @override
  String get selectPaymentMethod => 'Selectați o metodă de plată.';

  @override
  String get paymentDataSaved => 'Date de plată salvate';

  @override
  String get selectDate => 'Selectați o dată.';

  @override
  String get membershipStartSaved => 'Începutul membriei salvat';

  @override
  String get fileTooLarge => 'Fișier prea mare (max. 10 MB).';

  @override
  String get leistungsbescheidUploaded => 'Certificat încărcat cu succes';

  @override
  String get verificationProgress => 'Progres verificare';

  @override
  String get notApplicable => 'Nu se aplică';

  @override
  String get socialBenefitsExempt =>
      'Metoda de plată nu este necesară pentru beneficiarii de ajutor social.';

  @override
  String get locked => 'Blocat';

  @override
  String completePreviousStep(int step) {
    return 'Completați mai întâi pasul $step.';
  }

  @override
  String rejectedNote(String note) {
    return 'Respins: $note';
  }

  @override
  String get waitingForReview => 'Se așteaptă verificarea conducerii.';

  @override
  String get stepApproved => 'Acest pas a fost verificat și aprobat.';

  @override
  String get changesViaChat => 'Modificări posibile doar prin Live Chat.';

  @override
  String get firstNameRequired => 'Prenume *';

  @override
  String get lastNameRequired => 'Nume *';

  @override
  String get birthDateLabel => 'Data nașterii *';

  @override
  String get streetRequired => 'Strada *';

  @override
  String get houseNumberRequired => 'Nr. *';

  @override
  String get cityRequired => 'Localitate *';

  @override
  String get phoneRequired => 'Număr de telefon *';

  @override
  String get phonePurpose =>
      'Scop: Contact când nu sunteți accesibil prin aplicație';

  @override
  String get selectMemberTypePrompt => 'Selectați tipul de membru dorit:';

  @override
  String get financialExplanation =>
      'Pentru a verifica dacă aveți dreptul la o reducere a cotizației, avem nevoie de următoarele informații.';

  @override
  String get socialBenefitsQuestion => 'Primiți în prezent ajutor social?';

  @override
  String get optionBuergergeld => 'Da, ajutor social (Centrul de Muncă)';

  @override
  String get optionSozialamt => 'Da, prestații sociale (Asistență Socială)';

  @override
  String get optionNoBenefits => 'Nu, nu primesc ajutor social';

  @override
  String get feeExempt => 'Cotizația lunară: 0,00 €/lună';

  @override
  String get uploadLeistungsbescheid => 'Încarcă certificat';

  @override
  String get uploadLeistungsbescheidHint =>
      'Încărcați un certificat actual în 14 zile pentru a confirma scutirea.';

  @override
  String get allowedFormatsUpload =>
      'Formate permise: PDF, JPG, PNG (max. 10 MB)';

  @override
  String get feeRegular => 'Cotizația lunară: 25,00 €/lună';

  @override
  String paymentDayReminder(int day) {
    return 'Veți fi notificat în fiecare $day a lunii.';
  }

  @override
  String get membershipStartPrompt =>
      'Alegeți când să înceapă calitatea de membru.';

  @override
  String get optionAfterVerification => 'După finalizarea verificării';

  @override
  String get optionAfterVerificationDesc =>
      'Calitatea de membru începe de la confirmarea conducerii.';

  @override
  String get optionRetroFoundation =>
      'Retroactiv la data înființării (01.08.2025)';

  @override
  String get optionRetroFoundationDesc =>
      'Deveniți membru retroactiv de la înființarea asociației.';

  @override
  String get optionRetroCustom => 'Retroactiv la altă dată';

  @override
  String get optionRetroCustomDesc =>
      'Alegeți o dată între 01.08.2025 și astăzi.';

  @override
  String get selectDateLabel => 'Selectați data';

  @override
  String get selectDateHint => 'Selectați data...';

  @override
  String get dateNotBefore => 'Nu înainte de 01.08.2025 (data înființării)';

  @override
  String get feeExemptRetro =>
      'Scutit: 0,00 € retroactiv.\nDoar data membriei este setată retroactiv.';

  @override
  String get retroactiveFees => 'Cotizații retroactive';

  @override
  String retroFeeCalculation(
      String from, String to, String months, String total) {
    return 'Perioadă: $from – $to\nLuni: $months\nCotizație: $months × 25,00 € = $total €';
  }

  @override
  String get pleaseReadSatzung => 'Vă rugăm citiți statutul asociației.';

  @override
  String get pleaseReadDatenschutz =>
      'Vă rugăm citiți politica de confidențialitate.';

  @override
  String get pleaseReadWiderruf => 'Vă rugăm citiți dreptul de retragere.';

  @override
  String get acceptedAtRegistration => 'Acceptat la înregistrare';

  @override
  String get confirmedByBoard => 'Va fi confirmat după verificarea conducerii.';

  @override
  String get docSatzung => 'Statut';

  @override
  String get docDatenschutz => 'Politica de confidențialitate';

  @override
  String get docWiderruf => 'Dreptul de retragere';

  @override
  String acceptedAtRegCount(int count) {
    return 'Acceptat la înregistrare ($count/3)';
  }

  @override
  String acceptedOn(String date) {
    return 'Acceptat pe $date';
  }

  @override
  String get notAccepted => 'Neacceptat';

  @override
  String get statusAccepted => 'Acceptat';

  @override
  String get nameTooLong => 'Numele prea lung (max 100 caractere)';

  @override
  String get emailTooLong => 'E-mail prea lung (max 255 caractere)';

  @override
  String get legalAcknowledgePrefix => 'Am luat cunoștință de ';

  @override
  String get legalAcknowledgeSuffix => '.';

  @override
  String get legalStatutesSuffix =>
      ' a ICD360S e.V. și le recunosc ca obligatorii.';

  @override
  String get legalPleaseReadFirst => '(vă rugăm citiți mai întâi)';

  @override
  String get statusActive => 'Activ';

  @override
  String get statusSuspended => 'Suspendat';

  @override
  String get statusNew => 'Nou';

  @override
  String get statusCancelled => 'Anulat';

  @override
  String get statusDeleted => 'Șters';

  @override
  String get roleMitglied => 'Membru';

  @override
  String get roleVorsitzer => 'Președinte';

  @override
  String get roleStellvertreter => 'Vicepreședinte';

  @override
  String get roleSchatzmeister => 'Trezorier';

  @override
  String get roleSchriftfuehrer => 'Secretar';

  @override
  String get roleBeisitzer => 'Asesor';

  @override
  String get roleKassierer => 'Casier';

  @override
  String get roleKassenpruefer => 'Auditor';

  @override
  String get roleEhrenamtlich => 'Voluntar';

  @override
  String get roleMitgliedergruender => 'Membru Fondator';

  @override
  String get roleEhrenmitglied => 'Membru de Onoare';

  @override
  String get roleFoerdermitglied => 'Membru Susținător';

  @override
  String get memberTypeNotSet => 'Nu a fost încă stabilit';

  @override
  String get payMethodSepa => 'Debit direct SEPA';

  @override
  String get labelStatus => 'Stare';

  @override
  String get labelMemberNumber => 'Număr de membru';

  @override
  String get labelRole => 'Rol';

  @override
  String get labelMemberType => 'Tip de membru';

  @override
  String get labelPaymentMethod => 'Metodă de plată';

  @override
  String get labelRegisteredOn => 'Înregistrat la';

  @override
  String get labelLastLogin => 'Ultima autentificare';

  @override
  String get labelMemberSince => 'Membru din';

  @override
  String get neverLoggedIn => 'Niciodată';

  @override
  String get notActivatedYet => 'Nu a fost încă activat';

  @override
  String get tabVerification => 'Verificare';

  @override
  String get tabWarnings => 'Avertismente';

  @override
  String get tabDocuments => 'Documente';

  @override
  String get tabMembership => 'Membru';

  @override
  String get pleaseEnterFirstName => 'Introduceți prenumele';

  @override
  String get pleaseEnterLastName => 'Introduceți numele de familie';

  @override
  String get noFileDataReceived => 'Nu s-au primit date';

  @override
  String get openFile => 'Deschide';

  @override
  String get noMicrophoneError =>
      'Nu s-a găsit niciun microfon. Conectați un microfon și încercați din nou.';

  @override
  String get startConversation => 'Începeți o conversație!';

  @override
  String get staffWillReply => 'Un angajat vă va răspunde în curând.';

  @override
  String get inCall => 'În apel...';

  @override
  String get registration => 'Înregistrare';

  @override
  String get deactivation => 'Dezactivare';

  @override
  String get deactivatedOn => 'Dezactivat la';

  @override
  String get accountAutoSuspend =>
      'Conturile care nu sunt verificate în 30 de zile vor fi suspendate automat.';

  @override
  String get documentsProvidedByBoard =>
      'Documentele sunt furnizate de consiliu.';

  @override
  String get noDocumentsAvailable => 'Nu există documente';

  @override
  String get noDocumentsDescription =>
      'Nu au fost încă furnizate documente pentru dvs.';

  @override
  String uploadedBy(String name) {
    return 'Încărcat de: $name';
  }

  @override
  String stepsCompleted(int completed, int total) {
    return '$completed/$total etape completate';
  }

  @override
  String dayOfMonth(int day) {
    return '$day a lunii';
  }

  @override
  String changeField(String field) {
    return 'Schimbă $field';
  }

  @override
  String openDocument(String name) {
    return 'Deschide $name';
  }

  @override
  String logEntries(int count) {
    return '$count înregistrări';
  }

  @override
  String get noLogs => 'Fără jurnale';

  @override
  String get newLoginDetected => 'Autentificare nouă detectată';

  @override
  String get errorNoInternet =>
      'Nu există conexiune la internet. Verificați rețeaua.';

  @override
  String get errorTimeout =>
      'Serverul nu răspunde. Încercați din nou mai târziu.';

  @override
  String get errorServer => 'Eroare de server. Încercați din nou mai târziu.';

  @override
  String get errorConnection =>
      'Eroare de conexiune. Încercați din nou mai târziu.';

  @override
  String get errorUnexpected =>
      'A apărut o eroare neașteptată. Încercați din nou mai târziu.';

  @override
  String get securityBannerTlsInterception =>
      'Reteaua ta intercepteaza conexiunile securizate. Schimba reteaua sau dezactiveaza VPN-ul/antivirusul.';

  @override
  String get securityBannerDnsFailure =>
      'Problema DNS detectata. Verifica conexiunea sau incearca alta retea.';

  @override
  String get securityBannerSlowNetwork => 'Conexiune lenta.';

  @override
  String get securityPermissionDialogTitle => 'Posibil atac de retea detectat';

  @override
  String get securityPermissionDialogBody =>
      'Ceva din reteaua ta ar putea intercepta conexiunile. Pentru a identifica reteaua si a te proteja, avem nevoie de permisiunea de a citi numele WiFi. Fara urmarirea locatiei.';

  @override
  String get securityPermissionDialogAllow => 'Permite';

  @override
  String get securityPermissionDialogDeny => 'Nu acum';

  @override
  String get callErrorMicPermissionDenied =>
      'Accesul la microfon este blocat. Activeaza-l in Windows Settings → Privacy → Microphone (sau setarile de confidentialitate ale sistemului tau) si incearca din nou.';

  @override
  String get callErrorMicNotFound =>
      'Nu a fost gasit niciun microfon. Conecteaza casti sau un microfon si incearca din nou.';

  @override
  String get claudiuWelcomeMorning => 'Bună dimineața';

  @override
  String get claudiuWelcomeDay => 'Bună ziua';

  @override
  String get claudiuWelcomeEvening => 'Bună seara';

  @override
  String get claudiuWelcomeNight => 'Bună seara';

  @override
  String get claudiuWelcomeVisitor => 'drag vizitator';

  @override
  String get claudiuWelcomeAsk => 'Cu ce te pot ajuta?';

  @override
  String get claudiuWelcomeBecomeMember => 'Vreau să devin membru';

  @override
  String get claudiuWelcomeLogin =>
      'Sunt deja membru și vreau să mă autentific';

  @override
  String get claudiuWelcomeProblem => 'Am o problemă cu aplicația';

  @override
  String get claudiuWelcomeEmergency => 'Urgență — sună-ne';

  @override
  String get claudiuWelcomeMascotName => 'Claudiu';

  @override
  String get claudiuWelcomeEmergencyIntro =>
      'Înainte să suni — programul nostru de lucru:';

  @override
  String get claudiuWelcomeScheduleOffice => 'La birou';

  @override
  String get claudiuWelcomeScheduleField => 'Pe teren cu clienții';

  @override
  String get claudiuWelcomeOutsideHoursNote =>
      'În afara acestui program preluăm doar urgențele. Poți să ne și scrii la același număr — te contactăm noi.';

  @override
  String get claudiuWelcomeCallNow => 'Sună-ne acum';

  @override
  String get claudiuWelcomeSendSms => 'Trimite SMS';

  @override
  String get claudiuWelcomeSmsBody =>
      'Urgență ICD360S e.V. — vă rog să mă contactați cât mai curând.';

  @override
  String get claudiuWelcomeCloseButton => 'Închide';

  @override
  String get claudiuLoginWelcome => 'Bine ai revenit, drag membru!';

  @override
  String get claudiuLoginAsk => 'Spune-mi numărul tău de membru.';

  @override
  String get claudiuLoginProgress => 'Mai aproape… continuă să tastezi.';

  @override
  String get claudiuLoginReady => 'Perfect! Apasă butonul de mai jos.';

  @override
  String get claudiuLoginLoading => 'Verific identitatea… 🔍';

  @override
  String get claudiuLoginFoundPlain => 'Te-am găsit! Te conectez acum…';

  @override
  String claudiuLoginFoundNamed(String name) {
    return 'Te-am găsit, $name! Te conectez acum…';
  }

  @override
  String get claudiuLoginError =>
      'Hm, nu găsesc numărul ăsta. Verifici dacă ai scris bine?';

  @override
  String get claudiuLoginForgotHeader => 'Ai uitat numărul de membru?';

  @override
  String get claudiuLoginNoSms => 'Nu trimitem numărul prin email sau SMS.';

  @override
  String get claudiuLoginOnlyWay =>
      'Singura cale: să ne întâlnim personal la sediul asociației, după verificare CI.';

  @override
  String get claudiuLoginContactUs => 'Contactează-ne pentru programare:';

  @override
  String get claudiuDiagnosticGreeting => 'Înainte să intri, am o întrebare';

  @override
  String get claudiuDiagnosticAsk =>
      'Pot trimite raportări anonime ca să-i ajutăm pe dezvoltatori să facă aplicația mai bună?';

  @override
  String get claudiuDiagnosticYes => 'Da, vreau să ajut';

  @override
  String get claudiuDiagnosticNo => 'Nu, doar exploram';

  @override
  String get claudiuDiagnosticTellMore => 'Spune-mi mai mult';

  @override
  String get claudiuDiagnosticSendsHeader => '📤 Ce TRIMITEM (anonim):';

  @override
  String get claudiuDiagnosticSends1 =>
      'Un cod anonim al dispozitivului (nu mitgliedernummer-ul)';

  @override
  String get claudiuDiagnosticSends2 => 'Rolul tău (membru / vorstand)';

  @override
  String get claudiuDiagnosticSends3 =>
      'Sistemul (Linux / Android / iOS / Windows)';

  @override
  String get claudiuDiagnosticSends4 => 'Limba aleasă';

  @override
  String get claudiuDiagnosticSends5 => 'Nivelul + starea bateriei';

  @override
  String get claudiuDiagnosticSends6 => 'Pe ce ecran ești';

  @override
  String get claudiuDiagnosticSends7 => 'Durata sesiunii (secunde)';

  @override
  String get claudiuDiagnosticSends8 => 'Erori dacă apar (ultimele 10)';

  @override
  String get claudiuDiagnosticSends9 => 'Navigare (ultimele 20 ecrane)';

  @override
  String get claudiuDiagnosticNeverHeader => '🛡️ Ce NU trimitem NICIODATĂ:';

  @override
  String get claudiuDiagnosticNever1 => 'Numele tău real';

  @override
  String get claudiuDiagnosticNever2 => 'Adresa de email';

  @override
  String get claudiuDiagnosticNever3 => 'Numărul de telefon';

  @override
  String get claudiuDiagnosticNever4 => 'Parola';

  @override
  String get claudiuDiagnosticNever5 => 'Conținutul mesajelor din chat';

  @override
  String get claudiuDiagnosticNever6 => 'Conținutul ticket-urilor';

  @override
  String get claudiuDiagnosticNever7 => 'Documente sau atașamente';

  @override
  String get claudiuDiagnosticTechHeader => '📡 Detalii tehnice:';

  @override
  String get claudiuDiagnosticTech1 => 'Trimite la fiecare 2 minute';

  @override
  String get claudiuDiagnosticTech2 =>
      'Conexiune TLS criptată cu certificat fix (pinned)';

  @override
  String get claudiuDiagnosticTech3 => 'Poți opri oricând din Setări';

  @override
  String get claudiuProblemHelpTitle => 'Cum te pot ajuta?';

  @override
  String get claudiuProblemHelpGreeting => 'Ce s-a întâmplat?';

  @override
  String get claudiuProblemHelpAsk => 'Cum vrei să-mi povestești?';

  @override
  String get claudiuProblemHelpWriteTitle => 'Scriu un raport';

  @override
  String get claudiuProblemHelpWriteBody =>
      'Cu detalii pas cu pas. Echipa primește textul și îl rezolvă mai târziu.';

  @override
  String get claudiuProblemHelpChatTitle => 'Vorbim acum';

  @override
  String get claudiuProblemHelpChatBody =>
      'Chat anonim cu un operator. Răspuns în timp real, dacă e cineva online.';

  @override
  String get claudiuProblemHelpAltCallHeader => 'Sau, dacă e ceva urgent:';

  @override
  String get claudiuProblemHelpAltCallLabel => 'Sună-ne';

  @override
  String get claudiuAnonymousChatTitle => 'Chat anonim';

  @override
  String get claudiuAnonymousChatGreeting => 'Salut!';

  @override
  String get claudiuAnonymousChatWelcome =>
      'Te ascult. Scrie-mi orice — nu am nevoie de numele tău. Răspund de îndată ce sunt aici.';

  @override
  String get claudiuAnonymousChatHint => 'Scrie un mesaj…';

  @override
  String get claudiuAnonymousChatWaitingOperator =>
      'Așteptăm ca un operator să răspundă…';

  @override
  String get claudiuVorsitzerConnectedTitle => 'Bună!';

  @override
  String get claudiuVorsitzerConnectedBody =>
      'Mulțumim că ai ajuns aici — ești conectat acum cu un vorsitzer. Scrie-ne cu ce te putem ajuta în ceea ce privește cererea ta de aderare în asociația noastră non-profit.';

  @override
  String get claudiuVorsitzerConnectedSender => 'Vorsitzer';

  @override
  String get claudiuQuickReplyValidationTime => 'Cât timp durează validarea?';

  @override
  String get claudiuQuickReplyDocuments => 'Ce documente am nevoie?';

  @override
  String get claudiuQuickReplyStepProblem => 'Am o problemă cu un pas';

  @override
  String get claudiuQuickReplyHuman => 'Vreau să vorbesc cu cineva acum';

  @override
  String get claudiuAnonymousChatConnecting => 'Mă conectez…';

  @override
  String get claudiuAnonymousChatConnectionFailed =>
      'Nu am putut deschide chat-ul. Încearcă din nou sau sună-ne.';

  @override
  String get claudiuAnonymousChatRetry => 'Încearcă din nou';

  @override
  String get claudiuAnonymousChatOnline => 'Conectat';

  @override
  String get claudiuAnonymousChatOffline => 'Reconectare…';

  @override
  String get claudiuAnonymousChatAdminTyping => 'Operatorul scrie…';

  @override
  String get claudiuProblemReportTitle => 'Raportează o problemă';

  @override
  String get claudiuProblemReportGreeting => 'Ce s-a întâmplat?';

  @override
  String get claudiuProblemReportAsk =>
      'Spune-mi în detaliu și trimit raportul la echipă.';

  @override
  String get claudiuProblemReportIncludeHeader => 'Include în descrierea ta:';

  @override
  String get claudiuProblemReportIncludeBullets1 =>
      'Ce făceai când a apărut problema';

  @override
  String get claudiuProblemReportIncludeBullets2 =>
      'Ce mesaj de eroare ai văzut';

  @override
  String get claudiuProblemReportIncludeBullets3 => 'Pe ce ecran erai';

  @override
  String get claudiuProblemReportIncludeBullets4 =>
      'Aplicația crapă? Se închide? Apare ecran alb?';

  @override
  String get claudiuProblemReportIncludeBullets5 =>
      'Se repetă mereu sau o singură dată';

  @override
  String get claudiuProblemReportDescriptionLabel => 'Descrierea ta';

  @override
  String get claudiuProblemReportDescriptionHint =>
      'Ex: Când deschid ecranul de chat, apare un mesaj „Connection error\" și aplicația nu mai răspunde…';

  @override
  String claudiuProblemReportTooShort(int count) {
    return 'Mai detaliază, te rog (minim $count caractere)';
  }

  @override
  String get claudiuProblemReportSubmit => 'Trimite raportul';

  @override
  String get claudiuProblemReportSubmitting => 'Trimit...';

  @override
  String get claudiuProblemReportSentTitle => 'Mulțumesc!';

  @override
  String get claudiuProblemReportSentBody =>
      'Raportul a fost trimis. Echipa noastră îl va analiza cât mai curând.';

  @override
  String get claudiuProblemReportSentClose => 'Înțeles';

  @override
  String get claudiuProblemReportSendFailed =>
      'Nu am putut trimite raportul. Sună-ne pentru asistență urgentă.';

  @override
  String get claudiuProblemReportAlt => 'Sau, dacă e ceva urgent:';

  @override
  String get claudiuProblemReportCallLabel => 'Sună-ne';

  @override
  String claudiuApprovalGreeting(String name) {
    return 'Bună, $name! 👋';
  }

  @override
  String get claudiuApprovalGreetingNoName => 'Bună! 👋';

  @override
  String get claudiuApprovalGladToSeeYou => 'Mă bucur că ai venit!';

  @override
  String get claudiuApprovalCheckingForSafety =>
      'Pentru siguranța ta, un Vorsitzer verifică acum cererea ta de logare. 🛡️';

  @override
  String get claudiuApprovalMonthlyExplain =>
      '💡 Asta facem o dată la 30 de zile, ca să fim siguri că tu ești. E ca un check-up de securitate — durează maxim 5 minute.';

  @override
  String get claudiuApprovalSuccess =>
      'Gata! 🎉 Vorsitzer-ul te-a recunoscut. Te conectez acum…';

  @override
  String get claudiuApprovalDenied =>
      'Hm, Vorsitzer-ul a respins cererea ta. 😔';

  @override
  String get claudiuApprovalDeniedHelp =>
      'Dacă crezi că e o greșeală, te rog sună-ne să clarificăm.';

  @override
  String get claudiuApprovalExpired =>
      'Cele 5 minute au trecut și nu am primit răspuns de la Vorsitzer.';

  @override
  String get claudiuApprovalExpiredHelp =>
      'Sună-ne și putem să-ți aprobăm direct cererea pe loc. 📞';

  @override
  String get claudiuApprovalCallUs => 'Sună-ne';

  @override
  String get claudiuApprovalTryAgain => 'Încearcă din nou';

  @override
  String get claudiuApprovalCancel => 'Anulează';

  @override
  String get claudiuApprovalClose => 'Închide';

  @override
  String get wizardIntroBubble1 =>
      'Bună, vizitator! 👋 Îți mulțumesc că vrei să intri în familia noastră.';

  @override
  String get wizardIntroBubble2 =>
      'Mă numesc Claudiu. În primăvara lui 2025 am avut o viziune clară: să creez o asociație care să ajute oamenii care au nevoie — voluntar, cu inima, fără birocrație stufoasă. ❤️';

  @override
  String get wizardIntroBubble3 =>
      'Am început să vorbesc cu clienții pe care îi vizitam. Le-am spus visul meu. Și fiecare a zis: „Da, hai!\" În iulie 2025 ne-am întâlnit 6 oameni hotărâți. Am decis să fondăm **ICD360S e.V.** în Neu-Ulm. 📍';

  @override
  String get wizardIntroBubble4 =>
      'Pe **1 august 2025**, asociația a prins viață oficial — în Registrul Asociațiilor. Cel mai frumos cadou al meu. 🎂';

  @override
  String get wizardIntroBubble5 =>
      'Ce facem? Ajutăm refugiați, persoane cu dizabilități, oameni dezavantajați economic, **copii și tineri** — cu probleme administrative, limba germană, locuință, cumpărături, prestații sociale. Vorstandul nostru e majoritar format din oameni cu dizabilități — așa ne asigurăm că deciziile vin din experiență reală. 🤝';

  @override
  String get wizardIntroBubble6 =>
      'Acum e timpul tău. Hai să te înscriem — durează vreo 5 minute. Mergem pas cu pas, nu te las singur. ✨';

  @override
  String get wizardIntroStart => 'Hai să începem';

  @override
  String get wizardBack => 'Înapoi';

  @override
  String get wizardNext => 'Mai departe';

  @override
  String wizardStepLabel(int step, int total, String title) {
    return 'Pas $step din $total · $title';
  }

  @override
  String get wizardErrRequired => 'Acest câmp e obligatoriu';

  @override
  String wizardErrTooShort(int count) {
    return 'Prea scurt (minim $count caractere)';
  }

  @override
  String get wizardErrOnlyLetters => 'Doar litere, spații, cratime și apostrof';

  @override
  String get wizardErrSaveFailed =>
      'Nu am putut salva. Verifică conexiunea și încearcă din nou.';

  @override
  String get wizardStufe1aTitle => 'Identitate';

  @override
  String get wizardStufe1aPrompt =>
      'Hai să te cunoaștem oficial. Te rog să scrii numele tău exact cum apare pe Personalausweis, Reisepass sau Aufenthaltstitel — așa rămâne consistent cu actele.';

  @override
  String get wizardStufe1aVornameLabel => 'Vornamen (prenumele)';

  @override
  String get wizardStufe1aVornameHelper =>
      'Toate prenumele tale, exact ca pe acte. Folosește spațiu sau cratimă (ex: Hans-Peter, Maria Anna, José María).';

  @override
  String get wizardStufe1aNachnameLabel => 'Familienname (numele de familie)';

  @override
  String get wizardStufe1aNachnameHelper => 'Numele de familie actual.';

  @override
  String get wizardStufe1aGeburtsnameLabel =>
      'Geburtsname (numele de naștere) — opțional';

  @override
  String get wizardStufe1aGeburtsnameHelper =>
      'Doar dacă diferă de Familienname — ex. înainte de căsătorie.';

  @override
  String get wizardStufe1bTitle => 'Ziua de naștere';

  @override
  String get wizardStufe1bPrompt =>
      'Vrem să sărbătorim împreună cu tine ziua ta de naștere! 🎂 Ne ajută și să știm că ai cel puțin 16 ani — așa zice Satzung-ul nostru.';

  @override
  String get wizardStufe1bGeburtsdatumLabel => 'Data nașterii';

  @override
  String get wizardStufe1bGeburtsdatumHelper => 'Apasă să selectezi data';

  @override
  String get wizardStufe1bGeburtsortLabel => 'Locul nașterii';

  @override
  String get wizardStufe1bGeburtsortHelper =>
      'Orașul / localitatea unde te-ai născut.';

  @override
  String get wizardAgeGatePrompt => 'Îmi pare rău… 😔';

  @override
  String wizardAgeGateBody1(int age, int years) {
    return 'Satzung-ul nostru spune că trebuie să ai cel puțin 16 ani să fii membru. Tu ai $age ani — sper să te revedem peste $years ani! 🌱';
  }

  @override
  String get wizardAgeGateBody2 =>
      'Dacă vrei să te implici punctual ca voluntar (orice vârstă, cu acordul părinților), sună-ne și vorbim — ne face plăcere să ajutăm tinerii care vor să schimbe lumea.';

  @override
  String get wizardAgeGateBackHome => 'Înapoi la welcome';

  @override
  String get wizardErrInvalidPhone => 'Număr de telefon invalid';

  @override
  String get wizardStufe1b1Title => 'Acord părinte';

  @override
  String get wizardStufe1b1Prompt =>
      'Ești minor (16-17 ani) — conform §106 BGB avem nevoie de acordul unui părinte sau tutore legal. Spune-mi cum îl cheamă și numărul lui de telefon. Un Vorsitzer îl va suna și va stabili o întâlnire (în persoană sau apel video). Nu trimitem email — vrem să fim siguri că vorbim cu persoana reală.';

  @override
  String get wizardStufe1b1VornameLabel => 'Prenume părinte';

  @override
  String get wizardStufe1b1VornameHelper =>
      'Ca pe Personalausweis al părintelui.';

  @override
  String get wizardStufe1b1NachnameLabel => 'Nume părinte';

  @override
  String get wizardStufe1b1NachnameHelper =>
      'Ca pe Personalausweis al părintelui.';

  @override
  String get wizardStufe1b1TelefonLabel => 'Telefon mobil părinte';

  @override
  String get wizardStufe1b1TelefonHelper =>
      'Pe acest număr îl va suna un Vorsitzer.';

  @override
  String get wizardStufe1b1RelationLabel => 'Relația cu copilul:';

  @override
  String get wizardStufe1b1RelationMutter => 'Mamă';

  @override
  String get wizardStufe1b1RelationVater => 'Tată';

  @override
  String get wizardStufe1b1RelationSorgeberechtigter => 'Tutore legal';

  @override
  String get wizardStufe1b1RelationAndere => 'Alt tutore';

  @override
  String get wizardStufe1cTitle => 'Detalii personale';

  @override
  String get wizardStufe1cPrompt =>
      'Doar ca să te cunosc puțin mai bine. Aceste informații rămân între noi și nu apar nicăieri public.';

  @override
  String get wizardStufe1cGeschlechtLabel => 'Gen';

  @override
  String get wizardStufe1cGeschlechtMaennlich => 'Bărbat';

  @override
  String get wizardStufe1cGeschlechtWeiblich => 'Femeie';

  @override
  String get wizardStufe1cGeschlechtDivers => 'Divers';

  @override
  String get wizardStufe1cGeschlechtKeineAngabe => 'Prefer să nu spun';

  @override
  String get wizardStufe1cFamilienstandLabel => 'Stare civilă';

  @override
  String get wizardStufe1cFamilienstandLedig => 'Necăsătorit/ă';

  @override
  String get wizardStufe1cFamilienstandVerheiratet => 'Căsătorit/ă';

  @override
  String get wizardStufe1cFamilienstandGeschieden => 'Divorțat/ă';

  @override
  String get wizardStufe1cFamilienstandVerwitwet => 'Văduv/ă';

  @override
  String get wizardStufe1dTitle => 'Originea ta';

  @override
  String get wizardStufe1dPrompt =>
      'Asta ne ajută să-ți oferim ajutorul potrivit — de ex. dacă ai nevoie de consiliere pe Aufenthalt sau să găsești comunitatea ta lingvistică.';

  @override
  String get wizardStufe1dStaatLabel => 'Cetățenie';

  @override
  String get wizardStufe1dStaatHelper =>
      'Ex. deutsch, rumänisch, ukrainisch. Mai multe, despărțite cu virgulă.';

  @override
  String get wizardStufe1dAufenthaltLabel =>
      'Statut de ședere (Aufenthaltsstatus) — opțional';

  @override
  String get wizardStufe1dAufenthaltHelper =>
      'Alege titlul din Aufenthaltskarte / decizia ta. Vorstand-ul îl verifică cu documentele tale.';

  @override
  String get wizardStufe1dAufenthaltAwaitingCitizenship =>
      'Completează mai întâi cetățenia de mai sus — îți arăt doar opțiunile potrivite.';

  @override
  String get wizardStufe1dAufenthaltGerman =>
      'Niciun titlu de ședere necesar — cetățean german.';

  @override
  String get wizardStufe1dAufenthaltEuEea =>
      'Cetățean UE/SEE/CH — libertatea de circulație (Freizügigkeit).';

  @override
  String get wizardStufe1dAufenthaltTempHint => 'permis temporar';

  @override
  String get wizardStufe1dAufenthaltPermHint => 'permis permanent';

  @override
  String get wizardStufe1dAufenthaltAsylumProcessHint => 'în procedura de azil';

  @override
  String get wizardStufe1dAufenthaltOther =>
      'Altele (te rog precizează în chat)';

  @override
  String get wizardStufe1dAufenthaltRequired =>
      'Te rog alege un statut de ședere.';

  @override
  String get wizardStufe1dMutterspracheLabel => 'Limba maternă';

  @override
  String get wizardStufe1dMutterspracheHelper =>
      'Pre-completat cu limba aplicației — schimbă dacă diferă.';

  @override
  String get wizardStufe1eTitle => 'Adresa';

  @override
  String get wizardStufe1ePrompt =>
      'Adresa ta de corespondență — o folosim pentru documente oficiale (statute, contracte de membru, înștiințări).';

  @override
  String get wizardStufe1eStrasseLabel => 'Strada';

  @override
  String get wizardStufe1eStrasseHelper =>
      'Doar numele străzii — numărul în câmpul de lângă.';

  @override
  String get wizardStufe1eHausnummerLabel => 'Nr.';

  @override
  String get wizardStufe1ePlzLabel => 'PLZ (cod poștal)';

  @override
  String get wizardStufe1eOrtLabel => 'Oraș';

  @override
  String get wizardStufe1eLandLabel => 'Țara';

  @override
  String get wizardStufe1eLandHelper => 'Pre-completat cu Deutschland.';

  @override
  String get wizardErrInvalidStreet => 'Nume de stradă invalid';

  @override
  String get wizardErrInvalidHausnummer => 'Număr invalid (ex: 12, 12a, 12/3)';

  @override
  String get wizardErrInvalidPlz => 'Cod poștal invalid (doar cifre)';

  @override
  String get wizardStufe1fTitle => 'Contact';

  @override
  String get wizardStufe1fPrompt =>
      'Cum te contactăm? Telefonul îl folosim doar pentru urgențe — pentru restul comunicăm prin aplicație (criptat end-to-end). Adresa ta de membru e generată automat și o vezi mai jos.';

  @override
  String get wizardStufe1fTelefonLabel => 'Telefon mobil';

  @override
  String get wizardStufe1fTelefonHelper =>
      'Promit, nu te sun decât dacă e ceva important. 📱';

  @override
  String get wizardStufe2Title => 'Tip de membru';

  @override
  String get wizardStufe2Prompt =>
      'Ce fel de membru vrei să fii? Hai să-ți explic fiecare opțiune.';

  @override
  String get wizardStufe2OrdentlichTitle => 'Membru ordinar (ordentlich)';

  @override
  String get wizardStufe2OrdentlichBody =>
      'Drepturi depline. Plătești cotizația lunară, votezi în Mitgliederversammlung, poți fi ales în Vorstand. Alegerea standard.';

  @override
  String get wizardStufe2FoerderTitle => 'Membru susținător (Fördermitglied)';

  @override
  String get wizardStufe2FoerderBody =>
      'Sprijini asociația financiar, dar nu participi activ la decizii. Fără drept de vot. Bun dacă vrei să ajuți de la distanță.';

  @override
  String get wizardStufe2EhrenTitle => 'Membru de onoare (Ehrenmitglied)';

  @override
  String get wizardStufe2EhrenBody =>
      'Statut acordat de Vorstand pentru merite deosebite. Nu îl alegi singur — îl primești ca recunoaștere. Selectează doar dacă ai fost deja onorat.';

  @override
  String get wizardStufe3Title => 'Situație financiară';

  @override
  String get wizardStufe3Prompt =>
      'Acum despre situația ta financiară. Nu e ca să te judec — e ca să te scutim de cotizație dacă primești ajutor social.';

  @override
  String get wizardStufe3OptionBuergergeld => 'Primesc Bürgergeld';

  @override
  String get wizardStufe3OptionSozialamt => 'Primesc ajutor de la Sozialamt';

  @override
  String get wizardStufe3OptionNein => 'Nu primesc niciuna din acestea';

  @override
  String get wizardStufe3FeeExemptTitle => 'Cotizație: 0 € / lună 🎉';

  @override
  String get wizardStufe3FeeExemptBody =>
      'Cu Bürgergeld, Sozialamt, ALG I sau Krankengeld ești scutit complet de cotizație, conform Satzung-ului §6. Avem nevoie doar de o dovadă (Leistungsbescheid sau Bescheinigung de la autoritate / casa de asigurări).';

  @override
  String get wizardStufe3UploadTitle => 'Încarcă Leistungsbescheid';

  @override
  String get wizardStufe3UploadHint => 'PDF / JPG / PNG, maxim 10 MB.';

  @override
  String get wizardStufe3UploadRequired =>
      'Te rog încarcă Leistungsbescheid înainte să mergi mai departe.';

  @override
  String get wizardStufe3FileTooLarge => 'Fișierul e prea mare. Maxim 10 MB.';

  @override
  String get wizardStufe3UploadFailed =>
      'Nu am putut încărca fișierul. Încearcă din nou.';

  @override
  String get wizardStufe3RegularFeeTitle => 'Cotizație: 25 € / lună';

  @override
  String get wizardStufe3RegularFeeBody =>
      'Cotizația standard pentru membri ordinari, conform Satzung-ului.';

  @override
  String get wizardStufe4Title => 'Plata';

  @override
  String get wizardStufe4Prompt =>
      'Cum vrei să plătești cotizația? Și în ce zi a lunii preferi să fie debitată?';

  @override
  String get wizardStufe4MethodUeberweisungTitle =>
      'Transfer bancar (Überweisung)';

  @override
  String get wizardStufe4MethodUeberweisungBody =>
      'Tu inițiezi plata manual în fiecare lună din contul tău.';

  @override
  String get wizardStufe4MethodSepaTitle => 'SEPA-Lastschrift (debit direct)';

  @override
  String get wizardStufe4MethodSepaBody =>
      'Noi tragem suma automat din contul tău. Cel mai comod, dar avem nevoie de IBAN și un mandat semnat.';

  @override
  String get wizardStufe4MethodDauerauftragTitle =>
      'Dauerauftrag (ordin permanent)';

  @override
  String get wizardStufe4MethodDauerauftragBody =>
      'Tu setezi un ordin permanent în banca ta. Banca ta trimite suma automat în fiecare lună.';

  @override
  String get wizardStufe4DayLabel => 'Ziua plății';

  @override
  String get wizardStufe4DayHint => 'Alege o zi între 1 și 31';

  @override
  String wizardStufe4DayItem(int day) {
    return 'Ziua $day';
  }

  @override
  String wizardStufe4DayReminder(int day) {
    return 'Cotizația va fi debitată în ziua $day a fiecărei luni.';
  }

  @override
  String get wizardStufe5Title => 'Începutul';

  @override
  String get wizardStufe5Prompt =>
      'Când vrei să fii oficial membru ICD360S? Poți alege din momentul aprobării sau retroactiv.';

  @override
  String get wizardStufe5OptionAbVerifizierungTitle =>
      'De la aprobarea Vorstand-ului';

  @override
  String get wizardStufe5OptionAbVerifizierungBody =>
      'Cea mai simplă alegere. Fără cotizație retroactivă.';

  @override
  String get wizardStufe5OptionGruendungsdatumTitle =>
      'Retroactiv din 01.08.2025 (Gründungsdatum)';

  @override
  String get wizardStufe5OptionGruendungsdatumBody =>
      'Vei număra ca membru încă din prima zi a asociației.';

  @override
  String get wizardStufe5OptionAnderesDatumTitle => 'O altă dată';

  @override
  String get wizardStufe5OptionAnderesDatumBody =>
      'Alegi tu o dată între 01.08.2025 și azi.';

  @override
  String get wizardStufe5PickDate => 'Apasă pentru a alege data';

  @override
  String get wizardStufe5PickDateFirst => 'Te rog alege întâi o dată.';

  @override
  String get wizardStufe5DatePickerHelp => 'Începutul calității de membru';

  @override
  String wizardStufe5DateRange(String start) {
    return 'Între $start și azi';
  }

  @override
  String get wizardStufe5RetroactiveTitle => 'Cotizație retroactivă';

  @override
  String wizardStufe5RetroactiveBody(
      String start, String end, int months, String amount) {
    return 'De la $start până la $end sunt $months luni. La 25 €/lună înseamnă $amount € de plată retroactivă, în plus față de cotizația lunară curentă.';
  }

  @override
  String get wizardStufe5FeeExemptTitle => 'Cotizație retroactivă: 0 € 🎉';

  @override
  String get wizardStufe5FeeExemptBody =>
      'Cu Bürgergeld sau Sozialamt ești scutit complet — chiar și retroactiv nu datorezi nimic.';

  @override
  String wizardDocumentPrompt(String doc) {
    return 'Înainte să închidem, te rog citește cu atenție $doc. E important să știi ce semnezi.';
  }

  @override
  String get wizardDocumentScrollHint =>
      'Derulează până la sfârșit pentru a continua.';

  @override
  String get wizardDocumentScrolledOk => 'Ai citit până la sfârșit ✓';

  @override
  String wizardDocumentOpenButton(String doc) {
    return 'Deschide $doc în browser';
  }

  @override
  String get wizardDocumentExternalHint =>
      'Pe această platformă deschidem documentul în browser-ul tău preferat.';

  @override
  String get wizardDocumentOpenedOk =>
      'Documentul a fost deschis. Te rog citește-l cu atenție.';

  @override
  String wizardDocumentConfirm(String doc) {
    return 'Confirm că am citit și sunt de acord cu $doc.';
  }

  @override
  String get wizardFinalAdultTitle => 'Gata, ești înscris! 🎉';

  @override
  String get wizardFinalMinorTitle => 'Cererea ta a fost trimisă 📨';

  @override
  String get wizardFinalMinorBody =>
      'Îți vom contacta părintele și vom stabili o întâlnire (în persoană sau apel video). Te rugăm să ai răbdare — procedura poate dura până la 7 zile. Te anunțăm prin notificare în aplicație imediat ce părintele a aprobat.';

  @override
  String get wizardFinalMitgliedernummerLabel => 'Numărul tău de membru';

  @override
  String get wizardStufe4MethodComingSoon => 'Disponibil în viitor';

  @override
  String get wizardStufe4StreichungWarning =>
      'Dacă rămâi cu cotizația în urmă mai mult de 6 luni, te radiem automat (Satzung §6 Abs. 3).';

  @override
  String get wizardStufe5KuendigungInfo =>
      'Pentru retragere: anunță-ne în scris cu 3 luni înainte de 31 decembrie (până la 30 septembrie pentru a ieși la sfârșitul anului). Nu există durată minimă (Satzung §6 Abs. 3).';

  @override
  String get wizardStufe1fEmailLabel => 'Adresa ta de membru';

  @override
  String get wizardStufe1fEmailHelper =>
      'Atribuită automat pe baza numărului tău de membru. Se activează imediat ce Vorstand-ul validează cererea ta. Avem o aplicație de email dedicată — trimiți și primești emailuri criptate, simplu și gratuit.';

  @override
  String get wizardErrInvalidEmail => 'Adresă de email invalidă';

  @override
  String get wizardStufe3OptionAlg1 => 'Primesc Arbeitslosengeld I (ALG I)';

  @override
  String get wizardStufe3OptionKrankengeld =>
      'Primesc Krankengeld (concediu medical prelungit)';

  @override
  String get wizardStufe3UploadAddMore => 'Adaugă alt document';

  @override
  String get wizardStufe3UploadLimitCount =>
      'Ai atins limita: maxim 20 documente.';

  @override
  String get wizardStufe3UploadLimitTotal =>
      'Ai atins limita totală de 100 MB. Șterge un fișier existent.';

  @override
  String get wizardStufe3UploadDeleteTooltip => 'Șterge';

  @override
  String wizardStufe3UploadCounter(int count, int max) {
    return '$count / $max documente';
  }

  @override
  String get wizardDocumentExternalOpenFailed =>
      'Nu am putut deschide browserul. Link-ul a fost copiat în clipboard — lipește-l într-un browser pentru a continua.';

  @override
  String get wizardFinalTimelineProcessing =>
      'Vorstand verifică · de obicei 1 zi, maxim 7 lucrătoare';

  @override
  String get wizardFinalTimelineActivated => 'Cont activat';

  @override
  String get wizardFinalAdultThank =>
      'Îți mulțumim că ai completat formularul de înregistrare! 🎉';

  @override
  String get wizardFinalAdultUsual =>
      'Cererea ta a ajuns la noi. De obicei o validăm într-o zi lucrătoare.';

  @override
  String get wizardFinalAdultExceptional =>
      'Uneori poate dura până la 7 zile lucrătoare. Și dacă ceva nu corespunde, te trimitem înapoi la formular ca să corectezi 🙂';

  @override
  String get wizardFinalStatusTitle => 'STATUS CERERE';

  @override
  String wizardFinalStatusStepsValidated(int reviewed, int total) {
    return '$reviewed/$total pași validați de Vorstand';
  }

  @override
  String get wizardFinalStufeSheetTitle => 'Detalii cerere';

  @override
  String get wizardFinalStufeSheetHint =>
      'Cei 8 pași pe care i-ai completat. Vorstand-ul îi verifică pe rând — vezi în timp real ce a fost validat.';

  @override
  String get wizardFinalStufeStatusPending => 'În așteptarea verificării';

  @override
  String get wizardFinalStufeStatusApproved => 'Verificat';

  @override
  String get wizardFinalStufeStatusRejected => 'Respins';

  @override
  String wizardFinalStatusRejectionCount(int count) {
    return '$count pas necesită corectare';
  }

  @override
  String get wizardFinalStufeRejectionReason => 'Motivul Vorstand-ului:';

  @override
  String get wizardFinalStufeCorrectNow => 'Corectează acum';

  @override
  String wizardFinalApprovalsHeader(int current, int total) {
    return 'Aprobări Vorstand ($current/$total)';
  }

  @override
  String get wizardFinalApprovalAwaiting => 'Așteptăm al 2-lea Vorstand';

  @override
  String get wizardFinalApprovalRejected => 'RESPINS';

  @override
  String get wizardFinalStufeNoDataYet => 'Datele nu sunt încă disponibile.';

  @override
  String get wizardFinalStufeReadAt => 'Citit la:';

  @override
  String get wizardFinalStufeBeitragsfrei =>
      'Scutit de contribuție (fără plată)';

  @override
  String get wizardFinalStufeNotExempt => 'Fără ajutoare sociale';

  @override
  String get wizardFinalStufeBeginAtVerification => 'Începe la validare';

  @override
  String get wizardFinalStufeBeginAtFoundation => 'Data fondării (retroactiv)';

  @override
  String get wizardFinalStufeBeginAtCustom => 'Dată personalizată';

  @override
  String get wizardFinalStufeStatusSkipped => 'Sărit';

  @override
  String get wizardFinalStufeFilledAt => 'Completat:';

  @override
  String get wizardFinalStufeReviewedAt => 'Verificat:';

  @override
  String get wizardFinalWithdrawLink => 'Anulează cererea';

  @override
  String get wizardFinalWithdrawDialogTitle => 'Anulezi cererea?';

  @override
  String get wizardFinalWithdrawDialogBody =>
      'Cererea ta va fi marcată ca anulată de tine. Datele rămân în baza de date pentru audit (DSGVO), dar contul nu va mai fi activat. Vei putea reîncepe înregistrarea oricând cu un alt număr de membru.';

  @override
  String get wizardFinalWithdrawKeep => 'Nu, mai aștept';

  @override
  String get wizardFinalWithdrawConfirm => 'Da, anulează';

  @override
  String get wizardErrTooManyWithdrawals =>
      'Cererea ta nu poate fi procesată automat. Sună-ne sau vino în persoană la Vorstand pentru a continua înregistrarea.';

  @override
  String get wizardDuplicateLoginTitle => 'Se pare că ești deja membru';

  @override
  String get wizardDuplicateLoginBody =>
      'Cu numele și data ta de naștere găsim deja un cont activ. Te rugăm să folosești \"Sunt deja membru\" pe ecranul principal pentru a te autentifica. Dacă nu mai ai acces, sună-ne.';

  @override
  String get wizardDuplicatePendingTitle => 'Cererea ta e deja la noi';

  @override
  String get wizardDuplicatePendingBody =>
      'Cu numele și data ta de naștere am găsit deja o cerere în curs de verificare. Vorstand-ul lucrează la ea — te anunțăm prin notificare imediat ce contul tău e activ. Dacă vrei să discutăm, sună-ne.';

  @override
  String get wizardDuplicateRecentlyWithdrawnTitle =>
      'Nu putem procesa cererea acum';

  @override
  String get wizardDuplicateRecentlyWithdrawnBody =>
      'Numele și data ta de naștere se potrivesc cu o cerere retrasă recent. Te rugăm să ne suni pentru a vorbi cu Vorstand-ul înainte de a continua.';

  @override
  String get wizardDuplicatePreviouslyWithdrawnTitle => 'Ai mai depus o cerere';

  @override
  String get wizardDuplicatePreviouslyWithdrawnBody =>
      'Numele și data ta de naștere se potrivesc cu o cerere veche pe care ai retras-o. Bun venit înapoi — te rugăm să ne suni înainte de a continua, ca Vorstand-ul să poată decide cum procedăm.';

  @override
  String get wizardDuplicateCallUsTitle => 'Te rugăm să ne suni';

  @override
  String get wizardDuplicateCallUsBody =>
      'Numele și data ta de naștere apar deja la noi, dar nu îți putem da detalii prin aplicație. Te rugăm să ne suni — Vorstand-ul îți va explica situația direct.';

  @override
  String get wizardChatHelp => 'Vorbim acum';

  @override
  String get wizardChatHelpSubtitle =>
      'Chat live cu Vorstand-ul · răspuns rapid';

  @override
  String get benachrichtigungTitel => 'Reamintiri prin SMS';

  @override
  String get benachrichtigungIntro =>
      'Ca să nu pierdeți nicio programare, asociația vă poate trimite un SMS. Dumneavoastră decideți dacă și pentru ce — și puteți schimba oricând.';

  @override
  String get benachrichtigungTermineFrage =>
      'Doriți să primiți prin SMS reamintiri pentru programările dumneavoastră?';

  @override
  String get benachrichtigungTermineDetail =>
      'Mesajul conține data, ora, locul și subiectul programării.';

  @override
  String get benachrichtigungMedikamenteFrage =>
      'Doriți să vă reamintim și de medicamente?';

  @override
  String get benachrichtigungMedikamenteDetail =>
      'În mesaj apare numele medicamentului. Este o informație de sănătate, de aceea întrebăm separat.';

  @override
  String get benachrichtigungHinweis =>
      'Reamintirea este un ajutor, nu o garanție — vă rugăm să nu vă bazați doar pe ea. Puteți schimba oricând din profil.';

  @override
  String get benachrichtigungJa => 'Da';

  @override
  String get benachrichtigungNein => 'Nu';

  @override
  String get benachrichtigungSpaeter => 'Decid mai târziu';

  @override
  String get benachrichtigungSpeichern => 'Salvează';

  @override
  String get benachrichtigungGespeichert => 'Mulțumim, am salvat.';

  @override
  String get benachrichtigungenLeer => 'Nicio notificare';

  @override
  String get benachrichtigungenAlleGelesen => 'Marchează toate ca citite';

  @override
  String get benachrichtigungWetterFrage =>
      'Doriți să fiți avertizat în caz de vreme severă în localitatea dumneavoastră?';

  @override
  String get benachrichtigungWetterDetail =>
      'Doar avertizări oficiale ale serviciului meteo german, de la nivelul „sever” în sus — nu la fiecare ploaie.';

  @override
  String get signaturTitel => 'Semnături';

  @override
  String get signaturNichtsOffen => 'Momentan nu aveți nimic de semnat.';

  @override
  String get signaturStatusOffen => 'Așteaptă semnătura dumneavoastră';

  @override
  String get signaturStatusSigniert => 'Semnat de dumneavoastră';

  @override
  String get signaturStatusAbgelehnt => 'Refuzat de dumneavoastră';

  @override
  String get signaturStatusWiderrufen => 'Retras de asociație';

  @override
  String get signaturStatusAbgelaufen => 'Termen expirat';

  @override
  String signaturBitteGanzLesen(int gelesen, int gesamt) {
    return 'Vă rugăm să citiți documentul până la final (pagina $gelesen din $gesamt).';
  }

  @override
  String get signaturWeiterZurUnterschrift => 'Continuați spre semnătură';

  @override
  String get signaturAblehnen => 'Refuz';

  @override
  String get signaturAblehnenHinweis =>
      'Asociația va fi înștiințată. Puteți menționa motivele.';

  @override
  String get signaturAblehnenGrund => 'Motiv (opțional)';

  @override
  String get signaturMitFingerHinweis => 'Semnați cu degetul în câmpul alb.';

  @override
  String get signaturNochmal => 'Din nou';

  @override
  String get signaturZurueckZumDokument => 'Înapoi la document';

  @override
  String get signaturCodeAnfordern => 'Cere codul prin SMS';

  @override
  String get signaturCodeUnterwegs => 'Codul este pe drum.';

  @override
  String signaturCodeGesendetAn(String nummer) {
    return 'V-am trimis un cod la $nummer.';
  }

  @override
  String get signaturCodeErneutSenden => 'Trimite codul din nou';

  @override
  String get signaturJetztUnterschreiben => 'Semnează acum';

  @override
  String get signaturCodeFalsch => 'Codul nu este corect.';

  @override
  String get signaturCodeAbgelaufen =>
      'Codul a expirat. Vă rugăm să cereți unul nou.';

  @override
  String get signaturZuVieleVersuche =>
      'Prea multe încercări greșite. Vă rugăm să cereți un cod nou.';

  @override
  String get signaturKeineRufnummer =>
      'Contul dumneavoastră nu are un număr de mobil înregistrat. Fără el nu vă putem trimite un cod — vă rugăm să vă adresați președintelui.';

  @override
  String get signaturCodeFehlgeschlagen => 'Codul nu a putut fi trimis.';

  @override
  String get signaturLeer => 'Vă rugăm să semnați mai întâi.';

  @override
  String get signaturErfolg =>
      'Vă mulțumim — semnătura dumneavoastră a fost înregistrată.';

  @override
  String get signaturFehlgeschlagen =>
      'Nu a funcționat. Vă rugăm să încercați din nou.';

  @override
  String get signaturSiegelInArbeit =>
      'Sigiliul este încă în curs de creare. Vă rugăm să încercați din nou peste un minut.';

  @override
  String get signaturWartetZweiteUnterschrift => 'Așteaptă a doua semnătură';

  @override
  String get signaturWartenHinweis =>
      'Ați semnat. Documentul va fi sigilat de îndată ce va semna și a doua persoană.';

  @override
  String get kontaktNochAktuell => 'Aceste date mai sunt valabile?';

  @override
  String get kontaktWarumFragen =>
      'Ca să nu pierdeți nimic, întrebăm scurt o dată la trei luni. Veți primi un cod din șase cifre.';

  @override
  String kontaktBestaetigtAm(Object datum) {
    return 'confirmat la $datum';
  }

  @override
  String get kontaktFestnetzKeinSms =>
      'Acesta este un număr fix — acolo nu ajunge niciun SMS.';

  @override
  String get kontaktIstAndersGeworden => 'S-a schimbat';
}
