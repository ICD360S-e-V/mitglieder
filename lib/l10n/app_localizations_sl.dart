// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Slovenian (`sl`).
class AppLocalizationsSl extends AppLocalizations {
  AppLocalizationsSl([String locale = 'sl']) : super(locale);

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
  String get confirmPassword => 'Potrdite geslo';

  @override
  String get confirmPasswordHint => 'Potrdite geslo';

  @override
  String get newPassword => 'Novo geslo';

  @override
  String get newPasswordHint => 'Vnesite novo geslo';

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
  String get unknown => 'Neznano';

  @override
  String error(String error) {
    return 'Napaka: $error';
  }

  @override
  String get cancel => 'Prekliči';

  @override
  String get resetPassword => 'Ponastavi geslo';

  @override
  String get imprint => 'Impressum';

  @override
  String get privacy => 'Politika zasebnosti';

  @override
  String get statutes => 'Statut';

  @override
  String get revocation => 'Pravica do odstopa';

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
  String get myAppointments => 'Moji sestanki';

  @override
  String get priority => 'Prioriteta';

  @override
  String get messageLabel => 'Sporočilo';

  @override
  String get reportProblems => 'Prijavite težave';

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
  String get low => 'Nizka';

  @override
  String get high => 'Visoka';

  @override
  String get submit => 'Pošlji';

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
  String get saveEmail => 'Shrani e-pošto';

  @override
  String get savePassword => 'Shrani geslo';

  @override
  String get deviceLoggedOut => 'Naprava odjavljena';

  @override
  String get emailChangedSuccessfully => 'E-pošta uspešno spremenjena';

  @override
  String get errorChangingPassword => 'Napaka pri spreminjanju gesla';

  @override
  String get errorChangingEmail => 'Napaka pri spreminjanju e-pošte';

  @override
  String get validEmailRequired => 'Prosimo, vnesite veljaven e-poštni naslov';

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
  String get autoUpdateEnableTitle => 'Install future updates automatically';

  @override
  String get autoUpdateEnableHint =>
      'The app downloads and installs updates on its own and restarts briefly. No further prompts.';

  @override
  String autoUpdateInstalling(String version) {
    return 'Version $version is being installed in the background. The app will restart shortly.';
  }

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
  String get reasonLabel2 => 'Razlog';

  @override
  String get downloadFailed2 => 'Prenos ni uspel';

  @override
  String get downloadTooltip => 'Prenesi';

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
  String logEntries(int count) {
    return '$count vnosov';
  }

  @override
  String get noLogs => 'Ni dnevnikov';

  @override
  String get newLoginDetected => 'Zaznana nova prijava';

  @override
  String get errorNoInternet => 'Ni internetne povezave. Preverite omrežje.';

  @override
  String get errorTimeout => 'Strežnik se ne odziva. Poskusite znova pozneje.';

  @override
  String get errorServer => 'Napaka strežnika. Poskusite znova pozneje.';

  @override
  String get errorConnection => 'Napaka povezave. Poskusite znova pozneje.';

  @override
  String get errorUnexpected =>
      'Prišlo je do nepričakovane napake. Poskusite znova pozneje.';

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
  String get claudiuWelcomeDay => 'Dober dan';

  @override
  String get claudiuWelcomeEvening => 'Dober večer';

  @override
  String get claudiuWelcomeNight => 'Dober večer';

  @override
  String get claudiuWelcomeVisitor => 'dragi obiskovalec';

  @override
  String get claudiuWelcomeAsk => 'Kako ti lahko pomagam?';

  @override
  String get claudiuWelcomeBecomeMember => 'Želim postati član';

  @override
  String get claudiuWelcomeLogin => 'Sem že član in se želim prijaviti';

  @override
  String get claudiuWelcomeProblem => 'Imam težavo z aplikacijo';

  @override
  String get claudiuWelcomeEmergency => 'Nujno — pokličite nas';

  @override
  String get claudiuWelcomeMascotName => 'Claudiu';

  @override
  String get claudiuWelcomeEmergencyIntro =>
      'Preden pokličeš — naše delovne ure:';

  @override
  String get claudiuWelcomeScheduleOffice => 'V pisarni';

  @override
  String get claudiuWelcomeScheduleField => 'Na terenu s strankami';

  @override
  String get claudiuWelcomeOutsideHoursNote =>
      'Izven teh ur obravnavamo le nujne primere. Lahko nam pošlješ tudi SMS na isto številko — javili se bomo.';

  @override
  String get claudiuWelcomeCallNow => 'Pokliči zdaj';

  @override
  String get claudiuWelcomeSendSms => 'Pošlji SMS';

  @override
  String get claudiuWelcomeSmsBody =>
      'Nujno ICD360S e.V. — prosim, čim prej me kontaktirajte.';

  @override
  String get claudiuWelcomeCloseButton => 'Zapri';

  @override
  String get claudiuLoginWelcome => 'Dobrodošel nazaj, dragi član!';

  @override
  String get claudiuLoginAsk => 'Prosim, povej mi svojo člansko številko.';

  @override
  String get claudiuLoginProgress => 'Skoraj… nadaljuj s tipkanjem.';

  @override
  String get claudiuLoginReady => 'Odlično! Pritisni gumb spodaj.';

  @override
  String get claudiuLoginLoading => 'Preverjam identiteto… 🔍';

  @override
  String get claudiuLoginFoundPlain => 'Našel sem te! Prijavljam te…';

  @override
  String claudiuLoginFoundNamed(String name) {
    return 'Našel sem te, $name! Prijavljam te…';
  }

  @override
  String get claudiuLoginError =>
      'Hm, te številke ne najdem. Si jo pravilno vnesel?';

  @override
  String get claudiuLoginForgotHeader => 'Si pozabil člansko številko?';

  @override
  String get claudiuLoginNoSms => 'Številke ne pošiljamo po e-pošti ali SMS.';

  @override
  String get claudiuLoginOnlyWay =>
      'Edini način: osebni sestanek v pisarni društva, po preverbi osebnega dokumenta.';

  @override
  String get claudiuLoginContactUs => 'Pokliči za dogovor:';

  @override
  String get claudiuDiagnosticGreeting => 'Preden vstopiš, eno hitro vprašanje';

  @override
  String get claudiuDiagnosticAsk =>
      'Smem pošiljati anonimna poročila, da razvijalci lahko izboljšajo aplikacijo?';

