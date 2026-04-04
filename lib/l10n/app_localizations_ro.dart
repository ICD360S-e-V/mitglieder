// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Romanian Moldavian Moldovan (`ro`).
class AppLocalizationsRo extends AppLocalizations {
  AppLocalizationsRo([String locale = 'ro']) : super(locale);

  @override
  String get appTitle => 'ICD360S e.V - Portal Membri';

  @override
  String get memberPortal => 'Portal Membri';

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
  String get password => 'Parolă';

  @override
  String get passwordHint => 'Introduceți parola';

  @override
  String get confirmPassword => 'Confirmați Parola';

  @override
  String get confirmPasswordHint => 'Confirmați parola';

  @override
  String get newPassword => 'Parolă Nouă';

  @override
  String get newPasswordHint => 'Introduceți parola nouă';

  @override
  String get saveCredentials => 'Salvează datele de autentificare';

  @override
  String get autoLogin => 'Autentificare automată';

  @override
  String get forgotPassword => 'Ai uitat parola?';

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
  String get recoveryCode => 'Cod de Recuperare (6 cifre)';

  @override
  String get recoveryCodeHelper =>
      'Memorați acest cod pentru recuperarea parolei';

  @override
  String get recoveryCodeHint => 'Introduceți codul de recuperare';

  @override
  String get recoveryCodeInvalid => 'Codul trebuie să aibă exact 6 cifre';

  @override
  String get loginFailed => 'Autentificare eșuată';

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
  String get tooManyDevices => 'Prea multe dispozitive';

  @override
  String get maxDevicesMessage =>
      'Sunteți deja conectat pe 3 dispozitive.\nSelectați un dispozitiv pentru deconectare:';

  @override
  String get unknownDevice => 'Dispozitiv necunoscut';

  @override
  String get unknown => 'Necunoscut';

  @override
  String get logoutError => 'Eroare la deconectare';

  @override
  String error(String error) {
    return 'Eroare: $error';
  }

  @override
  String get cancel => 'Anulare';

  @override
  String get resetPassword => 'Resetare Parolă';

  @override
  String get forgotPasswordTitle => 'Ai Uitat Parola';

  @override
  String get forgotPasswordDescription =>
      'Introduceți numărul de membru și codul de recuperare creat la înregistrare.';

  @override
  String get passwordResetSuccess =>
      'Parola a fost resetată cu succes!\n\nAcum vă puteți autentifica cu noua parolă.';

  @override
  String get passwordResetFailed => 'Resetarea parolei a eșuat';

  @override
  String get needHelp => 'Ai nevoie de ajutor?';

  @override
  String get helpQuestion => 'Probleme cu autentificarea sau înregistrarea?';

  @override
  String get helpDescription =>
      'Contactați-ne prin WhatsApp și descrieți exact ce nu funcționează. Vom răspunde cât mai curând!';

  @override
  String get whatsapp => 'WhatsApp';

  @override
  String get emailSubject => 'Solicitare prin aplicația ICD360S';

  @override
  String get whatsappMessage => 'Bună, am o problemă cu aplicația ICD360S. ';

  @override
  String get imprint => 'Impressum';

  @override
  String get privacy => 'Politica de Confidențialitate';

  @override
  String get statutes => 'Statut';

  @override
  String get revocation => 'Drept de Retragere';

  @override
  String get cancellation => 'Anulare';

  @override
  String get allRightsReserved => 'Toate drepturile rezervate.';

  @override
  String get enterCredentials => 'Introduceți numărul de membru și parola';

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
  String get membership => 'Membru';

  @override
  String get myAppointments => 'Programările mele';

  @override
  String get appointmentsLoadingReady => 'Se încarcă programări - API gata!';

  @override
  String get priority => 'Prioritate';

  @override
  String get messageLabel => 'Mesaj';

  @override
  String get createdOn => 'Creat';

  @override
  String get handler => 'Responsabil';

  @override
  String get reportProblems => 'Raportați probleme';

  @override
  String get reportProblem => 'Raportați problemă';

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
  String get newTicket => 'Ticket nou';

