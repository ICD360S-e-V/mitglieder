// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Modern Greek (`el`).
class AppLocalizationsEl extends AppLocalizations {
  AppLocalizationsEl([String locale = 'el']) : super(locale);

  @override
  String get welcomeLoading => 'Φόρτωση...';

  @override
  String get welcomeAutoLogin => 'Αυτόματη σύνδεση...';

  @override
  String get login => 'Σύνδεση';

  @override
  String get register => 'Εγγραφή';

  @override
  String get becomeMember => 'Γίνετε Μέλος';

  @override
  String get memberNumber => 'Αριθμός Μέλους';

  @override
  String get memberNumberHint => 'Εισάγετε τον αριθμό μέλους';

  @override
  String get confirmPassword => 'Επιβεβαίωση Κωδικού';

  @override
  String get confirmPasswordHint => 'Επιβεβαιώστε τον κωδικό';

  @override
  String get newPassword => 'Νέος Κωδικός';

  @override
  String get newPasswordHint => 'Εισάγετε νέο κωδικό';

  @override
  String get firstName => 'Όνομα και Επώνυμο';

  @override
  String get firstNameHint => 'Εισάγετε όνομα και επώνυμο';

  @override
  String get nameMinLength =>
      'Το όνομα πρέπει να έχει τουλάχιστον 2 χαρακτήρες';

  @override
  String get nameOnlyLetters => 'Επιτρέπονται μόνο γράμματα και παύλες';

  @override
  String get email => 'Διεύθυνση Email';

  @override
  String get emailHint => 'Εισάγετε email';

  @override
  String get emailInvalid => 'Εισάγετε έγκυρο email';

  @override
  String get passwordMinLength =>
      'Ο κωδικός πρέπει να έχει τουλάχιστον 6 χαρακτήρες';

  @override
  String get passwordsNotMatch => 'Οι κωδικοί δεν ταιριάζουν';

  @override
  String get registrationFailed => 'Αποτυχία εγγραφής';

  @override
  String connectionError(String error) {
    return 'Σφάλμα σύνδεσης: $error';
  }

  @override
  String registrationSuccess(String memberNumber) {
    return 'Επιτυχής εγγραφή!\n\nΟ αριθμός μέλους σας: $memberNumber\n\nΘυμηθείτε αυτόν τον αριθμό για σύνδεση.';
  }

  @override
  String get unknown => 'Άγνωστο';

  @override
  String error(String error) {
    return 'Σφάλμα: $error';
  }

  @override
  String get cancel => 'Ακύρωση';

  @override
  String get resetPassword => 'Επαναφορά Κωδικού';

  @override
  String get imprint => 'Impressum';

  @override
  String get privacy => 'Πολιτική Απορρήτου';

  @override
  String get statutes => 'Καταστατικό';

  @override
  String get revocation => 'Δικαίωμα Υπαναχώρησης';

  @override
  String get appointments => 'Ραντεβού';

  @override
  String get tickets => 'Εισιτήρια';

  @override
  String get liveChat => 'Ζωντανή Συνομιλία';

  @override
  String get notifications => 'Ειδοποιήσεις';

  @override
  String get myProfile => 'Το Προφίλ μου';

  @override
  String get logout => 'Αποσύνδεση';

  @override
  String get goodMorning => 'Καλημέρα';

  @override
  String get goodDay => 'Καλή μέρα';

  @override
  String get goodEvening => 'Καλησπέρα';

  @override
  String get goodNight => 'Καληνύχτα';

  @override
  String get welcomeToICD => 'Καλώς ήρθατε στο ICD360S e.V!';

  @override
  String get accountCreatedSuccessfully =>
      'Ο λογαριασμός σας δημιουργήθηκε με επιτυχία.';

  @override
  String get today => 'Σήμερα';

  @override
  String get membershipFeeDue => 'Οφειλόμενη συνδρομή μέλους';

  @override
  String get pleaseTransferAnnualFee =>
      'Παρακαλώ μεταφέρετε την ετήσια συνδρομή.';

  @override
  String get newBadge => 'Νέο';

  @override
  String get close => 'Κλείσιμο';

  @override
  String get myAppointments => 'Τα ραντεβού μου';

  @override
  String get priority => 'Προτεραιότητα';

  @override
  String get messageLabel => 'Μήνυμα';

  @override
  String get reportProblems => 'Αναφορά προβλημάτων';

  @override
  String get weRespondIn24Hours => 'Θα σας απαντήσουμε εντός 24 ωρών!';

  @override
  String get everythingOk => 'Όλα εντάξει!';

  @override
  String get haveProblemWeHelp => 'Έχετε πρόβλημα;\nΘα το φροντίσουμε!';

  @override
  String get myMembership => 'Η συνδρομή μου';

  @override
  String get managePersonalDataAndFee =>
      'Διαχείριση προσωπικών δεδομένων και συνδρομής';

  @override
  String get myAppointmentsTitle => 'Τα ραντεβού μου';

  @override
  String get appointmentsDescription =>
      'Εδώ μπορείτε να δείτε τα επερχόμενα ραντεβού σας.\nΜπορείτε να επιβεβαιώσετε τη συμμετοχή σας ή να αρνηθείτε.';

  @override
  String get loadAppointments => 'Φόρτωση ραντεβού';

  @override
  String get myTickets => 'Τα αιτήματά μου';

  @override
  String get low => 'Χαμηλή';

  @override
  String get high => 'Υψηλή';

  @override
  String get submit => 'Υποβολή';

  @override
  String get errorCreatingTicket => 'Σφάλμα κατά τη δημιουργία αιτήματος';

  @override
  String get verified => 'Επαληθευμένο';

  @override
  String get account => 'Λογαριασμός';

  @override
  String get myDevices => 'Οι συσκευές μου';

  @override
  String get changeEmail => 'Αλλαγή email';

  @override
  String get changePassword => 'Αλλαγή κωδικού';

  @override
  String get saveEmail => 'Αποθήκευση email';

  @override
  String get savePassword => 'Αποθήκευση κωδικού';

  @override
  String get deviceLoggedOut => 'Η συσκευή αποσυνδέθηκε';

  @override
  String get emailChangedSuccessfully => 'Το email άλλαξε επιτυχώς';

  @override
  String get errorChangingPassword => 'Σφάλμα κατά την αλλαγή κωδικού';

  @override
  String get errorChangingEmail => 'Σφάλμα κατά την αλλαγή email';

  @override
  String get validEmailRequired => 'Εισαγάγετε μια έγκυρη διεύθυνση email';

  @override
  String get confirmLogoutDevice => 'Αποσύνδεση συσκευής;';

  @override
  String get confirmLogoutMessage =>
      'Θέλετε να αποσυνδεθείτε από αυτή τη συσκευή;\n\nΘα χρειαστεί να συνδεθείτε ξανά για να χρησιμοποιήσετε αυτή τη συσκευή.';

  @override
  String get ipAddress => 'IP';

  @override
  String get platform => 'Πλατφόρμα';