  @override
  String get claudiuDiagnosticYes => 'Da, želim pomagati';

  @override
  String get claudiuDiagnosticNo => 'Ne, samo raziskujem';

  @override
  String get claudiuDiagnosticTellMore => 'Povej mi več';

  @override
  String get claudiuDiagnosticSendsHeader => '📤 Kaj POŠILJAMO (anonimno):';

  @override
  String get claudiuDiagnosticSends1 =>
      'Anonimna koda naprave (NE članska številka)';

  @override
  String get claudiuDiagnosticSends2 => 'Tvoja vloga (član / uprava)';

  @override
  String get claudiuDiagnosticSends3 =>
      'Operacijski sistem (Linux / Android / iOS / Windows)';

  @override
  String get claudiuDiagnosticSends4 => 'Izbrani jezik';

  @override
  String get claudiuDiagnosticSends5 => 'Stanje in raven baterije';

  @override
  String get claudiuDiagnosticSends6 => 'Trenutni zaslon';

  @override
  String get claudiuDiagnosticSends7 => 'Trajanje seje (sekunde)';

  @override
  String get claudiuDiagnosticSends8 => 'Napake, če obstajajo (zadnjih 10)';

  @override
  String get claudiuDiagnosticSends9 => 'Navigacija (zadnjih 20 zaslonov)';

  @override
  String get claudiuDiagnosticSends10 =>
      'Kolikokrat je aplikacija poslala podatke (samo število, brez vsebine)';

  @override
  String get claudiuDiagnosticSends11 =>
      'Kako sistem razvršča aplikacijo in kako hitro se prazni baterija';

  @override
  String get claudiuDiagnosticNeverHeader => '🛡️ Kaj NIKOLI ne pošljemo:';

  @override
  String get claudiuDiagnosticNever1 => 'Tvoje pravo ime';

  @override
  String get claudiuDiagnosticNever2 => 'E-poštni naslov';

  @override
  String get claudiuDiagnosticNever3 => 'Telefonska številka';

  @override
  String get claudiuDiagnosticNever4 => 'Geslo';

  @override
  String get claudiuDiagnosticNever5 => 'Vsebina sporočil klepeta';

  @override
  String get claudiuDiagnosticNever6 => 'Vsebina vstopnic';

  @override
  String get claudiuDiagnosticNever7 => 'Dokumenti ali priloge';

  @override
  String get claudiuDiagnosticTechHeader => '📡 Tehnične podrobnosti:';

  @override
  String get claudiuDiagnosticTech1 => 'Pošlje se vsakih 15 minut';

  @override
  String get claudiuDiagnosticTech2 =>
      'TLS-šifrirana povezava s pripetim certifikatom';

  @override
  String get claudiuDiagnosticTech3 => 'Lahko izklopiš kadarkoli v Nastavitvah';

  @override
  String get claudiuProblemHelpTitle => 'Kako lahko pomagam?';

  @override
  String get claudiuProblemHelpGreeting => 'Kaj se je zgodilo?';

  @override
  String get claudiuProblemHelpAsk => 'Kako mi želiš povedati?';

  @override
  String get claudiuProblemHelpWriteTitle => 'Napiši poročilo';

  @override
  String get claudiuProblemHelpWriteBody =>
      'S podrobnostmi korak za korakom. Ekipa prejme besedilo in ga reši pozneje.';

  @override
  String get claudiuProblemHelpChatTitle => 'Pogovorimo se zdaj';

  @override
  String get claudiuProblemHelpChatBody =>
      'Anonimni klepet z operaterjem. Odgovor v realnem času, če je kdo na spletu.';

  @override
  String get claudiuProblemHelpAltCallHeader => 'Ali, če je nujno:';

  @override
  String get claudiuProblemHelpAltCallLabel => 'Pokliči nas';

  @override
  String get claudiuAnonymousChatTitle => 'Anonimni klepet';

  @override
  String get claudiuAnonymousChatGreeting => 'Živjo!';

  @override
  String get claudiuAnonymousChatWelcome =>
      'Poslušam. Piši karkoli — brez imena. Odgovorim, takoj ko bom tu.';

  @override
  String get claudiuAnonymousChatHint => 'Napiši sporočilo…';

  @override
  String get claudiuAnonymousChatWaitingOperator =>
      'Čakamo, da operater odgovori…';

  @override
  String get claudiuVorsitzerConnectedTitle => 'Živjo!';

  @override
  String get claudiuVorsitzerConnectedBody =>
      'Hvala, ker si nam pisal — zdaj si v stiku z Vorsitzerjem. Povej, kako ti lahko pomagamo z vlogo za članstvo.';

  @override
  String get claudiuVorsitzerConnectedSender => 'Vorsitzer';

  @override
  String get claudiuQuickReplyValidationTime =>
      'Koliko časa traja preverjanje?';

  @override
  String get claudiuQuickReplyDocuments => 'Katere dokumente potrebujem?';

  @override
  String get claudiuQuickReplyStepProblem => 'Zataknil sem se pri enem koraku';

  @override
  String get claudiuQuickReplyHuman => 'Lahko zdaj s kom govorim?';

  @override
  String get claudiuAnonymousChatConnecting => 'Povezovanje…';

  @override
  String get claudiuAnonymousChatConnectionFailed =>
      'Klepeta ni bilo mogoče odpreti. Poskusi znova ali pokliči.';

  @override
  String get claudiuAnonymousChatRetry => 'Poskusi znova';

  @override
  String get claudiuAnonymousChatOnline => 'Povezano';

  @override
  String get claudiuAnonymousChatOffline => 'Ponovna povezava…';

  @override
  String get claudiuAnonymousChatAdminTyping => 'Operater piše…';

  @override
  String get claudiuProblemReportTitle => 'Prijavi težavo';

  @override
  String get claudiuProblemReportGreeting => 'Kaj se je zgodilo?';

  @override
  String get claudiuProblemReportAsk =>
      'Povej mi podrobno in poročilo bom posredoval ekipi.';

  @override
  String get claudiuProblemReportIncludeHeader => 'Prosim, vključi:';

  @override
  String get claudiuProblemReportIncludeBullets1 =>
      'Kaj si počel, ko se je težava pojavila';

  @override
  String get claudiuProblemReportIncludeBullets2 =>
      'Katero koli sporočilo o napaki, ki si ga videl';

  @override
  String get claudiuProblemReportIncludeBullets3 => 'Na katerem zaslonu si bil';

