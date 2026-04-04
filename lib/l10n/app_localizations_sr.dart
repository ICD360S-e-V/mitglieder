// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Serbian (`sr`).
class AppLocalizationsSr extends AppLocalizations {
  AppLocalizationsSr([String locale = 'sr']) : super(locale);

  @override
  String get appTitle => 'ICD360S e.V - Портал чланова';

  @override
  String get memberPortal => 'Портал чланова';

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
  String get password => 'Лозинка';

  @override
  String get passwordHint => 'Унесите лозинку';

  @override
  String get confirmPassword => 'Потврдите лозинку';

  @override
  String get confirmPasswordHint => 'Потврдите лозинку';

  @override
  String get newPassword => 'Нова лозинка';

  @override
  String get newPasswordHint => 'Унесите нову лозинку';

  @override
  String get saveCredentials => 'Сачувај податке за пријаву';

  @override
  String get autoLogin => 'Аутоматска пријава';

  @override
  String get forgotPassword => 'Заборавили сте лозинку?';

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
  String get recoveryCode => 'Код за опоравак (6 цифара)';

  @override
  String get recoveryCodeHelper => 'Запамтите овај код за опоравак лозинке';

  @override
  String get recoveryCodeHint => 'Унесите код за опоравак';

  @override
  String get recoveryCodeInvalid => 'Код мора имати тачно 6 цифара';

  @override
  String get loginFailed => 'Пријава није успела';

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
  String get tooManyDevices => 'Превише уређаја';

  @override
  String get maxDevicesMessage =>
      'Већ сте пријављени на 3 уређаја.\nИзаберите уређај за одјаву:';

  @override
  String get unknownDevice => 'Непознат уређај';

  @override
  String get unknown => 'Непознато';

  @override
  String get logoutError => 'Грешка при одјави';

  @override
  String error(String error) {
    return 'Грешка: $error';
  }

  @override
  String get cancel => 'Откажи';

  @override
  String get resetPassword => 'Поништи лозинку';

  @override
  String get forgotPasswordTitle => 'Заборављена лозинка';

  @override
  String get forgotPasswordDescription =>
      'Унесите број члана и код за опоравак створен приликом регистрације.';

  @override
  String get passwordResetSuccess =>
      'Лозинка успешно поништена!\n\nСада се можете пријавити новом лозинком.';

  @override
  String get passwordResetFailed => 'Поништавање лозинке није успело';

  @override
  String get needHelp => 'Требате помоћ?';

  @override
  String get helpQuestion => 'Проблеми са пријавом или регистрацијом?';

  @override
  String get helpDescription =>
      'Контактирајте нас путем WhatsApp-а и опишите шта не ради. Одговорићемо што пре!';

  @override
  String get whatsapp => 'WhatsApp';

  @override
  String get emailSubject => 'Упит путем апликације ICD360S';

  @override
  String get whatsappMessage => 'Здраво, имам проблем са апликацијом ICD360S. ';

  @override
  String get imprint => 'Импресум';

  @override
  String get privacy => 'Политика приватности';

  @override
  String get statutes => 'Статут';

  @override
  String get revocation => 'Право повлачења';

  @override
  String get cancellation => 'Отказивање';

  @override
  String get allRightsReserved => 'Сва права задржана.';

  @override
  String get enterCredentials => 'Унесите број члана и лозинку';

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
  String get membership => 'Чланство';

  @override
  String get myAppointments => 'Моји састанци';

  @override
  String get appointmentsLoadingReady => 'Учитавање састанака - API спреман!';

  @override
  String get priority => 'Приоритет';

  @override
  String get messageLabel => 'Порука';

  @override
  String get createdOn => 'Креирано';

  @override
  String get handler => 'Руковалац';

  @override
  String get reportProblems => 'Пријавите проблеме';

  @override
  String get reportProblem => 'Пријавите проблем';

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
  String get newTicket => 'Нови тикет';

  @override
  String get noOpenTickets => 'Нема отворених тикета';

  @override
  String get haveQuestionCreateTicket =>
      'Имате питање или проблем?\nКреирајте нови тикет.';

