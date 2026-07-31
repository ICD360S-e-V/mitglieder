// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Croatian (`hr`).
class AppLocalizationsHr extends AppLocalizations {
  AppLocalizationsHr([String locale = 'hr']) : super(locale);

  @override
  String get welcomeLoading => 'Učitavanje...';

  @override
  String get welcomeAutoLogin => 'Automatska prijava...';

  @override
  String get login => 'Prijava';

  @override
  String get register => 'Registracija';

  @override
  String get becomeMember => 'Postanite član';

  @override
  String get memberNumber => 'Broj člana';

  @override
  String get memberNumberHint => 'Unesite broj člana';

  @override
  String get confirmPassword => 'Potvrdite lozinku';

  @override
  String get confirmPasswordHint => 'Potvrdite lozinku';

  @override
  String get newPassword => 'Nova lozinka';

  @override
  String get newPasswordHint => 'Unesite novu lozinku';

  @override
  String get firstName => 'Ime i prezime';

  @override
  String get firstNameHint => 'Unesite ime i prezime';

  @override
  String get nameMinLength => 'Ime mora imati najmanje 2 znaka';

  @override
  String get nameOnlyLetters => 'Dozvoljeni su samo slova i crtice';

  @override
  String get email => 'Email adresa';

  @override
  String get emailHint => 'Unesite email';

  @override
  String get emailInvalid => 'Unesite važeći email';

  @override
  String get passwordMinLength => 'Lozinka mora imati najmanje 6 znakova';

  @override
  String get passwordsNotMatch => 'Lozinke se ne podudaraju';

  @override
  String get registrationFailed => 'Registracija nije uspjela';

  @override
  String connectionError(String error) {
    return 'Greška povezivanja: $error';
  }

  @override
  String registrationSuccess(String memberNumber) {
    return 'Uspješna registracija!\n\nVaš broj člana: $memberNumber\n\nZapamtite ovaj broj za prijavu.';
  }

  @override
  String get unknown => 'Nepoznato';

  @override
  String error(String error) {
    return 'Greška: $error';
  }

  @override
  String get cancel => 'Odustani';

  @override
  String get resetPassword => 'Poništi lozinku';

  @override
  String get imprint => 'Impressum';

  @override
  String get privacy => 'Politika privatnosti';

  @override
  String get statutes => 'Statut';

  @override
  String get revocation => 'Pravo povlačenja';

  @override
  String get appointments => 'Sastanci';

  @override
  String get tickets => 'Zahtjevi';

  @override
  String get liveChat => 'Chat uživo';

  @override
  String get notifications => 'Obavijesti';

  @override
  String get myProfile => 'Moj Profil';

  @override
  String get logout => 'Odjava';

  @override
  String get goodMorning => 'Dobro jutro';

  @override
  String get goodDay => 'Dobar dan';

  @override
  String get goodEvening => 'Dobra večer';

  @override
  String get goodNight => 'Laku noć';

  @override
  String get welcomeToICD => 'Dobrodošli u ICD360S e.V!';

  @override
  String get accountCreatedSuccessfully => 'Vaš račun je uspješno kreiran.';

  @override
  String get today => 'Danas';

  @override
  String get membershipFeeDue => 'Članarina dospjela';

  @override
  String get pleaseTransferAnnualFee => 'Molimo prenijeti godišnju članarinu.';

  @override
  String get newBadge => 'Novo';

  @override
  String get close => 'Zatvori';

  @override
  String get myAppointments => 'Moji sastanci';

  @override
  String get priority => 'Prioritet';

  @override
  String get messageLabel => 'Poruka';

  @override
  String get reportProblems => 'Prijavite probleme';

  @override
  String get weRespondIn24Hours =>
      'Odgovorit ćemo vam u roku od maksimalno 24 sata!';

  @override
  String get everythingOk => 'Sve u redu!';

  @override
  String get haveProblemWeHelp => 'Imate problem?\nMi ćemo se pobrinuti!';

  @override
  String get myMembership => 'Moje članstvo';

  @override
  String get managePersonalDataAndFee =>
      'Upravljanje osobnim podacima i članarinom';

  @override
  String get myAppointmentsTitle => 'Moji termini';

  @override
  String get appointmentsDescription =>
      'Ovdje možete vidjeti nadolazeće termine.\nMožete potvrditi svoje sudjelovanje ili odbiti.';

  @override
  String get loadAppointments => 'Učitaj termine';

  @override
  String get myTickets => 'Moji zahtjevi';

  @override
  String get low => 'Niska';

  @override
  String get high => 'Visoka';

  @override
  String get submit => 'Pošalji';

  @override
  String get errorCreatingTicket => 'Greška pri kreiranju zahtjeva';

  @override
  String get verified => 'Potvrđeno';

  @override
  String get account => 'Račun';

  @override
  String get myDevices => 'Moji uređaji';

  @override
  String get changeEmail => 'Promijeni email';

  @override
  String get changePassword => 'Promijeni lozinku';

  @override
  String get saveEmail => 'Spremi email';

  @override
  String get savePassword => 'Spremi lozinku';

  @override
  String get deviceLoggedOut => 'Uređaj odjavljen';

  @override
  String get emailChangedSuccessfully => 'Email uspješno promijenjen';

  @override
  String get errorChangingPassword => 'Greška pri promjeni lozinke';

  @override
  String get errorChangingEmail => 'Greška pri promjeni emaila';

  @override
  String get validEmailRequired => 'Molimo unesite valjanu email adresu';

  @override
  String get confirmLogoutDevice => 'Odjaviti uređaj?';

  @override
  String get confirmLogoutMessage =>
      'Želite li se odjaviti s ovog uređaja?\n\nMorat ćete se ponovno prijaviti za korištenje ovog uređaja.';

  @override
  String get ipAddress => 'IP';

  @override
  String get platform => 'Platforma';

