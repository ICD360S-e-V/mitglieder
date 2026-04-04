// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Croatian (`hr`).
class AppLocalizationsHr extends AppLocalizations {
  AppLocalizationsHr([String locale = 'hr']) : super(locale);

  @override
  String get appTitle => 'ICD360S e.V - Portal članova';

  @override
  String get memberPortal => 'Portal članova';

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
  String get password => 'Lozinka';

  @override
  String get passwordHint => 'Unesite lozinku';

  @override
  String get confirmPassword => 'Potvrdite lozinku';

  @override
  String get confirmPasswordHint => 'Potvrdite lozinku';

  @override
  String get newPassword => 'Nova lozinka';

  @override
  String get newPasswordHint => 'Unesite novu lozinku';

  @override
  String get saveCredentials => 'Spremi podatke za prijavu';

  @override
  String get autoLogin => 'Automatska prijava';

  @override
  String get forgotPassword => 'Zaboravljena lozinka?';

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
  String get recoveryCode => 'Kod za oporavak (6 znamenki)';

  @override
  String get recoveryCodeHelper => 'Zapamtite ovaj kod za oporavak lozinke';

  @override
  String get recoveryCodeHint => 'Unesite kod za oporavak';

  @override
  String get recoveryCodeInvalid => 'Kod mora imati točno 6 znamenki';

  @override
  String get loginFailed => 'Prijava nije uspjela';

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
  String get tooManyDevices => 'Previše uređaja';

  @override
  String get maxDevicesMessage =>
      'Već ste prijavljeni na 3 uređaja.\nOdaberite uređaj za odjavu:';

  @override
  String get unknownDevice => 'Nepoznat uređaj';

  @override
  String get unknown => 'Nepoznato';

  @override
  String get logoutError => 'Greška pri odjavi';

  @override
  String error(String error) {
    return 'Greška: $error';
  }

  @override
  String get cancel => 'Odustani';

  @override
  String get resetPassword => 'Poništi lozinku';

  @override
  String get forgotPasswordTitle => 'Zaboravljena lozinka';

  @override
  String get forgotPasswordDescription =>
      'Unesite broj člana i kod za oporavak stvoren prilikom registracije.';

  @override
  String get passwordResetSuccess =>
      'Lozinka uspješno poništena!\n\nSada se možete prijaviti novom lozinkom.';

  @override
  String get passwordResetFailed => 'Poništavanje lozinke nije uspjelo';

  @override
  String get needHelp => 'Trebate pomoć?';

  @override
  String get helpQuestion => 'Problemi s prijavom ili registracijom?';

  @override
  String get helpDescription =>
      'Kontaktirajte nas putem WhatsAppa i opišite što ne radi. Odgovorit ćemo što prije!';

  @override
  String get whatsapp => 'WhatsApp';

  @override
  String get emailSubject => 'Upit putem aplikacije ICD360S';

  @override
  String get whatsappMessage => 'Pozdrav, imam problem s aplikacijom ICD360S. ';

  @override
  String get imprint => 'Impressum';

  @override
  String get privacy => 'Politika privatnosti';

  @override
  String get statutes => 'Statut';

  @override
  String get revocation => 'Pravo povlačenja';

  @override
  String get cancellation => 'Otkazivanje';

  @override
  String get allRightsReserved => 'Sva prava pridržana.';

  @override
  String get enterCredentials => 'Unesite broj člana i lozinku';

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
  String get membership => 'Članstvo';

  @override
  String get myAppointments => 'Moji sastanci';

  @override
  String get appointmentsLoadingReady => 'Učitavanje sastanaka - API spreman!';

  @override
  String get priority => 'Prioritet';

  @override
  String get messageLabel => 'Poruka';

  @override
  String get createdOn => 'Kreirano';

  @override
  String get handler => 'Rukovatelj';

  @override
  String get reportProblems => 'Prijavite probleme';

  @override
  String get reportProblem => 'Prijavite problem';

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
  String get newTicket => 'Novi zahtjev';

  @override
  String get noOpenTickets => 'Nema otvorenih zahtjeva';

  @override
  String get haveQuestionCreateTicket =>
      'Imate pitanje ili problem?\nStvorite novi zahtjev.';

