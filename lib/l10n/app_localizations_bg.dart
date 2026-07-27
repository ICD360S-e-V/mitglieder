// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Bulgarian (`bg`).
class AppLocalizationsBg extends AppLocalizations {
  AppLocalizationsBg([String locale = 'bg']) : super(locale);

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
  String get confirmPassword => 'Потвърдете паролата';

  @override
  String get confirmPasswordHint => 'Потвърдете паролата';

  @override
  String get newPassword => 'Нова парола';

  @override
  String get newPasswordHint => 'Въведете нова парола';

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
  String get unknown => 'Неизвестно';

  @override
  String error(String error) {
    return 'Грешка: $error';
  }

  @override
  String get cancel => 'Отказ';

  @override
  String get resetPassword => 'Нулиране на паролата';

  @override
  String get imprint => 'Импресум';

  @override
  String get privacy => 'Политика за поверителност';

  @override
  String get statutes => 'Устав';

  @override
  String get revocation => 'Право на отказ';

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
  String get myAppointments => 'Моите срещи';

  @override
  String get priority => 'Приоритет';

  @override
  String get messageLabel => 'Съобщение';

  @override
  String get reportProblems => 'Докладване на проблеми';

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
  String get low => 'Ниска';

  @override
  String get high => 'Висока';

  @override
  String get submit => 'Изпрати';

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
  String get saveEmail => 'Запази имейл';

  @override
  String get savePassword => 'Запази парола';

  @override
  String get deviceLoggedOut => 'Устройството е излязло';

  @override
  String get emailChangedSuccessfully => 'Имейлът е променен успешно';

  @override
  String get errorChangingPassword => 'Грешка при промяна на парола';

  @override
  String get errorChangingEmail => 'Грешка при промяна на имейл';

  @override
  String get validEmailRequired => 'Моля, въведете валиден имейл адрес';

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
  String get autoUpdateEnableTitle => 'Install future updates automatically';

  @override
  String get autoUpdateEnableHint =>
      'The app downloads and installs updates on its own and restarts briefly. No further prompts.';

  @override
  String autoUpdateInstalling(String version) {
    return 'Version $version is being installed in the background. The app will restart shortly.';
  }

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
  String get reasonLabel2 => 'Причина';

  @override
  String get downloadFailed2 => 'Изтеглянето не успя';

  @override
  String get downloadTooltip => 'Изтегли';

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
  String logEntries(int count) {
    return '$count записа';
  }

  @override
  String get noLogs => 'Няма логове';

  @override
  String get newLoginDetected => 'Открито ново влизане';

  @override
  String get errorNoInternet =>
      'Няма интернет връзка. Моля, проверете мрежата си.';

  @override
  String get errorTimeout => 'Сървърът не отговаря. Моля, опитайте по-късно.';

  @override
  String get errorServer => 'Грешка на сървъра. Моля, опитайте по-късно.';

  @override
  String get errorConnection =>
      'Грешка при свързване. Моля, опитайте по-късно.';

  @override
  String get errorUnexpected =>
      'Възникна неочаквана грешка. Моля, опитайте по-късно.';

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
  String get claudiuWelcomeMorning => 'Добро утро';

  @override
  String get claudiuWelcomeDay => 'Здравейте';

  @override
  String get claudiuWelcomeEvening => 'Добър вечер';

  @override
  String get claudiuWelcomeNight => 'Добър вечер';

  @override
  String get claudiuWelcomeVisitor => 'скъпи посетителю';

  @override
  String get claudiuWelcomeAsk => 'Как мога да помогна?';

  @override
  String get claudiuWelcomeBecomeMember => 'Искам да стана член';

  @override
  String get claudiuWelcomeLogin => 'Вече съм член и искам да вляза';

  @override
  String get claudiuWelcomeProblem => 'Имам проблем с приложението';

  @override
  String get claudiuWelcomeEmergency => 'Спешно — обадете ни се';

  @override
  String get claudiuWelcomeMascotName => 'Claudiu';

  @override
  String get claudiuWelcomeEmergencyIntro =>
      'Преди да се обадите — нашето работно време:';

  @override
  String get claudiuWelcomeScheduleOffice => 'В офиса';

  @override
  String get claudiuWelcomeScheduleField => 'На терен с клиентите';

  @override
  String get claudiuWelcomeOutsideHoursNote =>
      'Извън тези часове приемаме само спешни случаи. Можете и да пишете на същия номер — ще се свържем с вас.';

  @override
  String get claudiuWelcomeCallNow => 'Обадете се сега';

  @override
  String get claudiuWelcomeSendSms => 'Изпрати SMS';

  @override
  String get claudiuWelcomeSmsBody =>
      'Спешно ICD360S e.V. — моля, свържете се с мен възможно най-скоро.';

  @override
  String get claudiuWelcomeCloseButton => 'Затвори';

  @override
  String get claudiuLoginWelcome => 'Добре дошли отново, скъпи член!';

  @override
  String get claudiuLoginAsk => 'Моля, кажете ми членския си номер.';

  @override
  String get claudiuLoginProgress => 'Почти… продължавайте да пишете.';

  @override
  String get claudiuLoginReady => 'Перфектно! Натиснете бутона по-долу.';

