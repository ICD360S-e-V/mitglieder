// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Finnish (`fi`).
class AppLocalizationsFi extends AppLocalizations {
  AppLocalizationsFi([String locale = 'fi']) : super(locale);

  @override
  String get welcomeLoading => 'Ladataan...';

  @override
  String get welcomeAutoLogin => 'Automaattinen kirjautuminen...';

  @override
  String get login => 'Kirjaudu';

  @override
  String get register => 'Rekisteröidy';

  @override
  String get becomeMember => 'Liity jäseneksi';

  @override
  String get memberNumber => 'Jäsennumero';

  @override
  String get memberNumberHint => 'Anna jäsennumero';

  @override
  String get confirmPassword => 'Vahvista salasana';

  @override
  String get confirmPasswordHint => 'Vahvista salasana';

  @override
  String get newPassword => 'Uusi salasana';

  @override
  String get newPasswordHint => 'Anna uusi salasana';

  @override
  String get firstName => 'Etunimi ja sukunimi';

  @override
  String get firstNameHint => 'Anna etu- ja sukunimi';

  @override
  String get nameMinLength => 'Nimessä on oltava vähintään 2 merkkiä';

  @override
  String get nameOnlyLetters => 'Vain kirjaimet ja yhdysmerkit sallittu';

  @override
  String get email => 'Sähköpostiosoite';

  @override
  String get emailHint => 'Anna sähköposti';

  @override
  String get emailInvalid => 'Anna kelvollinen sähköpostiosoite';

  @override
  String get passwordMinLength => 'Salasanassa on oltava vähintään 6 merkkiä';

  @override
  String get passwordsNotMatch => 'Salasanat eivät täsmää';

  @override
  String get registrationFailed => 'Rekisteröinti epäonnistui';

  @override
  String connectionError(String error) {
    return 'Yhteysvirhe: $error';
  }

  @override
  String registrationSuccess(String memberNumber) {
    return 'Rekisteröinti onnistui!\n\nJäsennumerosi: $memberNumber\n\nMuista tämä numero kirjautumista varten.';
  }

  @override
  String get unknown => 'Tuntematon';

  @override
  String error(String error) {
    return 'Virhe: $error';
  }

  @override
  String get cancel => 'Peruuta';

  @override
  String get resetPassword => 'Nollaa salasana';

  @override
  String get imprint => 'Impressum';

  @override
  String get privacy => 'Tietosuojakäytäntö';

  @override
  String get statutes => 'Säännöt';

  @override
  String get revocation => 'Peruutusoikeus';

  @override
  String get appointments => 'Tapaamiset';

  @override
  String get tickets => 'Tiketit';

  @override
  String get liveChat => 'Live Chat';

  @override
  String get notifications => 'Ilmoitukset';

  @override
  String get myProfile => 'Profiilini';

  @override
  String get logout => 'Kirjaudu ulos';

  @override
  String get goodMorning => 'Hyvää huomenta';

  @override
  String get goodDay => 'Hyvää päivää';

  @override
  String get goodEvening => 'Hyvää iltaa';

  @override
  String get goodNight => 'Hyvää yötä';

  @override
  String get welcomeToICD => 'Tervetuloa ICD360S e.V:lle!';

  @override
  String get accountCreatedSuccessfully => 'Tilisi on luotu onnistuneesti.';

  @override
  String get today => 'Tänään';

  @override
  String get membershipFeeDue => 'Jäsenmaksu erääntynyt';

  @override
  String get pleaseTransferAnnualFee => 'Ole hyvä ja siirrä vuosimaksu.';

  @override
  String get newBadge => 'Uusi';

  @override
  String get close => 'Sulje';

  @override
  String get myAppointments => 'Omat tapaamiset';

  @override
  String get priority => 'Prioriteetti';

  @override
  String get messageLabel => 'Viesti';

  @override
  String get reportProblems => 'Ilmoita ongelmista';

  @override
  String get weRespondIn24Hours =>
      'Vastaamme sinulle enintään 24 tunnin kuluessa!';

  @override
  String get everythingOk => 'Kaikki OK!';

  @override
  String get haveProblemWeHelp => 'Ongelma?\nMe hoidamme sen!';

  @override
  String get myMembership => 'Jäsenyyteni';

  @override
  String get managePersonalDataAndFee =>
      'Hallitse henkilötietoja ja jäsenmaksua';

  @override
  String get myAppointmentsTitle => 'Tapaamiseni';

  @override
  String get appointmentsDescription =>
      'Täällä näet tulevat tapaamisesi.\nVoit vahvistaa osallistumisesi tai kieltäytyä.';

  @override
  String get loadAppointments => 'Lataa tapaamiset';

  @override
  String get myTickets => 'Tikettini';

  @override
  String get low => 'Matala';

  @override
  String get high => 'Korkea';

  @override
  String get submit => 'Lähetä';

  @override
  String get errorCreatingTicket => 'Virhe tiketin luomisessa';

  @override
  String get verified => 'Vahvistettu';

  @override
  String get account => 'Tili';

  @override
  String get myDevices => 'Laitteeni';

  @override
  String get changeEmail => 'Vaihda sähköposti';

  @override
  String get changePassword => 'Vaihda salasana';

  @override
  String get saveEmail => 'Tallenna sähköposti';

  @override
  String get savePassword => 'Tallenna salasana';

  @override
  String get deviceLoggedOut => 'Laite kirjautunut ulos';

  @override
  String get emailChangedSuccessfully => 'Sähköposti vaihdettu';

  @override
  String get errorChangingPassword => 'Virhe salasanan vaihdossa';

  @override
  String get errorChangingEmail => 'Virhe sähköpostin vaihdossa';

  @override
  String get validEmailRequired => 'Anna kelvollinen sähköpostiosoite';

  @override
  String get confirmLogoutDevice => 'Kirjaudu ulos laitteelta?';

  @override
  String get confirmLogoutMessage =>
      'Haluatko kirjautua ulos tältä laitteelta?\n\nSinun on kirjauduttava uudelleen käyttääksesi tätä laitetta.';

  @override
  String get ipAddress => 'IP';

  @override
  String get platform => 'Alusta';

