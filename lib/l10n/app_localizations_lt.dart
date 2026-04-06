// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Lithuanian (`lt`).
class AppLocalizationsLt extends AppLocalizations {
  AppLocalizationsLt([String locale = 'lt']) : super(locale);

  @override
  String get appTitle => 'ICD360S e.V - Narių portalas';

  @override
  String get memberPortal => 'Narių portalas';

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
  String get password => 'Slaptažodis';

  @override
  String get passwordHint => 'Įveskite slaptažodį';

  @override
  String get confirmPassword => 'Patvirtinkite slaptažodį';

  @override
  String get confirmPasswordHint => 'Patvirtinkite slaptažodį';

  @override
  String get newPassword => 'Naujas slaptažodis';

  @override
  String get newPasswordHint => 'Įveskite naują slaptažodį';

  @override
  String get saveCredentials => 'Išsaugoti prisijungimo duomenis';

  @override
  String get autoLogin => 'Automatinis prisijungimas';

  @override
  String get forgotPassword => 'Pamiršote slaptažodį?';

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
  String get recoveryCode => 'Atkūrimo kodas (6 skaitmenys)';

  @override
  String get recoveryCodeHelper =>
      'Prisiminkite šį kodą slaptažodžio atkūrimui';

  @override
  String get recoveryCodeHint => 'Įveskite atkūrimo kodą';

  @override
  String get recoveryCodeInvalid => 'Kodas turi būti lygiai 6 skaitmenų';

  @override
  String get loginFailed => 'Prisijungimas nepavyko';

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
  String get tooManyDevices => 'Per daug įrenginių';

  @override
  String get maxDevicesMessage =>
      'Jau esate prisijungę 3 įrenginiuose.\nPasirinkite įrenginį atsijungimui:';

  @override
  String get unknownDevice => 'Nežinomas įrenginys';

  @override
  String get unknown => 'Nežinoma';

  @override
  String get logoutError => 'Atsijungimo klaida';

  @override
  String error(String error) {
    return 'Klaida: $error';
  }

  @override
  String get cancel => 'Atšaukti';

  @override
  String get resetPassword => 'Atstatyti slaptažodį';

  @override
  String get forgotPasswordTitle => 'Pamirštas slaptažodis';

  @override
  String get forgotPasswordDescription =>
      'Įveskite savo nario numerį ir registracijos metu sukurtą atkūrimo kodą.';

  @override
  String get passwordResetSuccess =>
      'Slaptažodis atstatytas!\n\nDabar galite prisijungti su nauju slaptažodžiu.';

  @override
  String get passwordResetFailed => 'Slaptažodžio atstatymas nepavyko';

  @override
  String get needHelp => 'Reikia pagalbos?';

  @override
  String get helpQuestion => 'Problemos su prisijungimu ar registracija?';

  @override
  String get helpDescription =>
      'Susisiekite su mumis per WhatsApp ir aprašykite, kas neveikia. Atsakysime kuo greičiau!';

  @override
  String get whatsapp => 'WhatsApp';

  @override
  String get emailSubject => 'Užklausa per ICD360S programėlę';

  @override
  String get whatsappMessage =>
      'Sveiki, turiu problemą su ICD360S programėle. ';

  @override
  String get imprint => 'Impressum';

  @override
  String get privacy => 'Privatumo politika';

  @override
  String get statutes => 'Įstatai';

  @override
  String get revocation => 'Atsisakymo teisė';

  @override
  String get cancellation => 'Atšaukimas';

  @override
  String get allRightsReserved => 'Visos teisės saugomos.';

  @override
  String get enterCredentials => 'Įveskite nario numerį ir slaptažodį';

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
  String get membership => 'Narystė';

  @override
  String get myAppointments => 'Mano susitikimai';

  @override
  String get appointmentsLoadingReady =>
      'Įkeliami susitikimai - API paruoštas!';

  @override
  String get priority => 'Prioritetas';

  @override
  String get messageLabel => 'Žinutė';

  @override
  String get createdOn => 'Sukurta';

  @override
  String get handler => 'Tvarkyklė';

  @override
  String get reportProblems => 'Pranešti apie problemas';

  @override
  String get reportProblem => 'Pranešti apie problemą';

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
  String get newTicket => 'Naujas prašymas';

  @override
  String get noOpenTickets => 'Nėra atvirų prašymų';

  @override
  String get haveQuestionCreateTicket =>
      'Turite klausimą ar problemą?\nSukurkite naują prašymą.';

  @override
  String get whatIsTheProblem => 'Kokia problema?';

  @override
  String get describeTheProblem => 'Aprašykite problemą';

