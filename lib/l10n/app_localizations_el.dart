// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Modern Greek (`el`).
class AppLocalizationsEl extends AppLocalizations {
  AppLocalizationsEl([String locale = 'el']) : super(locale);

  @override
  String get appTitle => 'ICD360S e.V - Πύλη Μελών';

  @override
  String get memberPortal => 'Πύλη Μελών';

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
  String get password => 'Κωδικός';

  @override
  String get passwordHint => 'Εισάγετε τον κωδικό';

  @override
  String get confirmPassword => 'Επιβεβαίωση Κωδικού';

  @override
  String get confirmPasswordHint => 'Επιβεβαιώστε τον κωδικό';

  @override
  String get newPassword => 'Νέος Κωδικός';

  @override
  String get newPasswordHint => 'Εισάγετε νέο κωδικό';

  @override
  String get saveCredentials => 'Αποθήκευση στοιχείων';

  @override
  String get autoLogin => 'Αυτόματη σύνδεση';

  @override
  String get forgotPassword => 'Ξεχάσατε τον κωδικό;';

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
  String get recoveryCode => 'Κωδικός Ανάκτησης (6 ψηφία)';

  @override
  String get recoveryCodeHelper =>
      'Θυμηθείτε αυτόν τον κωδικό για ανάκτηση κωδικού';

  @override
  String get recoveryCodeHint => 'Εισάγετε κωδικό ανάκτησης';

  @override
  String get recoveryCodeInvalid => 'Ο κωδικός πρέπει να έχει ακριβώς 6 ψηφία';

  @override
  String get loginFailed => 'Αποτυχία σύνδεσης';

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
  String get tooManyDevices => 'Πάρα πολλές συσκευές';

  @override
  String get maxDevicesMessage =>
      'Είστε ήδη συνδεδεμένοι σε 3 συσκευές.\nΕπιλέξτε συσκευή για αποσύνδεση:';

  @override
  String get unknownDevice => 'Άγνωστη συσκευή';

  @override
  String get unknown => 'Άγνωστο';

  @override
  String get logoutError => 'Σφάλμα αποσύνδεσης';

  @override
  String error(String error) {
    return 'Σφάλμα: $error';
  }

  @override
  String get cancel => 'Ακύρωση';

  @override
  String get resetPassword => 'Επαναφορά Κωδικού';

  @override
  String get forgotPasswordTitle => 'Ξεχάσατε τον Κωδικό';

  @override
  String get forgotPasswordDescription =>
      'Εισάγετε τον αριθμό μέλους και τον κωδικό ανάκτησης που δημιουργήσατε κατά την εγγραφή.';

  @override
  String get passwordResetSuccess =>
      'Ο κωδικός επαναφέρθηκε επιτυχώς!\n\nΤώρα μπορείτε να συνδεθείτε με τον νέο κωδικό.';

  @override
  String get passwordResetFailed => 'Αποτυχία επαναφοράς κωδικού';

  @override
  String get needHelp => 'Χρειάζεστε βοήθεια;';

  @override
  String get helpQuestion => 'Προβλήματα με τη σύνδεση ή την εγγραφή;';

  @override
  String get helpDescription =>
      'Επικοινωνήστε μέσω WhatsApp και περιγράψτε τι δεν λειτουργεί. Θα απαντήσουμε το συντομότερο!';

  @override
  String get whatsapp => 'WhatsApp';

  @override
  String get emailSubject => 'Ερώτημα μέσω εφαρμογής ICD360S';

  @override
  String get whatsappMessage =>
      'Γεια σας, έχω πρόβλημα με την εφαρμογή ICD360S. ';

  @override
  String get imprint => 'Impressum';

  @override
  String get privacy => 'Πολιτική Απορρήτου';

  @override
  String get statutes => 'Καταστατικό';

  @override
  String get revocation => 'Δικαίωμα Υπαναχώρησης';

  @override
  String get cancellation => 'Ακύρωση';

  @override
  String get allRightsReserved => 'Με επιφύλαξη παντός δικαιώματος.';

  @override
  String get enterCredentials => 'Εισάγετε αριθμό μέλους και κωδικό';

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
  String get membership => 'Μέλος';

  @override
  String get myAppointments => 'Τα ραντεβού μου';

  @override
  String get appointmentsLoadingReady => 'Φόρτωση ραντεβού - API έτοιμο!';

  @override
  String get priority => 'Προτεραιότητα';

  @override
  String get messageLabel => 'Μήνυμα';

  @override
  String get createdOn => 'Δημιουργήθηκε';

  @override
  String get handler => 'Διαχειριστής';

  @override
  String get reportProblems => 'Αναφορά προβλημάτων';

  @override
  String get reportProblem => 'Αναφορά προβλήματος';

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
  String get newTicket => 'Νέο αίτημα';

  @override
  String get noOpenTickets => 'Δεν υπάρχουν ανοιχτά αιτήματα';

  @override
  String get haveQuestionCreateTicket =>
      'Έχετε ερώτηση ή πρόβλημα;\nΔημιουργήστε ένα νέο αίτημα.';

  @override
  String get whatIsTheProblem => 'Ποιο είναι το πρόβλημα;';

  @override
  String get describeTheProblem => 'Περιγράψτε το πρόβλημα';

  @override
  String get howUrgentIsIt => 'Πόσο επείγον είναι;';

  @override
  String get low => 'Χαμηλή';