  @override
  String get claudiuLoginLoading => 'Проверявам самоличността… 🔍';

  @override
  String get claudiuLoginFoundPlain => 'Намерих ви! Влизате сега…';

  @override
  String claudiuLoginFoundNamed(String name) {
    return 'Намерих ви, $name! Влизате сега…';
  }

  @override
  String get claudiuLoginError =>
      'Хм, не намирам този номер. Проверете дали сте го въвели правилно.';

  @override
  String get claudiuLoginForgotHeader => 'Забравихте членския си номер?';

  @override
  String get claudiuLoginNoSms => 'Не изпращаме номера по имейл или SMS.';

  @override
  String get claudiuLoginOnlyWay =>
      'Единственият начин: лична среща в офиса на сдружението, след проверка на личната карта.';

  @override
  String get claudiuLoginContactUs => 'Обадете се за час:';

  @override
  String get claudiuDiagnosticGreeting => 'Преди да влезете, един въпрос';

  @override
  String get claudiuDiagnosticAsk =>
      'Мога ли да изпращам анонимни отчети, за да могат разработчиците да подобрят приложението?';

  @override
  String get claudiuDiagnosticYes => 'Да, искам да помогна';

  @override
  String get claudiuDiagnosticNo => 'Не, само разглеждам';

  @override
  String get claudiuDiagnosticTellMore => 'Кажете ми повече';

  @override
  String get claudiuDiagnosticSendsHeader => '📤 Какво ИЗПРАЩАМЕ (анонимно):';

  @override
  String get claudiuDiagnosticSends1 =>
      'Анонимен код на устройството (НЕ членския номер)';

  @override
  String get claudiuDiagnosticSends2 => 'Вашата роля (член / борд)';

  @override
  String get claudiuDiagnosticSends3 =>
      'Операционна система (Linux / Android / iOS / Windows)';

  @override
  String get claudiuDiagnosticSends4 => 'Избран език';

  @override
  String get claudiuDiagnosticSends5 => 'Ниво и състояние на батерията';

  @override
  String get claudiuDiagnosticSends6 => 'Текущ екран';

  @override
  String get claudiuDiagnosticSends7 => 'Времетраене на сесията (секунди)';

  @override
  String get claudiuDiagnosticSends8 => 'Грешки, ако има (последните 10)';

  @override
  String get claudiuDiagnosticSends9 => 'Навигация (последните 20 екрана)';

  @override
  String get claudiuDiagnosticNeverHeader => '🛡️ Какво НИКОГА не изпращаме:';

  @override
  String get claudiuDiagnosticNever1 => 'Вашето истинско име';

  @override
  String get claudiuDiagnosticNever2 => 'Имейл адрес';

  @override
  String get claudiuDiagnosticNever3 => 'Телефонен номер';

  @override
  String get claudiuDiagnosticNever4 => 'Парола';

  @override
  String get claudiuDiagnosticNever5 => 'Съдържание на съобщенията в чата';

  @override
  String get claudiuDiagnosticNever6 => 'Съдържание на тикетите';

  @override
  String get claudiuDiagnosticNever7 => 'Документи или прикачени файлове';

  @override
  String get claudiuDiagnosticTechHeader => '📡 Технически детайли:';

  @override
  String get claudiuDiagnosticTech1 => 'Изпраща се на всеки 2 минути';

  @override
  String get claudiuDiagnosticTech2 =>
      'TLS-криптирана връзка с фиксиран сертификат';

  @override
  String get claudiuDiagnosticTech3 =>
      'Можете да го изключите по всяко време от Настройки';

  @override
  String get claudiuProblemHelpTitle => 'Как мога да помогна?';

  @override
  String get claudiuProblemHelpGreeting => 'Какво се случи?';

  @override
  String get claudiuProblemHelpAsk => 'Как искате да ми разкажете?';

  @override
  String get claudiuProblemHelpWriteTitle => 'Напишете доклад';

  @override
  String get claudiuProblemHelpWriteBody =>
      'Със стъпка-по-стъпка детайли. Екипът получава текста и го решава по-късно.';

  @override
  String get claudiuProblemHelpChatTitle => 'Да поговорим сега';

  @override
  String get claudiuProblemHelpChatBody =>
      'Анонимен чат с оператор. Отговор в реално време, ако някой е онлайн.';

  @override
  String get claudiuProblemHelpAltCallHeader => 'Или, ако е спешно:';

  @override
  String get claudiuProblemHelpAltCallLabel => 'Обади се';

  @override
  String get claudiuAnonymousChatTitle => 'Анонимен чат';

  @override
  String get claudiuAnonymousChatGreeting => 'Здравей!';

  @override
  String get claudiuAnonymousChatWelcome =>
      'Слушам ви. Пишете каквото искате — не е нужно име. Ще отговоря веднага щом съм тук.';

  @override
  String get claudiuAnonymousChatHint => 'Напишете съобщение…';

  @override
  String get claudiuAnonymousChatWaitingOperator =>
      'Чакаме оператор да отговори…';

  @override
  String get claudiuVorsitzerConnectedTitle => 'Здравей!';

  @override
  String get claudiuVorsitzerConnectedBody =>
      'Благодарим, че се свърза с нас — вече си в чат с Vorsitzer. Кажи как можем да ти помогнем с молбата за членство.';

