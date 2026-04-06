// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Estonian (`et`).
class AppLocalizationsEt extends AppLocalizations {
  AppLocalizationsEt([String locale = 'et']) : super(locale);

  @override
  String get appTitle => 'ICD360S e.V - Liikmete portaal';

  @override
  String get memberPortal => 'Liikmete portaal';

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
  String get password => 'Parool';

  @override
  String get passwordHint => 'Sisesta parool';

  @override
  String get confirmPassword => 'Kinnita parool';

  @override
  String get confirmPasswordHint => 'Kinnita parool';

  @override
  String get newPassword => 'Uus parool';

  @override
  String get newPasswordHint => 'Sisesta uus parool';

  @override
  String get saveCredentials => 'Salvesta sisselogimisandmed';

  @override
  String get autoLogin => 'Automaatne sisselogimine';

  @override
  String get forgotPassword => 'Unustasid parooli?';

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
  String get recoveryCode => 'Taastekood (6 numbrit)';

  @override
  String get recoveryCodeHelper => 'Jäta see kood parooli taastamiseks meelde';

  @override
  String get recoveryCodeHint => 'Sisesta taastekood';

  @override
  String get recoveryCodeInvalid => 'Kood peab olema täpselt 6 numbrit';

  @override
  String get loginFailed => 'Sisselogimine ebaõnnestus';

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
  String get tooManyDevices => 'Liiga palju seadmeid';

  @override
  String get maxDevicesMessage =>
      'Oled juba 3 seadmesse sisse logitud.\nVali seade väljalogimiseks:';

  @override
  String get unknownDevice => 'Tundmatu seade';

  @override
  String get unknown => 'Tundmatu';

  @override
  String get logoutError => 'Väljalogimise viga';

  @override
  String error(String error) {
    return 'Viga: $error';
  }

  @override
  String get cancel => 'Tühista';

  @override
  String get resetPassword => 'Lähtesta parool';

  @override
  String get forgotPasswordTitle => 'Unustatud parool';

  @override
  String get forgotPasswordDescription =>
      'Sisesta oma liikme number ja registreerimisel loodud taastekood.';

  @override
  String get passwordResetSuccess =>
      'Parool lähtestatud!\n\nNüüd saad oma uue parooliga sisse logida.';

  @override
  String get passwordResetFailed => 'Parooli lähtestamine ebaõnnestus';

  @override
  String get needHelp => 'Vajad abi?';

  @override
  String get helpQuestion => 'Probleemid sisselogimise või registreerimisega?';

  @override
  String get helpDescription =>
      'Võta meiega ühendust WhatsAppi kaudu ja kirjelda, mis ei tööta. Vastame esimesel võimalusel!';

  @override
  String get whatsapp => 'WhatsApp';

  @override
  String get emailSubject => 'Päring ICD360S rakenduse kaudu';

  @override
  String get whatsappMessage => 'Tere, mul on probleem ICD360S rakendusega. ';

  @override
  String get imprint => 'Impressum';

  @override
  String get privacy => 'Privaatsuspoliitika';

  @override
  String get statutes => 'Põhikiri';

  @override
  String get revocation => 'Taganemisõigus';

  @override
  String get cancellation => 'Tühistamine';

  @override
  String get allRightsReserved => 'Kõik õigused kaitstud.';

  @override
  String get enterCredentials => 'Sisesta liikme number ja parool';

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
  String get membership => 'Liikmelisus';

  @override
  String get myAppointments => 'Minu kohtumised';

  @override
  String get appointmentsLoadingReady => 'Kohtumiste laadimine - API valmis!';

  @override
  String get priority => 'Prioriteet';

  @override
  String get messageLabel => 'Sõnum';

  @override
  String get createdOn => 'Loodud';

  @override
  String get handler => 'Käsitleja';

  @override
  String get reportProblems => 'Teavita probleemidest';

  @override
  String get reportProblem => 'Teavita probleemist';

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
  String get newTicket => 'Uus pilet';

  @override
  String get noOpenTickets => 'Avatud pileteid pole';

  @override
  String get haveQuestionCreateTicket =>
      'Kas teil on küsimus või probleem?\nLooge uus pilet.';

  @override
  String get whatIsTheProblem => 'Mis on probleem?';

  @override
  String get describeTheProblem => 'Kirjeldage probleemi';

  @override
  String get howUrgentIsIt => 'Kui kiire see on?';

  @override
  String get low => 'Madal';

