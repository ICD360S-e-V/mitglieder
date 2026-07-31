// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Polish (`pl`).
class AppLocalizationsPl extends AppLocalizations {
  AppLocalizationsPl([String locale = 'pl']) : super(locale);

  @override
  String get welcomeLoading => 'Ładowanie...';

  @override
  String get welcomeAutoLogin => 'Automatyczne logowanie...';

  @override
  String get login => 'Zaloguj się';

  @override
  String get register => 'Zarejestruj się';

  @override
  String get becomeMember => 'Zostań Członkiem';

  @override
  String get memberNumber => 'Numer Członka';

  @override
  String get memberNumberHint => 'Wprowadź numer członka';

  @override
  String get confirmPassword => 'Potwierdź Hasło';

  @override
  String get confirmPasswordHint => 'Potwierdź hasło';

  @override
  String get newPassword => 'Nowe Hasło';

  @override
  String get newPasswordHint => 'Wprowadź nowe hasło';

  @override
  String get firstName => 'Imię i Nazwisko';

  @override
  String get firstNameHint => 'Wprowadź imię i nazwisko';

  @override
  String get nameMinLength => 'Imię musi mieć co najmniej 2 znaki';

  @override
  String get nameOnlyLetters => 'Dozwolone tylko litery i myślniki';

  @override
  String get email => 'Adres Email';

  @override
  String get emailHint => 'Wprowadź email';

  @override
  String get emailInvalid => 'Wprowadź prawidłowy email';

  @override
  String get passwordMinLength => 'Hasło musi mieć co najmniej 6 znaków';

  @override
  String get passwordsNotMatch => 'Hasła nie są zgodne';

  @override
  String get registrationFailed => 'Rejestracja nie powiodła się';

  @override
  String connectionError(String error) {
    return 'Błąd połączenia: $error';
  }

  @override
  String registrationSuccess(String memberNumber) {
    return 'Rejestracja udana!\n\nTwój numer członka: $memberNumber\n\nZapamiętaj ten numer do logowania.';
  }

  @override
  String get unknown => 'Nieznane';

  @override
  String error(String error) {
    return 'Błąd: $error';
  }

  @override
  String get cancel => 'Anuluj';

  @override
  String get resetPassword => 'Zresetuj Hasło';

  @override
  String get imprint => 'Impressum';

  @override
  String get privacy => 'Polityka Prywatności';

  @override
  String get statutes => 'Statut';

  @override
  String get revocation => 'Prawo Odstąpienia';

  @override
  String get appointments => 'Spotkania';

  @override
  String get tickets => 'Zgłoszenia';

  @override
  String get liveChat => 'Czat na żywo';

  @override
  String get notifications => 'Powiadomienia';

  @override
  String get myProfile => 'Mój Profil';

  @override
  String get logout => 'Wyloguj';

  @override
  String get goodMorning => 'Dzień dobry';

  @override
  String get goodDay => 'Dzień dobry';

  @override
  String get goodEvening => 'Dobry wieczór';

  @override
  String get goodNight => 'Dobranoc';

  @override
  String get welcomeToICD => 'Witamy w ICD360S e.V!';

  @override
  String get accountCreatedSuccessfully =>
      'Twoje konto zostało pomyślnie utworzone.';

  @override
  String get today => 'Dzisiaj';

  @override
  String get membershipFeeDue => 'Opłata członkowska należna';

  @override
  String get pleaseTransferAnnualFee => 'Prosimy o przelanie rocznej składki.';

  @override
  String get newBadge => 'Nowy';

  @override
  String get close => 'Zamknij';

  @override
  String get myAppointments => 'Moje spotkania';

  @override
  String get priority => 'Priorytet';

  @override
  String get messageLabel => 'Wiadomość';

  @override
  String get reportProblems => 'Zgłoś problemy';

  @override
  String get weRespondIn24Hours => 'Odpowiemy w ciągu maksymalnie 24 godzin!';

  @override
  String get everythingOk => 'Wszystko OK!';

  @override
  String get haveProblemWeHelp => 'Masz problem?\nMy się tym zajmiemy!';

  @override
  String get myMembership => 'Moje członkostwo';

  @override
  String get managePersonalDataAndFee => 'Zarządzaj danymi osobowymi i składką';

  @override
  String get myAppointmentsTitle => 'Moje spotkania';

  @override
  String get appointmentsDescription =>
      'Tutaj możesz zobaczyć nadchodzące spotkania.\nMożesz potwierdzić swój udział lub odrzucić.';

  @override
  String get loadAppointments => 'Załaduj spotkania';

  @override
  String get myTickets => 'Moje zgłoszenia';

  @override
  String get low => 'Niski';

  @override
  String get high => 'Wysoki';

  @override
  String get submit => 'Wyślij';

  @override
  String get errorCreatingTicket => 'Błąd podczas tworzenia zgłoszenia';

  @override
  String get verified => 'Zweryfikowany';

  @override
  String get account => 'Konto';

  @override
  String get myDevices => 'Moje urządzenia';

  @override
  String get changeEmail => 'Zmień email';

  @override
  String get changePassword => 'Zmień hasło';

  @override
  String get saveEmail => 'Zapisz email';

  @override
  String get savePassword => 'Zapisz hasło';

  @override
  String get deviceLoggedOut => 'Urządzenie wylogowane';

  @override
  String get emailChangedSuccessfully => 'Email został zmieniony';

  @override
  String get errorChangingPassword => 'Błąd zmiany hasła';

  @override
  String get errorChangingEmail => 'Błąd zmiany emaila';

  @override
  String get validEmailRequired => 'Podaj prawidłowy adres email';

  @override
  String get confirmLogoutDevice => 'Wylogować urządzenie?';

  @override
  String get confirmLogoutMessage =>
      'Czy chcesz się wylogować z tego urządzenia?\n\nMusisz zalogować się ponownie, aby używać tego urządzenia.';

  @override
  String get ipAddress => 'IP';

  @override
  String get platform => 'Platforma';

