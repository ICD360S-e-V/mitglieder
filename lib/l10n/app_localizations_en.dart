// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'ICD360S e.V - Member Portal';

  @override
  String get memberPortal => 'Member Portal';

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
  String get password => 'Password';

  @override
  String get passwordHint => 'Please enter password';

  @override
  String get confirmPassword => 'Confirm Password';

  @override
  String get confirmPasswordHint => 'Please confirm password';

  @override
  String get newPassword => 'New Password';

  @override
  String get newPasswordHint => 'Please enter new password';

  @override
  String get saveCredentials => 'Save login data';

  @override
  String get autoLogin => 'Login automatically';

  @override
  String get forgotPassword => 'Forgot password?';

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
  String get recoveryCode => 'Recovery Code (6 digits)';

  @override
  String get recoveryCodeHelper => 'Remember this code for password recovery';

  @override
  String get recoveryCodeHint => 'Please enter recovery code';

  @override
  String get recoveryCodeInvalid => 'Code must be exactly 6 digits';

  @override
  String get loginFailed => 'Login failed';

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
  String get tooManyDevices => 'Too many devices';

  @override
  String get maxDevicesMessage =>
      'You are already logged in on 3 devices.\nSelect a device to log out:';

  @override
  String get unknownDevice => 'Unknown device';

  @override
  String get unknown => 'Unknown';

  @override
  String get logoutError => 'Logout error';

  @override
  String error(String error) {
    return 'Error: $error';
  }

  @override
  String get cancel => 'Cancel';

  @override
  String get resetPassword => 'Reset Password';

  @override
  String get forgotPasswordTitle => 'Forgot Password';

  @override
  String get forgotPasswordDescription =>
      'Enter your member number and the recovery code you created during registration.';

  @override
  String get passwordResetSuccess =>
      'Password successfully reset!\n\nYou can now log in with your new password.';

  @override
  String get passwordResetFailed => 'Password reset failed';

  @override
  String get needHelp => 'Need help?';

  @override
  String get helpQuestion => 'Having problems with login or registration?';

  @override
  String get helpDescription =>
      'Contact us via WhatsApp and describe exactly what is not working. We will respond as soon as possible!';

  @override
  String get whatsapp => 'WhatsApp';

  @override
  String get emailSubject => 'Inquiry via ICD360S App';

  @override
  String get whatsappMessage =>
      'Hello, I have a problem with the ICD360S App. ';

  @override
  String get imprint => 'Imprint';

  @override
  String get privacy => 'Privacy Policy';

  @override
  String get statutes => 'Statutes';

  @override
  String get revocation => 'Right of Withdrawal';

  @override
  String get cancellation => 'Cancellation';

  @override
  String get allRightsReserved => 'All rights reserved.';

  @override
  String get enterCredentials => 'Please enter member number and password';

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
  String get membership => 'Membership';

  @override
  String get myAppointments => 'My Appointments';

  @override
  String get appointmentsLoadingReady => 'Loading appointments - API is ready!';

  @override
  String get priority => 'Priority';

  @override
  String get messageLabel => 'Message';

  @override
  String get createdOn => 'Created';

  @override
  String get handler => 'Handler';

  @override
  String get reportProblems => 'Report Problems';

  @override
  String get reportProblem => 'Report Problem';

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
  String get newTicket => 'New Ticket';

  @override
  String get noOpenTickets => 'No open tickets';

  @override
  String get haveQuestionCreateTicket =>
      'Have a question or problem?\nCreate a new ticket.';

  @override
  String get whatIsTheProblem => 'What is the problem?';

  @override
  String get describeTheProblem => 'Describe the problem';

  @override
  String get howUrgentIsIt => 'How urgent is it?';

  @override
  String get low => 'Low';

  @override
  String get medium => 'Medium';

  @override
  String get high => 'High';

  @override
  String get submit => 'Submit';

  @override
  String get fillSubjectAndMessage => 'Please fill in subject and message';

  @override
  String get ticketCreated => 'Ticket has been created';

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
  String get newEmailAddress => 'New Email Address';

  @override
  String get currentPassword => 'Current Password';

  @override
  String get saveEmail => 'Save Email';

  @override
  String get savePassword => 'Save Password';

  @override
  String get deviceLoggedOut => 'Device logged out';

  @override
  String get passwordChangedSuccessfully => 'Password changed successfully';

  @override
  String get emailChangedSuccessfully => 'Email changed successfully';

  @override
  String get errorChangingPassword => 'Error changing password';

  @override
  String get errorChangingEmail => 'Error changing email';

  @override
  String get validEmailRequired => 'Please enter a valid email address';

  @override
  String get passwordTooShort => 'Password must be at least 6 characters long';

  @override
  String get maxDevicesReached =>
      'You are logged in on the maximum of 3 devices.';

  @override
  String loggedInOnDevices(int count) {
    return 'You are logged in on $count of 3 devices.';
  }

  @override
  String get noActiveSessions => 'No active sessions';

  @override
  String get logoutFromDevice => 'Log out from this device';

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
  String get errorAcceptingCall => 'Error accepting call';

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
  String typingIndicator(String name) {
    return '$name is typing...';
  }

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
  String get diagnosticDataTitle => 'Diagnostic Data';

  @override
  String get diagnosticDescription =>
      'Would you like to send anonymous diagnostic data to improve the app?';

  @override
  String get noThanks => 'No, thanks';

  @override
  String get yesEnable => 'Yes, enable';

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
  String get newPasswordMinChars => 'New Password (min. 6 chars)';

  @override
  String get reasonLabel2 => 'Reason';

  @override
  String get downloadFailed2 => 'Download failed';

  @override
  String get downloadTooltip => 'Download';

  @override
  String get connectionErrorGeneric => 'Connection error';

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
  String get bankTransfer => 'Bank transfer';

  @override
  String get standingOrder => 'Standing order';

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
  String get memberNumberTooLong =>
      'Member number too long (max 20 characters)';

  @override
  String get onlyUppercaseAndNumbers =>
      'Only uppercase letters and numbers allowed';

  @override
  String get passwordTooLong => 'Password too long (max 100 characters)';

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
  String get diagnosticErrors => 'Error reports for improvement';

  @override
  String get diagnosticAnonymousStats => 'Anonymous usage statistics';

  @override
  String get diagnosticPerformance => 'App performance data';

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
  String get ipClean => 'IP clean - not listed';

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
  String get helpImproveApp => 'Would you like to help us improve the app?';

  @override
  String get noPersonalDataCollected =>
      'No personal data is collected. This setting can be changed at any time.';

  @override
  String logEntries(int count) {
    return '$count entries';
  }

  @override
  String get noLogs => 'No logs';

  @override
  String get newLoginDetected => 'New login detected';

  @override
  String get waitingForMember => 'Waiting for member';

  @override
  String get waitingForStaff => 'Waiting for staff';

  @override
  String get waitingForAuthority => 'Waiting for authority';
}
