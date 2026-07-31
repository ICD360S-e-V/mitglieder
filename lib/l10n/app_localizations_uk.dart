// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Ukrainian (`uk`).
class AppLocalizationsUk extends AppLocalizations {
  AppLocalizationsUk([String locale = 'uk']) : super(locale);

  @override
  String get welcomeLoading => 'Завантаження...';

  @override
  String get welcomeAutoLogin => 'Автоматичний вхід...';

  @override
  String get login => 'Увійти';

  @override
  String get register => 'Реєстрація';

  @override
  String get becomeMember => 'Стати учасником';

  @override
  String get memberNumber => 'Номер учасника';

  @override
  String get memberNumberHint => 'Введіть номер учасника';

  @override
  String get confirmPassword => 'Підтвердіть пароль';

  @override
  String get confirmPasswordHint => 'Підтвердіть пароль';

  @override
  String get newPassword => 'Новий пароль';

  @override
  String get newPasswordHint => 'Введіть новий пароль';

  @override
  String get firstName => 'Ім\'я та прізвище';

  @override
  String get firstNameHint => 'Введіть ім\'я та прізвище';

  @override
  String get nameMinLength => 'Ім\'я має містити мінімум 2 символи';

  @override
  String get nameOnlyLetters => 'Дозволені лише літери та дефіс';

  @override
  String get email => 'Електронна пошта';

  @override
  String get emailHint => 'Введіть email';

  @override
  String get emailInvalid => 'Введіть коректний email';

  @override
  String get passwordMinLength => 'Пароль має містити мінімум 6 символів';

  @override
  String get passwordsNotMatch => 'Паролі не збігаються';

  @override
  String get registrationFailed => 'Помилка реєстрації';

  @override
  String connectionError(String error) {
    return 'Помилка з\'єднання: $error';
  }

  @override
  String registrationSuccess(String memberNumber) {
    return 'Реєстрація успішна!\n\nВаш номер учасника: $memberNumber\n\nЗапам\'ятайте цей номер для входу.';
  }

  @override
  String get unknown => 'Невідомо';

  @override
  String error(String error) {
    return 'Помилка: $error';
  }

  @override
  String get cancel => 'Скасувати';

  @override
  String get resetPassword => 'Скинути пароль';

  @override
  String get imprint => 'Імпресум';

  @override
  String get privacy => 'Політика конфіденційності';

  @override
  String get statutes => 'Статут';

  @override
  String get revocation => 'Право відкликання';

  @override
  String get appointments => 'Зустрічі';

  @override
  String get tickets => 'Заявки';

  @override
  String get liveChat => 'Чат';

  @override
  String get notifications => 'Сповіщення';

  @override
  String get myProfile => 'Мій профіль';

  @override
  String get logout => 'Вийти';

  @override
  String get goodMorning => 'Доброго ранку';

  @override
  String get goodDay => 'Добрий день';

  @override
  String get goodEvening => 'Добрий вечір';

  @override
  String get goodNight => 'Надобранiч';

  @override
  String get welcomeToICD => 'Ласкаво просимо до ICD360S e.V!';

  @override
  String get accountCreatedSuccessfully =>
      'Ваш обліковий запис успішно створено.';

  @override
  String get today => 'Сьогодні';

  @override
  String get membershipFeeDue => 'Членський внесок до сплати';

  @override
  String get pleaseTransferAnnualFee => 'Будь ласка, переведіть річний внесок.';

  @override
  String get newBadge => 'Новий';

  @override
  String get close => 'Закрити';

  @override
  String get myAppointments => 'Мої зустрічі';

  @override
  String get priority => 'Пріоритет';

  @override
  String get messageLabel => 'Повідомлення';

  @override
  String get reportProblems => 'Повідомити про проблеми';

  @override
  String get weRespondIn24Hours => 'Ми відповімо вам протягом 24 годин!';

  @override
  String get everythingOk => 'Все гаразд!';

  @override
  String get haveProblemWeHelp => 'Є проблема?\nМи подбаємо про це!';

  @override
  String get myMembership => 'Моє членство';

  @override
  String get managePersonalDataAndFee =>
      'Керування особистими даними та членським внеском';

  @override
  String get myAppointmentsTitle => 'Мої зустрічі';

  @override
  String get appointmentsDescription =>
      'Тут ви можете побачити свої майбутні зустрічі.\nВи можете підтвердити свою участь або відхилити.';

  @override
  String get loadAppointments => 'Завантажити зустрічі';

  @override
  String get myTickets => 'Мої заявки';

  @override
  String get low => 'Низький';

  @override
  String get high => 'Високий';

  @override
  String get submit => 'Надіслати';

  @override
  String get errorCreatingTicket => 'Помилка створення заявки';

  @override
  String get verified => 'Перевірено';

  @override
  String get account => 'Обліковий запис';

  @override
  String get myDevices => 'Мої пристрої';

  @override
  String get changeEmail => 'Змінити email';

  @override
  String get changePassword => 'Змінити пароль';

  @override
  String get saveEmail => 'Зберегти email';

  @override
  String get savePassword => 'Зберегти пароль';

  @override
  String get deviceLoggedOut => 'Пристрій відключено';

  @override
  String get emailChangedSuccessfully => 'Email успішно змінено';

  @override
  String get errorChangingPassword => 'Помилка зміни пароля';

  @override
  String get errorChangingEmail => 'Помилка зміни email';

  @override
  String get validEmailRequired => 'Будь ласка, введіть дійсну адресу email';

  @override
  String get confirmLogoutDevice => 'Вийти з пристрою?';

  @override
  String get confirmLogoutMessage =>
      'Ви хочете вийти з цього пристрою?\n\nВам потрібно буде увійти знову, щоб використовувати цей пристрій.';

  @override
  String get ipAddress => 'IP';

  @override
  String get platform => 'Платформа';