  @override
  String get howUrgentIsIt => 'Kiek skubu?';

  @override
  String get low => 'Žemas';

  @override
  String get medium => 'Vidutinis';

  @override
  String get high => 'Aukštas';

  @override
  String get submit => 'Pateikti';

  @override
  String get fillSubjectAndMessage => 'Užpildykite temą ir žinutę';

  @override
  String get ticketCreated => 'Prašymas sukurtas';

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
  String get newEmailAddress => 'Naujas el. pašto adresas';

  @override
  String get currentPassword => 'Dabartinis slaptažodis';

  @override
  String get saveEmail => 'Išsaugoti el. paštą';

  @override
  String get savePassword => 'Išsaugoti slaptažodį';

  @override
  String get deviceLoggedOut => 'Įrenginys atjungtas';

  @override
  String get passwordChangedSuccessfully => 'Slaptažodis sėkmingai pakeistas';

  @override
  String get emailChangedSuccessfully => 'El. paštas sėkmingai pakeistas';

  @override
  String get errorChangingPassword => 'Klaida keičiant slaptažodį';

  @override
  String get errorChangingEmail => 'Klaida keičiant el. paštą';

  @override
  String get validEmailRequired => 'Įveskite galiojantį el. pašto adresą';

  @override
  String get passwordTooShort => 'Slaptažodis turi būti bent 6 simbolių';

  @override
  String get maxDevicesReached =>
      'Esate prisijungę prie maksimaliai 3 įrenginių.';

  @override
  String loggedInOnDevices(int count) {
    return 'Esate prisijungę prie $count iš 3 įrenginių.';
  }

  @override
  String get noActiveSessions => 'Nėra aktyvių seansų';

  @override
  String get logoutFromDevice => 'Atsijungti nuo šio įrenginio';

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
  String get errorAcceptingCall => 'Klaida priimant skambutį';

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
  String typingIndicator(String name) {
    return '$name rašo...';
  }

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
  String get diagnosticDataTitle => 'Diagnostikos duomenys';

  @override
  String get diagnosticDescription =>
      'Ar norite siųsti anoniminius diagnostikos duomenis programėlei tobulinti?';

  @override
  String get noThanks => 'Ne, ačiū';

  @override
  String get yesEnable => 'Taip, įjungti';

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
  String get newPasswordMinChars => 'Naujas slaptažodis (min. 6 simboliai)';

  @override
  String get reasonLabel2 => 'Priežastis';

  @override
  String get downloadFailed2 => 'Atsisiuntimas nepavyko';

  @override
  String get downloadTooltip => 'Atsisiųsti';

  @override
  String get connectionErrorGeneric => 'Ryšio klaida';

  @override
  String get errorNoInternet => 'Nėra interneto ryšio. Patikrinkite savo tinklą.';

  @override
  String get errorTimeout => 'Serveris neatsako. Bandykite vėliau.';

  @override
  String get errorServer => 'Serverio klaida. Bandykite vėliau.';

  @override
  String get errorConnection => 'Ryšio klaida. Bandykite vėliau.';

  @override
  String get errorUnexpected => 'Įvyko netikėta klaida. Bandykite vėliau.';

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
  String get bankTransfer => 'Bankinis pavedimas';

  @override
  String get standingOrder => 'Nuolatinis pavedimas';

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
  String get memberNumberTooLong =>
      'Nario numeris per ilgas (maks. 20 simbolių)';

  @override
  String get onlyUppercaseAndNumbers =>
      'Leidžiamos tik didžiosios raidės ir skaičiai';

  @override
  String get passwordTooLong => 'Slaptažodis per ilgas (maks. 100 simbolių)';

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
  String get diagnosticErrors => 'Klaidų ataskaitos tobulinimui';

  @override
  String get diagnosticAnonymousStats => 'Anoniminė naudojimo statistika';

  @override
  String get diagnosticPerformance => 'Programėlės veikimo duomenys';

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
  String get ipClean => 'IP švarus - neįtrauktas';

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
  String get helpImproveApp => 'Ar norite padėti mums patobulinti programėlę?';

  @override
  String get noPersonalDataCollected =>
      'Asmeniniai duomenys nerenkami. Šį nustatymą galima pakeisti bet kuriuo metu.';

  @override
  String logEntries(int count) {
    return '$count įrašų';
  }

  @override
  String get noLogs => 'Nėra žurnalų';

  @override
  String get newLoginDetected => 'Aptiktas naujas prisijungimas';

  @override
  String get waitingForMember => 'Laukiama nario';

  @override
  String get waitingForStaff => 'Laukiama darbuotojo';

  @override
  String get waitingForAuthority => 'Laukiama institucijos';
}
