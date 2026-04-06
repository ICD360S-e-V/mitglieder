// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'بوابة الأعضاء ICD360S e.V.';

  @override
  String get memberPortal => 'بوابة الأعضاء';

  @override
  String get welcomeLoading => 'جاري التحميل...';

  @override
  String get welcomeAutoLogin => 'تسجيل دخول تلقائي...';

  @override
  String get login => 'تسجيل الدخول';

  @override
  String get register => 'التسجيل';

  @override
  String get becomeMember => 'كن عضواً';

  @override
  String get memberNumber => 'رقم العضوية';

  @override
  String get memberNumberHint => 'مثال: M12345';

  @override
  String get password => 'كلمة المرور';

  @override
  String get passwordHint => 'أدخل كلمة المرور';

  @override
  String get confirmPassword => 'تأكيد كلمة المرور';

  @override
  String get confirmPasswordHint => 'تأكيد كلمة المرور';

  @override
  String get newPassword => 'كلمة المرور الجديدة';

  @override
  String get newPasswordHint => 'أدخل كلمة المرور الجديدة';

  @override
  String get saveCredentials => 'حفظ بيانات الدخول';

  @override
  String get autoLogin => 'تسجيل دخول تلقائي';

  @override
  String get forgotPassword => 'نسيت كلمة المرور؟';

  @override
  String get firstName => 'الاسم الأول';

  @override
  String get firstNameHint => 'أدخل الاسم الأول واسم العائلة';

  @override
  String get nameMinLength => 'الاسم يجب أن يحتوي على حرفين على الأقل';

  @override
  String get nameOnlyLetters => 'يُسمح فقط بالأحرف والشرطات';

  @override
  String get email => 'البريد الإلكتروني';

  @override
  String get emailHint => 'أدخل بريدك الإلكتروني';

  @override
  String get emailInvalid => 'الرجاء إدخال بريد إلكتروني صالح';

  @override
  String get passwordMinLength => 'كلمة المرور 6 أحرف على الأقل';

  @override
  String get passwordsNotMatch => 'كلمتا المرور غير متطابقتين';

  @override
  String get recoveryCode => 'رمز الاسترداد';

  @override
  String get recoveryCodeHelper => 'تذكر هذا الرمز لاسترداد كلمة المرور';

  @override
  String get recoveryCodeHint => '6 أرقام';

  @override
  String get recoveryCodeInvalid => 'يجب أن يكون الرمز 6 أرقام بالضبط';

  @override
  String get loginFailed => 'فشل تسجيل الدخول';

  @override
  String get registrationFailed => 'فشل التسجيل';

  @override
  String connectionError(String error) {
    return 'خطأ في الاتصال: $error';
  }

  @override
  String registrationSuccess(String memberNumber) {
    return 'تم التسجيل بنجاح!\n\nرقم عضويتك: $memberNumber\n\nيرجى حفظ هذا الرقم لتسجيل الدخول.';
  }

  @override
  String get tooManyDevices => 'أجهزة كثيرة جداً';

  @override
  String get maxDevicesMessage =>
      'أنت مسجل الدخول بالفعل على 3 أجهزة.\nاختر جهازاً لتسجيل الخروج منه:';

  @override
  String get unknownDevice => 'جهاز غير معروف';

  @override
  String get unknown => 'غير معروف';

  @override
  String get logoutError => 'خطأ في تسجيل الخروج';

  @override
  String error(String error) {
    return 'خطأ';
  }

  @override
  String get cancel => 'إلغاء';

  @override
  String get resetPassword => 'إعادة تعيين كلمة المرور';

  @override
  String get forgotPasswordTitle => 'نسيت كلمة المرور';

  @override
  String get forgotPasswordDescription =>
      'أدخل رقم عضويتك ورمز الاسترداد الذي أنشأته أثناء التسجيل.';

  @override
  String get passwordResetSuccess => 'تم إعادة تعيين كلمة المرور بنجاح';

  @override
  String get passwordResetFailed => 'فشل إعادة تعيين كلمة المرور';

  @override
  String get needHelp => 'تحتاج مساعدة؟';

  @override
  String get helpQuestion => 'هل لديك مشاكل في تسجيل الدخول أو التسجيل؟';

  @override
  String get helpDescription =>
      'تواصل معنا عبر واتساب وصف بالضبط ما لا يعمل. سنرد في أقرب وقت!';

  @override
  String get whatsapp => 'واتساب';

  @override
  String get emailSubject => 'استفسار عبر تطبيق ICD360S';

  @override
  String get whatsappMessage => 'مرحباً، لدي مشكلة في تطبيق ICD360S. ';

  @override
  String get imprint => 'بيانات النشر';

  @override
  String get privacy => 'سياسة الخصوصية';

  @override
  String get statutes => 'النظام الأساسي';

  @override
  String get revocation => 'حق الانسحاب';

  @override
  String get cancellation => 'الإلغاء';

  @override
  String get allRightsReserved => 'جميع الحقوق محفوظة.';

  @override
  String get enterCredentials => 'الرجاء إدخال رقم العضوية وكلمة المرور';

  @override
  String get appointments => 'المواعيد';

  @override
  String get tickets => 'التذاكر';

  @override
  String get liveChat => 'دردشة مباشرة';

  @override
  String get notifications => 'الإشعارات';

  @override
  String get myProfile => 'ملفي الشخصي';

  @override
  String get logout => 'تسجيل الخروج';

  @override
  String get goodMorning => 'صباح الخير';

  @override
  String get goodDay => 'نهارك سعيد';

  @override
  String get goodEvening => 'مساء الخير';

  @override
  String get goodNight => 'تصبح على خير';

  @override
  String get welcomeToICD => 'مرحباً بك في ICD360S e.V!';

  @override
  String get accountCreatedSuccessfully => 'تم إنشاء حسابك بنجاح.';

  @override
  String get today => 'اليوم';

  @override
  String get membershipFeeDue => 'رسوم العضوية مستحقة';

  @override
  String get pleaseTransferAnnualFee => 'يرجى تحويل الرسوم السنوية.';

  @override
  String get newBadge => 'جديد';

  @override
  String get close => 'إغلاق';

  @override
  String get membership => 'العضوية';

  @override
  String get myAppointments => 'مواعيدي';

  @override
  String get appointmentsLoadingReady => 'جاري تحميل المواعيد - الخادم جاهز!';

  @override
  String get priority => 'الأولوية';

  @override
  String get messageLabel => 'الرسالة';

  @override
  String get createdOn => 'تاريخ الإنشاء';

  @override
  String get handler => 'المسؤول';

  @override
  String get reportProblems => 'الإبلاغ عن مشاكل';

  @override
  String get reportProblem => 'الإبلاغ عن مشكلة';

  @override
  String get weRespondIn24Hours => 'سنرد عليك خلال 24 ساعة كحد أقصى!';

  @override
  String get everythingOk => 'كل شيء على ما يرام!';

  @override
  String get haveProblemWeHelp => 'لديك مشكلة؟\nسنهتم بها!';

  @override
  String get myMembership => 'عضويتي';

  @override
  String get managePersonalDataAndFee => 'إدارة بياناتك الشخصية ورسوم العضوية';

  @override
  String get myAppointmentsTitle => 'مواعيدي';

  @override
  String get appointmentsDescription =>
      'هنا يمكنك رؤية مواعيدك القادمة.\nيمكنك تأكيد مشاركتك أو رفضها.';

  @override
  String get loadAppointments => 'تحميل المواعيد';

  @override
  String get myTickets => 'تذاكري';

  @override
  String get newTicket => 'تذكرة جديدة';

  @override
  String get noOpenTickets => 'لا توجد تذاكر مفتوحة';

  @override
  String get haveQuestionCreateTicket =>
      'لديك سؤال أو مشكلة؟\nأنشئ تذكرة جديدة.';

  @override
  String get whatIsTheProblem => 'ما هي المشكلة؟';

  @override
  String get describeTheProblem => 'صف المشكلة';

  @override
  String get howUrgentIsIt => 'ما مدى الاستعجال؟';

  @override
  String get low => 'منخفض';

  @override
  String get medium => 'متوسط';

  @override
  String get high => 'مرتفع';

  @override
  String get submit => 'إرسال';

  @override
  String get fillSubjectAndMessage => 'يرجى ملء الموضوع والرسالة';

  @override
  String get ticketCreated => 'تم الإنشاء';

  @override
  String get errorCreatingTicket => 'خطأ في إنشاء التذكرة';

  @override
  String get verified => 'تم التحقق';

  @override
  String get account => 'الحساب';

  @override
  String get myDevices => 'أجهزتي';

  @override
  String get changeEmail => 'تغيير البريد الإلكتروني';

  @override
  String get changePassword => 'تغيير كلمة المرور';

  @override
  String get newEmailAddress => 'عنوان بريد إلكتروني جديد';

  @override
  String get currentPassword => 'كلمة المرور الحالية';

  @override
  String get saveEmail => 'حفظ البريد الإلكتروني';

  @override
  String get savePassword => 'حفظ كلمة المرور';

  @override
  String get deviceLoggedOut => 'تم تسجيل خروج الجهاز';

  @override
  String get passwordChangedSuccessfully => 'تم تغيير كلمة المرور بنجاح';

  @override
  String get emailChangedSuccessfully => 'تم تغيير البريد الإلكتروني بنجاح';

  @override
  String get errorChangingPassword => 'خطأ في تغيير كلمة المرور';

  @override
  String get errorChangingEmail => 'خطأ في تغيير البريد الإلكتروني';

  @override
  String get validEmailRequired => 'يرجى إدخال بريد إلكتروني صالح';

  @override
  String get passwordTooShort => 'كلمة المرور 6 أحرف على الأقل';

  @override
  String get maxDevicesReached => 'أنت مسجل الدخول على 3 أجهزة كحد أقصى.';

  @override
  String loggedInOnDevices(int count) {
    return 'أنت مسجل الدخول على $count من 3 أجهزة.';
  }

  @override
  String get noActiveSessions => 'لا توجد جلسات نشطة';

  @override
  String get logoutFromDevice => 'تسجيل الخروج من هذا الجهاز';

  @override
  String get confirmLogoutDevice => 'تسجيل خروج الجهاز؟';

  @override
  String get confirmLogoutMessage =>
      'هل تريد تسجيل الخروج من هذا الجهاز؟\n\nستحتاج لتسجيل الدخول مرة أخرى.';

  @override
  String get ipAddress => 'عنوان IP';

  @override
  String get platform => 'المنصة';

  @override
  String trialWarningUrgentTitle(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'أيام',
      one: 'يوم',
    );
    return 'تحذير: $days $_temp0 فقط حتى تعليق الحساب!';
  }

  @override
  String get trialWarningTitle => 'لم يتم التحقق من حسابك بعد';

  @override
  String get trialWarningDescription =>
      'يرجى إكمال بياناتك في \"ملفي الشخصي\". بعد 30 يوماً سيتم تعليق حسابك تلقائياً.';

  @override
  String trialDaysRemaining(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days أيام',
      one: 'يوم واحد',
    );
    return '$_temp0';
  }

  @override
  String get overview => 'نظرة عامة';

  @override
  String get member => 'عضو';

  @override
  String get memberManagement => 'إدارة الأعضاء';

  @override
  String get reportProblemTooltip => 'الإبلاغ عن مشكلة';

  @override
  String get newAppointmentsTitle => 'مواعيد جديدة';

  @override
  String get youHaveNewAppointment => 'لديك موعد جديد.';

  @override
  String youHaveNewAppointments(int count) {
    return 'لديك $count مواعيد جديدة.';
  }

  @override
  String get appointmentReminderTomorrow => 'تذكير: موعد غداً';

  @override
  String tomorrowAppointment(String title) {
    return 'غداً: $title';
  }

  @override
  String youHaveTomorrowAppointments(int count) {
    return 'لديك $count مواعيد غداً.';
  }

  @override
  String get appointmentsToday => 'مواعيد اليوم';

  @override
  String todayAppointment(String title) {
    return 'اليوم: $title';
  }

  @override
  String youHaveTodayAppointments(int count) {
    return 'لديك $count مواعيد اليوم.';
  }

  @override
  String get paymentReminder => 'تذكير بالدفع';

  @override
  String paymentReminderMessage(int day, String method) {
    return 'اليوم هو $day من الشهر - يرجى إتمام $method.';
  }

  @override
  String get paymentDayLabel => 'يوم الدفع (تذكير شهري)';

  @override
  String get updateAvailable => 'تحديث متوفر';

  @override
  String newVersionAvailable(String version) {
    return 'إصدار جديد متوفر: $version';
  }

  @override
  String currentVersionLabel(String version) {
    return 'الإصدار الحالي: $version';
  }

  @override
  String get changes => 'التغييرات:';

  @override
  String downloadProgress(String percent) {
    return 'جاري التحميل... $percent%';
  }

  @override
  String get installationStarting => 'جاري بدء التثبيت...';

  @override
  String get appWillRestart => 'سيتم إعادة تشغيل التطبيق تلقائياً.';

  @override
  String get later => 'لاحقاً';

  @override
  String get updateNow => 'تحديث الآن';

  @override
  String get downloading => 'جاري التحميل...';

  @override
  String get downloadFailed => 'فشل التحميل. يرجى المحاولة لاحقاً.';

  @override
  String get searchingForUpdates => 'جاري البحث عن تحديثات...';

  @override
  String get appUpToDate => 'التطبيق محدث';

  @override
  String get updateCheckError => 'خطأ في التحقق من التحديثات';

  @override
  String get changelog => 'سجل التغييرات';

  @override
  String get terminConfirmed => 'تم تأكيد الموعد';

  @override
  String get terminDeclined => 'تم رفض الموعد';

  @override
  String get terminRescheduleRequested => 'تم طلب إعادة الجدولة';

  @override
  String get statusConfirmed => 'مؤكد';

  @override
  String get statusDeclined => 'مرفوض';

  @override
  String get statusRescheduling => 'إعادة جدولة';

  @override
  String get statusPending => 'معلق';

  @override
  String get categoryVorstandssitzung => 'اجتماع مجلس الإدارة';

  @override
  String get categoryMitgliederversammlung => 'الجمعية العمومية';

  @override
  String get categorySchulung => 'تدريب';

  @override
  String get categorySonstiges => 'أخرى';

  @override
  String openCount(int count) {
    return '$count مفتوحة';
  }

  @override
  String get refresh => 'تحديث';

  @override
  String get filterUpcoming => 'القادمة';

  @override
  String get filterPast => 'السابقة';

  @override
  String get filterAll => 'الكل';

  @override
  String get noUpcomingAppointments => 'لا توجد مواعيد قادمة';

  @override
  String get noPastAppointments => 'لا توجد مواعيد سابقة';

  @override
  String get noAppointmentsAvailable => 'لا توجد مواعيد';

  @override
  String get appointmentsShownHere => 'ستظهر مواعيدك هنا';

  @override
  String get dateLabel => 'التاريخ';

  @override
  String get timeLabel => 'الوقت';

  @override
  String get locationLabel => 'المكان';

  @override
  String get createdByLabel => 'أنشأه';

  @override
  String get descriptionLabel => 'الوصف';

  @override
  String get ticketLabel => 'تذكرة';

  @override
  String get yourStatus => 'حالتك: ';

  @override
  String reasonLabel(String reason) {
    return 'السبب: $reason';
  }

  @override
  String durationMinutes(int minutes) {
    return '$minutes دقيقة';
  }

  @override
  String get confirm => 'تأكيد';

  @override
  String get decline => 'رفض';

  @override
  String get reschedule => 'إعادة جدولة';

  @override
  String get requestReschedule => 'طلب إعادة جدولة';

  @override
  String appointmentLabel(String title) {
    return 'الموعد: $title';
  }

  @override
  String get rescheduleReason => 'سبب إعادة الجدولة *';

  @override
  String get rescheduleReasonHint => 'يرجى تقديم سبب...';

  @override
  String get pleaseProvideReason => 'يرجى تقديم سبب';

  @override
  String get request => 'طلب';

  @override
  String get ticketStatusOpen => 'مفتوحة';

  @override
  String get ticketStatusInProgress => 'قيد التنفيذ';

  @override
  String get ticketStatusWaitingMember => 'في انتظار العضو';

  @override
  String get ticketStatusWaitingStaff => 'في انتظار الموظف';

  @override
  String get ticketStatusWaitingAuthority => 'في انتظار الجهة';

  @override
  String get ticketStatusDone => 'منجزة';

  @override
  String get ticketPriorityHigh => 'عالية';

  @override
  String get ticketPriorityMedium => 'متوسطة';

  @override
  String get ticketPriorityLow => 'منخفضة';

  @override
  String get comments => 'التعليقات';

  @override
  String get documents => 'المستندات';

  @override
  String get details => 'التفاصيل';

  @override
  String get replySent => 'تم إرسال الرد';

  @override
  String get sendError => 'خطأ في الإرسال';

  @override
  String get uploading => 'جاري الرفع...';

  @override
  String fileUploaded(String filename) {
    return 'تم رفع $filename';
  }

  @override
  String get uploadFailed => 'فشل الرفع';

  @override
  String get openError => 'خطأ في الفتح';

  @override
  String get noRepliesYet => 'لا توجد ردود بعد';

  @override
  String get waitingForSupport => 'في انتظار رد الدعم';

  @override
  String get writeReply => 'اكتب رداً...';

  @override
  String get attachFile => 'إرفاق ملف';

  @override
  String documentsCount(int count) {
    return 'المستندات ($count)';
  }

  @override
  String get upload => 'رفع';

  @override
  String get noDocuments => 'لا توجد مستندات';

  @override
  String get allowedFormats => 'الصيغ المسموحة: PDF, JPEG, JPG, TXT, ZIP';

  @override
  String get yourMessage => 'رسالتك:';

  @override
  String get translation => 'ترجمة';

  @override
  String get original => 'الأصلي';

  @override
  String get originalText => 'النص الأصلي';

  @override
  String get autoTranslated => 'مترجم تلقائياً';

  @override
  String get originalTapTranslation => 'النص الأصلي · اضغط للترجمة';

  @override
  String get translatedTapOriginal => 'مترجم · اضغط للأصلي';

  @override
  String get justNow => 'الآن';

  @override
  String minutesAgo(int minutes) {
    return 'قبل $minutes دقيقة';
  }

  @override
  String hoursAgo(int hours) {
    return 'قبل $hours ساعات';
  }

  @override
  String daysAgo(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'أيام',
      one: 'يوم',
    );
    return 'قبل $days $_temp0';
  }

  @override
  String get createdLabel => 'الإنشاء';

  @override
  String get updatedLabel => 'التحديث';

  @override
  String get handlerLabel => 'المسؤول';

  @override
  String get doneLabel => 'منجزة';

  @override
  String get newTicketTitle => 'تذكرة جديدة';

  @override
  String get categoryOptional => 'الفئة (اختياري)';

  @override
  String get selectCategory => 'اختر الفئة';

  @override
  String get subjectLabel => 'الموضوع';

  @override
  String get fillAllFields => 'يرجى ملء جميع الحقول';

  @override
  String ticketCreatedId(int id) {
    return 'تذكرة #$id تم إنشاؤها';
  }

  @override
  String get priorityLabel => 'الأولوية: ';

  @override
  String get supportOffline => 'الدعم غير متصل';

  @override
  String get lastSeenSeconds => 'آخر نشاط قبل ثوانٍ';

  @override
  String lastSeenMinutes(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: 'دقائق',
      one: 'دقيقة',
    );
    return 'آخر نشاط قبل $minutes $_temp0';
  }

  @override
  String lastSeenHours(int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: 'ساعات',
      one: 'ساعة',
    );
    return 'آخر نشاط قبل $hours $_temp0';
  }

  @override
  String lastSeenDays(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'أيام',
      one: 'يوم',
    );
    return 'آخر نشاط قبل $days $_temp0';
  }

  @override
  String get online => 'متصل';

  @override
  String get callSupport => 'اتصال';

  @override
  String get typeMessage => 'اكتب رسالة...';

  @override
  String get callBusy => 'الدعم مشغول';

  @override
  String get callRejected => 'تم رفض المكالمة';

  @override
  String get callFailed => 'فشلت المكالمة';

  @override
  String get callEnded => 'انتهت المكالمة';

  @override
  String get callSupportBusy => 'الدعم في مكالمة أخرى';

  @override
  String get errorStartingChat => 'خطأ في بدء الدردشة';

  @override
  String get errorStartingCall => 'خطأ في بدء المكالمة';

  @override
  String get errorConnecting => 'خطأ في الاتصال';

  @override
  String get errorAcceptingCall => 'خطأ في قبول المكالمة';

  @override
  String get errorDownloading => 'خطأ في التحميل';

  @override
  String get errorUploading => 'خطأ في الرفع';

  @override
  String get errorSending => 'خطأ في الإرسال';

  @override
  String get errorPickingPhotos => 'خطأ في اختيار الصور';

  @override
  String get errorPickingFiles => 'خطأ في اختيار الملفات';

  @override
  String get errorTakingPhoto => 'خطأ في التقاط الصورة';

  @override
  String get fileNotLoaded => 'لا يمكن تحميل الملف';

  @override
  String get attachmentIdMissing => 'معرف المرفق مفقود';

  @override
  String get camera => 'الكاميرا';

  @override
  String get gallery => 'المعرض';

  @override
  String get file => 'ملف';

  @override
  String typingIndicator(String name) {
    return '$name يكتب...';
  }

  @override
  String get notifNewMessageFrom => 'رسالة جديدة من';

  @override
  String get notifUrgentPrefix => 'عاجل';

  @override
  String get notifUrgentMessage => 'رسالة عاجلة';

  @override
  String get notifIncomingCall => 'مكالمة واردة';

  @override
  String get notifCallingYou => 'يتصل بك...';

  @override
  String get notifUpdateAvailable => 'تحديث متوفر';

  @override
  String get notifVersionAvailable => 'متوفر الآن';

  @override
  String get notifConnected => 'متصل';

  @override
  String get notifDisconnected => 'غير متصل';

  @override
  String get notifConnectedBody => 'أنت متصل بالخادم الآن.';

  @override
  String get notifDisconnectedBody => 'تم فقد الاتصال بالخادم.';

  @override
  String get notifError => 'خطأ';

  @override
  String get retry => 'إعادة المحاولة';

  @override
  String get save => 'حفظ';

  @override
  String get accept => 'قبول';

  @override
  String get selectFile => 'اختر ملفاً';

  @override
  String get dataLoadingText => 'جاري تحميل البيانات...';

  @override
  String get dataSavedSuccess => 'تم حفظ البيانات بنجاح';

  @override
  String get errorSaving => 'خطأ في الحفظ';

  @override
  String get errorLoading => 'خطأ في التحميل';

  @override
  String savedFilename(String filename) {
    return 'تم الحفظ: $filename';
  }

  @override
  String get logsCopied => 'تم نسخ السجلات!';

  @override
  String get diagnosticDataTitle => 'بيانات التشخيص';

  @override
  String get diagnosticDescription =>
      'هل تريد إرسال بيانات تشخيص مجهولة لتحسين التطبيق؟';

  @override
  String get noThanks => 'لا، شكراً';

  @override
  String get yesEnable => 'نعم، تفعيل';

  @override
  String get passwordMinEightChars => 'كلمة المرور 8 أحرف على الأقل';

  @override
  String get passwordChangeSuccess => 'تم تغيير كلمة المرور بنجاح';

  @override
  String get emailChangeError => 'خطأ في تغيير البريد الإلكتروني';

  @override
  String get acceptDocumentCheckbox => 'لقد قرأت المستند وأوافق عليه.';

  @override
  String loadingErrorGeneric(String details) {
    return 'خطأ في التحميل: $details';
  }

  @override
  String get incomingCallTitle => 'مكالمة واردة';

  @override
  String ringingFor(int seconds) {
    return 'رنين منذ $seconds ثانية';
  }

  @override
  String get rejectCall => 'رفض';

  @override
  String get acceptCall => 'قبول';

  @override
  String get unmute => 'إلغاء الكتم';

  @override
  String get mute => 'كتم';

  @override
  String get hangUp => 'إنهاء';

  @override
  String get calling => 'جاري الاتصال...';

  @override
  String autoRejectIn(int seconds) {
    return 'رفض تلقائي خلال $seconds ثانية';
  }

  @override
  String get speakerOn => 'مكبر الصوت';

  @override
  String get speakerOff => 'سماعة الأذن';

  @override
  String get micMuted => 'مكتوم';

  @override
  String get micOn => 'الميكروفون';

  @override
  String get connectionExcellent => 'ممتاز';

  @override
  String get connectionGood => 'جيد';

  @override
  String get connectionWeak => 'ضعيف';

  @override
  String get connectionLost => 'منقطع';

  @override
  String get personalData => 'البيانات الشخصية';

  @override
  String get personalDataSubtitle => 'الاسم، اللقب، العنوان';

  @override
  String get membershipFee => 'رسوم العضوية';

  @override
  String annualFeeYear(String year) {
    return 'الرسوم السنوية $year';
  }

  @override
  String get amount => 'المبلغ:';

  @override
  String get dueBy => 'مستحق بحلول:';

  @override
  String get paid => 'مدفوع';

  @override
  String get versionHistory => 'سجل الإصدارات';

  @override
  String lastUpdated(String date) {
    return 'آخر تحديث: $date';
  }

  @override
  String get noVersionHistory => 'لا يوجد سجل إصدارات';

  @override
  String get failedLoadChangelog => 'فشل تحميل سجل التغييرات';

  @override
  String get callMember => 'اتصل بالعضو';

  @override
  String get closeConversation => 'إغلاق المحادثة';

  @override
  String get chatOffline => 'غير متصل';

  @override
  String get attachFiles => 'إرفاق ملفات (حد أقصى 10، 50 ميغابايت)';

  @override
  String get conversationClosed => 'تم إغلاق هذه المحادثة';

  @override
  String get noMessages => 'لا توجد رسائل';

  @override
  String get goBack => 'رجوع';

  @override
  String get goForward => 'للأمام';

  @override
  String get homePage => 'الرئيسية';

  @override
  String get firstNameLabel => 'الاسم الأول';

  @override
  String get lastNameLabel => 'اسم العائلة';

  @override
  String get streetLabel => 'الشارع';

  @override
  String get houseNumberLabel => 'الرقم';

  @override
  String get postalCodeLabel => 'الرمز البريدي';

  @override
  String get cityLabel => 'المدينة';

  @override
  String get phoneMobileLabel => 'الهاتف (جوال)';

  @override
  String get phoneLandlineLabel => 'الهاتف (أرضي)';

  @override
  String get newEmailLabel => 'بريد إلكتروني جديد';

  @override
  String get currentPasswordLabel => 'كلمة المرور الحالية';

  @override
  String get newPasswordLabel => 'كلمة المرور الجديدة';

  @override
  String get confirmPasswordLabel => 'تأكيد كلمة المرور';

  @override
  String get emailChangedSuccess => 'تم تغيير البريد الإلكتروني بنجاح';

  @override
  String get newPasswordMinChars => 'كلمة مرور جديدة (6 أحرف على الأقل)';

  @override
  String get reasonLabel2 => 'السبب';

  @override
  String get downloadFailed2 => 'فشل التحميل';

  @override
  String get downloadTooltip => 'تحميل';

  @override
  String get connectionErrorGeneric => 'خطأ في الاتصال';

  @override
  String get errorNoInternet => 'لا يوجد اتصال بالإنترنت. يرجى التحقق من شبكتك.';

  @override
  String get errorTimeout => 'الخادم لا يستجيب. يرجى المحاولة لاحقاً.';

  @override
  String get errorServer => 'خطأ في الخادم. يرجى المحاولة لاحقاً.';

  @override
  String get errorConnection => 'خطأ في الاتصال. يرجى المحاولة لاحقاً.';

  @override
  String get errorUnexpected => 'حدث خطأ غير متوقع. يرجى المحاولة لاحقاً.';

  @override
  String get copyLogs => 'نسخ السجلات';

  @override
  String get deleteLogs => 'حذف السجلات';

  @override
  String get autoScrollOn => 'تمرير تلقائي مفعل';

  @override
  String get autoScrollOff => 'تمرير تلقائي معطل';

  @override
  String get unknownValue => 'غير معروف';

  @override
  String get bankTransfer => 'تحويل بنكي';

  @override
  String get standingOrder => 'أمر دائم';

  @override
  String get payment => 'الدفع';

  @override
  String get warningType_ermahnung => 'تنبيه';

  @override
  String get warningType_abmahnung => 'إنذار';

  @override
  String get warningType_letzte => 'إنذار أخير';

  @override
  String warningsTotal(int count) {
    return 'المجموع: $count';
  }

  @override
  String warningsErmahnung(int count) {
    return 'تنبيه: $count';
  }

  @override
  String warningsAbmahnung(int count) {
    return 'إنذار: $count';
  }

  @override
  String warningsLetzte(int count) {
    return 'أخير: $count';
  }

  @override
  String get noWarnings => 'لا توجد تحذيرات';

  @override
  String get noWarningsDescription => 'ليس لديك أي تحذيرات حالياً.';

  @override
  String createdBy(String name) {
    return 'أنشأه: $name';
  }

  @override
  String get monthJan => 'يناير';

  @override
  String get monthFeb => 'فبراير';

  @override
  String get monthMar => 'مارس';

  @override
  String get monthApr => 'أبريل';

  @override
  String get monthMay => 'مايو';

  @override
  String get monthJun => 'يونيو';

  @override
  String get monthJul => 'يوليو';

  @override
  String get monthAug => 'أغسطس';

  @override
  String get monthSep => 'سبتمبر';

  @override
  String get monthOct => 'أكتوبر';

  @override
  String get monthNov => 'نوفمبر';

  @override
  String get monthDec => 'ديسمبر';

  @override
  String get stufe1_name => 'البيانات الشخصية';

  @override
  String get stufe2_name => 'نوع العضوية';

  @override
  String get stufe3_name => 'الوضع المالي';

  @override
  String get stufe4_name => 'طريقة الدفع';

  @override
  String get stufe5_name => 'بدء العضوية';

  @override
  String get stufe6_name => 'النظام الأساسي';

  @override
  String get stufe7_name => 'سياسة الخصوصية';

  @override
  String get stufe8_name => 'حق الانسحاب';

  @override
  String get memberType_ordentlich => 'عضو عادي';

  @override
  String get memberType_foerder => 'عضو داعم';

  @override
  String get memberType_ehren => 'عضو فخري';

  @override
  String get memberDesc_ordentlich =>
      'عضو فعال له حق التصويت. يشارك في خدمات الجمعية (بريد إلكتروني، سحابة، دعم بيروقراطي).';

  @override
  String get memberDesc_foerder =>
      'يدعم الجمعية بالمساهمات. يحضر الجمعية العمومية بصوت استشاري، بدون حق التصويت أو الترشح.';

  @override
  String get memberDesc_ehren =>
      'له حقوق العضو العادي بدون التزام بدفع رسوم. يعينه الجمعية العمومية أو مجلس الإدارة.';

  @override
  String get payMethod_ueberweisung => 'تحويل بنكي';

  @override
  String get payMethod_dauerauftrag => 'أمر دائم';

  @override
  String get verifyStatus_geprueft => 'تم التحقق';

  @override
  String get verifyStatus_ausgefuellt => 'مكتمل';

  @override
  String get verifyStatus_abgelehnt => 'مرفوض';

  @override
  String get verifyStatus_offen => 'مفتوح';

  @override
  String get fillRequiredFields => 'يرجى ملء جميع الحقول المطلوبة.';

  @override
  String get personalDataSaved => 'تم حفظ البيانات الشخصية';

  @override
  String get selectMemberType => 'يرجى اختيار نوع العضوية.';

  @override
  String get memberTypeSaved => 'تم حفظ نوع العضوية';

  @override
  String get selectOption => 'يرجى اختيار خيار.';

  @override
  String get financialSaved => 'تم حفظ الوضع المالي';

  @override
  String get selectPaymentMethod => 'يرجى اختيار طريقة الدفع.';

  @override
  String get paymentDataSaved => 'تم حفظ بيانات الدفع';

  @override
  String get selectDate => 'يرجى اختيار تاريخ.';

  @override
  String get membershipStartSaved => 'تم حفظ بدء العضوية';

  @override
  String get fileTooLarge => 'الملف كبير جداً (الحد الأقصى: 50 ميغابايت)';

  @override
  String get leistungsbescheidUploaded => 'تم رفع شهادة الإعانة بنجاح';

  @override
  String get verificationProgress => 'تقدم التحقق';

  @override
  String get notApplicable => 'لا ينطبق';

  @override
  String get socialBenefitsExempt =>
      'طريقة الدفع غير مطلوبة لمستفيدي الإعانات.';

  @override
  String get locked => 'مقفل';

  @override
  String completePreviousStep(int step) {
    return 'يرجى إكمال المرحلة $step أولاً.';
  }

  @override
  String rejectedNote(String note) {
    return 'مرفوض: $note';
  }

  @override
  String get waitingForReview => 'في انتظار مراجعة مجلس الإدارة.';

  @override
  String get stepApproved => 'تمت مراجعة هذه المرحلة والموافقة عليها.';

  @override
  String get changesViaChat => 'التغييرات ممكنة فقط عبر الدردشة المباشرة.';

  @override
  String get firstNameRequired => 'الاسم الأول *';

  @override
  String get lastNameRequired => 'اسم العائلة *';

  @override
  String get birthDateLabel => 'تاريخ الميلاد *';

  @override
  String get streetRequired => 'الشارع *';

  @override
  String get houseNumberRequired => 'الرقم *';

  @override
  String get cityRequired => 'المدينة *';

  @override
  String get phoneRequired => 'رقم الهاتف *';

  @override
  String get phonePurpose =>
      'الغرض: الاتصال عند عدم إمكانية الوصول عبر التطبيق';

  @override
  String get selectMemberTypePrompt => 'يرجى اختيار نوع العضوية المرغوب:';

  @override
  String get financialExplanation =>
      'للتحقق من أهليتك لتخفيض الرسوم، نحتاج المعلومات التالية. تُستخدم حصرياً لتحديد رسوم عضويتك.';

  @override
  String get socialBenefitsQuestion => 'هل تتلقى حالياً إعانات اجتماعية؟';

  @override
  String get optionBuergergeld => 'نعم، إعانة المواطن (مركز التوظيف)';

  @override
  String get optionSozialamt => 'نعم، إعانات اجتماعية (الشؤون الاجتماعية)';

  @override
  String get optionNoBenefits => 'لا، لا أتلقى إعانات اجتماعية';

  @override
  String get feeExempt => 'رسوم عضويتك الشهرية: 0.00€/شهر';

  @override
  String get uploadLeistungsbescheid => 'رفع شهادة الإعانة';

  @override
  String get uploadLeistungsbescheidHint =>
      'يرجى رفع شهادة إعانة حالية خلال 14 يوماً لتأكيد الإعفاء.';

  @override
  String get allowedFormatsUpload =>
      'الصيغ المسموحة: PDF, JPG, PNG (حد أقصى 10 ميغابايت)';

  @override
  String get feeRegular => 'رسوم عضويتك الشهرية: 25.00€/شهر';

  @override
  String paymentDayReminder(int day) {
    return 'سيتم تذكيرك في $day من كل شهر.';
  }

  @override
  String get membershipStartPrompt => 'اختر متى تبدأ عضويتك.';

  @override
  String get optionAfterVerification => 'بعد اكتمال التحقق';

  @override
  String get optionAfterVerificationDesc =>
      'تبدأ العضوية من يوم تأكيد مجلس الإدارة.';

  @override
  String get optionRetroFoundation => 'بأثر رجعي من تاريخ التأسيس (01.08.2025)';

  @override
  String get optionRetroFoundationDesc =>
      'تصبح عضواً بأثر رجعي من تأسيس الجمعية.';

  @override
  String get optionRetroCustom => 'بأثر رجعي من تاريخ آخر';

  @override
  String get optionRetroCustomDesc => 'اختر تاريخاً بين 01.08.2025 واليوم.';

  @override
  String get selectDateLabel => 'اختر تاريخاً';

  @override
  String get selectDateHint => 'اختر تاريخاً...';

  @override
  String get dateNotBefore => 'ليس قبل 01.08.2025 (تاريخ التأسيس)';

  @override
  String get feeExemptRetro =>
      'معفى من الرسوم: 0.00€ بأثر رجعي.\nيتم تحديد تاريخ العضوية فقط بأثر رجعي.';

  @override
  String get retroactiveFees => 'رسوم بأثر رجعي';

  @override
  String retroFeeCalculation(
      String from, String to, String months, String total) {
    return 'الفترة: $from – $to\nالأشهر: $months\nالرسوم: $months × 25.00€ = $total€';
  }

  @override
  String get pleaseReadSatzung => 'يرجى قراءة النظام الأساسي للجمعية.';

  @override
  String get pleaseReadDatenschutz => 'يرجى قراءة سياسة الخصوصية.';

  @override
  String get pleaseReadWiderruf => 'يرجى قراءة حق الانسحاب.';

  @override
  String get acceptedAtRegistration => 'تم القبول عند التسجيل';

  @override
  String get confirmedByBoard => 'سيتم التأكيد بعد مراجعة مجلس الإدارة.';

  @override
  String get docSatzung => 'النظام الأساسي';

  @override
  String get docDatenschutz => 'سياسة الخصوصية';

  @override
  String get docWiderruf => 'حق الانسحاب';

  @override
  String acceptedAtRegCount(int count) {
    return 'تم القبول عند التسجيل ($count/3)';
  }

  @override
  String acceptedOn(String date) {
    return 'تم القبول في $date';
  }

  @override
  String get notAccepted => 'لم يتم القبول';

  @override
  String get statusAccepted => 'مقبول';

  @override
  String get memberNumberTooLong =>
      'رقم العضوية طويل جداً (الحد الأقصى 20 حرفاً)';

  @override
  String get onlyUppercaseAndNumbers => 'يُسمح فقط بالأحرف الكبيرة والأرقام';

  @override
  String get passwordTooLong => 'كلمة المرور طويلة جداً (الحد الأقصى 100 حرف)';

  @override
  String get nameTooLong => 'الاسم طويل جداً (الحد الأقصى 100 حرف)';

  @override
  String get emailTooLong => 'البريد طويل جداً (الحد الأقصى 255 حرفاً)';

  @override
  String get legalAcknowledgePrefix => 'لقد قرأت ';

  @override
  String get legalAcknowledgeSuffix => ' وأقر بها.';

  @override
  String get legalStatutesSuffix => ' لـ ICD360S e.V. وأعترف بها كملزمة.';

  @override
  String get legalPleaseReadFirst => '(يرجى القراءة أولاً)';

  @override
  String get statusActive => 'نشط';

  @override
  String get statusSuspended => 'معلق';

  @override
  String get statusNew => 'جديد';

  @override
  String get statusCancelled => 'ملغى';

  @override
  String get statusDeleted => 'محذوف';

  @override
  String get roleMitglied => 'عضو';

  @override
  String get roleVorsitzer => 'رئيس';

  @override
  String get roleStellvertreter => 'نائب الرئيس';

  @override
  String get roleSchatzmeister => 'أمين الصندوق';

  @override
  String get roleSchriftfuehrer => 'أمين السر';

  @override
  String get roleBeisitzer => 'عضو مجلس';

  @override
  String get roleKassierer => 'أمين الصندوق';

  @override
  String get roleKassenpruefer => 'مدقق الحسابات';

  @override
  String get roleEhrenamtlich => 'متطوع';

  @override
  String get roleMitgliedergruender => 'عضو مؤسس';

  @override
  String get roleEhrenmitglied => 'عضو فخري';

  @override
  String get roleFoerdermitglied => 'عضو داعم';

  @override
  String get memberTypeNotSet => 'لم يتم تحديده';

  @override
  String get payMethodSepa => 'خصم SEPA المباشر';

  @override
  String get labelStatus => 'الحالة';

  @override
  String get labelMemberNumber => 'رقم العضوية';

  @override
  String get labelRole => 'الدور';

  @override
  String get labelMemberType => 'نوع العضوية';

  @override
  String get labelPaymentMethod => 'طريقة الدفع';

  @override
  String get labelRegisteredOn => 'تاريخ التسجيل';

  @override
  String get labelLastLogin => 'آخر تسجيل دخول';

  @override
  String get labelMemberSince => 'عضو منذ';

  @override
  String get neverLoggedIn => 'لم يسجل الدخول أبداً';

  @override
  String get notActivatedYet => 'لم يتم التفعيل بعد';

  @override
  String get tabVerification => 'التحقق';

  @override
  String get tabWarnings => 'التحذيرات';

  @override
  String get tabDocuments => 'المستندات';

  @override
  String get tabMembership => 'العضوية';

  @override
  String get pleaseEnterFirstName => 'الرجاء إدخال الاسم الأول';

  @override
  String get pleaseEnterLastName => 'الرجاء إدخال اسم العائلة';

  @override
  String get noFileDataReceived => 'لم يتم استلام بيانات الملف';

  @override
  String get openFile => 'فتح';

  @override
  String get diagnosticErrors => 'تقارير أخطاء للتحسين';

  @override
  String get diagnosticAnonymousStats => 'إحصائيات استخدام مجهولة';

  @override
  String get diagnosticPerformance => 'بيانات أداء التطبيق';

  @override
  String get noMicrophoneError =>
      'لم يتم العثور على ميكروفون. يرجى توصيل ميكروفون والمحاولة مرة أخرى.';

  @override
  String get startConversation => 'ابدأ محادثة!';

  @override
  String get staffWillReply => 'سيرد عليك أحد الموظفين قريباً.';

  @override
  String get inCall => 'في مكالمة...';

  @override
  String get registration => 'التسجيل';

  @override
  String get deactivation => 'التعطيل';

  @override
  String get deactivatedOn => 'تم التعطيل في';

  @override
  String get accountAutoSuspend =>
      'الحسابات التي لا يتم التحقق منها خلال 30 يوماً يتم تعليقها تلقائياً.';

  @override
  String get ipClean => 'IP نظيف - غير مدرج';

  @override
  String get documentsProvidedByBoard =>
      'يتم توفير المستندات من قبل مجلس الإدارة.';

  @override
  String get noDocumentsAvailable => 'لا توجد مستندات';

  @override
  String get noDocumentsDescription => 'لم يتم توفير أي مستندات لك بعد.';

  @override
  String uploadedBy(String name) {
    return 'رفعه: $name';
  }

  @override
  String stepsCompleted(int completed, int total) {
    return '$completed/$total مراحل مكتملة';
  }

  @override
  String dayOfMonth(int day) {
    return '$day. من الشهر';
  }

  @override
  String changeField(String field) {
    return 'تغيير $field';
  }

  @override
  String openDocument(String name) {
    return 'فتح $name';
  }

  @override
  String get helpImproveApp => 'هل تريد مساعدتنا في تحسين التطبيق؟';

  @override
  String get noPersonalDataCollected =>
      'لا يتم جمع بيانات شخصية. يمكن تغيير هذا الإعداد في أي وقت.';

  @override
  String logEntries(int count) {
    return '$count إدخالات';
  }

  @override
  String get noLogs => 'لا توجد سجلات';

  @override
  String get newLoginDetected => 'تم اكتشاف تسجيل دخول جديد';

  @override
  String get waitingForMember => 'في انتظار العضو';

  @override
  String get waitingForStaff => 'في انتظار الموظف';

  @override
  String get waitingForAuthority => 'في انتظار الجهة المختصة';
}
