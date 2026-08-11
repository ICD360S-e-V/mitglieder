// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Lithuanian (`lt`).
class AppLocalizationsLt extends AppLocalizations {
  AppLocalizationsLt([String locale = 'lt']) : super(locale);

  @override
  String get welcomeLoading => 'Kraunama...';

  @override
  String get welcomeAutoLogin => 'Automatinis prisijungimas...';

  @override
  String get login => 'Prisijungti';

  @override
  String get register => 'Registruotis';

  @override
  String get becomeMember => 'Tapkite nariu';

  @override
  String get memberNumber => 'Nario numeris';

  @override
  String get memberNumberHint => 'Įveskite nario numerį';

  @override
  String get confirmPassword => 'Patvirtinkite slaptažodį';

  @override
  String get confirmPasswordHint => 'Patvirtinkite slaptažodį';

  @override
  String get newPassword => 'Naujas slaptažodis';

  @override
  String get newPasswordHint => 'Įveskite naują slaptažodį';

  @override
  String get firstName => 'Vardas ir pavardė';

  @override
  String get firstNameHint => 'Įveskite vardą ir pavardę';

  @override
  String get nameMinLength => 'Vardas turi būti bent 2 simbolių';

  @override
  String get nameOnlyLetters => 'Leidžiamos tik raidės ir brūkšneliai';

  @override
  String get email => 'El. pašto adresas';

  @override
  String get emailHint => 'Įveskite el. paštą';

  @override
  String get emailInvalid => 'Įveskite galiojantį el. pašto adresą';

  @override
  String get passwordMinLength => 'Slaptažodis turi būti bent 6 simbolių';

  @override
  String get passwordsNotMatch => 'Slaptažodžiai nesutampa';

  @override
  String get registrationFailed => 'Registracija nepavyko';

  @override
  String connectionError(String error) {
    return 'Ryšio klaida: $error';
  }

  @override
  String registrationSuccess(String memberNumber) {
    return 'Registracija sėkminga!\n\nJūsų nario numeris: $memberNumber\n\nPrisiminkite šį numerį prisijungimui.';
  }

  @override
  String get unknown => 'Nežinoma';

  @override
  String error(String error) {
    return 'Klaida: $error';
  }

  @override
  String get cancel => 'Atšaukti';

  @override
  String get resetPassword => 'Atstatyti slaptažodį';

  @override
  String get imprint => 'Impressum';

  @override
  String get privacy => 'Privatumo politika';

  @override
  String get statutes => 'Įstatai';

  @override
  String get revocation => 'Atsisakymo teisė';

  @override
  String get appointments => 'Susitikimai';

  @override
  String get tickets => 'Užklausos';

  @override
  String get liveChat => 'Tiesioginis pokalbis';

  @override
  String get notifications => 'Pranešimai';

  @override
  String get myProfile => 'Mano Profilis';

  @override
  String get logout => 'Atsijungti';

  @override
  String get goodMorning => 'Labas rytas';

  @override
  String get goodDay => 'Laba diena';

  @override
  String get goodEvening => 'Labas vakaras';

  @override
  String get goodNight => 'Labos nakties';

  @override
  String get welcomeToICD => 'Sveiki atvykę į ICD360S e.V!';

  @override
  String get accountCreatedSuccessfully => 'Jūsų paskyra sėkmingai sukurta.';

  @override
  String get today => 'Šiandien';

  @override
  String get membershipFeeDue => 'Narystės mokestis mokėtinas';

  @override
  String get pleaseTransferAnnualFee => 'Prašome pervesti metinį mokestį.';

  @override
  String get newBadge => 'Naujas';

  @override
  String get close => 'Uždaryti';

  @override
  String get myAppointments => 'Mano susitikimai';

  @override
  String get priority => 'Prioritetas';

  @override
  String get messageLabel => 'Žinutė';

  @override
  String get reportProblems => 'Pranešti apie problemas';

  @override
  String get weRespondIn24Hours => 'Atsakysime per maksimaliai 24 valandas!';

  @override
  String get everythingOk => 'Viskas gerai!';

  @override
  String get haveProblemWeHelp => 'Turite problemą?\nMes pasirūpinsime!';

  @override
  String get myMembership => 'Mano narystė';

  @override
  String get managePersonalDataAndFee =>
      'Valdyti asmeninius duomenis ir mokestį';

  @override
  String get myAppointmentsTitle => 'Mano susitikimai';

  @override
  String get appointmentsDescription =>
      'Čia galite pamatyti savo būsimus susitikimus.\nGalite patvirtinti savo dalyvavimą arba atsisakyti.';

  @override
  String get loadAppointments => 'Įkelti susitikimus';

  @override
  String get myTickets => 'Mano prašymai';

  @override
  String get low => 'Žemas';

  @override
  String get high => 'Aukštas';

  @override
  String get submit => 'Pateikti';

  @override
  String get errorCreatingTicket => 'Klaida kuriant prašymą';

  @override
  String get verified => 'Patvirtinta';

  @override
  String get account => 'Paskyra';

  @override
  String get myDevices => 'Mano įrenginiai';

  @override
  String get changeEmail => 'Keisti el. paštą';

  @override
  String get changePassword => 'Keisti slaptažodį';

  @override
  String get saveEmail => 'Išsaugoti el. paštą';

  @override
  String get savePassword => 'Išsaugoti slaptažodį';

  @override
  String get deviceLoggedOut => 'Įrenginys atjungtas';

  @override
  String get emailChangedSuccessfully => 'El. paštas sėkmingai pakeistas';

  @override
  String get errorChangingPassword => 'Klaida keičiant slaptažodį';

  @override
  String get errorChangingEmail => 'Klaida keičiant el. paštą';

  @override
  String get validEmailRequired => 'Įveskite galiojantį el. pašto adresą';

  @override
  String get confirmLogoutDevice => 'Atjungti įrenginį?';

  @override
  String get confirmLogoutMessage =>
      'Ar norite atsijungti nuo šio įrenginio?\n\nTurėsite prisijungti iš naujo, kad galėtumėte naudoti šį įrenginį.';

  @override
  String get ipAddress => 'IP';

  @override
  String get platform => 'Platforma';