  @override
  String get claudiuVorsitzerConnectedSender => 'Vorsitzer';

  @override
  String get claudiuQuickReplyValidationTime =>
      'Колко време отнема проверката?';

  @override
  String get claudiuQuickReplyDocuments => 'Какви документи са ми нужни?';

  @override
  String get claudiuQuickReplyStepProblem => 'Заседнал съм на една стъпка';

  @override
  String get claudiuQuickReplyHuman => 'Мога ли да говоря с някого сега?';

  @override
  String get claudiuAnonymousChatConnecting => 'Свързване…';

  @override
  String get claudiuAnonymousChatConnectionFailed =>
      'Чатът не може да се отвори. Опитайте отново или се обадете.';

  @override
  String get claudiuAnonymousChatRetry => 'Опитайте отново';

  @override
  String get claudiuAnonymousChatOnline => 'Свързан';

  @override
  String get claudiuAnonymousChatOffline => 'Повторно свързване…';

  @override
  String get claudiuAnonymousChatAdminTyping => 'Операторът пише…';

  @override
  String get claudiuProblemReportTitle => 'Докладване на проблем';

  @override
  String get claudiuProblemReportGreeting => 'Какво се случи?';

  @override
  String get claudiuProblemReportAsk =>
      'Кажете ми с детайли и ще препратя доклада на екипа.';

  @override
  String get claudiuProblemReportIncludeHeader => 'Моля, включете:';

  @override
  String get claudiuProblemReportIncludeBullets1 =>
      'Какво правехте, когато се появи проблемът';

  @override
  String get claudiuProblemReportIncludeBullets2 =>
      'Каквото и съобщение за грешка сте видели';

  @override
  String get claudiuProblemReportIncludeBullets3 => 'На кой екран сте били';

  @override
  String get claudiuProblemReportIncludeBullets4 =>
      'Приложението забива ли? Затваря се? Показва бял екран?';

  @override
  String get claudiuProblemReportIncludeBullets5 =>
      'Повтаря ли се всеки път или само веднъж?';

  @override
  String get claudiuProblemReportDescriptionLabel => 'Вашето описание';

  @override
  String get claudiuProblemReportDescriptionHint =>
      'Напр.: Когато отворя екрана за чат, появява се съобщение „Connection error\" и приложението спира да отговаря…';

  @override
  String claudiuProblemReportTooShort(int count) {
    return 'Малко повече детайли, моля (минимум $count символа)';
  }

  @override
  String get claudiuProblemReportSubmit => 'Изпрати доклада';

  @override
  String get claudiuProblemReportSubmitting => 'Изпращане…';

  @override
  String get claudiuProblemReportSentTitle => 'Благодаря!';

  @override
  String get claudiuProblemReportSentBody =>
      'Докладът е изпратен. Нашият екип ще го разгледа възможно най-скоро.';

  @override
  String get claudiuProblemReportSentClose => 'Разбрано';

  @override
  String get claudiuProblemReportSendFailed =>
      'Не може да се изпрати докладът. Обадете ни се за спешна помощ.';

  @override
  String get claudiuProblemReportAlt => 'Или, ако е спешно:';

  @override
  String get claudiuProblemReportCallLabel => 'Обади се';

  @override
  String claudiuApprovalGreeting(String name) {
    return 'Здравей, $name! 👋';
  }

  @override
  String get claudiuApprovalGreetingNoName => 'Здравей! 👋';

  @override
  String get claudiuApprovalGladToSeeYou => 'Радвам се, че дойде!';

  @override
  String get claudiuApprovalCheckingForSafety =>
      'За вашата сигурност, Vorsitzer проверява заявката ви за вход в момента. 🛡️';

  @override
  String get claudiuApprovalMonthlyExplain =>
      '💡 Правим това веднъж на 30 дни, за да сме сигурни, че наистина си ти. Това е като проверка на сигурността — максимум 5 минути.';

  @override
  String get claudiuApprovalSuccess =>
      'Готово! 🎉 Vorsitzer ви разпозна. Влизате сега…';

  @override
  String get claudiuApprovalDenied => 'Хм, Vorsitzer отхвърли заявката ви. 😔';

  @override
  String get claudiuApprovalDeniedHelp =>
      'Ако смятате, че това е грешка, моля обадете ни се да изясним.';

  @override
  String get claudiuApprovalExpired =>
      '5-те минути изтекоха и не получихме отговор от Vorsitzer.';

  @override
  String get claudiuApprovalExpiredHelp =>
      'Обадете се и можем да одобрим заявката ви веднага. 📞';

  @override
  String get claudiuApprovalCallUs => 'Обади се';

  @override
  String get claudiuApprovalTryAgain => 'Опитайте отново';

  @override
  String get claudiuApprovalCancel => 'Отказ';

  @override
  String get claudiuApprovalClose => 'Затвори';

  @override
  String get wizardIntroBubble1 =>
      'Здравей, посетителю! 👋 Благодаря, че искаш да станеш част от нашето семейство.';

  @override
  String get wizardIntroBubble2 =>
      'Казвам се Клаудиу. През пролетта на 2025 имах ясна визия: да създам сдружение, което помага на хора в нужда — доброволно, от сърце, без излишна бюрокрация. ❤️';

