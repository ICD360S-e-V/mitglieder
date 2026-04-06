// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Czech (`cs`).
class AppLocalizationsCs extends AppLocalizations {
  AppLocalizationsCs([String locale = 'cs']) : super(locale);

  @override
  String get appTitle => 'ICD360S e.V - Portál členů';

  @override
  String get memberPortal => 'Portál členů';

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
  String get password => 'Heslo';

  @override
  String get passwordHint => 'Zadejte heslo';

  @override
  String get confirmPassword => 'Potvrďte heslo';

  @override
  String get confirmPasswordHint => 'Potvrďte heslo';

  @override
  String get newPassword => 'Nové heslo';

  @override
  String get newPasswordHint => 'Zadejte nové heslo';

  @override
  String get saveCredentials => 'Uložit přihlašovací údaje';

  @override
  String get autoLogin => 'Automatické přihlášení';

  @override
  String get forgotPassword => 'Zapomněli jste heslo?';

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
  String get recoveryCode => 'Kód pro obnovení (6 číslic)';

  @override
  String get recoveryCodeHelper =>
      'Zapamatujte si tento kód pro obnovení hesla';

  @override
  String get recoveryCodeHint => 'Zadejte kód pro obnovení';

  @override
  String get recoveryCodeInvalid => 'Kód musí mít přesně 6 číslic';

  @override
  String get loginFailed => 'Přihlášení se nezdařilo';

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
  String get tooManyDevices => 'Příliš mnoho zařízení';

  @override
  String get maxDevicesMessage =>
      'Jste již přihlášeni na 3 zařízeních.\nVyberte zařízení k odhlášení:';

  @override
  String get unknownDevice => 'Neznámé zařízení';

  @override
  String get unknown => 'Neznámé';

  @override
  String get logoutError => 'Chyba při odhlášení';

  @override
  String error(String error) {
    return 'Chyba: $error';
  }

  @override
  String get cancel => 'Zrušit';

  @override
  String get resetPassword => 'Obnovit heslo';

  @override
  String get forgotPasswordTitle => 'Zapomenuté heslo';

  @override
  String get forgotPasswordDescription =>
      'Zadejte číslo člena a kód pro obnovení vytvořený při registraci.';

  @override
  String get passwordResetSuccess =>
      'Heslo bylo úspěšně obnoveno!\n\nNyní se můžete přihlásit novým heslem.';

  @override
  String get passwordResetFailed => 'Obnovení hesla se nezdařilo';

  @override
  String get needHelp => 'Potřebujete pomoc?';

  @override
  String get helpQuestion => 'Problémy s přihlášením nebo registrací?';

  @override
  String get helpDescription =>
      'Kontaktujte nás přes WhatsApp a popište přesně, co nefunguje. Odpovíme co nejdříve!';

  @override
  String get whatsapp => 'WhatsApp';

  @override
  String get emailSubject => 'Dotaz přes aplikaci ICD360S';

  @override
  String get whatsappMessage => 'Dobrý den, mám problém s aplikací ICD360S. ';

  @override
  String get imprint => 'Impressum';

  @override
  String get privacy => 'Ochrana osobních údajů';

  @override
  String get statutes => 'Stanovy';

  @override
  String get revocation => 'Právo na odstoupení';

  @override
  String get cancellation => 'Zrušení';

  @override
  String get allRightsReserved => 'Všechna práva vyhrazena.';

  @override
  String get enterCredentials => 'Zadejte číslo člena a heslo';

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
  String get membership => 'Členství';

  @override
  String get myAppointments => 'Moje schůzky';

  @override
  String get appointmentsLoadingReady => 'Načítání schůzek - API připraveno!';

  @override
  String get priority => 'Priorita';

  @override
  String get messageLabel => 'Zpráva';

  @override
  String get createdOn => 'Vytvořeno';

  @override
  String get handler => 'Správce';

  @override
  String get reportProblems => 'Nahlásit problémy';

  @override
  String get reportProblem => 'Nahlásit problém';

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
  String get newTicket => 'Nový tiket';

  @override
  String get noOpenTickets => 'Žádné otevřené tikety';

  @override
  String get haveQuestionCreateTicket =>
      'Máte otázku nebo problém?\nVytvořte nový tiket.';

  @override
  String get whatIsTheProblem => 'Jaký je problém?';

  @override
  String get describeTheProblem => 'Popište problém';