  @override
  String get claudiuProblemReportIncludeBullets4 =>
      'Ali se aplikacija sesuje, zapre ali prikaže prazen zaslon?';

  @override
  String get claudiuProblemReportIncludeBullets5 =>
      'Se zgodi vsakič ali samo enkrat?';

  @override
  String get claudiuProblemReportDescriptionLabel => 'Tvoj opis';

  @override
  String get claudiuProblemReportDescriptionHint =>
      'Npr.: Ko odprem klepet, se prikaže \"Connection error\" in aplikacija se ne odziva…';

  @override
  String claudiuProblemReportTooShort(int count) {
    return 'Malo več podrobnosti, prosim (vsaj $count znakov)';
  }

  @override
  String get claudiuProblemReportSubmit => 'Pošlji poročilo';

  @override
  String get claudiuProblemReportSubmitting => 'Pošiljanje…';

  @override
  String get claudiuProblemReportSentTitle => 'Hvala!';

  @override
  String get claudiuProblemReportSentBody =>
      'Poročilo je bilo poslano. Naša ekipa ga bo pregledala čim prej.';

  @override
  String get claudiuProblemReportSentClose => 'Razumem';

  @override
  String get claudiuProblemReportSendFailed =>
      'Poročila ni bilo mogoče poslati. Pokliči nas za nujno pomoč.';

  @override
  String get claudiuProblemReportAlt => 'Ali, če je nujno:';

  @override
  String get claudiuProblemReportCallLabel => 'Pokliči nas';

  @override
  String claudiuApprovalGreeting(String name) {
    return 'Živjo, $name! 👋';
  }

  @override
  String get claudiuApprovalGreetingNoName => 'Živjo! 👋';

  @override
  String get claudiuApprovalGladToSeeYou => 'Vesel sem, da si tu!';

  @override
  String get claudiuApprovalCheckingForSafety =>
      'Za tvojo varnost Vorsitzer trenutno preverja tvojo zahtevo za prijavo. 🛡️';

  @override
  String get claudiuApprovalMonthlyExplain =>
      '💡 To naredimo vsakih 30 dni, da se prepričamo, da si res ti. Je kot varnostni pregled — največ 5 minut.';

  @override
  String get claudiuApprovalSuccess =>
      'Končano! 🎉 Vorsitzer te je prepoznal. Prijavljam te…';

  @override
  String get claudiuApprovalDenied =>
      'Hm, Vorsitzer je zavrnil tvojo zahtevo. 😔';

  @override
  String get claudiuApprovalDeniedHelp =>
      'Če misliš, da je to napaka, nas prosim pokliči, da razjasnimo.';

  @override
  String get claudiuApprovalExpired =>
      'Preteklo je 5 minut in od Vorsitzerja nismo prejeli odgovora.';

  @override
  String get claudiuApprovalExpiredHelp =>
      'Pokliči nas in lahko tvojo zahtevo odobrimo takoj. 📞';

  @override
  String get claudiuApprovalCallUs => 'Pokliči nas';

  @override
  String get claudiuApprovalTryAgain => 'Poskusi znova';

  @override
  String get claudiuApprovalCancel => 'Prekliči';

  @override
  String get claudiuApprovalClose => 'Zapri';

  @override
  String get wizardIntroBubble1 =>
      'Živjo, obiskovalec! 👋 Hvala, da se želiš pridružiti naši družini.';

  @override
  String get wizardIntroBubble2 =>
      'Ime mi je Claudiu. Spomladi 2025 sem imel jasno vizijo: ustanoviti društvo, ki pomaga ljudem v stiski — prostovoljno, iz srca, brez nepotrebne birokracije. ❤️';

  @override
  String get wizardIntroBubble3 =>
      'Začel sem se pogovarjati s klienti, ki sem jih obiskoval. Povedal sem jim svoje sanje. In vsak je rekel: „Da, gremo!\" Julija 2025 smo se srečali — 6 odločnih ljudi. Odločili smo se ustanoviti **ICD360S e.V.** v Neu-Ulmu. 📍';

  @override
  String get wizardIntroBubble4 =>
      '**1. avgusta 2025** je društvo uradno zaživelo — v Registru društev. Moje najlepše darilo. 🎂';

  @override
  String get wizardIntroBubble5 =>
      'Kaj počnemo? Pomagamo beguncem, invalidom, ekonomsko prikrajšanim, **otrokom in mladim** — pri upravnih zadevah, nemškem jeziku, stanovanju, nakupih, socialnih prejemkih. Naš Vorstand večinoma sestavljajo invalidi — tako odločitve izhajajo iz resnične življenjske izkušnje. 🤝';

  @override
  String get wizardIntroBubble6 =>
      'Zdaj si na vrsti ti. Prijavimo te — traja približno 5 minut. Greva korak za korakom, ne pustim te samega. ✨';

  @override
  String get wizardIntroStart => 'Začnimo';

  @override
  String get wizardBack => 'Nazaj';

  @override
  String get wizardNext => 'Naprej';

  @override
  String wizardStepLabel(int step, int total, String title) {
    return 'Korak $step od $total · $title';
  }

  @override
  String get wizardErrRequired => 'To polje je obvezno';

  @override
  String wizardErrTooShort(int count) {
    return 'Prekratko (vsaj $count znakov)';
  }

  @override
  String get wizardErrOnlyLetters =>
      'Samo črke, presledki, vezaji in apostrofi';

  @override
  String get wizardErrSaveFailed =>
      'Shranjevanje ni uspelo. Preveri povezavo in poskusi znova.';

  @override
  String get wizardStufe1aTitle => 'Identiteta';

  @override
  String get wizardStufe1aPrompt =>
      'Spoznajmo se uradno. Napiši ime točno tako, kot je na Personalausweis, Reisepass ali Aufenthaltstitel — da bo skladno z dokumenti.';

  @override
  String get wizardStufe1aVornameLabel => 'Vornamen (imena)';

  @override
  String get wizardStufe1aVornameHelper =>
      'Vsa tvoja imena točno kot na dokumentu. S presledkom ali vezajem (npr. Hans-Peter, Maria Anna).';

  @override
  String get wizardStufe1aNachnameLabel => 'Familienname (priimek)';

  @override
  String get wizardStufe1aNachnameHelper => 'Tvoj trenutni priimek.';

  @override
  String get wizardStufe1aGeburtsnameLabel =>
      'Geburtsname (rojstno ime) — neobvezno';