  @override
  String get wizardIntroBubble3 =>
      'Започнах да говоря с клиентите, които посещавах. Разказах им мечтата си. И всеки каза: „Да, давай!\" През юли 2025 се срещнахме — 6 решителни души. Решихме да основем **ICD360S e.V.** в Ной-Улм. 📍';

  @override
  String get wizardIntroBubble4 =>
      'На **1 август 2025** сдружението официално оживя — в Регистъра на сдруженията. Най-красивият ми подарък. 🎂';

  @override
  String get wizardIntroBubble5 =>
      'Какво правим? Помагаме на бежанци, хора с увреждания, икономически уязвими, **деца и младежи** — с административни въпроси, немски език, жилище, пазаруване, социални помощи. Нашият Vorstand се състои предимно от хора с увреждания — така решенията идват от истински житейски опит. 🤝';

  @override
  String get wizardIntroBubble6 =>
      'Сега е твой ред. Хайде да те запишем — отнема около 5 минути. Вървим стъпка по стъпка, няма да те оставя сам. ✨';

  @override
  String get wizardIntroStart => 'Да започнем';

  @override
  String get wizardBack => 'Назад';

  @override
  String get wizardNext => 'Напред';

  @override
  String wizardStepLabel(int step, int total, String title) {
    return 'Стъпка $step от $total · $title';
  }

  @override
  String get wizardErrRequired => 'Това поле е задължително';

  @override
  String wizardErrTooShort(int count) {
    return 'Твърде кратко (минимум $count символа)';
  }

  @override
  String get wizardErrOnlyLetters =>
      'Само букви, интервали, тирета и апострофи';

  @override
  String get wizardErrSaveFailed =>
      'Не може да се запази. Провери връзката и опитай отново.';

  @override
  String get wizardStufe1aTitle => 'Самоличност';

  @override
  String get wizardStufe1aPrompt =>
      'Нека се запознаем официално. Моля, напиши името си точно както е в Personalausweis, Reisepass или Aufenthaltstitel — за да съвпада с документите ти.';

  @override
  String get wizardStufe1aVornameLabel => 'Vornamen (имена)';

  @override
  String get wizardStufe1aVornameHelper =>
      'Всички ти имена, точно както в документа. Със интервал или тире (напр. Hans-Peter, Maria Anna).';

  @override
  String get wizardStufe1aNachnameLabel => 'Familienname (фамилия)';

  @override
  String get wizardStufe1aNachnameHelper => 'Сегашната ти фамилия.';

  @override
  String get wizardStufe1aGeburtsnameLabel =>
      'Geburtsname (рождена фамилия) — по избор';

  @override
  String get wizardStufe1aGeburtsnameHelper =>
      'Само ако се различава от Familienname — напр. преди брака.';

  @override
  String get wizardStufe1bTitle => 'Рожден ден';

  @override
  String get wizardStufe1bPrompt =>
      'Бихме искали да празнуваме рождения ти ден заедно! 🎂 Помага ни и да знаем, че си поне на 16 — така пише в нашия устав.';

  @override
  String get wizardStufe1bGeburtsdatumLabel => 'Дата на раждане';

  @override
  String get wizardStufe1bGeburtsdatumHelper => 'Натисни, за да избереш дата';

  @override
  String get wizardStufe1bGeburtsortLabel => 'Място на раждане';

  @override
  String get wizardStufe1bGeburtsortHelper =>
      'Град / населено място, където си роден.';

  @override
  String get wizardAgeGatePrompt => 'Съжалявам… 😔';

  @override
  String wizardAgeGateBody1(int age, int years) {
    return 'Уставът ни казва, че трябва да си поне на 16, за да станеш член. Ти си на $age — надявам се да те видя след $years години! 🌱';
  }

  @override
  String get wizardAgeGateBody2 =>
      'Ако искаш да помагаш като доброволец понякога (всякаква възраст, със съгласието на родителите), обади се — обичаме да подкрепяме млади, които искат да променят света.';

  @override
  String get wizardAgeGateBackHome => 'Обратно към началото';

  @override
  String get wizardErrInvalidPhone => 'Невалиден телефонен номер';

  @override
  String get wizardStufe1b1Title => 'Съгласие на родител';

  @override
  String get wizardStufe1b1Prompt =>
      'Непълнолетен си (16-17) — съгласно §106 BGB ни е нужно съгласието на родител или законен представител. Кажи ми името и телефонния номер. Vorsitzer ще се обади и ще уговори среща (лично или видео разговор). Без имейл — искаме да сме сигурни, че говорим с истинския човек.';

  @override
  String get wizardStufe1b1VornameLabel => 'Име на родителя';

  @override
  String get wizardStufe1b1VornameHelper =>
      'Както е в Personalausweis на родителя.';

  @override
  String get wizardStufe1b1NachnameLabel => 'Фамилия на родителя';

  @override
  String get wizardStufe1b1NachnameHelper =>
      'Както е в Personalausweis на родителя.';

  @override
  String get wizardStufe1b1TelefonLabel => 'Мобилен телефон на родителя';

  @override
  String get wizardStufe1b1TelefonHelper =>
      'На този номер ще се обади Vorsitzer.';

