// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Ukrainian (`uk`).
class AppLocalizationsUk extends AppLocalizations {
  AppLocalizationsUk([String locale = 'uk']) : super(locale);

  @override
  String get appTitle => 'ICD360S e.V - Портал учасників';

  @override
  String get memberPortal => 'Портал учасників';

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
  String get password => 'Пароль';

  @override
  String get passwordHint => 'Введіть пароль';

  @override
  String get confirmPassword => 'Підтвердіть пароль';

  @override
  String get confirmPasswordHint => 'Підтвердіть пароль';

  @override
  String get newPassword => 'Новий пароль';

  @override
  String get newPasswordHint => 'Введіть новий пароль';

  @override
  String get saveCredentials => 'Зберегти дані входу';

  @override
  String get autoLogin => 'Автоматичний вхід';

  @override
  String get forgotPassword => 'Забули пароль?';

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
  String get recoveryCode => 'Код відновлення (6 цифр)';

  @override
  String get recoveryCodeHelper =>
      'Запам\'ятайте цей код для відновлення пароля';

  @override
  String get recoveryCodeHint => 'Введіть код відновлення';

  @override
  String get recoveryCodeInvalid => 'Код має складатися з 6 цифр';

  @override
  String get loginFailed => 'Помилка входу';

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
  String get tooManyDevices => 'Забагато пристроїв';

  @override
  String get maxDevicesMessage =>
      'Ви вже увійшли на 3 пристроях.\nВиберіть пристрій для виходу:';

  @override
  String get unknownDevice => 'Невідомий пристрій';

  @override
  String get unknown => 'Невідомо';

  @override
  String get logoutError => 'Помилка виходу';

  @override
  String error(String error) {
    return 'Помилка: $error';
  }

  @override
  String get cancel => 'Скасувати';

  @override
  String get resetPassword => 'Скинути пароль';

  @override
  String get forgotPasswordTitle => 'Забули пароль';

  @override
  String get forgotPasswordDescription =>
      'Введіть номер учасника та код відновлення, створений під час реєстрації.';

  @override
  String get passwordResetSuccess =>
      'Пароль успішно скинуто!\n\nТепер ви можете увійти з новим паролем.';

  @override
  String get passwordResetFailed => 'Скидання пароля не вдалося';

  @override
  String get needHelp => 'Потрібна допомога?';

  @override
  String get helpQuestion => 'Проблеми з входом або реєстрацією?';

  @override
  String get helpDescription =>
      'Зв\'яжіться з нами через WhatsApp та опишіть, що не працює. Ми відповімо якнайшвидше!';

  @override
  String get whatsapp => 'WhatsApp';

  @override
  String get emailSubject => 'Запит через додаток ICD360S';

  @override
  String get whatsappMessage => 'Вітаю, у мене проблема з додатком ICD360S. ';

  @override
  String get imprint => 'Імпресум';

  @override
  String get privacy => 'Політика конфіденційності';

  @override
  String get statutes => 'Статут';

  @override
  String get revocation => 'Право відкликання';

  @override
  String get cancellation => 'Скасування';

  @override
  String get allRightsReserved => 'Всі права захищені.';

  @override
  String get enterCredentials => 'Введіть номер учасника та пароль';

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
  String get membership => 'Членство';

  @override
  String get myAppointments => 'Мої зустрічі';

  @override
  String get appointmentsLoadingReady =>
      'Завантаження зустрічей - API готовий!';

  @override
  String get priority => 'Пріоритет';

  @override
  String get messageLabel => 'Повідомлення';

  @override
  String get createdOn => 'Створено';

  @override
  String get handler => 'Обробник';

  @override
  String get reportProblems => 'Повідомити про проблеми';

  @override
  String get reportProblem => 'Повідомити про проблему';

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
  String get newTicket => 'Нова заявка';

  @override
  String get noOpenTickets => 'Немає відкритих заявок';

  @override
  String get haveQuestionCreateTicket =>
      'Є питання або проблема?\nСтворіть нову заявку.';