  @override
  String get wizardStufe1aGeburtsnameHelper =>
      'Samo če se razlikuje od Familienname — npr. pred poroko.';

  @override
  String get wizardStufe1bTitle => 'Rojstni dan';

  @override
  String get wizardStufe1bPrompt =>
      'Z veseljem bi praznovali tvoj rojstni dan! 🎂 In nam pomaga potrditi, da imaš vsaj 16 — tako pravi naš statut.';

  @override
  String get wizardStufe1bGeburtsdatumLabel => 'Datum rojstva';

  @override
  String get wizardStufe1bGeburtsdatumHelper => 'Tapni za izbiro datuma';

  @override
  String get wizardStufe1bGeburtsortLabel => 'Kraj rojstva';

  @override
  String get wizardStufe1bGeburtsortHelper => 'Mesto / kraj, kjer si se rodil.';

  @override
  String get wizardAgeGatePrompt => 'Žal mi je… 😔';

  @override
  String wizardAgeGateBody1(int age, int years) {
    return 'Naš statut pravi, da moraš biti vsaj star 16, da postaneš član. Star si $age — upam, da se vidiva čez $years let! 🌱';
  }

  @override
  String get wizardAgeGateBody2 =>
      'Če želiš občasno prostovoljiti (katera koli starost, s soglasjem staršev), pokliči nas — radi podpiramo mlade, ki želijo spremeniti svet.';

  @override
  String get wizardAgeGateBackHome => 'Nazaj na pozdrav';

  @override
  String get wizardErrInvalidPhone => 'Neveljavna telefonska številka';

  @override
  String get wizardStufe1b1Title => 'Soglasje staršev';

  @override
  String get wizardStufe1b1Prompt =>
      'Si mladoletnik (16-17) — po §106 BGB potrebujemo soglasje staršev ali zakonitega skrbnika. Povej mi ime in telefonsko številko. Vorsitzer ga bo poklical in dogovoril srečanje (osebno ali video klic). Brez e-pošte — želimo biti prepričani, da govorimo s pravo osebo.';

  @override
  String get wizardStufe1b1VornameLabel => 'Ime starša';

  @override
  String get wizardStufe1b1VornameHelper => 'Kot na Personalausweis starša.';

  @override
  String get wizardStufe1b1NachnameLabel => 'Priimek starša';

  @override
  String get wizardStufe1b1NachnameHelper => 'Kot na Personalausweis starša.';

  @override
  String get wizardStufe1b1TelefonLabel => 'Mobilna številka starša';

  @override
  String get wizardStufe1b1TelefonHelper =>
      'Na to številko bo poklical Vorsitzer.';

  @override
  String get wizardStufe1b1RelationLabel => 'Razmerje do otroka:';

  @override
  String get wizardStufe1b1RelationMutter => 'Mati';

  @override
  String get wizardStufe1b1RelationVater => 'Oče';

  @override
  String get wizardStufe1b1RelationSorgeberechtigter => 'Zakoniti skrbnik';

  @override
  String get wizardStufe1b1RelationAndere => 'Drug skrbnik';

  @override
  String get wizardStufe1cTitle => 'Osebni podatki';

  @override
  String get wizardStufe1cPrompt =>
      'Samo da te malo bolje spoznam. To ostane med nama in nikjer ni javno prikazano.';

  @override
  String get wizardStufe1cGeschlechtLabel => 'Spol';

  @override
  String get wizardStufe1cGeschlechtMaennlich => 'Moški';

  @override
  String get wizardStufe1cGeschlechtWeiblich => 'Ženski';

  @override
  String get wizardStufe1cGeschlechtDivers => 'Drugo';

  @override
  String get wizardStufe1cGeschlechtKeineAngabe => 'Ne želim povedati';

  @override
  String get wizardStufe1cFamilienstandLabel => 'Zakonski stan';

  @override
  String get wizardStufe1cFamilienstandLedig => 'Samski/a';

  @override
  String get wizardStufe1cFamilienstandVerheiratet => 'Poročen/a';

  @override
  String get wizardStufe1cFamilienstandGeschieden => 'Ločen/a';

  @override
  String get wizardStufe1cFamilienstandVerwitwet => 'Vdovec / Vdova';

  @override
  String get wizardStufe1dTitle => 'Tvoj izvor';

  @override
  String get wizardStufe1dPrompt =>
      'To nam pomaga ponuditi ti pravo podporo — na primer nasvet glede Aufenthalt ali iskanje tvoje jezikovne skupnosti.';

  @override
  String get wizardStufe1dStaatLabel => 'Državljanstvo';

  @override
  String get wizardStufe1dStaatHelper =>
      'Npr. deutsch, rumänisch, ukrainisch. Več ločenih z vejico.';

  @override
  String get wizardStufe1dAufenthaltLabel =>
      'Status bivanja (Aufenthaltsstatus) — neobvezno';

  @override
  String get wizardStufe1dAufenthaltHelper =>
      'Izberi naziv iz svoje Aufenthaltskarte / odločbe. Vorstand to primerja s tvojimi dokumenti.';

  @override
  String get wizardStufe1dAufenthaltAwaitingCitizenship =>
      'Najprej zgoraj vpiši državljanstvo — prikazali bomo samo ustrezne možnosti.';

  @override
  String get wizardStufe1dAufenthaltGerman =>
      'Aufenthaltstitel ni potreben — nemški državljan.';

  @override
  String get wizardStufe1dAufenthaltEuEea =>
      'Državljan EU/EGP/CH — prosto gibanje (Freizügigkeit).';

  @override
  String get wizardStufe1dAufenthaltTempHint => 'začasno';

  @override
  String get wizardStufe1dAufenthaltPermHint => 'stalno prebivanje';

  @override
  String get wizardStufe1dAufenthaltAsylumProcessHint => 'azilni postopek';

  @override
  String get wizardStufe1dAufenthaltOther => 'Drugo (prosim navedi v klepetu)';

  @override
  String get wizardStufe1dAufenthaltRequired =>
      'Prosim izberi Aufenthaltstitel.';

  @override
  String get wizardStufe1dMutterspracheLabel => 'Materni jezik';

  @override
  String get wizardStufe1dMutterspracheHelper =>
      'Vnaprej izpolnjeno z jezikom aplikacije — spremeni če je drug.';

  @override
  String get wizardStufe1eTitle => 'Naslov';