  @override
  String get medium => 'Keskmine';

  @override
  String get high => 'Kõrge';

  @override
  String get submit => 'Esita';

  @override
  String get fillSubjectAndMessage => 'Palun täitke teema ja sõnum';

  @override
  String get ticketCreated => 'Pilet loodud';

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
  String get newEmailAddress => 'Uus e-posti aadress';

  @override
  String get currentPassword => 'Praegune parool';

  @override
  String get saveEmail => 'Salvesta e-post';

  @override
  String get savePassword => 'Salvesta parool';

  @override
  String get deviceLoggedOut => 'Seade välja logitud';

  @override
  String get passwordChangedSuccessfully => 'Parool edukalt muudetud';

  @override
  String get emailChangedSuccessfully => 'E-post edukalt muudetud';

  @override
  String get errorChangingPassword => 'Viga parooli muutmisel';

  @override
  String get errorChangingEmail => 'Viga e-posti muutmisel';

  @override
  String get validEmailRequired => 'Palun sisestage kehtiv e-posti aadress';

  @override
  String get passwordTooShort => 'Parool peab olema vähemalt 6 tähemärki';

  @override
  String get maxDevicesReached =>
      'Olete sisse loginud maksimaalselt 3 seadmesse.';

  @override
  String loggedInOnDevices(int count) {
    return 'Olete sisse loginud $count seadmesse 3-st.';
  }

  @override
  String get noActiveSessions => 'Aktiivseid seanse pole';

  @override
  String get logoutFromDevice => 'Logi sellest seadmest välja';

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
  String get errorAcceptingCall => 'Viga kõne vastuvõtmisel';

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
  String typingIndicator(String name) {
    return '$name kirjutab...';
  }

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
  String get diagnosticDataTitle => 'Diagnostikaandmed';

  @override
  String get diagnosticDescription =>
      'Kas soovite saata anonüümseid diagnostikaandmeid rakenduse parandamiseks?';

  @override
  String get noThanks => 'Ei, aitäh';

  @override
  String get yesEnable => 'Jah, luba';

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
  String get newPasswordMinChars => 'Uus parool (min. 6 tähemärki)';

  @override
  String get reasonLabel2 => 'Põhjus';

  @override
  String get downloadFailed2 => 'Allalaadimine ebaõnnestus';

  @override
  String get downloadTooltip => 'Laadi alla';

  @override
  String get connectionErrorGeneric => 'Ühendusviga';

  @override
  String get errorNoInternet => 'Internetiühendus puudub. Palun kontrollige oma võrku.';

  @override
  String get errorTimeout => 'Server ei vasta. Palun proovige hiljem uuesti.';

  @override
  String get errorServer => 'Serveri viga. Palun proovige hiljem uuesti.';

  @override
  String get errorConnection => 'Ühenduse viga. Palun proovige hiljem uuesti.';

  @override
  String get errorUnexpected => 'Tekkis ootamatu viga. Palun proovige hiljem uuesti.';

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
  String get bankTransfer => 'Pangaülekanne';

  @override
  String get standingOrder => 'Püsikorraldus';

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
  String get memberNumberTooLong =>
      'Liikmenuumber liiga pikk (maks 20 tähemärki)';

  @override
  String get onlyUppercaseAndNumbers => 'Lubatud ainult suurtähed ja numbrid';

  @override
  String get passwordTooLong => 'Parool liiga pikk (maks 100 tähemärki)';

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
  String get diagnosticErrors => 'Veateated parandamiseks';

  @override
  String get diagnosticAnonymousStats => 'Anonüümne kasutusstatistika';

  @override
  String get diagnosticPerformance => 'Rakenduse jõudlusandmed';

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
  String get ipClean => 'IP puhas - pole nimekirjas';

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
  String get helpImproveApp => 'Kas soovite meid aidata rakendust parandada?';

  @override
  String get noPersonalDataCollected =>
      'Isikuandmeid ei koguta. Seda seadet saab igal ajal muuta.';

  @override
  String logEntries(int count) {
    return '$count kirjet';
  }

  @override
  String get noLogs => 'Logisid pole';

  @override
  String get newLoginDetected => 'Tuvastati uus sisselogimine';

  @override
  String get waitingForMember => 'Oodatakse liiget';

  @override
  String get waitingForStaff => 'Oodatakse töötajat';

  @override
  String get waitingForAuthority => 'Oodatakse asutust';
}