  @override
  String get wizardStufe1b1RelationLabel => 'Отношение към детето:';

  @override
  String get wizardStufe1b1RelationMutter => 'Майка';

  @override
  String get wizardStufe1b1RelationVater => 'Баща';

  @override
  String get wizardStufe1b1RelationSorgeberechtigter => 'Законен настойник';

  @override
  String get wizardStufe1b1RelationAndere => 'Друг настойник';

  @override
  String get wizardStufe1cTitle => 'Лични данни';

  @override
  String get wizardStufe1cPrompt =>
      'Само за да те опозная малко по-добре. Тази информация остава между нас и не се показва никъде публично.';

  @override
  String get wizardStufe1cGeschlechtLabel => 'Пол';

  @override
  String get wizardStufe1cGeschlechtMaennlich => 'Мъж';

  @override
  String get wizardStufe1cGeschlechtWeiblich => 'Жена';

  @override
  String get wizardStufe1cGeschlechtDivers => 'Друго';

  @override
  String get wizardStufe1cGeschlechtKeineAngabe => 'Предпочитам да не казвам';

  @override
  String get wizardStufe1cFamilienstandLabel => 'Семейно положение';

  @override
  String get wizardStufe1cFamilienstandLedig => 'Несемеен/Несемейна';

  @override
  String get wizardStufe1cFamilienstandVerheiratet => 'Семеен/Семейна';

  @override
  String get wizardStufe1cFamilienstandGeschieden => 'Разведен/Разведена';

  @override
  String get wizardStufe1cFamilienstandVerwitwet => 'Вдовец/Вдовица';

  @override
  String get wizardStufe1dTitle => 'Произход';

  @override
  String get wizardStufe1dPrompt =>
      'Това ни помага да ти предложим правилната подкрепа — например консултация за Aufenthalt или намиране на езиковата ти общност.';

  @override
  String get wizardStufe1dStaatLabel => 'Гражданство';

  @override
  String get wizardStufe1dStaatHelper =>
      'Напр. deutsch, rumänisch, ukrainisch. Няколко, разделени със запетая.';

  @override
  String get wizardStufe1dAufenthaltLabel =>
      'Статут на пребиваване (Aufenthaltsstatus) — по избор';

  @override
  String get wizardStufe1dAufenthaltHelper =>
      'Избери титлата от твоята Aufenthaltskarte / решение. Vorstand-ът я сверява с документите ти.';

  @override
  String get wizardStufe1dAufenthaltAwaitingCitizenship =>
      'Първо попълни гражданството по-горе — ще покажем само подходящите опции.';

  @override
  String get wizardStufe1dAufenthaltGerman =>
      'Не е необходима Aufenthaltstitel — германски гражданин.';

  @override
  String get wizardStufe1dAufenthaltEuEea =>
      'Гражданин на ЕС/ЕИП/Швейцария — свобода на движение (Freizügigkeit).';

  @override
  String get wizardStufe1dAufenthaltTempHint => 'временно';

  @override
  String get wizardStufe1dAufenthaltPermHint => 'постоянно пребиваване';

  @override
  String get wizardStufe1dAufenthaltAsylumProcessHint => 'процедура по убежище';

  @override
  String get wizardStufe1dAufenthaltOther => 'Друго (моля уточни в чата)';

  @override
  String get wizardStufe1dAufenthaltRequired => 'Моля избери Aufenthaltstitel.';

  @override
  String get wizardStufe1dMutterspracheLabel => 'Майчин език';

  @override
  String get wizardStufe1dMutterspracheHelper =>
      'Предварително попълнено с езика на приложението — промени ако е различен.';

  @override
  String get wizardStufe1eTitle => 'Адрес';

  @override
  String get wizardStufe1ePrompt =>
      'Твоят пощенски адрес — използваме го за официални документи (устав, договори за членство, известия).';

  @override
  String get wizardStufe1eStrasseLabel => 'Улица';

  @override
  String get wizardStufe1eStrasseHelper =>
      'Само името на улицата — номерът в съседното поле.';

  @override
  String get wizardStufe1eHausnummerLabel => '№';

  @override
  String get wizardStufe1ePlzLabel => 'PLZ (пощ. код)';

  @override
  String get wizardStufe1eOrtLabel => 'Град';

  @override
  String get wizardStufe1eLandLabel => 'Държава';

  @override
  String get wizardStufe1eLandHelper => 'Предварително попълнено: Deutschland.';

  @override
  String get wizardErrInvalidStreet => 'Невалидно име на улица';

  @override
  String get wizardErrInvalidHausnummer =>
      'Невалиден номер (напр. 12, 12a, 12/3)';

  @override
  String get wizardErrInvalidPlz => 'Невалиден пощенски код (само цифри)';

  @override
  String get wizardStufe1fTitle => 'Контакт';

  @override
  String get wizardStufe1fPrompt =>
      'Как да се свържем с теб? Телефонът е само за спешни случаи — всичко останало минава през нашия собствен криптиран от край до край канал в приложението. Имейлът ти на член се присвоява автоматично и се показва по-долу.';

  @override
  String get wizardStufe1fTelefonLabel => 'Мобилен телефон';