  @override
  String get medium => 'Μεσαία';

  @override
  String get high => 'Υψηλή';

  @override
  String get submit => 'Υποβολή';

  @override
  String get fillSubjectAndMessage => 'Συμπληρώστε το θέμα και το μήνυμα';

  @override
  String get ticketCreated => 'Το αίτημα δημιουργήθηκε';

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
  String get newEmailAddress => 'Νέα διεύθυνση email';

  @override
  String get currentPassword => 'Τρέχων κωδικός';

  @override
  String get saveEmail => 'Αποθήκευση email';

  @override
  String get savePassword => 'Αποθήκευση κωδικού';

  @override
  String get deviceLoggedOut => 'Η συσκευή αποσυνδέθηκε';

  @override
  String get passwordChangedSuccessfully => 'Ο κωδικός άλλαξε επιτυχώς';

  @override
  String get emailChangedSuccessfully => 'Το email άλλαξε επιτυχώς';

  @override
  String get errorChangingPassword => 'Σφάλμα κατά την αλλαγή κωδικού';

  @override
  String get errorChangingEmail => 'Σφάλμα κατά την αλλαγή email';

  @override
  String get validEmailRequired => 'Εισαγάγετε μια έγκυρη διεύθυνση email';

  @override
  String get passwordTooShort =>
      'Ο κωδικός πρέπει να έχει τουλάχιστον 6 χαρακτήρες';

  @override
  String get maxDevicesReached =>
      'Είστε συνδεδεμένοι στο μέγιστο των 3 συσκευών.';

  @override
  String loggedInOnDevices(int count) {
    return 'Είστε συνδεδεμένοι σε $count από 3 συσκευές.';
  }

  @override
  String get noActiveSessions => 'Δεν υπάρχουν ενεργές συνεδρίες';

  @override
  String get logoutFromDevice => 'Αποσύνδεση από αυτή τη συσκευή';

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
  String get errorAcceptingCall => 'Σφάλμα αποδοχής κλήσης';

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
  String typingIndicator(String name) {
    return '$name γράφει...';
  }

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
  String get diagnosticDataTitle => 'Διαγνωστικά δεδομένα';

  @override
  String get diagnosticDescription =>
      'Θέλετε να στέλνετε ανώνυμα διαγνωστικά δεδομένα για τη βελτίωση της εφαρμογής;';

  @override
  String get noThanks => 'Όχι, ευχαριστώ';

  @override
  String get yesEnable => 'Ναι, ενεργοποίηση';

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
  String get newPasswordMinChars => 'Νέος κωδικός (ελάχ. 6 χαρακτήρες)';

  @override
  String get reasonLabel2 => 'Λόγος';

  @override
  String get downloadFailed2 => 'Η λήψη απέτυχε';

  @override
  String get downloadTooltip => 'Λήψη';

  @override
  String get connectionErrorGeneric => 'Σφάλμα σύνδεσης';

  @override
  String get errorNoInternet => 'Δεν υπάρχει σύνδεση στο διαδίκτυο. Ελέγξτε το δίκτυό σας.';

  @override
  String get errorTimeout => 'Ο διακομιστής δεν αποκρίνεται. Δοκιμάστε αργότερα.';

  @override
  String get errorServer => 'Σφάλμα διακομιστή. Δοκιμάστε αργότερα.';

  @override
  String get errorConnection => 'Σφάλμα σύνδεσης. Δοκιμάστε αργότερα.';

  @override
  String get errorUnexpected => 'Παρουσιάστηκε απροσδόκητο σφάλμα. Δοκιμάστε αργότερα.';

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
  String get bankTransfer => 'Τραπεζικό έμβασμα';

  @override
  String get standingOrder => 'Πάγια εντολή';

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
  String get memberNumberTooLong =>
      'Αριθμός μέλους πολύ μεγάλος (μέγ. 20 χαρακτήρες)';

  @override
  String get onlyUppercaseAndNumbers =>
      'Επιτρέπονται μόνο κεφαλαία γράμματα και αριθμοί';

  @override
  String get passwordTooLong => 'Κωδικός πολύ μεγάλος (μέγ. 100 χαρακτήρες)';

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
  String get diagnosticErrors => 'Αναφορές σφαλμάτων για βελτίωση';

  @override
  String get diagnosticAnonymousStats => 'Ανώνυμα στατιστικά χρήσης';

  @override
  String get diagnosticPerformance => 'Δεδομένα απόδοσης εφαρμογής';

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
  String get ipClean => 'IP καθαρή - μη καταχωρημένη';

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
  String get helpImproveApp =>
      'Θέλετε να μας βοηθήσετε να βελτιώσουμε την εφαρμογή;';

  @override
  String get noPersonalDataCollected =>
      'Δεν συλλέγονται προσωπικά δεδομένα. Αυτή η ρύθμιση μπορεί να αλλάξει ανά πάσα στιγμή.';

  @override
  String logEntries(int count) {
    return '$count εγγραφές';
  }

  @override
  String get noLogs => 'Χωρίς αρχεία';

  @override
  String get newLoginDetected => 'Εντοπίστηκε νέα σύνδεση';

  @override
  String get waitingForMember => 'Αναμονή μέλους';

  @override
  String get waitingForStaff => 'Αναμονή προσωπικού';

  @override
  String get waitingForAuthority => 'Αναμονή αρχής';
}
