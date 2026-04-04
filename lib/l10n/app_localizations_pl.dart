// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Polish (`pl`).
class AppLocalizationsPl extends AppLocalizations {
  AppLocalizationsPl([String locale = 'pl']) : super(locale);

  @override
  String get appTitle => 'ICD360S e.V - Portal Członków';

  @override
  String get memberPortal => 'Portal Członków';

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
  String get password => 'Hasło';

  @override
  String get passwordHint => 'Wprowadź hasło';

  @override
  String get confirmPassword => 'Potwierdź Hasło';

  @override
  String get confirmPasswordHint => 'Potwierdź hasło';

  @override
  String get newPassword => 'Nowe Hasło';

  @override
  String get newPasswordHint => 'Wprowadź nowe hasło';

  @override
  String get saveCredentials => 'Zapisz dane logowania';

  @override
  String get autoLogin => 'Automatyczne logowanie';

  @override
  String get forgotPassword => 'Zapomniałeś hasła?';

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
  String get recoveryCode => 'Kod Odzyskiwania (6 cyfr)';

  @override
  String get recoveryCodeHelper => 'Zapamiętaj ten kod do odzyskiwania hasła';

  @override
  String get recoveryCodeHint => 'Wprowadź kod odzyskiwania';

  @override
  String get recoveryCodeInvalid => 'Kod musi mieć dokładnie 6 cyfr';

  @override
  String get loginFailed => 'Logowanie nie powiodło się';

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
  String get tooManyDevices => 'Za dużo urządzeń';

  @override
  String get maxDevicesMessage =>
      'Jesteś już zalogowany na 3 urządzeniach.\nWybierz urządzenie do wylogowania:';

  @override
  String get unknownDevice => 'Nieznane urządzenie';

  @override
  String get unknown => 'Nieznane';

  @override
  String get logoutError => 'Błąd wylogowania';

  @override
  String error(String error) {
    return 'Błąd: $error';
  }

  @override
  String get cancel => 'Anuluj';

  @override
  String get resetPassword => 'Zresetuj Hasło';

  @override
  String get forgotPasswordTitle => 'Zapomniałeś Hasła';

  @override
  String get forgotPasswordDescription =>
      'Wprowadź numer członka i kod odzyskiwania utworzony podczas rejestracji.';

  @override
  String get passwordResetSuccess =>
      'Hasło zostało pomyślnie zresetowane!\n\nMożesz się teraz zalogować nowym hasłem.';

  @override
  String get passwordResetFailed => 'Resetowanie hasła nie powiodło się';

  @override
  String get needHelp => 'Potrzebujesz pomocy?';

  @override
  String get helpQuestion => 'Problemy z logowaniem lub rejestracją?';

  @override
  String get helpDescription =>
      'Skontaktuj się przez WhatsApp i opisz dokładnie co nie działa. Odpowiemy jak najszybciej!';

  @override
  String get whatsapp => 'WhatsApp';

  @override
  String get emailSubject => 'Zapytanie przez aplikację ICD360S';

  @override
  String get whatsappMessage => 'Witam, mam problem z aplikacją ICD360S. ';

  @override
  String get imprint => 'Impressum';

  @override
  String get privacy => 'Polityka Prywatności';

  @override
  String get statutes => 'Statut';

  @override
  String get revocation => 'Prawo Odstąpienia';

  @override
  String get cancellation => 'Anulowanie';

  @override
  String get allRightsReserved => 'Wszelkie prawa zastrzeżone.';

  @override
  String get enterCredentials => 'Wprowadź numer członka i hasło';

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
  String get membership => 'Członkostwo';

  @override
  String get myAppointments => 'Moje spotkania';

  @override
  String get appointmentsLoadingReady => 'Ładowanie spotkań - API gotowe!';

  @override
  String get priority => 'Priorytet';

  @override
  String get messageLabel => 'Wiadomość';

  @override
  String get createdOn => 'Utworzono';

  @override
  String get handler => 'Obsługa';

  @override
  String get reportProblems => 'Zgłoś problemy';

  @override
  String get reportProblem => 'Zgłoś problem';

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
  String get newTicket => 'Nowe zgłoszenie';

  @override
  String get noOpenTickets => 'Brak otwartych zgłoszeń';