  @override
  String get whatIsTheProblem => 'У чому проблема?';

  @override
  String get describeTheProblem => 'Опишіть проблему';

  @override
  String get howUrgentIsIt => 'Наскільки це терміново?';

  @override
  String get low => 'Низький';

  @override
  String get medium => 'Середній';

  @override
  String get high => 'Високий';

  @override
  String get submit => 'Надіслати';

  @override
  String get fillSubjectAndMessage =>
      'Будь ласка, заповніть тему та повідомлення';

  @override
  String get ticketCreated => 'Заявку створено';

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
  String get newEmailAddress => 'Нова адреса email';

  @override
  String get currentPassword => 'Поточний пароль';

  @override
  String get saveEmail => 'Зберегти email';

  @override
  String get savePassword => 'Зберегти пароль';

  @override
  String get deviceLoggedOut => 'Пристрій відключено';

  @override
  String get passwordChangedSuccessfully => 'Пароль успішно змінено';

  @override
  String get emailChangedSuccessfully => 'Email успішно змінено';

  @override
  String get errorChangingPassword => 'Помилка зміни пароля';

  @override
  String get errorChangingEmail => 'Помилка зміни email';

  @override
  String get validEmailRequired => 'Будь ласка, введіть дійсну адресу email';

  @override
  String get passwordTooShort => 'Пароль повинен містити не менше 6 символів';

  @override
  String get maxDevicesReached => 'Ви увійшли на максимум з 3 пристроїв.';

  @override
  String loggedInOnDevices(int count) {
    return 'Ви увійшли на $count з 3 пристроїв.';
  }

  @override
  String get noActiveSessions => 'Немає активних сеансів';

  @override
  String get logoutFromDevice => 'Вийти з цього пристрою';

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
  String get errorAcceptingCall => 'Помилка прийняття дзвінка';

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
  String typingIndicator(String name) {
    return '$name друкує...';
  }

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
  String get diagnosticDataTitle => 'Діагностичні дані';

  @override
  String get diagnosticDescription =>
      'Бажаєте надсилати анонімні діагностичні дані для покращення додатку?';

  @override
  String get noThanks => 'Ні, дякую';

  @override
  String get yesEnable => 'Так, увімкнути';

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
  String get newPasswordMinChars => 'Новий пароль (мін. 6 символів)';

  @override
  String get reasonLabel2 => 'Причина';

  @override
  String get downloadFailed2 => 'Завантаження не вдалося';

  @override
  String get downloadTooltip => 'Завантажити';

  @override
  String get connectionErrorGeneric => 'Помилка з\'єднання';

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
  String get bankTransfer => 'Банківський переказ';

  @override
  String get standingOrder => 'Постійне доручення';

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
  String get memberNumberTooLong =>
      'Номер учасника занадто довгий (макс. 20 символів)';

  @override
  String get onlyUppercaseAndNumbers => 'Дозволено лише великі літери та цифри';

  @override
  String get passwordTooLong => 'Пароль занадто довгий (макс. 100 символів)';

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
  String get diagnosticErrors => 'Звіти про помилки для покращення';

  @override
  String get diagnosticAnonymousStats => 'Анонімна статистика використання';

  @override
  String get diagnosticPerformance => 'Дані про продуктивність додатку';

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
  String get ipClean => 'IP чистий - не в списку';

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
  String get helpImproveApp => 'Бажаєте допомогти нам покращити додаток?';

  @override
  String get noPersonalDataCollected =>
      'Особисті дані не збираються. Цей параметр можна змінити в будь-який час.';

  @override
  String logEntries(int count) {
    return '$count записів';
  }

  @override
  String get noLogs => 'Немає логів';

  @override
  String get newLoginDetected => 'Виявлено новий вхід';

  @override
  String get waitingForMember => 'Очікування учасника';

  @override
  String get waitingForStaff => 'Очікування співробітника';

  @override
  String get waitingForAuthority => 'Очікування органу влади';
}