  @override
  String trialWarningUrgentTitle(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days dana',
      few: '$days dana',
      one: '1 dan',
    );
    return 'Pažnja: Preostalo je $_temp0 do obustave računa!';
  }

  @override
  String get trialWarningTitle => 'Vaš račun još nije verificiran';

  @override
  String get trialWarningDescription =>
      'Molimo ispunite svoje podatke u \"Moj profil\". Nakon 30 dana vaš račun će biti automatski obustavljen.';

  @override
  String trialDaysRemaining(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days dana',
      few: '$days dana',
      one: '1 dan',
    );
    return '$_temp0';
  }

  @override
  String get overview => 'Pregled';

  @override
  String get member => 'Član';

  @override
  String get memberManagement => 'Upravljanje članovima';

  @override
  String get reportProblemTooltip => 'Prijavite problem';

  @override
  String get newAppointmentsTitle => 'Novi sastanci';

  @override
  String get youHaveNewAppointment => 'Imate novi sastanak.';

  @override
  String youHaveNewAppointments(int count) {
    return 'Imate $count novih sastanaka.';
  }

  @override
  String get appointmentReminderTomorrow => 'Podsjetnik: Sastanak sutra';

  @override
  String tomorrowAppointment(String title) {
    return 'Sutra: $title';
  }

  @override
  String youHaveTomorrowAppointments(int count) {
    return 'Imate $count sastanaka sutra.';
  }

  @override
  String get appointmentsToday => 'Sastanci danas';

  @override
  String todayAppointment(String title) {
    return 'Danas: $title';
  }

  @override
  String youHaveTodayAppointments(int count) {
    return 'Imate $count sastanaka danas.';
  }

  @override
  String get paymentReminder => 'Podsjetnik za plaćanje';

  @override
  String paymentReminderMessage(int day, String method) {
    return 'Danas je $day. dan u mjesecu – molimo dovršite $method.';
  }

  @override
  String get paymentDayLabel => 'Dan plaćanja (mjesečni podsjetnik)';

  @override
  String get updateAvailable => 'Ažuriranje dostupno';

  @override
  String newVersionAvailable(String version) {
    return 'Nova verzija je dostupna: $version';
  }

  @override
  String currentVersionLabel(String version) {
    return 'Trenutna verzija: $version';
  }

  @override
  String get changes => 'Promjene:';

  @override
  String downloadProgress(String percent) {
    return 'Preuzimanje: $percent%';
  }

  @override
  String get installationStarting => 'Pokretanje instalacije...';

  @override
  String get appWillRestart => 'Aplikacija će se automatski ponovo pokrenuti.';

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
  String get later => 'Kasnije';

  @override
  String get updateNow => 'Ažuriraj sada';

  @override
  String get downloading => 'Preuzimanje...';

  @override
  String get downloadFailed =>
      'Preuzimanje nije uspjelo. Pokušajte ponovno kasnije.';

  @override
  String get searchingForUpdates => 'Traženje ažuriranja...';

  @override
  String get appUpToDate => 'Aplikacija je ažurna';

  @override
  String get updateCheckError => 'Greška pri provjeri ažuriranja';

  @override
  String get changelog => 'Evidencija promjena';

  @override
  String get terminConfirmed => 'Termin potvrđen';

  @override
  String get terminDeclined => 'Termin odbijen';

  @override
  String get terminRescheduleRequested => 'Zatražena odgoda';

  @override
  String get statusConfirmed => 'Potvrđeno';

  @override
  String get statusDeclined => 'Odbijeno';

  @override
  String get statusRescheduling => 'Odgoda';

  @override
  String get statusPending => 'Na čekanju';

  @override
  String get categoryVorstandssitzung => 'Sjednica uprave';

  @override
  String get categoryMitgliederversammlung => 'Skupština članova';

  @override
  String get categorySchulung => 'Obuka';

  @override
  String get categorySonstiges => 'Ostalo';

  @override
  String openCount(int count) {
    return '$count otvorenih';
  }

  @override
  String get refresh => 'Osvježi';

  @override
  String get filterUpcoming => 'Nadolazeći';

  @override
  String get filterPast => 'Prošli';

  @override
  String get filterAll => 'Svi';

  @override
  String get noUpcomingAppointments => 'Nema nadolazećih termina';

  @override
  String get noPastAppointments => 'Nema prošlih termina';

  @override
  String get noAppointmentsAvailable => 'Nema termina';

  @override
  String get appointmentsShownHere => 'Vaši termini bit će prikazani ovdje';

  @override
  String get dateLabel => 'Datum';

  @override
  String get timeLabel => 'Vrijeme';

  @override
  String get locationLabel => 'Mjesto';

  @override
  String get createdByLabel => 'Stvorio';

  @override
  String get descriptionLabel => 'Opis';

  @override
  String get ticketLabel => 'Zahtjev';

  @override
  String get yourStatus => 'Vaš status: ';

  @override
  String reasonLabel(String reason) {
    return 'Razlog: $reason';
  }

  @override
  String durationMinutes(int minutes) {
    return '$minutes min';
  }

  @override
  String get confirm => 'Potvrdi';

  @override
  String get decline => 'Odbij';

  @override
  String get reschedule => 'Odgodi';

  @override
  String get requestReschedule => 'Zatraži odgodu';

  @override
  String appointmentLabel(String title) {
    return 'Termin: $title';
  }

  @override
  String get rescheduleReason => 'Razlog odgode *';

  @override
  String get rescheduleReasonHint => 'Navedite razlog...';

  @override
  String get pleaseProvideReason => 'Navedite razlog';

  @override
  String get request => 'Zatraži';

  @override
  String get ticketStatusOpen => 'Otvoreno';

  @override
  String get ticketStatusInProgress => 'U obradi';

  @override
  String get ticketStatusWaitingMember => 'Čeka se član';

  @override
  String get ticketStatusWaitingStaff => 'Čeka se djelatnik';

  @override
  String get ticketStatusWaitingAuthority => 'Čeka se ustanova';

  @override
  String get ticketStatusDone => 'Završeno';

  @override
  String get ticketPriorityHigh => 'Visok';

  @override
  String get ticketPriorityMedium => 'Srednji';

  @override
  String get ticketPriorityLow => 'Nizak';

  @override
  String get comments => 'Komentari';

  @override
  String get documents => 'Dokumenti';

  @override
  String get details => 'Detalji';

  @override
  String get replySent => 'Odgovor poslan';

  @override
  String get sendError => 'Greška pri slanju';

  @override
  String get uploading => 'Učitavanje...';

  @override
  String fileUploaded(String filename) {
    return '$filename učitan';
  }

  @override
  String get uploadFailed => 'Učitavanje neuspješno';

  @override
  String get openError => 'Greška pri otvaranju';

  @override
  String get noRepliesYet => 'Još nema odgovora';

  @override
  String get waitingForSupport => 'Čeka se odgovor podrške';

  @override
  String get writeReply => 'Napišite odgovor...';

  @override
  String get attachFile => 'Priloži datoteku';

  @override
  String documentsCount(int count) {
    return 'Dokumenti ($count)';
  }

  @override
  String get upload => 'Učitaj';

  @override
  String get noDocuments => 'Nema dokumenata';

  @override
  String get allowedFormats => 'Dozvoljeni formati: PDF, JPEG, JPG, TXT, ZIP';

  @override
  String get yourMessage => 'Vaša poruka:';

  @override
  String get translation => 'Prijevod';

  @override
  String get original => 'Original';

  @override
  String get originalText => 'Izvorni tekst';

  @override
  String get autoTranslated => 'Automatski prevedeno';

  @override
  String get originalTapTranslation => 'Izvorni tekst · Dodirnite za prijevod';

  @override
  String get translatedTapOriginal => 'Prevedeno · Dodirnite za original';

  @override
  String get justNow => 'Upravo';

  @override
  String minutesAgo(int minutes) {
    return 'prije $minutes min';
  }

  @override
  String hoursAgo(int hours) {
    return 'prije $hours h';
  }

  @override
  String daysAgo(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'dana',
      one: 'dan',
    );
    return 'prije $days $_temp0';
  }

  @override
  String get createdLabel => 'Stvoreno';

  @override
  String get updatedLabel => 'Ažurirano';

  @override
  String get handlerLabel => 'Obrađivač';

  @override
  String get doneLabel => 'Završeno';

  @override
  String get newTicketTitle => 'Novi zahtjev';

  @override
  String get categoryOptional => 'Kategorija (neobvezno)';

  @override
  String get selectCategory => 'Odaberi';

  @override
  String get subjectLabel => 'Predmet';

  @override
  String get fillAllFields => 'Ispunite sva polja';

  @override
  String ticketCreatedId(int id) {
    return 'Zahtjev #$id stvoren';
  }

  @override
  String get priorityLabel => 'Prioritet: ';

  @override
  String get supportOffline => 'Podrška offline';

  @override
  String get lastSeenSeconds => 'Aktivan prije nekoliko sekundi';

  @override
  String lastSeenMinutes(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: 'minuta',
      one: 'minutu',
    );
    return 'Aktivan prije $minutes $_temp0';
  }

  @override
  String lastSeenHours(int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: 'sati',
      one: 'sat',
    );
    return 'Aktivan prije $hours $_temp0';
  }

  @override
  String lastSeenDays(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'dana',
      one: 'dan',
    );
    return 'Aktivan prije $days $_temp0';
  }

  @override
  String get online => 'Online';

  @override
  String get callSupport => 'Pozovi';

  @override
  String get typeMessage => 'Napišite poruku...';

  @override
  String get callBusy => 'Podrška je zauzeta';

  @override
  String get callRejected => 'Poziv je odbijen';

  @override
  String get callFailed => 'Poziv se nije mogao spojiti';

  @override
  String get callEnded => 'Poziv završen';

  @override
  String get callSupportBusy => 'Podrška je već u drugom pozivu';

  @override
  String get errorStartingChat => 'Greška pri pokretanju chata';

  @override
  String get errorStartingCall => 'Greška pri pokretanju poziva';

  @override
  String get errorConnecting => 'Greška pri spajanju';

  @override
  String get errorDownloading => 'Greška pri preuzimanju';

  @override
  String get errorUploading => 'Greška pri učitavanju';

  @override
  String get errorSending => 'Greška pri slanju';

  @override
  String get errorPickingPhotos => 'Greška pri odabiru fotografija';

  @override
  String get errorPickingFiles => 'Greška pri odabiru datoteka';

  @override
  String get errorTakingPhoto => 'Greška pri fotografiranju';

  @override
  String get fileNotLoaded => 'Datoteka se ne može učitati';

  @override
  String get attachmentIdMissing => 'Nedostaje ID priloga';

  @override
  String get camera => 'Kamera';

  @override
  String get gallery => 'Galerija';

  @override
  String get file => 'Datoteka';

  @override
  String get notifNewMessageFrom => 'Nova poruka od';

  @override
  String get notifUrgentPrefix => 'HITNO';

  @override
  String get notifUrgentMessage => 'HITNA PORUKA';

  @override
  String get notifIncomingCall => 'Dolazni poziv';

  @override
  String get notifCallingYou => 'zove...';

  @override
  String get notifUpdateAvailable => 'Ažuriranje dostupno';

  @override
  String get notifVersionAvailable => 'je sada dostupna';

  @override
  String get notifConnected => 'Povezano';

  @override
  String get notifDisconnected => 'Prekinuto';

  @override
  String get notifConnectedBody => 'Povezani ste s poslužiteljem.';

  @override
  String get notifDisconnectedBody => 'Veza s poslužiteljem je prekinuta.';

  @override
  String get notifError => 'Greška';

  @override
  String get retry => 'Pokušaj ponovno';

  @override
  String get save => 'Spremi';

  @override
  String get accept => 'Prihvati';

  @override
  String get selectFile => 'Odaberi datoteku';

  @override
  String get dataLoadingText => 'Učitavanje podataka...';

  @override
  String get dataSavedSuccess => 'Podaci uspješno spremljeni';

  @override
  String get errorSaving => 'Greška pri spremanju';

  @override
  String get errorLoading => 'Greška pri učitavanju';

  @override
  String savedFilename(String filename) {
    return 'Spremljeno: $filename';
  }

  @override
  String get logsCopied => 'Logovi kopirani!';

  @override
  String get passwordMinEightChars => 'Lozinka mora imati najmanje 8 znakova';

  @override
  String get passwordChangeSuccess => 'Lozinka uspješno promijenjena';

  @override
  String get emailChangeError => 'Greška pri promjeni e-maila';

  @override
  String get acceptDocumentCheckbox => 'Pročitao sam i prihvaćam dokument.';

  @override
  String loadingErrorGeneric(String details) {
    return 'Greška pri učitavanju: $details';
  }

  @override
  String get incomingCallTitle => 'Dolazni poziv';

  @override
  String ringingFor(int seconds) {
    return 'Zvoni ${seconds}s';
  }

  @override
  String get rejectCall => 'Odbij';

  @override
  String get acceptCall => 'Prihvati';

  @override
  String get unmute => 'Uključi zvuk';

  @override
  String get mute => 'Isključi zvuk';

  @override
  String get hangUp => 'Prekini';

  @override
  String get calling => 'Pozivanje...';

  @override
  String autoRejectIn(int seconds) {
    return 'Automatsko odbijanje za $seconds sekundi';
  }

  @override
  String get speakerOn => 'Zvučnik';

  @override
  String get speakerOff => 'Slušalica';

  @override
  String get micMuted => 'Isključen';

  @override
  String get micOn => 'Mikrofon';

  @override
  String get connectionExcellent => 'Izvrsno';

  @override
  String get connectionGood => 'Dobro';

  @override
  String get connectionWeak => 'Slabo';

  @override
  String get connectionLost => 'Prekinuto';

  @override
  String get personalData => 'Osobni podaci';

  @override
  String get personalDataSubtitle => 'Ime, prezime, adresa';

  @override
  String get membershipFee => 'Članarina';

  @override
  String annualFeeYear(String year) {
    return 'Godišnja članarina $year';
  }

  @override
  String get amount => 'Iznos:';

  @override
  String get dueBy => 'Rok:';

  @override
  String get paid => 'Plaćeno';

  @override
  String get versionHistory => 'Povijest verzija';

  @override
  String lastUpdated(String date) {
    return 'Zadnje ažuriranje: $date';
  }

  @override
  String get noVersionHistory => 'Nema dostupne povijesti';

  @override
  String get failedLoadChangelog => 'Učitavanje dnevnika nije uspjelo';

  @override
  String get callMember => 'Pozovi člana';

  @override
  String get closeConversation => 'Zatvori razgovor';

  @override
  String get chatOffline => 'Offline';

  @override
  String get attachFiles => 'Priloži datoteke (maks. 10, 50MB)';

  @override
  String get conversationClosed => 'Ovaj razgovor je zatvoren';

  @override
  String get noMessages => 'Nema poruka';

  @override
  String get goBack => 'Natrag';

  @override
  String get goForward => 'Naprijed';

  @override
  String get homePage => 'Početna';

  @override
  String get firstNameLabel => 'Ime';

  @override
  String get lastNameLabel => 'Prezime';

  @override
  String get streetLabel => 'Ulica';

  @override
  String get houseNumberLabel => 'Br.';

  @override
  String get postalCodeLabel => 'Poštanski broj';

  @override
  String get cityLabel => 'Grad';

  @override
  String get phoneMobileLabel => 'Telefon (Mobitel)';

  @override
  String get phoneLandlineLabel => 'Telefon (Fiksni)';

  @override
  String get newEmailLabel => 'Nova e-mail adresa';

  @override
  String get currentPasswordLabel => 'Trenutna lozinka';

  @override
  String get newPasswordLabel => 'Nova lozinka';

  @override
  String get confirmPasswordLabel => 'Potvrdi lozinku';

  @override
  String get emailChangedSuccess => 'E-mail uspješno promijenjen';

  @override
  String get reasonLabel2 => 'Razlog';

  @override
  String get downloadFailed2 => 'Preuzimanje neuspješno';

  @override
  String get downloadTooltip => 'Preuzmi';

  @override
  String get copyLogs => 'Kopiraj logove';

  @override
  String get deleteLogs => 'Obriši logove';

  @override
  String get autoScrollOn => 'Automatsko pomicanje UKLJ';

  @override
  String get autoScrollOff => 'Automatsko pomicanje ISKLJ';

  @override
  String get unknownValue => 'Nepoznato';

  @override
  String get payment => 'Plaćanje';

  @override
  String get warningType_ermahnung => 'Opomena';

  @override
  String get warningType_abmahnung => 'Upozorenje';

  @override
  String get warningType_letzte => 'Posljednje upozorenje';

  @override
  String warningsTotal(int count) {
    return 'Ukupno: $count';
  }

  @override
  String warningsErmahnung(int count) {
    return 'Opomene: $count';
  }

  @override
  String warningsAbmahnung(int count) {
    return 'Upozorenja: $count';
  }

  @override
  String warningsLetzte(int count) {
    return 'Posljednje: $count';
  }

  @override
  String get noWarnings => 'Nema opomena';

  @override
  String get noWarningsDescription => 'Trenutno nemate opomena.';

  @override
  String createdBy(String name) {
    return 'Kreirao: $name';
  }

  @override
  String get monthJan => 'Sij';

  @override
  String get monthFeb => 'Vel';

  @override
  String get monthMar => 'Ozu';

  @override
  String get monthApr => 'Tra';

  @override
  String get monthMay => 'Svi';

  @override
  String get monthJun => 'Lip';

  @override
  String get monthJul => 'Srp';

  @override
  String get monthAug => 'Kol';

  @override
  String get monthSep => 'Ruj';

  @override
  String get monthOct => 'Lis';

  @override
  String get monthNov => 'Stu';

  @override
  String get monthDec => 'Pro';

  @override
  String get stufe1_name => 'Osobni podaci';

  @override
  String get stufe2_name => 'Vrsta članstva';

  @override
  String get stufe3_name => 'Financijska situacija';

  @override
  String get stufe4_name => 'Način plaćanja';

  @override
  String get stufe5_name => 'Početak članstva';

  @override
  String get stufe6_name => 'Statut';

  @override
  String get stufe7_name => 'Pravila privatnosti';

  @override
  String get stufe8_name => 'Pravo na odustajanje';

  @override
  String get memberType_ordentlich => 'Redovni član';

  @override
  String get memberType_foerder => 'Podupirući član';

  @override
  String get memberType_ehren => 'Počasni član';

  @override
  String get memberDesc_ordentlich =>
      'Aktivni član s pravom glasa. Sudjeluje u uslugama udruge (email, oblak, birokratska podrška).';

  @override
  String get memberDesc_foerder =>
      'Podupire udrugu doprinosima. Može prisustvovati skupštini sa savjetodavnim glasom, bez prava glasa ili izbora u upravu.';

  @override
  String get memberDesc_ehren =>
      'Ima prava redovnog člana bez obveze plaćanja članarine. Imenovan od strane skupštine ili uprave.';

  @override
  String get payMethod_ueberweisung => 'Bankovni prijenos';

  @override
  String get payMethod_dauerauftrag => 'Trajni nalog';

  @override
  String get verifyStatus_geprueft => 'Provjereno';

  @override
  String get verifyStatus_ausgefuellt => 'Ispunjeno';

  @override
  String get verifyStatus_abgelehnt => 'Odbijeno';

  @override
  String get verifyStatus_offen => 'Otvoreno';

  @override
  String get fillRequiredFields => 'Ispunite sva obavezna polja.';

  @override
  String get personalDataSaved => 'Osobni podaci spremljeni';

  @override
  String get selectMemberType => 'Odaberite vrstu članstva.';

  @override
  String get memberTypeSaved => 'Vrsta članstva spremljena';

  @override
  String get selectOption => 'Odaberite opciju.';

  @override
  String get financialSaved => 'Financijska situacija spremljena';

  @override
  String get selectPaymentMethod => 'Odaberite način plaćanja.';

  @override
  String get paymentDataSaved => 'Podaci o plaćanju spremljeni';

  @override
  String get selectDate => 'Odaberite datum.';

  @override
  String get membershipStartSaved => 'Početak članstva spremljen';

  @override
  String get fileTooLarge => 'Datoteka prevelika (maks. 10 MB).';

  @override
  String get leistungsbescheidUploaded =>
      'Rješenje o naknadama uspješno učitano';

  @override
  String get verificationProgress => 'Napredak provjere';

  @override
  String get notApplicable => 'Nije primjenjivo';

  @override
  String get socialBenefitsExempt =>
      'Način plaćanja nije potreban za primatelje socijalnih naknada.';

  @override
  String get locked => 'Zaključano';

  @override
  String completePreviousStep(int step) {
    return 'Najprije dovršite korak $step.';
  }

  @override
  String rejectedNote(String note) {
    return 'Odbijeno: $note';
  }

  @override
  String get waitingForReview => 'Čeka pregled uprave.';

  @override
  String get stepApproved => 'Ovaj korak je pregledan i odobren.';

  @override
  String get changesViaChat => 'Promjene moguće samo putem chata.';

  @override
  String get firstNameRequired => 'Ime *';

  @override
  String get lastNameRequired => 'Prezime *';

  @override
  String get birthDateLabel => 'Datum rođenja *';

  @override
  String get streetRequired => 'Ulica *';

  @override
  String get houseNumberRequired => 'Br. *';

  @override
  String get cityRequired => 'Grad *';

  @override
  String get phoneRequired => 'Telefonski broj *';

  @override
  String get phonePurpose =>
      'Svrha: Kontakt kada niste dostupni putem aplikacije';

  @override
  String get selectMemberTypePrompt => 'Odaberite željenu vrstu članstva:';

  @override
  String get financialExplanation =>
      'Da bismo provjerili imate li pravo na smanjenje članarine, potrebne su nam sljedeće informacije. Koristit će se isključivo za određivanje vaše članarine.';

  @override
  String get socialBenefitsQuestion => 'Primate li trenutno socijalne naknade?';

  @override
  String get optionBuergergeld => 'Da, građanska naknada (Job Center)';

  @override
  String get optionSozialamt => 'Da, socijalna pomoć (Socijalna služba)';

  @override
  String get optionNoBenefits => 'Ne, ne primam socijalne naknade';

  @override
  String get feeExempt => 'Vaša mjesečna članarina je: 0,00 €/mjesec';

  @override
  String get uploadLeistungsbescheid => 'Učitaj rješenje o naknadama';

  @override
  String get uploadLeistungsbescheidHint =>
      'Učitajte aktualno rješenje o naknadama u roku od 14 dana za potvrdu oslobođenja od članarine.';

  @override
  String get allowedFormatsUpload =>
      'Dozvoljeni formati: PDF, JPG, PNG (maks. 10 MB)';

  @override
  String get feeRegular => 'Vaša mjesečna članarina je: 25,00 €/mjesec';

  @override
  String paymentDayReminder(int day) {
    return 'Bit ćete podsjećeni $day. dana svakog mjeseca.';
  }

  @override
  String get membershipStartPrompt =>
      'Odaberite kada treba započeti vaše članstvo.';

  @override
  String get optionAfterVerification => 'Nakon završetka provjere';

  @override
  String get optionAfterVerificationDesc =>
      'Članstvo počinje od dana potvrde uprave.';

  @override
  String get optionRetroFoundation =>
      'Retroaktivno do datuma osnivanja (01.08.2025)';

  @override
  String get optionRetroFoundationDesc =>
      'Postajete retroaktivni član od osnivanja udruge.';

  @override
  String get optionRetroCustom => 'Retroaktivno do drugog datuma';

  @override
  String get optionRetroCustomDesc =>
      'Odaberite datum između 01.08.2025. i danas.';

  @override
  String get selectDateLabel => 'Odaberite datum';

  @override
  String get selectDateHint => 'Odaberite datum...';

  @override
  String get dateNotBefore => 'Ne prije 01.08.2025. (datum osnivanja)';

  @override
  String get feeExemptRetro =>
      'Oslobođenje od članarine: 0,00 € retroaktivno.\nSamo datum članstva se postavlja retroaktivno.';

  @override
  String get retroactiveFees => 'Retroaktivne članarine';

  @override
  String retroFeeCalculation(
      String from, String to, String months, String total) {
    return 'Razdoblje: $from – $to\nMjeseci: $months\nČlanarina: $months × 25,00 € = $total €';
  }

  @override
  String get pleaseReadSatzung => 'Pročitajte statut udruge.';

  @override
  String get pleaseReadDatenschutz => 'Pročitajte pravila privatnosti.';

  @override
  String get pleaseReadWiderruf => 'Pročitajte pravo na odustajanje.';

  @override
  String get acceptedAtRegistration => 'Prihvaćeno pri registraciji';

  @override
  String get confirmedByBoard => 'Bit će potvrđeno nakon pregleda uprave.';

  @override
  String get docSatzung => 'Statut';

  @override
  String get docDatenschutz => 'Pravila privatnosti';

  @override
  String get docWiderruf => 'Pravo na odustajanje';

  @override
  String acceptedAtRegCount(int count) {
    return 'Prihvaćeno pri registraciji ($count/3)';
  }

  @override
  String acceptedOn(String date) {
    return 'Prihvaćeno dana $date';
  }

  @override
  String get notAccepted => 'Nije prihvaćeno';

  @override
  String get statusAccepted => 'Prihvaćeno';

  @override
  String get nameTooLong => 'Ime predugo (maks. 100 znakova)';

  @override
  String get emailTooLong => 'E-mail predug (maks. 255 znakova)';

  @override
  String get legalAcknowledgePrefix => 'Pročitao/la sam ';

  @override
  String get legalAcknowledgeSuffix => '.';

  @override
  String get legalStatutesSuffix =>
      ' ICD360S e.V. i priznajem ih kao obvezujuće.';

  @override
  String get legalPleaseReadFirst => '(molimo prvo pročitajte)';

  @override
  String get statusActive => 'Aktivan';

  @override
  String get statusSuspended => 'Suspendiran';

  @override
  String get statusNew => 'Novo';

  @override
  String get statusCancelled => 'Otkazano';

  @override
  String get statusDeleted => 'Obrisano';

  @override
  String get roleMitglied => 'Član';

  @override
  String get roleVorsitzer => 'Predsjednik';

  @override
  String get roleStellvertreter => 'Zamjenik';

  @override
  String get roleSchatzmeister => 'Blagajnik';

  @override
  String get roleSchriftfuehrer => 'Tajnik';

  @override
  String get roleBeisitzer => 'Prisjednik';

  @override
  String get roleKassierer => 'Blagajnik';

  @override
  String get roleKassenpruefer => 'Revizor';

  @override
  String get roleEhrenamtlich => 'Volonter';

  @override
  String get roleMitgliedergruender => 'Osnivač';

  @override
  String get roleEhrenmitglied => 'Počasni član';

  @override
  String get roleFoerdermitglied => 'Podupirući član';

  @override
  String get memberTypeNotSet => 'Još nije određeno';

  @override
  String get payMethodSepa => 'SEPA izravno terećenje';

  @override
  String get labelStatus => 'Status';

  @override
  String get labelMemberNumber => 'Članski broj';

  @override
  String get labelRole => 'Uloga';

  @override
  String get labelMemberType => 'Vrsta članstva';

  @override
  String get labelPaymentMethod => 'Način plaćanja';

  @override
  String get labelRegisteredOn => 'Registrirano';

  @override
  String get labelLastLogin => 'Zadnja prijava';

  @override
  String get labelMemberSince => 'Član od';

  @override
  String get neverLoggedIn => 'Nikada';

  @override
  String get notActivatedYet => 'Još nije aktivirano';

  @override
  String get tabVerification => 'Verifikacija';

  @override
  String get tabWarnings => 'Upozorenja';

  @override
  String get tabDocuments => 'Dokumenti';

  @override
  String get tabMembership => 'Članstvo';

  @override
  String get pleaseEnterFirstName => 'Unesite ime';

  @override
  String get pleaseEnterLastName => 'Unesite prezime';

  @override
  String get noFileDataReceived => 'Nisu primljeni podaci';

  @override
  String get openFile => 'Otvori';

  @override
  String get noMicrophoneError =>
      'Mikrofon nije pronađen. Priključite mikrofon i pokušajte ponovno.';

  @override
  String get startConversation => 'Započnite razgovor!';

  @override
  String get staffWillReply => 'Djelatnik će vam uskoro odgovoriti.';

  @override
  String get inCall => 'U pozivu...';

  @override
  String get registration => 'Registracija';

  @override
  String get deactivation => 'Deaktivacija';

  @override
  String get deactivatedOn => 'Deaktivirano';

  @override
  String get accountAutoSuspend =>
      'Računi koji nisu verificirani u roku od 30 dana bit će automatski suspendirani.';

  @override
  String get documentsProvidedByBoard => 'Dokumente osigurava uprava.';

  @override
  String get noDocumentsAvailable => 'Nema dokumenata';

  @override
  String get noDocumentsDescription => 'Još nisu dostavljeni dokumenti za vas.';

  @override
  String uploadedBy(String name) {
    return 'Učitao: $name';
  }

  @override
  String stepsCompleted(int completed, int total) {
    return '$completed/$total koraka završeno';
  }

  @override
  String dayOfMonth(int day) {
    return '$day. u mjesecu';
  }

  @override
  String changeField(String field) {
    return 'Promijeni $field';
  }

  @override
  String openDocument(String name) {
    return 'Otvori $name';
  }

  @override
  String logEntries(int count) {
    return '$count zapisa';
  }

  @override
  String get noLogs => 'Nema zapisa';

  @override
  String get newLoginDetected => 'Otkrivljena nova prijava';

  @override
  String get errorNoInternet =>
      'Nema internetske veze. Provjerite svoju mrežu.';

  @override
  String get errorTimeout =>
      'Poslužitelj ne odgovara. Pokušajte ponovo kasnije.';

  @override
  String get errorServer => 'Greška poslužitelja. Pokušajte ponovo kasnije.';

  @override
  String get errorConnection => 'Greška veze. Pokušajte ponovo kasnije.';

  @override
  String get errorUnexpected =>
      'Došlo je do neočekivane greške. Pokušajte ponovo kasnije.';

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
  String get claudiuWelcomeMorning => 'Dobro jutro';

  @override
  String get claudiuWelcomeDay => 'Dobar dan';

  @override
  String get claudiuWelcomeEvening => 'Dobra večer';

  @override
  String get claudiuWelcomeNight => 'Dobra večer';

  @override
  String get claudiuWelcomeVisitor => 'dragi posjetitelju';

  @override
  String get claudiuWelcomeAsk => 'Kako ti mogu pomoći?';

  @override
  String get claudiuWelcomeBecomeMember => 'Želim postati član';

  @override
  String get claudiuWelcomeLogin => 'Već sam član i želim se prijaviti';

  @override
  String get claudiuWelcomeProblem => 'Imam problem s aplikacijom';

  @override
  String get claudiuWelcomeEmergency => 'Hitno — nazovite nas';

  @override
  String get claudiuWelcomeMascotName => 'Claudiu';

  @override
  String get claudiuWelcomeEmergencyIntro =>
      'Prije nego nazoveš — naše radno vrijeme:';

  @override
  String get claudiuWelcomeScheduleOffice => 'U uredu';

  @override
  String get claudiuWelcomeScheduleField => 'Na terenu s klijentima';

  @override
  String get claudiuWelcomeOutsideHoursNote =>
      'Izvan ovog vremena rješavamo samo hitne slučajeve. Možeš nam i poslati SMS na isti broj — javit ćemo se.';

  @override
  String get claudiuWelcomeCallNow => 'Nazovi sada';

  @override
  String get claudiuWelcomeSendSms => 'Pošalji SMS';

  @override
  String get claudiuWelcomeSmsBody =>
      'Hitno ICD360S e.V. — molim kontaktirajte me što prije.';

  @override
  String get claudiuWelcomeCloseButton => 'Zatvori';

  @override
  String get claudiuLoginWelcome => 'Dobrodošao natrag, dragi člane!';

  @override
  String get claudiuLoginAsk => 'Reci mi svoj članski broj, molim.';

  @override
  String get claudiuLoginProgress => 'Skoro… nastavi tipkati.';

  @override
  String get claudiuLoginReady => 'Savršeno! Pritisni gumb ispod.';

  @override
  String get claudiuLoginLoading => 'Provjeravam identitet… 🔍';

  @override
  String get claudiuLoginFoundPlain => 'Pronašao sam te! Prijavljujem te…';

  @override
  String claudiuLoginFoundNamed(String name) {
    return 'Pronašao sam te, $name! Prijavljujem te…';
  }

  @override
  String get claudiuLoginError =>
      'Hm, ne mogu pronaći taj broj. Jesi li ga ispravno upisao?';

  @override
  String get claudiuLoginForgotHeader => 'Zaboravio si članski broj?';

  @override
  String get claudiuLoginNoSms => 'Broj ne šaljemo e-poštom ni SMS-om.';

  @override
  String get claudiuLoginOnlyWay =>
      'Jedini način: osobni susret u uredu udruge, nakon provjere osobne iskaznice.';

  @override
  String get claudiuLoginContactUs => 'Nazovi za dogovor termina:';

  @override
  String get claudiuDiagnosticGreeting => 'Prije nego uđeš, jedno brzo pitanje';

  @override
  String get claudiuDiagnosticAsk =>
      'Smijem li slati anonimne izvještaje kako bi developeri mogli poboljšati aplikaciju?';

  @override
  String get claudiuDiagnosticYes => 'Da, želim pomoći';

  @override
  String get claudiuDiagnosticNo => 'Ne, samo razgledavam';

  @override
  String get claudiuDiagnosticTellMore => 'Reci mi više';

  @override
  String get claudiuDiagnosticSendsHeader => '📤 Što ŠALJEMO (anonimno):';

  @override
  String get claudiuDiagnosticSends1 =>
      'Anonimni kod uređaja (NE članski broj)';

  @override
  String get claudiuDiagnosticSends2 => 'Tvoja uloga (član / uprava)';

  @override
  String get claudiuDiagnosticSends3 =>
      'Operacijski sustav (Linux / Android / iOS / Windows)';

  @override
  String get claudiuDiagnosticSends4 => 'Odabrani jezik';

  @override
  String get claudiuDiagnosticSends5 => 'Razina i stanje baterije';

  @override
  String get claudiuDiagnosticSends6 => 'Trenutni zaslon';

  @override
  String get claudiuDiagnosticSends7 => 'Trajanje sesije (sekunde)';

  @override
  String get claudiuDiagnosticSends8 => 'Greške ako ih ima (zadnjih 10)';

  @override
  String get claudiuDiagnosticSends9 => 'Navigacija (zadnjih 20 zaslona)';

  @override
  String get claudiuDiagnosticNeverHeader => '🛡️ Što NIKADA ne šaljemo:';

  @override
  String get claudiuDiagnosticNever1 => 'Tvoje pravo ime';

  @override
  String get claudiuDiagnosticNever2 => 'E-mail adresa';

  @override
  String get claudiuDiagnosticNever3 => 'Broj telefona';

  @override
  String get claudiuDiagnosticNever4 => 'Lozinka';

  @override
  String get claudiuDiagnosticNever5 => 'Sadržaj poruka chata';

  @override
  String get claudiuDiagnosticNever6 => 'Sadržaj tiketa';

  @override
  String get claudiuDiagnosticNever7 => 'Dokumenti ili privici';

  @override
  String get claudiuDiagnosticTechHeader => '📡 Tehnički detalji:';

  @override
  String get claudiuDiagnosticTech1 => 'Šalje se svake 2 minute';

  @override
  String get claudiuDiagnosticTech2 =>
      'TLS-šifrirana veza s prikvačenim certifikatom';

  @override
  String get claudiuDiagnosticTech3 =>
      'Možeš isključiti u bilo koje vrijeme u Postavkama';

  @override
  String get claudiuProblemHelpTitle => 'Kako mogu pomoći?';

  @override
  String get claudiuProblemHelpGreeting => 'Što se dogodilo?';

  @override
  String get claudiuProblemHelpAsk => 'Kako mi želiš ispričati?';

  @override
  String get claudiuProblemHelpWriteTitle => 'Napiši izvještaj';

  @override
  String get claudiuProblemHelpWriteBody =>
      'S detaljima korak po korak. Tim dobiva tekst i rješava ga kasnije.';

  @override
  String get claudiuProblemHelpChatTitle => 'Razgovarajmo sada';

  @override
  String get claudiuProblemHelpChatBody =>
      'Anonimni chat s operaterom. Odgovor u stvarnom vremenu ako je netko online.';

  @override
  String get claudiuProblemHelpAltCallHeader => 'Ili, ako je hitno:';

  @override
  String get claudiuProblemHelpAltCallLabel => 'Nazovi nas';

  @override
  String get claudiuAnonymousChatTitle => 'Anonimni chat';

  @override
  String get claudiuAnonymousChatGreeting => 'Bok!';

  @override
  String get claudiuAnonymousChatWelcome =>
      'Slušam te. Piši što god želiš — bez imena. Odgovaram čim sam unutra.';

  @override
  String get claudiuAnonymousChatHint => 'Napiši poruku…';

  @override
  String get claudiuAnonymousChatWaitingOperator =>
      'Čekamo da operater odgovori…';

  @override
  String get claudiuVorsitzerConnectedTitle => 'Bok!';

  @override
  String get claudiuVorsitzerConnectedBody =>
      'Hvala što si nam se javio — sada si u kontaktu s Vorsitzerom. Reci nam kako ti možemo pomoći oko prijave za članstvo.';

  @override
  String get claudiuVorsitzerConnectedSender => 'Vorsitzer';

  @override
  String get claudiuQuickReplyValidationTime => 'Koliko dugo traje provjera?';

  @override
  String get claudiuQuickReplyDocuments => 'Koji dokumenti su mi potrebni?';

  @override
  String get claudiuQuickReplyStepProblem => 'Zapeo sam na jednom koraku';

  @override
  String get claudiuQuickReplyHuman => 'Mogu li sada razgovarati s nekim?';

  @override
  String get claudiuAnonymousChatConnecting => 'Spajanje…';

  @override
  String get claudiuAnonymousChatConnectionFailed =>
      'Nije moguće otvoriti chat. Pokušaj ponovno ili nas nazovi.';

  @override
  String get claudiuAnonymousChatRetry => 'Pokušaj ponovno';

  @override
  String get claudiuAnonymousChatOnline => 'Spojen';

  @override
  String get claudiuAnonymousChatOffline => 'Ponovno spajanje…';

  @override
  String get claudiuAnonymousChatAdminTyping => 'Operater piše…';

  @override
  String get claudiuProblemReportTitle => 'Prijavi problem';

  @override
  String get claudiuProblemReportGreeting => 'Što se dogodilo?';

  @override
  String get claudiuProblemReportAsk =>
      'Reci mi detaljno i proslijedit ću izvještaj timu.';

  @override
  String get claudiuProblemReportIncludeHeader => 'Molim uključi:';

  @override
  String get claudiuProblemReportIncludeBullets1 =>
      'Što si radio kad se problem pojavio';

  @override
  String get claudiuProblemReportIncludeBullets2 =>
      'Bilo koja poruka greške koju si vidio';

  @override
  String get claudiuProblemReportIncludeBullets3 => 'Na kojem zaslonu si bio';

  @override
  String get claudiuProblemReportIncludeBullets4 =>
      'Aplikacija puca, zatvara se ili pokazuje prazan zaslon?';

  @override
  String get claudiuProblemReportIncludeBullets5 =>
      'Događa li se to svaki put ili samo jednom?';

  @override
  String get claudiuProblemReportDescriptionLabel => 'Tvoj opis';

  @override
  String get claudiuProblemReportDescriptionHint =>
      'Npr.: Kad otvorim chat zaslon dobijem poruku „Connection error\" i aplikacija prestane reagirati…';

  @override
  String claudiuProblemReportTooShort(int count) {
    return 'Malo više detalja, molim (najmanje $count znakova)';
  }

  @override
  String get claudiuProblemReportSubmit => 'Pošalji izvještaj';

  @override
  String get claudiuProblemReportSubmitting => 'Šaljem…';

  @override
  String get claudiuProblemReportSentTitle => 'Hvala!';

  @override
  String get claudiuProblemReportSentBody =>
      'Izvještaj je poslan. Naš tim će ga pregledati što prije.';

  @override
  String get claudiuProblemReportSentClose => 'Razumijem';

  @override
  String get claudiuProblemReportSendFailed =>
      'Izvještaj se ne može poslati. Nazovi nas za hitnu pomoć.';

  @override
  String get claudiuProblemReportAlt => 'Ili, ako je hitno:';

  @override
  String get claudiuProblemReportCallLabel => 'Nazovi nas';

  @override
  String claudiuApprovalGreeting(String name) {
    return 'Bok, $name! 👋';
  }

  @override
  String get claudiuApprovalGreetingNoName => 'Bok! 👋';

  @override
  String get claudiuApprovalGladToSeeYou => 'Drago mi je što si došao!';

  @override
  String get claudiuApprovalCheckingForSafety =>
      'Za tvoju sigurnost, Vorsitzer sada provjerava tvoj zahtjev za prijavu. 🛡️';

  @override
  String get claudiuApprovalMonthlyExplain =>
      '💡 Ovo radimo svakih 30 dana kako bismo bili sigurni da si stvarno ti. To je kao sigurnosna provjera — traje najviše 5 minuta.';

  @override
  String get claudiuApprovalSuccess =>
      'Gotovo! 🎉 Vorsitzer te prepoznao. Prijavljujem te…';

  @override
  String get claudiuApprovalDenied => 'Hm, Vorsitzer je odbio tvoj zahtjev. 😔';

  @override
  String get claudiuApprovalDeniedHelp =>
      'Ako misliš da je ovo greška, nazovi nas da to razjasnimo.';

  @override
  String get claudiuApprovalExpired =>
      'Prošlo je 5 minuta i Vorsitzer nije odgovorio.';

  @override
  String get claudiuApprovalExpiredHelp =>
      'Nazovi nas i možemo odobriti tvoj zahtjev odmah. 📞';

  @override
  String get claudiuApprovalCallUs => 'Nazovi nas';

  @override
  String get claudiuApprovalTryAgain => 'Pokušaj ponovno';

  @override
  String get claudiuApprovalCancel => 'Odustani';

  @override
  String get claudiuApprovalClose => 'Zatvori';

  @override
  String get wizardIntroBubble1 =>
      'Bok, posjetitelju! 👋 Hvala što se želiš pridružiti našoj obitelji.';

  @override
  String get wizardIntroBubble2 =>
      'Zovem se Claudiu. U proljeće 2025. imao sam jasnu viziju: stvoriti udrugu koja pomaže ljudima u potrebi — dobrovoljno, srcem, bez nepotrebne birokracije. ❤️';

  @override
  String get wizardIntroBubble3 =>
      'Počeo sam razgovarati s klijentima koje sam posjećivao. Ispričao sam im svoj san. I svatko je rekao: „Da, idemo!\" U srpnju 2025. nas šestero se sastalo — odlučni ljudi. Odlučili smo osnovati **ICD360S e.V.** u Neu-Ulmu. 📍';

  @override
  String get wizardIntroBubble4 =>
      '**1. kolovoza 2025.** udruga je službeno oživjela — u Registru udruga. Moj najljepši dar. 🎂';

  @override
  String get wizardIntroBubble5 =>
      'Što radimo? Pomažemo izbjeglicama, osobama s invaliditetom, ekonomski ugroženim, **djeci i mladima** — s administrativnim pitanjima, njemačkim jezikom, stanovanjem, kupovinom, socijalnim naknadama. Naš Vorstand većinom čine osobe s invaliditetom — tako odluke dolaze iz stvarnog životnog iskustva. 🤝';

  @override
  String get wizardIntroBubble6 =>
      'Sada je tvoj red. Hajde da te upišemo — traje oko 5 minuta. Idemo korak po korak, ne ostavljam te samog. ✨';

  @override
  String get wizardIntroStart => 'Krenimo';

  @override
  String get wizardBack => 'Natrag';

  @override
  String get wizardNext => 'Dalje';

  @override
  String wizardStepLabel(int step, int total, String title) {
    return 'Korak $step od $total · $title';
  }

  @override
  String get wizardErrRequired => 'Ovo polje je obavezno';

  @override
  String wizardErrTooShort(int count) {
    return 'Prekratko (najmanje $count znakova)';
  }

  @override
  String get wizardErrOnlyLetters => 'Samo slova, razmaci, crtice i apostrofi';

  @override
  String get wizardErrSaveFailed =>
      'Spremanje nije uspjelo. Provjeri vezu i pokušaj ponovno.';

  @override
  String get wizardStufe1aTitle => 'Identitet';

  @override
  String get wizardStufe1aPrompt =>
      'Hajde da se službeno upoznamo. Napiši ime točno kako stoji na Personalausweisu, Reisepassu ili Aufenthaltstitelu — da odgovara dokumentima.';

  @override
  String get wizardStufe1aVornameLabel => 'Vornamen (imena)';

  @override
  String get wizardStufe1aVornameHelper =>
      'Sva tvoja imena točno kao na dokumentu. S razmakom ili crticom (npr. Hans-Peter, Maria Anna).';

  @override
  String get wizardStufe1aNachnameLabel => 'Familienname (prezime)';

  @override
  String get wizardStufe1aNachnameHelper => 'Tvoje trenutno prezime.';

  @override
  String get wizardStufe1aGeburtsnameLabel =>
      'Geburtsname (djevojačko prezime) — neobavezno';

  @override
  String get wizardStufe1aGeburtsnameHelper =>
      'Samo ako se razlikuje od Familienname — npr. prije braka.';

  @override
  String get wizardStufe1bTitle => 'Rođendan';

  @override
  String get wizardStufe1bPrompt =>
      'Voljeli bismo proslaviti tvoj rođendan s tobom! 🎂 I pomaže nam potvrditi da imaš najmanje 16 — to kaže naš statut.';

  @override
  String get wizardStufe1bGeburtsdatumLabel => 'Datum rođenja';

  @override
  String get wizardStufe1bGeburtsdatumHelper => 'Dodirni za odabir datuma';

  @override
  String get wizardStufe1bGeburtsortLabel => 'Mjesto rođenja';

  @override
  String get wizardStufe1bGeburtsortHelper => 'Grad / mjesto gdje si rođen.';

  @override
  String get wizardAgeGatePrompt => 'Žao mi je… 😔';

  @override
  String wizardAgeGateBody1(int age, int years) {
    return 'Naš statut kaže da moraš imati najmanje 16 godina da bi bio član. Imaš $age — nadam se da ćemo se vidjeti za $years godina! 🌱';
  }

  @override
  String get wizardAgeGateBody2 =>
      'Ako želiš povremeno volontirati (bilo koja dob, uz pristanak roditelja), nazovi nas — rado podržavamo mlade koji žele promijeniti svijet.';

  @override
  String get wizardAgeGateBackHome => 'Natrag na dobrodošlicu';

  @override
  String get wizardErrInvalidPhone => 'Nevažeći broj telefona';

  @override
  String get wizardStufe1b1Title => 'Roditeljska suglasnost';

  @override
  String get wizardStufe1b1Prompt =>
      'Maloljetan si (16-17) — prema §106 BGB-a treba nam suglasnost roditelja ili zakonskog skrbnika. Reci mi ime i broj telefona. Vorsitzer će nazvati i dogovoriti susret (osobno ili videopozivom). Bez e-maila — želimo biti sigurni da razgovaramo s pravom osobom.';

  @override
  String get wizardStufe1b1VornameLabel => 'Ime roditelja';

  @override
  String get wizardStufe1b1VornameHelper =>
      'Kao na Personalausweisu roditelja.';

  @override
  String get wizardStufe1b1NachnameLabel => 'Prezime roditelja';

  @override
  String get wizardStufe1b1NachnameHelper =>
      'Kao na Personalausweisu roditelja.';

  @override
  String get wizardStufe1b1TelefonLabel => 'Mobitel roditelja';

  @override
  String get wizardStufe1b1TelefonHelper =>
      'Vorsitzer će nazvati na ovaj broj.';

  @override
  String get wizardStufe1b1RelationLabel => 'Odnos prema djetetu:';

  @override
  String get wizardStufe1b1RelationMutter => 'Majka';

  @override
  String get wizardStufe1b1RelationVater => 'Otac';

  @override
  String get wizardStufe1b1RelationSorgeberechtigter => 'Zakonski skrbnik';

  @override
  String get wizardStufe1b1RelationAndere => 'Drugi skrbnik';

  @override
  String get wizardStufe1cTitle => 'Osobni podaci';

  @override
  String get wizardStufe1cPrompt =>
      'Samo da te malo bolje upoznam. Ovo ostaje između nas i nije nigdje javno prikazano.';

  @override
  String get wizardStufe1cGeschlechtLabel => 'Spol';

  @override
  String get wizardStufe1cGeschlechtMaennlich => 'Muški';

  @override
  String get wizardStufe1cGeschlechtWeiblich => 'Ženski';

  @override
  String get wizardStufe1cGeschlechtDivers => 'Različito';

  @override
  String get wizardStufe1cGeschlechtKeineAngabe => 'Ne želim odgovoriti';

  @override
  String get wizardStufe1cFamilienstandLabel => 'Bračno stanje';

  @override
  String get wizardStufe1cFamilienstandLedig => 'Neoženjen / Neudata';

  @override
  String get wizardStufe1cFamilienstandVerheiratet => 'Oženjen / Udata';

  @override
  String get wizardStufe1cFamilienstandGeschieden => 'Razveden/a';

  @override
  String get wizardStufe1cFamilienstandVerwitwet => 'Udovac/Udovica';

  @override
  String get wizardStufe1dTitle => 'Tvoje podrijetlo';

  @override
  String get wizardStufe1dPrompt =>
      'To nam pomaže ponuditi ti pravu podršku — na primjer savjet o Aufenthaltu ili pronalazak tvoje jezične zajednice.';

  @override
  String get wizardStufe1dStaatLabel => 'Državljanstvo';

  @override
  String get wizardStufe1dStaatHelper =>
      'Npr. deutsch, rumänisch, ukrainisch. Više odvojiti zarezom.';

  @override
  String get wizardStufe1dAufenthaltLabel =>
      'Boravišni status (Aufenthaltsstatus) — neobavezno';

  @override
  String get wizardStufe1dAufenthaltHelper =>
      'Odaberi titulu iz svoje Aufenthaltskarte / odluke. Vorstand to provjerava s tvojim dokumentima.';

  @override
  String get wizardStufe1dAufenthaltAwaitingCitizenship =>
      'Prvo gore unesi državljanstvo — pokazat ćemo samo odgovarajuće opcije.';

  @override
  String get wizardStufe1dAufenthaltGerman =>
      'Aufenthaltstitel nije potreban — njemački državljanin.';

  @override
  String get wizardStufe1dAufenthaltEuEea =>
      'Državljanin EU/EGP/CH — slobodno kretanje (Freizügigkeit).';

  @override
  String get wizardStufe1dAufenthaltTempHint => 'privremeni';

  @override
  String get wizardStufe1dAufenthaltPermHint => 'trajni boravak';

  @override
  String get wizardStufe1dAufenthaltAsylumProcessHint => 'postupak azila';

  @override
  String get wizardStufe1dAufenthaltOther => 'Drugo (navedi u chatu)';

  @override
  String get wizardStufe1dAufenthaltRequired =>
      'Molim odaberi Aufenthaltstitel.';

  @override
  String get wizardStufe1dMutterspracheLabel => 'Materinski jezik';

  @override
  String get wizardStufe1dMutterspracheHelper =>
      'Unaprijed ispunjeno jezikom aplikacije — promijeni ako je drugačije.';

  @override
  String get wizardStufe1eTitle => 'Adresa';

  @override
  String get wizardStufe1ePrompt =>
      'Tvoja poštanska adresa — koristimo je za službene dokumente (statut, članske ugovore, obavijesti).';

  @override
  String get wizardStufe1eStrasseLabel => 'Ulica';

  @override
  String get wizardStufe1eStrasseHelper =>
      'Samo naziv ulice — broj u susjedno polje.';

  @override
  String get wizardStufe1eHausnummerLabel => 'Br.';

  @override
  String get wizardStufe1ePlzLabel => 'PLZ (poštanski br.)';

  @override
  String get wizardStufe1eOrtLabel => 'Grad';

  @override
  String get wizardStufe1eLandLabel => 'Država';

  @override
  String get wizardStufe1eLandHelper => 'Unaprijed ispunjeno: Deutschland.';

  @override
  String get wizardErrInvalidStreet => 'Nevažeći naziv ulice';

  @override
  String get wizardErrInvalidHausnummer => 'Nevažeći broj (npr. 12, 12a, 12/3)';

  @override
  String get wizardErrInvalidPlz => 'Nevažeći poštanski broj (samo znamenke)';

  @override
  String get wizardStufe1fTitle => 'Kontakt';

  @override
  String get wizardStufe1fPrompt =>
      'Kako te kontaktirati? Telefon je samo za hitne slučajeve — sve ostalo ide preko našeg vlastitog end-to-end kriptiranog kanala u aplikaciji. Tvoja članska e-pošta dodjeljuje se automatski i prikazana je u nastavku.';

  @override
  String get wizardStufe1fTelefonLabel => 'Mobitel';

  @override
  String get wizardStufe1fTelefonHelper =>
      'Obećavam, nazvat ću samo ako je važno. 📱';

  @override
  String get wizardStufe2Title => 'Vrsta članstva';

  @override
  String get wizardStufe2Prompt =>
      'Kakav član želiš biti? Daj da ti objasnim svaku opciju.';

  @override
  String get wizardStufe2OrdentlichTitle => 'Redovni član (ordentlich)';

  @override
  String get wizardStufe2OrdentlichBody =>
      'Sva prava. Plaćaš mjesečnu članarinu, glasaš u skupštini, možeš biti izabran u upravu. Standardni izbor.';

  @override
  String get wizardStufe2FoerderTitle => 'Podupirući član (Fördermitglied)';

  @override
  String get wizardStufe2FoerderBody =>
      'Podržavaš udrugu financijski, ali ne sudjeluješ aktivno u odlukama. Bez prava glasa. Dobro ako želiš pomagati izdaleka.';

  @override
  String get wizardStufe2EhrenTitle => 'Počasni član (Ehrenmitglied)';

  @override
  String get wizardStufe2EhrenBody =>
      'Dodjeljuje uprava za posebne zasluge. Ne biraš ga sam — dodjeljuje se kao priznanje. Odaberi samo ako si već počašćen.';

  @override
  String get wizardStufe3Title => 'Financijska situacija';

  @override
  String get wizardStufe3Prompt =>
      'Sada o tvojoj financijskoj situaciji. Ne da te osuđujem — već da te oslobodimo članarine ako primaš socijalne naknade.';

  @override
  String get wizardStufe3OptionBuergergeld => 'Primam Bürgergeld';

  @override
  String get wizardStufe3OptionSozialamt => 'Primam pomoć od Sozialamta';

  @override
  String get wizardStufe3OptionNein => 'Ne primam ništa od navedenog';

  @override
  String get wizardStufe3FeeExemptTitle => 'Članarina: 0 € / mjesec 🎉';

  @override
  String get wizardStufe3FeeExemptBody =>
      'S Bürgergeldom, Sozialamtom, ALG I ili Krankengeldom potpuno si oslobođen članarine prema Satzungu §6. Trebamo samo dokaz (Leistungsbescheid ili potvrdu nadležnog tijela / zdravstvenog osiguranja).';

  @override
  String get wizardStufe3UploadTitle => 'Učitaj Leistungsbescheid';

  @override
  String get wizardStufe3UploadHint => 'PDF / JPG / PNG, najviše 10 MB.';

  @override
  String get wizardStufe3UploadRequired =>
      'Molim učitaj Leistungsbescheid prije nego nastaviš.';

  @override
  String get wizardStufe3FileTooLarge =>
      'Datoteka je prevelika. Najviše 10 MB.';

  @override
  String get wizardStufe3UploadFailed =>
      'Datoteku nije bilo moguće učitati. Pokušaj ponovno.';

  @override
  String get wizardStufe3RegularFeeTitle => 'Članarina: 25 € / mjesec';

  @override
  String get wizardStufe3RegularFeeBody =>
      'Standardna članarina za redovne članove prema statutu.';

  @override
  String get wizardStufe4Title => 'Plaćanje';

  @override
  String get wizardStufe4Prompt =>
      'Kako želiš plaćati članarinu? I koji dan u mjesecu preferiraš?';

  @override
  String get wizardStufe4MethodUeberweisungTitle =>
      'Bankovni prijenos (Überweisung)';

  @override
  String get wizardStufe4MethodUeberweisungBody =>
      'Plaćanje pokrećeš sam svaki mjesec sa svog računa.';

  @override
  String get wizardStufe4MethodSepaTitle =>
      'SEPA-Lastschrift (izravno terećenje)';

  @override
  String get wizardStufe4MethodSepaBody =>
      'Iznos automatski povlačimo s tvog računa. Najpraktičnije, ali trebamo IBAN i potpisani SEPA mandat.';

  @override
  String get wizardStufe4MethodDauerauftragTitle =>
      'Dauerauftrag (trajni nalog)';

  @override
  String get wizardStufe4MethodDauerauftragBody =>
      'Postaviš trajni nalog u svojoj banci. Banka automatski prenosi iznos svaki mjesec.';

  @override
  String get wizardStufe4DayLabel => 'Dan plaćanja';

  @override
  String get wizardStufe4DayHint => 'Odaberi dan između 1 i 31';

  @override
  String wizardStufe4DayItem(int day) {
    return '$day. dan';
  }

  @override
  String wizardStufe4DayReminder(int day) {
    return 'Članarina će biti naplaćena $day. u svakom mjesecu.';
  }

  @override
  String get wizardStufe5Title => 'Početak';

  @override
  String get wizardStufe5Prompt =>
      'Otkad želiš biti službeno član ICD360S-a? Od odobrenja ili retroaktivno.';

  @override
  String get wizardStufe5OptionAbVerifizierungTitle => 'Od odobrenja uprave';

  @override
  String get wizardStufe5OptionAbVerifizierungBody =>
      'Najjednostavniji izbor. Bez retroaktivne članarine.';

  @override
  String get wizardStufe5OptionGruendungsdatumTitle =>
      'Retroaktivno od 01.08.2025. (osnivanje)';

  @override
  String get wizardStufe5OptionGruendungsdatumBody =>
      'Računat ćeš se kao član od prvog dana udruge.';

  @override
  String get wizardStufe5OptionAnderesDatumTitle => 'Drugi datum';

  @override
  String get wizardStufe5OptionAnderesDatumBody =>
      'Sam biraš datum između 01.08.2025. i danas.';

  @override
  String get wizardStufe5PickDate => 'Dodirni za odabir datuma';

  @override
  String get wizardStufe5PickDateFirst => 'Molim prvo odaberi datum.';

  @override
  String get wizardStufe5DatePickerHelp => 'Početak članstva';

  @override
  String wizardStufe5DateRange(String start) {
    return 'Između $start i danas';
  }

  @override
  String get wizardStufe5RetroactiveTitle => 'Retroaktivna članarina';

  @override
  String wizardStufe5RetroactiveBody(
      String start, String end, int months, String amount) {
    return 'Od $start do $end to je $months mjeseci. Po 25 €/mjesec to iznosi $amount € za platiti retroaktivno, povrh trenutne mjesečne članarine.';
  }

  @override
  String get wizardStufe5FeeExemptTitle => 'Retroaktivna članarina: 0 € 🎉';

  @override
  String get wizardStufe5FeeExemptBody =>
      'S Bürgergeldom ili Sozialamtom potpuno si oslobođen — ni retroaktivno ne duguješ ništa.';

  @override
  String wizardDocumentPrompt(String doc) {
    return 'Prije nego završimo, molim pažljivo pročitaj $doc. Važno je znati što potpisuješ.';
  }

  @override
  String get wizardDocumentScrollHint => 'Pomakni do dna za nastavak.';

  @override
  String get wizardDocumentScrolledOk => 'Pročitao si do kraja ✓';

  @override
  String wizardDocumentOpenButton(String doc) {
    return 'Otvori $doc u pregledniku';
  }

  @override
  String get wizardDocumentExternalHint =>
      'Na ovoj platformi otvaramo dokument u tvojem zadanom pregledniku.';

  @override
  String get wizardDocumentOpenedOk =>
      'Dokument je otvoren. Molim pažljivo ga pročitaj.';

  @override
  String wizardDocumentConfirm(String doc) {
    return 'Potvrđujem da sam pročitao(la) i slažem se s $doc.';
  }

  @override
  String get wizardFinalAdultTitle => 'Gotovo! Upisan si 🎉';

  @override
  String get wizardFinalMinorTitle => 'Tvoj zahtjev je poslan 📨';

  @override
  String get wizardFinalMinorBody =>
      'Kontaktirat ćemo tvog roditelja i dogovoriti susret (osobno ili videopozivom). Molim te budi strpljiv — proces može trajati do 7 dana. Dobit ćeš obavijest u aplikaciji čim roditelj odobri.';

  @override
  String get wizardFinalMitgliedernummerLabel => 'Tvoj članski broj';

  @override
  String get wizardStufe4MethodComingSoon => 'Uskoro';

  @override
  String get wizardStufe4StreichungWarning =>
      'Ako kasniš s članarinom više od 6 mjeseci, automatski ćemo te brisati (Satzung §6 Abs. 3).';

  @override
  String get wizardStufe5KuendigungInfo =>
      'Za istup: pošalji nam pisanu obavijest 3 mjeseca prije 31. prosinca (najkasnije do 30. rujna kako bi proizvelo učinak na kraju godine). Nema minimalnog trajanja (Satzung §6 Abs. 3).';

  @override
  String get wizardStufe1fEmailLabel => 'Tvoja članska e-pošta';

  @override
  String get wizardStufe1fEmailHelper =>
      'Dodjeljuje se automatski iz tvog članskog broja. Aktivira se u trenutku kada upravni odbor (Vorstand) potvrdi tvoju prijavu. Imamo vlastitu aplikaciju za e-poštu — šalji i primaj kriptirane e-mailove, jednostavno i besplatno.';

  @override
  String get wizardErrInvalidEmail => 'Nevažeća e-mail adresa';

  @override
  String get wizardStufe3OptionAlg1 =>
      'Primam Arbeitslosengeld I (ALG I, naknada za nezaposlene)';

  @override
  String get wizardStufe3OptionKrankengeld =>
      'Primam Krankengeld (naknada za dugotrajnu bolest)';

  @override
  String get wizardStufe3UploadAddMore => 'Dodaj još dokumenata';

  @override
  String get wizardStufe3UploadLimitCount =>
      'Dosegao si granicu: najviše 20 dokumenata.';

  @override
  String get wizardStufe3UploadLimitTotal =>
      'Dosegao si ukupnu granicu od 100 MB. Obriši postojeću datoteku.';

  @override
  String get wizardStufe3UploadDeleteTooltip => 'Obriši';

  @override
  String wizardStufe3UploadCounter(int count, int max) {
    return '$count / $max dokumenata';
  }

  @override
  String get wizardDocumentExternalOpenFailed =>
      'Nisam mogao otvoriti preglednik. Link je u međuspremniku — zalijepi ga u preglednik za nastavak.';

  @override
  String get wizardFinalTimelineProcessing =>
      'Vorstand provjerava · obično 1 radni dan, do 7';

  @override
  String get wizardFinalTimelineActivated => 'Račun aktiviran';

  @override
  String get wizardFinalAdultThank =>
      'Hvala što si ispunio obrazac za registraciju! 🎉';

  @override
  String get wizardFinalAdultUsual =>
      'Tvoj zahtjev je kod nas. Obično ga potvrdimo u roku od jednog radnog dana.';

  @override
  String get wizardFinalAdultExceptional =>
      'Ponekad može potrajati do 7 radnih dana. A ako se nešto ne poklapa, vraćamo te na obrazac da to ispraviš 🙂';

  @override
  String get wizardFinalStatusTitle => 'STATUS ZAHTJEVA';

  @override
  String wizardFinalStatusStepsValidated(int reviewed, int total) {
    return '$reviewed/$total koraka potvrdio Vorstand';
  }

  @override
  String get wizardFinalStufeSheetTitle => 'Detalji zahtjeva';

  @override
  String get wizardFinalStufeSheetHint =>
      '8 faza koje si ispunio. Vorstand ih provjerava jednu po jednu — vidiš u stvarnom vremenu što je potvrđeno.';

  @override
  String get wizardFinalStufeStatusPending => 'Čeka pregled';

  @override
  String get wizardFinalStufeStatusApproved => 'Odobreno';

  @override
  String get wizardFinalStufeStatusRejected => 'Odbijeno';

  @override
  String wizardFinalStatusRejectionCount(int count) {
    return '$count korak treba ispravak';
  }

  @override
  String get wizardFinalStufeRejectionReason => 'Razlog Vorstanda:';

  @override
  String get wizardFinalStufeCorrectNow => 'Ispravi sada';

  @override
  String wizardFinalApprovalsHeader(int current, int total) {
    return 'Odobrenja Vorstanda ($current/$total)';
  }

  @override
  String get wizardFinalApprovalAwaiting => 'Čeka se 2. Vorstand';

  @override
  String get wizardFinalApprovalRejected => 'ODBIJENO';

  @override
  String get wizardFinalStufeNoDataYet => 'Podaci još nisu dostupni.';

  @override
  String get wizardFinalStufeReadAt => 'Pročitano:';

  @override
  String get wizardFinalStufeBeitragsfrei =>
      'Oslobođeno članarine (bez plaćanja)';

  @override
  String get wizardFinalStufeNotExempt => 'Bez socijalnih pomoći';

  @override
  String get wizardFinalStufeBeginAtVerification => 'Počinje pri verifikaciji';

  @override
  String get wizardFinalStufeBeginAtFoundation =>
      'Datum osnivanja (retroaktivno)';

  @override
  String get wizardFinalStufeBeginAtCustom => 'Drugi datum';

  @override
  String get wizardFinalStufeStatusSkipped => 'Preskočeno';

  @override
  String get wizardFinalStufeFilledAt => 'Ispunjeno:';

  @override
  String get wizardFinalStufeReviewedAt => 'Pregledano:';

  @override
  String get wizardFinalWithdrawLink => 'Povuci zahtjev';

  @override
  String get wizardFinalWithdrawDialogTitle => 'Povući zahtjev?';

  @override
  String get wizardFinalWithdrawDialogBody =>
      'Tvoj zahtjev bit će označen kao povučen od strane tebe. Podaci ostaju u bazi radi revizije (GDPR), ali račun neće biti aktiviran. Registraciju možeš pokrenuti ponovno bilo kada s novim brojem člana.';

  @override
  String get wizardFinalWithdrawKeep => 'Ne, čekat ću';

  @override
  String get wizardFinalWithdrawConfirm => 'Da, povuci';

  @override
  String get wizardErrTooManyWithdrawals =>
      'Tvoj zahtjev ne može se obraditi automatski. Nazovi nas ili dođi osobno u Vorstand kako bi nastavio registraciju.';

  @override
  String get wizardDuplicateLoginTitle => 'Čini se da si već naš član';

  @override
  String get wizardDuplicateLoginBody =>
      'S tvojim imenom i datumom rođenja već nalazimo aktivan račun. Molimo, koristi \"Već sam član\" na početnom zaslonu da se prijaviš. Ako više nemaš pristup, nazovi nas.';

  @override
  String get wizardDuplicatePendingTitle => 'Tvoj zahtjev je već kod nas';

  @override
  String get wizardDuplicatePendingBody =>
      'S tvojim imenom i datumom rođenja već imamo zahtjev u razmatranju. Vorstand radi na njemu — javit ćemo ti obavijest u aplikaciji čim tvoj račun bude aktivan. Nazovi ako želiš razgovarati.';

  @override
  String get wizardDuplicateRecentlyWithdrawnTitle =>
      'Sada ne možemo obraditi ovaj zahtjev';

  @override
  String get wizardDuplicateRecentlyWithdrawnBody =>
      'Tvoje ime i datum rođenja podudaraju se s nedavno povučenim zahtjevom. Molimo nazovi nas kako bi razgovarao s Vorstandom prije nego što nastaviš.';

  @override
  String get wizardDuplicatePreviouslyWithdrawnTitle =>
      'Već si nekad podnio zahtjev';

  @override
  String get wizardDuplicatePreviouslyWithdrawnBody =>
      'Tvoje ime i datum rođenja podudaraju se sa starijim zahtjevom koji si bio povukao. Dobrodošao natrag — nazovi nas prije nego nastaviš, kako bi Vorstand odlučio kako dalje.';

  @override
  String get wizardDuplicateCallUsTitle => 'Molimo, nazovi nas';

  @override
  String get wizardDuplicateCallUsBody =>
      'Tvoje ime i datum rođenja već se nalaze kod nas, ali pojedinosti ne možemo dijeliti kroz aplikaciju. Nazovi nas — Vorstand će ti objasniti situaciju izravno.';

  @override
  String get wizardChatHelp => 'Razgovarajmo';

  @override
  String get wizardChatHelpSubtitle => 'Chat uživo s Vorstandom · brz odgovor';

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
  String get signaturTitel => 'Potpisi';

  @override
  String get signaturNichtsOffen => 'Trenutačno nema ništa za potpisivanje.';

  @override
  String get signaturStatusOffen => 'Čeka Vaš potpis';

  @override
  String get signaturStatusSigniert => 'Potpisali ste dokument';

  @override
  String get signaturStatusAbgelehnt => 'Odbili ste dokument';

  @override
  String get signaturStatusWiderrufen => 'Udruga je povukla dokument';

  @override
  String get signaturStatusAbgelaufen => 'Rok je istekao';

  @override
  String signaturBitteGanzLesen(int gelesen, int gesamt) {
    return 'Molimo pročitajte dokument do kraja (stranica $gelesen od $gesamt).';
  }

  @override
  String get signaturWeiterZurUnterschrift => 'Dalje na potpis';

  @override
  String get signaturAblehnen => 'Odbijte';

  @override
  String get signaturAblehnenHinweis =>
      'Udruga će o tome biti obaviještena. Možete navesti svoje razloge.';

  @override
  String get signaturAblehnenGrund => 'Razlog (nije obvezno)';

  @override
  String get signaturMitFingerHinweis => 'Potpišite se prstom u bijelom polju.';

  @override
  String get signaturNochmal => 'Ispočetka';

  @override
  String get signaturZurueckZumDokument => 'Natrag na dokument';

  @override
  String get signaturCodeAnfordern => 'Zatražite kod SMS-om';

  @override
  String get signaturCodeUnterwegs => 'Kod je na putu.';

  @override
  String signaturCodeGesendetAn(String nummer) {
    return 'Poslali smo Vam kod na broj $nummer.';
  }

  @override
  String get signaturCodeErneutSenden => 'Ponovno pošaljite kod';

  @override
  String get signaturJetztUnterschreiben => 'Potpišite sada';

  @override
  String get signaturCodeFalsch => 'Kod nije točan.';

  @override
  String get signaturCodeAbgelaufen => 'Kod je istekao. Molimo zatražite novi.';

  @override
  String get signaturZuVieleVersuche =>
      'Previše neuspjelih pokušaja. Molimo zatražite novi kod.';

  @override
  String get signaturKeineRufnummer =>
      'Za Vaš korisnički račun nije upisan broj mobitela. Bez njega Vam ne možemo poslati kod — molimo obratite se predsjedniku udruge.';

  @override
  String get signaturCodeFehlgeschlagen => 'Slanje koda nije uspjelo.';

  @override
  String get signaturLeer => 'Molimo, najprije se potpišite.';

  @override
  String get signaturErfolg => 'Hvala — primili smo Vaš potpis.';

  @override
  String get signaturFehlgeschlagen =>
      'To nije uspjelo. Molimo pokušajte ponovno.';

  @override
  String get signaturSiegelInArbeit =>
      'Pečat se još izrađuje. Molimo pokušajte ponovno za jednu minutu.';
}