  @override
  String trialWarningUrgentTitle(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'Zostało $days dni',
      few: 'Zostały $days dni',
      one: 'Został 1 dzień',
    );
    return 'Uwaga: $_temp0 do zawieszenia konta!';
  }

  @override
  String get trialWarningTitle =>
      'Twoje konto nie zostało jeszcze zweryfikowane';

  @override
  String get trialWarningDescription =>
      'Uzupełnij swoje dane w \"Mój Profil\". Po 30 dniach Twoje konto zostanie automatycznie zawieszone.';

  @override
  String trialDaysRemaining(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days dni',
      few: '$days dni',
      one: '1 dzień',
    );
    return '$_temp0';
  }

  @override
  String get overview => 'Przegląd';

  @override
  String get member => 'Członek';

  @override
  String get memberManagement => 'Zarządzanie członkami';

  @override
  String get reportProblemTooltip => 'Zgłoś problem';

  @override
  String get newAppointmentsTitle => 'Nowe spotkania';

  @override
  String get youHaveNewAppointment => 'Masz nowe spotkanie.';

  @override
  String youHaveNewAppointments(int count) {
    return 'Masz $count nowych spotkań.';
  }

  @override
  String get appointmentReminderTomorrow => 'Przypomnienie: Spotkanie jutro';

  @override
  String tomorrowAppointment(String title) {
    return 'Jutro: $title';
  }

  @override
  String youHaveTomorrowAppointments(int count) {
    return 'Masz $count spotkań jutro.';
  }

  @override
  String get appointmentsToday => 'Spotkania dzisiaj';

  @override
  String todayAppointment(String title) {
    return 'Dzisiaj: $title';
  }

  @override
  String youHaveTodayAppointments(int count) {
    return 'Masz $count spotkań dzisiaj.';
  }

  @override
  String get paymentReminder => 'Przypomnienie o płatności';

  @override
  String paymentReminderMessage(int day, String method) {
    return 'Dzisiaj jest $day dzień miesiąca – proszę dokończyć $method.';
  }

  @override
  String get paymentDayLabel => 'Dzień płatności (przypomnienie miesięczne)';

  @override
  String get updateAvailable => 'Dostępna aktualizacja';

  @override
  String newVersionAvailable(String version) {
    return 'Dostępna jest nowa wersja: $version';
  }

  @override
  String currentVersionLabel(String version) {
    return 'Bieżąca wersja: $version';
  }

  @override
  String get changes => 'Zmiany:';

  @override
  String downloadProgress(String percent) {
    return 'Pobieranie: $percent%';
  }

  @override
  String get installationStarting => 'Rozpoczynanie instalacji...';

  @override
  String get appWillRestart =>
      'Aplikacja zostanie automatycznie uruchomiona ponownie.';

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
  String get later => 'Później';

  @override
  String get updateNow => 'Zaktualizuj teraz';

  @override
  String get downloading => 'Pobieranie...';

  @override
  String get downloadFailed =>
      'Pobieranie nie powiodło się. Spróbuj ponownie później.';

  @override
  String get searchingForUpdates => 'Szukanie aktualizacji...';

  @override
  String get appUpToDate => 'Aplikacja jest aktualna';

  @override
  String get updateCheckError => 'Błąd sprawdzania aktualizacji';

  @override
  String get changelog => 'Dziennik zmian';

  @override
  String get terminConfirmed => 'Spotkanie potwierdzone';

  @override
  String get terminDeclined => 'Spotkanie odrzucone';

  @override
  String get terminRescheduleRequested => 'Prośba o przełożenie';

  @override
  String get statusConfirmed => 'Potwierdzone';

  @override
  String get statusDeclined => 'Odrzucone';

  @override
  String get statusRescheduling => 'Przełożenie';

  @override
  String get statusPending => 'Oczekujące';

  @override
  String get categoryVorstandssitzung => 'Posiedzenie zarządu';

  @override
  String get categoryMitgliederversammlung => 'Zgromadzenie członków';

  @override
  String get categorySchulung => 'Szkolenie';

  @override
  String get categorySonstiges => 'Inne';

  @override
  String openCount(int count) {
    return '$count otwartych';
  }

  @override
  String get refresh => 'Odśwież';

  @override
  String get filterUpcoming => 'Nadchodzące';

  @override
  String get filterPast => 'Przeszłe';

  @override
  String get filterAll => 'Wszystkie';

  @override
  String get noUpcomingAppointments => 'Brak nadchodzących spotkań';

  @override
  String get noPastAppointments => 'Brak przeszłych spotkań';

  @override
  String get noAppointmentsAvailable => 'Brak spotkań';

  @override
  String get appointmentsShownHere => 'Twoje spotkania pojawią się tutaj';

  @override
  String get dateLabel => 'Data';

  @override
  String get timeLabel => 'Godzina';

  @override
  String get locationLabel => 'Miejsce';

  @override
  String get createdByLabel => 'Utworzył';

  @override
  String get descriptionLabel => 'Opis';

  @override
  String get ticketLabel => 'Zgłoszenie';

  @override
  String get yourStatus => 'Twój status: ';

  @override
  String reasonLabel(String reason) {
    return 'Powód: $reason';
  }

  @override
  String durationMinutes(int minutes) {
    return '$minutes min';
  }

  @override
  String get confirm => 'Potwierdź';

  @override
  String get decline => 'Odrzuć';

  @override
  String get reschedule => 'Przełóż';

  @override
  String get requestReschedule => 'Poproś o przełożenie';

  @override
  String appointmentLabel(String title) {
    return 'Spotkanie: $title';
  }

  @override
  String get rescheduleReason => 'Powód przełożenia *';

  @override
  String get rescheduleReasonHint => 'Podaj powód...';

  @override
  String get pleaseProvideReason => 'Podaj powód';

  @override
  String get request => 'Wyślij';

  @override
  String get ticketStatusOpen => 'Otwarty';

  @override
  String get ticketStatusInProgress => 'W toku';

  @override
  String get ticketStatusWaitingMember => 'Oczekiwanie na członka';

  @override
  String get ticketStatusWaitingStaff => 'Oczekiwanie na pracownika';

  @override
  String get ticketStatusWaitingAuthority => 'Oczekiwanie na urząd';

  @override
  String get ticketStatusDone => 'Zakończony';

  @override
  String get ticketPriorityHigh => 'Wysoki';

  @override
  String get ticketPriorityMedium => 'Średni';

  @override
  String get ticketPriorityLow => 'Niski';

  @override
  String get comments => 'Komentarze';

  @override
  String get documents => 'Dokumenty';

  @override
  String get details => 'Szczegóły';

  @override
  String get replySent => 'Odpowiedź wysłana';

  @override
  String get sendError => 'Błąd wysyłania';

  @override
  String get uploading => 'Przesyłanie...';

  @override
  String fileUploaded(String filename) {
    return '$filename przesłany';
  }

  @override
  String get uploadFailed => 'Przesyłanie nie powiodło się';

  @override
  String get openError => 'Błąd otwierania';

  @override
  String get noRepliesYet => 'Brak odpowiedzi';

  @override
  String get waitingForSupport => 'Oczekiwanie na odpowiedź';

  @override
  String get writeReply => 'Napisz odpowiedź...';

  @override
  String get attachFile => 'Załącz plik';

  @override
  String documentsCount(int count) {
    return 'Dokumenty ($count)';
  }

  @override
  String get upload => 'Prześlij';

  @override
  String get noDocuments => 'Brak dokumentów';

  @override
  String get allowedFormats => 'Dozwolone formaty: PDF, JPEG, JPG, TXT, ZIP';

  @override
  String get yourMessage => 'Twoja wiadomość:';

  @override
  String get translation => 'Tłumaczenie';

  @override
  String get original => 'Oryginał';

  @override
  String get originalText => 'Tekst oryginalny';

  @override
  String get autoTranslated => 'Przetłumaczono automatycznie';

  @override
  String get originalTapTranslation =>
      'Tekst oryginalny · Dotknij aby przetłumaczyć';

  @override
  String get translatedTapOriginal =>
      'Przetłumaczono · Dotknij aby zobaczyć oryginał';

  @override
  String get justNow => 'Właśnie teraz';

  @override
  String minutesAgo(int minutes) {
    return '$minutes min temu';
  }

  @override
  String hoursAgo(int hours) {
    return '$hours godz. temu';
  }

  @override
  String daysAgo(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'dni',
      one: 'dzień',
    );
    return '$days $_temp0 temu';
  }

  @override
  String get createdLabel => 'Utworzono';

  @override
  String get updatedLabel => 'Zaktualizowano';

  @override
  String get handlerLabel => 'Odpowiedzialny';

  @override
  String get doneLabel => 'Zakończono';

  @override
  String get newTicketTitle => 'Nowe zgłoszenie';

  @override
  String get categoryOptional => 'Kategoria (opcjonalnie)';

  @override
  String get selectCategory => 'Wybierz';

  @override
  String get subjectLabel => 'Temat';

  @override
  String get fillAllFields => 'Wypełnij wszystkie pola';

  @override
  String ticketCreatedId(int id) {
    return 'Zgłoszenie #$id utworzone';
  }

  @override
  String get priorityLabel => 'Priorytet: ';

  @override
  String get supportOffline => 'Pomoc offline';

  @override
  String get lastSeenSeconds => 'Aktywny kilka sekund temu';

  @override
  String lastSeenMinutes(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: 'minut',
      one: 'minutę',
    );
    return 'Aktywny $minutes $_temp0 temu';
  }

  @override
  String lastSeenHours(int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: 'godzin',
      one: 'godzinę',
    );
    return 'Aktywny $hours $_temp0 temu';
  }

  @override
  String lastSeenDays(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'dni',
      one: 'dzień',
    );
    return 'Aktywny $days $_temp0 temu';
  }

  @override
  String get online => 'Online';

  @override
  String get callSupport => 'Zadzwoń';

  @override
  String get typeMessage => 'Wpisz wiadomość...';

  @override
  String get callBusy => 'Pomoc jest zajęta';

  @override
  String get callRejected => 'Połączenie odrzucone';

  @override
  String get callFailed => 'Nie udało się połączyć';

  @override
  String get callEnded => 'Połączenie zakończone';

  @override
  String get callSupportBusy => 'Pomoc jest już w innym połączeniu';

  @override
  String get errorStartingChat => 'Błąd uruchamiania czatu';

  @override
  String get errorStartingCall => 'Błąd uruchamiania połączenia';

  @override
  String get errorConnecting => 'Błąd połączenia';

  @override
  String get errorDownloading => 'Błąd pobierania';

  @override
  String get errorUploading => 'Błąd przesyłania';

  @override
  String get errorSending => 'Błąd wysyłania';

  @override
  String get errorPickingPhotos => 'Błąd wyboru zdjęć';

  @override
  String get errorPickingFiles => 'Błąd wyboru plików';

  @override
  String get errorTakingPhoto => 'Błąd robienia zdjęcia';

  @override
  String get fileNotLoaded => 'Nie udało się załadować pliku';

  @override
  String get attachmentIdMissing => 'Brak ID załącznika';

  @override
  String get camera => 'Aparat';

  @override
  String get gallery => 'Galeria';

  @override
  String get file => 'Plik';

  @override
  String get notifNewMessageFrom => 'Nowa wiadomość od';

  @override
  String get notifUrgentPrefix => 'PILNE';

  @override
  String get notifUrgentMessage => 'PILNA WIADOMOŚĆ';

  @override
  String get notifIncomingCall => 'Połączenie przychodzące';

  @override
  String get notifCallingYou => 'dzwoni...';

  @override
  String get notifUpdateAvailable => 'Dostępna aktualizacja';

  @override
  String get notifVersionAvailable => 'jest teraz dostępna';

  @override
  String get notifConnected => 'Połączono';

  @override
  String get notifDisconnected => 'Rozłączono';

  @override
  String get notifConnectedBody => 'Jesteś połączony z serwerem.';

  @override
  String get notifDisconnectedBody =>
      'Połączenie z serwerem zostało przerwane.';

  @override
  String get notifError => 'Błąd';

  @override
  String get retry => 'Spróbuj ponownie';

  @override
  String get save => 'Zapisz';

  @override
  String get accept => 'Akceptuj';

  @override
  String get selectFile => 'Wybierz plik';

  @override
  String get dataLoadingText => 'Ładowanie danych...';

  @override
  String get dataSavedSuccess => 'Dane zapisane pomyślnie';

  @override
  String get errorSaving => 'Błąd zapisu';

  @override
  String get errorLoading => 'Błąd ładowania';

  @override
  String savedFilename(String filename) {
    return 'Zapisano: $filename';
  }

  @override
  String get logsCopied => 'Logi skopiowane!';

  @override
  String get passwordMinEightChars => 'Hasło musi mieć co najmniej 8 znaków';

  @override
  String get passwordChangeSuccess => 'Hasło zmienione pomyślnie';

  @override
  String get emailChangeError => 'Błąd zmiany e-maila';

  @override
  String get acceptDocumentCheckbox => 'Przeczytałem i akceptuję dokument.';

  @override
  String loadingErrorGeneric(String details) {
    return 'Błąd ładowania: $details';
  }

  @override
  String get incomingCallTitle => 'Połączenie przychodzące';

  @override
  String ringingFor(int seconds) {
    return 'Dzwoni od ${seconds}s';
  }

  @override
  String get rejectCall => 'Odrzuć';

  @override
  String get acceptCall => 'Odbierz';

  @override
  String get unmute => 'Wyłącz wyciszenie';

  @override
  String get mute => 'Wycisz';

  @override
  String get hangUp => 'Rozłącz';

  @override
  String get calling => 'Dzwonienie...';

  @override
  String autoRejectIn(int seconds) {
    return 'Automatyczne odrzucenie za $seconds sekund';
  }

  @override
  String get speakerOn => 'Głośnik';

  @override
  String get speakerOff => 'Słuchawka';

  @override
  String get micMuted => 'Wyciszony';

  @override
  String get micOn => 'Mikrofon';

  @override
  String get connectionExcellent => 'Doskonałe';

  @override
  String get connectionGood => 'Dobre';

  @override
  String get connectionWeak => 'Słabe';

  @override
  String get connectionLost => 'Rozłączono';

  @override
  String get personalData => 'Dane osobowe';

  @override
  String get personalDataSubtitle => 'Imię, nazwisko, adres';

  @override
  String get membershipFee => 'Składka członkowska';

  @override
  String annualFeeYear(String year) {
    return 'Składka roczna $year';
  }

  @override
  String get amount => 'Kwota:';

  @override
  String get dueBy => 'Termin:';

  @override
  String get paid => 'Zapłacono';

  @override
  String get versionHistory => 'Historia wersji';

  @override
  String lastUpdated(String date) {
    return 'Ostatnia aktualizacja: $date';
  }

  @override
  String get noVersionHistory => 'Brak historii wersji';

  @override
  String get failedLoadChangelog => 'Nie udało się załadować dziennika zmian';

  @override
  String get callMember => 'Zadzwoń do członka';

  @override
  String get closeConversation => 'Zamknij rozmowę';

  @override
  String get chatOffline => 'Offline';

  @override
  String get attachFiles => 'Dołącz pliki (maks. 10, 50MB)';

  @override
  String get conversationClosed => 'Ta rozmowa została zamknięta';

  @override
  String get noMessages => 'Brak wiadomości';

  @override
  String get goBack => 'Wstecz';

  @override
  String get goForward => 'Dalej';

  @override
  String get homePage => 'Strona główna';

  @override
  String get firstNameLabel => 'Imię';

  @override
  String get lastNameLabel => 'Nazwisko';

  @override
  String get streetLabel => 'Ulica';

  @override
  String get houseNumberLabel => 'Nr';

  @override
  String get postalCodeLabel => 'Kod pocztowy';

  @override
  String get cityLabel => 'Miasto';

  @override
  String get phoneMobileLabel => 'Telefon (Komórkowy)';

  @override
  String get phoneLandlineLabel => 'Telefon (Stacjonarny)';

  @override
  String get newEmailLabel => 'Nowy adres e-mail';

  @override
  String get currentPasswordLabel => 'Aktualne hasło';

  @override
  String get newPasswordLabel => 'Nowe hasło';

  @override
  String get confirmPasswordLabel => 'Potwierdź hasło';

  @override
  String get emailChangedSuccess => 'Email zmieniony pomyślnie';

  @override
  String get reasonLabel2 => 'Powód';

  @override
  String get downloadFailed2 => 'Pobieranie nie powiodło się';

  @override
  String get downloadTooltip => 'Pobierz';

  @override
  String get copyLogs => 'Kopiuj logi';

  @override
  String get deleteLogs => 'Usuń logi';

  @override
  String get autoScrollOn => 'Automatyczne przewijanie WŁ';

  @override
  String get autoScrollOff => 'Automatyczne przewijanie WYŁ';

  @override
  String get unknownValue => 'Nieznane';

  @override
  String get payment => 'Płatność';

  @override
  String get warningType_ermahnung => 'Upomnienie';

  @override
  String get warningType_abmahnung => 'Ostrzeżenie';

  @override
  String get warningType_letzte => 'Ostatnie ostrzeżenie';

  @override
  String warningsTotal(int count) {
    return 'Łącznie: $count';
  }

  @override
  String warningsErmahnung(int count) {
    return 'Upomnienia: $count';
  }

  @override
  String warningsAbmahnung(int count) {
    return 'Ostrzeżenia: $count';
  }

  @override
  String warningsLetzte(int count) {
    return 'Ostatnie: $count';
  }

  @override
  String get noWarnings => 'Brak upomnień';

  @override
  String get noWarningsDescription => 'Obecnie nie masz żadnych upomnień.';

  @override
  String createdBy(String name) {
    return 'Utworzone przez: $name';
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
  String get monthMay => 'May';

  @override
  String get monthJun => 'Jun';

  @override
  String get monthJul => 'Jul';

  @override
  String get monthAug => 'Aug';

  @override
  String get monthSep => 'Sep';

  @override
  String get monthOct => 'Oct';

  @override
  String get monthNov => 'Nov';

  @override
  String get monthDec => 'Dec';

  @override
  String get stufe1_name => 'Dane osobowe';

  @override
  String get stufe2_name => 'Rodzaj członkostwa';

  @override
  String get stufe3_name => 'Sytuacja finansowa';

  @override
  String get stufe4_name => 'Metoda płatności';

  @override
  String get stufe5_name => 'Początek członkostwa';

  @override
  String get stufe6_name => 'Statut';

  @override
  String get stufe7_name => 'Polityka prywatności';

  @override
  String get stufe8_name => 'Prawo do odstąpienia';

  @override
  String get memberType_ordentlich => 'Członek zwyczajny';

  @override
  String get memberType_foerder => 'Członek wspierający';

  @override
  String get memberType_ehren => 'Członek honorowy';

  @override
  String get memberDesc_ordentlich =>
      'Aktywny członek z prawem głosu. Korzysta z usług stowarzyszenia (email, chmura, wsparcie urzędowe).';

  @override
  String get memberDesc_foerder =>
      'Wspiera stowarzyszenie składkami. Może uczestniczyć w walnym zgromadzeniu z głosem doradczym, bez prawa głosu lub kandydowania do zarządu.';

  @override
  String get memberDesc_ehren =>
      'Ma prawa członka zwyczajnego bez obowiązku opłacania składek. Mianowany przez walne zgromadzenie lub zarząd.';

  @override
  String get payMethod_ueberweisung => 'Przelew bankowy';

  @override
  String get payMethod_dauerauftrag => 'Zlecenie stałe';

  @override
  String get verifyStatus_geprueft => 'Zweryfikowano';

  @override
  String get verifyStatus_ausgefuellt => 'Wypełniono';

  @override
  String get verifyStatus_abgelehnt => 'Odrzucono';

  @override
  String get verifyStatus_offen => 'Otwarty';

  @override
  String get fillRequiredFields => 'Wypełnij wszystkie wymagane pola.';

  @override
  String get personalDataSaved => 'Dane osobowe zapisane';

  @override
  String get selectMemberType => 'Wybierz rodzaj członkostwa.';

  @override
  String get memberTypeSaved => 'Rodzaj członkostwa zapisany';

  @override
  String get selectOption => 'Wybierz opcję.';

  @override
  String get financialSaved => 'Sytuacja finansowa zapisana';

  @override
  String get selectPaymentMethod => 'Wybierz metodę płatności.';

  @override
  String get paymentDataSaved => 'Dane płatności zapisane';

  @override
  String get selectDate => 'Wybierz datę.';

  @override
  String get membershipStartSaved => 'Początek członkostwa zapisany';

  @override
  String get fileTooLarge => 'Plik za duży (maks. 10 MB).';

  @override
  String get leistungsbescheidUploaded =>
      'Zaświadczenie o świadczeniach przesłane pomyślnie';

  @override
  String get verificationProgress => 'Postęp weryfikacji';

  @override
  String get notApplicable => 'Nie dotyczy';

  @override
  String get socialBenefitsExempt =>
      'Metoda płatności nie jest wymagana dla osób pobierających świadczenia socjalne.';

  @override
  String get locked => 'Zablokowane';

  @override
  String completePreviousStep(int step) {
    return 'Najpierw ukończ krok $step.';
  }

  @override
  String rejectedNote(String note) {
    return 'Odrzucono: $note';
  }

  @override
  String get waitingForReview => 'Oczekuje na weryfikację zarządu.';

  @override
  String get stepApproved => 'Ten krok został zweryfikowany i zatwierdzony.';

  @override
  String get changesViaChat => 'Zmiany możliwe tylko przez czat.';

  @override
  String get firstNameRequired => 'Imię *';

  @override
  String get lastNameRequired => 'Nazwisko *';

  @override
  String get birthDateLabel => 'Data urodzenia *';

  @override
  String get streetRequired => 'Ulica *';

  @override
  String get houseNumberRequired => 'Nr *';

  @override
  String get cityRequired => 'Miasto *';

  @override
  String get phoneRequired => 'Numer telefonu *';

  @override
  String get phonePurpose =>
      'Cel: Kontakt w razie niedostępności przez aplikację';

  @override
  String get selectMemberTypePrompt => 'Wybierz pożądany rodzaj członkostwa:';

  @override
  String get financialExplanation =>
      'Aby sprawdzić, czy przysługuje Ci obniżka składki, potrzebujemy poniższych informacji. Będą one wykorzystane wyłącznie do ustalenia Twojej składki członkowskiej.';

  @override
  String get socialBenefitsQuestion =>
      'Czy obecnie pobierasz świadczenia socjalne?';

  @override
  String get optionBuergergeld => 'Tak, zasiłek obywatelski (Job Center)';

  @override
  String get optionSozialamt => 'Tak, pomoc społeczna (MOPS)';

  @override
  String get optionNoBenefits => 'Nie, nie pobieram świadczeń socjalnych';

  @override
  String get feeExempt => 'Twoja miesięczna składka wynosi: 0,00 €/miesiąc';

  @override
  String get uploadLeistungsbescheid =>
      'Prześlij zaświadczenie o świadczeniach';

  @override
  String get uploadLeistungsbescheidHint =>
      'Prześlij aktualne zaświadczenie o świadczeniach w ciągu 14 dni, aby potwierdzić zwolnienie ze składki.';

  @override
  String get allowedFormatsUpload =>
      'Dopuszczalne formaty: PDF, JPG, PNG (maks. 10 MB)';

  @override
  String get feeRegular => 'Twoja miesięczna składka wynosi: 25,00 €/miesiąc';

  @override
  String paymentDayReminder(int day) {
    return 'Otrzymasz przypomnienie $day. dnia każdego miesiąca.';
  }

  @override
  String get membershipStartPrompt =>
      'Wybierz, kiedy ma rozpocząć się Twoje członkostwo.';

  @override
  String get optionAfterVerification => 'Po zakończeniu weryfikacji';

  @override
  String get optionAfterVerificationDesc =>
      'Członkostwo rozpoczyna się od dnia zatwierdzenia przez zarząd.';

  @override
  String get optionRetroFoundation =>
      'Wstecznie od daty założenia (01.08.2025)';

  @override
  String get optionRetroFoundationDesc =>
      'Stajesz się członkiem wstecznym od założenia stowarzyszenia.';

  @override
  String get optionRetroCustom => 'Wstecznie do innej daty';

  @override
  String get optionRetroCustomDesc => 'Wybierz datę między 01.08.2025 a dziś.';

  @override
  String get selectDateLabel => 'Wybierz datę';

  @override
  String get selectDateHint => 'Wybierz datę...';

  @override
  String get dateNotBefore => 'Nie wcześniej niż 01.08.2025 (data założenia)';

  @override
  String get feeExemptRetro =>
      'Zwolnienie ze składki: 0,00 € wstecznie.\nTylko data członkostwa jest ustawiona wstecznie.';

  @override
  String get retroactiveFees => 'Składki wsteczne';

  @override
  String retroFeeCalculation(
      String from, String to, String months, String total) {
    return 'Okres: $from – $to\nMiesiące: $months\nSkładka: $months × 25,00 € = $total €';
  }

  @override
  String get pleaseReadSatzung => 'Przeczytaj statut stowarzyszenia.';

  @override
  String get pleaseReadDatenschutz => 'Przeczytaj politykę prywatności.';

  @override
  String get pleaseReadWiderruf => 'Przeczytaj prawo do odstąpienia.';

  @override
  String get acceptedAtRegistration => 'Zaakceptowano przy rejestracji';

  @override
  String get confirmedByBoard =>
      'Zostanie potwierdzone po weryfikacji zarządu.';

  @override
  String get docSatzung => 'Statut';

  @override
  String get docDatenschutz => 'Polityka prywatności';

  @override
  String get docWiderruf => 'Prawo do odstąpienia';

  @override
  String acceptedAtRegCount(int count) {
    return 'Zaakceptowano przy rejestracji ($count/3)';
  }

  @override
  String acceptedOn(String date) {
    return 'Zaakceptowano dnia $date';
  }

  @override
  String get notAccepted => 'Nie zaakceptowano';

  @override
  String get statusAccepted => 'Zaakceptowano';

  @override
  String get nameTooLong => 'Imię za długie (maks. 100 znaków)';

  @override
  String get emailTooLong => 'E-mail za długi (maks. 255 znaków)';

  @override
  String get legalAcknowledgePrefix => 'Zapoznałem/am się z ';

  @override
  String get legalAcknowledgeSuffix => '.';

  @override
  String get legalStatutesSuffix => ' ICD360S e.V. i uznaję je za wiążące.';

  @override
  String get legalPleaseReadFirst => '(proszę najpierw przeczytać)';

  @override
  String get statusActive => 'Aktywny';

  @override
  String get statusSuspended => 'Zawieszony';

  @override
  String get statusNew => 'Nowy';

  @override
  String get statusCancelled => 'Anulowany';

  @override
  String get statusDeleted => 'Usunięty';

  @override
  String get roleMitglied => 'Członek';

  @override
  String get roleVorsitzer => 'Przewodniczący';

  @override
  String get roleStellvertreter => 'Zastępca';

  @override
  String get roleSchatzmeister => 'Skarbnik';

  @override
  String get roleSchriftfuehrer => 'Sekretarz';

  @override
  String get roleBeisitzer => 'Asesor';

  @override
  String get roleKassierer => 'Kasjer';

  @override
  String get roleKassenpruefer => 'Rewident';

  @override
  String get roleEhrenamtlich => 'Wolontariusz';

  @override
  String get roleMitgliedergruender => 'Członek Założyciel';

  @override
  String get roleEhrenmitglied => 'Członek Honorowy';

  @override
  String get roleFoerdermitglied => 'Członek Wspierający';

  @override
  String get memberTypeNotSet => 'Jeszcze nie ustalono';

  @override
  String get payMethodSepa => 'Polecenie zapłaty SEPA';

  @override
  String get labelStatus => 'Status';

  @override
  String get labelMemberNumber => 'Numer członkowski';

  @override
  String get labelRole => 'Rola';

  @override
  String get labelMemberType => 'Typ członkostwa';

  @override
  String get labelPaymentMethod => 'Metoda płatności';

  @override
  String get labelRegisteredOn => 'Zarejestrowano';

  @override
  String get labelLastLogin => 'Ostatnie logowanie';

  @override
  String get labelMemberSince => 'Członek od';

  @override
  String get neverLoggedIn => 'Nigdy';

  @override
  String get notActivatedYet => 'Jeszcze nie aktywowano';

  @override
  String get tabVerification => 'Weryfikacja';

  @override
  String get tabWarnings => 'Ostrzeżenia';

  @override
  String get tabDocuments => 'Dokumenty';

  @override
  String get tabMembership => 'Członkostwo';

  @override
  String get pleaseEnterFirstName => 'Podaj imię';

  @override
  String get pleaseEnterLastName => 'Podaj nazwisko';

  @override
  String get noFileDataReceived => 'Nie otrzymano danych';

  @override
  String get openFile => 'Otwórz';

  @override
  String get noMicrophoneError =>
      'Nie znaleziono mikrofonu. Podłącz mikrofon i spróbuj ponownie.';

  @override
  String get startConversation => 'Rozpocznij rozmowę!';

  @override
  String get staffWillReply => 'Pracownik wkrótce odpowie.';

  @override
  String get inCall => 'W trakcie rozmowy...';

  @override
  String get registration => 'Rejestracja';

  @override
  String get deactivation => 'Dezaktywacja';

  @override
  String get deactivatedOn => 'Dezaktywowano';

  @override
  String get accountAutoSuspend =>
      'Konta niezweryfikowane w ciągu 30 dni zostaną automatycznie zawieszone.';

  @override
  String get documentsProvidedByBoard =>
      'Dokumenty są udostępniane przez zarząd.';

  @override
  String get noDocumentsAvailable => 'Brak dokumentów';

  @override
  String get noDocumentsDescription =>
      'Nie udostępniono jeszcze żadnych dokumentów.';

  @override
  String uploadedBy(String name) {
    return 'Przesłane przez: $name';
  }

  @override
  String stepsCompleted(int completed, int total) {
    return '$completed/$total kroków ukończono';
  }

  @override
  String dayOfMonth(int day) {
    return '$day. dnia miesiąca';
  }

  @override
  String changeField(String field) {
    return 'Zmień $field';
  }

  @override
  String openDocument(String name) {
    return 'Otwórz $name';
  }

  @override
  String logEntries(int count) {
    return '$count wpisów';
  }

  @override
  String get noLogs => 'Brak logów';

  @override
  String get newLoginDetected => 'Wykryto nowe logowanie';

  @override
  String get errorNoInternet =>
      'Brak połączenia z Internetem. Sprawdź swoją sieć.';

  @override
  String get errorTimeout => 'Serwer nie odpowiada. Spróbuj ponownie później.';

  @override
  String get errorServer => 'Błąd serwera. Spróbuj ponownie później.';

  @override
  String get errorConnection => 'Błąd połączenia. Spróbuj ponownie później.';

  @override
  String get errorUnexpected =>
      'Wystąpił nieoczekiwany błąd. Spróbuj ponownie później.';

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
  String get claudiuWelcomeMorning => 'Dzień dobry';

  @override
  String get claudiuWelcomeDay => 'Dzień dobry';

  @override
  String get claudiuWelcomeEvening => 'Dobry wieczór';

  @override
  String get claudiuWelcomeNight => 'Dobry wieczór';

  @override
  String get claudiuWelcomeVisitor => 'drogi gościu';

  @override
  String get claudiuWelcomeAsk => 'Jak mogę pomóc?';

  @override
  String get claudiuWelcomeBecomeMember => 'Chcę zostać członkiem';

  @override
  String get claudiuWelcomeLogin => 'Jestem już członkiem i chcę się zalogować';

  @override
  String get claudiuWelcomeProblem => 'Mam problem z aplikacją';

  @override
  String get claudiuWelcomeEmergency => 'Pilne — zadzwoń do nas';

  @override
  String get claudiuWelcomeMascotName => 'Claudiu';

  @override
  String get claudiuWelcomeEmergencyIntro =>
      'Zanim zadzwonisz — nasze godziny pracy:';

  @override
  String get claudiuWelcomeScheduleOffice => 'W biurze';

  @override
  String get claudiuWelcomeScheduleField => 'W terenie z klientami';

  @override
  String get claudiuWelcomeOutsideHoursNote =>
      'Poza tymi godzinami obsługujemy tylko pilne sprawy. Możesz też wysłać SMS na ten sam numer — oddzwonimy.';

  @override
  String get claudiuWelcomeCallNow => 'Zadzwoń teraz';

  @override
  String get claudiuWelcomeSendSms => 'Wyślij SMS';

  @override
  String get claudiuWelcomeSmsBody =>
      'Pilne ICD360S e.V. — proszę o kontakt jak najszybciej.';

  @override
  String get claudiuWelcomeCloseButton => 'Zamknij';

  @override
  String get claudiuLoginWelcome => 'Witaj ponownie, drogi członku!';

  @override
  String get claudiuLoginAsk => 'Podaj proszę swój numer członkowski.';

  @override
  String get claudiuLoginProgress => 'Już prawie… pisz dalej.';

  @override
  String get claudiuLoginReady => 'Świetnie! Naciśnij przycisk poniżej.';

  @override
  String get claudiuLoginLoading => 'Sprawdzam tożsamość… 🔍';

  @override
  String get claudiuLoginFoundPlain => 'Znalazłem cię! Loguję…';

  @override
  String claudiuLoginFoundNamed(String name) {
    return 'Znalazłem cię, $name! Loguję…';
  }

  @override
  String get claudiuLoginError =>
      'Hmm, nie znajduję tego numeru. Czy wpisałeś go poprawnie?';

  @override
  String get claudiuLoginForgotHeader => 'Zapomniałeś numeru członkowskiego?';

  @override
  String get claudiuLoginNoSms => 'Nie wysyłamy numeru e-mailem ani SMS-em.';

  @override
  String get claudiuLoginOnlyWay =>
      'Jedyna droga: osobiste spotkanie w biurze stowarzyszenia, po weryfikacji dowodu tożsamości.';

  @override
  String get claudiuLoginContactUs => 'Zadzwoń, aby umówić spotkanie:';

  @override
  String get claudiuDiagnosticGreeting =>
      'Zanim wejdziesz, jedno szybkie pytanie';

  @override
  String get claudiuDiagnosticAsk =>
      'Czy mogę wysyłać anonimowe raporty, aby deweloperzy mogli ulepszyć aplikację?';

  @override
  String get claudiuDiagnosticYes => 'Tak, chcę pomóc';

  @override
  String get claudiuDiagnosticNo => 'Nie, tylko się rozglądam';

  @override
  String get claudiuDiagnosticTellMore => 'Powiedz mi więcej';

  @override
  String get claudiuDiagnosticSendsHeader => '📤 Co WYSYŁAMY (anonimowo):';

  @override
  String get claudiuDiagnosticSends1 =>
      'Anonimowy kod urządzenia (NIE numer członkowski)';

  @override
  String get claudiuDiagnosticSends2 => 'Twoja rola (członek / zarząd)';

  @override
  String get claudiuDiagnosticSends3 =>
      'System operacyjny (Linux / Android / iOS / Windows)';

  @override
  String get claudiuDiagnosticSends4 => 'Wybrany język';

  @override
  String get claudiuDiagnosticSends5 => 'Poziom i stan baterii';

  @override
  String get claudiuDiagnosticSends6 => 'Bieżący ekran';

  @override
  String get claudiuDiagnosticSends7 => 'Czas trwania sesji (sekundy)';

  @override
  String get claudiuDiagnosticSends8 => 'Błędy, jeśli są (ostatnie 10)';

  @override
  String get claudiuDiagnosticSends9 => 'Nawigacja (ostatnie 20 ekranów)';

  @override
  String get claudiuDiagnosticNeverHeader => '🛡️ Czego NIGDY nie wysyłamy:';

  @override
  String get claudiuDiagnosticNever1 => 'Twoje prawdziwe imię';

  @override
  String get claudiuDiagnosticNever2 => 'Adres e-mail';

  @override
  String get claudiuDiagnosticNever3 => 'Numer telefonu';

  @override
  String get claudiuDiagnosticNever4 => 'Hasło';

  @override
  String get claudiuDiagnosticNever5 => 'Treść wiadomości czatu';

  @override
  String get claudiuDiagnosticNever6 => 'Treść zgłoszeń';

  @override
  String get claudiuDiagnosticNever7 => 'Dokumenty lub załączniki';

  @override
  String get claudiuDiagnosticTechHeader => '📡 Szczegóły techniczne:';

  @override
  String get claudiuDiagnosticTech1 => 'Wysyłane co 2 minuty';

  @override
  String get claudiuDiagnosticTech2 =>
      'Połączenie szyfrowane TLS, przypięty certyfikat';

  @override
  String get claudiuDiagnosticTech3 =>
      'Możesz wyłączyć w każdej chwili w Ustawieniach';

  @override
  String get claudiuProblemHelpTitle => 'Jak mogę pomóc?';

  @override
  String get claudiuProblemHelpGreeting => 'Co się stało?';

  @override
  String get claudiuProblemHelpAsk => 'Jak chcesz mi powiedzieć?';

  @override
  String get claudiuProblemHelpWriteTitle => 'Napisz raport';

  @override
  String get claudiuProblemHelpWriteBody =>
      'Ze szczegółami krok po kroku. Zespół otrzymuje tekst i rozwiązuje go później.';

  @override
  String get claudiuProblemHelpChatTitle => 'Porozmawiajmy teraz';

  @override
  String get claudiuProblemHelpChatBody =>
      'Anonimowy czat z operatorem. Odpowiedź w czasie rzeczywistym, jeśli ktoś jest online.';

  @override
  String get claudiuProblemHelpAltCallHeader => 'Lub, jeśli pilne:';

  @override
  String get claudiuProblemHelpAltCallLabel => 'Zadzwoń';

  @override
  String get claudiuAnonymousChatTitle => 'Anonimowy czat';

  @override
  String get claudiuAnonymousChatGreeting => 'Cześć!';

  @override
  String get claudiuAnonymousChatWelcome =>
      'Słucham. Pisz co chcesz — imię niepotrzebne. Odpowiem, jak tylko będę.';

  @override
  String get claudiuAnonymousChatHint => 'Napisz wiadomość…';

  @override
  String get claudiuAnonymousChatWaitingOperator =>
      'Czekamy na odpowiedź operatora…';

  @override
  String get claudiuVorsitzerConnectedTitle => 'Cześć!';

  @override
  String get claudiuVorsitzerConnectedBody =>
      'Dzięki, że napisałeś — jesteś teraz w kontakcie z Vorsitzerem. Powiedz, w czym możemy pomóc z twoim wnioskiem o członkostwo.';

  @override
  String get claudiuVorsitzerConnectedSender => 'Vorsitzer';

  @override
  String get claudiuQuickReplyValidationTime => 'Ile trwa weryfikacja?';

  @override
  String get claudiuQuickReplyDocuments => 'Jakie dokumenty są mi potrzebne?';

  @override
  String get claudiuQuickReplyStepProblem => 'Utknąłem na jednym kroku';

  @override
  String get claudiuQuickReplyHuman => 'Mogę teraz z kimś porozmawiać?';

  @override
  String get claudiuAnonymousChatConnecting => 'Łączenie…';

  @override
  String get claudiuAnonymousChatConnectionFailed =>
      'Nie udało się otworzyć czatu. Spróbuj ponownie lub zadzwoń.';

  @override
  String get claudiuAnonymousChatRetry => 'Spróbuj ponownie';

  @override
  String get claudiuAnonymousChatOnline => 'Połączono';

  @override
  String get claudiuAnonymousChatOffline => 'Ponowne łączenie…';

  @override
  String get claudiuAnonymousChatAdminTyping => 'Operator pisze…';

  @override
  String get claudiuProblemReportTitle => 'Zgłoś problem';

  @override
  String get claudiuProblemReportGreeting => 'Co się stało?';

  @override
  String get claudiuProblemReportAsk =>
      'Powiedz szczegółowo, a ja przekażę raport zespołowi.';

  @override
  String get claudiuProblemReportIncludeHeader => 'Proszę uwzględnij:';

  @override
  String get claudiuProblemReportIncludeBullets1 =>
      'Co robiłeś, gdy pojawił się problem';

  @override
  String get claudiuProblemReportIncludeBullets2 =>
      'Jakikolwiek komunikat o błędzie, który zobaczyłeś';

  @override
  String get claudiuProblemReportIncludeBullets3 => 'Na jakim ekranie byłeś';

  @override
  String get claudiuProblemReportIncludeBullets4 =>
      'Aplikacja się zawiesza, zamyka czy pokazuje pusty ekran?';

  @override
  String get claudiuProblemReportIncludeBullets5 =>
      'Czy zdarza się za każdym razem czy tylko raz?';

  @override
  String get claudiuProblemReportDescriptionLabel => 'Twój opis';

  @override
  String get claudiuProblemReportDescriptionHint =>
      'Np.: Po otwarciu czatu pojawia się „Connection error\" i aplikacja przestaje odpowiadać…';

  @override
  String claudiuProblemReportTooShort(int count) {
    return 'Trochę więcej szczegółów (przynajmniej $count znaków)';
  }

  @override
  String get claudiuProblemReportSubmit => 'Wyślij raport';

  @override
  String get claudiuProblemReportSubmitting => 'Wysyłanie…';

  @override
  String get claudiuProblemReportSentTitle => 'Dziękuję!';

  @override
  String get claudiuProblemReportSentBody =>
      'Raport został wysłany. Nasz zespół zajmie się nim jak najszybciej.';

  @override
  String get claudiuProblemReportSentClose => 'Rozumiem';

  @override
  String get claudiuProblemReportSendFailed =>
      'Nie udało się wysłać raportu. Zadzwoń po pilną pomoc.';

  @override
  String get claudiuProblemReportAlt => 'Lub, jeśli pilne:';

  @override
  String get claudiuProblemReportCallLabel => 'Zadzwoń';

  @override
  String claudiuApprovalGreeting(String name) {
    return 'Cześć, $name! 👋';
  }

  @override
  String get claudiuApprovalGreetingNoName => 'Cześć! 👋';

  @override
  String get claudiuApprovalGladToSeeYou => 'Cieszę się, że jesteś!';

  @override
  String get claudiuApprovalCheckingForSafety =>
      'Dla twojego bezpieczeństwa Vorsitzer sprawdza teraz twoje żądanie logowania. 🛡️';

  @override
  String get claudiuApprovalMonthlyExplain =>
      '💡 Robimy to co 30 dni, aby upewnić się, że to naprawdę ty. To jak kontrola bezpieczeństwa — maksymalnie 5 minut.';

  @override
  String get claudiuApprovalSuccess =>
      'Gotowe! 🎉 Vorsitzer cię rozpoznał. Loguję cię…';

  @override
  String get claudiuApprovalDenied =>
      'Hmm, Vorsitzer odrzucił twoją prośbę. 😔';

  @override
  String get claudiuApprovalDeniedHelp =>
      'Jeśli sądzisz, że to pomyłka, proszę zadzwoń, abyśmy to wyjaśnili.';

  @override
  String get claudiuApprovalExpired =>
      'Minęło 5 minut i nie otrzymaliśmy odpowiedzi od Vorsitzera.';

  @override
  String get claudiuApprovalExpiredHelp =>
      'Zadzwoń, a możemy zatwierdzić twoje żądanie na miejscu. 📞';

  @override
  String get claudiuApprovalCallUs => 'Zadzwoń';

  @override
  String get claudiuApprovalTryAgain => 'Spróbuj ponownie';

  @override
  String get claudiuApprovalCancel => 'Anuluj';

  @override
  String get claudiuApprovalClose => 'Zamknij';

  @override
  String get wizardIntroBubble1 =>
      'Cześć, gościu! 👋 Dziękuję, że chcesz dołączyć do naszej rodziny.';

  @override
  String get wizardIntroBubble2 =>
      'Nazywam się Claudiu. Wiosną 2025 roku miałem jasną wizję: stworzyć stowarzyszenie, które pomaga ludziom w potrzebie — wolontariacko, sercem, bez zbędnej biurokracji. ❤️';

  @override
  String get wizardIntroBubble3 =>
      'Zacząłem rozmawiać z klientami, których odwiedzałem. Opowiedziałem im swoje marzenie. I każdy powiedział: „Tak, działamy!\" W lipcu 2025 spotkaliśmy się — sześcioro zdecydowanych ludzi. Postanowiliśmy założyć **ICD360S e.V.** w Neu-Ulm. 📍';

  @override
  String get wizardIntroBubble4 =>
      '**1 sierpnia 2025** stowarzyszenie oficjalnie ożyło — w Rejestrze Stowarzyszeń. Mój najpiękniejszy prezent. 🎂';

  @override
  String get wizardIntroBubble5 =>
      'Co robimy? Pomagamy uchodźcom, osobom z niepełnosprawnościami, osobom w trudnej sytuacji ekonomicznej, **dzieciom i młodzieży** — w sprawach urzędowych, nauce niemieckiego, mieszkaniu, zakupach, świadczeniach socjalnych. Nasz Vorstand składa się głównie z osób z niepełnosprawnościami — dzięki temu decyzje wynikają z prawdziwego doświadczenia życiowego. 🤝';

  @override
  String get wizardIntroBubble6 =>
      'Teraz twoja kolej. Zapiszmy cię — trwa około 5 minut. Idziemy krok po kroku, nie zostawiam cię samego. ✨';

  @override
  String get wizardIntroStart => 'Zaczynajmy';

  @override
  String get wizardBack => 'Wstecz';

  @override
  String get wizardNext => 'Dalej';

  @override
  String wizardStepLabel(int step, int total, String title) {
    return 'Krok $step z $total · $title';
  }

  @override
  String get wizardErrRequired => 'To pole jest wymagane';

  @override
  String wizardErrTooShort(int count) {
    return 'Za krótkie (co najmniej $count znaków)';
  }

  @override
  String get wizardErrOnlyLetters =>
      'Tylko litery, spacje, myślniki i apostrofy';

  @override
  String get wizardErrSaveFailed =>
      'Nie udało się zapisać. Sprawdź połączenie i spróbuj ponownie.';

  @override
  String get wizardStufe1aTitle => 'Tożsamość';

  @override
  String get wizardStufe1aPrompt =>
      'Poznajmy się oficjalnie. Wpisz swoje imię i nazwisko dokładnie tak, jak są zapisane w Personalausweis, Reisepass lub Aufenthaltstitel — żeby się zgadzało z dokumentami.';

  @override
  String get wizardStufe1aVornameLabel => 'Vornamen (imiona)';

  @override
  String get wizardStufe1aVornameHelper =>
      'Wszystkie twoje imiona dokładnie jak w dokumencie. Ze spacją lub myślnikiem (np. Hans-Peter, Maria Anna).';

  @override
  String get wizardStufe1aNachnameLabel => 'Familienname (nazwisko)';

  @override
  String get wizardStufe1aNachnameHelper => 'Twoje obecne nazwisko.';

  @override
  String get wizardStufe1aGeburtsnameLabel =>
      'Geburtsname (nazwisko rodowe) — opcjonalne';

  @override
  String get wizardStufe1aGeburtsnameHelper =>
      'Tylko jeśli różni się od Familienname — np. przed małżeństwem.';

  @override
  String get wizardStufe1bTitle => 'Urodziny';

  @override
  String get wizardStufe1bPrompt =>
      'Chcielibyśmy świętować twoje urodziny razem! 🎂 Pomaga nam też potwierdzić, że masz co najmniej 16 lat — tak mówi nasz statut.';

  @override
  String get wizardStufe1bGeburtsdatumLabel => 'Data urodzenia';

  @override
  String get wizardStufe1bGeburtsdatumHelper => 'Dotknij, aby wybrać datę';

  @override
  String get wizardStufe1bGeburtsortLabel => 'Miejsce urodzenia';

  @override
  String get wizardStufe1bGeburtsortHelper =>
      'Miasto / miejscowość, w której się urodziłeś.';

  @override
  String get wizardAgeGatePrompt => 'Przykro mi… 😔';

  @override
  String wizardAgeGateBody1(int age, int years) {
    return 'Nasz statut mówi, że trzeba mieć co najmniej 16 lat, aby zostać członkiem. Masz $age — mam nadzieję, że zobaczymy się za $years lat! 🌱';
  }

  @override
  String get wizardAgeGateBody2 =>
      'Jeśli chcesz pomagać jako wolontariusz okazjonalnie (każdy wiek, za zgodą rodziców), zadzwoń — uwielbiamy wspierać młodych, którzy chcą zmieniać świat.';

  @override
  String get wizardAgeGateBackHome => 'Wróć na powitanie';

  @override
  String get wizardErrInvalidPhone => 'Nieprawidłowy numer telefonu';

  @override
  String get wizardStufe1b1Title => 'Zgoda rodzica';

  @override
  String get wizardStufe1b1Prompt =>
      'Jesteś niepełnoletni (16-17) — zgodnie z §106 BGB potrzebujemy zgody rodzica lub opiekuna prawnego. Podaj imię i numer telefonu. Vorsitzer zadzwoni i umówi spotkanie (osobiście lub przez wideorozmowę). Bez maila — chcemy mieć pewność, że rozmawiamy z właściwą osobą.';

  @override
  String get wizardStufe1b1VornameLabel => 'Imię rodzica';

  @override
  String get wizardStufe1b1VornameHelper =>
      'Tak jak w Personalausweis rodzica.';

  @override
  String get wizardStufe1b1NachnameLabel => 'Nazwisko rodzica';

  @override
  String get wizardStufe1b1NachnameHelper =>
      'Tak jak w Personalausweis rodzica.';

  @override
  String get wizardStufe1b1TelefonLabel => 'Mobil rodzica';

  @override
  String get wizardStufe1b1TelefonHelper => 'Na ten numer zadzwoni Vorsitzer.';

  @override
  String get wizardStufe1b1RelationLabel => 'Relacja z dzieckiem:';

  @override
  String get wizardStufe1b1RelationMutter => 'Matka';

  @override
  String get wizardStufe1b1RelationVater => 'Ojciec';

  @override
  String get wizardStufe1b1RelationSorgeberechtigter => 'Opiekun prawny';

  @override
  String get wizardStufe1b1RelationAndere => 'Inny opiekun';

  @override
  String get wizardStufe1cTitle => 'Dane osobowe';

  @override
  String get wizardStufe1cPrompt =>
      'Po prostu żebym cię trochę lepiej poznał. To zostaje między nami i nigdzie nie jest publicznie pokazywane.';

  @override
  String get wizardStufe1cGeschlechtLabel => 'Płeć';

  @override
  String get wizardStufe1cGeschlechtMaennlich => 'Mężczyzna';

  @override
  String get wizardStufe1cGeschlechtWeiblich => 'Kobieta';

  @override
  String get wizardStufe1cGeschlechtDivers => 'Inna';

  @override
  String get wizardStufe1cGeschlechtKeineAngabe => 'Wolę nie podawać';

  @override
  String get wizardStufe1cFamilienstandLabel => 'Stan cywilny';

  @override
  String get wizardStufe1cFamilienstandLedig => 'Kawaler / Panna';

  @override
  String get wizardStufe1cFamilienstandVerheiratet => 'Żonaty / Mężatka';

  @override
  String get wizardStufe1cFamilienstandGeschieden => 'Rozwiedziony/a';

  @override
  String get wizardStufe1cFamilienstandVerwitwet => 'Wdowiec / Wdowa';

  @override
  String get wizardStufe1dTitle => 'Twoje pochodzenie';

  @override
  String get wizardStufe1dPrompt =>
      'To pomaga nam zaproponować odpowiednie wsparcie — na przykład poradę dotyczącą Aufenthalt lub znalezienie twojej społeczności językowej.';

  @override
  String get wizardStufe1dStaatLabel => 'Obywatelstwo';

  @override
  String get wizardStufe1dStaatHelper =>
      'Np. deutsch, rumänisch, ukrainisch. Kilka oddzielonych przecinkiem.';

  @override
  String get wizardStufe1dAufenthaltLabel =>
      'Status pobytu (Aufenthaltsstatus) — opcjonalne';

  @override
  String get wizardStufe1dAufenthaltHelper =>
      'Wybierz tytuł z Twojej Aufenthaltskarte / decyzji. Vorstand porównuje z Twoimi dokumentami.';

  @override
  String get wizardStufe1dAufenthaltAwaitingCitizenship =>
      'Najpierw uzupełnij obywatelstwo powyżej — pokażemy tylko pasujące opcje.';

  @override
  String get wizardStufe1dAufenthaltGerman =>
      'Aufenthaltstitel niepotrzebny — obywatel Niemiec.';

  @override
  String get wizardStufe1dAufenthaltEuEea =>
      'Obywatel UE/EOG/CH — swoboda przemieszczania (Freizügigkeit).';

  @override
  String get wizardStufe1dAufenthaltTempHint => 'tymczasowy';

  @override
  String get wizardStufe1dAufenthaltPermHint => 'stały pobyt';

  @override
  String get wizardStufe1dAufenthaltAsylumProcessHint => 'procedura azylowa';

  @override
  String get wizardStufe1dAufenthaltOther =>
      'Inne (proszę sprecyzuj na czacie)';

  @override
  String get wizardStufe1dAufenthaltRequired => 'Wybierz Aufenthaltstitel.';

  @override
  String get wizardStufe1dMutterspracheLabel => 'Język ojczysty';

  @override
  String get wizardStufe1dMutterspracheHelper =>
      'Wstępnie wypełnione językiem aplikacji — zmień jeśli inny.';

  @override
  String get wizardStufe1eTitle => 'Adres';

  @override
  String get wizardStufe1ePrompt =>
      'Twój adres pocztowy — używamy go do oficjalnych dokumentów (statut, umowy członkowskie, powiadomienia).';

  @override
  String get wizardStufe1eStrasseLabel => 'Ulica';

  @override
  String get wizardStufe1eStrasseHelper =>
      'Tylko nazwa ulicy — numer w sąsiednim polu.';

  @override
  String get wizardStufe1eHausnummerLabel => 'Nr';

  @override
  String get wizardStufe1ePlzLabel => 'PLZ (kod pocztowy)';

  @override
  String get wizardStufe1eOrtLabel => 'Miasto';

  @override
  String get wizardStufe1eLandLabel => 'Kraj';

  @override
  String get wizardStufe1eLandHelper => 'Wstępnie wypełnione: Deutschland.';

  @override
  String get wizardErrInvalidStreet => 'Nieprawidłowa nazwa ulicy';

  @override
  String get wizardErrInvalidHausnummer =>
      'Nieprawidłowy numer (np. 12, 12a, 12/3)';

  @override
  String get wizardErrInvalidPlz => 'Nieprawidłowy kod pocztowy (tylko cyfry)';

  @override
  String get wizardStufe1fTitle => 'Kontakt';

  @override
  String get wizardStufe1fPrompt =>
      'Jak się z tobą skontaktować? Telefon tylko w pilnych sprawach — resztę załatwiamy przez nasz własny szyfrowany end-to-end kanał w aplikacji. Twój członkowski e-mail jest przydzielany automatycznie i widzisz go poniżej.';

  @override
  String get wizardStufe1fTelefonLabel => 'Telefon komórkowy';

  @override
  String get wizardStufe1fTelefonHelper =>
      'Obiecuję, zadzwonię tylko jeśli to ważne. 📱';

  @override
  String get wizardStufe2Title => 'Typ członkostwa';

  @override
  String get wizardStufe2Prompt =>
      'Jakim członkiem chcesz być? Wyjaśnię ci każdą opcję.';

  @override
  String get wizardStufe2OrdentlichTitle => 'Członek zwyczajny (ordentlich)';

  @override
  String get wizardStufe2OrdentlichBody =>
      'Pełne prawa. Płacisz miesięczną składkę, głosujesz na walnym zgromadzeniu, możesz być wybrany do zarządu. Domyślny wybór.';

  @override
  String get wizardStufe2FoerderTitle => 'Członek wspierający (Fördermitglied)';

  @override
  String get wizardStufe2FoerderBody =>
      'Wspierasz stowarzyszenie finansowo, ale nie uczestniczysz aktywnie w decyzjach. Bez prawa głosu. Dobre, jeśli chcesz pomagać z dystansu.';

  @override
  String get wizardStufe2EhrenTitle => 'Członek honorowy (Ehrenmitglied)';

  @override
  String get wizardStufe2EhrenBody =>
      'Przyznawany przez zarząd za szczególne zasługi. Nie wybierasz tego sam — to wyróżnienie. Wybierz tylko jeśli już zostałeś uhonorowany.';

  @override
  String get wizardStufe3Title => 'Sytuacja finansowa';

  @override
  String get wizardStufe3Prompt =>
      'Teraz o twojej sytuacji finansowej. Nie żeby cię oceniać — tylko żeby zwolnić ze składki jeśli otrzymujesz świadczenia socjalne.';

  @override
  String get wizardStufe3OptionBuergergeld => 'Otrzymuję Bürgergeld';

  @override
  String get wizardStufe3OptionSozialamt =>
      'Otrzymuję świadczenia od Sozialamt';

  @override
  String get wizardStufe3OptionNein => 'Nie otrzymuję żadnego z tych';

  @override
  String get wizardStufe3FeeExemptTitle => 'Składka: 0 € / m-c 🎉';

  @override
  String get wizardStufe3FeeExemptBody =>
      'Z Bürgergeldem, Sozialamtem, ALG I lub Krankengeldem jesteś całkowicie zwolniony ze składki zgodnie z Satzung §6. Potrzebujemy tylko dowodu (Leistungsbescheid lub zaświadczenia z urzędu / kasy chorych).';

  @override
  String get wizardStufe3UploadTitle => 'Prześlij Leistungsbescheid';

  @override
  String get wizardStufe3UploadHint => 'PDF / JPG / PNG, maks. 10 MB.';

  @override
  String get wizardStufe3UploadRequired =>
      'Prześlij Leistungsbescheid, zanim przejdziesz dalej.';

  @override
  String get wizardStufe3FileTooLarge => 'Plik za duży. Maksymalnie 10 MB.';

  @override
  String get wizardStufe3UploadFailed =>
      'Nie udało się przesłać pliku. Spróbuj ponownie.';

  @override
  String get wizardStufe3RegularFeeTitle => 'Składka: 25 € / m-c';

  @override
  String get wizardStufe3RegularFeeBody =>
      'Standardowa składka dla członków zwyczajnych zgodnie ze statutem.';

  @override
  String get wizardStufe4Title => 'Płatność';

  @override
  String get wizardStufe4Prompt =>
      'Jak chcesz płacić składkę? I którego dnia miesiąca?';

  @override
  String get wizardStufe4MethodUeberweisungTitle => 'Przelew (Überweisung)';

  @override
  String get wizardStufe4MethodUeberweisungBody =>
      'Sam inicjujesz płatność co miesiąc ze swojego konta.';

  @override
  String get wizardStufe4MethodSepaTitle =>
      'SEPA-Lastschrift (polecenie zapłaty)';

  @override
  String get wizardStufe4MethodSepaBody =>
      'Automatycznie pobieramy kwotę z twojego konta. Najwygodniejsze, ale potrzebujemy IBAN i podpisanego upoważnienia.';

  @override
  String get wizardStufe4MethodDauerauftragTitle =>
      'Dauerauftrag (zlecenie stałe)';

  @override
  String get wizardStufe4MethodDauerauftragBody =>
      'Ustawiasz zlecenie stałe w swoim banku. Bank automatycznie przelewa kwotę co miesiąc.';

  @override
  String get wizardStufe4DayLabel => 'Dzień płatności';

  @override
  String get wizardStufe4DayHint => 'Wybierz dzień między 1 a 31';

  @override
  String wizardStufe4DayItem(int day) {
    return 'Dzień $day';
  }

  @override
  String wizardStufe4DayReminder(int day) {
    return 'Składka będzie pobierana $day-go każdego miesiąca.';
  }

  @override
  String get wizardStufe5Title => 'Początek';

  @override
  String get wizardStufe5Prompt =>
      'Od kiedy chcesz oficjalnie być członkiem ICD360S? Od zatwierdzenia lub z mocą wsteczną.';

  @override
  String get wizardStufe5OptionAbVerifizierungTitle =>
      'Od zatwierdzenia przez Vorstand';

  @override
  String get wizardStufe5OptionAbVerifizierungBody =>
      'Najprostszy wybór. Bez składki z mocą wsteczną.';

  @override
  String get wizardStufe5OptionGruendungsdatumTitle =>
      'Z mocą wsteczną od 01.08.2025 (założenie)';

  @override
  String get wizardStufe5OptionGruendungsdatumBody =>
      'Będziesz liczony jako członek od pierwszego dnia stowarzyszenia.';

  @override
  String get wizardStufe5OptionAnderesDatumTitle => 'Inna data';

  @override
  String get wizardStufe5OptionAnderesDatumBody =>
      'Sam wybierasz datę między 01.08.2025 a dziś.';

  @override
  String get wizardStufe5PickDate => 'Dotknij, aby wybrać datę';

  @override
  String get wizardStufe5PickDateFirst => 'Najpierw wybierz datę.';

  @override
  String get wizardStufe5DatePickerHelp => 'Początek członkostwa';

  @override
  String wizardStufe5DateRange(String start) {
    return 'Pomiędzy $start a dziś';
  }

  @override
  String get wizardStufe5RetroactiveTitle => 'Składka z mocą wsteczną';

  @override
  String wizardStufe5RetroactiveBody(
      String start, String end, int months, String amount) {
    return 'Od $start do $end to $months miesięcy. Po 25 €/mies. to $amount € do zapłaty z mocą wsteczną, oprócz bieżącej składki miesięcznej.';
  }

  @override
  String get wizardStufe5FeeExemptTitle => 'Składka z mocą wsteczną: 0 € 🎉';

  @override
  String get wizardStufe5FeeExemptBody =>
      'Z Bürgergeld lub Sozialamt jesteś całkowicie zwolniony — nawet z mocą wsteczną nic nie jesteś winien.';

  @override
  String wizardDocumentPrompt(String doc) {
    return 'Zanim skończymy, przeczytaj uważnie $doc. Ważne, abyś wiedział, co podpisujesz.';
  }

  @override
  String get wizardDocumentScrollHint => 'Przewiń na dół, aby kontynuować.';

  @override
  String get wizardDocumentScrolledOk => 'Przeczytałeś do końca ✓';

  @override
  String wizardDocumentOpenButton(String doc) {
    return 'Otwórz $doc w przeglądarce';
  }

  @override
  String get wizardDocumentExternalHint =>
      'Na tej platformie otwieramy dokument w domyślnej przeglądarce.';

  @override
  String get wizardDocumentOpenedOk =>
      'Dokument został otwarty. Przeczytaj go uważnie.';

  @override
  String wizardDocumentConfirm(String doc) {
    return 'Potwierdzam, że przeczytałem(am) i zgadzam się z $doc.';
  }

  @override
  String get wizardFinalAdultTitle => 'Gotowe! Jesteś zapisany 🎉';

  @override
  String get wizardFinalMinorTitle => 'Twoja prośba została wysłana 📨';

  @override
  String get wizardFinalMinorBody =>
      'Skontaktujemy się z twoim rodzicem i umówimy spotkanie (osobiście lub przez wideorozmowę). Prosimy o cierpliwość — proces może potrwać do 7 dni. Otrzymasz powiadomienie w aplikacji, gdy tylko rodzic zatwierdzi.';

  @override
  String get wizardFinalMitgliedernummerLabel => 'Twój numer członkowski';

  @override
  String get wizardStufe4MethodComingSoon => 'Wkrótce';

  @override
  String get wizardStufe4StreichungWarning =>
      'Jeśli zalegasz ze składką ponad 6 miesięcy, automatycznie cię skreślamy (Satzung §6 Abs. 3).';

  @override
  String get wizardStufe5KuendigungInfo =>
      'Aby się wypisać: prześlij wypowiedzenie pisemnie 3 miesiące przed 31 grudnia (do 30 września, by obowiązywało od końca roku). Brak okresu minimalnego (Satzung §6 Abs. 3).';

  @override
  String get wizardStufe1fEmailLabel => 'Twój członkowski e-mail';

  @override
  String get wizardStufe1fEmailHelper =>
      'Przydzielany automatycznie na podstawie twojego numeru członkowskiego. Aktywowany w chwili, gdy zarząd (Vorstand) zatwierdzi twój wniosek. Mamy własną aplikację e-mail — wysyłaj i odbieraj zaszyfrowane e-maile, prosto i za darmo.';

  @override
  String get wizardErrInvalidEmail => 'Nieprawidłowy adres e-mail';

  @override
  String get wizardStufe3OptionAlg1 =>
      'Pobieram Arbeitslosengeld I (ALG I, zasiłek dla bezrobotnych)';

  @override
  String get wizardStufe3OptionKrankengeld =>
      'Pobieram Krankengeld (zasiłek chorobowy długoterminowy)';

  @override
  String get wizardStufe3UploadAddMore => 'Dodaj kolejny dokument';

  @override
  String get wizardStufe3UploadLimitCount =>
      'Osiągnięty limit: maksymalnie 20 dokumentów.';

  @override
  String get wizardStufe3UploadLimitTotal =>
      'Osiągnięty łączny limit 100 MB. Usuń istniejący plik.';

  @override
  String get wizardStufe3UploadDeleteTooltip => 'Usuń';

  @override
  String wizardStufe3UploadCounter(int count, int max) {
    return '$count / $max dokumentów';
  }

  @override
  String get wizardDocumentExternalOpenFailed =>
      'Nie udało się otworzyć przeglądarki. Link został skopiowany do schowka — wklej go w przeglądarce, aby kontynuować.';

  @override
  String get wizardFinalTimelineProcessing =>
      'Vorstand weryfikuje · zwykle 1 dzień roboczy, do 7';

  @override
  String get wizardFinalTimelineActivated => 'Konto aktywowane';

  @override
  String get wizardFinalAdultThank =>
      'Dziękujemy za wypełnienie formularza rejestracyjnego! 🎉';

  @override
  String get wizardFinalAdultUsual =>
      'Twój wniosek jest u nas. Zwykle weryfikujemy go w ciągu jednego dnia roboczego.';

  @override
  String get wizardFinalAdultExceptional =>
      'Czasem może to potrwać do 7 dni roboczych. A jeśli coś się nie zgadza, odeślemy cię z powrotem do formularza, byś poprawił 🙂';

  @override
  String get wizardFinalStatusTitle => 'STATUS WNIOSKU';

  @override
  String wizardFinalStatusStepsValidated(int reviewed, int total) {
    return '$reviewed/$total kroków zatwierdzonych przez Vorstand';
  }

  @override
  String get wizardFinalStufeSheetTitle => 'Szczegóły wniosku';

  @override
  String get wizardFinalStufeSheetHint =>
      '8 etapów, które ukończyłeś. Vorstand sprawdza je po kolei — widzisz w czasie rzeczywistym, co zostało zatwierdzone.';

  @override
  String get wizardFinalStufeStatusPending => 'Czeka na weryfikację';

  @override
  String get wizardFinalStufeStatusApproved => 'Zatwierdzone';

  @override
  String get wizardFinalStufeStatusRejected => 'Odrzucone';

  @override
  String wizardFinalStatusRejectionCount(int count) {
    return '$count krok wymaga poprawy';
  }

  @override
  String get wizardFinalStufeRejectionReason => 'Powód Vorstandu:';

  @override
  String get wizardFinalStufeCorrectNow => 'Popraw teraz';

  @override
  String wizardFinalApprovalsHeader(int current, int total) {
    return 'Zatwierdzenia Vorstandu ($current/$total)';
  }

  @override
  String get wizardFinalApprovalAwaiting => 'Czekamy na 2. Vorstand';

  @override
  String get wizardFinalApprovalRejected => 'ODRZUCONE';

  @override
  String get wizardFinalStufeNoDataYet => 'Dane jeszcze niedostępne.';

  @override
  String get wizardFinalStufeReadAt => 'Przeczytano:';

  @override
  String get wizardFinalStufeBeitragsfrei =>
      'Zwolniony ze składki (bez opłaty)';

  @override
  String get wizardFinalStufeNotExempt => 'Bez świadczeń socjalnych';

  @override
  String get wizardFinalStufeBeginAtVerification =>
      'Rozpoczyna się przy weryfikacji';

  @override
  String get wizardFinalStufeBeginAtFoundation => 'Data założenia (wstecznie)';

  @override
  String get wizardFinalStufeBeginAtCustom => 'Inna data';

  @override
  String get wizardFinalStufeStatusSkipped => 'Pominięte';

  @override
  String get wizardFinalStufeFilledAt => 'Wypełnione:';

  @override
  String get wizardFinalStufeReviewedAt => 'Sprawdzone:';

  @override
  String get wizardFinalWithdrawLink => 'Wycofaj wniosek';

  @override
  String get wizardFinalWithdrawDialogTitle => 'Wycofać wniosek?';

  @override
  String get wizardFinalWithdrawDialogBody =>
      'Twój wniosek zostanie oznaczony jako wycofany przez ciebie. Dane pozostają w bazie do celów audytu (RODO), ale konto nie zostanie aktywowane. Możesz w każdej chwili rozpocząć rejestrację od nowa z nowym numerem członkowskim.';

  @override
  String get wizardFinalWithdrawKeep => 'Nie, poczekam';

  @override
  String get wizardFinalWithdrawConfirm => 'Tak, wycofaj';

  @override
  String get wizardErrTooManyWithdrawals =>
      'Twojego wniosku nie da się przetworzyć automatycznie. Zadzwoń do nas lub przyjdź osobiście do Vorstandu, żeby kontynuować rejestrację.';

  @override
  String get wizardDuplicateLoginTitle =>
      'Wygląda na to, że już jesteś naszym członkiem';

  @override
  String get wizardDuplicateLoginBody =>
      'Z twoim imieniem i datą urodzenia znajdujemy już aktywne konto. Skorzystaj z \"Jestem już członkiem\" na ekranie głównym, by się zalogować. Jeśli nie masz dostępu, zadzwoń.';

  @override
  String get wizardDuplicatePendingTitle => 'Twój wniosek już jest u nas';

  @override
  String get wizardDuplicatePendingBody =>
      'Z twoim imieniem i datą urodzenia mamy już wniosek w trakcie weryfikacji. Vorstand nad nim pracuje — powiadomimy cię w aplikacji, gdy konto stanie się aktywne. Zadzwoń, jeśli chcesz porozmawiać.';

  @override
  String get wizardDuplicateRecentlyWithdrawnTitle =>
      'Nie możemy teraz przetworzyć tego wniosku';

  @override
  String get wizardDuplicateRecentlyWithdrawnBody =>
      'Twoje imię i data urodzenia pasują do niedawno wycofanego wniosku. Zadzwoń do nas, aby porozmawiać z Vorstandem zanim ruszysz dalej.';

  @override
  String get wizardDuplicatePreviouslyWithdrawnTitle =>
      'Już wcześniej składałeś wniosek';

  @override
  String get wizardDuplicatePreviouslyWithdrawnBody =>
      'Twoje imię i data urodzenia pasują do starszego wniosku, który wycofałeś. Witaj z powrotem — zadzwoń przed kontynuacją, by Vorstand zdecydował, jak postępujemy.';

  @override
  String get wizardDuplicateCallUsTitle => 'Prosimy, zadzwoń';

  @override
  String get wizardDuplicateCallUsBody =>
      'Twoje imię i data urodzenia są już w naszej bazie, ale szczegółów nie możemy podać przez aplikację. Zadzwoń do nas — Vorstand wyjaśni sytuację bezpośrednio.';

  @override
  String get wizardChatHelp => 'Porozmawiajmy';

  @override
  String get wizardChatHelpSubtitle =>
      'Czat na żywo z Vorstandem · szybka odpowiedź';

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

  @override
  String get benachrichtigungenLeer => 'Keine Benachrichtigungen';

  @override
  String get benachrichtigungenAlleGelesen => 'Alle als gelesen markieren';

  @override
  String get benachrichtigungWetterFrage =>
      'Möchten Sie bei Unwetter an Ihrem Wohnort gewarnt werden?';

  @override
  String get benachrichtigungWetterDetail =>
      'Nur amtliche Warnungen des Deutschen Wetterdienstes ab Stufe „schwer“ — nicht bei jedem Regen.';

  @override
  String get signaturTitel => 'Podpisy';

  @override
  String get signaturNichtsOffen => 'Obecnie nie ma nic do podpisania.';

  @override
  String get signaturStatusOffen => 'Czeka na Pana/Pani podpis';

  @override
  String get signaturStatusSigniert => 'Podpisane przez Pana/Panią';

  @override
  String get signaturStatusAbgelehnt => 'Odrzucone przez Pana/Panią';

  @override
  String get signaturStatusWiderrufen => 'Wycofane przez stowarzyszenie';

  @override
  String get signaturStatusAbgelaufen => 'Termin minął';

  @override
  String signaturBitteGanzLesen(int gelesen, int gesamt) {
    return 'Prosimy przeczytać dokument do końca (strona $gelesen z $gesamt).';
  }

  @override
  String get signaturWeiterZurUnterschrift => 'Przejdź do podpisu';

  @override
  String get signaturAblehnen => 'Odrzuć';

  @override
  String get signaturAblehnenHinweis =>
      'Stowarzyszenie zostanie o tym powiadomione. Może Pan/Pani podać powód.';

  @override
  String get signaturAblehnenGrund => 'Powód (nieobowiązkowy)';

  @override
  String get signaturMitFingerHinweis =>
      'Prosimy podpisać się palcem w białym polu.';

  @override
  String get signaturNochmal => 'Jeszcze raz';

  @override
  String get signaturZurueckZumDokument => 'Powrót do dokumentu';

  @override
  String get signaturCodeAnfordern => 'Zamów kod SMS';

  @override
  String get signaturCodeUnterwegs => 'Kod jest w drodze.';

  @override
  String signaturCodeGesendetAn(String nummer) {
    return 'Wysłaliśmy kod na numer $nummer.';
  }

  @override
  String get signaturCodeErneutSenden => 'Wyślij kod ponownie';

  @override
  String get signaturJetztUnterschreiben => 'Podpisz teraz';

  @override
  String get signaturCodeFalsch => 'Kod się nie zgadza.';

  @override
  String get signaturCodeAbgelaufen =>
      'Kod stracił ważność. Prosimy zamówić nowy kod.';

  @override
  String get signaturZuVieleVersuche =>
      'Zbyt wiele nieudanych prób. Prosimy zamówić nowy kod.';

  @override
  String get signaturKeineRufnummer =>
      'Na Pana/Pani koncie nie ma zapisanego numeru telefonu komórkowego. Bez niego nie możemy wysłać Panu/Pani kodu — prosimy skontaktować się z przewodniczącym stowarzyszenia.';

  @override
  String get signaturCodeFehlgeschlagen => 'Nie udało się wysłać kodu.';

  @override
  String get signaturLeer => 'Prosimy najpierw złożyć podpis.';

  @override
  String get signaturErfolg => 'Dziękujemy — otrzymaliśmy Pana/Pani podpis.';

  @override
  String get signaturFehlgeschlagen =>
      'Nie udało się. Prosimy spróbować jeszcze raz.';

  @override
  String get signaturSiegelInArbeit =>
      'Podpisany dokument jest jeszcze przygotowywany. Proszę spróbować ponownie za minutę.';
}