  @override
  String trialWarningUrgentTitle(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days ημέρες',
      one: '1 ημέρα',
    );
    return 'Προσοχή: Απομένουν $_temp0 μέχρι την αναστολή του λογαριασμού!';
  }

  @override
  String get trialWarningTitle =>
      'Ο λογαριασμός σας δεν έχει επαληθευτεί ακόμα';

  @override
  String get trialWarningDescription =>
      'Παρακαλώ συμπληρώστε τα στοιχεία σας στο \"Το προφίλ μου\". Μετά από 30 ημέρες ο λογαριασμός σας θα ανασταλεί αυτόματα.';

  @override
  String trialDaysRemaining(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days ημέρες',
      one: '1 ημέρα',
    );
    return '$_temp0';
  }

  @override
  String get overview => 'Επισκόπηση';

  @override
  String get member => 'Μέλος';

  @override
  String get memberManagement => 'Διαχείριση μελών';

  @override
  String get reportProblemTooltip => 'Αναφορά προβλήματος';

  @override
  String get newAppointmentsTitle => 'Νέα ραντεβού';

  @override
  String get youHaveNewAppointment => 'Έχετε νέο ραντεβού.';

  @override
  String youHaveNewAppointments(int count) {
    return 'Έχετε $count νέα ραντεβού.';
  }

  @override
  String get appointmentReminderTomorrow => 'Υπενθύμιση: Ραντεβού αύριο';

  @override
  String tomorrowAppointment(String title) {
    return 'Αύριο: $title';
  }

  @override
  String youHaveTomorrowAppointments(int count) {
    return 'Έχετε $count ραντεβού αύριο.';
  }

  @override
  String get appointmentsToday => 'Ραντεβού σήμερα';

  @override
  String todayAppointment(String title) {
    return 'Σήμερα: $title';
  }

  @override
  String youHaveTodayAppointments(int count) {
    return 'Έχετε $count ραντεβού σήμερα.';
  }

  @override
  String get paymentReminder => 'Υπενθύμιση πληρωμής';

  @override
  String paymentReminderMessage(int day, String method) {
    return 'Σήμερα είναι η $dayη του μήνα – παρακαλώ ολοκληρώστε $method.';
  }

  @override
  String get paymentDayLabel => 'Ημέρα πληρωμής (μηνιαία υπενθύμιση)';

  @override
  String get updateAvailable => 'Διαθέσιμη ενημέρωση';

  @override
  String newVersionAvailable(String version) {
    return 'Μια νέα έκδοση είναι διαθέσιμη: $version';
  }

  @override
  String currentVersionLabel(String version) {
    return 'Τρέχουσα έκδοση: $version';
  }

  @override
  String get changes => 'Αλλαγές:';

  @override
  String downloadProgress(String percent) {
    return 'Λήψη: $percent%';
  }

  @override
  String get installationStarting => 'Έναρξη εγκατάστασης...';

  @override
  String get appWillRestart => 'Η εφαρμογή θα επανεκκινηθεί αυτόματα.';

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
  String get later => 'Αργότερα';

  @override
  String get updateNow => 'Ενημέρωση τώρα';

  @override
  String get downloading => 'Γίνεται λήψη...';

  @override
  String get downloadFailed => 'Η λήψη απέτυχε. Δοκιμάστε ξανά αργότερα.';

  @override
  String get searchingForUpdates => 'Αναζήτηση ενημερώσεων...';

  @override
  String get appUpToDate => 'Η εφαρμογή είναι ενημερωμένη';

  @override
  String get updateCheckError => 'Σφάλμα ελέγχου ενημερώσεων';

  @override
  String get changelog => 'Ιστορικό αλλαγών';

  @override
  String get terminConfirmed => 'Ραντεβού επιβεβαιώθηκε';

  @override
  String get terminDeclined => 'Ραντεβού απορρίφθηκε';

  @override
  String get terminRescheduleRequested => 'Ζητήθηκε αναβολή';

  @override
  String get statusConfirmed => 'Επιβεβαιωμένο';

  @override
  String get statusDeclined => 'Απορρίφθηκε';

  @override
  String get statusRescheduling => 'Αναβολή';

  @override
  String get statusPending => 'Εκκρεμεί';

  @override
  String get categoryVorstandssitzung => 'Συνεδρίαση διοικητικού';

  @override
  String get categoryMitgliederversammlung => 'Γενική συνέλευση';

  @override
  String get categorySchulung => 'Εκπαίδευση';

  @override
  String get categorySonstiges => 'Άλλο';

  @override
  String openCount(int count) {
    return '$count ανοιχτά';
  }

  @override
  String get refresh => 'Ανανέωση';

  @override
  String get filterUpcoming => 'Επερχόμενα';

  @override
  String get filterPast => 'Παρελθόντα';

  @override
  String get filterAll => 'Όλα';

  @override
  String get noUpcomingAppointments => 'Δεν υπάρχουν επερχόμενα ραντεβού';

  @override
  String get noPastAppointments => 'Δεν υπάρχουν προηγούμενα ραντεβού';

  @override
  String get noAppointmentsAvailable => 'Δεν υπάρχουν ραντεβού';

  @override
  String get appointmentsShownHere => 'Τα ραντεβού σας θα εμφανιστούν εδώ';

  @override
  String get dateLabel => 'Ημερομηνία';

  @override
  String get timeLabel => 'Ώρα';

  @override
  String get locationLabel => 'Τοποθεσία';

  @override
  String get createdByLabel => 'Δημιουργήθηκε από';

  @override
  String get descriptionLabel => 'Περιγραφή';

  @override
  String get ticketLabel => 'Αίτημα';

  @override
  String get yourStatus => 'Η κατάστασή σας: ';

  @override
  String reasonLabel(String reason) {
    return 'Λόγος: $reason';
  }

  @override
  String durationMinutes(int minutes) {
    return '$minutes λεπτά';
  }

  @override
  String get confirm => 'Επιβεβαίωση';

  @override
  String get decline => 'Απόρριψη';

  @override
  String get reschedule => 'Αναβολή';

  @override
  String get requestReschedule => 'Αίτηση αναβολής';

  @override
  String appointmentLabel(String title) {
    return 'Ραντεβού: $title';
  }

  @override
  String get rescheduleReason => 'Λόγος αναβολής *';

  @override
  String get rescheduleReasonHint => 'Παρακαλώ αναφέρετε τον λόγο...';

  @override
  String get pleaseProvideReason => 'Παρακαλώ αναφέρετε τον λόγο';

  @override
  String get request => 'Αίτηση';

  @override
  String get ticketStatusOpen => 'Ανοιχτό';

  @override
  String get ticketStatusInProgress => 'Σε εξέλιξη';

  @override
  String get ticketStatusWaitingMember => 'Αναμονή μέλους';

  @override
  String get ticketStatusWaitingStaff => 'Αναμονή προσωπικού';

  @override
  String get ticketStatusWaitingAuthority => 'Αναμονή αρχής';

  @override
  String get ticketStatusDone => 'Ολοκληρωμένο';

  @override
  String get ticketPriorityHigh => 'Υψηλή';

  @override
  String get ticketPriorityMedium => 'Μεσαία';

  @override
  String get ticketPriorityLow => 'Χαμηλή';

  @override
  String get comments => 'Σχόλια';

  @override
  String get documents => 'Έγγραφα';

  @override
  String get details => 'Λεπτομέρειες';

  @override
  String get replySent => 'Απάντηση εστάλη';

  @override
  String get sendError => 'Σφάλμα αποστολής';

  @override
  String get uploading => 'Μεταφόρτωση...';

  @override
  String fileUploaded(String filename) {
    return '$filename μεταφορτώθηκε';
  }

  @override
  String get uploadFailed => 'Αποτυχία μεταφόρτωσης';

  @override
  String get openError => 'Σφάλμα ανοίγματος';

  @override
  String get noRepliesYet => 'Δεν υπάρχουν απαντήσεις ακόμα';

  @override
  String get waitingForSupport => 'Αναμονή απάντησης υποστήριξης';

  @override
  String get writeReply => 'Γράψτε απάντηση...';

  @override
  String get attachFile => 'Επισύναψη αρχείου';

  @override
  String documentsCount(int count) {
    return 'Έγγραφα ($count)';
  }

  @override
  String get upload => 'Μεταφόρτωση';

  @override
  String get noDocuments => 'Δεν υπάρχουν έγγραφα';

  @override
  String get allowedFormats => 'Επιτρεπόμενες μορφές: PDF, JPEG, JPG, TXT, ZIP';

  @override
  String get yourMessage => 'Το μήνυμά σας:';

  @override
  String get translation => 'Μετάφραση';

  @override
  String get original => 'Πρωτότυπο';

  @override
  String get originalText => 'Αρχικό κείμενο';

  @override
  String get autoTranslated => 'Αυτόματα μεταφρασμένο';

  @override
  String get originalTapTranslation => 'Πρωτότυπο · Πατήστε για μετάφραση';

  @override
  String get translatedTapOriginal => 'Μεταφρασμένο · Πατήστε για πρωτότυπο';

  @override
  String get justNow => 'Μόλις τώρα';

  @override
  String minutesAgo(int minutes) {
    return 'πριν $minutes λεπτά';
  }

  @override
  String hoursAgo(int hours) {
    return 'πριν $hours ώρες';
  }

  @override
  String daysAgo(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'ημέρες',
      one: 'ημέρα',
    );
    return 'πριν $days $_temp0';
  }

  @override
  String get createdLabel => 'Δημιουργήθηκε';

  @override
  String get updatedLabel => 'Ενημερώθηκε';

  @override
  String get handlerLabel => 'Υπεύθυνος';

  @override
  String get doneLabel => 'Ολοκληρωμένο';

  @override
  String get newTicketTitle => 'Νέο αίτημα';

  @override
  String get categoryOptional => 'Κατηγορία (προαιρετικό)';

  @override
  String get selectCategory => 'Επιλογή';

  @override
  String get subjectLabel => 'Θέμα';

  @override
  String get fillAllFields => 'Συμπληρώστε όλα τα πεδία';

  @override
  String ticketCreatedId(int id) {
    return 'Αίτημα #$id δημιουργήθηκε';
  }

  @override
  String get priorityLabel => 'Προτεραιότητα: ';

  @override
  String get supportOffline => 'Υποστήριξη εκτός σύνδεσης';

  @override
  String get lastSeenSeconds => 'Ενεργός πριν λίγα δευτερόλεπτα';

  @override
  String lastSeenMinutes(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: 'λεπτά',
      one: 'λεπτό',
    );
    return 'Ενεργός πριν $minutes $_temp0';
  }

  @override
  String lastSeenHours(int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: 'ώρες',
      one: 'ώρα',
    );
    return 'Ενεργός πριν $hours $_temp0';
  }

  @override
  String lastSeenDays(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'ημέρες',
      one: 'ημέρα',
    );
    return 'Ενεργός πριν $days $_temp0';
  }

  @override
  String get online => 'Σε σύνδεση';

  @override
  String get callSupport => 'Κλήση';

  @override
  String get typeMessage => 'Πληκτρολογήστε μήνυμα...';

  @override
  String get callBusy => 'Η υποστήριξη είναι απασχολημένη';

  @override
  String get callRejected => 'Η κλήση απορρίφθηκε';

  @override
  String get callFailed => 'Η κλήση δεν μπόρεσε να συνδεθεί';

  @override
  String get callEnded => 'Η κλήση τερματίστηκε';

  @override
  String get callSupportBusy => 'Η υποστήριξη είναι ήδη σε άλλη κλήση';

  @override
  String get errorStartingChat => 'Σφάλμα εκκίνησης συνομιλίας';

  @override
  String get errorStartingCall => 'Σφάλμα εκκίνησης κλήσης';

  @override
  String get errorConnecting => 'Σφάλμα σύνδεσης';

  @override
  String get errorDownloading => 'Σφάλμα λήψης';

  @override
  String get errorUploading => 'Σφάλμα μεταφόρτωσης';

  @override
  String get errorSending => 'Σφάλμα αποστολής';

  @override
  String get errorPickingPhotos => 'Σφάλμα επιλογής φωτογραφιών';

  @override
  String get errorPickingFiles => 'Σφάλμα επιλογής αρχείων';

  @override
  String get errorTakingPhoto => 'Σφάλμα λήψης φωτογραφίας';

  @override
  String get fileNotLoaded => 'Το αρχείο δεν φορτώθηκε';

  @override
  String get attachmentIdMissing => 'Λείπει ID συνημμένου';

  @override
  String get camera => 'Κάμερα';

  @override
  String get gallery => 'Συλλογή';

  @override
  String get file => 'Αρχείο';

  @override
  String get notifNewMessageFrom => 'Νέο μήνυμα από';

  @override
  String get notifUrgentPrefix => 'ΕΠΕΙΓΟΝ';

  @override
  String get notifUrgentMessage => 'ΕΠΕΙΓΟΝ ΜΗΝΥΜΑ';

  @override
  String get notifIncomingCall => 'Εισερχόμενη κλήση';

  @override
  String get notifCallingYou => 'καλεί...';

  @override
  String get notifUpdateAvailable => 'Διαθέσιμη ενημέρωση';

  @override
  String get notifVersionAvailable => 'είναι τώρα διαθέσιμη';

  @override
  String get notifConnected => 'Συνδέθηκε';

  @override
  String get notifDisconnected => 'Αποσυνδέθηκε';

  @override
  String get notifConnectedBody => 'Είστε συνδεδεμένοι στον διακομιστή.';

  @override
  String get notifDisconnectedBody => 'Η σύνδεση με τον διακομιστή χάθηκε.';

  @override
  String get notifError => 'Σφάλμα';

  @override
  String get retry => 'Δοκιμάστε ξανά';

  @override
  String get save => 'Αποθήκευση';

  @override
  String get accept => 'Αποδοχή';

  @override
  String get selectFile => 'Επιλογή αρχείου';

  @override
  String get dataLoadingText => 'Φόρτωση δεδομένων...';

  @override
  String get dataSavedSuccess => 'Τα δεδομένα αποθηκεύτηκαν';

  @override
  String get errorSaving => 'Σφάλμα αποθήκευσης';

  @override
  String get errorLoading => 'Σφάλμα φόρτωσης';

  @override
  String savedFilename(String filename) {
    return 'Αποθηκεύτηκε: $filename';
  }

  @override
  String get logsCopied => 'Αρχεία καταγραφής αντιγράφηκαν!';

  @override
  String get passwordMinEightChars =>
      'Ο κωδικός πρέπει να έχει τουλάχιστον 8 χαρακτήρες';

  @override
  String get passwordChangeSuccess => 'Ο κωδικός άλλαξε επιτυχώς';

  @override
  String get emailChangeError => 'Σφάλμα αλλαγής email';

  @override
  String get acceptDocumentCheckbox =>
      'Έχω διαβάσει και αποδέχομαι το έγγραφο.';

  @override
  String loadingErrorGeneric(String details) {
    return 'Σφάλμα φόρτωσης: $details';
  }

  @override
  String get incomingCallTitle => 'Εισερχόμενη κλήση';

  @override
  String ringingFor(int seconds) {
    return 'Χτυπά $secondsδ';
  }

  @override
  String get rejectCall => 'Απόρριψη';

  @override
  String get acceptCall => 'Αποδοχή';

  @override
  String get unmute => 'Κατάργηση σίγασης';

  @override
  String get mute => 'Σίγαση';

  @override
  String get hangUp => 'Τερματισμός';

  @override
  String get calling => 'Κλήση...';

  @override
  String autoRejectIn(int seconds) {
    return 'Αυτόματη απόρριψη σε $seconds δευτερόλεπτα';
  }

  @override
  String get speakerOn => 'Ηχείο';

  @override
  String get speakerOff => 'Ακουστικό';

  @override
  String get micMuted => 'Σε σίγαση';

  @override
  String get micOn => 'Μικρόφωνο';

  @override
  String get connectionExcellent => 'Εξαιρετική';

  @override
  String get connectionGood => 'Καλή';

  @override
  String get connectionWeak => 'Ασθενής';

  @override
  String get connectionLost => 'Αποσυνδέθηκε';

  @override
  String get personalData => 'Προσωπικά δεδομένα';

  @override
  String get personalDataSubtitle => 'Όνομα, επώνυμο, διεύθυνση';

  @override
  String get membershipFee => 'Συνδρομή μέλους';

  @override
  String annualFeeYear(String year) {
    return 'Ετήσια συνδρομή $year';
  }

  @override
  String get amount => 'Ποσό:';

  @override
  String get dueBy => 'Προθεσμία:';

  @override
  String get paid => 'Πληρωμένο';

  @override
  String get versionHistory => 'Ιστορικό εκδόσεων';

  @override
  String lastUpdated(String date) {
    return 'Τελευταία ενημέρωση: $date';
  }

  @override
  String get noVersionHistory => 'Δεν υπάρχει ιστορικό εκδόσεων';

  @override
  String get failedLoadChangelog => 'Αποτυχία φόρτωσης αρχείου αλλαγών';

  @override
  String get callMember => 'Κλήση μέλους';

  @override
  String get closeConversation => 'Κλείσιμο συνομιλίας';

  @override
  String get chatOffline => 'Εκτός σύνδεσης';

  @override
  String get attachFiles => 'Επισύναψη αρχείων (μέγ. 10, 50MB)';

  @override
  String get conversationClosed => 'Αυτή η συνομιλία έχει κλείσει';

  @override
  String get noMessages => 'Δεν υπάρχουν μηνύματα';

  @override
  String get goBack => 'Πίσω';

  @override
  String get goForward => 'Εμπρός';

  @override
  String get homePage => 'Αρχική';

  @override
  String get firstNameLabel => 'Όνομα';

  @override
  String get lastNameLabel => 'Επώνυμο';

  @override
  String get streetLabel => 'Οδός';

  @override
  String get houseNumberLabel => 'Αρ.';

  @override
  String get postalCodeLabel => 'Τ.Κ.';

  @override
  String get cityLabel => 'Πόλη';

  @override
  String get phoneMobileLabel => 'Τηλέφωνο (Κινητό)';

  @override
  String get phoneLandlineLabel => 'Τηλέφωνο (Σταθερό)';

  @override
  String get newEmailLabel => 'Νέα διεύθυνση email';

  @override
  String get currentPasswordLabel => 'Τρέχων κωδικός';

  @override
  String get newPasswordLabel => 'Νέος κωδικός';

  @override
  String get confirmPasswordLabel => 'Επιβεβαίωση κωδικού';

  @override
  String get emailChangedSuccess => 'Το email άλλαξε επιτυχώς';

  @override
  String get reasonLabel2 => 'Λόγος';

  @override
  String get downloadFailed2 => 'Η λήψη απέτυχε';

  @override
  String get downloadTooltip => 'Λήψη';

  @override
  String get copyLogs => 'Αντιγραφή αρχείων καταγραφής';

  @override
  String get deleteLogs => 'Διαγραφή αρχείων καταγραφής';

  @override
  String get autoScrollOn => 'Αυτόματη κύλιση ΕΝΕΡΓΉ';

  @override
  String get autoScrollOff => 'Αυτόματη κύλιση ΑΝΕΝΕΡΓΉ';

  @override
  String get unknownValue => 'Άγνωστο';

  @override
  String get payment => 'Πληρωμή';

  @override
  String get warningType_ermahnung => 'Προειδοποίηση';

  @override
  String get warningType_abmahnung => 'Επίπληξη';

  @override
  String get warningType_letzte => 'Τελευταία προειδοποίηση';

  @override
  String warningsTotal(int count) {
    return 'Σύνολο: $count';
  }

  @override
  String warningsErmahnung(int count) {
    return 'Προειδοποιήσεις: $count';
  }

  @override
  String warningsAbmahnung(int count) {
    return 'Επιπλήξεις: $count';
  }

  @override
  String warningsLetzte(int count) {
    return 'Τελευταίες: $count';
  }

  @override
  String get noWarnings => 'Δεν υπάρχουν προειδοποιήσεις';

  @override
  String get noWarningsDescription =>
      'Δεν έχετε προειδοποιήσεις αυτή τη στιγμή.';

  @override
  String createdBy(String name) {
    return 'Δημιουργήθηκε από: $name';
  }

  @override
  String get monthJan => 'Ian';

  @override
  String get monthFeb => 'Fev';

  @override
  String get monthMar => 'Mar';

  @override
  String get monthApr => 'Apr';

  @override
  String get monthMay => 'Mai';

  @override
  String get monthJun => 'Iun';

  @override
  String get monthJul => 'Iul';

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
  String get stufe1_name => 'Προσωπικά δεδομένα';

  @override
  String get stufe2_name => 'Τύπος μέλους';

  @override
  String get stufe3_name => 'Οικονομική κατάσταση';

  @override
  String get stufe4_name => 'Τρόπος πληρωμής';

  @override
  String get stufe5_name => 'Έναρξη συνδρομής';

  @override
  String get stufe6_name => 'Καταστατικό';

  @override
  String get stufe7_name => 'Πολιτική απορρήτου';

  @override
  String get stufe8_name => 'Δικαίωμα υπαναχώρησης';

  @override
  String get memberType_ordentlich => 'Τακτικό μέλος';

  @override
  String get memberType_foerder => 'Υποστηρικτικό μέλος';

  @override
  String get memberType_ehren => 'Επίτιμο μέλος';

  @override
  String get memberDesc_ordentlich =>
      'Ενεργό μέλος με δικαίωμα ψήφου. Συμμετέχει στις υπηρεσίες του συλλόγου (email, cloud, γραφειοκρατική υποστήριξη).';

  @override
  String get memberDesc_foerder =>
      'Υποστηρίζει τον σύλλογο με εισφορές. Μπορεί να παρευρίσκεται στη γενική συνέλευση με συμβουλευτική ψήφο, χωρίς δικαίωμα ψήφου ή εκλογής στο διοικητικό συμβούλιο.';

  @override
  String get memberDesc_ehren =>
      'Έχει τα δικαιώματα τακτικού μέλους χωρίς την υποχρέωση καταβολής συνδρομών. Διορίζεται από τη γενική συνέλευση ή το διοικητικό συμβούλιο.';

  @override
  String get payMethod_ueberweisung => 'Τραπεζικό έμβασμα';

  @override
  String get payMethod_dauerauftrag => 'Πάγια εντολή';

  @override
  String get verifyStatus_geprueft => 'Επαληθεύτηκε';

  @override
  String get verifyStatus_ausgefuellt => 'Συμπληρώθηκε';

  @override
  String get verifyStatus_abgelehnt => 'Απορρίφθηκε';

  @override
  String get verifyStatus_offen => 'Ανοιχτό';

  @override
  String get fillRequiredFields => 'Συμπληρώστε όλα τα υποχρεωτικά πεδία.';

  @override
  String get personalDataSaved => 'Τα προσωπικά δεδομένα αποθηκεύτηκαν';

  @override
  String get selectMemberType => 'Επιλέξτε τύπο μέλους.';

  @override
  String get memberTypeSaved => 'Ο τύπος μέλους αποθηκεύτηκε';

  @override
  String get selectOption => 'Επιλέξτε μια επιλογή.';

  @override
  String get financialSaved => 'Η οικονομική κατάσταση αποθηκεύτηκε';

  @override
  String get selectPaymentMethod => 'Επιλέξτε τρόπο πληρωμής.';

  @override
  String get paymentDataSaved => 'Τα στοιχεία πληρωμής αποθηκεύτηκαν';

  @override
  String get selectDate => 'Επιλέξτε ημερομηνία.';

  @override
  String get membershipStartSaved => 'Η έναρξη συνδρομής αποθηκεύτηκε';

  @override
  String get fileTooLarge => 'Το αρχείο είναι πολύ μεγάλο (μέγ. 10 MB).';

  @override
  String get leistungsbescheidUploaded =>
      'Η βεβαίωση παροχών μεταφορτώθηκε επιτυχώς';

  @override
  String get verificationProgress => 'Πρόοδος επαλήθευσης';

  @override
  String get notApplicable => 'Δεν ισχύει';

  @override
  String get socialBenefitsExempt =>
      'Ο τρόπος πληρωμής δεν απαιτείται για δικαιούχους κοινωνικών παροχών.';

  @override
  String get locked => 'Κλειδωμένο';

  @override
  String completePreviousStep(int step) {
    return 'Ολοκληρώστε πρώτα το βήμα $step.';
  }

  @override
  String rejectedNote(String note) {
    return 'Απορρίφθηκε: $note';
  }

  @override
  String get waitingForReview => 'Αναμονή ελέγχου από το διοικητικό συμβούλιο.';

  @override
  String get stepApproved => 'Αυτό το βήμα ελέγχθηκε και εγκρίθηκε.';

  @override
  String get changesViaChat => 'Αλλαγές μόνο μέσω συνομιλίας.';

  @override
  String get firstNameRequired => 'Όνομα *';

  @override
  String get lastNameRequired => 'Επώνυμο *';

  @override
  String get birthDateLabel => 'Ημερομηνία γέννησης *';

  @override
  String get streetRequired => 'Οδός *';

  @override
  String get houseNumberRequired => 'Αρ. *';

  @override
  String get cityRequired => 'Πόλη *';

  @override
  String get phoneRequired => 'Αριθμός τηλεφώνου *';

  @override
  String get phonePurpose =>
      'Σκοπός: Επικοινωνία όταν δεν είστε προσβάσιμοι μέσω της εφαρμογής';

  @override
  String get selectMemberTypePrompt => 'Επιλέξτε τον επιθυμητό τύπο μέλους:';

  @override
  String get financialExplanation =>
      'Για να ελέγξουμε αν δικαιούστε μείωση συνδρομής, χρειαζόμαστε τις ακόλουθες πληροφορίες. Θα χρησιμοποιηθούν αποκλειστικά για τον καθορισμό της συνδρομής σας.';

  @override
  String get socialBenefitsQuestion =>
      'Λαμβάνετε αυτήν τη στιγμή κοινωνικές παροχές;';

  @override
  String get optionBuergergeld => 'Ναι, επίδομα πολίτη (Job Center)';

  @override
  String get optionSozialamt => 'Ναι, κοινωνική πρόνοια (Κοινωνική Υπηρεσία)';

  @override
  String get optionNoBenefits => 'Όχι, δεν λαμβάνω κοινωνικές παροχές';

  @override
  String get feeExempt => 'Η μηνιαία συνδρομή σας είναι: 0,00 €/μήνα';

  @override
  String get uploadLeistungsbescheid => 'Μεταφόρτωση βεβαίωσης παροχών';

  @override
  String get uploadLeistungsbescheidHint =>
      'Μεταφορτώστε μια τρέχουσα βεβαίωση παροχών εντός 14 ημερών για επιβεβαίωση της απαλλαγής.';

  @override
  String get allowedFormatsUpload =>
      'Επιτρεπόμενες μορφές: PDF, JPG, PNG (μέγ. 10 MB)';

  @override
  String get feeRegular => 'Η μηνιαία συνδρομή σας είναι: 25,00 €/μήνα';

  @override
  String paymentDayReminder(int day) {
    return 'Θα σας υπενθυμίζεται στις $day κάθε μήνα.';
  }

  @override
  String get membershipStartPrompt =>
      'Επιλέξτε πότε θα ξεκινήσει η συνδρομή σας.';

  @override
  String get optionAfterVerification => 'Μετά την ολοκλήρωση της επαλήθευσης';

  @override
  String get optionAfterVerificationDesc =>
      'Η συνδρομή αρχίζει από την ημέρα επιβεβαίωσης του διοικητικού συμβουλίου.';

  @override
  String get optionRetroFoundation =>
      'Αναδρομικά στην ημερομηνία ίδρυσης (01.08.2025)';

  @override
  String get optionRetroFoundationDesc =>
      'Γίνεστε αναδρομικό μέλος από την ίδρυση του συλλόγου.';

  @override
  String get optionRetroCustom => 'Αναδρομικά σε άλλη ημερομηνία';

  @override
  String get optionRetroCustomDesc =>
      'Επιλέξτε ημερομηνία μεταξύ 01.08.2025 και σήμερα.';

  @override
  String get selectDateLabel => 'Επιλογή ημερομηνίας';

  @override
  String get selectDateHint => 'Επιλέξτε ημερομηνία...';

  @override
  String get dateNotBefore => 'Όχι πριν τις 01.08.2025 (ημερομηνία ίδρυσης)';

  @override
  String get feeExemptRetro =>
      'Απαλλαγή συνδρομής: 0,00 € αναδρομικά.\nΜόνο η ημερομηνία συνδρομής ορίζεται αναδρομικά.';

  @override
  String get retroactiveFees => 'Αναδρομικές συνδρομές';

  @override
  String retroFeeCalculation(
      String from, String to, String months, String total) {
    return 'Περίοδος: $from – $to\nΜήνες: $months\nΣυνδρομή: $months × 25,00 € = $total €';
  }

  @override
  String get pleaseReadSatzung => 'Διαβάστε το καταστατικό του συλλόγου.';

  @override
  String get pleaseReadDatenschutz => 'Διαβάστε την πολιτική απορρήτου.';

  @override
  String get pleaseReadWiderruf => 'Διαβάστε το δικαίωμα υπαναχώρησης.';

  @override
  String get acceptedAtRegistration => 'Αποδεκτό κατά την εγγραφή';

  @override
  String get confirmedByBoard =>
      'Θα επιβεβαιωθεί μετά τον έλεγχο του διοικητικού συμβουλίου.';

  @override
  String get docSatzung => 'Καταστατικό';

  @override
  String get docDatenschutz => 'Πολιτική απορρήτου';

  @override
  String get docWiderruf => 'Δικαίωμα υπαναχώρησης';

  @override
  String acceptedAtRegCount(int count) {
    return 'Αποδεκτό κατά την εγγραφή ($count/3)';
  }

  @override
  String acceptedOn(String date) {
    return 'Αποδεκτό στις $date';
  }

  @override
  String get notAccepted => 'Δεν έγινε αποδεκτό';

  @override
  String get statusAccepted => 'Αποδεκτό';

  @override
  String get nameTooLong => 'Όνομα πολύ μεγάλο (μέγ. 100 χαρακτήρες)';

  @override
  String get emailTooLong => 'Email πολύ μεγάλο (μέγ. 255 χαρακτήρες)';

  @override
  String get legalAcknowledgePrefix => 'Έχω διαβάσει την ';

  @override
  String get legalAcknowledgeSuffix => '.';

  @override
  String get legalStatutesSuffix =>
      ' του ICD360S e.V. και τα αναγνωρίζω ως δεσμευτικά.';

  @override
  String get legalPleaseReadFirst => '(παρακαλώ διαβάστε πρώτα)';

  @override
  String get statusActive => 'Ενεργός';

  @override
  String get statusSuspended => 'Ανεσταλμένος';

  @override
  String get statusNew => 'Νέος';

  @override
  String get statusCancelled => 'Ακυρωμένος';

  @override
  String get statusDeleted => 'Διαγραμμένος';

  @override
  String get roleMitglied => 'Μέλος';

  @override
  String get roleVorsitzer => 'Πρόεδρος';

  @override
  String get roleStellvertreter => 'Αναπληρωτής';

  @override
  String get roleSchatzmeister => 'Ταμίας';

  @override
  String get roleSchriftfuehrer => 'Γραμματέας';

  @override
  String get roleBeisitzer => 'Πάρεδρος';

  @override
  String get roleKassierer => 'Ταμίας';

  @override
  String get roleKassenpruefer => 'Ελεγκτής';

  @override
  String get roleEhrenamtlich => 'Εθελοντής';

  @override
  String get roleMitgliedergruender => 'Ιδρυτικό Μέλος';

  @override
  String get roleEhrenmitglied => 'Επίτιμο Μέλος';

  @override
  String get roleFoerdermitglied => 'Υποστηρικτικό Μέλος';

  @override
  String get memberTypeNotSet => 'Δεν έχει οριστεί ακόμα';

  @override
  String get payMethodSepa => 'Άμεση χρέωση SEPA';

  @override
  String get labelStatus => 'Κατάσταση';

  @override
  String get labelMemberNumber => 'Αριθμός μέλους';

  @override
  String get labelRole => 'Ρόλος';

  @override
  String get labelMemberType => 'Τύπος μέλους';

  @override
  String get labelPaymentMethod => 'Μέθοδος πληρωμής';

  @override
  String get labelRegisteredOn => 'Εγγραφή στις';

  @override
  String get labelLastLogin => 'Τελευταία σύνδεση';

  @override
  String get labelMemberSince => 'Μέλος από';

  @override
  String get neverLoggedIn => 'Ποτέ';

  @override
  String get notActivatedYet => 'Δεν έχει ενεργοποιηθεί ακόμα';

  @override
  String get tabVerification => 'Επαλήθευση';

  @override
  String get tabWarnings => 'Προειδοποιήσεις';

  @override
  String get tabDocuments => 'Έγγραφα';

  @override
  String get tabMembership => 'Συνδρομή';

  @override
  String get pleaseEnterFirstName => 'Εισάγετε το όνομα';

  @override
  String get pleaseEnterLastName => 'Εισάγετε το επώνυμο';

  @override
  String get noFileDataReceived => 'Δεν ελήφθησαν δεδομένα';

  @override
  String get openFile => 'Άνοιγμα';

  @override
  String get noMicrophoneError =>
      'Δεν βρέθηκε μικρόφωνο. Συνδέστε ένα μικρόφωνο και δοκιμάστε ξανά.';

  @override
  String get startConversation => 'Ξεκινήστε μια συνομιλία!';

  @override
  String get staffWillReply => 'Ένας υπάλληλος θα σας απαντήσει σύντομα.';

  @override
  String get inCall => 'Σε κλήση...';

  @override
  String get registration => 'Εγγραφή';

  @override
  String get deactivation => 'Απενεργοποίηση';

  @override
  String get deactivatedOn => 'Απενεργοποιήθηκε στις';

  @override
  String get accountAutoSuspend =>
      'Οι λογαριασμοί που δεν επαληθεύονται εντός 30 ημερών θα ανασταλούν αυτόματα.';

  @override
  String get documentsProvidedByBoard =>
      'Τα έγγραφα παρέχονται από το διοικητικό συμβούλιο.';

  @override
  String get noDocumentsAvailable => 'Δεν υπάρχουν έγγραφα';

  @override
  String get noDocumentsDescription =>
      'Δεν έχουν παρασχεθεί ακόμα έγγραφα για εσάς.';

  @override
  String uploadedBy(String name) {
    return 'Μεταφορτώθηκε από: $name';
  }

  @override
  String stepsCompleted(int completed, int total) {
    return '$completed/$total βήματα ολοκληρώθηκαν';
  }

  @override
  String dayOfMonth(int day) {
    return '$dayη του μήνα';
  }

  @override
  String changeField(String field) {
    return 'Αλλαγή $field';
  }

  @override
  String openDocument(String name) {
    return 'Άνοιγμα $name';
  }

  @override
  String logEntries(int count) {
    return '$count εγγραφές';
  }

  @override
  String get noLogs => 'Χωρίς αρχεία';

  @override
  String get newLoginDetected => 'Εντοπίστηκε νέα σύνδεση';

  @override
  String get errorNoInternet =>
      'Δεν υπάρχει σύνδεση στο διαδίκτυο. Ελέγξτε το δίκτυό σας.';

  @override
  String get errorTimeout =>
      'Ο διακομιστής δεν αποκρίνεται. Δοκιμάστε αργότερα.';

  @override
  String get errorServer => 'Σφάλμα διακομιστή. Δοκιμάστε αργότερα.';

  @override
  String get errorConnection => 'Σφάλμα σύνδεσης. Δοκιμάστε αργότερα.';

  @override
  String get errorUnexpected =>
      'Παρουσιάστηκε απροσδόκητο σφάλμα. Δοκιμάστε αργότερα.';

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
  String get claudiuWelcomeMorning => 'Καλημέρα';

  @override
  String get claudiuWelcomeDay => 'Γεια σας';

  @override
  String get claudiuWelcomeEvening => 'Καλησπέρα';

  @override
  String get claudiuWelcomeNight => 'Καλησπέρα';

  @override
  String get claudiuWelcomeVisitor => 'αγαπητέ επισκέπτη';

  @override
  String get claudiuWelcomeAsk => 'Πώς μπορώ να σε βοηθήσω;';

  @override
  String get claudiuWelcomeBecomeMember => 'Θέλω να γίνω μέλος';

  @override
  String get claudiuWelcomeLogin => 'Είμαι ήδη μέλος και θέλω να συνδεθώ';

  @override
  String get claudiuWelcomeProblem => 'Έχω πρόβλημα με την εφαρμογή';

  @override
  String get claudiuWelcomeEmergency => 'Επείγον — καλέστε μας';

  @override
  String get claudiuWelcomeMascotName => 'Claudiu';

  @override
  String get claudiuWelcomeEmergencyIntro =>
      'Πριν καλέσεις — οι ώρες λειτουργίας μας:';

  @override
  String get claudiuWelcomeScheduleOffice => 'Στο γραφείο';

  @override
  String get claudiuWelcomeScheduleField => 'Στο πεδίο με τους πελάτες';

  @override
  String get claudiuWelcomeOutsideHoursNote =>
      'Εκτός αυτών των ωρών αντιμετωπίζουμε μόνο επείγοντα. Μπορείς και να μας στείλεις SMS — θα σε καλέσουμε.';

  @override
  String get claudiuWelcomeCallNow => 'Κάλεσε τώρα';

  @override
  String get claudiuWelcomeSendSms => 'Στείλε SMS';

  @override
  String get claudiuWelcomeSmsBody =>
      'Επείγον ICD360S e.V. — παρακαλώ επικοινωνήστε μαζί μου το συντομότερο.';

  @override
  String get claudiuWelcomeCloseButton => 'Κλείσιμο';

  @override
  String get claudiuLoginWelcome => 'Καλώς ήρθες πίσω, αγαπητέ μέλος!';

  @override
  String get claudiuLoginAsk => 'Πες μου τον αριθμό μέλους σου, παρακαλώ.';

  @override
  String get claudiuLoginProgress => 'Πλησιάζουμε… συνέχισε.';

  @override
  String get claudiuLoginReady => 'Τέλεια! Πάτα το κουμπί παρακάτω.';

  @override
  String get claudiuLoginLoading => 'Επαληθεύω την ταυτότητα… 🔍';

  @override
  String get claudiuLoginFoundPlain => 'Σε βρήκα! Συνδέεσαι τώρα…';

  @override
  String claudiuLoginFoundNamed(String name) {
    return 'Σε βρήκα, $name! Συνδέεσαι τώρα…';
  }

  @override
  String get claudiuLoginError =>
      'Χμ, δεν βρίσκω αυτόν τον αριθμό. Τον έγραψες σωστά;';

  @override
  String get claudiuLoginForgotHeader => 'Ξέχασες τον αριθμό μέλους;';

  @override
  String get claudiuLoginNoSms => 'Δεν στέλνουμε τον αριθμό με email ή SMS.';

  @override
  String get claudiuLoginOnlyWay =>
      'Ο μοναδικός τρόπος: προσωπική συνάντηση στα γραφεία του συλλόγου, μετά από έλεγχο ταυτότητας.';

  @override
  String get claudiuLoginContactUs => 'Κάλεσέ μας για ραντεβού:';

  @override
  String get claudiuDiagnosticGreeting => 'Πριν μπεις, μια γρήγορη ερώτηση';

  @override
  String get claudiuDiagnosticAsk =>
      'Μπορώ να στέλνω ανώνυμες αναφορές ώστε οι προγραμματιστές να βελτιώνουν την εφαρμογή;';

  @override
  String get claudiuDiagnosticYes => 'Ναι, θέλω να βοηθήσω';

  @override
  String get claudiuDiagnosticNo => 'Όχι, απλώς εξερευνώ';

  @override
  String get claudiuDiagnosticTellMore => 'Πες μου περισσότερα';

  @override
  String get claudiuDiagnosticSendsHeader => '📤 Τι ΣΤΕΛΝΟΥΜΕ (ανώνυμα):';

  @override
  String get claudiuDiagnosticSends1 =>
      'Ένας ανώνυμος κωδικός συσκευής (ΟΧΙ ο αριθμός μέλους)';

  @override
  String get claudiuDiagnosticSends2 => 'Ο ρόλος σου (μέλος / διοίκηση)';

  @override
  String get claudiuDiagnosticSends3 =>
      'Λειτουργικό σύστημα (Linux / Android / iOS / Windows)';

  @override
  String get claudiuDiagnosticSends4 => 'Επιλεγμένη γλώσσα';

  @override
  String get claudiuDiagnosticSends5 => 'Επίπεδο και κατάσταση μπαταρίας';

  @override
  String get claudiuDiagnosticSends6 => 'Τρέχουσα οθόνη';

  @override
  String get claudiuDiagnosticSends7 => 'Διάρκεια συνεδρίας (δευτερόλεπτα)';

  @override
  String get claudiuDiagnosticSends8 => 'Σφάλματα αν υπάρχουν (τελευταία 10)';

  @override
  String get claudiuDiagnosticSends9 => 'Πλοήγηση (τελευταίες 20 οθόνες)';

  @override
  String get claudiuDiagnosticNeverHeader => '🛡️ Τι ΠΟΤΕ δεν στέλνουμε:';

  @override
  String get claudiuDiagnosticNever1 => 'Το πραγματικό σου όνομα';

  @override
  String get claudiuDiagnosticNever2 => 'Διεύθυνση email';

  @override
  String get claudiuDiagnosticNever3 => 'Αριθμός τηλεφώνου';

  @override
  String get claudiuDiagnosticNever4 => 'Κωδικός';

  @override
  String get claudiuDiagnosticNever5 => 'Περιεχόμενο μηνυμάτων συνομιλίας';

  @override
  String get claudiuDiagnosticNever6 => 'Περιεχόμενο εισιτηρίων';

  @override
  String get claudiuDiagnosticNever7 => 'Έγγραφα ή συνημμένα';

  @override
  String get claudiuDiagnosticTechHeader => '📡 Τεχνικές λεπτομέρειες:';

  @override
  String get claudiuDiagnosticTech1 => 'Στέλνεται κάθε 2 λεπτά';

  @override
  String get claudiuDiagnosticTech2 =>
      'TLS-κρυπτογραφημένη σύνδεση με σταθερό πιστοποιητικό';

  @override
  String get claudiuDiagnosticTech3 =>
      'Μπορείς να το απενεργοποιήσεις οποιαδήποτε στιγμή στις Ρυθμίσεις';

  @override
  String get claudiuProblemHelpTitle => 'Πώς μπορώ να βοηθήσω;';

  @override
  String get claudiuProblemHelpGreeting => 'Τι συνέβη;';

  @override
  String get claudiuProblemHelpAsk => 'Πώς θες να μου το πεις;';

  @override
  String get claudiuProblemHelpWriteTitle => 'Συντάξτε αναφορά';

  @override
  String get claudiuProblemHelpWriteBody =>
      'Με βήμα-προς-βήμα λεπτομέρειες. Η ομάδα λαμβάνει το κείμενο και το επιλύει αργότερα.';

  @override
  String get claudiuProblemHelpChatTitle => 'Ας μιλήσουμε τώρα';

  @override
  String get claudiuProblemHelpChatBody =>
      'Ανώνυμη συνομιλία με χειριστή. Απάντηση σε πραγματικό χρόνο αν κάποιος είναι συνδεδεμένος.';

  @override
  String get claudiuProblemHelpAltCallHeader => 'Ή, αν είναι επείγον:';

  @override
  String get claudiuProblemHelpAltCallLabel => 'Καλέστε μας';

  @override
  String get claudiuAnonymousChatTitle => 'Ανώνυμη συνομιλία';

  @override
  String get claudiuAnonymousChatGreeting => 'Γεια!';

  @override
  String get claudiuAnonymousChatWelcome =>
      'Σε ακούω. Γράψε ό,τι θες — χωρίς όνομα. Θα απαντήσω μόλις είμαι εδώ.';

  @override
  String get claudiuAnonymousChatHint => 'Γράψε ένα μήνυμα…';

  @override
  String get claudiuAnonymousChatWaitingOperator =>
      'Περιμένουμε απάντηση από χειριστή…';

  @override
  String get claudiuVorsitzerConnectedTitle => 'Γεια!';

  @override
  String get claudiuVorsitzerConnectedBody =>
      'Ευχαριστούμε που μας έγραψες — τώρα είσαι σε επαφή με έναν Vorsitzer. Πες μας πώς μπορούμε να σε βοηθήσουμε με την αίτηση μέλους.';

  @override
  String get claudiuVorsitzerConnectedSender => 'Vorsitzer';

  @override
  String get claudiuQuickReplyValidationTime => 'Πόσο χρόνο παίρνει ο έλεγχος;';

  @override
  String get claudiuQuickReplyDocuments => 'Ποια έγγραφα χρειάζομαι;';

  @override
  String get claudiuQuickReplyStepProblem => 'Έχω κολλήσει σε ένα βήμα';

  @override
  String get claudiuQuickReplyHuman => 'Μπορώ να μιλήσω με κάποιον τώρα;';

  @override
  String get claudiuAnonymousChatConnecting => 'Σύνδεση…';

  @override
  String get claudiuAnonymousChatConnectionFailed =>
      'Δεν μπόρεσα να ανοίξω τη συνομιλία. Δοκίμασε ξανά ή κάλεσε.';

  @override
  String get claudiuAnonymousChatRetry => 'Δοκίμασε ξανά';

  @override
  String get claudiuAnonymousChatOnline => 'Συνδεδεμένος';

  @override
  String get claudiuAnonymousChatOffline => 'Επανασύνδεση…';

  @override
  String get claudiuAnonymousChatAdminTyping => 'Ο χειριστής γράφει…';

  @override
  String get claudiuProblemReportTitle => 'Αναφορά προβλήματος';

  @override
  String get claudiuProblemReportGreeting => 'Τι συνέβη;';

  @override
  String get claudiuProblemReportAsk =>
      'Πες μου με λεπτομέρειες και θα προωθήσω την αναφορά στην ομάδα.';

  @override
  String get claudiuProblemReportIncludeHeader => 'Παρακαλώ συμπεριέλαβε:';

  @override
  String get claudiuProblemReportIncludeBullets1 =>
      'Τι έκανες όταν εμφανίστηκε το πρόβλημα';

  @override
  String get claudiuProblemReportIncludeBullets2 =>
      'Οποιοδήποτε μήνυμα σφάλματος είδες';

  @override
  String get claudiuProblemReportIncludeBullets3 => 'Σε ποια οθόνη ήσουν';

  @override
  String get claudiuProblemReportIncludeBullets4 =>
      'Η εφαρμογή κολλάει, κλείνει ή εμφανίζει λευκή οθόνη;';

  @override
  String get claudiuProblemReportIncludeBullets5 =>
      'Συμβαίνει κάθε φορά ή μόνο μία φορά;';

  @override
  String get claudiuProblemReportDescriptionLabel => 'Η περιγραφή σου';

  @override
  String get claudiuProblemReportDescriptionHint =>
      'Π.χ.: Όταν ανοίγω την οθόνη συνομιλίας, εμφανίζεται μήνυμα \"Connection error\" και η εφαρμογή δεν ανταποκρίνεται…';

  @override
  String claudiuProblemReportTooShort(int count) {
    return 'Λίγο πιο λεπτομερές, παρακαλώ (τουλάχιστον $count χαρακτήρες)';
  }

  @override
  String get claudiuProblemReportSubmit => 'Αποστολή αναφοράς';

  @override
  String get claudiuProblemReportSubmitting => 'Αποστολή…';

  @override
  String get claudiuProblemReportSentTitle => 'Ευχαριστώ!';

  @override
  String get claudiuProblemReportSentBody =>
      'Η αναφορά εστάλη. Η ομάδα μας θα την εξετάσει το συντομότερο.';

  @override
  String get claudiuProblemReportSentClose => 'Κατάλαβα';

  @override
  String get claudiuProblemReportSendFailed =>
      'Δεν ήταν δυνατή η αποστολή της αναφοράς. Καλέστε μας για επείγουσα βοήθεια.';

  @override
  String get claudiuProblemReportAlt => 'Ή, αν είναι επείγον:';

  @override
  String get claudiuProblemReportCallLabel => 'Καλέστε μας';

  @override
  String claudiuApprovalGreeting(String name) {
    return 'Γεια σου, $name! 👋';
  }

  @override
  String get claudiuApprovalGreetingNoName => 'Γεια σου! 👋';

  @override
  String get claudiuApprovalGladToSeeYou => 'Χαίρομαι που ήρθες!';

  @override
  String get claudiuApprovalCheckingForSafety =>
      'Για την ασφάλειά σου, ένας Vorsitzer ελέγχει τώρα το αίτημα σύνδεσης. 🛡️';

  @override
  String get claudiuApprovalMonthlyExplain =>
      '💡 Το κάνουμε αυτό κάθε 30 ημέρες για να είμαστε σίγουροι ότι είσαι εσύ. Είναι σαν έλεγχος ασφαλείας — διαρκεί το πολύ 5 λεπτά.';

  @override
  String get claudiuApprovalSuccess =>
      'Έτοιμο! 🎉 Ο Vorsitzer σε αναγνώρισε. Σε συνδέω τώρα…';

  @override
  String get claudiuApprovalDenied =>
      'Χμ, ο Vorsitzer απέρριψε το αίτημά σου. 😔';

  @override
  String get claudiuApprovalDeniedHelp =>
      'Αν πιστεύεις ότι είναι λάθος, παρακαλώ κάλεσέ μας για να το ξεκαθαρίσουμε.';

  @override
  String get claudiuApprovalExpired =>
      'Πέρασαν τα 5 λεπτά και δεν λάβαμε απάντηση από τον Vorsitzer.';

  @override
  String get claudiuApprovalExpiredHelp =>
      'Κάλεσέ μας και μπορούμε να εγκρίνουμε το αίτημά σου άμεσα. 📞';

  @override
  String get claudiuApprovalCallUs => 'Καλέστε μας';

  @override
  String get claudiuApprovalTryAgain => 'Δοκίμασε ξανά';

  @override
  String get claudiuApprovalCancel => 'Άκυρο';

  @override
  String get claudiuApprovalClose => 'Κλείσιμο';

  @override
  String get wizardIntroBubble1 =>
      'Γεια σου, επισκέπτη! 👋 Σ\'ευχαριστώ που θες να γίνεις μέλος της οικογένειάς μας.';

  @override
  String get wizardIntroBubble2 =>
      'Με λένε Κλαούντιου. Την άνοιξη του 2025 είχα ένα ξεκάθαρο όραμα: να δημιουργήσω έναν σύλλογο που βοηθάει ανθρώπους σε ανάγκη — εθελοντικά, με την καρδιά, χωρίς γραφειοκρατικές περιπλοκές. ❤️';

  @override
  String get wizardIntroBubble3 =>
      'Άρχισα να μιλάω με τους πελάτες που επισκεπτόμουν. Τους είπα το όνειρό μου. Και κάθε ένας είπε: «Ναι, πάμε!» Τον Ιούλιο του 2025 συναντηθήκαμε — 6 αποφασισμένοι άνθρωποι. Αποφασίσαμε να ιδρύσουμε το **ICD360S e.V.** στο Νόι-Ουλμ. 📍';

  @override
  String get wizardIntroBubble4 =>
      'Την **1η Αυγούστου 2025**, ο σύλλογος ζωντάνεψε επίσημα — στο Μητρώο Συλλόγων. Το πιο όμορφο δώρο μου. 🎂';

  @override
  String get wizardIntroBubble5 =>
      'Τι κάνουμε; Βοηθάμε πρόσφυγες, άτομα με αναπηρία, οικονομικά μειονεκτούντες, **παιδιά και νέους** — με διοικητικά θέματα, γερμανικά, στέγαση, ψώνια, κοινωνικά επιδόματα. Το Vorstand μας αποτελείται κυρίως από άτομα με αναπηρία — έτσι οι αποφάσεις προέρχονται από αληθινή εμπειρία ζωής. 🤝';

  @override
  String get wizardIntroBubble6 =>
      'Τώρα είναι η σειρά σου. Ας σε εγγράψουμε — διαρκεί περίπου 5 λεπτά. Πάμε βήμα-βήμα, δεν σε αφήνω μόνο. ✨';

  @override
  String get wizardIntroStart => 'Ας ξεκινήσουμε';

  @override
  String get wizardBack => 'Πίσω';

  @override
  String get wizardNext => 'Επόμενο';

  @override
  String wizardStepLabel(int step, int total, String title) {
    return 'Βήμα $step από $total · $title';
  }

  @override
  String get wizardErrRequired => 'Αυτό το πεδίο είναι υποχρεωτικό';

  @override
  String wizardErrTooShort(int count) {
    return 'Πολύ σύντομο (τουλάχιστον $count χαρακτήρες)';
  }

  @override
  String get wizardErrOnlyLetters =>
      'Μόνο γράμματα, κενά, παύλες και απόστροφοι';

  @override
  String get wizardErrSaveFailed =>
      'Δεν ήταν δυνατή η αποθήκευση. Έλεγξε τη σύνδεση και προσπάθησε ξανά.';

  @override
  String get wizardStufe1aTitle => 'Ταυτότητα';

  @override
  String get wizardStufe1aPrompt =>
      'Ας γνωριστούμε επίσημα. Γράψε το όνομά σου ακριβώς όπως εμφανίζεται στο Personalausweis, Reisepass ή Aufenthaltstitel — ώστε να ταιριάζει με τα έγγραφά σου.';

  @override
  String get wizardStufe1aVornameLabel => 'Vornamen (όνομα)';

  @override
  String get wizardStufe1aVornameHelper =>
      'Όλα τα ονόματά σου, ακριβώς όπως στην ταυτότητα. Με κενό ή παύλα (π.χ. Hans-Peter, Maria Anna).';

  @override
  String get wizardStufe1aNachnameLabel => 'Familienname (επώνυμο)';

  @override
  String get wizardStufe1aNachnameHelper => 'Το τρέχον επώνυμό σου.';

  @override
  String get wizardStufe1aGeburtsnameLabel =>
      'Geburtsname (όνομα γέννησης) — προαιρετικό';

  @override
  String get wizardStufe1aGeburtsnameHelper =>
      'Μόνο αν διαφέρει από το Familienname — π.χ. πριν τον γάμο.';

  @override
  String get wizardStufe1bTitle => 'Γενέθλια';

  @override
  String get wizardStufe1bPrompt =>
      'Θα θέλαμε να γιορτάσουμε τα γενέθλιά σου μαζί! 🎂 Μας βοηθάει επίσης να επιβεβαιώσουμε ότι είσαι τουλάχιστον 16 — έτσι λέει το καταστατικό μας.';

  @override
  String get wizardStufe1bGeburtsdatumLabel => 'Ημερομηνία γέννησης';

  @override
  String get wizardStufe1bGeburtsdatumHelper =>
      'Πάτα για να επιλέξεις ημερομηνία';

  @override
  String get wizardStufe1bGeburtsortLabel => 'Τόπος γέννησης';

  @override
  String get wizardStufe1bGeburtsortHelper =>
      'Πόλη / οικισμός όπου γεννήθηκες.';

  @override
  String get wizardAgeGatePrompt => 'Λυπάμαι… 😔';

  @override
  String wizardAgeGateBody1(int age, int years) {
    return 'Το καταστατικό μας λέει ότι πρέπει να είσαι τουλάχιστον 16 για να γίνεις μέλος. Είσαι $age — ελπίζω να σε δω σε $years χρόνια! 🌱';
  }

  @override
  String get wizardAgeGateBody2 =>
      'Αν θες να βοηθάς περιστασιακά εθελοντικά (οποιαδήποτε ηλικία, με συγκατάθεση γονέων), κάλεσέ μας — μας αρέσει να στηρίζουμε νέους που θέλουν ν\' αλλάξουν τον κόσμο.';

  @override
  String get wizardAgeGateBackHome => 'Πίσω στην αρχική';

  @override
  String get wizardErrInvalidPhone => 'Μη έγκυρος αριθμός τηλεφώνου';

  @override
  String get wizardStufe1b1Title => 'Γονική συναίνεση';

  @override
  String get wizardStufe1b1Prompt =>
      'Είσαι ανήλικος (16-17) — βάσει §106 BGB χρειαζόμαστε τη συναίνεση γονέα ή νόμιμου κηδεμόνα. Πες μου όνομα και τηλέφωνο. Ένας Vorsitzer θα τους καλέσει και θα κανονίσει συνάντηση (από κοντά ή με βιντεοκλήση). Όχι email — θέλουμε να βεβαιωθούμε ότι μιλάμε με το σωστό άτομο.';

  @override
  String get wizardStufe1b1VornameLabel => 'Όνομα γονέα';

  @override
  String get wizardStufe1b1VornameHelper =>
      'Όπως εμφανίζεται στο Personalausweis του γονέα.';

  @override
  String get wizardStufe1b1NachnameLabel => 'Επώνυμο γονέα';

  @override
  String get wizardStufe1b1NachnameHelper =>
      'Όπως εμφανίζεται στο Personalausweis του γονέα.';

  @override
  String get wizardStufe1b1TelefonLabel => 'Κινητό γονέα';

  @override
  String get wizardStufe1b1TelefonHelper =>
      'Ένας Vorsitzer θα καλέσει αυτόν τον αριθμό.';

  @override
  String get wizardStufe1b1RelationLabel => 'Σχέση με το παιδί:';

  @override
  String get wizardStufe1b1RelationMutter => 'Μητέρα';

  @override
  String get wizardStufe1b1RelationVater => 'Πατέρας';

  @override
  String get wizardStufe1b1RelationSorgeberechtigter => 'Νόμιμος κηδεμόνας';

  @override
  String get wizardStufe1b1RelationAndere => 'Άλλος κηδεμόνας';

  @override
  String get wizardStufe1cTitle => 'Προσωπικές πληροφορίες';

  @override
  String get wizardStufe1cPrompt =>
      'Απλά για να σε γνωρίσω λίγο καλύτερα. Αυτά μένουν μεταξύ μας και δεν εμφανίζονται δημόσια πουθενά.';

  @override
  String get wizardStufe1cGeschlechtLabel => 'Φύλο';

  @override
  String get wizardStufe1cGeschlechtMaennlich => 'Άνδρας';

  @override
  String get wizardStufe1cGeschlechtWeiblich => 'Γυναίκα';

  @override
  String get wizardStufe1cGeschlechtDivers => 'Διαφορετικό';

  @override
  String get wizardStufe1cGeschlechtKeineAngabe => 'Προτιμώ να μην πω';

  @override
  String get wizardStufe1cFamilienstandLabel => 'Οικογενειακή κατάσταση';

  @override
  String get wizardStufe1cFamilienstandLedig => 'Άγαμος/η';

  @override
  String get wizardStufe1cFamilienstandVerheiratet => 'Παντρεμένος/η';

  @override
  String get wizardStufe1cFamilienstandGeschieden => 'Διαζευγμένος/η';

  @override
  String get wizardStufe1cFamilienstandVerwitwet => 'Χήρος/Χήρα';

  @override
  String get wizardStufe1dTitle => 'Καταγωγή';

  @override
  String get wizardStufe1dPrompt =>
      'Αυτό μας βοηθάει να σου προσφέρουμε τη σωστή υποστήριξη — π.χ. συμβουλές για Aufenthalt ή να βρεις τη γλωσσική σου κοινότητα.';

  @override
  String get wizardStufe1dStaatLabel => 'Υπηκοότητα';

  @override
  String get wizardStufe1dStaatHelper =>
      'Π.χ. deutsch, rumänisch, ukrainisch. Πολλά με κόμμα.';

  @override
  String get wizardStufe1dAufenthaltLabel =>
      'Καθεστώς διαμονής (Aufenthaltsstatus) — προαιρετικό';

  @override
  String get wizardStufe1dAufenthaltHelper =>
      'Διάλεξε τον τίτλο από την Aufenthaltskarte / την απόφαση σου. Το Vorstand το διασταυρώνει με τα έγγραφά σου.';

  @override
  String get wizardStufe1dAufenthaltAwaitingCitizenship =>
      'Συμπλήρωσε πρώτα την υπηκοότητα παραπάνω — θα δείξουμε μόνο τις σχετικές επιλογές.';

  @override
  String get wizardStufe1dAufenthaltGerman =>
      'Δεν χρειάζεται Aufenthaltstitel — Γερμανός πολίτης.';

  @override
  String get wizardStufe1dAufenthaltEuEea =>
      'Πολίτης ΕΕ/ΕΟΧ/CH — ελευθερία κυκλοφορίας (Freizügigkeit).';

  @override
  String get wizardStufe1dAufenthaltTempHint => 'προσωρινός';

  @override
  String get wizardStufe1dAufenthaltPermHint => 'μόνιμη διαμονή';

  @override
  String get wizardStufe1dAufenthaltAsylumProcessHint => 'διαδικασία ασύλου';

  @override
  String get wizardStufe1dAufenthaltOther => 'Άλλο (διευκρίνισε στο chat)';

  @override
  String get wizardStufe1dAufenthaltRequired =>
      'Διάλεξε έναν Aufenthaltstitel.';

  @override
  String get wizardStufe1dMutterspracheLabel => 'Μητρική γλώσσα';

  @override
  String get wizardStufe1dMutterspracheHelper =>
      'Προσυμπληρωμένο με τη γλώσσα της εφαρμογής — άλλαξε αν διαφέρει.';

  @override
  String get wizardStufe1eTitle => 'Διεύθυνση';

  @override
  String get wizardStufe1ePrompt =>
      'Η ταχυδρομική σου διεύθυνση — τη χρησιμοποιούμε για επίσημα έγγραφα (καταστατικό, συμβάσεις μέλους, ειδοποιήσεις).';

  @override
  String get wizardStufe1eStrasseLabel => 'Οδός';

  @override
  String get wizardStufe1eStrasseHelper =>
      'Μόνο το όνομα της οδού — ο αριθμός στο διπλανό πεδίο.';

  @override
  String get wizardStufe1eHausnummerLabel => 'Αρ.';

  @override
  String get wizardStufe1ePlzLabel => 'PLZ (Τ.Κ.)';

  @override
  String get wizardStufe1eOrtLabel => 'Πόλη';

  @override
  String get wizardStufe1eLandLabel => 'Χώρα';

  @override
  String get wizardStufe1eLandHelper => 'Προσυμπληρωμένο: Deutschland.';

  @override
  String get wizardErrInvalidStreet => 'Μη έγκυρο όνομα οδού';

  @override
  String get wizardErrInvalidHausnummer =>
      'Μη έγκυρος αριθμός (π.χ. 12, 12a, 12/3)';

  @override
  String get wizardErrInvalidPlz => 'Μη έγκυρος Τ.Κ. (μόνο ψηφία)';

  @override
  String get wizardStufe1fTitle => 'Επικοινωνία';

  @override
  String get wizardStufe1fPrompt =>
      'Πώς θα σε βρούμε; Το τηλέφωνο είναι μόνο για επείγοντα — όλα τα υπόλοιπα γίνονται μέσα από το δικό μας κανάλι στην εφαρμογή με κρυπτογράφηση από άκρη σε άκρη. Το email μέλους σου εκχωρείται αυτόματα και εμφανίζεται παρακάτω.';

  @override
  String get wizardStufe1fTelefonLabel => 'Κινητό';

  @override
  String get wizardStufe1fTelefonHelper =>
      'Υπόσχομαι, θα καλέσω μόνο αν είναι σημαντικό. 📱';

  @override
  String get wizardStufe2Title => 'Τύπος μέλους';

  @override
  String get wizardStufe2Prompt =>
      'Τι είδους μέλος θες να γίνεις; Σου εξηγώ κάθε επιλογή.';

  @override
  String get wizardStufe2OrdentlichTitle => 'Τακτικό μέλος (ordentlich)';

  @override
  String get wizardStufe2OrdentlichBody =>
      'Πλήρη δικαιώματα. Πληρώνεις μηνιαία συνδρομή, ψηφίζεις στη Γενική Συνέλευση, μπορείς να εκλεγείς στο Διοικητικό Συμβούλιο. Προεπιλογή.';

  @override
  String get wizardStufe2FoerderTitle => 'Υποστηρικτής (Fördermitglied)';

  @override
  String get wizardStufe2FoerderBody =>
      'Στηρίζεις τον σύλλογο οικονομικά αλλά δεν συμμετέχεις ενεργά στις αποφάσεις. Χωρίς δικαίωμα ψήφου. Καλό αν θες να βοηθήσεις από μακριά.';

  @override
  String get wizardStufe2EhrenTitle => 'Επίτιμο μέλος (Ehrenmitglied)';

  @override
  String get wizardStufe2EhrenBody =>
      'Απονέμεται από το Διοικητικό Συμβούλιο για ιδιαίτερες υπηρεσίες. Δεν το επιλέγεις μόνος — δίνεται ως αναγνώριση. Επίλεξε μόνο αν έχεις ήδη τιμηθεί.';

  @override
  String get wizardStufe3Title => 'Οικονομική κατάσταση';

  @override
  String get wizardStufe3Prompt =>
      'Τώρα για την οικονομική σου κατάσταση. Όχι για να κρίνω — απλά για να σε απαλλάξουμε από τη συνδρομή αν λαμβάνεις κοινωνικά επιδόματα.';

  @override
  String get wizardStufe3OptionBuergergeld => 'Λαμβάνω Bürgergeld';

  @override
  String get wizardStufe3OptionSozialamt => 'Λαμβάνω παροχές από το Sozialamt';

  @override
  String get wizardStufe3OptionNein => 'Δεν λαμβάνω κανένα από αυτά';

  @override
  String get wizardStufe3FeeExemptTitle => 'Συνδρομή: 0 € / μήνα 🎉';

  @override
  String get wizardStufe3FeeExemptBody =>
      'Με Bürgergeld, Sozialamt, ALG I ή Krankengeld απαλλάσσεσαι πλήρως από τη συνδρομή σύμφωνα με το Καταστατικό §6. Χρειαζόμαστε μόνο μια απόδειξη (Leistungsbescheid ή βεβαίωση από την αρχή / το ταμείο υγείας).';

  @override
  String get wizardStufe3UploadTitle => 'Μεταφόρτωση Leistungsbescheid';

  @override
  String get wizardStufe3UploadHint => 'PDF / JPG / PNG, μέγ. 10 MB.';

  @override
  String get wizardStufe3UploadRequired =>
      'Παρακαλώ μεταφόρτωσε το Leistungsbescheid πριν συνεχίσεις.';

  @override
  String get wizardStufe3FileTooLarge =>
      'Το αρχείο είναι πολύ μεγάλο. Μέγιστο 10 MB.';

  @override
  String get wizardStufe3UploadFailed =>
      'Δεν ήταν δυνατή η μεταφόρτωση. Δοκίμασε ξανά.';

  @override
  String get wizardStufe3RegularFeeTitle => 'Συνδρομή: 25 € / μήνα';

  @override
  String get wizardStufe3RegularFeeBody =>
      'Η τυπική συνδρομή για τακτικά μέλη βάσει του καταστατικού.';

  @override
  String get wizardStufe4Title => 'Πληρωμή';

  @override
  String get wizardStufe4Prompt =>
      'Πώς θέλεις να πληρώσεις τη συνδρομή; Και ποια ημέρα του μήνα προτιμάς να γίνεται η χρέωση;';

  @override
  String get wizardStufe4MethodUeberweisungTitle =>
      'Τραπεζικό έμβασμα (Überweisung)';

  @override
  String get wizardStufe4MethodUeberweisungBody =>
      'Ξεκινάς εσύ την πληρωμή κάθε μήνα από τον λογαριασμό σου.';

  @override
  String get wizardStufe4MethodSepaTitle => 'SEPA-Lastschrift (άμεση χρέωση)';

  @override
  String get wizardStufe4MethodSepaBody =>
      'Χρεώνουμε αυτόματα από τον λογαριασμό σου. Πιο βολικό, αλλά χρειαζόμαστε IBAN και υπογεγραμμένη εντολή.';

  @override
  String get wizardStufe4MethodDauerauftragTitle =>
      'Dauerauftrag (πάγια εντολή)';

  @override
  String get wizardStufe4MethodDauerauftragBody =>
      'Στήνεις πάγια εντολή στην τράπεζά σου. Η τράπεζα μεταφέρει το ποσό αυτόματα κάθε μήνα.';

  @override
  String get wizardStufe4DayLabel => 'Ημέρα πληρωμής';

  @override
  String get wizardStufe4DayHint => 'Επίλεξε ημέρα από 1 έως 31';

  @override
  String wizardStufe4DayItem(int day) {
    return 'Ημέρα $day';
  }

  @override
  String wizardStufe4DayReminder(int day) {
    return 'Η συνδρομή θα χρεώνεται την $dayη κάθε μήνα.';
  }

  @override
  String get wizardStufe5Title => 'Έναρξη';

  @override
  String get wizardStufe5Prompt =>
      'Από πότε θες να γίνεις επίσημα μέλος του ICD360S; Από την έγκριση ή αναδρομικά.';

  @override
  String get wizardStufe5OptionAbVerifizierungTitle =>
      'Από την έγκριση του Vorstand';

  @override
  String get wizardStufe5OptionAbVerifizierungBody =>
      'Η πιο απλή επιλογή. Καμία αναδρομική συνδρομή.';

  @override
  String get wizardStufe5OptionGruendungsdatumTitle =>
      'Αναδρομικά από 01.08.2025 (ίδρυση)';

  @override
  String get wizardStufe5OptionGruendungsdatumBody =>
      'Θα θεωρείσαι μέλος από την πρώτη μέρα του συλλόγου.';

  @override
  String get wizardStufe5OptionAnderesDatumTitle => 'Άλλη ημερομηνία';

  @override
  String get wizardStufe5OptionAnderesDatumBody =>
      'Επιλέγεις μια ημερομηνία ανάμεσα στις 01.08.2025 και σήμερα.';

  @override
  String get wizardStufe5PickDate => 'Πάτα για επιλογή ημερομηνίας';

  @override
  String get wizardStufe5PickDateFirst => 'Πρώτα επίλεξε μια ημερομηνία.';

  @override
  String get wizardStufe5DatePickerHelp => 'Έναρξη μέλους';

  @override
  String wizardStufe5DateRange(String start) {
    return 'Ανάμεσα στις $start και σήμερα';
  }

  @override
  String get wizardStufe5RetroactiveTitle => 'Αναδρομική συνδρομή';

  @override
  String wizardStufe5RetroactiveBody(
      String start, String end, int months, String amount) {
    return 'Από $start έως $end είναι $months μήνες. Με 25 €/μήνα γίνονται $amount € οφειλόμενα αναδρομικά, επιπλέον της τρέχουσας μηνιαίας συνδρομής.';
  }

  @override
  String get wizardStufe5FeeExemptTitle => 'Αναδρομική συνδρομή: 0 € 🎉';

  @override
  String get wizardStufe5FeeExemptBody =>
      'Με Bürgergeld ή Sozialamt είσαι πλήρως απαλλαγμένος — ακόμη και αναδρομικά δεν χρωστάς τίποτα.';

  @override
  String wizardDocumentPrompt(String doc) {
    return 'Πριν τελειώσουμε, παρακαλώ διάβασε προσεκτικά το $doc. Είναι σημαντικό να ξέρεις τι υπογράφεις.';
  }

  @override
  String get wizardDocumentScrollHint =>
      'Κάνε κύλιση μέχρι το τέλος για να συνεχίσεις.';

  @override
  String get wizardDocumentScrolledOk => 'Έχεις διαβάσει μέχρι το τέλος ✓';

  @override
  String wizardDocumentOpenButton(String doc) {
    return 'Άνοιξε το $doc στο πρόγραμμα περιήγησης';
  }

  @override
  String get wizardDocumentExternalHint =>
      'Σε αυτή την πλατφόρμα ανοίγουμε το έγγραφο στον προεπιλεγμένο σου περιηγητή.';

  @override
  String get wizardDocumentOpenedOk =>
      'Το έγγραφο άνοιξε. Παρακαλώ διάβασέ το προσεκτικά.';

  @override
  String wizardDocumentConfirm(String doc) {
    return 'Επιβεβαιώνω ότι έχω διαβάσει και συμφωνώ με το $doc.';
  }

  @override
  String get wizardFinalAdultTitle => 'Έτοιμο! Έχεις εγγραφεί 🎉';

  @override
  String get wizardFinalMinorTitle => 'Το αίτημά σου εστάλη 📨';

  @override
  String get wizardFinalMinorBody =>
      'Θα επικοινωνήσουμε με τον γονέα σου και θα κανονίσουμε συνάντηση (από κοντά ή με βιντεοκλήση). Παρακαλώ κάνε υπομονή — η διαδικασία μπορεί να διαρκέσει έως 7 ημέρες. Θα λάβεις ειδοποίηση στην εφαρμογή μόλις ο γονέας σου εγκρίνει.';

  @override
  String get wizardFinalMitgliedernummerLabel => 'Ο αριθμός μέλους σου';

  @override
  String get wizardStufe4MethodComingSoon => 'Σύντομα';

  @override
  String get wizardStufe4StreichungWarning =>
      'Αν καθυστερήσεις τη συνδρομή πάνω από 6 μήνες, θα σε διαγράψουμε αυτόματα (Καταστατικό §6 Abs. 3).';

  @override
  String get wizardStufe5KuendigungInfo =>
      'Για αποχώρηση: στείλε μας την παραίτησή σου γραπτώς 3 μήνες πριν τις 31 Δεκεμβρίου (έως 30 Σεπτεμβρίου για να ισχύσει στο τέλος του έτους). Δεν υπάρχει ελάχιστη διάρκεια (Καταστατικό §6 Abs. 3).';

  @override
  String get wizardStufe1fEmailLabel => 'Το email μέλους σου';

  @override
  String get wizardStufe1fEmailHelper =>
      'Εκχωρείται αυτόματα από τον αριθμό μέλους σου. Ενεργοποιείται τη στιγμή που το διοικητικό συμβούλιο (Vorstand) επικυρώνει την αίτησή σου. Έχουμε τη δική μας εφαρμογή email — στείλε και λάβε κρυπτογραφημένα email, απλά και δωρεάν.';

  @override
  String get wizardErrInvalidEmail => 'Μη έγκυρη διεύθυνση email';

  @override
  String get wizardStufe3OptionAlg1 =>
      'Λαμβάνω Arbeitslosengeld I (ALG I, επίδομα ανεργίας)';

  @override
  String get wizardStufe3OptionKrankengeld =>
      'Λαμβάνω Krankengeld (επίδομα μακροχρόνιας ασθένειας)';

  @override
  String get wizardStufe3UploadAddMore => 'Πρόσθεσε άλλο έγγραφο';

  @override
  String get wizardStufe3UploadLimitCount =>
      'Έφτασες στο όριο: έως 20 έγγραφα.';

  @override
  String get wizardStufe3UploadLimitTotal =>
      'Έφτασες το συνολικό όριο 100 MB. Διέγραψε ένα υπάρχον αρχείο.';

  @override
  String get wizardStufe3UploadDeleteTooltip => 'Διαγραφή';

  @override
  String wizardStufe3UploadCounter(int count, int max) {
    return '$count / $max έγγραφα';
  }

  @override
  String get wizardDocumentExternalOpenFailed =>
      'Δεν μπόρεσα να ανοίξω το πρόγραμμα περιήγησης. Ο σύνδεσμος αντιγράφηκε στο πρόχειρο — επικόλλησέ τον σε ένα πρόγραμμα περιήγησης για να συνεχίσεις.';

  @override
  String get wizardFinalTimelineProcessing =>
      'Το Vorstand ελέγχει · συνήθως 1 εργάσιμη, έως 7';

  @override
  String get wizardFinalTimelineActivated => 'Ο λογαριασμός ενεργοποιήθηκε';

  @override
  String get wizardFinalAdultThank =>
      'Ευχαριστούμε που συμπλήρωσες τη φόρμα εγγραφής! 🎉';

  @override
  String get wizardFinalAdultUsual =>
      'Η αίτησή σου είναι σε εμάς. Συνήθως την επικυρώνουμε εντός μίας εργάσιμης ημέρας.';

  @override
  String get wizardFinalAdultExceptional =>
      'Μερικές φορές μπορεί να χρειαστούν έως 7 εργάσιμες ημέρες. Και αν κάτι δεν ταιριάζει, θα σε επιστρέψουμε στη φόρμα για να το διορθώσεις 🙂';

  @override
  String get wizardFinalStatusTitle => 'ΚΑΤΑΣΤΑΣΗ ΑΙΤΗΣΗΣ';

  @override
  String wizardFinalStatusStepsValidated(int reviewed, int total) {
    return '$reviewed/$total βήματα επικυρώθηκαν από το Vorstand';
  }

  @override
  String get wizardFinalStufeSheetTitle => 'Λεπτομέρειες αίτησης';

  @override
  String get wizardFinalStufeSheetHint =>
      'Τα 8 στάδια που συμπλήρωσες. Το Vorstand τα ελέγχει ένα προς ένα — βλέπεις σε πραγματικό χρόνο τι έχει εγκριθεί.';

  @override
  String get wizardFinalStufeStatusPending => 'Σε αναμονή ελέγχου';

  @override
  String get wizardFinalStufeStatusApproved => 'Εγκρίθηκε';

  @override
  String get wizardFinalStufeStatusRejected => 'Απορρίφθηκε';

  @override
  String wizardFinalStatusRejectionCount(int count) {
    return '$count βήμα χρειάζεται διόρθωση';
  }

  @override
  String get wizardFinalStufeRejectionReason => 'Αιτιολογία του Vorstand:';

  @override
  String get wizardFinalStufeCorrectNow => 'Διόρθωση τώρα';

  @override
  String wizardFinalApprovalsHeader(int current, int total) {
    return 'Εγκρίσεις Vorstand ($current/$total)';
  }

  @override
  String get wizardFinalApprovalAwaiting => 'Αναμονή 2ου Vorstand';

  @override
  String get wizardFinalApprovalRejected => 'ΑΠΟΡΡΙΦΘΗΚΕ';

  @override
  String get wizardFinalStufeNoDataYet =>
      'Τα δεδομένα δεν είναι ακόμη διαθέσιμα.';

  @override
  String get wizardFinalStufeReadAt => 'Διαβάστηκε στις:';

  @override
  String get wizardFinalStufeBeitragsfrei =>
      'Απαλλαγή εισφοράς (χωρίς πληρωμή)';

  @override
  String get wizardFinalStufeNotExempt => 'Χωρίς κοινωνικές παροχές';

  @override
  String get wizardFinalStufeBeginAtVerification =>
      'Έναρξη κατά την επαλήθευση';

  @override
  String get wizardFinalStufeBeginAtFoundation =>
      'Ημερομηνία ίδρυσης (αναδρομικά)';

  @override
  String get wizardFinalStufeBeginAtCustom => 'Άλλη ημερομηνία';

  @override
  String get wizardFinalStufeStatusSkipped => 'Παραλείφθηκε';

  @override
  String get wizardFinalStufeFilledAt => 'Συμπληρώθηκε:';

  @override
  String get wizardFinalStufeReviewedAt => 'Ελέγχθηκε:';

  @override
  String get wizardFinalWithdrawLink => 'Απόσυρση αίτησης';

  @override
  String get wizardFinalWithdrawDialogTitle => 'Απόσυρση της αίτησής σου;';

  @override
  String get wizardFinalWithdrawDialogBody =>
      'Η αίτησή σου θα επισημανθεί ως αποσυρμένη από σένα. Τα δεδομένα παραμένουν στη βάση για έλεγχο (GDPR), αλλά ο λογαριασμός δεν θα ενεργοποιηθεί. Μπορείς να ξαναξεκινήσεις την εγγραφή ανά πάσα στιγμή με νέο αριθμό μέλους.';

  @override
  String get wizardFinalWithdrawKeep => 'Όχι, θα περιμένω';

  @override
  String get wizardFinalWithdrawConfirm => 'Ναι, απόσυρση';

  @override
  String get wizardErrTooManyWithdrawals =>
      'Η αίτησή σου δεν μπορεί να γίνει αυτόματα. Κάλεσέ μας ή έλα αυτοπροσώπως στο Vorstand για να συνεχίσεις την εγγραφή.';

  @override
  String get wizardDuplicateLoginTitle => 'Φαίνεται ότι είσαι ήδη μέλος μας';

  @override
  String get wizardDuplicateLoginBody =>
      'Με το όνομα και την ημερομηνία γέννησής σου βρίσκουμε ήδη ενεργό λογαριασμό. Χρησιμοποίησε το \"Είμαι ήδη μέλος\" στην αρχική οθόνη για να συνδεθείς. Αν δεν έχεις πια πρόσβαση, κάλεσέ μας.';

  @override
  String get wizardDuplicatePendingTitle => 'Η αίτησή σου είναι ήδη σε εμάς';

  @override
  String get wizardDuplicatePendingBody =>
      'Με το όνομα και την ημερομηνία γέννησής σου έχουμε ήδη αίτηση υπό εξέταση. Το Vorstand εργάζεται πάνω της — θα σου στείλουμε ειδοποίηση στην εφαρμογή μόλις ενεργοποιηθεί ο λογαριασμός. Κάλεσέ μας αν θέλεις να μιλήσουμε.';

  @override
  String get wizardDuplicateRecentlyWithdrawnTitle =>
      'Δεν μπορούμε να επεξεργαστούμε αυτή την αίτηση τώρα';

  @override
  String get wizardDuplicateRecentlyWithdrawnBody =>
      'Το όνομα και η ημερομηνία γέννησής σου ταιριάζουν με πρόσφατα αποσυρμένη αίτηση. Κάλεσέ μας για να μιλήσεις με το Vorstand πριν συνεχίσεις.';

  @override
  String get wizardDuplicatePreviouslyWithdrawnTitle =>
      'Έχεις υποβάλει αίτηση στο παρελθόν';

  @override
  String get wizardDuplicatePreviouslyWithdrawnBody =>
      'Το όνομα και η ημερομηνία γέννησής σου ταιριάζουν με παλαιότερη αίτηση που είχες αποσύρει. Καλώς ήρθες ξανά — κάλεσέ μας πριν συνεχίσεις, ώστε το Vorstand να αποφασίσει πώς προχωράμε.';

  @override
  String get wizardDuplicateCallUsTitle => 'Κάλεσέ μας, σε παρακαλώ';

  @override
  String get wizardDuplicateCallUsBody =>
      'Το όνομα και η ημερομηνία γέννησής σου εμφανίζονται ήδη στα αρχεία μας, αλλά δεν μπορούμε να σου τα κοινοποιήσουμε μέσω της εφαρμογής. Κάλεσέ μας — το Vorstand θα σου εξηγήσει απευθείας.';

  @override
  String get wizardChatHelp => 'Ας μιλήσουμε';

  @override
  String get wizardChatHelpSubtitle =>
      'Live chat με το Vorstand · γρήγορη απάντηση';

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

  @override
  String get benachrichtigungenLeer => 'Keine Benachrichtigungen';

  @override
  String get benachrichtigungenAlleGelesen => 'Alle als gelesen markieren';

  @override
  String get benachrichtigungWetterFrage =>
      'Möchten Sie bei Unwetter an Ihrem Wohnort gewarnt werden?';

  @override
  String get benachrichtigungWetterDetail =>
      'Nur amtliche Warnungen des Deutschen Wetterdienstes ab Stufe „schwer“ — nicht bei jedem Regen.';
}
