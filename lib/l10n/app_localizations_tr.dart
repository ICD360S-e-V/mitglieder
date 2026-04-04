// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get appTitle => 'ICD360S e.V - Üye Portalı';

  @override
  String get memberPortal => 'Üye Portalı';

  @override
  String get welcomeLoading => 'Yükleniyor...';

  @override
  String get welcomeAutoLogin => 'Otomatik giriş...';

  @override
  String get login => 'Giriş Yap';

  @override
  String get register => 'Kayıt Ol';

  @override
  String get becomeMember => 'Üye Ol';

  @override
  String get memberNumber => 'Üye Numarası';

  @override
  String get memberNumberHint => 'Lütfen üye numaranızı girin';

  @override
  String get password => 'Şifre';

  @override
  String get passwordHint => 'Lütfen şifrenizi girin';

  @override
  String get confirmPassword => 'Şifreyi Onayla';

  @override
  String get confirmPasswordHint => 'Lütfen şifrenizi onaylayın';

  @override
  String get newPassword => 'Yeni Şifre';

  @override
  String get newPasswordHint => 'Lütfen yeni şifrenizi girin';

  @override
  String get saveCredentials => 'Giriş bilgilerini kaydet';

  @override
  String get autoLogin => 'Otomatik giriş yap';

  @override
  String get forgotPassword => 'Şifrenizi mi unuttunuz?';

  @override
  String get firstName => 'Ad ve Soyad';

  @override
  String get firstNameHint => 'Lütfen ad ve soyadınızı girin';

  @override
  String get nameMinLength => 'İsim en az 2 karakter olmalıdır';

  @override
  String get nameOnlyLetters => 'Sadece harf ve tire kullanılabilir';

  @override
  String get email => 'E-posta Adresi';

  @override
  String get emailHint => 'Lütfen e-posta adresinizi girin';

  @override
  String get emailInvalid => 'Lütfen geçerli bir e-posta adresi girin';

  @override
  String get passwordMinLength => 'Şifre en az 6 karakter olmalıdır';

  @override
  String get passwordsNotMatch => 'Şifreler eşleşmiyor';

  @override
  String get recoveryCode => 'Kurtarma Kodu (6 rakam)';

  @override
  String get recoveryCodeHelper => 'Şifre kurtarma için bu kodu unutmayın';

  @override
  String get recoveryCodeHint => 'Lütfen kurtarma kodunu girin';

  @override
  String get recoveryCodeInvalid => 'Kod tam olarak 6 rakam olmalıdır';

  @override
  String get loginFailed => 'Giriş başarısız';

  @override
  String get registrationFailed => 'Kayıt başarısız';

  @override
  String connectionError(String error) {
    return 'Bağlantı hatası: $error';
  }

  @override
  String registrationSuccess(String memberNumber) {
    return 'Kayıt başarılı!\n\nÜye numaranız: $memberNumber\n\nLütfen giriş için bu numarayı unutmayın.';
  }

  @override
  String get tooManyDevices => 'Çok fazla cihaz';

  @override
  String get maxDevicesMessage =>
      'Zaten 3 cihazda giriş yapmış durumdasınız.\nÇıkış yapmak için bir cihaz seçin:';

  @override
  String get unknownDevice => 'Bilinmeyen cihaz';

  @override
  String get unknown => 'Bilinmeyen';

  @override
  String get logoutError => 'Çıkış hatası';

  @override
  String error(String error) {
    return 'Hata: $error';
  }

  @override
  String get cancel => 'İptal';

  @override
  String get resetPassword => 'Şifreyi Sıfırla';

  @override
  String get forgotPasswordTitle => 'Şifremi Unuttum';

  @override
  String get forgotPasswordDescription =>
      'Üye numaranızı ve kayıt sırasında oluşturduğunuz kurtarma kodunu girin.';

  @override
  String get passwordResetSuccess =>
      'Şifre başarıyla sıfırlandı!\n\nArtık yeni şifrenizle giriş yapabilirsiniz.';

  @override
  String get passwordResetFailed => 'Şifre sıfırlama başarısız';

  @override
  String get needHelp => 'Yardıma mı ihtiyacınız var?';

  @override
  String get helpQuestion =>
      'Giriş veya kayıt ile ilgili sorun mu yaşıyorsunuz?';

  @override
  String get helpDescription =>
      'WhatsApp üzerinden bizimle iletişime geçin ve neyin çalışmadığını tam olarak açıklayın. En kısa sürede cevap vereceğiz!';

  @override
  String get whatsapp => 'WhatsApp';

  @override
  String get emailSubject => 'ICD360S Uygulaması hakkında soru';

  @override
  String get whatsappMessage =>
      'Merhaba, ICD360S Uygulamasıyla ilgili bir sorunum var. ';

  @override
  String get imprint => 'Künye';

  @override
  String get privacy => 'Gizlilik Politikası';

  @override
  String get statutes => 'Tüzük';

  @override
  String get revocation => 'İptal Hakkı';

  @override
  String get cancellation => 'Fesih';

  @override
  String get allRightsReserved => 'Tüm hakları saklıdır.';

  @override
  String get enterCredentials => 'Lütfen üye numaranızı ve şifrenizi girin';

  @override
  String get appointments => 'Randevular';

  @override
  String get tickets => 'Talepler';

  @override
  String get liveChat => 'Canlı Sohbet';

  @override
  String get notifications => 'Bildirimler';

  @override
  String get myProfile => 'Profilim';

  @override
  String get logout => 'Çıkış Yap';

  @override
  String get goodMorning => 'Günaydın';

  @override
  String get goodDay => 'İyi Günler';

  @override
  String get goodEvening => 'İyi Akşamlar';

  @override
  String get goodNight => 'İyi Geceler';

  @override
  String get welcomeToICD => 'ICD360S e.V\'ye Hoş Geldiniz!';

  @override
  String get accountCreatedSuccessfully => 'Hesabınız başarıyla oluşturuldu.';

  @override
  String get today => 'Bugün';

  @override
  String get membershipFeeDue => 'Üyelik aidatı vadesi';

  @override
  String get pleaseTransferAnnualFee => 'Lütfen yıllık aidatı transfer edin.';

  @override
  String get newBadge => 'Yeni';

  @override
  String get close => 'Kapat';

  @override
  String get membership => 'Üyelik';

  @override
  String get myAppointments => 'Randevularım';

  @override
  String get appointmentsLoadingReady => 'Randevular yükleniyor - API hazır!';

  @override
  String get priority => 'Öncelik';

  @override
  String get messageLabel => 'Mesaj';

  @override
  String get createdOn => 'Oluşturulma';

  @override
  String get handler => 'İşlemci';

  @override
  String get reportProblems => 'Sorunları Bildir';

  @override
  String get reportProblem => 'Sorun Bildir';

  @override
  String get weRespondIn24Hours => 'En geç 24 saat içinde cevap vereceğiz!';

  @override
  String get everythingOk => 'Her şey yolunda!';

  @override
  String get haveProblemWeHelp => 'Bir sorununuz mu var?\nBiz hallederiz!';

  @override
  String get myMembership => 'Üyeliğim';

  @override
  String get managePersonalDataAndFee =>
      'Kişisel verilerinizi ve üyelik aidatınızı yönetin';

  @override
  String get myAppointmentsTitle => 'Randevularım';

  @override
  String get appointmentsDescription =>
      'Burada yaklaşan randevularınızı görebilirsiniz.\nKatılımınızı onaylayabilir veya iptal edebilirsiniz.';

  @override
  String get loadAppointments => 'Randevuları Yükle';

  @override
  String get myTickets => 'Taleplerim';

  @override
  String get newTicket => 'Yeni Talep';

  @override
  String get noOpenTickets => 'Açık talep yok';

  @override
  String get haveQuestionCreateTicket =>
      'Bir sorunuz veya sorununuz mu var?\nYeni bir talep oluşturun.';

  @override
  String get whatIsTheProblem => 'Sorun nedir?';

  @override
  String get describeTheProblem => 'Sorunu açıklayın';

  @override
  String get howUrgentIsIt => 'Ne kadar acil?';

  @override
  String get low => 'Düşük';

  @override
  String get medium => 'Orta';

  @override
  String get high => 'Yüksek';

  @override
  String get submit => 'Gönder';

  @override
  String get fillSubjectAndMessage => 'Lütfen konu ve mesajı doldurun';

  @override
  String get ticketCreated => 'Talep oluşturuldu';

  @override
  String get errorCreatingTicket => 'Talep oluşturulurken hata';

  @override
  String get verified => 'Doğrulanmış';

  @override
  String get account => 'Hesap';

  @override
  String get myDevices => 'Cihazlarım';

  @override
  String get changeEmail => 'E-posta Değiştir';

  @override
  String get changePassword => 'Şifre Değiştir';

  @override
  String get newEmailAddress => 'Yeni E-posta Adresi';

  @override
  String get currentPassword => 'Mevcut Şifre';

  @override
  String get saveEmail => 'E-postayı Kaydet';

  @override
  String get savePassword => 'Şifreyi Kaydet';

  @override
  String get deviceLoggedOut => 'Cihaz çıkış yaptı';

  @override
  String get passwordChangedSuccessfully => 'Şifre başarıyla değiştirildi';

  @override
  String get emailChangedSuccessfully => 'E-posta başarıyla değiştirildi';

  @override
  String get errorChangingPassword => 'Şifre değiştirme hatası';

  @override
  String get errorChangingEmail => 'E-posta değiştirme hatası';

  @override
  String get validEmailRequired => 'Lütfen geçerli bir e-posta adresi girin';

  @override
  String get passwordTooShort => 'Şifre en az 6 karakter uzunluğunda olmalıdır';

  @override
  String get maxDevicesReached =>
      'Maksimum 3 cihazda giriş yapmış durumdasınız.';

  @override
  String loggedInOnDevices(int count) {
    return '3 cihazdan $count tanesinde giriş yapmış durumdasınız.';
  }

  @override
  String get noActiveSessions => 'Aktif oturum yok';

  @override
  String get logoutFromDevice => 'Bu cihazdan çıkış yap';

  @override
  String get confirmLogoutDevice => 'Cihazdan çıkış yapılsın mı?';

  @override
  String get confirmLogoutMessage =>
      'Bu cihazdan çıkış yapmak istiyor musunuz?\n\nBu cihazı tekrar kullanmak için yeniden giriş yapmanız gerekecektir.';

  @override
  String get ipAddress => 'IP';

  @override
  String get platform => 'Platform';

  @override
  String trialWarningUrgentTitle(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'gün',
      one: 'gün',
    );
    return 'Dikkat: Hesap askıya alınmasına sadece $days $_temp0 kaldı!';
  }

  @override
  String get trialWarningTitle => 'Hesabınız henüz doğrulanmadı';

  @override
  String get trialWarningDescription =>
      'Lütfen \"Profilim\" bölümünden verilerinizi tamamlayın. 30 gün sonra hesabınız otomatik olarak askıya alınacaktır.';

  @override
  String trialDaysRemaining(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days gün',
      one: '1 gün',
    );
    return '$_temp0';
  }

  @override
  String get overview => 'Genel Bakış';

  @override
  String get member => 'Üye';

  @override
  String get memberManagement => 'Üye Yönetimi';

  @override
  String get reportProblemTooltip => 'Sorun Bildir';

  @override
  String get newAppointmentsTitle => 'Yeni Randevular';

  @override
  String get youHaveNewAppointment => 'Yeni bir randevunuz var.';

  @override
  String youHaveNewAppointments(int count) {
    return '$count yeni randevunuz var.';
  }

  @override
  String get appointmentReminderTomorrow => 'Hatırlatma: Yarın randevunuz var';

  @override
  String tomorrowAppointment(String title) {
    return 'Yarın: $title';
  }

  @override
  String youHaveTomorrowAppointments(int count) {
    return 'Yarın $count randevunuz var.';
  }

  @override
  String get appointmentsToday => 'Bugünkü randevular';

  @override
  String todayAppointment(String title) {
    return 'Bugün: $title';
  }

  @override
  String youHaveTodayAppointments(int count) {
    return 'Bugün $count randevunuz var.';
  }

  @override
  String get paymentReminder => 'Ödeme Hatırlatması';

  @override
  String paymentReminderMessage(int day, String method) {
    return 'Bugün ayın $day. günü – lütfen $method işlemini gerçekleştirin.';
  }

  @override
  String get paymentDayLabel => 'Ödeme günü (aylık hatırlatma)';

  @override
  String get updateAvailable => 'Güncelleme mevcut';

  @override
  String newVersionAvailable(String version) {
    return 'Yeni bir sürüm mevcut: $version';
  }

  @override
  String currentVersionLabel(String version) {
    return 'Mevcut sürüm: $version';
  }

  @override
  String get changes => 'Değişiklikler:';

  @override
  String downloadProgress(String percent) {
    return 'İndirme: $percent%';
  }

  @override
  String get installationStarting => 'Kurulum başlatılıyor...';

  @override
  String get appWillRestart => 'Uygulama otomatik olarak yeniden başlatılacak.';

  @override
  String get later => 'Daha Sonra';

  @override
  String get updateNow => 'Şimdi Güncelle';

  @override
  String get downloading => 'İndiriliyor...';

  @override
  String get downloadFailed =>
      'İndirme başarısız. Lütfen daha sonra tekrar deneyin.';

  @override
  String get searchingForUpdates => 'Güncelleme aranıyor...';

  @override
  String get appUpToDate => 'Uygulama güncel';

  @override
  String get updateCheckError => 'Güncelleme kontrolü hatası';

  @override
  String get changelog => 'Değişiklik Günlüğü';

  @override
  String get terminConfirmed => 'Randevu onaylandı';

  @override
  String get terminDeclined => 'Randevu reddedildi';

  @override
  String get terminRescheduleRequested => 'Erteleme talep edildi';

  @override
  String get statusConfirmed => 'Onaylandı';

  @override
  String get statusDeclined => 'Reddedildi';

  @override
  String get statusRescheduling => 'Erteleme';

  @override
  String get statusPending => 'Beklemede';

  @override
  String get categoryVorstandssitzung => 'Yönetim Kurulu Toplantısı';

  @override
  String get categoryMitgliederversammlung => 'Üye Genel Kurulu';

  @override
  String get categorySchulung => 'Eğitim';

  @override
  String get categorySonstiges => 'Diğer';

  @override
  String openCount(int count) {
    return '$count açık';
  }

  @override
  String get refresh => 'Yenile';

  @override
  String get filterUpcoming => 'Yaklaşan';

  @override
  String get filterPast => 'Geçmiş';

  @override
  String get filterAll => 'Tümü';

  @override
  String get noUpcomingAppointments => 'Yaklaşan randevu yok';

  @override
  String get noPastAppointments => 'Geçmiş randevu yok';

  @override
  String get noAppointmentsAvailable => 'Randevu bulunmuyor';

  @override
  String get appointmentsShownHere => 'Randevularınız burada görüntülenecek';

  @override
  String get dateLabel => 'Tarih';

  @override
  String get timeLabel => 'Saat';

  @override
  String get locationLabel => 'Yer';

  @override
  String get createdByLabel => 'Oluşturan';

  @override
  String get descriptionLabel => 'Açıklama';

  @override
  String get ticketLabel => 'Talep';

  @override
  String get yourStatus => 'Durumunuz: ';

  @override
  String reasonLabel(String reason) {
    return 'Sebep: $reason';
  }

  @override
  String durationMinutes(int minutes) {
    return '$minutes dk';
  }

  @override
  String get confirm => 'Onayla';

  @override
  String get decline => 'Reddet';

  @override
  String get reschedule => 'Ertele';

  @override
  String get requestReschedule => 'Erteleme talep et';

  @override
  String appointmentLabel(String title) {
    return 'Randevu: $title';
  }

  @override
  String get rescheduleReason => 'Erteleme sebebi *';

  @override
  String get rescheduleReasonHint => 'Lütfen bir sebep belirtin...';

  @override
  String get pleaseProvideReason => 'Lütfen bir sebep belirtin';

  @override
  String get request => 'Talep Et';

  @override
  String get ticketStatusOpen => 'Açık';

  @override
  String get ticketStatusInProgress => 'İşlemde';

  @override
  String get ticketStatusWaitingMember => 'Üye bekleniyor';

  @override
  String get ticketStatusWaitingStaff => 'Personel bekleniyor';

  @override
  String get ticketStatusWaitingAuthority => 'Kurum bekleniyor';

  @override
  String get ticketStatusDone => 'Tamamlandı';

  @override
  String get ticketPriorityHigh => 'Yüksek';

  @override
  String get ticketPriorityMedium => 'Orta';

  @override
  String get ticketPriorityLow => 'Düşük';

  @override
  String get comments => 'Yorumlar';

  @override
  String get documents => 'Belgeler';

  @override
  String get details => 'Detaylar';

  @override
  String get replySent => 'Yanıt gönderildi';

  @override
  String get sendError => 'Gönderme hatası';

  @override
  String get uploading => 'Yükleniyor...';

  @override
  String fileUploaded(String filename) {
    return '$filename yüklendi';
  }

  @override
  String get uploadFailed => 'Yükleme başarısız';

  @override
  String get openError => 'Açma hatası';

  @override
  String get noRepliesYet => 'Henüz yanıt yok';

  @override
  String get waitingForSupport => 'Destek ekibinden yanıt bekleniyor';

  @override
  String get writeReply => 'Yanıt yazın...';

  @override
  String get attachFile => 'Dosya ekle';

  @override
  String documentsCount(int count) {
    return 'Belgeler ($count)';
  }

  @override
  String get upload => 'Yükle';

  @override
  String get noDocuments => 'Belge bulunmuyor';

  @override
  String get allowedFormats =>
      'İzin verilen formatlar: PDF, JPEG, JPG, TXT, ZIP';

  @override
  String get yourMessage => 'Mesajınız:';

  @override
  String get translation => 'Çeviri';

  @override
  String get original => 'Orijinal';

  @override
  String get originalText => 'Orijinal metin';

  @override
  String get autoTranslated => 'Otomatik çevrildi';

  @override
  String get originalTapTranslation => 'Orijinal metin · Çeviri için dokunun';

  @override
  String get translatedTapOriginal => 'Çevrildi · Orijinal için dokunun';

  @override
  String get justNow => 'Az önce';

  @override
  String minutesAgo(int minutes) {
    return '$minutes dk önce';
  }

  @override
  String hoursAgo(int hours) {
    return '$hours saat önce';
  }

  @override
  String daysAgo(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'gün',
      one: 'gün',
    );
    return '$days $_temp0 önce';
  }

  @override
  String get createdLabel => 'Oluşturulma';

  @override
  String get updatedLabel => 'Güncelleme';

  @override
  String get handlerLabel => 'İşlemci';

  @override
  String get doneLabel => 'Tamamlandı';

  @override
  String get newTicketTitle => 'Yeni Talep';

  @override
  String get categoryOptional => 'Kategori (isteğe bağlı)';

  @override
  String get selectCategory => 'Seçin';

  @override
  String get subjectLabel => 'Konu';

  @override
  String get fillAllFields => 'Lütfen tüm alanları doldurun';

  @override
  String ticketCreatedId(int id) {
    return 'Talep #$id oluşturuldu';
  }

  @override
  String get priorityLabel => 'Öncelik: ';

  @override
  String get supportOffline => 'Destek çevrimdışı';

  @override
  String get lastSeenSeconds => 'Birkaç saniye önce aktifti';

  @override
  String lastSeenMinutes(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: 'dakika',
      one: 'dakika',
    );
    return '$minutes $_temp0 önce aktifti';
  }

  @override
  String lastSeenHours(int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: 'saat',
      one: 'saat',
    );
    return '$hours $_temp0 önce aktifti';
  }

  @override
  String lastSeenDays(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'gün',
      one: 'gün',
    );
    return '$days $_temp0 önce aktifti';
  }

  @override
  String get online => 'Çevrimiçi';

  @override
  String get callSupport => 'Ara';

  @override
  String get typeMessage => 'Mesaj yazın...';

  @override
  String get callBusy => 'Destek meşgul';

  @override
  String get callRejected => 'Arama reddedildi';

  @override
  String get callFailed => 'Arama bağlanamadı';

  @override
  String get callEnded => 'Arama sona erdi';

  @override
  String get callSupportBusy => 'Destek başka bir aramada';

  @override
  String get errorStartingChat => 'Sohbet başlatma hatası';

  @override
  String get errorStartingCall => 'Arama başlatma hatası';

  @override
  String get errorConnecting => 'Bağlantı hatası';

  @override
  String get errorAcceptingCall => 'Arama kabul hatası';

  @override
  String get errorDownloading => 'İndirme hatası';

  @override
  String get errorUploading => 'Yükleme hatası';

  @override
  String get errorSending => 'Gönderme hatası';

  @override
  String get errorPickingPhotos => 'Fotoğraf seçme hatası';

  @override
  String get errorPickingFiles => 'Dosya seçme hatası';

  @override
  String get errorTakingPhoto => 'Fotoğraf çekme hatası';

  @override
  String get fileNotLoaded => 'Dosya yüklenemedi';

  @override
  String get attachmentIdMissing => 'Ek kimliği eksik';

  @override
  String get camera => 'Kamera';

  @override
  String get gallery => 'Galeri';

  @override
  String get file => 'Dosya';

  @override
  String typingIndicator(String name) {
    return '$name yazıyor...';
  }

  @override
  String get notifNewMessageFrom => 'Yeni mesaj:';

  @override
  String get notifUrgentPrefix => 'ACİL';

  @override
  String get notifUrgentMessage => 'ACİL MESAJ';

  @override
  String get notifIncomingCall => 'Gelen arama';

  @override
  String get notifCallingYou => 'arıyor...';

  @override
  String get notifUpdateAvailable => 'Güncelleme mevcut';

  @override
  String get notifVersionAvailable => 'şimdi mevcut';

  @override
  String get notifConnected => 'Bağlandı';

  @override
  String get notifDisconnected => 'Bağlantı kesildi';

  @override
  String get notifConnectedBody => 'Sunucuya bağlandınız.';

  @override
  String get notifDisconnectedBody => 'Sunucu bağlantısı kesildi.';

  @override
  String get notifError => 'Hata';

  @override
  String get retry => 'Tekrar dene';

  @override
  String get save => 'Kaydet';

  @override
  String get accept => 'Kabul Et';

  @override
  String get selectFile => 'Dosya seç';

  @override
  String get dataLoadingText => 'Veriler yükleniyor...';

  @override
  String get dataSavedSuccess => 'Veriler başarıyla kaydedildi';

  @override
  String get errorSaving => 'Kaydetme hatası';

  @override
  String get errorLoading => 'Yükleme hatası';

  @override
  String savedFilename(String filename) {
    return 'Kaydedildi: $filename';
  }

  @override
  String get logsCopied => 'Günlükler kopyalandı!';

  @override
  String get diagnosticDataTitle => 'Tanılama Verileri';

  @override
  String get diagnosticDescription =>
      'Uygulamayı iyileştirmek için anonim tanılama verileri göndermek ister misiniz?';

  @override
  String get noThanks => 'Hayır, teşekkürler';

  @override
  String get yesEnable => 'Evet, etkinleştir';

  @override
  String get passwordMinEightChars => 'Şifre en az 8 karakter olmalıdır';

  @override
  String get passwordChangeSuccess => 'Şifre başarıyla değiştirildi';

  @override
  String get emailChangeError => 'E-posta değiştirme hatası';

  @override
  String get acceptDocumentCheckbox => 'Belgeyi okudum ve kabul ediyorum.';

  @override
  String loadingErrorGeneric(String details) {
    return 'Yükleme hatası: $details';
  }

  @override
  String get incomingCallTitle => 'Gelen Arama';

  @override
  String ringingFor(int seconds) {
    return '$seconds saniyedir çalıyor';
  }

  @override
  String get rejectCall => 'Reddet';

  @override
  String get acceptCall => 'Kabul Et';

  @override
  String get unmute => 'Sesi aç';

  @override
  String get mute => 'Sessize al';

  @override
  String get hangUp => 'Kapat';

  @override
  String get calling => 'Aranıyor...';

  @override
  String autoRejectIn(int seconds) {
    return '$seconds saniye sonra otomatik reddedilecek';
  }

  @override
  String get speakerOn => 'Hoparlör';

  @override
  String get speakerOff => 'Kulaklık';

  @override
  String get micMuted => 'Sessiz';

  @override
  String get micOn => 'Mikrofon';

  @override
  String get connectionExcellent => 'Mükemmel';

  @override
  String get connectionGood => 'İyi';

  @override
  String get connectionWeak => 'Zayıf';

  @override
  String get connectionLost => 'Bağlantı kesildi';

  @override
  String get personalData => 'Kişisel Veriler';

  @override
  String get personalDataSubtitle => 'Ad, soyad, adres';

  @override
  String get membershipFee => 'Üyelik Aidatı';

  @override
  String annualFeeYear(String year) {
    return 'Yıllık aidat $year';
  }

  @override
  String get amount => 'Tutar:';

  @override
  String get dueBy => 'Son ödeme:';

  @override
  String get paid => 'Ödendi';

  @override
  String get versionHistory => 'Sürüm Geçmişi';

  @override
  String lastUpdated(String date) {
    return 'Son güncelleme: $date';
  }

  @override
  String get noVersionHistory => 'Sürüm geçmişi mevcut değil';

  @override
  String get failedLoadChangelog => 'Değişiklik günlüğü yüklenemedi';

  @override
  String get callMember => 'Üyeyi ara';

  @override
  String get closeConversation => 'Sohbeti kapat';

  @override
  String get chatOffline => 'Çevrimdışı';

  @override
  String get attachFiles => 'Dosya ekle (maks. 10, 50MB)';

  @override
  String get conversationClosed => 'Bu sohbet kapatılmıştır';

  @override
  String get noMessages => 'Mesaj yok';

  @override
  String get goBack => 'Geri';

  @override
  String get goForward => 'İleri';

  @override
  String get homePage => 'Ana Sayfa';

  @override
  String get firstNameLabel => 'Ad';

  @override
  String get lastNameLabel => 'Soyad';

  @override
  String get streetLabel => 'Sokak';

  @override
  String get houseNumberLabel => 'No.';

  @override
  String get postalCodeLabel => 'Posta Kodu';

  @override
  String get cityLabel => 'Şehir';

  @override
  String get phoneMobileLabel => 'Telefon (Mobil)';

  @override
  String get phoneLandlineLabel => 'Telefon (Sabit)';

  @override
  String get newEmailLabel => 'Yeni E-posta Adresi';

  @override
  String get currentPasswordLabel => 'Mevcut Şifre';

  @override
  String get newPasswordLabel => 'Yeni Şifre';

  @override
  String get confirmPasswordLabel => 'Şifreyi Onayla';

  @override
  String get emailChangedSuccess => 'E-posta başarıyla değiştirildi';

  @override
  String get newPasswordMinChars => 'Yeni Şifre (min. 6 karakter)';

  @override
  String get reasonLabel2 => 'Sebep';

  @override
  String get downloadFailed2 => 'İndirme başarısız';

  @override
  String get downloadTooltip => 'İndir';

  @override
  String get connectionErrorGeneric => 'Bağlantı hatası';

  @override
  String get copyLogs => 'Günlükleri kopyala';

  @override
  String get deleteLogs => 'Günlükleri sil';

  @override
  String get autoScrollOn => 'Otomatik kaydırma AÇIK';

  @override
  String get autoScrollOff => 'Otomatik kaydırma KAPALI';

  @override
  String get unknownValue => 'Bilinmeyen';

  @override
  String get bankTransfer => 'Havale';

  @override
  String get standingOrder => 'Otomatik Ödeme';

  @override
  String get payment => 'Ödeme';

  @override
  String get warningType_ermahnung => 'Uyarı';

  @override
  String get warningType_abmahnung => 'İhtar';

  @override
  String get warningType_letzte => 'Son İhtar';

  @override
  String warningsTotal(int count) {
    return 'Toplam: $count';
  }

  @override
  String warningsErmahnung(int count) {
    return 'Uyarı: $count';
  }

  @override
  String warningsAbmahnung(int count) {
    return 'İhtar: $count';
  }

  @override
  String warningsLetzte(int count) {
    return 'Son: $count';
  }

  @override
  String get noWarnings => 'Uyarı bulunmuyor';

  @override
  String get noWarningsDescription => 'Şu anda herhangi bir uyarınız yok.';

  @override
  String createdBy(String name) {
    return 'Oluşturan: $name';
  }

  @override
  String get monthJan => 'Oca';

  @override
  String get monthFeb => 'Şub';

  @override
  String get monthMar => 'Mar';

  @override
  String get monthApr => 'Nis';

  @override
  String get monthMay => 'May';

  @override
  String get monthJun => 'Haz';

  @override
  String get monthJul => 'Tem';

  @override
  String get monthAug => 'Ağu';

  @override
  String get monthSep => 'Eyl';

  @override
  String get monthOct => 'Eki';

  @override
  String get monthNov => 'Kas';

  @override
  String get monthDec => 'Ara';

  @override
  String get stufe1_name => 'Kişisel Veriler';

  @override
  String get stufe2_name => 'Üyelik Türü';

  @override
  String get stufe3_name => 'Mali Durum';

  @override
  String get stufe4_name => 'Ödeme Yöntemi';

  @override
  String get stufe5_name => 'Üyelik Başlangıcı';

  @override
  String get stufe6_name => 'Tüzük';

  @override
  String get stufe7_name => 'Gizlilik Politikası';

  @override
  String get stufe8_name => 'İptal Hakkı Bilgilendirmesi';

  @override
  String get memberType_ordentlich => 'Asıl Üye';

  @override
  String get memberType_foerder => 'Destekçi Üye';

  @override
  String get memberType_ehren => 'Onursal Üye';

  @override
  String get memberDesc_ordentlich =>
      'Oy hakkına sahip aktif üye. Derneğin hizmetlerine katılır (E-posta, Bulut, bürokratik destek).';

  @override
  String get memberDesc_foerder =>
      'Derneği aidatlarla destekler. Genel kurula danışma oy hakkıyla katılabilir, ancak seçme veya yönetim kuruluna seçilme hakkı yoktur.';

  @override
  String get memberDesc_ehren =>
      'Asıl üye haklarına sahiptir, aidat ödeme yükümlülüğü yoktur. Genel kurul veya yönetim kurulu tarafından belirlenir.';

  @override
  String get payMethod_ueberweisung => 'Havale';

  @override
  String get payMethod_dauerauftrag => 'Otomatik Ödeme';

  @override
  String get verifyStatus_geprueft => 'Onaylandı';

  @override
  String get verifyStatus_ausgefuellt => 'Dolduruldu';

  @override
  String get verifyStatus_abgelehnt => 'Reddedildi';

  @override
  String get verifyStatus_offen => 'Açık';

  @override
  String get fillRequiredFields => 'Lütfen tüm zorunlu alanları doldurun.';

  @override
  String get personalDataSaved => 'Kişisel veriler kaydedildi';

  @override
  String get selectMemberType => 'Lütfen bir üyelik türü seçin.';

  @override
  String get memberTypeSaved => 'Üyelik türü kaydedildi';

  @override
  String get selectOption => 'Lütfen bir seçenek belirleyin.';

  @override
  String get financialSaved => 'Mali durum kaydedildi';

  @override
  String get selectPaymentMethod => 'Lütfen bir ödeme yöntemi seçin.';

  @override
  String get paymentDataSaved => 'Ödeme verileri kaydedildi';

  @override
  String get selectDate => 'Lütfen bir tarih seçin.';

  @override
  String get membershipStartSaved => 'Üyelik başlangıcı kaydedildi';

  @override
  String get fileTooLarge => 'Dosya çok büyük (maks. 10 MB).';

  @override
  String get leistungsbescheidUploaded => 'Yardım belgesi başarıyla yüklendi';

  @override
  String get verificationProgress => 'Doğrulama İlerlemesi';

  @override
  String get notApplicable => 'Uygulanmaz';

  @override
  String get socialBenefitsExempt =>
      'Sosyal yardım alanlarda ödeme yöntemi gerekmez.';

  @override
  String get locked => 'Kilitli';

  @override
  String completePreviousStep(int step) {
    return 'Lütfen önce Adım $step tamamlayın.';
  }

  @override
  String rejectedNote(String note) {
    return 'Reddedildi: $note';
  }

  @override
  String get waitingForReview => 'Yönetim kurulu incelemesi bekleniyor.';

  @override
  String get stepApproved => 'Bu adım incelendi ve onaylandı.';

  @override
  String get changesViaChat =>
      'Değişiklikler yalnızca Canlı Sohbet üzerinden yapılabilir.';

  @override
  String get firstNameRequired => 'Ad *';

  @override
  String get lastNameRequired => 'Soyad *';

  @override
  String get birthDateLabel => 'Doğum Tarihi *';

  @override
  String get streetRequired => 'Sokak *';

  @override
  String get houseNumberRequired => 'No. *';

  @override
  String get cityRequired => 'Şehir *';

  @override
  String get phoneRequired => 'Telefon Numarası *';

  @override
  String get phonePurpose =>
      'Amaç: Uygulama üzerinden ulaşılamadığında iletişim';

  @override
  String get selectMemberTypePrompt =>
      'Lütfen istediğiniz üyelik türünü seçin:';

  @override
  String get financialExplanation =>
      'Aidat indirimine hak kazanıp kazanmadığınızı kontrol etmek için aşağıdaki bilgiye ihtiyacımız var. Bu bilgi yalnızca üyelik aidatınızın belirlenmesi için kullanılacaktır.';

  @override
  String get socialBenefitsQuestion => 'Şu anda sosyal yardım alıyor musunuz?';

  @override
  String get optionBuergergeld => 'Evet, vatandaş parası (İş Merkezi)';

  @override
  String get optionSozialamt => 'Evet, sosyal yardım (Sosyal Hizmetler)';

  @override
  String get optionNoBenefits => 'Hayır, sosyal yardım almıyorum';

  @override
  String get feeExempt => 'Aylık üyelik aidatınız: 0,00 €/Ay';

  @override
  String get uploadLeistungsbescheid => 'Yardım belgesi yükle';

  @override
  String get uploadLeistungsbescheidHint =>
      'Aidat muafiyetini onaylamak için lütfen 14 gün içinde güncel bir yardım belgesi yükleyin.';

  @override
  String get allowedFormatsUpload =>
      'İzin verilen formatlar: PDF, JPG, PNG (maks. 10 MB)';

  @override
  String get feeRegular => 'Aylık üyelik aidatınız: 25,00 €/Ay';

  @override
  String paymentDayReminder(int day) {
    return 'Her ayın $day. gününde ödeme hatırlatılacaktır.';
  }

  @override
  String get membershipStartPrompt =>
      'Üyeliğinizin ne zaman başlaması gerektiğini seçin.';

  @override
  String get optionAfterVerification => 'Doğrulama tamamlandıktan sonra';

  @override
  String get optionAfterVerificationDesc =>
      'Üyelik, yönetim kurulu onayından itibaren başlar.';

  @override
  String get optionRetroFoundation =>
      'Kuruluş tarihinden itibaren geçmişe dönük (01.08.2025)';

  @override
  String get optionRetroFoundationDesc =>
      'Derneğin kuruluşundan itibaren geçmişe dönük üye olursunuz.';

  @override
  String get optionRetroCustom => 'Başka bir tarihten itibaren geçmişe dönük';

  @override
  String get optionRetroCustomDesc =>
      '01.08.2025 ile bugün arasında bir tarih seçin.';

  @override
  String get selectDateLabel => 'Tarih seç';

  @override
  String get selectDateHint => 'Tarih seçin...';

  @override
  String get dateNotBefore => '01.08.2025\'ten önce olamaz (Kuruluş tarihi)';

  @override
  String get feeExemptRetro =>
      'Aidat muafiyeti: 0,00 € geçmişe dönük.\nSadece üyelik tarihi geriye dönük olarak belirlenir.';

  @override
  String get retroactiveFees => 'Geçmişe Dönük Aidatlar';

  @override
  String retroFeeCalculation(
      String from, String to, String months, String total) {
    return 'Dönem: $from – $to\nAy: $months\nAidat: $months × 25,00 € = $total €';
  }

  @override
  String get pleaseReadSatzung => 'Lütfen derneğin tüzüğünü okuyun.';

  @override
  String get pleaseReadDatenschutz => 'Lütfen gizlilik politikasını okuyun.';

  @override
  String get pleaseReadWiderruf =>
      'Lütfen iptal hakkı bilgilendirmesini okuyun.';

  @override
  String get acceptedAtRegistration => 'Kayıt sırasında kabul edildi';

  @override
  String get confirmedByBoard =>
      'Yönetim kurulu incelemesinden sonra onaylanacaktır.';

  @override
  String get docSatzung => 'Tüzük';

  @override
  String get docDatenschutz => 'Gizlilik Politikası';

  @override
  String get docWiderruf => 'İptal Hakkı Bilgilendirmesi';

  @override
  String acceptedAtRegCount(int count) {
    return 'Kayıt sırasında kabul edildi ($count/3)';
  }

  @override
  String acceptedOn(String date) {
    return '$date tarihinde kabul edildi';
  }

  @override
  String get notAccepted => 'Kabul edilmedi';

  @override
  String get statusAccepted => 'Kabul Edildi';

  @override
  String get memberNumberTooLong => 'Üye numarası çok uzun (maks. 20 karakter)';

  @override
  String get onlyUppercaseAndNumbers =>
      'Sadece büyük harfler ve rakamlar kullanılabilir';

  @override
  String get passwordTooLong => 'Şifre çok uzun (maks. 100 karakter)';

  @override
  String get nameTooLong => 'İsim çok uzun (maks. 100 karakter)';

  @override
  String get emailTooLong => 'E-posta çok uzun (maks. 255 karakter)';

  @override
  String get legalAcknowledgePrefix => 'Okudum ve kabul ediyorum: ';

  @override
  String get legalAcknowledgeSuffix => '.';

  @override
  String get legalStatutesSuffix =>
      ' belgesini okudum ve bağlayıcı olduğunu kabul ediyorum.';

  @override
  String get legalPleaseReadFirst => '(lütfen önce okuyun)';

  @override
  String get statusActive => 'Aktif';

  @override
  String get statusSuspended => 'Askıya alındı';

  @override
  String get statusNew => 'Yeni';

  @override
  String get statusCancelled => 'İptal edildi';

  @override
  String get statusDeleted => 'Silindi';

  @override
  String get roleMitglied => 'Üye';

  @override
  String get roleVorsitzer => 'Başkan';

  @override
  String get roleStellvertreter => 'Başkan Yardımcısı';

  @override
  String get roleSchatzmeister => 'Sayman';

  @override
  String get roleSchriftfuehrer => 'Sekreter';

  @override
  String get roleBeisitzer => 'Yönetim Kurulu Üyesi';

  @override
  String get roleKassierer => 'Kasiyer';

  @override
  String get roleKassenpruefer => 'Denetçi';

  @override
  String get roleEhrenamtlich => 'Gönüllü';

  @override
  String get roleMitgliedergruender => 'Kurucu Üye';

  @override
  String get roleEhrenmitglied => 'Onursal Üye';

  @override
  String get roleFoerdermitglied => 'Destekçi Üye';

  @override
  String get memberTypeNotSet => 'Henüz belirlenmedi';

  @override
  String get payMethodSepa => 'SEPA Otomatik Ödeme';

  @override
  String get labelStatus => 'Durum';

  @override
  String get labelMemberNumber => 'Üye Numarası';

  @override
  String get labelRole => 'Rol';

  @override
  String get labelMemberType => 'Üyelik Türü';

  @override
  String get labelPaymentMethod => 'Ödeme Yöntemi';

  @override
  String get labelRegisteredOn => 'Kayıt tarihi';

  @override
  String get labelLastLogin => 'Son Giriş';

  @override
  String get labelMemberSince => 'Üyelik başlangıcı';

  @override
  String get neverLoggedIn => 'Hiçbir zaman';

  @override
  String get notActivatedYet => 'Henüz etkinleştirilmedi';

  @override
  String get tabVerification => 'Doğrulama';

  @override
  String get tabWarnings => 'Uyarılar';

  @override
  String get tabDocuments => 'Belgeler';

  @override
  String get tabMembership => 'Üyelik';

  @override
  String get pleaseEnterFirstName => 'Lütfen adınızı girin';

  @override
  String get pleaseEnterLastName => 'Lütfen soyadınızı girin';

  @override
  String get noFileDataReceived => 'Dosya verisi alınamadı';

  @override
  String get openFile => 'Aç';

  @override
  String get diagnosticErrors => 'İyileştirme için hata raporları';

  @override
  String get diagnosticAnonymousStats => 'Anonim kullanım istatistikleri';

  @override
  String get diagnosticPerformance => 'Uygulama performans verileri';

  @override
  String get noMicrophoneError =>
      'Mikrofon bulunamadı. Lütfen bir mikrofon bağlayın ve tekrar deneyin.';

  @override
  String get startConversation => 'Bir sohbet başlatın!';

  @override
  String get staffWillReply => 'Bir görevli en kısa sürede size cevap verecek.';

  @override
  String get inCall => 'Aramada...';

  @override
  String get registration => 'Kayıt';

  @override
  String get deactivation => 'Devre dışı bırakma';

  @override
  String get deactivatedOn => 'Devre dışı bırakılma tarihi';

  @override
  String get accountAutoSuspend =>
      '30 gün içinde doğrulanmayan hesaplar otomatik olarak askıya alınacaktır.';

  @override
  String get ipClean => 'IP temiz - listelenmemiş';

  @override
  String get documentsProvidedByBoard =>
      'Belgeler yönetim kurulu tarafından sağlanır.';

  @override
  String get noDocumentsAvailable => 'Belge bulunmuyor';

  @override
  String get noDocumentsDescription => 'Sizin için henüz belge sağlanmadı.';

  @override
  String uploadedBy(String name) {
    return 'Yükleyen: $name';
  }

  @override
  String stepsCompleted(int completed, int total) {
    return '$completed/$total adım tamamlandı';
  }

  @override
  String dayOfMonth(int day) {
    return 'Ayın $day. günü';
  }

  @override
  String changeField(String field) {
    return '$field değiştir';
  }

  @override
  String openDocument(String name) {
    return '$name aç';
  }

  @override
  String get helpImproveApp =>
      'Uygulamayı geliştirmemize yardımcı olmak ister misiniz?';

  @override
  String get noPersonalDataCollected =>
      'Kişisel veri toplanmaz. Bu ayar her zaman değiştirilebilir.';

  @override
  String logEntries(int count) {
    return '$count kayıt';
  }

  @override
  String get noLogs => 'Günlük yok';

  @override
  String get newLoginDetected => 'Yeni giriş algılandı';

  @override
  String get waitingForMember => 'Üye bekleniyor';

  @override
  String get waitingForStaff => 'Personel bekleniyor';

  @override
  String get waitingForAuthority => 'Kurum bekleniyor';
}