  @override
  String get howUrgentIsIt => 'Jak naléhavé?';

  @override
  String get low => 'Nízká';

  @override
  String get medium => 'Střední';

  @override
  String get high => 'Vysoká';

  @override
  String get submit => 'Odeslat';

  @override
  String get fillSubjectAndMessage => 'Vyplňte předmět a zprávu';

  @override
  String get ticketCreated => 'Tiket vytvořen';

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
  String get newEmailAddress => 'Nová emailová adresa';

  @override
  String get currentPassword => 'Aktuální heslo';

  @override
  String get saveEmail => 'Uložit email';

  @override
  String get savePassword => 'Uložit heslo';

  @override
  String get deviceLoggedOut => 'Zařízení odhlášeno';

  @override
  String get passwordChangedSuccessfully => 'Heslo úspěšně změněno';

  @override
  String get emailChangedSuccessfully => 'Email úspěšně změněn';

  @override
  String get errorChangingPassword => 'Chyba při změně hesla';

  @override
  String get errorChangingEmail => 'Chyba při změně emailu';

  @override
  String get validEmailRequired => 'Zadejte platnou emailovou adresu';

  @override
  String get passwordTooShort => 'Heslo musí mít alespoň 6 znaků';

  @override
  String get maxDevicesReached =>
      'Jste přihlášeni na maximálním počtu 3 zařízení.';

  @override
  String loggedInOnDevices(int count) {
    return 'Jste přihlášeni na $count ze 3 zařízení.';
  }

  @override
  String get noActiveSessions => 'Žádné aktivní relace';

  @override
  String get logoutFromDevice => 'Odhlásit z tohoto zařízení';

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
  String get errorAcceptingCall => 'Chyba při přijímání hovoru';

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
  String typingIndicator(String name) {
    return '$name píše...';
  }

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
  String get diagnosticDataTitle => 'Diagnostická data';

  @override
  String get diagnosticDescription =>
      'Chcete odesílat anonymní diagnostická data pro zlepšení aplikace?';

  @override
  String get noThanks => 'Ne, děkuji';

  @override
  String get yesEnable => 'Ano, povolit';

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
  String get newPasswordMinChars => 'Nové heslo (min. 6 znaků)';

  @override
  String get reasonLabel2 => 'Důvod';

  @override
  String get downloadFailed2 => 'Stahování selhalo';

  @override
  String get downloadTooltip => 'Stáhnout';

  @override
  String get connectionErrorGeneric => 'Chyba připojení';

  @override
  String get errorNoInternet => 'Žádné připojení k internetu. Zkontrolujte prosím síť.';

  @override
  String get errorTimeout => 'Server neodpovídá. Zkuste to prosím později.';

  @override
  String get errorServer => 'Chyba serveru. Zkuste to prosím později.';

  @override
  String get errorConnection => 'Chyba připojení. Zkuste to prosím později.';

  @override
  String get errorUnexpected => 'Došlo k neočekávané chybě. Zkuste to prosím později.';

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
  String get bankTransfer => 'Bankovní převod';

  @override
  String get standingOrder => 'Trvalý příkaz';

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
  String get memberNumberTooLong => 'Číslo člena příliš dlouhé (max 20 znaků)';

  @override
  String get onlyUppercaseAndNumbers =>
      'Povolena jsou pouze velká písmena a čísla';

  @override
  String get passwordTooLong => 'Heslo příliš dlouhé (max 100 znaků)';

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
  String get diagnosticErrors => 'Hlášení chyb pro vylepšení';

  @override
  String get diagnosticAnonymousStats => 'Anonymní statistiky použití';

  @override
  String get diagnosticPerformance => 'Údaje o výkonu aplikace';

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
  String get ipClean => 'IP čistá - neuvedena';

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
  String get helpImproveApp => 'Chcete nám pomoci vylepšit aplikaci?';

  @override
  String get noPersonalDataCollected =>
      'Žádné osobní údaje nejsou shromažďovány. Toto nastavení lze kdykoli změnit.';

  @override
  String logEntries(int count) {
    return '$count záznamů';
  }

  @override
  String get noLogs => 'Žádné záznamy';

  @override
  String get newLoginDetected => 'Zjištěno nové přihlášení';

  @override
  String get waitingForMember => 'Čekání na člena';

  @override
  String get waitingForStaff => 'Čekání na pracovníka';

  @override
  String get waitingForAuthority => 'Čekání na úřad';
}
