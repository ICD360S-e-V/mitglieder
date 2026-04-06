// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Bulgarian (`bg`).
class AppLocalizationsBg extends AppLocalizations {
  AppLocalizationsBg([String locale = 'bg']) : super(locale);

  @override
  String get appTitle => 'ICD360S e.V - Портал за членове';

  @override
  String get memberPortal => 'Портал за членове';

  @override
  String get welcomeLoading => 'Зареждане...';

  @override
  String get welcomeAutoLogin => 'Автоматично влизане...';

  @override
  String get login => 'Вход';

  @override
  String get register => 'Регистрация';

  @override
  String get becomeMember => 'Станете член';

  @override
  String get memberNumber => 'Членски номер';

  @override
  String get memberNumberHint => 'Въведете членски номер';

  @override
  String get password => 'Парола';

  @override
  String get passwordHint => 'Въведете парола';

  @override
  String get confirmPassword => 'Потвърдете паролата';

  @override
  String get confirmPasswordHint => 'Потвърдете паролата';

  @override
  String get newPassword => 'Нова парола';

  @override
  String get newPasswordHint => 'Въведете нова парола';

  @override
  String get saveCredentials => 'Запазване на данните за вход';

  @override
  String get autoLogin => 'Автоматично влизане';

  @override
  String get forgotPassword => 'Забравена парола?';

  @override
  String get firstName => 'Име и фамилия';

  @override
  String get firstNameHint => 'Въведете име и фамилия';

  @override
  String get nameMinLength => 'Името трябва да е поне 2 символа';

  @override
  String get nameOnlyLetters => 'Разрешени са само букви и тирета';

  @override
  String get email => 'Имейл адрес';

  @override
  String get emailHint => 'Въведете имейл';

  @override
  String get emailInvalid => 'Въведете валиден имейл';

  @override
  String get passwordMinLength => 'Паролата трябва да е поне 6 символа';

  @override
  String get passwordsNotMatch => 'Паролите не съвпадат';

  @override
  String get recoveryCode => 'Код за възстановяване (6 цифри)';

  @override
  String get recoveryCodeHelper =>
      'Запомнете този код за възстановяване на паролата';

  @override
  String get recoveryCodeHint => 'Въведете код за възстановяване';

  @override
  String get recoveryCodeInvalid => 'Кодът трябва да е точно 6 цифри';

  @override
  String get loginFailed => 'Неуспешно влизане';

  @override
  String get registrationFailed => 'Неуспешна регистрация';

  @override
  String connectionError(String error) {
    return 'Грешка при свързване: $error';
  }

  @override
  String registrationSuccess(String memberNumber) {
    return 'Успешна регистрация!\n\nВашият членски номер: $memberNumber\n\nЗапомнете този номер за влизане.';
  }

  @override
  String get tooManyDevices => 'Твърде много устройства';

  @override
  String get maxDevicesMessage =>
      'Вече сте влезли на 3 устройства.\nИзберете устройство за излизане:';

  @override
  String get unknownDevice => 'Неизвестно устройство';

  @override
  String get unknown => 'Неизвестно';

  @override
  String get logoutError => 'Грешка при излизане';

  @override
  String error(String error) {
    return 'Грешка: $error';
  }

  @override
  String get cancel => 'Отказ';

  @override
  String get resetPassword => 'Нулиране на паролата';

  @override
  String get forgotPasswordTitle => 'Забравена парола';

  @override
  String get forgotPasswordDescription =>
      'Въведете членския номер и кода за възстановяване, създаден при регистрация.';

  @override
  String get passwordResetSuccess =>
      'Паролата е нулирана успешно!\n\nСега можете да влезете с новата парола.';

  @override
  String get passwordResetFailed => 'Неуспешно нулиране на паролата';

  @override
  String get needHelp => 'Нуждаете се от помощ?';

  @override
  String get helpQuestion => 'Проблеми с влизането или регистрацията?';

  @override
  String get helpDescription =>
      'Свържете се с нас чрез WhatsApp и опишете какво не работи. Ще отговорим възможно най-бързо!';

  @override
  String get whatsapp => 'WhatsApp';

  @override
  String get emailSubject => 'Запитване чрез приложението ICD360S';

  @override
  String get whatsappMessage =>
      'Здравейте, имам проблем с приложението ICD360S. ';

  @override
  String get imprint => 'Импресум';

  @override
  String get privacy => 'Политика за поверителност';

  @override
  String get statutes => 'Устав';

  @override
  String get revocation => 'Право на отказ';

  @override
  String get cancellation => 'Отмяна';

  @override
  String get allRightsReserved => 'Всички права запазени.';

  @override
  String get enterCredentials => 'Въведете членски номер и парола';

  @override
  String get appointments => 'Срещи';

  @override
  String get tickets => 'Заявки';

  @override
  String get liveChat => 'Чат на живо';

  @override
  String get notifications => 'Известия';

  @override
  String get myProfile => 'Моят профил';

  @override
  String get logout => 'Изход';

  @override
  String get goodMorning => 'Добро утро';

  @override
  String get goodDay => 'Добър ден';

  @override
  String get goodEvening => 'Добър вечер';

