// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Serbian (`sr`).
class AppLocalizationsSr extends AppLocalizations {
  AppLocalizationsSr([String locale = 'sr']) : super(locale);

  @override
  String get welcomeLoading => 'Учитавање...';

  @override
  String get welcomeAutoLogin => 'Аутоматска пријава...';

  @override
  String get login => 'Пријава';

  @override
  String get register => 'Регистрација';

  @override
  String get becomeMember => 'Постаните члан';

  @override
  String get memberNumber => 'Број члана';

  @override
  String get memberNumberHint => 'Унесите број члана';

  @override
  String get confirmPassword => 'Потврдите лозинку';

  @override
  String get confirmPasswordHint => 'Потврдите лозинку';

  @override
  String get newPassword => 'Нова лозинка';

  @override
  String get newPasswordHint => 'Унесите нову лозинку';

  @override
  String get firstName => 'Име и презиме';

  @override
  String get firstNameHint => 'Унесите име и презиме';

  @override
  String get nameMinLength => 'Име мора имати најмање 2 знака';

  @override
  String get nameOnlyLetters => 'Дозвољена су само слова и цртице';

  @override
  String get email => 'Имејл адреса';

  @override
  String get emailHint => 'Унесите имејл';

  @override
  String get emailInvalid => 'Унесите важећи имејл';

  @override
  String get passwordMinLength => 'Лозинка мора имати најмање 6 знакова';

  @override
  String get passwordsNotMatch => 'Лозинке се не подударају';

  @override
  String get registrationFailed => 'Регистрација није успела';

  @override
  String connectionError(String error) {
    return 'Грешка повезивања: $error';
  }

  @override
  String registrationSuccess(String memberNumber) {
    return 'Успешна регистрација!\n\nВаш број члана: $memberNumber\n\nЗапамтите овај број за пријаву.';
  }

  @override
  String get unknown => 'Непознато';

  @override
  String error(String error) {
    return 'Грешка: $error';
  }

  @override
  String get cancel => 'Откажи';

  @override
  String get resetPassword => 'Поништи лозинку';

  @override
  String get imprint => 'Импресум';

  @override
  String get privacy => 'Политика приватности';

  @override
  String get statutes => 'Статут';

  @override
  String get revocation => 'Право повлачења';

  @override
  String get appointments => 'Састанци';

  @override
  String get tickets => 'Захтеви';

  @override
  String get liveChat => 'Ћаскање уживо';

  @override
  String get notifications => 'Обавештења';

  @override
  String get myProfile => 'Мој профил';

  @override
  String get logout => 'Одјава';

  @override
  String get goodMorning => 'Добро јутро';

  @override
  String get goodDay => 'Добар дан';

  @override
  String get goodEvening => 'Добро вече';

  @override
  String get goodNight => 'Лаку ноћ';

  @override
  String get welcomeToICD => 'Добродошли у ICD360S e.V!';

  @override
  String get accountCreatedSuccessfully => 'Ваш налог је успешно креиран.';

  @override
  String get today => 'Данас';

  @override
  String get membershipFeeDue => 'Чланарина доспела';

  @override
  String get pleaseTransferAnnualFee => 'Молимо пренесите годишњу чланарину.';

  @override
  String get newBadge => 'Ново';

  @override
  String get close => 'Затвори';

  @override
  String get myAppointments => 'Моји састанци';

  @override
  String get priority => 'Приоритет';

  @override
  String get messageLabel => 'Порука';

  @override
  String get reportProblems => 'Пријавите проблеме';

  @override
  String get weRespondIn24Hours =>
      'Одговорићемо вам у року од максимално 24 сата!';

  @override
  String get everythingOk => 'Све је у реду!';

  @override
  String get haveProblemWeHelp => 'Имате проблем?\nМи ћемо се побринути!';

  @override
  String get myMembership => 'Моје чланство';

  @override
  String get managePersonalDataAndFee =>
      'Управљање личним подацима и чланарином';

  @override
  String get myAppointmentsTitle => 'Моји термини';

  @override
  String get appointmentsDescription =>
      'Овде можете видети своје предстојеће термине.\nМожете потврдити своје учешће или одбити.';

  @override
  String get loadAppointments => 'Учитај термине';

  @override
  String get myTickets => 'Моји тикети';

  @override
  String get low => 'Ниско';

  @override
  String get high => 'Високо';

  @override
  String get submit => 'Пошаљи';

  @override
  String get errorCreatingTicket => 'Грешка при креирању тикета';

  @override
  String get verified => 'Верификовано';

  @override
  String get account => 'Налог';

  @override
  String get myDevices => 'Моји уређаји';

  @override
  String get changeEmail => 'Промени е-пошту';

  @override
  String get changePassword => 'Промени лозинку';

  @override
  String get saveEmail => 'Сачувај е-пошту';

  @override
  String get savePassword => 'Сачувај лозинку';

  @override
  String get deviceLoggedOut => 'Уређај одјављен';

  @override
  String get emailChangedSuccessfully => 'Е-пошта успешно промењена';

  @override
  String get errorChangingPassword => 'Грешка при промени лозинке';

  @override
  String get errorChangingEmail => 'Грешка при промени е-поште';

  @override
  String get validEmailRequired => 'Молимо унесите важећу адресу е-поште';

  @override
  String get confirmLogoutDevice => 'Одјавити уређај?';

  @override
  String get confirmLogoutMessage =>
      'Желите ли да се одјавите са овог уређаја?\n\nМораћете се поново пријавити да бисте користили овај уређај.';

  @override
  String get ipAddress => 'IP';

  @override
  String get platform => 'Платформа';