  @override
  String trialWarningUrgentTitle(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days dienų',
      few: '$days dienos',
      one: '1 diena',
    );
    return 'Dėmesio: Liko $_temp0 iki paskyros sustabdymo!';
  }

  @override
  String get trialWarningTitle => 'Jūsų paskyra dar nepatvirtinta';

  @override
  String get trialWarningDescription =>
      'Užpildykite savo duomenis skiltyje \"Mano profilis\". Po 30 dienų jūsų paskyra bus automatiškai sustabdyta.';

  @override
  String trialDaysRemaining(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days dienų',
      few: '$days dienos',
      one: '1 diena',
    );
    return '$_temp0';
  }

  @override
  String get overview => 'Apžvalga';

  @override
  String get member => 'Narys';

  @override
  String get memberManagement => 'Narių valdymas';

  @override
  String get reportProblemTooltip => 'Pranešti apie problemą';

  @override
  String get newAppointmentsTitle => 'Nauji susitikimai';

  @override
  String get youHaveNewAppointment => 'Turite naują susitikimą.';

  @override
  String youHaveNewAppointments(int count) {
    return 'Turite $count naujus susitikimus.';
  }

  @override
  String get appointmentReminderTomorrow => 'Priminimas: Susitikimas rytoj';

  @override
  String tomorrowAppointment(String title) {
    return 'Rytoj: $title';
  }

  @override
  String youHaveTomorrowAppointments(int count) {
    return 'Turite $count susitikimus rytoj.';
  }

  @override
  String get appointmentsToday => 'Susitikimai šiandien';

  @override
  String todayAppointment(String title) {
    return 'Šiandien: $title';
  }

  @override
  String youHaveTodayAppointments(int count) {
    return 'Turite $count susitikimus šiandien.';
  }

  @override
  String get paymentReminder => 'Mokėjimo priminimas';

  @override
  String paymentReminderMessage(int day, String method) {
    return 'Šiandien yra mėnesio $day diena – užbaikite $method.';
  }

  @override
  String get paymentDayLabel => 'Mokėjimo diena (mėnesinis priminimas)';

  @override
  String get updateAvailable => 'Yra naujinimas';

  @override
  String newVersionAvailable(String version) {
    return 'Yra nauja versija: $version';
  }

  @override
  String currentVersionLabel(String version) {
    return 'Dabartinė versija: $version';
  }

  @override
  String get changes => 'Pakeitimai:';

  @override
  String downloadProgress(String percent) {
    return 'Atsisiuntimas: $percent%';
  }

  @override
  String get installationStarting => 'Pradedama diegti...';

  @override
  String get appWillRestart => 'Programa bus automatiškai paleista iš naujo.';

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
  String get later => 'Vėliau';

  @override
  String get updateNow => 'Atnaujinti dabar';

  @override
  String get downloading => 'Atsisiunčiama...';

  @override
  String get downloadFailed => 'Atsisiuntimas nepavyko. Bandykite vėliau.';

  @override
  String get searchingForUpdates => 'Ieškoma naujinimų...';

  @override
  String get appUpToDate => 'Programa yra naujausia';

  @override
  String get updateCheckError => 'Klaida tikrinant naujinimus';

  @override
  String get changelog => 'Pakeitimų žurnalas';

  @override
  String get terminConfirmed => 'Susitikimas patvirtintas';

  @override
  String get terminDeclined => 'Susitikimas atmestas';

  @override
  String get terminRescheduleRequested => 'Prašoma perkelti';

  @override
  String get statusConfirmed => 'Patvirtinta';

  @override
  String get statusDeclined => 'Atmesta';

  @override
  String get statusRescheduling => 'Perkėlimas';

  @override
  String get statusPending => 'Laukiama';

  @override
  String get categoryVorstandssitzung => 'Valdybos posėdis';

  @override
  String get categoryMitgliederversammlung => 'Visuotinis susirinkimas';

  @override
  String get categorySchulung => 'Mokymai';

  @override
  String get categorySonstiges => 'Kita';

  @override
  String openCount(int count) {
    return '$count atvirų';
  }

  @override
  String get refresh => 'Atnaujinti';

  @override
  String get filterUpcoming => 'Artėjantys';

  @override
  String get filterPast => 'Praėję';

  @override
  String get filterAll => 'Visi';

  @override
  String get noUpcomingAppointments => 'Nėra artėjančių susitikimų';

  @override
  String get noPastAppointments => 'Nėra praėjusių susitikimų';

  @override
  String get noAppointmentsAvailable => 'Nėra susitikimų';

  @override
  String get appointmentsShownHere => 'Jūsų susitikimai bus rodomi čia';

  @override
  String get dateLabel => 'Data';

  @override
  String get timeLabel => 'Laikas';

  @override
  String get locationLabel => 'Vieta';

  @override
  String get createdByLabel => 'Sukūrė';

  @override
  String get descriptionLabel => 'Aprašymas';

  @override
  String get ticketLabel => 'Užklausa';

  @override
  String get yourStatus => 'Jūsų būsena: ';

  @override
  String reasonLabel(String reason) {
    return 'Priežastis: $reason';
  }

  @override
  String durationMinutes(int minutes) {
    return '$minutes min';
  }

  @override
  String get confirm => 'Patvirtinti';

  @override
  String get decline => 'Atmesti';

  @override
  String get reschedule => 'Perkelti';

  @override
  String get requestReschedule => 'Prašyti perkėlimo';

  @override
  String appointmentLabel(String title) {
    return 'Susitikimas: $title';
  }

  @override
  String get rescheduleReason => 'Perkėlimo priežastis *';

  @override
  String get rescheduleReasonHint => 'Nurodykite priežastį...';

  @override
  String get pleaseProvideReason => 'Nurodykite priežastį';

  @override
  String get request => 'Prašyti';

  @override
  String get ticketStatusOpen => 'Atidaryta';

  @override
  String get ticketStatusInProgress => 'Vykdoma';

  @override
  String get ticketStatusWaitingMember => 'Laukiama nario';

  @override
  String get ticketStatusWaitingStaff => 'Laukiama darbuotojo';

  @override
  String get ticketStatusWaitingAuthority => 'Laukiama institucijos';

  @override
  String get ticketStatusDone => 'Atlikta';

  @override
  String get ticketPriorityHigh => 'Aukštas';

  @override
  String get ticketPriorityMedium => 'Vidutinis';

  @override
  String get ticketPriorityLow => 'Žemas';

  @override
  String get comments => 'Komentarai';

  @override
  String get documents => 'Dokumentai';

  @override
  String get details => 'Informacija';

  @override
  String get replySent => 'Atsakymas išsiųstas';

  @override
  String get sendError => 'Siuntimo klaida';

  @override
  String get uploading => 'Įkeliama...';

  @override
  String fileUploaded(String filename) {
    return '$filename įkeltas';
  }

  @override
  String get uploadFailed => 'Įkėlimas nepavyko';

  @override
  String get openError => 'Atidarymo klaida';

  @override
  String get noRepliesYet => 'Dar nėra atsakymų';

  @override
  String get waitingForSupport => 'Laukiama palaikymo atsakymo';

  @override
  String get writeReply => 'Rašykite atsakymą...';

  @override
  String get attachFile => 'Prisegti failą';

  @override
  String documentsCount(int count) {
    return 'Dokumentai ($count)';
  }

  @override
  String get upload => 'Įkelti';

  @override
  String get noDocuments => 'Nėra dokumentų';

  @override
  String get allowedFormats => 'Leidžiami formatai: PDF, JPEG, JPG, TXT, ZIP';

  @override
  String get yourMessage => 'Jūsų žinutė:';

  @override
  String get translation => 'Vertimas';

  @override
  String get original => 'Originalas';

  @override
  String get originalText => 'Originalus tekstas';

  @override
  String get autoTranslated => 'Automatiškai išversta';

  @override
  String get originalTapTranslation => 'Originalas · Bakstelėkite vertimui';

  @override
  String get translatedTapOriginal => 'Išversta · Bakstelėkite originalui';

  @override
  String get justNow => 'Ką tik';

  @override
  String minutesAgo(int minutes) {
    return 'prieš $minutes min';
  }

  @override
  String hoursAgo(int hours) {
    return 'prieš $hours val';
  }

  @override
  String daysAgo(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'dienas',
      one: 'dieną',
    );
    return 'prieš $days $_temp0';
  }

  @override
  String get createdLabel => 'Sukurta';

  @override
  String get updatedLabel => 'Atnaujinta';

  @override
  String get handlerLabel => 'Atsakingas';

  @override
  String get doneLabel => 'Atlikta';

  @override
  String get newTicketTitle => 'Nauja užklausa';

  @override
  String get categoryOptional => 'Kategorija (neprivaloma)';

  @override
  String get selectCategory => 'Pasirinkite';

  @override
  String get subjectLabel => 'Tema';

  @override
  String get fillAllFields => 'Užpildykite visus laukus';

  @override
  String ticketCreatedId(int id) {
    return 'Užklausa #$id sukurta';
  }

  @override
  String get priorityLabel => 'Prioritetas: ';

  @override
  String get supportOffline => 'Palaikymas neprisijungęs';

  @override
  String get lastSeenSeconds => 'Aktyvus prieš kelias sekundes';

  @override
  String lastSeenMinutes(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: 'minutes',
      one: 'minutę',
    );
    return 'Aktyvus prieš $minutes $_temp0';
  }

  @override
  String lastSeenHours(int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: 'valandas',
      one: 'valandą',
    );
    return 'Aktyvus prieš $hours $_temp0';
  }

  @override
  String lastSeenDays(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'dienas',
      one: 'dieną',
    );
    return 'Aktyvus prieš $days $_temp0';
  }

  @override
  String get online => 'Prisijungęs';

  @override
  String get callSupport => 'Skambinti';

  @override
  String get typeMessage => 'Rašykite žinutę...';

  @override
  String get callBusy => 'Palaikymas užimtas';

  @override
  String get callRejected => 'Skambutis atmestas';

  @override
  String get callFailed => 'Skambučio nepavyko sujungti';

  @override
  String get callEnded => 'Skambutis baigtas';

  @override
  String get callSupportBusy => 'Palaikymas jau kitame skambutyje';

  @override
  String get errorStartingChat => 'Klaida paleidžiant pokalbį';

  @override
  String get errorStartingCall => 'Klaida paleidžiant skambutį';

  @override
  String get errorConnecting => 'Ryšio klaida';

  @override
  String get errorDownloading => 'Atsisiuntimo klaida';

  @override
  String get errorUploading => 'Įkėlimo klaida';

  @override
  String get errorSending => 'Siuntimo klaida';

  @override
  String get errorPickingPhotos => 'Klaida renkant nuotraukas';

  @override
  String get errorPickingFiles => 'Klaida renkant failus';

  @override
  String get errorTakingPhoto => 'Klaida fotografuojant';

  @override
  String get fileNotLoaded => 'Failo nepavyko įkelti';

  @override
  String get attachmentIdMissing => 'Trūksta priedo ID';

  @override
  String get camera => 'Kamera';

  @override
  String get gallery => 'Galerija';

  @override
  String get file => 'Failas';

  @override
  String get notifNewMessageFrom => 'Nauja žinutė nuo';

  @override
  String get notifUrgentPrefix => 'SKUBU';

  @override
  String get notifUrgentMessage => 'SKUBI ŽINUTĖ';

  @override
  String get notifIncomingCall => 'Gaunamasis skambutis';

  @override
  String get notifCallingYou => 'skambina...';

  @override
  String get notifUpdateAvailable => 'Yra naujinimas';

  @override
  String get notifVersionAvailable => 'jau prieinama';

  @override
  String get notifConnected => 'Prisijungta';

  @override
  String get notifDisconnected => 'Atjungta';

  @override
  String get notifConnectedBody => 'Esate prisijungęs prie serverio.';

  @override
  String get notifDisconnectedBody => 'Ryšys su serveriu nutrūko.';

  @override
  String get notifError => 'Klaida';

  @override
  String get retry => 'Bandyti dar kartą';

  @override
  String get save => 'Išsaugoti';

  @override
  String get accept => 'Priimti';

  @override
  String get selectFile => 'Pasirinkti failą';

  @override
  String get dataLoadingText => 'Kraunami duomenys...';

  @override
  String get dataSavedSuccess => 'Duomenys sėkmingai išsaugoti';

  @override
  String get errorSaving => 'Išsaugojimo klaida';

  @override
  String get errorLoading => 'Įkėlimo klaida';

  @override
  String savedFilename(String filename) {
    return 'Išsaugota: $filename';
  }

  @override
  String get logsCopied => 'Žurnalai nukopijuoti!';

  @override
  String get passwordMinEightChars => 'Slaptažodis turi būti bent 8 simbolių';

  @override
  String get passwordChangeSuccess => 'Slaptažodis sėkmingai pakeistas';

  @override
  String get emailChangeError => 'Klaida keičiant el. paštą';

  @override
  String get acceptDocumentCheckbox => 'Perskaičiau ir sutinku su dokumentu.';

  @override
  String loadingErrorGeneric(String details) {
    return 'Įkėlimo klaida: $details';
  }

  @override
  String get incomingCallTitle => 'Įeinantis skambutis';

  @override
  String ringingFor(int seconds) {
    return 'Skambina ${seconds}s';
  }

  @override
  String get rejectCall => 'Atmesti';

  @override
  String get acceptCall => 'Atsiliepti';

  @override
  String get unmute => 'Įjungti garsą';

  @override
  String get mute => 'Nutildyti';

  @override
  String get hangUp => 'Padėti ragelį';

  @override
  String get calling => 'Skambinama...';

  @override
  String autoRejectIn(int seconds) {
    return 'Automatinis atmetimas po $seconds sekundžių';
  }

  @override
  String get speakerOn => 'Garsiakalbis';

  @override
  String get speakerOff => 'Ausinė';

  @override
  String get micMuted => 'Nutildytas';

  @override
  String get micOn => 'Mikrofonas';

  @override
  String get connectionExcellent => 'Puiku';

  @override
  String get connectionGood => 'Geras';

  @override
  String get connectionWeak => 'Silpnas';

  @override
  String get connectionLost => 'Atsijungta';

  @override
  String get personalData => 'Asmens duomenys';

  @override
  String get personalDataSubtitle => 'Vardas, pavardė, adresas';

  @override
  String get membershipFee => 'Nario mokestis';

  @override
  String annualFeeYear(String year) {
    return 'Metinis mokestis $year';
  }

  @override
  String get amount => 'Suma:';

  @override
  String get dueBy => 'Terminas:';

  @override
  String get paid => 'Apmokėta';

  @override
  String get versionHistory => 'Versijų istorija';

  @override
  String lastUpdated(String date) {
    return 'Paskutinė atnaujinimas: $date';
  }

  @override
  String get noVersionHistory => 'Versijų istorija nepasiekiama';

  @override
  String get failedLoadChangelog => 'Nepavyko įkelti pakeitimų žurnalo';

  @override
  String get callMember => 'Skambinti nariui';

  @override
  String get closeConversation => 'Uždaryti pokalbį';

  @override
  String get chatOffline => 'Neprisijungęs';

  @override
  String get attachFiles => 'Prisegti failus (maks. 10, 50MB)';

  @override
  String get conversationClosed => 'Šis pokalbis buvo uždarytas';

  @override
  String get noMessages => 'Nėra žinučių';

  @override
  String get goBack => 'Atgal';

  @override
  String get goForward => 'Pirmyn';

  @override
  String get homePage => 'Pradžia';

  @override
  String get firstNameLabel => 'Vardas';

  @override
  String get lastNameLabel => 'Pavardė';

  @override
  String get streetLabel => 'Gatvė';

  @override
  String get houseNumberLabel => 'Nr.';

  @override
  String get postalCodeLabel => 'Pašto kodas';

  @override
  String get cityLabel => 'Miestas';

  @override
  String get phoneMobileLabel => 'Telefonas (Mobilus)';

  @override
  String get phoneLandlineLabel => 'Telefonas (Fiksuotasis)';

  @override
  String get newEmailLabel => 'Naujas el. pašto adresas';

  @override
  String get currentPasswordLabel => 'Dabartinis slaptažodis';

  @override
  String get newPasswordLabel => 'Naujas slaptažodis';

  @override
  String get confirmPasswordLabel => 'Patvirtinti slaptažodį';

  @override
  String get emailChangedSuccess => 'El. paštas pakeistas';

  @override
  String get reasonLabel2 => 'Priežastis';

  @override
  String get downloadFailed2 => 'Atsisiuntimas nepavyko';

  @override
  String get downloadTooltip => 'Atsisiųsti';

  @override
  String get copyLogs => 'Kopijuoti žurnalus';

  @override
  String get deleteLogs => 'Ištrinti žurnalus';

  @override
  String get autoScrollOn => 'Automatinis slinkimas ĮJ';

  @override
  String get autoScrollOff => 'Automatinis slinkimas IŠJ';

  @override
  String get unknownValue => 'Nežinoma';

  @override
  String get payment => 'Mokėjimas';

  @override
  String get warningType_ermahnung => 'Įspėjimas';

  @override
  String get warningType_abmahnung => 'Pastaba';

  @override
  String get warningType_letzte => 'Paskutinis įspėjimas';

  @override
  String warningsTotal(int count) {
    return 'Iš viso: $count';
  }

  @override
  String warningsErmahnung(int count) {
    return 'Įspėjimai: $count';
  }

  @override
  String warningsAbmahnung(int count) {
    return 'Pastabos: $count';
  }

  @override
  String warningsLetzte(int count) {
    return 'Paskutiniai: $count';
  }

  @override
  String get noWarnings => 'Nėra įspėjimų';

  @override
  String get noWarningsDescription => 'Šiuo metu neturite įspėjimų.';

  @override
  String createdBy(String name) {
    return 'Sukūrė: $name';
  }

  @override
  String get monthJan => 'Sau';

  @override
  String get monthFeb => 'Vas';

  @override
  String get monthMar => 'Kov';

  @override
  String get monthApr => 'Bal';

  @override
  String get monthMay => 'Geg';

  @override
  String get monthJun => 'Bir';

  @override
  String get monthJul => 'Lie';

  @override
  String get monthAug => 'Rgp';

  @override
  String get monthSep => 'Rgs';

  @override
  String get monthOct => 'Spa';

  @override
  String get monthNov => 'Lap';

  @override
  String get monthDec => 'Gru';

  @override
  String get stufe1_name => 'Asmens duomenys';

  @override
  String get stufe2_name => 'Narystės tipas';

  @override
  String get stufe3_name => 'Finansinė padėtis';

  @override
  String get stufe4_name => 'Mokėjimo būdas';

  @override
  String get stufe5_name => 'Narystės pradžia';

  @override
  String get stufe6_name => 'Įstatai';

  @override
  String get stufe7_name => 'Privatumo politika';

  @override
  String get stufe8_name => 'Teisė atšaukti';

  @override
  String get memberType_ordentlich => 'Tikrasis narys';

  @override
  String get memberType_foerder => 'Narys rėmėjas';

  @override
  String get memberType_ehren => 'Garbės narys';

  @override
  String get memberDesc_ordentlich =>
      'Aktyvus narys su balso teise. Dalyvauja asociacijos paslaugose (el. paštas, debesis, biurokratinė pagalba).';

  @override
  String get memberDesc_foerder =>
      'Remia asociaciją įmokomis. Gali dalyvauti visuotiniame susirinkime su patariamuoju balsu, be balsavimo teisės ar teisės būti išrinktam į valdybą.';

  @override
  String get memberDesc_ehren =>
      'Turi tikrojo nario teises be pareigos mokėti nario mokestį. Skiriamas visuotinio susirinkimo ar valdybos.';

  @override
  String get payMethod_ueberweisung => 'Bankinis pavedimas';

  @override
  String get payMethod_dauerauftrag => 'Nuolatinis pavedimas';

  @override
  String get verifyStatus_geprueft => 'Patikrinta';

  @override
  String get verifyStatus_ausgefuellt => 'Užpildyta';

  @override
  String get verifyStatus_abgelehnt => 'Atmesta';

  @override
  String get verifyStatus_offen => 'Atidaryta';

  @override
  String get fillRequiredFields => 'Užpildykite visus privalomus laukus.';

  @override
  String get personalDataSaved => 'Asmens duomenys išsaugoti';

  @override
  String get selectMemberType => 'Pasirinkite narystės tipą.';

  @override
  String get memberTypeSaved => 'Narystės tipas išsaugotas';

  @override
  String get selectOption => 'Pasirinkite variantą.';

  @override
  String get financialSaved => 'Finansinė padėtis išsaugota';

  @override
  String get selectPaymentMethod => 'Pasirinkite mokėjimo būdą.';

  @override
  String get paymentDataSaved => 'Mokėjimo duomenys išsaugoti';

  @override
  String get selectDate => 'Pasirinkite datą.';

  @override
  String get membershipStartSaved => 'Narystės pradžia išsaugota';

  @override
  String get fileTooLarge => 'Failas per didelis (maks. 10 MB).';

  @override
  String get leistungsbescheidUploaded => 'Išmokų pažyma sėkmingai įkelta';

  @override
  String get verificationProgress => 'Tikrinimo eiga';

  @override
  String get notApplicable => 'Netaikoma';

  @override
  String get socialBenefitsExempt =>
      'Mokėjimo būdas nereikalingas socialinių išmokų gavėjams.';

  @override
  String get locked => 'Užrakinta';

  @override
  String completePreviousStep(int step) {
    return 'Pirmiausia užbaikite žingsnį $step.';
  }

  @override
  String rejectedNote(String note) {
    return 'Atmesta: $note';
  }

  @override
  String get waitingForReview => 'Laukiama valdybos peržiūros.';

  @override
  String get stepApproved => 'Šis žingsnis buvo patikrintas ir patvirtintas.';

  @override
  String get changesViaChat => 'Pakeitimai galimi tik per pokalbį.';

  @override
  String get firstNameRequired => 'Vardas *';

  @override
  String get lastNameRequired => 'Pavardė *';

  @override
  String get birthDateLabel => 'Gimimo data *';

  @override
  String get streetRequired => 'Gatvė *';

  @override
  String get houseNumberRequired => 'Nr. *';

  @override
  String get cityRequired => 'Miestas *';

  @override
  String get phoneRequired => 'Telefono numeris *';

  @override
  String get phonePurpose =>
      'Paskirtis: Kontaktas, kai nepasiekiamas per programėlę';

  @override
  String get selectMemberTypePrompt => 'Pasirinkite norimą narystės tipą:';

  @override
  String get financialExplanation =>
      'Norėdami patikrinti, ar jums priklauso mokesčio sumažinimas, mums reikia šios informacijos. Ji bus naudojama tik jūsų nario mokesčiui nustatyti.';

  @override
  String get socialBenefitsQuestion =>
      'Ar šiuo metu gaunate socialines išmokas?';

  @override
  String get optionBuergergeld => 'Taip, piliečio pašalpa (Job Center)';

  @override
  String get optionSozialamt => 'Taip, socialinė parama (Socialinis skyrius)';

  @override
  String get optionNoBenefits => 'Ne, negaunu socialinių išmokų';

  @override
  String get feeExempt => 'Jūsų mėnesinis mokestis: 0,00 €/mėn.';

  @override
  String get uploadLeistungsbescheid => 'Įkelti išmokų pažymą';

  @override
  String get uploadLeistungsbescheidHint =>
      'Įkelkite aktualią išmokų pažymą per 14 dienų, kad patvirtintumėte atleidimą nuo mokesčio.';

  @override
  String get allowedFormatsUpload =>
      'Leidžiami formatai: PDF, JPG, PNG (maks. 10 MB)';

  @override
  String get feeRegular => 'Jūsų mėnesinis mokestis: 25,00 €/mėn.';

  @override
  String paymentDayReminder(int day) {
    return 'Jums bus priminta kiekvieno mėnesio $day dieną.';
  }

  @override
  String get membershipStartPrompt =>
      'Pasirinkite, kada turi prasidėti jūsų narystė.';

  @override
  String get optionAfterVerification => 'Po tikrinimo užbaigimo';

  @override
  String get optionAfterVerificationDesc =>
      'Narystė prasideda nuo valdybos patvirtinimo dienos.';

  @override
  String get optionRetroFoundation =>
      'Atgaline data nuo įkūrimo datos (01.08.2025)';

  @override
  String get optionRetroFoundationDesc =>
      'Tampate atgaline data nariu nuo asociacijos įkūrimo.';

  @override
  String get optionRetroCustom => 'Atgaline data iki kitos datos';

  @override
  String get optionRetroCustomDesc =>
      'Pasirinkite datą nuo 01.08.2025 iki šiandien.';

  @override
  String get selectDateLabel => 'Pasirinkite datą';

  @override
  String get selectDateHint => 'Pasirinkite datą...';

  @override
  String get dateNotBefore => 'Ne anksčiau nei 01.08.2025 (įkūrimo data)';

  @override
  String get feeExemptRetro =>
      'Atleidimas nuo mokesčio: 0,00 € atgaline data.\nTik narystės data nustatoma atgaline data.';

  @override
  String get retroactiveFees => 'Atgaliniai mokesčiai';

  @override
  String retroFeeCalculation(
      String from, String to, String months, String total) {
    return 'Laikotarpis: $from – $to\nMėnesiai: $months\nMokestis: $months × 25,00 € = $total €';
  }

  @override
  String get pleaseReadSatzung => 'Perskaitykite asociacijos įstatus.';

  @override
  String get pleaseReadDatenschutz => 'Perskaitykite privatumo politiką.';

  @override
  String get pleaseReadWiderruf => 'Perskaitykite teisę atšaukti.';

  @override
  String get acceptedAtRegistration => 'Priimta registracijos metu';

  @override
  String get confirmedByBoard => 'Bus patvirtinta po valdybos peržiūros.';

  @override
  String get docSatzung => 'Įstatai';

  @override
  String get docDatenschutz => 'Privatumo politika';

  @override
  String get docWiderruf => 'Teisė atšaukti';

  @override
  String acceptedAtRegCount(int count) {
    return 'Priimta registracijos metu ($count/3)';
  }

  @override
  String acceptedOn(String date) {
    return 'Priimta $date';
  }

  @override
  String get notAccepted => 'Nepriimta';

  @override
  String get statusAccepted => 'Priimta';

  @override
  String get nameTooLong => 'Vardas per ilgas (maks. 100 simbolių)';

  @override
  String get emailTooLong => 'El. paštas per ilgas (maks. 255 simbolių)';

  @override
  String get legalAcknowledgePrefix => 'Susipažinau su ';

  @override
  String get legalAcknowledgeSuffix => '.';

  @override
  String get legalStatutesSuffix =>
      ' ICD360S e.V. ir pripažįstu juos privalomais.';

  @override
  String get legalPleaseReadFirst => '(prašome pirmiausia perskaityti)';

  @override
  String get statusActive => 'Aktyvus';

  @override
  String get statusSuspended => 'Sustabdytas';

  @override
  String get statusNew => 'Naujas';

  @override
  String get statusCancelled => 'Atšauktas';

  @override
  String get statusDeleted => 'Ištrintas';

  @override
  String get roleMitglied => 'Narys';

  @override
  String get roleVorsitzer => 'Pirmininkas';

  @override
  String get roleStellvertreter => 'Pavaduotojas';

  @override
  String get roleSchatzmeister => 'Iždininkas';

  @override
  String get roleSchriftfuehrer => 'Sekretorius';

  @override
  String get roleBeisitzer => 'Posėdininkas';

  @override
  String get roleKassierer => 'Kasininkas';

  @override
  String get roleKassenpruefer => 'Revizorius';

  @override
  String get roleEhrenamtlich => 'Savanoris';

  @override
  String get roleMitgliedergruender => 'Narys steigėjas';

  @override
  String get roleEhrenmitglied => 'Garbės narys';

  @override
  String get roleFoerdermitglied => 'Rėmėjas narys';

  @override
  String get memberTypeNotSet => 'Dar nenustatyta';

  @override
  String get payMethodSepa => 'SEPA tiesioginis debetas';

  @override
  String get labelStatus => 'Būsena';

  @override
  String get labelMemberNumber => 'Nario numeris';

  @override
  String get labelRole => 'Rolė';

  @override
  String get labelMemberType => 'Narystės tipas';

  @override
  String get labelPaymentMethod => 'Mokėjimo būdas';

  @override
  String get labelRegisteredOn => 'Registruota';

  @override
  String get labelLastLogin => 'Paskutinis prisijungimas';

  @override
  String get labelMemberSince => 'Narys nuo';

  @override
  String get neverLoggedIn => 'Niekada';

  @override
  String get notActivatedYet => 'Dar neaktyvuota';

  @override
  String get tabVerification => 'Patvirtinimas';

  @override
  String get tabWarnings => 'Įspėjimai';

  @override
  String get tabDocuments => 'Dokumentai';

  @override
  String get tabMembership => 'Narystė';

  @override
  String get pleaseEnterFirstName => 'Įveskite vardą';

  @override
  String get pleaseEnterLastName => 'Įveskite pavardę';

  @override
  String get noFileDataReceived => 'Duomenys negauti';

  @override
  String get openFile => 'Atidaryti';

  @override
  String get noMicrophoneError =>
      'Mikrofonas nerastas. Prijunkite mikrofoną ir bandykite dar kartą.';

  @override
  String get startConversation => 'Pradėkite pokalbį!';

  @override
  String get staffWillReply => 'Darbuotojas netrukus jums atsakys.';

  @override
  String get inCall => 'Skambutyje...';

  @override
  String get registration => 'Registracija';

  @override
  String get deactivation => 'Deaktyvavimas';

  @override
  String get deactivatedOn => 'Deaktyvuota';

  @override
  String get accountAutoSuspend =>
      'Paskyros, nepatvirtintos per 30 dienų, bus automatiškai sustabdytos.';

  @override
  String get documentsProvidedByBoard => 'Dokumentus teikia valdyba.';

  @override
  String get noDocumentsAvailable => 'Dokumentų nėra';

  @override
  String get noDocumentsDescription => 'Jums dar nepateikta dokumentų.';

  @override
  String uploadedBy(String name) {
    return 'Įkėlė: $name';
  }

  @override
  String stepsCompleted(int completed, int total) {
    return '$completed/$total žingsnių atlikta';
  }

  @override
  String dayOfMonth(int day) {
    return 'Mėnesio $day d.';
  }

  @override
  String changeField(String field) {
    return 'Keisti $field';
  }

  @override
  String openDocument(String name) {
    return 'Atidaryti $name';
  }

  @override
  String logEntries(int count) {
    return '$count įrašų';
  }

  @override
  String get noLogs => 'Nėra žurnalų';

  @override
  String get newLoginDetected => 'Aptiktas naujas prisijungimas';

  @override
  String get errorNoInternet =>
      'Nėra interneto ryšio. Patikrinkite savo tinklą.';

  @override
  String get errorTimeout => 'Serveris neatsako. Bandykite vėliau.';

  @override
  String get errorServer => 'Serverio klaida. Bandykite vėliau.';

  @override
  String get errorConnection => 'Ryšio klaida. Bandykite vėliau.';

  @override
  String get errorUnexpected => 'Įvyko netikėta klaida. Bandykite vėliau.';

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
  String get claudiuWelcomeMorning => 'Labas rytas';

  @override
  String get claudiuWelcomeDay => 'Sveiki';

  @override
  String get claudiuWelcomeEvening => 'Labas vakaras';

  @override
  String get claudiuWelcomeNight => 'Labas vakaras';

  @override
  String get claudiuWelcomeVisitor => 'gerbiamas svečias';

  @override
  String get claudiuWelcomeAsk => 'Kaip galiu padėti?';

  @override
  String get claudiuWelcomeBecomeMember => 'Noriu tapti nariu';

  @override
  String get claudiuWelcomeLogin => 'Jau esu narys ir noriu prisijungti';

  @override
  String get claudiuWelcomeProblem => 'Turiu problemą su programėle';

  @override
  String get claudiuWelcomeEmergency => 'Skubu — paskambinkite';

  @override
  String get claudiuWelcomeMascotName => 'Claudiu';

  @override
  String get claudiuWelcomeEmergencyIntro =>
      'Prieš skambindami — mūsų darbo valandos:';

  @override
  String get claudiuWelcomeScheduleOffice => 'Biure';

  @override
  String get claudiuWelcomeScheduleField => 'Lauke su klientais';

  @override
  String get claudiuWelcomeOutsideHoursNote =>
      'Ne darbo valandomis priimame tik skubius atvejus. Galite atsiųsti SMS tuo pačiu numeriu — susisieksime.';

  @override
  String get claudiuWelcomeCallNow => 'Skambinti dabar';

  @override
  String get claudiuWelcomeSendSms => 'Siųsti SMS';

  @override
  String get claudiuWelcomeSmsBody =>
      'Skubu ICD360S e.V. — prašau susisiekite kuo greičiau.';

  @override
  String get claudiuWelcomeCloseButton => 'Uždaryti';

  @override
  String get claudiuLoginWelcome => 'Sveikas sugrįžęs, mielas nary!';

  @override
  String get claudiuLoginAsk => 'Prašau pasakyk savo nario numerį.';

  @override
  String get claudiuLoginProgress => 'Beveik… toliau rašyk.';

  @override
  String get claudiuLoginReady => 'Puiku! Paspausk mygtuką žemiau.';

  @override
  String get claudiuLoginLoading => 'Tikrinu tapatybę… 🔍';

  @override
  String get claudiuLoginFoundPlain => 'Suradau tave! Jungiu…';

  @override
  String claudiuLoginFoundNamed(String name) {
    return 'Suradau tave, $name! Jungiu…';
  }

  @override
  String get claudiuLoginError =>
      'Hmm, šio numerio neradau. Ar teisingai įvedei?';

  @override
  String get claudiuLoginForgotHeader => 'Pamiršai nario numerį?';

  @override
  String get claudiuLoginNoSms =>
      'Numerio nesiunčiame el. paštu ar SMS žinute.';

  @override
  String get claudiuLoginOnlyWay =>
      'Vienintelis būdas: asmeniškas susitikimas asociacijos biure, patikrinus asmens dokumentą.';

  @override
  String get claudiuLoginContactUs => 'Skambink dėl susitikimo:';

  @override
  String get claudiuDiagnosticGreeting => 'Prieš įeinant, vienas klausimas';

  @override
  String get claudiuDiagnosticAsk =>
      'Ar galiu siųsti anoniminius pranešimus, kad kūrėjai patobulintų programėlę?';

  @override
  String get claudiuDiagnosticYes => 'Taip, noriu padėti';

  @override
  String get claudiuDiagnosticNo => 'Ne, tik apžiūrinėju';

  @override
  String get claudiuDiagnosticTellMore => 'Papasakok daugiau';

  @override
  String get claudiuDiagnosticSendsHeader => '📤 Ką SIUNČIAME (anonimiškai):';

  @override
  String get claudiuDiagnosticSends1 =>
      'Anoniminis įrenginio kodas (NE nario numeris)';

  @override
  String get claudiuDiagnosticSends2 => 'Tavo vaidmuo (narys / valdyba)';

  @override
  String get claudiuDiagnosticSends3 =>
      'Operacinė sistema (Linux / Android / iOS / Windows)';

  @override
  String get claudiuDiagnosticSends4 => 'Pasirinkta kalba';

  @override
  String get claudiuDiagnosticSends5 => 'Baterijos lygis ir būsena';

  @override
  String get claudiuDiagnosticSends6 => 'Dabartinis ekranas';

  @override
  String get claudiuDiagnosticSends7 => 'Sesijos trukmė (sekundėmis)';

  @override
  String get claudiuDiagnosticSends8 => 'Klaidos, jei yra (paskutinės 10)';

  @override
  String get claudiuDiagnosticSends9 => 'Navigacija (paskutinių 20 ekranų)';

  @override
  String get claudiuDiagnosticNeverHeader => '🛡️ Ko NIEKADA nesiunčiame:';

  @override
  String get claudiuDiagnosticNever1 => 'Tavo tikrasis vardas';

  @override
  String get claudiuDiagnosticNever2 => 'El. pašto adresas';

  @override
  String get claudiuDiagnosticNever3 => 'Telefono numeris';

  @override
  String get claudiuDiagnosticNever4 => 'Slaptažodis';

  @override
  String get claudiuDiagnosticNever5 => 'Pokalbio žinučių turinys';

  @override
  String get claudiuDiagnosticNever6 => 'Bilietų turinys';

  @override
  String get claudiuDiagnosticNever7 => 'Dokumentai ar priedai';

  @override
  String get claudiuDiagnosticTechHeader => '📡 Techninės detalės:';

  @override
  String get claudiuDiagnosticTech1 => 'Siunčiama kas 2 minutes';

  @override
  String get claudiuDiagnosticTech2 =>
      'TLS-šifruotas ryšys su prisegtu sertifikatu';

  @override
  String get claudiuDiagnosticTech3 => 'Bet kada gali išjungti Nustatymuose';

  @override
  String get claudiuProblemHelpTitle => 'Kaip galiu padėti?';

  @override
  String get claudiuProblemHelpGreeting => 'Kas atsitiko?';

  @override
  String get claudiuProblemHelpAsk => 'Kaip nori man papasakoti?';

  @override
  String get claudiuProblemHelpWriteTitle => 'Rašyti pranešimą';

  @override
  String get claudiuProblemHelpWriteBody =>
      'Su žingsnis po žingsnio detalėmis. Komanda gauna tekstą ir vėliau išsprendžia.';

  @override
  String get claudiuProblemHelpChatTitle => 'Pakalbėkime dabar';

  @override
  String get claudiuProblemHelpChatBody =>
      'Anoniminis pokalbis su operatoriumi. Atsakymas realiu laiku, jei kažkas prisijungęs.';

  @override
  String get claudiuProblemHelpAltCallHeader => 'Arba, jei skubu:';

  @override
  String get claudiuProblemHelpAltCallLabel => 'Skambinti';

  @override
  String get claudiuAnonymousChatTitle => 'Anoniminis pokalbis';

  @override
  String get claudiuAnonymousChatGreeting => 'Sveiki!';

  @override
  String get claudiuAnonymousChatWelcome =>
      'Klausau. Rašyk ką nori — vardo nereikia. Atsakysiu kai tik būsiu.';

  @override
  String get claudiuAnonymousChatHint => 'Parašyk žinutę…';

  @override
  String get claudiuAnonymousChatWaitingOperator =>
      'Laukiame operatoriaus atsakymo…';

  @override
  String get claudiuVorsitzerConnectedTitle => 'Sveiki!';

  @override
  String get claudiuVorsitzerConnectedBody =>
      'Ačiū, kad parašei — dabar esi susisiekęs su Vorsitzeriu. Pasakyk, kuo galime padėti dėl narystės paraiškos.';

  @override
  String get claudiuVorsitzerConnectedSender => 'Vorsitzer';

  @override
  String get claudiuQuickReplyValidationTime => 'Kiek užtrunka patikrinimas?';

  @override
  String get claudiuQuickReplyDocuments => 'Kokių dokumentų man reikia?';

  @override
  String get claudiuQuickReplyStepProblem => 'Įstrigau prie vieno žingsnio';

  @override
  String get claudiuQuickReplyHuman => 'Ar galiu dabar pakalbėti su kuo nors?';

  @override
  String get claudiuAnonymousChatConnecting => 'Jungiamasi…';

  @override
  String get claudiuAnonymousChatConnectionFailed =>
      'Nepavyko atidaryti pokalbio. Pabandyk dar kartą arba paskambink.';

  @override
  String get claudiuAnonymousChatRetry => 'Bandyti vėl';

  @override
  String get claudiuAnonymousChatOnline => 'Prisijungta';

  @override
  String get claudiuAnonymousChatOffline => 'Jungiamasi iš naujo…';

  @override
  String get claudiuAnonymousChatAdminTyping => 'Operatorius rašo…';

  @override
  String get claudiuProblemReportTitle => 'Pranešk apie problemą';

  @override
  String get claudiuProblemReportGreeting => 'Kas atsitiko?';

  @override
  String get claudiuProblemReportAsk =>
      'Papasakok detaliai ir aš perduosiu pranešimą komandai.';

  @override
  String get claudiuProblemReportIncludeHeader => 'Prašom įtraukti:';

  @override
  String get claudiuProblemReportIncludeBullets1 =>
      'Ką darei, kai atsirado problema';

  @override
  String get claudiuProblemReportIncludeBullets2 =>
      'Bet kokį klaidos pranešimą, kurį matei';

  @override
  String get claudiuProblemReportIncludeBullets3 => 'Kuriame ekrane buvai';

  @override
  String get claudiuProblemReportIncludeBullets4 =>
      'Ar programėlė lūžta, užsidaro ar rodo baltą ekraną?';

  @override
  String get claudiuProblemReportIncludeBullets5 =>
      'Ar tai nutinka kiekvieną kartą, ar tik kartą?';

  @override
  String get claudiuProblemReportDescriptionLabel => 'Tavo aprašymas';

  @override
  String get claudiuProblemReportDescriptionHint =>
      'Pvz.: Atidarius pokalbio ekraną pasirodo žinutė „Connection error\" ir programėlė nustoja reaguoti…';

  @override
  String claudiuProblemReportTooShort(int count) {
    return 'Truputį daugiau detalių, prašau (bent $count simbolių)';
  }

  @override
  String get claudiuProblemReportSubmit => 'Siųsti pranešimą';

  @override
  String get claudiuProblemReportSubmitting => 'Siunčiama…';

  @override
  String get claudiuProblemReportSentTitle => 'Ačiū!';

  @override
  String get claudiuProblemReportSentBody =>
      'Pranešimas išsiųstas. Mūsų komanda jį peržiūrės kuo greičiau.';

  @override
  String get claudiuProblemReportSentClose => 'Aišku';

  @override
  String get claudiuProblemReportSendFailed =>
      'Pranešimo išsiųsti nepavyko. Skambink dėl skubios pagalbos.';

  @override
  String get claudiuProblemReportAlt => 'Arba, jei skubu:';

  @override
  String get claudiuProblemReportCallLabel => 'Skambinti';

  @override
  String claudiuApprovalGreeting(String name) {
    return 'Sveikas, $name! 👋';
  }

  @override
  String get claudiuApprovalGreetingNoName => 'Sveikas! 👋';

  @override
  String get claudiuApprovalGladToSeeYou => 'Džiaugiuosi, kad atėjai!';

  @override
  String get claudiuApprovalCheckingForSafety =>
      'Tavo saugumui Vorsitzer dabar tikrina tavo prisijungimo prašymą. 🛡️';

  @override
  String get claudiuApprovalMonthlyExplain =>
      '💡 Tai darome kas 30 dienų, kad būtume tikri, jog tai tikrai tu. Tai kaip saugumo patikrinimas — maksimum 5 minutės.';

  @override
  String get claudiuApprovalSuccess =>
      'Atlikta! 🎉 Vorsitzer tave atpažino. Jungiu…';

  @override
  String get claudiuApprovalDenied => 'Hmm, Vorsitzer atmetė tavo prašymą. 😔';

  @override
  String get claudiuApprovalDeniedHelp =>
      'Jei manai, kad tai klaida, paskambink, kad išsiaiškintume.';

  @override
  String get claudiuApprovalExpired =>
      'Praėjo 5 minutės ir Vorsitzer neatsakė.';

  @override
  String get claudiuApprovalExpiredHelp =>
      'Skambink ir galėsime patvirtinti tavo prašymą vietoje. 📞';

  @override
  String get claudiuApprovalCallUs => 'Skambinti';

  @override
  String get claudiuApprovalTryAgain => 'Bandyti vėl';

  @override
  String get claudiuApprovalCancel => 'Atšaukti';

  @override
  String get claudiuApprovalClose => 'Uždaryti';

  @override
  String get wizardIntroBubble1 =>
      'Sveikas, lankytojau! 👋 Ačiū, kad nori prisijungti prie mūsų šeimos.';

  @override
  String get wizardIntroBubble2 =>
      'Mano vardas Claudiu. 2025 m. pavasarį turėjau aiškią viziją: sukurti asociaciją, kuri padeda žmonėms, kuriems reikia pagalbos — savanoriškai, iš širdies, be nereikalingos biurokratijos. ❤️';

  @override
  String get wizardIntroBubble3 =>
      'Pradėjau kalbėtis su klientais, kuriuos lankydavau. Papasakojau jiems savo svajonę. Ir kiekvienas pasakė: „Taip, eime!\" 2025 m. liepą susitikome — 6 ryžtingi žmonės. Nusprendėme įkurti **ICD360S e.V.** Neu-Ulme. 📍';

  @override
  String get wizardIntroBubble4 =>
      '**2025 m. rugpjūčio 1 d.** asociacija oficialiai atgijo — Asociacijų registre. Pati gražiausia mano dovana. 🎂';

  @override
  String get wizardIntroBubble5 =>
      'Ką darome? Padedame pabėgėliams, neįgaliesiems, ekonomiškai pažeidžiamiems, **vaikams ir jaunimui** — administraciniais klausimais, vokiečių kalba, būstu, apsipirkimu, socialinėmis išmokomis. Mūsų Vorstand sudaro daugiausia neįgalūs žmonės — taip sprendimai kyla iš tikros gyvenimo patirties. 🤝';

  @override
  String get wizardIntroBubble6 =>
      'Dabar tavo eilė. Užregistruosime tave — tai užtruks apie 5 minutes. Eisime žingsnis po žingsnio, tavęs vieno nepaliksiu. ✨';

  @override
  String get wizardIntroStart => 'Pradėkime';

  @override
  String get wizardBack => 'Atgal';

  @override
  String get wizardNext => 'Toliau';

  @override
  String wizardStepLabel(int step, int total, String title) {
    return '$step žingsnis iš $total · $title';
  }

  @override
  String get wizardErrRequired => 'Šis laukas privalomas';

  @override
  String wizardErrTooShort(int count) {
    return 'Per trumpa (bent $count simbolių)';
  }

  @override
  String get wizardErrOnlyLetters =>
      'Tik raidės, tarpai, brūkšneliai ir apostrofai';

  @override
  String get wizardErrSaveFailed =>
      'Nepavyko išsaugoti. Patikrink ryšį ir bandyk dar kartą.';

  @override
  String get wizardStufe1aTitle => 'Tapatybė';

  @override
  String get wizardStufe1aPrompt =>
      'Susipažinkime oficialiai. Įrašyk savo vardą tiksliai taip, kaip yra Personalausweis, Reisepass arba Aufenthaltstitel dokumente — kad sutaptų su tavo dokumentais.';

  @override
  String get wizardStufe1aVornameLabel => 'Vornamen (vardai)';

  @override
  String get wizardStufe1aVornameHelper =>
      'Visi tavo vardai tiksliai kaip dokumente. Su tarpu arba brūkšneliu (pvz. Hans-Peter, Maria Anna).';

  @override
  String get wizardStufe1aNachnameLabel => 'Familienname (pavardė)';

  @override
  String get wizardStufe1aNachnameHelper => 'Dabartinė tavo pavardė.';

  @override
  String get wizardStufe1aGeburtsnameLabel =>
      'Geburtsname (gimimo pavardė) — neprivaloma';

  @override
  String get wizardStufe1aGeburtsnameHelper =>
      'Tik jei skiriasi nuo Familienname — pvz. iki santuokos.';

  @override
  String get wizardStufe1bTitle => 'Gimtadienis';

  @override
  String get wizardStufe1bPrompt =>
      'Norėtume švęsti tavo gimtadienį kartu! 🎂 Ir mums padeda patikrinti, kad tau bent 16 — taip rašoma mūsų įstatuose.';

  @override
  String get wizardStufe1bGeburtsdatumLabel => 'Gimimo data';

  @override
  String get wizardStufe1bGeburtsdatumHelper =>
      'Bakstelėk, kad pasirinktum datą';

  @override
  String get wizardStufe1bGeburtsortLabel => 'Gimimo vieta';

  @override
  String get wizardStufe1bGeburtsortHelper => 'Miestas / vietovė, kur gimei.';

  @override
  String get wizardAgeGatePrompt => 'Atsiprašau… 😔';

  @override
  String wizardAgeGateBody1(int age, int years) {
    return 'Mūsų įstatai sako, kad nariui reikia turėti bent 16 metų. Tau $age — tikiuosi pasimatysime po $years metų! 🌱';
  }

  @override
  String get wizardAgeGateBody2 =>
      'Jei nori savanoriauti retkarčiais (bet kuriame amžiuje, su tėvų sutikimu), paskambink — mums patinka palaikyti jaunimą, kuris nori keisti pasaulį.';

  @override
  String get wizardAgeGateBackHome => 'Atgal į pradžią';

  @override
  String get wizardErrInvalidPhone => 'Neteisingas telefono numeris';

  @override
  String get wizardStufe1b1Title => 'Tėvų sutikimas';

  @override
  String get wizardStufe1b1Prompt =>
      'Esi nepilnametis (16-17) — pagal §106 BGB mums reikia tėvų ar globėjo sutikimo. Pasakyk vardą ir telefono numerį. Vorsitzer paskambins ir susitars dėl susitikimo (asmeniškai arba per vaizdo skambutį). Be el. pašto — norime būti tikri, kad kalbamės su tikru žmogumi.';

  @override
  String get wizardStufe1b1VornameLabel => 'Tėvo / motinos vardas';

  @override
  String get wizardStufe1b1VornameHelper =>
      'Kaip tėvo / motinos Personalausweis.';

  @override
  String get wizardStufe1b1NachnameLabel => 'Tėvo / motinos pavardė';

  @override
  String get wizardStufe1b1NachnameHelper =>
      'Kaip tėvo / motinos Personalausweis.';

  @override
  String get wizardStufe1b1TelefonLabel => 'Tėvo / motinos mobilus';

  @override
  String get wizardStufe1b1TelefonHelper => 'Į šį numerį skambins Vorsitzer.';

  @override
  String get wizardStufe1b1RelationLabel => 'Santykis su vaiku:';

  @override
  String get wizardStufe1b1RelationMutter => 'Motina';

  @override
  String get wizardStufe1b1RelationVater => 'Tėvas';

  @override
  String get wizardStufe1b1RelationSorgeberechtigter => 'Teisinis globėjas';

  @override
  String get wizardStufe1b1RelationAndere => 'Kitas globėjas';

  @override
  String get wizardStufe1cTitle => 'Asmens duomenys';

  @override
  String get wizardStufe1cPrompt =>
      'Tiesiog kad geriau tave pažinčiau. Tai liks tarp mūsų ir niekur viešai nebus rodoma.';

  @override
  String get wizardStufe1cGeschlechtLabel => 'Lytis';

  @override
  String get wizardStufe1cGeschlechtMaennlich => 'Vyras';

  @override
  String get wizardStufe1cGeschlechtWeiblich => 'Moteris';

  @override
  String get wizardStufe1cGeschlechtDivers => 'Kita';

  @override
  String get wizardStufe1cGeschlechtKeineAngabe => 'Nenoriu sakyti';

  @override
  String get wizardStufe1cFamilienstandLabel => 'Šeiminė padėtis';

  @override
  String get wizardStufe1cFamilienstandLedig => 'Nevedęs / Netekėjusi';

  @override
  String get wizardStufe1cFamilienstandVerheiratet => 'Vedęs / Ištekėjusi';

  @override
  String get wizardStufe1cFamilienstandGeschieden => 'Išsiskyręs / Išsiskyrusi';

  @override
  String get wizardStufe1cFamilienstandVerwitwet => 'Našlys / Našlė';

  @override
  String get wizardStufe1dTitle => 'Tavo kilmė';

  @override
  String get wizardStufe1dPrompt =>
      'Tai padeda mums pasiūlyti tinkamą pagalbą — pavyzdžiui konsultaciją dėl Aufenthalt arba rasti tavo kalbinę bendruomenę.';

  @override
  String get wizardStufe1dStaatLabel => 'Pilietybė';

  @override
  String get wizardStufe1dStaatHelper =>
      'Pvz. deutsch, rumänisch, ukrainisch. Kelias atskirti kableliais.';

  @override
  String get wizardStufe1dAufenthaltLabel =>
      'Buvimo statusas (Aufenthaltsstatus) — neprivaloma';

  @override
  String get wizardStufe1dAufenthaltHelper =>
      'Pasirink titulą iš savo Aufenthaltskarte / sprendimo. Vorstand jį sutikrina su tavo dokumentais.';

  @override
  String get wizardStufe1dAufenthaltAwaitingCitizenship =>
      'Pirma viršuje įvesk pilietybę — parodysime tik tinkamas parinktis.';

  @override
  String get wizardStufe1dAufenthaltGerman =>
      'Aufenthaltstitel nereikia — Vokietijos pilietis.';

  @override
  String get wizardStufe1dAufenthaltEuEea =>
      'ES/EEE/CH pilietis — laisvas judėjimas (Freizügigkeit).';

  @override
  String get wizardStufe1dAufenthaltTempHint => 'laikinas';

  @override
  String get wizardStufe1dAufenthaltPermHint => 'nuolatinis gyvenimas';

  @override
  String get wizardStufe1dAufenthaltAsylumProcessHint =>
      'prieglobsčio procedūra';

  @override
  String get wizardStufe1dAufenthaltOther => 'Kita (patikslink pokalbyje)';

  @override
  String get wizardStufe1dAufenthaltRequired =>
      'Prašau pasirink Aufenthaltstitel.';

  @override
  String get wizardStufe1dMutterspracheLabel => 'Gimtoji kalba';

  @override
  String get wizardStufe1dMutterspracheHelper =>
      'Iš anksto užpildyta programos kalba — pakeisk jei kita.';

  @override
  String get wizardStufe1eTitle => 'Adresas';

  @override
  String get wizardStufe1ePrompt =>
      'Tavo pašto adresas — naudojame jį oficialiems dokumentams (įstatai, narystės sutartys, pranešimai).';

  @override
  String get wizardStufe1eStrasseLabel => 'Gatvė';

  @override
  String get wizardStufe1eStrasseHelper =>
      'Tik gatvės pavadinimas — numeris šalia esančiame laukelyje.';

  @override
  String get wizardStufe1eHausnummerLabel => 'Nr.';

  @override
  String get wizardStufe1ePlzLabel => 'PLZ (pašto kodas)';

  @override
  String get wizardStufe1eOrtLabel => 'Miestas';

  @override
  String get wizardStufe1eLandLabel => 'Šalis';

  @override
  String get wizardStufe1eLandHelper => 'Iš anksto užpildyta: Deutschland.';

  @override
  String get wizardErrInvalidStreet => 'Neteisingas gatvės pavadinimas';

  @override
  String get wizardErrInvalidHausnummer =>
      'Neteisingas numeris (pvz. 12, 12a, 12/3)';

  @override
  String get wizardErrInvalidPlz => 'Neteisingas pašto kodas (tik skaitmenys)';

  @override
  String get wizardStufe1fTitle => 'Kontaktas';

  @override
  String get wizardStufe1fPrompt =>
      'Kaip su tavimi susisiekti? Telefonas — tik kritiniais atvejais. Visa kita vyksta mūsų pačių abipusiu šifravimu apsaugotu kanalu programėlėje. Tavo nario el. paštas priskiriamas automatiškai ir matomas žemiau.';

  @override
  String get wizardStufe1fTelefonLabel => 'Mobilus telefonas';

  @override
  String get wizardStufe1fTelefonHelper =>
      'Žadu, skambinsiu tik tada, kai bus svarbu. 📱';

  @override
  String get wizardStufe2Title => 'Narystės tipas';

  @override
  String get wizardStufe2Prompt =>
      'Kokiu nariu nori būti? Paaiškinsiu kiekvieną variantą.';

  @override
  String get wizardStufe2OrdentlichTitle => 'Tikrasis narys (ordentlich)';

  @override
  String get wizardStufe2OrdentlichBody =>
      'Pilnos teisės. Moki mėnesinį mokestį, balsuoji visuotiniame susirinkime, gali būti išrinktas į valdybą. Standartinis pasirinkimas.';

  @override
  String get wizardStufe2FoerderTitle => 'Remiantis narys (Fördermitglied)';

  @override
  String get wizardStufe2FoerderBody =>
      'Remi asociaciją finansiškai, bet aktyviai nedalyvauji sprendimuose. Be balsavimo teisės. Gera, jei nori padėti iš toli.';

  @override
  String get wizardStufe2EhrenTitle => 'Garbės narys (Ehrenmitglied)';

  @override
  String get wizardStufe2EhrenBody =>
      'Skiriama valdybos už ypatingus nuopelnus. Pats nesirinki — gauni kaip pripažinimą. Pasirink tik jei jau buvai pagerbtas.';

  @override
  String get wizardStufe3Title => 'Finansinė padėtis';

  @override
  String get wizardStufe3Prompt =>
      'Dabar apie tavo finansinę padėtį. Ne tam, kad teisčiau — kad atleisčiau nuo mokesčio, jei gauni socialinę paramą.';

  @override
  String get wizardStufe3OptionBuergergeld => 'Gaunu Bürgergeld';

  @override
  String get wizardStufe3OptionSozialamt => 'Gaunu išmokas iš Sozialamto';

  @override
  String get wizardStufe3OptionNein => 'Negaunu nė vienos';

  @override
  String get wizardStufe3FeeExemptTitle => 'Mokestis: 0 € / mėn. 🎉';

  @override
  String get wizardStufe3FeeExemptBody =>
      'Su Bürgergeldu, Sozialamtu, ALG I ar Krankengeldu pagal Satzung §6 esi visiškai atleistas nuo mokesčio. Mums tereikia įrodymo (Leistungsbescheid arba pažymos iš institucijos / sveikatos draudimo kasos).';

  @override
  String get wizardStufe3UploadTitle => 'Įkelti Leistungsbescheid';

  @override
  String get wizardStufe3UploadHint => 'PDF / JPG / PNG, iki 10 MB.';

  @override
  String get wizardStufe3UploadRequired =>
      'Prieš tęsiant, įkelk Leistungsbescheid.';

  @override
  String get wizardStufe3FileTooLarge =>
      'Failas per didelis. Daugiausia 10 MB.';

  @override
  String get wizardStufe3UploadFailed =>
      'Nepavyko įkelti failo. Bandyk dar kartą.';

  @override
  String get wizardStufe3RegularFeeTitle => 'Mokestis: 25 € / mėn.';

  @override
  String get wizardStufe3RegularFeeBody =>
      'Standartinis mokestis tikriesiems nariams pagal įstatus.';

  @override
  String get wizardStufe4Title => 'Mokėjimas';

  @override
  String get wizardStufe4Prompt =>
      'Kaip nori mokėti mokestį? Ir kurią mėnesio dieną tau patogiausia?';

  @override
  String get wizardStufe4MethodUeberweisungTitle =>
      'Bankinis pavedimas (Überweisung)';

  @override
  String get wizardStufe4MethodUeberweisungBody =>
      'Pats pradedi mokėjimą kiekvieną mėnesį iš savo sąskaitos.';

  @override
  String get wizardStufe4MethodSepaTitle =>
      'SEPA-Lastschrift (tiesioginis debetas)';

  @override
  String get wizardStufe4MethodSepaBody =>
      'Sumą automatiškai nuskaitome iš tavo sąskaitos. Patogiausia, bet reikia IBAN ir pasirašyto įgaliojimo.';

  @override
  String get wizardStufe4MethodDauerauftragTitle =>
      'Dauerauftrag (nuolatinis pavedimas)';

  @override
  String get wizardStufe4MethodDauerauftragBody =>
      'Banke nustatai nuolatinį pavedimą. Bankas kas mėnesį automatiškai perveda sumą.';

  @override
  String get wizardStufe4DayLabel => 'Mokėjimo diena';

  @override
  String get wizardStufe4DayHint => 'Pasirink dieną nuo 1 iki 31';

  @override
  String wizardStufe4DayItem(int day) {
    return '$day d.';
  }

  @override
  String wizardStufe4DayReminder(int day) {
    return 'Mokestis bus nuskaitomas $day-ą kiekvieno mėnesio dieną.';
  }

  @override
  String get wizardStufe5Title => 'Pradžia';

  @override
  String get wizardStufe5Prompt =>
      'Nuo kada nori būti oficialiu ICD360S nariu? Nuo patvirtinimo arba atgaline data.';

  @override
  String get wizardStufe5OptionAbVerifizierungTitle =>
      'Nuo Vorstand patvirtinimo';

  @override
  String get wizardStufe5OptionAbVerifizierungBody =>
      'Paprasčiausias pasirinkimas. Be atgalinio mokesčio.';

  @override
  String get wizardStufe5OptionGruendungsdatumTitle =>
      'Atgaline data nuo 2025-08-01 (įsteigimas)';

  @override
  String get wizardStufe5OptionGruendungsdatumBody =>
      'Būsi laikomas nariu nuo pirmosios asociacijos dienos.';

  @override
  String get wizardStufe5OptionAnderesDatumTitle => 'Kita data';

  @override
  String get wizardStufe5OptionAnderesDatumBody =>
      'Pats pasirinki datą tarp 2025-08-01 ir šios dienos.';

  @override
  String get wizardStufe5PickDate => 'Bakstelėk, kad pasirinktum datą';

  @override
  String get wizardStufe5PickDateFirst => 'Pirmiausia pasirinki datą.';

  @override
  String get wizardStufe5DatePickerHelp => 'Narystės pradžia';

  @override
  String wizardStufe5DateRange(String start) {
    return 'Tarp $start ir šios dienos';
  }

  @override
  String get wizardStufe5RetroactiveTitle => 'Atgalinis mokestis';

  @override
  String wizardStufe5RetroactiveBody(
      String start, String end, int months, String amount) {
    return 'Nuo $start iki $end yra $months mėn. Po 25 €/mėn. tai sudaro $amount € atgaline data, papildomai prie esamo mėnesinio mokesčio.';
  }

  @override
  String get wizardStufe5FeeExemptTitle => 'Atgalinis mokestis: 0 € 🎉';

  @override
  String get wizardStufe5FeeExemptBody =>
      'Su Bürgergeld arba Sozialamt esi visiškai atleistas — net atgaline data nieko nesi skolingas.';

  @override
  String wizardDocumentPrompt(String doc) {
    return 'Prieš užbaigiant, atidžiai perskaityk $doc. Svarbu žinoti, ką pasirašai.';
  }

  @override
  String get wizardDocumentScrollHint => 'Slink iki galo, kad galėtum tęsti.';

  @override
  String get wizardDocumentScrolledOk => 'Perskaitei iki galo ✓';

  @override
  String wizardDocumentOpenButton(String doc) {
    return 'Atidaryti $doc naršyklėje';
  }

  @override
  String get wizardDocumentExternalHint =>
      'Šioje platformoje atidarome dokumentą tavo numatytojoje naršyklėje.';

  @override
  String get wizardDocumentOpenedOk =>
      'Dokumentas atidarytas. Atidžiai jį perskaityk.';

  @override
  String wizardDocumentConfirm(String doc) {
    return 'Patvirtinu, kad perskaičiau ir sutinku su $doc.';
  }

  @override
  String get wizardFinalAdultTitle => 'Atlikta! Esi užregistruotas 🎉';

  @override
  String get wizardFinalMinorTitle => 'Tavo prašymas išsiųstas 📨';

  @override
  String get wizardFinalMinorBody =>
      'Susisieksime su tavo tėvu/motina ir suderinsime susitikimą (asmeniškai arba per vaizdo skambutį). Prašom kantrybės — procesas gali užtrukti iki 7 dienų. Gausi pranešimą programėlėje, kai tik tėvas/motina patvirtins.';

  @override
  String get wizardFinalMitgliedernummerLabel => 'Tavo nario numeris';

  @override
  String get wizardStufe4MethodComingSoon => 'Netrukus';

  @override
  String get wizardStufe4StreichungWarning =>
      'Jei vėluosi su mokesčiu daugiau nei 6 mėnesius, automatiškai tave išbraukiame (Satzung §6 Abs. 3).';

  @override
  String get wizardStufe5KuendigungInfo =>
      'Norėdamas išstoti: atsiųsk mums pranešimą raštu likus 3 mėnesiams iki gruodžio 31 d. (iki rugsėjo 30 d., kad įsigaliotų metų gale). Minimalaus laikotarpio nėra (Satzung §6 Abs. 3).';

  @override
  String get wizardStufe1fEmailLabel => 'Tavo nario el. paštas';

  @override
  String get wizardStufe1fEmailHelper =>
      'Priskiriamas automatiškai pagal tavo nario numerį. Aktyvuojamas tą akimirką, kai valdyba (Vorstand) patvirtina tavo paraišką. Turime savo el. pašto programėlę — siųsk ir gauk užšifruotus el. laiškus, paprasta ir nemokama.';

  @override
  String get wizardErrInvalidEmail => 'Neteisingas el. pašto adresas';

  @override
  String get wizardStufe3OptionAlg1 =>
      'Gaunu Arbeitslosengeld I (ALG I, nedarbo išmoką)';

  @override
  String get wizardStufe3OptionKrankengeld =>
      'Gaunu Krankengeld (ilgalaikės ligos pašalpą)';

  @override
  String get wizardStufe3UploadAddMore => 'Pridėti dar dokumentą';

  @override
  String get wizardStufe3UploadLimitCount =>
      'Pasiekta riba: ne daugiau kaip 20 dokumentų.';

  @override
  String get wizardStufe3UploadLimitTotal =>
      'Pasiekta bendra 100 MB riba. Ištrink esamą failą.';

  @override
  String get wizardStufe3UploadDeleteTooltip => 'Ištrinti';

  @override
  String wizardStufe3UploadCounter(int count, int max) {
    return '$count / $max dokumentų';
  }

  @override
  String get wizardDocumentExternalOpenFailed =>
      'Nepavyko atidaryti naršyklės. Nuoroda nukopijuota į iškarpinę — įklijuok ją naršyklėje, kad tęstum.';

  @override
  String get wizardFinalTimelineProcessing =>
      'Vorstand tikrina · paprastai 1 darbo diena, iki 7';

  @override
  String get wizardFinalTimelineActivated => 'Paskyra aktyvuota';

  @override
  String get wizardFinalAdultThank =>
      'Ačiū, kad užpildei registracijos formą! 🎉';

  @override
  String get wizardFinalAdultUsual =>
      'Tavo prašymas pas mus. Paprastai jį patvirtiname per vieną darbo dieną.';

  @override
  String get wizardFinalAdultExceptional =>
      'Kartais tai gali užtrukti iki 7 darbo dienų. O jei kažkas neatitinka, grąžinsime tave į formą, kad pataisytum 🙂';

  @override
  String get wizardFinalStatusTitle => 'PRAŠYMO BŪSENA';

  @override
  String wizardFinalStatusStepsValidated(int reviewed, int total) {
    return '$reviewed/$total žingsnių patvirtino Vorstand';
  }

  @override
  String get wizardFinalStufeSheetTitle => 'Prašymo informacija';

  @override
  String get wizardFinalStufeSheetHint =>
      '8 etapai, kuriuos užpildei. Vorstand juos tikrina po vieną — realiu laiku matai, kas patvirtinta.';

  @override
  String get wizardFinalStufeStatusPending => 'Laukia patikrinimo';

  @override
  String get wizardFinalStufeStatusApproved => 'Patvirtinta';

  @override
  String get wizardFinalStufeStatusRejected => 'Atmesta';

  @override
  String wizardFinalStatusRejectionCount(int count) {
    return '$count žingsnis reikalauja pataisymo';
  }

  @override
  String get wizardFinalStufeRejectionReason => 'Vorstando priežastis:';

  @override
  String get wizardFinalStufeCorrectNow => 'Taisyti dabar';

  @override
  String wizardFinalApprovalsHeader(int current, int total) {
    return 'Vorstando patvirtinimai ($current/$total)';
  }

  @override
  String get wizardFinalApprovalAwaiting => 'Laukiama 2-ojo Vorstando';

  @override
  String get wizardFinalApprovalRejected => 'ATMESTA';

  @override
  String get wizardFinalStufeNoDataYet => 'Duomenys dar neprieinami.';

  @override
  String get wizardFinalStufeReadAt => 'Perskaityta:';

  @override
  String get wizardFinalStufeBeitragsfrei =>
      'Atleista nuo mokesčio (mokėti nereikia)';

  @override
  String get wizardFinalStufeNotExempt => 'Be socialinių išmokų';

  @override
  String get wizardFinalStufeBeginAtVerification => 'Pradedama patvirtinus';

  @override
  String get wizardFinalStufeBeginAtFoundation =>
      'Įsteigimo data (atgaline data)';

  @override
  String get wizardFinalStufeBeginAtCustom => 'Kita data';

  @override
  String get wizardFinalStufeStatusSkipped => 'Praleista';

  @override
  String get wizardFinalStufeFilledAt => 'Užpildyta:';

  @override
  String get wizardFinalStufeReviewedAt => 'Patikrinta:';

  @override
  String get wizardFinalWithdrawLink => 'Atšaukti prašymą';

  @override
  String get wizardFinalWithdrawDialogTitle => 'Atšaukti prašymą?';

  @override
  String get wizardFinalWithdrawDialogBody =>
      'Tavo prašymas bus pažymėtas kaip atšauktas tavęs. Duomenys lieka duomenų bazėje audito tikslais (GDPR), bet paskyra nebus aktyvuota. Registraciją gali pradėti iš naujo bet kada su nauju nario numeriu.';

  @override
  String get wizardFinalWithdrawKeep => 'Ne, palauksiu';

  @override
  String get wizardFinalWithdrawConfirm => 'Taip, atšaukti';

  @override
  String get wizardErrTooManyWithdrawals =>
      'Tavo prašymas negali būti apdorotas automatiškai. Paskambink mums arba ateik asmeniškai pas Vorstandą, kad tęstum registraciją.';

  @override
  String get wizardDuplicateLoginTitle => 'Atrodo, kad jau esi mūsų narys';

  @override
  String get wizardDuplicateLoginBody =>
      'Pagal tavo vardą ir gimimo datą jau randame aktyvią paskyrą. Pagrindiniame ekrane pasirink \"Jau esu narys\", kad prisijungtum. Jei prieigos nebėra, paskambink.';

  @override
  String get wizardDuplicatePendingTitle => 'Tavo prašymas jau pas mus';

  @override
  String get wizardDuplicatePendingBody =>
      'Pagal tavo vardą ir gimimo datą jau turime svarstomą prašymą. Vorstand jį tikrina — pranešime programėlėje, kai paskyra taps aktyvi. Paskambink, jei nori pasikalbėti.';

  @override
  String get wizardDuplicateRecentlyWithdrawnTitle =>
      'Šiuo metu negalime apdoroti šio prašymo';

  @override
  String get wizardDuplicateRecentlyWithdrawnBody =>
      'Tavo vardas ir gimimo data sutampa su neseniai atšauktu prašymu. Paskambink, kad pasikalbėtum su Vorstand prieš tęsdamas.';

  @override
  String get wizardDuplicatePreviouslyWithdrawnTitle =>
      'Anksčiau jau buvai pateikęs prašymą';

  @override
  String get wizardDuplicatePreviouslyWithdrawnBody =>
      'Tavo vardas ir gimimo data sutampa su senesniu prašymu, kurį buvai atšaukęs. Sveikas grįžęs — paskambink prieš tęsdamas, kad Vorstand nuspręstų, kaip elgsimės.';

  @override
  String get wizardDuplicateCallUsTitle => 'Prašome, paskambink';

  @override
  String get wizardDuplicateCallUsBody =>
      'Tavo vardas ir gimimo data jau yra mūsų įrašuose, bet detalių per programėlę pateikti negalime. Paskambink — Vorstand paaiškins situaciją tiesiogiai.';

  @override
  String get wizardChatHelp => 'Pasikalbėkim';

  @override
  String get wizardChatHelpSubtitle =>
      'Tiesioginis pokalbis su Vorstand · greitas atsakymas';

  @override
  String get benachrichtigungTitel => 'SMS priminimai';

  @override
  String get benachrichtigungIntro =>
      'Kad nepraleistumėte susitikimo, asociacija gali atsiųsti jums SMS žinutę. Jūs nusprendžiate, ar ir dėl ko — ir galite tai bet kada pakeisti.';

  @override
  String get benachrichtigungTermineFrage =>
      'Ar norite gauti priminimus apie savo susitikimus SMS žinute?';

  @override
  String get benachrichtigungTermineDetail =>
      'Žinutėje nurodoma susitikimo data, laikas, vieta ir tema.';

  @override
  String get benachrichtigungMedikamenteFrage =>
      'Ar norite priminimų ir apie savo vaistus?';

  @override
  String get benachrichtigungMedikamenteDetail =>
      'Tada žinutėje nurodomas vaisto pavadinimas. Tai sveikatos duomenys — todėl klausiame atskirai.';

  @override
  String get benachrichtigungHinweis =>
      'Priminimas yra pagalba, o ne garantija: prašome nesiremti vien juo. Tai galite bet kada pakeisti savo profilyje.';

  @override
  String get benachrichtigungJa => 'Taip';

  @override
  String get benachrichtigungNein => 'Ne';

  @override
  String get benachrichtigungSpaeter => 'Nuspręsti vėliau';

  @override
  String get benachrichtigungSpeichern => 'Išsaugoti';

  @override
  String get benachrichtigungGespeichert => 'Ačiū, išsaugota.';

  @override
  String get benachrichtigungenLeer => 'Pranešimų nėra';

  @override
  String get benachrichtigungenAlleGelesen => 'Žymėti visus kaip perskaitytus';

  @override
  String get benachrichtigungWetterFrage =>
      'Ar norite įspėjimų apie audrą jūsų gyvenamojoje vietoje?';

  @override
  String get benachrichtigungWetterDetail =>
      'Tik oficialūs Vokietijos meteorologijos tarnybos įspėjimai nuo „stipraus“ lygio — ne per kiekvieną lietų.';

  @override
  String get signaturTitel => 'Parašai';

  @override
  String get signaturNichtsOffen =>
      'Šiuo metu nėra nieko, ką reikėtų pasirašyti.';

  @override
  String get signaturStatusOffen => 'Laukiama Jūsų parašo';

  @override
  String get signaturStatusSigniert => 'Jūsų pasirašyta';

  @override
  String get signaturStatusAbgelehnt => 'Jūsų atmesta';

  @override
  String get signaturStatusWiderrufen => 'Asociacijos atšaukta';

  @override
  String get signaturStatusAbgelaufen => 'Terminas pasibaigė';

  @override
  String signaturBitteGanzLesen(int gelesen, int gesamt) {
    return 'Prašome perskaityti dokumentą iki galo (puslapis $gelesen iš $gesamt).';
  }

  @override
  String get signaturWeiterZurUnterschrift => 'Pereiti prie pasirašymo';

  @override
  String get signaturAblehnen => 'Atmesti';

  @override
  String get signaturAblehnenHinweis =>
      'Apie tai bus pranešta asociacijai. Galite nurodyti savo priežastis.';

  @override
  String get signaturAblehnenGrund => 'Priežastis (neprivaloma)';

  @override
  String get signaturMitFingerHinweis =>
      'Pasirašykite pirštu baltame laukelyje.';

  @override
  String get signaturNochmal => 'Dar kartą';

  @override
  String get signaturZurueckZumDokument => 'Atgal į dokumentą';

  @override
  String get signaturCodeAnfordern => 'Gauti kodą SMS žinute';

  @override
  String get signaturCodeUnterwegs => 'Kodas jau siunčiamas.';

  @override
  String signaturCodeGesendetAn(String nummer) {
    return 'Išsiuntėme Jums kodą telefono numeriu $nummer.';
  }

  @override
  String get signaturCodeErneutSenden => 'Siųsti kodą dar kartą';

  @override
  String get signaturJetztUnterschreiben => 'Pasirašyti dabar';

  @override
  String get signaturCodeFalsch => 'Kodas neteisingas.';

  @override
  String get signaturCodeAbgelaufen =>
      'Kodas nebegalioja. Prašome gauti naują kodą.';

  @override
  String get signaturZuVieleVersuche =>
      'Per daug nesėkmingų bandymų. Prašome gauti naują kodą.';

  @override
  String get signaturKeineRufnummer =>
      'Jūsų paskyroje nenurodytas mobiliojo telefono numeris. Be jo negalime Jums išsiųsti kodo — prašome kreiptis į asociacijos pirmininką.';

  @override
  String get signaturCodeFehlgeschlagen => 'Kodo išsiųsti nepavyko.';

  @override
  String get signaturLeer => 'Pirmiausia prašome pasirašyti.';

  @override
  String get signaturErfolg => 'Ačiū — Jūsų parašas gautas.';

  @override
  String get signaturFehlgeschlagen => 'Nepavyko. Prašome pabandyti dar kartą.';

  @override
  String get signaturSiegelInArbeit =>
      'Antspaudas dar ruošiamas. Prašome pabandyti dar kartą po minutės.';

  @override
  String get signaturWartetZweiteUnterschrift => 'Laukiama antrojo parašo';

  @override
  String get signaturWartenHinweis =>
      'Jūs pasirašėte. Dokumentui bus uždėtas antspaudas, kai tik jį pasirašys ir antrasis asmuo.';
}