  @override
  String get noOpenTickets => 'Niciun ticket deschis';

  @override
  String get haveQuestionCreateTicket =>
      'Aveți o întrebare sau problemă?\nCreați un ticket nou.';

  @override
  String get whatIsTheProblem => 'Care este problema?';

  @override
  String get describeTheProblem => 'Descrieți problema';

  @override
  String get howUrgentIsIt => 'Cât de urgent este?';

  @override
  String get low => 'Scăzut';

  @override
  String get medium => 'Mediu';

  @override
  String get high => 'Ridicat';

  @override
  String get submit => 'Trimite';

  @override
  String get fillSubjectAndMessage =>
      'Vă rugăm să completați subiectul și mesajul';

  @override
  String get ticketCreated => 'Ticketul a fost creat';

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
  String get newEmailAddress => 'Adresă email nouă';

  @override
  String get currentPassword => 'Parola curentă';

  @override
  String get saveEmail => 'Salvează email';

  @override
  String get savePassword => 'Salvează parola';

  @override
  String get deviceLoggedOut => 'Dispozitiv deconectat';

  @override
  String get passwordChangedSuccessfully => 'Parola a fost schimbată cu succes';

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
  String get passwordTooShort => 'Parola trebuie să aibă cel puțin 6 caractere';

  @override
  String get maxDevicesReached => 'Sunteți conectat pe maximum 3 dispozitive.';

  @override
  String loggedInOnDevices(int count) {
    return 'Sunteți conectat pe $count din 3 dispozitive.';
  }

  @override
  String get noActiveSessions => 'Nicio sesiune activă';

  @override
  String get logoutFromDevice => 'Deconectare de pe acest dispozitiv';

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
  String get errorAcceptingCall => 'Eroare la acceptarea apelului';

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
  String typingIndicator(String name) {
    return '$name scrie...';
  }

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
  String get diagnosticDataTitle => 'Date de diagnosticare';

  @override
  String get diagnosticDescription =>
      'Doriți să trimiteți date anonime de diagnosticare pentru a îmbunătăți aplicația?';

  @override
  String get noThanks => 'Nu, mulțumesc';

  @override
  String get yesEnable => 'Da, activează';

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
  String get newPasswordMinChars => 'Parolă nouă (min. 6 caractere)';

  @override
  String get reasonLabel2 => 'Motiv';

  @override
  String get downloadFailed2 => 'Descărcare eșuată';

  @override
  String get downloadTooltip => 'Descarcă';

  @override
  String get connectionErrorGeneric => 'Eroare de conexiune';

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
  String get bankTransfer => 'Transfer bancar';

  @override
  String get standingOrder => 'Ordin permanent';

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
  String get memberNumberTooLong =>
      'Număr de membru prea lung (max 20 caractere)';

  @override
  String get onlyUppercaseAndNumbers =>
      'Doar litere mari și cifre sunt permise';

  @override
  String get passwordTooLong => 'Parola prea lungă (max 100 caractere)';

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
  String get diagnosticErrors => 'Rapoarte de erori pentru îmbunătățire';

  @override
  String get diagnosticAnonymousStats => 'Statistici de utilizare anonime';

  @override
  String get diagnosticPerformance => 'Date de performanță ale aplicației';

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
  String get ipClean => 'IP curat - nelistat';

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
  String get helpImproveApp => 'Doriți să ne ajutați să îmbunătățim aplicația?';

  @override
  String get noPersonalDataCollected =>
      'Nu se colectează date personale. Această setare poate fi modificată oricând.';

  @override
  String logEntries(int count) {
    return '$count înregistrări';
  }

  @override
  String get noLogs => 'Fără jurnale';

  @override
  String get newLoginDetected => 'Autentificare nouă detectată';

  @override
  String get waitingForMember => 'Se așteaptă membrul';

  @override
  String get waitingForStaff => 'Se așteaptă personalul';

  @override
  String get waitingForAuthority => 'Se așteaptă autoritatea';
}