  @override
  String trialWarningUrgentTitle(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days дана',
      few: '$days дана',
      one: '1 дан',
    );
    return 'Пажња: Преостало је $_temp0 до суспензије налога!';
  }

  @override
  String get trialWarningTitle => 'Ваш налог још није верификован';

  @override
  String get trialWarningDescription =>
      'Молимо попуните своје податке у \"Мој профил\". После 30 дана ваш налог ће бити аутоматски суспендован.';

  @override
  String trialDaysRemaining(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days дана',
      few: '$days дана',
      one: '1 дан',
    );
    return '$_temp0';
  }

  @override
  String get overview => 'Преглед';

  @override
  String get member => 'Члан';

  @override
  String get memberManagement => 'Управљање члановима';

  @override
  String get reportProblemTooltip => 'Пријавите проблем';

  @override
  String get newAppointmentsTitle => 'Нови састанци';

  @override
  String get youHaveNewAppointment => 'Имате нови састанак.';

  @override
  String youHaveNewAppointments(int count) {
    return 'Имате $count нових састанака.';
  }

  @override
  String get appointmentReminderTomorrow => 'Подсетник: Састанак сутра';

  @override
  String tomorrowAppointment(String title) {
    return 'Сутра: $title';
  }

  @override
  String youHaveTomorrowAppointments(int count) {
    return 'Имате $count састанака сутра.';
  }

  @override
  String get appointmentsToday => 'Састанци данас';

  @override
  String todayAppointment(String title) {
    return 'Данас: $title';
  }

  @override
  String youHaveTodayAppointments(int count) {
    return 'Имате $count састанака данас.';
  }

  @override
  String get paymentReminder => 'Подсетник за плаћање';

  @override
  String paymentReminderMessage(int day, String method) {
    return 'Данас је $day. дан у месецу – молимо завршите $method.';
  }

  @override
  String get paymentDayLabel => 'Дан плаћања (месечни подсетник)';

  @override
  String get updateAvailable => 'Ажурирање доступно';

  @override
  String newVersionAvailable(String version) {
    return 'Нова верзија је доступна: $version';
  }

  @override
  String currentVersionLabel(String version) {
    return 'Тренутна верзија: $version';
  }

  @override
  String get changes => 'Промене:';

  @override
  String downloadProgress(String percent) {
    return 'Преузимање: $percent%';
  }

  @override
  String get installationStarting => 'Покретање инсталације...';

  @override
  String get appWillRestart => 'Апликација ће се аутоматски поново покренути.';

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
  String get later => 'Касније';

  @override
  String get updateNow => 'Ажурирај сада';

  @override
  String get downloading => 'Преузимање...';

  @override
  String get downloadFailed =>
      'Преузимање није успело. Покушајте поново касније.';

  @override
  String get searchingForUpdates => 'Тражење ажурирања...';

  @override
  String get appUpToDate => 'Апликација је ажурна';

  @override
  String get updateCheckError => 'Грешка при провери ажурирања';

  @override
  String get changelog => 'Дневник промена';

  @override
  String get terminConfirmed => 'Термин потврђен';

  @override
  String get terminDeclined => 'Термин одбијен';

  @override
  String get terminRescheduleRequested => 'Затражено одлагање';

  @override
  String get statusConfirmed => 'Потврђено';

  @override
  String get statusDeclined => 'Одбијено';

  @override
  String get statusRescheduling => 'Одлагање';

  @override
  String get statusPending => 'На чекању';

  @override
  String get categoryVorstandssitzung => 'Седница управе';

  @override
  String get categoryMitgliederversammlung => 'Скупштина чланова';

  @override
  String get categorySchulung => 'Обука';

  @override
  String get categorySonstiges => 'Остало';

  @override
  String openCount(int count) {
    return '$count отворених';
  }

  @override
  String get refresh => 'Освежи';

  @override
  String get filterUpcoming => 'Предстојећи';

  @override
  String get filterPast => 'Прошли';

  @override
  String get filterAll => 'Сви';

  @override
  String get noUpcomingAppointments => 'Нема предстојећих термина';

  @override
  String get noPastAppointments => 'Нема прошлих термина';

  @override
  String get noAppointmentsAvailable => 'Нема термина';

  @override
  String get appointmentsShownHere => 'Ваши термини ће бити приказани овде';

  @override
  String get dateLabel => 'Датум';

  @override
  String get timeLabel => 'Време';

  @override
  String get locationLabel => 'Место';

  @override
  String get createdByLabel => 'Креирао';

  @override
  String get descriptionLabel => 'Опис';

  @override
  String get ticketLabel => 'Захтев';

  @override
  String get yourStatus => 'Ваш статус: ';

  @override
  String reasonLabel(String reason) {
    return 'Разлог: $reason';
  }

  @override
  String durationMinutes(int minutes) {
    return '$minutes мин';
  }

  @override
  String get confirm => 'Потврди';

  @override
  String get decline => 'Одбиј';

  @override
  String get reschedule => 'Одложи';

  @override
  String get requestReschedule => 'Затражи одлагање';

  @override
  String appointmentLabel(String title) {
    return 'Термин: $title';
  }

  @override
  String get rescheduleReason => 'Разлог одлагања *';

  @override
  String get rescheduleReasonHint => 'Наведите разлог...';

  @override
  String get pleaseProvideReason => 'Наведите разлог';

  @override
  String get request => 'Затражи';

  @override
  String get ticketStatusOpen => 'Отворено';

  @override
  String get ticketStatusInProgress => 'У обради';

  @override
  String get ticketStatusWaitingMember => 'Чека се члан';

  @override
  String get ticketStatusWaitingStaff => 'Чека се запослени';

  @override
  String get ticketStatusWaitingAuthority => 'Чека се установа';

  @override
  String get ticketStatusDone => 'Завршено';

  @override
  String get ticketPriorityHigh => 'Висок';

  @override
  String get ticketPriorityMedium => 'Средњи';

  @override
  String get ticketPriorityLow => 'Низак';

  @override
  String get comments => 'Коментари';

  @override
  String get documents => 'Документи';

  @override
  String get details => 'Детаљи';

  @override
  String get replySent => 'Одговор послат';

  @override
  String get sendError => 'Грешка при слању';

  @override
  String get uploading => 'Отпремање...';

  @override
  String fileUploaded(String filename) {
    return '$filename отпремљен';
  }

  @override
  String get uploadFailed => 'Отпремање неуспешно';

  @override
  String get openError => 'Грешка при отварању';

  @override
  String get noRepliesYet => 'Још нема одговора';

  @override
  String get waitingForSupport => 'Чека се одговор подршке';

  @override
  String get writeReply => 'Напишите одговор...';

  @override
  String get attachFile => 'Приложи датотеку';

  @override
  String documentsCount(int count) {
    return 'Документи ($count)';
  }

  @override
  String get upload => 'Отпреми';

  @override
  String get noDocuments => 'Нема докумената';

  @override
  String get allowedFormats => 'Дозвољени формати: PDF, JPEG, JPG, TXT, ZIP';

  @override
  String get yourMessage => 'Ваша порука:';

  @override
  String get translation => 'Превод';

  @override
  String get original => 'Оригинал';

  @override
  String get originalText => 'Оригинални текст';

  @override
  String get autoTranslated => 'Аутоматски преведено';

  @override
  String get originalTapTranslation => 'Оригинал · Додирните за превод';

  @override
  String get translatedTapOriginal => 'Преведено · Додирните за оригинал';

  @override
  String get justNow => 'Управо';

  @override
  String minutesAgo(int minutes) {
    return 'пре $minutes мин';
  }

  @override
  String hoursAgo(int hours) {
    return 'пре $hours ч';
  }

  @override
  String daysAgo(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'дана',
      one: 'дан',
    );
    return 'пре $days $_temp0';
  }

  @override
  String get createdLabel => 'Креирано';

  @override
  String get updatedLabel => 'Ажурирано';

  @override
  String get handlerLabel => 'Обрађивач';

  @override
  String get doneLabel => 'Завршено';

  @override
  String get newTicketTitle => 'Нови захтев';

  @override
  String get categoryOptional => 'Категорија (необавезно)';

  @override
  String get selectCategory => 'Изабери';

  @override
  String get subjectLabel => 'Предмет';

  @override
  String get fillAllFields => 'Попуните сва поља';

  @override
  String ticketCreatedId(int id) {
    return 'Захтев #$id креиран';
  }

  @override
  String get priorityLabel => 'Приоритет: ';

  @override
  String get supportOffline => 'Подршка офлајн';

  @override
  String get lastSeenSeconds => 'Активан пре неколико секунди';

  @override
  String lastSeenMinutes(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: 'минута',
      one: 'минут',
    );
    return 'Активан пре $minutes $_temp0';
  }

  @override
  String lastSeenHours(int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: 'сати',
      one: 'сат',
    );
    return 'Активан пре $hours $_temp0';
  }

  @override
  String lastSeenDays(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'дана',
      one: 'дан',
    );
    return 'Активан пре $days $_temp0';
  }

  @override
  String get online => 'Онлајн';

  @override
  String get callSupport => 'Позови';

  @override
  String get typeMessage => 'Напишите поруку...';

  @override
  String get callBusy => 'Подршка је заузета';

  @override
  String get callRejected => 'Позив је одбијен';

  @override
  String get callFailed => 'Позив није успео';

  @override
  String get callEnded => 'Позив завршен';

  @override
  String get callSupportBusy => 'Подршка је већ у другом позиву';

  @override
  String get errorStartingChat => 'Грешка при покретању чата';

  @override
  String get errorStartingCall => 'Грешка при покретању позива';

  @override
  String get errorConnecting => 'Грешка при повезивању';

  @override
  String get errorDownloading => 'Грешка при преузимању';

  @override
  String get errorUploading => 'Грешка при отпремању';

  @override
  String get errorSending => 'Грешка при слању';

  @override
  String get errorPickingPhotos => 'Грешка при одабиру фотографија';

  @override
  String get errorPickingFiles => 'Грешка при одабиру датотека';

  @override
  String get errorTakingPhoto => 'Грешка при фотографисању';

  @override
  String get fileNotLoaded => 'Датотека се не може учитати';

  @override
  String get attachmentIdMissing => 'Недостаје ID прилога';

  @override
  String get camera => 'Камера';

  @override
  String get gallery => 'Галерија';

  @override
  String get file => 'Датотека';

  @override
  String get notifNewMessageFrom => 'Нова порука од';

  @override
  String get notifUrgentPrefix => 'ХИТНО';

  @override
  String get notifUrgentMessage => 'ХИТНА ПОРУКА';

  @override
  String get notifIncomingCall => 'Долазни позив';

  @override
  String get notifCallingYou => 'зове...';

  @override
  String get notifUpdateAvailable => 'Ажурирање доступно';

  @override
  String get notifVersionAvailable => 'је сада доступна';

  @override
  String get notifConnected => 'Повезано';

  @override
  String get notifDisconnected => 'Прекинуто';

  @override
  String get notifConnectedBody => 'Повезани сте са сервером.';

  @override
  String get notifDisconnectedBody => 'Веза са сервером је прекинута.';

  @override
  String get notifError => 'Грешка';

  @override
  String get retry => 'Покушај поново';

  @override
  String get save => 'Сачувај';

  @override
  String get accept => 'Прихвати';

  @override
  String get selectFile => 'Изабери датотеку';

  @override
  String get dataLoadingText => 'Учитавање података...';

  @override
  String get dataSavedSuccess => 'Подаци успешно сачувани';

  @override
  String get errorSaving => 'Грешка при чувању';

  @override
  String get errorLoading => 'Грешка при учитавању';

  @override
  String savedFilename(String filename) {
    return 'Сачувано: $filename';
  }

  @override
  String get logsCopied => 'Логови копирани!';

  @override
  String get passwordMinEightChars => 'Лозинка мора имати најмање 8 знакова';

  @override
  String get passwordChangeSuccess => 'Лозинка успешно промењена';

  @override
  String get emailChangeError => 'Грешка при промени е-маила';

  @override
  String get acceptDocumentCheckbox => 'Прочитао сам и прихватам документ.';

  @override
  String loadingErrorGeneric(String details) {
    return 'Грешка при учитавању: $details';
  }

  @override
  String get incomingCallTitle => 'Долазни позив';

  @override
  String ringingFor(int seconds) {
    return 'Звони $secondsс';
  }

  @override
  String get rejectCall => 'Одбиј';

  @override
  String get acceptCall => 'Прихвати';

  @override
  String get unmute => 'Укључи звук';

  @override
  String get mute => 'Искључи звук';

  @override
  String get hangUp => 'Прекини';

  @override
  String get calling => 'Позивање...';

  @override
  String autoRejectIn(int seconds) {
    return 'Аутоматско одбијање за $seconds секунди';
  }

  @override
  String get speakerOn => 'Звучник';

  @override
  String get speakerOff => 'Слушалица';

  @override
  String get micMuted => 'Искључен';

  @override
  String get micOn => 'Микрофон';

  @override
  String get connectionExcellent => 'Одлично';

  @override
  String get connectionGood => 'Добро';

  @override
  String get connectionWeak => 'Слабо';

  @override
  String get connectionLost => 'Прекинуто';

  @override
  String get personalData => 'Лични подаци';

  @override
  String get personalDataSubtitle => 'Име, презиме, адреса';

  @override
  String get membershipFee => 'Чланарина';

  @override
  String annualFeeYear(String year) {
    return 'Годишња чланарина $year';
  }

  @override
  String get amount => 'Износ:';

  @override
  String get dueBy => 'Рок:';

  @override
  String get paid => 'Плаћено';

  @override
  String get versionHistory => 'Историја верзија';

  @override
  String lastUpdated(String date) {
    return 'Последње ажурирање: $date';
  }

  @override
  String get noVersionHistory => 'Нема доступне историје';

  @override
  String get failedLoadChangelog => 'Учитавање дневника није успело';

  @override
  String get callMember => 'Позови члана';

  @override
  String get closeConversation => 'Затвори разговор';

  @override
  String get chatOffline => 'Офлајн';

  @override
  String get attachFiles => 'Приложи датотеке (макс. 10, 50MB)';

  @override
  String get conversationClosed => 'Овај разговор је затворен';

  @override
  String get noMessages => 'Нема порука';

  @override
  String get goBack => 'Назад';

  @override
  String get goForward => 'Напред';

  @override
  String get homePage => 'Почетна';

  @override
  String get firstNameLabel => 'Име';

  @override
  String get lastNameLabel => 'Презиме';

  @override
  String get streetLabel => 'Улица';

  @override
  String get houseNumberLabel => 'Бр.';

  @override
  String get postalCodeLabel => 'Поштански број';

  @override
  String get cityLabel => 'Град';

  @override
  String get phoneMobileLabel => 'Телефон (Мобилни)';

  @override
  String get phoneLandlineLabel => 'Телефон (Фиксни)';

  @override
  String get newEmailLabel => 'Нова е-маил адреса';

  @override
  String get currentPasswordLabel => 'Тренутна лозинка';

  @override
  String get newPasswordLabel => 'Нова лозинка';

  @override
  String get confirmPasswordLabel => 'Потврди лозинку';

  @override
  String get emailChangedSuccess => 'Е-маил успешно промењен';

  @override
  String get reasonLabel2 => 'Разлог';

  @override
  String get downloadFailed2 => 'Преузимање неуспешно';

  @override
  String get downloadTooltip => 'Преузми';

  @override
  String get copyLogs => 'Копирај логове';

  @override
  String get deleteLogs => 'Обриши логове';

  @override
  String get autoScrollOn => 'Аутоматско померање УКЉ';

  @override
  String get autoScrollOff => 'Аутоматско померање ИСКЉ';

  @override
  String get unknownValue => 'Непознато';

  @override
  String get payment => 'Плаћање';

  @override
  String get warningType_ermahnung => 'Опомена';

  @override
  String get warningType_abmahnung => 'Упозорење';

  @override
  String get warningType_letzte => 'Последње упозорење';

  @override
  String warningsTotal(int count) {
    return 'Укупно: $count';
  }

  @override
  String warningsErmahnung(int count) {
    return 'Опомене: $count';
  }

  @override
  String warningsAbmahnung(int count) {
    return 'Упозорења: $count';
  }

  @override
  String warningsLetzte(int count) {
    return 'Последње: $count';
  }

  @override
  String get noWarnings => 'Нема опомена';

  @override
  String get noWarningsDescription => 'Тренутно немате опомена.';

  @override
  String createdBy(String name) {
    return 'Креирао: $name';
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
  String get monthMay => 'Maj';

  @override
  String get monthJun => 'Jun';

  @override
  String get monthJul => 'Jul';

  @override
  String get monthAug => 'Avg';

  @override
  String get monthSep => 'Sep';

  @override
  String get monthOct => 'Okt';

  @override
  String get monthNov => 'Nov';

  @override
  String get monthDec => 'Dec';

  @override
  String get stufe1_name => 'Лични подаци';

  @override
  String get stufe2_name => 'Врста чланства';

  @override
  String get stufe3_name => 'Финансијска ситуација';

  @override
  String get stufe4_name => 'Начин плаћања';

  @override
  String get stufe5_name => 'Почетак чланства';

  @override
  String get stufe6_name => 'Статут';

  @override
  String get stufe7_name => 'Политика приватности';

  @override
  String get stufe8_name => 'Право на одустајање';

  @override
  String get memberType_ordentlich => 'Редовни члан';

  @override
  String get memberType_foerder => 'Подржавајући члан';

  @override
  String get memberType_ehren => 'Почасни члан';

  @override
  String get memberDesc_ordentlich =>
      'Активни члан са правом гласа. Учествује у услугама удружења (имејл, облак, бирократска подршка).';

  @override
  String get memberDesc_foerder =>
      'Подржава удружење доприносима. Може присуствовати скупштини са саветодавним гласом, без права гласа или избора у управу.';

  @override
  String get memberDesc_ehren =>
      'Има права редовног члана без обавезе плаћања чланарине. Именован од стране скупштине или управе.';

  @override
  String get payMethod_ueberweisung => 'Банковни пренос';

  @override
  String get payMethod_dauerauftrag => 'Трајни налог';

  @override
  String get verifyStatus_geprueft => 'Проверено';

  @override
  String get verifyStatus_ausgefuellt => 'Попуњено';

  @override
  String get verifyStatus_abgelehnt => 'Одбијено';

  @override
  String get verifyStatus_offen => 'Отворено';

  @override
  String get fillRequiredFields => 'Попуните сва обавезна поља.';

  @override
  String get personalDataSaved => 'Лични подаци сачувани';

  @override
  String get selectMemberType => 'Одаберите врсту чланства.';

  @override
  String get memberTypeSaved => 'Врста чланства сачувана';

  @override
  String get selectOption => 'Одаберите опцију.';

  @override
  String get financialSaved => 'Финансијска ситуација сачувана';

  @override
  String get selectPaymentMethod => 'Одаберите начин плаћања.';

  @override
  String get paymentDataSaved => 'Подаци о плаћању сачувани';

  @override
  String get selectDate => 'Одаберите датум.';

  @override
  String get membershipStartSaved => 'Почетак чланства сачуван';

  @override
  String get fileTooLarge => 'Датотека превелика (макс. 10 MB).';

  @override
  String get leistungsbescheidUploaded =>
      'Решење о накнадама успешно отпремљено';

  @override
  String get verificationProgress => 'Напредак провере';

  @override
  String get notApplicable => 'Није применљиво';

  @override
  String get socialBenefitsExempt =>
      'Начин плаћања није потребан за примаоце социјалних накнада.';

  @override
  String get locked => 'Закључано';

  @override
  String completePreviousStep(int step) {
    return 'Прво довршите корак $step.';
  }

  @override
  String rejectedNote(String note) {
    return 'Одбијено: $note';
  }

  @override
  String get waitingForReview => 'Чека преглед управе.';

  @override
  String get stepApproved => 'Овај корак је прегледан и одобрен.';

  @override
  String get changesViaChat => 'Промене могуће само путем чата.';

  @override
  String get firstNameRequired => 'Име *';

  @override
  String get lastNameRequired => 'Презиме *';

  @override
  String get birthDateLabel => 'Датум рођења *';

  @override
  String get streetRequired => 'Улица *';

  @override
  String get houseNumberRequired => 'Бр. *';

  @override
  String get cityRequired => 'Град *';

  @override
  String get phoneRequired => 'Телефонски број *';

  @override
  String get phonePurpose =>
      'Сврха: Контакт када нисте доступни путем апликације';

  @override
  String get selectMemberTypePrompt => 'Одаберите жељену врсту чланства:';

  @override
  String get financialExplanation =>
      'Да бисмо проверили да ли имате право на смањење чланарине, потребне су нам следеће информације. Користиће се искључиво за одређивање ваше чланарине.';

  @override
  String get socialBenefitsQuestion =>
      'Да ли тренутно примате социјалне накнаде?';

  @override
  String get optionBuergergeld => 'Да, грађанска накнада (Job Center)';

  @override
  String get optionSozialamt => 'Да, социјална помоћ (Социјална служба)';

  @override
  String get optionNoBenefits => 'Не, не примам социјалне накнаде';

  @override
  String get feeExempt => 'Ваша месечна чланарина је: 0,00 €/месец';

  @override
  String get uploadLeistungsbescheid => 'Отпремите решење о накнадама';

  @override
  String get uploadLeistungsbescheidHint =>
      'Отпремите актуелно решење о накнадама у року од 14 дана за потврду ослобађања од чланарине.';

  @override
  String get allowedFormatsUpload =>
      'Дозвољени формати: PDF, JPG, PNG (макс. 10 MB)';

  @override
  String get feeRegular => 'Ваша месечна чланарина је: 25,00 €/месец';

  @override
  String paymentDayReminder(int day) {
    return 'Бићете подсећани $day. дана сваког месеца.';
  }

  @override
  String get membershipStartPrompt =>
      'Одаберите када треба да почне ваше чланство.';

  @override
  String get optionAfterVerification => 'Након завршетка провере';

  @override
  String get optionAfterVerificationDesc =>
      'Чланство почиње од дана потврде управе.';

  @override
  String get optionRetroFoundation =>
      'Ретроактивно до датума оснивања (01.08.2025)';

  @override
  String get optionRetroFoundationDesc =>
      'Постајете ретроактивни члан од оснивања удружења.';

  @override
  String get optionRetroCustom => 'Ретроактивно до другог датума';

  @override
  String get optionRetroCustomDesc =>
      'Одаберите датум између 01.08.2025. и данас.';

  @override
  String get selectDateLabel => 'Одаберите датум';

  @override
  String get selectDateHint => 'Одаберите датум...';

  @override
  String get dateNotBefore => 'Не пре 01.08.2025. (датум оснивања)';

  @override
  String get feeExemptRetro =>
      'Ослобађање од чланарине: 0,00 € ретроактивно.\nСамо датум чланства се поставља ретроактивно.';

  @override
  String get retroactiveFees => 'Ретроактивне чланарине';

  @override
  String retroFeeCalculation(
      String from, String to, String months, String total) {
    return 'Период: $from – $to\nМесеци: $months\nЧланарина: $months × 25,00 € = $total €';
  }

  @override
  String get pleaseReadSatzung => 'Прочитајте статут удружења.';

  @override
  String get pleaseReadDatenschutz => 'Прочитајте политику приватности.';

  @override
  String get pleaseReadWiderruf => 'Прочитајте право на одустајање.';

  @override
  String get acceptedAtRegistration => 'Прихваћено при регистрацији';

  @override
  String get confirmedByBoard => 'Биће потврђено након прегледа управе.';

  @override
  String get docSatzung => 'Статут';

  @override
  String get docDatenschutz => 'Политика приватности';

  @override
  String get docWiderruf => 'Право на одустајање';

  @override
  String acceptedAtRegCount(int count) {
    return 'Прихваћено при регистрацији ($count/3)';
  }

  @override
  String acceptedOn(String date) {
    return 'Прихваћено дана $date';
  }

  @override
  String get notAccepted => 'Није прихваћено';

  @override
  String get statusAccepted => 'Прихваћено';

  @override
  String get nameTooLong => 'Име предуго (макс. 100 знакова)';

  @override
  String get emailTooLong => 'Имејл предуг (макс. 255 знакова)';

  @override
  String get legalAcknowledgePrefix => 'Прочитао/ла сам ';

  @override
  String get legalAcknowledgeSuffix => '.';

  @override
  String get legalStatutesSuffix =>
      ' ICD360S e.V. и признајем их као обавезујуће.';

  @override
  String get legalPleaseReadFirst => '(молимо прво прочитајте)';

  @override
  String get statusActive => 'Активан';

  @override
  String get statusSuspended => 'Суспендован';

  @override
  String get statusNew => 'Ново';

  @override
  String get statusCancelled => 'Отказано';

  @override
  String get statusDeleted => 'Обрисано';

  @override
  String get roleMitglied => 'Члан';

  @override
  String get roleVorsitzer => 'Председник';

  @override
  String get roleStellvertreter => 'Заменик';

  @override
  String get roleSchatzmeister => 'Благајник';

  @override
  String get roleSchriftfuehrer => 'Секретар';

  @override
  String get roleBeisitzer => 'Заседатељ';

  @override
  String get roleKassierer => 'Касир';

  @override
  String get roleKassenpruefer => 'Ревизор';

  @override
  String get roleEhrenamtlich => 'Волонтер';

  @override
  String get roleMitgliedergruender => 'Оснивач';

  @override
  String get roleEhrenmitglied => 'Почасни члан';

  @override
  String get roleFoerdermitglied => 'Подржавајући члан';

  @override
  String get memberTypeNotSet => 'Још није одређено';

  @override
  String get payMethodSepa => 'SEPA директно задужење';

  @override
  String get labelStatus => 'Статус';

  @override
  String get labelMemberNumber => 'Члански број';

  @override
  String get labelRole => 'Улога';

  @override
  String get labelMemberType => 'Врста чланства';

  @override
  String get labelPaymentMethod => 'Начин плаћања';

  @override
  String get labelRegisteredOn => 'Регистровано';

  @override
  String get labelLastLogin => 'Последња пријава';

  @override
  String get labelMemberSince => 'Члан од';

  @override
  String get neverLoggedIn => 'Никада';

  @override
  String get notActivatedYet => 'Још није активирано';

  @override
  String get tabVerification => 'Верификација';

  @override
  String get tabWarnings => 'Упозорења';

  @override
  String get tabDocuments => 'Документи';

  @override
  String get tabMembership => 'Чланство';

  @override
  String get pleaseEnterFirstName => 'Унесите име';

  @override
  String get pleaseEnterLastName => 'Унесите презиме';

  @override
  String get noFileDataReceived => 'Нису примљени подаци';

  @override
  String get openFile => 'Отвори';

  @override
  String get noMicrophoneError =>
      'Микрофон није пронађен. Повежите микрофон и покушајте поново.';

  @override
  String get startConversation => 'Започните разговор!';

  @override
  String get staffWillReply => 'Запослени ће вам ускоро одговорити.';

  @override
  String get inCall => 'У позиву...';

  @override
  String get registration => 'Регистрација';

  @override
  String get deactivation => 'Деактивација';

  @override
  String get deactivatedOn => 'Деактивирано';

  @override
  String get accountAutoSuspend =>
      'Налози који нису верификовани у року од 30 дана биће аутоматски суспендовани.';

  @override
  String get documentsProvidedByBoard => 'Документе обезбеђује управа.';

  @override
  String get noDocumentsAvailable => 'Нема докумената';

  @override
  String get noDocumentsDescription => 'Још нису достављени документи за вас.';

  @override
  String uploadedBy(String name) {
    return 'Отпремио: $name';
  }

  @override
  String stepsCompleted(int completed, int total) {
    return '$completed/$total корака завршено';
  }

  @override
  String dayOfMonth(int day) {
    return '$day. у месецу';
  }

  @override
  String changeField(String field) {
    return 'Промени $field';
  }

  @override
  String openDocument(String name) {
    return 'Отвори $name';
  }

  @override
  String logEntries(int count) {
    return '$count записа';
  }

  @override
  String get noLogs => 'Нема записа';

  @override
  String get newLoginDetected => 'Откривена нова пријава';

  @override
  String get errorNoInternet => 'Нема интернет везе. Проверите мрежу.';

  @override
  String get errorTimeout => 'Сервер не одговара. Покушајте касније.';

  @override
  String get errorServer => 'Грешка сервера. Покушајте касније.';

  @override
  String get errorConnection => 'Грешка повезивања. Покушајте касније.';

  @override
  String get errorUnexpected =>
      'Дошло је до неочекиване грешке. Покушајте касније.';

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
  String get claudiuWelcomeMorning => 'Добро јутро';

  @override
  String get claudiuWelcomeDay => 'Здраво';

  @override
  String get claudiuWelcomeEvening => 'Добро вече';

  @override
  String get claudiuWelcomeNight => 'Добро вече';

  @override
  String get claudiuWelcomeVisitor => 'драги посетиоче';

  @override
  String get claudiuWelcomeAsk => 'Како могу да помогнем?';

  @override
  String get claudiuWelcomeBecomeMember => 'Желим да постанем члан';

  @override
  String get claudiuWelcomeLogin => 'Већ сам члан и желим да се пријавим';

  @override
  String get claudiuWelcomeProblem => 'Имам проблем са апликацијом';

  @override
  String get claudiuWelcomeEmergency => 'Хитно — позовите нас';

  @override
  String get claudiuWelcomeMascotName => 'Claudiu';

  @override
  String get claudiuWelcomeEmergencyIntro =>
      'Пре него што позовеш — наше радно време:';

  @override
  String get claudiuWelcomeScheduleOffice => 'У канцеларији';

  @override
  String get claudiuWelcomeScheduleField => 'На терену са клијентима';

  @override
  String get claudiuWelcomeOutsideHoursNote =>
      'Ван овог времена решавамо само хитне случајеве. Можеш да нам пошаљеш и SMS на исти број — јавићемо се.';

  @override
  String get claudiuWelcomeCallNow => 'Позови сада';

  @override
  String get claudiuWelcomeSendSms => 'Пошаљи SMS';

  @override
  String get claudiuWelcomeSmsBody =>
      'Хитно ICD360S e.V. — молим вас да ме контактирате што пре.';

  @override
  String get claudiuWelcomeCloseButton => 'Затвори';

  @override
  String get claudiuLoginWelcome => 'Добро дошао назад, драги члане!';

  @override
  String get claudiuLoginAsk => 'Молим те, реци ми свој члански број.';

  @override
  String get claudiuLoginProgress => 'Скоро… настави да куцаш.';

  @override
  String get claudiuLoginReady => 'Савршено! Притисни дугме испод.';

  @override
  String get claudiuLoginLoading => 'Проверавам идентитет… 🔍';

  @override
  String get claudiuLoginFoundPlain => 'Нашао сам те! Пријављујем те…';

  @override
  String claudiuLoginFoundNamed(String name) {
    return 'Нашао сам те, $name! Пријављујем те…';
  }

  @override
  String get claudiuLoginError =>
      'Хм, не могу да нађем тај број. Да ли си га исправно унео?';

  @override
  String get claudiuLoginForgotHeader => 'Заборавио си члански број?';

  @override
  String get claudiuLoginNoSms => 'Број не шаљемо мејлом ни SMS-ом.';

  @override
  String get claudiuLoginOnlyWay =>
      'Једини начин: лични састанак у канцеларији удружења, након провере личне карте.';

  @override
  String get claudiuLoginContactUs => 'Позови да закажеш термин:';

  @override
  String get claudiuDiagnosticGreeting =>
      'Пре него што уђеш, једно брзо питање';

  @override
  String get claudiuDiagnosticAsk =>
      'Могу ли да шаљем анонимне извештаје како би програмери побољшали апликацију?';

  @override
  String get claudiuDiagnosticYes => 'Да, желим да помогнем';

  @override
  String get claudiuDiagnosticNo => 'Не, само разгледам';

  @override
  String get claudiuDiagnosticTellMore => 'Реци ми више';

  @override
  String get claudiuDiagnosticSendsHeader => '📤 Шта ШАЉЕМО (анонимно):';

  @override
  String get claudiuDiagnosticSends1 =>
      'Анонимни код уређаја (НЕ члански број)';

  @override
  String get claudiuDiagnosticSends2 => 'Твоја улога (члан / управа)';

  @override
  String get claudiuDiagnosticSends3 =>
      'Оперативни систем (Linux / Android / iOS / Windows)';

  @override
  String get claudiuDiagnosticSends4 => 'Изабрани језик';

  @override
  String get claudiuDiagnosticSends5 => 'Ниво и стање батерије';

  @override
  String get claudiuDiagnosticSends6 => 'Тренутни екран';

  @override
  String get claudiuDiagnosticSends7 => 'Трајање сесије (секунде)';

  @override
  String get claudiuDiagnosticSends8 => 'Грешке ако постоје (последњих 10)';

  @override
  String get claudiuDiagnosticSends9 => 'Навигација (последњих 20 екрана)';

  @override
  String get claudiuDiagnosticNeverHeader => '🛡️ Шта НИКАДА не шаљемо:';

  @override
  String get claudiuDiagnosticNever1 => 'Твоје право име';

  @override
  String get claudiuDiagnosticNever2 => 'Имејл адреса';

  @override
  String get claudiuDiagnosticNever3 => 'Број телефона';

  @override
  String get claudiuDiagnosticNever4 => 'Лозинка';

  @override
  String get claudiuDiagnosticNever5 => 'Садржај поруке ћаскања';

  @override
  String get claudiuDiagnosticNever6 => 'Садржај тикета';

  @override
  String get claudiuDiagnosticNever7 => 'Документи или прилози';

  @override
  String get claudiuDiagnosticTechHeader => '📡 Технички детаљи:';

  @override
  String get claudiuDiagnosticTech1 => 'Шаље се на свака 2 минута';

  @override
  String get claudiuDiagnosticTech2 =>
      'TLS-шифрована веза са причвршћеним сертификатом';

  @override
  String get claudiuDiagnosticTech3 =>
      'Можеш искључити у било ком тренутку у Подешавањима';

  @override
  String get claudiuProblemHelpTitle => 'Како могу да помогнем?';

  @override
  String get claudiuProblemHelpGreeting => 'Шта се десило?';

  @override
  String get claudiuProblemHelpAsk => 'Како желиш да ми кажеш?';

  @override
  String get claudiuProblemHelpWriteTitle => 'Напиши извештај';

  @override
  String get claudiuProblemHelpWriteBody =>
      'Са детаљима корак по корак. Тим добија текст и решава га касније.';

  @override
  String get claudiuProblemHelpChatTitle => 'Разговарајмо одмах';

  @override
  String get claudiuProblemHelpChatBody =>
      'Анонимни ћаскање са оператером. Одговор у реалном времену ако је неко онлајн.';

  @override
  String get claudiuProblemHelpAltCallHeader => 'Или, ако је хитно:';

  @override
  String get claudiuProblemHelpAltCallLabel => 'Позови нас';

  @override
  String get claudiuAnonymousChatTitle => 'Анонимно ћаскање';

  @override
  String get claudiuAnonymousChatGreeting => 'Здраво!';

  @override
  String get claudiuAnonymousChatWelcome =>
      'Слушам те. Пиши шта год — име не треба. Одговорићу чим будем овде.';

  @override
  String get claudiuAnonymousChatHint => 'Напиши поруку…';

  @override
  String get claudiuAnonymousChatWaitingOperator =>
      'Чекамо да оператер одговори…';

  @override
  String get claudiuVorsitzerConnectedTitle => 'Здраво!';

  @override
  String get claudiuVorsitzerConnectedBody =>
      'Хвала што си нам се јавио — сада си у контакту са Vorsitzer-ом. Реци како ти можемо помоћи око пријаве за чланство.';

  @override
  String get claudiuVorsitzerConnectedSender => 'Vorsitzer';

  @override
  String get claudiuQuickReplyValidationTime => 'Колико траје провера?';

  @override
  String get claudiuQuickReplyDocuments => 'Који документи су ми потребни?';

  @override
  String get claudiuQuickReplyStepProblem => 'Заглавио сам се на једном кораку';

  @override
  String get claudiuQuickReplyHuman => 'Могу ли сада да причам са неким?';

  @override
  String get claudiuAnonymousChatConnecting => 'Повезивање…';

  @override
  String get claudiuAnonymousChatConnectionFailed =>
      'Није могуће отворити ћаскање. Покушај поново или позови.';

  @override
  String get claudiuAnonymousChatRetry => 'Покушај поново';

  @override
  String get claudiuAnonymousChatOnline => 'Повезано';

  @override
  String get claudiuAnonymousChatOffline => 'Поновно повезивање…';

  @override
  String get claudiuAnonymousChatAdminTyping => 'Оператер куца…';

  @override
  String get claudiuProblemReportTitle => 'Пријави проблем';

  @override
  String get claudiuProblemReportGreeting => 'Шта се десило?';

  @override
  String get claudiuProblemReportAsk =>
      'Реци ми детаљно и проследићу извештај тиму.';

  @override
  String get claudiuProblemReportIncludeHeader => 'Молим уврсти:';

  @override
  String get claudiuProblemReportIncludeBullets1 =>
      'Шта си радио када се проблем појавио';

  @override
  String get claudiuProblemReportIncludeBullets2 =>
      'Било која порука грешке коју си видео';

  @override
  String get claudiuProblemReportIncludeBullets3 => 'На ком екрану си био';

  @override
  String get claudiuProblemReportIncludeBullets4 =>
      'Да ли се апликација руши, затвара или приказује бели екран?';

  @override
  String get claudiuProblemReportIncludeBullets5 =>
      'Дешава ли се сваки пут или само једном?';

  @override
  String get claudiuProblemReportDescriptionLabel => 'Твој опис';

  @override
  String get claudiuProblemReportDescriptionHint =>
      'Нпр.: Када отворим ћаскање појављује се „Connection error\" и апликација престаје да реагује…';

  @override
  String claudiuProblemReportTooShort(int count) {
    return 'Мало више детаља, молим (најмање $count знакова)';
  }

  @override
  String get claudiuProblemReportSubmit => 'Пошаљи извештај';

  @override
  String get claudiuProblemReportSubmitting => 'Слање…';

  @override
  String get claudiuProblemReportSentTitle => 'Хвала!';

  @override
  String get claudiuProblemReportSentBody =>
      'Извештај је послат. Наш тим ће га погледати у најкраћем року.';

  @override
  String get claudiuProblemReportSentClose => 'Разумем';

  @override
  String get claudiuProblemReportSendFailed =>
      'Извештај није могуће послати. Позови нас за хитну помоћ.';

  @override
  String get claudiuProblemReportAlt => 'Или, ако је хитно:';

  @override
  String get claudiuProblemReportCallLabel => 'Позови нас';

  @override
  String claudiuApprovalGreeting(String name) {
    return 'Здраво, $name! 👋';
  }

  @override
  String get claudiuApprovalGreetingNoName => 'Здраво! 👋';

  @override
  String get claudiuApprovalGladToSeeYou => 'Драго ми је што си дошао!';

  @override
  String get claudiuApprovalCheckingForSafety =>
      'За твоју безбедност, Vorsitzer тренутно проверава твој захтев за пријаву. 🛡️';

  @override
  String get claudiuApprovalMonthlyExplain =>
      '💡 Ово радимо сваких 30 дана да бисмо били сигурни да си заиста ти. То је као безбедносна провера — највише 5 минута.';

  @override
  String get claudiuApprovalSuccess =>
      'Готово! 🎉 Vorsitzer те препознао. Пријављујем те…';

  @override
  String get claudiuApprovalDenied => 'Хм, Vorsitzer је одбио твој захтев. 😔';

  @override
  String get claudiuApprovalDeniedHelp =>
      'Ако мислиш да је ово грешка, молим те позови нас да разјаснимо.';

  @override
  String get claudiuApprovalExpired =>
      'Прошло је 5 минута и Vorsitzer није одговорио.';

  @override
  String get claudiuApprovalExpiredHelp =>
      'Позови нас и можемо одмах одобрити твој захтев. 📞';

  @override
  String get claudiuApprovalCallUs => 'Позови нас';

  @override
  String get claudiuApprovalTryAgain => 'Покушај поново';

  @override
  String get claudiuApprovalCancel => 'Откажи';

  @override
  String get claudiuApprovalClose => 'Затвори';

  @override
  String get wizardIntroBubble1 =>
      'Здраво, посетиоче! 👋 Хвала ти што желиш да постанеш део наше породице.';

  @override
  String get wizardIntroBubble2 =>
      'Зовем се Клаудио. У пролеће 2025. имао сам јасну визију: створити удружење које помаже људима у невољи — добровољно, од срца, без непотребне бирократије. ❤️';

  @override
  String get wizardIntroBubble3 =>
      'Почео сам да разговарам са клијентима које сам посећивао. Испричао сам им свој сан. И сваки је рекао: „Да, идемо!\" У јулу 2025. састали смо се — 6 одлучних људи. Одлучили смо да оснујемо **ICD360S e.V.** у Ноj-Улму. 📍';

  @override
  String get wizardIntroBubble4 =>
      '**1. августа 2025.** удружење је званично оживело — у Регистру удружења. Мој најлепши поклон. 🎂';

  @override
  String get wizardIntroBubble5 =>
      'Шта радимо? Помажемо избеглицама, особама са инвалидитетом, економски угроженим, **деци и младима** — у административним питањима, немачком језику, становању, куповини, социјалним накнадама. Наш Vorstand чине углавном особе са инвалидитетом — тако одлуке долазе из стварног животног искуства. 🤝';

  @override
  String get wizardIntroBubble6 =>
      'Сада си ти на реду. Хајде да те упишемо — траје око 5 минута. Идемо корак по корак, не остављам те самог. ✨';

  @override
  String get wizardIntroStart => 'Кренимо';

  @override
  String get wizardBack => 'Назад';

  @override
  String get wizardNext => 'Даље';

  @override
  String wizardStepLabel(int step, int total, String title) {
    return 'Корак $step од $total · $title';
  }

  @override
  String get wizardErrRequired => 'Ово поље је обавезно';

  @override
  String wizardErrTooShort(int count) {
    return 'Прекратко (најмање $count знакова)';
  }

  @override
  String get wizardErrOnlyLetters => 'Само слова, размаци, цртице и апострофи';

  @override
  String get wizardErrSaveFailed =>
      'Чување није успело. Провери везу и покушај поново.';

  @override
  String get wizardStufe1aTitle => 'Идентитет';

  @override
  String get wizardStufe1aPrompt =>
      'Хајде да се званично упознамо. Молим те, упиши име тачно онако како пише на Personalausweis-у, Reisepass-у или Aufenthaltstitel-у — да буде у складу са документима.';

  @override
  String get wizardStufe1aVornameLabel => 'Vornamen (имена)';

  @override
  String get wizardStufe1aVornameHelper =>
      'Сва твоја имена тачно као на документу. Са размаком или цртицом (нпр. Hans-Peter, Maria Anna).';

  @override
  String get wizardStufe1aNachnameLabel => 'Familienname (презиме)';

  @override
  String get wizardStufe1aNachnameHelper => 'Твоје тренутно презиме.';

  @override
  String get wizardStufe1aGeburtsnameLabel =>
      'Geburtsname (девојачко презиме) — опционо';

  @override
  String get wizardStufe1aGeburtsnameHelper =>
      'Само ако се разликује од Familienname — нпр. пре брака.';

  @override
  String get wizardStufe1bTitle => 'Рођендан';

  @override
  String get wizardStufe1bPrompt =>
      'Желимо да прославимо твој рођендан заједно! 🎂 И помаже нам да потврдимо да имаш бар 16 — тако каже наш статут.';

  @override
  String get wizardStufe1bGeburtsdatumLabel => 'Датум рођења';

  @override
  String get wizardStufe1bGeburtsdatumHelper => 'Додирни да изабереш датум';

  @override
  String get wizardStufe1bGeburtsortLabel => 'Место рођења';

  @override
  String get wizardStufe1bGeburtsortHelper => 'Град / место где си рођен.';

  @override
  String get wizardAgeGatePrompt => 'Жао ми је… 😔';

  @override
  String wizardAgeGateBody1(int age, int years) {
    return 'Наш статут каже да мораш имати бар 16 година да би био члан. Имаш $age — надам се да ћемо се видети за $years година! 🌱';
  }

  @override
  String get wizardAgeGateBody2 =>
      'Ако желиш да повремено волонтираш (било који узраст, са пристанком родитеља), позови — радо подржавамо младе који желе да промене свет.';

  @override
  String get wizardAgeGateBackHome => 'Назад на почетну';

  @override
  String get wizardErrInvalidPhone => 'Неважећи број телефона';

  @override
  String get wizardStufe1b1Title => 'Сагласност родитеља';

  @override
  String get wizardStufe1b1Prompt =>
      'Малолетан си (16-17) — према §106 BGB треба нам сагласност родитеља или законског старатеља. Реци ми име и број телефона. Vorsitzer ће позвати и заказати састанак (лично или видео позивом). Без мејла — желимо да будемо сигурни да разговарамо са правом особом.';

  @override
  String get wizardStufe1b1VornameLabel => 'Име родитеља';

  @override
  String get wizardStufe1b1VornameHelper =>
      'Како је на Personalausweis-у родитеља.';

  @override
  String get wizardStufe1b1NachnameLabel => 'Презиме родитеља';

  @override
  String get wizardStufe1b1NachnameHelper =>
      'Како је на Personalausweis-у родитеља.';

  @override
  String get wizardStufe1b1TelefonLabel => 'Мобилни родитеља';

  @override
  String get wizardStufe1b1TelefonHelper =>
      'На овај број ће позвати Vorsitzer.';

  @override
  String get wizardStufe1b1RelationLabel => 'Однос према детету:';

  @override
  String get wizardStufe1b1RelationMutter => 'Мајка';

  @override
  String get wizardStufe1b1RelationVater => 'Отац';

  @override
  String get wizardStufe1b1RelationSorgeberechtigter => 'Законски старатељ';

  @override
  String get wizardStufe1b1RelationAndere => 'Други старатељ';

  @override
  String get wizardStufe1cTitle => 'Лични подаци';

  @override
  String get wizardStufe1cPrompt =>
      'Само да те мало боље упознам. Ово остаје између нас и не приказује се нигде јавно.';

  @override
  String get wizardStufe1cGeschlechtLabel => 'Пол';

  @override
  String get wizardStufe1cGeschlechtMaennlich => 'Мушки';

  @override
  String get wizardStufe1cGeschlechtWeiblich => 'Женски';

  @override
  String get wizardStufe1cGeschlechtDivers => 'Друго';

  @override
  String get wizardStufe1cGeschlechtKeineAngabe => 'Не желим да кажем';

  @override
  String get wizardStufe1cFamilienstandLabel => 'Брачно стање';

  @override
  String get wizardStufe1cFamilienstandLedig => 'Неожењен / Неудата';

  @override
  String get wizardStufe1cFamilienstandVerheiratet => 'Ожењен / Удата';

  @override
  String get wizardStufe1cFamilienstandGeschieden => 'Разведен/а';

  @override
  String get wizardStufe1cFamilienstandVerwitwet => 'Удовац/Удовица';

  @override
  String get wizardStufe1dTitle => 'Твоје порекло';

  @override
  String get wizardStufe1dPrompt =>
      'Ово нам помаже да ти понудимо праву подршку — на пример савет о Aufenthalt-у или налажење твоје језичке заједнице.';

  @override
  String get wizardStufe1dStaatLabel => 'Држављанство';

  @override
  String get wizardStufe1dStaatHelper =>
      'Нпр. deutsch, rumänisch, ukrainisch. Више одвојених запетом.';

  @override
  String get wizardStufe1dAufenthaltLabel =>
      'Статус боравка (Aufenthaltsstatus) — опционо';

  @override
  String get wizardStufe1dAufenthaltHelper =>
      'Изабери титулу из своје Aufenthaltskarte / одлуке. Vorstand то упоређује са твојим документима.';

  @override
  String get wizardStufe1dAufenthaltAwaitingCitizenship =>
      'Прво горе унеси држављанство — приказаћемо само одговарајуће опције.';

  @override
  String get wizardStufe1dAufenthaltGerman =>
      'Aufenthaltstitel није потребан — немачки држављанин.';

  @override
  String get wizardStufe1dAufenthaltEuEea =>
      'Држављанин ЕУ/ЕЕП/ЦХ — слободно кретање (Freizügigkeit).';

  @override
  String get wizardStufe1dAufenthaltTempHint => 'привремени';

  @override
  String get wizardStufe1dAufenthaltPermHint => 'стално настањење';

  @override
  String get wizardStufe1dAufenthaltAsylumProcessHint => 'поступак азила';

  @override
  String get wizardStufe1dAufenthaltOther => 'Друго (наведи у ћаскању)';

  @override
  String get wizardStufe1dAufenthaltRequired =>
      'Молим изабери Aufenthaltstitel.';

  @override
  String get wizardStufe1dMutterspracheLabel => 'Матерњи језик';

  @override
  String get wizardStufe1dMutterspracheHelper =>
      'Унапред попуњено језиком апликације — промени ако је друкчије.';

  @override
  String get wizardStufe1eTitle => 'Адреса';

  @override
  String get wizardStufe1ePrompt =>
      'Твоја поштанска адреса — користимо је за службене документе (статут, чланске уговоре, обавештења).';

  @override
  String get wizardStufe1eStrasseLabel => 'Улица';

  @override
  String get wizardStufe1eStrasseHelper =>
      'Само назив улице — број у суседном пољу.';

  @override
  String get wizardStufe1eHausnummerLabel => 'Бр.';

  @override
  String get wizardStufe1ePlzLabel => 'PLZ (поштански бр.)';

  @override
  String get wizardStufe1eOrtLabel => 'Град';

  @override
  String get wizardStufe1eLandLabel => 'Држава';

  @override
  String get wizardStufe1eLandHelper => 'Унапред попуњено: Deutschland.';

  @override
  String get wizardErrInvalidStreet => 'Неважећи назив улице';

  @override
  String get wizardErrInvalidHausnummer => 'Неважећи број (нпр. 12, 12a, 12/3)';

  @override
  String get wizardErrInvalidPlz => 'Неважећи поштански број (само цифре)';

  @override
  String get wizardStufe1fTitle => 'Контакт';

  @override
  String get wizardStufe1fPrompt =>
      'Како да те контактирамо? Телефон је само за хитне случајеве — све остало иде преко нашег сопственог end-to-end енкриптованог канала у апликацији. Твој члански мејл се додељује аутоматски и приказан је испод.';

  @override
  String get wizardStufe1fTelefonLabel => 'Мобилни';

  @override
  String get wizardStufe1fTelefonHelper =>
      'Обећавам, позваћу само ако је важно. 📱';

  @override
  String get wizardStufe2Title => 'Тип чланства';

  @override
  String get wizardStufe2Prompt =>
      'Какав члан желиш да будеш? Хајде да ти објасним сваку опцију.';

  @override
  String get wizardStufe2OrdentlichTitle => 'Редовни члан (ordentlich)';

  @override
  String get wizardStufe2OrdentlichBody =>
      'Сва права. Плаћаш месечну чланарину, гласаш на скупштини, можеш бити изабран у управу. Стандардни избор.';

  @override
  String get wizardStufe2FoerderTitle => 'Подупирући члан (Fördermitglied)';

  @override
  String get wizardStufe2FoerderBody =>
      'Подржаваш удружење финансијски, али не учествујеш активно у одлукама. Без права гласа. Добро ако желиш да помажеш са даљине.';

  @override
  String get wizardStufe2EhrenTitle => 'Почасни члан (Ehrenmitglied)';

  @override
  String get wizardStufe2EhrenBody =>
      'Додељује управа за посебне заслуге. Не бираш сам — додељује се као признање. Бирај само ако си већ почаствован.';

  @override
  String get wizardStufe3Title => 'Финансијска ситуација';

  @override
  String get wizardStufe3Prompt =>
      'Сада о твојој финансијској ситуацији. Не да те осуђујем — већ да те ослободимо чланарине ако примаш социјалне накнаде.';

  @override
  String get wizardStufe3OptionBuergergeld => 'Примам Bürgergeld';

  @override
  String get wizardStufe3OptionSozialamt => 'Примам помоћ од Sozialamta';

  @override
  String get wizardStufe3OptionNein => 'Не примам ниједно од овога';

  @override
  String get wizardStufe3FeeExemptTitle => 'Чланарина: 0 € / месечно 🎉';

  @override
  String get wizardStufe3FeeExemptBody =>
      'Са Bürgergeldom, Sozialamtom, ALG I или Krankengeldom потпуно си ослобођен чланарине према Сатзунг-у §6. Треба нам само доказ (Leistungsbescheid или потврда од органа / здравствене касе).';

  @override
  String get wizardStufe3UploadTitle => 'Отпреми Leistungsbescheid';

  @override
  String get wizardStufe3UploadHint => 'PDF / JPG / PNG, највише 10 MB.';

  @override
  String get wizardStufe3UploadRequired =>
      'Молим те отпреми Leistungsbescheid пре него што наставиш.';

  @override
  String get wizardStufe3FileTooLarge =>
      'Датотека је превелика. Највише 10 MB.';

  @override
  String get wizardStufe3UploadFailed =>
      'Није било могуће отпремити датотеку. Покушај поново.';

  @override
  String get wizardStufe3RegularFeeTitle => 'Чланарина: 25 € / месечно';

  @override
  String get wizardStufe3RegularFeeBody =>
      'Стандардна чланарина за редовне чланове према статуту.';

  @override
  String get wizardStufe4Title => 'Плаћање';

  @override
  String get wizardStufe4Prompt =>
      'Како желиш да плаћаш чланарину? И ког дана у месецу ти одговара?';

  @override
  String get wizardStufe4MethodUeberweisungTitle =>
      'Банковни пренос (Überweisung)';

  @override
  String get wizardStufe4MethodUeberweisungBody =>
      'Сам започињеш плаћање сваког месеца са свог рачуна.';

  @override
  String get wizardStufe4MethodSepaTitle =>
      'SEPA-Lastschrift (директно задужење)';

  @override
  String get wizardStufe4MethodSepaBody =>
      'Износ аутоматски скидамо са твог рачуна. Најпрактичније, али нам треба IBAN и потписано овлашћење.';

  @override
  String get wizardStufe4MethodDauerauftragTitle =>
      'Dauerauftrag (трајни налог)';

  @override
  String get wizardStufe4MethodDauerauftragBody =>
      'Поставиш трајни налог у својој банци. Банка аутоматски преноси износ сваког месеца.';

  @override
  String get wizardStufe4DayLabel => 'Дан плаћања';

  @override
  String get wizardStufe4DayHint => 'Изабери дан између 1 и 31';

  @override
  String wizardStufe4DayItem(int day) {
    return '$day. дан';
  }

  @override
  String wizardStufe4DayReminder(int day) {
    return 'Чланарина ће се скидати $day. сваког месеца.';
  }

  @override
  String get wizardStufe5Title => 'Почетак';

  @override
  String get wizardStufe5Prompt =>
      'Од када желиш да будеш званично члан ICD360S? Од одобрења или ретроактивно.';

  @override
  String get wizardStufe5OptionAbVerifizierungTitle => 'Од одобрења управе';

  @override
  String get wizardStufe5OptionAbVerifizierungBody =>
      'Најједноставнији избор. Без ретроактивне чланарине.';

  @override
  String get wizardStufe5OptionGruendungsdatumTitle =>
      'Ретроактивно од 01.08.2025. (оснивање)';

  @override
  String get wizardStufe5OptionGruendungsdatumBody =>
      'Биће се рачунати као члан од првог дана удружења.';

  @override
  String get wizardStufe5OptionAnderesDatumTitle => 'Други датум';

  @override
  String get wizardStufe5OptionAnderesDatumBody =>
      'Сам бираш датум између 01.08.2025. и данас.';

  @override
  String get wizardStufe5PickDate => 'Додирни да изабереш датум';

  @override
  String get wizardStufe5PickDateFirst => 'Молим те, прво изабери датум.';

  @override
  String get wizardStufe5DatePickerHelp => 'Почетак чланства';

  @override
  String wizardStufe5DateRange(String start) {
    return 'Између $start и данас';
  }

  @override
  String get wizardStufe5RetroactiveTitle => 'Ретроактивна чланарина';

  @override
  String wizardStufe5RetroactiveBody(
      String start, String end, int months, String amount) {
    return 'Од $start до $end то је $months месеци. По 25 €/месечно то износи $amount € за плаћање ретроактивно, поред тренутне месечне чланарине.';
  }

  @override
  String get wizardStufe5FeeExemptTitle => 'Ретроактивна чланарина: 0 € 🎉';

  @override
  String get wizardStufe5FeeExemptBody =>
      'Са Bürgergeld или Sozialamt-ом потпуно си ослобођен — чак ни ретроактивно не дугујеш ништа.';

  @override
  String wizardDocumentPrompt(String doc) {
    return 'Пре него што завршимо, молим те пажљиво прочитај $doc. Важно је знати шта потписујеш.';
  }

  @override
  String get wizardDocumentScrollHint => 'Помери до дна да би наставио.';

  @override
  String get wizardDocumentScrolledOk => 'Прочитао си до краја ✓';

  @override
  String wizardDocumentOpenButton(String doc) {
    return 'Отвори $doc у прегледачу';
  }

  @override
  String get wizardDocumentExternalHint =>
      'На овој платформи отварамо документ у твом подразумеваном прегледачу.';

  @override
  String get wizardDocumentOpenedOk =>
      'Документ је отворен. Молим те пажљиво га прочитај.';

  @override
  String wizardDocumentConfirm(String doc) {
    return 'Потврђујем да сам прочитао(ла) $doc и слажем се са њим.';
  }

  @override
  String get wizardFinalAdultTitle => 'Готово! Уписан си 🎉';

  @override
  String get wizardFinalMinorTitle => 'Твој захтев је послат 📨';

  @override
  String get wizardFinalMinorBody =>
      'Контактираћемо твог родитеља и заказати састанак (лично или видео позивом). Молимо те за стрпљење — поступак може трајати до 7 дана. Добићеш обавештење у апликацији чим родитељ одобри.';

  @override
  String get wizardFinalMitgliedernummerLabel => 'Твој члански број';

  @override
  String get wizardStufe4MethodComingSoon => 'Ускоро';

  @override
  String get wizardStufe4StreichungWarning =>
      'Ако касниш са чланарином више од 6 месеци, аутоматски ћемо те брисати (Satzung §6 Abs. 3).';

  @override
  String get wizardStufe5KuendigungInfo =>
      'За иступ: пошаљи нам отказ писмено 3 месеца пре 31. децембра (најкасније до 30. септембра да би ступило на снагу крајем године). Нема минималног трајања (Satzung §6 Abs. 3).';

  @override
  String get wizardStufe1fEmailLabel => 'Твој члански мејл';

  @override
  String get wizardStufe1fEmailHelper =>
      'Додељује се аутоматски на основу твог чланског броја. Активира се у тренутку када управни одбор (Vorstand) одобри твоју пријаву. Имамо сопствену апликацију за е-пошту — шаљи и примај шифроване е-поруке, једноставно и бесплатно.';

  @override
  String get wizardErrInvalidEmail => 'Неважећа имејл адреса';

  @override
  String get wizardStufe3OptionAlg1 =>
      'Примам Arbeitslosengeld I (ALG I, накнаду за незапослене)';

  @override
  String get wizardStufe3OptionKrankengeld =>
      'Примам Krankengeld (накнаду за дуготрајну болест)';

  @override
  String get wizardStufe3UploadAddMore => 'Додај још један документ';

  @override
  String get wizardStufe3UploadLimitCount =>
      'Достигао си границу: највише 20 докумената.';

  @override
  String get wizardStufe3UploadLimitTotal =>
      'Достигао си укупно ограничење од 100 MB. Обриши постојећи фајл.';

  @override
  String get wizardStufe3UploadDeleteTooltip => 'Обриши';

  @override
  String wizardStufe3UploadCounter(int count, int max) {
    return '$count / $max докумената';
  }

  @override
  String get wizardDocumentExternalOpenFailed =>
      'Нисам могао да отворим прегледач. Линк је копиран у клипборд — налепи га у прегледач за наставак.';

  @override
  String get wizardFinalTimelineProcessing =>
      'Vorstand проверава · обично 1 радни дан, до 7';

  @override
  String get wizardFinalTimelineActivated => 'Налог активиран';

  @override
  String get wizardFinalAdultThank =>
      'Хвала што си попунио регистрациони формулар! 🎉';

  @override
  String get wizardFinalAdultUsual =>
      'Твој захтев је код нас. Обично га потврђујемо у року од једног радног дана.';

  @override
  String get wizardFinalAdultExceptional =>
      'Понекад може потрајати до 7 радних дана. А ако нешто не одговара, вратићемо те у формулар да исправиш 🙂';

  @override
  String get wizardFinalStatusTitle => 'СТАТУС ЗАХТЕВА';

  @override
  String wizardFinalStatusStepsValidated(int reviewed, int total) {
    return '$reviewed/$total корака потврдио је Vorstand';
  }

  @override
  String get wizardFinalStufeSheetTitle => 'Детаљи захтева';

  @override
  String get wizardFinalStufeSheetHint =>
      '8 фаза које си попунио. Vorstand их прегледа једну по једну — у реалном времену видиш шта је потврђено.';

  @override
  String get wizardFinalStufeStatusPending => 'Чека преглед';

  @override
  String get wizardFinalStufeStatusApproved => 'Одобрено';

  @override
  String get wizardFinalStufeStatusRejected => 'Одбијено';

  @override
  String wizardFinalStatusRejectionCount(int count) {
    return '$count корак захтева исправку';
  }

  @override
  String get wizardFinalStufeRejectionReason => 'Разлог Vorstand-а:';

  @override
  String get wizardFinalStufeCorrectNow => 'Исправи сада';

  @override
  String wizardFinalApprovalsHeader(int current, int total) {
    return 'Одобрења Vorstand-а ($current/$total)';
  }

  @override
  String get wizardFinalApprovalAwaiting => 'Чека се 2. Vorstand';

  @override
  String get wizardFinalApprovalRejected => 'ОДБИЈЕНО';

  @override
  String get wizardFinalStufeNoDataYet => 'Подаци још нису доступни.';

  @override
  String get wizardFinalStufeReadAt => 'Прочитано:';

  @override
  String get wizardFinalStufeBeitragsfrei =>
      'Ослобођено чланарине (без плаћања)';

  @override
  String get wizardFinalStufeNotExempt => 'Без социјалне помоћи';

  @override
  String get wizardFinalStufeBeginAtVerification => 'Почиње при верификацији';

  @override
  String get wizardFinalStufeBeginAtFoundation =>
      'Датум оснивања (ретроактивно)';

  @override
  String get wizardFinalStufeBeginAtCustom => 'Други датум';

  @override
  String get wizardFinalStufeStatusSkipped => 'Прескочено';

  @override
  String get wizardFinalStufeFilledAt => 'Попуњено:';

  @override
  String get wizardFinalStufeReviewedAt => 'Прегледано:';

  @override
  String get wizardFinalWithdrawLink => 'Повуци захтев';

  @override
  String get wizardFinalWithdrawDialogTitle => 'Повлачиш захтев?';

  @override
  String get wizardFinalWithdrawDialogBody =>
      'Твој захтев ће бити означен као повучен од тебе. Подаци остају у бази ради ревизије (GDPR), али налог неће бити активиран. Регистрацију можеш почети поново у било ком тренутку са новим бројем чланства.';

  @override
  String get wizardFinalWithdrawKeep => 'Не, сачекаћу';

  @override
  String get wizardFinalWithdrawConfirm => 'Да, повуци';

  @override
  String get wizardErrTooManyWithdrawals =>
      'Твој захтев не може бити аутоматски обрађен. Позови нас или дођи лично код Vorstand-а да наставиш регистрацију.';

  @override
  String get wizardDuplicateLoginTitle => 'Изгледа да си већ наш члан';

  @override
  String get wizardDuplicateLoginBody =>
      'Са твојим именом и датумом рођења већ налазимо активан налог. Молимо, користи \"Већ сам члан\" на почетном екрану да се пријавиш. Ако више немаш приступ, позови нас.';

  @override
  String get wizardDuplicatePendingTitle => 'Твој захтев је већ код нас';

  @override
  String get wizardDuplicatePendingBody =>
      'Са твојим именом и датумом рођења већ имамо захтев у разматрању. Vorstand ради на њему — обавестићемо те у апликацији чим налог буде активан. Позови ако желиш да разговарамо.';

  @override
  String get wizardDuplicateRecentlyWithdrawnTitle =>
      'Тренутно не можемо обрадити овај захтев';

  @override
  String get wizardDuplicateRecentlyWithdrawnBody =>
      'Твоје име и датум рођења поклапају се са недавно повученим захтевом. Молимо позови нас да пре наставка разговараш са Vorstand-ом.';

  @override
  String get wizardDuplicatePreviouslyWithdrawnTitle =>
      'Већ си раније поднео захтев';

  @override
  String get wizardDuplicatePreviouslyWithdrawnBody =>
      'Твоје име и датум рођења поклапају се са старијим захтевом који си повукао. Добродошао назад — позови нас пре наставка да Vorstand одлучи како даље.';

  @override
  String get wizardDuplicateCallUsTitle => 'Молимо, позови нас';

  @override
  String get wizardDuplicateCallUsBody =>
      'Твоје име и датум рођења већ су код нас, али детаље не можемо делити кроз апликацију. Позови нас — Vorstand ће ти ситуацију објаснити директно.';

  @override
  String get wizardChatHelp => 'Хајде да разговарамо';

  @override
  String get wizardChatHelpSubtitle => 'Чет уживо са Vorstand-ом · брз одговор';

  @override
  String get benachrichtigungTitel => 'SMS подсетници';

  @override
  String get benachrichtigungIntro =>
      'Да не бисте пропустили термин, удружење може да вам пошаље SMS. Ви одлучујете да ли и за шта — и то можете променити у сваком тренутку.';

  @override
  String get benachrichtigungTermineFrage =>
      'Желите ли подсетнике на своје термине путем SMS-а?';

  @override
  String get benachrichtigungTermineDetail =>
      'Порука садржи датум, време, место и тему термина.';

  @override
  String get benachrichtigungMedikamenteFrage =>
      'Желите ли подсетнике и за своје лекове?';

  @override
  String get benachrichtigungMedikamenteDetail =>
      'Тада у поруци стоји назив лека. То је здравствени податак — зато питамо одвојено.';

  @override
  String get benachrichtigungHinweis =>
      'Подсетник је помоћ, а не гаранција: молимо вас, немојте се ослањати само на њега. То можете променити у сваком тренутку у свом профилу.';

  @override
  String get benachrichtigungJa => 'Да';

  @override
  String get benachrichtigungNein => 'Не';

  @override
  String get benachrichtigungSpaeter => 'Одлучи касније';

  @override
  String get benachrichtigungSpeichern => 'Сачувај';

  @override
  String get benachrichtigungGespeichert => 'Хвала, сачувано.';

  @override
  String get benachrichtigungenLeer => 'Нема обавештења';

  @override
  String get benachrichtigungenAlleGelesen => 'Означи све као прочитано';

  @override
  String get benachrichtigungWetterFrage =>
      'Желите ли упозорење на невреме у месту становања?';

  @override
  String get benachrichtigungWetterDetail =>
      'Само званична упозорења Немачке метеоролошке службе од степена „јако“ навише — не при свакој киши.';

  @override
  String get signaturTitel => 'Потписи';

  @override
  String get signaturNichtsOffen => 'Тренутно немате ништа за потписивање.';

  @override
  String get signaturStatusOffen => 'Чека Ваш потпис';

  @override
  String get signaturStatusSigniert => 'Потписали сте документ';

  @override
  String get signaturStatusAbgelehnt => 'Одбили сте документ';

  @override
  String get signaturStatusWiderrufen => 'Удружење је повукло документ';

  @override
  String get signaturStatusAbgelaufen => 'Рок је истекао';

  @override
  String signaturBitteGanzLesen(int gelesen, int gesamt) {
    return 'Молимо Вас да прочитате документ до краја (страна $gelesen од $gesamt).';
  }

  @override
  String get signaturWeiterZurUnterschrift => 'Пређите на потпис';

  @override
  String get signaturAblehnen => 'Одбијте';

  @override
  String get signaturAblehnenHinweis =>
      'Удружење ће о томе бити обавештено. Можете навести своје разлоге.';

  @override
  String get signaturAblehnenGrund => 'Разлог (необавезно)';

  @override
  String get signaturMitFingerHinweis => 'Потпишите се прстом у белом пољу.';

  @override
  String get signaturNochmal => 'Још једном';

  @override
  String get signaturZurueckZumDokument => 'Назад на документ';

  @override
  String get signaturCodeAnfordern => 'Затражите код СМС-ом';

  @override
  String get signaturCodeUnterwegs => 'Код стиже.';

  @override
  String signaturCodeGesendetAn(String nummer) {
    return 'Послали смо Вам код на $nummer.';
  }

  @override
  String get signaturCodeErneutSenden => 'Пошаљите код поново';

  @override
  String get signaturJetztUnterschreiben => 'Потпишите се сада';

  @override
  String get signaturCodeFalsch => 'Код није тачан.';

  @override
  String get signaturCodeAbgelaufen =>
      'Код је истекао. Молимо Вас да затражите нови.';

  @override
  String get signaturZuVieleVersuche =>
      'Превише погрешних покушаја. Молимо Вас да затражите нови код.';

  @override
  String get signaturKeineRufnummer =>
      'У Вашем налогу није уписан број мобилног телефона. Без њега не можемо да Вам пошаљемо код — молимо Вас да се обратите председнику удружења.';

  @override
  String get signaturCodeFehlgeschlagen => 'Слање кода није успело.';

  @override
  String get signaturLeer => 'Молимо Вас да се прво потпишете.';

  @override
  String get signaturErfolg => 'Хвала — Ваш потпис је примљен.';

  @override
  String get signaturFehlgeschlagen =>
      'Није успело. Молимо Вас да покушате поново.';

  @override
  String get signaturSiegelInArbeit =>
      'Pečat se još izrađuje. Molimo pokušajte ponovo za jedan minut.';
}
