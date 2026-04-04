// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Slovenian (`sl`).
class AppLocalizationsSl extends AppLocalizations {
  AppLocalizationsSl([String locale = 'sl']) : super(locale);

  @override
  String get appTitle => 'ICD360S e.V - Portal članov';

  @override
  String get memberPortal => 'Portal članov';

  @override
  String get welcomeLoading => 'Nalaganje...';

  @override
  String get welcomeAutoLogin => 'Samodejna prijava...';

  @override
  String get login => 'Prijava';

  @override
  String get register => 'Registracija';

  @override
  String get becomeMember => 'Postanite član';

  @override
  String get memberNumber => 'Članska številka';

  @override
  String get memberNumberHint => 'Vnesite člansko številko';

  @override
  String get password => 'Geslo';

  @override
  String get passwordHint => 'Vnesite geslo';

  @override
  String get confirmPassword => 'Potrdite geslo';

  @override
  String get confirmPasswordHint => 'Potrdite geslo';

  @override
  String get newPassword => 'Novo geslo';

  @override
  String get newPasswordHint => 'Vnesite novo geslo';

  @override
  String get saveCredentials => 'Shrani prijavne podatke';

  @override
  String get autoLogin => 'Samodejna prijava';

  @override
  String get forgotPassword => 'Pozabljeno geslo?';

  @override
  String get firstName => 'Ime in priimek';

  @override
  String get firstNameHint => 'Vnesite ime in priimek';

  @override
  String get nameMinLength => 'Ime mora imeti vsaj 2 znaka';

  @override
  String get nameOnlyLetters => 'Dovoljene so samo črke in vezaji';

  @override
  String get email => 'E-poštni naslov';

  @override
  String get emailHint => 'Vnesite e-pošto';

  @override
  String get emailInvalid => 'Vnesite veljaven e-poštni naslov';

  @override
  String get passwordMinLength => 'Geslo mora imeti vsaj 6 znakov';

  @override
  String get passwordsNotMatch => 'Gesli se ne ujemata';

  @override
  String get recoveryCode => 'Koda za obnovitev (6 števk)';

  @override
  String get recoveryCodeHelper => 'Zapomnite si to kodo za obnovitev gesla';

  @override
  String get recoveryCodeHint => 'Vnesite kodo za obnovitev';

  @override
  String get recoveryCodeInvalid => 'Koda mora imeti natanko 6 števk';

  @override
  String get loginFailed => 'Prijava ni uspela';

  @override
  String get registrationFailed => 'Registracija ni uspela';

  @override
  String connectionError(String error) {
    return 'Napaka povezave: $error';
  }

  @override
  String registrationSuccess(String memberNumber) {
    return 'Uspešna registracija!\n\nVaša članska številka: $memberNumber\n\nZapomnite si to številko za prijavo.';
  }

  @override
  String get tooManyDevices => 'Preveč naprav';

  @override
  String get maxDevicesMessage =>
      'Že ste prijavljeni na 3 napravah.\nIzberite napravo za odjavo:';

  @override
  String get unknownDevice => 'Neznana naprava';

  @override
  String get unknown => 'Neznano';

  @override
  String get logoutError => 'Napaka pri odjavi';

  @override
  String error(String error) {
    return 'Napaka: $error';
  }

  @override
  String get cancel => 'Prekliči';

  @override
  String get resetPassword => 'Ponastavi geslo';

  @override
  String get forgotPasswordTitle => 'Pozabljeno geslo';

  @override
  String get forgotPasswordDescription =>
      'Vnesite člansko številko in kodo za obnovitev, ki ste jo ustvarili ob registraciji.';

  @override
  String get passwordResetSuccess =>
      'Geslo uspešno ponastavljeno!\n\nZdaj se lahko prijavite z novim geslom.';

  @override
  String get passwordResetFailed => 'Ponastavitev gesla ni uspela';

  @override
  String get needHelp => 'Potrebujete pomoč?';

  @override
  String get helpQuestion => 'Težave s prijavo ali registracijo?';

  @override
  String get helpDescription =>
      'Kontaktirajte nas prek WhatsAppa in opišite, kaj ne deluje. Odgovorili bomo čim prej!';

  @override
  String get whatsapp => 'WhatsApp';

  @override
  String get emailSubject => 'Povpraševanje prek aplikacije ICD360S';

  @override
  String get whatsappMessage =>
      'Pozdravljeni, imam težavo z aplikacijo ICD360S. ';

  @override
  String get imprint => 'Impressum';

  @override
  String get privacy => 'Politika zasebnosti';

  @override
  String get statutes => 'Statut';

  @override
  String get revocation => 'Pravica do odstopa';

  @override
  String get cancellation => 'Preklic';

  @override
  String get allRightsReserved => 'Vse pravice pridržane.';

  @override
  String get enterCredentials => 'Vnesite člansko številko in geslo';

  @override
  String get appointments => 'Sestanki';

  @override
  String get tickets => 'Zahtevki';

  @override
  String get liveChat => 'Klepet v živo';

  @override
  String get notifications => 'Obvestila';

  @override
  String get myProfile => 'Moj Profil';

  @override
  String get logout => 'Odjava';

  @override
  String get goodMorning => 'Dobro jutro';

  @override
  String get goodDay => 'Dober dan';