  @override
  String get whatIsTheProblem => 'U čemu je problem?';

  @override
  String get describeTheProblem => 'Opišite problem';

  @override
  String get howUrgentIsIt => 'Koliko je hitno?';

  @override
  String get low => 'Niska';

  @override
  String get medium => 'Srednja';

  @override
  String get high => 'Visoka';

  @override
  String get submit => 'Pošalji';

  @override
  String get fillSubjectAndMessage => 'Molimo popunite predmet i poruku';

  @override
  String get ticketCreated => 'Zahtjev je kreiran';

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
  String get newEmailAddress => 'Nova email adresa';

  @override
  String get currentPassword => 'Trenutna lozinka';

  @override
  String get saveEmail => 'Spremi email';

  @override
  String get savePassword => 'Spremi lozinku';

  @override
  String get deviceLoggedOut => 'Uređaj odjavljen';

  @override
  String get passwordChangedSuccessfully => 'Lozinka uspješno promijenjena';

  @override
  String get emailChangedSuccessfully => 'Email uspješno promijenjen';

  @override
  String get errorChangingPassword => 'Greška pri promjeni lozinke';

  @override
  String get errorChangingEmail => 'Greška pri promjeni emaila';

  @override
  String get validEmailRequired => 'Molimo unesite valjanu email adresu';

  @override
  String get passwordTooShort => 'Lozinka mora imati najmanje 6 znakova';

  @override
  String get maxDevicesReached => 'Prijavljeni ste na maksimum od 3 uređaja.';

  @override
  String loggedInOnDevices(int count) {
    return 'Prijavljeni ste na $count od 3 uređaja.';
  }

  @override
  String get noActiveSessions => 'Nema aktivnih sesija';

  @override
  String get logoutFromDevice => 'Odjavite se s ovog uređaja';

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
  String get errorAcceptingCall => 'Greška pri prihvaćanju poziva';

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
  String typingIndicator(String name) {
    return '$name piše...';
  }

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
  String get diagnosticDataTitle => 'Dijagnostički podaci';

  @override
  String get diagnosticDescription =>
      'Želite li slati anonimne dijagnostičke podatke za poboljšanje aplikacije?';

  @override
  String get noThanks => 'Ne, hvala';

  @override
  String get yesEnable => 'Da, omogući';

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
  String get newPasswordMinChars => 'Nova lozinka (min. 6 znakova)';

  @override
  String get reasonLabel2 => 'Razlog';

  @override
  String get downloadFailed2 => 'Preuzimanje neuspješno';

  @override
  String get downloadTooltip => 'Preuzmi';

  @override
  String get connectionErrorGeneric => 'Greška povezivanja';

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
  String get bankTransfer => 'Bankovni prijenos';

  @override
  String get standingOrder => 'Trajni nalog';

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
  String get memberNumberTooLong => 'Članski broj predug (maks. 20 znakova)';

  @override
  String get onlyUppercaseAndNumbers =>
      'Dopuštena su samo velika slova i brojevi';

  @override
  String get passwordTooLong => 'Lozinka preduga (maks. 100 znakova)';

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
  String get diagnosticErrors => 'Izvješća o greškama za poboljšanje';

  @override
  String get diagnosticAnonymousStats => 'Anonimne statistike korištenja';

  @override
  String get diagnosticPerformance => 'Podaci o performansama aplikacije';

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
  String get ipClean => 'IP čist - nije na popisu';

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
  String get helpImproveApp => 'Želite li nam pomoći poboljšati aplikaciju?';

  @override
  String get noPersonalDataCollected =>
      'Ne prikupljaju se osobni podaci. Ova postavka se može promijeniti u bilo kojem trenutku.';

  @override
  String logEntries(int count) {
    return '$count zapisa';
  }

  @override
  String get noLogs => 'Nema zapisa';

  @override
  String get newLoginDetected => 'Otkrivljena nova prijava';

  @override
  String get waitingForMember => 'Čekanje na člana';

  @override
  String get waitingForStaff => 'Čekanje na djelatnika';

  @override
  String get waitingForAuthority => 'Čekanje na tijelo';
}