  @override
  String get wizardStufe1ePrompt =>
      'Tvoj poštni naslov — uporabljamo ga za uradne dokumente (statut, članske pogodbe, obvestila).';

  @override
  String get wizardStufe1eStrasseLabel => 'Ulica';

  @override
  String get wizardStufe1eStrasseHelper =>
      'Samo ime ulice — številka v sosednje polje.';

  @override
  String get wizardStufe1eHausnummerLabel => 'Št.';

  @override
  String get wizardStufe1ePlzLabel => 'PLZ (poštna št.)';

  @override
  String get wizardStufe1eOrtLabel => 'Mesto';

  @override
  String get wizardStufe1eLandLabel => 'Država';

  @override
  String get wizardStufe1eLandHelper => 'Vnaprej izpolnjeno: Deutschland.';

  @override
  String get wizardErrInvalidStreet => 'Neveljavno ime ulice';

  @override
  String get wizardErrInvalidHausnummer =>
      'Neveljavna številka (npr. 12, 12a, 12/3)';

  @override
  String get wizardErrInvalidPlz =>
      'Neveljavna poštna številka (samo številke)';

  @override
  String get wizardStufe1fTitle => 'Kontakt';

  @override
  String get wizardStufe1fPrompt =>
      'Kako te dosežemo? Telefon je samo za nujne primere — vse drugo poteka po našem lastnem od konca do konca šifriranem kanalu v aplikaciji. Tvoj članski e-naslov se dodeli samodejno in je prikazan spodaj.';

  @override
  String get wizardStufe1fTelefonLabel => 'Mobilna številka';

  @override
  String get wizardStufe1fTelefonHelper =>
      'Obljubim, pokličem samo če je pomembno. 📱';

  @override
  String get wizardStufe2Title => 'Vrsta članstva';

  @override
  String get wizardStufe2Prompt =>
      'Kakšen član želiš biti? Naj ti pojasnim vsako možnost.';

  @override
  String get wizardStufe2OrdentlichTitle => 'Redni član (ordentlich)';

  @override
  String get wizardStufe2OrdentlichBody =>
      'Polna pravica. Plačuješ mesečno članarino, glasuješ na občnem zboru, lahko si izvoljen v upravo. Privzeta izbira.';

  @override
  String get wizardStufe2FoerderTitle => 'Podporni član (Fördermitglied)';

  @override
  String get wizardStufe2FoerderBody =>
      'Društvo podpiraš finančno, a ne sodeluješ aktivno pri odločitvah. Brez glasovalne pravice. Dobro, če želiš pomagati od daleč.';

  @override
  String get wizardStufe2EhrenTitle => 'Častni član (Ehrenmitglied)';

  @override
  String get wizardStufe2EhrenBody =>
      'Podeli uprava za posebne zasluge. Ne izbereš ga sam — podeljen je kot priznanje. Izberi le, če si že bil počaščen.';

  @override
  String get wizardStufe3Title => 'Finančni položaj';

  @override
  String get wizardStufe3Prompt =>
      'Zdaj o tvojem finančnem položaju. Ne da bi te sodil — le da te oprostimo članarine, če prejemaš socialne prejemke.';

  @override
  String get wizardStufe3OptionBuergergeld => 'Prejemam Bürgergeld';

  @override
  String get wizardStufe3OptionSozialamt => 'Prejemam pomoč od Sozialamta';

  @override
  String get wizardStufe3OptionNein => 'Ne prejemam nobenega';

  @override
  String get wizardStufe3FeeExemptTitle => 'Članarina: 0 € / mesec 🎉';

  @override
  String get wizardStufe3FeeExemptBody =>
      'Z Bürgergeldom, Sozialamtom, ALG I ali Krankengeldom si po Satzungu §6 popolnoma oproščen članarine. Potrebujemo le dokazilo (Leistungsbescheid ali potrdilo organa / zdravstvene blagajne).';

  @override
  String get wizardStufe3UploadTitle => 'Naloži Leistungsbescheid';

  @override
  String get wizardStufe3UploadHint => 'PDF / JPG / PNG, največ 10 MB.';

  @override
  String get wizardStufe3UploadRequired =>
      'Prosim naloži Leistungsbescheid, preden nadaljuješ.';

  @override
  String get wizardStufe3FileTooLarge => 'Datoteka je prevelika. Največ 10 MB.';

  @override
  String get wizardStufe3UploadFailed =>
      'Datoteke ni bilo mogoče naložiti. Poskusi znova.';

  @override
  String get wizardStufe3RegularFeeTitle => 'Članarina: 25 € / mesec';

  @override
  String get wizardStufe3RegularFeeBody =>
      'Standardna članarina za redne člane po statutu.';

  @override
  String get wizardStufe4Title => 'Plačilo';

  @override
  String get wizardStufe4Prompt =>
      'Kako želiš plačati članarino? In na kateri dan v mesecu?';

  @override
  String get wizardStufe4MethodUeberweisungTitle =>
      'Bančno nakazilo (Überweisung)';

  @override
  String get wizardStufe4MethodUeberweisungBody =>
      'Plačilo začneš sam vsak mesec s svojega računa.';

  @override
  String get wizardStufe4MethodSepaTitle =>
      'SEPA-Lastschrift (neposredna bremenitev)';

  @override
  String get wizardStufe4MethodSepaBody =>
      'Znesek samodejno potegnemo s tvojega računa. Najbolj priročno, vendar potrebujemo IBAN in podpisano pooblastilo.';

  @override
  String get wizardStufe4MethodDauerauftragTitle =>
      'Dauerauftrag (trajni nalog)';

  @override
  String get wizardStufe4MethodDauerauftragBody =>
      'V banki nastaviš trajni nalog. Banka znesek samodejno nakaže vsak mesec.';

  @override
  String get wizardStufe4DayLabel => 'Dan plačila';

  @override
  String get wizardStufe4DayHint => 'Izberi dan med 1 in 31';

  @override
  String wizardStufe4DayItem(int day) {
    return '$day. dan';
  }

  @override
  String wizardStufe4DayReminder(int day) {
    return 'Članarina bo bremenjena $day. v vsakem mesecu.';
  }

  @override
  String get wizardStufe5Title => 'Začetek';

  @override
  String get wizardStufe5Prompt =>
      'Od kdaj želiš biti uradno član ICD360S? Od odobritve ali za nazaj.';