  @override
  String get goodEvening => 'Dober večer';

  @override
  String get goodNight => 'Lahko noč';

  @override
  String get welcomeToICD => 'Dobrodošli v ICD360S e.V!';

  @override
  String get accountCreatedSuccessfully =>
      'Vaš račun je bil uspešno ustvarjen.';

  @override
  String get today => 'Danes';

  @override
  String get membershipFeeDue => 'Članarina zapade';

  @override
  String get pleaseTransferAnnualFee => 'Prosimo, nakazite letno članarino.';

  @override
  String get newBadge => 'Novo';

  @override
  String get close => 'Zapri';

  @override
  String get membership => 'Članstvo';

  @override
  String get myAppointments => 'Moji sestanki';

  @override
  String get appointmentsLoadingReady =>
      'Nalaganje sestankov - API pripravljen!';

  @override
  String get priority => 'Prioriteta';

  @override
  String get messageLabel => 'Sporočilo';

  @override
  String get createdOn => 'Ustvarjeno';

  @override
  String get handler => 'Upravljavec';

  @override
  String get reportProblems => 'Prijavite težave';

  @override
  String get reportProblem => 'Prijavite težavo';

  @override
  String get weRespondIn24Hours => 'Odgovorili vam bomo v največ 24 urah!';

  @override
  String get everythingOk => 'Vse v redu!';

  @override
  String get haveProblemWeHelp => 'Imate težavo?\nMi jo bomo uredili!';

  @override
  String get myMembership => 'Moje članstvo';

  @override
  String get managePersonalDataAndFee =>
      'Upravljajte osebne podatke in članarino';

  @override
  String get myAppointmentsTitle => 'Moji sestanki';

  @override
  String get appointmentsDescription =>
      'Tukaj lahko vidite svoje prihajajoče sestanke.\nLahko potrdite svojo udeležbo ali zavrnete.';

  @override
  String get loadAppointments => 'Naloži sestanke';

  @override
  String get myTickets => 'Moji zahtevki';

  @override
  String get newTicket => 'Nov zahtevek';

  @override
  String get noOpenTickets => 'Ni odprtih zahtevkov';

  @override
  String get haveQuestionCreateTicket =>
      'Imate vprašanje ali težavo?\nUstvarite nov zahtevek.';

  @override
  String get whatIsTheProblem => 'Kakšna je težava?';

  @override
  String get describeTheProblem => 'Opišite težavo';

  @override
  String get howUrgentIsIt => 'Kako nujno je?';

  @override
  String get low => 'Nizka';

  @override
  String get medium => 'Srednja';

  @override
  String get high => 'Visoka';

  @override
  String get submit => 'Pošlji';

  @override
  String get fillSubjectAndMessage => 'Prosimo, izpolnite predmet in sporočilo';

  @override
  String get ticketCreated => 'Zahtevek je bil ustvarjen';

  @override
  String get errorCreatingTicket => 'Napaka pri ustvarjanju zahtevka';

  @override
  String get verified => 'Preverjeno';

  @override
  String get account => 'Račun';

  @override
  String get myDevices => 'Moje naprave';

  @override
  String get changeEmail => 'Spremeni e-pošto';

  @override
  String get changePassword => 'Spremeni geslo';

  @override
  String get newEmailAddress => 'Nov e-poštni naslov';

  @override
  String get currentPassword => 'Trenutno geslo';

  @override
  String get saveEmail => 'Shrani e-pošto';

  @override
  String get savePassword => 'Shrani geslo';

  @override
  String get deviceLoggedOut => 'Naprava odjavljena';

  @override
  String get passwordChangedSuccessfully => 'Geslo uspešno spremenjeno';

  @override
  String get emailChangedSuccessfully => 'E-pošta uspešno spremenjena';

  @override
  String get errorChangingPassword => 'Napaka pri spreminjanju gesla';

  @override
  String get errorChangingEmail => 'Napaka pri spreminjanju e-pošte';

  @override
  String get validEmailRequired => 'Prosimo, vnesite veljaven e-poštni naslov';

  @override
  String get passwordTooShort => 'Geslo mora imeti vsaj 6 znakov';

  @override
  String get maxDevicesReached =>
      'Prijavljeni ste na največje število 3 naprav.';

  @override
  String loggedInOnDevices(int count) {
    return 'Prijavljeni ste na $count od 3 naprav.';
  }

  @override
  String get noActiveSessions => 'Ni aktivnih sej';

  @override
  String get logoutFromDevice => 'Odjavi se iz te naprave';

  @override
  String get confirmLogoutDevice => 'Odjaviti napravo?';

  @override
  String get confirmLogoutMessage =>
      'Ali se želite odjaviti iz te naprave?\n\nPonovno se boste morali prijaviti, da boste lahko uporabljali to napravo.';

  @override
  String get ipAddress => 'IP';

  @override
  String get platform => 'Platforma';

