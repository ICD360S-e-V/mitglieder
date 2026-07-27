// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Czech (`cs`).
class AppLocalizationsCs extends AppLocalizations {
  AppLocalizationsCs([String locale = 'cs']) : super(locale);

  @override
  String get welcomeLoading => 'Načítání...';

  @override
  String get welcomeAutoLogin => 'Automatické přihlášení...';

  @override
  String get login => 'Přihlásit se';

  @override
  String get register => 'Registrovat se';

  @override
  String get becomeMember => 'Staňte se členem';

  @override
  String get memberNumber => 'Číslo člena';

  @override
  String get memberNumberHint => 'Zadejte číslo člena';

  @override
  String get confirmPassword => 'Potvrďte heslo';

  @override
  String get confirmPasswordHint => 'Potvrďte heslo';

  @override
  String get newPassword => 'Nové heslo';

  @override
  String get newPasswordHint => 'Zadejte nové heslo';

  @override
  String get firstName => 'Jméno a příjmení';

  @override
  String get firstNameHint => 'Zadejte jméno a příjmení';

  @override
  String get nameMinLength => 'Jméno musí mít alespoň 2 znaky';

  @override
  String get nameOnlyLetters => 'Povolena pouze písmena a pomlčky';

  @override
  String get email => 'E-mailová adresa';

  @override
  String get emailHint => 'Zadejte e-mail';

  @override
  String get emailInvalid => 'Zadejte platný e-mail';

  @override
  String get passwordMinLength => 'Heslo musí mít alespoň 6 znaků';

  @override
  String get passwordsNotMatch => 'Hesla se neshodují';

  @override
  String get registrationFailed => 'Registrace se nezdařila';

  @override
  String connectionError(String error) {
    return 'Chyba připojení: $error';
  }

  @override
  String registrationSuccess(String memberNumber) {
    return 'Registrace úspěšná!\n\nVaše číslo člena: $memberNumber\n\nZapamatujte si toto číslo pro přihlášení.';
  }

  @override
  String get unknown => 'Neznámé';

  @override
  String error(String error) {
    return 'Chyba: $error';
  }

  @override
  String get cancel => 'Zrušit';

  @override
  String get resetPassword => 'Obnovit heslo';

  @override
  String get imprint => 'Impressum';

  @override
  String get privacy => 'Ochrana osobních údajů';

  @override
  String get statutes => 'Stanovy';

  @override
  String get revocation => 'Právo na odstoupení';

  @override
  String get appointments => 'Schůzky';

  @override
  String get tickets => 'Tikety';

  @override
  String get liveChat => 'Live Chat';

  @override
  String get notifications => 'Oznámení';

  @override
  String get myProfile => 'Můj Profil';

  @override
  String get logout => 'Odhlásit';

  @override
  String get goodMorning => 'Dobré ráno';

  @override
  String get goodDay => 'Dobrý den';

  @override
  String get goodEvening => 'Dobrý večer';

  @override
  String get goodNight => 'Dobrou noc';

  @override
  String get welcomeToICD => 'Vítejte v ICD360S e.V!';

  @override
  String get accountCreatedSuccessfully => 'Váš účet byl úspěšně vytvořen.';

  @override
  String get today => 'Dnes';

  @override
  String get membershipFeeDue => 'Členský příspěvek splatný';

  @override
  String get pleaseTransferAnnualFee => 'Prosím, převeďte roční příspěvek.';

  @override
  String get newBadge => 'Nový';

  @override
  String get close => 'Zavřít';

  @override
  String get myAppointments => 'Moje schůzky';

  @override
  String get priority => 'Priorita';

  @override
  String get messageLabel => 'Zpráva';

  @override
  String get reportProblems => 'Nahlásit problémy';

  @override
  String get weRespondIn24Hours => 'Odpovíme vám do maximálně 24 hodin!';

  @override
  String get everythingOk => 'Vše v pořádku!';

  @override
  String get haveProblemWeHelp => 'Máte problém?\nPostaráme se o to!';

  @override
  String get myMembership => 'Moje členství';

  @override
  String get managePersonalDataAndFee =>
      'Spravujte své osobní údaje a příspěvek';

  @override
  String get myAppointmentsTitle => 'Moje schůzky';

  @override
  String get appointmentsDescription =>
      'Zde můžete vidět své nadcházející schůzky.\nMůžete potvrdit svou účast nebo odmítnout.';

  @override
  String get loadAppointments => 'Načíst schůzky';

  @override
  String get myTickets => 'Moje tikety';

  @override
  String get low => 'Nízká';

  @override
  String get high => 'Vysoká';

  @override
  String get submit => 'Odeslat';

  @override
  String get errorCreatingTicket => 'Chyba při vytváření tiketu';

  @override
  String get verified => 'Ověřeno';

  @override
  String get account => 'Účet';

  @override
  String get myDevices => 'Moje zařízení';

  @override
  String get changeEmail => 'Změnit email';

  @override
  String get changePassword => 'Změnit heslo';

  @override
  String get saveEmail => 'Uložit email';

  @override
  String get savePassword => 'Uložit heslo';

  @override
  String get deviceLoggedOut => 'Zařízení odhlášeno';

  @override
  String get emailChangedSuccessfully => 'Email úspěšně změněn';

  @override
  String get errorChangingPassword => 'Chyba při změně hesla';

  @override
  String get errorChangingEmail => 'Chyba při změně emailu';

  @override
  String get validEmailRequired => 'Zadejte platnou emailovou adresu';

  @override
  String get confirmLogoutDevice => 'Odhlásit zařízení?';

  @override
  String get confirmLogoutMessage =>
      'Chcete se odhlásit z tohoto zařízení?\n\nBudete se muset znovu přihlásit, abyste mohli toto zařízení používat.';

  @override
  String get ipAddress => 'IP';

  @override
  String get platform => 'Platforma';