  @override
  String get haveQuestionCreateTicket =>
      'Masz pytanie lub problem?\nUtwórz nowe zgłoszenie.';

  @override
  String get whatIsTheProblem => 'Jaki jest problem?';

  @override
  String get describeTheProblem => 'Opisz problem';

  @override
  String get howUrgentIsIt => 'Jak pilne?';

  @override
  String get low => 'Niski';

  @override
  String get medium => 'Średni';

  @override
  String get high => 'Wysoki';

  @override
  String get submit => 'Wyślij';

  @override
  String get fillSubjectAndMessage => 'Wypełnij temat i wiadomość';

  @override
  String get ticketCreated => 'Zgłoszenie utworzone';

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
  String get newEmailAddress => 'Nowy adres email';

  @override
  String get currentPassword => 'Aktualne hasło';

  @override
  String get saveEmail => 'Zapisz email';

  @override
  String get savePassword => 'Zapisz hasło';

  @override
  String get deviceLoggedOut => 'Urządzenie wylogowane';

  @override
  String get passwordChangedSuccessfully => 'Hasło zostało zmienione';

  @override
  String get emailChangedSuccessfully => 'Email został zmieniony';

  @override
  String get errorChangingPassword => 'Błąd zmiany hasła';

  @override
  String get errorChangingEmail => 'Błąd zmiany emaila';

  @override
  String get validEmailRequired => 'Podaj prawidłowy adres email';

  @override
  String get passwordTooShort => 'Hasło musi mieć co najmniej 6 znaków';

  @override
  String get maxDevicesReached =>
      'Jesteś zalogowany na maksymalnie 3 urządzeniach.';

  @override
  String loggedInOnDevices(int count) {
    return 'Jesteś zalogowany na $count z 3 urządzeń.';
  }

  @override
  String get noActiveSessions => 'Brak aktywnych sesji';

  @override
  String get logoutFromDevice => 'Wyloguj z tego urządzenia';

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
  String get errorAcceptingCall => 'Błąd akceptacji połączenia';

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
  String typingIndicator(String name) {
    return '$name pisze...';
  }

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
  String get diagnosticDataTitle => 'Dane diagnostyczne';

  @override
  String get diagnosticDescription =>
      'Czy chcesz wysyłać anonimowe dane diagnostyczne, aby ulepszyć aplikację?';

  @override
  String get noThanks => 'Nie, dziękuję';

  @override
  String get yesEnable => 'Tak, włącz';

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
  String get newPasswordMinChars => 'Nowe hasło (min. 6 znaków)';

  @override
  String get reasonLabel2 => 'Powód';

  @override
  String get downloadFailed2 => 'Pobieranie nie powiodło się';

  @override
  String get downloadTooltip => 'Pobierz';

  @override
  String get connectionErrorGeneric => 'Błąd połączenia';

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
  String get bankTransfer => 'Przelew bankowy';

  @override
  String get standingOrder => 'Zlecenie stałe';

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
  String get memberNumberTooLong =>
      'Numer członkowski za długi (maks. 20 znaków)';

  @override
  String get onlyUppercaseAndNumbers =>
      'Dozwolone tylko wielkie litery i cyfry';

  @override
  String get passwordTooLong => 'Hasło za długie (maks. 100 znaków)';

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
  String get diagnosticErrors => 'Raporty błędów do ulepszenia';

  @override
  String get diagnosticAnonymousStats => 'Anonimowe statystyki użytkowania';

  @override
  String get diagnosticPerformance => 'Dane o wydajności aplikacji';

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
  String get ipClean => 'IP czyste - nie na liście';

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
  String get helpImproveApp => 'Czy chcesz pomóc nam ulepszyć aplikację?';

  @override
  String get noPersonalDataCollected =>
      'Żadne dane osobowe nie są zbierane. To ustawienie można zmienić w dowolnym momencie.';

  @override
  String logEntries(int count) {
    return '$count wpisów';
  }

  @override
  String get noLogs => 'Brak logów';

  @override
  String get newLoginDetected => 'Wykryto nowe logowanie';

  @override
  String get waitingForMember => 'Oczekiwanie na członka';

  @override
  String get waitingForStaff => 'Oczekiwanie na pracownika';

  @override
  String get waitingForAuthority => 'Oczekiwanie na urząd';
}
