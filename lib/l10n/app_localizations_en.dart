// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get welcomeLoading => 'Loading...';

  @override
  String get welcomeAutoLogin => 'Automatic login...';

  @override
  String get login => 'Login';

  @override
  String get register => 'Register';

  @override
  String get becomeMember => 'Become a Member';

  @override
  String get memberNumber => 'Member Number';

  @override
  String get memberNumberHint => 'Please enter member number';

  @override
  String get confirmPassword => 'Confirm Password';

  @override
  String get confirmPasswordHint => 'Please confirm password';

  @override
  String get newPassword => 'New Password';

  @override
  String get newPasswordHint => 'Please enter new password';

  @override
  String get firstName => 'First and Last Name';

  @override
  String get firstNameHint => 'Please enter first and last name';

  @override
  String get nameMinLength => 'Name must have at least 2 characters';

  @override
  String get nameOnlyLetters => 'Only letters and hyphens allowed';

  @override
  String get email => 'Email Address';

  @override
  String get emailHint => 'Please enter email';

  @override
  String get emailInvalid => 'Please enter a valid email';

  @override
  String get passwordMinLength => 'Password must have at least 6 characters';

  @override
  String get passwordsNotMatch => 'Passwords do not match';

  @override
  String get registrationFailed => 'Registration failed';

  @override
  String connectionError(String error) {
    return 'Connection error: $error';
  }

  @override
  String registrationSuccess(String memberNumber) {
    return 'Registration successful!\n\nYour member number: $memberNumber\n\nPlease remember this number for login.';
  }

  @override
  String get unknown => 'Unknown';

  @override
  String error(String error) {
    return 'Error: $error';
  }

  @override
  String get cancel => 'Cancel';

  @override
  String get resetPassword => 'Reset Password';

  @override
  String get imprint => 'Imprint';

  @override
  String get privacy => 'Privacy Policy';

  @override
  String get statutes => 'Statutes';

  @override
  String get revocation => 'Right of Withdrawal';

  @override
  String get appointments => 'Appointments';

  @override
  String get tickets => 'Tickets';

  @override
  String get liveChat => 'Live Chat';

  @override
  String get notifications => 'Notifications';

  @override
  String get myProfile => 'My Profile';

  @override
  String get logout => 'Logout';

  @override
  String get goodMorning => 'Good Morning';

  @override
  String get goodDay => 'Good Day';

  @override
  String get goodEvening => 'Good Evening';

  @override
  String get goodNight => 'Good Night';

  @override
  String get welcomeToICD => 'Welcome to ICD360S e.V!';

  @override
  String get accountCreatedSuccessfully =>
      'Your account has been successfully created.';

  @override
  String get today => 'Today';

  @override
  String get membershipFeeDue => 'Membership fee due';

  @override
  String get pleaseTransferAnnualFee => 'Please transfer the annual fee.';

  @override
  String get newBadge => 'New';

  @override
  String get close => 'Close';

  @override
  String get myAppointments => 'My Appointments';

  @override
  String get priority => 'Priority';

  @override
  String get messageLabel => 'Message';

  @override
  String get reportProblems => 'Report Problems';

  @override
  String get weRespondIn24Hours =>
      'We will respond to you within a maximum of 24 hours!';

  @override
  String get everythingOk => 'Everything OK!';

  @override
  String get haveProblemWeHelp => 'Have a problem?\nWe\'ll take care of it!';

  @override
  String get myMembership => 'My Membership';

  @override
  String get managePersonalDataAndFee =>
      'Manage your personal data and membership fee';

  @override
  String get myAppointmentsTitle => 'My Appointments';

  @override
  String get appointmentsDescription =>
      'Here you can see your upcoming appointments.\nYou can confirm your participation or decline.';

  @override
  String get loadAppointments => 'Load Appointments';

  @override
  String get myTickets => 'My Tickets';

  @override
  String get low => 'Low';

  @override
  String get high => 'High';

  @override
  String get submit => 'Submit';

  @override
  String get errorCreatingTicket => 'Error creating ticket';

  @override
  String get verified => 'Verified';

  @override
  String get account => 'Account';

  @override
  String get myDevices => 'My Devices';

  @override
  String get changeEmail => 'Change Email';

  @override
  String get changePassword => 'Change Password';

  @override
  String get saveEmail => 'Save Email';

  @override
  String get savePassword => 'Save Password';

  @override
  String get deviceLoggedOut => 'Device logged out';

  @override
  String get emailChangedSuccessfully => 'Email changed successfully';

  @override
  String get errorChangingPassword => 'Error changing password';

  @override
  String get errorChangingEmail => 'Error changing email';

  @override
  String get validEmailRequired => 'Please enter a valid email address';

  @override
  String get confirmLogoutDevice => 'Log out device?';

  @override
  String get confirmLogoutMessage =>
      'Do you want to log out from this device?\n\nYou will need to log in again to use this device.';

  @override
  String get ipAddress => 'IP';

  @override
  String get platform => 'Platform';

  @override
  String trialWarningUrgentTitle(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'days',
      one: 'day',
    );
    return 'Warning: Only $days $_temp0 until account suspension!';
  }

  @override
  String get trialWarningTitle => 'Your account is not yet verified';

  @override
  String get trialWarningDescription =>
      'Please complete your data in \"My Profile\". After 30 days your account will be automatically suspended.';

  @override
  String trialDaysRemaining(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days days',
      one: '1 day',
    );
    return '$_temp0';
  }

  @override
  String get overview => 'Overview';

  @override
  String get member => 'Member';

  @override
  String get memberManagement => 'Member Management';

  @override
  String get reportProblemTooltip => 'Report Problem';

  @override
  String get newAppointmentsTitle => 'New Appointments';

  @override
  String get youHaveNewAppointment => 'You have a new appointment.';

  @override
  String youHaveNewAppointments(int count) {
    return 'You have $count new appointments.';
  }

  @override
  String get appointmentReminderTomorrow => 'Reminder: Appointment tomorrow';

  @override
  String tomorrowAppointment(String title) {
    return 'Tomorrow: $title';
  }

  @override
  String youHaveTomorrowAppointments(int count) {
    return 'You have $count appointments tomorrow.';
  }

  @override
  String get appointmentsToday => 'Appointments today';

  @override
  String todayAppointment(String title) {
    return 'Today: $title';
  }

  @override
  String youHaveTodayAppointments(int count) {
    return 'You have $count appointments today.';
  }

  @override
  String get paymentReminder => 'Payment Reminder';

  @override
  String paymentReminderMessage(int day, String method) {
    return 'Today is the ${day}th of the month – please complete $method.';
  }

  @override
  String get paymentDayLabel => 'Payment day (monthly reminder)';

  @override
  String get updateAvailable => 'Update available';

  @override
  String newVersionAvailable(String version) {
    return 'A new version is available: $version';
  }

  @override
  String currentVersionLabel(String version) {
    return 'Current version: $version';
  }

  @override
  String get changes => 'Changes:';

  @override
  String downloadProgress(String percent) {
    return 'Download: $percent%';
  }

  @override
  String get installationStarting => 'Starting installation...';

  @override
  String get appWillRestart => 'The app will restart automatically.';

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
  String get later => 'Later';

  @override
  String get updateNow => 'Update now';

  @override
  String get downloading => 'Downloading...';

  @override
  String get downloadFailed => 'Download failed. Please try again later.';

  @override
  String get searchingForUpdates => 'Searching for updates...';

  @override
  String get appUpToDate => 'The app is up to date';

  @override
  String get updateCheckError => 'Error checking for updates';

  @override
  String get changelog => 'Changelog';

  @override
  String get terminConfirmed => 'Appointment confirmed';

  @override
  String get terminDeclined => 'Appointment declined';

  @override
  String get terminRescheduleRequested => 'Reschedule requested';

  @override
  String get statusConfirmed => 'Confirmed';

  @override
  String get statusDeclined => 'Declined';

  @override
  String get statusRescheduling => 'Rescheduling';

  @override
  String get statusPending => 'Pending';

  @override
  String get categoryVorstandssitzung => 'Board Meeting';

  @override
  String get categoryMitgliederversammlung => 'General Assembly';

  @override
  String get categorySchulung => 'Training';

  @override
  String get categorySonstiges => 'Other';

  @override
  String openCount(int count) {
    return '$count open';
  }

  @override
  String get refresh => 'Refresh';

  @override
  String get filterUpcoming => 'Upcoming';

  @override
  String get filterPast => 'Past';

  @override
  String get filterAll => 'All';

  @override
  String get noUpcomingAppointments => 'No upcoming appointments';

  @override
  String get noPastAppointments => 'No past appointments';

  @override
  String get noAppointmentsAvailable => 'No appointments available';

  @override
  String get appointmentsShownHere => 'Your appointments will be shown here';

  @override
  String get dateLabel => 'Date';

  @override
  String get timeLabel => 'Time';

  @override
  String get locationLabel => 'Location';

  @override
  String get createdByLabel => 'Created by';

  @override
  String get descriptionLabel => 'Description';

  @override
  String get ticketLabel => 'Ticket';

  @override
  String get yourStatus => 'Your status: ';

  @override
  String reasonLabel(String reason) {
    return 'Reason: $reason';
  }

  @override
  String durationMinutes(int minutes) {
    return '$minutes min';
  }

  @override
  String get confirm => 'Confirm';

  @override
  String get decline => 'Decline';

  @override
  String get reschedule => 'Reschedule';

  @override
  String get requestReschedule => 'Request reschedule';

  @override
  String appointmentLabel(String title) {
    return 'Appointment: $title';
  }

  @override
  String get rescheduleReason => 'Reason for rescheduling *';

  @override
  String get rescheduleReasonHint => 'Please provide a reason...';

  @override
  String get pleaseProvideReason => 'Please provide a reason';

  @override
  String get request => 'Request';

  @override
  String get ticketStatusOpen => 'Open';

  @override
  String get ticketStatusInProgress => 'In Progress';

  @override
  String get ticketStatusWaitingMember => 'Waiting for Member';

  @override
  String get ticketStatusWaitingStaff => 'Waiting for Staff';

  @override
  String get ticketStatusWaitingAuthority => 'Waiting for Authority';

  @override
  String get ticketStatusDone => 'Done';

  @override
  String get ticketPriorityHigh => 'High';

  @override
  String get ticketPriorityMedium => 'Medium';

  @override
  String get ticketPriorityLow => 'Low';

  @override
  String get comments => 'Comments';

  @override
  String get documents => 'Documents';

  @override
  String get details => 'Details';

  @override
  String get replySent => 'Reply sent';

  @override
  String get sendError => 'Error sending';

  @override
  String get uploading => 'Uploading...';

  @override
  String fileUploaded(String filename) {
    return '$filename uploaded';
  }

  @override
  String get uploadFailed => 'Upload failed';

  @override
  String get openError => 'Error opening';

  @override
  String get noRepliesYet => 'No replies yet';

  @override
  String get waitingForSupport => 'Waiting for support response';

  @override
  String get writeReply => 'Write a reply...';

  @override
  String get attachFile => 'Attach file';

  @override
  String documentsCount(int count) {
    return 'Documents ($count)';
  }

  @override
  String get upload => 'Upload';

  @override
  String get noDocuments => 'No documents available';

  @override
  String get allowedFormats => 'Allowed formats: PDF, JPEG, JPG, TXT, ZIP';

  @override
  String get yourMessage => 'Your message:';

  @override
  String get translation => 'Translation';

  @override
  String get original => 'Original';

  @override
  String get originalText => 'Original text';

  @override
  String get autoTranslated => 'Automatically translated';

  @override
  String get originalTapTranslation => 'Original text · Tap for translation';

  @override
  String get translatedTapOriginal => 'Translated · Tap for original';

  @override
  String get justNow => 'Just now';

  @override
  String minutesAgo(int minutes) {
    return '$minutes min ago';
  }

  @override
  String hoursAgo(int hours) {
    return '$hours hours ago';
  }

  @override
  String daysAgo(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'days',
      one: 'day',
    );
    return '$days $_temp0 ago';
  }

  @override
  String get createdLabel => 'Created';

  @override
  String get updatedLabel => 'Updated';

  @override
  String get handlerLabel => 'Handler';

  @override
  String get doneLabel => 'Done';

  @override
  String get newTicketTitle => 'New Ticket';

  @override
  String get categoryOptional => 'Category (optional)';

  @override
  String get selectCategory => 'Select';

  @override
  String get subjectLabel => 'Subject';

  @override
  String get fillAllFields => 'Please fill in all fields';

  @override
  String ticketCreatedId(int id) {
    return 'Ticket #$id created';
  }

  @override
  String get priorityLabel => 'Priority: ';

  @override
  String get supportOffline => 'Support offline';

  @override
  String get lastSeenSeconds => 'Last active a few seconds ago';

  @override
  String lastSeenMinutes(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: 'minutes',
      one: 'minute',
    );
    return 'Last active $minutes $_temp0 ago';
  }

  @override
  String lastSeenHours(int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: 'hours',
      one: 'hour',
    );
    return 'Last active $hours $_temp0 ago';
  }

  @override
  String lastSeenDays(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'days',
      one: 'day',
    );
    return 'Last active $days $_temp0 ago';
  }

  @override
  String get online => 'Online';

  @override
  String get callSupport => 'Call';

  @override
  String get typeMessage => 'Type a message...';

  @override
  String get callBusy => 'Support is busy';

  @override
  String get callRejected => 'Call was rejected';

  @override
  String get callFailed => 'Call could not connect';

  @override
  String get callEnded => 'Call ended';

  @override
  String get callSupportBusy => 'Support is already in another call';

  @override
  String get errorStartingChat => 'Error starting chat';

  @override
  String get errorStartingCall => 'Error starting call';

  @override
  String get errorConnecting => 'Error connecting';

  @override
  String get errorDownloading => 'Error downloading';

  @override
  String get errorUploading => 'Error uploading';

  @override
  String get errorSending => 'Error sending';

  @override
  String get errorPickingPhotos => 'Error selecting photos';

  @override
  String get errorPickingFiles => 'Error selecting files';

  @override
  String get errorTakingPhoto => 'Error taking photo';

  @override
  String get fileNotLoaded => 'File could not be loaded';

  @override
  String get attachmentIdMissing => 'Attachment ID missing';

  @override
  String get camera => 'Camera';

  @override
  String get gallery => 'Gallery';

  @override
  String get file => 'File';

  @override
  String get notifNewMessageFrom => 'New message from';

  @override
  String get notifUrgentPrefix => 'URGENT';

  @override
  String get notifUrgentMessage => 'URGENT MESSAGE';

  @override
  String get notifIncomingCall => 'Incoming call';

  @override
  String get notifCallingYou => 'is calling...';

  @override
  String get notifUpdateAvailable => 'Update available';

  @override
  String get notifVersionAvailable => 'is now available';

  @override
  String get notifConnected => 'Connected';

  @override
  String get notifDisconnected => 'Disconnected';

  @override
  String get notifConnectedBody => 'You are now connected to the server.';

  @override
  String get notifDisconnectedBody => 'The connection to the server was lost.';

  @override
  String get notifError => 'Error';

  @override
  String get retry => 'Try again';

  @override
  String get save => 'Save';

  @override
  String get accept => 'Accept';

  @override
  String get selectFile => 'Select file';

  @override
  String get dataLoadingText => 'Loading data...';

  @override
  String get dataSavedSuccess => 'Data saved successfully';

  @override
  String get errorSaving => 'Error saving';

  @override
  String get errorLoading => 'Error loading';

  @override
  String savedFilename(String filename) {
    return 'Saved: $filename';
  }

  @override
  String get logsCopied => 'Logs copied!';

  @override
  String get passwordMinEightChars => 'Password must be at least 8 characters';

  @override
  String get passwordChangeSuccess => 'Password changed successfully';

  @override
  String get emailChangeError => 'Error changing email';

  @override
  String get acceptDocumentCheckbox => 'I have read and accept the document.';

  @override
  String loadingErrorGeneric(String details) {
    return 'Loading error: $details';
  }

  @override
  String get incomingCallTitle => 'Incoming Call';

  @override
  String ringingFor(int seconds) {
    return 'Ringing for ${seconds}s';
  }

  @override
  String get rejectCall => 'Reject';

  @override
  String get acceptCall => 'Accept';

  @override
  String get unmute => 'Unmute';

  @override
  String get mute => 'Mute';

  @override
  String get hangUp => 'Hang up';

  @override
  String get calling => 'Calling...';

  @override
  String autoRejectIn(int seconds) {
    return 'Auto-reject in $seconds seconds';
  }

  @override
  String get speakerOn => 'Speaker';

  @override
  String get speakerOff => 'Earpiece';

  @override
  String get micMuted => 'Muted';

  @override
  String get micOn => 'Microphone';

  @override
  String get connectionExcellent => 'Excellent';

  @override
  String get connectionGood => 'Good';

  @override
  String get connectionWeak => 'Weak';

  @override
  String get connectionLost => 'Disconnected';

  @override
  String get personalData => 'Personal Data';

  @override
  String get personalDataSubtitle => 'Name, surname, address';

  @override
  String get membershipFee => 'Membership Fee';

  @override
  String annualFeeYear(String year) {
    return 'Annual fee $year';
  }

  @override
  String get amount => 'Amount:';

  @override
  String get dueBy => 'Due by:';

  @override
  String get paid => 'Paid';

  @override
  String get versionHistory => 'Version History';

  @override
  String lastUpdated(String date) {
    return 'Last updated: $date';
  }

  @override
  String get noVersionHistory => 'No version history available';

  @override
  String get failedLoadChangelog => 'Failed to load changelog';

  @override
  String get callMember => 'Call member';

  @override
  String get closeConversation => 'Close conversation';

  @override
  String get chatOffline => 'Offline';

  @override
  String get attachFiles => 'Attach files (max. 10, 50MB)';

  @override
  String get conversationClosed => 'This conversation has been closed';

  @override
  String get noMessages => 'No messages';

  @override
  String get goBack => 'Back';

  @override
  String get goForward => 'Forward';

  @override
  String get homePage => 'Home';

  @override
  String get firstNameLabel => 'First name';

  @override
  String get lastNameLabel => 'Last name';

  @override
  String get streetLabel => 'Street';

  @override
  String get houseNumberLabel => 'No.';

  @override
  String get postalCodeLabel => 'Postal code';

  @override
  String get cityLabel => 'City';

  @override
  String get phoneMobileLabel => 'Phone (Mobile)';

  @override
  String get phoneLandlineLabel => 'Phone (Landline)';

  @override
  String get newEmailLabel => 'New Email Address';

  @override
  String get currentPasswordLabel => 'Current Password';

  @override
  String get newPasswordLabel => 'New Password';

  @override
  String get confirmPasswordLabel => 'Confirm Password';

  @override
  String get emailChangedSuccess => 'Email changed successfully';

  @override
  String get reasonLabel2 => 'Reason';

  @override
  String get downloadFailed2 => 'Download failed';

  @override
  String get downloadTooltip => 'Download';

  @override
  String get copyLogs => 'Copy logs';

  @override
  String get deleteLogs => 'Delete logs';

  @override
  String get autoScrollOn => 'Auto-scroll ON';

  @override
  String get autoScrollOff => 'Auto-scroll OFF';

  @override
  String get unknownValue => 'Unknown';

  @override
  String get payment => 'Payment';

  @override
  String get warningType_ermahnung => 'Warning';

  @override
  String get warningType_abmahnung => 'Caution';

  @override
  String get warningType_letzte => 'Final caution';

  @override
  String warningsTotal(int count) {
    return 'Total: $count';
  }

  @override
  String warningsErmahnung(int count) {
    return 'Warning: $count';
  }

  @override
  String warningsAbmahnung(int count) {
    return 'Caution: $count';
  }

  @override
  String warningsLetzte(int count) {
    return 'Final: $count';
  }

  @override
  String get noWarnings => 'No warnings';

  @override
  String get noWarningsDescription => 'You currently have no warnings.';

  @override
  String createdBy(String name) {
    return 'Created by: $name';
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
  String get stufe1_name => 'Personal Data';

  @override
  String get stufe2_name => 'Membership Type';

  @override
  String get stufe3_name => 'Financial Situation';

  @override
  String get stufe4_name => 'Payment Method';

  @override
  String get stufe5_name => 'Membership Start';

  @override
  String get stufe6_name => 'Statutes';

  @override
  String get stufe7_name => 'Privacy Policy';

  @override
  String get stufe8_name => 'Right of Withdrawal';

  @override
  String get memberType_ordentlich => 'Regular Member';

  @override
  String get memberType_foerder => 'Supporting Member';

  @override
  String get memberType_ehren => 'Honorary Member';

  @override
  String get memberDesc_ordentlich =>
      'Active member with voting rights. Participates in the association\'s services (email, cloud, bureaucratic support).';

  @override
  String get memberDesc_foerder =>
      'Supports the association through contributions. Can attend the general assembly with advisory voting rights, without the right to vote or be elected to the board.';

  @override
  String get memberDesc_ehren =>
      'Has the rights of a regular member without the obligation to pay membership fees. Appointed by the general assembly or the board.';

  @override
  String get payMethod_ueberweisung => 'Bank transfer';

  @override
  String get payMethod_dauerauftrag => 'Standing order';

  @override
  String get verifyStatus_geprueft => 'Verified';

  @override
  String get verifyStatus_ausgefuellt => 'Completed';

  @override
  String get verifyStatus_abgelehnt => 'Rejected';

  @override
  String get verifyStatus_offen => 'Open';

  @override
  String get fillRequiredFields => 'Please fill in all required fields.';

  @override
  String get personalDataSaved => 'Personal data saved';

  @override
  String get selectMemberType => 'Please select a membership type.';

  @override
  String get memberTypeSaved => 'Membership type saved';

  @override
  String get selectOption => 'Please select an option.';

  @override
  String get financialSaved => 'Financial situation saved';

  @override
  String get selectPaymentMethod => 'Please select a payment method.';

  @override
  String get paymentDataSaved => 'Payment data saved';

  @override
  String get selectDate => 'Please select a date.';

  @override
  String get membershipStartSaved => 'Membership start saved';

  @override
  String get fileTooLarge => 'File too large (max. 10 MB).';

  @override
  String get leistungsbescheidUploaded =>
      'Benefits certificate uploaded successfully';

  @override
  String get verificationProgress => 'Verification Progress';

  @override
  String get notApplicable => 'Not applicable';

  @override
  String get socialBenefitsExempt =>
      'Payment method not required for social benefit recipients.';

  @override
  String get locked => 'Locked';

  @override
  String completePreviousStep(int step) {
    return 'Please complete step $step first.';
  }

  @override
  String rejectedNote(String note) {
    return 'Rejected: $note';
  }

  @override
  String get waitingForReview => 'Waiting for board review.';

  @override
  String get stepApproved => 'This step has been reviewed and approved.';

  @override
  String get changesViaChat => 'Changes only possible via Live Chat.';

  @override
  String get firstNameRequired => 'First name *';

  @override
  String get lastNameRequired => 'Last name *';

  @override
  String get birthDateLabel => 'Date of birth *';

  @override
  String get streetRequired => 'Street *';

  @override
  String get houseNumberRequired => 'No. *';

  @override
  String get cityRequired => 'City *';

  @override
  String get phoneRequired => 'Phone number *';

  @override
  String get phonePurpose => 'Purpose: Contact when unreachable via the app';

  @override
  String get selectMemberTypePrompt =>
      'Please select your desired membership type:';

  @override
  String get financialExplanation =>
      'To check if you are eligible for a fee reduction, we need the following information. This information will be used exclusively to determine your membership fee.';

  @override
  String get socialBenefitsQuestion =>
      'Are you currently receiving social benefits?';

  @override
  String get optionBuergergeld => 'Yes, citizen\'s allowance (Job Center)';

  @override
  String get optionSozialamt => 'Yes, social benefits (Social Services)';

  @override
  String get optionNoBenefits => 'No, I do not receive social benefits';

  @override
  String get feeExempt => 'Your monthly membership fee is: €0.00/month';

  @override
  String get uploadLeistungsbescheid => 'Upload benefits certificate';

  @override
  String get uploadLeistungsbescheidHint =>
      'Please upload a current benefits certificate within 14 days to confirm the fee exemption.';

  @override
  String get allowedFormatsUpload =>
      'Allowed formats: PDF, JPG, PNG (max. 10 MB)';

  @override
  String get feeRegular => 'Your monthly membership fee is: €25.00/month';

  @override
  String paymentDayReminder(int day) {
    return 'You will be reminded on the ${day}th of each month.';
  }

  @override
  String get membershipStartPrompt =>
      'Choose when your membership should begin.';

  @override
  String get optionAfterVerification => 'After verification completion';

  @override
  String get optionAfterVerificationDesc =>
      'Membership begins from the day of board confirmation.';

  @override
  String get optionRetroFoundation =>
      'Retroactive to founding date (01.08.2025)';

  @override
  String get optionRetroFoundationDesc =>
      'You become a retroactive member from the founding of the association.';

  @override
  String get optionRetroCustom => 'Retroactive to another date';

  @override
  String get optionRetroCustomDesc =>
      'Choose a date between 01.08.2025 and today.';

  @override
  String get selectDateLabel => 'Select date';

  @override
  String get selectDateHint => 'Select date...';

  @override
  String get dateNotBefore => 'Not before 01.08.2025 (founding date)';

  @override
  String get feeExemptRetro =>
      'Fee exempt: €0.00 retroactive.\nOnly the membership date is set retroactively.';

  @override
  String get retroactiveFees => 'Retroactive Fees';

  @override
  String retroFeeCalculation(
      String from, String to, String months, String total) {
    return 'Period: $from – $to\nMonths: $months\nFee: $months × €25.00 = €$total';
  }

  @override
  String get pleaseReadSatzung => 'Please read the association\'s statutes.';

  @override
  String get pleaseReadDatenschutz => 'Please read the privacy policy.';

  @override
  String get pleaseReadWiderruf => 'Please read the right of withdrawal.';

  @override
  String get acceptedAtRegistration => 'Accepted at registration';

  @override
  String get confirmedByBoard => 'Will be confirmed after board review.';

  @override
  String get docSatzung => 'Statutes';

  @override
  String get docDatenschutz => 'Privacy Policy';

  @override
  String get docWiderruf => 'Right of Withdrawal';

  @override
  String acceptedAtRegCount(int count) {
    return 'Accepted at registration ($count/3)';
  }

  @override
  String acceptedOn(String date) {
    return 'Accepted on $date';
  }

  @override
  String get notAccepted => 'Not accepted';

  @override
  String get statusAccepted => 'Accepted';

  @override
  String get nameTooLong => 'Name too long (max 100 characters)';

  @override
  String get emailTooLong => 'Email too long (max 255 characters)';

  @override
  String get legalAcknowledgePrefix => 'I have read the ';

  @override
  String get legalAcknowledgeSuffix => ' and acknowledge it.';

  @override
  String get legalStatutesSuffix =>
      ' of ICD360S e.V. and acknowledge them as binding.';

  @override
  String get legalPleaseReadFirst => '(please read first)';

  @override
  String get statusActive => 'Active';

  @override
  String get statusSuspended => 'Suspended';

  @override
  String get statusNew => 'New';

  @override
  String get statusCancelled => 'Cancelled';

  @override
  String get statusDeleted => 'Deleted';

  @override
  String get roleMitglied => 'Member';

  @override
  String get roleVorsitzer => 'Chairman';

  @override
  String get roleStellvertreter => 'Deputy';

  @override
  String get roleSchatzmeister => 'Treasurer';

  @override
  String get roleSchriftfuehrer => 'Secretary';

  @override
  String get roleBeisitzer => 'Assessor';

  @override
  String get roleKassierer => 'Cashier';

  @override
  String get roleKassenpruefer => 'Auditor';

  @override
  String get roleEhrenamtlich => 'Volunteer';

  @override
  String get roleMitgliedergruender => 'Founding Member';

  @override
  String get roleEhrenmitglied => 'Honorary Member';

  @override
  String get roleFoerdermitglied => 'Supporting Member';

  @override
  String get memberTypeNotSet => 'Not yet set';

  @override
  String get payMethodSepa => 'SEPA Direct Debit';

  @override
  String get labelStatus => 'Status';

  @override
  String get labelMemberNumber => 'Member Number';

  @override
  String get labelRole => 'Role';

  @override
  String get labelMemberType => 'Membership Type';

  @override
  String get labelPaymentMethod => 'Payment Method';

  @override
  String get labelRegisteredOn => 'Registered on';

  @override
  String get labelLastLogin => 'Last Login';

  @override
  String get labelMemberSince => 'Member since';

  @override
  String get neverLoggedIn => 'Never';

  @override
  String get notActivatedYet => 'Not yet activated';

  @override
  String get tabVerification => 'Verification';

  @override
  String get tabWarnings => 'Warnings';

  @override
  String get tabDocuments => 'Documents';

  @override
  String get tabMembership => 'Membership';

  @override
  String get pleaseEnterFirstName => 'Please enter first name';

  @override
  String get pleaseEnterLastName => 'Please enter last name';

  @override
  String get noFileDataReceived => 'No file data received';

  @override
  String get openFile => 'Open';

  @override
  String get noMicrophoneError =>
      'No microphone found. Please connect a microphone and try again.';

  @override
  String get startConversation => 'Start a conversation!';

  @override
  String get staffWillReply => 'A staff member will reply to you soon.';

  @override
  String get inCall => 'In call...';

  @override
  String get registration => 'Registration';

  @override
  String get deactivation => 'Deactivation';

  @override
  String get deactivatedOn => 'Deactivated on';

  @override
  String get accountAutoSuspend =>
      'Accounts that are not verified within 30 days will be automatically suspended.';

  @override
  String get documentsProvidedByBoard => 'Documents are provided by the board.';

  @override
  String get noDocumentsAvailable => 'No documents available';

  @override
  String get noDocumentsDescription =>
      'No documents have been provided for you yet.';

  @override
  String uploadedBy(String name) {
    return 'Uploaded by: $name';
  }

  @override
  String stepsCompleted(int completed, int total) {
    return '$completed/$total steps completed';
  }

  @override
  String dayOfMonth(int day) {
    return '${day}th of the month';
  }

  @override
  String changeField(String field) {
    return 'Change $field';
  }

  @override
  String openDocument(String name) {
    return 'Open $name';
  }

  @override
  String logEntries(int count) {
    return '$count entries';
  }

  @override
  String get noLogs => 'No logs';

  @override
  String get newLoginDetected => 'New login detected';

  @override
  String get errorNoInternet =>
      'No internet connection. Please check your network.';

  @override
  String get errorTimeout =>
      'Server is not responding. Please try again later.';

  @override
  String get errorServer => 'Server error. Please try again later.';

  @override
  String get errorConnection => 'Connection error. Please try again later.';

  @override
  String get errorUnexpected =>
      'An unexpected error occurred. Please try again later.';

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
  String get claudiuWelcomeMorning => 'Good morning';

  @override
  String get claudiuWelcomeDay => 'Hello';

  @override
  String get claudiuWelcomeEvening => 'Good evening';

  @override
  String get claudiuWelcomeNight => 'Good evening';

  @override
  String get claudiuWelcomeVisitor => 'dear visitor';

  @override
  String get claudiuWelcomeAsk => 'How can I help you?';

  @override
  String get claudiuWelcomeBecomeMember => 'I want to become a member';

  @override
  String get claudiuWelcomeLogin => 'I\'m already a member and want to sign in';

  @override
  String get claudiuWelcomeProblem => 'I have a problem with the app';

  @override
  String get claudiuWelcomeEmergency => 'Emergency — call us';

  @override
  String get claudiuWelcomeMascotName => 'Claudiu';

  @override
  String get claudiuWelcomeEmergencyIntro =>
      'Before you call — our office hours:';

  @override
  String get claudiuWelcomeScheduleOffice => 'At the office';

  @override
  String get claudiuWelcomeScheduleField => 'On the field with our clients';

  @override
  String get claudiuWelcomeOutsideHoursNote =>
      'Outside these hours we only handle emergencies. You can also text the same number — we\'ll get back to you.';

  @override
  String get claudiuWelcomeCallNow => 'Call us now';

  @override
  String get claudiuWelcomeSendSms => 'Send SMS';

  @override
  String get claudiuWelcomeSmsBody =>
      'Emergency at ICD360S e.V. — please contact me as soon as possible.';

  @override
  String get claudiuWelcomeCloseButton => 'Close';

  @override
  String get claudiuLoginWelcome => 'Welcome back, dear member!';

  @override
  String get claudiuLoginAsk => 'Please tell me your member number.';

  @override
  String get claudiuLoginProgress => 'Getting closer… keep typing.';

  @override
  String get claudiuLoginReady => 'Perfect! Tap the button below.';

  @override
  String get claudiuLoginLoading => 'I\'m verifying your identity… 🔍';

  @override
  String get claudiuLoginFoundPlain => 'Found you! Signing you in…';

  @override
  String claudiuLoginFoundNamed(String name) {
    return 'Found you, $name! Signing you in…';
  }

  @override
  String get claudiuLoginError =>
      'Hm, I can\'t find that number. Did you type it correctly?';

  @override
  String get claudiuLoginForgotHeader => 'Forgot your member number?';

  @override
  String get claudiuLoginNoSms => 'We don\'t send the number by email or SMS.';

  @override
  String get claudiuLoginOnlyWay =>
      'The only way: meet us in person at the association office, after ID verification.';

  @override
  String get claudiuLoginContactUs => 'Call us to book an appointment:';

  @override
  String get claudiuDiagnosticGreeting =>
      'Before you go in, one quick question';

  @override
  String get claudiuDiagnosticAsk =>
      'May I send anonymous reports so the developers can improve the app?';

  @override
  String get claudiuDiagnosticYes => 'Yes, I\'d like to help';

  @override
  String get claudiuDiagnosticNo => 'No, I\'m just exploring';

  @override
  String get claudiuDiagnosticTellMore => 'Tell me more';

  @override
  String get claudiuDiagnosticSendsHeader => '📤 What we SEND (anonymous):';

  @override
  String get claudiuDiagnosticSends1 =>
      'An anonymous device code (NOT your member number)';

  @override
  String get claudiuDiagnosticSends2 => 'Your role (member / board)';

  @override
  String get claudiuDiagnosticSends3 =>
      'Operating system (Linux / Android / iOS / Windows)';

  @override
  String get claudiuDiagnosticSends4 => 'Selected language';

  @override
  String get claudiuDiagnosticSends5 => 'Battery level + state';

  @override
  String get claudiuDiagnosticSends6 => 'Current screen';

  @override
  String get claudiuDiagnosticSends7 => 'Session duration (seconds)';

  @override
  String get claudiuDiagnosticSends8 => 'Errors if any (last 10)';

  @override
  String get claudiuDiagnosticSends9 => 'Navigation (last 20 screens)';

  @override
  String get claudiuDiagnosticNeverHeader => '🛡️ What we NEVER send:';

  @override
  String get claudiuDiagnosticNever1 => 'Your real name';

  @override
  String get claudiuDiagnosticNever2 => 'Email address';

  @override
  String get claudiuDiagnosticNever3 => 'Phone number';

  @override
  String get claudiuDiagnosticNever4 => 'Password';

  @override
  String get claudiuDiagnosticNever5 => 'Chat message contents';

  @override
  String get claudiuDiagnosticNever6 => 'Ticket contents';

  @override
  String get claudiuDiagnosticNever7 => 'Documents or attachments';

  @override
  String get claudiuDiagnosticTechHeader => '📡 Technical details:';

  @override
  String get claudiuDiagnosticTech1 => 'Sent every 2 minutes';

  @override
  String get claudiuDiagnosticTech2 =>
      'TLS-encrypted connection, pinned certificate';

  @override
  String get claudiuDiagnosticTech3 =>
      'You can turn it off any time in Settings';

  @override
  String get claudiuProblemHelpTitle => 'How can I help?';

  @override
  String get claudiuProblemHelpGreeting => 'What happened?';

  @override
  String get claudiuProblemHelpAsk => 'How would you like to tell me?';

  @override
  String get claudiuProblemHelpWriteTitle => 'Write a report';

  @override
  String get claudiuProblemHelpWriteBody =>
      'With step-by-step details. The team gets the text and resolves it later.';

  @override
  String get claudiuProblemHelpChatTitle => 'Let\'s talk now';

  @override
  String get claudiuProblemHelpChatBody =>
      'Anonymous chat with an operator. Realtime reply if someone is online.';

  @override
  String get claudiuProblemHelpAltCallHeader => 'Or, if it\'s urgent:';

  @override
  String get claudiuProblemHelpAltCallLabel => 'Call us';

  @override
  String get claudiuAnonymousChatTitle => 'Anonymous chat';

  @override
  String get claudiuAnonymousChatGreeting => 'Hi!';

  @override
  String get claudiuAnonymousChatWelcome =>
      'I\'m listening. Write anything you\'d like — no name needed. I\'ll reply as soon as I\'m in.';

  @override
  String get claudiuAnonymousChatHint => 'Write a message…';

  @override
  String get claudiuAnonymousChatWaitingOperator =>
      'Waiting for an operator to reply…';

  @override
  String get claudiuVorsitzerConnectedTitle => 'Hi!';

  @override
  String get claudiuVorsitzerConnectedBody =>
      'Thanks for reaching out — you\'re now connected with a Vorsitzer. Tell us how we can help with your membership application.';

  @override
  String get claudiuVorsitzerConnectedSender => 'Vorsitzer';

  @override
  String get claudiuQuickReplyValidationTime =>
      'How long does validation take?';

  @override
  String get claudiuQuickReplyDocuments => 'Which documents do I need?';

  @override
  String get claudiuQuickReplyStepProblem => 'I\'m stuck on a step';

  @override
  String get claudiuQuickReplyHuman => 'Can I talk to someone now?';

  @override
  String get claudiuAnonymousChatConnecting => 'Connecting…';

  @override
  String get claudiuAnonymousChatConnectionFailed =>
      'Couldn\'t open the chat. Try again or call us.';

  @override
  String get claudiuAnonymousChatRetry => 'Try again';

  @override
  String get claudiuAnonymousChatOnline => 'Connected';

  @override
  String get claudiuAnonymousChatOffline => 'Reconnecting…';

  @override
  String get claudiuAnonymousChatAdminTyping => 'Operator is typing…';

  @override
  String get claudiuProblemReportTitle => 'Report a problem';

  @override
  String get claudiuProblemReportGreeting => 'What happened?';

  @override
  String get claudiuProblemReportAsk =>
      'Tell me in detail and I\'ll forward the report to the team.';

  @override
  String get claudiuProblemReportIncludeHeader => 'Please include:';

  @override
  String get claudiuProblemReportIncludeBullets1 =>
      'What you were doing when the problem appeared';

  @override
  String get claudiuProblemReportIncludeBullets2 => 'Any error message you saw';

  @override
  String get claudiuProblemReportIncludeBullets3 => 'Which screen you were on';

  @override
  String get claudiuProblemReportIncludeBullets4 =>
      'Does the app crash, close, or show a blank screen?';

  @override
  String get claudiuProblemReportIncludeBullets5 =>
      'Does it happen every time or just once?';

  @override
  String get claudiuProblemReportDescriptionLabel => 'Your description';

  @override
  String get claudiuProblemReportDescriptionHint =>
      'E.g.: When I open the chat screen I get a \'Connection error\' message and the app stops responding…';

  @override
  String claudiuProblemReportTooShort(int count) {
    return 'A bit more detail, please (at least $count characters)';
  }

  @override
  String get claudiuProblemReportSubmit => 'Send report';

  @override
  String get claudiuProblemReportSubmitting => 'Sending…';

  @override
  String get claudiuProblemReportSentTitle => 'Thank you!';

  @override
  String get claudiuProblemReportSentBody =>
      'The report has been sent. Our team will look into it as soon as possible.';

  @override
  String get claudiuProblemReportSentClose => 'Got it';

  @override
  String get claudiuProblemReportSendFailed =>
      'Couldn\'t send the report. Please call us for urgent help.';

  @override
  String get claudiuProblemReportAlt => 'Or, if it\'s urgent:';

  @override
  String get claudiuProblemReportCallLabel => 'Call us';

  @override
  String claudiuApprovalGreeting(String name) {
    return 'Hi, $name! 👋';
  }

  @override
  String get claudiuApprovalGreetingNoName => 'Hi! 👋';

  @override
  String get claudiuApprovalGladToSeeYou => 'I\'m glad you\'re here!';

  @override
  String get claudiuApprovalCheckingForSafety =>
      'For your safety, a Vorsitzer is now checking your login request. 🛡️';

  @override
  String get claudiuApprovalMonthlyExplain =>
      '💡 We do this every 30 days to make sure it\'s really you. Think of it as a security check-up — takes 5 minutes max.';

  @override
  String get claudiuApprovalSuccess =>
      'Done! 🎉 The Vorsitzer recognized you. Signing you in…';

  @override
  String get claudiuApprovalDenied =>
      'Hm, the Vorsitzer declined your request. 😔';

  @override
  String get claudiuApprovalDeniedHelp =>
      'If you think this is a mistake, please call us so we can sort it out.';

  @override
  String get claudiuApprovalExpired =>
      'The 5 minutes passed and we didn\'t hear back from the Vorsitzer.';

  @override
  String get claudiuApprovalExpiredHelp =>
      'Call us and we can approve your request directly on the spot. 📞';

  @override
  String get claudiuApprovalCallUs => 'Call us';

  @override
  String get claudiuApprovalTryAgain => 'Try again';

  @override
  String get claudiuApprovalCancel => 'Cancel';

  @override
  String get claudiuApprovalClose => 'Close';

  @override
  String get wizardIntroBubble1 =>
      'Hi, visitor! 👋 Thank you for wanting to join our family.';

  @override
  String get wizardIntroBubble2 =>
      'My name is Claudiu. In spring 2025 I had a clear vision: to create an association that helps people in need — voluntarily, from the heart, without bureaucratic clutter. ❤️';

  @override
  String get wizardIntroBubble3 =>
      'I started talking to the clients I visited. I told them my dream. And each one said: \"Yes, let\'s go!\" In July 2025 the six of us met — determined people. We decided to found **ICD360S e.V.** in Neu-Ulm. 📍';

  @override
  String get wizardIntroBubble4 =>
      'On **August 1, 2025**, the association officially came to life — in the Association Register. The most beautiful gift of all. 🎂';

  @override
  String get wizardIntroBubble5 =>
      'What do we do? We help refugees, people with disabilities, the economically disadvantaged, **children and young people** — with administrative matters, German lessons, housing, shopping, social benefits. Our Vorstand is made up mostly of people with disabilities — that way decisions come from real lived experience. 🤝';

  @override
  String get wizardIntroBubble6 =>
      'Now it\'s your turn. Let\'s enrol you — takes about 5 minutes. We\'ll go step by step, I\'m not leaving you alone. ✨';

  @override
  String get wizardIntroStart => 'Let\'s start';

  @override
  String get wizardBack => 'Back';

  @override
  String get wizardNext => 'Next';

  @override
  String wizardStepLabel(int step, int total, String title) {
    return 'Step $step of $total · $title';
  }

  @override
  String get wizardErrRequired => 'This field is required';

  @override
  String wizardErrTooShort(int count) {
    return 'Too short (at least $count characters)';
  }

  @override
  String get wizardErrOnlyLetters =>
      'Only letters, spaces, hyphens and apostrophes';

  @override
  String get wizardErrSaveFailed =>
      'Couldn\'t save. Check your connection and try again.';

  @override
  String get wizardStufe1aTitle => 'Identity';

  @override
  String get wizardStufe1aPrompt =>
      'Let\'s get to know you officially. Please write your name exactly as it appears on your Personalausweis, Reisepass or Aufenthaltstitel — so it stays consistent with your documents.';

  @override
  String get wizardStufe1aVornameLabel => 'Vornamen (first names)';

  @override
  String get wizardStufe1aVornameHelper =>
      'All your first names, exactly as on your ID. Use space or hyphen (e.g. Hans-Peter, Maria Anna, José María).';

  @override
  String get wizardStufe1aNachnameLabel => 'Familienname (family name)';

  @override
  String get wizardStufe1aNachnameHelper => 'Your current family name.';

  @override
  String get wizardStufe1aGeburtsnameLabel =>
      'Geburtsname (birth name) — optional';

  @override
  String get wizardStufe1aGeburtsnameHelper =>
      'Only if it differs from Familienname — e.g. before marriage.';

  @override
  String get wizardStufe1bTitle => 'Birthday';

  @override
  String get wizardStufe1bPrompt =>
      'We\'d love to celebrate your birthday with you! 🎂 It also helps us confirm you\'re at least 16 — that\'s what our Satzung says.';

  @override
  String get wizardStufe1bGeburtsdatumLabel => 'Date of birth';

  @override
  String get wizardStufe1bGeburtsdatumHelper => 'Tap to pick a date';

  @override
  String get wizardStufe1bGeburtsortLabel => 'Place of birth';

  @override
  String get wizardStufe1bGeburtsortHelper =>
      'City / town where you were born.';

  @override
  String get wizardAgeGatePrompt => 'I\'m sorry… 😔';

  @override
  String wizardAgeGateBody1(int age, int years) {
    return 'Our Satzung says you must be at least 16 to become a member. You\'re $age — I hope we see you again in $years years! 🌱';
  }

  @override
  String get wizardAgeGateBody2 =>
      'If you want to volunteer occasionally (any age, with your parents\' consent), give us a call — we love supporting young people who want to change the world.';

  @override
  String get wizardAgeGateBackHome => 'Back to welcome';

  @override
  String get wizardErrInvalidPhone => 'Invalid phone number';

  @override
  String get wizardStufe1b1Title => 'Parental consent';

  @override
  String get wizardStufe1b1Prompt =>
      'You\'re a minor (16-17) — per §106 BGB we need a parent or legal guardian\'s consent. Tell me their name and phone number. A Vorsitzer will call them and arrange a meeting (in person or video call). No email — we want to be sure we\'re speaking to the real person.';

  @override
  String get wizardStufe1b1VornameLabel => 'Parent first name';

  @override
  String get wizardStufe1b1VornameHelper =>
      'As shown on the parent\'s Personalausweis.';

  @override
  String get wizardStufe1b1NachnameLabel => 'Parent family name';

  @override
  String get wizardStufe1b1NachnameHelper =>
      'As shown on the parent\'s Personalausweis.';

  @override
  String get wizardStufe1b1TelefonLabel => 'Parent mobile number';

  @override
  String get wizardStufe1b1TelefonHelper =>
      'A Vorsitzer will call this number.';

  @override
  String get wizardStufe1b1RelationLabel => 'Relationship to the child:';

  @override
  String get wizardStufe1b1RelationMutter => 'Mother';

  @override
  String get wizardStufe1b1RelationVater => 'Father';

  @override
  String get wizardStufe1b1RelationSorgeberechtigter => 'Legal guardian';

  @override
  String get wizardStufe1b1RelationAndere => 'Other guardian';

  @override
  String get wizardStufe1cTitle => 'Personal details';

  @override
  String get wizardStufe1cPrompt =>
      'Just so I get to know you a bit better. This stays between us and isn\'t shown anywhere publicly.';

  @override
  String get wizardStufe1cGeschlechtLabel => 'Gender';

  @override
  String get wizardStufe1cGeschlechtMaennlich => 'Male';

  @override
  String get wizardStufe1cGeschlechtWeiblich => 'Female';

  @override
  String get wizardStufe1cGeschlechtDivers => 'Diverse';

  @override
  String get wizardStufe1cGeschlechtKeineAngabe => 'Prefer not to say';

  @override
  String get wizardStufe1cFamilienstandLabel => 'Marital status';

  @override
  String get wizardStufe1cFamilienstandLedig => 'Single';

  @override
  String get wizardStufe1cFamilienstandVerheiratet => 'Married';

  @override
  String get wizardStufe1cFamilienstandGeschieden => 'Divorced';

  @override
  String get wizardStufe1cFamilienstandVerwitwet => 'Widowed';

  @override
  String get wizardStufe1dTitle => 'Your background';

  @override
  String get wizardStufe1dPrompt =>
      'This helps us offer you the right kind of support — for example Aufenthalt advice or finding your language community.';

  @override
  String get wizardStufe1dStaatLabel => 'Citizenship';

  @override
  String get wizardStufe1dStaatHelper =>
      'E.g. deutsch, rumänisch, ukrainisch. Multiple comma-separated.';

  @override
  String get wizardStufe1dAufenthaltLabel =>
      'Residence status (Aufenthaltsstatus) — optional';

  @override
  String get wizardStufe1dAufenthaltHelper =>
      'Pick the title from your Aufenthaltskarte / decision letter. The Vorstand cross-checks against your documents.';

  @override
  String get wizardStufe1dAufenthaltAwaitingCitizenship =>
      'Fill in citizenship above first — we\'ll show only the options that apply.';

  @override
  String get wizardStufe1dAufenthaltGerman =>
      'No residence title needed — German citizen.';

  @override
  String get wizardStufe1dAufenthaltEuEea =>
      'EU/EEA/CH citizen — freedom of movement (Freizügigkeit).';

  @override
  String get wizardStufe1dAufenthaltTempHint => 'temporary';

  @override
  String get wizardStufe1dAufenthaltPermHint => 'permanent settlement';

  @override
  String get wizardStufe1dAufenthaltAsylumProcessHint => 'asylum procedure';

  @override
  String get wizardStufe1dAufenthaltOther => 'Other (please specify in chat)';

  @override
  String get wizardStufe1dAufenthaltRequired =>
      'Please pick a residence title.';

  @override
  String get wizardStufe1dMutterspracheLabel => 'Mother tongue';

  @override
  String get wizardStufe1dMutterspracheHelper =>
      'Pre-filled with the app language — change if different.';

  @override
  String get wizardStufe1eTitle => 'Address';

  @override
  String get wizardStufe1ePrompt =>
      'Your postal address — we use it for official documents (Satzung, member contracts, notices).';

  @override
  String get wizardStufe1eStrasseLabel => 'Street';

  @override
  String get wizardStufe1eStrasseHelper =>
      'Just the street name — the number goes in the field next to it.';

  @override
  String get wizardStufe1eHausnummerLabel => 'No.';

  @override
  String get wizardStufe1ePlzLabel => 'PLZ (postal code)';

  @override
  String get wizardStufe1eOrtLabel => 'City';

  @override
  String get wizardStufe1eLandLabel => 'Country';

  @override
  String get wizardStufe1eLandHelper => 'Pre-filled with Deutschland.';

  @override
  String get wizardErrInvalidStreet => 'Invalid street name';

  @override
  String get wizardErrInvalidHausnummer =>
      'Invalid number (e.g. 12, 12a, 12/3)';

  @override
  String get wizardErrInvalidPlz => 'Invalid postal code (digits only)';

  @override
  String get wizardStufe1fTitle => 'Contact';

  @override
  String get wizardStufe1fPrompt =>
      'How can we reach you? The phone is just for emergencies — everything else goes through our end-to-end encrypted in-app channel. Your member email is assigned automatically and shown below.';

  @override
  String get wizardStufe1fTelefonLabel => 'Mobile number';

  @override
  String get wizardStufe1fTelefonHelper =>
      'Promise, I won\'t call unless it\'s important. 📱';

  @override
  String get wizardStufe2Title => 'Membership type';

  @override
  String get wizardStufe2Prompt =>
      'What kind of member do you want to be? Let me explain each option.';

  @override
  String get wizardStufe2OrdentlichTitle => 'Regular member (ordentlich)';

  @override
  String get wizardStufe2OrdentlichBody =>
      'Full rights. You pay the monthly fee, vote in the Mitgliederversammlung, can be elected to the Vorstand. The default choice.';

  @override
  String get wizardStufe2FoerderTitle => 'Supporting member (Fördermitglied)';

  @override
  String get wizardStufe2FoerderBody =>
      'You support the association financially but don\'t take part in decisions. No voting right. Good if you want to help from a distance.';

  @override
  String get wizardStufe2EhrenTitle => 'Honorary member (Ehrenmitglied)';

  @override
  String get wizardStufe2EhrenBody =>
      'Awarded by the Vorstand for special merit. You don\'t pick this yourself — it\'s granted as recognition. Only choose if you\'ve already been honoured.';

  @override
  String get wizardStufe3Title => 'Financial situation';

  @override
  String get wizardStufe3Prompt =>
      'Now about your financial situation. Not to judge you — just so we can waive the fee if you receive social benefits.';

  @override
  String get wizardStufe3OptionBuergergeld => 'I receive Bürgergeld';

  @override
  String get wizardStufe3OptionSozialamt => 'I receive Sozialamt benefits';

  @override
  String get wizardStufe3OptionNein => 'I don\'t receive any of these';

  @override
  String get wizardStufe3FeeExemptTitle => 'Fee: € 0 / month 🎉';

  @override
  String get wizardStufe3FeeExemptBody =>
      'With Bürgergeld, Sozialamt, ALG I or Krankengeld you\'re fully exempt under Satzung §6. We just need a proof document (Leistungsbescheid or Bescheinigung from the authority / health insurance).';

  @override
  String get wizardStufe3UploadTitle => 'Upload Leistungsbescheid';

  @override
  String get wizardStufe3UploadHint => 'PDF / JPG / PNG, max 10 MB.';

  @override
  String get wizardStufe3UploadRequired =>
      'Please upload the Leistungsbescheid before continuing.';

  @override
  String get wizardStufe3FileTooLarge => 'File too large. Maximum 10 MB.';

  @override
  String get wizardStufe3UploadFailed =>
      'Couldn\'t upload the file. Please try again.';

  @override
  String get wizardStufe3RegularFeeTitle => 'Fee: € 25 / month';

  @override
  String get wizardStufe3RegularFeeBody =>
      'The standard fee for regular members under our Satzung.';

  @override
  String get wizardStufe4Title => 'Payment';

  @override
  String get wizardStufe4Prompt =>
      'How would you like to pay the membership fee? And which day of the month should it be due?';

  @override
  String get wizardStufe4MethodUeberweisungTitle =>
      'Bank transfer (Überweisung)';

  @override
  String get wizardStufe4MethodUeberweisungBody =>
      'You start the payment yourself each month from your account.';

  @override
  String get wizardStufe4MethodSepaTitle => 'SEPA-Lastschrift (direct debit)';

  @override
  String get wizardStufe4MethodSepaBody =>
      'We pull the amount automatically from your account. Most convenient, but we\'ll need your IBAN and a signed mandate.';

  @override
  String get wizardStufe4MethodDauerauftragTitle =>
      'Dauerauftrag (standing order)';

  @override
  String get wizardStufe4MethodDauerauftragBody =>
      'You set up a standing order at your bank. Your bank then transfers the amount automatically each month.';

  @override
  String get wizardStufe4DayLabel => 'Payment day';

  @override
  String get wizardStufe4DayHint => 'Pick a day between 1 and 31';

  @override
  String wizardStufe4DayItem(int day) {
    return 'Day $day';
  }

  @override
  String wizardStufe4DayReminder(int day) {
    return 'The fee will be due on day $day of every month.';
  }

  @override
  String get wizardStufe5Title => 'Start date';

  @override
  String get wizardStufe5Prompt =>
      'When do you want your ICD360S membership to officially start? From approval onwards, or backdated.';

  @override
  String get wizardStufe5OptionAbVerifizierungTitle =>
      'From the Vorstand approval';

  @override
  String get wizardStufe5OptionAbVerifizierungBody =>
      'The simplest choice. No backdated fee.';

  @override
  String get wizardStufe5OptionGruendungsdatumTitle =>
      'Backdated to 01.08.2025 (founding date)';

  @override
  String get wizardStufe5OptionGruendungsdatumBody =>
      'You\'ll count as a member from the very first day.';

  @override
  String get wizardStufe5OptionAnderesDatumTitle => 'A different date';

  @override
  String get wizardStufe5OptionAnderesDatumBody =>
      'You pick any date between 01.08.2025 and today.';

  @override
  String get wizardStufe5PickDate => 'Tap to pick a date';

  @override
  String get wizardStufe5PickDateFirst => 'Please pick a date first.';

  @override
  String get wizardStufe5DatePickerHelp => 'Membership start date';

  @override
  String wizardStufe5DateRange(String start) {
    return 'Between $start and today';
  }

  @override
  String get wizardStufe5RetroactiveTitle => 'Retroactive fee';

  @override
  String wizardStufe5RetroactiveBody(
      String start, String end, int months, String amount) {
    return 'From $start to $end is $months months. At €25/month that\'s €$amount due retroactively, on top of the current monthly fee.';
  }

  @override
  String get wizardStufe5FeeExemptTitle => 'Retroactive fee: € 0 🎉';

  @override
  String get wizardStufe5FeeExemptBody =>
      'With Bürgergeld or Sozialamt you\'re fully exempt — even retroactively nothing is owed.';

  @override
  String wizardDocumentPrompt(String doc) {
    return 'Before we wrap up, please read the $doc carefully. It\'s important you know what you\'re signing.';
  }

  @override
  String get wizardDocumentScrollHint => 'Scroll to the bottom to continue.';

  @override
  String get wizardDocumentScrolledOk => 'You\'ve read to the end ✓';

  @override
  String wizardDocumentOpenButton(String doc) {
    return 'Open $doc in browser';
  }

  @override
  String get wizardDocumentExternalHint =>
      'On this platform we open the document in your default browser.';

  @override
  String get wizardDocumentOpenedOk =>
      'The document was opened. Please read it carefully.';

  @override
  String wizardDocumentConfirm(String doc) {
    return 'I confirm that I\'ve read and agree to the $doc.';
  }

  @override
  String get wizardFinalAdultTitle => 'All set! You\'re enrolled 🎉';

  @override
  String get wizardFinalMinorTitle => 'Your request has been sent 📨';

  @override
  String get wizardFinalMinorBody =>
      'We\'ll contact your parent and arrange a meeting (in person or video call). Please be patient — the process can take up to 7 days. You\'ll get an in-app notification as soon as your parent approves.';

  @override
  String get wizardFinalMitgliedernummerLabel => 'Your member number';

  @override
  String get wizardStufe4MethodComingSoon => 'Coming soon';

  @override
  String get wizardStufe4StreichungWarning =>
      'If you fall more than 6 months behind on dues, we\'ll automatically strike you off (Satzung §6 Abs. 3).';

  @override
  String get wizardStufe5KuendigungInfo =>
      'To leave: send us your cancellation in writing 3 months before December 31 (by September 30 to take effect at year-end). No minimum membership duration (Satzung §6 Abs. 3).';

  @override
  String get wizardStufe1fEmailLabel => 'Your member email';

  @override
  String get wizardStufe1fEmailHelper =>
      'Assigned automatically from your member number. Activated once the Vorstand validates your application. We have our own dedicated email app — send and receive encrypted emails, simple and free.';

  @override
  String get wizardErrInvalidEmail => 'Invalid email address';

  @override
  String get wizardStufe3OptionAlg1 =>
      'I receive Arbeitslosengeld I (ALG I, unemployment benefit)';

  @override
  String get wizardStufe3OptionKrankengeld =>
      'I receive Krankengeld (long-term sick pay)';

  @override
  String get wizardStufe3UploadAddMore => 'Add another document';

  @override
  String get wizardStufe3UploadLimitCount =>
      'Limit reached: up to 20 documents.';

  @override
  String get wizardStufe3UploadLimitTotal =>
      '100 MB total limit reached. Delete an existing file first.';

  @override
  String get wizardStufe3UploadDeleteTooltip => 'Delete';

  @override
  String wizardStufe3UploadCounter(int count, int max) {
    return '$count / $max documents';
  }

  @override
  String get wizardDocumentExternalOpenFailed =>
      'Couldn\'t open your browser. The link is on your clipboard — paste it in a browser to continue.';

  @override
  String get wizardFinalTimelineProcessing =>
      'Vorstand reviewing · usually 1 business day, up to 7';

  @override
  String get wizardFinalTimelineActivated => 'Account activated';

  @override
  String get wizardFinalAdultThank =>
      'Thank you for completing the registration form! 🎉';

  @override
  String get wizardFinalAdultUsual =>
      'Your application is with us now. We usually validate it within one business day.';

  @override
  String get wizardFinalAdultExceptional =>
      'Sometimes it takes up to 7 business days. And if anything doesn\'t add up, we\'ll send you back to the form so you can fix it 🙂';

  @override
  String get wizardFinalStatusTitle => 'APPLICATION STATUS';

  @override
  String wizardFinalStatusStepsValidated(int reviewed, int total) {
    return '$reviewed/$total steps validated by the Vorstand';
  }

  @override
  String get wizardFinalStufeSheetTitle => 'Application details';

  @override
  String get wizardFinalStufeSheetHint =>
      'The 8 stages you filled in. The Vorstand reviews them one by one — you see in real time which ones have been validated.';

  @override
  String get wizardFinalStufeStatusPending => 'Awaiting review';

  @override
  String get wizardFinalStufeStatusApproved => 'Approved';

  @override
  String get wizardFinalStufeStatusRejected => 'Rejected';

  @override
  String wizardFinalStatusRejectionCount(int count) {
    return '$count step needs correction';
  }

  @override
  String get wizardFinalStufeRejectionReason => 'Vorstand\'s reason:';

  @override
  String get wizardFinalStufeCorrectNow => 'Fix now';

  @override
  String wizardFinalApprovalsHeader(int current, int total) {
    return 'Vorstand approvals ($current/$total)';
  }

  @override
  String get wizardFinalApprovalAwaiting => 'Awaiting 2nd Vorstand';

  @override
  String get wizardFinalApprovalRejected => 'REJECTED';

  @override
  String get wizardFinalStufeNoDataYet => 'Data not available yet.';

  @override
  String get wizardFinalStufeReadAt => 'Read on:';

  @override
  String get wizardFinalStufeBeitragsfrei => 'Fee-exempt (no payment required)';

  @override
  String get wizardFinalStufeNotExempt => 'Not on social benefits';

  @override
  String get wizardFinalStufeBeginAtVerification => 'Starts on validation';

  @override
  String get wizardFinalStufeBeginAtFoundation => 'Founding date (retroactive)';

  @override
  String get wizardFinalStufeBeginAtCustom => 'Custom date';

  @override
  String get wizardFinalStufeStatusSkipped => 'Skipped';

  @override
  String get wizardFinalStufeFilledAt => 'Filled in:';

  @override
  String get wizardFinalStufeReviewedAt => 'Reviewed:';

  @override
  String get wizardFinalWithdrawLink => 'Withdraw application';

  @override
  String get wizardFinalWithdrawDialogTitle => 'Withdraw your application?';

  @override
  String get wizardFinalWithdrawDialogBody =>
      'Your application will be marked as withdrawn-by-you. The data stays in the database for audit (GDPR), but the account won\'t be activated. You can restart the registration any time with a new member number.';

  @override
  String get wizardFinalWithdrawKeep => 'No, I\'ll wait';

  @override
  String get wizardFinalWithdrawConfirm => 'Yes, withdraw';

  @override
  String get wizardErrTooManyWithdrawals =>
      'Your application can\'t be processed automatically. Please give us a call or come in person to the Vorstand to continue your registration.';

  @override
  String get wizardDuplicateLoginTitle => 'Looks like you\'re already a member';

  @override
  String get wizardDuplicateLoginBody =>
      'We already find an active account under your name and date of birth. Please tap \'I\'m already a member\' on the welcome screen to log in. If you can\'t access it any more, give us a call.';

  @override
  String get wizardDuplicatePendingTitle =>
      'Your application is already with us';

  @override
  String get wizardDuplicatePendingBody =>
      'We already have an application in review under your name and date of birth. The Vorstand is working on it — we\'ll notify you in the app the moment your account goes active. Call us if you want to talk it through.';

  @override
  String get wizardDuplicateRecentlyWithdrawnTitle =>
      'We can\'t process this application now';

  @override
  String get wizardDuplicateRecentlyWithdrawnBody =>
      'Your name and date of birth match a recently withdrawn application. Please give us a call so you can speak with the Vorstand before going further.';

  @override
  String get wizardDuplicatePreviouslyWithdrawnTitle =>
      'You\'ve applied before';

  @override
  String get wizardDuplicatePreviouslyWithdrawnBody =>
      'Your name and date of birth match an older application you\'d withdrawn. Welcome back — please give us a call before continuing so the Vorstand can decide how to proceed.';

  @override
  String get wizardDuplicateCallUsTitle => 'Please give us a call';

  @override
  String get wizardDuplicateCallUsBody =>
      'Your name and date of birth already appear in our records, but we can\'t share the details through the app. Please give us a call — the Vorstand will explain the situation directly.';

  @override
  String get wizardChatHelp => 'Let\'s talk';

  @override
  String get wizardChatHelpSubtitle =>
      'Live chat with the Vorstand · quick reply';
}