  @override
  String trialWarningUrgentTitle(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days dní',
      few: '$days dny',
      one: '1 den',
    );
    return 'Pozor: Zbývá $_temp0 do pozastavení účtu!';
  }

  @override
  String get trialWarningTitle => 'Váš účet ještě nebyl ověřen';

  @override
  String get trialWarningDescription =>
      'Vyplňte prosím své údaje v \"Můj profil\". Po 30 dnech bude váš účet automaticky pozastaven.';

  @override
  String trialDaysRemaining(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days dní',
      few: '$days dny',
      one: '1 den',
    );
    return '$_temp0';
  }

  @override
  String get overview => 'Přehled';

  @override
  String get member => 'Člen';

  @override
  String get memberManagement => 'Správa členů';

  @override
  String get reportProblemTooltip => 'Nahlásit problém';

  @override
  String get newAppointmentsTitle => 'Nové schůzky';

  @override
  String get youHaveNewAppointment => 'Máte novou schůzku.';

  @override
  String youHaveNewAppointments(int count) {
    return 'Máte $count nových schůzek.';
  }

  @override
  String get appointmentReminderTomorrow => 'Připomínka: Schůzka zítra';

  @override
  String tomorrowAppointment(String title) {
    return 'Zítra: $title';
  }

  @override
  String youHaveTomorrowAppointments(int count) {
    return 'Máte $count schůzek zítra.';
  }

  @override
  String get appointmentsToday => 'Schůzky dnes';

  @override
  String todayAppointment(String title) {
    return 'Dnes: $title';
  }

  @override
  String youHaveTodayAppointments(int count) {
    return 'Máte $count schůzek dnes.';
  }

  @override
  String get paymentReminder => 'Připomínka platby';

  @override
  String paymentReminderMessage(int day, String method) {
    return 'Dnes je $day. den v měsíci – dokončete prosím $method.';
  }

  @override
  String get paymentDayLabel => 'Den platby (měsíční připomínka)';

  @override
  String get updateAvailable => 'Aktualizace k dispozici';

  @override
  String newVersionAvailable(String version) {
    return 'Je k dispozici nová verze: $version';
  }

  @override
  String currentVersionLabel(String version) {
    return 'Aktuální verze: $version';
  }

  @override
  String get changes => 'Změny:';

  @override
  String downloadProgress(String percent) {
    return 'Stahování: $percent%';
  }

  @override
  String get installationStarting => 'Spouštění instalace...';

  @override
  String get appWillRestart => 'Aplikace se automaticky restartuje.';

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
  String get later => 'Později';

  @override
  String get updateNow => 'Aktualizovat nyní';

  @override
  String get downloading => 'Stahování...';

  @override
  String get downloadFailed =>
      'Stahování se nezdařilo. Zkuste to prosím později.';

  @override
  String get searchingForUpdates => 'Hledání aktualizací...';

  @override
  String get appUpToDate => 'Aplikace je aktuální';

  @override
  String get updateCheckError => 'Chyba při kontrole aktualizací';

  @override
  String get changelog => 'Seznam změn';

  @override
  String get terminConfirmed => 'Schůzka potvrzena';

  @override
  String get terminDeclined => 'Schůzka odmítnuta';

  @override
  String get terminRescheduleRequested => 'Požadavek na přeložení';

  @override
  String get statusConfirmed => 'Potvrzeno';

  @override
  String get statusDeclined => 'Odmítnuto';

  @override
  String get statusRescheduling => 'Přeložení';

  @override
  String get statusPending => 'Čekající';

  @override
  String get categoryVorstandssitzung => 'Schůze představenstva';

  @override
  String get categoryMitgliederversammlung => 'Valná hromada';

  @override
  String get categorySchulung => 'Školení';

  @override
  String get categorySonstiges => 'Ostatní';

  @override
  String openCount(int count) {
    return '$count otevřených';
  }

  @override
  String get refresh => 'Obnovit';

  @override
  String get filterUpcoming => 'Nadcházející';

  @override
  String get filterPast => 'Minulé';

  @override
  String get filterAll => 'Vše';

  @override
  String get noUpcomingAppointments => 'Žádné nadcházející schůzky';

  @override
  String get noPastAppointments => 'Žádné minulé schůzky';

  @override
  String get noAppointmentsAvailable => 'Žádné schůzky';

  @override
  String get appointmentsShownHere => 'Vaše schůzky se zobrazí zde';

  @override
  String get dateLabel => 'Datum';

  @override
  String get timeLabel => 'Čas';

  @override
  String get locationLabel => 'Místo';

  @override
  String get createdByLabel => 'Vytvořil';

  @override
  String get descriptionLabel => 'Popis';

  @override
  String get ticketLabel => 'Ticket';

  @override
  String get yourStatus => 'Váš stav: ';

  @override
  String reasonLabel(String reason) {
    return 'Důvod: $reason';
  }

  @override
  String durationMinutes(int minutes) {
    return '$minutes min';
  }

  @override
  String get confirm => 'Potvrdit';

  @override
  String get decline => 'Odmítnout';

  @override
  String get reschedule => 'Přeložit';

  @override
  String get requestReschedule => 'Požádat o přeložení';

  @override
  String appointmentLabel(String title) {
    return 'Schůzka: $title';
  }

  @override
  String get rescheduleReason => 'Důvod přeložení *';

  @override
  String get rescheduleReasonHint => 'Uveďte důvod...';

  @override
  String get pleaseProvideReason => 'Uveďte důvod';

  @override
  String get request => 'Požádat';

  @override
  String get ticketStatusOpen => 'Otevřeno';

  @override
  String get ticketStatusInProgress => 'Zpracovává se';

  @override
  String get ticketStatusWaitingMember => 'Čeká se na člena';

  @override
  String get ticketStatusWaitingStaff => 'Čeká se na pracovníka';

  @override
  String get ticketStatusWaitingAuthority => 'Čeká se na úřad';

  @override
  String get ticketStatusDone => 'Vyřízeno';

  @override
  String get ticketPriorityHigh => 'Vysoká';

  @override
  String get ticketPriorityMedium => 'Střední';

  @override
  String get ticketPriorityLow => 'Nízká';

  @override
  String get comments => 'Komentáře';

  @override
  String get documents => 'Dokumenty';

  @override
  String get details => 'Podrobnosti';

  @override
  String get replySent => 'Odpověď odeslána';

  @override
  String get sendError => 'Chyba při odesílání';

  @override
  String get uploading => 'Nahrávání...';

  @override
  String fileUploaded(String filename) {
    return '$filename nahráno';
  }

  @override
  String get uploadFailed => 'Nahrávání selhalo';

  @override
  String get openError => 'Chyba při otevírání';

  @override
  String get noRepliesYet => 'Zatím žádné odpovědi';

  @override
  String get waitingForSupport => 'Čekání na odpověď podpory';

  @override
  String get writeReply => 'Napsat odpověď...';

  @override
  String get attachFile => 'Připojit soubor';

  @override
  String documentsCount(int count) {
    return 'Dokumenty ($count)';
  }

  @override
  String get upload => 'Nahrát';

  @override
  String get noDocuments => 'Žádné dokumenty';

  @override
  String get allowedFormats => 'Povolené formáty: PDF, JPEG, JPG, TXT, ZIP';

  @override
  String get yourMessage => 'Vaše zpráva:';

  @override
  String get translation => 'Překlad';

  @override
  String get original => 'Originál';

  @override
  String get originalText => 'Původní text';

  @override
  String get autoTranslated => 'Automaticky přeloženo';

  @override
  String get originalTapTranslation => 'Originál · Klepněte pro překlad';

  @override
  String get translatedTapOriginal => 'Přeloženo · Klepněte pro originál';

  @override
  String get justNow => 'Právě teď';

  @override
  String minutesAgo(int minutes) {
    return 'před $minutes min';
  }

  @override
  String hoursAgo(int hours) {
    return 'před $hours hod';
  }

  @override
  String daysAgo(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'dny',
      one: 'dnem',
    );
    return 'před $days $_temp0';
  }

  @override
  String get createdLabel => 'Vytvořeno';

  @override
  String get updatedLabel => 'Aktualizováno';

  @override
  String get handlerLabel => 'Zpracovatel';

  @override
  String get doneLabel => 'Vyřízeno';

  @override
  String get newTicketTitle => 'Nový ticket';

  @override
  String get categoryOptional => 'Kategorie (volitelné)';

  @override
  String get selectCategory => 'Vybrat';

  @override
  String get subjectLabel => 'Předmět';

  @override
  String get fillAllFields => 'Vyplňte všechna pole';

  @override
  String ticketCreatedId(int id) {
    return 'Ticket #$id vytvořen';
  }

  @override
  String get priorityLabel => 'Priorita: ';

  @override
  String get supportOffline => 'Podpora offline';

  @override
  String get lastSeenSeconds => 'Aktivní před několika sekundami';

  @override
  String lastSeenMinutes(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: 'minutami',
      one: 'minutou',
    );
    return 'Aktivní před $minutes $_temp0';
  }

  @override
  String lastSeenHours(int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: 'hodinami',
      one: 'hodinou',
    );
    return 'Aktivní před $hours $_temp0';
  }

  @override
  String lastSeenDays(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'dny',
      one: 'dnem',
    );
    return 'Aktivní před $days $_temp0';
  }

  @override
  String get online => 'Online';

  @override
  String get callSupport => 'Zavolat';

  @override
  String get typeMessage => 'Napište zprávu...';

  @override
  String get callBusy => 'Podpora je zaneprázdněna';

  @override
  String get callRejected => 'Hovor byl odmítnut';

  @override
  String get callFailed => 'Hovor se nepodařilo spojit';

  @override
  String get callEnded => 'Hovor ukončen';

  @override
  String get callSupportBusy => 'Podpora je již v jiném hovoru';

  @override
  String get errorStartingChat => 'Chyba při spuštění chatu';

  @override
  String get errorStartingCall => 'Chyba při spuštění hovoru';

  @override
  String get errorConnecting => 'Chyba připojení';

  @override
  String get errorDownloading => 'Chyba stahování';

  @override
  String get errorUploading => 'Chyba nahrávání';

  @override
  String get errorSending => 'Chyba odesílání';

  @override
  String get errorPickingPhotos => 'Chyba výběru fotek';

  @override
  String get errorPickingFiles => 'Chyba výběru souborů';

  @override
  String get errorTakingPhoto => 'Chyba focení';

  @override
  String get fileNotLoaded => 'Soubor nelze načíst';

  @override
  String get attachmentIdMissing => 'ID přílohy chybí';

  @override
  String get camera => 'Fotoaparát';

  @override
  String get gallery => 'Galerie';

  @override
  String get file => 'Soubor';

  @override
  String get notifNewMessageFrom => 'Nová zpráva od';

  @override
  String get notifUrgentPrefix => 'NALÉHAVÉ';

  @override
  String get notifUrgentMessage => 'NALÉHAVÁ ZPRÁVA';

  @override
  String get notifIncomingCall => 'Příchozí hovor';

  @override
  String get notifCallingYou => 'volá...';

  @override
  String get notifUpdateAvailable => 'Aktualizace k dispozici';

  @override
  String get notifVersionAvailable => 'je nyní k dispozici';

  @override
  String get notifConnected => 'Připojeno';

  @override
  String get notifDisconnected => 'Odpojeno';

  @override
  String get notifConnectedBody => 'Jste připojeni k serveru.';

  @override
  String get notifDisconnectedBody => 'Spojení se serverem bylo přerušeno.';

  @override
  String get notifError => 'Chyba';

  @override
  String get retry => 'Zkusit znovu';

  @override
  String get save => 'Uložit';

  @override
  String get accept => 'Přijmout';

  @override
  String get selectFile => 'Vybrat soubor';

  @override
  String get dataLoadingText => 'Načítání dat...';

  @override
  String get dataSavedSuccess => 'Data úspěšně uložena';

  @override
  String get errorSaving => 'Chyba při ukládání';

  @override
  String get errorLoading => 'Chyba při načítání';

  @override
  String savedFilename(String filename) {
    return 'Uloženo: $filename';
  }

  @override
  String get logsCopied => 'Logy zkopírovány!';

  @override
  String get passwordMinEightChars => 'Heslo musí mít alespoň 8 znaků';

  @override
  String get passwordChangeSuccess => 'Heslo úspěšně změněno';

  @override
  String get emailChangeError => 'Chyba při změně e-mailu';

  @override
  String get acceptDocumentCheckbox => 'Přečetl jsem a přijímám dokument.';

  @override
  String loadingErrorGeneric(String details) {
    return 'Chyba načítání: $details';
  }

  @override
  String get incomingCallTitle => 'Příchozí hovor';

  @override
  String ringingFor(int seconds) {
    return 'Vyzvání ${seconds}s';
  }

  @override
  String get rejectCall => 'Odmítnout';

  @override
  String get acceptCall => 'Přijmout';

  @override
  String get unmute => 'Zapnout zvuk';

  @override
  String get mute => 'Ztlumit';

  @override
  String get hangUp => 'Zavěsit';

  @override
  String get calling => 'Volání...';

  @override
  String autoRejectIn(int seconds) {
    return 'Automatické odmítnutí za $seconds sekund';
  }

  @override
  String get speakerOn => 'Reproduktor';

  @override
  String get speakerOff => 'Sluchátko';

  @override
  String get micMuted => 'Ztlumeno';

  @override
  String get micOn => 'Mikrofon';

  @override
  String get connectionExcellent => 'Výborné';

  @override
  String get connectionGood => 'Dobré';

  @override
  String get connectionWeak => 'Slabé';

  @override
  String get connectionLost => 'Odpojeno';

  @override
  String get personalData => 'Osobní údaje';

  @override
  String get personalDataSubtitle => 'Jméno, příjmení, adresa';

  @override
  String get membershipFee => 'Členský příspěvek';

  @override
  String annualFeeYear(String year) {
    return 'Roční příspěvek $year';
  }

  @override
  String get amount => 'Částka:';

  @override
  String get dueBy => 'Splatnost:';

  @override
  String get paid => 'Zaplaceno';

  @override
  String get versionHistory => 'Historie verzí';

  @override
  String lastUpdated(String date) {
    return 'Poslední aktualizace: $date';
  }

  @override
  String get noVersionHistory => 'Žádná historie verzí';

  @override
  String get failedLoadChangelog => 'Nepodařilo se načíst seznam změn';

  @override
  String get callMember => 'Zavolat členovi';

  @override
  String get closeConversation => 'Zavřít konverzaci';

  @override
  String get chatOffline => 'Offline';

  @override
  String get attachFiles => 'Přiložit soubory (max. 10, 50MB)';

  @override
  String get conversationClosed => 'Tato konverzace byla uzavřena';

  @override
  String get noMessages => 'Žádné zprávy';

  @override
  String get goBack => 'Zpět';

  @override
  String get goForward => 'Vpřed';

  @override
  String get homePage => 'Domů';

  @override
  String get firstNameLabel => 'Jméno';

  @override
  String get lastNameLabel => 'Příjmení';

  @override
  String get streetLabel => 'Ulice';

  @override
  String get houseNumberLabel => 'Č.';

  @override
  String get postalCodeLabel => 'PSČ';

  @override
  String get cityLabel => 'Město';

  @override
  String get phoneMobileLabel => 'Telefon (Mobil)';

  @override
  String get phoneLandlineLabel => 'Telefon (Pevná linka)';

  @override
  String get newEmailLabel => 'Nová e-mailová adresa';

  @override
  String get currentPasswordLabel => 'Současné heslo';

  @override
  String get newPasswordLabel => 'Nové heslo';

  @override
  String get confirmPasswordLabel => 'Potvrzení hesla';

  @override
  String get emailChangedSuccess => 'E-mail úspěšně změněn';

  @override
  String get reasonLabel2 => 'Důvod';

  @override
  String get downloadFailed2 => 'Stahování selhalo';

  @override
  String get downloadTooltip => 'Stáhnout';

  @override
  String get copyLogs => 'Kopírovat logy';

  @override
  String get deleteLogs => 'Smazat logy';

  @override
  String get autoScrollOn => 'Automatické posouvání ZAP';

  @override
  String get autoScrollOff => 'Automatické posouvání VYP';

  @override
  String get unknownValue => 'Neznámé';

  @override
  String get payment => 'Platba';

  @override
  String get warningType_ermahnung => 'Napomenutí';

  @override
  String get warningType_abmahnung => 'Výstraha';

  @override
  String get warningType_letzte => 'Poslední výstraha';

  @override
  String warningsTotal(int count) {
    return 'Celkem: $count';
  }

  @override
  String warningsErmahnung(int count) {
    return 'Napomenutí: $count';
  }

  @override
  String warningsAbmahnung(int count) {
    return 'Výstrahy: $count';
  }

  @override
  String warningsLetzte(int count) {
    return 'Poslední: $count';
  }

  @override
  String get noWarnings => 'Žádná napomenutí';

  @override
  String get noWarningsDescription => 'Momentálně nemáte žádná napomenutí.';

  @override
  String createdBy(String name) {
    return 'Vytvořil: $name';
  }

  @override
  String get monthJan => 'Led';

  @override
  String get monthFeb => 'Feb';

  @override
  String get monthMar => 'Mar';

  @override
  String get monthApr => 'Dub';

  @override
  String get monthMay => 'Kve';

  @override
  String get monthJun => 'Cer';

  @override
  String get monthJul => 'Cec';

  @override
  String get monthAug => 'Srp';

  @override
  String get monthSep => 'Zar';

  @override
  String get monthOct => 'Rij';

  @override
  String get monthNov => 'Lis';

  @override
  String get monthDec => 'Pro';

  @override
  String get stufe1_name => 'Osobní údaje';

  @override
  String get stufe2_name => 'Typ členství';

  @override
  String get stufe3_name => 'Finanční situace';

  @override
  String get stufe4_name => 'Platební metoda';

  @override
  String get stufe5_name => 'Začátek členství';

  @override
  String get stufe6_name => 'Stanovy';

  @override
  String get stufe7_name => 'Zásady ochrany osobních údajů';

  @override
  String get stufe8_name => 'Právo na odstoupení';

  @override
  String get memberType_ordentlich => 'Řádný člen';

  @override
  String get memberType_foerder => 'Podporující člen';

  @override
  String get memberType_ehren => 'Čestný člen';

  @override
  String get memberDesc_ordentlich =>
      'Aktivní člen s hlasovacím právem. Účastní se služeb spolku (email, cloud, úřední podpora).';

  @override
  String get memberDesc_foerder =>
      'Podporuje spolek příspěvky. Může se účastnit valné hromady s poradním hlasem, bez hlasovacího práva nebo volitelnosti do představenstva.';

  @override
  String get memberDesc_ehren =>
      'Má práva řádného člena bez povinnosti platit členské příspěvky. Jmenován valnou hromadou nebo představenstvem.';

  @override
  String get payMethod_ueberweisung => 'Bankovní převod';

  @override
  String get payMethod_dauerauftrag => 'Trvalý příkaz';

  @override
  String get verifyStatus_geprueft => 'Ověřeno';

  @override
  String get verifyStatus_ausgefuellt => 'Vyplněno';

  @override
  String get verifyStatus_abgelehnt => 'Zamítnuto';

  @override
  String get verifyStatus_offen => 'Otevřeno';

  @override
  String get fillRequiredFields => 'Vyplňte všechna povinná pole.';

  @override
  String get personalDataSaved => 'Osobní údaje uloženy';

  @override
  String get selectMemberType => 'Vyberte typ členství.';

  @override
  String get memberTypeSaved => 'Typ členství uložen';

  @override
  String get selectOption => 'Vyberte možnost.';

  @override
  String get financialSaved => 'Finanční situace uložena';

  @override
  String get selectPaymentMethod => 'Vyberte platební metodu.';

  @override
  String get paymentDataSaved => 'Platební údaje uloženy';

  @override
  String get selectDate => 'Vyberte datum.';

  @override
  String get membershipStartSaved => 'Začátek členství uložen';

  @override
  String get fileTooLarge => 'Soubor je příliš velký (max. 10 MB).';

  @override
  String get leistungsbescheidUploaded =>
      'Rozhodnutí o dávkách úspěšně nahráno';

  @override
  String get verificationProgress => 'Průběh ověření';

  @override
  String get notApplicable => 'Nepoužitelné';

  @override
  String get socialBenefitsExempt =>
      'Platební metoda není vyžadována pro příjemce sociálních dávek.';

  @override
  String get locked => 'Zamčeno';

  @override
  String completePreviousStep(int step) {
    return 'Nejprve dokončete krok $step.';
  }

  @override
  String rejectedNote(String note) {
    return 'Zamítnuto: $note';
  }

  @override
  String get waitingForReview => 'Čeká na posouzení představenstvem.';

  @override
  String get stepApproved => 'Tento krok byl zkontrolován a schválen.';

  @override
  String get changesViaChat => 'Změny možné pouze přes chat.';

  @override
  String get firstNameRequired => 'Jméno *';

  @override
  String get lastNameRequired => 'Příjmení *';

  @override
  String get birthDateLabel => 'Datum narození *';

  @override
  String get streetRequired => 'Ulice *';

  @override
  String get houseNumberRequired => 'Č. *';

  @override
  String get cityRequired => 'Město *';

  @override
  String get phoneRequired => 'Telefonní číslo *';

  @override
  String get phonePurpose =>
      'Účel: Kontakt, když nejste dostupní přes aplikaci';

  @override
  String get selectMemberTypePrompt => 'Vyberte požadovaný typ členství:';

  @override
  String get financialExplanation =>
      'Pro ověření nároku na snížení příspěvku potřebujeme následující informace. Budou použity výhradně ke stanovení vašeho členského příspěvku.';

  @override
  String get socialBenefitsQuestion => 'Pobíráte v současnosti sociální dávky?';

  @override
  String get optionBuergergeld => 'Ano, občanský příspěvek (Job Center)';

  @override
  String get optionSozialamt => 'Ano, sociální pomoc (Sociální úřad)';

  @override
  String get optionNoBenefits => 'Ne, nepobírám sociální dávky';

  @override
  String get feeExempt => 'Váš měsíční příspěvek je: 0,00 €/měsíc';

  @override
  String get uploadLeistungsbescheid => 'Nahrát rozhodnutí o dávkách';

  @override
  String get uploadLeistungsbescheidHint =>
      'Nahrajte aktuální rozhodnutí o dávkách do 14 dnů pro potvrzení osvobození od příspěvku.';

  @override
  String get allowedFormatsUpload =>
      'Povolené formáty: PDF, JPG, PNG (max. 10 MB)';

  @override
  String get feeRegular => 'Váš měsíční příspěvek je: 25,00 €/měsíc';

  @override
  String paymentDayReminder(int day) {
    return 'Budete upozorněni $day. den každého měsíce.';
  }

  @override
  String get membershipStartPrompt => 'Zvolte, kdy má začít vaše členství.';

  @override
  String get optionAfterVerification => 'Po dokončení ověření';

  @override
  String get optionAfterVerificationDesc =>
      'Členství začíná ode dne potvrzení představenstvem.';

  @override
  String get optionRetroFoundation => 'Zpětně k datu založení (01.08.2025)';

  @override
  String get optionRetroFoundationDesc =>
      'Stanete se zpětným členem od založení spolku.';

  @override
  String get optionRetroCustom => 'Zpětně k jinému datu';

  @override
  String get optionRetroCustomDesc => 'Zvolte datum mezi 01.08.2025 a dneškem.';

  @override
  String get selectDateLabel => 'Vybrat datum';

  @override
  String get selectDateHint => 'Vyberte datum...';

  @override
  String get dateNotBefore => 'Ne dříve než 01.08.2025 (datum založení)';

  @override
  String get feeExemptRetro =>
      'Osvobození od příspěvku: 0,00 € zpětně.\nPouze datum členství je nastaveno zpětně.';

  @override
  String get retroactiveFees => 'Zpětné příspěvky';

  @override
  String retroFeeCalculation(
      String from, String to, String months, String total) {
    return 'Období: $from – $to\nMěsíce: $months\nPříspěvek: $months × 25,00 € = $total €';
  }

  @override
  String get pleaseReadSatzung => 'Přečtěte si stanovy spolku.';

  @override
  String get pleaseReadDatenschutz =>
      'Přečtěte si zásady ochrany osobních údajů.';

  @override
  String get pleaseReadWiderruf => 'Přečtěte si právo na odstoupení.';

  @override
  String get acceptedAtRegistration => 'Přijato při registraci';

  @override
  String get confirmedByBoard => 'Bude potvrzeno po posouzení představenstvem.';

  @override
  String get docSatzung => 'Stanovy';

  @override
  String get docDatenschutz => 'Zásady ochrany osobních údajů';

  @override
  String get docWiderruf => 'Právo na odstoupení';

  @override
  String acceptedAtRegCount(int count) {
    return 'Přijato při registraci ($count/3)';
  }

  @override
  String acceptedOn(String date) {
    return 'Přijato dne $date';
  }

  @override
  String get notAccepted => 'Nepřijato';

  @override
  String get statusAccepted => 'Přijato';

  @override
  String get nameTooLong => 'Jméno příliš dlouhé (max 100 znaků)';

  @override
  String get emailTooLong => 'E-mail příliš dlouhý (max 255 znaků)';

  @override
  String get legalAcknowledgePrefix => 'Seznámil/a jsem se s ';

  @override
  String get legalAcknowledgeSuffix => '.';

  @override
  String get legalStatutesSuffix => ' ICD360S e.V. a uznávám je jako závazné.';

  @override
  String get legalPleaseReadFirst => '(prosím nejprve přečtěte)';

  @override
  String get statusActive => 'Aktivní';

  @override
  String get statusSuspended => 'Pozastaveno';

  @override
  String get statusNew => 'Nový';

  @override
  String get statusCancelled => 'Zrušeno';

  @override
  String get statusDeleted => 'Smazáno';

  @override
  String get roleMitglied => 'Člen';

  @override
  String get roleVorsitzer => 'Předseda';

  @override
  String get roleStellvertreter => 'Zástupce';

  @override
  String get roleSchatzmeister => 'Pokladník';

  @override
  String get roleSchriftfuehrer => 'Tajemník';

  @override
  String get roleBeisitzer => 'Přísedící';

  @override
  String get roleKassierer => 'Pokladní';

  @override
  String get roleKassenpruefer => 'Revisor';

  @override
  String get roleEhrenamtlich => 'Dobrovolník';

  @override
  String get roleMitgliedergruender => 'Zakládající člen';

  @override
  String get roleEhrenmitglied => 'Čestný člen';

  @override
  String get roleFoerdermitglied => 'Podporující člen';

  @override
  String get memberTypeNotSet => 'Dosud nenastaveno';

  @override
  String get payMethodSepa => 'SEPA inkaso';

  @override
  String get labelStatus => 'Stav';

  @override
  String get labelMemberNumber => 'Číslo člena';

  @override
  String get labelRole => 'Role';

  @override
  String get labelMemberType => 'Typ členství';

  @override
  String get labelPaymentMethod => 'Platební metoda';

  @override
  String get labelRegisteredOn => 'Registrováno';

  @override
  String get labelLastLogin => 'Poslední přihlášení';

  @override
  String get labelMemberSince => 'Členem od';

  @override
  String get neverLoggedIn => 'Nikdy';

  @override
  String get notActivatedYet => 'Dosud neaktivováno';

  @override
  String get tabVerification => 'Ověření';

  @override
  String get tabWarnings => 'Varování';

  @override
  String get tabDocuments => 'Dokumenty';

  @override
  String get tabMembership => 'Členství';

  @override
  String get pleaseEnterFirstName => 'Zadejte jméno';

  @override
  String get pleaseEnterLastName => 'Zadejte příjmení';

  @override
  String get noFileDataReceived => 'Žádná data nebyla přijata';

  @override
  String get openFile => 'Otevřít';

  @override
  String get noMicrophoneError =>
      'Mikrofon nebyl nalezen. Připojte mikrofon a zkuste to znovu.';

  @override
  String get startConversation => 'Zahajte konverzaci!';

  @override
  String get staffWillReply => 'Pracovník vám brzy odpoví.';

  @override
  String get inCall => 'V hovoru...';

  @override
  String get registration => 'Registrace';

  @override
  String get deactivation => 'Deaktivace';

  @override
  String get deactivatedOn => 'Deaktivováno dne';

  @override
  String get accountAutoSuspend =>
      'Účty neověřené do 30 dnů budou automaticky pozastaveny.';

  @override
  String get documentsProvidedByBoard => 'Dokumenty poskytuje představenstvo.';

  @override
  String get noDocumentsAvailable => 'Žádné dokumenty';

  @override
  String get noDocumentsDescription =>
      'Zatím pro vás nebyly poskytnuty žádné dokumenty.';

  @override
  String uploadedBy(String name) {
    return 'Nahráno: $name';
  }

  @override
  String stepsCompleted(int completed, int total) {
    return '$completed/$total kroků dokončeno';
  }

  @override
  String dayOfMonth(int day) {
    return '$day. den v měsíci';
  }

  @override
  String changeField(String field) {
    return 'Změnit $field';
  }

  @override
  String openDocument(String name) {
    return 'Otevřít $name';
  }

  @override
  String logEntries(int count) {
    return '$count záznamů';
  }

  @override
  String get noLogs => 'Žádné záznamy';

  @override
  String get newLoginDetected => 'Zjištěno nové přihlášení';

  @override
  String get errorNoInternet =>
      'Žádné připojení k internetu. Zkontrolujte prosím síť.';

  @override
  String get errorTimeout => 'Server neodpovídá. Zkuste to prosím později.';

  @override
  String get errorServer => 'Chyba serveru. Zkuste to prosím později.';

  @override
  String get errorConnection => 'Chyba připojení. Zkuste to prosím později.';

  @override
  String get errorUnexpected =>
      'Došlo k neočekávané chybě. Zkuste to prosím později.';

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
  String get claudiuWelcomeMorning => 'Dobré ráno';

  @override
  String get claudiuWelcomeDay => 'Dobrý den';

  @override
  String get claudiuWelcomeEvening => 'Dobrý večer';

  @override
  String get claudiuWelcomeNight => 'Dobrý večer';

  @override
  String get claudiuWelcomeVisitor => 'milý návštěvníku';

  @override
  String get claudiuWelcomeAsk => 'Jak ti mohu pomoci?';

  @override
  String get claudiuWelcomeBecomeMember => 'Chci se stát členem';

  @override
  String get claudiuWelcomeLogin => 'Už jsem členem a chci se přihlásit';

  @override
  String get claudiuWelcomeProblem => 'Mám problém s aplikací';

  @override
  String get claudiuWelcomeEmergency => 'Naléhavé — zavolejte nám';

  @override
  String get claudiuWelcomeMascotName => 'Claudiu';

  @override
  String get claudiuWelcomeEmergencyIntro =>
      'Než zavoláš — naše pracovní hodiny:';

  @override
  String get claudiuWelcomeScheduleOffice => 'V kanceláři';

  @override
  String get claudiuWelcomeScheduleField => 'V terénu s klienty';

  @override
  String get claudiuWelcomeOutsideHoursNote =>
      'Mimo tyto hodiny řešíme pouze naléhavé případy. Můžeš nám i napsat SMS na stejné číslo — ozveme se ti.';

  @override
  String get claudiuWelcomeCallNow => 'Zavolat hned';

  @override
  String get claudiuWelcomeSendSms => 'Poslat SMS';

  @override
  String get claudiuWelcomeSmsBody =>
      'Naléhavé ICD360S e.V. — prosím, kontaktujte mě co nejdříve.';

  @override
  String get claudiuWelcomeCloseButton => 'Zavřít';

  @override
  String get claudiuLoginWelcome => 'Vítej zpět, milý člene!';

  @override
  String get claudiuLoginAsk => 'Prosím, řekni mi své členské číslo.';

  @override
  String get claudiuLoginProgress => 'Skoro… piš dál.';

  @override
  String get claudiuLoginReady => 'Perfektní! Klikni na tlačítko níže.';

  @override
  String get claudiuLoginLoading => 'Ověřuji identitu… 🔍';

  @override
  String get claudiuLoginFoundPlain => 'Našel jsem tě! Přihlašuji…';

  @override
  String claudiuLoginFoundNamed(String name) {
    return 'Našel jsem tě, $name! Přihlašuji…';
  }

  @override
  String get claudiuLoginError =>
      'Hm, to číslo nemůžu najít. Napsal jsi ho správně?';

  @override
  String get claudiuLoginForgotHeader => 'Zapomněl jsi členské číslo?';

  @override
  String get claudiuLoginNoSms => 'Číslo neposíláme e-mailem ani SMS.';

  @override
  String get claudiuLoginOnlyWay =>
      'Jediná cesta: osobní schůzka v kanceláři spolku, po ověření občanského průkazu.';

  @override
  String get claudiuLoginContactUs => 'Zavolej a domluv si termín:';

  @override
  String get claudiuDiagnosticGreeting => 'Než vstoupíš, jedna otázka';

  @override
  String get claudiuDiagnosticAsk =>
      'Mohu posílat anonymní zprávy, aby vývojáři mohli vylepšit aplikaci?';

  @override
  String get claudiuDiagnosticYes => 'Ano, rád pomohu';

  @override
  String get claudiuDiagnosticNo => 'Ne, jen se rozhlížím';

  @override
  String get claudiuDiagnosticTellMore => 'Řekni mi víc';

  @override
  String get claudiuDiagnosticSendsHeader => '📤 Co POSÍLÁME (anonymně):';

  @override
  String get claudiuDiagnosticSends1 =>
      'Anonymní kód zařízení (NE členské číslo)';

  @override
  String get claudiuDiagnosticSends2 => 'Tvoje role (člen / představenstvo)';

  @override
  String get claudiuDiagnosticSends3 =>
      'Operační systém (Linux / Android / iOS / Windows)';

  @override
  String get claudiuDiagnosticSends4 => 'Zvolený jazyk';

  @override
  String get claudiuDiagnosticSends5 => 'Stav baterie + nabití';

  @override
  String get claudiuDiagnosticSends6 => 'Aktuální obrazovka';

  @override
  String get claudiuDiagnosticSends7 => 'Délka relace (sekundy)';

  @override
  String get claudiuDiagnosticSends8 =>
      'Chyby, pokud nějaké jsou (posledních 10)';

  @override
  String get claudiuDiagnosticSends9 => 'Navigace (posledních 20 obrazovek)';

  @override
  String get claudiuDiagnosticNeverHeader => '🛡️ Co NIKDY neposíláme:';

  @override
  String get claudiuDiagnosticNever1 => 'Tvoje skutečné jméno';

  @override
  String get claudiuDiagnosticNever2 => 'E-mailová adresa';

  @override
  String get claudiuDiagnosticNever3 => 'Telefonní číslo';

  @override
  String get claudiuDiagnosticNever4 => 'Heslo';

  @override
  String get claudiuDiagnosticNever5 => 'Obsah chatových zpráv';

  @override
  String get claudiuDiagnosticNever6 => 'Obsah tiketů';

  @override
  String get claudiuDiagnosticNever7 => 'Dokumenty nebo přílohy';

  @override
  String get claudiuDiagnosticTechHeader => '📡 Technické detaily:';

  @override
  String get claudiuDiagnosticTech1 => 'Odesílá se každé 2 minuty';

  @override
  String get claudiuDiagnosticTech2 =>
      'TLS-šifrované spojení s připnutým certifikátem';

  @override
  String get claudiuDiagnosticTech3 => 'Můžeš to kdykoli vypnout v Nastavení';

  @override
  String get claudiuProblemHelpTitle => 'Jak ti mohu pomoci?';

  @override
  String get claudiuProblemHelpGreeting => 'Co se stalo?';

  @override
  String get claudiuProblemHelpAsk => 'Jak mi to chceš říct?';

  @override
  String get claudiuProblemHelpWriteTitle => 'Napsat zprávu';

  @override
  String get claudiuProblemHelpWriteBody =>
      'S podrobnostmi krok za krokem. Tým dostane text a vyřeší jej později.';

  @override
  String get claudiuProblemHelpChatTitle => 'Pojďme si promluvit';

  @override
  String get claudiuProblemHelpChatBody =>
      'Anonymní chat s operátorem. Odpověď v reálném čase, pokud je někdo online.';

  @override
  String get claudiuProblemHelpAltCallHeader => 'Nebo, pokud je to naléhavé:';

  @override
  String get claudiuProblemHelpAltCallLabel => 'Zavolat';

  @override
  String get claudiuAnonymousChatTitle => 'Anonymní chat';

  @override
  String get claudiuAnonymousChatGreeting => 'Ahoj!';

  @override
  String get claudiuAnonymousChatWelcome =>
      'Poslouchám. Napiš cokoli — jméno nepotřebuji. Odpovím, jakmile budu tady.';

  @override
  String get claudiuAnonymousChatHint => 'Napiš zprávu…';

  @override
  String get claudiuAnonymousChatWaitingOperator =>
      'Čekáme na odpověď operátora…';

  @override
  String get claudiuVorsitzerConnectedTitle => 'Ahoj!';

  @override
  String get claudiuVorsitzerConnectedBody =>
      'Díky, že ses ozval — teď jsi ve spojení s Vorsitzerem. Napiš, s čím ti můžeme pomoct ohledně přihlášky o členství.';

  @override
  String get claudiuVorsitzerConnectedSender => 'Vorsitzer';

  @override
  String get claudiuQuickReplyValidationTime => 'Jak dlouho trvá ověření?';

  @override
  String get claudiuQuickReplyDocuments => 'Jaké dokumenty potřebuji?';

  @override
  String get claudiuQuickReplyStepProblem => 'Zasekl jsem se u jednoho kroku';

  @override
  String get claudiuQuickReplyHuman => 'Můžu teď s někým mluvit?';

  @override
  String get claudiuAnonymousChatConnecting => 'Připojuji se…';

  @override
  String get claudiuAnonymousChatConnectionFailed =>
      'Nepodařilo se otevřít chat. Zkus to znovu nebo zavolej.';

  @override
  String get claudiuAnonymousChatRetry => 'Zkusit znovu';

  @override
  String get claudiuAnonymousChatOnline => 'Připojeno';

  @override
  String get claudiuAnonymousChatOffline => 'Opětovné připojení…';

  @override
  String get claudiuAnonymousChatAdminTyping => 'Operátor píše…';

  @override
  String get claudiuProblemReportTitle => 'Nahlásit problém';

  @override
  String get claudiuProblemReportGreeting => 'Co se stalo?';

  @override
  String get claudiuProblemReportAsk =>
      'Řekni mi to podrobně a já předám zprávu týmu.';

  @override
  String get claudiuProblemReportIncludeHeader => 'Prosím uveď:';

  @override
  String get claudiuProblemReportIncludeBullets1 =>
      'Co jsi dělal, když problém nastal';

  @override
  String get claudiuProblemReportIncludeBullets2 =>
      'Jaké chybové hlášení se objevilo';

  @override
  String get claudiuProblemReportIncludeBullets3 =>
      'Na které obrazovce jsi byl';

  @override
  String get claudiuProblemReportIncludeBullets4 =>
      'Aplikace padá? Zavírá se? Ukazuje bílou obrazovku?';

  @override
  String get claudiuProblemReportIncludeBullets5 =>
      'Stává se to pokaždé nebo jen jednou?';

  @override
  String get claudiuProblemReportDescriptionLabel => 'Tvůj popis';

  @override
  String get claudiuProblemReportDescriptionHint =>
      'Např.: Když otevřu chat, objeví se „Connection error\" a aplikace přestane reagovat…';

  @override
  String claudiuProblemReportTooShort(int count) {
    return 'Trochu více detailů, prosím (alespoň $count znaků)';
  }

  @override
  String get claudiuProblemReportSubmit => 'Odeslat zprávu';

  @override
  String get claudiuProblemReportSubmitting => 'Odesílá se…';

  @override
  String get claudiuProblemReportSentTitle => 'Děkuji!';

  @override
  String get claudiuProblemReportSentBody =>
      'Zpráva byla odeslána. Náš tým se na to podívá co nejdříve.';

  @override
  String get claudiuProblemReportSentClose => 'Rozumím';

  @override
  String get claudiuProblemReportSendFailed =>
      'Zprávu nelze odeslat. Zavolej nám pro naléhavou pomoc.';

  @override
  String get claudiuProblemReportAlt => 'Nebo, pokud je to naléhavé:';

  @override
  String get claudiuProblemReportCallLabel => 'Zavolat';

  @override
  String claudiuApprovalGreeting(String name) {
    return 'Ahoj, $name! 👋';
  }

  @override
  String get claudiuApprovalGreetingNoName => 'Ahoj! 👋';

  @override
  String get claudiuApprovalGladToSeeYou => 'Rád, že jsi tu!';

  @override
  String get claudiuApprovalCheckingForSafety =>
      'Pro tvou bezpečnost Vorsitzer právě kontroluje tvou žádost o přihlášení. 🛡️';

  @override
  String get claudiuApprovalMonthlyExplain =>
      '💡 Děláme to každých 30 dní, abychom se ujistili, že jsi to opravdu ty. Je to jako bezpečnostní kontrola — maximálně 5 minut.';

  @override
  String get claudiuApprovalSuccess =>
      'Hotovo! 🎉 Vorsitzer tě poznal. Přihlašuji tě…';

  @override
  String get claudiuApprovalDenied => 'Hm, Vorsitzer tvou žádost odmítl. 😔';

  @override
  String get claudiuApprovalDeniedHelp =>
      'Pokud si myslíš, že je to omyl, zavolej nám, abychom to vyřešili.';

  @override
  String get claudiuApprovalExpired =>
      '5 minut uplynulo a od Vorsitzera nepřišla žádná odpověď.';

  @override
  String get claudiuApprovalExpiredHelp =>
      'Zavolej a můžeme tvou žádost schválit přímo na místě. 📞';

  @override
  String get claudiuApprovalCallUs => 'Zavolat';

  @override
  String get claudiuApprovalTryAgain => 'Zkusit znovu';

  @override
  String get claudiuApprovalCancel => 'Zrušit';

  @override
  String get claudiuApprovalClose => 'Zavřít';

  @override
  String get wizardIntroBubble1 =>
      'Ahoj, návštěvníku! 👋 Děkuji, že se chceš stát součástí naší rodiny.';

  @override
  String get wizardIntroBubble2 =>
      'Jmenuji se Claudiu. Na jaře 2025 jsem měl jasnou vizi: vytvořit spolek, který pomáhá lidem v nouzi — dobrovolně, ze srdce, bez zbytečné byrokracie. ❤️';

  @override
  String get wizardIntroBubble3 =>
      'Začal jsem mluvit s klienty, které jsem navštěvoval. Řekl jsem jim svůj sen. A každý řekl: „Ano, do toho!\" V červenci 2025 jsme se sešli — 6 odhodlaných lidí. Rozhodli jsme se založit **ICD360S e.V.** v Neu-Ulmu. 📍';

  @override
  String get wizardIntroBubble4 =>
      '**1. srpna 2025** spolek oficiálně ožil — ve spolkovém rejstříku. Můj nejkrásnější dárek. 🎂';

  @override
  String get wizardIntroBubble5 =>
      'Co děláme? Pomáháme uprchlíkům, lidem se zdravotním postižením, ekonomicky znevýhodněným, **dětem a mladým lidem** — s administrativními záležitostmi, němčinou, bydlením, nakupováním, sociálními dávkami. Náš Vorstand tvoří většinou lidé s postižením — rozhodnutí tak vycházejí z reálné zkušenosti. 🤝';

  @override
  String get wizardIntroBubble6 =>
      'Teď jsi na řadě ty. Pojďme tě zaregistrovat — trvá to asi 5 minut. Půjdeme krok za krokem, nenechám tě v tom samotného. ✨';

  @override
  String get wizardIntroStart => 'Začněme';

  @override
  String get wizardBack => 'Zpět';

  @override
  String get wizardNext => 'Dále';

  @override
  String wizardStepLabel(int step, int total, String title) {
    return 'Krok $step z $total · $title';
  }

  @override
  String get wizardErrRequired => 'Toto pole je povinné';

  @override
  String wizardErrTooShort(int count) {
    return 'Příliš krátké (alespoň $count znaků)';
  }

  @override
  String get wizardErrOnlyLetters =>
      'Pouze písmena, mezery, pomlčky a apostrofy';

  @override
  String get wizardErrSaveFailed =>
      'Uložení selhalo. Zkontroluj připojení a zkus to znovu.';

  @override
  String get wizardStufe1aTitle => 'Identita';

  @override
  String get wizardStufe1aPrompt =>
      'Pojďme se oficiálně seznámit. Napiš své jméno přesně tak, jak je na Personalausweis, Reisepass nebo Aufenthaltstitel — ať to sedí s doklady.';

  @override
  String get wizardStufe1aVornameLabel => 'Vornamen (křestní jména)';

  @override
  String get wizardStufe1aVornameHelper =>
      'Všechna tvá křestní jména přesně jako na dokladu. S mezerou nebo pomlčkou (např. Hans-Peter, Maria Anna).';

  @override
  String get wizardStufe1aNachnameLabel => 'Familienname (příjmení)';

  @override
  String get wizardStufe1aNachnameHelper => 'Tvé aktuální příjmení.';

  @override
  String get wizardStufe1aGeburtsnameLabel =>
      'Geburtsname (rodné příjmení) — volitelné';

  @override
  String get wizardStufe1aGeburtsnameHelper =>
      'Pouze pokud se liší od Familienname — např. před svatbou.';

  @override
  String get wizardStufe1bTitle => 'Datum narození';

  @override
  String get wizardStufe1bPrompt =>
      'Rádi bychom s tebou oslavili tvé narozeniny! 🎂 A pomáhá nám to ověřit, že máš aspoň 16 — tak to říká naše stanova.';

  @override
  String get wizardStufe1bGeburtsdatumLabel => 'Datum narození';

  @override
  String get wizardStufe1bGeburtsdatumHelper => 'Klepnutím vyber datum';

  @override
  String get wizardStufe1bGeburtsortLabel => 'Místo narození';

  @override
  String get wizardStufe1bGeburtsortHelper => 'Město / místo, kde ses narodil.';

  @override
  String get wizardAgeGatePrompt => 'Je mi líto… 😔';

  @override
  String wizardAgeGateBody1(int age, int years) {
    return 'Naše stanovy říkají, že musíš mít alespoň 16 let, abys mohl být členem. Je ti $age — doufám, že se vidíme za $years let! 🌱';
  }

  @override
  String get wizardAgeGateBody2 =>
      'Pokud chceš příležitostně pomáhat jako dobrovolník (jakýkoli věk, se souhlasem rodičů), zavolej nám — rádi podporujeme mladé lidi, kteří chtějí měnit svět.';

  @override
  String get wizardAgeGateBackHome => 'Zpět na úvod';

  @override
  String get wizardErrInvalidPhone => 'Neplatné telefonní číslo';

  @override
  String get wizardStufe1b1Title => 'Souhlas rodiče';

  @override
  String get wizardStufe1b1Prompt =>
      'Jsi nezletilý (16-17) — podle §106 BGB potřebujeme souhlas rodiče nebo zákonného zástupce. Řekni mi jméno a telefonní číslo. Vorsitzer zavolá a domluví schůzku (osobně nebo videohovorem). Žádný e-mail — chceme mít jistotu, že mluvíme se správnou osobou.';

  @override
  String get wizardStufe1b1VornameLabel => 'Jméno rodiče';

  @override
  String get wizardStufe1b1VornameHelper => 'Jak je v Personalausweis rodiče.';

  @override
  String get wizardStufe1b1NachnameLabel => 'Příjmení rodiče';

  @override
  String get wizardStufe1b1NachnameHelper => 'Jak je v Personalausweis rodiče.';

  @override
  String get wizardStufe1b1TelefonLabel => 'Mobil rodiča';

  @override
  String get wizardStufe1b1TelefonHelper => 'Na toto číslo zavolá Vorsitzer.';

  @override
  String get wizardStufe1b1RelationLabel => 'Vztah k dítěti:';

  @override
  String get wizardStufe1b1RelationMutter => 'Matka';

  @override
  String get wizardStufe1b1RelationVater => 'Otec';

  @override
  String get wizardStufe1b1RelationSorgeberechtigter => 'Zákonný zástupce';

  @override
  String get wizardStufe1b1RelationAndere => 'Jiný zástupce';

  @override
  String get wizardStufe1cTitle => 'Osobní údaje';

  @override
  String get wizardStufe1cPrompt =>
      'Jen abych tě trochu lépe poznal. Tyto údaje zůstanou mezi námi a nikde se veřejně nezobrazí.';

  @override
  String get wizardStufe1cGeschlechtLabel => 'Pohlaví';

  @override
  String get wizardStufe1cGeschlechtMaennlich => 'Muž';

  @override
  String get wizardStufe1cGeschlechtWeiblich => 'Žena';

  @override
  String get wizardStufe1cGeschlechtDivers => 'Jiné';

  @override
  String get wizardStufe1cGeschlechtKeineAngabe => 'Neuvedeno';

  @override
  String get wizardStufe1cFamilienstandLabel => 'Rodinný stav';

  @override
  String get wizardStufe1cFamilienstandLedig => 'Svobodný/á';

  @override
  String get wizardStufe1cFamilienstandVerheiratet => 'Ženatý / Vdaná';

  @override
  String get wizardStufe1cFamilienstandGeschieden => 'Rozvedený/á';

  @override
  String get wizardStufe1cFamilienstandVerwitwet => 'Ovdovělý/á';

  @override
  String get wizardStufe1dTitle => 'Tvůj původ';

  @override
  String get wizardStufe1dPrompt =>
      'Pomáhá nám to nabídnout ti tu pravou pomoc — například poradenství k pobytu (Aufenthalt) nebo najít tvou jazykovou komunitu.';

  @override
  String get wizardStufe1dStaatLabel => 'Státní občanství';

  @override
  String get wizardStufe1dStaatHelper =>
      'Např. deutsch, rumänisch, ukrainisch. Více oddělit čárkou.';

  @override
  String get wizardStufe1dAufenthaltLabel =>
      'Status pobytu (Aufenthaltsstatus) — volitelné';

  @override
  String get wizardStufe1dAufenthaltHelper =>
      'Vyber titul ze svojí Aufenthaltskarte / rozhodnutí. Vorstand to porovná s tvými dokumenty.';

  @override
  String get wizardStufe1dAufenthaltAwaitingCitizenship =>
      'Nejdřív vyplň státní příslušnost výše — zobrazíme jen vhodné možnosti.';

  @override
  String get wizardStufe1dAufenthaltGerman =>
      'Aufenthaltstitel není potřeba — německý občan.';

  @override
  String get wizardStufe1dAufenthaltEuEea =>
      'Občan EU/EHP/CH — volný pohyb (Freizügigkeit).';

  @override
  String get wizardStufe1dAufenthaltTempHint => 'dočasný';

  @override
  String get wizardStufe1dAufenthaltPermHint => 'trvalý pobyt';

  @override
  String get wizardStufe1dAufenthaltAsylumProcessHint => 'azylové řízení';

  @override
  String get wizardStufe1dAufenthaltOther => 'Jiné (upřesni v chatu)';

  @override
  String get wizardStufe1dAufenthaltRequired =>
      'Vyber prosím Aufenthaltstitel.';

  @override
  String get wizardStufe1dMutterspracheLabel => 'Mateřský jazyk';

  @override
  String get wizardStufe1dMutterspracheHelper =>
      'Předvyplněno jazykem aplikace — změň pokud se liší.';

  @override
  String get wizardStufe1eTitle => 'Adresa';

  @override
  String get wizardStufe1ePrompt =>
      'Tvá poštovní adresa — používáme ji pro oficiální dokumenty (stanovy, členské smlouvy, oznámení).';

  @override
  String get wizardStufe1eStrasseLabel => 'Ulice';

  @override
  String get wizardStufe1eStrasseHelper =>
      'Jen název ulice — číslo do vedlejšího pole.';

  @override
  String get wizardStufe1eHausnummerLabel => 'Č.';

  @override
  String get wizardStufe1ePlzLabel => 'PLZ (PSČ)';

  @override
  String get wizardStufe1eOrtLabel => 'Město';

  @override
  String get wizardStufe1eLandLabel => 'Země';

  @override
  String get wizardStufe1eLandHelper => 'Předvyplněno: Deutschland.';

  @override
  String get wizardErrInvalidStreet => 'Neplatný název ulice';

  @override
  String get wizardErrInvalidHausnummer =>
      'Neplatné číslo (např. 12, 12a, 12/3)';

  @override
  String get wizardErrInvalidPlz => 'Neplatné PSČ (jen číslice)';

  @override
  String get wizardStufe1fTitle => 'Kontakt';

  @override
  String get wizardStufe1fPrompt =>
      'Jak tě zastihneme? Telefon je jen pro naléhavé případy — všechno ostatní jde přes náš vlastní E2E šifrovaný kanál v aplikaci. Tvůj členský e-mail se přiřazuje automaticky a uvidíš ho níže.';

  @override
  String get wizardStufe1fTelefonLabel => 'Mobilní číslo';

  @override
  String get wizardStufe1fTelefonHelper =>
      'Slib — zavolám jen když to bude opravdu důležité. 📱';

  @override
  String get wizardStufe2Title => 'Typ členství';

  @override
  String get wizardStufe2Prompt =>
      'Jakým typem člena chceš být? Vysvětlím ti každou možnost.';

  @override
  String get wizardStufe2OrdentlichTitle => 'Řádný člen (ordentlich)';

  @override
  String get wizardStufe2OrdentlichBody =>
      'Plná práva. Platíš měsíční příspěvek, hlasuješ na členské schůzi, můžeš být zvolen do představenstva. Výchozí volba.';

  @override
  String get wizardStufe2FoerderTitle => 'Podporující člen (Fördermitglied)';

  @override
  String get wizardStufe2FoerderBody =>
      'Podporuješ spolek finančně, ale neúčastníš se aktivně rozhodování. Bez hlasovacího práva. Hodí se, pokud chceš pomáhat na dálku.';

  @override
  String get wizardStufe2EhrenTitle => 'Čestný člen (Ehrenmitglied)';

  @override
  String get wizardStufe2EhrenBody =>
      'Udělován představenstvem za zvláštní zásluhy. Nevybíráš si ho sám — uděluje se jako uznání. Zvol jen pokud ti už byla tato pocta udělena.';

  @override
  String get wizardStufe3Title => 'Finanční situace';

  @override
  String get wizardStufe3Prompt =>
      'Teď k tvé finanční situaci. Ne abych soudil — ale abychom tě osvobodili od příspěvku, pokud pobíráš sociální dávky.';

  @override
  String get wizardStufe3OptionBuergergeld => 'Pobírám Bürgergeld';

  @override
  String get wizardStufe3OptionSozialamt => 'Dostávám dávky od Sozialamtu';

  @override
  String get wizardStufe3OptionNein => 'Nepobírám žádné z těchto';

  @override
  String get wizardStufe3FeeExemptTitle => 'Příspěvek: 0 € / měsíc 🎉';

  @override
  String get wizardStufe3FeeExemptBody =>
      'S Bürgergeldem, Sozialamtem, ALG I nebo Krankengeldem jsi podle Satzung §6 plně osvobozen od příspěvku. Potřebujeme jen doklad (Leistungsbescheid nebo potvrzení od úřadu / zdravotní pojišťovny).';

  @override
  String get wizardStufe3UploadTitle => 'Nahrát Leistungsbescheid';

  @override
  String get wizardStufe3UploadHint => 'PDF / JPG / PNG, max 10 MB.';

  @override
  String get wizardStufe3UploadRequired =>
      'Před pokračováním prosím nahraj Leistungsbescheid.';

  @override
  String get wizardStufe3FileTooLarge =>
      'Soubor je příliš velký. Maximálně 10 MB.';

  @override
  String get wizardStufe3UploadFailed =>
      'Soubor se nepodařilo nahrát. Zkus to znovu.';

  @override
  String get wizardStufe3RegularFeeTitle => 'Příspěvek: 25 € / měsíc';

  @override
  String get wizardStufe3RegularFeeBody =>
      'Standardní příspěvek pro řádné členy podle stanov.';

  @override
  String get wizardStufe4Title => 'Platba';

  @override
  String get wizardStufe4Prompt =>
      'Jak chceš platit příspěvek? A který den v měsíci ti vyhovuje?';

  @override
  String get wizardStufe4MethodUeberweisungTitle =>
      'Bankovní převod (Überweisung)';

  @override
  String get wizardStufe4MethodUeberweisungBody =>
      'Platbu zadáváš sám každý měsíc ze svého účtu.';

  @override
  String get wizardStufe4MethodSepaTitle => 'SEPA-Lastschrift (přímé inkaso)';

  @override
  String get wizardStufe4MethodSepaBody =>
      'Strhneme částku automaticky z tvého účtu. Nejpohodlnější, ale potřebujeme IBAN a podepsané SEPA pověření.';

  @override
  String get wizardStufe4MethodDauerauftragTitle =>
      'Dauerauftrag (trvalý příkaz)';

  @override
  String get wizardStufe4MethodDauerauftragBody =>
      'Nastavíš si trvalý příkaz ve své bance. Banka pak posílá částku automaticky každý měsíc.';

  @override
  String get wizardStufe4DayLabel => 'Den platby';

  @override
  String get wizardStufe4DayHint => 'Vyber den mezi 1 a 31';

  @override
  String wizardStufe4DayItem(int day) {
    return '$day. den';
  }

  @override
  String wizardStufe4DayReminder(int day) {
    return 'Příspěvek se bude strhávat $day. den každého měsíce.';
  }

  @override
  String get wizardStufe5Title => 'Začátek';

  @override
  String get wizardStufe5Prompt =>
      'Od kdy chceš být oficiálně členem ICD360S? Od schválení nebo zpětně.';

  @override
  String get wizardStufe5OptionAbVerifizierungTitle =>
      'Od schválení představenstvem';

  @override
  String get wizardStufe5OptionAbVerifizierungBody =>
      'Nejjednodušší volba. Žádný zpětný příspěvek.';

  @override
  String get wizardStufe5OptionGruendungsdatumTitle =>
      'Zpětně od 01.08.2025 (datum založení)';

  @override
  String get wizardStufe5OptionGruendungsdatumBody =>
      'Budeš se počítat za člena od prvního dne spolku.';

  @override
  String get wizardStufe5OptionAnderesDatumTitle => 'Jiné datum';

  @override
  String get wizardStufe5OptionAnderesDatumBody =>
      'Vybíráš si datum mezi 01.08.2025 a dneškem.';

  @override
  String get wizardStufe5PickDate => 'Klepnutím vyber datum';

  @override
  String get wizardStufe5PickDateFirst => 'Nejprve vyber datum.';

  @override
  String get wizardStufe5DatePickerHelp => 'Začátek členství';

  @override
  String wizardStufe5DateRange(String start) {
    return 'Mezi $start a dneškem';
  }

  @override
  String get wizardStufe5RetroactiveTitle => 'Zpětný příspěvek';

  @override
  String wizardStufe5RetroactiveBody(
      String start, String end, int months, String amount) {
    return 'Od $start do $end je to $months měsíců. Při 25 €/měsíc to znamená $amount € zpětně k uhrazení, navíc k aktuálnímu měsíčnímu příspěvku.';
  }

  @override
  String get wizardStufe5FeeExemptTitle => 'Zpětný příspěvek: 0 € 🎉';

  @override
  String get wizardStufe5FeeExemptBody =>
      'S Bürgergeld nebo Sozialamtem jsi plně osvobozen — i zpětně nic nedlužíš.';

  @override
  String wizardDocumentPrompt(String doc) {
    return 'Než to uzavřeme, prosím pečlivě si přečti $doc. Je důležité vědět, co podepisuješ.';
  }

  @override
  String get wizardDocumentScrollHint =>
      'Posuň na konec, abys mohl pokračovat.';

  @override
  String get wizardDocumentScrolledOk => 'Přečetl jsi až do konce ✓';

  @override
  String wizardDocumentOpenButton(String doc) {
    return 'Otevřít $doc v prohlížeči';
  }

  @override
  String get wizardDocumentExternalHint =>
      'Na této platformě otevíráme dokument ve výchozím prohlížeči.';

  @override
  String get wizardDocumentOpenedOk =>
      'Dokument byl otevřen. Pečlivě si jej přečti.';

  @override
  String wizardDocumentConfirm(String doc) {
    return 'Potvrzuji, že jsem si přečetl(a) $doc a souhlasím s ní.';
  }

  @override
  String get wizardFinalAdultTitle => 'Hotovo! Jsi přihlášen 🎉';

  @override
  String get wizardFinalMinorTitle => 'Tvá žádost byla odeslána 📨';

  @override
  String get wizardFinalMinorBody =>
      'Spojíme se s tvým rodičem a domluvíme schůzku (osobně nebo videohovorem). Prosíme o trpělivost — proces může trvat až 7 dní. Dostaneš upozornění v aplikaci, jakmile rodič schválí.';

  @override
  String get wizardFinalMitgliedernummerLabel => 'Tvé členské číslo';

  @override
  String get wizardStufe4MethodComingSoon => 'Již brzy';

  @override
  String get wizardStufe4StreichungWarning =>
      'Pokud zaostaneš s příspěvkem o více než 6 měsíců, automaticky tě vyškrtneme (Satzung §6 Abs. 3).';

  @override
  String get wizardStufe5KuendigungInfo =>
      'K odchodu: pošli nám výpověď písemně 3 měsíce před 31. prosincem (do 30. září, aby byla účinná na konci roku). Žádná minimální doba (Satzung §6 Abs. 3).';

  @override
  String get wizardStufe1fEmailLabel => 'Tvůj členský e-mail';

  @override
  String get wizardStufe1fEmailHelper =>
      'Přiřazuje se automaticky podle tvého členského čísla. Aktivuje se ve chvíli, kdy představenstvo (Vorstand) schválí tvou přihlášku. Máme vlastní e-mailovou aplikaci — posílej a přijímej šifrované e-maily, jednoduše a zdarma.';

  @override
  String get wizardErrInvalidEmail => 'Neplatná e-mailová adresa';

  @override
  String get wizardStufe3OptionAlg1 =>
      'Pobírám Arbeitslosengeld I (ALG I, podpora v nezaměstnanosti)';

  @override
  String get wizardStufe3OptionKrankengeld =>
      'Pobírám Krankengeld (nemocenské po dlouhodobé pracovní neschopnosti)';

  @override
  String get wizardStufe3UploadAddMore => 'Přidat další dokument';

  @override
  String get wizardStufe3UploadLimitCount =>
      'Dosažen limit: nejvýše 20 dokumentů.';

  @override
  String get wizardStufe3UploadLimitTotal =>
      'Dosažen celkový limit 100 MB. Smaž některý existující soubor.';

  @override
  String get wizardStufe3UploadDeleteTooltip => 'Smazat';

  @override
  String wizardStufe3UploadCounter(int count, int max) {
    return '$count / $max dokumentů';
  }

  @override
  String get wizardDocumentExternalOpenFailed =>
      'Nepodařilo se otevřít prohlížeč. Odkaz byl zkopírován do schránky — vlož ho do prohlížeče, abys pokračoval.';

  @override
  String get wizardFinalTimelineProcessing =>
      'Vorstand kontroluje · obvykle 1 pracovní den, max. 7';

  @override
  String get wizardFinalTimelineActivated => 'Účet aktivován';

  @override
  String get wizardFinalAdultThank =>
      'Děkujeme, že jsi vyplnil registrační formulář! 🎉';

  @override
  String get wizardFinalAdultUsual =>
      'Tvoje žádost je u nás. Obvykle ji ověřujeme do jednoho pracovního dne.';

  @override
  String get wizardFinalAdultExceptional =>
      'Občas to může trvat až 7 pracovních dnů. A pokud něco nesedí, pošleme tě zpátky do formuláře, abys to opravil 🙂';

  @override
  String get wizardFinalStatusTitle => 'STAV ŽÁDOSTI';

  @override
  String wizardFinalStatusStepsValidated(int reviewed, int total) {
    return '$reviewed/$total kroků ověřeno představenstvem Vorstand';
  }

  @override
  String get wizardFinalStufeSheetTitle => 'Detaily žádosti';

  @override
  String get wizardFinalStufeSheetHint =>
      'Osm fází, které jsi vyplnil. Vorstand je kontroluje jednu po druhé — vidíš v reálném čase, co už bylo schváleno.';

  @override
  String get wizardFinalStufeStatusPending => 'Čeká na kontrolu';

  @override
  String get wizardFinalStufeStatusApproved => 'Schváleno';

  @override
  String get wizardFinalStufeStatusRejected => 'Zamítnuto';

  @override
  String wizardFinalStatusRejectionCount(int count) {
    return '$count krok vyžaduje opravu';
  }

  @override
  String get wizardFinalStufeRejectionReason => 'Důvod od Vorstandu:';

  @override
  String get wizardFinalStufeCorrectNow => 'Opravit nyní';

  @override
  String wizardFinalApprovalsHeader(int current, int total) {
    return 'Schválení Vorstandu ($current/$total)';
  }

  @override
  String get wizardFinalApprovalAwaiting => 'Čeká se na 2. Vorstand';

  @override
  String get wizardFinalApprovalRejected => 'ZAMÍTNUTO';

  @override
  String get wizardFinalStufeNoDataYet => 'Data zatím nejsou k dispozici.';

  @override
  String get wizardFinalStufeReadAt => 'Přečteno:';

  @override
  String get wizardFinalStufeBeitragsfrei =>
      'Osvobozeno od příspěvku (bez platby)';

  @override
  String get wizardFinalStufeNotExempt => 'Bez sociálních dávek';

  @override
  String get wizardFinalStufeBeginAtVerification => 'Začíná ověřením';

  @override
  String get wizardFinalStufeBeginAtFoundation => 'Datum založení (zpětně)';

  @override
  String get wizardFinalStufeBeginAtCustom => 'Vlastní datum';

  @override
  String get wizardFinalStufeStatusSkipped => 'Přeskočeno';

  @override
  String get wizardFinalStufeFilledAt => 'Vyplněno:';

  @override
  String get wizardFinalStufeReviewedAt => 'Zkontrolováno:';

  @override
  String get wizardFinalWithdrawLink => 'Zrušit žádost';

  @override
  String get wizardFinalWithdrawDialogTitle => 'Zrušit žádost?';

  @override
  String get wizardFinalWithdrawDialogBody =>
      'Tvoje žádost bude označena jako zrušena tebou. Data zůstanou v databázi pro audit (GDPR), ale účet nebude aktivován. Registraci můžeš kdykoli zopakovat s novým členským číslem.';

  @override
  String get wizardFinalWithdrawKeep => 'Ne, počkám';

  @override
  String get wizardFinalWithdrawConfirm => 'Ano, zrušit';

  @override
  String get wizardErrTooManyWithdrawals =>
      'Tvoji žádost nelze zpracovat automaticky. Zavolej nám nebo přijď osobně k Vorstandu, abys mohl pokračovat v registraci.';

  @override
  String get wizardDuplicateLoginTitle => 'Vypadá to, že už jsi naším členem';

  @override
  String get wizardDuplicateLoginBody =>
      'Podle tvého jména a data narození už nacházíme aktivní účet. Použij prosím \"Jsem už člen\" na úvodní obrazovce, aby ses přihlásil. Pokud nemáš přístup, zavolej nám.';

  @override
  String get wizardDuplicatePendingTitle => 'Tvoje žádost je už u nás';

  @override
  String get wizardDuplicatePendingBody =>
      'Podle tvého jména a data narození máme už žádost v posuzování. Vorstand na ní pracuje — pošleme ti oznámení v aplikaci, jakmile bude tvůj účet aktivní. Zavolej, pokud si chceš popovídat.';

  @override
  String get wizardDuplicateRecentlyWithdrawnTitle =>
      'Tuto žádost teď nemůžeme zpracovat';

  @override
  String get wizardDuplicateRecentlyWithdrawnBody =>
      'Tvoje jméno a datum narození odpovídají nedávno zrušené žádosti. Zavolej nám, ať si o tom promluvíš s Vorstandem, než budeš pokračovat.';

  @override
  String get wizardDuplicatePreviouslyWithdrawnTitle =>
      'Už jsi jednou žádost podal';

  @override
  String get wizardDuplicatePreviouslyWithdrawnBody =>
      'Tvoje jméno a datum narození odpovídají starší žádosti, kterou jsi zrušil. Vítej zpátky — zavolej nám, než budeš pokračovat, ať Vorstand rozhodne, jak dál.';

  @override
  String get wizardDuplicateCallUsTitle => 'Prosím, zavolej nám';

  @override
  String get wizardDuplicateCallUsBody =>
      'Tvoje jméno a datum narození u nás už figurují, ale podrobnosti přes aplikaci sdělit nemůžeme. Zavolej nám — Vorstand ti situaci vysvětlí osobně.';

  @override
  String get wizardChatHelp => 'Promluvíme si';

  @override
  String get wizardChatHelpSubtitle =>
      'Živý chat s Vorstandem · rychlá odpověď';

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
}