  @override
  String get wizardStufe1fTelefonHelper =>
      'Обещавам, ще се обадя само ако е важно. 📱';

  @override
  String get wizardStufe2Title => 'Тип членство';

  @override
  String get wizardStufe2Prompt =>
      'Какъв член искаш да бъдеш? Нека ти обясня всяка опция.';

  @override
  String get wizardStufe2OrdentlichTitle => 'Редовен член (ordentlich)';

  @override
  String get wizardStufe2OrdentlichBody =>
      'Пълни права. Плащаш месечен членски внос, гласуваш в Mitgliederversammlung, можеш да бъдеш избран в Vorstand. Стандартен избор.';

  @override
  String get wizardStufe2FoerderTitle => 'Подкрепящ член (Fördermitglied)';

  @override
  String get wizardStufe2FoerderBody =>
      'Подкрепяш сдружението финансово, но не участваш активно в решенията. Без право на глас. Добре ако искаш да помагаш отдалечено.';

  @override
  String get wizardStufe2EhrenTitle => 'Почетен член (Ehrenmitglied)';

  @override
  String get wizardStufe2EhrenBody =>
      'Присъжда се от Vorstand за специални заслуги. Не го избираш сам — получаваш го като признание. Избери само ако вече си отличен.';

  @override
  String get wizardStufe3Title => 'Финансово положение';

  @override
  String get wizardStufe3Prompt =>
      'Сега за финансовото ти положение. Не за да те съдя — а за да те освободим от вноска ако получаваш социални помощи.';

  @override
  String get wizardStufe3OptionBuergergeld => 'Получавам Bürgergeld';

  @override
  String get wizardStufe3OptionSozialamt => 'Получавам помощи от Sozialamt';

  @override
  String get wizardStufe3OptionNein => 'Не получавам нито едно от тези';

  @override
  String get wizardStufe3FeeExemptTitle => 'Членски внос: 0 € / месец 🎉';

  @override
  String get wizardStufe3FeeExemptBody =>
      'С Bürgergeld, Sozialamt, ALG I или Krankengeld си напълно освободен от членски внос съгласно Satzung §6. Нужно ни е само доказателство (Leistungsbescheid или удостоверение от службата / здравната каса).';

  @override
  String get wizardStufe3UploadTitle => 'Качи Leistungsbescheid';

  @override
  String get wizardStufe3UploadHint => 'PDF / JPG / PNG, макс. 10 MB.';

  @override
  String get wizardStufe3UploadRequired =>
      'Моля, качи Leistungsbescheid преди да продължиш.';

  @override
  String get wizardStufe3FileTooLarge =>
      'Файлът е твърде голям. Максимум 10 MB.';

  @override
  String get wizardStufe3UploadFailed =>
      'Файлът не може да бъде качен. Опитай отново.';

  @override
  String get wizardStufe3RegularFeeTitle => 'Членски внос: 25 € / месец';

  @override
  String get wizardStufe3RegularFeeBody =>
      'Стандартен членски внос за редовни членове съгласно устава.';

  @override
  String get wizardStufe4Title => 'Плащане';

  @override
  String get wizardStufe4Prompt =>
      'Как искаш да плащаш членския внос? И в кой ден от месеца предпочиташ да се удържа?';

  @override
  String get wizardStufe4MethodUeberweisungTitle =>
      'Банков превод (Überweisung)';

  @override
  String get wizardStufe4MethodUeberweisungBody =>
      'Ти инициираш плащането ръчно всеки месец от твоята сметка.';

  @override
  String get wizardStufe4MethodSepaTitle => 'SEPA-Lastschrift (директен дебит)';

  @override
  String get wizardStufe4MethodSepaBody =>
      'Ние удържаме сумата автоматично от сметката ти. Най-удобно, но ни трябва IBAN и подписан мандат.';

  @override
  String get wizardStufe4MethodDauerauftragTitle =>
      'Dauerauftrag (постоянно нареждане)';

  @override
  String get wizardStufe4MethodDauerauftragBody =>
      'Ти настройваш постоянно нареждане в банката си. Банката автоматично превежда сумата всеки месец.';

  @override
  String get wizardStufe4DayLabel => 'Ден на плащане';

  @override
  String get wizardStufe4DayHint => 'Избери ден между 1 и 31';

  @override
  String wizardStufe4DayItem(int day) {
    return 'Ден $day';
  }

  @override
  String wizardStufe4DayReminder(int day) {
    return 'Членският внос ще се удържа на $day-то число всеки месец.';
  }

  @override
  String get wizardStufe5Title => 'Начална дата';

  @override
  String get wizardStufe5Prompt =>
      'Кога искаш да станеш официално член на ICD360S? От одобрението или с обратна сила.';

  @override
  String get wizardStufe5OptionAbVerifizierungTitle =>
      'От одобрението на Vorstand';

  @override
  String get wizardStufe5OptionAbVerifizierungBody =>
      'Най-простият избор. Без членски внос с обратна сила.';

  @override
  String get wizardStufe5OptionGruendungsdatumTitle =>
      'С обратна сила от 01.08.2025 (учредяване)';

  @override
  String get wizardStufe5OptionGruendungsdatumBody =>
      'Ще се считаш за член още от първия ден на сдружението.';

