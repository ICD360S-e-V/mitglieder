// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get welcomeLoading => 'Загрузка...';

  @override
  String get welcomeAutoLogin => 'Автоматический вход...';

  @override
  String get login => 'Войти';

  @override
  String get register => 'Регистрация';

  @override
  String get becomeMember => 'Стать участником';

  @override
  String get memberNumber => 'Номер участника';

  @override
  String get memberNumberHint => 'Введите номер участника';

  @override
  String get confirmPassword => 'Подтвердите пароль';

  @override
  String get confirmPasswordHint => 'Подтвердите пароль';

  @override
  String get newPassword => 'Новый пароль';

  @override
  String get newPasswordHint => 'Введите новый пароль';

  @override
  String get firstName => 'Имя и фамилия';

  @override
  String get firstNameHint => 'Введите имя и фамилию';

  @override
  String get nameMinLength => 'Имя должно содержать минимум 2 символа';

  @override
  String get nameOnlyLetters => 'Разрешены только буквы и дефис';

  @override
  String get email => 'Электронная почта';

  @override
  String get emailHint => 'Введите email';

  @override
  String get emailInvalid => 'Введите корректный email';

  @override
  String get passwordMinLength => 'Пароль должен содержать минимум 6 символов';

  @override
  String get passwordsNotMatch => 'Пароли не совпадают';

  @override
  String get registrationFailed => 'Ошибка регистрации';

  @override
  String connectionError(String error) {
    return 'Ошибка соединения: $error';
  }

  @override
  String registrationSuccess(String memberNumber) {
    return 'Регистрация успешна!\n\nВаш номер участника: $memberNumber\n\nЗапомните этот номер для входа.';
  }

  @override
  String get unknown => 'Неизвестно';

  @override
  String error(String error) {
    return 'Ошибка: $error';
  }

  @override
  String get cancel => 'Отмена';

  @override
  String get resetPassword => 'Сбросить пароль';

  @override
  String get imprint => 'Импрессум';

  @override
  String get privacy => 'Политика конфиденциальности';

  @override
  String get statutes => 'Устав';

  @override
  String get revocation => 'Право отзыва';

  @override
  String get appointments => 'Встречи';

  @override
  String get tickets => 'Заявки';

  @override
  String get liveChat => 'Чат';

  @override
  String get notifications => 'Уведомления';

  @override
  String get myProfile => 'Мой профиль';

  @override
  String get logout => 'Выйти';

  @override
  String get goodMorning => 'Доброе утро';

  @override
  String get goodDay => 'Добрый день';

  @override
  String get goodEvening => 'Добрый вечер';

  @override
  String get goodNight => 'Спокойной ночи';

  @override
  String get welcomeToICD => 'Добро пожаловать в ICD360S e.V!';

  @override
  String get accountCreatedSuccessfully =>
      'Ваша учетная запись успешно создана.';

  @override
  String get today => 'Сегодня';

  @override
  String get membershipFeeDue => 'Членский взнос подлежит оплате';

  @override
  String get pleaseTransferAnnualFee => 'Пожалуйста, переведите годовой взнос.';

  @override
  String get newBadge => 'Новый';

  @override
  String get close => 'Закрыть';

  @override
  String get myAppointments => 'Мои встречи';

  @override
  String get priority => 'Приоритет';

  @override
  String get messageLabel => 'Сообщение';

  @override
  String get reportProblems => 'Сообщить о проблемах';

  @override
  String get weRespondIn24Hours => 'Мы ответим вам в течение 24 часов!';

  @override
  String get everythingOk => 'Все в порядке!';

  @override
  String get haveProblemWeHelp => 'Есть проблема?\nМы позаботимся об этом!';

  @override
  String get myMembership => 'Мое членство';

  @override
  String get managePersonalDataAndFee =>
      'Управление личными данными и членским взносом';

  @override
  String get myAppointmentsTitle => 'Мои встречи';

  @override
  String get appointmentsDescription =>
      'Здесь вы можете увидеть свои предстоящие встречи.\nВы можете подтвердить свое участие или отклонить.';

  @override
  String get loadAppointments => 'Загрузить встречи';

  @override
  String get myTickets => 'Мои заявки';

  @override
  String get low => 'Низкий';

  @override
  String get high => 'Высокий';

  @override
  String get submit => 'Отправить';

  @override
  String get errorCreatingTicket => 'Ошибка создания заявки';

  @override
  String get verified => 'Проверено';

  @override
  String get account => 'Аккаунт';

  @override
  String get myDevices => 'Мои устройства';

  @override
  String get changeEmail => 'Изменить email';

  @override
  String get changePassword => 'Изменить пароль';

  @override
  String get saveEmail => 'Сохранить email';

  @override
  String get savePassword => 'Сохранить пароль';

  @override
  String get deviceLoggedOut => 'Устройство отключено';

  @override
  String get emailChangedSuccessfully => 'Email успешно изменен';

  @override
  String get errorChangingPassword => 'Ошибка изменения пароля';

  @override
  String get errorChangingEmail => 'Ошибка изменения email';

  @override
  String get validEmailRequired =>
      'Пожалуйста, введите действительный адрес email';

  @override
  String get confirmLogoutDevice => 'Выйти с устройства?';

  @override
  String get confirmLogoutMessage =>
      'Вы хотите выйти с этого устройства?\n\nВам нужно будет войти снова, чтобы использовать это устройство.';

  @override
  String get ipAddress => 'IP';

  @override
  String get platform => 'Платформа';

  @override
  String trialWarningUrgentTitle(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days дней',
      few: '$days дня',
      one: '1 день',
    );
    return 'Внимание: Осталось $_temp0 до блокировки аккаунта!';
  }

  @override
  String get trialWarningTitle => 'Ваш аккаунт еще не верифицирован';

  @override
  String get trialWarningDescription =>
      'Пожалуйста, заполните данные в \"Мой профиль\". Через 30 дней аккаунт будет автоматически заблокирован.';

  @override
  String trialDaysRemaining(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days дней',
      few: '$days дня',
      one: '1 день',
    );
    return '$_temp0';
  }

  @override
  String get overview => 'Обзор';

  @override
  String get member => 'Член';

  @override
  String get memberManagement => 'Управление членами';

  @override
  String get reportProblemTooltip => 'Сообщить о проблеме';

  @override
  String get newAppointmentsTitle => 'Новые встречи';

  @override
  String get youHaveNewAppointment => 'У вас новая встреча.';

  @override
  String youHaveNewAppointments(int count) {
    return 'У вас $count новых встреч.';
  }

  @override
  String get appointmentReminderTomorrow => 'Напоминание: Встреча завтра';

  @override
  String tomorrowAppointment(String title) {
    return 'Завтра: $title';
  }

  @override
  String youHaveTomorrowAppointments(int count) {
    return 'У вас $count встреч завтра.';
  }

  @override
  String get appointmentsToday => 'Встречи сегодня';

  @override
  String todayAppointment(String title) {
    return 'Сегодня: $title';
  }

  @override
  String youHaveTodayAppointments(int count) {
    return 'У вас $count встреч сегодня.';
  }

  @override
  String get paymentReminder => 'Напоминание об оплате';

  @override
  String paymentReminderMessage(int day, String method) {
    return 'Сегодня $day-е число месяца – пожалуйста, завершите $method.';
  }

  @override
  String get paymentDayLabel => 'День оплаты (ежемесячное напоминание)';

  @override
  String get updateAvailable => 'Доступно обновление';

  @override
  String newVersionAvailable(String version) {
    return 'Доступна новая версия: $version';
  }

  @override
  String currentVersionLabel(String version) {
    return 'Текущая версия: $version';
  }

  @override
  String get changes => 'Изменения:';

  @override
  String downloadProgress(String percent) {
    return 'Загрузка: $percent%';
  }

  @override
  String get installationStarting => 'Начинается установка...';

  @override
  String get appWillRestart => 'Приложение будет перезапущено автоматически.';

  @override
  String get autoUpdateEnableTitle =>
      'Автоматически устанавливать будущие обновления';

  @override
  String get autoUpdateEnableHint =>
      'Приложение само загрузит и установит обновления и ненадолго перезапустится. Без дополнительных вопросов.';

  @override
  String autoUpdateInstalling(String version) {
    return 'Версия $version устанавливается в фоновом режиме. Приложение скоро перезапустится.';
  }

  @override
  String get later => 'Позже';

  @override
  String get updateNow => 'Обновить сейчас';

  @override
  String get downloading => 'Загрузка...';

  @override
  String get downloadFailed => 'Не удалось загрузить. Попробуйте позже.';

  @override
  String get searchingForUpdates => 'Поиск обновлений...';

  @override
  String get appUpToDate => 'Приложение обновлено';

  @override
  String get updateCheckError => 'Ошибка проверки обновлений';

  @override
  String get changelog => 'Журнал изменений';

  @override
  String get terminConfirmed => 'Встреча подтверждена';

  @override
  String get terminDeclined => 'Встреча отклонена';

  @override
  String get terminRescheduleRequested => 'Запрошен перенос';

  @override
  String get statusConfirmed => 'Подтверждено';

  @override
  String get statusDeclined => 'Отклонено';

  @override
  String get statusRescheduling => 'Перенос';

  @override
  String get statusPending => 'Ожидание';

  @override
  String get categoryVorstandssitzung => 'Заседание правления';

  @override
  String get categoryMitgliederversammlung => 'Общее собрание';

  @override
  String get categorySchulung => 'Обучение';

  @override
  String get categorySonstiges => 'Прочее';

  @override
  String openCount(int count) {
    return '$count открытых';
  }

  @override
  String get refresh => 'Обновить';

  @override
  String get filterUpcoming => 'Предстоящие';

  @override
  String get filterPast => 'Прошедшие';

  @override
  String get filterAll => 'Все';

  @override
  String get noUpcomingAppointments => 'Нет предстоящих встреч';

  @override
  String get noPastAppointments => 'Нет прошедших встреч';

  @override
  String get noAppointmentsAvailable => 'Встречи отсутствуют';

  @override
  String get appointmentsShownHere => 'Ваши встречи будут показаны здесь';

  @override
  String get dateLabel => 'Дата';

  @override
  String get timeLabel => 'Время';

  @override
  String get locationLabel => 'Место';

  @override
  String get createdByLabel => 'Создал';

  @override
  String get descriptionLabel => 'Описание';

  @override
  String get ticketLabel => 'Заявка';

  @override
  String get yourStatus => 'Ваш статус: ';

  @override
  String reasonLabel(String reason) {
    return 'Причина: $reason';
  }

  @override
  String durationMinutes(int minutes) {
    return '$minutes мин';
  }

  @override
  String get confirm => 'Подтвердить';

  @override
  String get decline => 'Отклонить';

  @override
  String get reschedule => 'Перенести';

  @override
  String get requestReschedule => 'Запросить перенос';

  @override
  String appointmentLabel(String title) {
    return 'Встреча: $title';
  }

  @override
  String get rescheduleReason => 'Причина переноса *';

  @override
  String get rescheduleReasonHint => 'Укажите причину...';

  @override
  String get pleaseProvideReason => 'Укажите причину';

  @override
  String get request => 'Запросить';

  @override
  String get ticketStatusOpen => 'Открыта';

  @override
  String get ticketStatusInProgress => 'В работе';

  @override
  String get ticketStatusWaitingMember => 'Ожидание участника';

  @override
  String get ticketStatusWaitingStaff => 'Ожидание сотрудника';

  @override
  String get ticketStatusWaitingAuthority => 'Ожидание ведомства';

  @override
  String get ticketStatusDone => 'Завершена';

  @override
  String get ticketPriorityHigh => 'Высокий';

  @override
  String get ticketPriorityMedium => 'Средний';

  @override
  String get ticketPriorityLow => 'Низкий';

  @override
  String get comments => 'Комментарии';

  @override
  String get documents => 'Документы';

  @override
  String get details => 'Детали';

  @override
  String get replySent => 'Ответ отправлен';

  @override
  String get sendError => 'Ошибка отправки';

  @override
  String get uploading => 'Загрузка...';

  @override
  String fileUploaded(String filename) {
    return '$filename загружен';
  }

  @override
  String get uploadFailed => 'Ошибка загрузки';

  @override
  String get openError => 'Ошибка открытия';

  @override
  String get noRepliesYet => 'Пока нет ответов';

  @override
  String get waitingForSupport => 'Ожидание ответа поддержки';

  @override
  String get writeReply => 'Написать ответ...';

  @override
  String get attachFile => 'Прикрепить файл';

  @override
  String documentsCount(int count) {
    return 'Документы ($count)';
  }

  @override
  String get upload => 'Загрузить';

  @override
  String get noDocuments => 'Нет документов';

  @override
  String get allowedFormats => 'Допустимые форматы: PDF, JPEG, JPG, TXT, ZIP';

  @override
  String get yourMessage => 'Ваше сообщение:';

  @override
  String get translation => 'Перевод';

  @override
  String get original => 'Оригинал';

  @override
  String get originalText => 'Оригинальный текст';

  @override
  String get autoTranslated => 'Переведено автоматически';

  @override
  String get originalTapTranslation => 'Оригинал · Нажмите для перевода';

  @override
  String get translatedTapOriginal => 'Переведено · Нажмите для оригинала';

  @override
  String get justNow => 'Только что';

  @override
  String minutesAgo(int minutes) {
    return '$minutes мин назад';
  }

  @override
  String hoursAgo(int hours) {
    return '$hours ч назад';
  }

  @override
  String daysAgo(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'дней',
      one: 'день',
    );
    return '$days $_temp0 назад';
  }

  @override
  String get createdLabel => 'Создано';

  @override
  String get updatedLabel => 'Обновлено';

  @override
  String get handlerLabel => 'Ответственный';

  @override
  String get doneLabel => 'Завершено';

  @override
  String get newTicketTitle => 'Новая заявка';

  @override
  String get categoryOptional => 'Категория (необязательно)';

  @override
  String get selectCategory => 'Выбрать';

  @override
  String get subjectLabel => 'Тема';

  @override
  String get fillAllFields => 'Заполните все поля';

  @override
  String ticketCreatedId(int id) {
    return 'Заявка #$id создана';
  }

  @override
  String get priorityLabel => 'Приоритет: ';

  @override
  String get supportOffline => 'Поддержка офлайн';

  @override
  String get lastSeenSeconds => 'Был активен несколько секунд назад';

  @override
  String lastSeenMinutes(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: 'минут',
      one: 'минуту',
    );
    return 'Был активен $minutes $_temp0 назад';
  }

  @override
  String lastSeenHours(int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: 'часов',
      one: 'час',
    );
    return 'Был активен $hours $_temp0 назад';
  }

  @override
  String lastSeenDays(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'дней',
      one: 'день',
    );
    return 'Был активен $days $_temp0 назад';
  }

  @override
  String get online => 'Онлайн';

  @override
  String get callSupport => 'Позвонить';

  @override
  String get typeMessage => 'Введите сообщение...';

  @override
  String get callBusy => 'Поддержка занята';

  @override
  String get callRejected => 'Звонок отклонён';

  @override
  String get callFailed => 'Не удалось подключить звонок';

  @override
  String get callEnded => 'Звонок завершён';

  @override
  String get callSupportBusy => 'Поддержка уже в другом звонке';

  @override
  String get errorStartingChat => 'Ошибка запуска чата';

  @override
  String get errorStartingCall => 'Ошибка запуска звонка';

  @override
  String get errorConnecting => 'Ошибка подключения';

  @override
  String get errorDownloading => 'Ошибка загрузки';

  @override
  String get errorUploading => 'Ошибка отправки файла';

  @override
  String get errorSending => 'Ошибка отправки';

  @override
  String get errorPickingPhotos => 'Ошибка выбора фото';

  @override
  String get errorPickingFiles => 'Ошибка выбора файлов';

  @override
  String get errorTakingPhoto => 'Ошибка съёмки';

  @override
  String get fileNotLoaded => 'Файл не загружен';

  @override
  String get attachmentIdMissing => 'ID вложения отсутствует';

  @override
  String get camera => 'Камера';

  @override
  String get gallery => 'Галерея';

  @override
  String get file => 'Файл';

  @override
  String get notifNewMessageFrom => 'Новое сообщение от';

  @override
  String get notifUrgentPrefix => 'СРОЧНО';

  @override
  String get notifUrgentMessage => 'СРОЧНОЕ СООБЩЕНИЕ';

  @override
  String get notifIncomingCall => 'Входящий звонок';

  @override
  String get notifCallingYou => 'звонит...';

  @override
  String get notifUpdateAvailable => 'Доступно обновление';

  @override
  String get notifVersionAvailable => 'уже доступна';

  @override
  String get notifConnected => 'Подключено';

  @override
  String get notifDisconnected => 'Отключено';

  @override
  String get notifConnectedBody => 'Вы подключены к серверу.';

  @override
  String get notifDisconnectedBody => 'Соединение с сервером потеряно.';

  @override
  String get notifError => 'Ошибка';

  @override
  String get retry => 'Повторить';

  @override
  String get save => 'Сохранить';

  @override
  String get accept => 'Принять';

  @override
  String get selectFile => 'Выбрать файл';

  @override
  String get dataLoadingText => 'Загрузка данных...';

  @override
  String get dataSavedSuccess => 'Данные успешно сохранены';

  @override
  String get errorSaving => 'Ошибка сохранения';

  @override
  String get errorLoading => 'Ошибка загрузки';

  @override
  String savedFilename(String filename) {
    return 'Сохранено: $filename';
  }

  @override
  String get logsCopied => 'Логи скопированы!';

  @override
  String get passwordMinEightChars =>
      'Пароль должен содержать не менее 8 символов';

  @override
  String get passwordChangeSuccess => 'Пароль успешно изменён';

  @override
  String get emailChangeError => 'Ошибка изменения email';

  @override
  String get acceptDocumentCheckbox => 'Я прочитал и принимаю документ.';

  @override
  String loadingErrorGeneric(String details) {
    return 'Ошибка загрузки: $details';
  }

  @override
  String get incomingCallTitle => 'Входящий звонок';

  @override
  String ringingFor(int seconds) {
    return 'Звонит $secondsс';
  }

  @override
  String get rejectCall => 'Отклонить';

  @override
  String get acceptCall => 'Ответить';

  @override
  String get unmute => 'Включить звук';

  @override
  String get mute => 'Выключить звук';

  @override
  String get hangUp => 'Завершить';

  @override
  String get calling => 'Вызов...';

  @override
  String autoRejectIn(int seconds) {
    return 'Автоотклонение через $seconds секунд';
  }

  @override
  String get speakerOn => 'Динамик';

  @override
  String get speakerOff => 'Наушник';

  @override
  String get micMuted => 'Отключён';

  @override
  String get micOn => 'Микрофон';

  @override
  String get connectionExcellent => 'Отличное';

  @override
  String get connectionGood => 'Хорошее';

  @override
  String get connectionWeak => 'Слабое';

  @override
  String get connectionLost => 'Отключено';

  @override
  String get personalData => 'Личные данные';

  @override
  String get personalDataSubtitle => 'Имя, фамилия, адрес';

  @override
  String get membershipFee => 'Членский взнос';

  @override
  String annualFeeYear(String year) {
    return 'Годовой взнос $year';
  }

  @override
  String get amount => 'Сумма:';

  @override
  String get dueBy => 'Срок:';

  @override
  String get paid => 'Оплачено';

  @override
  String get versionHistory => 'История версий';

  @override
  String lastUpdated(String date) {
    return 'Последнее обновление: $date';
  }

  @override
  String get noVersionHistory => 'История версий недоступна';

  @override
  String get failedLoadChangelog => 'Не удалось загрузить журнал изменений';

  @override
  String get callMember => 'Позвонить участнику';

  @override
  String get closeConversation => 'Закрыть беседу';

  @override
  String get chatOffline => 'Не в сети';

  @override
  String get attachFiles => 'Прикрепить файлы (макс. 10, 50МБ)';

  @override
  String get conversationClosed => 'Эта беседа была закрыта';

  @override
  String get noMessages => 'Нет сообщений';

  @override
  String get goBack => 'Назад';

  @override
  String get goForward => 'Вперёд';

  @override
  String get homePage => 'Главная';

  @override
  String get firstNameLabel => 'Имя';

  @override
  String get lastNameLabel => 'Фамилия';

  @override
  String get streetLabel => 'Улица';

  @override
  String get houseNumberLabel => '№';

  @override
  String get postalCodeLabel => 'Индекс';

  @override
  String get cityLabel => 'Город';

  @override
  String get phoneMobileLabel => 'Телефон (Мобильный)';

  @override
  String get phoneLandlineLabel => 'Телефон (Стационарный)';

  @override
  String get newEmailLabel => 'Новый адрес электронной почты';

  @override
  String get currentPasswordLabel => 'Текущий пароль';

  @override
  String get newPasswordLabel => 'Новый пароль';

  @override
  String get confirmPasswordLabel => 'Подтвердите пароль';

  @override
  String get emailChangedSuccess => 'Email успешно изменён';

  @override
  String get reasonLabel2 => 'Причина';

  @override
  String get downloadFailed2 => 'Ошибка загрузки';

  @override
  String get downloadTooltip => 'Скачать';

  @override
  String get copyLogs => 'Копировать логи';

  @override
  String get deleteLogs => 'Удалить логи';

  @override
  String get autoScrollOn => 'Автопрокрутка ВКЛ';

  @override
  String get autoScrollOff => 'Автопрокрутка ВЫКЛ';

  @override
  String get unknownValue => 'Неизвестно';

  @override
  String get payment => 'Оплата';

  @override
  String get warningType_ermahnung => 'Предупреждение';

  @override
  String get warningType_abmahnung => 'Выговор';

  @override
  String get warningType_letzte => 'Последнее предупреждение';

  @override
  String warningsTotal(int count) {
    return 'Всего: $count';
  }

  @override
  String warningsErmahnung(int count) {
    return 'Предупреждения: $count';
  }

  @override
  String warningsAbmahnung(int count) {
    return 'Выговоры: $count';
  }

  @override
  String warningsLetzte(int count) {
    return 'Последние: $count';
  }

  @override
  String get noWarnings => 'Нет предупреждений';

  @override
  String get noWarningsDescription => 'У вас нет предупреждений.';

  @override
  String createdBy(String name) {
    return 'Создано: $name';
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
  String get stufe1_name => 'Личные данные';

  @override
  String get stufe2_name => 'Тип членства';

  @override
  String get stufe3_name => 'Финансовое положение';

  @override
  String get stufe4_name => 'Способ оплаты';

  @override
  String get stufe5_name => 'Начало членства';

  @override
  String get stufe6_name => 'Устав';

  @override
  String get stufe7_name => 'Политика конфиденциальности';

  @override
  String get stufe8_name => 'Право на отзыв';

  @override
  String get memberType_ordentlich => 'Обычный член';

  @override
  String get memberType_foerder => 'Член-спонсор';

  @override
  String get memberType_ehren => 'Почётный член';

  @override
  String get memberDesc_ordentlich =>
      'Активный член с правом голоса. Участвует в услугах ассоциации (почта, облако, бюрократическая поддержка).';

  @override
  String get memberDesc_foerder =>
      'Поддерживает ассоциацию взносами. Может присутствовать на общем собрании с совещательным голосом, без права голоса или избрания в правление.';

  @override
  String get memberDesc_ehren =>
      'Имеет права обычного члена без обязанности уплаты членских взносов. Назначается общим собранием или правлением.';

  @override
  String get payMethod_ueberweisung => 'Банковский перевод';

  @override
  String get payMethod_dauerauftrag => 'Постоянное поручение';

  @override
  String get verifyStatus_geprueft => 'Проверено';

  @override
  String get verifyStatus_ausgefuellt => 'Заполнено';

  @override
  String get verifyStatus_abgelehnt => 'Отклонено';

  @override
  String get verifyStatus_offen => 'Открыто';

  @override
  String get fillRequiredFields => 'Заполните все обязательные поля.';

  @override
  String get personalDataSaved => 'Личные данные сохранены';

  @override
  String get selectMemberType => 'Выберите тип членства.';

  @override
  String get memberTypeSaved => 'Тип членства сохранён';

  @override
  String get selectOption => 'Выберите вариант.';

  @override
  String get financialSaved => 'Финансовое положение сохранено';

  @override
  String get selectPaymentMethod => 'Выберите способ оплаты.';

  @override
  String get paymentDataSaved => 'Платёжные данные сохранены';

  @override
  String get selectDate => 'Выберите дату.';

  @override
  String get membershipStartSaved => 'Начало членства сохранено';

  @override
  String get fileTooLarge => 'Файл слишком большой (макс. 10 МБ).';

  @override
  String get leistungsbescheidUploaded =>
      'Справка о пособиях успешно загружена';

  @override
  String get verificationProgress => 'Прогресс верификации';

  @override
  String get notApplicable => 'Не применимо';

  @override
  String get socialBenefitsExempt =>
      'Способ оплаты не требуется для получателей социальных пособий.';

  @override
  String get locked => 'Заблокировано';

  @override
  String completePreviousStep(int step) {
    return 'Сначала завершите шаг $step.';
  }

  @override
  String rejectedNote(String note) {
    return 'Отклонено: $note';
  }

  @override
  String get waitingForReview => 'Ожидает рассмотрения правлением.';

  @override
  String get stepApproved => 'Этот шаг проверен и одобрен.';

  @override
  String get changesViaChat => 'Изменения возможны только через чат.';

  @override
  String get firstNameRequired => 'Имя *';

  @override
  String get lastNameRequired => 'Фамилия *';

  @override
  String get birthDateLabel => 'Дата рождения *';

  @override
  String get streetRequired => 'Улица *';

  @override
  String get houseNumberRequired => '№ *';

  @override
  String get cityRequired => 'Город *';

  @override
  String get phoneRequired => 'Номер телефона *';

  @override
  String get phonePurpose =>
      'Назначение: Связь при недоступности через приложение';

  @override
  String get selectMemberTypePrompt => 'Выберите желаемый тип членства:';

  @override
  String get financialExplanation =>
      'Чтобы проверить, имеете ли вы право на снижение взноса, нам нужна следующая информация. Она будет использована исключительно для определения вашего членского взноса.';

  @override
  String get socialBenefitsQuestion =>
      'Вы сейчас получаете социальные пособия?';

  @override
  String get optionBuergergeld => 'Да, гражданское пособие (Job Center)';

  @override
  String get optionSozialamt => 'Да, социальная помощь (Социальная служба)';

  @override
  String get optionNoBenefits => 'Нет, я не получаю социальных пособий';

  @override
  String get feeExempt => 'Ваш ежемесячный взнос: 0,00 €/месяц';

  @override
  String get uploadLeistungsbescheid => 'Загрузить справку о пособиях';

  @override
  String get uploadLeistungsbescheidHint =>
      'Загрузите актуальную справку о пособиях в течение 14 дней для подтверждения освобождения от взноса.';

  @override
  String get allowedFormatsUpload =>
      'Допустимые форматы: PDF, JPG, PNG (макс. 10 МБ)';

  @override
  String get feeRegular => 'Ваш ежемесячный взнос: 25,00 €/месяц';

  @override
  String paymentDayReminder(int day) {
    return 'Вам будет напоминаться $day-го числа каждого месяца.';
  }

  @override
  String get membershipStartPrompt =>
      'Выберите, когда должно начаться ваше членство.';

  @override
  String get optionAfterVerification => 'После завершения верификации';

  @override
  String get optionAfterVerificationDesc =>
      'Членство начинается со дня утверждения правлением.';

  @override
  String get optionRetroFoundation =>
      'Ретроактивно с даты основания (01.08.2025)';

  @override
  String get optionRetroFoundationDesc =>
      'Вы становитесь ретроактивным членом с момента основания ассоциации.';

  @override
  String get optionRetroCustom => 'Ретроактивно к другой дате';

  @override
  String get optionRetroCustomDesc =>
      'Выберите дату между 01.08.2025 и сегодняшним днём.';

  @override
  String get selectDateLabel => 'Выберите дату';

  @override
  String get selectDateHint => 'Выберите дату...';

  @override
  String get dateNotBefore => 'Не ранее 01.08.2025 (дата основания)';

  @override
  String get feeExemptRetro =>
      'Освобождение от взноса: 0,00 € ретроактивно.\nТолько дата членства устанавливается ретроактивно.';

  @override
  String get retroactiveFees => 'Ретроактивные взносы';

  @override
  String retroFeeCalculation(
      String from, String to, String months, String total) {
    return 'Период: $from – $to\nМесяцы: $months\nВзнос: $months × 25,00 € = $total €';
  }

  @override
  String get pleaseReadSatzung => 'Ознакомьтесь с уставом ассоциации.';

  @override
  String get pleaseReadDatenschutz =>
      'Ознакомьтесь с политикой конфиденциальности.';

  @override
  String get pleaseReadWiderruf => 'Ознакомьтесь с правом на отзыв.';

  @override
  String get acceptedAtRegistration => 'Принято при регистрации';

  @override
  String get confirmedByBoard =>
      'Будет подтверждено после рассмотрения правлением.';

  @override
  String get docSatzung => 'Устав';

  @override
  String get docDatenschutz => 'Политика конфиденциальности';

  @override
  String get docWiderruf => 'Право на отзыв';

  @override
  String acceptedAtRegCount(int count) {
    return 'Принято при регистрации ($count/3)';
  }

  @override
  String acceptedOn(String date) {
    return 'Принято $date';
  }

  @override
  String get notAccepted => 'Не принято';

  @override
  String get statusAccepted => 'Принято';

  @override
  String get nameTooLong => 'Имя слишком длинное (макс. 100 символов)';

  @override
  String get emailTooLong => 'Email слишком длинный (макс. 255 символов)';

  @override
  String get legalAcknowledgePrefix => 'Я ознакомился/ась с ';

  @override
  String get legalAcknowledgeSuffix => '.';

  @override
  String get legalStatutesSuffix => ' ICD360S e.V. и признаю их обязательными.';

  @override
  String get legalPleaseReadFirst => '(пожалуйста, сначала прочитайте)';

  @override
  String get statusActive => 'Активный';

  @override
  String get statusSuspended => 'Заблокирован';

  @override
  String get statusNew => 'Новый';

  @override
  String get statusCancelled => 'Отменён';

  @override
  String get statusDeleted => 'Удалён';

  @override
  String get roleMitglied => 'Участник';

  @override
  String get roleVorsitzer => 'Председатель';

  @override
  String get roleStellvertreter => 'Заместитель';

  @override
  String get roleSchatzmeister => 'Казначей';

  @override
  String get roleSchriftfuehrer => 'Секретарь';

  @override
  String get roleBeisitzer => 'Заседатель';

  @override
  String get roleKassierer => 'Кассир';

  @override
  String get roleKassenpruefer => 'Ревизор';

  @override
  String get roleEhrenamtlich => 'Волонтёр';

  @override
  String get roleMitgliedergruender => 'Член-основатель';

  @override
  String get roleEhrenmitglied => 'Почётный член';

  @override
  String get roleFoerdermitglied => 'Член-спонсор';

  @override
  String get memberTypeNotSet => 'Ещё не установлено';

  @override
  String get payMethodSepa => 'Прямое дебетование SEPA';

  @override
  String get labelStatus => 'Статус';

  @override
  String get labelMemberNumber => 'Номер участника';

  @override
  String get labelRole => 'Роль';

  @override
  String get labelMemberType => 'Тип членства';

  @override
  String get labelPaymentMethod => 'Способ оплаты';

  @override
  String get labelRegisteredOn => 'Зарегистрирован';

  @override
  String get labelLastLogin => 'Последний вход';

  @override
  String get labelMemberSince => 'Участник с';

  @override
  String get neverLoggedIn => 'Никогда';

  @override
  String get notActivatedYet => 'Ещё не активировано';

  @override
  String get tabVerification => 'Верификация';

  @override
  String get tabWarnings => 'Предупреждения';

  @override
  String get tabDocuments => 'Документы';

  @override
  String get tabMembership => 'Членство';

  @override
  String get pleaseEnterFirstName => 'Введите имя';

  @override
  String get pleaseEnterLastName => 'Введите фамилию';

  @override
  String get noFileDataReceived => 'Данные не получены';

  @override
  String get openFile => 'Открыть';

  @override
  String get noMicrophoneError =>
      'Микрофон не найден. Подключите микрофон и попробуйте снова.';

  @override
  String get startConversation => 'Начните разговор!';

  @override
  String get staffWillReply => 'Сотрудник скоро вам ответит.';

  @override
  String get inCall => 'В звонке...';

  @override
  String get registration => 'Регистрация';

  @override
  String get deactivation => 'Деактивация';

  @override
  String get deactivatedOn => 'Деактивирован';

  @override
  String get accountAutoSuspend =>
      'Аккаунты, не подтверждённые в течение 30 дней, будут автоматически заблокированы.';

  @override
  String get documentsProvidedByBoard =>
      'Документы предоставляются правлением.';

  @override
  String get noDocumentsAvailable => 'Документов нет';

  @override
  String get noDocumentsDescription =>
      'Для вас ещё не предоставлено документов.';

  @override
  String uploadedBy(String name) {
    return 'Загружено: $name';
  }

  @override
  String stepsCompleted(int completed, int total) {
    return '$completed/$total шагов выполнено';
  }

  @override
  String dayOfMonth(int day) {
    return '$day-е число месяца';
  }

  @override
  String changeField(String field) {
    return 'Изменить $field';
  }

  @override
  String openDocument(String name) {
    return 'Открыть $name';
  }

  @override
  String logEntries(int count) {
    return '$count записей';
  }

  @override
  String get noLogs => 'Нет логов';

  @override
  String get newLoginDetected => 'Обнаружен новый вход';

  @override
  String get errorNoInternet => 'Нет подключения к Интернету. Проверьте сеть.';

  @override
  String get errorTimeout => 'Сервер не отвечает. Попробуйте позже.';

  @override
  String get errorServer => 'Ошибка сервера. Попробуйте позже.';

  @override
  String get errorConnection => 'Ошибка соединения. Попробуйте позже.';

  @override
  String get errorUnexpected =>
      'Произошла непредвиденная ошибка. Попробуйте позже.';

  @override
  String get securityBannerTlsInterception =>
      'Ваша сеть перехватывает защищённые соединения. Смените сеть или отключите VPN/антивирус.';

  @override
  String get securityBannerDnsFailure =>
      'Обнаружена проблема с DNS. Проверьте соединение или смените сеть.';

  @override
  String get securityBannerSlowNetwork => 'Медленное соединение.';

  @override
  String get securityPermissionDialogTitle =>
      'Обнаружена возможная атака на сеть';

  @override
  String get securityPermissionDialogBody =>
      'Что-то в вашей сети может перехватывать соединения. Чтобы определить сеть и защитить вас, нам нужно разрешение читать имя Wi-Fi. Никакого отслеживания местоположения.';

  @override
  String get securityPermissionDialogAllow => 'Разрешить';

  @override
  String get securityPermissionDialogDeny => 'Не сейчас';

  @override
  String get callErrorMicPermissionDenied =>
      'Доступ к микрофону заблокирован. Включите его в Windows Settings → Privacy → Microphone (или в настройках конфиденциальности вашей системы) и попробуйте снова.';

  @override
  String get callErrorMicNotFound =>
      'Микрофон не найден. Подключите гарнитуру или микрофон и попробуйте снова.';

  @override
  String get claudiuWelcomeMorning => 'Доброе утро';

  @override
  String get claudiuWelcomeDay => 'Здравствуйте';

  @override
  String get claudiuWelcomeEvening => 'Добрый вечер';

  @override
  String get claudiuWelcomeNight => 'Добрый вечер';

  @override
  String get claudiuWelcomeVisitor => 'дорогой гость';

  @override
  String get claudiuWelcomeAsk => 'Чем я могу помочь?';

  @override
  String get claudiuWelcomeBecomeMember => 'Я хочу стать членом';

  @override
  String get claudiuWelcomeLogin => 'Я уже член и хочу войти';

  @override
  String get claudiuWelcomeProblem => 'У меня проблема с приложением';

  @override
  String get claudiuWelcomeEmergency => 'Срочно — позвоните нам';

  @override
  String get claudiuWelcomeMascotName => 'Клаудиу';

  @override
  String get claudiuWelcomeEmergencyIntro =>
      'Прежде чем звонить — наш график работы:';

  @override
  String get claudiuWelcomeScheduleOffice => 'В офисе';

  @override
  String get claudiuWelcomeScheduleField => 'На выезде с клиентами';

  @override
  String get claudiuWelcomeOutsideHoursNote =>
      'Вне этого времени мы принимаем только срочные обращения. Можно также отправить SMS — мы свяжемся с вами.';

  @override
  String get claudiuWelcomeCallNow => 'Позвонить сейчас';

  @override
  String get claudiuWelcomeSendSms => 'Отправить SMS';

  @override
  String get claudiuWelcomeSmsBody =>
      'Срочно, ICD360S e.V. — пожалуйста, свяжитесь со мной как можно скорее.';

  @override
  String get claudiuWelcomeCloseButton => 'Закрыть';

  @override
  String get claudiuLoginWelcome => 'С возвращением, дорогой член!';

  @override
  String get claudiuLoginAsk => 'Пожалуйста, скажи свой членский номер.';

  @override
  String get claudiuLoginProgress => 'Почти… продолжай вводить.';

  @override
  String get claudiuLoginReady => 'Отлично! Нажми кнопку ниже.';

  @override
  String get claudiuLoginLoading => 'Проверяю личность… 🔍';

  @override
  String get claudiuLoginFoundPlain => 'Нашёл! Сейчас войдёшь…';

  @override
  String claudiuLoginFoundNamed(String name) {
    return 'Нашёл, $name! Сейчас войдёшь…';
  }

  @override
  String get claudiuLoginError =>
      'Хм, такой номер не нахожу. Проверь, не ошибся ли?';

  @override
  String get claudiuLoginForgotHeader => 'Забыл членский номер?';

  @override
  String get claudiuLoginNoSms => 'Мы не отправляем номер по email или SMS.';

  @override
  String get claudiuLoginOnlyWay =>
      'Единственный путь: личная встреча в офисе ассоциации с удостоверением.';

  @override
  String get claudiuLoginContactUs => 'Позвони, чтобы записаться:';

  @override
  String get claudiuDiagnosticGreeting => 'Перед тем как войти, один вопрос';

  @override
  String get claudiuDiagnosticAsk =>
      'Можно отправлять анонимные отчёты, чтобы разработчики могли улучшить приложение?';

  @override
  String get claudiuDiagnosticYes => 'Да, я хочу помочь';

  @override
  String get claudiuDiagnosticNo => 'Нет, я просто смотрю';

  @override
  String get claudiuDiagnosticTellMore => 'Расскажи подробнее';

  @override
  String get claudiuDiagnosticSendsHeader => '📤 Что мы ОТПРАВЛЯЕМ (анонимно):';

  @override
  String get claudiuDiagnosticSends1 =>
      'Анонимный код устройства (НЕ номер члена)';

  @override
  String get claudiuDiagnosticSends2 => 'Ваша роль (член / правление)';

  @override
  String get claudiuDiagnosticSends3 =>
      'Система (Linux / Android / iOS / Windows)';

  @override
  String get claudiuDiagnosticSends4 => 'Выбранный язык';

  @override
  String get claudiuDiagnosticSends5 => 'Уровень и состояние батареи';

  @override
  String get claudiuDiagnosticSends6 => 'Текущий экран';

  @override
  String get claudiuDiagnosticSends7 => 'Длительность сессии (секунды)';

  @override
  String get claudiuDiagnosticSends8 => 'Ошибки, если есть (последние 10)';

  @override
  String get claudiuDiagnosticSends9 => 'Навигация (последние 20 экранов)';

  @override
  String get claudiuDiagnosticNeverHeader =>
      '🛡️ Что мы НИКОГДА не отправляем:';

  @override
  String get claudiuDiagnosticNever1 => 'Ваше настоящее имя';

  @override
  String get claudiuDiagnosticNever2 => 'Адрес электронной почты';

  @override
  String get claudiuDiagnosticNever3 => 'Номер телефона';

  @override
  String get claudiuDiagnosticNever4 => 'Пароль';

  @override
  String get claudiuDiagnosticNever5 => 'Содержимое сообщений чата';

  @override
  String get claudiuDiagnosticNever6 => 'Содержимое тикетов';

  @override
  String get claudiuDiagnosticNever7 => 'Документы или вложения';

  @override
  String get claudiuDiagnosticTechHeader => '📡 Технические детали:';

  @override
  String get claudiuDiagnosticTech1 => 'Отправляется каждые 2 минуты';

  @override
  String get claudiuDiagnosticTech2 =>
      'TLS-шифрование, фиксированный сертификат';

  @override
  String get claudiuDiagnosticTech3 => 'Можно отключить в настройках';

  @override
  String get claudiuProblemHelpTitle => 'Чем я могу помочь?';

  @override
  String get claudiuProblemHelpGreeting => 'Что случилось?';

  @override
  String get claudiuProblemHelpAsk => 'Как тебе удобно рассказать?';

  @override
  String get claudiuProblemHelpWriteTitle => 'Написать отчёт';

  @override
  String get claudiuProblemHelpWriteBody =>
      'С подробностями шаг за шагом. Команда получит текст и разберётся позже.';

  @override
  String get claudiuProblemHelpChatTitle => 'Поговорим сейчас';

  @override
  String get claudiuProblemHelpChatBody =>
      'Анонимный чат с оператором. Ответ в реальном времени, если кто-то онлайн.';

  @override
  String get claudiuProblemHelpAltCallHeader => 'Или, если срочно:';

  @override
  String get claudiuProblemHelpAltCallLabel => 'Позвонить';

  @override
  String get claudiuAnonymousChatTitle => 'Анонимный чат';

  @override
  String get claudiuAnonymousChatGreeting => 'Привет!';

  @override
  String get claudiuAnonymousChatWelcome =>
      'Я слушаю. Пиши что угодно — имя не нужно. Отвечу, как только буду на связи.';

  @override
  String get claudiuAnonymousChatHint => 'Написать сообщение…';

  @override
  String get claudiuAnonymousChatWaitingOperator => 'Ждём ответа оператора…';

  @override
  String get claudiuVorsitzerConnectedTitle => 'Привет!';

  @override
  String get claudiuVorsitzerConnectedBody =>
      'Спасибо, что написал — ты на связи с Vorsitzer. Расскажи, чем мы можем помочь с твоей заявкой на вступление.';

  @override
  String get claudiuVorsitzerConnectedSender => 'Vorsitzer';

  @override
  String get claudiuQuickReplyValidationTime =>
      'Сколько времени занимает проверка?';

  @override
  String get claudiuQuickReplyDocuments => 'Какие документы мне нужны?';

  @override
  String get claudiuQuickReplyStepProblem => 'Я застрял на одном шаге';

  @override
  String get claudiuQuickReplyHuman => 'Можно сейчас поговорить с кем-то?';

  @override
  String get claudiuAnonymousChatConnecting => 'Подключаюсь…';

  @override
  String get claudiuAnonymousChatConnectionFailed =>
      'Не удалось открыть чат. Попробуй ещё раз или позвони.';

  @override
  String get claudiuAnonymousChatRetry => 'Попробовать снова';

  @override
  String get claudiuAnonymousChatOnline => 'Подключено';

  @override
  String get claudiuAnonymousChatOffline => 'Переподключение…';

  @override
  String get claudiuAnonymousChatAdminTyping => 'Оператор печатает…';

  @override
  String get claudiuProblemReportTitle => 'Сообщить о проблеме';

  @override
  String get claudiuProblemReportGreeting => 'Что случилось?';

  @override
  String get claudiuProblemReportAsk =>
      'Расскажи подробно, и я передам отчёт команде.';

  @override
  String get claudiuProblemReportIncludeHeader => 'Пожалуйста, укажи:';

  @override
  String get claudiuProblemReportIncludeBullets1 =>
      'Что ты делал, когда появилась проблема';

  @override
  String get claudiuProblemReportIncludeBullets2 =>
      'Какое сообщение об ошибке появилось';

  @override
  String get claudiuProblemReportIncludeBullets3 => 'На каком экране ты был';

  @override
  String get claudiuProblemReportIncludeBullets4 =>
      'Приложение вылетает? Закрывается? Показывает белый экран?';

  @override
  String get claudiuProblemReportIncludeBullets5 =>
      'Повторяется или это один раз?';

  @override
  String get claudiuProblemReportDescriptionLabel => 'Твоё описание';

  @override
  String get claudiuProblemReportDescriptionHint =>
      'Напр.: При открытии чата появляется «Connection error» и приложение не отвечает…';

  @override
  String claudiuProblemReportTooShort(int count) {
    return 'Чуть подробнее, пожалуйста (минимум $count символов)';
  }

  @override
  String get claudiuProblemReportSubmit => 'Отправить отчёт';

  @override
  String get claudiuProblemReportSubmitting => 'Отправка…';

  @override
  String get claudiuProblemReportSentTitle => 'Спасибо!';

  @override
  String get claudiuProblemReportSentBody =>
      'Отчёт отправлен. Наша команда рассмотрит его как можно скорее.';

  @override
  String get claudiuProblemReportSentClose => 'Понятно';

  @override
  String get claudiuProblemReportSendFailed =>
      'Не удалось отправить отчёт. Позвони нам, если срочно.';

  @override
  String get claudiuProblemReportAlt => 'Или, если срочно:';

  @override
  String get claudiuProblemReportCallLabel => 'Позвонить';

  @override
  String claudiuApprovalGreeting(String name) {
    return 'Привет, $name! 👋';
  }

  @override
  String get claudiuApprovalGreetingNoName => 'Привет! 👋';

  @override
  String get claudiuApprovalGladToSeeYou => 'Рад, что ты пришёл!';

  @override
  String get claudiuApprovalCheckingForSafety =>
      'Для твоей безопасности Vorsitzer сейчас проверяет твой запрос на вход. 🛡️';

  @override
  String get claudiuApprovalMonthlyExplain =>
      '💡 Мы делаем это раз в 30 дней, чтобы убедиться, что это действительно ты. Это как чек-ап безопасности — максимум 5 минут.';

  @override
  String get claudiuApprovalSuccess =>
      'Готово! 🎉 Vorsitzer тебя узнал. Сейчас войдёшь…';

  @override
  String get claudiuApprovalDenied => 'Хм, Vorsitzer отклонил твой запрос. 😔';

  @override
  String get claudiuApprovalDeniedHelp =>
      'Если думаешь, что это ошибка, позвони нам, и мы разберёмся.';

  @override
  String get claudiuApprovalExpired =>
      'Прошло 5 минут, а ответа от Vorsitzer не было.';

  @override
  String get claudiuApprovalExpiredHelp =>
      'Позвони нам и мы сможем одобрить твой запрос на месте. 📞';

  @override
  String get claudiuApprovalCallUs => 'Позвонить';

  @override
  String get claudiuApprovalTryAgain => 'Попробовать снова';

  @override
  String get claudiuApprovalCancel => 'Отмена';

  @override
  String get claudiuApprovalClose => 'Закрыть';

  @override
  String get wizardIntroBubble1 =>
      'Привет, гость! 👋 Спасибо, что хочешь стать частью нашей семьи.';

  @override
  String get wizardIntroBubble2 =>
      'Меня зовут Клаудиу. Весной 2025 года у меня было ясное видение: создать ассоциацию, которая помогает нуждающимся людям — добровольно, от сердца, без лишней бюрократии. ❤️';

  @override
  String get wizardIntroBubble3 =>
      'Я начал говорить с клиентами, которых посещал. Я рассказал им свою мечту. И каждый сказал: «Да, давай!» В июле 2025 года мы встретились — 6 решительных людей. Мы решили основать **ICD360S e.V.** в Нойу-Ульме. 📍';

  @override
  String get wizardIntroBubble4 =>
      '**1 августа 2025 года** ассоциация официально появилась — в Реестре ассоциаций. Самый прекрасный подарок для меня. 🎂';

  @override
  String get wizardIntroBubble5 =>
      'Что мы делаем? Помогаем беженцам, людям с инвалидностью, экономически уязвимым, **детям и молодежи** — с административными вопросами, изучением немецкого, жильем, покупками, социальными пособиями. Наш Vorstand состоит преимущественно из людей с инвалидностью — так решения принимаются из реального жизненного опыта. 🤝';

  @override
  String get wizardIntroBubble6 =>
      'Теперь твоя очередь. Давай тебя запишем — займёт около 5 минут. Идём шаг за шагом, я тебя не оставлю. ✨';

  @override
  String get wizardIntroStart => 'Начнём';

  @override
  String get wizardBack => 'Назад';

  @override
  String get wizardNext => 'Далее';

  @override
  String wizardStepLabel(int step, int total, String title) {
    return 'Шаг $step из $total · $title';
  }

  @override
  String get wizardErrRequired => 'Это поле обязательно';

  @override
  String wizardErrTooShort(int count) {
    return 'Слишком коротко (минимум $count символов)';
  }

  @override
  String get wizardErrOnlyLetters =>
      'Только буквы, пробелы, дефисы и апострофы';

  @override
  String get wizardErrSaveFailed =>
      'Не удалось сохранить. Проверь соединение и попробуй ещё раз.';

  @override
  String get wizardStufe1aTitle => 'Личность';

  @override
  String get wizardStufe1aPrompt =>
      'Давай знакомиться официально. Напиши своё имя точно так, как в Personalausweis, Reisepass или Aufenthaltstitel — чтобы совпадало с документами.';

  @override
  String get wizardStufe1aVornameLabel => 'Vornamen (имена)';

  @override
  String get wizardStufe1aVornameHelper =>
      'Все имена точно как в документе. Через пробел или дефис (например, Hans-Peter, Maria Anna).';

  @override
  String get wizardStufe1aNachnameLabel => 'Familienname (фамилия)';

  @override
  String get wizardStufe1aNachnameHelper => 'Твоя нынешняя фамилия.';

  @override
  String get wizardStufe1aGeburtsnameLabel =>
      'Geburtsname (фамилия при рождении) — необязательно';

  @override
  String get wizardStufe1aGeburtsnameHelper =>
      'Только если отличается от Familienname — например, до брака.';

  @override
  String get wizardStufe1bTitle => 'День рождения';

  @override
  String get wizardStufe1bPrompt =>
      'Мы хотим праздновать твой день рождения вместе! 🎂 И нам важно знать, что тебе хотя бы 16 — так написано в нашем уставе.';

  @override
  String get wizardStufe1bGeburtsdatumLabel => 'Дата рождения';

  @override
  String get wizardStufe1bGeburtsdatumHelper => 'Нажми, чтобы выбрать дату';

  @override
  String get wizardStufe1bGeburtsortLabel => 'Место рождения';

  @override
  String get wizardStufe1bGeburtsortHelper =>
      'Город / населённый пункт, где ты родился.';

  @override
  String get wizardAgeGatePrompt => 'Мне жаль… 😔';

  @override
  String wizardAgeGateBody1(int age, int years) {
    return 'Наш устав говорит, что для членства нужно быть не моложе 16 лет. Тебе $age — надеюсь увидеть тебя через $years лет(а)! 🌱';
  }

  @override
  String get wizardAgeGateBody2 =>
      'Если хочешь иногда помогать как волонтёр (любой возраст, с согласия родителей), позвони нам — мы любим поддерживать молодых, которые хотят менять мир.';

  @override
  String get wizardAgeGateBackHome => 'Назад к началу';

  @override
  String get wizardErrInvalidPhone => 'Неверный номер телефона';

  @override
  String get wizardStufe1b1Title => 'Согласие родителя';

  @override
  String get wizardStufe1b1Prompt =>
      'Ты несовершеннолетний (16-17) — согласно §106 BGB нам нужно согласие родителя или законного представителя. Скажи мне имя и номер телефона. Vorsitzer позвонит и договорится о встрече (лично или по видеосвязи). Без email — мы хотим быть уверены, что говорим с реальным человеком.';

  @override
  String get wizardStufe1b1VornameLabel => 'Имя родителя';

  @override
  String get wizardStufe1b1VornameHelper => 'Как в Personalausweis родителя.';

  @override
  String get wizardStufe1b1NachnameLabel => 'Фамилия родителя';

  @override
  String get wizardStufe1b1NachnameHelper => 'Как в Personalausweis родителя.';

  @override
  String get wizardStufe1b1TelefonLabel => 'Мобильный родителя';

  @override
  String get wizardStufe1b1TelefonHelper => 'На этот номер позвонит Vorsitzer.';

  @override
  String get wizardStufe1b1RelationLabel => 'Отношение к ребёнку:';

  @override
  String get wizardStufe1b1RelationMutter => 'Мать';

  @override
  String get wizardStufe1b1RelationVater => 'Отец';

  @override
  String get wizardStufe1b1RelationSorgeberechtigter => 'Законный опекун';

  @override
  String get wizardStufe1b1RelationAndere => 'Другой опекун';

  @override
  String get wizardStufe1cTitle => 'Личные данные';

  @override
  String get wizardStufe1cPrompt =>
      'Просто чтобы я узнал тебя чуть лучше. Это останется между нами и нигде публично не показывается.';

  @override
  String get wizardStufe1cGeschlechtLabel => 'Пол';

  @override
  String get wizardStufe1cGeschlechtMaennlich => 'Мужской';

  @override
  String get wizardStufe1cGeschlechtWeiblich => 'Женский';

  @override
  String get wizardStufe1cGeschlechtDivers => 'Иное';

  @override
  String get wizardStufe1cGeschlechtKeineAngabe => 'Не указано';

  @override
  String get wizardStufe1cFamilienstandLabel => 'Семейное положение';

  @override
  String get wizardStufe1cFamilienstandLedig => 'Холост / Не замужем';

  @override
  String get wizardStufe1cFamilienstandVerheiratet => 'Женат / Замужем';

  @override
  String get wizardStufe1cFamilienstandGeschieden => 'Разведён / Разведена';

  @override
  String get wizardStufe1cFamilienstandVerwitwet => 'Вдовец / Вдова';

  @override
  String get wizardStufe1dTitle => 'Происхождение';

  @override
  String get wizardStufe1dPrompt =>
      'Это помогает предложить тебе подходящую помощь — например, консультации по Aufenthalt или поиск твоего языкового сообщества.';

  @override
  String get wizardStufe1dStaatLabel => 'Гражданство';

  @override
  String get wizardStufe1dStaatHelper =>
      'Например: deutsch, rumänisch, ukrainisch. Несколько через запятую.';

  @override
  String get wizardStufe1dAufenthaltLabel =>
      'Статус пребывания (Aufenthaltsstatus) — необязательно';

  @override
  String get wizardStufe1dAufenthaltHelper =>
      'Выбери название из своей Aufenthaltskarte / решения. Vorstand сверит с твоими документами.';

  @override
  String get wizardStufe1dAufenthaltAwaitingCitizenship =>
      'Сначала укажи гражданство выше — покажем только подходящие варианты.';

  @override
  String get wizardStufe1dAufenthaltGerman =>
      'Aufenthaltstitel не требуется — гражданин Германии.';

  @override
  String get wizardStufe1dAufenthaltEuEea =>
      'Гражданин ЕС/ЕЭП/Швейцарии — свобода передвижения (Freizügigkeit).';

  @override
  String get wizardStufe1dAufenthaltTempHint => 'временный';

  @override
  String get wizardStufe1dAufenthaltPermHint => 'постоянное проживание';

  @override
  String get wizardStufe1dAufenthaltAsylumProcessHint => 'процедура убежища';

  @override
  String get wizardStufe1dAufenthaltOther => 'Другое (уточни в чате)';

  @override
  String get wizardStufe1dAufenthaltRequired =>
      'Пожалуйста, выбери Aufenthaltstitel.';

  @override
  String get wizardStufe1dMutterspracheLabel => 'Родной язык';

  @override
  String get wizardStufe1dMutterspracheHelper =>
      'Заполнено языком приложения — измени, если другой.';

  @override
  String get wizardStufe1eTitle => 'Адрес';

  @override
  String get wizardStufe1ePrompt =>
      'Твой почтовый адрес — мы используем его для официальных документов (устав, договоры членства, уведомления).';

  @override
  String get wizardStufe1eStrasseLabel => 'Улица';

  @override
  String get wizardStufe1eStrasseHelper =>
      'Только название улицы — номер дома в соседнем поле.';

  @override
  String get wizardStufe1eHausnummerLabel => '№';

  @override
  String get wizardStufe1ePlzLabel => 'PLZ (индекс)';

  @override
  String get wizardStufe1eOrtLabel => 'Город';

  @override
  String get wizardStufe1eLandLabel => 'Страна';

  @override
  String get wizardStufe1eLandHelper => 'Предзаполнено: Deutschland.';

  @override
  String get wizardErrInvalidStreet => 'Неверное название улицы';

  @override
  String get wizardErrInvalidHausnummer =>
      'Неверный номер (напр. 12, 12a, 12/3)';

  @override
  String get wizardErrInvalidPlz => 'Неверный индекс (только цифры)';

  @override
  String get wizardStufe1fTitle => 'Контакт';

  @override
  String get wizardStufe1fPrompt =>
      'Как с тобой связаться? Телефон — только для срочных случаев, всё остальное идёт через наш собственный сквозно зашифрованный канал в приложении. Твой членский email присваивается автоматически и показан ниже.';

  @override
  String get wizardStufe1fTelefonLabel => 'Мобильный';

  @override
  String get wizardStufe1fTelefonHelper =>
      'Обещаю, позвоню только если это действительно важно. 📱';

  @override
  String get wizardStufe2Title => 'Тип членства';

  @override
  String get wizardStufe2Prompt =>
      'Каким членом ты хочешь стать? Дай мне объяснить каждую опцию.';

  @override
  String get wizardStufe2OrdentlichTitle => 'Действительный член (ordentlich)';

  @override
  String get wizardStufe2OrdentlichBody =>
      'Полные права. Платишь ежемесячный взнос, голосуешь в Mitgliederversammlung, можешь быть избран в Vorstand. Стандартный выбор.';

  @override
  String get wizardStufe2FoerderTitle => 'Поддерживающий член (Fördermitglied)';

  @override
  String get wizardStufe2FoerderBody =>
      'Поддерживаешь ассоциацию финансово, но не участвуешь активно в решениях. Без права голоса. Подходит, если хочешь помогать на расстоянии.';

  @override
  String get wizardStufe2EhrenTitle => 'Почётный член (Ehrenmitglied)';

  @override
  String get wizardStufe2EhrenBody =>
      'Присуждается Vorstand за особые заслуги. Ты не выбираешь его сам — он даётся как признание. Выбери только если уже был удостоен.';

  @override
  String get wizardStufe3Title => 'Финансовое положение';

  @override
  String get wizardStufe3Prompt =>
      'Теперь о твоей финансовой ситуации. Не для того, чтобы судить — а чтобы освободить от взноса, если получаешь социальные выплаты.';

  @override
  String get wizardStufe3OptionBuergergeld => 'Получаю Bürgergeld';

  @override
  String get wizardStufe3OptionSozialamt => 'Получаю пособие от Sozialamt';

  @override
  String get wizardStufe3OptionNein => 'Не получаю ни одно из этих';

  @override
  String get wizardStufe3FeeExemptTitle => 'Взнос: 0 € / месяц 🎉';

  @override
  String get wizardStufe3FeeExemptBody =>
      'С Bürgergeld, Sozialamt, ALG I или Krankengeld ты полностью освобождён от взноса по Satzung §6. Нам нужно только подтверждение (Leistungsbescheid или справка от ведомства / больничной кассы).';

  @override
  String get wizardStufe3UploadTitle => 'Загрузить Leistungsbescheid';

  @override
  String get wizardStufe3UploadHint => 'PDF / JPG / PNG, максимум 10 МБ.';

  @override
  String get wizardStufe3UploadRequired =>
      'Загрузи Leistungsbescheid прежде чем продолжишь.';

  @override
  String get wizardStufe3FileTooLarge =>
      'Файл слишком большой. Максимум 10 МБ.';

  @override
  String get wizardStufe3UploadFailed =>
      'Не удалось загрузить файл. Попробуй ещё раз.';

  @override
  String get wizardStufe3RegularFeeTitle => 'Взнос: 25 € / месяц';

  @override
  String get wizardStufe3RegularFeeBody =>
      'Стандартный взнос для действительных членов согласно уставу.';

  @override
  String get wizardStufe4Title => 'Оплата';

  @override
  String get wizardStufe4Prompt =>
      'Как хочешь платить взнос? И в какой день месяца тебе удобно?';

  @override
  String get wizardStufe4MethodUeberweisungTitle =>
      'Банковский перевод (Überweisung)';

  @override
  String get wizardStufe4MethodUeberweisungBody =>
      'Ты сам инициируешь оплату каждый месяц со своего счёта.';

  @override
  String get wizardStufe4MethodSepaTitle => 'SEPA-Lastschrift (прямой дебет)';

  @override
  String get wizardStufe4MethodSepaBody =>
      'Мы списываем сумму автоматически с твоего счёта. Удобнее всего, но нужны IBAN и подписанное мандат.';

  @override
  String get wizardStufe4MethodDauerauftragTitle =>
      'Dauerauftrag (постоянное поручение)';

  @override
  String get wizardStufe4MethodDauerauftragBody =>
      'Ты настраиваешь постоянное поручение в своём банке. Банк сам переводит сумму каждый месяц.';

  @override
  String get wizardStufe4DayLabel => 'День оплаты';

  @override
  String get wizardStufe4DayHint => 'Выбери день от 1 до 31';

  @override
  String wizardStufe4DayItem(int day) {
    return '$day-е число';
  }

  @override
  String wizardStufe4DayReminder(int day) {
    return 'Взнос будет списываться $day-го числа каждого месяца.';
  }

  @override
  String get wizardStufe5Title => 'Дата начала';

  @override
  String get wizardStufe5Prompt =>
      'С какого момента ты хочешь стать официальным членом ICD360S? С момента одобрения или ретроактивно.';

  @override
  String get wizardStufe5OptionAbVerifizierungTitle =>
      'С момента одобрения Vorstand';

  @override
  String get wizardStufe5OptionAbVerifizierungBody =>
      'Самый простой вариант. Без ретроактивного взноса.';

  @override
  String get wizardStufe5OptionGruendungsdatumTitle =>
      'Ретроактивно с 01.08.2025 (дата основания)';

  @override
  String get wizardStufe5OptionGruendungsdatumBody =>
      'Будешь считаться членом с первого дня ассоциации.';

  @override
  String get wizardStufe5OptionAnderesDatumTitle => 'Другая дата';

  @override
  String get wizardStufe5OptionAnderesDatumBody =>
      'Сам выбираешь дату между 01.08.2025 и сегодня.';

  @override
  String get wizardStufe5PickDate => 'Нажми, чтобы выбрать дату';

  @override
  String get wizardStufe5PickDateFirst => 'Сначала выбери дату.';

  @override
  String get wizardStufe5DatePickerHelp => 'Дата начала членства';

  @override
  String wizardStufe5DateRange(String start) {
    return 'Между $start и сегодня';
  }

  @override
  String get wizardStufe5RetroactiveTitle => 'Ретроактивный взнос';

  @override
  String wizardStufe5RetroactiveBody(
      String start, String end, int months, String amount) {
    return 'С $start по $end это $months месяцев. По 25 €/месяц получается $amount € к доплате, помимо текущего месячного взноса.';
  }

  @override
  String get wizardStufe5FeeExemptTitle => 'Ретроактивный взнос: 0 € 🎉';

  @override
  String get wizardStufe5FeeExemptBody =>
      'С Bürgergeld или Sozialamt ты полностью освобождён — даже ретроактивно ничего не должен.';

  @override
  String wizardDocumentPrompt(String doc) {
    return 'Прежде чем закончить, прочитай внимательно $doc. Важно понимать, что ты подписываешь.';
  }

  @override
  String get wizardDocumentScrollHint => 'Прокрути до конца, чтобы продолжить.';

  @override
  String get wizardDocumentScrolledOk => 'Ты прочитал до конца ✓';

  @override
  String wizardDocumentOpenButton(String doc) {
    return 'Открыть $doc в браузере';
  }

  @override
  String get wizardDocumentExternalHint =>
      'На этой платформе мы открываем документ в твоём браузере по умолчанию.';

  @override
  String get wizardDocumentOpenedOk =>
      'Документ был открыт. Прочитай его внимательно.';

  @override
  String wizardDocumentConfirm(String doc) {
    return 'Подтверждаю, что прочитал(а) и согласен(на) с $doc.';
  }

  @override
  String get wizardFinalAdultTitle => 'Готово! Ты записан 🎉';

  @override
  String get wizardFinalMinorTitle => 'Заявка отправлена 📨';

  @override
  String get wizardFinalMinorBody =>
      'Мы свяжемся с твоим родителем и назначим встречу (лично или видеозвонок). Прошу проявить терпение — процесс может занять до 7 дней. Получишь уведомление в приложении, как только родитель одобрит.';

  @override
  String get wizardFinalMitgliedernummerLabel => 'Твой номер члена';

  @override
  String get wizardStufe4MethodComingSoon => 'Скоро';

  @override
  String get wizardStufe4StreichungWarning =>
      'Если ты задолжаешь более 6 месяцев по взносу, мы автоматически тебя вычеркнем (Satzung §6 Abs. 3).';

  @override
  String get wizardStufe5KuendigungInfo =>
      'Для выхода: пришли заявление об отказе в письменном виде за 3 месяца до 31 декабря (до 30 сентября, чтобы вступило в силу к концу года). Минимального срока нет (Satzung §6 Abs. 3).';

  @override
  String get wizardStufe1fEmailLabel => 'Твой членский email';

  @override
  String get wizardStufe1fEmailHelper =>
      'Присваивается автоматически на основе твоего членского номера. Активируется в тот момент, когда правление (Vorstand) одобрит твою заявку. У нас есть собственное почтовое приложение — отправляй и получай зашифрованные письма, просто и бесплатно.';

  @override
  String get wizardErrInvalidEmail => 'Неверный адрес электронной почты';

  @override
  String get wizardStufe3OptionAlg1 =>
      'Получаю Arbeitslosengeld I (ALG I, пособие по безработице)';

  @override
  String get wizardStufe3OptionKrankengeld =>
      'Получаю Krankengeld (пособие по длительной болезни)';

  @override
  String get wizardStufe3UploadAddMore => 'Добавить ещё документ';

  @override
  String get wizardStufe3UploadLimitCount =>
      'Достигнут лимит: до 20 документов.';

  @override
  String get wizardStufe3UploadLimitTotal =>
      'Достигнут лимит 100 МБ. Удали один из существующих файлов.';

  @override
  String get wizardStufe3UploadDeleteTooltip => 'Удалить';

  @override
  String wizardStufe3UploadCounter(int count, int max) {
    return '$count / $max документов';
  }

  @override
  String get wizardDocumentExternalOpenFailed =>
      'Не удалось открыть браузер. Ссылка скопирована в буфер обмена — вставь её в браузер, чтобы продолжить.';

  @override
  String get wizardFinalTimelineProcessing =>
      'Vorstand проверяет · обычно 1 рабочий день, максимум 7';

  @override
  String get wizardFinalTimelineActivated => 'Аккаунт активирован';

  @override
  String get wizardFinalAdultThank =>
      'Спасибо, что заполнил форму регистрации! 🎉';

  @override
  String get wizardFinalAdultUsual =>
      'Твоя заявка у нас. Обычно мы её проверяем за один рабочий день.';

  @override
  String get wizardFinalAdultExceptional =>
      'Иногда может занять до 7 рабочих дней. А если что-то не сходится, мы вернём тебя в форму, чтобы исправить 🙂';

  @override
  String get wizardFinalStatusTitle => 'СТАТУС ЗАЯВКИ';

  @override
  String wizardFinalStatusStepsValidated(int reviewed, int total) {
    return '$reviewed/$total шагов проверено правлением Vorstand';
  }

  @override
  String get wizardFinalStufeSheetTitle => 'Детали заявки';

  @override
  String get wizardFinalStufeSheetHint =>
      'Восемь этапов, которые ты прошёл. Vorstand проверяет их по очереди — ты видишь в реальном времени, что уже одобрено.';

  @override
  String get wizardFinalStufeStatusPending => 'Ожидает проверки';

  @override
  String get wizardFinalStufeStatusApproved => 'Одобрено';

  @override
  String get wizardFinalStufeStatusRejected => 'Отклонено';

  @override
  String wizardFinalStatusRejectionCount(int count) {
    return '$count шаг требует исправления';
  }

  @override
  String get wizardFinalStufeRejectionReason => 'Причина от Vorstand:';

  @override
  String get wizardFinalStufeCorrectNow => 'Исправить сейчас';

  @override
  String wizardFinalApprovalsHeader(int current, int total) {
    return 'Одобрения Vorstand ($current/$total)';
  }

  @override
  String get wizardFinalApprovalAwaiting => 'Ожидаем 2-го Vorstand';

  @override
  String get wizardFinalApprovalRejected => 'ОТКЛОНЕНО';

  @override
  String get wizardFinalStufeNoDataYet => 'Данные пока недоступны.';

  @override
  String get wizardFinalStufeReadAt => 'Прочитано:';

  @override
  String get wizardFinalStufeBeitragsfrei =>
      'Освобождён от взноса (без оплаты)';

  @override
  String get wizardFinalStufeNotExempt => 'Без социальных пособий';

  @override
  String get wizardFinalStufeBeginAtVerification => 'Начало при верификации';

  @override
  String get wizardFinalStufeBeginAtFoundation =>
      'Дата основания (задним числом)';

  @override
  String get wizardFinalStufeBeginAtCustom => 'Другая дата';

  @override
  String get wizardFinalStufeStatusSkipped => 'Пропущено';

  @override
  String get wizardFinalStufeFilledAt => 'Заполнено:';

  @override
  String get wizardFinalStufeReviewedAt => 'Проверено:';

  @override
  String get wizardFinalWithdrawLink => 'Отозвать заявку';

  @override
  String get wizardFinalWithdrawDialogTitle => 'Отозвать заявку?';

  @override
  String get wizardFinalWithdrawDialogBody =>
      'Твоя заявка будет помечена как отозванная тобой. Данные останутся в базе для аудита (GDPR), но аккаунт не будет активирован. Ты сможешь пройти регистрацию заново в любой момент с новым номером.';

  @override
  String get wizardFinalWithdrawKeep => 'Нет, подожду';

  @override
  String get wizardFinalWithdrawConfirm => 'Да, отозвать';

  @override
  String get wizardErrTooManyWithdrawals =>
      'Твоя заявка не может быть обработана автоматически. Позвони нам или приходи лично к Vorstand, чтобы продолжить регистрацию.';

  @override
  String get wizardDuplicateLoginTitle => 'Похоже, ты уже наш член';

  @override
  String get wizardDuplicateLoginBody =>
      'По твоему имени и дате рождения мы уже находим активный аккаунт. Пожалуйста, используй «Я уже член» на главном экране, чтобы войти. Если доступа больше нет, позвони нам.';

  @override
  String get wizardDuplicatePendingTitle => 'Твоя заявка уже у нас';

  @override
  String get wizardDuplicatePendingBody =>
      'По твоему имени и дате рождения у нас уже есть заявка на рассмотрении. Vorstand работает над ней — мы пришлём уведомление, как только аккаунт станет активным. Позвони, если хочешь обсудить.';

  @override
  String get wizardDuplicateRecentlyWithdrawnTitle =>
      'Сейчас мы не можем обработать заявку';

  @override
  String get wizardDuplicateRecentlyWithdrawnBody =>
      'Твоё имя и дата рождения совпадают с недавно отозванной заявкой. Пожалуйста, позвони нам, чтобы поговорить с Vorstand, прежде чем продолжать.';

  @override
  String get wizardDuplicatePreviouslyWithdrawnTitle => 'Ты уже подавал заявку';

  @override
  String get wizardDuplicatePreviouslyWithdrawnBody =>
      'Твоё имя и дата рождения совпадают со старой заявкой, которую ты отозвал. С возвращением — пожалуйста, позвони нам перед тем, как продолжишь, чтобы Vorstand принял решение.';

  @override
  String get wizardDuplicateCallUsTitle => 'Пожалуйста, позвони нам';

  @override
  String get wizardDuplicateCallUsBody =>
      'Твоё имя и дата рождения уже есть у нас, но мы не можем сообщить детали через приложение. Пожалуйста, позвони — Vorstand объяснит ситуацию напрямую.';

  @override
  String get wizardChatHelp => 'Поговорим';

  @override
  String get wizardChatHelpSubtitle => 'Живой чат с Vorstand · быстрый ответ';

  @override
  String get benachrichtigungTitel => 'Напоминания по SMS';

  @override
  String get benachrichtigungIntro =>
      'Чтобы вы не пропустили встречу, объединение может присылать вам SMS. Вы решаете, нужно ли это и для чего, и можете изменить решение в любой момент.';

  @override
  String get benachrichtigungTermineFrage =>
      'Хотите получать напоминания о встречах по SMS?';

  @override
  String get benachrichtigungTermineDetail =>
      'В сообщении будут дата, время, место и тема встречи.';

  @override
  String get benachrichtigungMedikamenteFrage =>
      'Напоминать также о лекарствах?';

  @override
  String get benachrichtigungMedikamenteDetail =>
      'В сообщении будет указано название лекарства. Это сведения о здоровье, поэтому мы спрашиваем отдельно.';

  @override
  String get benachrichtigungHinweis =>
      'Напоминание — это помощь, а не гарантия: пожалуйста, не полагайтесь только на него. Изменить можно в любой момент в профиле.';

  @override
  String get benachrichtigungJa => 'Да';

  @override
  String get benachrichtigungNein => 'Нет';

  @override
  String get benachrichtigungSpaeter => 'Решить позже';

  @override
  String get benachrichtigungSpeichern => 'Сохранить';

  @override
  String get benachrichtigungGespeichert => 'Спасибо, сохранено.';

  @override
  String get benachrichtigungenLeer => 'Нет уведомлений';

  @override
  String get benachrichtigungenAlleGelesen => 'Отметить все как прочитанные';

  @override
  String get benachrichtigungWetterFrage =>
      'Хотите получать предупреждения о непогоде по месту жительства?';

  @override
  String get benachrichtigungWetterDetail =>
      'Только официальные предупреждения немецкой метеослужбы уровня «сильное» и выше — не при каждом дожде.';

  @override
  String get signaturTitel => 'Подписи';

  @override
  String get signaturNichtsOffen => 'Сейчас нет документов на подпись.';

  @override
  String get signaturStatusOffen => 'Ожидает вашей подписи';

  @override
  String get signaturStatusSigniert => 'Подписано вами';

  @override
  String get signaturStatusAbgelehnt => 'Отклонено вами';

  @override
  String get signaturStatusWiderrufen => 'Отозвано объединением';

  @override
  String get signaturStatusAbgelaufen => 'Срок истёк';

  @override
  String signaturBitteGanzLesen(int gelesen, int gesamt) {
    return 'Пожалуйста, прочитайте документ до конца (страница $gelesen из $gesamt).';
  }

  @override
  String get signaturWeiterZurUnterschrift => 'Перейти к подписи';

  @override
  String get signaturAblehnen => 'Отклонить';

  @override
  String get signaturAblehnenHinweis =>
      'Объединение будет уведомлено. Вы можете указать причины.';

  @override
  String get signaturAblehnenGrund => 'Причина (необязательно)';

  @override
  String get signaturMitFingerHinweis => 'Распишитесь пальцем в белом поле.';

  @override
  String get signaturNochmal => 'Заново';

  @override
  String get signaturZurueckZumDokument => 'Назад к документу';

  @override
  String get signaturCodeAnfordern => 'Запросить код по SMS';

  @override
  String get signaturCodeUnterwegs => 'Код отправляется.';

  @override
  String signaturCodeGesendetAn(String nummer) {
    return 'Мы отправили код на $nummer.';
  }

  @override
  String get signaturCodeErneutSenden => 'Отправить код ещё раз';

  @override
  String get signaturJetztUnterschreiben => 'Подписать';

  @override
  String get signaturCodeFalsch => 'Код неверный.';

  @override
  String get signaturCodeAbgelaufen =>
      'Срок действия кода истёк. Запросите новый.';

  @override
  String get signaturZuVieleVersuche =>
      'Слишком много неудачных попыток. Запросите новый код.';

  @override
  String get signaturKeineRufnummer =>
      'Для вашей учётной записи не указан мобильный номер. Без него мы не можем отправить код — обратитесь к председателю.';

  @override
  String get signaturCodeFehlgeschlagen => 'Код не удалось отправить.';

  @override
  String get signaturLeer => 'Сначала поставьте подпись.';

  @override
  String get signaturErfolg => 'Спасибо — ваша подпись получена.';

  @override
  String get signaturFehlgeschlagen =>
      'Не получилось. Пожалуйста, попробуйте ещё раз.';

  @override
  String get signaturSiegelInArbeit =>
      'Печать ещё создаётся. Пожалуйста, попробуйте снова через минуту.';

  @override
  String get signaturWartetZweiteUnterschrift => 'Ожидает второй подписи';

  @override
  String get signaturWartenHinweis =>
      'Вы поставили подпись. Документ будет скреплён печатью, как только его подпишет и второй человек.';

  @override
  String get kontaktNochAktuell => 'Эти данные ещё актуальны?';

  @override
  String get kontaktWarumFragen =>
      'Чтобы вы ничего не пропустили, мы коротко спрашиваем раз в три месяца. Вы получите код из шести цифр.';

  @override
  String kontaktBestaetigtAm(Object datum) {
    return 'подтверждено $datum';
  }

  @override
  String get kontaktFestnetzKeinSms =>
      'Это стационарный номер — SMS туда не дойдёт.';

  @override
  String get kontaktIstAndersGeworden => 'Изменилось';

  @override
  String get themeTitle => 'Оформление';

  @override
  String get themeLight => 'Светлая';

  @override
  String get themeDark => 'Тёмная';

  @override
  String get themeSystem => 'Как на устройстве';

  @override
  String get themeSchedule => 'Автоматически (20:00–06:00)';

  @override
  String get themeScheduleHint =>
      'Тёмная с 20:00 до 6:00, светлая в остальное время.';
}
