// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Finnish (`fi`).
class AppLocalizationsFi extends AppLocalizations {
  AppLocalizationsFi([String locale = 'fi']) : super(locale);

  @override
  String get appTitle => 'ICD360S e.V - Jäsenportaali';

  @override
  String get memberPortal => 'Jäsenportaali';

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
  String get password => 'Salasana';

  @override
  String get passwordHint => 'Anna salasana';

  @override
  String get confirmPassword => 'Vahvista salasana';

  @override
  String get confirmPasswordHint => 'Vahvista salasana';

  @override
  String get newPassword => 'Uusi salasana';

  @override
  String get newPasswordHint => 'Anna uusi salasana';

  @override
  String get saveCredentials => 'Tallenna kirjautumistiedot';

  @override
  String get autoLogin => 'Automaattinen kirjautuminen';

  @override
  String get forgotPassword => 'Unohditko salasanan?';

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
  String get recoveryCode => 'Palautuskoodi (6 numeroa)';

  @override
  String get recoveryCodeHelper => 'Muista tämä koodi salasanan palauttamiseen';

  @override
  String get recoveryCodeHint => 'Anna palautuskoodi';

  @override
  String get recoveryCodeInvalid => 'Koodissa on oltava tasan 6 numeroa';

  @override
  String get loginFailed => 'Kirjautuminen epäonnistui';

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
  String get tooManyDevices => 'Liian monta laitetta';

  @override
  String get maxDevicesMessage =>
      'Olet jo kirjautunut 3 laitteella.\nValitse laite uloskirjautumista varten:';

  @override
  String get unknownDevice => 'Tuntematon laite';

  @override
  String get unknown => 'Tuntematon';

  @override
  String get logoutError => 'Uloskirjautumisvirhe';

  @override
  String error(String error) {
    return 'Virhe: $error';
  }

  @override
  String get cancel => 'Peruuta';

  @override
  String get resetPassword => 'Nollaa salasana';

  @override
  String get forgotPasswordTitle => 'Unohtunut salasana';

  @override
  String get forgotPasswordDescription =>
      'Anna jäsennumerosi ja rekisteröinnin yhteydessä luomasi palautuskoodi.';

  @override
  String get passwordResetSuccess =>
      'Salasana nollattu onnistuneesti!\n\nVoit nyt kirjautua uudella salasanallasi.';

  @override
  String get passwordResetFailed => 'Salasanan nollaus epäonnistui';

  @override
  String get needHelp => 'Tarvitsetko apua?';

  @override
  String get helpQuestion => 'Ongelmia kirjautumisessa tai rekisteröinnissä?';

  @override
  String get helpDescription =>
      'Ota yhteyttä WhatsAppissa ja kuvaile, mikä ei toimi. Vastaamme mahdollisimman pian!';

  @override
  String get whatsapp => 'WhatsApp';

  @override
  String get emailSubject => 'Kysely ICD360S-sovelluksen kautta';

  @override
  String get whatsappMessage =>
      'Hei, minulla on ongelma ICD360S-sovelluksen kanssa. ';

  @override
  String get imprint => 'Impressum';

  @override
  String get privacy => 'Tietosuojakäytäntö';

  @override
  String get statutes => 'Säännöt';

  @override
  String get revocation => 'Peruutusoikeus';

  @override
  String get cancellation => 'Irtisanominen';

  @override
  String get allRightsReserved => 'Kaikki oikeudet pidätetään.';

  @override
  String get enterCredentials => 'Anna jäsennumero ja salasana';

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
  String get membership => 'Jäsenyys';

  @override
  String get myAppointments => 'Omat tapaamiset';

  @override
  String get appointmentsLoadingReady => 'Ladataan tapaamisia - API valmis!';

  @override
  String get priority => 'Prioriteetti';

  @override
  String get messageLabel => 'Viesti';

  @override
  String get createdOn => 'Luotu';

  @override
  String get handler => 'Käsittelijä';

  @override
  String get reportProblems => 'Ilmoita ongelmista';

  @override
  String get reportProblem => 'Ilmoita ongelma';

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
  String get newTicket => 'Uusi tiketti';

  @override
  String get noOpenTickets => 'Ei avoimia tikettejä';

  @override
  String get haveQuestionCreateTicket =>
      'Onko sinulla kysymys tai ongelma?\nLuo uusi tiketti.';