  @override
  String get whatIsTheProblem => 'У чему је проблем?';

  @override
  String get describeTheProblem => 'Опишите проблем';

  @override
  String get howUrgentIsIt => 'Колико је хитно?';

  @override
  String get low => 'Ниско';

  @override
  String get medium => 'Средње';

  @override
  String get high => 'Високо';

  @override
  String get submit => 'Пошаљи';

  @override
  String get fillSubjectAndMessage => 'Молимо попуните тему и поруку';

  @override
  String get ticketCreated => 'Тикет је креиран';

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
  String get newEmailAddress => 'Нова адреса е-поште';

  @override
  String get currentPassword => 'Тренутна лозинка';

  @override
  String get saveEmail => 'Сачувај е-пошту';

  @override
  String get savePassword => 'Сачувај лозинку';

  @override
  String get deviceLoggedOut => 'Уређај одјављен';

  @override
  String get passwordChangedSuccessfully => 'Лозинка успешно промењена';

  @override
  String get emailChangedSuccessfully => 'Е-пошта успешно промењена';

  @override
  String get errorChangingPassword => 'Грешка при промени лозинке';

  @override
  String get errorChangingEmail => 'Грешка при промени е-поште';

  @override
  String get validEmailRequired => 'Молимо унесите важећу адресу е-поште';

  @override
  String get passwordTooShort => 'Лозинка мора имати најмање 6 карактера';

  @override
  String get maxDevicesReached => 'Пријављени сте на максимум од 3 уређаја.';

  @override
  String loggedInOnDevices(int count) {
    return 'Пријављени сте на $count од 3 уређаја.';
  }

  @override
  String get noActiveSessions => 'Нема активних сесија';

  @override
  String get logoutFromDevice => 'Одјавите се са овог уређаја';

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
  String get errorAcceptingCall => 'Грешка при прихватању позива';

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
  String typingIndicator(String name) {
    return '$name пише...';
  }

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
  String get diagnosticDataTitle => 'Дијагностички подаци';

  @override
  String get diagnosticDescription =>
      'Желите ли да шаљете анонимне дијагностичке податке за побољшање апликације?';

  @override
  String get noThanks => 'Не, хвала';

  @override
  String get yesEnable => 'Да, омогући';

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
  String get newPasswordMinChars => 'Нова лозинка (мин. 6 знакова)';

  @override
  String get reasonLabel2 => 'Разлог';

  @override
  String get downloadFailed2 => 'Преузимање неуспешно';

  @override
  String get downloadTooltip => 'Преузми';

  @override
  String get connectionErrorGeneric => 'Грешка повезивања';

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
  String get bankTransfer => 'Банковни пренос';

  @override
  String get standingOrder => 'Трајни налог';

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
  String get memberNumberTooLong => 'Члански број предуг (макс. 20 знакова)';

  @override
  String get onlyUppercaseAndNumbers =>
      'Дозвољена су само велика слова и бројеви';

  @override
  String get passwordTooLong => 'Лозинка предуга (макс. 100 знакова)';

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
  String get diagnosticErrors => 'Извештаји о грешкама за побољшање';

  @override
  String get diagnosticAnonymousStats => 'Анонимне статистике коришћења';

  @override
  String get diagnosticPerformance => 'Подаци о перформансама апликације';

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
  String get ipClean => 'IP чист - није на листи';

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
  String get helpImproveApp =>
      'Желите ли да нам помогнете да побољшамо апликацију?';

  @override
  String get noPersonalDataCollected =>
      'Лични подаци се не прикупљају. Ово подешавање се може променити у било ком тренутку.';

  @override
  String logEntries(int count) {
    return '$count записа';
  }

  @override
  String get noLogs => 'Нема записа';

  @override
  String get newLoginDetected => 'Откривена нова пријава';

  @override
  String get waitingForMember => 'Чекање на члана';

  @override
  String get waitingForStaff => 'Чекање на запосленог';

  @override
  String get waitingForAuthority => 'Чекање на орган';
}