  @override
  String trialWarningUrgentTitle(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days päivää',
      one: '1 päivä',
    );
    return 'Varoitus: Vain $_temp0 tilin jäädyttämiseen!';
  }

  @override
  String get trialWarningTitle => 'Tiliäsi ei ole vielä vahvistettu';

  @override
  String get trialWarningDescription =>
      'Täytä tietosi kohdassa \"Oma profiili\". 30 päivän jälkeen tilisi jäädytetään automaattisesti.';

  @override
  String trialDaysRemaining(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days päivää',
      one: '1 päivä',
    );
    return '$_temp0';
  }

  @override
  String get overview => 'Yleiskatsaus';

  @override
  String get member => 'Jäsen';

  @override
  String get memberManagement => 'Jäsenhallinta';

  @override
  String get reportProblemTooltip => 'Ilmoita ongelmasta';

  @override
  String get newAppointmentsTitle => 'Uudet tapaamiset';

  @override
  String get youHaveNewAppointment => 'Sinulla on uusi tapaaminen.';

  @override
  String youHaveNewAppointments(int count) {
    return 'Sinulla on $count uutta tapaamista.';
  }

  @override
  String get appointmentReminderTomorrow => 'Muistutus: Tapaaminen huomenna';

  @override
  String tomorrowAppointment(String title) {
    return 'Huomenna: $title';
  }

  @override
  String youHaveTomorrowAppointments(int count) {
    return 'Sinulla on $count tapaamista huomenna.';
  }

  @override
  String get appointmentsToday => 'Tapaamiset tänään';

  @override
  String todayAppointment(String title) {
    return 'Tänään: $title';
  }

  @override
  String youHaveTodayAppointments(int count) {
    return 'Sinulla on $count tapaamista tänään.';
  }

  @override
  String get paymentReminder => 'Maksumuistutus';

  @override
  String paymentReminderMessage(int day, String method) {
    return 'Tänään on kuukauden $day. päivä – suorita $method.';
  }

  @override
  String get paymentDayLabel => 'Maksupäivä (kuukausittainen muistutus)';

  @override
  String get updateAvailable => 'Päivitys saatavilla';

  @override
  String newVersionAvailable(String version) {
    return 'Uusi versio on saatavilla: $version';
  }

  @override
  String currentVersionLabel(String version) {
    return 'Nykyinen versio: $version';
  }

  @override
  String get changes => 'Muutokset:';

  @override
  String downloadProgress(String percent) {
    return 'Lataus: $percent%';
  }

  @override
  String get installationStarting => 'Asennus alkaa...';

  @override
  String get appWillRestart => 'Sovellus käynnistyy automaattisesti uudelleen.';

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
  String get later => 'Myöhemmin';

  @override
  String get updateNow => 'Päivitä nyt';

  @override
  String get downloading => 'Ladataan...';

  @override
  String get downloadFailed => 'Lataus epäonnistui. Yritä myöhemmin uudelleen.';

  @override
  String get searchingForUpdates => 'Etsitään päivityksiä...';

  @override
  String get appUpToDate => 'Sovellus on ajan tasalla';

  @override
  String get updateCheckError => 'Virhe päivityksen tarkistuksessa';

  @override
  String get changelog => 'Muutosloki';

  @override
  String get terminConfirmed => 'Tapaaminen vahvistettu';

  @override
  String get terminDeclined => 'Tapaaminen hylätty';

  @override
  String get terminRescheduleRequested => 'Siirto pyydetty';

  @override
  String get statusConfirmed => 'Vahvistettu';

  @override
  String get statusDeclined => 'Hylätty';

  @override
  String get statusRescheduling => 'Siirto';

  @override
  String get statusPending => 'Odottaa';

  @override
  String get categoryVorstandssitzung => 'Hallituksen kokous';

  @override
  String get categoryMitgliederversammlung => 'Yleiskokous';

  @override
  String get categorySchulung => 'Koulutus';

  @override
  String get categorySonstiges => 'Muu';

  @override
  String openCount(int count) {
    return '$count avointa';
  }

  @override
  String get refresh => 'Päivitä';

  @override
  String get filterUpcoming => 'Tulevat';

  @override
  String get filterPast => 'Menneet';

  @override
  String get filterAll => 'Kaikki';

  @override
  String get noUpcomingAppointments => 'Ei tulevia tapaamisia';

  @override
  String get noPastAppointments => 'Ei menneitä tapaamisia';

  @override
  String get noAppointmentsAvailable => 'Ei tapaamisia';

  @override
  String get appointmentsShownHere => 'Tapaamisesi näytetään täällä';

  @override
  String get dateLabel => 'Päivämäärä';

  @override
  String get timeLabel => 'Aika';

  @override
  String get locationLabel => 'Paikka';

  @override
  String get createdByLabel => 'Luonut';

  @override
  String get descriptionLabel => 'Kuvaus';

  @override
  String get ticketLabel => 'Tiketti';

  @override
  String get yourStatus => 'Tilasi: ';

  @override
  String reasonLabel(String reason) {
    return 'Syy: $reason';
  }

  @override
  String durationMinutes(int minutes) {
    return '$minutes min';
  }

  @override
  String get confirm => 'Vahvista';

  @override
  String get decline => 'Hylkää';

  @override
  String get reschedule => 'Siirrä';

  @override
  String get requestReschedule => 'Pyydä siirtoa';

  @override
  String appointmentLabel(String title) {
    return 'Tapaaminen: $title';
  }

  @override
  String get rescheduleReason => 'Syy siirtoon *';

  @override
  String get rescheduleReasonHint => 'Anna syy...';

  @override
  String get pleaseProvideReason => 'Anna syy';

  @override
  String get request => 'Pyydä';

  @override
  String get ticketStatusOpen => 'Avoin';

  @override
  String get ticketStatusInProgress => 'Käsittelyssä';

  @override
  String get ticketStatusWaitingMember => 'Odottaa jäsentä';

  @override
  String get ticketStatusWaitingStaff => 'Odottaa henkilökuntaa';

  @override
  String get ticketStatusWaitingAuthority => 'Odottaa viranomaista';

  @override
  String get ticketStatusDone => 'Valmis';

  @override
  String get ticketPriorityHigh => 'Korkea';

  @override
  String get ticketPriorityMedium => 'Keskitaso';

  @override
  String get ticketPriorityLow => 'Matala';

  @override
  String get comments => 'Kommentit';

  @override
  String get documents => 'Asiakirjat';

  @override
  String get details => 'Tiedot';

  @override
  String get replySent => 'Vastaus lähetetty';

  @override
  String get sendError => 'Lähetysvirhe';

  @override
  String get uploading => 'Ladataan...';

  @override
  String fileUploaded(String filename) {
    return '$filename ladattu';
  }

  @override
  String get uploadFailed => 'Lataus epäonnistui';

  @override
  String get openError => 'Avausvirhe';

  @override
  String get noRepliesYet => 'Ei vielä vastauksia';

  @override
  String get waitingForSupport => 'Odotetaan tukivastausta';

  @override
  String get writeReply => 'Kirjoita vastaus...';

  @override
  String get attachFile => 'Liitä tiedosto';

  @override
  String documentsCount(int count) {
    return 'Asiakirjat ($count)';
  }

  @override
  String get upload => 'Lataa';

  @override
  String get noDocuments => 'Ei asiakirjoja';

  @override
  String get allowedFormats => 'Sallitut muodot: PDF, JPEG, JPG, TXT, ZIP';

  @override
  String get yourMessage => 'Viestisi:';

  @override
  String get translation => 'Käännös';

  @override
  String get original => 'Alkuperäinen';

  @override
  String get originalText => 'Alkuperäinen teksti';

  @override
  String get autoTranslated => 'Käännetty automaattisesti';

  @override
  String get originalTapTranslation =>
      'Alkuperäinen · Napauta käännöstä varten';

  @override
  String get translatedTapOriginal => 'Käännetty · Napauta alkuperäistä varten';

  @override
  String get justNow => 'Juuri nyt';

  @override
  String minutesAgo(int minutes) {
    return '$minutes min sitten';
  }

  @override
  String hoursAgo(int hours) {
    return '$hours tuntia sitten';
  }

  @override
  String daysAgo(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'päivää',
      one: 'päivä',
    );
    return '$days $_temp0 sitten';
  }

  @override
  String get createdLabel => 'Luotu';

  @override
  String get updatedLabel => 'Päivitetty';

  @override
  String get handlerLabel => 'Käsittelijä';

  @override
  String get doneLabel => 'Valmis';

  @override
  String get newTicketTitle => 'Uusi tiketti';

  @override
  String get categoryOptional => 'Kategoria (valinnainen)';

  @override
  String get selectCategory => 'Valitse';

  @override
  String get subjectLabel => 'Aihe';

  @override
  String get fillAllFields => 'Täytä kaikki kentät';

  @override
  String ticketCreatedId(int id) {
    return 'Tiketti #$id luotu';
  }

  @override
  String get priorityLabel => 'Prioriteetti: ';

  @override
  String get supportOffline => 'Tuki offline';

  @override
  String get lastSeenSeconds => 'Aktiivinen muutama sekunti sitten';

  @override
  String lastSeenMinutes(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: 'minuuttia',
      one: 'minuutti',
    );
    return 'Aktiivinen $minutes $_temp0 sitten';
  }

  @override
  String lastSeenHours(int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: 'tuntia',
      one: 'tunti',
    );
    return 'Aktiivinen $hours $_temp0 sitten';
  }

  @override
  String lastSeenDays(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'päivää',
      one: 'päivä',
    );
    return 'Aktiivinen $days $_temp0 sitten';
  }

  @override
  String get online => 'Paikalla';

  @override
  String get callSupport => 'Soita';

  @override
  String get typeMessage => 'Kirjoita viesti...';

  @override
  String get callBusy => 'Tuki on varattu';

  @override
  String get callRejected => 'Puhelu hylättiin';

  @override
  String get callFailed => 'Puhelua ei voitu yhdistää';

  @override
  String get callEnded => 'Puhelu päättyi';

  @override
  String get callSupportBusy => 'Tuki on jo toisessa puhelussa';

  @override
  String get errorStartingChat => 'Virhe chatin käynnistyksessä';

  @override
  String get errorStartingCall => 'Virhe puhelun käynnistyksessä';

  @override
  String get errorConnecting => 'Yhteysvirhe';

  @override
  String get errorDownloading => 'Latausvirhe';

  @override
  String get errorUploading => 'Lähetysvirhe';

  @override
  String get errorSending => 'Lähetysvirhe';

  @override
  String get errorPickingPhotos => 'Virhe kuvien valinnassa';

  @override
  String get errorPickingFiles => 'Virhe tiedostojen valinnassa';

  @override
  String get errorTakingPhoto => 'Virhe kuvan ottamisessa';

  @override
  String get fileNotLoaded => 'Tiedostoa ei voitu ladata';

  @override
  String get attachmentIdMissing => 'Liitteen ID puuttuu';

  @override
  String get camera => 'Kamera';

  @override
  String get gallery => 'Galleria';

  @override
  String get file => 'Tiedosto';

  @override
  String get notifNewMessageFrom => 'Uusi viesti lähettäjältä';

  @override
  String get notifUrgentPrefix => 'KIIREELLINEN';

  @override
  String get notifUrgentMessage => 'KIIREELLINEN VIESTI';

  @override
  String get notifIncomingCall => 'Saapuva puhelu';

  @override
  String get notifCallingYou => 'soittaa...';

  @override
  String get notifUpdateAvailable => 'Päivitys saatavilla';

  @override
  String get notifVersionAvailable => 'on nyt saatavilla';

  @override
  String get notifConnected => 'Yhdistetty';

  @override
  String get notifDisconnected => 'Yhteys katkaistu';

  @override
  String get notifConnectedBody => 'Olet nyt yhteydessä palvelimeen.';

  @override
  String get notifDisconnectedBody => 'Yhteys palvelimeen katkesi.';

  @override
  String get notifError => 'Virhe';

  @override
  String get retry => 'Yritä uudelleen';

  @override
  String get save => 'Tallenna';

  @override
  String get accept => 'Hyväksy';

  @override
  String get selectFile => 'Valitse tiedosto';

  @override
  String get dataLoadingText => 'Ladataan tietoja...';

  @override
  String get dataSavedSuccess => 'Tiedot tallennettu';

  @override
  String get errorSaving => 'Tallennusvirhe';

  @override
  String get errorLoading => 'Latausvirhe';

  @override
  String savedFilename(String filename) {
    return 'Tallennettu: $filename';
  }

  @override
  String get logsCopied => 'Lokit kopioitu!';

  @override
  String get passwordMinEightChars =>
      'Salasanassa on oltava vähintään 8 merkkiä';

  @override
  String get passwordChangeSuccess => 'Salasana vaihdettu';

  @override
  String get emailChangeError => 'Virhe sähköpostin vaihdossa';

  @override
  String get acceptDocumentCheckbox => 'Olen lukenut ja hyväksyn asiakirjan.';

  @override
  String loadingErrorGeneric(String details) {
    return 'Latausvirhe: $details';
  }

  @override
  String get incomingCallTitle => 'Saapuva puhelu';

  @override
  String ringingFor(int seconds) {
    return 'Soi ${seconds}s';
  }

  @override
  String get rejectCall => 'Hylkää';

  @override
  String get acceptCall => 'Vastaa';

  @override
  String get unmute => 'Poista mykistys';

  @override
  String get mute => 'Mykistä';

  @override
  String get hangUp => 'Lopeta puhelu';

  @override
  String get calling => 'Soitetaan...';

  @override
  String autoRejectIn(int seconds) {
    return 'Automaattinen hylkäys $seconds sekunnin kuluttua';
  }

  @override
  String get speakerOn => 'Kaiutin';

  @override
  String get speakerOff => 'Kuuloke';

  @override
  String get micMuted => 'Mykistetty';

  @override
  String get micOn => 'Mikrofoni';

  @override
  String get connectionExcellent => 'Erinomainen';

  @override
  String get connectionGood => 'Hyvä';

  @override
  String get connectionWeak => 'Heikko';

  @override
  String get connectionLost => 'Yhteys katkesi';

  @override
  String get personalData => 'Henkilötiedot';

  @override
  String get personalDataSubtitle => 'Etunimi, sukunimi, osoite';

  @override
  String get membershipFee => 'Jäsenmaksu';

  @override
  String annualFeeYear(String year) {
    return 'Vuosimaksu $year';
  }

  @override
  String get amount => 'Summa:';

  @override
  String get dueBy => 'Eräpäivä:';

  @override
  String get paid => 'Maksettu';

  @override
  String get versionHistory => 'Versiohistoria';

  @override
  String lastUpdated(String date) {
    return 'Viimeksi päivitetty: $date';
  }

  @override
  String get noVersionHistory => 'Ei versiohistoriaa saatavilla';

  @override
  String get failedLoadChangelog => 'Muutoslokin lataus epäonnistui';

  @override
  String get callMember => 'Soita jäsenelle';

  @override
  String get closeConversation => 'Sulje keskustelu';

  @override
  String get chatOffline => 'Ei verkossa';

  @override
  String get attachFiles => 'Liitä tiedostoja (enint. 10, 50Mt)';

  @override
  String get conversationClosed => 'Tämä keskustelu on suljettu';

  @override
  String get noMessages => 'Ei viestejä';

  @override
  String get goBack => 'Takaisin';

  @override
  String get goForward => 'Eteenpäin';

  @override
  String get homePage => 'Etusivu';

  @override
  String get firstNameLabel => 'Etunimi';

  @override
  String get lastNameLabel => 'Sukunimi';

  @override
  String get streetLabel => 'Katu';

  @override
  String get houseNumberLabel => 'Nro';

  @override
  String get postalCodeLabel => 'Postinumero';

  @override
  String get cityLabel => 'Kaupunki';

  @override
  String get phoneMobileLabel => 'Puhelin (Matkapuhelin)';

  @override
  String get phoneLandlineLabel => 'Puhelin (Lankapuhelin)';

  @override
  String get newEmailLabel => 'Uusi sähköpostiosoite';

  @override
  String get currentPasswordLabel => 'Nykyinen salasana';

  @override
  String get newPasswordLabel => 'Uusi salasana';

  @override
  String get confirmPasswordLabel => 'Vahvista salasana';

  @override
  String get emailChangedSuccess => 'Sähköposti vaihdettu';

  @override
  String get reasonLabel2 => 'Syy';

  @override
  String get downloadFailed2 => 'Lataus epäonnistui';

  @override
  String get downloadTooltip => 'Lataa';

  @override
  String get copyLogs => 'Kopioi lokit';

  @override
  String get deleteLogs => 'Poista lokit';

  @override
  String get autoScrollOn => 'Automaattinen vieritys PÄÄLLÄ';

  @override
  String get autoScrollOff => 'Automaattinen vieritys POIS';

  @override
  String get unknownValue => 'Tuntematon';

  @override
  String get payment => 'Maksu';

  @override
  String get warningType_ermahnung => 'Varoitus';

  @override
  String get warningType_abmahnung => 'Huomautus';

  @override
  String get warningType_letzte => 'Viimeinen varoitus';

  @override
  String warningsTotal(int count) {
    return 'Yhteensä: $count';
  }

  @override
  String warningsErmahnung(int count) {
    return 'Varoituksia: $count';
  }

  @override
  String warningsAbmahnung(int count) {
    return 'Huomautuksia: $count';
  }

  @override
  String warningsLetzte(int count) {
    return 'Viimeiset: $count';
  }

  @override
  String get noWarnings => 'Ei varoituksia';

  @override
  String get noWarningsDescription =>
      'Sinulla ei ole tällä hetkellä varoituksia.';

  @override
  String createdBy(String name) {
    return 'Luonut: $name';
  }

  @override
  String get monthJan => 'Tam';

  @override
  String get monthFeb => 'Hel';

  @override
  String get monthMar => 'Maa';

  @override
  String get monthApr => 'Huh';

  @override
  String get monthMay => 'Tou';

  @override
  String get monthJun => 'Kes';

  @override
  String get monthJul => 'Hei';

  @override
  String get monthAug => 'Elo';

  @override
  String get monthSep => 'Syy';

  @override
  String get monthOct => 'Lok';

  @override
  String get monthNov => 'Mar';

  @override
  String get monthDec => 'Jou';

  @override
  String get stufe1_name => 'Henkilötiedot';

  @override
  String get stufe2_name => 'Jäsentyyppi';

  @override
  String get stufe3_name => 'Taloudellinen tilanne';

  @override
  String get stufe4_name => 'Maksutapa';

  @override
  String get stufe5_name => 'Jäsenyyden alku';

  @override
  String get stufe6_name => 'Säännöt';

  @override
  String get stufe7_name => 'Tietosuojakäytäntö';

  @override
  String get stufe8_name => 'Peruuttamisoikeus';

  @override
  String get memberType_ordentlich => 'Varsinainen jäsen';

  @override
  String get memberType_foerder => 'Kannatusjäsen';

  @override
  String get memberType_ehren => 'Kunniajäsen';

  @override
  String get memberDesc_ordentlich =>
      'Aktiivijäsen äänioikeudella. Osallistuu yhdistyksen palveluihin (sähköposti, pilvi, byrokratiatuki).';

  @override
  String get memberDesc_foerder =>
      'Tukee yhdistystä jäsenmaksuilla. Voi osallistua vuosikokoukseen neuvoa-antavalla äänellä, ilman äänioikeutta tai vaalikelpoisuutta hallitukseen.';

  @override
  String get memberDesc_ehren =>
      'Varsinaisen jäsenen oikeudet ilman jäsenmaksuvelvollisuutta. Nimittää vuosikokous tai hallitus.';

  @override
  String get payMethod_ueberweisung => 'Pankkisiirto';

  @override
  String get payMethod_dauerauftrag => 'Toistuvaissuoritus';

  @override
  String get verifyStatus_geprueft => 'Vahvistettu';

  @override
  String get verifyStatus_ausgefuellt => 'Täytetty';

  @override
  String get verifyStatus_abgelehnt => 'Hylätty';

  @override
  String get verifyStatus_offen => 'Avoin';

  @override
  String get fillRequiredFields => 'Täytä kaikki pakolliset kentät.';

  @override
  String get personalDataSaved => 'Henkilötiedot tallennettu';

  @override
  String get selectMemberType => 'Valitse jäsentyyppi.';

  @override
  String get memberTypeSaved => 'Jäsentyyppi tallennettu';

  @override
  String get selectOption => 'Valitse vaihtoehto.';

  @override
  String get financialSaved => 'Taloudellinen tilanne tallennettu';

  @override
  String get selectPaymentMethod => 'Valitse maksutapa.';

  @override
  String get paymentDataSaved => 'Maksutiedot tallennettu';

  @override
  String get selectDate => 'Valitse päivämäärä.';

  @override
  String get membershipStartSaved => 'Jäsenyyden alku tallennettu';

  @override
  String get fileTooLarge => 'Tiedosto on liian suuri (enint. 10 Mt).';

  @override
  String get leistungsbescheidUploaded => 'Etuuspäätös ladattu onnistuneesti';

  @override
  String get verificationProgress => 'Vahvistuksen edistyminen';

  @override
  String get notApplicable => 'Ei sovellettavissa';

  @override
  String get socialBenefitsExempt =>
      'Maksutapaa ei vaadita sosiaalietuuksien saajilta.';

  @override
  String get locked => 'Lukittu';

  @override
  String completePreviousStep(int step) {
    return 'Suorita ensin vaihe $step.';
  }

  @override
  String rejectedNote(String note) {
    return 'Hylätty: $note';
  }

  @override
  String get waitingForReview => 'Odottaa hallituksen tarkistusta.';

  @override
  String get stepApproved => 'Tämä vaihe on tarkistettu ja hyväksytty.';

  @override
  String get changesViaChat => 'Muutokset mahdollisia vain chatin kautta.';

  @override
  String get firstNameRequired => 'Etunimi *';

  @override
  String get lastNameRequired => 'Sukunimi *';

  @override
  String get birthDateLabel => 'Syntymäaika *';

  @override
  String get streetRequired => 'Katu *';

  @override
  String get houseNumberRequired => 'Nro *';

  @override
  String get cityRequired => 'Kaupunki *';

  @override
  String get phoneRequired => 'Puhelinnumero *';

  @override
  String get phonePurpose =>
      'Tarkoitus: Yhteydenotto kun ei tavoitettavissa sovelluksessa';

  @override
  String get selectMemberTypePrompt => 'Valitse haluamasi jäsentyyppi:';

  @override
  String get financialExplanation =>
      'Jotta voimme tarkistaa, onko sinulla oikeus maksuvähennykseen, tarvitsemme seuraavat tiedot. Niitä käytetään yksinomaan jäsenmaksusi määrittämiseen.';

  @override
  String get socialBenefitsQuestion =>
      'Saatko tällä hetkellä sosiaalietuuksia?';

  @override
  String get optionBuergergeld => 'Kyllä, kansalaistuki (Job Center)';

  @override
  String get optionSozialamt => 'Kyllä, toimeentulotuki (Sosiaalivirasto)';

  @override
  String get optionNoBenefits => 'Ei, en saa sosiaalietuuksia';

  @override
  String get feeExempt => 'Kuukausimaksusi on: 0,00 €/kk';

  @override
  String get uploadLeistungsbescheid => 'Lataa etuuspäätös';

  @override
  String get uploadLeistungsbescheidHint =>
      'Lataa ajantasainen etuuspäätös 14 päivän kuluessa maksuvapautuksen vahvistamiseksi.';

  @override
  String get allowedFormatsUpload =>
      'Sallitut muodot: PDF, JPG, PNG (enint. 10 Mt)';

  @override
  String get feeRegular => 'Kuukausimaksusi on: 25,00 €/kk';

  @override
  String paymentDayReminder(int day) {
    return 'Sinua muistutetaan joka kuukauden $day. päivä.';
  }

  @override
  String get membershipStartPrompt => 'Valitse, milloin jäsenyytesi alkaa.';

  @override
  String get optionAfterVerification => 'Vahvistuksen jälkeen';

  @override
  String get optionAfterVerificationDesc =>
      'Jäsenyys alkaa hallituksen vahvistuspäivästä.';

  @override
  String get optionRetroFoundation =>
      'Takautuvasti perustamispäivään (01.08.2025)';

  @override
  String get optionRetroFoundationDesc =>
      'Sinusta tulee takautuva jäsen yhdistyksen perustamisesta alkaen.';

  @override
  String get optionRetroCustom => 'Takautuvasti toiseen päivämäärään';

  @override
  String get optionRetroCustomDesc =>
      'Valitse päivämäärä väliltä 01.08.2025 ja tänään.';

  @override
  String get selectDateLabel => 'Valitse päivämäärä';

  @override
  String get selectDateHint => 'Valitse päivämäärä...';

  @override
  String get dateNotBefore => 'Ei ennen 01.08.2025 (perustamispäivä)';

  @override
  String get feeExemptRetro =>
      'Maksuvapautus: 0,00 € takautuvasti.\nVain jäsenyyden päivämäärä asetetaan takautuvasti.';

  @override
  String get retroactiveFees => 'Takautuvat maksut';

  @override
  String retroFeeCalculation(
      String from, String to, String months, String total) {
    return 'Jakso: $from – $to\nKuukaudet: $months\nMaksu: $months × 25,00 € = $total €';
  }

  @override
  String get pleaseReadSatzung => 'Lue yhdistyksen säännöt.';

  @override
  String get pleaseReadDatenschutz => 'Lue tietosuojakäytäntö.';

  @override
  String get pleaseReadWiderruf => 'Lue peruuttamisoikeus.';

  @override
  String get acceptedAtRegistration => 'Hyväksytty rekisteröinnissä';

  @override
  String get confirmedByBoard =>
      'Vahvistetaan hallituksen tarkistuksen jälkeen.';

  @override
  String get docSatzung => 'Säännöt';

  @override
  String get docDatenschutz => 'Tietosuojakäytäntö';

  @override
  String get docWiderruf => 'Peruuttamisoikeus';

  @override
  String acceptedAtRegCount(int count) {
    return 'Hyväksytty rekisteröinnissä ($count/3)';
  }

  @override
  String acceptedOn(String date) {
    return 'Hyväksytty $date';
  }

  @override
  String get notAccepted => 'Ei hyväksytty';

  @override
  String get statusAccepted => 'Hyväksytty';

  @override
  String get nameTooLong => 'Nimi liian pitkä (enintään 100 merkkiä)';

  @override
  String get emailTooLong => 'Sähköposti liian pitkä (enintään 255 merkkiä)';

  @override
  String get legalAcknowledgePrefix => 'Olen lukenut ';

  @override
  String get legalAcknowledgeSuffix => '.';

  @override
  String get legalStatutesSuffix =>
      ' ICD360S e.V.:n ja tunnustan ne sitoviksi.';

  @override
  String get legalPleaseReadFirst => '(lue ensin)';

  @override
  String get statusActive => 'Aktiivinen';

  @override
  String get statusSuspended => 'Jäädytetty';

  @override
  String get statusNew => 'Uusi';

  @override
  String get statusCancelled => 'Peruutettu';

  @override
  String get statusDeleted => 'Poistettu';

  @override
  String get roleMitglied => 'Jäsen';

  @override
  String get roleVorsitzer => 'Puheenjohtaja';

  @override
  String get roleStellvertreter => 'Varapuheenjohtaja';

  @override
  String get roleSchatzmeister => 'Rahastonhoitaja';

  @override
  String get roleSchriftfuehrer => 'Sihteeri';

  @override
  String get roleBeisitzer => 'Lautamies';

  @override
  String get roleKassierer => 'Kassanhoitaja';

  @override
  String get roleKassenpruefer => 'Tilintarkastaja';

  @override
  String get roleEhrenamtlich => 'Vapaaehtoinen';

  @override
  String get roleMitgliedergruender => 'Perustajajäsen';

  @override
  String get roleEhrenmitglied => 'Kunniajäsen';

  @override
  String get roleFoerdermitglied => 'Kannatusjäsen';

  @override
  String get memberTypeNotSet => 'Ei vielä asetettu';

  @override
  String get payMethodSepa => 'SEPA-suoraveloitus';

  @override
  String get labelStatus => 'Tila';

  @override
  String get labelMemberNumber => 'Jäsennumero';

  @override
  String get labelRole => 'Rooli';

  @override
  String get labelMemberType => 'Jäsentyyppi';

  @override
  String get labelPaymentMethod => 'Maksutapa';

  @override
  String get labelRegisteredOn => 'Rekisteröity';

  @override
  String get labelLastLogin => 'Viimeisin kirjautuminen';

  @override
  String get labelMemberSince => 'Jäsen alkaen';

  @override
  String get neverLoggedIn => 'Ei koskaan';

  @override
  String get notActivatedYet => 'Ei vielä aktivoitu';

  @override
  String get tabVerification => 'Vahvistus';

  @override
  String get tabWarnings => 'Varoitukset';

  @override
  String get tabDocuments => 'Asiakirjat';

  @override
  String get tabMembership => 'Jäsenyys';

  @override
  String get pleaseEnterFirstName => 'Syötä etunimi';

  @override
  String get pleaseEnterLastName => 'Syötä sukunimi';

  @override
  String get noFileDataReceived => 'Tietoja ei vastaanotettu';

  @override
  String get openFile => 'Avaa';

  @override
  String get noMicrophoneError =>
      'Mikrofonia ei löytynyt. Liitä mikrofoni ja yritä uudelleen.';

  @override
  String get startConversation => 'Aloita keskustelu!';

  @override
  String get staffWillReply => 'Työntekijä vastaa sinulle pian.';

  @override
  String get inCall => 'Puhelussa...';

  @override
  String get registration => 'Rekisteröinti';

  @override
  String get deactivation => 'Käytöstäpoisto';

  @override
  String get deactivatedOn => 'Poistettu käytöstä';

  @override
  String get accountAutoSuspend =>
      'Tilit, joita ei vahvisteta 30 päivän kuluessa, jäädytetään automaattisesti.';

  @override
  String get documentsProvidedByBoard => 'Asiakirjat tarjoaa hallitus.';

  @override
  String get noDocumentsAvailable => 'Ei asiakirjoja';

  @override
  String get noDocumentsDescription =>
      'Sinulle ei ole vielä toimitettu asiakirjoja.';

  @override
  String uploadedBy(String name) {
    return 'Lähettäjä: $name';
  }

  @override
  String stepsCompleted(int completed, int total) {
    return '$completed/$total vaihetta suoritettu';
  }

  @override
  String dayOfMonth(int day) {
    return 'Kuukauden $day. päivä';
  }

  @override
  String changeField(String field) {
    return 'Muuta $field';
  }

  @override
  String openDocument(String name) {
    return 'Avaa $name';
  }

  @override
  String logEntries(int count) {
    return '$count merkintää';
  }

  @override
  String get noLogs => 'Ei lokeja';

  @override
  String get newLoginDetected => 'Uusi kirjautuminen havaittu';

  @override
  String get errorNoInternet => 'Ei Internet-yhteyttä. Tarkista verkkosi.';

  @override
  String get errorTimeout => 'Palvelin ei vastaa. Yritä myöhemmin uudelleen.';

  @override
  String get errorServer => 'Palvelinvirhe. Yritä myöhemmin uudelleen.';

  @override
  String get errorConnection => 'Yhteysvirhe. Yritä myöhemmin uudelleen.';

  @override
  String get errorUnexpected => 'Odottamaton virhe. Yritä myöhemmin uudelleen.';

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
  String get claudiuWelcomeMorning => 'Hyvää huomenta';

  @override
  String get claudiuWelcomeDay => 'Hei';

  @override
  String get claudiuWelcomeEvening => 'Hyvää iltaa';

  @override
  String get claudiuWelcomeNight => 'Hyvää iltaa';

  @override
  String get claudiuWelcomeVisitor => 'rakas vieras';

  @override
  String get claudiuWelcomeAsk => 'Miten voin auttaa?';

  @override
  String get claudiuWelcomeBecomeMember => 'Haluan liittyä jäseneksi';

  @override
  String get claudiuWelcomeLogin => 'Olen jo jäsen ja haluan kirjautua sisään';

  @override
  String get claudiuWelcomeProblem => 'Minulla on ongelma sovelluksen kanssa';

  @override
  String get claudiuWelcomeEmergency => 'Hätätilanne — soita';

  @override
  String get claudiuWelcomeMascotName => 'Claudiu';

  @override
  String get claudiuWelcomeEmergencyIntro =>
      'Ennen kuin soitat — aukioloaikamme:';

  @override
  String get claudiuWelcomeScheduleOffice => 'Toimistolla';

  @override
  String get claudiuWelcomeScheduleField => 'Kentällä asiakkaiden kanssa';

  @override
  String get claudiuWelcomeOutsideHoursNote =>
      'Näiden aikojen ulkopuolella käsittelemme vain hätätapauksia. Voit myös tekstata samaan numeroon — palaamme asiaan.';

  @override
  String get claudiuWelcomeCallNow => 'Soita nyt';

  @override
  String get claudiuWelcomeSendSms => 'Lähetä viesti';

  @override
  String get claudiuWelcomeSmsBody =>
      'Hätä ICD360S e.V. — ottakaa minuun yhteyttä mahdollisimman pian.';

  @override
  String get claudiuWelcomeCloseButton => 'Sulje';

  @override
  String get claudiuLoginWelcome => 'Tervetuloa takaisin, hyvä jäsen!';

  @override
  String get claudiuLoginAsk => 'Kerro jäsennumerosi.';

  @override
  String get claudiuLoginProgress => 'Kohta… jatka kirjoittamista.';

  @override
  String get claudiuLoginReady => 'Loistavaa! Paina alla olevaa painiketta.';

  @override
  String get claudiuLoginLoading => 'Tarkistan henkilöllisyyden… 🔍';

  @override
  String get claudiuLoginFoundPlain => 'Löysin sinut! Kirjaudutaan…';

  @override
  String claudiuLoginFoundNamed(String name) {
    return 'Löysin sinut, $name! Kirjaudutaan…';
  }

  @override
  String get claudiuLoginError =>
      'Hmm, en löydä tätä numeroa. Kirjoititko sen oikein?';

  @override
  String get claudiuLoginForgotHeader => 'Unohditko jäsennumerosi?';

  @override
  String get claudiuLoginNoSms =>
      'Emme lähetä numeroa sähköpostilla tai tekstiviestillä.';

  @override
  String get claudiuLoginOnlyWay =>
      'Ainoa tapa: tapaaminen henkilökohtaisesti yhdistyksen toimistossa, henkilöllisyyden tarkistuksen jälkeen.';

  @override
  String get claudiuLoginContactUs => 'Soita ja varaa aika:';

  @override
  String get claudiuDiagnosticGreeting =>
      'Ennen kuin menet sisään, yksi kysymys';

  @override
  String get claudiuDiagnosticAsk =>
      'Saanko lähettää nimettömiä raportteja, jotta kehittäjät voivat parantaa sovellusta?';

  @override
  String get claudiuDiagnosticYes => 'Kyllä, haluan auttaa';

  @override
  String get claudiuDiagnosticNo => 'Ei, vain tutkin';

  @override
  String get claudiuDiagnosticTellMore => 'Kerro lisää';

  @override
  String get claudiuDiagnosticSendsHeader =>
      '📤 Mitä LÄHETÄMME (nimettömästi):';

  @override
  String get claudiuDiagnosticSends1 => 'Anonyymi laitekoodi (EI jäsennumeroa)';

  @override
  String get claudiuDiagnosticSends2 => 'Roolisi (jäsen / hallitus)';

  @override
  String get claudiuDiagnosticSends3 =>
      'Käyttöjärjestelmä (Linux / Android / iOS / Windows)';

  @override
  String get claudiuDiagnosticSends4 => 'Valittu kieli';

  @override
  String get claudiuDiagnosticSends5 => 'Akun taso ja tila';

  @override
  String get claudiuDiagnosticSends6 => 'Nykyinen näyttö';

  @override
  String get claudiuDiagnosticSends7 => 'Istunnon kesto (sekuntia)';

  @override
  String get claudiuDiagnosticSends8 => 'Virheet jos on (viimeiset 10)';

  @override
  String get claudiuDiagnosticSends9 => 'Navigointi (viimeiset 20 näyttöä)';

  @override
  String get claudiuDiagnosticSends10 =>
      'Kuinka monta kertaa sovellus on lähettänyt tietoja (vain määrä, ei sisältöä)';

  @override
  String get claudiuDiagnosticSends11 =>
      'Miten järjestelmä luokittelee sovelluksen ja kuinka nopeasti akku tyhjenee';

  @override
  String get claudiuDiagnosticNeverHeader => '🛡️ Mitä emme KOSKAAN lähetä:';

  @override
  String get claudiuDiagnosticNever1 => 'Oikea nimesi';

  @override
  String get claudiuDiagnosticNever2 => 'Sähköpostiosoite';

  @override
  String get claudiuDiagnosticNever3 => 'Puhelinnumero';

  @override
  String get claudiuDiagnosticNever4 => 'Salasana';

  @override
  String get claudiuDiagnosticNever5 => 'Chat-viestien sisältö';

  @override
  String get claudiuDiagnosticNever6 => 'Tikettien sisältö';

  @override
  String get claudiuDiagnosticNever7 => 'Asiakirjat tai liitteet';

  @override
  String get claudiuDiagnosticTechHeader => '📡 Tekniset tiedot:';

  @override
  String get claudiuDiagnosticTech1 => 'Lähetetään 15 minuutin välein';

  @override
  String get claudiuDiagnosticTech2 =>
      'TLS-salattu yhteys, kiinnitetty varmenne';

  @override
  String get claudiuDiagnosticTech3 =>
      'Voit kytkeä sen pois päältä milloin tahansa Asetuksista';

  @override
  String get claudiuProblemHelpTitle => 'Miten voin auttaa?';

  @override
  String get claudiuProblemHelpGreeting => 'Mitä tapahtui?';

  @override
  String get claudiuProblemHelpAsk => 'Miten haluat kertoa siitä?';

  @override
  String get claudiuProblemHelpWriteTitle => 'Kirjoita raportti';

  @override
  String get claudiuProblemHelpWriteBody =>
      'Vaihe-vaiheelta yksityiskohdat. Tiimi saa tekstin ja ratkaisee asian myöhemmin.';

  @override
  String get claudiuProblemHelpChatTitle => 'Puhutaan nyt';

  @override
  String get claudiuProblemHelpChatBody =>
      'Anonyymi keskustelu operaattorin kanssa. Reaaliaikainen vastaus jos joku on online.';

  @override
  String get claudiuProblemHelpAltCallHeader => 'Tai jos asia on kiireellinen:';

  @override
  String get claudiuProblemHelpAltCallLabel => 'Soita meille';

  @override
  String get claudiuAnonymousChatTitle => 'Anonyymi keskustelu';

  @override
  String get claudiuAnonymousChatGreeting => 'Hei!';

  @override
  String get claudiuAnonymousChatWelcome =>
      'Kuuntelen. Kirjoita mitä haluat — nimeä ei tarvita. Vastaan heti kun olen täällä.';

  @override
  String get claudiuAnonymousChatHint => 'Kirjoita viesti…';

  @override
  String get claudiuAnonymousChatWaitingOperator =>
      'Odotetaan operaattorin vastausta…';

  @override
  String get claudiuVorsitzerConnectedTitle => 'Hei!';

  @override
  String get claudiuVorsitzerConnectedBody =>
      'Kiitos kun otit yhteyttä — olet nyt yhteydessä Vorsitzeriin. Kerro miten voimme auttaa jäsenhakemuksessasi.';

  @override
  String get claudiuVorsitzerConnectedSender => 'Vorsitzer';

  @override
  String get claudiuQuickReplyValidationTime => 'Kauanko tarkistus kestää?';

  @override
  String get claudiuQuickReplyDocuments => 'Mitä dokumentteja tarvitsen?';

  @override
  String get claudiuQuickReplyStepProblem => 'Olen jumissa yhdessä vaiheessa';

  @override
  String get claudiuQuickReplyHuman => 'Voinko puhua jonkun kanssa nyt?';

  @override
  String get claudiuAnonymousChatConnecting => 'Yhdistetään…';

  @override
  String get claudiuAnonymousChatConnectionFailed =>
      'Keskustelua ei voitu avata. Yritä uudelleen tai soita meille.';

  @override
  String get claudiuAnonymousChatRetry => 'Yritä uudelleen';

  @override
  String get claudiuAnonymousChatOnline => 'Yhdistetty';

  @override
  String get claudiuAnonymousChatOffline => 'Yhdistetään uudelleen…';

  @override
  String get claudiuAnonymousChatAdminTyping => 'Operaattori kirjoittaa…';

  @override
  String get claudiuProblemReportTitle => 'Ilmoita ongelmasta';

  @override
  String get claudiuProblemReportGreeting => 'Mitä tapahtui?';

  @override
  String get claudiuProblemReportAsk =>
      'Kerro yksityiskohtaisesti, niin välitän raportin tiimille.';

  @override
  String get claudiuProblemReportIncludeHeader => 'Sisällytä:';

  @override
  String get claudiuProblemReportIncludeBullets1 =>
      'Mitä teit, kun ongelma ilmaantui';

  @override
  String get claudiuProblemReportIncludeBullets2 =>
      'Mahdolliset virheilmoitukset';

  @override
  String get claudiuProblemReportIncludeBullets3 => 'Millä näytöllä olit';

  @override
  String get claudiuProblemReportIncludeBullets4 =>
      'Kaatuuko sovellus, sulkeutuuko se vai näyttääkö tyhjän ruudun?';

  @override
  String get claudiuProblemReportIncludeBullets5 =>
      'Tapahtuuko se joka kerta vai vain kerran?';

  @override
  String get claudiuProblemReportDescriptionLabel => 'Kuvauksesi';

  @override
  String get claudiuProblemReportDescriptionHint =>
      'Esim.: Kun avaan chatin, näkyy \"Connection error\" ja sovellus lakkaa vastaamasta…';

  @override
  String claudiuProblemReportTooShort(int count) {
    return 'Hieman lisää yksityiskohtia (vähintään $count merkkiä)';
  }

  @override
  String get claudiuProblemReportSubmit => 'Lähetä raportti';

  @override
  String get claudiuProblemReportSubmitting => 'Lähetetään…';

  @override
  String get claudiuProblemReportSentTitle => 'Kiitos!';

  @override
  String get claudiuProblemReportSentBody =>
      'Raportti on lähetetty. Tiimimme tutkii sen mahdollisimman pian.';

  @override
  String get claudiuProblemReportSentClose => 'Selvä';

  @override
  String get claudiuProblemReportSendFailed =>
      'Raporttia ei voitu lähettää. Soita meille kiireellistä apua varten.';

  @override
  String get claudiuProblemReportAlt => 'Tai jos asia on kiireellinen:';

  @override
  String get claudiuProblemReportCallLabel => 'Soita meille';

  @override
  String claudiuApprovalGreeting(String name) {
    return 'Hei, $name! 👋';
  }

  @override
  String get claudiuApprovalGreetingNoName => 'Hei! 👋';

  @override
  String get claudiuApprovalGladToSeeYou => 'Mukava nähdä sinut!';

  @override
  String get claudiuApprovalCheckingForSafety =>
      'Turvallisuutesi vuoksi Vorsitzer tarkistaa nyt kirjautumispyyntöäsi. 🛡️';

  @override
  String get claudiuApprovalMonthlyExplain =>
      '💡 Teemme tämän 30 päivän välein varmistaaksemme, että olet todella sinä. Se on kuin turvallisuustarkastus — kestää enintään 5 minuuttia.';

  @override
  String get claudiuApprovalSuccess =>
      'Valmis! 🎉 Vorsitzer tunnisti sinut. Kirjaudutaan sisään…';

  @override
  String get claudiuApprovalDenied => 'Hmm, Vorsitzer hylkäsi pyyntösi. 😔';

  @override
  String get claudiuApprovalDeniedHelp =>
      'Jos uskot, että tämä on virhe, soita meille, niin selvitetään.';

  @override
  String get claudiuApprovalExpired =>
      '5 minuuttia kului, eikä Vorsitzer vastannut.';

  @override
  String get claudiuApprovalExpiredHelp =>
      'Soita meille, niin voimme hyväksyä pyyntösi heti. 📞';

  @override
  String get claudiuApprovalCallUs => 'Soita meille';

  @override
  String get claudiuApprovalTryAgain => 'Yritä uudelleen';

  @override
  String get claudiuApprovalCancel => 'Peruuta';

  @override
  String get claudiuApprovalClose => 'Sulje';

  @override
  String get wizardIntroBubble1 =>
      'Hei, vieras! 👋 Kiitos, että haluat liittyä perheeseemme.';

  @override
  String get wizardIntroBubble2 =>
      'Nimeni on Claudiu. Keväällä 2025 minulla oli selkeä visio: perustaa yhdistys, joka auttaa hädässä olevia ihmisiä — vapaaehtoisesti, sydämestä, ilman turhaa byrokratiaa. ❤️';

  @override
  String get wizardIntroBubble3 =>
      'Aloin puhua asiakkaiden kanssa, joita kävin tapaamassa. Kerroin heille unelmani. Ja jokainen sanoi: \"Kyllä, mennään!\" Heinäkuussa 2025 me kuusi tapasimme — päättäväiset ihmiset. Päätimme perustaa **ICD360S e.V.** Neu-Ulmiin. 📍';

  @override
  String get wizardIntroBubble4 =>
      '**1. elokuuta 2025** yhdistys heräsi virallisesti eloon — yhdistysrekisterissä. Kaunein lahjani. 🎂';

  @override
  String get wizardIntroBubble5 =>
      'Mitä teemme? Autamme pakolaisia, vammaisia, taloudellisesti heikossa asemassa olevia, **lapsia ja nuoria** — virastoasioissa, saksan oppimisessa, asumisessa, ostoksilla, sosiaalietuuksissa. Vorstandimme koostuu pääosin vammaisista — näin päätökset perustuvat aitoon elämänkokemukseen. 🤝';

  @override
  String get wizardIntroBubble6 =>
      'Nyt on sinun vuorosi. Rekisteröidään sinut — kestää noin 5 minuuttia. Etenemme askel kerrallaan, en jätä sinua yksin. ✨';

  @override
  String get wizardIntroStart => 'Aloitetaan';

  @override
  String get wizardBack => 'Takaisin';

  @override
  String get wizardNext => 'Seuraava';

  @override
  String wizardStepLabel(int step, int total, String title) {
    return 'Vaihe $step / $total · $title';
  }

  @override
  String get wizardErrRequired => 'Tämä kenttä on pakollinen';

  @override
  String wizardErrTooShort(int count) {
    return 'Liian lyhyt (vähintään $count merkkiä)';
  }

  @override
  String get wizardErrOnlyLetters =>
      'Vain kirjaimet, välilyönnit, väliviivat ja heittomerkit';

  @override
  String get wizardErrSaveFailed =>
      'Tallennus epäonnistui. Tarkista yhteys ja yritä uudelleen.';

  @override
  String get wizardStufe1aTitle => 'Henkilöllisyys';

  @override
  String get wizardStufe1aPrompt =>
      'Tutustutaan virallisesti. Kirjoita nimesi täsmälleen samoin kuin Personalausweis-, Reisepass- tai Aufenthaltstitel-asiakirjassa — niin se vastaa dokumenttejasi.';

  @override
  String get wizardStufe1aVornameLabel => 'Vornamen (etunimet)';

  @override
  String get wizardStufe1aVornameHelper =>
      'Kaikki etunimesi tarkalleen kuten asiakirjassa. Välilyönnillä tai väliviivalla (esim. Hans-Peter, Maria Anna).';

  @override
  String get wizardStufe1aNachnameLabel => 'Familienname (sukunimi)';

  @override
  String get wizardStufe1aNachnameHelper => 'Nykyinen sukunimesi.';

  @override
  String get wizardStufe1aGeburtsnameLabel =>
      'Geburtsname (syntymänimi) — valinnainen';

  @override
  String get wizardStufe1aGeburtsnameHelper =>
      'Vain jos eroaa Familiennamen kanssa — esim. ennen avioliittoa.';

  @override
  String get wizardStufe1bTitle => 'Syntymäpäivä';

  @override
  String get wizardStufe1bPrompt =>
      'Haluamme juhlia syntymäpäivääsi kanssasi! 🎂 Se auttaa myös vahvistamaan, että olet vähintään 16 — niin sanoo sääntömme.';

  @override
  String get wizardStufe1bGeburtsdatumLabel => 'Syntymäaika';

  @override
  String get wizardStufe1bGeburtsdatumHelper => 'Napauta valitaksesi päivän';

  @override
  String get wizardStufe1bGeburtsortLabel => 'Syntymäpaikka';

  @override
  String get wizardStufe1bGeburtsortHelper =>
      'Kaupunki / paikkakunta, jossa synnyit.';

  @override
  String get wizardAgeGatePrompt => 'Olen pahoillani… 😔';

  @override
  String wizardAgeGateBody1(int age, int years) {
    return 'Sääntömme sanovat, että jäseneksi liittymiseen täytyy olla vähintään 16. Olet $age — toivottavasti tapaamme $years vuoden päästä! 🌱';
  }

  @override
  String get wizardAgeGateBody2 =>
      'Jos haluat auttaa silloin tällöin vapaaehtoisena (kaikenikäisille, vanhempien suostumuksella), soita meille — tuemme mielellämme nuoria, jotka haluavat muuttaa maailmaa.';

  @override
  String get wizardAgeGateBackHome => 'Takaisin alkuun';

  @override
  String get wizardErrInvalidPhone => 'Virheellinen puhelinnumero';

  @override
  String get wizardStufe1b1Title => 'Vanhemman suostumus';

  @override
  String get wizardStufe1b1Prompt =>
      'Olet alaikäinen (16-17) — §106 BGB:n mukaan tarvitsemme vanhemman tai laillisen huoltajan suostumuksen. Kerro nimi ja puhelinnumero. Vorsitzer soittaa ja sopii tapaamisen (paikan päällä tai videopuhelulla). Ei sähköpostia — haluamme varmistaa, että puhumme oikealle henkilölle.';

  @override
  String get wizardStufe1b1VornameLabel => 'Vanhemman etunimi';

  @override
  String get wizardStufe1b1VornameHelper =>
      'Kuten vanhemman Personalausweisissa.';

  @override
  String get wizardStufe1b1NachnameLabel => 'Vanhemman sukunimi';

  @override
  String get wizardStufe1b1NachnameHelper =>
      'Kuten vanhemman Personalausweisissa.';

  @override
  String get wizardStufe1b1TelefonLabel => 'Vanhemman matkapuhelinnumero';

  @override
  String get wizardStufe1b1TelefonHelper => 'Vorsitzer soittaa tähän numeroon.';

  @override
  String get wizardStufe1b1RelationLabel => 'Suhde lapseen:';

  @override
  String get wizardStufe1b1RelationMutter => 'Äiti';

  @override
  String get wizardStufe1b1RelationVater => 'Isä';

  @override
  String get wizardStufe1b1RelationSorgeberechtigter => 'Laillinen huoltaja';

  @override
  String get wizardStufe1b1RelationAndere => 'Muu huoltaja';

  @override
  String get wizardStufe1cTitle => 'Henkilötiedot';

  @override
  String get wizardStufe1cPrompt =>
      'Vain jotta tutustun sinuun vähän paremmin. Tämä jää meidän välillemme eikä näy missään julkisesti.';

  @override
  String get wizardStufe1cGeschlechtLabel => 'Sukupuoli';

  @override
  String get wizardStufe1cGeschlechtMaennlich => 'Mies';

  @override
  String get wizardStufe1cGeschlechtWeiblich => 'Nainen';

  @override
  String get wizardStufe1cGeschlechtDivers => 'Muunsukupuolinen';

  @override
  String get wizardStufe1cGeschlechtKeineAngabe => 'En halua sanoa';

  @override
  String get wizardStufe1cFamilienstandLabel => 'Siviilisääty';

  @override
  String get wizardStufe1cFamilienstandLedig => 'Naimaton';

  @override
  String get wizardStufe1cFamilienstandVerheiratet => 'Naimisissa';

  @override
  String get wizardStufe1cFamilienstandGeschieden => 'Eronnut';

  @override
  String get wizardStufe1cFamilienstandVerwitwet => 'Leski';

  @override
  String get wizardStufe1dTitle => 'Taustasi';

  @override
  String get wizardStufe1dPrompt =>
      'Tämä auttaa meitä tarjoamaan sinulle oikeaa tukea — esimerkiksi Aufenthalt-neuvontaa tai löytämään kieliyhteisösi.';

  @override
  String get wizardStufe1dStaatLabel => 'Kansalaisuus';

  @override
  String get wizardStufe1dStaatHelper =>
      'Esim. deutsch, rumänisch, ukrainisch. Useita pilkulla erotettuna.';

  @override
  String get wizardStufe1dAufenthaltLabel =>
      'Oleskelustatus (Aufenthaltsstatus) — valinnainen';

  @override
  String get wizardStufe1dAufenthaltHelper =>
      'Valitse otsikko Aufenthaltskarte / päätöksestäsi. Vorstand tarkistaa sen dokumenteistasi.';

  @override
  String get wizardStufe1dAufenthaltAwaitingCitizenship =>
      'Täytä ensin kansalaisuus yllä — näytämme vain sopivat vaihtoehdot.';

  @override
  String get wizardStufe1dAufenthaltGerman =>
      'Aufenthaltstitel ei tarvita — Saksan kansalainen.';

  @override
  String get wizardStufe1dAufenthaltEuEea =>
      'EU/ETA/CH-kansalainen — vapaa liikkuvuus (Freizügigkeit).';

  @override
  String get wizardStufe1dAufenthaltTempHint => 'tilapäinen';

  @override
  String get wizardStufe1dAufenthaltPermHint => 'pysyvä oleskelu';

  @override
  String get wizardStufe1dAufenthaltAsylumProcessHint => 'turvapaikkamenettely';

  @override
  String get wizardStufe1dAufenthaltOther => 'Muu (täsmennä chatissa)';

  @override
  String get wizardStufe1dAufenthaltRequired => 'Valitse Aufenthaltstitel.';

  @override
  String get wizardStufe1dMutterspracheLabel => 'Äidinkieli';

  @override
  String get wizardStufe1dMutterspracheHelper =>
      'Esitäytetty sovelluksen kielellä — vaihda jos eri.';

  @override
  String get wizardStufe1eTitle => 'Osoite';

  @override
  String get wizardStufe1ePrompt =>
      'Postiosoitteesi — käytämme sitä virallisiin asiakirjoihin (säännöt, jäsensopimukset, ilmoitukset).';

  @override
  String get wizardStufe1eStrasseLabel => 'Katu';

  @override
  String get wizardStufe1eStrasseHelper =>
      'Vain kadunnimi — numero viereiseen kenttään.';

  @override
  String get wizardStufe1eHausnummerLabel => 'Nro';

  @override
  String get wizardStufe1ePlzLabel => 'PLZ (postinro)';

  @override
  String get wizardStufe1eOrtLabel => 'Kaupunki';

  @override
  String get wizardStufe1eLandLabel => 'Maa';

  @override
  String get wizardStufe1eLandHelper => 'Esitäytetty: Deutschland.';

  @override
  String get wizardErrInvalidStreet => 'Virheellinen kadunnimi';

  @override
  String get wizardErrInvalidHausnummer =>
      'Virheellinen numero (esim. 12, 12a, 12/3)';

  @override
  String get wizardErrInvalidPlz => 'Virheellinen postinumero (vain numerot)';

  @override
  String get wizardStufe1fTitle => 'Yhteystiedot';

  @override
  String get wizardStufe1fPrompt =>
      'Miten saamme sinuun yhteyttä? Puhelin on vain hätätapauksia varten — kaikki muu hoituu omalla päästä päähän salatulla kanavallamme sovelluksessa. Jäsensähköpostisi luodaan automaattisesti, ja näet sen alla.';

  @override
  String get wizardStufe1fTelefonLabel => 'Matkapuhelin';

  @override
  String get wizardStufe1fTelefonHelper =>
      'Lupaan, soitan vain jos asia on tärkeä. 📱';

  @override
  String get wizardStufe2Title => 'Jäsenyystyyppi';

  @override
  String get wizardStufe2Prompt =>
      'Millainen jäsen haluat olla? Selitän jokaisen vaihtoehdon.';

  @override
  String get wizardStufe2OrdentlichTitle => 'Varsinainen jäsen (ordentlich)';

  @override
  String get wizardStufe2OrdentlichBody =>
      'Täydet oikeudet. Maksat kuukausimaksun, äänestät jäsenkokouksessa, voit tulla valituksi hallitukseen. Oletusvalinta.';

  @override
  String get wizardStufe2FoerderTitle => 'Kannattajajäsen (Fördermitglied)';

  @override
  String get wizardStufe2FoerderBody =>
      'Tuet yhdistystä taloudellisesti mutta et osallistu aktiivisesti päätöksiin. Ei äänioikeutta. Sopii jos haluat auttaa etäältä.';

  @override
  String get wizardStufe2EhrenTitle => 'Kunniajäsen (Ehrenmitglied)';

  @override
  String get wizardStufe2EhrenBody =>
      'Hallitus myöntää erityisistä ansioista. Et valitse sitä itse — se myönnetään tunnustuksena. Valitse vain jos sinut on jo kunnioitettu.';

  @override
  String get wizardStufe3Title => 'Taloudellinen tilanne';

  @override
  String get wizardStufe3Prompt =>
      'Nyt taloudellisesta tilanteestasi. En tuomitse — vaan voidaksemme vapauttaa sinut maksusta jos saat sosiaaliturvaa.';

  @override
  String get wizardStufe3OptionBuergergeld => 'Saan Bürgergeldiä';

  @override
  String get wizardStufe3OptionSozialamt => 'Saan Sozialamt-tukia';

  @override
  String get wizardStufe3OptionNein => 'En saa kumpaakaan';

  @override
  String get wizardStufe3FeeExemptTitle => 'Maksu: 0 € / kk 🎉';

  @override
  String get wizardStufe3FeeExemptBody =>
      'Bürgergeldillä, Sozialamtilla, ALG I:llä tai Krankengeldillä olet Satzungin §6 mukaan kokonaan vapaa jäsenmaksusta. Tarvitsemme vain todisteen (Leistungsbescheid tai todistus viranomaiselta / sairauskassalta).';

  @override
  String get wizardStufe3UploadTitle => 'Lataa Leistungsbescheid';

  @override
  String get wizardStufe3UploadHint => 'PDF / JPG / PNG, enintään 10 MB.';

  @override
  String get wizardStufe3UploadRequired =>
      'Lataa Leistungsbescheid ennen jatkamista.';

  @override
  String get wizardStufe3FileTooLarge =>
      'Tiedosto on liian suuri. Enintään 10 MB.';

  @override
  String get wizardStufe3UploadFailed =>
      'Tiedoston lataus epäonnistui. Yritä uudelleen.';

  @override
  String get wizardStufe3RegularFeeTitle => 'Maksu: 25 € / kk';

  @override
  String get wizardStufe3RegularFeeBody =>
      'Sääntöjen mukainen vakiojäsenmaksu varsinaisille jäsenille.';

  @override
  String get wizardStufe4Title => 'Maksu';

  @override
  String get wizardStufe4Prompt =>
      'Miten haluat maksaa jäsenmaksun? Ja minä päivänä kuukaudessa?';

  @override
  String get wizardStufe4MethodUeberweisungTitle => 'Tilisiirto (Überweisung)';

  @override
  String get wizardStufe4MethodUeberweisungBody =>
      'Aloitat maksun itse kuukausittain tililtäsi.';

  @override
  String get wizardStufe4MethodSepaTitle => 'SEPA-Lastschrift (suoraveloitus)';

  @override
  String get wizardStufe4MethodSepaBody =>
      'Veloitamme summan automaattisesti tililtäsi. Helpoin, mutta tarvitsemme IBANin ja allekirjoitetun valtakirjan.';

  @override
  String get wizardStufe4MethodDauerauftragTitle =>
      'Dauerauftrag (toistuva toimeksianto)';

  @override
  String get wizardStufe4MethodDauerauftragBody =>
      'Asetat pankissasi toistuvan toimeksiannon. Pankki siirtää summan automaattisesti kuukausittain.';

  @override
  String get wizardStufe4DayLabel => 'Maksupäivä';

  @override
  String get wizardStufe4DayHint => 'Valitse päivä väliltä 1–31';

  @override
  String wizardStufe4DayItem(int day) {
    return '$day. päivä';
  }

  @override
  String wizardStufe4DayReminder(int day) {
    return 'Maksu veloitetaan $day. päivänä joka kuukausi.';
  }

  @override
  String get wizardStufe5Title => 'Alkamispäivä';

  @override
  String get wizardStufe5Prompt =>
      'Mistä lähtien haluat olla virallisesti ICD360S-jäsen? Hyväksynnästä alkaen vai takautuvasti.';

  @override
  String get wizardStufe5OptionAbVerifizierungTitle =>
      'Vorstandin hyväksynnästä alkaen';

  @override
  String get wizardStufe5OptionAbVerifizierungBody =>
      'Yksinkertaisin valinta. Ei takautuvaa maksua.';

  @override
  String get wizardStufe5OptionGruendungsdatumTitle =>
      'Takautuvasti 01.08.2025 (perustaminen)';

  @override
  String get wizardStufe5OptionGruendungsdatumBody =>
      'Sinut lasketaan jäseneksi yhdistyksen ensimmäisestä päivästä.';

  @override
  String get wizardStufe5OptionAnderesDatumTitle => 'Muu päivä';

  @override
  String get wizardStufe5OptionAnderesDatumBody =>
      'Valitset päivän väliltä 01.08.2025–tänään.';

  @override
  String get wizardStufe5PickDate => 'Napauta valitaksesi päivän';

  @override
  String get wizardStufe5PickDateFirst => 'Valitse ensin päivämäärä.';

  @override
  String get wizardStufe5DatePickerHelp => 'Jäsenyyden alku';

  @override
  String wizardStufe5DateRange(String start) {
    return '$start ja tämä päivä välillä';
  }

  @override
  String get wizardStufe5RetroactiveTitle => 'Takautuva maksu';

  @override
  String wizardStufe5RetroactiveBody(
      String start, String end, int months, String amount) {
    return '$start ja $end välillä on $months kuukautta. 25 €/kk laskien tämä on $amount € maksettavaksi takautuvasti nykyisen kuukausimaksun lisäksi.';
  }

  @override
  String get wizardStufe5FeeExemptTitle => 'Takautuva maksu: 0 € 🎉';

  @override
  String get wizardStufe5FeeExemptBody =>
      'Bürgergeldillä tai Sozialamtilla olet täysin vapautettu — myöskään takautuvasti et ole velkaa.';

  @override
  String wizardDocumentPrompt(String doc) {
    return 'Ennen kuin lopetamme, lue $doc huolellisesti. On tärkeää tietää, mitä allekirjoitat.';
  }

  @override
  String get wizardDocumentScrollHint => 'Vieritä loppuun jatkaaksesi.';

  @override
  String get wizardDocumentScrolledOk => 'Olet lukenut loppuun ✓';

  @override
  String wizardDocumentOpenButton(String doc) {
    return 'Avaa $doc selaimessa';
  }

  @override
  String get wizardDocumentExternalHint =>
      'Tällä alustalla avaamme dokumentin oletusselaimessasi.';

  @override
  String get wizardDocumentOpenedOk =>
      'Dokumentti avattiin. Lue se huolellisesti.';

  @override
  String wizardDocumentConfirm(String doc) {
    return 'Vahvistan, että olen lukenut $doc ja hyväksyn sen.';
  }

  @override
  String get wizardFinalAdultTitle => 'Valmis! Olet ilmoittautunut 🎉';

  @override
  String get wizardFinalMinorTitle => 'Pyyntösi on lähetetty 📨';

  @override
  String get wizardFinalMinorBody =>
      'Otamme yhteyttä vanhempaasi ja sovimme tapaamisen (paikan päällä tai videopuhelulla). Ole kärsivällinen — prosessi voi kestää jopa 7 päivää. Saat ilmoituksen sovelluksessa heti, kun vanhempasi on hyväksynyt.';

  @override
  String get wizardFinalMitgliedernummerLabel => 'Jäsennumerosi';

  @override
  String get wizardStufe4MethodComingSoon => 'Tulossa pian';

  @override
  String get wizardStufe4StreichungWarning =>
      'Jos jäät yli 6 kuukautta jälkeen maksusta, poistamme sinut automaattisesti (Satzung §6 Abs. 3).';

  @override
  String get wizardStufe5KuendigungInfo =>
      'Eroamiseen: lähetä irtisanominen kirjallisesti 3 kuukautta ennen 31. joulukuuta (viimeistään 30. syyskuuta, jotta tulee voimaan vuoden lopussa). Vähimmäisjäsenyyttä ei ole (Satzung §6 Abs. 3).';

  @override
  String get wizardStufe1fEmailLabel => 'Jäsensähköpostisi';

  @override
  String get wizardStufe1fEmailHelper =>
      'Luodaan automaattisesti jäsennumerosi pohjalta. Aktivoituu sillä hetkellä, kun hallitus (Vorstand) hyväksyy hakemuksesi. Meillä on oma sähköpostisovellus — lähetä ja vastaanota salattuja sähköposteja, helposti ja ilmaiseksi.';

  @override
  String get wizardErrInvalidEmail => 'Virheellinen sähköpostiosoite';

  @override
  String get wizardStufe3OptionAlg1 =>
      'Saan Arbeitslosengeld I (ALG I, työttömyyspäiväraha)';

  @override
  String get wizardStufe3OptionKrankengeld =>
      'Saan Krankengeld (sairauspäiväraha pitkäaikaisesta sairaudesta)';

  @override
  String get wizardStufe3UploadAddMore => 'Lisää uusi asiakirja';

  @override
  String get wizardStufe3UploadLimitCount =>
      'Raja saavutettu: enintään 20 asiakirjaa.';

  @override
  String get wizardStufe3UploadLimitTotal =>
      'Kokonaisraja 100 MB saavutettu. Poista olemassa oleva tiedosto.';

  @override
  String get wizardStufe3UploadDeleteTooltip => 'Poista';

  @override
  String wizardStufe3UploadCounter(int count, int max) {
    return '$count / $max asiakirjaa';
  }

  @override
  String get wizardDocumentExternalOpenFailed =>
      'Selainta ei voitu avata. Linkki on leikepöydällä — liitä se selaimeen jatkaaksesi.';

  @override
  String get wizardFinalTimelineProcessing =>
      'Vorstand tarkistaa · yleensä 1 arkipäivä, enintään 7';

  @override
  String get wizardFinalTimelineActivated => 'Tili aktivoitu';

  @override
  String get wizardFinalAdultThank =>
      'Kiitos, että täytit rekisteröintilomakkeen! 🎉';

  @override
  String get wizardFinalAdultUsual =>
      'Hakemuksesi on meillä. Yleensä tarkistamme sen yhden arkipäivän kuluessa.';

  @override
  String get wizardFinalAdultExceptional =>
      'Joskus se voi viedä jopa 7 arkipäivää. Ja jos jokin ei täsmää, lähetämme sinut takaisin lomakkeeseen korjaamaan 🙂';

  @override
  String get wizardFinalStatusTitle => 'HAKEMUKSEN TILA';

  @override
  String wizardFinalStatusStepsValidated(int reviewed, int total) {
    return '$reviewed/$total vaihetta Vorstandin vahvistamaa';
  }

  @override
  String get wizardFinalStufeSheetTitle => 'Hakemuksen tiedot';

  @override
  String get wizardFinalStufeSheetHint =>
      'Kahdeksan täyttämääsi vaihetta. Vorstand käy ne läpi yksi kerrallaan — näet reaaliaikaisesti, mitkä on hyväksytty.';

  @override
  String get wizardFinalStufeStatusPending => 'Odottaa tarkistusta';

  @override
  String get wizardFinalStufeStatusApproved => 'Hyväksytty';

  @override
  String get wizardFinalStufeStatusRejected => 'Hylätty';

  @override
  String wizardFinalStatusRejectionCount(int count) {
    return '$count vaihe vaatii korjausta';
  }

  @override
  String get wizardFinalStufeRejectionReason => 'Vorstandin perustelu:';

  @override
  String get wizardFinalStufeCorrectNow => 'Korjaa nyt';

  @override
  String wizardFinalApprovalsHeader(int current, int total) {
    return 'Vorstandin hyväksynnät ($current/$total)';
  }

  @override
  String get wizardFinalApprovalAwaiting => 'Odotetaan 2. Vorstandia';

  @override
  String get wizardFinalApprovalRejected => 'HYLÄTTY';

  @override
  String get wizardFinalStufeNoDataYet => 'Tietoja ei ole vielä saatavilla.';

  @override
  String get wizardFinalStufeReadAt => 'Luettu:';

  @override
  String get wizardFinalStufeBeitragsfrei => 'Maksuvapaa (ei maksua)';

  @override
  String get wizardFinalStufeNotExempt => 'Ei sosiaalietuuksia';

  @override
  String get wizardFinalStufeBeginAtVerification => 'Alkaa vahvistuksesta';

  @override
  String get wizardFinalStufeBeginAtFoundation =>
      'Perustamispäivä (takautuvasti)';

  @override
  String get wizardFinalStufeBeginAtCustom => 'Muu päivä';

  @override
  String get wizardFinalStufeStatusSkipped => 'Ohitettu';

  @override
  String get wizardFinalStufeFilledAt => 'Täytetty:';

  @override
  String get wizardFinalStufeReviewedAt => 'Tarkistettu:';

  @override
  String get wizardFinalWithdrawLink => 'Peruuta hakemus';

  @override
  String get wizardFinalWithdrawDialogTitle => 'Perutaanko hakemus?';

  @override
  String get wizardFinalWithdrawDialogBody =>
      'Hakemuksesi merkitään sinun perumaksi. Tiedot säilyvät tietokannassa tarkastusta varten (GDPR), mutta tiliä ei aktivoida. Voit aloittaa rekisteröitymisen uudelleen milloin tahansa uudella jäsennumerolla.';

  @override
  String get wizardFinalWithdrawKeep => 'Ei, odotan';

  @override
  String get wizardFinalWithdrawConfirm => 'Kyllä, peru';

  @override
  String get wizardErrTooManyWithdrawals =>
      'Hakemustasi ei voi käsitellä automaattisesti. Soita meille tai tule käymään Vorstandilla henkilökohtaisesti, jotta voit jatkaa rekisteröitymistä.';

  @override
  String get wizardDuplicateLoginTitle =>
      'Näyttää siltä, että olet jo jäsenemme';

  @override
  String get wizardDuplicateLoginBody =>
      'Nimellä ja syntymäajalla löydämme jo aktiivisen tilin. Käytä etusivulla \"Olen jo jäsen\" -kohtaa kirjautuaksesi. Jos sinulla ei ole enää pääsyä, soita meille.';

  @override
  String get wizardDuplicatePendingTitle => 'Hakemuksesi on jo meillä';

  @override
  String get wizardDuplicatePendingBody =>
      'Nimellä ja syntymäajalla meillä on jo hakemus käsittelyssä. Vorstand tutkii sitä — ilmoitamme sovelluksessa heti, kun tilisi on aktiivinen. Soita, jos haluat keskustella.';

  @override
  String get wizardDuplicateRecentlyWithdrawnTitle =>
      'Emme voi käsitellä tätä hakemusta nyt';

  @override
  String get wizardDuplicateRecentlyWithdrawnBody =>
      'Nimesi ja syntymäaikasi vastaavat hiljattain peruttua hakemusta. Soita meille, jotta voit puhua Vorstandin kanssa ennen kuin jatkat.';

  @override
  String get wizardDuplicatePreviouslyWithdrawnTitle => 'Olet hakenut aiemmin';

  @override
  String get wizardDuplicatePreviouslyWithdrawnBody =>
      'Nimesi ja syntymäaikasi vastaavat vanhempaa hakemusta, jonka olit perunut. Tervetuloa takaisin — soita meille ennen jatkamista, jotta Vorstand voi päättää, miten etenemme.';

  @override
  String get wizardDuplicateCallUsTitle => 'Soita meille';

  @override
  String get wizardDuplicateCallUsBody =>
      'Nimesi ja syntymäaikasi näkyvät jo tietokannassamme, mutta emme voi kertoa yksityiskohtia sovelluksen kautta. Soita meille — Vorstand selittää tilanteen suoraan.';

  @override
  String get wizardChatHelp => 'Jutellaan';

  @override
  String get wizardChatHelpSubtitle =>
      'Live-chat Vorstandin kanssa · nopea vastaus';

  @override
  String get benachrichtigungTitel => 'Tekstiviestimuistutukset';

  @override
  String get benachrichtigungIntro =>
      'Jotta et unohtaisi tapaamista, yhdistys voi lähettää sinulle tekstiviestin. Sinä päätät, haluatko ja mistä — ja voit muuttaa sen milloin tahansa.';

  @override
  String get benachrichtigungTermineFrage =>
      'Haluatko muistutukset tapaamisistasi tekstiviestillä?';

  @override
  String get benachrichtigungTermineDetail =>
      'Viesti sisältää tapaamisen päivämäärän, kellonajan, paikan ja aiheen.';

  @override
  String get benachrichtigungMedikamenteFrage =>
      'Haluatko muistutukset myös lääkkeistäsi?';

  @override
  String get benachrichtigungMedikamenteDetail =>
      'Silloin viestissä lukee lääkkeen nimi. Se on terveystieto — siksi kysymme erikseen.';

  @override
  String get benachrichtigungHinweis =>
      'Muistutus on apu eikä takuu: älä luota pelkästään siihen. Voit muuttaa tätä milloin tahansa profiilissasi.';

  @override
  String get benachrichtigungJa => 'Kyllä';

  @override
  String get benachrichtigungNein => 'Ei';

  @override
  String get benachrichtigungSpaeter => 'Päätän myöhemmin';

  @override
  String get benachrichtigungSpeichern => 'Tallenna';

  @override
  String get benachrichtigungGespeichert => 'Kiitos, tallennettu.';

  @override
  String get benachrichtigungenLeer => 'Ei ilmoituksia';

  @override
  String get benachrichtigungenAlleGelesen => 'Merkitse kaikki luetuiksi';

  @override
  String get benachrichtigungWetterFrage =>
      'Haluatko varoituksen rajuilmasta asuinpaikkakunnallasi?';

  @override
  String get benachrichtigungWetterDetail =>
      'Vain Saksan ilmatieteen laitoksen viralliset varoitukset tasosta „vakava“ ylöspäin — ei jokaisesta sateesta.';

  @override
  String get signaturTitel => 'Allekirjoitukset';

  @override
  String get signaturNichtsOffen =>
      'Tällä hetkellä ei ole mitään allekirjoitettavaa.';

  @override
  String get signaturStatusOffen => 'Odottaa allekirjoitustasi';

  @override
  String get signaturStatusSigniert => 'Olet allekirjoittanut';

  @override
  String get signaturStatusAbgelehnt => 'Olet kieltäytynyt';

  @override
  String get signaturStatusWiderrufen => 'Yhdistys on peruuttanut pyynnön';

  @override
  String get signaturStatusAbgelaufen => 'Määräaika on umpeutunut';

  @override
  String signaturBitteGanzLesen(int gelesen, int gesamt) {
    return 'Lue asiakirja loppuun asti (sivu $gelesen/$gesamt).';
  }

  @override
  String get signaturWeiterZurUnterschrift => 'Siirry allekirjoitukseen';

  @override
  String get signaturAblehnen => 'Kieltäydy';

  @override
  String get signaturAblehnenHinweis =>
      'Yhdistys saa tästä ilmoituksen. Voit halutessasi kertoa syyn.';

  @override
  String get signaturAblehnenGrund => 'Syy (valinnainen)';

  @override
  String get signaturMitFingerHinweis =>
      'Piirrä allekirjoituksesi sormella valkoiseen kenttään.';

  @override
  String get signaturNochmal => 'Piirrä uudelleen';

  @override
  String get signaturZurueckZumDokument => 'Takaisin asiakirjaan';

  @override
  String get signaturCodeAnfordern => 'Pyydä koodi tekstiviestillä';

  @override
  String get signaturCodeUnterwegs => 'Koodi on matkalla.';

  @override
  String signaturCodeGesendetAn(String nummer) {
    return 'Lähetimme koodin numeroon $nummer.';
  }

  @override
  String get signaturCodeErneutSenden => 'Lähetä koodi uudelleen';

  @override
  String get signaturJetztUnterschreiben => 'Allekirjoita nyt';

  @override
  String get signaturCodeFalsch => 'Koodi ei ole oikein.';

  @override
  String get signaturCodeAbgelaufen =>
      'Koodi on vanhentunut. Pyydä uusi koodi.';

  @override
  String get signaturZuVieleVersuche =>
      'Liian monta virheellistä yritystä. Pyydä uusi koodi.';

  @override
  String get signaturKeineRufnummer =>
      'Tilillesi ei ole tallennettu matkapuhelinnumeroa. Ilman sitä emme voi lähettää sinulle koodia — ota yhteyttä yhdistyksen puheenjohtajaan.';

  @override
  String get signaturCodeFehlgeschlagen => 'Koodin lähettäminen ei onnistunut.';

  @override
  String get signaturLeer => 'Piirrä ensin allekirjoituksesi.';

  @override
  String get signaturErfolg => 'Kiitos — allekirjoituksesi on vastaanotettu.';

  @override
  String get signaturFehlgeschlagen => 'Jokin meni pieleen. Yritä uudelleen.';

  @override
  String get signaturSiegelInArbeit =>
      'Allekirjoitettua asiakirjaa valmistellaan vielä. Yritäthän uudelleen minuutin kuluttua.';

  @override
  String get signaturWartetZweiteUnterschrift =>
      'Odottaa toista allekirjoitusta';

  @override
  String get signaturWartenHinweis =>
      'Olet allekirjoittanut. Asiakirja valmistellaan, heti kun myös toinen henkilö on allekirjoittanut sen.';

  @override
  String get kontaktNochAktuell => 'Ovatko nämä tiedot yhä ajan tasalla?';

  @override
  String get kontaktWarumFragen =>
      'Jotta et menetä mitään, kysymme lyhyesti kolmen kuukauden välein. Saat kuusinumeroisen koodin.';

  @override
  String kontaktBestaetigtAm(Object datum) {
    return 'vahvistettu $datum';
  }

  @override
  String get kontaktFestnetzKeinSms =>
      'Tämä on lankapuhelinnumero — tekstiviesti ei mene perille.';

  @override
  String get kontaktIstAndersGeworden => 'On muuttunut';

  @override
  String get themeTitle => 'Ulkoasu';

  @override
  String get themeLight => 'Vaalea';

  @override
  String get themeDark => 'Tumma';

  @override
  String get themeSystem => 'Laitteen mukaan';

  @override
  String get themeSchedule => 'Automaattinen (klo 20–06)';

  @override
  String get themeScheduleHint => 'Tumma klo 20–6, muun ajan vaalea.';

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
  String get fernwartungAnfrageTitel => 'Etätukipyyntö';

  @override
  String fernwartungAnfrageText(String name) {
    return '”$name” haluaa nähdä ja ohjata näyttöäsi auttaakseen sinua. Mitään ei välitetä ilman suostumustasi.';
  }

  @override
  String get fernwartungAnfrageHinweis =>
      'Näet ilmoituksen koko ajan ja voit painaa ”Lopeta” milloin tahansa.';

  @override
  String get fernwartungErlauben => 'Salli';

  @override
  String get fernwartungAblehnen => 'Hylkää';

  @override
  String get fernwartungVerbindet => 'Yhdistetään …';

  @override
  String get fernwartungAktiv => 'Näyttöäsi jaetaan';

  @override
  String get fernwartungStopp => 'Lopeta';

  @override
  String get fernwartungMikroAus => 'Mykistä mikrofoni';

  @override
  String get fernwartungMikroAn => 'Poista mikrofonin mykistys';
}