  @override
  String get wizardStufe5OptionAnderesDatumTitle => 'Друга дата';

  @override
  String get wizardStufe5OptionAnderesDatumBody =>
      'Сам избираш дата между 01.08.2025 и днес.';

  @override
  String get wizardStufe5PickDate => 'Натисни, за да избереш дата';

  @override
  String get wizardStufe5PickDateFirst => 'Моля, първо избери дата.';

  @override
  String get wizardStufe5DatePickerHelp => 'Начало на членството';

  @override
  String wizardStufe5DateRange(String start) {
    return 'Между $start и днес';
  }

  @override
  String get wizardStufe5RetroactiveTitle => 'Членски внос с обратна сила';

  @override
  String wizardStufe5RetroactiveBody(
      String start, String end, int months, String amount) {
    return 'От $start до $end са $months месеца. По 25 €/месец това прави $amount € за изплащане с обратна сила, плюс текущия месечен внос.';
  }

  @override
  String get wizardStufe5FeeExemptTitle =>
      'Членски внос с обратна сила: 0 € 🎉';

  @override
  String get wizardStufe5FeeExemptBody =>
      'С Bürgergeld или Sozialamt си напълно освободен — дори с обратна сила не дължиш нищо.';

  @override
  String wizardDocumentPrompt(String doc) {
    return 'Преди да приключим, моля прочети внимателно $doc. Важно е да знаеш какво подписваш.';
  }

  @override
  String get wizardDocumentScrollHint => 'Превърти до края, за да продължиш.';

  @override
  String get wizardDocumentScrolledOk => 'Прочете до края ✓';

  @override
  String wizardDocumentOpenButton(String doc) {
    return 'Отвори $doc в браузър';
  }

  @override
  String get wizardDocumentExternalHint =>
      'На тази платформа отваряме документа във браузъра ти по подразбиране.';

  @override
  String get wizardDocumentOpenedOk =>
      'Документът беше отворен. Моля, прочети го внимателно.';

  @override
  String wizardDocumentConfirm(String doc) {
    return 'Потвърждавам, че прочетох и съм съгласен с $doc.';
  }

  @override
  String get wizardFinalAdultTitle => 'Готово! Записан си 🎉';

  @override
  String get wizardFinalMinorTitle => 'Заявката ти е изпратена 📨';

  @override
  String get wizardFinalMinorBody =>
      'Ще се свържем с родителя ти и ще уговорим среща (лично или видео разговор). Моля, имай търпение — процедурата може да отнеме до 7 дни. Ще получиш известие в приложението, щом родителят ти одобри.';

  @override
  String get wizardFinalMitgliedernummerLabel => 'Твоят членски номер';

  @override
  String get wizardStufe4MethodComingSoon => 'Скоро';

  @override
  String get wizardStufe4StreichungWarning =>
      'Ако изостанеш с членския внос повече от 6 месеца, ще те отпишем автоматично (Satzung §6 Abs. 3).';

  @override
  String get wizardStufe5KuendigungInfo =>
      'За напускане: изпрати ни писмено предизвестие 3 месеца преди 31 декември (до 30 септември за да влезе в сила в края на годината). Няма минимален срок (Satzung §6 Abs. 3).';

  @override
  String get wizardStufe1fEmailLabel => 'Твоят имейл на член';

  @override
  String get wizardStufe1fEmailHelper =>
      'Присвоява се автоматично от членския ти номер. Активира се в момента, в който управителният съвет (Vorstand) одобри заявлението ти. Имаме собствено приложение за имейл — изпращай и получавай криптирани имейли, просто и безплатно.';

  @override
  String get wizardErrInvalidEmail => 'Невалиден имейл адрес';

  @override
  String get wizardStufe3OptionAlg1 =>
      'Получавам Arbeitslosengeld I (ALG I, обезщетение за безработица)';

  @override
  String get wizardStufe3OptionKrankengeld =>
      'Получавам Krankengeld (обезщетение за продължителна болест)';

  @override
  String get wizardStufe3UploadAddMore => 'Добави друг документ';

  @override
  String get wizardStufe3UploadLimitCount =>
      'Достигнат лимит: до 20 документа.';

  @override
  String get wizardStufe3UploadLimitTotal =>
      'Достигнат общ лимит 100 МБ. Изтрий съществуващ файл.';

  @override
  String get wizardStufe3UploadDeleteTooltip => 'Изтрий';

  @override
  String wizardStufe3UploadCounter(int count, int max) {
    return '$count / $max документа';
  }

  @override
  String get wizardDocumentExternalOpenFailed =>
      'Не успях да отворя браузъра. Линкът е копиран в клипборда — постави го в браузър, за да продължиш.';

  @override
  String get wizardFinalTimelineProcessing =>
      'Vorstand преглежда · обикновено 1 работен ден, до 7';

  @override
  String get wizardFinalTimelineActivated => 'Профилът е активиран';

  @override
  String get wizardFinalAdultThank =>
      'Благодарим, че попълни регистрационната форма! 🎉';

  @override
  String get wizardFinalAdultUsual =>
      'Заявката ти е при нас. Обикновено я валидираме в рамките на един работен ден.';