  @override
  String get whatIsTheProblem => 'Mikä ongelma on?';

  @override
  String get describeTheProblem => 'Kuvaile ongelma';

  @override
  String get howUrgentIsIt => 'Kuinka kiireellinen?';

  @override
  String get low => 'Matala';

  @override
  String get medium => 'Keskitaso';

  @override
  String get high => 'Korkea';

  @override
  String get submit => 'Lähetä';

  @override
  String get fillSubjectAndMessage => 'Täytä aihe ja viesti';

  @override
  String get ticketCreated => 'Tiketti luotu';

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
  String get newEmailAddress => 'Uusi sähköpostiosoite';

  @override
  String get currentPassword => 'Nykyinen salasana';

  @override
  String get saveEmail => 'Tallenna sähköposti';

  @override
  String get savePassword => 'Tallenna salasana';

  @override
  String get deviceLoggedOut => 'Laite kirjautunut ulos';

  @override
  String get passwordChangedSuccessfully => 'Salasana vaihdettu';

  @override
  String get emailChangedSuccessfully => 'Sähköposti vaihdettu';

  @override
  String get errorChangingPassword => 'Virhe salasanan vaihdossa';

  @override
  String get errorChangingEmail => 'Virhe sähköpostin vaihdossa';

  @override
  String get validEmailRequired => 'Anna kelvollinen sähköpostiosoite';

  @override
  String get passwordTooShort => 'Salasanan on oltava vähintään 6 merkkiä';

  @override
  String get maxDevicesReached =>
      'Olet kirjautuneena maksimimäärään 3 laitetta.';

  @override
  String loggedInOnDevices(int count) {
    return 'Olet kirjautuneena $count laitteella 3:sta.';
  }

  @override
  String get noActiveSessions => 'Ei aktiivisia istuntoja';

  @override
  String get logoutFromDevice => 'Kirjaudu ulos tältä laitteelta';

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
  String get errorAcceptingCall => 'Virhe puhelun vastaanottamisessa';

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
  String typingIndicator(String name) {
    return '$name kirjoittaa...';
  }

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
  String get diagnosticDataTitle => 'Diagnostiikkatiedot';

  @override
  String get diagnosticDescription =>
      'Haluatko lähettää nimettömiä diagnostiikkatietoja sovelluksen parantamiseksi?';

  @override
  String get noThanks => 'Ei kiitos';

  @override
  String get yesEnable => 'Kyllä, ota käyttöön';

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
  String get newPasswordMinChars => 'Uusi salasana (väh. 6 merkkiä)';

  @override
  String get reasonLabel2 => 'Syy';

  @override
  String get downloadFailed2 => 'Lataus epäonnistui';

  @override
  String get downloadTooltip => 'Lataa';

  @override
  String get connectionErrorGeneric => 'Yhteysvirhe';

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
  String get bankTransfer => 'Pankkisiirto';

  @override
  String get standingOrder => 'Toistuvaissuoritus';

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
  String get memberNumberTooLong =>
      'Jäsennumero liian pitkä (enintään 20 merkkiä)';

  @override
  String get onlyUppercaseAndNumbers =>
      'Vain isot kirjaimet ja numerot sallittu';

  @override
  String get passwordTooLong => 'Salasana liian pitkä (enintään 100 merkkiä)';

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
  String get diagnosticErrors => 'Virheraportteja parannukseen';

  @override
  String get diagnosticAnonymousStats => 'Anonyymit käyttötilastot';

  @override
  String get diagnosticPerformance => 'Sovelluksen suorituskykytiedot';

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
  String get ipClean => 'IP puhdas - ei listalla';

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
  String get helpImproveApp => 'Haluatko auttaa meitä parantamaan sovellusta?';

  @override
  String get noPersonalDataCollected =>
      'Henkilötietoja ei kerätä. Tätä asetusta voi muuttaa milloin tahansa.';

  @override
  String logEntries(int count) {
    return '$count merkintää';
  }

  @override
  String get noLogs => 'Ei lokeja';

  @override
  String get newLoginDetected => 'Uusi kirjautuminen havaittu';

  @override
  String get waitingForMember => 'Odotetaan jäsentä';

  @override
  String get waitingForStaff => 'Odotetaan henkilökuntaa';

  @override
  String get waitingForAuthority => 'Odotetaan viranomaista';
}
