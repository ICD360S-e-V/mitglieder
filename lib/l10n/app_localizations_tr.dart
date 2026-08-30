// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

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
  String get confirmPassword => 'Şifreyi Onayla';

  @override
  String get confirmPasswordHint => 'Lütfen şifrenizi onaylayın';

  @override
  String get newPassword => 'Yeni Şifre';

  @override
  String get newPasswordHint => 'Lütfen yeni şifrenizi girin';

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
  String get unknown => 'Bilinmeyen';

  @override
  String error(String error) {
    return 'Hata: $error';
  }

  @override
  String get cancel => 'İptal';

  @override
  String get resetPassword => 'Şifreyi Sıfırla';

  @override
  String get imprint => 'Künye';

  @override
  String get privacy => 'Gizlilik Politikası';

  @override
  String get statutes => 'Tüzük';

  @override
  String get revocation => 'İptal Hakkı';

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
  String get myAppointments => 'Randevularım';

  @override
  String get priority => 'Öncelik';

  @override
  String get messageLabel => 'Mesaj';

  @override
  String get reportProblems => 'Sorunları Bildir';

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
  String get low => 'Düşük';

  @override
  String get high => 'Yüksek';

  @override
  String get submit => 'Gönder';

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
  String get saveEmail => 'E-postayı Kaydet';

  @override
  String get savePassword => 'Şifreyi Kaydet';

  @override
  String get deviceLoggedOut => 'Cihaz çıkış yaptı';

  @override
  String get emailChangedSuccessfully => 'E-posta başarıyla değiştirildi';

  @override
  String get errorChangingPassword => 'Şifre değiştirme hatası';

  @override
  String get errorChangingEmail => 'E-posta değiştirme hatası';

  @override
  String get validEmailRequired => 'Lütfen geçerli bir e-posta adresi girin';

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
  String get autoUpdateEnableTitle => 'Install future updates automatically';

  @override
  String get autoUpdateEnableHint =>
      'The app downloads and installs updates on its own and restarts briefly. No further prompts.';

  @override
  String autoUpdateInstalling(String version) {
    return 'Version $version is being installed in the background. The app will restart shortly.';
  }

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
  String get reasonLabel2 => 'Sebep';

  @override
  String get downloadFailed2 => 'İndirme başarısız';

  @override
  String get downloadTooltip => 'İndir';

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
  String logEntries(int count) {
    return '$count kayıt';
  }

  @override
  String get noLogs => 'Günlük yok';

  @override
  String get newLoginDetected => 'Yeni giriş algılandı';

  @override
  String get errorNoInternet =>
      'İnternet bağlantısı yok. Lütfen ağınızı kontrol edin.';

  @override
  String get errorTimeout =>
      'Sunucu yanıt vermiyor. Lütfen daha sonra tekrar deneyin.';

  @override
  String get errorServer => 'Sunucu hatası. Lütfen daha sonra tekrar deneyin.';

  @override
  String get errorConnection =>
      'Bağlantı hatası. Lütfen daha sonra tekrar deneyin.';

  @override
  String get errorUnexpected =>
      'Beklenmeyen bir hata oluştu. Lütfen daha sonra tekrar deneyin.';

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
  String get claudiuWelcomeMorning => 'Günaydın';

  @override
  String get claudiuWelcomeDay => 'Merhaba';

  @override
  String get claudiuWelcomeEvening => 'İyi akşamlar';

  @override
  String get claudiuWelcomeNight => 'İyi akşamlar';

  @override
  String get claudiuWelcomeVisitor => 'sevgili ziyaretçi';

  @override
  String get claudiuWelcomeAsk => 'Sana nasıl yardımcı olabilirim?';

  @override
  String get claudiuWelcomeBecomeMember => 'Üye olmak istiyorum';

  @override
  String get claudiuWelcomeLogin => 'Zaten üyeyim ve giriş yapmak istiyorum';

  @override
  String get claudiuWelcomeProblem => 'Uygulamayla bir sorunum var';

  @override
  String get claudiuWelcomeEmergency => 'Acil — bizi arayın';

  @override
  String get claudiuWelcomeMascotName => 'Claudiu';

  @override
  String get claudiuWelcomeEmergencyIntro =>
      'Aramadan önce — çalışma saatlerimiz:';

  @override
  String get claudiuWelcomeScheduleOffice => 'Ofiste';

  @override
  String get claudiuWelcomeScheduleField => 'Sahada müşterilerle';

  @override
  String get claudiuWelcomeOutsideHoursNote =>
      'Bu saatlerin dışında yalnızca acil durumlarla ilgileniyoruz. Aynı numaraya SMS de gönderebilirsin — sana döneriz.';

  @override
  String get claudiuWelcomeCallNow => 'Şimdi ara';

  @override
  String get claudiuWelcomeSendSms => 'SMS gönder';

  @override
  String get claudiuWelcomeSmsBody =>
      'ICD360S e.V. acil — lütfen en kısa sürede benimle iletişime geçin.';

  @override
  String get claudiuWelcomeCloseButton => 'Kapat';

  @override
  String get claudiuLoginWelcome => 'Tekrar hoş geldin, sevgili üye!';

  @override
  String get claudiuLoginAsk => 'Lütfen üye numaranı söyle.';

  @override
  String get claudiuLoginProgress => 'Neredeyse… yazmaya devam et.';

  @override
  String get claudiuLoginReady => 'Mükemmel! Aşağıdaki düğmeye dokun.';

  @override
  String get claudiuLoginLoading => 'Kimliği doğruluyorum… 🔍';

  @override
  String get claudiuLoginFoundPlain => 'Seni buldum! Giriş yapılıyor…';

  @override
  String claudiuLoginFoundNamed(String name) {
    return 'Seni buldum, $name! Giriş yapılıyor…';
  }

  @override
  String get claudiuLoginError =>
      'Hm, bu numarayı bulamıyorum. Doğru mu yazdın?';

  @override
  String get claudiuLoginForgotHeader => 'Üye numaranı mı unuttun?';

  @override
  String get claudiuLoginNoSms =>
      'Numarayı e-posta veya SMS ile göndermiyoruz.';

  @override
  String get claudiuLoginOnlyWay =>
      'Tek yol: kimlik kontrolünden sonra dernek ofisinde yüz yüze görüşmek.';

  @override
  String get claudiuLoginContactUs => 'Randevu için bizi ara:';

  @override
  String get claudiuDiagnosticGreeting => 'Girmeden önce, kısa bir soru';

  @override
  String get claudiuDiagnosticAsk =>
      'Geliştiriciler uygulamayı iyileştirebilsin diye anonim raporlar gönderebilir miyim?';

  @override
  String get claudiuDiagnosticYes => 'Evet, yardım etmek istiyorum';

  @override
  String get claudiuDiagnosticNo => 'Hayır, sadece bakıyorum';

  @override
  String get claudiuDiagnosticTellMore => 'Daha fazla anlat';

  @override
  String get claudiuDiagnosticSendsHeader => '📤 NE GÖNDERİRİZ (anonim):';

  @override
  String get claudiuDiagnosticSends1 =>
      'Anonim cihaz kodu (üye numarası DEĞİL)';

  @override
  String get claudiuDiagnosticSends2 => 'Rolün (üye / yönetim)';

  @override
  String get claudiuDiagnosticSends3 =>
      'İşletim sistemi (Linux / Android / iOS / Windows)';

  @override
  String get claudiuDiagnosticSends4 => 'Seçilen dil';

  @override
  String get claudiuDiagnosticSends5 => 'Pil seviyesi ve durumu';

  @override
  String get claudiuDiagnosticSends6 => 'Mevcut ekran';

  @override
  String get claudiuDiagnosticSends7 => 'Oturum süresi (saniye)';

  @override
  String get claudiuDiagnosticSends8 => 'Varsa hatalar (son 10)';

  @override
  String get claudiuDiagnosticSends9 => 'Gezinme (son 20 ekran)';

  @override
  String get claudiuDiagnosticSends10 =>
      'Uygulamanın kaç kez veri gönderdiği (yalnızca sayı, içerik yok)';

  @override
  String get claudiuDiagnosticSends11 =>
      'Sistemin uygulamayı nasıl sınıflandırdığı ve pilin ne kadar hızlı boşaldığı';

  @override
  String get claudiuDiagnosticNeverHeader => '🛡️ ASLA göndermediklerimiz:';

  @override
  String get claudiuDiagnosticNever1 => 'Gerçek adın';

  @override
  String get claudiuDiagnosticNever2 => 'E-posta adresi';

  @override
  String get claudiuDiagnosticNever3 => 'Telefon numarası';

  @override
  String get claudiuDiagnosticNever4 => 'Şifre';

  @override
  String get claudiuDiagnosticNever5 => 'Sohbet mesajlarının içeriği';

  @override
  String get claudiuDiagnosticNever6 => 'Bilet içerikleri';

  @override
  String get claudiuDiagnosticNever7 => 'Belgeler veya ekler';

  @override
  String get claudiuDiagnosticTechHeader => '📡 Teknik detaylar:';

  @override
  String get claudiuDiagnosticTech1 => '15 dakikada bir gönderilir';

  @override
  String get claudiuDiagnosticTech2 =>
      'Sabitlenmiş sertifikalı TLS şifreli bağlantı';

  @override
  String get claudiuDiagnosticTech3 =>
      'İstediğin zaman Ayarlar\'dan kapatabilirsin';

  @override
  String get claudiuProblemHelpTitle => 'Nasıl yardımcı olabilirim?';

  @override
  String get claudiuProblemHelpGreeting => 'Ne oldu?';

  @override
  String get claudiuProblemHelpAsk => 'Bana nasıl anlatmak istersin?';

  @override
  String get claudiuProblemHelpWriteTitle => 'Bir rapor yaz';

  @override
  String get claudiuProblemHelpWriteBody =>
      'Adım adım ayrıntılarla. Ekip metni alır ve daha sonra çözer.';

  @override
  String get claudiuProblemHelpChatTitle => 'Şimdi konuşalım';

  @override
  String get claudiuProblemHelpChatBody =>
      'Bir operatörle anonim sohbet. Biri çevrimiçiyse gerçek zamanlı yanıt.';

  @override
  String get claudiuProblemHelpAltCallHeader => 'Veya acilse:';

  @override
  String get claudiuProblemHelpAltCallLabel => 'Bizi ara';

  @override
  String get claudiuAnonymousChatTitle => 'Anonim sohbet';

  @override
  String get claudiuAnonymousChatGreeting => 'Selam!';

  @override
  String get claudiuAnonymousChatWelcome =>
      'Seni dinliyorum. İstediğini yaz — isim gerekmez. Geldiğimde hemen yanıtlarım.';

  @override
  String get claudiuAnonymousChatHint => 'Bir mesaj yaz…';

  @override
  String get claudiuAnonymousChatWaitingOperator =>
      'Bir operatörün yanıtlamasını bekliyoruz…';

  @override
  String get claudiuVorsitzerConnectedTitle => 'Selam!';

  @override
  String get claudiuVorsitzerConnectedBody =>
      'Yazdığın için sağ ol — şimdi bir Vorsitzer ile bağlantıdasın. Üyelik başvurun konusunda nasıl yardımcı olabileceğimizi söyle.';

  @override
  String get claudiuVorsitzerConnectedSender => 'Vorsitzer';

  @override
  String get claudiuQuickReplyValidationTime => 'Doğrulama ne kadar sürer?';

  @override
  String get claudiuQuickReplyDocuments => 'Hangi belgelere ihtiyacım var?';

  @override
  String get claudiuQuickReplyStepProblem => 'Bir adımda takıldım';

  @override
  String get claudiuQuickReplyHuman => 'Şimdi biriyle konuşabilir miyim?';

  @override
  String get claudiuAnonymousChatConnecting => 'Bağlanılıyor…';

  @override
  String get claudiuAnonymousChatConnectionFailed =>
      'Sohbet açılamadı. Tekrar dene veya bizi ara.';

  @override
  String get claudiuAnonymousChatRetry => 'Tekrar dene';

  @override
  String get claudiuAnonymousChatOnline => 'Bağlı';

  @override
  String get claudiuAnonymousChatOffline => 'Yeniden bağlanılıyor…';

  @override
  String get claudiuAnonymousChatAdminTyping => 'Operatör yazıyor…';

  @override
  String get claudiuProblemReportTitle => 'Bir sorun bildir';

  @override
  String get claudiuProblemReportGreeting => 'Ne oldu?';

  @override
  String get claudiuProblemReportAsk =>
      'Bana ayrıntılı anlat, raporu ekibe ileteyim.';

  @override
  String get claudiuProblemReportIncludeHeader => 'Lütfen şunları ekle:';

  @override
  String get claudiuProblemReportIncludeBullets1 =>
      'Sorun ortaya çıktığında ne yapıyordun';

  @override
  String get claudiuProblemReportIncludeBullets2 => 'Gördüğün hata mesajı';

  @override
  String get claudiuProblemReportIncludeBullets3 => 'Hangi ekrandaydın';

  @override
  String get claudiuProblemReportIncludeBullets4 =>
      'Uygulama çöküyor mu, kapanıyor mu ya da boş ekran mı gösteriyor?';

  @override
  String get claudiuProblemReportIncludeBullets5 =>
      'Her seferinde mi yoksa sadece bir kez mi oluyor?';

  @override
  String get claudiuProblemReportDescriptionLabel => 'Açıklaman';

  @override
  String get claudiuProblemReportDescriptionHint =>
      'Örn.: Sohbet ekranını açtığımda \'Connection error\' mesajı geliyor ve uygulama yanıt vermiyor…';

  @override
  String claudiuProblemReportTooShort(int count) {
    return 'Biraz daha ayrıntı lütfen (en az $count karakter)';
  }

  @override
  String get claudiuProblemReportSubmit => 'Raporu gönder';

  @override
  String get claudiuProblemReportSubmitting => 'Gönderiliyor…';

  @override
  String get claudiuProblemReportSentTitle => 'Teşekkürler!';

  @override
  String get claudiuProblemReportSentBody =>
      'Rapor gönderildi. Ekibimiz en kısa sürede inceleyecek.';

  @override
  String get claudiuProblemReportSentClose => 'Anladım';

  @override
  String get claudiuProblemReportSendFailed =>
      'Rapor gönderilemedi. Acil yardım için bizi ara.';

  @override
  String get claudiuProblemReportAlt => 'Veya acilse:';

  @override
  String get claudiuProblemReportCallLabel => 'Bizi ara';

  @override
  String claudiuApprovalGreeting(String name) {
    return 'Merhaba, $name! 👋';
  }

  @override
  String get claudiuApprovalGreetingNoName => 'Merhaba! 👋';

  @override
  String get claudiuApprovalGladToSeeYou => 'Geldiğine sevindim!';

  @override
  String get claudiuApprovalCheckingForSafety =>
      'Güvenliğin için, bir Vorsitzer giriş talebini şimdi kontrol ediyor. 🛡️';

  @override
  String get claudiuApprovalMonthlyExplain =>
      '💡 Bunu her 30 günde bir, gerçekten sen olduğundan emin olmak için yapıyoruz. Bir güvenlik kontrolü gibi — en fazla 5 dakika.';

  @override
  String get claudiuApprovalSuccess =>
      'Tamam! 🎉 Vorsitzer seni tanıdı. Giriş yapılıyor…';

  @override
  String get claudiuApprovalDenied => 'Hm, Vorsitzer talebini reddetti. 😔';

  @override
  String get claudiuApprovalDeniedHelp =>
      'Bu bir hata olduğunu düşünüyorsan, lütfen bizi ara, çözelim.';

  @override
  String get claudiuApprovalExpired =>
      '5 dakika geçti ve Vorsitzer\'den yanıt alamadık.';

  @override
  String get claudiuApprovalExpiredHelp =>
      'Bizi ara, talebini hemen onaylayabiliriz. 📞';

  @override
  String get claudiuApprovalCallUs => 'Bizi ara';

  @override
  String get claudiuApprovalTryAgain => 'Tekrar dene';

  @override
  String get claudiuApprovalCancel => 'İptal';

  @override
  String get claudiuApprovalClose => 'Kapat';

  @override
  String get wizardIntroBubble1 =>
      'Merhaba, ziyaretçi! 👋 Ailemize katılmak istediğin için teşekkürler.';

  @override
  String get wizardIntroBubble2 =>
      'Adım Claudiu. 2025 baharında net bir vizyonum vardı: ihtiyacı olan insanlara yardım eden bir dernek kurmak — gönüllü olarak, kalpten, gereksiz bürokrasi olmadan. ❤️';

  @override
  String get wizardIntroBubble3 =>
      'Ziyaret ettiğim danışanlarla konuşmaya başladım. Onlara hayalimi anlattım. Ve her biri \"Evet, hadi!\" dedi. Temmuz 2025\'te 6 kararlı insan olarak buluştuk. Neu-Ulm\'da **ICD360S e.V.**\'yi kurmaya karar verdik. 📍';

  @override
  String get wizardIntroBubble4 =>
      '**1 Ağustos 2025**\'te dernek resmen hayata geldi — Dernekler Sicili\'nde. En güzel hediyem. 🎂';

  @override
  String get wizardIntroBubble5 =>
      'Ne yapıyoruz? Mültecilere, engellilere, ekonomik olarak dezavantajlı kişilere, **çocuklara ve gençlere** yardım ediyoruz — idari işlemlerde, Almanca öğrenmede, konut bulmada, alışverişte, sosyal yardımlarda. Vorstand\'ımızın büyük çoğunluğu engelli kişilerden oluşuyor — böylece kararlar gerçek yaşam deneyiminden geliyor. 🤝';

  @override
  String get wizardIntroBubble6 =>
      'Şimdi sıra sende. Seni kaydedelim — yaklaşık 5 dakika sürer. Adım adım gideceğiz, seni yalnız bırakmayacağım. ✨';

  @override
  String get wizardIntroStart => 'Hadi başlayalım';

  @override
  String get wizardBack => 'Geri';

  @override
  String get wizardNext => 'İleri';

  @override
  String wizardStepLabel(int step, int total, String title) {
    return '$step. adım / $total · $title';
  }

  @override
  String get wizardErrRequired => 'Bu alan zorunludur';

  @override
  String wizardErrTooShort(int count) {
    return 'Çok kısa (en az $count karakter)';
  }

  @override
  String get wizardErrOnlyLetters =>
      'Yalnızca harfler, boşluklar, tireler ve kesme işaretleri';

  @override
  String get wizardErrSaveFailed =>
      'Kaydedilemedi. Bağlantını kontrol et ve tekrar dene.';

  @override
  String get wizardStufe1aTitle => 'Kimlik';

  @override
  String get wizardStufe1aPrompt =>
      'Resmi olarak tanışalım. Adını lütfen Personalausweis, Reisepass veya Aufenthaltstitel\'de göründüğü gibi yaz — belgelerinle uyumlu kalsın.';

  @override
  String get wizardStufe1aVornameLabel => 'Vornamen (adlar)';

  @override
  String get wizardStufe1aVornameHelper =>
      'Tüm adların belgendekiyle aynı şekilde. Boşluk veya tire kullan (örn. Hans-Peter, Maria Anna).';

  @override
  String get wizardStufe1aNachnameLabel => 'Familienname (soyad)';

  @override
  String get wizardStufe1aNachnameHelper => 'Mevcut soyadın.';

  @override
  String get wizardStufe1aGeburtsnameLabel =>
      'Geburtsname (doğum soyadı) — isteğe bağlı';

  @override
  String get wizardStufe1aGeburtsnameHelper =>
      'Yalnızca Familienname\'den farklıysa — örn. evlilik öncesi.';

  @override
  String get wizardStufe1bTitle => 'Doğum günü';

  @override
  String get wizardStufe1bPrompt =>
      'Doğum gününü seninle kutlamak isteriz! 🎂 Ayrıca en az 16 yaşında olduğunu doğrulamamıza yardımcı olur — tüzüğümüz öyle diyor.';

  @override
  String get wizardStufe1bGeburtsdatumLabel => 'Doğum tarihi';

  @override
  String get wizardStufe1bGeburtsdatumHelper => 'Tarih seçmek için dokun';

  @override
  String get wizardStufe1bGeburtsortLabel => 'Doğum yeri';

  @override
  String get wizardStufe1bGeburtsortHelper => 'Doğduğun şehir / kasaba.';

  @override
  String get wizardAgeGatePrompt => 'Üzgünüm… 😔';

  @override
  String wizardAgeGateBody1(int age, int years) {
    return 'Tüzüğümüze göre üye olabilmek için en az 16 yaşında olman gerekiyor. $age yaşındasın — $years yıl sonra görüşmek dileğiyle! 🌱';
  }

  @override
  String get wizardAgeGateBody2 =>
      'Ara sıra gönüllü olmak istersen (her yaşta, ailenin onayıyla), bizi ara — dünyayı değiştirmek isteyen gençleri desteklemeyi seviyoruz.';

  @override
  String get wizardAgeGateBackHome => 'Karşılama ekranına dön';

  @override
  String get wizardErrInvalidPhone => 'Geçersiz telefon numarası';

  @override
  String get wizardStufe1b1Title => 'Veli onayı';

  @override
  String get wizardStufe1b1Prompt =>
      'Reşit değilsin (16-17) — §106 BGB uyarınca anne, baba veya yasal vasinin onayı gerekiyor. Bana adını ve telefon numarasını söyle. Bir Vorsitzer onu arayıp bir toplantı (yüz yüze veya görüntülü görüşme) ayarlayacak. E-posta yok — doğru kişiyle konuştuğumuzdan emin olmak istiyoruz.';

  @override
  String get wizardStufe1b1VornameLabel => 'Veli adı';

  @override
  String get wizardStufe1b1VornameHelper =>
      'Velinin Personalausweis\'inde göründüğü gibi.';

  @override
  String get wizardStufe1b1NachnameLabel => 'Veli soyadı';

  @override
  String get wizardStufe1b1NachnameHelper =>
      'Velinin Personalausweis\'inde göründüğü gibi.';

  @override
  String get wizardStufe1b1TelefonLabel => 'Veli cep telefonu';

  @override
  String get wizardStufe1b1TelefonHelper =>
      'Bu numarayı bir Vorsitzer arayacak.';

  @override
  String get wizardStufe1b1RelationLabel => 'Çocukla ilişki:';

  @override
  String get wizardStufe1b1RelationMutter => 'Anne';

  @override
  String get wizardStufe1b1RelationVater => 'Baba';

  @override
  String get wizardStufe1b1RelationSorgeberechtigter => 'Yasal vasi';

  @override
  String get wizardStufe1b1RelationAndere => 'Diğer vasi';

  @override
  String get wizardStufe1cTitle => 'Kişisel bilgiler';

  @override
  String get wizardStufe1cPrompt =>
      'Sadece seni biraz daha tanımak için. Bu aramızda kalır ve hiçbir yerde herkese açık şekilde gösterilmez.';

  @override
  String get wizardStufe1cGeschlechtLabel => 'Cinsiyet';

  @override
  String get wizardStufe1cGeschlechtMaennlich => 'Erkek';

  @override
  String get wizardStufe1cGeschlechtWeiblich => 'Kadın';

  @override
  String get wizardStufe1cGeschlechtDivers => 'Diğer';

  @override
  String get wizardStufe1cGeschlechtKeineAngabe => 'Söylemek istemiyorum';

  @override
  String get wizardStufe1cFamilienstandLabel => 'Medeni durum';

  @override
  String get wizardStufe1cFamilienstandLedig => 'Bekâr';

  @override
  String get wizardStufe1cFamilienstandVerheiratet => 'Evli';

  @override
  String get wizardStufe1cFamilienstandGeschieden => 'Boşanmış';

  @override
  String get wizardStufe1cFamilienstandVerwitwet => 'Dul';

  @override
  String get wizardStufe1dTitle => 'Geçmişin';

  @override
  String get wizardStufe1dPrompt =>
      'Bu, sana doğru desteği sunmamıza yardımcı olur — örneğin Aufenthalt danışmanlığı veya dil topluluğunu bulmak.';

  @override
  String get wizardStufe1dStaatLabel => 'Uyruk';

  @override
  String get wizardStufe1dStaatHelper =>
      'Örn. deutsch, rumänisch, ukrainisch. Birden fazlasını virgülle ayır.';

  @override
  String get wizardStufe1dAufenthaltLabel =>
      'Oturum durumu (Aufenthaltsstatus) — isteğe bağlı';

  @override
  String get wizardStufe1dAufenthaltHelper =>
      'Başlığı Aufenthaltskarte / karar yazından seç. Vorstand belgelerinle karşılaştırır.';

  @override
  String get wizardStufe1dAufenthaltAwaitingCitizenship =>
      'Önce yukarıdan vatandaşlığı doldur — sadece uygun seçenekleri göstereceğiz.';

  @override
  String get wizardStufe1dAufenthaltGerman =>
      'Aufenthaltstitel gerekmez — Alman vatandaşı.';

  @override
  String get wizardStufe1dAufenthaltEuEea =>
      'AB/AEA/CH vatandaşı — serbest dolaşım (Freizügigkeit).';

  @override
  String get wizardStufe1dAufenthaltTempHint => 'geçici';

  @override
  String get wizardStufe1dAufenthaltPermHint => 'kalıcı yerleşim';

  @override
  String get wizardStufe1dAufenthaltAsylumProcessHint => 'iltica süreci';

  @override
  String get wizardStufe1dAufenthaltOther => 'Diğer (lütfen sohbette belirt)';

  @override
  String get wizardStufe1dAufenthaltRequired =>
      'Lütfen bir Aufenthaltstitel seç.';

  @override
  String get wizardStufe1dMutterspracheLabel => 'Ana dil';

  @override
  String get wizardStufe1dMutterspracheHelper =>
      'Uygulama diliyle önceden dolduruldu — farklıysa değiştir.';

  @override
  String get wizardStufe1eTitle => 'Adres';

  @override
  String get wizardStufe1ePrompt =>
      'Posta adresin — onu resmi belgeler için kullanırız (tüzük, üyelik sözleşmeleri, bildirimler).';

  @override
  String get wizardStufe1eStrasseLabel => 'Sokak';

  @override
  String get wizardStufe1eStrasseHelper =>
      'Sadece sokak adı — numara yan kutuya.';

  @override
  String get wizardStufe1eHausnummerLabel => 'No';

  @override
  String get wizardStufe1ePlzLabel => 'PLZ (posta kodu)';

  @override
  String get wizardStufe1eOrtLabel => 'Şehir';

  @override
  String get wizardStufe1eLandLabel => 'Ülke';

  @override
  String get wizardStufe1eLandHelper => 'Önceden dolduruldu: Deutschland.';

  @override
  String get wizardErrInvalidStreet => 'Geçersiz sokak adı';

  @override
  String get wizardErrInvalidHausnummer =>
      'Geçersiz numara (örn. 12, 12a, 12/3)';

  @override
  String get wizardErrInvalidPlz => 'Geçersiz posta kodu (yalnızca rakam)';

  @override
  String get wizardStufe1fTitle => 'İletişim';

  @override
  String get wizardStufe1fPrompt =>
      'Sana nasıl ulaşalım? Telefon yalnızca acil durumlar için — geri kalan her şey kendi uygulamamızdaki uçtan uca şifreli kanaldan ilerliyor. Üye e-postan otomatik olarak atanır ve aşağıda görünür.';

  @override
  String get wizardStufe1fTelefonLabel => 'Cep telefonu';

  @override
  String get wizardStufe1fTelefonHelper =>
      'Söz veriyorum, sadece önemli olduğunda ararım. 📱';

  @override
  String get wizardStufe2Title => 'Üyelik türü';

  @override
  String get wizardStufe2Prompt =>
      'Ne tür bir üye olmak istiyorsun? Her seçeneği açıklayayım.';

  @override
  String get wizardStufe2OrdentlichTitle => 'Asıl üye (ordentlich)';

  @override
  String get wizardStufe2OrdentlichBody =>
      'Tam haklar. Aylık aidat ödersin, Genel Kurul\'da oy verirsin, Yönetim Kurulu\'na seçilebilirsin. Standart seçim.';

  @override
  String get wizardStufe2FoerderTitle => 'Destek üyesi (Fördermitglied)';

  @override
  String get wizardStufe2FoerderBody =>
      'Derneği maddi olarak desteklersin ama kararlara aktif katılmazsın. Oy hakkı yok. Uzaktan yardım etmek istiyorsan iyi seçim.';

  @override
  String get wizardStufe2EhrenTitle => 'Onursal üye (Ehrenmitglied)';

  @override
  String get wizardStufe2EhrenBody =>
      'Yönetim Kurulu tarafından özel hizmetler için verilir. Bunu kendin seçemezsin — bir takdir olarak verilir. Yalnızca daha önce onurlandırıldıysan seç.';

  @override
  String get wizardStufe3Title => 'Mali durum';

  @override
  String get wizardStufe3Prompt =>
      'Şimdi mali durumun hakkında. Yargılamak için değil — sosyal yardım alıyorsan aidattan muaf tutalım diye.';

  @override
  String get wizardStufe3OptionBuergergeld => 'Bürgergeld alıyorum';

  @override
  String get wizardStufe3OptionSozialamt => 'Sozialamt\'tan yardım alıyorum';

  @override
  String get wizardStufe3OptionNein => 'Bunlardan hiçbirini almıyorum';

  @override
  String get wizardStufe3FeeExemptTitle => 'Aidat: 0 € / ay 🎉';

  @override
  String get wizardStufe3FeeExemptBody =>
      'Bürgergeld, Sozialamt, ALG I veya Krankengeld ile Tüzük §6 uyarınca aidattan tamamen muafsın. Bize sadece bir belge (Leistungsbescheid veya kurum / hastalık sigortasından alınan belge) lazım.';

  @override
  String get wizardStufe3UploadTitle => 'Leistungsbescheid yükle';

  @override
  String get wizardStufe3UploadHint => 'PDF / JPG / PNG, en fazla 10 MB.';

  @override
  String get wizardStufe3UploadRequired =>
      'Devam etmeden önce lütfen Leistungsbescheid\'i yükle.';

  @override
  String get wizardStufe3FileTooLarge => 'Dosya çok büyük. En fazla 10 MB.';

  @override
  String get wizardStufe3UploadFailed => 'Dosya yüklenemedi. Tekrar dene.';

  @override
  String get wizardStufe3RegularFeeTitle => 'Aidat: 25 € / ay';

  @override
  String get wizardStufe3RegularFeeBody =>
      'Tüzüğümüze göre asıl üyeler için standart aidat.';

  @override
  String get wizardStufe4Title => 'Ödeme';

  @override
  String get wizardStufe4Prompt =>
      'Üyelik aidatını nasıl ödemek istersin? Ve ayın hangi günü çekilsin?';

  @override
  String get wizardStufe4MethodUeberweisungTitle =>
      'Banka havalesi (Überweisung)';

  @override
  String get wizardStufe4MethodUeberweisungBody =>
      'Her ay ödemeyi kendin başlatırsın.';

  @override
  String get wizardStufe4MethodSepaTitle => 'SEPA-Lastschrift (otomatik ödeme)';

  @override
  String get wizardStufe4MethodSepaBody =>
      'Tutarı hesabından otomatik çekiyoruz. En kolayı ama IBAN ve imzalı yetki belgesi gerekiyor.';

  @override
  String get wizardStufe4MethodDauerauftragTitle =>
      'Dauerauftrag (düzenli talimat)';

  @override
  String get wizardStufe4MethodDauerauftragBody =>
      'Bankanda düzenli talimat oluşturursun. Banka her ay tutarı otomatik aktarır.';

  @override
  String get wizardStufe4DayLabel => 'Ödeme günü';

  @override
  String get wizardStufe4DayHint => '1 ile 31 arasında bir gün seç';

  @override
  String wizardStufe4DayItem(int day) {
    return '$day. gün';
  }

  @override
  String wizardStufe4DayReminder(int day) {
    return 'Aidat her ayın $day. günü çekilecek.';
  }

  @override
  String get wizardStufe5Title => 'Başlangıç';

  @override
  String get wizardStufe5Prompt =>
      'ICD360S üyeliğin ne zamandan itibaren resmen başlasın? Onaydan itibaren mi yoksa geriye dönük olarak mı?';

  @override
  String get wizardStufe5OptionAbVerifizierungTitle =>
      'Vorstand\'ın onayından itibaren';

  @override
  String get wizardStufe5OptionAbVerifizierungBody =>
      'En basit seçim. Geriye dönük aidat yok.';

  @override
  String get wizardStufe5OptionGruendungsdatumTitle =>
      '01.08.2025\'e geriye dönük (kuruluş)';

  @override
  String get wizardStufe5OptionGruendungsdatumBody =>
      'Derneğin ilk gününden itibaren üye sayılırsın.';

  @override
  String get wizardStufe5OptionAnderesDatumTitle => 'Başka bir tarih';

  @override
  String get wizardStufe5OptionAnderesDatumBody =>
      '01.08.2025 ile bugün arasında bir tarih seçersin.';

  @override
  String get wizardStufe5PickDate => 'Tarih seçmek için dokun';

  @override
  String get wizardStufe5PickDateFirst => 'Lütfen önce bir tarih seç.';

  @override
  String get wizardStufe5DatePickerHelp => 'Üyelik başlangıcı';

  @override
  String wizardStufe5DateRange(String start) {
    return '$start ile bugün arasında';
  }

  @override
  String get wizardStufe5RetroactiveTitle => 'Geriye dönük aidat';

  @override
  String wizardStufe5RetroactiveBody(
      String start, String end, int months, String amount) {
    return '$start - $end arası $months ay. Ayda 25 € üzerinden bu, mevcut aylık aidatın yanı sıra geriye dönük $amount € borç anlamına gelir.';
  }

  @override
  String get wizardStufe5FeeExemptTitle => 'Geriye dönük aidat: 0 € 🎉';

  @override
  String get wizardStufe5FeeExemptBody =>
      'Bürgergeld veya Sozialamt ile tamamen muafsın — geriye dönük olarak da hiçbir şey ödemen gerekmez.';

  @override
  String wizardDocumentPrompt(String doc) {
    return 'Bitirmeden önce lütfen $doc\'u dikkatlice oku. Neyi imzaladığını bilmen önemli.';
  }

  @override
  String get wizardDocumentScrollHint => 'Devam etmek için en alta kaydır.';

  @override
  String get wizardDocumentScrolledOk => 'Sona kadar okudun ✓';

  @override
  String wizardDocumentOpenButton(String doc) {
    return '$doc\'u tarayıcıda aç';
  }

  @override
  String get wizardDocumentExternalHint =>
      'Bu platformda belgeyi varsayılan tarayıcında açıyoruz.';

  @override
  String get wizardDocumentOpenedOk => 'Belge açıldı. Lütfen dikkatlice oku.';

  @override
  String wizardDocumentConfirm(String doc) {
    return '$doc\'u okuduğumu ve kabul ettiğimi onaylıyorum.';
  }

  @override
  String get wizardFinalAdultTitle => 'Tamam! Kaydın yapıldı 🎉';

  @override
  String get wizardFinalMinorTitle => 'Talebin gönderildi 📨';

  @override
  String get wizardFinalMinorBody =>
      'Velinizle iletişime geçeceğiz ve bir görüşme ayarlayacağız (yüz yüze veya görüntülü görüşme). Lütfen sabırlı ol — süreç en fazla 7 gün sürebilir. Velin onayladığı anda uygulamadan bir bildirim alacaksın.';

  @override
  String get wizardFinalMitgliedernummerLabel => 'Üye numaran';

  @override
  String get wizardStufe4MethodComingSoon => 'Yakında';

  @override
  String get wizardStufe4StreichungWarning =>
      'Aidatta 6 aydan fazla geride kalırsan otomatik olarak silinirsin (Tüzük §6 Abs. 3).';

  @override
  String get wizardStufe5KuendigungInfo =>
      'Üyelikten ayrılmak için: 31 Aralık\'tan 3 ay önce yazılı bildirimini gönder (yıl sonu itibarıyla geçerli olması için en geç 30 Eylül). Asgari süre yok (Tüzük §6 Abs. 3).';

  @override
  String get wizardStufe1fEmailLabel => 'Üye e-postan';

  @override
  String get wizardStufe1fEmailHelper =>
      'Üye numarandan otomatik olarak oluşturulur. Yönetim kurulu (Vorstand) başvurunu onayladığı anda devreye girer. Kendi özel e-posta uygulamamız var — şifreli e-postalar gönder ve al, basit ve ücretsiz.';

  @override
  String get wizardErrInvalidEmail => 'Geçersiz e-posta adresi';

  @override
  String get wizardStufe3OptionAlg1 =>
      'Arbeitslosengeld I (ALG I, işsizlik yardımı) alıyorum';

  @override
  String get wizardStufe3OptionKrankengeld =>
      'Krankengeld (uzun süreli hastalık ödeneği) alıyorum';

  @override
  String get wizardStufe3UploadAddMore => 'Başka belge ekle';

  @override
  String get wizardStufe3UploadLimitCount =>
      'Sınıra ulaştın: en fazla 20 belge.';

  @override
  String get wizardStufe3UploadLimitTotal =>
      'Toplam sınır 100 MB doldu. Mevcut bir dosyayı sil.';

  @override
  String get wizardStufe3UploadDeleteTooltip => 'Sil';

  @override
  String wizardStufe3UploadCounter(int count, int max) {
    return '$count / $max belge';
  }

  @override
  String get wizardDocumentExternalOpenFailed =>
      'Tarayıcı açılamadı. Bağlantı panoya kopyalandı — devam etmek için bir tarayıcıya yapıştır.';

  @override
  String get wizardFinalTimelineProcessing =>
      'Vorstand inceliyor · genelde 1 iş günü, en fazla 7';

  @override
  String get wizardFinalTimelineActivated => 'Hesap aktif';

  @override
  String get wizardFinalAdultThank =>
      'Kayıt formunu doldurduğun için teşekkürler! 🎉';

  @override
  String get wizardFinalAdultUsual =>
      'Başvurun bizde. Genelde bir iş günü içinde doğruluyoruz.';

  @override
  String get wizardFinalAdultExceptional =>
      'Bazen 7 iş gününe kadar sürebilir. Bir şey uymazsa, düzeltebilmen için formu yeniden açıyoruz 🙂';

  @override
  String get wizardFinalStatusTitle => 'BAŞVURU DURUMU';

  @override
  String wizardFinalStatusStepsValidated(int reviewed, int total) {
    return '$reviewed/$total adım Vorstand tarafından doğrulandı';
  }

  @override
  String get wizardFinalStufeSheetTitle => 'Başvuru detayları';

  @override
  String get wizardFinalStufeSheetHint =>
      'Tamamladığın 8 aşama. Vorstand bunları sırayla inceler — gerçek zamanlı olarak neyin onaylandığını görürsün.';

  @override
  String get wizardFinalStufeStatusPending => 'İnceleme bekliyor';

  @override
  String get wizardFinalStufeStatusApproved => 'Onaylandı';

  @override
  String get wizardFinalStufeStatusRejected => 'Reddedildi';

  @override
  String wizardFinalStatusRejectionCount(int count) {
    return '$count adım düzeltilmeli';
  }

  @override
  String get wizardFinalStufeRejectionReason => 'Vorstand\'ın gerekçesi:';

  @override
  String get wizardFinalStufeCorrectNow => 'Şimdi düzelt';

  @override
  String wizardFinalApprovalsHeader(int current, int total) {
    return 'Vorstand onayları ($current/$total)';
  }

  @override
  String get wizardFinalApprovalAwaiting => '2. Vorstand bekleniyor';

  @override
  String get wizardFinalApprovalRejected => 'REDDEDİLDİ';

  @override
  String get wizardFinalStufeNoDataYet => 'Veriler henüz mevcut değil.';

  @override
  String get wizardFinalStufeReadAt => 'Okundu:';

  @override
  String get wizardFinalStufeBeitragsfrei => 'Aidattan muaf (ödeme gerekmez)';

  @override
  String get wizardFinalStufeNotExempt => 'Sosyal yardım yok';

  @override
  String get wizardFinalStufeBeginAtVerification => 'Doğrulamada başlar';

  @override
  String get wizardFinalStufeBeginAtFoundation =>
      'Kuruluş tarihi (geriye dönük)';

  @override
  String get wizardFinalStufeBeginAtCustom => 'Özel tarih';

  @override
  String get wizardFinalStufeStatusSkipped => 'Atlandı';

  @override
  String get wizardFinalStufeFilledAt => 'Dolduruldu:';

  @override
  String get wizardFinalStufeReviewedAt => 'İncelendi:';

  @override
  String get wizardFinalWithdrawLink => 'Başvuruyu geri çek';

  @override
  String get wizardFinalWithdrawDialogTitle => 'Başvurunu geri mi çekiyorsun?';

  @override
  String get wizardFinalWithdrawDialogBody =>
      'Başvurun, senin tarafından geri çekilmiş olarak işaretlenecek. Denetim (GDPR) için veriler veritabanında kalır, ancak hesap etkinleştirilmez. Yeni bir üye numarasıyla kaydı istediğin zaman yeniden başlatabilirsin.';

  @override
  String get wizardFinalWithdrawKeep => 'Hayır, bekliyorum';

  @override
  String get wizardFinalWithdrawConfirm => 'Evet, geri çek';

  @override
  String get wizardErrTooManyWithdrawals =>
      'Başvurun otomatik olarak işlenemez. Lütfen bizi ara veya kayda devam etmek için Vorstand\'a şahsen gel.';

  @override
  String get wizardDuplicateLoginTitle => 'Görünüşe göre zaten üyemizsin';

  @override
  String get wizardDuplicateLoginBody =>
      'İsmin ve doğum tarihinle zaten aktif bir hesap buluyoruz. Lütfen ana ekranda \'Zaten üyeyim\' seçeneğini kullanarak giriş yap. Erişimin yoksa bizi ara.';

  @override
  String get wizardDuplicatePendingTitle => 'Başvurun zaten bizde';

  @override
  String get wizardDuplicatePendingBody =>
      'İsmin ve doğum tarihinle inceleme aşamasında bir başvurun zaten var. Vorstand üzerinde çalışıyor — hesabın aktif olur olmaz uygulamadan haber veririz. Konuşmak istersen bizi ara.';

  @override
  String get wizardDuplicateRecentlyWithdrawnTitle =>
      'Bu başvuruyu şu anda işleyemiyoruz';

  @override
  String get wizardDuplicateRecentlyWithdrawnBody =>
      'İsmin ve doğum tarihin yakın zamanda geri çekilen bir başvuruyla eşleşiyor. Lütfen devam etmeden önce Vorstand ile konuşmak için bizi ara.';

  @override
  String get wizardDuplicatePreviouslyWithdrawnTitle =>
      'Daha önce başvuru yapmıştın';

  @override
  String get wizardDuplicatePreviouslyWithdrawnBody =>
      'İsmin ve doğum tarihin daha önce geri çektiğin eski bir başvuruyla eşleşiyor. Tekrar hoş geldin — devam etmeden önce Vorstand\'ın nasıl ilerleyeceğine karar verebilmesi için bizi ara.';

  @override
  String get wizardDuplicateCallUsTitle => 'Lütfen bizi ara';

  @override
  String get wizardDuplicateCallUsBody =>
      'İsmin ve doğum tarihin kayıtlarımızda zaten var, ama detayları uygulama üzerinden paylaşamayız. Lütfen ara — Vorstand sana durumu doğrudan açıklayacak.';

  @override
  String get wizardChatHelp => 'Konuşalım';

  @override
  String get wizardChatHelpSubtitle =>
      'Vorstand ile canlı sohbet · hızlı yanıt';

  @override
  String get benachrichtigungTitel => 'SMS hatırlatmaları';

  @override
  String get benachrichtigungIntro =>
      'Randevunuzu kaçırmamanız için dernek size SMS gönderebilir. Bunu isteyip istemediğinize siz karar verirsiniz ve istediğiniz zaman değiştirebilirsiniz.';

  @override
  String get benachrichtigungTermineFrage =>
      'Randevularınız için SMS ile hatırlatma almak ister misiniz?';

  @override
  String get benachrichtigungTermineDetail =>
      'Mesajda randevunun tarihi, saati, yeri ve konusu yer alır.';

  @override
  String get benachrichtigungMedikamenteFrage =>
      'İlaçlarınız için de hatırlatma ister misiniz?';

  @override
  String get benachrichtigungMedikamenteDetail =>
      'Mesajda ilacın adı yazar. Bu bir sağlık bilgisidir, bu yüzden ayrıca soruyoruz.';

  @override
  String get benachrichtigungHinweis =>
      'Hatırlatma bir yardımdır, garanti değildir; lütfen yalnızca buna güvenmeyin. Profilinizden istediğiniz zaman değiştirebilirsiniz.';

  @override
  String get benachrichtigungJa => 'Evet';

  @override
  String get benachrichtigungNein => 'Hayır';

  @override
  String get benachrichtigungSpaeter => 'Daha sonra karar ver';

  @override
  String get benachrichtigungSpeichern => 'Kaydet';

  @override
  String get benachrichtigungGespeichert => 'Teşekkürler, kaydedildi.';

  @override
  String get benachrichtigungenLeer => 'Bildirim yok';

  @override
  String get benachrichtigungenAlleGelesen => 'Tümünü okundu olarak işaretle';

  @override
  String get benachrichtigungWetterFrage =>
      'Yaşadığınız yerde şiddetli hava durumunda uyarılmak ister misiniz?';

  @override
  String get benachrichtigungWetterDetail =>
      'Yalnızca Alman Meteoroloji Servisi\'nin „şiddetli“ ve üzeri resmî uyarıları — her yağmurda değil.';

  @override
  String get signaturTitel => 'İmzalar';

  @override
  String get signaturNichtsOffen => 'Şu anda imzanızı bekleyen bir belge yok.';

  @override
  String get signaturStatusOffen => 'İmzanızı bekliyor';

  @override
  String get signaturStatusSigniert => 'Tarafınızdan imzalandı';

  @override
  String get signaturStatusAbgelehnt => 'Tarafınızdan reddedildi';

  @override
  String get signaturStatusWiderrufen => 'Dernek tarafından geri çekildi';

  @override
  String get signaturStatusAbgelaufen => 'Süre doldu';

  @override
  String signaturBitteGanzLesen(int gelesen, int gesamt) {
    return 'Lütfen belgeyi sonuna kadar okuyun (sayfa $gelesen / $gesamt).';
  }

  @override
  String get signaturWeiterZurUnterschrift => 'İmzaya geç';

  @override
  String get signaturAblehnen => 'Reddet';

  @override
  String get signaturAblehnenHinweis =>
      'Dernek bilgilendirilecektir. Gerekçenizi yazabilirsiniz.';

  @override
  String get signaturAblehnenGrund => 'Gerekçe (isteğe bağlı)';

  @override
  String get signaturMitFingerHinweis => 'Beyaz alana parmağınızla imzalayın.';

  @override
  String get signaturNochmal => 'Yeniden';

  @override
  String get signaturZurueckZumDokument => 'Belgeye dön';

  @override
  String get signaturCodeAnfordern => 'SMS ile kod iste';

  @override
  String get signaturCodeUnterwegs => 'Kod yolda.';

  @override
  String signaturCodeGesendetAn(String nummer) {
    return '$nummer numarasına bir kod gönderdik.';
  }

  @override
  String get signaturCodeErneutSenden => 'Kodu tekrar gönder';

  @override
  String get signaturJetztUnterschreiben => 'Şimdi imzala';

  @override
  String get signaturCodeFalsch => 'Kod doğru değil.';

  @override
  String get signaturCodeAbgelaufen =>
      'Kodun süresi doldu. Lütfen yeni bir kod isteyin.';

  @override
  String get signaturZuVieleVersuche =>
      'Çok fazla hatalı deneme. Lütfen yeni bir kod isteyin.';

  @override
  String get signaturKeineRufnummer =>
      'Hesabınızda kayıtlı bir cep telefonu numarası yok. Numara olmadan size kod gönderemeyiz — lütfen dernek başkanına başvurun.';

  @override
  String get signaturCodeFehlgeschlagen => 'Kod gönderilemedi.';

  @override
  String get signaturLeer => 'Lütfen önce imzalayın.';

  @override
  String get signaturErfolg => 'Teşekkürler — imzanız alındı.';

  @override
  String get signaturFehlgeschlagen =>
      'Bu işe yaramadı. Lütfen tekrar deneyin.';

  @override
  String get signaturSiegelInArbeit =>
      'Mühür henüz oluşturuluyor. Lütfen bir dakika sonra tekrar deneyin.';

  @override
  String get signaturWartetZweiteUnterschrift => 'İkinci imzayı bekliyor';

  @override
  String get signaturWartenHinweis =>
      'İmzaladınız. Belge, ikinci kişi de imzaladığında mühürlenecek.';

  @override
  String get kontaktNochAktuell => 'Bu bilgiler hâlâ doğru mu?';

  @override
  String get kontaktWarumFragen =>
      'Hiçbir şeyi kaçırmamanız için üç ayda bir kısaca soruyoruz. Altı haneli bir kod alacaksınız.';

  @override
  String kontaktBestaetigtAm(Object datum) {
    return '$datum tarihinde onaylandı';
  }

  @override
  String get kontaktFestnetzKeinSms =>
      'Bu bir sabit hat numarası — oraya SMS ulaşmaz.';

  @override
  String get kontaktIstAndersGeworden => 'Değişti';

  @override
  String get themeTitle => 'Görünüm';

  @override
  String get themeLight => 'Açık';

  @override
  String get themeDark => 'Koyu';

  @override
  String get themeSystem => 'Cihazı takip et';

  @override
  String get themeSchedule => 'Otomatik (20.00–06.00)';

  @override
  String get themeScheduleHint =>
      '20.00 ile 06.00 arası koyu, günün geri kalanında açık.';
}