  @override
  String get wizardFinalAdultExceptional =>
      'Понякога може да отнеме до 7 работни дни. А ако нещо не съвпада, ще те върнем към формата, за да го коригираш 🙂';

  @override
  String get wizardFinalStatusTitle => 'СТАТУС НА ЗАЯВКАТА';

  @override
  String wizardFinalStatusStepsValidated(int reviewed, int total) {
    return '$reviewed/$total стъпки, проверени от Vorstand';
  }

  @override
  String get wizardFinalStufeSheetTitle => 'Детайли на заявката';

  @override
  String get wizardFinalStufeSheetHint =>
      '8-те етапа, които си попълнил. Vorstand ги преглежда един по един — виждаш в реално време какво е валидирано.';

  @override
  String get wizardFinalStufeStatusPending => 'Очаква преглед';

  @override
  String get wizardFinalStufeStatusApproved => 'Одобрено';

  @override
  String get wizardFinalStufeStatusRejected => 'Отхвърлено';

  @override
  String wizardFinalStatusRejectionCount(int count) {
    return '$count стъпка изисква корекция';
  }

  @override
  String get wizardFinalStufeRejectionReason => 'Причина от Vorstand:';

  @override
  String get wizardFinalStufeCorrectNow => 'Коригирай сега';

  @override
  String wizardFinalApprovalsHeader(int current, int total) {
    return 'Одобрения от Vorstand ($current/$total)';
  }

  @override
  String get wizardFinalApprovalAwaiting => 'Чакаме 2-ри Vorstand';

  @override
  String get wizardFinalApprovalRejected => 'ОТХВЪРЛЕНО';

  @override
  String get wizardFinalStufeNoDataYet => 'Данните още не са налични.';

  @override
  String get wizardFinalStufeReadAt => 'Прочетено на:';

  @override
  String get wizardFinalStufeBeitragsfrei =>
      'Освободен от вноска (без плащане)';

  @override
  String get wizardFinalStufeNotExempt => 'Без социални помощи';

  @override
  String get wizardFinalStufeBeginAtVerification => 'Започва при верификация';

  @override
  String get wizardFinalStufeBeginAtFoundation =>
      'Дата на основаване (със задна дата)';

  @override
  String get wizardFinalStufeBeginAtCustom => 'Друга дата';

  @override
  String get wizardFinalStufeStatusSkipped => 'Пропуснато';

  @override
  String get wizardFinalStufeFilledAt => 'Попълнено:';

  @override
  String get wizardFinalStufeReviewedAt => 'Прегледано:';

  @override
  String get wizardFinalWithdrawLink => 'Оттегли заявката';

  @override
  String get wizardFinalWithdrawDialogTitle => 'Да оттеглим заявката?';

  @override
  String get wizardFinalWithdrawDialogBody =>
      'Заявката ще бъде маркирана като оттеглена от теб. Данните остават в базата за одит (GDPR), но профилът няма да бъде активиран. Винаги можеш да започнеш регистрацията отново с нов членски номер.';

  @override
  String get wizardFinalWithdrawKeep => 'Не, ще изчакам';

  @override
  String get wizardFinalWithdrawConfirm => 'Да, оттегли';

  @override
  String get wizardErrTooManyWithdrawals =>
      'Заявката ти не може да бъде обработена автоматично. Обади ни се или ела лично при Vorstand, за да продължиш регистрацията.';

  @override
  String get wizardDuplicateLoginTitle => 'Изглежда вече си наш член';

  @override
  String get wizardDuplicateLoginBody =>
      'С твоето име и дата на раждане вече намираме активен профил. Моля, използвай \"Аз съм вече член\" на началния екран, за да влезеш. Ако нямаш достъп, обади ни се.';

  @override
  String get wizardDuplicatePendingTitle => 'Заявката ти вече е при нас';

  @override
  String get wizardDuplicatePendingBody =>
      'С твоето име и дата на раждане вече имаме заявка в процес на разглеждане. Vorstand работи по нея — ще те уведомим в приложението веднага щом профилът ти стане активен. Обади се, ако искаш да обсъдим.';

  @override
  String get wizardDuplicateRecentlyWithdrawnTitle =>
      'Не можем да обработим заявката сега';

  @override
  String get wizardDuplicateRecentlyWithdrawnBody =>
      'Името и датата ти на раждане съвпадат с наскоро оттеглена заявка. Моля, обади ни се, за да говориш с Vorstand, преди да продължиш.';

  @override
  String get wizardDuplicatePreviouslyWithdrawnTitle =>
      'Подавал си заявка преди';

  @override
  String get wizardDuplicatePreviouslyWithdrawnBody =>
      'Името и датата ти на раждане съвпадат със стара заявка, която си оттеглил. Добре дошъл обратно — обади ни се преди да продължиш, за да реши Vorstand как ще процедираме.';

  @override
  String get wizardDuplicateCallUsTitle => 'Моля, обади ни се';

  @override
  String get wizardDuplicateCallUsBody =>
      'Името и датата ти на раждане вече фигурират при нас, но не можем да споделим подробности през приложението. Обади ни се — Vorstand ще ти обясни директно.';

  @override
  String get wizardChatHelp => 'Да поговорим';

  @override
  String get wizardChatHelpSubtitle => 'Чат на живо с Vorstand · бърз отговор';

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