  @override
  String trialWarningUrgentTitle(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'ostaja $days dni',
      few: 'ostajajo $days dnevi',
      two: 'ostajata $days dneva',
      one: 'ostaja 1 dan',
    );
    return 'Pozor: Do začasne ustavitve računa $_temp0!';
  }

  @override
  String get trialWarningTitle => 'Vaš račun še ni preverjen';

  @override
  String get trialWarningDescription =>
      'Prosimo, izpolnite svoje podatke v \"Moj profil\". Po 30 dneh bo vaš račun samodejno začasno ustavljen.';

  @override
  String trialDaysRemaining(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days dni',
      few: '$days dnevi',
      two: '$days dneva',
      one: '1 dan',
    );
    return '$_temp0';
  }

  @override
  String get overview => 'Pregled';

  @override
  String get member => 'Član';

  @override
  String get memberManagement => 'Upravljanje članov';

  @override
  String get reportProblemTooltip => 'Prijavite problem';

  @override
  String get newAppointmentsTitle => 'Novi sestanki';

  @override
  String get youHaveNewAppointment => 'Imate nov sestanek.';

  @override
  String youHaveNewAppointments(int count) {
    return 'Imate $count novih sestankov.';
  }

  @override
  String get appointmentReminderTomorrow => 'Opomnik: Sestanek jutri';

  @override
  String tomorrowAppointment(String title) {
    return 'Jutri: $title';
  }

  @override
  String youHaveTomorrowAppointments(int count) {
    return 'Imate $count sestankov jutri.';
  }

  @override
  String get appointmentsToday => 'Sestanki danes';

  @override
  String todayAppointment(String title) {
    return 'Danes: $title';
  }

  @override
  String youHaveTodayAppointments(int count) {
    return 'Imate $count sestankov danes.';
  }

  @override
  String get paymentReminder => 'Opomnik za plačilo';

  @override
  String paymentReminderMessage(int day, String method) {
    return 'Danes je $day. dan v mesecu – prosimo dokončajte $method.';
  }

  @override
  String get paymentDayLabel => 'Dan plačila (mesečni opomnik)';

  @override
  String get updateAvailable => 'Na voljo je posodobitev';

  @override
  String newVersionAvailable(String version) {
    return 'Na voljo je nova različica: $version';
  }

  @override
  String currentVersionLabel(String version) {
    return 'Trenutna različica: $version';
  }

  @override
  String get changes => 'Spremembe:';

  @override
  String downloadProgress(String percent) {
    return 'Prenos: $percent%';
  }

  @override
  String get installationStarting => 'Začetek namestitve...';

  @override
  String get appWillRestart => 'Aplikacija se bo samodejno znova zagnala.';

  @override
  String get later => 'Pozneje';

  @override
  String get updateNow => 'Posodobi zdaj';

  @override
  String get downloading => 'Prenašanje...';

  @override
  String get downloadFailed => 'Prenos ni uspel. Poskusite znova pozneje.';

  @override
  String get searchingForUpdates => 'Iskanje posodobitev...';

  @override
  String get appUpToDate => 'Aplikacija je posodobljena';

  @override
  String get updateCheckError => 'Napaka pri preverjanju posodobitev';

  @override
  String get changelog => 'Dnevnik sprememb';

  @override
  String get terminConfirmed => 'Termin potrjen';

  @override
  String get terminDeclined => 'Termin zavrnjen';

  @override
  String get terminRescheduleRequested => 'Prestavitev zahtevana';

  @override
  String get statusConfirmed => 'Potrjeno';

  @override
  String get statusDeclined => 'Zavrnjeno';

  @override
  String get statusRescheduling => 'Prestavitev';

  @override
  String get statusPending => 'V čakanju';

  @override
  String get categoryVorstandssitzung => 'Seja uprave';

  @override
  String get categoryMitgliederversammlung => 'Skupščina članov';

  @override
  String get categorySchulung => 'Usposabljanje';

  @override
  String get categorySonstiges => 'Drugo';

  @override
  String openCount(int count) {
    return '$count odprtih';
  }

  @override
  String get refresh => 'Osveži';

  @override
  String get filterUpcoming => 'Prihajajoči';

  @override
  String get filterPast => 'Pretekli';

  @override
  String get filterAll => 'Vsi';

  @override
  String get noUpcomingAppointments => 'Ni prihajajočih terminov';

  @override
  String get noPastAppointments => 'Ni preteklih terminov';

  @override
  String get noAppointmentsAvailable => 'Ni terminov';

  @override
  String get appointmentsShownHere => 'Vaši termini bodo prikazani tukaj';

  @override
  String get dateLabel => 'Datum';

  @override
  String get timeLabel => 'Čas';

  @override
  String get locationLabel => 'Lokacija';

  @override
  String get createdByLabel => 'Ustvaril';

  @override
  String get descriptionLabel => 'Opis';

  @override
  String get ticketLabel => 'Zahtevek';

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
  String get confirm => 'Potrdi';

  @override
  String get decline => 'Zavrni';

  @override
  String get reschedule => 'Prestavi';

  @override
  String get requestReschedule => 'Zahtevaj prestavitev';

  @override
  String appointmentLabel(String title) {
    return 'Termin: $title';
  }

  @override
  String get rescheduleReason => 'Razlog prestavitve *';

  @override
  String get rescheduleReasonHint => 'Navedite razlog...';

  @override
  String get pleaseProvideReason => 'Navedite razlog';

  @override
  String get request => 'Zahtevaj';

  @override
  String get ticketStatusOpen => 'Odprto';

  @override
  String get ticketStatusInProgress => 'V obdelavi';

  @override
  String get ticketStatusWaitingMember => 'Čaka se na člana';

  @override
  String get ticketStatusWaitingStaff => 'Čaka se na uslužbenca';

  @override
  String get ticketStatusWaitingAuthority => 'Čaka se na organ';

  @override
  String get ticketStatusDone => 'Zaključeno';

  @override
  String get ticketPriorityHigh => 'Visoka';

  @override
  String get ticketPriorityMedium => 'Srednja';

  @override
  String get ticketPriorityLow => 'Nizka';

  @override
  String get comments => 'Komentarji';

  @override
  String get documents => 'Dokumenti';

  @override
  String get details => 'Podrobnosti';

  @override
  String get replySent => 'Odgovor poslan';

  @override
  String get sendError => 'Napaka pri pošiljanju';

  @override
  String get uploading => 'Nalaganje...';

  @override
  String fileUploaded(String filename) {
    return '$filename naložen';
  }

  @override
  String get uploadFailed => 'Nalaganje neuspešno';

  @override
  String get openError => 'Napaka pri odpiranju';

  @override
  String get noRepliesYet => 'Še ni odgovorov';

  @override
  String get waitingForSupport => 'Čakanje na odgovor podpore';

  @override
  String get writeReply => 'Napišite odgovor...';

  @override
  String get attachFile => 'Priloži datoteko';

  @override
  String documentsCount(int count) {
    return 'Dokumenti ($count)';
  }

  @override
  String get upload => 'Naloži';

  @override
  String get noDocuments => 'Ni dokumentov';

  @override
  String get allowedFormats => 'Dovoljeni formati: PDF, JPEG, JPG, TXT, ZIP';

  @override
  String get yourMessage => 'Vaše sporočilo:';

  @override
  String get translation => 'Prevod';

  @override
  String get original => 'Izvirnik';

  @override
  String get originalText => 'Izvirno besedilo';

  @override
  String get autoTranslated => 'Samodejno prevedeno';

  @override
  String get originalTapTranslation => 'Izvirnik · Tapnite za prevod';

  @override
  String get translatedTapOriginal => 'Prevedeno · Tapnite za izvirnik';

  @override
  String get justNow => 'Ravnokar';

  @override
  String minutesAgo(int minutes) {
    return 'pred $minutes min';
  }

  @override
  String hoursAgo(int hours) {
    return 'pred $hours urami';
  }

  @override
  String daysAgo(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'dnevi',
      one: 'dnem',
    );
    return 'pred $days $_temp0';
  }

  @override
  String get createdLabel => 'Ustvarjeno';

  @override
  String get updatedLabel => 'Posodobljeno';

  @override
  String get handlerLabel => 'Obdelovalec';

  @override
  String get doneLabel => 'Zaključeno';

  @override
  String get newTicketTitle => 'Nov zahtevek';

  @override
  String get categoryOptional => 'Kategorija (neobvezno)';

  @override
  String get selectCategory => 'Izberi';

  @override
  String get subjectLabel => 'Zadeva';

  @override
  String get fillAllFields => 'Izpolnite vsa polja';

  @override
  String ticketCreatedId(int id) {
    return 'Zahtevek #$id ustvarjen';
  }

  @override
  String get priorityLabel => 'Prioriteta: ';

  @override
  String get supportOffline => 'Podpora offline';

  @override
  String get lastSeenSeconds => 'Aktiven pred nekaj sekundami';

  @override
  String lastSeenMinutes(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: 'minutami',
      one: 'minuto',
    );
    return 'Aktiven pred $minutes $_temp0';
  }

  @override
  String lastSeenHours(int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: 'urami',
      one: 'uro',
    );
    return 'Aktiven pred $hours $_temp0';
  }

  @override
  String lastSeenDays(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'dnevi',
      one: 'dnem',
    );
    return 'Aktiven pred $days $_temp0';
  }

  @override
  String get online => 'Na spletu';

  @override
  String get callSupport => 'Pokliči';

  @override
  String get typeMessage => 'Napišite sporočilo...';

  @override
  String get callBusy => 'Podpora je zasedena';

  @override
  String get callRejected => 'Klic je bil zavrnjen';

  @override
  String get callFailed => 'Klica ni bilo mogoče vzpostaviti';

  @override
  String get callEnded => 'Klic končan';

  @override
  String get callSupportBusy => 'Podpora je že v drugem klicu';

  @override
  String get errorStartingChat => 'Napaka pri zagonu klepeta';

  @override
  String get errorStartingCall => 'Napaka pri zagonu klica';

  @override
  String get errorConnecting => 'Napaka pri povezovanju';

  @override
  String get errorAcceptingCall => 'Napaka pri sprejemanju klica';

  @override
  String get errorDownloading => 'Napaka pri prenosu';

  @override
  String get errorUploading => 'Napaka pri nalaganju';

  @override
  String get errorSending => 'Napaka pri pošiljanju';

  @override
  String get errorPickingPhotos => 'Napaka pri izbiri fotografij';

  @override
  String get errorPickingFiles => 'Napaka pri izbiri datotek';

  @override
  String get errorTakingPhoto => 'Napaka pri fotografiranju';

  @override
  String get fileNotLoaded => 'Datoteke ni mogoče naložiti';

  @override
  String get attachmentIdMissing => 'ID priloge manjka';

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
  String get notifNewMessageFrom => 'Novo sporočilo od';

  @override
  String get notifUrgentPrefix => 'NUJNO';

  @override
  String get notifUrgentMessage => 'NUJNO SPOROČILO';

  @override
  String get notifIncomingCall => 'Dohodni klic';

  @override
  String get notifCallingYou => 'kliče...';

  @override
  String get notifUpdateAvailable => 'Na voljo posodobitev';

  @override
  String get notifVersionAvailable => 'je zdaj na voljo';

  @override
  String get notifConnected => 'Povezano';

  @override
  String get notifDisconnected => 'Odklopljeno';

  @override
  String get notifConnectedBody => 'Povezani ste s strežnikom.';

  @override
  String get notifDisconnectedBody =>
      'Povezava s strežnikom je bila prekinjena.';

  @override
  String get notifError => 'Napaka';

  @override
  String get retry => 'Poskusi znova';

  @override
  String get save => 'Shrani';

  @override
  String get accept => 'Sprejmi';

  @override
  String get selectFile => 'Izberi datoteko';

  @override
  String get dataLoadingText => 'Nalaganje podatkov...';

  @override
  String get dataSavedSuccess => 'Podatki uspešno shranjeni';

  @override
  String get errorSaving => 'Napaka pri shranjevanju';

  @override
  String get errorLoading => 'Napaka pri nalaganju';

  @override
  String savedFilename(String filename) {
    return 'Shranjeno: $filename';
  }

  @override
  String get logsCopied => 'Dnevniki kopirani!';

  @override
  String get diagnosticDataTitle => 'Diagnostični podatki';

  @override
  String get diagnosticDescription =>
      'Ali želite pošiljati anonimne diagnostične podatke za izboljšanje aplikacije?';

  @override
  String get noThanks => 'Ne, hvala';

  @override
  String get yesEnable => 'Da, omogoči';

  @override
  String get passwordMinEightChars => 'Geslo mora imeti vsaj 8 znakov';

  @override
  String get passwordChangeSuccess => 'Geslo uspešno spremenjeno';

  @override
  String get emailChangeError => 'Napaka pri spremembi e-pošte';

  @override
  String get acceptDocumentCheckbox => 'Prebral sem in sprejemam dokument.';

  @override
  String loadingErrorGeneric(String details) {
    return 'Napaka pri nalaganju: $details';
  }

  @override
  String get incomingCallTitle => 'Dohodni klic';

  @override
  String ringingFor(int seconds) {
    return 'Zvoni ${seconds}s';
  }

  @override
  String get rejectCall => 'Zavrni';

  @override
  String get acceptCall => 'Sprejmi';

  @override
  String get unmute => 'Vklopi zvok';

  @override
  String get mute => 'Izklopi zvok';

  @override
  String get hangUp => 'Odloži';

  @override
  String get calling => 'Klicanje...';

  @override
  String autoRejectIn(int seconds) {
    return 'Samodejna zavrnitev čez $seconds sekund';
  }

  @override
  String get speakerOn => 'Zvočnik';

  @override
  String get speakerOff => 'Slušalka';

  @override
  String get micMuted => 'Izključen';

  @override
  String get micOn => 'Mikrofon';

  @override
  String get connectionExcellent => 'Odlično';

  @override
  String get connectionGood => 'Dobro';

  @override
  String get connectionWeak => 'Šibko';

  @override
  String get connectionLost => 'Prekinjeno';

  @override
  String get personalData => 'Osebni podatki';

  @override
  String get personalDataSubtitle => 'Ime, priimek, naslov';

  @override
  String get membershipFee => 'Članarina';

  @override
  String annualFeeYear(String year) {
    return 'Letna članarina $year';
  }

  @override
  String get amount => 'Znesek:';

  @override
  String get dueBy => 'Rok:';

  @override
  String get paid => 'Plačano';

  @override
  String get versionHistory => 'Zgodovina različic';

  @override
  String lastUpdated(String date) {
    return 'Zadnja posodobitev: $date';
  }

  @override
  String get noVersionHistory => 'Ni razpoložljive zgodovine';

  @override
  String get failedLoadChangelog => 'Nalaganje dnevnika ni uspelo';

  @override
  String get callMember => 'Pokliči člana';

  @override
  String get closeConversation => 'Zapri pogovor';

  @override
  String get chatOffline => 'Nedosegljiv';

  @override
  String get attachFiles => 'Priloži datoteke (maks. 10, 50MB)';

  @override
  String get conversationClosed => 'Ta pogovor je bil zaprt';

  @override
  String get noMessages => 'Ni sporočil';

  @override
  String get goBack => 'Nazaj';

  @override
  String get goForward => 'Naprej';

  @override
  String get homePage => 'Domov';

  @override
  String get firstNameLabel => 'Ime';

  @override
  String get lastNameLabel => 'Priimek';

  @override
  String get streetLabel => 'Ulica';

  @override
  String get houseNumberLabel => 'Št.';

  @override
  String get postalCodeLabel => 'Poštna številka';

  @override
  String get cityLabel => 'Mesto';

  @override
  String get phoneMobileLabel => 'Telefon (Mobilni)';

  @override
  String get phoneLandlineLabel => 'Telefon (Stacionarni)';

  @override
  String get newEmailLabel => 'Nov e-poštni naslov';

  @override
  String get currentPasswordLabel => 'Trenutno geslo';

  @override
  String get newPasswordLabel => 'Novo geslo';

  @override
  String get confirmPasswordLabel => 'Potrdi geslo';

  @override
  String get emailChangedSuccess => 'E-pošta uspešno spremenjena';

  @override
  String get newPasswordMinChars => 'Novo geslo (min. 6 znakov)';

  @override
  String get reasonLabel2 => 'Razlog';

  @override
  String get downloadFailed2 => 'Prenos ni uspel';

  @override
  String get downloadTooltip => 'Prenesi';

  @override
  String get connectionErrorGeneric => 'Napaka povezave';

  @override
  String get copyLogs => 'Kopiraj dnevnike';

  @override
  String get deleteLogs => 'Izbriši dnevnike';

  @override
  String get autoScrollOn => 'Samodejno pomikanje VKLJ';

  @override
  String get autoScrollOff => 'Samodejno pomikanje IZKLJ';

  @override
  String get unknownValue => 'Neznano';

  @override
  String get bankTransfer => 'Bančno nakazilo';

  @override
  String get standingOrder => 'Trajni nalog';

  @override
  String get payment => 'Plačilo';

  @override
  String get warningType_ermahnung => 'Opomin';

  @override
  String get warningType_abmahnung => 'Opozorilo';

  @override
  String get warningType_letzte => 'Zadnje opozorilo';

  @override
  String warningsTotal(int count) {
    return 'Skupaj: $count';
  }

  @override
  String warningsErmahnung(int count) {
    return 'Opomini: $count';
  }

  @override
  String warningsAbmahnung(int count) {
    return 'Opozorila: $count';
  }

  @override
  String warningsLetzte(int count) {
    return 'Zadnje: $count';
  }

  @override
  String get noWarnings => 'Ni opominov';

  @override
  String get noWarningsDescription => 'Trenutno nimate opominov.';

  @override
  String createdBy(String name) {
    return 'Ustvaril: $name';
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
  String get monthMay => 'Maj';

  @override
  String get monthJun => 'Jun';

  @override
  String get monthJul => 'Jul';

  @override
  String get monthAug => 'Avg';

  @override
  String get monthSep => 'Sep';

  @override
  String get monthOct => 'Okt';

  @override
  String get monthNov => 'Nov';

  @override
  String get monthDec => 'Dec';

  @override
  String get stufe1_name => 'Osebni podatki';

  @override
  String get stufe2_name => 'Vrsta članstva';

  @override
  String get stufe3_name => 'Finančno stanje';

  @override
  String get stufe4_name => 'Način plačila';

  @override
  String get stufe5_name => 'Začetek članstva';

  @override
  String get stufe6_name => 'Statut';

  @override
  String get stufe7_name => 'Pravilnik o zasebnosti';

  @override
  String get stufe8_name => 'Pravica do preklica';

  @override
  String get memberType_ordentlich => 'Redni član';

  @override
  String get memberType_foerder => 'Podporni član';

  @override
  String get memberType_ehren => 'Častni član';

  @override
  String get memberDesc_ordentlich =>
      'Aktivni član z glasovalno pravico. Sodeluje pri storitvah društva (e-pošta, oblak, birokratska podpora).';

  @override
  String get memberDesc_foerder =>
      'Podpira društvo s prispevki. Lahko se udeleži zbora članov s svetovalnim glasom, brez glasovalne pravice ali izvoljivosti v upravo.';

  @override
  String get memberDesc_ehren =>
      'Ima pravice rednega člana brez obveznosti plačila članarine. Imenovan s strani zbora članov ali uprave.';

  @override
  String get payMethod_ueberweisung => 'Bančno nakazilo';

  @override
  String get payMethod_dauerauftrag => 'Trajni nalog';

  @override
  String get verifyStatus_geprueft => 'Preverjeno';

  @override
  String get verifyStatus_ausgefuellt => 'Izpolnjeno';

  @override
  String get verifyStatus_abgelehnt => 'Zavrnjeno';

  @override
  String get verifyStatus_offen => 'Odprto';

  @override
  String get fillRequiredFields => 'Izpolnite vsa obvezna polja.';

  @override
  String get personalDataSaved => 'Osebni podatki shranjeni';

  @override
  String get selectMemberType => 'Izberite vrsto članstva.';

  @override
  String get memberTypeSaved => 'Vrsta članstva shranjena';

  @override
  String get selectOption => 'Izberite možnost.';

  @override
  String get financialSaved => 'Finančno stanje shranjeno';

  @override
  String get selectPaymentMethod => 'Izberite način plačila.';

  @override
  String get paymentDataSaved => 'Plačilni podatki shranjeni';

  @override
  String get selectDate => 'Izberite datum.';

  @override
  String get membershipStartSaved => 'Začetek članstva shranjen';

  @override
  String get fileTooLarge => 'Datoteka je prevelika (maks. 10 MB).';

  @override
  String get leistungsbescheidUploaded =>
      'Odločba o prejemkih uspešno naložena';

  @override
  String get verificationProgress => 'Napredek preverjanja';

  @override
  String get notApplicable => 'Ni uporabno';

  @override
  String get socialBenefitsExempt =>
      'Način plačila ni potreben za prejemnike socialnih prejemkov.';

  @override
  String get locked => 'Zaklenjeno';

  @override
  String completePreviousStep(int step) {
    return 'Najprej dokončajte korak $step.';
  }

  @override
  String rejectedNote(String note) {
    return 'Zavrnjeno: $note';
  }

  @override
  String get waitingForReview => 'Čaka na pregled uprave.';

  @override
  String get stepApproved => 'Ta korak je bil pregledan in odobren.';

  @override
  String get changesViaChat => 'Spremembe možne le prek klepeta.';

  @override
  String get firstNameRequired => 'Ime *';

  @override
  String get lastNameRequired => 'Priimek *';

  @override
  String get birthDateLabel => 'Datum rojstva *';

  @override
  String get streetRequired => 'Ulica *';

  @override
  String get houseNumberRequired => 'Št. *';

  @override
  String get cityRequired => 'Mesto *';

  @override
  String get phoneRequired => 'Telefonska številka *';

  @override
  String get phonePurpose =>
      'Namen: Kontakt, ko niste dosegljivi prek aplikacije';

  @override
  String get selectMemberTypePrompt => 'Izberite želeno vrsto članstva:';

  @override
  String get financialExplanation =>
      'Za preverjanje upravičenosti do znižanja članarine potrebujemo naslednje podatke. Ti bodo uporabljeni izključno za določitev vaše članarine.';

  @override
  String get socialBenefitsQuestion =>
      'Ali trenutno prejemate socialne prejemke?';

  @override
  String get optionBuergergeld => 'Da, državljanski dodatek (Job Center)';

  @override
  String get optionSozialamt => 'Da, socialna pomoč (Center za socialno delo)';

  @override
  String get optionNoBenefits => 'Ne, ne prejemam socialnih prejemkov';

  @override
  String get feeExempt => 'Vaša mesečna članarina je: 0,00 €/mesec';

  @override
  String get uploadLeistungsbescheid => 'Naložite odločbo o prejemkih';

  @override
  String get uploadLeistungsbescheidHint =>
      'Naložite aktualno odločbo o prejemkih v 14 dneh za potrditev oprostitve članarine.';

  @override
  String get allowedFormatsUpload =>
      'Dovoljeni formati: PDF, JPG, PNG (maks. 10 MB)';

  @override
  String get feeRegular => 'Vaša mesečna članarina je: 25,00 €/mesec';

  @override
  String paymentDayReminder(int day) {
    return 'Opominjeni boste $day. dan vsakega meseca.';
  }

  @override
  String get membershipStartPrompt =>
      'Izberite, kdaj naj se začne vaše članstvo.';

  @override
  String get optionAfterVerification => 'Po zaključku preverjanja';

  @override
  String get optionAfterVerificationDesc =>
      'Članstvo se začne z dnem potrditve uprave.';

  @override
  String get optionRetroFoundation =>
      'Retroaktivno do datuma ustanovitve (01.08.2025)';

  @override
  String get optionRetroFoundationDesc =>
      'Postanete retroaktivni član od ustanovitve društva.';

  @override
  String get optionRetroCustom => 'Retroaktivno do drugega datuma';

  @override
  String get optionRetroCustomDesc => 'Izberite datum med 01.08.2025 in danes.';

  @override
  String get selectDateLabel => 'Izberite datum';

  @override
  String get selectDateHint => 'Izberite datum...';

  @override
  String get dateNotBefore => 'Ne pred 01.08.2025 (datum ustanovitve)';

  @override
  String get feeExemptRetro =>
      'Oprostitev članarine: 0,00 € retroaktivno.\nSamo datum članstva se nastavi retroaktivno.';

  @override
  String get retroactiveFees => 'Retroaktivne članarine';

  @override
  String retroFeeCalculation(
      String from, String to, String months, String total) {
    return 'Obdobje: $from – $to\nMeseci: $months\nČlanarina: $months × 25,00 € = $total €';
  }

  @override
  String get pleaseReadSatzung => 'Preberite statut društva.';

  @override
  String get pleaseReadDatenschutz => 'Preberite pravilnik o zasebnosti.';

  @override
  String get pleaseReadWiderruf => 'Preberite pravico do preklica.';

  @override
  String get acceptedAtRegistration => 'Sprejeto ob registraciji';

  @override
  String get confirmedByBoard => 'Bo potrjeno po pregledu uprave.';

  @override
  String get docSatzung => 'Statut';

  @override
  String get docDatenschutz => 'Pravilnik o zasebnosti';

  @override
  String get docWiderruf => 'Pravica do preklica';

  @override
  String acceptedAtRegCount(int count) {
    return 'Sprejeto ob registraciji ($count/3)';
  }

  @override
  String acceptedOn(String date) {
    return 'Sprejeto dne $date';
  }

  @override
  String get notAccepted => 'Ni sprejeto';

  @override
  String get statusAccepted => 'Sprejeto';

  @override
  String get memberNumberTooLong =>
      'Članska številka predolga (maks. 20 znakov)';

  @override
  String get onlyUppercaseAndNumbers =>
      'Dovoljene so samo velike črke in številke';

  @override
  String get passwordTooLong => 'Geslo predolgo (maks. 100 znakov)';

  @override
  String get nameTooLong => 'Ime predolgo (maks. 100 znakov)';

  @override
  String get emailTooLong => 'E-pošta predolga (maks. 255 znakov)';

  @override
  String get legalAcknowledgePrefix => 'Prebral/a sem ';

  @override
  String get legalAcknowledgeSuffix => '.';

  @override
  String get legalStatutesSuffix =>
      ' ICD360S e.V. in jih priznam kot zavezujoče.';

  @override
  String get legalPleaseReadFirst => '(prosimo najprej preberite)';

  @override
  String get statusActive => 'Aktiven';

  @override
  String get statusSuspended => 'Suspendiran';

  @override
  String get statusNew => 'Novo';

  @override
  String get statusCancelled => 'Prekinjeno';

  @override
  String get statusDeleted => 'Izbrisano';

  @override
  String get roleMitglied => 'Član';

  @override
  String get roleVorsitzer => 'Predsednik';

  @override
  String get roleStellvertreter => 'Namestnik';

  @override
  String get roleSchatzmeister => 'Blagajnik';

  @override
  String get roleSchriftfuehrer => 'Tajnik';

  @override
  String get roleBeisitzer => 'Prisednik';

  @override
  String get roleKassierer => 'Blagajnik';

  @override
  String get roleKassenpruefer => 'Revizor';

  @override
  String get roleEhrenamtlich => 'Prostovoljec';

  @override
  String get roleMitgliedergruender => 'Ustanovni član';

  @override
  String get roleEhrenmitglied => 'Častni član';

  @override
  String get roleFoerdermitglied => 'Podporni član';

  @override
  String get memberTypeNotSet => 'Še ni določeno';

  @override
  String get payMethodSepa => 'SEPA direktna obremenitev';

  @override
  String get labelStatus => 'Stanje';

  @override
  String get labelMemberNumber => 'Članska številka';

  @override
  String get labelRole => 'Vloga';

  @override
  String get labelMemberType => 'Vrsta članstva';

  @override
  String get labelPaymentMethod => 'Način plačila';

  @override
  String get labelRegisteredOn => 'Registrirano';

  @override
  String get labelLastLogin => 'Zadnja prijava';

  @override
  String get labelMemberSince => 'Član od';

  @override
  String get neverLoggedIn => 'Nikoli';

  @override
  String get notActivatedYet => 'Še ni aktivirano';

  @override
  String get tabVerification => 'Preverjanje';

  @override
  String get tabWarnings => 'Opozorila';

  @override
  String get tabDocuments => 'Dokumenti';

  @override
  String get tabMembership => 'Članstvo';

  @override
  String get pleaseEnterFirstName => 'Vnesite ime';

  @override
  String get pleaseEnterLastName => 'Vnesite priimek';

  @override
  String get noFileDataReceived => 'Podatki niso prejeti';

  @override
  String get openFile => 'Odpri';

  @override
  String get diagnosticErrors => 'Poročila o napakah za izboljšanje';

  @override
  String get diagnosticAnonymousStats => 'Anonimna statistika uporabe';

  @override
  String get diagnosticPerformance => 'Podatki o zmogljivosti aplikacije';

  @override
  String get noMicrophoneError =>
      'Mikrofon ni bil najden. Priključite mikrofon in poskusite znova.';

  @override
  String get startConversation => 'Začnite pogovor!';

  @override
  String get staffWillReply => 'Sodelavec vam bo kmalu odgovoril.';

  @override
  String get inCall => 'V klicu...';

  @override
  String get registration => 'Registracija';

  @override
  String get deactivation => 'Deaktivacija';

  @override
  String get deactivatedOn => 'Deaktivirano';

  @override
  String get accountAutoSuspend =>
      'Računi, ki niso preverjeni v 30 dneh, bodo samodejno suspendirani.';

  @override
  String get ipClean => 'IP čist - ni na seznamu';

  @override
  String get documentsProvidedByBoard => 'Dokumente zagotavlja uprava.';

  @override
  String get noDocumentsAvailable => 'Ni dokumentov';

  @override
  String get noDocumentsDescription =>
      'Za vas še niso bili zagotovljeni dokumenti.';

  @override
  String uploadedBy(String name) {
    return 'Naložil: $name';
  }

  @override
  String stepsCompleted(int completed, int total) {
    return '$completed/$total korakov dokončanih';
  }

  @override
  String dayOfMonth(int day) {
    return '$day. v mesecu';
  }

  @override
  String changeField(String field) {
    return 'Spremeni $field';
  }

  @override
  String openDocument(String name) {
    return 'Odpri $name';
  }

  @override
  String get helpImproveApp => 'Želite pomagati izboljšati aplikacijo?';

  @override
  String get noPersonalDataCollected =>
      'Osebni podatki se ne zbirajo. To nastavitev je mogoče kadar koli spremeniti.';

  @override
  String logEntries(int count) {
    return '$count vnosov';
  }

  @override
  String get noLogs => 'Ni dnevnikov';

  @override
  String get newLoginDetected => 'Zaznana nova prijava';

  @override
  String get waitingForMember => 'Čakanje na člana';

  @override
  String get waitingForStaff => 'Čakanje na sodelavca';

  @override
  String get waitingForAuthority => 'Čakanje na organ';
}
