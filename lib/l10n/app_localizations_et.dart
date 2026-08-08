// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Estonian (`et`).
class AppLocalizationsEt extends AppLocalizations {
  AppLocalizationsEt([String locale = 'et']) : super(locale);

  @override
  String get welcomeLoading => 'Laadimine...';

  @override
  String get welcomeAutoLogin => 'Automaatne sisselogimine...';

  @override
  String get login => 'Logi sisse';

  @override
  String get register => 'Registreeru';

  @override
  String get becomeMember => 'Saa liikmeks';

  @override
  String get memberNumber => 'Liikme number';

  @override
  String get memberNumberHint => 'Sisesta liikme number';

  @override
  String get confirmPassword => 'Kinnita parool';

  @override
  String get confirmPasswordHint => 'Kinnita parool';

  @override
  String get newPassword => 'Uus parool';

  @override
  String get newPasswordHint => 'Sisesta uus parool';

  @override
  String get firstName => 'Eesnimi ja perekonnanimi';

  @override
  String get firstNameHint => 'Sisesta ees- ja perekonnanimi';

  @override
  String get nameMinLength => 'Nimi peab olema vähemalt 2 tähemärki';

  @override
  String get nameOnlyLetters => 'Lubatud ainult tähed ja sidekriipsud';

  @override
  String get email => 'E-posti aadress';

  @override
  String get emailHint => 'Sisesta e-post';

  @override
  String get emailInvalid => 'Sisesta kehtiv e-posti aadress';

  @override
  String get passwordMinLength => 'Parool peab olema vähemalt 6 tähemärki';

  @override
  String get passwordsNotMatch => 'Paroolid ei kattu';

  @override
  String get registrationFailed => 'Registreerimine ebaõnnestus';

  @override
  String connectionError(String error) {
    return 'Ühendusviga: $error';
  }

  @override
  String registrationSuccess(String memberNumber) {
    return 'Registreerimine õnnestus!\n\nSinu liikme number: $memberNumber\n\nJäta see number sisselogimiseks meelde.';
  }

  @override
  String get unknown => 'Tundmatu';

  @override
  String error(String error) {
    return 'Viga: $error';
  }

  @override
  String get cancel => 'Tühista';

  @override
  String get resetPassword => 'Lähtesta parool';

  @override
  String get imprint => 'Impressum';

  @override
  String get privacy => 'Privaatsuspoliitika';

  @override
  String get statutes => 'Põhikiri';

  @override
  String get revocation => 'Taganemisõigus';

  @override
  String get appointments => 'Kohtumised';

  @override
  String get tickets => 'Piletid';

  @override
  String get liveChat => 'Reaalajas vestlus';

  @override
  String get notifications => 'Teavitused';

  @override
  String get myProfile => 'Minu Profiil';

  @override
  String get logout => 'Logi välja';

  @override
  String get goodMorning => 'Tere hommikust';

  @override
  String get goodDay => 'Tere päevast';

  @override
  String get goodEvening => 'Tere õhtust';

  @override
  String get goodNight => 'Head ööd';

  @override
  String get welcomeToICD => 'Tere tulemast ICD360S e.V!';

  @override
  String get accountCreatedSuccessfully => 'Teie konto on edukalt loodud.';

  @override
  String get today => 'Täna';

  @override
  String get membershipFeeDue => 'Liikmemaks tasumisele';

  @override
  String get pleaseTransferAnnualFee => 'Palun kandke üle aastamaks.';

  @override
  String get newBadge => 'Uus';

  @override
  String get close => 'Sulge';

  @override
  String get myAppointments => 'Minu kohtumised';

  @override
  String get priority => 'Prioriteet';

  @override
  String get messageLabel => 'Sõnum';

  @override
  String get reportProblems => 'Teavita probleemidest';

  @override
  String get weRespondIn24Hours =>
      'Vastame teile maksimaalselt 24 tunni jooksul!';

  @override
  String get everythingOk => 'Kõik korras!';

  @override
  String get haveProblemWeHelp => 'Kas teil on probleem?\nMe võtame sellest!';

  @override
  String get myMembership => 'Minu liikmelisus';

  @override
  String get managePersonalDataAndFee => 'Hallake isikuandmeid ja liikmemaksu';

  @override
  String get myAppointmentsTitle => 'Minu kohtumised';

  @override
  String get appointmentsDescription =>
      'Siin saate näha oma tulevasi kohtumisi.\nSaate kinnitada oma osalemist või keelduda.';

  @override
  String get loadAppointments => 'Laadi kohtumised';

  @override
  String get myTickets => 'Minu piletid';

  @override
  String get low => 'Madal';

  @override
  String get high => 'Kõrge';

  @override
  String get submit => 'Esita';

  @override
  String get errorCreatingTicket => 'Viga pileti loomisel';

  @override
  String get verified => 'Kinnitatud';

  @override
  String get account => 'Konto';

  @override
  String get myDevices => 'Minu seadmed';

  @override
  String get changeEmail => 'Muuda e-posti';

  @override
  String get changePassword => 'Muuda parooli';

  @override
  String get saveEmail => 'Salvesta e-post';

  @override
  String get savePassword => 'Salvesta parool';

  @override
  String get deviceLoggedOut => 'Seade välja logitud';

  @override
  String get emailChangedSuccessfully => 'E-post edukalt muudetud';

  @override
  String get errorChangingPassword => 'Viga parooli muutmisel';

  @override
  String get errorChangingEmail => 'Viga e-posti muutmisel';

  @override
  String get validEmailRequired => 'Palun sisestage kehtiv e-posti aadress';

  @override
  String get confirmLogoutDevice => 'Logi seade välja?';

  @override
  String get confirmLogoutMessage =>
      'Kas soovite sellest seadmest välja logida?\n\nSelle seadme kasutamiseks peate uuesti sisse logima.';

  @override
  String get ipAddress => 'IP';

  @override
  String get platform => 'Platvorm';

