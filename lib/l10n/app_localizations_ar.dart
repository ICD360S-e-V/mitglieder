// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

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
  String get confirmPassword => 'تأكيد كلمة المرور';

  @override
  String get confirmPasswordHint => 'تأكيد كلمة المرور';

  @override
  String get newPassword => 'كلمة المرور الجديدة';

  @override
  String get newPasswordHint => 'أدخل كلمة المرور الجديدة';

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
  String get unknown => 'غير معروف';

  @override
  String error(String error) {
    return 'خطأ';
  }

  @override
  String get cancel => 'إلغاء';

  @override
  String get resetPassword => 'إعادة تعيين كلمة المرور';

  @override
  String get imprint => 'بيانات النشر';

  @override
  String get privacy => 'سياسة الخصوصية';

  @override
  String get statutes => 'النظام الأساسي';

  @override
  String get revocation => 'حق الانسحاب';

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
  String get myAppointments => 'مواعيدي';

  @override
  String get priority => 'الأولوية';

  @override
  String get messageLabel => 'الرسالة';

  @override
  String get reportProblems => 'الإبلاغ عن مشاكل';

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
  String get low => 'منخفض';

  @override
  String get high => 'مرتفع';

  @override
  String get submit => 'إرسال';

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
  String get saveEmail => 'حفظ البريد الإلكتروني';

  @override
  String get savePassword => 'حفظ كلمة المرور';

  @override
  String get deviceLoggedOut => 'تم تسجيل خروج الجهاز';

  @override
  String get emailChangedSuccessfully => 'تم تغيير البريد الإلكتروني بنجاح';

  @override
  String get errorChangingPassword => 'خطأ في تغيير كلمة المرور';

  @override
  String get errorChangingEmail => 'خطأ في تغيير البريد الإلكتروني';

  @override
  String get validEmailRequired => 'يرجى إدخال بريد إلكتروني صالح';

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
  String get autoUpdateEnableTitle => 'Install future updates automatically';

  @override
  String get autoUpdateEnableHint =>
      'The app downloads and installs updates on its own and restarts briefly. No further prompts.';

  @override
  String autoUpdateInstalling(String version) {
    return 'Version $version is being installed in the background. The app will restart shortly.';
  }

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
  String get reasonLabel2 => 'السبب';

  @override
  String get downloadFailed2 => 'فشل التحميل';

  @override
  String get downloadTooltip => 'تحميل';

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
  String logEntries(int count) {
    return '$count إدخالات';
  }

  @override
  String get noLogs => 'لا توجد سجلات';

  @override
  String get newLoginDetected => 'تم اكتشاف تسجيل دخول جديد';

  @override
  String get errorNoInternet =>
      'لا يوجد اتصال بالإنترنت. يرجى التحقق من شبكتك.';

  @override
  String get errorTimeout => 'الخادم لا يستجيب. يرجى المحاولة لاحقاً.';

  @override
  String get errorServer => 'خطأ في الخادم. يرجى المحاولة لاحقاً.';

  @override
  String get errorConnection => 'خطأ في الاتصال. يرجى المحاولة لاحقاً.';

  @override
  String get errorUnexpected => 'حدث خطأ غير متوقع. يرجى المحاولة لاحقاً.';

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
  String get claudiuWelcomeMorning => 'صباح الخير';

  @override
  String get claudiuWelcomeDay => 'مرحبًا';

  @override
  String get claudiuWelcomeEvening => 'مساء الخير';

  @override
  String get claudiuWelcomeNight => 'مساء الخير';

  @override
  String get claudiuWelcomeVisitor => 'عزيزي الزائر';

  @override
  String get claudiuWelcomeAsk => 'كيف يمكنني مساعدتك؟';

  @override
  String get claudiuWelcomeBecomeMember => 'أريد أن أصبح عضوًا';

  @override
  String get claudiuWelcomeLogin => 'أنا عضو بالفعل وأريد تسجيل الدخول';

  @override
  String get claudiuWelcomeProblem => 'لدي مشكلة مع التطبيق';

  @override
  String get claudiuWelcomeEmergency => 'طارئ — اتصل بنا';

  @override
  String get claudiuWelcomeMascotName => 'Claudiu';

  @override
  String get claudiuWelcomeEmergencyIntro => 'قبل أن تتصل — ساعات العمل لدينا:';

  @override
  String get claudiuWelcomeScheduleOffice => 'في المكتب';

  @override
  String get claudiuWelcomeScheduleField => 'في الميدان مع عملائنا';

  @override
  String get claudiuWelcomeOutsideHoursNote =>
      'خارج هذه الساعات نتعامل فقط مع الحالات الطارئة. يمكنك أيضًا مراسلتنا بنفس الرقم — سنرد عليك.';

  @override
  String get claudiuWelcomeCallNow => 'اتصل بنا الآن';

  @override
  String get claudiuWelcomeSendSms => 'إرسال رسالة';

  @override
  String get claudiuWelcomeSmsBody =>
      'حالة طارئة في ICD360S e.V. — يرجى التواصل معي في أقرب وقت ممكن.';

  @override
  String get claudiuWelcomeCloseButton => 'إغلاق';

  @override
  String get claudiuLoginWelcome => 'مرحبًا بعودتك، عزيزي العضو!';

  @override
  String get claudiuLoginAsk => 'من فضلك أخبرني برقم عضويتك.';

  @override
  String get claudiuLoginProgress => 'اقتربنا… استمر في الكتابة.';

  @override
  String get claudiuLoginReady => 'ممتاز! اضغط الزر أدناه.';

  @override
  String get claudiuLoginLoading => 'أتحقق من الهوية… 🔍';

  @override
  String get claudiuLoginFoundPlain => 'وجدتك! جاري تسجيل الدخول…';

  @override
  String claudiuLoginFoundNamed(String name) {
    return 'وجدتك يا $name! جاري تسجيل الدخول…';
  }

  @override
  String get claudiuLoginError =>
      'حسنًا، لم أجد هذا الرقم. هل كتبته بشكل صحيح؟';

  @override
  String get claudiuLoginForgotHeader => 'نسيت رقم عضويتك؟';

  @override
  String get claudiuLoginNoSms =>
      'لا نرسل الرقم عبر البريد الإلكتروني أو الرسائل القصيرة.';

  @override
  String get claudiuLoginOnlyWay =>
      'الطريقة الوحيدة: مقابلتنا شخصيًا في مكتب الجمعية، بعد التحقق من الهوية.';

  @override
  String get claudiuLoginContactUs => 'اتصل بنا لحجز موعد:';

  @override
  String get claudiuDiagnosticGreeting => 'قبل أن تدخل، سؤال سريع';

  @override
  String get claudiuDiagnosticAsk =>
      'هل يمكنني إرسال تقارير مجهولة الهوية ليتمكن المطورون من تحسين التطبيق؟';

  @override
  String get claudiuDiagnosticYes => 'نعم، أود المساعدة';

  @override
  String get claudiuDiagnosticNo => 'لا، أنا أتصفح فقط';

  @override
  String get claudiuDiagnosticTellMore => 'أخبرني المزيد';

  @override
  String get claudiuDiagnosticSendsHeader =>
      '📤 ما الذي نُرسله (مجهول الهوية):';

  @override
  String get claudiuDiagnosticSends1 =>
      'رمز جهاز مجهول الهوية (ليس رقم العضوية)';

  @override
  String get claudiuDiagnosticSends2 => 'دورك (عضو / مجلس إدارة)';

  @override
  String get claudiuDiagnosticSends3 =>
      'نظام التشغيل (Linux / Android / iOS / Windows)';

  @override
  String get claudiuDiagnosticSends4 => 'اللغة المختارة';

  @override
  String get claudiuDiagnosticSends5 => 'مستوى وحالة البطارية';

  @override
  String get claudiuDiagnosticSends6 => 'الشاشة الحالية';

  @override
  String get claudiuDiagnosticSends7 => 'مدة الجلسة (ثوانٍ)';

  @override
  String get claudiuDiagnosticSends8 => 'الأخطاء إن وجدت (آخر 10)';

  @override
  String get claudiuDiagnosticSends9 => 'التنقل (آخر 20 شاشة)';

  @override
  String get claudiuDiagnosticNeverHeader => '🛡️ ما الذي لا نُرسله أبدًا:';

  @override
  String get claudiuDiagnosticNever1 => 'اسمك الحقيقي';

  @override
  String get claudiuDiagnosticNever2 => 'البريد الإلكتروني';

  @override
  String get claudiuDiagnosticNever3 => 'رقم الهاتف';

  @override
  String get claudiuDiagnosticNever4 => 'كلمة المرور';

  @override
  String get claudiuDiagnosticNever5 => 'محتوى رسائل الدردشة';

  @override
  String get claudiuDiagnosticNever6 => 'محتوى التذاكر';

  @override
  String get claudiuDiagnosticNever7 => 'الوثائق أو المرفقات';

  @override
  String get claudiuDiagnosticTechHeader => '📡 التفاصيل التقنية:';

  @override
  String get claudiuDiagnosticTech1 => 'يُرسل كل دقيقتين';

  @override
  String get claudiuDiagnosticTech2 => 'اتصال مشفر بـ TLS بشهادة مثبتة';

  @override
  String get claudiuDiagnosticTech3 => 'يمكنك إيقافه في أي وقت من الإعدادات';

  @override
  String get claudiuProblemHelpTitle => 'كيف يمكنني المساعدة؟';

  @override
  String get claudiuProblemHelpGreeting => 'ماذا حدث؟';

  @override
  String get claudiuProblemHelpAsk => 'كيف تريد أن تخبرني؟';

  @override
  String get claudiuProblemHelpWriteTitle => 'كتابة تقرير';

  @override
  String get claudiuProblemHelpWriteBody =>
      'بتفاصيل خطوة بخطوة. يستلم الفريق النص ويحلّه لاحقًا.';

  @override
  String get claudiuProblemHelpChatTitle => 'لنتحدث الآن';

  @override
  String get claudiuProblemHelpChatBody =>
      'دردشة مجهولة مع موظف. رد فوري إذا كان أحد متصلًا.';

  @override
  String get claudiuProblemHelpAltCallHeader => 'أو إذا كان الأمر طارئًا:';

  @override
  String get claudiuProblemHelpAltCallLabel => 'اتصل بنا';

  @override
  String get claudiuAnonymousChatTitle => 'دردشة مجهولة';

  @override
  String get claudiuAnonymousChatGreeting => 'مرحبًا!';

  @override
  String get claudiuAnonymousChatWelcome =>
      'أنا أسمعك. اكتب ما تريد — لا حاجة للاسم. سأرد فور وصولي.';

  @override
  String get claudiuAnonymousChatHint => 'اكتب رسالة…';

  @override
  String get claudiuAnonymousChatWaitingOperator => 'في انتظار رد الموظف…';

  @override
  String get claudiuVorsitzerConnectedTitle => 'مرحبًا!';

  @override
  String get claudiuVorsitzerConnectedBody =>
      'شكرًا على تواصلك — أنت الآن متصل بـ Vorsitzer. أخبرنا كيف يمكننا مساعدتك في طلب العضوية.';

  @override
  String get claudiuVorsitzerConnectedSender => 'Vorsitzer';

  @override
  String get claudiuQuickReplyValidationTime => 'كم تستغرق عملية التحقق؟';

  @override
  String get claudiuQuickReplyDocuments => 'ما المستندات التي أحتاجها؟';

  @override
  String get claudiuQuickReplyStepProblem => 'أنا عالق في إحدى الخطوات';

  @override
  String get claudiuQuickReplyHuman => 'هل يمكنني التحدث مع شخص الآن؟';

  @override
  String get claudiuAnonymousChatConnecting => 'جاري الاتصال…';

  @override
  String get claudiuAnonymousChatConnectionFailed =>
      'تعذر فتح الدردشة. حاول مرة أخرى أو اتصل بنا.';

  @override
  String get claudiuAnonymousChatRetry => 'حاول مجددًا';

  @override
  String get claudiuAnonymousChatOnline => 'متصل';

  @override
  String get claudiuAnonymousChatOffline => 'إعادة الاتصال…';

  @override
  String get claudiuAnonymousChatAdminTyping => 'الموظف يكتب…';

  @override
  String get claudiuProblemReportTitle => 'الإبلاغ عن مشكلة';

  @override
  String get claudiuProblemReportGreeting => 'ماذا حدث؟';

  @override
  String get claudiuProblemReportAsk =>
      'أخبرني بالتفاصيل وسأرسل التقرير إلى الفريق.';

  @override
  String get claudiuProblemReportIncludeHeader => 'يرجى تضمين:';

  @override
  String get claudiuProblemReportIncludeBullets1 =>
      'ماذا كنت تفعل عند ظهور المشكلة';

  @override
  String get claudiuProblemReportIncludeBullets2 => 'أي رسالة خطأ رأيتها';

  @override
  String get claudiuProblemReportIncludeBullets3 => 'على أي شاشة كنت';

  @override
  String get claudiuProblemReportIncludeBullets4 =>
      'هل يتعطل التطبيق؟ هل يُغلق؟ هل يظهر شاشة بيضاء؟';

  @override
  String get claudiuProblemReportIncludeBullets5 =>
      'هل يحدث في كل مرة أم مرة واحدة فقط؟';

  @override
  String get claudiuProblemReportDescriptionLabel => 'وصفك';

  @override
  String get claudiuProblemReportDescriptionHint =>
      'مثال: عند فتح شاشة الدردشة تظهر رسالة \"Connection error\" ويتوقف التطبيق عن الاستجابة…';

  @override
  String claudiuProblemReportTooShort(int count) {
    return 'مزيد من التفاصيل من فضلك (الحد الأدنى $count حرفًا)';
  }

  @override
  String get claudiuProblemReportSubmit => 'إرسال التقرير';

  @override
  String get claudiuProblemReportSubmitting => 'جاري الإرسال…';

  @override
  String get claudiuProblemReportSentTitle => 'شكرًا لك!';

  @override
  String get claudiuProblemReportSentBody =>
      'تم إرسال التقرير. سيراجعه فريقنا في أقرب وقت ممكن.';

  @override
  String get claudiuProblemReportSentClose => 'فهمت';

  @override
  String get claudiuProblemReportSendFailed =>
      'تعذر إرسال التقرير. اتصل بنا للمساعدة العاجلة.';

  @override
  String get claudiuProblemReportAlt => 'أو إذا كان الأمر طارئًا:';

  @override
  String get claudiuProblemReportCallLabel => 'اتصل بنا';

  @override
  String claudiuApprovalGreeting(String name) {
    return 'مرحبًا، $name! 👋';
  }

  @override
  String get claudiuApprovalGreetingNoName => 'مرحبًا! 👋';

  @override
  String get claudiuApprovalGladToSeeYou => 'سعيد بقدومك!';

  @override
  String get claudiuApprovalCheckingForSafety =>
      'لسلامتك، يقوم Vorsitzer الآن بمراجعة طلب تسجيل الدخول الخاص بك. 🛡️';

  @override
  String get claudiuApprovalMonthlyExplain =>
      '💡 نقوم بهذا كل 30 يومًا للتأكد من أنك أنت حقًا. اعتبره فحصًا أمنيًا — يستغرق 5 دقائق كحد أقصى.';

  @override
  String get claudiuApprovalSuccess =>
      'تم! 🎉 لقد تعرف عليك Vorsitzer. جاري تسجيل دخولك…';

  @override
  String get claudiuApprovalDenied => 'حسنًا، رفض Vorsitzer طلبك. 😔';

  @override
  String get claudiuApprovalDeniedHelp =>
      'إذا كنت تعتقد أن هذا خطأ، يرجى الاتصال بنا لنوضح الأمر.';

  @override
  String get claudiuApprovalExpired =>
      'مرت 5 دقائق ولم نتلقَ ردًا من Vorsitzer.';

  @override
  String get claudiuApprovalExpiredHelp =>
      'اتصل بنا ويمكننا الموافقة على طلبك مباشرةً. 📞';

  @override
  String get claudiuApprovalCallUs => 'اتصل بنا';

  @override
  String get claudiuApprovalTryAgain => 'حاول مجددًا';

  @override
  String get claudiuApprovalCancel => 'إلغاء';

  @override
  String get claudiuApprovalClose => 'إغلاق';

  @override
  String get wizardIntroBubble1 =>
      'مرحبًا أيها الزائر! 👋 شكرًا لك على رغبتك في الانضمام إلى عائلتنا.';

  @override
  String get wizardIntroBubble2 =>
      'اسمي كلاوديو. في ربيع 2025 كانت لدي رؤية واضحة: إنشاء جمعية تساعد المحتاجين — تطوعيًا، من القلب، دون بيروقراطية معقدة. ❤️';

  @override
  String get wizardIntroBubble3 =>
      'بدأت بالتحدث مع العملاء الذين أزورهم. أخبرتهم بحلمي. وقال كل واحد منهم: \"نعم، لنفعلها!\" في يوليو 2025 التقينا — 6 أشخاص مصممون. قررنا تأسيس **ICD360S e.V.** في نوي-أولم. 📍';

  @override
  String get wizardIntroBubble4 =>
      'في **1 أغسطس 2025**، ولدت الجمعية رسميًا — في سجل الجمعيات. أجمل هدية لي. 🎂';

  @override
  String get wizardIntroBubble5 =>
      'ماذا نفعل؟ نساعد اللاجئين، ذوي الإعاقة، المحرومين اقتصاديًا، **الأطفال والشباب** — في المسائل الإدارية، تعلم الألمانية، السكن، التسوق، الإعانات الاجتماعية. مجلس إدارتنا يتكون في الغالب من أشخاص ذوي إعاقة — هكذا تأتي القرارات من تجربة حياتية حقيقية. 🤝';

  @override
  String get wizardIntroBubble6 =>
      'الآن دورك. دعنا نسجلك — يستغرق حوالي 5 دقائق. سنسير خطوة بخطوة، لن أتركك وحدك. ✨';

  @override
  String get wizardIntroStart => 'لنبدأ';

  @override
  String get wizardBack => 'رجوع';

  @override
  String get wizardNext => 'التالي';

  @override
  String wizardStepLabel(int step, int total, String title) {
    return 'الخطوة $step من $total · $title';
  }

  @override
  String get wizardErrRequired => 'هذا الحقل مطلوب';

  @override
  String wizardErrTooShort(int count) {
    return 'قصير جدًا (الحد الأدنى $count حرفًا)';
  }

  @override
  String get wizardErrOnlyLetters =>
      'الحروف والمسافات والشرطات والفواصل العلوية فقط';

  @override
  String get wizardErrSaveFailed =>
      'تعذر الحفظ. تحقق من اتصالك وحاول مرة أخرى.';

  @override
  String get wizardStufe1aTitle => 'الهوية';

  @override
  String get wizardStufe1aPrompt =>
      'لنتعرف عليك رسميًا. اكتب اسمك تمامًا كما يظهر على بطاقة الهوية (Personalausweis) أو جواز السفر (Reisepass) أو تصريح الإقامة (Aufenthaltstitel) — حتى يكون متطابقًا مع وثائقك.';

  @override
  String get wizardStufe1aVornameLabel => 'Vornamen (الأسماء الأولى)';

  @override
  String get wizardStufe1aVornameHelper =>
      'كل أسمائك الأولى تمامًا كما في الوثيقة. استخدم مسافة أو شرطة (مثلاً Hans-Peter أو Maria Anna).';

  @override
  String get wizardStufe1aNachnameLabel => 'Familienname (اللقب)';

  @override
  String get wizardStufe1aNachnameHelper => 'لقبك الحالي.';

  @override
  String get wizardStufe1aGeburtsnameLabel =>
      'Geburtsname (اسم الميلاد) — اختياري';

  @override
  String get wizardStufe1aGeburtsnameHelper =>
      'فقط إذا كان يختلف عن Familienname — مثلاً قبل الزواج.';

  @override
  String get wizardStufe1bTitle => 'عيد الميلاد';

  @override
  String get wizardStufe1bPrompt =>
      'نود الاحتفال بعيد ميلادك معك! 🎂 ويساعدنا أيضًا للتأكد أنك على الأقل 16 سنة — هذا ما يقوله نظامنا الأساسي (Satzung).';

  @override
  String get wizardStufe1bGeburtsdatumLabel => 'تاريخ الميلاد';

  @override
  String get wizardStufe1bGeburtsdatumHelper => 'اضغط لاختيار التاريخ';

  @override
  String get wizardStufe1bGeburtsortLabel => 'مكان الميلاد';

  @override
  String get wizardStufe1bGeburtsortHelper =>
      'المدينة / البلدة التي ولدت فيها.';

  @override
  String get wizardAgeGatePrompt => 'آسف… 😔';

  @override
  String wizardAgeGateBody1(int age, int years) {
    return 'يقول نظامنا الأساسي إنه يجب أن تكون على الأقل 16 سنة للانضمام. عمرك $age — أتمنى أن أراك بعد $years سنوات! 🌱';
  }

  @override
  String get wizardAgeGateBody2 =>
      'إذا أردت التطوع بشكل عرضي (في أي عمر، بموافقة الوالدين)، اتصل بنا — يسعدنا دعم الشباب الذين يريدون تغيير العالم.';

  @override
  String get wizardAgeGateBackHome => 'العودة إلى البداية';

  @override
  String get wizardErrInvalidPhone => 'رقم هاتف غير صحيح';

  @override
  String get wizardStufe1b1Title => 'موافقة الوالدين';

  @override
  String get wizardStufe1b1Prompt =>
      'أنت قاصر (16-17) — وفقًا للمادة §106 من القانون المدني الألماني نحتاج إلى موافقة أحد الوالدين أو الوصي القانوني. أخبرني باسمه ورقم هاتفه. سيتصل به Vorsitzer ويرتب لقاء (شخصيًا أو عبر مكالمة فيديو). لا بريد إلكتروني — نريد التأكد أننا نتحدث مع الشخص الحقيقي.';

  @override
  String get wizardStufe1b1VornameLabel => 'اسم الوالد';

  @override
  String get wizardStufe1b1VornameHelper => 'كما يظهر في بطاقة هوية الوالد.';

  @override
  String get wizardStufe1b1NachnameLabel => 'لقب الوالد';

  @override
  String get wizardStufe1b1NachnameHelper => 'كما يظهر في بطاقة هوية الوالد.';

  @override
  String get wizardStufe1b1TelefonLabel => 'رقم هاتف الوالد';

  @override
  String get wizardStufe1b1TelefonHelper => 'سيتصل Vorsitzer على هذا الرقم.';

  @override
  String get wizardStufe1b1RelationLabel => 'العلاقة بالطفل:';

  @override
  String get wizardStufe1b1RelationMutter => 'الأم';

  @override
  String get wizardStufe1b1RelationVater => 'الأب';

  @override
  String get wizardStufe1b1RelationSorgeberechtigter => 'الوصي القانوني';

  @override
  String get wizardStufe1b1RelationAndere => 'وصي آخر';

  @override
  String get wizardStufe1cTitle => 'تفاصيل شخصية';

  @override
  String get wizardStufe1cPrompt =>
      'فقط لأتعرف عليك أكثر قليلاً. هذه المعلومات تبقى بيننا ولا تظهر في أي مكان علني.';

  @override
  String get wizardStufe1cGeschlechtLabel => 'الجنس';

  @override
  String get wizardStufe1cGeschlechtMaennlich => 'ذكر';

  @override
  String get wizardStufe1cGeschlechtWeiblich => 'أنثى';

  @override
  String get wizardStufe1cGeschlechtDivers => 'متنوع';

  @override
  String get wizardStufe1cGeschlechtKeineAngabe => 'أفضل عدم القول';

  @override
  String get wizardStufe1cFamilienstandLabel => 'الحالة الاجتماعية';

  @override
  String get wizardStufe1cFamilienstandLedig => 'أعزب / عزباء';

  @override
  String get wizardStufe1cFamilienstandVerheiratet => 'متزوج / متزوجة';

  @override
  String get wizardStufe1cFamilienstandGeschieden => 'مطلق / مطلقة';

  @override
  String get wizardStufe1cFamilienstandVerwitwet => 'أرمل / أرملة';

  @override
  String get wizardStufe1dTitle => 'خلفيتك';

  @override
  String get wizardStufe1dPrompt =>
      'يساعدنا هذا في تقديم الدعم المناسب — على سبيل المثال استشارة بخصوص الإقامة (Aufenthalt) أو إيجاد مجتمعك اللغوي.';

  @override
  String get wizardStufe1dStaatLabel => 'الجنسية';

  @override
  String get wizardStufe1dStaatHelper =>
      'مثلاً: deutsch، rumänisch، ukrainisch. عدة بفواصل.';

  @override
  String get wizardStufe1dAufenthaltLabel =>
      'حالة الإقامة (Aufenthaltsstatus) — اختياري';

  @override
  String get wizardStufe1dAufenthaltHelper =>
      'اختر العنوان من Aufenthaltskarte / خطاب القرار الخاص بك. يقارنه Vorstand بمستنداتك.';

  @override
  String get wizardStufe1dAufenthaltAwaitingCitizenship =>
      'املأ الجنسية أعلاه أولاً — سنعرض فقط الخيارات المناسبة.';

  @override
  String get wizardStufe1dAufenthaltGerman =>
      'لا حاجة إلى Aufenthaltstitel — مواطن ألماني.';

  @override
  String get wizardStufe1dAufenthaltEuEea =>
      'مواطن الاتحاد الأوروبي/EEA/سويسرا — حرية التنقل (Freizügigkeit).';

  @override
  String get wizardStufe1dAufenthaltTempHint => 'مؤقت';

  @override
  String get wizardStufe1dAufenthaltPermHint => 'إقامة دائمة';

  @override
  String get wizardStufe1dAufenthaltAsylumProcessHint => 'إجراء اللجوء';

  @override
  String get wizardStufe1dAufenthaltOther => 'أخرى (يرجى التحديد في الدردشة)';

  @override
  String get wizardStufe1dAufenthaltRequired => 'يرجى اختيار Aufenthaltstitel.';

  @override
  String get wizardStufe1dMutterspracheLabel => 'اللغة الأم';

  @override
  String get wizardStufe1dMutterspracheHelper =>
      'تم تعبئتها بلغة التطبيق — غيّرها إن كانت مختلفة.';

  @override
  String get wizardStufe1eTitle => 'العنوان';

  @override
  String get wizardStufe1ePrompt =>
      'عنوانك البريدي — نستخدمه للوثائق الرسمية (النظام الأساسي، عقود العضوية، الإشعارات).';

  @override
  String get wizardStufe1eStrasseLabel => 'الشارع';

  @override
  String get wizardStufe1eStrasseHelper =>
      'اسم الشارع فقط — رقم المنزل في الحقل المجاور.';

  @override
  String get wizardStufe1eHausnummerLabel => 'الرقم';

  @override
  String get wizardStufe1ePlzLabel => 'PLZ (الرمز البريدي)';

  @override
  String get wizardStufe1eOrtLabel => 'المدينة';

  @override
  String get wizardStufe1eLandLabel => 'البلد';

  @override
  String get wizardStufe1eLandHelper => 'تم تعبئتها مسبقًا بـ Deutschland.';

  @override
  String get wizardErrInvalidStreet => 'اسم شارع غير صحيح';

  @override
  String get wizardErrInvalidHausnummer => 'رقم غير صحيح (مثلاً 12, 12a, 12/3)';

  @override
  String get wizardErrInvalidPlz => 'رمز بريدي غير صحيح (أرقام فقط)';

  @override
  String get wizardStufe1fTitle => 'الاتصال';

  @override
  String get wizardStufe1fPrompt =>
      'كيف يمكننا التواصل معك؟ الهاتف للطوارئ فقط — كل شيء آخر يمر عبر قناتنا داخل التطبيق المشفّرة من طرف إلى طرف. يُخصَّص لك بريد العضوية تلقائيًا ويظهر أدناه.';

  @override
  String get wizardStufe1fTelefonLabel => 'الهاتف المحمول';

  @override
  String get wizardStufe1fTelefonHelper =>
      'وعد، لن أتصل إلا في الأمور المهمة. 📱';

  @override
  String get wizardStufe2Title => 'نوع العضوية';

  @override
  String get wizardStufe2Prompt =>
      'أي نوع من العضوية تريد؟ دعني أشرح لك كل خيار.';

  @override
  String get wizardStufe2OrdentlichTitle => 'عضو عادي (ordentlich)';

  @override
  String get wizardStufe2OrdentlichBody =>
      'حقوق كاملة. تدفع الاشتراك الشهري، تصوت في الاجتماع العام، يمكنك أن تُنتخب في مجلس الإدارة. الخيار الافتراضي.';

  @override
  String get wizardStufe2FoerderTitle => 'عضو داعم (Fördermitglied)';

  @override
  String get wizardStufe2FoerderBody =>
      'تدعم الجمعية ماليًا لكن لا تشارك بنشاط في القرارات. لا حق تصويت. مناسب إذا أردت المساعدة عن بُعد.';

  @override
  String get wizardStufe2EhrenTitle => 'عضو فخري (Ehrenmitglied)';

  @override
  String get wizardStufe2EhrenBody =>
      'يُمنح من قبل مجلس الإدارة لمزايا خاصة. لا تختاره بنفسك — يُمنح كاعتراف. اختر فقط إذا تم تكريمك بالفعل.';

  @override
  String get wizardStufe3Title => 'الوضع المالي';

  @override
  String get wizardStufe3Prompt =>
      'الآن عن وضعك المالي. ليس للحكم عليك — بل لإعفائك من الاشتراك إذا كنت تتلقى مساعدات اجتماعية.';

  @override
  String get wizardStufe3OptionBuergergeld => 'أتلقى Bürgergeld';

  @override
  String get wizardStufe3OptionSozialamt => 'أتلقى مساعدات من Sozialamt';

  @override
  String get wizardStufe3OptionNein => 'لا أتلقى أيًا منها';

  @override
  String get wizardStufe3FeeExemptTitle => 'الاشتراك: 0 € / شهر 🎉';

  @override
  String get wizardStufe3FeeExemptBody =>
      'مع Bürgergeld أو Sozialamt أو ALG I أو Krankengeld أنت معفى كاملاً من الاشتراك بموجب §6 من النظام الأساسي. نحتاج فقط إلى إثبات (Leistungsbescheid أو شهادة من السلطة / صندوق التأمين الصحي).';

  @override
  String get wizardStufe3UploadTitle => 'رفع Leistungsbescheid';

  @override
  String get wizardStufe3UploadHint => 'PDF / JPG / PNG، 10 ميجابايت كحد أقصى.';

  @override
  String get wizardStufe3UploadRequired =>
      'يرجى رفع Leistungsbescheid قبل المتابعة.';

  @override
  String get wizardStufe3FileTooLarge =>
      'الملف كبير جدًا. 10 ميجابايت كحد أقصى.';

  @override
  String get wizardStufe3UploadFailed => 'تعذر رفع الملف. حاول مرة أخرى.';

  @override
  String get wizardStufe3RegularFeeTitle => 'الاشتراك: 25 € / شهر';

  @override
  String get wizardStufe3RegularFeeBody =>
      'الاشتراك القياسي للأعضاء العاديين وفقًا للنظام الأساسي.';

  @override
  String get wizardStufe4Title => 'الدفع';

  @override
  String get wizardStufe4Prompt =>
      'كيف تريد دفع الاشتراك؟ وفي أي يوم من الشهر ترغب في الخصم؟';

  @override
  String get wizardStufe4MethodUeberweisungTitle => 'تحويل بنكي (Überweisung)';

  @override
  String get wizardStufe4MethodUeberweisungBody =>
      'تقوم بإجراء الدفعة يدويًا كل شهر من حسابك.';

  @override
  String get wizardStufe4MethodSepaTitle => 'SEPA-Lastschrift (خصم مباشر)';

  @override
  String get wizardStufe4MethodSepaBody =>
      'نسحب المبلغ تلقائيًا من حسابك. الأكثر راحة، لكن نحتاج إلى IBAN وتفويض موقع.';

  @override
  String get wizardStufe4MethodDauerauftragTitle => 'Dauerauftrag (أمر دائم)';

  @override
  String get wizardStufe4MethodDauerauftragBody =>
      'تقوم بإعداد أمر دائم في بنكك. ينقل بنكك المبلغ تلقائيًا كل شهر.';

  @override
  String get wizardStufe4DayLabel => 'يوم الدفع';

  @override
  String get wizardStufe4DayHint => 'اختر يومًا بين 1 و 31';

  @override
  String wizardStufe4DayItem(int day) {
    return 'اليوم $day';
  }

  @override
  String wizardStufe4DayReminder(int day) {
    return 'سيتم خصم الاشتراك في اليوم $day من كل شهر.';
  }

  @override
  String get wizardStufe5Title => 'تاريخ البدء';

  @override
  String get wizardStufe5Prompt =>
      'متى تريد أن تصبح عضوًا رسميًا في ICD360S؟ من الموافقة أو بأثر رجعي.';

  @override
  String get wizardStufe5OptionAbVerifizierungTitle => 'من موافقة مجلس الإدارة';

  @override
  String get wizardStufe5OptionAbVerifizierungBody =>
      'الخيار الأبسط. لا اشتراك بأثر رجعي.';

  @override
  String get wizardStufe5OptionGruendungsdatumTitle =>
      'بأثر رجعي من 01.08.2025 (تاريخ التأسيس)';

  @override
  String get wizardStufe5OptionGruendungsdatumBody =>
      'ستُحتسب عضوًا منذ أول يوم في الجمعية.';

  @override
  String get wizardStufe5OptionAnderesDatumTitle => 'تاريخ آخر';

  @override
  String get wizardStufe5OptionAnderesDatumBody =>
      'تختار تاريخًا بين 01.08.2025 واليوم.';

  @override
  String get wizardStufe5PickDate => 'اضغط لاختيار التاريخ';

  @override
  String get wizardStufe5PickDateFirst => 'يرجى اختيار تاريخ أولاً.';

  @override
  String get wizardStufe5DatePickerHelp => 'تاريخ بدء العضوية';

  @override
  String wizardStufe5DateRange(String start) {
    return 'بين $start واليوم';
  }

  @override
  String get wizardStufe5RetroactiveTitle => 'اشتراك بأثر رجعي';

  @override
  String wizardStufe5RetroactiveBody(
      String start, String end, int months, String amount) {
    return 'من $start إلى $end هذا $months شهرًا. بسعر 25 يورو/شهر، يصبح المبلغ $amount يورو مستحقًا بأثر رجعي، إضافة إلى الاشتراك الشهري الجاري.';
  }

  @override
  String get wizardStufe5FeeExemptTitle => 'الاشتراك بأثر رجعي: 0 € 🎉';

  @override
  String get wizardStufe5FeeExemptBody =>
      'مع Bürgergeld أو Sozialamt أنت معفى تمامًا — حتى بأثر رجعي لا تدين بشيء.';

  @override
  String wizardDocumentPrompt(String doc) {
    return 'قبل أن ننتهي، يرجى قراءة $doc بعناية. من المهم أن تعرف ما توقع عليه.';
  }

  @override
  String get wizardDocumentScrollHint => 'مرر للأسفل حتى النهاية للمتابعة.';

  @override
  String get wizardDocumentScrolledOk => 'لقد قرأت حتى النهاية ✓';

  @override
  String wizardDocumentOpenButton(String doc) {
    return 'افتح $doc في المتصفح';
  }

  @override
  String get wizardDocumentExternalHint =>
      'على هذه المنصة، نفتح المستند في متصفحك الافتراضي.';

  @override
  String get wizardDocumentOpenedOk => 'تم فتح المستند. يرجى قراءته بعناية.';

  @override
  String wizardDocumentConfirm(String doc) {
    return 'أؤكد أنني قرأت $doc وأوافق عليها.';
  }

  @override
  String get wizardFinalAdultTitle => 'تم! أنت مسجل 🎉';

  @override
  String get wizardFinalMinorTitle => 'تم إرسال طلبك 📨';

  @override
  String get wizardFinalMinorBody =>
      'سنتواصل مع والدك ونرتب لقاءً (شخصيًا أو عبر مكالمة فيديو). يرجى التحلي بالصبر — قد تستغرق العملية حتى 7 أيام. ستحصل على إشعار في التطبيق بمجرد موافقة والدك.';

  @override
  String get wizardFinalMitgliedernummerLabel => 'رقم عضويتك';

  @override
  String get wizardStufe4MethodComingSoon => 'قريبًا';

  @override
  String get wizardStufe4StreichungWarning =>
      'إذا تأخرت في دفع الاشتراك لأكثر من 6 أشهر، سنشطبك تلقائيًا (النظام الأساسي §6 Abs. 3).';

  @override
  String get wizardStufe5KuendigungInfo =>
      'للانسحاب: أرسل لنا إخطار الإلغاء كتابة قبل 3 أشهر من 31 ديسمبر (بحد أقصى 30 سبتمبر ليصبح ساري المفعول في نهاية العام). لا توجد مدة أدنى (النظام الأساسي §6 Abs. 3).';

  @override
  String get wizardStufe1fEmailLabel => 'بريد العضوية الخاص بك';

  @override
  String get wizardStufe1fEmailHelper =>
      'يُخصَّص تلقائيًا بناءً على رقم عضويتك. يتم التفعيل بمجرد أن يصادق مجلس الإدارة (Vorstand) على طلبك. لدينا تطبيق بريد إلكتروني خاص بنا — أرسل واستقبل رسائل مشفّرة، ببساطة ومجانًا.';

  @override
  String get wizardErrInvalidEmail => 'بريد إلكتروني غير صالح';

  @override
  String get wizardStufe3OptionAlg1 =>
      'أتلقى Arbeitslosengeld I (ALG I، إعانة البطالة)';

  @override
  String get wizardStufe3OptionKrankengeld =>
      'أتلقى Krankengeld (بدل المرض طويل الأمد)';

  @override
  String get wizardStufe3UploadAddMore => 'إضافة وثيقة أخرى';

  @override
  String get wizardStufe3UploadLimitCount =>
      'تم بلوغ الحد الأقصى: 20 وثيقة كحد أعلى.';

  @override
  String get wizardStufe3UploadLimitTotal =>
      'تم بلوغ الحد الإجمالي 100 ميغابايت. احذف ملفًا موجودًا أولاً.';

  @override
  String get wizardStufe3UploadDeleteTooltip => 'حذف';

  @override
  String wizardStufe3UploadCounter(int count, int max) {
    return '$count / $max وثائق';
  }

  @override
  String get wizardDocumentExternalOpenFailed =>
      'تعذّر فتح المتصفح. تم نسخ الرابط إلى الحافظة — الصقه في متصفح للمتابعة.';

  @override
  String get wizardFinalTimelineProcessing =>
      'مجلس الإدارة يراجع · عادةً يوم عمل واحد، حتى 7';

  @override
  String get wizardFinalTimelineActivated => 'تم تفعيل الحساب';

  @override
  String get wizardFinalAdultThank => 'شكرًا لإكمالك نموذج التسجيل! 🎉';

  @override
  String get wizardFinalAdultUsual =>
      'وصلنا طلبك. عادةً نتحقق منه خلال يوم عمل واحد.';

  @override
  String get wizardFinalAdultExceptional =>
      'أحيانًا قد يستغرق الأمر حتى 7 أيام عمل. وإذا لم يكن شيء ما متطابقًا، فسنعيدك إلى النموذج لتصحيحه 🙂';

  @override
  String get wizardFinalStatusTitle => 'حالة الطلب';

  @override
  String wizardFinalStatusStepsValidated(int reviewed, int total) {
    return '$reviewed/$total خطوات تم التحقق منها من قبل المجلس التنفيذي';
  }

  @override
  String get wizardFinalStufeSheetTitle => 'تفاصيل الطلب';

  @override
  String get wizardFinalStufeSheetHint =>
      'المراحل الثماني التي أكملتها. يراجعها مجلس الإدارة واحدة تلو الأخرى — ترى في الوقت الفعلي ما تم التحقق منه.';

  @override
  String get wizardFinalStufeStatusPending => 'بانتظار المراجعة';

  @override
  String get wizardFinalStufeStatusApproved => 'تم التحقق';

  @override
  String get wizardFinalStufeStatusRejected => 'مرفوض';

  @override
  String wizardFinalStatusRejectionCount(int count) {
    return '$count خطوة تحتاج إلى تصحيح';
  }

  @override
  String get wizardFinalStufeRejectionReason => 'سبب المجلس:';

  @override
  String get wizardFinalStufeCorrectNow => 'تصحيح الآن';

  @override
  String wizardFinalApprovalsHeader(int current, int total) {
    return 'اعتمادات Vorstand ($current/$total)';
  }

  @override
  String get wizardFinalApprovalAwaiting => 'بانتظار عضو Vorstand الثاني';

  @override
  String get wizardFinalApprovalRejected => 'مرفوض';

  @override
  String get wizardFinalStufeNoDataYet => 'البيانات غير متوفرة بعد.';

  @override
  String get wizardFinalStufeReadAt => 'تمت القراءة في:';

  @override
  String get wizardFinalStufeBeitragsfrei => 'معفى من الرسوم (لا يلزم الدفع)';

  @override
  String get wizardFinalStufeNotExempt => 'بدون مساعدات اجتماعية';

  @override
  String get wizardFinalStufeBeginAtVerification => 'يبدأ عند التحقق';

  @override
  String get wizardFinalStufeBeginAtFoundation => 'تاريخ التأسيس (بأثر رجعي)';

  @override
  String get wizardFinalStufeBeginAtCustom => 'تاريخ مخصص';

  @override
  String get wizardFinalStufeStatusSkipped => 'تم تخطيه';

  @override
  String get wizardFinalStufeFilledAt => 'تم الملء في:';

  @override
  String get wizardFinalStufeReviewedAt => 'تمت المراجعة في:';

  @override
  String get wizardFinalWithdrawLink => 'سحب الطلب';

  @override
  String get wizardFinalWithdrawDialogTitle => 'هل تريد سحب الطلب؟';

  @override
  String get wizardFinalWithdrawDialogBody =>
      'سيتم وضع علامة على طلبك بأنه مسحوب من قِبَلك. تبقى البيانات في قاعدة البيانات لأغراض التدقيق (GDPR)، لكن لن يتم تفعيل الحساب. يمكنك إعادة التسجيل في أي وقت برقم عضوية جديد.';

  @override
  String get wizardFinalWithdrawKeep => 'لا، سأنتظر';

  @override
  String get wizardFinalWithdrawConfirm => 'نعم، اسحب';

  @override
  String get wizardErrTooManyWithdrawals =>
      'لا يمكن معالجة طلبك تلقائيًا. اتصل بنا أو احضر شخصيًا إلى Vorstand لمتابعة التسجيل.';

  @override
  String get wizardDuplicateLoginTitle => 'يبدو أنك عضو لدينا بالفعل';

  @override
  String get wizardDuplicateLoginBody =>
      'وفقًا لاسمك وتاريخ ميلادك، نجد بالفعل حسابًا نشطًا. يرجى استخدام \"أنا عضو بالفعل\" على الشاشة الرئيسية لتسجيل الدخول. إذا فقدت الوصول، اتصل بنا.';

  @override
  String get wizardDuplicatePendingTitle => 'طلبك معنا بالفعل';

  @override
  String get wizardDuplicatePendingBody =>
      'لدينا بالفعل طلب قيد المراجعة باسمك وتاريخ ميلادك. مجلس الإدارة يعمل عليه — سنُعلِمك عبر إشعار في التطبيق فور تفعيل حسابك. اتصل بنا إذا أردت التحدث.';

  @override
  String get wizardDuplicateRecentlyWithdrawnTitle =>
      'لا يمكننا معالجة هذا الطلب الآن';

  @override
  String get wizardDuplicateRecentlyWithdrawnBody =>
      'اسمك وتاريخ ميلادك يتطابقان مع طلب تم سحبه مؤخرًا. يرجى الاتصال بنا للتحدث مع مجلس الإدارة قبل المتابعة.';

  @override
  String get wizardDuplicatePreviouslyWithdrawnTitle => 'لقد قدمت طلبًا من قبل';

  @override
  String get wizardDuplicatePreviouslyWithdrawnBody =>
      'اسمك وتاريخ ميلادك يتطابقان مع طلب أقدم سحبته. أهلًا بعودتك — يرجى الاتصال بنا قبل المتابعة حتى يقرر مجلس الإدارة كيف نتقدم.';

  @override
  String get wizardDuplicateCallUsTitle => 'يرجى الاتصال بنا';

  @override
  String get wizardDuplicateCallUsBody =>
      'اسمك وتاريخ ميلادك موجودان لدينا بالفعل، لكن لا يمكننا مشاركة التفاصيل عبر التطبيق. يرجى الاتصال بنا — مجلس الإدارة سيشرح لك الأمر مباشرة.';

  @override
  String get wizardChatHelp => 'لنتحدث';

  @override
  String get wizardChatHelpSubtitle => 'دردشة مباشرة مع مجلس الإدارة · رد سريع';

  @override
  String get benachrichtigungTitel => 'تذكيرات عبر الرسائل القصيرة';

  @override
  String get benachrichtigungIntro =>
      'حتى لا يفوتك أي موعد، يمكن للجمعية أن ترسل لك رسالة قصيرة. أنت من يقرر ما إذا كنت ترغب في ذلك ولأي غرض، ويمكنك تغيير ذلك في أي وقت.';

  @override
  String get benachrichtigungTermineFrage =>
      'هل ترغب في تلقي تذكيرات بمواعيدك عبر الرسائل القصيرة؟';

  @override
  String get benachrichtigungTermineDetail =>
      'تتضمن الرسالة تاريخ الموعد ووقته ومكانه وموضوعه.';

  @override
  String get benachrichtigungMedikamenteFrage =>
      'هل ترغب أيضاً في تذكيرك بأدويتك؟';

  @override
  String get benachrichtigungMedikamenteDetail =>
      'سيظهر اسم الدواء في الرسالة. هذه معلومة صحية، لذلك نسأل عنها بشكل منفصل.';

  @override
  String get benachrichtigungHinweis =>
      'التذكير مساعدة وليس ضماناً، فالرجاء عدم الاعتماد عليه وحده. يمكنك تغيير ذلك في أي وقت من ملفك الشخصي.';

  @override
  String get benachrichtigungJa => 'نعم';

  @override
  String get benachrichtigungNein => 'لا';

  @override
  String get benachrichtigungSpaeter => 'أقرر لاحقاً';

  @override
  String get benachrichtigungSpeichern => 'حفظ';

  @override
  String get benachrichtigungGespeichert => 'شكراً، تم الحفظ.';
}