  @override
  String get wizardStufe5OptionAbVerifizierungTitle => 'Od odobritve Vorstanda';

  @override
  String get wizardStufe5OptionAbVerifizierungBody =>
      'Najpreprostejša izbira. Brez članarine za nazaj.';

  @override
  String get wizardStufe5OptionGruendungsdatumTitle =>
      'Za nazaj od 01.08.2025 (ustanovitev)';

  @override
  String get wizardStufe5OptionGruendungsdatumBody =>
      'Boš član že od prvega dne društva.';

  @override
  String get wizardStufe5OptionAnderesDatumTitle => 'Drug datum';

  @override
  String get wizardStufe5OptionAnderesDatumBody =>
      'Sam izbereš datum med 01.08.2025 in danes.';

  @override
  String get wizardStufe5PickDate => 'Tapni za izbiro datuma';

  @override
  String get wizardStufe5PickDateFirst => 'Prosim, najprej izberi datum.';

  @override
  String get wizardStufe5DatePickerHelp => 'Začetek članstva';

  @override
  String wizardStufe5DateRange(String start) {
    return 'Med $start in danes';
  }

  @override
  String get wizardStufe5RetroactiveTitle => 'Članarina za nazaj';

  @override
  String wizardStufe5RetroactiveBody(
      String start, String end, int months, String amount) {
    return 'Od $start do $end je to $months mesecev. Pri 25 €/mesec to znaša $amount € za plačilo nazaj, poleg trenutne mesečne članarine.';
  }

  @override
  String get wizardStufe5FeeExemptTitle => 'Članarina za nazaj: 0 € 🎉';

  @override
  String get wizardStufe5FeeExemptBody =>
      'Z Bürgergeld ali Sozialamt si popolnoma oproščen — niti za nazaj ne dolguješ nič.';

  @override
  String wizardDocumentPrompt(String doc) {
    return 'Preden zaključimo, prosim natančno preberi $doc. Pomembno je vedeti, kaj podpisuješ.';
  }

  @override
  String get wizardDocumentScrollHint => 'Pomakni do konca za nadaljevanje.';

  @override
  String get wizardDocumentScrolledOk => 'Prebral si do konca ✓';

  @override
  String wizardDocumentOpenButton(String doc) {
    return 'Odpri $doc v brskalniku';
  }

  @override
  String get wizardDocumentExternalHint =>
      'Na tej platformi dokument odpremo v privzetem brskalniku.';

  @override
  String get wizardDocumentOpenedOk =>
      'Dokument je odprt. Prosim, natančno ga preberi.';

  @override
  String wizardDocumentConfirm(String doc) {
    return 'Potrjujem, da sem prebral(a) $doc in se z njim strinjam.';
  }

  @override
  String get wizardFinalAdultTitle => 'Gotovo! Si vpisan 🎉';

  @override
  String get wizardFinalMinorTitle => 'Tvoja zahteva je bila poslana 📨';

  @override
  String get wizardFinalMinorBody =>
      'Stopili bomo v stik s tvojim staršem in dogovorili srečanje (osebno ali video klic). Prosim, bodi potrpežljiv — postopek lahko traja do 7 dni. Prejel boš obvestilo v aplikaciji, takoj ko starš odobri.';

  @override
  String get wizardFinalMitgliedernummerLabel => 'Tvoja članska številka';

  @override
  String get wizardStufe4MethodComingSoon => 'Kmalu';

  @override
  String get wizardStufe4StreichungWarning =>
      'Če zaostaneš s članarino več kot 6 mesecev, te samodejno izbrišemo (Satzung §6 Abs. 3).';

  @override
  String get wizardStufe5KuendigungInfo =>
      'Za izstop: pošlji nam pisno odpoved 3 mesece pred 31. decembrom (do 30. septembra, da bo veljala ob koncu leta). Brez minimalnega trajanja (Satzung §6 Abs. 3).';

  @override
  String get wizardStufe1fEmailLabel => 'Tvoj članski e-naslov';

  @override
  String get wizardStufe1fEmailHelper =>
      'Samodejno se dodeli iz tvoje članske številke. Aktivira se v trenutku, ko upravni odbor (Vorstand) potrdi tvojo prijavo. Imamo svojo e-poštno aplikacijo — pošiljaj in prejemaj šifrirana e-poštna sporočila, preprosto in brezplačno.';

  @override
  String get wizardErrInvalidEmail => 'Neveljaven e-poštni naslov';

  @override
  String get wizardStufe3OptionAlg1 =>
      'Prejemam Arbeitslosengeld I (ALG I, nadomestilo za brezposelnost)';

  @override
  String get wizardStufe3OptionKrankengeld =>
      'Prejemam Krankengeld (nadomestilo za dolgotrajno bolezen)';

  @override
  String get wizardStufe3UploadAddMore => 'Dodaj še en dokument';

  @override
  String get wizardStufe3UploadLimitCount =>
      'Dosežena meja: največ 20 dokumentov.';

  @override
  String get wizardStufe3UploadLimitTotal =>
      'Dosežena skupna meja 100 MB. Izbriši obstoječo datoteko.';

  @override
  String get wizardStufe3UploadDeleteTooltip => 'Izbriši';

  @override
  String wizardStufe3UploadCounter(int count, int max) {
    return '$count / $max dokumentov';
  }

  @override
  String get wizardDocumentExternalOpenFailed =>
      'Brskalnika ni bilo mogoče odpreti. Povezava je v odložišču — prilepi jo v brskalnik za nadaljevanje.';

  @override
  String get wizardFinalTimelineProcessing =>
      'Vorstand preverja · običajno 1 delovni dan, do 7';

  @override
  String get wizardFinalTimelineActivated => 'Račun aktiviran';

  @override
  String get wizardFinalAdultThank =>
      'Hvala, da si izpolnil prijavni obrazec! 🎉';

  @override
  String get wizardFinalAdultUsual =>
      'Tvoja vloga je pri nas. Običajno jo potrdimo v enem delovnem dnevu.';

  @override
  String get wizardFinalAdultExceptional =>
      'Včasih lahko traja do 7 delovnih dni. In če kaj ne ujema, te pošljemo nazaj v obrazec, da popraviš 🙂';

  @override
  String get wizardFinalStatusTitle => 'STANJE VLOGE';

  @override
  String wizardFinalStatusStepsValidated(int reviewed, int total) {
    return '$reviewed/$total korakov je potrdil Vorstand';
  }