  @override
  String trialWarningUrgentTitle(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days днів',
      few: '$days дні',
      one: '1 день',
    );
    return 'Увага: Залишилось $_temp0 до блокування акаунту!';
  }

  @override
  String get trialWarningTitle => 'Ваш акаунт ще не верифіковано';

  @override
  String get trialWarningDescription =>
      'Будь ласка, заповніть дані в \"Мій профіль\". Через 30 днів акаунт буде автоматично заблоковано.';

  @override
  String trialDaysRemaining(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days днів',
      few: '$days дні',
      one: '1 день',
    );
    return '$_temp0';
  }

  @override
  String get overview => 'Огляд';

  @override
  String get member => 'Член';

  @override
  String get memberManagement => 'Управління членами';

  @override
  String get reportProblemTooltip => 'Повідомити про проблему';

  @override
  String get newAppointmentsTitle => 'Нові зустрічі';

  @override
  String get youHaveNewAppointment => 'У вас нова зустріч.';

  @override
  String youHaveNewAppointments(int count) {
    return 'У вас $count нових зустрічей.';
  }

  @override
  String get appointmentReminderTomorrow => 'Нагадування: Зустріч завтра';

  @override
  String tomorrowAppointment(String title) {
    return 'Завтра: $title';
  }

  @override
  String youHaveTomorrowAppointments(int count) {
    return 'У вас $count зустрічей завтра.';
  }

  @override
  String get appointmentsToday => 'Зустрічі сьогодні';

  @override
  String todayAppointment(String title) {
    return 'Сьогодні: $title';
  }

  @override
  String youHaveTodayAppointments(int count) {
    return 'У вас $count зустрічей сьогодні.';
  }

  @override
  String get paymentReminder => 'Нагадування про оплату';

  @override
  String paymentReminderMessage(int day, String method) {
    return 'Сьогодні $day-е число місяця – будь ласка, завершіть $method.';
  }

  @override
  String get paymentDayLabel => 'День оплати (щомісячне нагадування)';

  @override
  String get updateAvailable => 'Доступне оновлення';

  @override
  String newVersionAvailable(String version) {
    return 'Доступна нова версія: $version';
  }

  @override
  String currentVersionLabel(String version) {
    return 'Поточна версія: $version';
  }

  @override
  String get changes => 'Зміни:';

  @override
  String downloadProgress(String percent) {
    return 'Завантаження: $percent%';
  }

  @override
  String get installationStarting => 'Початок встановлення...';

  @override
  String get appWillRestart => 'Додаток буде перезапущено автоматично.';

  @override
  String get autoUpdateEnableTitle =>
      'Автоматично встановлювати майбутні оновлення';

  @override
  String get autoUpdateEnableHint =>
      'Застосунок сам завантажить і встановить оновлення та ненадовго перезапуститься. Без додаткових запитань.';

  @override
  String autoUpdateInstalling(String version) {
    return 'Версія $version встановлюється у фоновому режимі. Застосунок скоро перезапуститься.';
  }

  @override
  String get later => 'Пізніше';

  @override
  String get updateNow => 'Оновити зараз';

  @override
  String get downloading => 'Завантаження...';

  @override
  String get downloadFailed => 'Не вдалося завантажити. Спробуйте пізніше.';

  @override
  String get searchingForUpdates => 'Пошук оновлень...';

  @override
  String get appUpToDate => 'Додаток оновлено';

  @override
  String get updateCheckError => 'Помилка перевірки оновлень';

  @override
  String get changelog => 'Журнал змін';

  @override
  String get terminConfirmed => 'Зустріч підтверджено';

  @override
  String get terminDeclined => 'Зустріч відхилено';

  @override
  String get terminRescheduleRequested => 'Запитано перенесення';

  @override
  String get statusConfirmed => 'Підтверджено';

  @override
  String get statusDeclined => 'Відхилено';

  @override
  String get statusRescheduling => 'Перенесення';

  @override
  String get statusPending => 'Очікування';

  @override
  String get categoryVorstandssitzung => 'Засідання правління';

  @override
  String get categoryMitgliederversammlung => 'Загальні збори';

  @override
  String get categorySchulung => 'Навчання';

  @override
  String get categorySonstiges => 'Інше';

  @override
  String openCount(int count) {
    return '$count відкритих';
  }

  @override
  String get refresh => 'Оновити';

  @override
  String get filterUpcoming => 'Майбутні';

  @override
  String get filterPast => 'Минулі';

  @override
  String get filterAll => 'Усі';

  @override
  String get noUpcomingAppointments => 'Немає майбутніх зустрічей';

  @override
  String get noPastAppointments => 'Немає минулих зустрічей';

  @override
  String get noAppointmentsAvailable => 'Зустрічей немає';

  @override
  String get appointmentsShownHere => 'Ваші зустрічі відображатимуться тут';

  @override
  String get dateLabel => 'Дата';

  @override
  String get timeLabel => 'Час';

  @override
  String get locationLabel => 'Місце';

  @override
  String get createdByLabel => 'Створив';

  @override
  String get descriptionLabel => 'Опис';

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
    return '$minutes хв';
  }

  @override
  String get confirm => 'Підтвердити';

  @override
  String get decline => 'Відхилити';

  @override
  String get reschedule => 'Перенести';

  @override
  String get requestReschedule => 'Запитати перенесення';

  @override
  String appointmentLabel(String title) {
    return 'Зустріч: $title';
  }

  @override
  String get rescheduleReason => 'Причина перенесення *';

  @override
  String get rescheduleReasonHint => 'Вкажіть причину...';

  @override
  String get pleaseProvideReason => 'Вкажіть причину';

  @override
  String get request => 'Запитати';

  @override
  String get ticketStatusOpen => 'Відкрита';

  @override
  String get ticketStatusInProgress => 'В роботі';

  @override
  String get ticketStatusWaitingMember => 'Очікування учасника';

  @override
  String get ticketStatusWaitingStaff => 'Очікування співробітника';

  @override
  String get ticketStatusWaitingAuthority => 'Очікування відомства';

  @override
  String get ticketStatusDone => 'Завершена';

  @override
  String get ticketPriorityHigh => 'Високий';

  @override
  String get ticketPriorityMedium => 'Середній';

  @override
  String get ticketPriorityLow => 'Низький';

  @override
  String get comments => 'Коментарі';

  @override
  String get documents => 'Документи';

  @override
  String get details => 'Деталі';

  @override
  String get replySent => 'Відповідь надіслано';

  @override
  String get sendError => 'Помилка надсилання';

  @override
  String get uploading => 'Завантаження...';

  @override
  String fileUploaded(String filename) {
    return '$filename завантажено';
  }

  @override
  String get uploadFailed => 'Помилка завантаження';

  @override
  String get openError => 'Помилка відкриття';

  @override
  String get noRepliesYet => 'Ще немає відповідей';

  @override
  String get waitingForSupport => 'Очікування відповіді підтримки';

  @override
  String get writeReply => 'Написати відповідь...';

  @override
  String get attachFile => 'Прикріпити файл';

  @override
  String documentsCount(int count) {
    return 'Документи ($count)';
  }

  @override
  String get upload => 'Завантажити';

  @override
  String get noDocuments => 'Немає документів';

  @override
  String get allowedFormats => 'Дозволені формати: PDF, JPEG, JPG, TXT, ZIP';

  @override
  String get yourMessage => 'Ваше повідомлення:';

  @override
  String get translation => 'Переклад';

  @override
  String get original => 'Оригінал';

  @override
  String get originalText => 'Оригінальний текст';

  @override
  String get autoTranslated => 'Перекладено автоматично';

  @override
  String get originalTapTranslation => 'Оригінал · Натисніть для перекладу';

  @override
  String get translatedTapOriginal => 'Перекладено · Натисніть для оригіналу';

  @override
  String get justNow => 'Щойно';

  @override
  String minutesAgo(int minutes) {
    return '$minutes хв тому';
  }

  @override
  String hoursAgo(int hours) {
    return '$hours год тому';
  }

  @override
  String daysAgo(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'днів',
      one: 'день',
    );
    return '$days $_temp0 тому';
  }

  @override
  String get createdLabel => 'Створено';

  @override
  String get updatedLabel => 'Оновлено';

  @override
  String get handlerLabel => 'Відповідальний';

  @override
  String get doneLabel => 'Завершено';

  @override
  String get newTicketTitle => 'Нова заявка';

  @override
  String get categoryOptional => 'Категорія (необов\'язково)';

  @override
  String get selectCategory => 'Вибрати';

  @override
  String get subjectLabel => 'Тема';

  @override
  String get fillAllFields => 'Заповніть усі поля';

  @override
  String ticketCreatedId(int id) {
    return 'Заявка #$id створена';
  }

  @override
  String get priorityLabel => 'Пріоритет: ';

  @override
  String get supportOffline => 'Підтримка офлайн';

  @override
  String get lastSeenSeconds => 'Активний кілька секунд тому';

  @override
  String lastSeenMinutes(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: 'хвилин',
      one: 'хвилину',
    );
    return 'Активний $minutes $_temp0 тому';
  }

  @override
  String lastSeenHours(int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: 'годин',
      one: 'годину',
    );
    return 'Активний $hours $_temp0 тому';
  }

  @override
  String lastSeenDays(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'днів',
      one: 'день',
    );
    return 'Активний $days $_temp0 тому';
  }

  @override
  String get online => 'Онлайн';

  @override
  String get callSupport => 'Зателефонувати';

  @override
  String get typeMessage => 'Введіть повідомлення...';

  @override
  String get callBusy => 'Підтримка зайнята';

  @override
  String get callRejected => 'Дзвінок відхилено';

  @override
  String get callFailed => 'Дзвінок не вдалося з\'єднати';

  @override
  String get callEnded => 'Дзвінок завершено';

  @override
  String get callSupportBusy => 'Підтримка вже в іншому дзвінку';

  @override
  String get errorStartingChat => 'Помилка запуску чату';

  @override
  String get errorStartingCall => 'Помилка запуску дзвінка';

  @override
  String get errorConnecting => 'Помилка з\'єднання';

  @override
  String get errorDownloading => 'Помилка завантаження';

  @override
  String get errorUploading => 'Помилка відправки файлу';

  @override
  String get errorSending => 'Помилка відправки';

  @override
  String get errorPickingPhotos => 'Помилка вибору фото';

  @override
  String get errorPickingFiles => 'Помилка вибору файлів';

  @override
  String get errorTakingPhoto => 'Помилка зйомки';

  @override
  String get fileNotLoaded => 'Файл не завантажено';

  @override
  String get attachmentIdMissing => 'ID вкладення відсутній';

  @override
  String get camera => 'Камера';

  @override
  String get gallery => 'Галерея';

  @override
  String get file => 'Файл';

  @override
  String get notifNewMessageFrom => 'Нове повідомлення від';

  @override
  String get notifUrgentPrefix => 'ТЕРМІНОВО';

  @override
  String get notifUrgentMessage => 'ТЕРМІНОВЕ ПОВІДОМЛЕННЯ';

  @override
  String get notifIncomingCall => 'Вхідний дзвінок';

  @override
  String get notifCallingYou => 'дзвонить...';

  @override
  String get notifUpdateAvailable => 'Доступне оновлення';

  @override
  String get notifVersionAvailable => 'вже доступна';

  @override
  String get notifConnected => 'Підключено';

  @override
  String get notifDisconnected => 'Відключено';

  @override
  String get notifConnectedBody => 'Ви підключені до сервера.';

  @override
  String get notifDisconnectedBody => 'З\'єднання з сервером втрачено.';

  @override
  String get notifError => 'Помилка';

  @override
  String get retry => 'Спробувати знову';

  @override
  String get save => 'Зберегти';

  @override
  String get accept => 'Прийняти';

  @override
  String get selectFile => 'Вибрати файл';

  @override
  String get dataLoadingText => 'Завантаження даних...';

  @override
  String get dataSavedSuccess => 'Дані успішно збережено';

  @override
  String get errorSaving => 'Помилка збереження';

  @override
  String get errorLoading => 'Помилка завантаження';

  @override
  String savedFilename(String filename) {
    return 'Збережено: $filename';
  }

  @override
  String get logsCopied => 'Логи скопійовано!';

  @override
  String get passwordMinEightChars =>
      'Пароль повинен містити щонайменше 8 символів';

  @override
  String get passwordChangeSuccess => 'Пароль успішно змінено';

  @override
  String get emailChangeError => 'Помилка зміни email';

  @override
  String get acceptDocumentCheckbox => 'Я прочитав і приймаю документ.';

  @override
  String loadingErrorGeneric(String details) {
    return 'Помилка завантаження: $details';
  }

  @override
  String get incomingCallTitle => 'Вхідний дзвінок';

  @override
  String ringingFor(int seconds) {
    return 'Дзвонить $secondsс';
  }

  @override
  String get rejectCall => 'Відхилити';

  @override
  String get acceptCall => 'Прийняти';

  @override
  String get unmute => 'Увімкнути звук';

  @override
  String get mute => 'Вимкнути звук';

  @override
  String get hangUp => 'Завершити';

  @override
  String get calling => 'Виклик...';

  @override
  String autoRejectIn(int seconds) {
    return 'Автовідхилення через $seconds секунд';
  }

  @override
  String get speakerOn => 'Динамік';

  @override
  String get speakerOff => 'Навушник';

  @override
  String get micMuted => 'Вимкнено';

  @override
  String get micOn => 'Мікрофон';

  @override
  String get connectionExcellent => 'Відмінне';

  @override
  String get connectionGood => 'Добре';

  @override
  String get connectionWeak => 'Слабке';

  @override
  String get connectionLost => 'Відключено';

  @override
  String get personalData => 'Особисті дані';

  @override
  String get personalDataSubtitle => 'Ім\'я, прізвище, адреса';

  @override
  String get membershipFee => 'Членський внесок';

  @override
  String annualFeeYear(String year) {
    return 'Річний внесок $year';
  }

  @override
  String get amount => 'Сума:';

  @override
  String get dueBy => 'Термін:';

  @override
  String get paid => 'Сплачено';

  @override
  String get versionHistory => 'Історія версій';

  @override
  String lastUpdated(String date) {
    return 'Останнє оновлення: $date';
  }

  @override
  String get noVersionHistory => 'Історія версій недоступна';

  @override
  String get failedLoadChangelog => 'Не вдалося завантажити журнал змін';

  @override
  String get callMember => 'Зателефонувати учаснику';

  @override
  String get closeConversation => 'Закрити розмову';

  @override
  String get chatOffline => 'Не в мережі';

  @override
  String get attachFiles => 'Прикріпити файли (макс. 10, 50МБ)';

  @override
  String get conversationClosed => 'Ця розмова була закрита';

  @override
  String get noMessages => 'Немає повідомлень';

  @override
  String get goBack => 'Назад';

  @override
  String get goForward => 'Вперед';

  @override
  String get homePage => 'Головна';

  @override
  String get firstNameLabel => 'Ім\'я';

  @override
  String get lastNameLabel => 'Прізвище';

  @override
  String get streetLabel => 'Вулиця';

  @override
  String get houseNumberLabel => '№';

  @override
  String get postalCodeLabel => 'Поштовий індекс';

  @override
  String get cityLabel => 'Місто';

  @override
  String get phoneMobileLabel => 'Телефон (Мобільний)';

  @override
  String get phoneLandlineLabel => 'Телефон (Стаціонарний)';

  @override
  String get newEmailLabel => 'Нова адреса електронної пошти';

  @override
  String get currentPasswordLabel => 'Поточний пароль';

  @override
  String get newPasswordLabel => 'Новий пароль';

  @override
  String get confirmPasswordLabel => 'Підтвердити пароль';

  @override
  String get emailChangedSuccess => 'Email успішно змінено';

  @override
  String get reasonLabel2 => 'Причина';

  @override
  String get downloadFailed2 => 'Завантаження не вдалося';

  @override
  String get downloadTooltip => 'Завантажити';

  @override
  String get copyLogs => 'Копіювати логи';

  @override
  String get deleteLogs => 'Видалити логи';

  @override
  String get autoScrollOn => 'Автопрокрутка УВІМК';

  @override
  String get autoScrollOff => 'Автопрокрутка ВИМК';

  @override
  String get unknownValue => 'Невідомо';

  @override
  String get payment => 'Оплата';

  @override
  String get warningType_ermahnung => 'Попередження';

  @override
  String get warningType_abmahnung => 'Догана';

  @override
  String get warningType_letzte => 'Останнє попередження';

  @override
  String warningsTotal(int count) {
    return 'Всього: $count';
  }

  @override
  String warningsErmahnung(int count) {
    return 'Попередження: $count';
  }

  @override
  String warningsAbmahnung(int count) {
    return 'Догани: $count';
  }

  @override
  String warningsLetzte(int count) {
    return 'Останні: $count';
  }

  @override
  String get noWarnings => 'Немає попереджень';

  @override
  String get noWarningsDescription => 'Наразі у вас немає попереджень.';

  @override
  String createdBy(String name) {
    return 'Створив: $name';
  }

  @override
  String get monthJan => 'Sic';

  @override
  String get monthFeb => 'Lut';

  @override
  String get monthMar => 'Ber';

  @override
  String get monthApr => 'Kvi';

  @override
  String get monthMay => 'Tra';

  @override
  String get monthJun => 'Cer';

  @override
  String get monthJul => 'Lyp';

  @override
  String get monthAug => 'Ser';

  @override
  String get monthSep => 'Ver';

  @override
  String get monthOct => 'Zov';

  @override
  String get monthNov => 'Lys';

  @override
  String get monthDec => 'Gru';

  @override
  String get stufe1_name => 'Особисті дані';

  @override
  String get stufe2_name => 'Тип членства';

  @override
  String get stufe3_name => 'Фінансове становище';

  @override
  String get stufe4_name => 'Спосіб оплати';

  @override
  String get stufe5_name => 'Початок членства';

  @override
  String get stufe6_name => 'Статут';

  @override
  String get stufe7_name => 'Політика конфіденційності';

  @override
  String get stufe8_name => 'Право на відкликання';

  @override
  String get memberType_ordentlich => 'Дійсний член';

  @override
  String get memberType_foerder => 'Член-прихильник';

  @override
  String get memberType_ehren => 'Почесний член';

  @override
  String get memberDesc_ordentlich =>
      'Активний член з правом голосу. Бере участь у послугах асоціації (пошта, хмара, бюрократична підтримка).';

  @override
  String get memberDesc_foerder =>
      'Підтримує асоціацію внесками. Може бути присутнім на загальних зборах з дорадчим голосом, без права голосу або обрання до правління.';

  @override
  String get memberDesc_ehren =>
      'Має права дійсного члена без обов\'язку сплати членських внесків. Призначається загальними зборами або правлінням.';

  @override
  String get payMethod_ueberweisung => 'Банківський переказ';

  @override
  String get payMethod_dauerauftrag => 'Постійне доручення';

  @override
  String get verifyStatus_geprueft => 'Перевірено';

  @override
  String get verifyStatus_ausgefuellt => 'Заповнено';

  @override
  String get verifyStatus_abgelehnt => 'Відхилено';

  @override
  String get verifyStatus_offen => 'Відкрито';

  @override
  String get fillRequiredFields =>
      'Будь ласка, заповніть усі обов\'язкові поля.';

  @override
  String get personalDataSaved => 'Особисті дані збережено';

  @override
  String get selectMemberType => 'Оберіть тип членства.';

  @override
  String get memberTypeSaved => 'Тип членства збережено';

  @override
  String get selectOption => 'Оберіть варіант.';

  @override
  String get financialSaved => 'Фінансове становище збережено';

  @override
  String get selectPaymentMethod => 'Оберіть спосіб оплати.';

  @override
  String get paymentDataSaved => 'Платіжні дані збережено';

  @override
  String get selectDate => 'Оберіть дату.';

  @override
  String get membershipStartSaved => 'Початок членства збережено';

  @override
  String get fileTooLarge => 'Файл занадто великий (макс. 10 МБ).';

  @override
  String get leistungsbescheidUploaded =>
      'Довідку про виплати успішно завантажено';

  @override
  String get verificationProgress => 'Прогрес верифікації';

  @override
  String get notApplicable => 'Не застосовується';

  @override
  String get socialBenefitsExempt =>
      'Спосіб оплати не потрібен для отримувачів соціальних виплат.';

  @override
  String get locked => 'Заблоковано';

  @override
  String completePreviousStep(int step) {
    return 'Спочатку завершіть крок $step.';
  }

  @override
  String rejectedNote(String note) {
    return 'Відхилено: $note';
  }

  @override
  String get waitingForReview => 'Очікує розгляду правлінням.';

  @override
  String get stepApproved => 'Цей крок перевірено та затверджено.';

  @override
  String get changesViaChat => 'Зміни можливі лише через чат.';

  @override
  String get firstNameRequired => 'Ім\'я *';

  @override
  String get lastNameRequired => 'Прізвище *';

  @override
  String get birthDateLabel => 'Дата народження *';

  @override
  String get streetRequired => 'Вулиця *';

  @override
  String get houseNumberRequired => '№ *';

  @override
  String get cityRequired => 'Місто *';

  @override
  String get phoneRequired => 'Номер телефону *';

  @override
  String get phonePurpose =>
      'Призначення: Зв\'язок, коли недоступний через додаток';

  @override
  String get selectMemberTypePrompt => 'Оберіть бажаний тип членства:';

  @override
  String get financialExplanation =>
      'Щоб перевірити, чи маєте ви право на зниження внеску, нам потрібна наступна інформація. Вона буде використана виключно для визначення вашого членського внеску.';

  @override
  String get socialBenefitsQuestion =>
      'Чи отримуєте ви зараз соціальні виплати?';

  @override
  String get optionBuergergeld => 'Так, громадянська допомога (Job Center)';

  @override
  String get optionSozialamt => 'Так, соціальна допомога (Соціальна служба)';

  @override
  String get optionNoBenefits => 'Ні, я не отримую соціальних виплат';

  @override
  String get feeExempt => 'Ваш щомісячний внесок: 0,00 €/місяць';

  @override
  String get uploadLeistungsbescheid => 'Завантажити довідку про виплати';

  @override
  String get uploadLeistungsbescheidHint =>
      'Завантажте актуальну довідку про виплати протягом 14 днів для підтвердження звільнення від внеску.';

  @override
  String get allowedFormatsUpload =>
      'Дозволені формати: PDF, JPG, PNG (макс. 10 МБ)';

  @override
  String get feeRegular => 'Ваш щомісячний внесок: 25,00 €/місяць';

  @override
  String paymentDayReminder(int day) {
    return 'Вам нагадуватиметься $day-го числа кожного місяця.';
  }

  @override
  String get membershipStartPrompt =>
      'Оберіть, коли має розпочатися ваше членство.';

  @override
  String get optionAfterVerification => 'Після завершення верифікації';

  @override
  String get optionAfterVerificationDesc =>
      'Членство починається з дня затвердження правлінням.';

  @override
  String get optionRetroFoundation =>
      'Ретроактивно до дати заснування (01.08.2025)';

  @override
  String get optionRetroFoundationDesc =>
      'Ви стаєте ретроактивним членом з моменту заснування асоціації.';

  @override
  String get optionRetroCustom => 'Ретроактивно до іншої дати';

  @override
  String get optionRetroCustomDesc =>
      'Оберіть дату між 01.08.2025 та сьогоднішнім днем.';

  @override
  String get selectDateLabel => 'Оберіть дату';

  @override
  String get selectDateHint => 'Оберіть дату...';

  @override
  String get dateNotBefore => 'Не раніше 01.08.2025 (дата заснування)';

  @override
  String get feeExemptRetro =>
      'Звільнення від внеску: 0,00 € ретроактивно.\nЛише дата членства встановлюється ретроактивно.';

  @override
  String get retroactiveFees => 'Ретроактивні внески';

  @override
  String retroFeeCalculation(
      String from, String to, String months, String total) {
    return 'Період: $from – $to\nМісяці: $months\nВнесок: $months × 25,00 € = $total €';
  }

  @override
  String get pleaseReadSatzung => 'Будь ласка, прочитайте статут асоціації.';

  @override
  String get pleaseReadDatenschutz =>
      'Будь ласка, прочитайте політику конфіденційності.';

  @override
  String get pleaseReadWiderruf =>
      'Будь ласка, прочитайте право на відкликання.';

  @override
  String get acceptedAtRegistration => 'Прийнято при реєстрації';

  @override
  String get confirmedByBoard => 'Буде підтверджено після розгляду правлінням.';

  @override
  String get docSatzung => 'Статут';

  @override
  String get docDatenschutz => 'Політика конфіденційності';

  @override
  String get docWiderruf => 'Право на відкликання';

  @override
  String acceptedAtRegCount(int count) {
    return 'Прийнято при реєстрації ($count/3)';
  }

  @override
  String acceptedOn(String date) {
    return 'Прийнято $date';
  }

  @override
  String get notAccepted => 'Не прийнято';

  @override
  String get statusAccepted => 'Прийнято';

  @override
  String get nameTooLong => 'Ім\'я занадто довге (макс. 100 символів)';

  @override
  String get emailTooLong => 'Email занадто довгий (макс. 255 символів)';

  @override
  String get legalAcknowledgePrefix => 'Я ознайомився/лася з ';

  @override
  String get legalAcknowledgeSuffix => '.';

  @override
  String get legalStatutesSuffix =>
      ' ICD360S e.V. та визнаю їх обов\'язковими.';

  @override
  String get legalPleaseReadFirst => '(будь ласка, спочатку прочитайте)';

  @override
  String get statusActive => 'Активний';

  @override
  String get statusSuspended => 'Заблоковано';

  @override
  String get statusNew => 'Новий';

  @override
  String get statusCancelled => 'Скасовано';

  @override
  String get statusDeleted => 'Видалено';

  @override
  String get roleMitglied => 'Учасник';

  @override
  String get roleVorsitzer => 'Голова';

  @override
  String get roleStellvertreter => 'Заступник';

  @override
  String get roleSchatzmeister => 'Скарбник';

  @override
  String get roleSchriftfuehrer => 'Секретар';

  @override
  String get roleBeisitzer => 'Засідатель';

  @override
  String get roleKassierer => 'Касир';

  @override
  String get roleKassenpruefer => 'Ревізор';

  @override
  String get roleEhrenamtlich => 'Волонтер';

  @override
  String get roleMitgliedergruender => 'Засновник';

  @override
  String get roleEhrenmitglied => 'Почесний член';

  @override
  String get roleFoerdermitglied => 'Член-спонсор';

  @override
  String get memberTypeNotSet => 'Ще не встановлено';

  @override
  String get payMethodSepa => 'Пряме дебетування SEPA';

  @override
  String get labelStatus => 'Статус';

  @override
  String get labelMemberNumber => 'Номер учасника';

  @override
  String get labelRole => 'Роль';

  @override
  String get labelMemberType => 'Тип членства';

  @override
  String get labelPaymentMethod => 'Спосіб оплати';

  @override
  String get labelRegisteredOn => 'Зареєстровано';

  @override
  String get labelLastLogin => 'Останній вхід';

  @override
  String get labelMemberSince => 'Учасник з';

  @override
  String get neverLoggedIn => 'Ніколи';

  @override
  String get notActivatedYet => 'Ще не активовано';

  @override
  String get tabVerification => 'Верифікація';

  @override
  String get tabWarnings => 'Попередження';

  @override
  String get tabDocuments => 'Документи';

  @override
  String get tabMembership => 'Членство';

  @override
  String get pleaseEnterFirstName => 'Введіть ім\'я';

  @override
  String get pleaseEnterLastName => 'Введіть прізвище';

  @override
  String get noFileDataReceived => 'Дані не отримано';

  @override
  String get openFile => 'Відкрити';

  @override
  String get noMicrophoneError =>
      'Мікрофон не знайдено. Підключіть мікрофон і спробуйте ще раз.';

  @override
  String get startConversation => 'Розпочніть розмову!';

  @override
  String get staffWillReply => 'Співробітник незабаром відповість вам.';

  @override
  String get inCall => 'У дзвінку...';

  @override
  String get registration => 'Реєстрація';

  @override
  String get deactivation => 'Деактивація';

  @override
  String get deactivatedOn => 'Деактивовано';

  @override
  String get accountAutoSuspend =>
      'Облікові записи, не підтверджені протягом 30 днів, будуть автоматично заблоковані.';

  @override
  String get documentsProvidedByBoard => 'Документи надаються правлінням.';

  @override
  String get noDocumentsAvailable => 'Документів немає';

  @override
  String get noDocumentsDescription => 'Для вас ще не надано документів.';

  @override
  String uploadedBy(String name) {
    return 'Завантажив: $name';
  }

  @override
  String stepsCompleted(int completed, int total) {
    return '$completed/$total кроків виконано';
  }

  @override
  String dayOfMonth(int day) {
    return '$day-е число місяця';
  }

  @override
  String changeField(String field) {
    return 'Змінити $field';
  }

  @override
  String openDocument(String name) {
    return 'Відкрити $name';
  }

  @override
  String logEntries(int count) {
    return '$count записів';
  }

  @override
  String get noLogs => 'Немає логів';

  @override
  String get newLoginDetected => 'Виявлено новий вхід';

  @override
  String get errorNoInternet =>
      'Немає з\'єднання з Інтернетом. Перевірте мережу.';

  @override
  String get errorTimeout => 'Сервер не відповідає. Спробуйте пізніше.';

  @override
  String get errorServer => 'Помилка сервера. Спробуйте пізніше.';

  @override
  String get errorConnection => 'Помилка з\'єднання. Спробуйте пізніше.';

  @override
  String get errorUnexpected =>
      'Сталася неочікувана помилка. Спробуйте пізніше.';

  @override
  String get securityBannerTlsInterception =>
      'Ваша мережа перехоплює захищені з\'єднання. Змініть мережу або вимкніть VPN/антивірус.';

  @override
  String get securityBannerDnsFailure =>
      'Виявлено проблему з DNS. Перевірте з\'єднання або спробуйте іншу мережу.';

  @override
  String get securityBannerSlowNetwork => 'Повільне з\'єднання.';

  @override
  String get securityPermissionDialogTitle => 'Виявлено можливу мережеву атаку';

  @override
  String get securityPermissionDialogBody =>
      'Щось у вашій мережі може перехоплювати з\'єднання. Щоб ідентифікувати мережу та захистити вас, потрібен дозвіл на читання назви Wi-Fi. Без відстеження місцезнаходження.';

  @override
  String get securityPermissionDialogAllow => 'Дозволити';

  @override
  String get securityPermissionDialogDeny => 'Не зараз';

  @override
  String get callErrorMicPermissionDenied =>
      'Доступ до мікрофона заблоковано. Увімкніть його в Windows Settings → Privacy → Microphone (або в налаштуваннях конфіденційності вашої системи) і спробуйте знову.';

  @override
  String get callErrorMicNotFound =>
      'Мікрофон не знайдено. Під\'єднайте гарнітуру або мікрофон і спробуйте знову.';

  @override
  String get claudiuWelcomeMorning => 'Доброго ранку';

  @override
  String get claudiuWelcomeDay => 'Вітаю';

  @override
  String get claudiuWelcomeEvening => 'Доброго вечора';

  @override
  String get claudiuWelcomeNight => 'Доброго вечора';

  @override
  String get claudiuWelcomeVisitor => 'дорогий відвідувачу';

  @override
  String get claudiuWelcomeAsk => 'Чим я можу допомогти?';

  @override
  String get claudiuWelcomeBecomeMember => 'Я хочу стати членом';

  @override
  String get claudiuWelcomeLogin => 'Я вже член і хочу увійти';

  @override
  String get claudiuWelcomeProblem => 'У мене проблема з застосунком';

  @override
  String get claudiuWelcomeEmergency => 'Терміново — зателефонуйте нам';

  @override
  String get claudiuWelcomeMascotName => 'Клаудіу';

  @override
  String get claudiuWelcomeEmergencyIntro =>
      'Перш ніж телефонувати — наш робочий графік:';

  @override
  String get claudiuWelcomeScheduleOffice => 'В офісі';

  @override
  String get claudiuWelcomeScheduleField => 'На виїзді з клієнтами';

  @override
  String get claudiuWelcomeOutsideHoursNote =>
      'Поза цим часом ми приймаємо лише термінові звернення. Можна також надіслати SMS — ми звʼяжемося з вами.';

  @override
  String get claudiuWelcomeCallNow => 'Зателефонувати зараз';

  @override
  String get claudiuWelcomeSendSms => 'Надіслати SMS';

  @override
  String get claudiuWelcomeSmsBody =>
      'Терміново, ICD360S e.V. — звʼяжіться зі мною якнайшвидше.';

  @override
  String get claudiuWelcomeCloseButton => 'Закрити';

  @override
  String get claudiuLoginWelcome => 'З поверненням, дорогий члене!';

  @override
  String get claudiuLoginAsk => 'Скажи мені свій членський номер.';

  @override
  String get claudiuLoginProgress => 'Майже… продовжуй вводити.';

  @override
  String get claudiuLoginReady => 'Чудово! Натисни кнопку нижче.';

  @override
  String get claudiuLoginLoading => 'Перевіряю особу… 🔍';

  @override
  String get claudiuLoginFoundPlain => 'Знайшов! Зараз увійдеш…';

  @override
  String claudiuLoginFoundNamed(String name) {
    return 'Знайшов, $name! Зараз увійдеш…';
  }

  @override
  String get claudiuLoginError =>
      'Хм, такого номера не знаходжу. Перевір, чи правильно ввів?';

  @override
  String get claudiuLoginForgotHeader => 'Забув членський номер?';

  @override
  String get claudiuLoginNoSms =>
      'Ми не надсилаємо номер електронною поштою або SMS.';

  @override
  String get claudiuLoginOnlyWay =>
      'Єдиний шлях: особиста зустріч в офісі асоціації, з посвідченням.';

  @override
  String get claudiuLoginContactUs => 'Зателефонуй, щоб записатися:';

  @override
  String get claudiuDiagnosticGreeting => 'Перш ніж увійти, одне запитання';

  @override
  String get claudiuDiagnosticAsk =>
      'Чи можу я надсилати анонімні звіти, щоб розробники могли покращити застосунок?';

  @override
  String get claudiuDiagnosticYes => 'Так, я хочу допомогти';

  @override
  String get claudiuDiagnosticNo => 'Ні, я просто переглядаю';

  @override
  String get claudiuDiagnosticTellMore => 'Розкажи більше';

  @override
  String get claudiuDiagnosticSendsHeader => '📤 Що ми НАДСИЛАЄМО (анонімно):';

  @override
  String get claudiuDiagnosticSends1 =>
      'Анонімний код пристрою (НЕ номер члена)';

  @override
  String get claudiuDiagnosticSends2 => 'Ваша роль (член / правління)';

  @override
  String get claudiuDiagnosticSends3 =>
      'Система (Linux / Android / iOS / Windows)';

  @override
  String get claudiuDiagnosticSends4 => 'Вибрана мова';

  @override
  String get claudiuDiagnosticSends5 => 'Рівень і стан акумулятора';

  @override
  String get claudiuDiagnosticSends6 => 'Поточний екран';

  @override
  String get claudiuDiagnosticSends7 => 'Тривалість сесії (секунди)';

  @override
  String get claudiuDiagnosticSends8 => 'Помилки, якщо є (останні 10)';

  @override
  String get claudiuDiagnosticSends9 => 'Навігація (останні 20 екранів)';

  @override
  String get claudiuDiagnosticNeverHeader => '🛡️ Що ми НІКОЛИ не надсилаємо:';

  @override
  String get claudiuDiagnosticNever1 => 'Ваше справжнє імʼя';

  @override
  String get claudiuDiagnosticNever2 => 'Електронна адреса';

  @override
  String get claudiuDiagnosticNever3 => 'Номер телефону';

  @override
  String get claudiuDiagnosticNever4 => 'Пароль';

  @override
  String get claudiuDiagnosticNever5 => 'Вміст повідомлень чату';

  @override
  String get claudiuDiagnosticNever6 => 'Вміст тикетів';

  @override
  String get claudiuDiagnosticNever7 => 'Документи або вкладення';

  @override
  String get claudiuDiagnosticTechHeader => '📡 Технічні деталі:';

  @override
  String get claudiuDiagnosticTech1 => 'Надсилається кожні 2 хвилини';

  @override
  String get claudiuDiagnosticTech2 => 'TLS-шифрування, фіксований сертифікат';

  @override
  String get claudiuDiagnosticTech3 => 'Можна вимкнути в налаштуваннях';

  @override
  String get claudiuProblemHelpTitle => 'Чим я можу допомогти?';

  @override
  String get claudiuProblemHelpGreeting => 'Що сталося?';

  @override
  String get claudiuProblemHelpAsk => 'Як тобі зручно розповісти?';

  @override
  String get claudiuProblemHelpWriteTitle => 'Написати звіт';

  @override
  String get claudiuProblemHelpWriteBody =>
      'З покроковими деталями. Команда отримає текст і розгляне пізніше.';

  @override
  String get claudiuProblemHelpChatTitle => 'Поговорімо зараз';

  @override
  String get claudiuProblemHelpChatBody =>
      'Анонімний чат з оператором. Відповідь у режимі реального часу, якщо хтось онлайн.';

  @override
  String get claudiuProblemHelpAltCallHeader => 'Або, якщо терміново:';

  @override
  String get claudiuProblemHelpAltCallLabel => 'Зателефонувати';

  @override
  String get claudiuAnonymousChatTitle => 'Анонімний чат';

  @override
  String get claudiuAnonymousChatGreeting => 'Привіт!';

  @override
  String get claudiuAnonymousChatWelcome =>
      'Я слухаю. Пиши що завгодно — імʼя не потрібне. Відповім, щойно буду на звʼязку.';

  @override
  String get claudiuAnonymousChatHint => 'Написати повідомлення…';

  @override
  String get claudiuAnonymousChatWaitingOperator =>
      'Чекаємо на відповідь оператора…';

  @override
  String get claudiuVorsitzerConnectedTitle => 'Привіт!';

  @override
  String get claudiuVorsitzerConnectedBody =>
      'Дякуємо, що написав — ти на звʼязку з Vorsitzer. Розкажи, з чим ми можемо допомогти щодо твоєї заявки на членство.';

  @override
  String get claudiuVorsitzerConnectedSender => 'Vorsitzer';

  @override
  String get claudiuQuickReplyValidationTime =>
      'Скільки часу триває перевірка?';

  @override
  String get claudiuQuickReplyDocuments => 'Які документи мені потрібні?';

  @override
  String get claudiuQuickReplyStepProblem => 'Я застряг на одному кроці';

  @override
  String get claudiuQuickReplyHuman => 'Можна зараз з кимось поговорити?';

  @override
  String get claudiuAnonymousChatConnecting => 'Підключаюсь…';

  @override
  String get claudiuAnonymousChatConnectionFailed =>
      'Не вдалося відкрити чат. Спробуй ще раз або зателефонуй.';

  @override
  String get claudiuAnonymousChatRetry => 'Спробувати ще раз';

  @override
  String get claudiuAnonymousChatOnline => 'Підключено';

  @override
  String get claudiuAnonymousChatOffline => 'Перепідключення…';

  @override
  String get claudiuAnonymousChatAdminTyping => 'Оператор пише…';

  @override
  String get claudiuProblemReportTitle => 'Повідомити про проблему';

  @override
  String get claudiuProblemReportGreeting => 'Що сталося?';

  @override
  String get claudiuProblemReportAsk =>
      'Розкажи детально, і я передам звіт команді.';

  @override
  String get claudiuProblemReportIncludeHeader => 'Будь ласка, вкажи:';

  @override
  String get claudiuProblemReportIncludeBullets1 =>
      'Що ти робив, коли зʼявилася проблема';

  @override
  String get claudiuProblemReportIncludeBullets2 =>
      'Яке повідомлення про помилку зʼявилося';

  @override
  String get claudiuProblemReportIncludeBullets3 => 'На якому екрані ти був';

  @override
  String get claudiuProblemReportIncludeBullets4 =>
      'Застосунок крашиться? Закривається? Показує білий екран?';

  @override
  String get claudiuProblemReportIncludeBullets5 =>
      'Це повторюється чи разово?';

  @override
  String get claudiuProblemReportDescriptionLabel => 'Твій опис';

  @override
  String get claudiuProblemReportDescriptionHint =>
      'Напр.: При відкритті чату зʼявляється «Connection error» і застосунок не відповідає…';

  @override
  String claudiuProblemReportTooShort(int count) {
    return 'Трохи більше деталей, будь ласка (мінімум $count символів)';
  }

  @override
  String get claudiuProblemReportSubmit => 'Надіслати звіт';

  @override
  String get claudiuProblemReportSubmitting => 'Надсилання…';

  @override
  String get claudiuProblemReportSentTitle => 'Дякую!';

  @override
  String get claudiuProblemReportSentBody =>
      'Звіт надіслано. Наша команда розгляне його якомога швидше.';

  @override
  String get claudiuProblemReportSentClose => 'Зрозуміло';

  @override
  String get claudiuProblemReportSendFailed =>
      'Не вдалося надіслати звіт. Зателефонуй нам у разі терміновості.';

  @override
  String get claudiuProblemReportAlt => 'Або, якщо терміново:';

  @override
  String get claudiuProblemReportCallLabel => 'Зателефонувати';

  @override
  String claudiuApprovalGreeting(String name) {
    return 'Привіт, $name! 👋';
  }

  @override
  String get claudiuApprovalGreetingNoName => 'Привіт! 👋';

  @override
  String get claudiuApprovalGladToSeeYou => 'Радий, що ти прийшов!';

  @override
  String get claudiuApprovalCheckingForSafety =>
      'Для твоєї безпеки Vorsitzer перевіряє твій запит на вхід. 🛡️';

  @override
  String get claudiuApprovalMonthlyExplain =>
      '💡 Ми робимо це раз на 30 днів, щоб переконатися, що це справді ти. Це як перевірка безпеки — максимум 5 хвилин.';

  @override
  String get claudiuApprovalSuccess =>
      'Готово! 🎉 Vorsitzer тебе впізнав. Зараз увійдеш…';

  @override
  String get claudiuApprovalDenied => 'Хм, Vorsitzer відхилив твій запит. 😔';

  @override
  String get claudiuApprovalDeniedHelp =>
      'Якщо думаєш, що це помилка, зателефонуй нам, і ми розберемося.';

  @override
  String get claudiuApprovalExpired =>
      'Минуло 5 хвилин, а відповіді від Vorsitzer не було.';

  @override
  String get claudiuApprovalExpiredHelp =>
      'Зателефонуй і ми зможемо схвалити твій запит на місці. 📞';

  @override
  String get claudiuApprovalCallUs => 'Зателефонувати';

  @override
  String get claudiuApprovalTryAgain => 'Спробувати ще раз';

  @override
  String get claudiuApprovalCancel => 'Скасувати';

  @override
  String get claudiuApprovalClose => 'Закрити';

  @override
  String get wizardIntroBubble1 =>
      'Привіт, гостю! 👋 Дякую, що хочеш стати частиною нашої родини.';

  @override
  String get wizardIntroBubble2 =>
      'Мене звати Клаудіу. Навесні 2025 року в мене було чітке бачення: створити асоціацію, яка допомагає людям у потребі — добровільно, від серця, без зайвої бюрократії. ❤️';

  @override
  String get wizardIntroBubble3 =>
      'Я почав говорити з клієнтами, яких відвідував. Розповів їм свою мрію. І кожен сказав: «Так, давай!» У липні 2025 ми зустрілися — 6 рішучих людей. Вирішили заснувати **ICD360S e.V.** у Ной-Ульмі. 📍';

  @override
  String get wizardIntroBubble4 =>
      '**1 серпня 2025 року** асоціація офіційно з\'явилася — у Реєстрі асоціацій. Найкрасивіший подарунок для мене. 🎂';

  @override
  String get wizardIntroBubble5 =>
      'Що ми робимо? Допомагаємо біженцям, людям з інвалідністю, економічно вразливим, **дітям і молоді** — з адміністративними питаннями, вивченням німецької, житлом, покупками, соціальними виплатами. Наш Vorstand переважно складається з людей з інвалідністю — так рішення приймаються з реального життєвого досвіду. 🤝';

  @override
  String get wizardIntroBubble6 =>
      'Тепер твоя черга. Запишемо тебе — займе близько 5 хвилин. Йдемо крок за кроком, я тебе не залишу. ✨';

  @override
  String get wizardIntroStart => 'Почнімо';

  @override
  String get wizardBack => 'Назад';

  @override
  String get wizardNext => 'Далі';

  @override
  String wizardStepLabel(int step, int total, String title) {
    return 'Крок $step з $total · $title';
  }

  @override
  String get wizardErrRequired => 'Це поле обовʼязкове';

  @override
  String wizardErrTooShort(int count) {
    return 'Занадто коротко (мінімум $count символів)';
  }

  @override
  String get wizardErrOnlyLetters => 'Лише букви, пробіли, дефіси та апострофи';

  @override
  String get wizardErrSaveFailed =>
      'Не вдалося зберегти. Перевір зʼєднання і спробуй ще раз.';

  @override
  String get wizardStufe1aTitle => 'Особа';

  @override
  String get wizardStufe1aPrompt =>
      'Знайомимося офіційно. Напиши своє імʼя точно так, як у Personalausweis, Reisepass або Aufenthaltstitel — щоб збігалося з документами.';

  @override
  String get wizardStufe1aVornameLabel => 'Vornamen (імена)';

  @override
  String get wizardStufe1aVornameHelper =>
      'Усі імена точно як у документі. Через пробіл або дефіс (наприклад, Hans-Peter, Maria Anna).';

  @override
  String get wizardStufe1aNachnameLabel => 'Familienname (прізвище)';

  @override
  String get wizardStufe1aNachnameHelper => 'Твоє теперішнє прізвище.';

  @override
  String get wizardStufe1aGeburtsnameLabel =>
      'Geburtsname (прізвище при народженні) — необовʼязково';

  @override
  String get wizardStufe1aGeburtsnameHelper =>
      'Лише якщо відрізняється від Familienname — наприклад, до шлюбу.';

  @override
  String get wizardStufe1bTitle => 'День народження';

  @override
  String get wizardStufe1bPrompt =>
      'Хочемо святкувати твій день народження разом! 🎂 І нам важливо знати, що тобі щонайменше 16 — так пише наш статут.';

  @override
  String get wizardStufe1bGeburtsdatumLabel => 'Дата народження';

  @override
  String get wizardStufe1bGeburtsdatumHelper => 'Натисни, щоб вибрати дату';

  @override
  String get wizardStufe1bGeburtsortLabel => 'Місце народження';

  @override
  String get wizardStufe1bGeburtsortHelper =>
      'Місто / населений пункт, де ти народився.';

  @override
  String get wizardAgeGatePrompt => 'Мені шкода… 😔';

  @override
  String wizardAgeGateBody1(int age, int years) {
    return 'Наш статут каже, що для членства потрібно бути щонайменше 16. Тобі $age — сподіваюся побачити тебе через $years років! 🌱';
  }

  @override
  String get wizardAgeGateBody2 =>
      'Якщо хочеш іноді допомагати як волонтер (будь-який вік, зі згодою батьків), зателефонуй — ми любимо підтримувати молодь, яка хоче змінювати світ.';

  @override
  String get wizardAgeGateBackHome => 'Назад на головну';

  @override
  String get wizardErrInvalidPhone => 'Невірний номер телефону';

  @override
  String get wizardStufe1b1Title => 'Згода батьків';

  @override
  String get wizardStufe1b1Prompt =>
      'Ти неповнолітній (16-17) — згідно з §106 BGB нам потрібна згода батька, матері або законного опікуна. Скажи імʼя та номер телефону. Vorsitzer зателефонує та домовиться про зустріч (особисто або відеодзвінок). Без email — хочемо бути впевненими, що говоримо з реальною людиною.';

  @override
  String get wizardStufe1b1VornameLabel => 'Імʼя батька / матері';

  @override
  String get wizardStufe1b1VornameHelper =>
      'Як у Personalausweis батька / матері.';

  @override
  String get wizardStufe1b1NachnameLabel => 'Прізвище батька / матері';

  @override
  String get wizardStufe1b1NachnameHelper =>
      'Як у Personalausweis батька / матері.';

  @override
  String get wizardStufe1b1TelefonLabel => 'Мобільний батька / матері';

  @override
  String get wizardStufe1b1TelefonHelper =>
      'На цей номер зателефонує Vorsitzer.';

  @override
  String get wizardStufe1b1RelationLabel => 'Стосунок до дитини:';

  @override
  String get wizardStufe1b1RelationMutter => 'Мати';

  @override
  String get wizardStufe1b1RelationVater => 'Батько';

  @override
  String get wizardStufe1b1RelationSorgeberechtigter => 'Законний опікун';

  @override
  String get wizardStufe1b1RelationAndere => 'Інший опікун';

  @override
  String get wizardStufe1cTitle => 'Особисті дані';

  @override
  String get wizardStufe1cPrompt =>
      'Просто щоб я тебе трохи краще пізнав. Це залишиться між нами і ніде публічно не зʼявиться.';

  @override
  String get wizardStufe1cGeschlechtLabel => 'Стать';

  @override
  String get wizardStufe1cGeschlechtMaennlich => 'Чоловіча';

  @override
  String get wizardStufe1cGeschlechtWeiblich => 'Жіноча';

  @override
  String get wizardStufe1cGeschlechtDivers => 'Інше';

  @override
  String get wizardStufe1cGeschlechtKeineAngabe => 'Не вказано';

  @override
  String get wizardStufe1cFamilienstandLabel => 'Сімейний стан';

  @override
  String get wizardStufe1cFamilienstandLedig => 'Неодружений / Незаміжня';

  @override
  String get wizardStufe1cFamilienstandVerheiratet => 'Одружений / Заміжня';

  @override
  String get wizardStufe1cFamilienstandGeschieden => 'Розлучений / Розлучена';

  @override
  String get wizardStufe1cFamilienstandVerwitwet => 'Удівець / Удова';

  @override
  String get wizardStufe1dTitle => 'Походження';

  @override
  String get wizardStufe1dPrompt =>
      'Це допомагає нам запропонувати тобі правильну допомогу — наприклад, поради щодо Aufenthalt або пошук твоєї мовної спільноти.';

  @override
  String get wizardStufe1dStaatLabel => 'Громадянство';

  @override
  String get wizardStufe1dStaatHelper =>
      'Наприклад: deutsch, rumänisch, ukrainisch. Декілька через кому.';

  @override
  String get wizardStufe1dAufenthaltLabel =>
      'Статус перебування (Aufenthaltsstatus) — необовʼязково';

  @override
  String get wizardStufe1dAufenthaltHelper =>
      'Обери назву зі своєї Aufenthaltskarte / рішення. Vorstand звіряє з твоїми документами.';

  @override
  String get wizardStufe1dAufenthaltAwaitingCitizenship =>
      'Спочатку вкажи громадянство вище — покажемо лише відповідні варіанти.';

  @override
  String get wizardStufe1dAufenthaltGerman =>
      'Aufenthaltstitel не потрібен — громадянин Німеччини.';

  @override
  String get wizardStufe1dAufenthaltEuEea =>
      'Громадянин ЄС/ЄЕП/Швейцарії — свобода пересування (Freizügigkeit).';

  @override
  String get wizardStufe1dAufenthaltTempHint => 'тимчасовий';

  @override
  String get wizardStufe1dAufenthaltPermHint => 'постійне проживання';

  @override
  String get wizardStufe1dAufenthaltAsylumProcessHint => 'процедура притулку';

  @override
  String get wizardStufe1dAufenthaltOther => 'Інше (уточни в чаті)';

  @override
  String get wizardStufe1dAufenthaltRequired =>
      'Будь ласка, обери Aufenthaltstitel.';

  @override
  String get wizardStufe1dMutterspracheLabel => 'Рідна мова';

  @override
  String get wizardStufe1dMutterspracheHelper =>
      'Заповнено мовою застосунку — зміни, якщо інша.';

  @override
  String get wizardStufe1eTitle => 'Адреса';

  @override
  String get wizardStufe1ePrompt =>
      'Твоя поштова адреса — використовуємо її для офіційних документів (статут, договори членства, повідомлення).';

  @override
  String get wizardStufe1eStrasseLabel => 'Вулиця';

  @override
  String get wizardStufe1eStrasseHelper =>
      'Лише назва вулиці — номер у сусідньому полі.';

  @override
  String get wizardStufe1eHausnummerLabel => '№';

  @override
  String get wizardStufe1ePlzLabel => 'PLZ (індекс)';

  @override
  String get wizardStufe1eOrtLabel => 'Місто';

  @override
  String get wizardStufe1eLandLabel => 'Країна';

  @override
  String get wizardStufe1eLandHelper => 'Заповнено: Deutschland.';

  @override
  String get wizardErrInvalidStreet => 'Невірна назва вулиці';

  @override
  String get wizardErrInvalidHausnummer =>
      'Невірний номер (напр. 12, 12a, 12/3)';

  @override
  String get wizardErrInvalidPlz => 'Невірний індекс (тільки цифри)';

  @override
  String get wizardStufe1fTitle => 'Контакт';

  @override
  String get wizardStufe1fPrompt =>
      'Як з тобою звʼязатися? Телефон — лише для термінових випадків, усе інше йде через наш власний наскрізно зашифрований канал у застосунку. Твій членський email призначається автоматично, і ти бачиш його нижче.';

  @override
  String get wizardStufe1fTelefonLabel => 'Мобільний';

  @override
  String get wizardStufe1fTelefonHelper =>
      'Обіцяю, дзвонитиму лише коли це справді важливо. 📱';

  @override
  String get wizardStufe2Title => 'Тип членства';

  @override
  String get wizardStufe2Prompt =>
      'Яким членом ти хочеш бути? Давай поясню кожну опцію.';

  @override
  String get wizardStufe2OrdentlichTitle => 'Дійсний член (ordentlich)';

  @override
  String get wizardStufe2OrdentlichBody =>
      'Повні права. Платиш щомісячний внесок, голосуєш у Mitgliederversammlung, можеш бути обраним до Vorstand. Стандартний вибір.';

  @override
  String get wizardStufe2FoerderTitle => 'Підтримуючий член (Fördermitglied)';

  @override
  String get wizardStufe2FoerderBody =>
      'Підтримуєш асоціацію фінансово, але не береш активної участі в рішеннях. Без права голосу. Добре, якщо хочеш допомагати на відстані.';

  @override
  String get wizardStufe2EhrenTitle => 'Почесний член (Ehrenmitglied)';

  @override
  String get wizardStufe2EhrenBody =>
      'Присвоюється Vorstand за особливі заслуги. Не вибираєш сам — отримуєш як визнання. Обери лише якщо вже був удостоєний.';

  @override
  String get wizardStufe3Title => 'Фінансовий стан';

  @override
  String get wizardStufe3Prompt =>
      'Тепер про твій фінансовий стан. Не для того, щоб судити — а щоб звільнити від внеску, якщо отримуєш соціальну допомогу.';

  @override
  String get wizardStufe3OptionBuergergeld => 'Отримую Bürgergeld';

  @override
  String get wizardStufe3OptionSozialamt => 'Отримую допомогу від Sozialamt';

  @override
  String get wizardStufe3OptionNein => 'Не отримую жодного';

  @override
  String get wizardStufe3FeeExemptTitle => 'Внесок: 0 € / місяць 🎉';

  @override
  String get wizardStufe3FeeExemptBody =>
      'З Bürgergeld, Sozialamt, ALG I чи Krankengeld ти повністю звільнений від внеску згідно з Satzung §6. Нам потрібне лише підтвердження (Leistungsbescheid чи довідка від відомства / лікарняної каси).';

  @override
  String get wizardStufe3UploadTitle => 'Завантажити Leistungsbescheid';

  @override
  String get wizardStufe3UploadHint => 'PDF / JPG / PNG, максимум 10 МБ.';

  @override
  String get wizardStufe3UploadRequired =>
      'Завантаж Leistungsbescheid перш ніж продовжити.';

  @override
  String get wizardStufe3FileTooLarge =>
      'Файл занадто великий. Максимум 10 МБ.';

  @override
  String get wizardStufe3UploadFailed =>
      'Не вдалося завантажити файл. Спробуй ще раз.';

  @override
  String get wizardStufe3RegularFeeTitle => 'Внесок: 25 € / місяць';

  @override
  String get wizardStufe3RegularFeeBody =>
      'Стандартний внесок для дійсних членів за статутом.';

  @override
  String get wizardStufe4Title => 'Оплата';

  @override
  String get wizardStufe4Prompt =>
      'Як ти хочеш сплачувати внесок? І в який день місяця тобі зручно?';

  @override
  String get wizardStufe4MethodUeberweisungTitle =>
      'Банківський переказ (Überweisung)';

  @override
  String get wizardStufe4MethodUeberweisungBody =>
      'Ти сам ініціюєш платіж щомісяця зі свого рахунку.';

  @override
  String get wizardStufe4MethodSepaTitle => 'SEPA-Lastschrift (прямий дебет)';

  @override
  String get wizardStufe4MethodSepaBody =>
      'Ми автоматично списуємо суму з твого рахунку. Найзручніше, але нам потрібні IBAN і підписаний мандат.';

  @override
  String get wizardStufe4MethodDauerauftragTitle =>
      'Dauerauftrag (постійне доручення)';

  @override
  String get wizardStufe4MethodDauerauftragBody =>
      'Ти налаштовуєш постійне доручення у своєму банку. Банк сам переказує суму щомісяця.';

  @override
  String get wizardStufe4DayLabel => 'День оплати';

  @override
  String get wizardStufe4DayHint => 'Вибери день від 1 до 31';

  @override
  String wizardStufe4DayItem(int day) {
    return '$day-е число';
  }

  @override
  String wizardStufe4DayReminder(int day) {
    return 'Внесок буде списуватися $day-го числа щомісяця.';
  }

  @override
  String get wizardStufe5Title => 'Дата початку';

  @override
  String get wizardStufe5Prompt =>
      'З якого моменту ти хочеш бути офіційним членом ICD360S? З моменту схвалення або ретроактивно.';

  @override
  String get wizardStufe5OptionAbVerifizierungTitle =>
      'З моменту схвалення Vorstand';

  @override
  String get wizardStufe5OptionAbVerifizierungBody =>
      'Найпростіший варіант. Без ретроактивного внеску.';

  @override
  String get wizardStufe5OptionGruendungsdatumTitle =>
      'Ретроактивно з 01.08.2025 (дата заснування)';

  @override
  String get wizardStufe5OptionGruendungsdatumBody =>
      'Будеш зараховуватися як член з першого дня асоціації.';

  @override
  String get wizardStufe5OptionAnderesDatumTitle => 'Інша дата';

  @override
  String get wizardStufe5OptionAnderesDatumBody =>
      'Сам обираєш дату між 01.08.2025 і сьогодні.';

  @override
  String get wizardStufe5PickDate => 'Натисни, щоб обрати дату';

  @override
  String get wizardStufe5PickDateFirst => 'Спочатку обери дату.';

  @override
  String get wizardStufe5DatePickerHelp => 'Дата початку членства';

  @override
  String wizardStufe5DateRange(String start) {
    return 'Між $start і сьогодні';
  }

  @override
  String get wizardStufe5RetroactiveTitle => 'Ретроактивний внесок';

  @override
  String wizardStufe5RetroactiveBody(
      String start, String end, int months, String amount) {
    return 'З $start по $end це $months місяців. По 25 €/місяць виходить $amount € до доплати, окрім поточного місячного внеску.';
  }

  @override
  String get wizardStufe5FeeExemptTitle => 'Ретроактивний внесок: 0 € 🎉';

  @override
  String get wizardStufe5FeeExemptBody =>
      'З Bürgergeld або Sozialamt ти повністю звільнений — навіть ретроактивно нічого не винен.';

  @override
  String wizardDocumentPrompt(String doc) {
    return 'Перед тим, як завершити, уважно прочитай $doc. Важливо знати, що підписуєш.';
  }

  @override
  String get wizardDocumentScrollHint => 'Прокрути до кінця, щоб продовжити.';

  @override
  String get wizardDocumentScrolledOk => 'Ти прочитав до кінця ✓';

  @override
  String wizardDocumentOpenButton(String doc) {
    return 'Відкрити $doc у браузері';
  }

  @override
  String get wizardDocumentExternalHint =>
      'На цій платформі ми відкриваємо документ у твоєму браузері за замовчуванням.';

  @override
  String get wizardDocumentOpenedOk =>
      'Документ було відкрито. Прочитай уважно.';

  @override
  String wizardDocumentConfirm(String doc) {
    return 'Підтверджую, що прочитав і погоджуюся з $doc.';
  }

  @override
  String get wizardFinalAdultTitle => 'Готово! Ти зареєстрований 🎉';

  @override
  String get wizardFinalMinorTitle => 'Заявку надіслано 📨';

  @override
  String get wizardFinalMinorBody =>
      'Ми звʼяжемося з твоїм батьком/матірʼю та призначимо зустріч (особисто або відеодзвінок). Прошу мати терпіння — процес може зайняти до 7 днів. Отримаєш сповіщення в застосунку, щойно батько/мати схвалять.';

  @override
  String get wizardFinalMitgliedernummerLabel => 'Твій номер члена';

  @override
  String get wizardStufe4MethodComingSoon => 'Скоро';

  @override
  String get wizardStufe4StreichungWarning =>
      'Якщо ти заборгуєш більше 6 місяців за внеском, ми автоматично виключимо тебе (Satzung §6 Abs. 3).';

  @override
  String get wizardStufe5KuendigungInfo =>
      'Для виходу: надішли заяву про вихід письмово за 3 місяці до 31 грудня (до 30 вересня, щоб набуло чинності в кінці року). Мінімального терміну немає (Satzung §6 Abs. 3).';

  @override
  String get wizardStufe1fEmailLabel => 'Твій членський email';

  @override
  String get wizardStufe1fEmailHelper =>
      'Призначається автоматично на основі твого членського номера. Активується в той момент, коли правління (Vorstand) затвердить твою заявку. У нас є власний поштовий застосунок — надсилай і отримуй зашифровані листи, просто й безкоштовно.';

  @override
  String get wizardErrInvalidEmail => 'Невірна адреса електронної пошти';

  @override
  String get wizardStufe3OptionAlg1 =>
      'Отримую Arbeitslosengeld I (ALG I, допомога по безробіттю)';

  @override
  String get wizardStufe3OptionKrankengeld =>
      'Отримую Krankengeld (допомога з хвороби)';

  @override
  String get wizardStufe3UploadAddMore => 'Додати ще документ';

  @override
  String get wizardStufe3UploadLimitCount =>
      'Досягнуто ліміту: до 20 документів.';

  @override
  String get wizardStufe3UploadLimitTotal =>
      'Досягнуто ліміту 100 МБ. Видали один із наявних файлів.';

  @override
  String get wizardStufe3UploadDeleteTooltip => 'Видалити';

  @override
  String wizardStufe3UploadCounter(int count, int max) {
    return '$count / $max документів';
  }

  @override
  String get wizardDocumentExternalOpenFailed =>
      'Не вдалося відкрити браузер. Посилання скопійовано в буфер обміну — встав його в браузер, щоб продовжити.';

  @override
  String get wizardFinalTimelineProcessing =>
      'Vorstand перевіряє · зазвичай 1 робочий день, максимум 7';

  @override
  String get wizardFinalTimelineActivated => 'Акаунт активовано';

  @override
  String get wizardFinalAdultThank =>
      'Дякуємо, що заповнив реєстраційну форму! 🎉';

  @override
  String get wizardFinalAdultUsual =>
      'Твоя заявка у нас. Зазвичай ми її перевіряємо за один робочий день.';

  @override
  String get wizardFinalAdultExceptional =>
      'Іноді це може зайняти до 7 робочих днів. А якщо щось не сходиться, ми повернемо тебе у форму, щоб виправити 🙂';

  @override
  String get wizardFinalStatusTitle => 'СТАТУС ЗАЯВКИ';

  @override
  String wizardFinalStatusStepsValidated(int reviewed, int total) {
    return '$reviewed/$total кроків перевірено правлінням Vorstand';
  }

  @override
  String get wizardFinalStufeSheetTitle => 'Деталі заявки';

  @override
  String get wizardFinalStufeSheetHint =>
      'Вісім етапів, які ти пройшов. Vorstand перевіряє їх по черзі — ти бачиш у реальному часі, що вже схвалено.';

  @override
  String get wizardFinalStufeStatusPending => 'Очікує перевірки';

  @override
  String get wizardFinalStufeStatusApproved => 'Схвалено';

  @override
  String get wizardFinalStufeStatusRejected => 'Відхилено';

  @override
  String wizardFinalStatusRejectionCount(int count) {
    return '$count крок потребує виправлення';
  }

  @override
  String get wizardFinalStufeRejectionReason => 'Причина Vorstand:';

  @override
  String get wizardFinalStufeCorrectNow => 'Виправити зараз';

  @override
  String wizardFinalApprovalsHeader(int current, int total) {
    return 'Схвалення Vorstand ($current/$total)';
  }

  @override
  String get wizardFinalApprovalAwaiting => 'Очікуємо 2-го Vorstand';

  @override
  String get wizardFinalApprovalRejected => 'ВІДХИЛЕНО';

  @override
  String get wizardFinalStufeNoDataYet => 'Дані поки що недоступні.';

  @override
  String get wizardFinalStufeReadAt => 'Прочитано:';

  @override
  String get wizardFinalStufeBeitragsfrei =>
      'Звільнено від внеску (без оплати)';

  @override
  String get wizardFinalStufeNotExempt => 'Без соціальних допомог';

  @override
  String get wizardFinalStufeBeginAtVerification =>
      'Починається при верифікації';

  @override
  String get wizardFinalStufeBeginAtFoundation =>
      'Дата заснування (заднім числом)';

  @override
  String get wizardFinalStufeBeginAtCustom => 'Інша дата';

  @override
  String get wizardFinalStufeStatusSkipped => 'Пропущено';

  @override
  String get wizardFinalStufeFilledAt => 'Заповнено:';

  @override
  String get wizardFinalStufeReviewedAt => 'Перевірено:';

  @override
  String get wizardFinalWithdrawLink => 'Відкликати заявку';

  @override
  String get wizardFinalWithdrawDialogTitle => 'Відкликати заявку?';

  @override
  String get wizardFinalWithdrawDialogBody =>
      'Твоя заявка буде позначена як відкликана тобою. Дані залишаться в базі для аудиту (GDPR), але акаунт не буде активовано. Ти зможеш пройти реєстрацію заново будь-коли з новим номером.';

  @override
  String get wizardFinalWithdrawKeep => 'Ні, зачекаю';

  @override
  String get wizardFinalWithdrawConfirm => 'Так, відкликати';

  @override
  String get wizardErrTooManyWithdrawals =>
      'Твою заявку не вдається обробити автоматично. Зателефонуй нам або прийди особисто до Vorstand, щоб продовжити реєстрацію.';

  @override
  String get wizardDuplicateLoginTitle => 'Схоже, ти вже наш член';

  @override
  String get wizardDuplicateLoginBody =>
      'За твоїм імʼям та датою народження ми вже знаходимо активний акаунт. Скористайся «Я вже член» на головному екрані, щоб увійти. Якщо немає доступу — зателефонуй.';

  @override
  String get wizardDuplicatePendingTitle => 'Твоя заявка вже у нас';

  @override
  String get wizardDuplicatePendingBody =>
      'За твоїм імʼям і датою народження ми вже маємо заявку на розгляді. Vorstand працює над нею — повідомимо в застосунку, щойно акаунт стане активним. Зателефонуй, якщо хочеш обговорити.';

  @override
  String get wizardDuplicateRecentlyWithdrawnTitle =>
      'Ми не можемо обробити заявку зараз';

  @override
  String get wizardDuplicateRecentlyWithdrawnBody =>
      'Твоє імʼя та дата народження збігаються з нещодавно відкликаною заявкою. Зателефонуй нам, щоб поговорити з Vorstand до того, як продовжиш.';

  @override
  String get wizardDuplicatePreviouslyWithdrawnTitle => 'Ти вже подавав заявку';

  @override
  String get wizardDuplicatePreviouslyWithdrawnBody =>
      'Твоє імʼя та дата народження збігаються зі старою заявкою, яку ти відкликав. З поверненням — зателефонуй нам перед продовженням, щоб Vorstand вирішив, як діємо далі.';

  @override
  String get wizardDuplicateCallUsTitle => 'Будь ласка, зателефонуй';

  @override
  String get wizardDuplicateCallUsBody =>
      'Твоє імʼя та дата народження вже в наших записах, але не можемо повідомити деталі через застосунок. Зателефонуй — Vorstand пояснить ситуацію напряму.';

  @override
  String get wizardChatHelp => 'Поговоримо';

  @override
  String get wizardChatHelpSubtitle =>
      'Живий чат із Vorstand · швидка відповідь';

  @override
  String get benachrichtigungTitel => 'Нагадування через SMS';

  @override
  String get benachrichtigungIntro =>
      'Щоб ви не пропустили зустріч, товариство може надсилати вам SMS. Ви вирішуєте, чи потрібно це і для чого, і можете змінити рішення будь-коли.';

  @override
  String get benachrichtigungTermineFrage =>
      'Бажаєте отримувати нагадування про зустрічі через SMS?';

  @override
  String get benachrichtigungTermineDetail =>
      'У повідомленні будуть дата, час, місце і тема зустрічі.';

  @override
  String get benachrichtigungMedikamenteFrage => 'Нагадувати також про ліки?';

  @override
  String get benachrichtigungMedikamenteDetail =>
      'У повідомленні буде назва ліків. Це дані про здоров\'я, тому запитуємо окремо.';

  @override
  String get benachrichtigungHinweis =>
      'Нагадування — це допомога, а не гарантія: будь ласка, не покладайтеся лише на нього. Змінити можна будь-коли у профілі.';

  @override
  String get benachrichtigungJa => 'Так';

  @override
  String get benachrichtigungNein => 'Ні';

  @override
  String get benachrichtigungSpaeter => 'Вирішити пізніше';

  @override
  String get benachrichtigungSpeichern => 'Зберегти';

  @override
  String get benachrichtigungGespeichert => 'Дякуємо, збережено.';

  @override
  String get benachrichtigungenLeer => 'Немає сповіщень';

  @override
  String get benachrichtigungenAlleGelesen => 'Позначити всі як прочитані';

  @override
  String get benachrichtigungWetterFrage =>
      'Бажаєте отримувати попередження про негоду за місцем проживання?';

  @override
  String get benachrichtigungWetterDetail =>
      'Лише офіційні попередження німецької метеослужби рівня «сильне» і вище — не за кожного дощу.';

  @override
  String get signaturTitel => 'Підписи';

  @override
  String get signaturNichtsOffen => 'Наразі немає документів на підпис.';

  @override
  String get signaturStatusOffen => 'Очікує на ваш підпис';

  @override
  String get signaturStatusSigniert => 'Підписано вами';

  @override
  String get signaturStatusAbgelehnt => 'Відхилено вами';

  @override
  String get signaturStatusWiderrufen => 'Відкликано об\'єднанням';

  @override
  String get signaturStatusAbgelaufen => 'Термін минув';

  @override
  String signaturBitteGanzLesen(int gelesen, int gesamt) {
    return 'Будь ласка, прочитайте документ до кінця (сторінка $gelesen з $gesamt).';
  }

  @override
  String get signaturWeiterZurUnterschrift => 'Перейти до підпису';

  @override
  String get signaturAblehnen => 'Відхилити';

  @override
  String get signaturAblehnenHinweis =>
      'Об\'єднання буде повідомлено. Ви можете вказати причини.';

  @override
  String get signaturAblehnenGrund => 'Причина (необов\'язково)';

  @override
  String get signaturMitFingerHinweis => 'Підпишіться пальцем у білому полі.';

  @override
  String get signaturNochmal => 'Заново';

  @override
  String get signaturZurueckZumDokument => 'Назад до документа';

  @override
  String get signaturCodeAnfordern => 'Запросити код через SMS';

  @override
  String get signaturCodeUnterwegs => 'Код надсилається.';

  @override
  String signaturCodeGesendetAn(String nummer) {
    return 'Ми надіслали код на $nummer.';
  }

  @override
  String get signaturCodeErneutSenden => 'Надіслати код ще раз';

  @override
  String get signaturJetztUnterschreiben => 'Підписати';

  @override
  String get signaturCodeFalsch => 'Код неправильний.';

  @override
  String get signaturCodeAbgelaufen =>
      'Термін дії коду минув. Будь ласка, запросіть новий.';

  @override
  String get signaturZuVieleVersuche =>
      'Забагато невдалих спроб. Будь ласка, запросіть новий код.';

  @override
  String get signaturKeineRufnummer =>
      'Для вашого облікового запису не вказано номер мобільного. Без нього ми не можемо надіслати код — зверніться до голови.';

  @override
  String get signaturCodeFehlgeschlagen => 'Не вдалося надіслати код.';

  @override
  String get signaturLeer => 'Спочатку поставте підпис.';

  @override
  String get signaturErfolg => 'Дякуємо — ваш підпис отримано.';

  @override
  String get signaturFehlgeschlagen =>
      'Не вийшло. Будь ласка, спробуйте ще раз.';
}
