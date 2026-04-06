// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'ICD360S e.V - Портал участников';

  @override
  String get memberPortal => 'Портал участников';

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
  String get password => 'Пароль';

  @override
  String get passwordHint => 'Введите пароль';

  @override
  String get confirmPassword => 'Подтвердите пароль';

  @override
  String get confirmPasswordHint => 'Подтвердите пароль';

  @override
  String get newPassword => 'Новый пароль';

  @override
  String get newPasswordHint => 'Введите новый пароль';

  @override
  String get saveCredentials => 'Сохранить данные входа';

  @override
  String get autoLogin => 'Автоматический вход';

  @override
  String get forgotPassword => 'Забыли пароль?';

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
  String get recoveryCode => 'Код восстановления (6 цифр)';

  @override
  String get recoveryCodeHelper =>
      'Запомните этот код для восстановления пароля';

  @override
  String get recoveryCodeHint => 'Введите код восстановления';

  @override
  String get recoveryCodeInvalid => 'Код должен состоять из 6 цифр';

  @override
  String get loginFailed => 'Ошибка входа';

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
  String get tooManyDevices => 'Слишком много устройств';

  @override
  String get maxDevicesMessage =>
      'Вы уже вошли на 3 устройствах.\nВыберите устройство для выхода:';

  @override
  String get unknownDevice => 'Неизвестное устройство';

  @override
  String get unknown => 'Неизвестно';

  @override
  String get logoutError => 'Ошибка выхода';

  @override
  String error(String error) {
    return 'Ошибка: $error';
  }

  @override
  String get cancel => 'Отмена';

  @override
  String get resetPassword => 'Сбросить пароль';

  @override
  String get forgotPasswordTitle => 'Забыли пароль';

  @override
  String get forgotPasswordDescription =>
      'Введите номер участника и код восстановления, созданный при регистрации.';

  @override
  String get passwordResetSuccess =>
      'Пароль успешно сброшен!\n\nТеперь вы можете войти с новым паролем.';

  @override
  String get passwordResetFailed => 'Сброс пароля не удался';

  @override
  String get needHelp => 'Нужна помощь?';

  @override
  String get helpQuestion => 'Проблемы со входом или регистрацией?';

  @override
  String get helpDescription =>
      'Свяжитесь с нами через WhatsApp и опишите, что не работает. Мы ответим как можно скорее!';

  @override
  String get whatsapp => 'WhatsApp';

  @override
  String get emailSubject => 'Запрос через приложение ICD360S';

  @override
  String get whatsappMessage =>
      'Здравствуйте, у меня проблема с приложением ICD360S. ';

  @override
  String get imprint => 'Импрессум';

  @override
  String get privacy => 'Политика конфиденциальности';

  @override
  String get statutes => 'Устав';

  @override
  String get revocation => 'Право отзыва';

  @override
  String get cancellation => 'Отмена';

  @override
  String get allRightsReserved => 'Все права защищены.';

  @override
  String get enterCredentials => 'Введите номер участника и пароль';

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
  String get membership => 'Членство';

  @override
  String get myAppointments => 'Мои встречи';

  @override
  String get appointmentsLoadingReady => 'Загрузка встреч - API готов!';

  @override
  String get priority => 'Приоритет';

  @override
  String get messageLabel => 'Сообщение';

  @override
  String get createdOn => 'Создано';

  @override
  String get handler => 'Обработчик';

  @override
  String get reportProblems => 'Сообщить о проблемах';

  @override
  String get reportProblem => 'Сообщить о проблеме';

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
  String get newTicket => 'Новая заявка';

  @override
  String get noOpenTickets => 'Нет открытых заявок';

  @override
  String get haveQuestionCreateTicket =>
      'Есть вопрос или проблема?\nСоздайте новую заявку.';

  @override
  String get whatIsTheProblem => 'В чем проблема?';

  @override
  String get describeTheProblem => 'Опишите проблему';

  @override
  String get howUrgentIsIt => 'Насколько это срочно?';

  @override
  String get low => 'Низкий';

  @override
  String get medium => 'Средний';

  @override
  String get high => 'Высокий';

  @override
  String get submit => 'Отправить';

  @override
  String get fillSubjectAndMessage => 'Пожалуйста, заполните тему и сообщение';

  @override
  String get ticketCreated => 'Заявка создана';

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
  String get newEmailAddress => 'Новый адрес email';

  @override
  String get currentPassword => 'Текущий пароль';

  @override
  String get saveEmail => 'Сохранить email';

  @override
  String get savePassword => 'Сохранить пароль';

  @override
  String get deviceLoggedOut => 'Устройство отключено';

  @override
  String get passwordChangedSuccessfully => 'Пароль успешно изменен';

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
  String get passwordTooShort => 'Пароль должен содержать не менее 6 символов';

  @override
  String get maxDevicesReached => 'Вы вошли на максимум из 3 устройств.';

  @override
  String loggedInOnDevices(int count) {
    return 'Вы вошли на $count из 3 устройств.';
  }

  @override
  String get noActiveSessions => 'Нет активных сеансов';

  @override
  String get logoutFromDevice => 'Выйти с этого устройства';

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
  String get errorAcceptingCall => 'Ошибка принятия звонка';

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
  String typingIndicator(String name) {
    return '$name печатает...';
  }

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
  String get diagnosticDataTitle => 'Диагностические данные';

  @override
  String get diagnosticDescription =>
      'Хотите отправлять анонимные диагностические данные для улучшения приложения?';

  @override
  String get noThanks => 'Нет, спасибо';

  @override
  String get yesEnable => 'Да, включить';

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
  String get newPasswordMinChars => 'Новый пароль (мин. 6 символов)';

  @override
  String get reasonLabel2 => 'Причина';

  @override
  String get downloadFailed2 => 'Ошибка загрузки';

  @override
  String get downloadTooltip => 'Скачать';

  @override
  String get connectionErrorGeneric => 'Ошибка подключения';

  @override
  String get errorNoInternet => 'Нет подключения к Интернету. Проверьте сеть.';

  @override
  String get errorTimeout => 'Сервер не отвечает. Попробуйте позже.';

  @override
  String get errorServer => 'Ошибка сервера. Попробуйте позже.';

  @override
  String get errorConnection => 'Ошибка соединения. Попробуйте позже.';

  @override
  String get errorUnexpected => 'Произошла непредвиденная ошибка. Попробуйте позже.';

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
  String get bankTransfer => 'Банковский перевод';

  @override
  String get standingOrder => 'Постоянное поручение';

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
  String get memberNumberTooLong =>
      'Номер участника слишком длинный (макс. 20 символов)';

  @override
  String get onlyUppercaseAndNumbers =>
      'Допускаются только заглавные буквы и цифры';

  @override
  String get passwordTooLong => 'Пароль слишком длинный (макс. 100 символов)';

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
  String get diagnosticErrors => 'Отчёты об ошибках для улучшения';

  @override
  String get diagnosticAnonymousStats => 'Анонимная статистика использования';

  @override
  String get diagnosticPerformance => 'Данные о производительности приложения';

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
  String get ipClean => 'IP чистый - не в списке';

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
  String get helpImproveApp => 'Хотите помочь нам улучшить приложение?';

  @override
  String get noPersonalDataCollected =>
      'Личные данные не собираются. Эту настройку можно изменить в любое время.';

  @override
  String logEntries(int count) {
    return '$count записей';
  }

  @override
  String get noLogs => 'Нет логов';

  @override
  String get newLoginDetected => 'Обнаружен новый вход';

  @override
  String get waitingForMember => 'Ожидание участника';

  @override
  String get waitingForStaff => 'Ожидание сотрудника';

  @override
  String get waitingForAuthority => 'Ожидание органа власти';
}