  @override
  String get wizardFinalStufeSheetTitle => 'Podrobnosti vloge';

  @override
  String get wizardFinalStufeSheetHint =>
      '8 stopenj, ki si jih opravil. Vorstand jih pregleduje eno za drugo — v realnem času vidiš, kaj je že potrjeno.';

  @override
  String get wizardFinalStufeStatusPending => 'Čaka na pregled';

  @override
  String get wizardFinalStufeStatusApproved => 'Odobreno';

  @override
  String get wizardFinalStufeStatusRejected => 'Zavrnjeno';

  @override
  String wizardFinalStatusRejectionCount(int count) {
    return '$count korak potrebuje popravek';
  }

  @override
  String get wizardFinalStufeRejectionReason => 'Razlog Vorstanda:';

  @override
  String get wizardFinalStufeCorrectNow => 'Popravi zdaj';

  @override
  String wizardFinalApprovalsHeader(int current, int total) {
    return 'Odobritve Vorstanda ($current/$total)';
  }

  @override
  String get wizardFinalApprovalAwaiting => 'Čaka se 2. Vorstand';

  @override
  String get wizardFinalApprovalRejected => 'ZAVRNJENO';

  @override
  String get wizardFinalStufeNoDataYet => 'Podatki še niso na voljo.';

  @override
  String get wizardFinalStufeReadAt => 'Prebrano:';

  @override
  String get wizardFinalStufeBeitragsfrei =>
      'Oproščeno članarine (brez plačila)';

  @override
  String get wizardFinalStufeNotExempt => 'Brez socialnih pomoči';

  @override
  String get wizardFinalStufeBeginAtVerification => 'Začne se ob preverjanju';

  @override
  String get wizardFinalStufeBeginAtFoundation =>
      'Datum ustanovitve (za nazaj)';

  @override
  String get wizardFinalStufeBeginAtCustom => 'Drug datum';

  @override
  String get wizardFinalStufeStatusSkipped => 'Preskočeno';

  @override
  String get wizardFinalStufeFilledAt => 'Izpolnjeno:';

  @override
  String get wizardFinalStufeReviewedAt => 'Pregledano:';

  @override
  String get wizardFinalWithdrawLink => 'Umakni vlogo';

  @override
  String get wizardFinalWithdrawDialogTitle => 'Umakneš vlogo?';

  @override
  String get wizardFinalWithdrawDialogBody =>
      'Tvoja vloga bo označena kot umaknjena od tebe. Podatki ostanejo v bazi za revizijo (GDPR), a račun ne bo aktiviran. Prijavo lahko kadarkoli začneš znova z novo članarno številko.';

  @override
  String get wizardFinalWithdrawKeep => 'Ne, počakam';

  @override
  String get wizardFinalWithdrawConfirm => 'Da, umakni';

  @override
  String get wizardErrTooManyWithdrawals =>
      'Tvoje vloge ne moremo obdelati samodejno. Pokliči nas ali pridi osebno k Vorstandu, da nadaljuješ prijavo.';

  @override
  String get wizardDuplicateLoginTitle => 'Zdi se, da si že naš član';

  @override
  String get wizardDuplicateLoginBody =>
      'Z imenom in datumom rojstva že najdemo aktiven račun. Prosim, uporabi „Sem že član\" na začetnem zaslonu, da se prijaviš. Če nimaš več dostopa, pokliči nas.';

  @override
  String get wizardDuplicatePendingTitle => 'Tvoja vloga je že pri nas';

  @override
  String get wizardDuplicatePendingBody =>
      'Z imenom in datumom rojstva že imamo vlogo v obravnavi. Vorstand jo pregleduje — obvestili te bomo v aplikaciji, ko bo račun aktiven. Pokliči, če želiš pogovor.';

  @override
  String get wizardDuplicateRecentlyWithdrawnTitle =>
      'Trenutno te vloge ne moremo obravnavati';

  @override
  String get wizardDuplicateRecentlyWithdrawnBody =>
      'Tvoje ime in datum rojstva se ujemata z nedavno umaknjeno vlogo. Pokliči nas, da pred nadaljevanjem govoriš z Vorstandom.';

  @override
  String get wizardDuplicatePreviouslyWithdrawnTitle =>
      'Že prej si oddal vlogo';

  @override
  String get wizardDuplicatePreviouslyWithdrawnBody =>
      'Tvoje ime in datum rojstva se ujemata s starejšo vlogo, ki si jo umaknil. Dobrodošel nazaj — pokliči nas pred nadaljevanjem, da Vorstand odloči, kako naprej.';

  @override
  String get wizardDuplicateCallUsTitle => 'Prosim, pokliči nas';

  @override
  String get wizardDuplicateCallUsBody =>
      'Tvoje ime in datum rojstva že obstajata pri nas, vendar podrobnosti ne moremo deliti prek aplikacije. Pokliči nas — Vorstand bo situacijo razložil neposredno.';

  @override
  String get wizardChatHelp => 'Pogovorimo se';

  @override
  String get wizardChatHelpSubtitle =>
      'Klepet v živo z Vorstandom · hiter odgovor';

  @override
  String get benachrichtigungTitel => 'Opomniki po SMS';

  @override
  String get benachrichtigungIntro =>
      'Da ne bi zamudili termina, vam lahko društvo pošlje SMS. Vi se odločite, ali in za kaj — in to lahko kadar koli spremenite.';

  @override
  String get benachrichtigungTermineFrage =>
      'Želite prejemati opomnike o svojih terminih po SMS?';

  @override
  String get benachrichtigungTermineDetail =>
      'Sporočilo vsebuje datum, uro, kraj in zadevo termina.';

  @override
  String get benachrichtigungMedikamenteFrage =>
      'Želite opomnike tudi za svoja zdravila?';

  @override
  String get benachrichtigungMedikamenteDetail =>
      'Takrat je v sporočilu ime zdravila. To je zdravstveni podatek — zato vprašamo ločeno.';

  @override
  String get benachrichtigungHinweis =>
      'Opomnik je pomoč in ne jamstvo: prosimo, ne zanašajte se samo nanj. To lahko kadar koli spremenite v svojem profilu.';

  @override
  String get benachrichtigungJa => 'Da';

  @override
  String get benachrichtigungNein => 'Ne';

  @override
  String get benachrichtigungSpaeter => 'Odločim se pozneje';