  @override
  String trialWarningUrgentTitle(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days päeva',
      one: '1 päev',
    );
    return 'Tähelepanu: Konto peatamiseni on jäänud $_temp0!';
  }

  @override
  String get trialWarningTitle => 'Teie konto pole veel kinnitatud';

  @override
  String get trialWarningDescription =>
      'Palun täitke oma andmed jaotises \"Minu profiil\". 30 päeva pärast peatatakse teie konto automaatselt.';

  @override
  String trialDaysRemaining(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days päeva',
      one: '1 päev',
    );
    return '$_temp0';
  }

  @override
  String get overview => 'Ülevaade';

  @override
  String get member => 'Liige';

  @override
  String get memberManagement => 'Liikmehaldus';

  @override
  String get reportProblemTooltip => 'Teavita probleemist';

  @override
  String get newAppointmentsTitle => 'Uued kohtumised';

  @override
  String get youHaveNewAppointment => 'Teil on uus kohtumine.';

  @override
  String youHaveNewAppointments(int count) {
    return 'Teil on $count uut kohtumist.';
  }

  @override
  String get appointmentReminderTomorrow => 'Meeldetuletus: Kohtumine homme';

  @override
  String tomorrowAppointment(String title) {
    return 'Homme: $title';
  }

  @override
  String youHaveTomorrowAppointments(int count) {
    return 'Teil on $count kohtumist homme.';
  }

  @override
  String get appointmentsToday => 'Kohtumised täna';

  @override
  String todayAppointment(String title) {
    return 'Täna: $title';
  }

  @override
  String youHaveTodayAppointments(int count) {
    return 'Teil on $count kohtumist täna.';
  }

  @override
  String get paymentReminder => 'Maksemeeldetuletus';

  @override
  String paymentReminderMessage(int day, String method) {
    return 'Täna on kuu $day. päev – palun viige lõpule $method.';
  }

  @override
  String get paymentDayLabel => 'Maksepäev (igakuine meeldetuletus)';

  @override
  String get updateAvailable => 'Värskendus saadaval';

  @override
  String newVersionAvailable(String version) {
    return 'Uus versioon on saadaval: $version';
  }

  @override
  String currentVersionLabel(String version) {
    return 'Praegune versioon: $version';
  }

  @override
  String get changes => 'Muudatused:';

  @override
  String downloadProgress(String percent) {
    return 'Allalaadimine: $percent%';
  }

  @override
  String get installationStarting => 'Paigaldamine algab...';

  @override
  String get appWillRestart => 'Rakendus taaskäivitub automaatselt.';

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
  String get later => 'Hiljem';

  @override
  String get updateNow => 'Värskenda kohe';

  @override
  String get downloading => 'Allalaadimine...';

  @override
  String get downloadFailed =>
      'Allalaadimine ebaõnnestus. Proovige hiljem uuesti.';

  @override
  String get searchingForUpdates => 'Värskenduste otsimine...';

  @override
  String get appUpToDate => 'Rakendus on ajakohane';

  @override
  String get updateCheckError => 'Viga värskenduse kontrollimisel';

  @override
  String get changelog => 'Muudatuste logi';

  @override
  String get terminConfirmed => 'Kohtumine kinnitatud';

  @override
  String get terminDeclined => 'Kohtumine keeldutud';

  @override
  String get terminRescheduleRequested => 'Edasilükkamine taotud';

  @override
  String get statusConfirmed => 'Kinnitatud';

  @override
  String get statusDeclined => 'Keeldutud';

  @override
  String get statusRescheduling => 'Edasilükkamine';

  @override
  String get statusPending => 'Ootel';

  @override
  String get categoryVorstandssitzung => 'Juhatuse koosolek';

  @override
  String get categoryMitgliederversammlung => 'Üldkoosolek';

  @override
  String get categorySchulung => 'Koolitus';

  @override
  String get categorySonstiges => 'Muu';

  @override
  String openCount(int count) {
    return '$count avatud';
  }

  @override
  String get refresh => 'Värskenda';

  @override
  String get filterUpcoming => 'Tulevased';

  @override
  String get filterPast => 'Möödunud';

  @override
  String get filterAll => 'Kõik';

  @override
  String get noUpcomingAppointments => 'Tulevasi kohtumisi pole';

  @override
  String get noPastAppointments => 'Möödunud kohtumisi pole';

  @override
  String get noAppointmentsAvailable => 'Kohtumisi pole';

  @override
  String get appointmentsShownHere => 'Teie kohtumised kuvatakse siin';

  @override
  String get dateLabel => 'Kuupäev';

  @override
  String get timeLabel => 'Aeg';

  @override
  String get locationLabel => 'Asukoht';

  @override
  String get createdByLabel => 'Loonud';

  @override
  String get descriptionLabel => 'Kirjeldus';

  @override
  String get ticketLabel => 'Pilet';

  @override
  String get yourStatus => 'Teie olek: ';

  @override
  String reasonLabel(String reason) {
    return 'Põhjus: $reason';
  }

  @override
  String durationMinutes(int minutes) {
    return '$minutes min';
  }

  @override
  String get confirm => 'Kinnita';

  @override
  String get decline => 'Keeldu';

  @override
  String get reschedule => 'Lükka edasi';

  @override
  String get requestReschedule => 'Taotle edasilükkamist';

  @override
  String appointmentLabel(String title) {
    return 'Kohtumine: $title';
  }

  @override
  String get rescheduleReason => 'Edasilükkamise põhjus *';

  @override
  String get rescheduleReasonHint => 'Märkige põhjus...';

  @override
  String get pleaseProvideReason => 'Märkige põhjus';

  @override
  String get request => 'Taotle';

  @override
  String get ticketStatusOpen => 'Avatud';

  @override
  String get ticketStatusInProgress => 'Töös';

  @override
  String get ticketStatusWaitingMember => 'Ootab liiget';

  @override
  String get ticketStatusWaitingStaff => 'Ootab töötajat';

  @override
  String get ticketStatusWaitingAuthority => 'Ootab asutust';

  @override
  String get ticketStatusDone => 'Lõpetatud';

  @override
  String get ticketPriorityHigh => 'Kõrge';

  @override
  String get ticketPriorityMedium => 'Keskmine';

  @override
  String get ticketPriorityLow => 'Madal';

  @override
  String get comments => 'Kommentaarid';

  @override
  String get documents => 'Dokumendid';

  @override
  String get details => 'Üksikasjad';

  @override
  String get replySent => 'Vastus saadetud';

  @override
  String get sendError => 'Saatmisviga';

  @override
  String get uploading => 'Üleslaadimine...';

  @override
  String fileUploaded(String filename) {
    return '$filename üles laetud';
  }

  @override
  String get uploadFailed => 'Üleslaadimine ebaõnnestus';

  @override
  String get openError => 'Avamisviga';

  @override
  String get noRepliesYet => 'Vastuseid veel pole';

  @override
  String get waitingForSupport => 'Ootel toe vastust';

  @override
  String get writeReply => 'Kirjutage vastus...';

  @override
  String get attachFile => 'Lisa fail';

  @override
  String documentsCount(int count) {
    return 'Dokumendid ($count)';
  }

  @override
  String get upload => 'Laadi üles';

  @override
  String get noDocuments => 'Dokumente pole';

  @override
  String get allowedFormats => 'Lubatud formaadid: PDF, JPEG, JPG, TXT, ZIP';

  @override
  String get yourMessage => 'Teie sõnum:';

  @override
  String get translation => 'Tõlge';

  @override
  String get original => 'Originaal';

  @override
  String get originalText => 'Algne tekst';

  @override
  String get autoTranslated => 'Automaatselt tõlgitud';

  @override
  String get originalTapTranslation => 'Originaal · Puudutage tõlke jaoks';

  @override
  String get translatedTapOriginal => 'Tõlgitud · Puudutage originaali jaoks';

  @override
  String get justNow => 'Äsja';

  @override
  String minutesAgo(int minutes) {
    return '$minutes min tagasi';
  }

  @override
  String hoursAgo(int hours) {
    return '$hours tundi tagasi';
  }

  @override
  String daysAgo(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'päeva',
      one: 'päev',
    );
    return '$days $_temp0 tagasi';
  }

  @override
  String get createdLabel => 'Loodud';

  @override
  String get updatedLabel => 'Uuendatud';

  @override
  String get handlerLabel => 'Menetleja';

  @override
  String get doneLabel => 'Lõpetatud';

  @override
  String get newTicketTitle => 'Uus pilet';

  @override
  String get categoryOptional => 'Kategooria (valikuline)';

  @override
  String get selectCategory => 'Vali';

  @override
  String get subjectLabel => 'Teema';

  @override
  String get fillAllFields => 'Täitke kõik väljad';

  @override
  String ticketCreatedId(int id) {
    return 'Pilet #$id loodud';
  }

  @override
  String get priorityLabel => 'Prioriteet: ';

  @override
  String get supportOffline => 'Tugi võrguühenduseta';

  @override
  String get lastSeenSeconds => 'Aktiivne mõni sekund tagasi';

  @override
  String lastSeenMinutes(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: 'minutit',
      one: 'minut',
    );
    return 'Aktiivne $minutes $_temp0 tagasi';
  }

  @override
  String lastSeenHours(int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: 'tundi',
      one: 'tund',
    );
    return 'Aktiivne $hours $_temp0 tagasi';
  }

  @override
  String lastSeenDays(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'päeva',
      one: 'päev',
    );
    return 'Aktiivne $days $_temp0 tagasi';
  }

  @override
  String get online => 'Võrgus';

  @override
  String get callSupport => 'Helista';

  @override
  String get typeMessage => 'Kirjutage sõnum...';

  @override
  String get callBusy => 'Tugi on hõivatud';

  @override
  String get callRejected => 'Kõne lükati tagasi';

  @override
  String get callFailed => 'Kõnet ei saanud ühendada';

  @override
  String get callEnded => 'Kõne lõppes';

  @override
  String get callSupportBusy => 'Tugi on juba teises kõnes';

  @override
  String get errorStartingChat => 'Viga vestluse alustamisel';

  @override
  String get errorStartingCall => 'Viga kõne alustamisel';

  @override
  String get errorConnecting => 'Ühendusviga';

  @override
  String get errorDownloading => 'Allalaadimisviga';

  @override
  String get errorUploading => 'Üleslaadimise viga';

  @override
  String get errorSending => 'Saatmisviga';

  @override
  String get errorPickingPhotos => 'Viga fotode valimisel';

  @override
  String get errorPickingFiles => 'Viga failide valimisel';

  @override
  String get errorTakingPhoto => 'Viga pildistamisel';

  @override
  String get fileNotLoaded => 'Faili ei saanud laadida';

  @override
  String get attachmentIdMissing => 'Manuse ID puudub';

  @override
  String get camera => 'Kaamera';

  @override
  String get gallery => 'Galerii';

  @override
  String get file => 'Fail';

  @override
  String get notifNewMessageFrom => 'Uus sõnum saatjalt';

  @override
  String get notifUrgentPrefix => 'KIIRE';

  @override
  String get notifUrgentMessage => 'KIIRE SÕNUM';

  @override
  String get notifIncomingCall => 'Sissetulev kõne';

  @override
  String get notifCallingYou => 'helistab...';

  @override
  String get notifUpdateAvailable => 'Värskendus saadaval';

  @override
  String get notifVersionAvailable => 'on nüüd saadaval';

  @override
  String get notifConnected => 'Ühendatud';

  @override
  String get notifDisconnected => 'Ühendus katkes';

  @override
  String get notifConnectedBody => 'Olete nüüd serveriga ühendatud.';

  @override
  String get notifDisconnectedBody => 'Ühendus serveriga katkes.';

  @override
  String get notifError => 'Viga';

  @override
  String get retry => 'Proovi uuesti';

  @override
  String get save => 'Salvesta';

  @override
  String get accept => 'Nõustu';

  @override
  String get selectFile => 'Vali fail';

  @override
  String get dataLoadingText => 'Andmete laadimine...';

  @override
  String get dataSavedSuccess => 'Andmed salvestatud';

  @override
  String get errorSaving => 'Salvestamisviga';

  @override
  String get errorLoading => 'Laadimise viga';

  @override
  String savedFilename(String filename) {
    return 'Salvestatud: $filename';
  }

  @override
  String get logsCopied => 'Logid kopeeritud!';

  @override
  String get passwordMinEightChars => 'Parool peab olema vähemalt 8 tähemärki';

  @override
  String get passwordChangeSuccess => 'Parool edukalt muudetud';

  @override
  String get emailChangeError => 'Viga e-posti muutmisel';

  @override
  String get acceptDocumentCheckbox =>
      'Olen dokumendi läbi lugenud ja nõustun sellega.';

  @override
  String loadingErrorGeneric(String details) {
    return 'Laadimise viga: $details';
  }

  @override
  String get incomingCallTitle => 'Sissetulev kõne';

  @override
  String ringingFor(int seconds) {
    return 'Heliseb ${seconds}s';
  }

  @override
  String get rejectCall => 'Keeldu';

  @override
  String get acceptCall => 'Vasta';

  @override
  String get unmute => 'Lõpeta vaigistus';

  @override
  String get mute => 'Vaigista';

  @override
  String get hangUp => 'Lõpeta kõne';

  @override
  String get calling => 'Helistamine...';

  @override
  String autoRejectIn(int seconds) {
    return 'Automaatne keeldumine $seconds sekundi pärast';
  }

  @override
  String get speakerOn => 'Kõlar';

  @override
  String get speakerOff => 'Kõrvakuular';

  @override
  String get micMuted => 'Vaigistatud';

  @override
  String get micOn => 'Mikrofon';

  @override
  String get connectionExcellent => 'Suurepärane';

  @override
  String get connectionGood => 'Hea';

  @override
  String get connectionWeak => 'Nõrk';

  @override
  String get connectionLost => 'Ühendus katkes';

  @override
  String get personalData => 'Isikuandmed';

  @override
  String get personalDataSubtitle => 'Eesnimi, perekonnanimi, aadress';

  @override
  String get membershipFee => 'Liikmemaks';

  @override
  String annualFeeYear(String year) {
    return 'Aastamaks $year';
  }

  @override
  String get amount => 'Summa:';

  @override
  String get dueBy => 'Tähtaeg:';

  @override
  String get paid => 'Makstud';

  @override
  String get versionHistory => 'Versiooniajalugu';

  @override
  String lastUpdated(String date) {
    return 'Viimati uuendatud: $date';
  }

  @override
  String get noVersionHistory => 'Versiooniajalugu pole saadaval';

  @override
  String get failedLoadChangelog => 'Muudatuste logi laadimine ebaõnnestus';

  @override
  String get callMember => 'Helista liikmele';

  @override
  String get closeConversation => 'Sulge vestlus';

  @override
  String get chatOffline => 'Ühenduseta';

  @override
  String get attachFiles => 'Lisa failid (max. 10, 50MB)';

  @override
  String get conversationClosed => 'See vestlus on suletud';

  @override
  String get noMessages => 'Sõnumeid pole';

  @override
  String get goBack => 'Tagasi';

  @override
  String get goForward => 'Edasi';

  @override
  String get homePage => 'Avaleht';

  @override
  String get firstNameLabel => 'Eesnimi';

  @override
  String get lastNameLabel => 'Perekonnanimi';

  @override
  String get streetLabel => 'Tänav';

  @override
  String get houseNumberLabel => 'Nr';

  @override
  String get postalCodeLabel => 'Postiindeks';

  @override
  String get cityLabel => 'Linn';

  @override
  String get phoneMobileLabel => 'Telefon (Mobiil)';

  @override
  String get phoneLandlineLabel => 'Telefon (Lauatelefon)';

  @override
  String get newEmailLabel => 'Uus e-posti aadress';

  @override
  String get currentPasswordLabel => 'Praegune parool';

  @override
  String get newPasswordLabel => 'Uus parool';

  @override
  String get confirmPasswordLabel => 'Kinnita parool';

  @override
  String get emailChangedSuccess => 'E-post muudetud';

  @override
  String get reasonLabel2 => 'Põhjus';

  @override
  String get downloadFailed2 => 'Allalaadimine ebaõnnestus';

  @override
  String get downloadTooltip => 'Laadi alla';

  @override
  String get copyLogs => 'Kopeeri logid';

  @override
  String get deleteLogs => 'Kustuta logid';

  @override
  String get autoScrollOn => 'Automaatne kerimine SEES';

  @override
  String get autoScrollOff => 'Automaatne kerimine VÄLJAS';

  @override
  String get unknownValue => 'Teadmata';

  @override
  String get payment => 'Makse';

  @override
  String get warningType_ermahnung => 'Hoiatus';

  @override
  String get warningType_abmahnung => 'Noomitus';

  @override
  String get warningType_letzte => 'Viimane hoiatus';

  @override
  String warningsTotal(int count) {
    return 'Kokku: $count';
  }

  @override
  String warningsErmahnung(int count) {
    return 'Hoiatused: $count';
  }

  @override
  String warningsAbmahnung(int count) {
    return 'Noomitused: $count';
  }

  @override
  String warningsLetzte(int count) {
    return 'Viimased: $count';
  }

  @override
  String get noWarnings => 'Hoiatusi pole';

  @override
  String get noWarningsDescription => 'Teil pole hetkel hoiatusi.';

  @override
  String createdBy(String name) {
    return 'Loonud: $name';
  }

  @override
  String get monthJan => 'Jan';

  @override
  String get monthFeb => 'Vee';

  @override
  String get monthMar => 'Mar';

  @override
  String get monthApr => 'Apr';

  @override
  String get monthMay => 'Mai';

  @override
  String get monthJun => 'Jun';

  @override
  String get monthJul => 'Jul';

  @override
  String get monthAug => 'Aug';

  @override
  String get monthSep => 'Sep';

  @override
  String get monthOct => 'Okt';

  @override
  String get monthNov => 'Nov';

  @override
  String get monthDec => 'Det';

  @override
  String get stufe1_name => 'Isikuandmed';

  @override
  String get stufe2_name => 'Liikmesuse tüüp';

  @override
  String get stufe3_name => 'Rahaline olukord';

  @override
  String get stufe4_name => 'Makseviis';

  @override
  String get stufe5_name => 'Liikmesuse algus';

  @override
  String get stufe6_name => 'Põhikiri';

  @override
  String get stufe7_name => 'Privaatsuspoliitika';

  @override
  String get stufe8_name => 'Taganemisõigus';

  @override
  String get memberType_ordentlich => 'Korraline liige';

  @override
  String get memberType_foerder => 'Toetajaliige';

  @override
  String get memberType_ehren => 'Auliige';

  @override
  String get memberDesc_ordentlich =>
      'Aktiivne liige hääleõigusega. Osaleb ühingu teenustes (e-post, pilv, bürokraatiline tugi).';

  @override
  String get memberDesc_foerder =>
      'Toetab ühingut maksetega. Võib osaleda üldkoosolekul nõuandva häälega, ilma hääleõiguse või valitavuseta juhatusse.';

  @override
  String get memberDesc_ehren =>
      'Omab korralise liikme õigusi ilma liikmemaksu tasumise kohustuseta. Nimetatud üldkoosoleku või juhatuse poolt.';

  @override
  String get payMethod_ueberweisung => 'Pangaülekanne';

  @override
  String get payMethod_dauerauftrag => 'Püsikorraldus';

  @override
  String get verifyStatus_geprueft => 'Kinnitatud';

  @override
  String get verifyStatus_ausgefuellt => 'Täidetud';

  @override
  String get verifyStatus_abgelehnt => 'Tagasilükatud';

  @override
  String get verifyStatus_offen => 'Avatud';

  @override
  String get fillRequiredFields => 'Täitke kõik kohustuslikud väljad.';

  @override
  String get personalDataSaved => 'Isikuandmed salvestatud';

  @override
  String get selectMemberType => 'Valige liikmesuse tüüp.';

  @override
  String get memberTypeSaved => 'Liikmesuse tüüp salvestatud';

  @override
  String get selectOption => 'Valige variant.';

  @override
  String get financialSaved => 'Rahaline olukord salvestatud';

  @override
  String get selectPaymentMethod => 'Valige makseviis.';

  @override
  String get paymentDataSaved => 'Makseandmed salvestatud';

  @override
  String get selectDate => 'Valige kuupäev.';

  @override
  String get membershipStartSaved => 'Liikmesuse algus salvestatud';

  @override
  String get fileTooLarge => 'Fail on liiga suur (max. 10 MB).';

  @override
  String get leistungsbescheidUploaded => 'Hüvitise otsus edukalt üles laetud';

  @override
  String get verificationProgress => 'Kinnitamise edenemine';

  @override
  String get notApplicable => 'Ei kohaldu';

  @override
  String get socialBenefitsExempt =>
      'Makseviis pole vajalik sotsiaalhüvitiste saajatele.';

  @override
  String get locked => 'Lukustatud';

  @override
  String completePreviousStep(int step) {
    return 'Lõpetage esmalt samm $step.';
  }

  @override
  String rejectedNote(String note) {
    return 'Tagasi lükatud: $note';
  }

  @override
  String get waitingForReview => 'Ootab juhatuse ülevaatust.';

  @override
  String get stepApproved => 'See samm on üle vaadatud ja kinnitatud.';

  @override
  String get changesViaChat =>
      'Muudatused on võimalikud ainult vestluse kaudu.';

  @override
  String get firstNameRequired => 'Eesnimi *';

  @override
  String get lastNameRequired => 'Perekonnanimi *';

  @override
  String get birthDateLabel => 'Sünniaeg *';

  @override
  String get streetRequired => 'Tänav *';

  @override
  String get houseNumberRequired => 'Nr *';

  @override
  String get cityRequired => 'Linn *';

  @override
  String get phoneRequired => 'Telefoninumber *';

  @override
  String get phonePurpose =>
      'Eesmärk: Kontakt, kui pole rakenduse kaudu kättesaadav';

  @override
  String get selectMemberTypePrompt => 'Valige soovitud liikmesuse tüüp:';

  @override
  String get financialExplanation =>
      'Selleks, et kontrollida, kas teil on õigus makse vähendamisele, vajame järgmist teavet. Seda kasutatakse ainult teie liikmemaksu määramiseks.';

  @override
  String get socialBenefitsQuestion => 'Kas te saate praegu sotsiaalhüvitisi?';

  @override
  String get optionBuergergeld => 'Jah, kodaniku toetus (Job Center)';

  @override
  String get optionSozialamt => 'Jah, sotsiaalabi (Sotsiaalamet)';

  @override
  String get optionNoBenefits => 'Ei, ma ei saa sotsiaalhüvitisi';

  @override
  String get feeExempt => 'Teie kuumakse on: 0,00 €/kuu';

  @override
  String get uploadLeistungsbescheid => 'Laadige üles hüvitise otsus';

  @override
  String get uploadLeistungsbescheidHint =>
      'Laadige üles kehtiv hüvitise otsus 14 päeva jooksul makse vabastuse kinnitamiseks.';

  @override
  String get allowedFormatsUpload =>
      'Lubatud formaadid: PDF, JPG, PNG (max. 10 MB)';

  @override
  String get feeRegular => 'Teie kuumakse on: 25,00 €/kuu';

  @override
  String paymentDayReminder(int day) {
    return 'Teid teavitatakse iga kuu $day. päeval.';
  }

  @override
  String get membershipStartPrompt =>
      'Valige, millal teie liikmesus peaks algama.';

  @override
  String get optionAfterVerification => 'Pärast kinnitamise lõpetamist';

  @override
  String get optionAfterVerificationDesc =>
      'Liikmesus algab juhatuse kinnitamise päevast.';

  @override
  String get optionRetroFoundation =>
      'Tagasiulatuvalt asutamiskuupäevani (01.08.2025)';

  @override
  String get optionRetroFoundationDesc =>
      'Teist saab tagasiulatuv liige ühingu asutamisest alates.';

  @override
  String get optionRetroCustom => 'Tagasiulatuvalt teisele kuupäevale';

  @override
  String get optionRetroCustomDesc =>
      'Valige kuupäev vahemikus 01.08.2025 kuni tänane päev.';

  @override
  String get selectDateLabel => 'Valige kuupäev';

  @override
  String get selectDateHint => 'Valige kuupäev...';

  @override
  String get dateNotBefore => 'Mitte enne 01.08.2025 (asutamiskuupäev)';

  @override
  String get feeExemptRetro =>
      'Makse vabastus: 0,00 € tagasiulatuvalt.\nAinult liikmesuse kuupäev määratakse tagasiulatuvalt.';

  @override
  String get retroactiveFees => 'Tagasiulatuvad maksed';

  @override
  String retroFeeCalculation(
      String from, String to, String months, String total) {
    return 'Periood: $from – $to\nKuud: $months\nMakse: $months × 25,00 € = $total €';
  }

  @override
  String get pleaseReadSatzung => 'Lugege ühingu põhikirja.';

  @override
  String get pleaseReadDatenschutz => 'Lugege privaatsuspoliitikat.';

  @override
  String get pleaseReadWiderruf => 'Lugege taganemisõigust.';

  @override
  String get acceptedAtRegistration => 'Aktsepteeritud registreerimisel';

  @override
  String get confirmedByBoard => 'Kinnitatakse pärast juhatuse ülevaatust.';

  @override
  String get docSatzung => 'Põhikiri';

  @override
  String get docDatenschutz => 'Privaatsuspoliitika';

  @override
  String get docWiderruf => 'Taganemisõigus';

  @override
  String acceptedAtRegCount(int count) {
    return 'Aktsepteeritud registreerimisel ($count/3)';
  }

  @override
  String acceptedOn(String date) {
    return 'Aktsepteeritud $date';
  }

  @override
  String get notAccepted => 'Pole aktsepteeritud';

  @override
  String get statusAccepted => 'Aktsepteeritud';

  @override
  String get nameTooLong => 'Nimi liiga pikk (maks 100 tähemärki)';

  @override
  String get emailTooLong => 'E-post liiga pikk (maks 255 tähemärki)';

  @override
  String get legalAcknowledgePrefix => 'Olen tutvunud ';

  @override
  String get legalAcknowledgeSuffix => '.';

  @override
  String get legalStatutesSuffix => ' ICD360S e.V. ja tunnistan need siduvaks.';

  @override
  String get legalPleaseReadFirst => '(palun lugege kõigepealt)';

  @override
  String get statusActive => 'Aktiivne';

  @override
  String get statusSuspended => 'Peatatud';

  @override
  String get statusNew => 'Uus';

  @override
  String get statusCancelled => 'Tühistatud';

  @override
  String get statusDeleted => 'Kustutatud';

  @override
  String get roleMitglied => 'Liige';

  @override
  String get roleVorsitzer => 'Esimees';

  @override
  String get roleStellvertreter => 'Asemees';

  @override
  String get roleSchatzmeister => 'Laekur';

  @override
  String get roleSchriftfuehrer => 'Sekretär';

  @override
  String get roleBeisitzer => 'Kaasistuja';

  @override
  String get roleKassierer => 'Kassapidaja';

  @override
  String get roleKassenpruefer => 'Revisor';

  @override
  String get roleEhrenamtlich => 'Vabatahtlik';

  @override
  String get roleMitgliedergruender => 'Asutajaliige';

  @override
  String get roleEhrenmitglied => 'Auliige';

  @override
  String get roleFoerdermitglied => 'Toetajaliige';

  @override
  String get memberTypeNotSet => 'Pole veel määratud';

  @override
  String get payMethodSepa => 'SEPA otsekorraldus';

  @override
  String get labelStatus => 'Olek';

  @override
  String get labelMemberNumber => 'Liikmenuumber';

  @override
  String get labelRole => 'Roll';

  @override
  String get labelMemberType => 'Liikmetüüp';

  @override
  String get labelPaymentMethod => 'Makseviis';

  @override
  String get labelRegisteredOn => 'Registreeritud';

  @override
  String get labelLastLogin => 'Viimane sisselogimine';

  @override
  String get labelMemberSince => 'Liige alates';

  @override
  String get neverLoggedIn => 'Mitte kunagi';

  @override
  String get notActivatedYet => 'Pole veel aktiveeritud';

  @override
  String get tabVerification => 'Kontrollimine';

  @override
  String get tabWarnings => 'Hoiatused';

  @override
  String get tabDocuments => 'Dokumendid';

  @override
  String get tabMembership => 'Liikmelisus';

  @override
  String get pleaseEnterFirstName => 'Sisestage eesnimi';

  @override
  String get pleaseEnterLastName => 'Sisestage perekonnanimi';

  @override
  String get noFileDataReceived => 'Andmeid ei saadud';

  @override
  String get openFile => 'Ava';

  @override
  String get noMicrophoneError =>
      'Mikrofoni ei leitud. Ühendage mikrofon ja proovige uuesti.';

  @override
  String get startConversation => 'Alustage vestlust!';

  @override
  String get staffWillReply => 'Töötaja vastab teile peagi.';

  @override
  String get inCall => 'Kõnes...';

  @override
  String get registration => 'Registreerimine';

  @override
  String get deactivation => 'Deaktiveerimine';

  @override
  String get deactivatedOn => 'Deaktiveeritud';

  @override
  String get accountAutoSuspend =>
      'Kontod, mida 30 päeva jooksul ei kinnitata, peatatakse automaatselt.';

  @override
  String get documentsProvidedByBoard => 'Dokumendid esitab juhatus.';

  @override
  String get noDocumentsAvailable => 'Dokumente pole';

  @override
  String get noDocumentsDescription => 'Teile pole veel dokumente esitatud.';

  @override
  String uploadedBy(String name) {
    return 'Üles laadinud: $name';
  }

  @override
  String stepsCompleted(int completed, int total) {
    return '$completed/$total sammu lõpetatud';
  }

  @override
  String dayOfMonth(int day) {
    return 'Kuu $day. päev';
  }

  @override
  String changeField(String field) {
    return 'Muuda $field';
  }

  @override
  String openDocument(String name) {
    return 'Ava $name';
  }

  @override
  String logEntries(int count) {
    return '$count kirjet';
  }

  @override
  String get noLogs => 'Logisid pole';

  @override
  String get newLoginDetected => 'Tuvastati uus sisselogimine';

  @override
  String get errorNoInternet =>
      'Internetiühendus puudub. Palun kontrollige oma võrku.';

  @override
  String get errorTimeout => 'Server ei vasta. Palun proovige hiljem uuesti.';

  @override
  String get errorServer => 'Serveri viga. Palun proovige hiljem uuesti.';

  @override
  String get errorConnection => 'Ühenduse viga. Palun proovige hiljem uuesti.';

  @override
  String get errorUnexpected =>
      'Tekkis ootamatu viga. Palun proovige hiljem uuesti.';

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
  String get claudiuWelcomeMorning => 'Tere hommikust';

  @override
  String get claudiuWelcomeDay => 'Tere';

  @override
  String get claudiuWelcomeEvening => 'Tere õhtust';

  @override
  String get claudiuWelcomeNight => 'Tere õhtust';

  @override
  String get claudiuWelcomeVisitor => 'kallis külaline';

  @override
  String get claudiuWelcomeAsk => 'Kuidas saan aidata?';

  @override
  String get claudiuWelcomeBecomeMember => 'Tahan liikmeks saada';

  @override
  String get claudiuWelcomeLogin => 'Olen juba liige ja tahan sisse logida';

  @override
  String get claudiuWelcomeProblem => 'Mul on rakendusega probleem';

  @override
  String get claudiuWelcomeEmergency => 'Hädaolukord — helista';

  @override
  String get claudiuWelcomeMascotName => 'Claudiu';

  @override
  String get claudiuWelcomeEmergencyIntro =>
      'Enne kui helistad — meie tööajad:';

  @override
  String get claudiuWelcomeScheduleOffice => 'Kontoris';

  @override
  String get claudiuWelcomeScheduleField => 'Väljas klientidega';

  @override
  String get claudiuWelcomeOutsideHoursNote =>
      'Väljaspool neid kellaaegu tegeleme ainult hädaolukordadega. Saad ka samale numbrile SMS-i saata — võtame ühendust.';

  @override
  String get claudiuWelcomeCallNow => 'Helista kohe';

  @override
  String get claudiuWelcomeSendSms => 'Saada SMS';

  @override
  String get claudiuWelcomeSmsBody =>
      'Hädaolukord ICD360S e.V. — palun võtke minuga ühendust nii kiiresti kui võimalik.';

  @override
  String get claudiuWelcomeCloseButton => 'Sulge';

  @override
  String get claudiuLoginWelcome => 'Tere tulemast tagasi, kallis liige!';

  @override
  String get claudiuLoginAsk => 'Palun ütle oma liikmenumber.';

  @override
  String get claudiuLoginProgress => 'Peaaegu… jätka kirjutamist.';

  @override
  String get claudiuLoginReady => 'Suurepärane! Puuduta allolevat nuppu.';

  @override
  String get claudiuLoginLoading => 'Kontrollin isikut… 🔍';

  @override
  String get claudiuLoginFoundPlain => 'Leidsin sind! Logitakse sisse…';

  @override
  String claudiuLoginFoundNamed(String name) {
    return 'Leidsin sind, $name! Logitakse sisse…';
  }

  @override
  String get claudiuLoginError =>
      'Hmm, ma ei leia seda numbrit. Kas kirjutasid õigesti?';

  @override
  String get claudiuLoginForgotHeader => 'Kas unustasid liikmenumbri?';

  @override
  String get claudiuLoginNoSms => 'Me ei saada numbrit e-postiga ega SMS-iga.';

  @override
  String get claudiuLoginOnlyWay =>
      'Ainus võimalus: kohtuda isiklikult ühingu kontoris pärast isikutuvastust.';

  @override
  String get claudiuLoginContactUs => 'Helista, et aeg kokku leppida:';

  @override
  String get claudiuDiagnosticGreeting => 'Enne kui sisse astud, üks küsimus';

  @override
  String get claudiuDiagnosticAsk =>
      'Kas tohin saata anonüümseid raporteid, et arendajad saaksid rakendust parandada?';

  @override
  String get claudiuDiagnosticYes => 'Jah, tahan aidata';

  @override
  String get claudiuDiagnosticNo => 'Ei, ma lihtsalt vaatan ringi';

  @override
  String get claudiuDiagnosticTellMore => 'Räägi mulle veel';

  @override
  String get claudiuDiagnosticSendsHeader =>
      '📤 Mida me SAADAME (anonüümselt):';

  @override
  String get claudiuDiagnosticSends1 =>
      'Anonüümne seadmekood (MITTE liikmenumber)';

  @override
  String get claudiuDiagnosticSends2 => 'Sinu roll (liige / juhatus)';

  @override
  String get claudiuDiagnosticSends3 =>
      'Operatsioonisüsteem (Linux / Android / iOS / Windows)';

  @override
  String get claudiuDiagnosticSends4 => 'Valitud keel';

  @override
  String get claudiuDiagnosticSends5 => 'Aku tase ja olek';

  @override
  String get claudiuDiagnosticSends6 => 'Praegune ekraan';

  @override
  String get claudiuDiagnosticSends7 => 'Sessiooni kestus (sekundid)';

  @override
  String get claudiuDiagnosticSends8 => 'Vead, kui esinevad (viimased 10)';

  @override
  String get claudiuDiagnosticSends9 => 'Navigeerimine (viimased 20 ekraani)';

  @override
  String get claudiuDiagnosticNeverHeader =>
      '🛡️ Mida me MITTE KUNAGI ei saada:';

  @override
  String get claudiuDiagnosticNever1 => 'Sinu pärisnimi';

  @override
  String get claudiuDiagnosticNever2 => 'E-posti aadress';

  @override
  String get claudiuDiagnosticNever3 => 'Telefoninumber';

  @override
  String get claudiuDiagnosticNever4 => 'Parool';

  @override
  String get claudiuDiagnosticNever5 => 'Vestlussõnumite sisu';

  @override
  String get claudiuDiagnosticNever6 => 'Piletite sisu';

  @override
  String get claudiuDiagnosticNever7 => 'Dokumendid või manused';

  @override
  String get claudiuDiagnosticTechHeader => '📡 Tehnilised üksikasjad:';

  @override
  String get claudiuDiagnosticTech1 => 'Saadetakse iga 2 minuti tagant';

  @override
  String get claudiuDiagnosticTech2 =>
      'TLS-krüpteeritud ühendus, kinnistatud sertifikaadiga';

  @override
  String get claudiuDiagnosticTech3 =>
      'Saad selle igal ajal Seadetes välja lülitada';

  @override
  String get claudiuProblemHelpTitle => 'Kuidas saan aidata?';

  @override
  String get claudiuProblemHelpGreeting => 'Mis juhtus?';

  @override
  String get claudiuProblemHelpAsk => 'Kuidas tahad mulle rääkida?';

  @override
  String get claudiuProblemHelpWriteTitle => 'Kirjuta raport';

  @override
  String get claudiuProblemHelpWriteBody =>
      'Samm-sammult detailidega. Tiim saab teksti ja lahendab selle hiljem.';

  @override
  String get claudiuProblemHelpChatTitle => 'Räägime kohe';

  @override
  String get claudiuProblemHelpChatBody =>
      'Anonüümne vestlus operaatoriga. Reaalajas vastus, kui keegi on online.';

  @override
  String get claudiuProblemHelpAltCallHeader => 'Või kui see on kiire:';

  @override
  String get claudiuProblemHelpAltCallLabel => 'Helista';

  @override
  String get claudiuAnonymousChatTitle => 'Anonüümne vestlus';

  @override
  String get claudiuAnonymousChatGreeting => 'Tere!';

  @override
  String get claudiuAnonymousChatWelcome =>
      'Ma kuulan. Kirjuta mida tahad — nime pole vaja. Vastan niipea kui sees olen.';

  @override
  String get claudiuAnonymousChatHint => 'Kirjuta sõnum…';

  @override
  String get claudiuAnonymousChatWaitingOperator =>
      'Ootame operaatori vastust…';

  @override
  String get claudiuVorsitzerConnectedTitle => 'Tere!';

  @override
  String get claudiuVorsitzerConnectedBody =>
      'Aitäh, et ühendust võtsid — oled nüüd ühenduses Vorsitzeriga. Räägi, kuidas saame su liikmestaotluse osas aidata.';

  @override
  String get claudiuVorsitzerConnectedSender => 'Vorsitzer';

  @override
  String get claudiuQuickReplyValidationTime => 'Kui kaua kontroll võtab?';

  @override
  String get claudiuQuickReplyDocuments => 'Milliseid dokumente vajan?';

  @override
  String get claudiuQuickReplyStepProblem => 'Olen ühe sammu juures kinni';

  @override
  String get claudiuQuickReplyHuman => 'Kas saan kohe kellegagi rääkida?';

  @override
  String get claudiuAnonymousChatConnecting => 'Ühendamine…';

  @override
  String get claudiuAnonymousChatConnectionFailed =>
      'Vestlust ei õnnestunud avada. Proovi uuesti või helista.';

  @override
  String get claudiuAnonymousChatRetry => 'Proovi uuesti';

  @override
  String get claudiuAnonymousChatOnline => 'Ühendatud';

  @override
  String get claudiuAnonymousChatOffline => 'Taasühendamine…';

  @override
  String get claudiuAnonymousChatAdminTyping => 'Operaator kirjutab…';

  @override
  String get claudiuProblemReportTitle => 'Teata probleemist';

  @override
  String get claudiuProblemReportGreeting => 'Mis juhtus?';

  @override
  String get claudiuProblemReportAsk =>
      'Räägi üksikasjalikult ja ma edastan raporti tiimile.';

  @override
  String get claudiuProblemReportIncludeHeader => 'Palun lisa:';

  @override
  String get claudiuProblemReportIncludeBullets1 =>
      'Mida sa tegid, kui probleem ilmnes';

  @override
  String get claudiuProblemReportIncludeBullets2 => 'Iga veateade, mida nägid';

  @override
  String get claudiuProblemReportIncludeBullets3 => 'Millisel ekraanil olid';

  @override
  String get claudiuProblemReportIncludeBullets4 =>
      'Kas rakendus jookseb kokku, sulgub või kuvab tühja ekraani?';

  @override
  String get claudiuProblemReportIncludeBullets5 =>
      'Kas see juhtub iga kord või ainult ühe korra?';

  @override
  String get claudiuProblemReportDescriptionLabel => 'Sinu kirjeldus';

  @override
  String get claudiuProblemReportDescriptionHint =>
      'Nt: Vestluse ekraani avades ilmub teade \"Connection error\" ja rakendus ei reageeri…';

  @override
  String claudiuProblemReportTooShort(int count) {
    return 'Veidi rohkem detaile palun (vähemalt $count märki)';
  }

  @override
  String get claudiuProblemReportSubmit => 'Saada raport';

  @override
  String get claudiuProblemReportSubmitting => 'Saadan…';

  @override
  String get claudiuProblemReportSentTitle => 'Aitäh!';

  @override
  String get claudiuProblemReportSentBody =>
      'Raport on saadetud. Meie tiim vaatab selle üle võimalikult kiiresti.';

  @override
  String get claudiuProblemReportSentClose => 'Selge';

  @override
  String get claudiuProblemReportSendFailed =>
      'Raporti saatmine ebaõnnestus. Helista meile kiireloomulise abi saamiseks.';

  @override
  String get claudiuProblemReportAlt => 'Või kui see on kiire:';

  @override
  String get claudiuProblemReportCallLabel => 'Helista';

  @override
  String claudiuApprovalGreeting(String name) {
    return 'Tere, $name! 👋';
  }

  @override
  String get claudiuApprovalGreetingNoName => 'Tere! 👋';

  @override
  String get claudiuApprovalGladToSeeYou => 'Tore, et tulid!';

  @override
  String get claudiuApprovalCheckingForSafety =>
      'Sinu turvalisuse huvides kontrollib Vorsitzer nüüd sinu sisselogimispäringut. 🛡️';

  @override
  String get claudiuApprovalMonthlyExplain =>
      '💡 Teeme seda iga 30 päeva tagant, et olla kindel, et see oled tõesti sina. See on nagu turvakontroll — kuni 5 minutit.';

  @override
  String get claudiuApprovalSuccess =>
      'Valmis! 🎉 Vorsitzer tundis sind ära. Logitakse sisse…';

  @override
  String get claudiuApprovalDenied =>
      'Hmm, Vorsitzer lükkas sinu päringu tagasi. 😔';

  @override
  String get claudiuApprovalDeniedHelp =>
      'Kui arvad, et see on viga, palun helista, et asja klaarida.';

  @override
  String get claudiuApprovalExpired =>
      '5 minutit on möödas ja Vorsitzerilt vastust ei tulnud.';

  @override
  String get claudiuApprovalExpiredHelp =>
      'Helista ja saame sinu päringu kohapeal kinnitada. 📞';

  @override
  String get claudiuApprovalCallUs => 'Helista';

  @override
  String get claudiuApprovalTryAgain => 'Proovi uuesti';

  @override
  String get claudiuApprovalCancel => 'Tühista';

  @override
  String get claudiuApprovalClose => 'Sulge';

  @override
  String get wizardIntroBubble1 =>
      'Tere, külaline! 👋 Aitäh, et soovid liituda meie perega.';

  @override
  String get wizardIntroBubble2 =>
      'Mu nimi on Claudiu. 2025. aasta kevadel oli mul selge nägemus: luua ühing, mis aitab abivajajaid — vabatahtlikult, südamest, ilma asjatu bürokraatiata. ❤️';

  @override
  String get wizardIntroBubble3 =>
      'Hakkasin rääkima klientidega, keda külastasin. Jutustasin neile oma unistuse. Ja igaüks ütles: „Jah, lähme!\" 2025. aasta juulis kohtusime — 6 otsustavat inimest. Otsustasime asutada **ICD360S e.V.** Neu-Ulmis. 📍';

  @override
  String get wizardIntroBubble4 =>
      '**1. augustil 2025** sai ühing ametlikult elu — Ühingute registris. Minu kõige ilusam kingitus. 🎂';

  @override
  String get wizardIntroBubble5 =>
      'Mida me teeme? Aitame pagulasi, puuetega inimesi, majanduslikult haavatavaid, **lapsi ja noori** — administratiivküsimuste, saksa keele, eluaseme, ostlemise ja sotsiaaltoetustega. Meie Vorstand koosneb peamiselt puuetega inimestest — nii tulevad otsused tegelikust elukogemusest. 🤝';

  @override
  String get wizardIntroBubble6 =>
      'Nüüd on sinu kord. Registreerime sind — võtab umbes 5 minutit. Liigume samm-sammult, ma ei jäta sind üksi. ✨';

  @override
  String get wizardIntroStart => 'Alustame';

  @override
  String get wizardBack => 'Tagasi';

  @override
  String get wizardNext => 'Edasi';

  @override
  String wizardStepLabel(int step, int total, String title) {
    return 'Samm $step / $total · $title';
  }

  @override
  String get wizardErrRequired => 'See väli on kohustuslik';

  @override
  String wizardErrTooShort(int count) {
    return 'Liiga lühike (vähemalt $count märki)';
  }

  @override
  String get wizardErrOnlyLetters =>
      'Ainult tähed, tühikud, sidekriipsud ja apostroofid';

  @override
  String get wizardErrSaveFailed =>
      'Salvestamine ebaõnnestus. Kontrolli ühendust ja proovi uuesti.';

  @override
  String get wizardStufe1aTitle => 'Isikuandmed';

  @override
  String get wizardStufe1aPrompt =>
      'Tutvume ametlikult. Palun kirjuta oma nimi täpselt nii nagu Personalausweis, Reisepass või Aufenthaltstitel — et see sobiks dokumentidega.';

  @override
  String get wizardStufe1aVornameLabel => 'Vornamen (eesnimed)';

  @override
  String get wizardStufe1aVornameHelper =>
      'Kõik eesnimed täpselt nagu dokumendil. Tühiku või sidekriipsuga (nt Hans-Peter, Maria Anna).';

  @override
  String get wizardStufe1aNachnameLabel => 'Familienname (perekonnanimi)';

  @override
  String get wizardStufe1aNachnameHelper => 'Sinu praegune perekonnanimi.';

  @override
  String get wizardStufe1aGeburtsnameLabel =>
      'Geburtsname (sünninimi) — vabatahtlik';

  @override
  String get wizardStufe1aGeburtsnameHelper =>
      'Ainult kui erineb perekonnanimest — nt enne abielu.';

  @override
  String get wizardStufe1bTitle => 'Sünnipäev';

  @override
  String get wizardStufe1bPrompt =>
      'Soovime tähistada sinu sünnipäeva koos! 🎂 See aitab meil ka kontrollida, et oled vähemalt 16 — nii ütleb meie põhikiri.';

  @override
  String get wizardStufe1bGeburtsdatumLabel => 'Sünnikuupäev';

  @override
  String get wizardStufe1bGeburtsdatumHelper => 'Puuduta kuupäeva valimiseks';

  @override
  String get wizardStufe1bGeburtsortLabel => 'Sünnikoht';

  @override
  String get wizardStufe1bGeburtsortHelper => 'Linn / koht, kus sa sündisid.';

  @override
  String get wizardAgeGatePrompt => 'Mul on kahju… 😔';

  @override
  String wizardAgeGateBody1(int age, int years) {
    return 'Meie põhikiri ütleb, et liikmeks saamiseks pead olema vähemalt 16. Sa oled $age — loodan näha sind $years aasta pärast! 🌱';
  }

  @override
  String get wizardAgeGateBody2 =>
      'Kui soovid juhuslikult vabatahtlikuna aidata (mistahes vanus, vanemate nõusolekul), helista — meile meeldib toetada noori, kes tahavad maailma muuta.';

  @override
  String get wizardAgeGateBackHome => 'Tagasi tervitusekraanile';

  @override
  String get wizardErrInvalidPhone => 'Vigane telefoninumber';

  @override
  String get wizardStufe1b1Title => 'Vanema nõusolek';

  @override
  String get wizardStufe1b1Prompt =>
      'Oled alaealine (16-17) — vastavalt §106 BGB vajame vanema või seadusliku esindaja nõusolekut. Ütle nimi ja telefon. Vorsitzer helistab ja lepib kokku kohtumise (kohapeal või videokõnega). Mitte e-postiga — tahame olla kindlad, et räägime õige inimesega.';

  @override
  String get wizardStufe1b1VornameLabel => 'Vanema eesnimi';

  @override
  String get wizardStufe1b1VornameHelper => 'Nagu vanema Personalausweisis.';

  @override
  String get wizardStufe1b1NachnameLabel => 'Vanema perekonnanimi';

  @override
  String get wizardStufe1b1NachnameHelper => 'Nagu vanema Personalausweisis.';

  @override
  String get wizardStufe1b1TelefonLabel => 'Vanema mobiilinumber';

  @override
  String get wizardStufe1b1TelefonHelper =>
      'Sellele numbrile helistab Vorsitzer.';

  @override
  String get wizardStufe1b1RelationLabel => 'Suhe lapsega:';

  @override
  String get wizardStufe1b1RelationMutter => 'Ema';

  @override
  String get wizardStufe1b1RelationVater => 'Isa';

  @override
  String get wizardStufe1b1RelationSorgeberechtigter => 'Seaduslik esindaja';

  @override
  String get wizardStufe1b1RelationAndere => 'Muu hooldaja';

  @override
  String get wizardStufe1cTitle => 'Isikuandmed';

  @override
  String get wizardStufe1cPrompt =>
      'Lihtsalt et sind veidi paremini tundma õppida. See jääb meie vahele ja ei kuvata kusagil avalikult.';

  @override
  String get wizardStufe1cGeschlechtLabel => 'Sugu';

  @override
  String get wizardStufe1cGeschlechtMaennlich => 'Mees';

  @override
  String get wizardStufe1cGeschlechtWeiblich => 'Naine';

  @override
  String get wizardStufe1cGeschlechtDivers => 'Muu';

  @override
  String get wizardStufe1cGeschlechtKeineAngabe => 'Eelistan mitte öelda';

  @override
  String get wizardStufe1cFamilienstandLabel => 'Perekonnaseis';

  @override
  String get wizardStufe1cFamilienstandLedig => 'Vallaline';

  @override
  String get wizardStufe1cFamilienstandVerheiratet => 'Abielus';

  @override
  String get wizardStufe1cFamilienstandGeschieden => 'Lahutatud';

  @override
  String get wizardStufe1cFamilienstandVerwitwet => 'Lesk';

  @override
  String get wizardStufe1dTitle => 'Sinu päritolu';

  @override
  String get wizardStufe1dPrompt =>
      'See aitab meil pakkuda sulle õiget tuge — näiteks Aufenthalt nõustamist või sinu keelekogukonna leidmist.';

  @override
  String get wizardStufe1dStaatLabel => 'Kodakondsus';

  @override
  String get wizardStufe1dStaatHelper =>
      'Nt deutsch, rumänisch, ukrainisch. Mitu eraldatud komaga.';

  @override
  String get wizardStufe1dAufenthaltLabel =>
      'Elamisstaatus (Aufenthaltsstatus) — vabatahtlik';

  @override
  String get wizardStufe1dAufenthaltHelper =>
      'Vali tiitel oma Aufenthaltskarte / otsuse alusel. Vorstand võrdleb seda sinu dokumentidega.';

  @override
  String get wizardStufe1dAufenthaltAwaitingCitizenship =>
      'Täida kõigepealt kodakondsus üleval — näitame ainult sobivaid valikuid.';

  @override
  String get wizardStufe1dAufenthaltGerman =>
      'Aufenthaltstitel pole vaja — Saksamaa kodanik.';

  @override
  String get wizardStufe1dAufenthaltEuEea =>
      'EL/EMP/CH kodanik — vaba liikumine (Freizügigkeit).';

  @override
  String get wizardStufe1dAufenthaltTempHint => 'ajutine';

  @override
  String get wizardStufe1dAufenthaltPermHint => 'alaline elamisluba';

  @override
  String get wizardStufe1dAufenthaltAsylumProcessHint => 'varjupaigamenetlus';

  @override
  String get wizardStufe1dAufenthaltOther => 'Muu (täpsusta vestluses)';

  @override
  String get wizardStufe1dAufenthaltRequired => 'Palun vali Aufenthaltstitel.';

  @override
  String get wizardStufe1dMutterspracheLabel => 'Emakeel';

  @override
  String get wizardStufe1dMutterspracheHelper =>
      'Eeltäidetud rakenduse keelega — muuda kui erineb.';

  @override
  String get wizardStufe1eTitle => 'Aadress';

  @override
  String get wizardStufe1ePrompt =>
      'Sinu postiaadress — kasutame seda ametlikele dokumentidele (põhikiri, liikmelepingud, teated).';

  @override
  String get wizardStufe1eStrasseLabel => 'Tänav';

  @override
  String get wizardStufe1eStrasseHelper =>
      'Ainult tänava nimi — number kõrvalolevasse lahtrisse.';

  @override
  String get wizardStufe1eHausnummerLabel => 'Nr';

  @override
  String get wizardStufe1ePlzLabel => 'PLZ (sihtnr)';

  @override
  String get wizardStufe1eOrtLabel => 'Linn';

  @override
  String get wizardStufe1eLandLabel => 'Riik';

  @override
  String get wizardStufe1eLandHelper => 'Eeltäidetud: Deutschland.';

  @override
  String get wizardErrInvalidStreet => 'Vigane tänava nimi';

  @override
  String get wizardErrInvalidHausnummer => 'Vigane number (nt 12, 12a, 12/3)';

  @override
  String get wizardErrInvalidPlz => 'Vigane sihtnumber (ainult numbrid)';

  @override
  String get wizardStufe1fTitle => 'Kontakt';

  @override
  String get wizardStufe1fPrompt =>
      'Kuidas sind kätte saame? Telefon on ainult hädaolukordade jaoks — kõik muu käib meie enda otspunktist-otspunkti krüpteeritud kanali kaudu rakenduses. Sinu liikme-e-post määratakse automaatselt ja näed seda allpool.';

  @override
  String get wizardStufe1fTelefonLabel => 'Mobiilinumber';

  @override
  String get wizardStufe1fTelefonHelper =>
      'Luban, et helistan ainult kui on midagi olulist. 📱';

  @override
  String get wizardStufe2Title => 'Liikme tüüp';

  @override
  String get wizardStufe2Prompt =>
      'Milline liige soovid olla? Las ma selgitan iga valiku.';

  @override
  String get wizardStufe2OrdentlichTitle => 'Tavaline liige (ordentlich)';

  @override
  String get wizardStufe2OrdentlichBody =>
      'Täielikud õigused. Maksad igakuist liikmemaksu, hääletad üldkoosolekul, võid olla valitud juhatusse. Vaikevalik.';

  @override
  String get wizardStufe2FoerderTitle => 'Toetajaliige (Fördermitglied)';

  @override
  String get wizardStufe2FoerderBody =>
      'Toetad ühingut rahaliselt, kuid ei osale aktiivselt otsustes. Hääleõiguseta. Hea kui soovid aidata kaugelt.';

  @override
  String get wizardStufe2EhrenTitle => 'Auliige (Ehrenmitglied)';

  @override
  String get wizardStufe2EhrenBody =>
      'Annab juhatus erilise teenistuse eest. Sa ei vali seda ise — antakse tunnustusena. Vali ainult, kui sind on juba pärjatud.';

  @override
  String get wizardStufe3Title => 'Rahaline olukord';

  @override
  String get wizardStufe3Prompt =>
      'Nüüd sinu rahalisest olukorrast. Mitte selleks, et hinnata — vaid et vabastada sind liikmemaksust, kui saad sotsiaaltoetusi.';

  @override
  String get wizardStufe3OptionBuergergeld => 'Saan Bürgergeld';

  @override
  String get wizardStufe3OptionSozialamt => 'Saan Sozialamt-toetusi';

  @override
  String get wizardStufe3OptionNein => 'Ei saa kumbagi neist';

  @override
  String get wizardStufe3FeeExemptTitle => 'Liikmemaks: 0 € / kuu 🎉';

  @override
  String get wizardStufe3FeeExemptBody =>
      'Bürgergeldi, Sozialamti, ALG I või Krankengeldiga oled vastavalt Satzungi §6-le liikmemaksust täielikult vabastatud. Vajame ainult tõendit (Leistungsbescheid või kinnitus ametiasutuselt / haigekassalt).';

  @override
  String get wizardStufe3UploadTitle => 'Lae üles Leistungsbescheid';

  @override
  String get wizardStufe3UploadHint => 'PDF / JPG / PNG, kuni 10 MB.';

  @override
  String get wizardStufe3UploadRequired =>
      'Palun lae Leistungsbescheid üles enne jätkamist.';

  @override
  String get wizardStufe3FileTooLarge =>
      'Fail on liiga suur. Maksimaalselt 10 MB.';

  @override
  String get wizardStufe3UploadFailed =>
      'Faili üleslaadimine ebaõnnestus. Proovi uuesti.';

  @override
  String get wizardStufe3RegularFeeTitle => 'Liikmemaks: 25 € / kuu';

  @override
  String get wizardStufe3RegularFeeBody =>
      'Põhikirja kohane standardne liikmemaks tavaliikmetele.';

  @override
  String get wizardStufe4Title => 'Makse';

  @override
  String get wizardStufe4Prompt =>
      'Kuidas soovid liikmemaksu maksta? Ja millisel kuupäeval kuus kõige sobivam?';

  @override
  String get wizardStufe4MethodUeberweisungTitle =>
      'Pangaülekanne (Überweisung)';

  @override
  String get wizardStufe4MethodUeberweisungBody =>
      'Sa algatad makse igal kuul ise oma kontolt.';

  @override
  String get wizardStufe4MethodSepaTitle =>
      'SEPA-Lastschrift (otsedebiteerimine)';

  @override
  String get wizardStufe4MethodSepaBody =>
      'Veame summa automaatselt sinu kontolt. Kõige mugavam, kuid vajame IBAN-i ja allkirjastatud volitust.';

  @override
  String get wizardStufe4MethodDauerauftragTitle =>
      'Dauerauftrag (püsikorraldus)';

  @override
  String get wizardStufe4MethodDauerauftragBody =>
      'Seadistad pangas püsikorralduse. Pank kannab summa igal kuul automaatselt.';

  @override
  String get wizardStufe4DayLabel => 'Maksepäev';

  @override
  String get wizardStufe4DayHint => 'Vali päev 1 ja 31 vahel';

  @override
  String wizardStufe4DayItem(int day) {
    return '$day. päev';
  }

  @override
  String wizardStufe4DayReminder(int day) {
    return 'Liikmemaksu võetakse iga kuu $day. kuupäeval.';
  }

  @override
  String get wizardStufe5Title => 'Algus';

  @override
  String get wizardStufe5Prompt =>
      'Millal soovid ametlikult ICD360S liige olla? Heakskiidust või tagasiulatuvalt.';

  @override
  String get wizardStufe5OptionAbVerifizierungTitle => 'Vorstand heakskiidust';

  @override
  String get wizardStufe5OptionAbVerifizierungBody =>
      'Lihtsaim valik. Tagasiulatuvat liikmemaksu pole.';

  @override
  String get wizardStufe5OptionGruendungsdatumTitle =>
      'Tagasiulatuvalt alates 01.08.2025 (asutamine)';

  @override
  String get wizardStufe5OptionGruendungsdatumBody =>
      'Loendud liikmena alates ühingu esimesest päevast.';

  @override
  String get wizardStufe5OptionAnderesDatumTitle => 'Muu kuupäev';

  @override
  String get wizardStufe5OptionAnderesDatumBody =>
      'Sina valid kuupäeva 01.08.2025 ja tänase vahel.';

  @override
  String get wizardStufe5PickDate => 'Puuduta kuupäeva valimiseks';

  @override
  String get wizardStufe5PickDateFirst => 'Palun vali kõigepealt kuupäev.';

  @override
  String get wizardStufe5DatePickerHelp => 'Liikmestaatuse algus';

  @override
  String wizardStufe5DateRange(String start) {
    return 'Vahemikus $start kuni täna';
  }

  @override
  String get wizardStufe5RetroactiveTitle => 'Tagasiulatuv liikmemaks';

  @override
  String wizardStufe5RetroactiveBody(
      String start, String end, int months, String amount) {
    return 'Alates $start kuni $end on see $months kuud. 25 €/kuus on see $amount € tagasiulatuvalt tasumiseks, lisaks praegusele kuumaksule.';
  }

  @override
  String get wizardStufe5FeeExemptTitle => 'Tagasiulatuv liikmemaks: 0 € 🎉';

  @override
  String get wizardStufe5FeeExemptBody =>
      'Bürgergeld või Sozialamt korral oled täiesti vabastatud — ka tagasiulatuvalt ei võlgne midagi.';

  @override
  String wizardDocumentPrompt(String doc) {
    return 'Enne lõpetamist palun loe hoolikalt $doc. On oluline teada, mida sa allkirjastad.';
  }

  @override
  String get wizardDocumentScrollHint => 'Keri lõpuni, et jätkata.';

  @override
  String get wizardDocumentScrolledOk => 'Sa lugesid lõpuni ✓';

  @override
  String wizardDocumentOpenButton(String doc) {
    return 'Ava $doc brauseris';
  }

  @override
  String get wizardDocumentExternalHint =>
      'Sellel platvormil avame dokumendi sinu vaikebrauseris.';

  @override
  String get wizardDocumentOpenedOk =>
      'Dokument avati. Palun loe see hoolikalt läbi.';

  @override
  String wizardDocumentConfirm(String doc) {
    return 'Kinnitan, et olen lugenud ja nõustun $doc-ga.';
  }

  @override
  String get wizardFinalAdultTitle => 'Valmis! Oled liige 🎉';

  @override
  String get wizardFinalMinorTitle => 'Sinu päring on saadetud 📨';

  @override
  String get wizardFinalMinorBody =>
      'Võtame ühendust sinu vanemaga ja lepime kohtumise kokku (kohapeal või videokõnega). Palun ole kannatlik — protsess võib kesta kuni 7 päeva. Saad rakenduses teate niipea, kui vanem on heaks kiitnud.';

  @override
  String get wizardFinalMitgliedernummerLabel => 'Sinu liikmenumber';

  @override
  String get wizardStufe4MethodComingSoon => 'Tulemas';

  @override
  String get wizardStufe4StreichungWarning =>
      'Kui jääd liikmemaksuga rohkem kui 6 kuud võlgu, kustutame sind automaatselt (Satzung §6 Abs. 3).';

  @override
  String get wizardStufe5KuendigungInfo =>
      'Lahkumiseks: saada meile kirjalik ülesütlemine 3 kuud enne 31. detsembrit (hiljemalt 30. septembriks, et see jõustuks aasta lõpus). Minimaalset kestust pole (Satzung §6 Abs. 3).';

  @override
  String get wizardStufe1fEmailLabel => 'Sinu liikme-e-post';

  @override
  String get wizardStufe1fEmailHelper =>
      'Määratakse automaatselt sinu liikmenumbri põhjal. Aktiveeritakse sel hetkel, kui juhatus (Vorstand) sinu avalduse kinnitab. Meil on oma e-posti rakendus — saada ja võta vastu krüpteeritud e-kirju, lihtsalt ja tasuta.';

  @override
  String get wizardErrInvalidEmail => 'Vigane e-posti aadress';

  @override
  String get wizardStufe3OptionAlg1 =>
      'Saan Arbeitslosengeld I (ALG I, töötuskindlustushüvitis)';

  @override
  String get wizardStufe3OptionKrankengeld =>
      'Saan Krankengeld (pikaajaline haigushüvitis)';

  @override
  String get wizardStufe3UploadAddMore => 'Lisa veel üks dokument';

  @override
  String get wizardStufe3UploadLimitCount => 'Piir täis: kuni 20 dokumenti.';

  @override
  String get wizardStufe3UploadLimitTotal =>
      'Saavutatud kogu maht 100 MB. Kustuta üks olemasolev fail.';

  @override
  String get wizardStufe3UploadDeleteTooltip => 'Kustuta';

  @override
  String wizardStufe3UploadCounter(int count, int max) {
    return '$count / $max dokumenti';
  }

  @override
  String get wizardDocumentExternalOpenFailed =>
      'Brauserit ei õnnestunud avada. Link on lõikepuhvris — kleebi see brauserisse, et jätkata.';

  @override
  String get wizardFinalTimelineProcessing =>
      'Vorstand kontrollib · tavaliselt 1 tööpäev, kuni 7';

  @override
  String get wizardFinalTimelineActivated => 'Konto aktiveeritud';

  @override
  String get wizardFinalAdultThank =>
      'Aitäh, et täitsid registreerimisvormi! 🎉';

  @override
  String get wizardFinalAdultUsual =>
      'Sinu avaldus on meil. Tavaliselt kinnitame selle ühe tööpäeva jooksul.';

  @override
  String get wizardFinalAdultExceptional =>
      'Mõnikord võib see võtta kuni 7 tööpäeva. Ja kui midagi ei klapi, saadame su tagasi vormi, et saaksid parandada 🙂';

  @override
  String get wizardFinalStatusTitle => 'AVALDUSE OLEK';

  @override
  String wizardFinalStatusStepsValidated(int reviewed, int total) {
    return '$reviewed/$total sammu kinnitanud Vorstand';
  }

  @override
  String get wizardFinalStufeSheetTitle => 'Avalduse üksikasjad';

  @override
  String get wizardFinalStufeSheetHint =>
      'Kaheksa etappi, mille täitsid. Vorstand vaatab need ühekaupa läbi — näed reaalajas, mis on juba kinnitatud.';

  @override
  String get wizardFinalStufeStatusPending => 'Ootab ülevaatamist';

  @override
  String get wizardFinalStufeStatusApproved => 'Kinnitatud';

  @override
  String get wizardFinalStufeStatusRejected => 'Tagasi lükatud';

  @override
  String wizardFinalStatusRejectionCount(int count) {
    return '$count samm vajab parandust';
  }

  @override
  String get wizardFinalStufeRejectionReason => 'Vorstandi põhjus:';

  @override
  String get wizardFinalStufeCorrectNow => 'Paranda kohe';

  @override
  String wizardFinalApprovalsHeader(int current, int total) {
    return 'Vorstandi heakskiidud ($current/$total)';
  }

  @override
  String get wizardFinalApprovalAwaiting => 'Ootame 2. Vorstandi';

  @override
  String get wizardFinalApprovalRejected => 'TAGASI LÜKATUD';

  @override
  String get wizardFinalStufeNoDataYet => 'Andmed pole veel saadaval.';

  @override
  String get wizardFinalStufeReadAt => 'Loetud:';

  @override
  String get wizardFinalStufeBeitragsfrei =>
      'Liikmemaksuvaba (makse pole nõutav)';

  @override
  String get wizardFinalStufeNotExempt => 'Ilma sotsiaaltoetusteta';

  @override
  String get wizardFinalStufeBeginAtVerification => 'Algab kinnitamisel';

  @override
  String get wizardFinalStufeBeginAtFoundation =>
      'Asutamiskuupäev (tagasiulatuvalt)';

  @override
  String get wizardFinalStufeBeginAtCustom => 'Muu kuupäev';

  @override
  String get wizardFinalStufeStatusSkipped => 'Vahele jäetud';

  @override
  String get wizardFinalStufeFilledAt => 'Täidetud:';

  @override
  String get wizardFinalStufeReviewedAt => 'Kontrollitud:';

  @override
  String get wizardFinalWithdrawLink => 'Tühista avaldus';

  @override
  String get wizardFinalWithdrawDialogTitle => 'Tühistada avaldus?';

  @override
  String get wizardFinalWithdrawDialogBody =>
      'Sinu avaldus märgitakse sinu poolt tagasi võetuks. Andmed jäävad andmebaasi auditeerimiseks (GDPR), kuid kontot ei aktiveerita. Sa võid registreerimise igal ajal uue liikmenumbriga uuesti alustada.';

  @override
  String get wizardFinalWithdrawKeep => 'Ei, jään ootama';

  @override
  String get wizardFinalWithdrawConfirm => 'Jah, tühistada';

  @override
  String get wizardErrTooManyWithdrawals =>
      'Sinu avaldust ei saa automaatselt töödelda. Helista meile või tule isiklikult Vorstandi juurde, et registreerimist jätkata.';

  @override
  String get wizardDuplicateLoginTitle => 'Tundub, et oled juba meie liige';

  @override
  String get wizardDuplicateLoginBody =>
      'Sinu nime ja sünnikuupäevaga leiame juba aktiivse konto. Palun kasuta avakuval „Olen juba liige\", et sisse logida. Kui sul pole enam ligipääsu, helista meile.';

  @override
  String get wizardDuplicatePendingTitle => 'Sinu avaldus on juba meil';

  @override
  String get wizardDuplicatePendingBody =>
      'Sinu nime ja sünnikuupäevaga on meil juba avaldus läbivaatamisel. Vorstand tegeleb sellega — teavitame rakenduses, niipea kui konto on aktiivne. Helista, kui tahad rääkida.';

  @override
  String get wizardDuplicateRecentlyWithdrawnTitle =>
      'Praegu ei saa seda avaldust töödelda';

  @override
  String get wizardDuplicateRecentlyWithdrawnBody =>
      'Sinu nimi ja sünnikuupäev sobivad hiljuti tagasi võetud avaldusega. Palun helista meile, et rääkida Vorstandiga enne jätkamist.';

  @override
  String get wizardDuplicatePreviouslyWithdrawnTitle =>
      'Oled juba varem avalduse esitanud';

  @override
  String get wizardDuplicatePreviouslyWithdrawnBody =>
      'Sinu nimi ja sünnikuupäev sobivad vanema avaldusega, mille olid tagasi võtnud. Tere tulemast tagasi — palun helista enne jätkamist, et Vorstand saaks otsustada, kuidas edasi tegutseme.';

  @override
  String get wizardDuplicateCallUsTitle => 'Palun helista meile';

  @override
  String get wizardDuplicateCallUsBody =>
      'Sinu nimi ja sünnikuupäev on meil juba olemas, kuid me ei saa üksikasju rakenduse kaudu jagada. Palun helista meile — Vorstand selgitab olukorra otse.';

  @override
  String get wizardChatHelp => 'Räägime';

  @override
  String get wizardChatHelpSubtitle => 'Otsesuhtlus Vorstandiga · kiire vastus';

  @override
  String get benachrichtigungTitel => 'SMS-meeldetuletused';

  @override
  String get benachrichtigungIntro =>
      'Et te ei jätaks kohtumist vahele, võib ühing saata teile SMS-i. Teie otsustate, kas ja mille kohta — ja saate seda igal ajal muuta.';

  @override
  String get benachrichtigungTermineFrage =>
      'Kas soovite oma kohtumiste kohta meeldetuletusi SMS-iga?';

  @override
  String get benachrichtigungTermineDetail =>
      'Sõnum sisaldab kohtumise kuupäeva, kellaaega, kohta ja teemat.';

  @override
  String get benachrichtigungMedikamenteFrage =>
      'Kas soovite meeldetuletusi ka oma ravimite kohta?';

  @override
  String get benachrichtigungMedikamenteDetail =>
      'Siis on sõnumis ravimi nimi. See on terviseandmed — seetõttu küsime eraldi.';

  @override
  String get benachrichtigungHinweis =>
      'Meeldetuletus on abi, mitte garantii: palun ärge tuginege ainult sellele. Saate seda igal ajal oma profiilis muuta.';

  @override
  String get benachrichtigungJa => 'Jah';

  @override
  String get benachrichtigungNein => 'Ei';

  @override
  String get benachrichtigungSpaeter => 'Otsustan hiljem';

  @override
  String get benachrichtigungSpeichern => 'Salvesta';

  @override
  String get benachrichtigungGespeichert => 'Aitäh, salvestatud.';

  @override
  String get benachrichtigungenLeer => 'Teateid pole';

  @override
  String get benachrichtigungenAlleGelesen => 'Märgi kõik loetuks';

  @override
  String get benachrichtigungWetterFrage =>
      'Kas soovite hoiatusi ohtliku ilma eest oma elukohas?';

  @override
  String get benachrichtigungWetterDetail =>
      'Ainult Saksa ilmateenistuse ametlikud hoiatused alates tasemest „raske“ — mitte iga vihma korral.';

  @override
  String get signaturTitel => 'Allkirjad';

  @override
  String get signaturNichtsOffen =>
      'Praegu ei ole ühtegi dokumenti, mis ootaks Teie allkirja.';

  @override
  String get signaturStatusOffen => 'Ootab Teie allkirja';

  @override
  String get signaturStatusSigniert => 'Olete allkirjastanud';

  @override
  String get signaturStatusAbgelehnt => 'Olete tagasi lükanud';

  @override
  String get signaturStatusWiderrufen => 'Ühing võttis tagasi';

  @override
  String get signaturStatusAbgelaufen => 'Tähtaeg on möödunud';

  @override
  String signaturBitteGanzLesen(int gelesen, int gesamt) {
    return 'Palun lugege dokument lõpuni (lehekülg $gelesen $gesamt-st).';
  }

  @override
  String get signaturWeiterZurUnterschrift => 'Edasi allkirjastamise juurde';

  @override
  String get signaturAblehnen => 'Lükake tagasi';

  @override
  String get signaturAblehnenHinweis =>
      'Ühingut teavitatakse sellest. Soovi korral võite oma põhjused kirja panna.';

  @override
  String get signaturAblehnenGrund => 'Põhjus (valikuline)';

  @override
  String get signaturMitFingerHinweis =>
      'Kirjutage oma allkiri sõrmega valgele väljale.';

  @override
  String get signaturNochmal => 'Uuesti';

  @override
  String get signaturZurueckZumDokument => 'Tagasi dokumendi juurde';

  @override
  String get signaturCodeAnfordern => 'Saatke kood SMS-iga';

  @override
  String get signaturCodeUnterwegs => 'Kood on teel.';

  @override
  String signaturCodeGesendetAn(String nummer) {
    return 'Saatsime Teile koodi numbrile $nummer.';
  }

  @override
  String get signaturCodeErneutSenden => 'Saatke kood uuesti';

  @override
  String get signaturJetztUnterschreiben => 'Allkirjastage nüüd';

  @override
  String get signaturCodeFalsch => 'Kood ei ole õige.';

  @override
  String get signaturCodeAbgelaufen =>
      'Kood on aegunud. Palun küsige uus kood.';

  @override
  String get signaturZuVieleVersuche =>
      'Liiga palju ebaõnnestunud katseid. Palun küsige uus kood.';

  @override
  String get signaturKeineRufnummer =>
      'Teie kontole ei ole mobiilinumbrit lisatud. Ilma selleta ei saa me Teile koodi saata — palun pöörduge ühingu esimehe poole.';

  @override
  String get signaturCodeFehlgeschlagen => 'Koodi ei õnnestunud saata.';

  @override
  String get signaturLeer => 'Palun andke kõigepealt oma allkiri.';

  @override
  String get signaturErfolg => 'Aitäh — Teie allkiri on meieni jõudnud.';

  @override
  String get signaturFehlgeschlagen =>
      'See ei õnnestunud. Palun proovige veel kord.';

  @override
  String get signaturSiegelInArbeit =>
      'Allkirjastatud dokument on veel valmimisel. Palun proovige minuti pärast uuesti.';
}