  @override
  String get goodNight => 'Лека нощ';

  @override
  String get welcomeToICD => 'Добре дошли в ICD360S e.V!';

  @override
  String get accountCreatedSuccessfully =>
      'Вашият акаунт беше създаден успешно.';

  @override
  String get today => 'Днес';

  @override
  String get membershipFeeDue => 'Дължима членска такса';

  @override
  String get pleaseTransferAnnualFee => 'Моля, преведете годишната такса.';

  @override
  String get newBadge => 'Нов';

  @override
  String get close => 'Затвори';

  @override
  String get membership => 'Членство';

  @override
  String get myAppointments => 'Моите срещи';

  @override
  String get appointmentsLoadingReady => 'Зареждане на срещи - API готов!';

  @override
  String get priority => 'Приоритет';

  @override
  String get messageLabel => 'Съобщение';

  @override
  String get createdOn => 'Създадено';

  @override
  String get handler => 'Обработващ';

  @override
  String get reportProblems => 'Докладване на проблеми';

  @override
  String get reportProblem => 'Докладване на проблем';

  @override
  String get weRespondIn24Hours =>
      'Ще ви отговорим в рамките на максимум 24 часа!';

  @override
  String get everythingOk => 'Всичко наред!';

  @override
  String get haveProblemWeHelp => 'Имате проблем?\nНие ще се погрижим!';

  @override
  String get myMembership => 'Моето членство';

  @override
  String get managePersonalDataAndFee => 'Управление на лични данни и такса';

  @override
  String get myAppointmentsTitle => 'Моите срещи';

  @override
  String get appointmentsDescription =>
      'Тук можете да видите предстоящите си срещи.\nМожете да потвърдите участието си или да откажете.';

  @override
  String get loadAppointments => 'Зареди срещи';

  @override
  String get myTickets => 'Моите заявки';

  @override
  String get newTicket => 'Нова заявка';

  @override
  String get noOpenTickets => 'Няма отворени заявки';

  @override
  String get haveQuestionCreateTicket =>
      'Имате въпрос или проблем?\nСъздайте нова заявка.';

  @override
  String get whatIsTheProblem => 'Какъв е проблемът?';

  @override
  String get describeTheProblem => 'Опишете проблема';

  @override
  String get howUrgentIsIt => 'Колко спешно е?';

  @override
  String get low => 'Ниска';

  @override
  String get medium => 'Средна';

  @override
  String get high => 'Висока';

  @override
  String get submit => 'Изпрати';

  @override
  String get fillSubjectAndMessage => 'Моля, попълнете тема и съобщение';

  @override
  String get ticketCreated => 'Заявката е създадена';

  @override
  String get errorCreatingTicket => 'Грешка при създаване на заявка';

  @override
  String get verified => 'Потвърдено';

  @override
  String get account => 'Акаунт';

  @override
  String get myDevices => 'Моите устройства';

  @override
  String get changeEmail => 'Промени имейл';

  @override
  String get changePassword => 'Промени парола';

  @override
  String get newEmailAddress => 'Нов имейл адрес';

  @override
  String get currentPassword => 'Текуща парола';

  @override
  String get saveEmail => 'Запази имейл';

  @override
  String get savePassword => 'Запази парола';

  @override
  String get deviceLoggedOut => 'Устройството е излязло';

  @override
  String get passwordChangedSuccessfully => 'Паролата е променена успешно';

  @override
  String get emailChangedSuccessfully => 'Имейлът е променен успешно';

  @override
  String get errorChangingPassword => 'Грешка при промяна на парола';

  @override
  String get errorChangingEmail => 'Грешка при промяна на имейл';

  @override
  String get validEmailRequired => 'Моля, въведете валиден имейл адрес';

  @override
  String get passwordTooShort => 'Паролата трябва да е поне 6 символа';

  @override
  String get maxDevicesReached => 'Влезли сте в максимум 3 устройства.';

  @override
  String loggedInOnDevices(int count) {
    return 'Влезли сте в $count от 3 устройства.';
  }

  @override
  String get noActiveSessions => 'Няма активни сесии';

  @override
  String get logoutFromDevice => 'Излез от това устройство';

  @override
  String get confirmLogoutDevice => 'Излизане от устройството?';

  @override
  String get confirmLogoutMessage =>
      'Искате ли да излезете от това устройство?\n\nЩе трябва да влезете отново, за да използвате това устройство.';

  @override
  String get ipAddress => 'IP';

  @override
  String get platform => 'Платформа';