  @override
  String get benachrichtigungSpeichern => 'Shrani';

  @override
  String get benachrichtigungGespeichert => 'Hvala, shranjeno.';

  @override
  String get benachrichtigungenLeer => 'Ni obvestil';

  @override
  String get benachrichtigungenAlleGelesen => 'Označi vse kot prebrano';

  @override
  String get benachrichtigungWetterFrage =>
      'Želite opozorilo ob neurju v kraju bivanja?';

  @override
  String get benachrichtigungWetterDetail =>
      'Samo uradna opozorila nemške vremenske službe od stopnje „hudo“ naprej — ne ob vsakem dežju.';

  @override
  String get signaturTitel => 'Podpisi';

  @override
  String get signaturNichtsOffen => 'Trenutno ni ničesar za podpis.';

  @override
  String get signaturStatusOffen => 'Čaka na vaš podpis';

  @override
  String get signaturStatusSigniert => 'Podpisali ste dokument';

  @override
  String get signaturStatusAbgelehnt => 'Zavrnili ste dokument';

  @override
  String get signaturStatusWiderrufen => 'Društvo je dokument umaknilo';

  @override
  String get signaturStatusAbgelaufen => 'Rok je potekel';

  @override
  String signaturBitteGanzLesen(int gelesen, int gesamt) {
    return 'Prosimo, preberite dokument do konca (stran $gelesen od $gesamt).';
  }

  @override
  String get signaturWeiterZurUnterschrift => 'Nadaljujte na podpis';

  @override
  String get signaturAblehnen => 'Zavrnite';

  @override
  String get signaturAblehnenHinweis =>
      'Društvo bo o tem obveščeno. Lahko navedete svoje razloge.';

  @override
  String get signaturAblehnenGrund => 'Razlog (neobvezno)';

  @override
  String get signaturMitFingerHinweis => 'Podpišite se s prstom v belem polju.';

  @override
  String get signaturNochmal => 'Še enkrat';

  @override
  String get signaturZurueckZumDokument => 'Nazaj na dokument';

  @override
  String get signaturCodeAnfordern => 'Zahtevajte kodo po SMS-u';

  @override
  String get signaturCodeUnterwegs => 'Koda je na poti.';

  @override
  String signaturCodeGesendetAn(String nummer) {
    return 'Kodo smo vam poslali na številko $nummer.';
  }

  @override
  String get signaturCodeErneutSenden => 'Pošljite kodo znova';

  @override
  String get signaturJetztUnterschreiben => 'Podpišite zdaj';

  @override
  String get signaturCodeFalsch => 'Koda ni pravilna.';

  @override
  String get signaturCodeAbgelaufen =>
      'Koda je potekla. Prosimo, zahtevajte novo.';

  @override
  String get signaturZuVieleVersuche =>
      'Preveč neuspešnih poskusov. Prosimo, zahtevajte novo kodo.';

  @override
  String get signaturKeineRufnummer =>
      'V vašem uporabniškem računu ni shranjene številke mobilnega telefona. Brez nje vam ne moremo poslati kode — prosimo, obrnite se na predsednika društva.';

  @override
  String get signaturCodeFehlgeschlagen => 'Kode ni bilo mogoče poslati.';

  @override
  String get signaturLeer => 'Prosimo, najprej se podpišite.';

  @override
  String get signaturErfolg => 'Hvala — vaš podpis smo prejeli.';

  @override
  String get signaturFehlgeschlagen =>
      'Ni uspelo. Prosimo, poskusite še enkrat.';

  @override
  String get signaturSiegelInArbeit =>
      'Žig se še pripravlja. Prosimo, poskusite znova čez eno minuto.';

  @override
  String get signaturWartetZweiteUnterschrift => 'Čaka se na drugi podpis';

  @override
  String get signaturWartenHinweis =>
      'Podpisali ste. Dokument bo opremljen z žigom, ko ga bo podpisala tudi druga oseba.';

  @override
  String get kontaktNochAktuell => 'Ali so ti podatki še vedno pravilni?';

  @override
  String get kontaktWarumFragen =>
      'Da ne bi česa zamudili, na kratko vprašamo vsake tri mesece. Prejeli boste šestmestno kodo.';

  @override
  String kontaktBestaetigtAm(Object datum) {
    return 'potrjeno $datum';
  }

  @override
  String get kontaktFestnetzKeinSms =>
      'To je številka stacionarnega telefona — SMS tja ne pride.';

  @override
  String get kontaktIstAndersGeworden => 'Se je spremenilo';

  @override
  String get themeTitle => 'Videz';

  @override
  String get themeLight => 'Svetlo';

  @override
  String get themeDark => 'Temno';

  @override
  String get themeSystem => 'Sledi napravi';

  @override
  String get themeSchedule => 'Samodejno (20:00–06:00)';

  @override
  String get themeScheduleHint =>
      'Temno od 20:00 do 6:00, preostanek dneva svetlo.';

  @override
  String get fernwartungTitel => 'Fernwartung';

  @override
  String get fernwartungSteuerungTitel => 'Steuerung erlauben';

  @override
  String get fernwartungSteuerungHinweis =>
      'Der Vorstand darf Ihr Gerät während einer Fernwartung bedienen. Sie stimmen jeder Sitzung einzeln zu; ohne Sitzung geschieht nichts. Der Dienst kann Ihren Bildschirm nicht lesen.';

  @override
  String get fernwartungSteuerungAktiv => 'Steuerung ist eingeschaltet';

  @override
  String get fernwartungAnfrageTitel => 'Zahteva za oddaljeno pomoč';

  @override
  String fernwartungAnfrageText(String name) {
    return '„$name\" želi videti in upravljati vaš zaslon, da vam pomaga. Brez vašega soglasja se ne prenaša nič.';
  }

  @override
  String get fernwartungAnfrageHinweis =>
      'Ves čas boste videli obvestilo in lahko kadar koli pritisnete „Ustavi\".';

  @override
  String get fernwartungErlauben => 'Dovoli';

  @override
  String get fernwartungAblehnen => 'Zavrni';

  @override
  String get fernwartungVerbindet => 'Povezovanje …';

  @override
  String get fernwartungAktiv => 'Vaš zaslon se deli';

  @override
  String get fernwartungStopp => 'Ustavi';

  @override
  String get fernwartungMikroAus => 'Izklopi mikrofon';

  @override
  String get fernwartungMikroAn => 'Vklopi mikrofon';
}