  @override
  String trialWarningUrgentTitle(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days дни',
      one: '1 ден',
    );
    return 'Внимание: Остават $_temp0 до спиране на акаунта!';
  }

  @override
  String get trialWarningTitle => 'Вашият акаунт все още не е верифициран';

  @override
  String get trialWarningDescription =>
      'Моля, попълнете данните си в \"Моят профил\". След 30 дни акаунтът ви ще бъде автоматично спрян.';

  @override
  String trialDaysRemaining(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days дни',
      one: '1 ден',
    );
    return '$_temp0';
  }

  @override
  String get overview => 'Преглед';

  @override
  String get member => 'Член';

  @override
  String get memberManagement => 'Управление на членове';

  @override
  String get reportProblemTooltip => 'Докладване на проблем';

  @override
  String get newAppointmentsTitle => 'Нови срещи';

  @override
  String get youHaveNewAppointment => 'Имате нова среща.';

  @override
  String youHaveNewAppointments(int count) {
    return 'Имате $count нови срещи.';
  }

  @override
  String get appointmentReminderTomorrow => 'Напомняне: Среща утре';

  @override
  String tomorrowAppointment(String title) {
    return 'Утре: $title';
  }

  @override
  String youHaveTomorrowAppointments(int count) {
    return 'Имате $count срещи утре.';
  }

  @override
  String get appointmentsToday => 'Срещи днес';

  @override
  String todayAppointment(String title) {
    return 'Днес: $title';
  }

  @override
  String youHaveTodayAppointments(int count) {
    return 'Имате $count срещи днес.';
  }

  @override
  String get paymentReminder => 'Напомняне за плащане';

  @override
  String paymentReminderMessage(int day, String method) {
    return 'Днес е $day-ият ден на месеца – моля завършете $method.';
  }

  @override
  String get paymentDayLabel => 'Ден на плащане (месечно напомняне)';

  @override
  String get updateAvailable => 'Налична актуализация';

  @override
  String newVersionAvailable(String version) {
    return 'Налична е нова версия: $version';
  }

  @override
  String currentVersionLabel(String version) {
    return 'Текуща версия: $version';
  }

  @override
  String get changes => 'Промени:';

  @override
  String downloadProgress(String percent) {
    return 'Изтегляне: $percent%';
  }

  @override
  String get installationStarting => 'Стартиране на инсталацията...';

  @override
  String get appWillRestart => 'Приложението ще се рестартира автоматично.';

  @override
  String get later => 'По-късно';

  @override
  String get updateNow => 'Актуализирай сега';

  @override
  String get downloading => 'Изтегляне...';

  @override
  String get downloadFailed =>
      'Изтеглянето не бе успешно. Моля, опитайте отново по-късно.';

  @override
  String get searchingForUpdates => 'Търсене на актуализации...';

  @override
  String get appUpToDate => 'Приложението е актуално';

  @override
  String get updateCheckError => 'Грешка при проверка за актуализации';

  @override
  String get changelog => 'Дневник на промените';

  @override
  String get terminConfirmed => 'Среща потвърдена';

  @override
  String get terminDeclined => 'Среща отказана';

  @override
  String get terminRescheduleRequested => 'Поискано пренасрочване';

  @override
  String get statusConfirmed => 'Потвърдено';

  @override
  String get statusDeclined => 'Отказано';

  @override
  String get statusRescheduling => 'Пренасрочване';

  @override
  String get statusPending => 'Изчакване';

  @override
  String get categoryVorstandssitzung => 'Заседание на управителния съвет';

  @override
  String get categoryMitgliederversammlung => 'Общо събрание';

  @override
  String get categorySchulung => 'Обучение';

  @override
  String get categorySonstiges => 'Друго';

  @override
  String openCount(int count) {
    return '$count отворени';
  }

  @override
  String get refresh => 'Обновяване';

  @override
  String get filterUpcoming => 'Предстоящи';

  @override
  String get filterPast => 'Минали';

  @override
  String get filterAll => 'Всички';

  @override
  String get noUpcomingAppointments => 'Няма предстоящи срещи';

  @override
  String get noPastAppointments => 'Няма минали срещи';

  @override
  String get noAppointmentsAvailable => 'Няма срещи';

  @override
  String get appointmentsShownHere => 'Вашите срещи ще се показват тук';

  @override
  String get dateLabel => 'Дата';

  @override
  String get timeLabel => 'Час';

  @override
  String get locationLabel => 'Място';

  @override
  String get createdByLabel => 'Създадено от';

  @override
  String get descriptionLabel => 'Описание';

  @override
  String get ticketLabel => 'Заявка';

  @override
  String get yourStatus => 'Вашият статус: ';

  @override
  String reasonLabel(String reason) {
    return 'Причина: $reason';
  }

  @override
  String durationMinutes(int minutes) {
    return '$minutes мин';
  }

  @override
  String get confirm => 'Потвърди';

  @override
  String get decline => 'Откажи';

  @override
  String get reschedule => 'Пренасрочи';

  @override
  String get requestReschedule => 'Поискай пренасрочване';

  @override
  String appointmentLabel(String title) {
    return 'Среща: $title';
  }

  @override
  String get rescheduleReason => 'Причина за пренасрочване *';

  @override
  String get rescheduleReasonHint => 'Моля посочете причина...';

  @override
  String get pleaseProvideReason => 'Моля посочете причина';

  @override
  String get request => 'Заяви';

  @override
  String get ticketStatusOpen => 'Отворена';

  @override
  String get ticketStatusInProgress => 'В процес';

  @override
  String get ticketStatusWaitingMember => 'Изчаква член';

  @override
  String get ticketStatusWaitingStaff => 'Изчаква служител';

  @override
  String get ticketStatusWaitingAuthority => 'Изчаква институция';

  @override
  String get ticketStatusDone => 'Приключена';

  @override
  String get ticketPriorityHigh => 'Висок';

  @override
  String get ticketPriorityMedium => 'Среден';

  @override
  String get ticketPriorityLow => 'Нисък';

  @override
  String get comments => 'Коментари';

  @override
  String get documents => 'Документи';

  @override
  String get details => 'Детайли';

  @override
  String get replySent => 'Отговорът е изпратен';

  @override
  String get sendError => 'Грешка при изпращане';

  @override
  String get uploading => 'Качване...';

  @override
  String fileUploaded(String filename) {
    return '$filename качен';
  }

  @override
  String get uploadFailed => 'Качването неуспешно';

  @override
  String get openError => 'Грешка при отваряне';

  @override
  String get noRepliesYet => 'Все още няма отговори';

  @override
  String get waitingForSupport => 'Изчаква се отговор от поддръжка';

  @override
  String get writeReply => 'Напишете отговор...';

  @override
  String get attachFile => 'Прикачете файл';

  @override
  String documentsCount(int count) {
    return 'Документи ($count)';
  }

  @override
  String get upload => 'Качване';

  @override
  String get noDocuments => 'Няма документи';

  @override
  String get allowedFormats => 'Позволени формати: PDF, JPEG, JPG, TXT, ZIP';

  @override
  String get yourMessage => 'Вашето съобщение:';

  @override
  String get translation => 'Превод';

  @override
  String get original => 'Оригинал';

  @override
  String get originalText => 'Оригинален текст';

  @override
  String get autoTranslated => 'Преведено автоматично';

  @override
  String get originalTapTranslation => 'Оригинал · Натиснете за превод';

  @override
  String get translatedTapOriginal => 'Преведено · Натиснете за оригинал';

  @override
  String get justNow => 'Току-що';

  @override
  String minutesAgo(int minutes) {
    return 'преди $minutes мин';
  }

  @override
  String hoursAgo(int hours) {
    return 'преди $hours ч';
  }

  @override
  String daysAgo(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'дни',
      one: 'ден',
    );
    return 'преди $days $_temp0';
  }

  @override
  String get createdLabel => 'Създадено';

  @override
  String get updatedLabel => 'Обновено';

  @override
  String get handlerLabel => 'Отговорник';

  @override
  String get doneLabel => 'Приключено';

  @override
  String get newTicketTitle => 'Нова заявка';

  @override
  String get categoryOptional => 'Категория (по избор)';

  @override
  String get selectCategory => 'Изберете';

  @override
  String get subjectLabel => 'Тема';

  @override
  String get fillAllFields => 'Попълнете всички полета';

  @override
  String ticketCreatedId(int id) {
    return 'Заявка #$id създадена';
  }

  @override
  String get priorityLabel => 'Приоритет: ';

  @override
  String get supportOffline => 'Поддръжка офлайн';

  @override
  String get lastSeenSeconds => 'Активен преди секунди';

  @override
  String lastSeenMinutes(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: 'минути',
      one: 'минута',
    );
    return 'Активен преди $minutes $_temp0';
  }

  @override
  String lastSeenHours(int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: 'часа',
      one: 'час',
    );
    return 'Активен преди $hours $_temp0';
  }

  @override
  String lastSeenDays(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'дни',
      one: 'ден',
    );
    return 'Активен преди $days $_temp0';
  }

  @override
  String get online => 'Онлайн';

  @override
  String get callSupport => 'Обади се';

  @override
  String get typeMessage => 'Напишете съобщение...';

  @override
  String get callBusy => 'Поддръжката е заета';

  @override
  String get callRejected => 'Обаждането е отказано';

  @override
  String get callFailed => 'Обаждането не успя';

  @override
  String get callEnded => 'Обаждането приключи';

  @override
  String get callSupportBusy => 'Поддръжката е в друго обаждане';

  @override
  String get errorStartingChat => 'Грешка при стартиране на чат';

  @override
  String get errorStartingCall => 'Грешка при стартиране на обаждане';

  @override
  String get errorConnecting => 'Грешка при свързване';

  @override
  String get errorAcceptingCall => 'Грешка при приемане на обаждане';

  @override
  String get errorDownloading => 'Грешка при изтегляне';

  @override
  String get errorUploading => 'Грешка при качване';

  @override
  String get errorSending => 'Грешка при изпращане';

  @override
  String get errorPickingPhotos => 'Грешка при избиране на снимки';

  @override
  String get errorPickingFiles => 'Грешка при избиране на файлове';

  @override
  String get errorTakingPhoto => 'Грешка при снимане';

  @override
  String get fileNotLoaded => 'Файлът не може да се зареди';

  @override
  String get attachmentIdMissing => 'Липсва ID на прикачения файл';

  @override
  String get camera => 'Камера';

  @override
  String get gallery => 'Галерия';

  @override
  String get file => 'Файл';

  @override
  String typingIndicator(String name) {
    return '$name пише...';
  }

  @override
  String get notifNewMessageFrom => 'Ново съобщение от';

  @override
  String get notifUrgentPrefix => 'СПЕШНО';

  @override
  String get notifUrgentMessage => 'СПЕШНО СЪОБЩЕНИЕ';

  @override
  String get notifIncomingCall => 'Входящо обаждане';

  @override
  String get notifCallingYou => 'ви се обажда...';

  @override
  String get notifUpdateAvailable => 'Налична актуализация';

  @override
  String get notifVersionAvailable => 'вече е налична';

  @override
  String get notifConnected => 'Свързан';

  @override
  String get notifDisconnected => 'Прекъснат';

  @override
  String get notifConnectedBody => 'Свързани сте със сървъра.';

  @override
  String get notifDisconnectedBody => 'Връзката със сървъра беше прекъсната.';

  @override
  String get notifError => 'Грешка';

  @override
  String get retry => 'Опитай отново';

  @override
  String get save => 'Запази';

  @override
  String get accept => 'Приемам';

  @override
  String get selectFile => 'Избери файл';

  @override
  String get dataLoadingText => 'Зареждане на данни...';

  @override
  String get dataSavedSuccess => 'Данните са запазени успешно';

  @override
  String get errorSaving => 'Грешка при запазване';

  @override
  String get errorLoading => 'Грешка при зареждане';

  @override
  String savedFilename(String filename) {
    return 'Запазено: $filename';
  }

  @override
  String get logsCopied => 'Логовете са копирани!';

  @override
  String get diagnosticDataTitle => 'Диагностични данни';

  @override
  String get diagnosticDescription =>
      'Искате ли да изпращате анонимни диагностични данни за подобряване на приложението?';

  @override
  String get noThanks => 'Не, благодаря';

  @override
  String get yesEnable => 'Да, активирай';

  @override
  String get passwordMinEightChars => 'Паролата трябва да е поне 8 символа';

  @override
  String get passwordChangeSuccess => 'Паролата е променена успешно';

  @override
  String get emailChangeError => 'Грешка при промяна на имейл';

  @override
  String get acceptDocumentCheckbox => 'Прочетох и приемам документа.';

  @override
  String loadingErrorGeneric(String details) {
    return 'Грешка при зареждане: $details';
  }

  @override
  String get incomingCallTitle => 'Входящо обаждане';

  @override
  String ringingFor(int seconds) {
    return 'Звъни от $secondsс';
  }

  @override
  String get rejectCall => 'Отхвърли';

  @override
  String get acceptCall => 'Приеми';

  @override
  String get unmute => 'Включи звука';

  @override
  String get mute => 'Заглуши';

  @override
  String get hangUp => 'Затвори';

  @override
  String get calling => 'Обаждане...';

  @override
  String autoRejectIn(int seconds) {
    return 'Автоматично отхвърляне след $seconds секунди';
  }

  @override
  String get speakerOn => 'Високоговорител';

  @override
  String get speakerOff => 'Слушалка';

  @override
  String get micMuted => 'Заглушен';

  @override
  String get micOn => 'Микрофон';

  @override
  String get connectionExcellent => 'Отлично';

  @override
  String get connectionGood => 'Добро';

  @override
  String get connectionWeak => 'Слабо';

  @override
  String get connectionLost => 'Прекъснато';

  @override
  String get personalData => 'Лични данни';

  @override
  String get personalDataSubtitle => 'Име, фамилия, адрес';

  @override
  String get membershipFee => 'Членски внос';

  @override
  String annualFeeYear(String year) {
    return 'Годишен внос $year';
  }

  @override
  String get amount => 'Сума:';

  @override
  String get dueBy => 'Срок:';

  @override
  String get paid => 'Платено';

  @override
  String get versionHistory => 'История на версиите';

  @override
  String lastUpdated(String date) {
    return 'Последна актуализация: $date';
  }

  @override
  String get noVersionHistory => 'Няма налична история';

  @override
  String get failedLoadChangelog => 'Неуспешно зареждане на дневника';

  @override
  String get callMember => 'Обади се на член';

  @override
  String get closeConversation => 'Затвори разговора';

  @override
  String get chatOffline => 'Офлайн';

  @override
  String get attachFiles => 'Прикачи файлове (макс. 10, 50MB)';

  @override
  String get conversationClosed => 'Този разговор е затворен';

  @override
  String get noMessages => 'Няма съобщения';

  @override
  String get goBack => 'Назад';

  @override
  String get goForward => 'Напред';

  @override
  String get homePage => 'Начало';

  @override
  String get firstNameLabel => 'Име';

  @override
  String get lastNameLabel => 'Фамилия';

  @override
  String get streetLabel => 'Улица';

  @override
  String get houseNumberLabel => '№';

  @override
  String get postalCodeLabel => 'Пощенски код';

  @override
  String get cityLabel => 'Град';

  @override
  String get phoneMobileLabel => 'Телефон (Мобилен)';

  @override
  String get phoneLandlineLabel => 'Телефон (Стационарен)';

  @override
  String get newEmailLabel => 'Нов имейл адрес';

  @override
  String get currentPasswordLabel => 'Текуща парола';

  @override
  String get newPasswordLabel => 'Нова парола';

  @override
  String get confirmPasswordLabel => 'Потвърдете паролата';

  @override
  String get emailChangedSuccess => 'Имейлът е променен успешно';

  @override
  String get newPasswordMinChars => 'Нова парола (мин. 6 символа)';

  @override
  String get reasonLabel2 => 'Причина';

  @override
  String get downloadFailed2 => 'Изтеглянето не успя';

  @override
  String get downloadTooltip => 'Изтегли';

  @override
  String get connectionErrorGeneric => 'Грешка при свързване';

  @override
  String get errorNoInternet => 'Няма интернет връзка. Моля, проверете мрежата си.';

  @override
  String get errorTimeout => 'Сървърът не отговаря. Моля, опитайте по-късно.';

  @override
  String get errorServer => 'Грешка на сървъра. Моля, опитайте по-късно.';

  @override
  String get errorConnection => 'Грешка при свързване. Моля, опитайте по-късно.';

  @override
  String get errorUnexpected => 'Възникна неочаквана грешка. Моля, опитайте по-късно.';

  @override
  String get copyLogs => 'Копирай логове';

  @override
  String get deleteLogs => 'Изтрий логове';

  @override
  String get autoScrollOn => 'Автоматично превъртане ВКЛ';

  @override
  String get autoScrollOff => 'Автоматично превъртане ИЗКЛ';

  @override
  String get unknownValue => 'Неизвестно';

  @override
  String get bankTransfer => 'Банков превод';

  @override
  String get standingOrder => 'Периодичен превод';

  @override
  String get payment => 'Плащане';

  @override
  String get warningType_ermahnung => 'Предупреждение';

  @override
  String get warningType_abmahnung => 'Забележка';

  @override
  String get warningType_letzte => 'Последно предупреждение';

  @override
  String warningsTotal(int count) {
    return 'Общо: $count';
  }

  @override
  String warningsErmahnung(int count) {
    return 'Предупреждения: $count';
  }

  @override
  String warningsAbmahnung(int count) {
    return 'Забележки: $count';
  }

  @override
  String warningsLetzte(int count) {
    return 'Последни: $count';
  }

  @override
  String get noWarnings => 'Няма предупреждения';

  @override
  String get noWarningsDescription => 'В момента нямате предупреждения.';

  @override
  String createdBy(String name) {
    return 'Създадено от: $name';
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
  String get monthNov => 'Noe';

  @override
  String get monthDec => 'Dek';

  @override
  String get stufe1_name => 'Лични данни';

  @override
  String get stufe2_name => 'Тип членство';

  @override
  String get stufe3_name => 'Финансово положение';

  @override
  String get stufe4_name => 'Начин на плащане';

  @override
  String get stufe5_name => 'Начало на членството';

  @override
  String get stufe6_name => 'Устав';

  @override
  String get stufe7_name => 'Политика за поверителност';

  @override
  String get stufe8_name => 'Право на отказ';

  @override
  String get memberType_ordentlich => 'Редовен член';

  @override
  String get memberType_foerder => 'Подкрепящ член';

  @override
  String get memberType_ehren => 'Почетен член';

  @override
  String get memberDesc_ordentlich =>
      'Активен член с право на глас. Участва в услугите на сдружението (имейл, облак, бюрократична подкрепа).';

  @override
  String get memberDesc_foerder =>
      'Подкрепя сдружението с вноски. Може да присъства на общото събрание със съвещателен глас, без право на глас или избираемост в управителния съвет.';

  @override
  String get memberDesc_ehren =>
      'Има правата на редовен член без задължение за плащане на членски внос. Назначен от общото събрание или управителния съвет.';

  @override
  String get payMethod_ueberweisung => 'Банков превод';

  @override
  String get payMethod_dauerauftrag => 'Периодичен превод';

  @override
  String get verifyStatus_geprueft => 'Проверено';

  @override
  String get verifyStatus_ausgefuellt => 'Попълнено';

  @override
  String get verifyStatus_abgelehnt => 'Отхвърлено';

  @override
  String get verifyStatus_offen => 'Отворено';

  @override
  String get fillRequiredFields =>
      'Моля, попълнете всички задължителни полета.';

  @override
  String get personalDataSaved => 'Личните данни са запазени';

  @override
  String get selectMemberType => 'Моля, изберете тип членство.';

  @override
  String get memberTypeSaved => 'Типът членство е запазен';

  @override
  String get selectOption => 'Моля, изберете опция.';

  @override
  String get financialSaved => 'Финансовото положение е запазено';

  @override
  String get selectPaymentMethod => 'Моля, изберете начин на плащане.';

  @override
  String get paymentDataSaved => 'Данните за плащане са запазени';

  @override
  String get selectDate => 'Моля, изберете дата.';

  @override
  String get membershipStartSaved => 'Началото на членството е запазено';

  @override
  String get fileTooLarge => 'Файлът е прекалено голям (макс. 10 MB).';

  @override
  String get leistungsbescheidUploaded =>
      'Удостоверението за обезщетение е качено успешно';

  @override
  String get verificationProgress => 'Напредък на проверката';

  @override
  String get notApplicable => 'Неприложимо';

  @override
  String get socialBenefitsExempt =>
      'Начин на плащане не е необходим за получатели на социални помощи.';

  @override
  String get locked => 'Заключено';

  @override
  String completePreviousStep(int step) {
    return 'Моля, първо завършете стъпка $step.';
  }

  @override
  String rejectedNote(String note) {
    return 'Отхвърлено: $note';
  }

  @override
  String get waitingForReview => 'Чака преглед от управителния съвет.';

  @override
  String get stepApproved => 'Тази стъпка е прегледана и одобрена.';

  @override
  String get changesViaChat => 'Промени са възможни само чрез чат.';

  @override
  String get firstNameRequired => 'Име *';

  @override
  String get lastNameRequired => 'Фамилия *';

  @override
  String get birthDateLabel => 'Дата на раждане *';

  @override
  String get streetRequired => 'Улица *';

  @override
  String get houseNumberRequired => '№ *';

  @override
  String get cityRequired => 'Град *';

  @override
  String get phoneRequired => 'Телефонен номер *';

  @override
  String get phonePurpose =>
      'Цел: Контакт, когато не сте достъпни чрез приложението';

  @override
  String get selectMemberTypePrompt => 'Моля, изберете желания тип членство:';

  @override
  String get financialExplanation =>
      'За да проверим дали имате право на намалена вноска, се нуждаем от следната информация. Тя ще бъде използвана единствено за определяне на вашия членски внос.';

  @override
  String get socialBenefitsQuestion =>
      'Получавате ли в момента социални помощи?';

  @override
  String get optionBuergergeld => 'Да, гражданска помощ (Job Center)';

  @override
  String get optionSozialamt => 'Да, социална помощ (Социална служба)';

  @override
  String get optionNoBenefits => 'Не, не получавам социални помощи';

  @override
  String get feeExempt => 'Вашата месечна вноска е: 0,00 €/месец';

  @override
  String get uploadLeistungsbescheid => 'Качете удостоверение за обезщетение';

  @override
  String get uploadLeistungsbescheidHint =>
      'Качете актуално удостоверение за обезщетение в рамките на 14 дни за потвърждаване на освобождаването от вноска.';

  @override
  String get allowedFormatsUpload =>
      'Разрешени формати: PDF, JPG, PNG (макс. 10 MB)';

  @override
  String get feeRegular => 'Вашата месечна вноска е: 25,00 €/месец';

  @override
  String paymentDayReminder(int day) {
    return 'Ще бъдете напомнени на $day-ти всеки месец.';
  }

  @override
  String get membershipStartPrompt => 'Изберете кога да започне членството ви.';

  @override
  String get optionAfterVerification => 'След завършване на проверката';

  @override
  String get optionAfterVerificationDesc =>
      'Членството започва от деня на потвърждението от управителния съвет.';

  @override
  String get optionRetroFoundation =>
      'Ретроактивно до датата на основаване (01.08.2025)';

  @override
  String get optionRetroFoundationDesc =>
      'Ставате ретроактивен член от основаването на сдружението.';

  @override
  String get optionRetroCustom => 'Ретроактивно до друга дата';

  @override
  String get optionRetroCustomDesc => 'Изберете дата между 01.08.2025 и днес.';

  @override
  String get selectDateLabel => 'Изберете дата';

  @override
  String get selectDateHint => 'Изберете дата...';

  @override
  String get dateNotBefore => 'Не по-рано от 01.08.2025 (дата на основаване)';

  @override
  String get feeExemptRetro =>
      'Освобождение от вноска: 0,00 € ретроактивно.\nСамо датата на членството се задава ретроактивно.';

  @override
  String get retroactiveFees => 'Ретроактивни вноски';

  @override
  String retroFeeCalculation(
      String from, String to, String months, String total) {
    return 'Период: $from – $to\nМесеци: $months\nВноска: $months × 25,00 € = $total €';
  }

  @override
  String get pleaseReadSatzung => 'Моля, прочетете устава на сдружението.';

  @override
  String get pleaseReadDatenschutz =>
      'Моля, прочетете политиката за поверителност.';

  @override
  String get pleaseReadWiderruf => 'Моля, прочетете правото на отказ.';

  @override
  String get acceptedAtRegistration => 'Прието при регистрация';

  @override
  String get confirmedByBoard =>
      'Ще бъде потвърдено след преглед от управителния съвет.';

  @override
  String get docSatzung => 'Устав';

  @override
  String get docDatenschutz => 'Политика за поверителност';

  @override
  String get docWiderruf => 'Право на отказ';

  @override
  String acceptedAtRegCount(int count) {
    return 'Прието при регистрация ($count/3)';
  }

  @override
  String acceptedOn(String date) {
    return 'Прието на $date';
  }

  @override
  String get notAccepted => 'Не е прието';

  @override
  String get statusAccepted => 'Прието';

  @override
  String get memberNumberTooLong =>
      'Членският номер е твърде дълъг (макс. 20 символа)';

  @override
  String get onlyUppercaseAndNumbers =>
      'Разрешени са само главни букви и цифри';

  @override
  String get passwordTooLong => 'Паролата е твърде дълга (макс. 100 символа)';

  @override
  String get nameTooLong => 'Името е твърде дълго (макс. 100 символа)';

  @override
  String get emailTooLong => 'Имейлът е твърде дълъг (макс. 255 символа)';

  @override
  String get legalAcknowledgePrefix => 'Запознах се с ';

  @override
  String get legalAcknowledgeSuffix => '.';

  @override
  String get legalStatutesSuffix =>
      ' на ICD360S e.V. и ги признавам за задължителни.';

  @override
  String get legalPleaseReadFirst => '(моля, прочетете първо)';

  @override
  String get statusActive => 'Активен';

  @override
  String get statusSuspended => 'Спрян';

  @override
  String get statusNew => 'Нов';

  @override
  String get statusCancelled => 'Прекратен';

  @override
  String get statusDeleted => 'Изтрит';

  @override
  String get roleMitglied => 'Член';

  @override
  String get roleVorsitzer => 'Председател';

  @override
  String get roleStellvertreter => 'Заместник';

  @override
  String get roleSchatzmeister => 'Ковчежник';

  @override
  String get roleSchriftfuehrer => 'Секретар';

  @override
  String get roleBeisitzer => 'Заседател';

  @override
  String get roleKassierer => 'Касиер';

  @override
  String get roleKassenpruefer => 'Ревизор';

  @override
  String get roleEhrenamtlich => 'Доброволец';

  @override
  String get roleMitgliedergruender => 'Учредител';

  @override
  String get roleEhrenmitglied => 'Почетен член';

  @override
  String get roleFoerdermitglied => 'Подкрепящ член';

  @override
  String get memberTypeNotSet => 'Все още не е определено';

  @override
  String get payMethodSepa => 'SEPA директен дебит';

  @override
  String get labelStatus => 'Статус';

  @override
  String get labelMemberNumber => 'Членски номер';

  @override
  String get labelRole => 'Роля';

  @override
  String get labelMemberType => 'Вид членство';

  @override
  String get labelPaymentMethod => 'Начин на плащане';

  @override
  String get labelRegisteredOn => 'Регистриран на';

  @override
  String get labelLastLogin => 'Последно влизане';

  @override
  String get labelMemberSince => 'Член от';

  @override
  String get neverLoggedIn => 'Никога';

  @override
  String get notActivatedYet => 'Все още не е активирано';

  @override
  String get tabVerification => 'Верификация';

  @override
  String get tabWarnings => 'Предупреждения';

  @override
  String get tabDocuments => 'Документи';

  @override
  String get tabMembership => 'Членство';

  @override
  String get pleaseEnterFirstName => 'Въведете име';

  @override
  String get pleaseEnterLastName => 'Въведете фамилия';

  @override
  String get noFileDataReceived => 'Няма получени данни';

  @override
  String get openFile => 'Отвори';

  @override
  String get diagnosticErrors => 'Доклади за грешки за подобрение';

  @override
  String get diagnosticAnonymousStats => 'Анонимна статистика за използване';

  @override
  String get diagnosticPerformance =>
      'Данни за производителността на приложението';

  @override
  String get noMicrophoneError =>
      'Не е намерен микрофон. Свържете микрофон и опитайте отново.';

  @override
  String get startConversation => 'Започнете разговор!';

  @override
  String get staffWillReply => 'Служител ще ви отговори скоро.';

  @override
  String get inCall => 'В разговор...';

  @override
  String get registration => 'Регистрация';

  @override
  String get deactivation => 'Деактивиране';

  @override
  String get deactivatedOn => 'Деактивирано на';

  @override
  String get accountAutoSuspend =>
      'Акаунти, които не са верифицирани в рамките на 30 дни, ще бъдат автоматично спрени.';

  @override
  String get ipClean => 'IP чист - не е в списък';

  @override
  String get documentsProvidedByBoard =>
      'Документите се предоставят от управителния съвет.';

  @override
  String get noDocumentsAvailable => 'Няма документи';

  @override
  String get noDocumentsDescription =>
      'Все още не са предоставени документи за вас.';

  @override
  String uploadedBy(String name) {
    return 'Качено от: $name';
  }

  @override
  String stepsCompleted(int completed, int total) {
    return '$completed/$total стъпки завършени';
  }

  @override
  String dayOfMonth(int day) {
    return '$day-и ден от месеца';
  }

  @override
  String changeField(String field) {
    return 'Промяна на $field';
  }

  @override
  String openDocument(String name) {
    return 'Отвори $name';
  }

  @override
  String get helpImproveApp =>
      'Искате ли да ни помогнете да подобрим приложението?';

  @override
  String get noPersonalDataCollected =>
      'Не се събират лични данни. Тази настройка може да бъде променена по всяко време.';

  @override
  String logEntries(int count) {
    return '$count записа';
  }

  @override
  String get noLogs => 'Няма логове';

  @override
  String get newLoginDetected => 'Открито ново влизане';

  @override
  String get waitingForMember => 'Изчакване на член';

  @override
  String get waitingForStaff => 'Изчакване на служител';

  @override
  String get waitingForAuthority => 'Изчакване на орган';
}
