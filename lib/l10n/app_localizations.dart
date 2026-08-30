import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_bg.dart';
import 'app_localizations_cs.dart';
import 'app_localizations_da.dart';
import 'app_localizations_de.dart';
import 'app_localizations_el.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_et.dart';
import 'app_localizations_fi.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_hr.dart';
import 'app_localizations_hu.dart';
import 'app_localizations_it.dart';
import 'app_localizations_lt.dart';
import 'app_localizations_lv.dart';
import 'app_localizations_nb.dart';
import 'app_localizations_nl.dart';
import 'app_localizations_pl.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_ro.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_sk.dart';
import 'app_localizations_sl.dart';
import 'app_localizations_sr.dart';
import 'app_localizations_sv.dart';
import 'app_localizations_tr.dart';
import 'app_localizations_uk.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('bg'),
    Locale('cs'),
    Locale('da'),
    Locale('de'),
    Locale('el'),
    Locale('en'),
    Locale('es'),
    Locale('et'),
    Locale('fi'),
    Locale('fr'),
    Locale('hr'),
    Locale('hu'),
    Locale('it'),
    Locale('lt'),
    Locale('lv'),
    Locale('nb'),
    Locale('nl'),
    Locale('pl'),
    Locale('pt'),
    Locale('ro'),
    Locale('ru'),
    Locale('sk'),
    Locale('sl'),
    Locale('sr'),
    Locale('sv'),
    Locale('tr'),
    Locale('uk')
  ];

  /// No description provided for @welcomeLoading.
  ///
  /// In de, this message translates to:
  /// **'Wird geladen...'**
  String get welcomeLoading;

  /// No description provided for @welcomeAutoLogin.
  ///
  /// In de, this message translates to:
  /// **'Automatische Anmeldung...'**
  String get welcomeAutoLogin;

  /// No description provided for @login.
  ///
  /// In de, this message translates to:
  /// **'Anmelden'**
  String get login;

  /// No description provided for @register.
  ///
  /// In de, this message translates to:
  /// **'Registrieren'**
  String get register;

  /// No description provided for @becomeMember.
  ///
  /// In de, this message translates to:
  /// **'Mitglied werden'**
  String get becomeMember;

  /// No description provided for @memberNumber.
  ///
  /// In de, this message translates to:
  /// **'Mitgliedernummer'**
  String get memberNumber;

  /// No description provided for @memberNumberHint.
  ///
  /// In de, this message translates to:
  /// **'Bitte Mitgliedernummer eingeben'**
  String get memberNumberHint;

  /// No description provided for @confirmPassword.
  ///
  /// In de, this message translates to:
  /// **'Passwort bestätigen'**
  String get confirmPassword;

  /// No description provided for @confirmPasswordHint.
  ///
  /// In de, this message translates to:
  /// **'Bitte Passwort bestätigen'**
  String get confirmPasswordHint;

  /// No description provided for @newPassword.
  ///
  /// In de, this message translates to:
  /// **'Neues Passwort'**
  String get newPassword;

  /// No description provided for @newPasswordHint.
  ///
  /// In de, this message translates to:
  /// **'Bitte neues Passwort eingeben'**
  String get newPasswordHint;

  /// No description provided for @firstName.
  ///
  /// In de, this message translates to:
  /// **'Vorname und Nachname'**
  String get firstName;

  /// No description provided for @firstNameHint.
  ///
  /// In de, this message translates to:
  /// **'Bitte Vorname und Nachname eingeben'**
  String get firstNameHint;

  /// No description provided for @nameMinLength.
  ///
  /// In de, this message translates to:
  /// **'Name muss mindestens 2 Zeichen haben'**
  String get nameMinLength;

  /// No description provided for @nameOnlyLetters.
  ///
  /// In de, this message translates to:
  /// **'Nur Buchstaben und Bindestrich erlaubt'**
  String get nameOnlyLetters;

  /// No description provided for @email.
  ///
  /// In de, this message translates to:
  /// **'E-Mail-Adresse'**
  String get email;

  /// No description provided for @emailHint.
  ///
  /// In de, this message translates to:
  /// **'Bitte E-Mail eingeben'**
  String get emailHint;

  /// No description provided for @emailInvalid.
  ///
  /// In de, this message translates to:
  /// **'Bitte gültige E-Mail eingeben'**
  String get emailInvalid;

  /// No description provided for @passwordMinLength.
  ///
  /// In de, this message translates to:
  /// **'Passwort muss mindestens 6 Zeichen haben'**
  String get passwordMinLength;

  /// No description provided for @passwordsNotMatch.
  ///
  /// In de, this message translates to:
  /// **'Passwörter stimmen nicht überein'**
  String get passwordsNotMatch;

  /// No description provided for @registrationFailed.
  ///
  /// In de, this message translates to:
  /// **'Registrierung fehlgeschlagen'**
  String get registrationFailed;

  /// No description provided for @connectionError.
  ///
  /// In de, this message translates to:
  /// **'Verbindungsfehler: {error}'**
  String connectionError(String error);

  /// No description provided for @registrationSuccess.
  ///
  /// In de, this message translates to:
  /// **'Registrierung erfolgreich!\n\nIhre Mitgliedernummer: {memberNumber}\n\nBitte merken Sie sich diese Nummer für die Anmeldung.'**
  String registrationSuccess(String memberNumber);

  /// No description provided for @unknown.
  ///
  /// In de, this message translates to:
  /// **'Unbekannt'**
  String get unknown;

  /// No description provided for @error.
  ///
  /// In de, this message translates to:
  /// **'Fehler: {error}'**
  String error(String error);

  /// No description provided for @cancel.
  ///
  /// In de, this message translates to:
  /// **'Abbrechen'**
  String get cancel;

  /// No description provided for @resetPassword.
  ///
  /// In de, this message translates to:
  /// **'Passwort zurücksetzen'**
  String get resetPassword;

  /// No description provided for @imprint.
  ///
  /// In de, this message translates to:
  /// **'Impressum'**
  String get imprint;

  /// No description provided for @privacy.
  ///
  /// In de, this message translates to:
  /// **'Datenschutz'**
  String get privacy;

  /// No description provided for @statutes.
  ///
  /// In de, this message translates to:
  /// **'Satzung'**
  String get statutes;

  /// No description provided for @revocation.
  ///
  /// In de, this message translates to:
  /// **'Widerrufsrecht'**
  String get revocation;

  /// No description provided for @appointments.
  ///
  /// In de, this message translates to:
  /// **'Termine'**
  String get appointments;

  /// No description provided for @tickets.
  ///
  /// In de, this message translates to:
  /// **'Tickets'**
  String get tickets;

  /// No description provided for @liveChat.
  ///
  /// In de, this message translates to:
  /// **'Live Chat'**
  String get liveChat;

  /// No description provided for @notifications.
  ///
  /// In de, this message translates to:
  /// **'Benachrichtigungen'**
  String get notifications;

  /// No description provided for @myProfile.
  ///
  /// In de, this message translates to:
  /// **'Mein Profil'**
  String get myProfile;

  /// No description provided for @logout.
  ///
  /// In de, this message translates to:
  /// **'Abmelden'**
  String get logout;

  /// No description provided for @goodMorning.
  ///
  /// In de, this message translates to:
  /// **'Guten Morgen'**
  String get goodMorning;

  /// No description provided for @goodDay.
  ///
  /// In de, this message translates to:
  /// **'Guten Tag'**
  String get goodDay;

  /// No description provided for @goodEvening.
  ///
  /// In de, this message translates to:
  /// **'Guten Abend'**
  String get goodEvening;

  /// No description provided for @goodNight.
  ///
  /// In de, this message translates to:
  /// **'Gute Nacht'**
  String get goodNight;

  /// No description provided for @welcomeToICD.
  ///
  /// In de, this message translates to:
  /// **'Willkommen bei ICD360S e.V!'**
  String get welcomeToICD;

  /// No description provided for @accountCreatedSuccessfully.
  ///
  /// In de, this message translates to:
  /// **'Ihr Konto wurde erfolgreich erstellt.'**
  String get accountCreatedSuccessfully;

  /// No description provided for @today.
  ///
  /// In de, this message translates to:
  /// **'Heute'**
  String get today;

  /// No description provided for @membershipFeeDue.
  ///
  /// In de, this message translates to:
  /// **'Mitgliedsbeitrag fällig'**
  String get membershipFeeDue;

  /// No description provided for @pleaseTransferAnnualFee.
  ///
  /// In de, this message translates to:
  /// **'Bitte überweisen Sie den Jahresbeitrag.'**
  String get pleaseTransferAnnualFee;

  /// No description provided for @newBadge.
  ///
  /// In de, this message translates to:
  /// **'Neu'**
  String get newBadge;

  /// No description provided for @close.
  ///
  /// In de, this message translates to:
  /// **'Schließen'**
  String get close;

  /// No description provided for @myAppointments.
  ///
  /// In de, this message translates to:
  /// **'Meine Termine'**
  String get myAppointments;

  /// No description provided for @priority.
  ///
  /// In de, this message translates to:
  /// **'Priorität'**
  String get priority;

  /// No description provided for @messageLabel.
  ///
  /// In de, this message translates to:
  /// **'Nachricht'**
  String get messageLabel;

  /// No description provided for @reportProblems.
  ///
  /// In de, this message translates to:
  /// **'Probleme melden'**
  String get reportProblems;

  /// No description provided for @weRespondIn24Hours.
  ///
  /// In de, this message translates to:
  /// **'Wir antworten Ihnen in maximal 24 Stunden!'**
  String get weRespondIn24Hours;

  /// No description provided for @everythingOk.
  ///
  /// In de, this message translates to:
  /// **'Alles in Ordnung!'**
  String get everythingOk;

  /// No description provided for @haveProblemWeHelp.
  ///
  /// In de, this message translates to:
  /// **'Haben Sie ein Problem?\nWir kümmern uns darum!'**
  String get haveProblemWeHelp;

  /// No description provided for @myMembership.
  ///
  /// In de, this message translates to:
  /// **'Meine Mitgliedschaft'**
  String get myMembership;

  /// No description provided for @managePersonalDataAndFee.
  ///
  /// In de, this message translates to:
  /// **'Verwalten Sie Ihre persönlichen Daten und Mitgliedsbeitrag'**
  String get managePersonalDataAndFee;

  /// No description provided for @myAppointmentsTitle.
  ///
  /// In de, this message translates to:
  /// **'Meine Termine'**
  String get myAppointmentsTitle;

  /// No description provided for @appointmentsDescription.
  ///
  /// In de, this message translates to:
  /// **'Hier sehen Sie Ihre bevorstehenden Termine.\nSie können Ihre Teilnahme bestätigen oder absagen.'**
  String get appointmentsDescription;

  /// No description provided for @loadAppointments.
  ///
  /// In de, this message translates to:
  /// **'Termine laden'**
  String get loadAppointments;

  /// No description provided for @myTickets.
  ///
  /// In de, this message translates to:
  /// **'Meine Tickets'**
  String get myTickets;

  /// No description provided for @low.
  ///
  /// In de, this message translates to:
  /// **'Niedrig'**
  String get low;

  /// No description provided for @high.
  ///
  /// In de, this message translates to:
  /// **'Hoch'**
  String get high;

  /// No description provided for @submit.
  ///
  /// In de, this message translates to:
  /// **'Absenden'**
  String get submit;

  /// No description provided for @errorCreatingTicket.
  ///
  /// In de, this message translates to:
  /// **'Fehler beim Erstellen des Tickets'**
  String get errorCreatingTicket;

  /// No description provided for @verified.
  ///
  /// In de, this message translates to:
  /// **'Verifiziert'**
  String get verified;

  /// No description provided for @account.
  ///
  /// In de, this message translates to:
  /// **'Konto'**
  String get account;

  /// No description provided for @myDevices.
  ///
  /// In de, this message translates to:
  /// **'Meine Geräte'**
  String get myDevices;

  /// No description provided for @changeEmail.
  ///
  /// In de, this message translates to:
  /// **'E-Mail ändern'**
  String get changeEmail;

  /// No description provided for @changePassword.
  ///
  /// In de, this message translates to:
  /// **'Passwort ändern'**
  String get changePassword;

  /// No description provided for @saveEmail.
  ///
  /// In de, this message translates to:
  /// **'E-Mail speichern'**
  String get saveEmail;

  /// No description provided for @savePassword.
  ///
  /// In de, this message translates to:
  /// **'Passwort speichern'**
  String get savePassword;

  /// No description provided for @deviceLoggedOut.
  ///
  /// In de, this message translates to:
  /// **'Gerät abgemeldet'**
  String get deviceLoggedOut;

  /// No description provided for @emailChangedSuccessfully.
  ///
  /// In de, this message translates to:
  /// **'E-Mail erfolgreich geändert'**
  String get emailChangedSuccessfully;

  /// No description provided for @errorChangingPassword.
  ///
  /// In de, this message translates to:
  /// **'Fehler beim Ändern des Passworts'**
  String get errorChangingPassword;

  /// No description provided for @errorChangingEmail.
  ///
  /// In de, this message translates to:
  /// **'Fehler beim Ändern der E-Mail'**
  String get errorChangingEmail;

  /// No description provided for @validEmailRequired.
  ///
  /// In de, this message translates to:
  /// **'Bitte geben Sie eine gültige E-Mail-Adresse ein'**
  String get validEmailRequired;

  /// No description provided for @confirmLogoutDevice.
  ///
  /// In de, this message translates to:
  /// **'Gerät abmelden?'**
  String get confirmLogoutDevice;

  /// No description provided for @confirmLogoutMessage.
  ///
  /// In de, this message translates to:
  /// **'Möchten Sie sich von diesem Gerät abmelden?\n\nSie müssen sich erneut anmelden um dieses Gerät wieder zu verwenden.'**
  String get confirmLogoutMessage;

  /// No description provided for @ipAddress.
  ///
  /// In de, this message translates to:
  /// **'IP'**
  String get ipAddress;

  /// No description provided for @platform.
  ///
  /// In de, this message translates to:
  /// **'Platform'**
  String get platform;

  /// No description provided for @trialWarningUrgentTitle.
  ///
  /// In de, this message translates to:
  /// **'Achtung: Nur noch {days} {days, plural, =1{Tag} other{Tage}} bis zur Kontosperrung!'**
  String trialWarningUrgentTitle(int days);

  /// No description provided for @trialWarningTitle.
  ///
  /// In de, this message translates to:
  /// **'Ihr Konto ist noch nicht verifiziert'**
  String get trialWarningTitle;

  /// No description provided for @trialWarningDescription.
  ///
  /// In de, this message translates to:
  /// **'Bitte vervollständigen Sie Ihre Daten in \"Mein Profil\". Nach 30 Tagen wird Ihr Konto automatisch gesperrt.'**
  String get trialWarningDescription;

  /// No description provided for @trialDaysRemaining.
  ///
  /// In de, this message translates to:
  /// **'{days, plural, =1{1 Tag} other{{days} Tage}}'**
  String trialDaysRemaining(int days);

  /// No description provided for @overview.
  ///
  /// In de, this message translates to:
  /// **'Übersicht'**
  String get overview;

  /// No description provided for @member.
  ///
  /// In de, this message translates to:
  /// **'Mitglied'**
  String get member;

  /// No description provided for @memberManagement.
  ///
  /// In de, this message translates to:
  /// **'Mitglieder Verwaltung'**
  String get memberManagement;

  /// No description provided for @reportProblemTooltip.
  ///
  /// In de, this message translates to:
  /// **'Problem melden'**
  String get reportProblemTooltip;

  /// No description provided for @newAppointmentsTitle.
  ///
  /// In de, this message translates to:
  /// **'Neue Termine'**
  String get newAppointmentsTitle;

  /// No description provided for @youHaveNewAppointment.
  ///
  /// In de, this message translates to:
  /// **'Sie haben einen neuen Termin.'**
  String get youHaveNewAppointment;

  /// No description provided for @youHaveNewAppointments.
  ///
  /// In de, this message translates to:
  /// **'Sie haben {count} neue Termine.'**
  String youHaveNewAppointments(int count);

  /// No description provided for @appointmentReminderTomorrow.
  ///
  /// In de, this message translates to:
  /// **'Erinnerung: Termin morgen'**
  String get appointmentReminderTomorrow;

  /// No description provided for @tomorrowAppointment.
  ///
  /// In de, this message translates to:
  /// **'Morgen: {title}'**
  String tomorrowAppointment(String title);

  /// No description provided for @youHaveTomorrowAppointments.
  ///
  /// In de, this message translates to:
  /// **'Sie haben morgen {count} Termine.'**
  String youHaveTomorrowAppointments(int count);

  /// No description provided for @appointmentsToday.
  ///
  /// In de, this message translates to:
  /// **'Termine heute'**
  String get appointmentsToday;

  /// No description provided for @todayAppointment.
  ///
  /// In de, this message translates to:
  /// **'Heute: {title}'**
  String todayAppointment(String title);

  /// No description provided for @youHaveTodayAppointments.
  ///
  /// In de, this message translates to:
  /// **'Sie haben heute {count} Termine.'**
  String youHaveTodayAppointments(int count);

  /// No description provided for @paymentReminder.
  ///
  /// In de, this message translates to:
  /// **'Zahlungserinnerung'**
  String get paymentReminder;

  /// No description provided for @paymentReminderMessage.
  ///
  /// In de, this message translates to:
  /// **'Heute ist der {day}. des Monats – bitte {method} durchführen.'**
  String paymentReminderMessage(int day, String method);

  /// No description provided for @paymentDayLabel.
  ///
  /// In de, this message translates to:
  /// **'Zahlungstag (monatliche Erinnerung)'**
  String get paymentDayLabel;

  /// No description provided for @updateAvailable.
  ///
  /// In de, this message translates to:
  /// **'Update verfügbar'**
  String get updateAvailable;

  /// No description provided for @newVersionAvailable.
  ///
  /// In de, this message translates to:
  /// **'Eine neue Version ist verfügbar: {version}'**
  String newVersionAvailable(String version);

  /// No description provided for @currentVersionLabel.
  ///
  /// In de, this message translates to:
  /// **'Aktuelle Version: {version}'**
  String currentVersionLabel(String version);

  /// No description provided for @changes.
  ///
  /// In de, this message translates to:
  /// **'Änderungen:'**
  String get changes;

  /// No description provided for @downloadProgress.
  ///
  /// In de, this message translates to:
  /// **'Download: {percent}%'**
  String downloadProgress(String percent);

  /// No description provided for @installationStarting.
  ///
  /// In de, this message translates to:
  /// **'Installation wird gestartet...'**
  String get installationStarting;

  /// No description provided for @appWillRestart.
  ///
  /// In de, this message translates to:
  /// **'Die Anwendung wird automatisch neu gestartet.'**
  String get appWillRestart;

  /// No description provided for @autoUpdateEnableTitle.
  ///
  /// In de, this message translates to:
  /// **'Zukünftige Updates automatisch installieren'**
  String get autoUpdateEnableTitle;

  /// No description provided for @autoUpdateEnableHint.
  ///
  /// In de, this message translates to:
  /// **'Die App lädt Updates selbständig herunter, installiert sie und startet kurz neu. Ohne weitere Rückfragen.'**
  String get autoUpdateEnableHint;

  /// No description provided for @autoUpdateInstalling.
  ///
  /// In de, this message translates to:
  /// **'Version {version} wird im Hintergrund installiert. Die App startet gleich neu.'**
  String autoUpdateInstalling(String version);

  /// No description provided for @later.
  ///
  /// In de, this message translates to:
  /// **'Später'**
  String get later;

  /// No description provided for @updateNow.
  ///
  /// In de, this message translates to:
  /// **'Jetzt aktualisieren'**
  String get updateNow;

  /// No description provided for @downloading.
  ///
  /// In de, this message translates to:
  /// **'Wird heruntergeladen...'**
  String get downloading;

  /// No description provided for @downloadFailed.
  ///
  /// In de, this message translates to:
  /// **'Download fehlgeschlagen. Bitte versuchen Sie es später erneut.'**
  String get downloadFailed;

  /// No description provided for @searchingForUpdates.
  ///
  /// In de, this message translates to:
  /// **'Suche nach Updates...'**
  String get searchingForUpdates;

  /// No description provided for @appUpToDate.
  ///
  /// In de, this message translates to:
  /// **'Die App ist auf dem neuesten Stand'**
  String get appUpToDate;

  /// No description provided for @updateCheckError.
  ///
  /// In de, this message translates to:
  /// **'Fehler bei der Update-Prüfung'**
  String get updateCheckError;

  /// No description provided for @changelog.
  ///
  /// In de, this message translates to:
  /// **'Änderungsprotokoll'**
  String get changelog;

  /// No description provided for @terminConfirmed.
  ///
  /// In de, this message translates to:
  /// **'Termin bestätigt'**
  String get terminConfirmed;

  /// No description provided for @terminDeclined.
  ///
  /// In de, this message translates to:
  /// **'Termin abgelehnt'**
  String get terminDeclined;

  /// No description provided for @terminRescheduleRequested.
  ///
  /// In de, this message translates to:
  /// **'Verschiebung angefragt'**
  String get terminRescheduleRequested;

  /// No description provided for @statusConfirmed.
  ///
  /// In de, this message translates to:
  /// **'Bestätigt'**
  String get statusConfirmed;

  /// No description provided for @statusDeclined.
  ///
  /// In de, this message translates to:
  /// **'Abgelehnt'**
  String get statusDeclined;

  /// No description provided for @statusRescheduling.
  ///
  /// In de, this message translates to:
  /// **'Verschiebung'**
  String get statusRescheduling;

  /// No description provided for @statusPending.
  ///
  /// In de, this message translates to:
  /// **'Ausstehend'**
  String get statusPending;

  /// No description provided for @categoryVorstandssitzung.
  ///
  /// In de, this message translates to:
  /// **'Vorstandssitzung'**
  String get categoryVorstandssitzung;

  /// No description provided for @categoryMitgliederversammlung.
  ///
  /// In de, this message translates to:
  /// **'Mitgliederversammlung'**
  String get categoryMitgliederversammlung;

  /// No description provided for @categorySchulung.
  ///
  /// In de, this message translates to:
  /// **'Schulung'**
  String get categorySchulung;

  /// No description provided for @categorySonstiges.
  ///
  /// In de, this message translates to:
  /// **'Sonstiges'**
  String get categorySonstiges;

  /// No description provided for @openCount.
  ///
  /// In de, this message translates to:
  /// **'{count} offen'**
  String openCount(int count);

  /// No description provided for @refresh.
  ///
  /// In de, this message translates to:
  /// **'Aktualisieren'**
  String get refresh;

  /// No description provided for @filterUpcoming.
  ///
  /// In de, this message translates to:
  /// **'Anstehend'**
  String get filterUpcoming;

  /// No description provided for @filterPast.
  ///
  /// In de, this message translates to:
  /// **'Vergangen'**
  String get filterPast;

  /// No description provided for @filterAll.
  ///
  /// In de, this message translates to:
  /// **'Alle'**
  String get filterAll;

  /// No description provided for @noUpcomingAppointments.
  ///
  /// In de, this message translates to:
  /// **'Keine anstehenden Termine'**
  String get noUpcomingAppointments;

  /// No description provided for @noPastAppointments.
  ///
  /// In de, this message translates to:
  /// **'Keine vergangenen Termine'**
  String get noPastAppointments;

  /// No description provided for @noAppointmentsAvailable.
  ///
  /// In de, this message translates to:
  /// **'Keine Termine vorhanden'**
  String get noAppointmentsAvailable;

  /// No description provided for @appointmentsShownHere.
  ///
  /// In de, this message translates to:
  /// **'Ihre Termine werden hier angezeigt'**
  String get appointmentsShownHere;

  /// No description provided for @dateLabel.
  ///
  /// In de, this message translates to:
  /// **'Datum'**
  String get dateLabel;

  /// No description provided for @timeLabel.
  ///
  /// In de, this message translates to:
  /// **'Uhrzeit'**
  String get timeLabel;

  /// No description provided for @locationLabel.
  ///
  /// In de, this message translates to:
  /// **'Ort'**
  String get locationLabel;

  /// No description provided for @createdByLabel.
  ///
  /// In de, this message translates to:
  /// **'Erstellt von'**
  String get createdByLabel;

  /// No description provided for @descriptionLabel.
  ///
  /// In de, this message translates to:
  /// **'Beschreibung'**
  String get descriptionLabel;

  /// No description provided for @ticketLabel.
  ///
  /// In de, this message translates to:
  /// **'Ticket'**
  String get ticketLabel;

  /// No description provided for @yourStatus.
  ///
  /// In de, this message translates to:
  /// **'Ihr Status: '**
  String get yourStatus;

  /// No description provided for @reasonLabel.
  ///
  /// In de, this message translates to:
  /// **'Grund: {reason}'**
  String reasonLabel(String reason);

  /// No description provided for @durationMinutes.
  ///
  /// In de, this message translates to:
  /// **'{minutes} Min'**
  String durationMinutes(int minutes);

  /// No description provided for @confirm.
  ///
  /// In de, this message translates to:
  /// **'Bestätigen'**
  String get confirm;

  /// No description provided for @decline.
  ///
  /// In de, this message translates to:
  /// **'Ablehnen'**
  String get decline;

  /// No description provided for @reschedule.
  ///
  /// In de, this message translates to:
  /// **'Verschieben'**
  String get reschedule;

  /// No description provided for @requestReschedule.
  ///
  /// In de, this message translates to:
  /// **'Verschiebung anfragen'**
  String get requestReschedule;

  /// No description provided for @appointmentLabel.
  ///
  /// In de, this message translates to:
  /// **'Termin: {title}'**
  String appointmentLabel(String title);

  /// No description provided for @rescheduleReason.
  ///
  /// In de, this message translates to:
  /// **'Grund für Verschiebung *'**
  String get rescheduleReason;

  /// No description provided for @rescheduleReasonHint.
  ///
  /// In de, this message translates to:
  /// **'Bitte geben Sie einen Grund an...'**
  String get rescheduleReasonHint;

  /// No description provided for @pleaseProvideReason.
  ///
  /// In de, this message translates to:
  /// **'Bitte geben Sie einen Grund an'**
  String get pleaseProvideReason;

  /// No description provided for @request.
  ///
  /// In de, this message translates to:
  /// **'Anfragen'**
  String get request;

  /// No description provided for @ticketStatusOpen.
  ///
  /// In de, this message translates to:
  /// **'Offen'**
  String get ticketStatusOpen;

  /// No description provided for @ticketStatusInProgress.
  ///
  /// In de, this message translates to:
  /// **'In Bearbeitung'**
  String get ticketStatusInProgress;

  /// No description provided for @ticketStatusWaitingMember.
  ///
  /// In de, this message translates to:
  /// **'Warten auf Mitglied'**
  String get ticketStatusWaitingMember;

  /// No description provided for @ticketStatusWaitingStaff.
  ///
  /// In de, this message translates to:
  /// **'Warten auf Mitarbeiter'**
  String get ticketStatusWaitingStaff;

  /// No description provided for @ticketStatusWaitingAuthority.
  ///
  /// In de, this message translates to:
  /// **'Warten auf Behörde'**
  String get ticketStatusWaitingAuthority;

  /// No description provided for @ticketStatusDone.
  ///
  /// In de, this message translates to:
  /// **'Erledigt'**
  String get ticketStatusDone;

  /// No description provided for @ticketPriorityHigh.
  ///
  /// In de, this message translates to:
  /// **'Hoch'**
  String get ticketPriorityHigh;

  /// No description provided for @ticketPriorityMedium.
  ///
  /// In de, this message translates to:
  /// **'Mittel'**
  String get ticketPriorityMedium;

  /// No description provided for @ticketPriorityLow.
  ///
  /// In de, this message translates to:
  /// **'Niedrig'**
  String get ticketPriorityLow;

  /// No description provided for @comments.
  ///
  /// In de, this message translates to:
  /// **'Kommentare'**
  String get comments;

  /// No description provided for @documents.
  ///
  /// In de, this message translates to:
  /// **'Dokumente'**
  String get documents;

  /// No description provided for @details.
  ///
  /// In de, this message translates to:
  /// **'Details'**
  String get details;

  /// No description provided for @replySent.
  ///
  /// In de, this message translates to:
  /// **'Antwort gesendet'**
  String get replySent;

  /// No description provided for @sendError.
  ///
  /// In de, this message translates to:
  /// **'Fehler beim Senden'**
  String get sendError;

  /// No description provided for @uploading.
  ///
  /// In de, this message translates to:
  /// **'Hochladen...'**
  String get uploading;

  /// No description provided for @fileUploaded.
  ///
  /// In de, this message translates to:
  /// **'{filename} hochgeladen'**
  String fileUploaded(String filename);

  /// No description provided for @uploadFailed.
  ///
  /// In de, this message translates to:
  /// **'Upload fehlgeschlagen'**
  String get uploadFailed;

  /// No description provided for @openError.
  ///
  /// In de, this message translates to:
  /// **'Fehler beim Öffnen'**
  String get openError;

  /// No description provided for @noRepliesYet.
  ///
  /// In de, this message translates to:
  /// **'Noch keine Antworten'**
  String get noRepliesYet;

  /// No description provided for @waitingForSupport.
  ///
  /// In de, this message translates to:
  /// **'Warten Sie auf Antwort vom Support'**
  String get waitingForSupport;

  /// No description provided for @writeReply.
  ///
  /// In de, this message translates to:
  /// **'Antwort schreiben...'**
  String get writeReply;

  /// No description provided for @attachFile.
  ///
  /// In de, this message translates to:
  /// **'Datei anhängen'**
  String get attachFile;

  /// No description provided for @documentsCount.
  ///
  /// In de, this message translates to:
  /// **'Dokumente ({count})'**
  String documentsCount(int count);

  /// No description provided for @upload.
  ///
  /// In de, this message translates to:
  /// **'Hochladen'**
  String get upload;

  /// No description provided for @noDocuments.
  ///
  /// In de, this message translates to:
  /// **'Keine Dokumente vorhanden'**
  String get noDocuments;

  /// No description provided for @allowedFormats.
  ///
  /// In de, this message translates to:
  /// **'Erlaubte Formate: PDF, JPEG, JPG, TXT, ZIP'**
  String get allowedFormats;

  /// No description provided for @yourMessage.
  ///
  /// In de, this message translates to:
  /// **'Ihre Nachricht:'**
  String get yourMessage;

  /// No description provided for @translation.
  ///
  /// In de, this message translates to:
  /// **'Übersetzung'**
  String get translation;

  /// No description provided for @original.
  ///
  /// In de, this message translates to:
  /// **'Original'**
  String get original;

  /// No description provided for @originalText.
  ///
  /// In de, this message translates to:
  /// **'Originaltext'**
  String get originalText;

  /// No description provided for @autoTranslated.
  ///
  /// In de, this message translates to:
  /// **'Automatisch übersetzt'**
  String get autoTranslated;

  /// No description provided for @originalTapTranslation.
  ///
  /// In de, this message translates to:
  /// **'Originaltext · Tippen für Übersetzung'**
  String get originalTapTranslation;

  /// No description provided for @translatedTapOriginal.
  ///
  /// In de, this message translates to:
  /// **'Übersetzt · Tippen für Original'**
  String get translatedTapOriginal;

  /// No description provided for @justNow.
  ///
  /// In de, this message translates to:
  /// **'Gerade eben'**
  String get justNow;

  /// No description provided for @minutesAgo.
  ///
  /// In de, this message translates to:
  /// **'vor {minutes} Min'**
  String minutesAgo(int minutes);

  /// No description provided for @hoursAgo.
  ///
  /// In de, this message translates to:
  /// **'vor {hours} Std'**
  String hoursAgo(int hours);

  /// No description provided for @daysAgo.
  ///
  /// In de, this message translates to:
  /// **'vor {days} {days, plural, =1{Tag} other{Tagen}}'**
  String daysAgo(int days);

  /// No description provided for @createdLabel.
  ///
  /// In de, this message translates to:
  /// **'Erstellt'**
  String get createdLabel;

  /// No description provided for @updatedLabel.
  ///
  /// In de, this message translates to:
  /// **'Aktualisiert'**
  String get updatedLabel;

  /// No description provided for @handlerLabel.
  ///
  /// In de, this message translates to:
  /// **'Bearbeiter'**
  String get handlerLabel;

  /// No description provided for @doneLabel.
  ///
  /// In de, this message translates to:
  /// **'Erledigt'**
  String get doneLabel;

  /// No description provided for @newTicketTitle.
  ///
  /// In de, this message translates to:
  /// **'Neues Ticket'**
  String get newTicketTitle;

  /// No description provided for @categoryOptional.
  ///
  /// In de, this message translates to:
  /// **'Kategorie (optional)'**
  String get categoryOptional;

  /// No description provided for @selectCategory.
  ///
  /// In de, this message translates to:
  /// **'Wählen'**
  String get selectCategory;

  /// No description provided for @subjectLabel.
  ///
  /// In de, this message translates to:
  /// **'Betreff'**
  String get subjectLabel;

  /// No description provided for @fillAllFields.
  ///
  /// In de, this message translates to:
  /// **'Bitte füllen Sie alle Felder aus'**
  String get fillAllFields;

  /// No description provided for @ticketCreatedId.
  ///
  /// In de, this message translates to:
  /// **'Ticket #{id} erstellt'**
  String ticketCreatedId(int id);

  /// No description provided for @priorityLabel.
  ///
  /// In de, this message translates to:
  /// **'Priorität: '**
  String get priorityLabel;

  /// No description provided for @supportOffline.
  ///
  /// In de, this message translates to:
  /// **'Support offline'**
  String get supportOffline;

  /// No description provided for @lastSeenSeconds.
  ///
  /// In de, this message translates to:
  /// **'Zuletzt aktiv vor wenigen Sekunden'**
  String get lastSeenSeconds;

  /// No description provided for @lastSeenMinutes.
  ///
  /// In de, this message translates to:
  /// **'Zuletzt aktiv vor {minutes} {minutes, plural, =1{Minute} other{Minuten}}'**
  String lastSeenMinutes(int minutes);

  /// No description provided for @lastSeenHours.
  ///
  /// In de, this message translates to:
  /// **'Zuletzt aktiv vor {hours} {hours, plural, =1{Stunde} other{Stunden}}'**
  String lastSeenHours(int hours);

  /// No description provided for @lastSeenDays.
  ///
  /// In de, this message translates to:
  /// **'Zuletzt aktiv vor {days} {days, plural, =1{Tag} other{Tagen}}'**
  String lastSeenDays(int days);

  /// No description provided for @online.
  ///
  /// In de, this message translates to:
  /// **'Online'**
  String get online;

  /// No description provided for @callSupport.
  ///
  /// In de, this message translates to:
  /// **'Anrufen'**
  String get callSupport;

  /// No description provided for @typeMessage.
  ///
  /// In de, this message translates to:
  /// **'Nachricht eingeben...'**
  String get typeMessage;

  /// No description provided for @callBusy.
  ///
  /// In de, this message translates to:
  /// **'Support ist beschäftigt'**
  String get callBusy;

  /// No description provided for @callRejected.
  ///
  /// In de, this message translates to:
  /// **'Anruf wurde abgelehnt'**
  String get callRejected;

  /// No description provided for @callFailed.
  ///
  /// In de, this message translates to:
  /// **'Anruf konnte nicht verbunden werden'**
  String get callFailed;

  /// No description provided for @callEnded.
  ///
  /// In de, this message translates to:
  /// **'Anruf beendet'**
  String get callEnded;

  /// No description provided for @callSupportBusy.
  ///
  /// In de, this message translates to:
  /// **'Der Support ist bereits in einem anderen Anruf'**
  String get callSupportBusy;

  /// No description provided for @errorStartingChat.
  ///
  /// In de, this message translates to:
  /// **'Fehler beim Starten des Chats'**
  String get errorStartingChat;

  /// No description provided for @errorStartingCall.
  ///
  /// In de, this message translates to:
  /// **'Fehler beim Starten des Anrufs'**
  String get errorStartingCall;

  /// No description provided for @errorConnecting.
  ///
  /// In de, this message translates to:
  /// **'Fehler beim Verbinden'**
  String get errorConnecting;

  /// No description provided for @errorDownloading.
  ///
  /// In de, this message translates to:
  /// **'Fehler beim Herunterladen'**
  String get errorDownloading;

  /// No description provided for @errorUploading.
  ///
  /// In de, this message translates to:
  /// **'Fehler beim Hochladen'**
  String get errorUploading;

  /// No description provided for @errorSending.
  ///
  /// In de, this message translates to:
  /// **'Fehler beim Senden'**
  String get errorSending;

  /// No description provided for @errorPickingPhotos.
  ///
  /// In de, this message translates to:
  /// **'Fehler beim Auswählen der Bilder'**
  String get errorPickingPhotos;

  /// No description provided for @errorPickingFiles.
  ///
  /// In de, this message translates to:
  /// **'Fehler beim Auswählen der Dateien'**
  String get errorPickingFiles;

  /// No description provided for @errorTakingPhoto.
  ///
  /// In de, this message translates to:
  /// **'Fehler beim Aufnehmen des Fotos'**
  String get errorTakingPhoto;

  /// No description provided for @fileNotLoaded.
  ///
  /// In de, this message translates to:
  /// **'Datei konnte nicht geladen werden'**
  String get fileNotLoaded;

  /// No description provided for @attachmentIdMissing.
  ///
  /// In de, this message translates to:
  /// **'Attachment ID fehlt'**
  String get attachmentIdMissing;

  /// No description provided for @camera.
  ///
  /// In de, this message translates to:
  /// **'Kamera'**
  String get camera;

  /// No description provided for @gallery.
  ///
  /// In de, this message translates to:
  /// **'Galerie'**
  String get gallery;

  /// No description provided for @file.
  ///
  /// In de, this message translates to:
  /// **'Datei'**
  String get file;

  /// No description provided for @notifNewMessageFrom.
  ///
  /// In de, this message translates to:
  /// **'Neue Nachricht von'**
  String get notifNewMessageFrom;

  /// No description provided for @notifUrgentPrefix.
  ///
  /// In de, this message translates to:
  /// **'DRINGEND'**
  String get notifUrgentPrefix;

  /// No description provided for @notifUrgentMessage.
  ///
  /// In de, this message translates to:
  /// **'DRINGENDE NACHRICHT'**
  String get notifUrgentMessage;

  /// No description provided for @notifIncomingCall.
  ///
  /// In de, this message translates to:
  /// **'Eingehender Anruf'**
  String get notifIncomingCall;

  /// No description provided for @notifCallingYou.
  ///
  /// In de, this message translates to:
  /// **'ruft an...'**
  String get notifCallingYou;

  /// No description provided for @notifUpdateAvailable.
  ///
  /// In de, this message translates to:
  /// **'Update verfügbar'**
  String get notifUpdateAvailable;

  /// No description provided for @notifVersionAvailable.
  ///
  /// In de, this message translates to:
  /// **'ist jetzt verfügbar'**
  String get notifVersionAvailable;

  /// No description provided for @notifConnected.
  ///
  /// In de, this message translates to:
  /// **'Verbunden'**
  String get notifConnected;

  /// No description provided for @notifDisconnected.
  ///
  /// In de, this message translates to:
  /// **'Verbindung getrennt'**
  String get notifDisconnected;

  /// No description provided for @notifConnectedBody.
  ///
  /// In de, this message translates to:
  /// **'Sie sind jetzt mit dem Server verbunden.'**
  String get notifConnectedBody;

  /// No description provided for @notifDisconnectedBody.
  ///
  /// In de, this message translates to:
  /// **'Die Verbindung zum Server wurde unterbrochen.'**
  String get notifDisconnectedBody;

  /// No description provided for @notifError.
  ///
  /// In de, this message translates to:
  /// **'Fehler'**
  String get notifError;

  /// No description provided for @retry.
  ///
  /// In de, this message translates to:
  /// **'Erneut versuchen'**
  String get retry;

  /// No description provided for @save.
  ///
  /// In de, this message translates to:
  /// **'Speichern'**
  String get save;

  /// No description provided for @accept.
  ///
  /// In de, this message translates to:
  /// **'Akzeptieren'**
  String get accept;

  /// No description provided for @selectFile.
  ///
  /// In de, this message translates to:
  /// **'Datei auswählen'**
  String get selectFile;

  /// No description provided for @dataLoadingText.
  ///
  /// In de, this message translates to:
  /// **'Daten werden geladen...'**
  String get dataLoadingText;

  /// No description provided for @dataSavedSuccess.
  ///
  /// In de, this message translates to:
  /// **'Daten erfolgreich gespeichert'**
  String get dataSavedSuccess;

  /// No description provided for @errorSaving.
  ///
  /// In de, this message translates to:
  /// **'Fehler beim Speichern'**
  String get errorSaving;

  /// No description provided for @errorLoading.
  ///
  /// In de, this message translates to:
  /// **'Fehler beim Laden'**
  String get errorLoading;

  /// No description provided for @savedFilename.
  ///
  /// In de, this message translates to:
  /// **'Gespeichert: {filename}'**
  String savedFilename(String filename);

  /// No description provided for @logsCopied.
  ///
  /// In de, this message translates to:
  /// **'Logs kopiert!'**
  String get logsCopied;

  /// No description provided for @passwordMinEightChars.
  ///
  /// In de, this message translates to:
  /// **'Passwort muss mindestens 8 Zeichen lang sein'**
  String get passwordMinEightChars;

  /// No description provided for @passwordChangeSuccess.
  ///
  /// In de, this message translates to:
  /// **'Passwort erfolgreich geändert'**
  String get passwordChangeSuccess;

  /// No description provided for @emailChangeError.
  ///
  /// In de, this message translates to:
  /// **'Fehler beim Ändern der E-Mail'**
  String get emailChangeError;

  /// No description provided for @acceptDocumentCheckbox.
  ///
  /// In de, this message translates to:
  /// **'Ich habe das Dokument gelesen und akzeptiere es.'**
  String get acceptDocumentCheckbox;

  /// No description provided for @loadingErrorGeneric.
  ///
  /// In de, this message translates to:
  /// **'Fehler beim Laden: {details}'**
  String loadingErrorGeneric(String details);

  /// No description provided for @incomingCallTitle.
  ///
  /// In de, this message translates to:
  /// **'Eingehender Anruf'**
  String get incomingCallTitle;

  /// No description provided for @ringingFor.
  ///
  /// In de, this message translates to:
  /// **'Klingelt seit {seconds}s'**
  String ringingFor(int seconds);

  /// No description provided for @rejectCall.
  ///
  /// In de, this message translates to:
  /// **'Ablehnen'**
  String get rejectCall;

  /// No description provided for @acceptCall.
  ///
  /// In de, this message translates to:
  /// **'Annehmen'**
  String get acceptCall;

  /// No description provided for @unmute.
  ///
  /// In de, this message translates to:
  /// **'Stummschaltung aufheben'**
  String get unmute;

  /// No description provided for @mute.
  ///
  /// In de, this message translates to:
  /// **'Stummschalten'**
  String get mute;

  /// No description provided for @hangUp.
  ///
  /// In de, this message translates to:
  /// **'Auflegen'**
  String get hangUp;

  /// No description provided for @calling.
  ///
  /// In de, this message translates to:
  /// **'Anrufen...'**
  String get calling;

  /// No description provided for @autoRejectIn.
  ///
  /// In de, this message translates to:
  /// **'Auto-ablehnen in {seconds} Sekunden'**
  String autoRejectIn(int seconds);

  /// No description provided for @speakerOn.
  ///
  /// In de, this message translates to:
  /// **'Lautsprecher'**
  String get speakerOn;

  /// No description provided for @speakerOff.
  ///
  /// In de, this message translates to:
  /// **'Hören'**
  String get speakerOff;

  /// No description provided for @micMuted.
  ///
  /// In de, this message translates to:
  /// **'Stumm'**
  String get micMuted;

  /// No description provided for @micOn.
  ///
  /// In de, this message translates to:
  /// **'Mikrofon'**
  String get micOn;

  /// No description provided for @connectionExcellent.
  ///
  /// In de, this message translates to:
  /// **'Ausgezeichnet'**
  String get connectionExcellent;

  /// No description provided for @connectionGood.
  ///
  /// In de, this message translates to:
  /// **'Gut'**
  String get connectionGood;

  /// No description provided for @connectionWeak.
  ///
  /// In de, this message translates to:
  /// **'Schwach'**
  String get connectionWeak;

  /// No description provided for @connectionLost.
  ///
  /// In de, this message translates to:
  /// **'Getrennt'**
  String get connectionLost;

  /// No description provided for @personalData.
  ///
  /// In de, this message translates to:
  /// **'Persönliche Daten'**
  String get personalData;

  /// No description provided for @personalDataSubtitle.
  ///
  /// In de, this message translates to:
  /// **'Name, Vorname, Anschrift'**
  String get personalDataSubtitle;

  /// No description provided for @membershipFee.
  ///
  /// In de, this message translates to:
  /// **'Mitgliedsbeitrag'**
  String get membershipFee;

  /// No description provided for @annualFeeYear.
  ///
  /// In de, this message translates to:
  /// **'Jahresbeitrag {year}'**
  String annualFeeYear(String year);

  /// No description provided for @amount.
  ///
  /// In de, this message translates to:
  /// **'Betrag:'**
  String get amount;

  /// No description provided for @dueBy.
  ///
  /// In de, this message translates to:
  /// **'Fällig bis:'**
  String get dueBy;

  /// No description provided for @paid.
  ///
  /// In de, this message translates to:
  /// **'Bezahlt'**
  String get paid;

  /// No description provided for @versionHistory.
  ///
  /// In de, this message translates to:
  /// **'Version History'**
  String get versionHistory;

  /// No description provided for @lastUpdated.
  ///
  /// In de, this message translates to:
  /// **'Last updated: {date}'**
  String lastUpdated(String date);

  /// No description provided for @noVersionHistory.
  ///
  /// In de, this message translates to:
  /// **'No version history available'**
  String get noVersionHistory;

  /// No description provided for @failedLoadChangelog.
  ///
  /// In de, this message translates to:
  /// **'Failed to load changelog'**
  String get failedLoadChangelog;

  /// No description provided for @callMember.
  ///
  /// In de, this message translates to:
  /// **'Mitglied anrufen'**
  String get callMember;

  /// No description provided for @closeConversation.
  ///
  /// In de, this message translates to:
  /// **'Konversation schließen'**
  String get closeConversation;

  /// No description provided for @chatOffline.
  ///
  /// In de, this message translates to:
  /// **'Offline'**
  String get chatOffline;

  /// No description provided for @attachFiles.
  ///
  /// In de, this message translates to:
  /// **'Dateien anhängen (max. 10, 50MB)'**
  String get attachFiles;

  /// No description provided for @conversationClosed.
  ///
  /// In de, this message translates to:
  /// **'Diese Konversation wurde geschlossen'**
  String get conversationClosed;

  /// No description provided for @noMessages.
  ///
  /// In de, this message translates to:
  /// **'Keine Nachrichten'**
  String get noMessages;

  /// No description provided for @goBack.
  ///
  /// In de, this message translates to:
  /// **'Zurück'**
  String get goBack;

  /// No description provided for @goForward.
  ///
  /// In de, this message translates to:
  /// **'Vorwärts'**
  String get goForward;

  /// No description provided for @homePage.
  ///
  /// In de, this message translates to:
  /// **'Startseite'**
  String get homePage;

  /// No description provided for @firstNameLabel.
  ///
  /// In de, this message translates to:
  /// **'Vorname'**
  String get firstNameLabel;

  /// No description provided for @lastNameLabel.
  ///
  /// In de, this message translates to:
  /// **'Nachname'**
  String get lastNameLabel;

  /// No description provided for @streetLabel.
  ///
  /// In de, this message translates to:
  /// **'Straße'**
  String get streetLabel;

  /// No description provided for @houseNumberLabel.
  ///
  /// In de, this message translates to:
  /// **'Nr.'**
  String get houseNumberLabel;

  /// No description provided for @postalCodeLabel.
  ///
  /// In de, this message translates to:
  /// **'PLZ'**
  String get postalCodeLabel;

  /// No description provided for @cityLabel.
  ///
  /// In de, this message translates to:
  /// **'Ort'**
  String get cityLabel;

  /// No description provided for @phoneMobileLabel.
  ///
  /// In de, this message translates to:
  /// **'Telefon (Mobil)'**
  String get phoneMobileLabel;

  /// No description provided for @phoneLandlineLabel.
  ///
  /// In de, this message translates to:
  /// **'Telefon (Festnetz)'**
  String get phoneLandlineLabel;

  /// No description provided for @newEmailLabel.
  ///
  /// In de, this message translates to:
  /// **'Neue E-Mail-Adresse'**
  String get newEmailLabel;

  /// No description provided for @currentPasswordLabel.
  ///
  /// In de, this message translates to:
  /// **'Aktuelles Passwort'**
  String get currentPasswordLabel;

  /// No description provided for @newPasswordLabel.
  ///
  /// In de, this message translates to:
  /// **'Neues Passwort'**
  String get newPasswordLabel;

  /// No description provided for @confirmPasswordLabel.
  ///
  /// In de, this message translates to:
  /// **'Passwort bestätigen'**
  String get confirmPasswordLabel;

  /// No description provided for @emailChangedSuccess.
  ///
  /// In de, this message translates to:
  /// **'E-Mail erfolgreich geändert'**
  String get emailChangedSuccess;

  /// No description provided for @reasonLabel2.
  ///
  /// In de, this message translates to:
  /// **'Grund'**
  String get reasonLabel2;

  /// No description provided for @downloadFailed2.
  ///
  /// In de, this message translates to:
  /// **'Download fehlgeschlagen'**
  String get downloadFailed2;

  /// No description provided for @downloadTooltip.
  ///
  /// In de, this message translates to:
  /// **'Herunterladen'**
  String get downloadTooltip;

  /// No description provided for @copyLogs.
  ///
  /// In de, this message translates to:
  /// **'Logs kopieren'**
  String get copyLogs;

  /// No description provided for @deleteLogs.
  ///
  /// In de, this message translates to:
  /// **'Logs löschen'**
  String get deleteLogs;

  /// No description provided for @autoScrollOn.
  ///
  /// In de, this message translates to:
  /// **'Auto-scroll AN'**
  String get autoScrollOn;

  /// No description provided for @autoScrollOff.
  ///
  /// In de, this message translates to:
  /// **'Auto-scroll AUS'**
  String get autoScrollOff;

  /// No description provided for @unknownValue.
  ///
  /// In de, this message translates to:
  /// **'Unbekannt'**
  String get unknownValue;

  /// No description provided for @payment.
  ///
  /// In de, this message translates to:
  /// **'Zahlung'**
  String get payment;

  /// No description provided for @warningType_ermahnung.
  ///
  /// In de, this message translates to:
  /// **'Ermahnung'**
  String get warningType_ermahnung;

  /// No description provided for @warningType_abmahnung.
  ///
  /// In de, this message translates to:
  /// **'Abmahnung'**
  String get warningType_abmahnung;

  /// No description provided for @warningType_letzte.
  ///
  /// In de, this message translates to:
  /// **'Letzte Abmahnung'**
  String get warningType_letzte;

  /// No description provided for @warningsTotal.
  ///
  /// In de, this message translates to:
  /// **'Gesamt: {count}'**
  String warningsTotal(int count);

  /// No description provided for @warningsErmahnung.
  ///
  /// In de, this message translates to:
  /// **'Ermahnung: {count}'**
  String warningsErmahnung(int count);

  /// No description provided for @warningsAbmahnung.
  ///
  /// In de, this message translates to:
  /// **'Abmahnung: {count}'**
  String warningsAbmahnung(int count);

  /// No description provided for @warningsLetzte.
  ///
  /// In de, this message translates to:
  /// **'Letzte: {count}'**
  String warningsLetzte(int count);

  /// No description provided for @noWarnings.
  ///
  /// In de, this message translates to:
  /// **'Keine Verwarnungen vorhanden'**
  String get noWarnings;

  /// No description provided for @noWarningsDescription.
  ///
  /// In de, this message translates to:
  /// **'Sie haben derzeit keine Verwarnungen.'**
  String get noWarningsDescription;

  /// No description provided for @createdBy.
  ///
  /// In de, this message translates to:
  /// **'Erstellt von: {name}'**
  String createdBy(String name);

  /// No description provided for @monthJan.
  ///
  /// In de, this message translates to:
  /// **'Jan'**
  String get monthJan;

  /// No description provided for @monthFeb.
  ///
  /// In de, this message translates to:
  /// **'Feb'**
  String get monthFeb;

  /// No description provided for @monthMar.
  ///
  /// In de, this message translates to:
  /// **'Mär'**
  String get monthMar;

  /// No description provided for @monthApr.
  ///
  /// In de, this message translates to:
  /// **'Apr'**
  String get monthApr;

  /// No description provided for @monthMay.
  ///
  /// In de, this message translates to:
  /// **'Mai'**
  String get monthMay;

  /// No description provided for @monthJun.
  ///
  /// In de, this message translates to:
  /// **'Jun'**
  String get monthJun;

  /// No description provided for @monthJul.
  ///
  /// In de, this message translates to:
  /// **'Jul'**
  String get monthJul;

  /// No description provided for @monthAug.
  ///
  /// In de, this message translates to:
  /// **'Aug'**
  String get monthAug;

  /// No description provided for @monthSep.
  ///
  /// In de, this message translates to:
  /// **'Sep'**
  String get monthSep;

  /// No description provided for @monthOct.
  ///
  /// In de, this message translates to:
  /// **'Okt'**
  String get monthOct;

  /// No description provided for @monthNov.
  ///
  /// In de, this message translates to:
  /// **'Nov'**
  String get monthNov;

  /// No description provided for @monthDec.
  ///
  /// In de, this message translates to:
  /// **'Dez'**
  String get monthDec;

  /// No description provided for @stufe1_name.
  ///
  /// In de, this message translates to:
  /// **'Persönliche Daten'**
  String get stufe1_name;

  /// No description provided for @stufe2_name.
  ///
  /// In de, this message translates to:
  /// **'Mitgliedsart'**
  String get stufe2_name;

  /// No description provided for @stufe3_name.
  ///
  /// In de, this message translates to:
  /// **'Finanzielle Situation'**
  String get stufe3_name;

  /// No description provided for @stufe4_name.
  ///
  /// In de, this message translates to:
  /// **'Zahlungsmethode'**
  String get stufe4_name;

  /// No description provided for @stufe5_name.
  ///
  /// In de, this message translates to:
  /// **'Mitgliedschaftsbeginn'**
  String get stufe5_name;

  /// No description provided for @stufe6_name.
  ///
  /// In de, this message translates to:
  /// **'Satzung'**
  String get stufe6_name;

  /// No description provided for @stufe7_name.
  ///
  /// In de, this message translates to:
  /// **'Datenschutzerklärung'**
  String get stufe7_name;

  /// No description provided for @stufe8_name.
  ///
  /// In de, this message translates to:
  /// **'Widerrufsbelehrung'**
  String get stufe8_name;

  /// No description provided for @memberType_ordentlich.
  ///
  /// In de, this message translates to:
  /// **'Ordentliches Mitglied'**
  String get memberType_ordentlich;

  /// No description provided for @memberType_foerder.
  ///
  /// In de, this message translates to:
  /// **'Fördermitglied'**
  String get memberType_foerder;

  /// No description provided for @memberType_ehren.
  ///
  /// In de, this message translates to:
  /// **'Ehrenmitglied'**
  String get memberType_ehren;

  /// No description provided for @memberDesc_ordentlich.
  ///
  /// In de, this message translates to:
  /// **'Aktives Mitglied mit Stimmrecht. Nimmt an den Dienstleistungen des Vereins teil (E-Mail, Cloud, bürokratische Unterstützung).'**
  String get memberDesc_ordentlich;

  /// No description provided for @memberDesc_foerder.
  ///
  /// In de, this message translates to:
  /// **'Unterstützt den Verein durch Beiträge. Kann an der Mitgliederversammlung mit beratendem Stimmrecht teilnehmen, ohne Wahlrecht oder Recht, in den Vorstand gewählt zu werden.'**
  String get memberDesc_foerder;

  /// No description provided for @memberDesc_ehren.
  ///
  /// In de, this message translates to:
  /// **'Hat die Rechte eines ordentlichen Mitglieds, ohne die Pflicht, Mitgliedsbeiträge zu zahlen. Wird von der Mitgliederversammlung oder dem Vorstand bestimmt.'**
  String get memberDesc_ehren;

  /// No description provided for @payMethod_ueberweisung.
  ///
  /// In de, this message translates to:
  /// **'Überweisung'**
  String get payMethod_ueberweisung;

  /// No description provided for @payMethod_dauerauftrag.
  ///
  /// In de, this message translates to:
  /// **'Dauerauftrag'**
  String get payMethod_dauerauftrag;

  /// No description provided for @verifyStatus_geprueft.
  ///
  /// In de, this message translates to:
  /// **'Geprüft'**
  String get verifyStatus_geprueft;

  /// No description provided for @verifyStatus_ausgefuellt.
  ///
  /// In de, this message translates to:
  /// **'Ausgefüllt'**
  String get verifyStatus_ausgefuellt;

  /// No description provided for @verifyStatus_abgelehnt.
  ///
  /// In de, this message translates to:
  /// **'Abgelehnt'**
  String get verifyStatus_abgelehnt;

  /// No description provided for @verifyStatus_offen.
  ///
  /// In de, this message translates to:
  /// **'Offen'**
  String get verifyStatus_offen;

  /// No description provided for @fillRequiredFields.
  ///
  /// In de, this message translates to:
  /// **'Bitte füllen Sie alle Pflichtfelder aus.'**
  String get fillRequiredFields;

  /// No description provided for @personalDataSaved.
  ///
  /// In de, this message translates to:
  /// **'Persönliche Daten gespeichert'**
  String get personalDataSaved;

  /// No description provided for @selectMemberType.
  ///
  /// In de, this message translates to:
  /// **'Bitte wählen Sie eine Mitgliedsart.'**
  String get selectMemberType;

  /// No description provided for @memberTypeSaved.
  ///
  /// In de, this message translates to:
  /// **'Mitgliedsart gespeichert'**
  String get memberTypeSaved;

  /// No description provided for @selectOption.
  ///
  /// In de, this message translates to:
  /// **'Bitte wählen Sie eine Option.'**
  String get selectOption;

  /// No description provided for @financialSaved.
  ///
  /// In de, this message translates to:
  /// **'Finanzielle Situation gespeichert'**
  String get financialSaved;

  /// No description provided for @selectPaymentMethod.
  ///
  /// In de, this message translates to:
  /// **'Bitte wählen Sie eine Zahlungsmethode.'**
  String get selectPaymentMethod;

  /// No description provided for @paymentDataSaved.
  ///
  /// In de, this message translates to:
  /// **'Zahlungsdaten gespeichert'**
  String get paymentDataSaved;

  /// No description provided for @selectDate.
  ///
  /// In de, this message translates to:
  /// **'Bitte wählen Sie ein Datum.'**
  String get selectDate;

  /// No description provided for @membershipStartSaved.
  ///
  /// In de, this message translates to:
  /// **'Mitgliedschaftsbeginn gespeichert'**
  String get membershipStartSaved;

  /// No description provided for @fileTooLarge.
  ///
  /// In de, this message translates to:
  /// **'Datei zu groß (max. 10 MB).'**
  String get fileTooLarge;

  /// No description provided for @leistungsbescheidUploaded.
  ///
  /// In de, this message translates to:
  /// **'Leistungsbescheid erfolgreich hochgeladen'**
  String get leistungsbescheidUploaded;

  /// No description provided for @verificationProgress.
  ///
  /// In de, this message translates to:
  /// **'Verifizierungsfortschritt'**
  String get verificationProgress;

  /// No description provided for @notApplicable.
  ///
  /// In de, this message translates to:
  /// **'Entfällt'**
  String get notApplicable;

  /// No description provided for @socialBenefitsExempt.
  ///
  /// In de, this message translates to:
  /// **'Bei Bürgergeld/Sozialamt entfällt die Zahlungsmethode.'**
  String get socialBenefitsExempt;

  /// No description provided for @locked.
  ///
  /// In de, this message translates to:
  /// **'Gesperrt'**
  String get locked;

  /// No description provided for @completePreviousStep.
  ///
  /// In de, this message translates to:
  /// **'Bitte schließen Sie zuerst Stufe {step} ab.'**
  String completePreviousStep(int step);

  /// No description provided for @rejectedNote.
  ///
  /// In de, this message translates to:
  /// **'Abgelehnt: {note}'**
  String rejectedNote(String note);

  /// No description provided for @waitingForReview.
  ///
  /// In de, this message translates to:
  /// **'Wartet auf Prüfung durch den Vorstand.'**
  String get waitingForReview;

  /// No description provided for @stepApproved.
  ///
  /// In de, this message translates to:
  /// **'Diese Stufe wurde geprüft und genehmigt.'**
  String get stepApproved;

  /// No description provided for @changesViaChat.
  ///
  /// In de, this message translates to:
  /// **'Änderungen nur über Live-Chat möglich.'**
  String get changesViaChat;

  /// No description provided for @firstNameRequired.
  ///
  /// In de, this message translates to:
  /// **'Vorname *'**
  String get firstNameRequired;

  /// No description provided for @lastNameRequired.
  ///
  /// In de, this message translates to:
  /// **'Nachname *'**
  String get lastNameRequired;

  /// No description provided for @birthDateLabel.
  ///
  /// In de, this message translates to:
  /// **'Geburtsdatum *'**
  String get birthDateLabel;

  /// No description provided for @streetRequired.
  ///
  /// In de, this message translates to:
  /// **'Straße *'**
  String get streetRequired;

  /// No description provided for @houseNumberRequired.
  ///
  /// In de, this message translates to:
  /// **'Nr. *'**
  String get houseNumberRequired;

  /// No description provided for @cityRequired.
  ///
  /// In de, this message translates to:
  /// **'Ort *'**
  String get cityRequired;

  /// No description provided for @phoneRequired.
  ///
  /// In de, this message translates to:
  /// **'Telefonnummer *'**
  String get phoneRequired;

  /// No description provided for @phonePurpose.
  ///
  /// In de, this message translates to:
  /// **'Zweck: Kontaktaufnahme bei Nichterreichbarkeit über die App'**
  String get phonePurpose;

  /// No description provided for @selectMemberTypePrompt.
  ///
  /// In de, this message translates to:
  /// **'Bitte wählen Sie Ihre gewünschte Mitgliedsart:'**
  String get selectMemberTypePrompt;

  /// No description provided for @financialExplanation.
  ///
  /// In de, this message translates to:
  /// **'Um zu prüfen, ob Sie Anspruch auf eine Beitragsermäßigung haben, benötigen wir folgende Information. Diese Information wird ausschließlich zur Festlegung Ihres Mitgliedsbeitrags verwendet.'**
  String get financialExplanation;

  /// No description provided for @socialBenefitsQuestion.
  ///
  /// In de, this message translates to:
  /// **'Beziehen Sie derzeit Sozialleistungen?'**
  String get socialBenefitsQuestion;

  /// No description provided for @optionBuergergeld.
  ///
  /// In de, this message translates to:
  /// **'Ja, Bürgergeld (Jobcenter)'**
  String get optionBuergergeld;

  /// No description provided for @optionSozialamt.
  ///
  /// In de, this message translates to:
  /// **'Ja, Sozialleistungen vom Sozialamt'**
  String get optionSozialamt;

  /// No description provided for @optionNoBenefits.
  ///
  /// In de, this message translates to:
  /// **'Nein, ich beziehe keine Sozialleistungen'**
  String get optionNoBenefits;

  /// No description provided for @feeExempt.
  ///
  /// In de, this message translates to:
  /// **'Ihr monatlicher Mitgliedsbeitrag beträgt: 0,00 €/Monat'**
  String get feeExempt;

  /// No description provided for @uploadLeistungsbescheid.
  ///
  /// In de, this message translates to:
  /// **'Leistungsbescheid hochladen'**
  String get uploadLeistungsbescheid;

  /// No description provided for @uploadLeistungsbescheidHint.
  ///
  /// In de, this message translates to:
  /// **'Bitte laden Sie innerhalb von 14 Tagen einen aktuellen Leistungsbescheid hoch, um die Beitragsbefreiung zu bestätigen.'**
  String get uploadLeistungsbescheidHint;

  /// No description provided for @allowedFormatsUpload.
  ///
  /// In de, this message translates to:
  /// **'Erlaubte Formate: PDF, JPG, PNG (max. 10 MB)'**
  String get allowedFormatsUpload;

  /// No description provided for @feeRegular.
  ///
  /// In de, this message translates to:
  /// **'Ihr monatlicher Mitgliedsbeitrag beträgt: 25,00 €/Monat'**
  String get feeRegular;

  /// No description provided for @paymentDayReminder.
  ///
  /// In de, this message translates to:
  /// **'Sie werden jeden {day}. des Monats an die Zahlung erinnert.'**
  String paymentDayReminder(int day);

  /// No description provided for @membershipStartPrompt.
  ///
  /// In de, this message translates to:
  /// **'Wählen Sie, ab wann Ihre Mitgliedschaft beginnen soll.'**
  String get membershipStartPrompt;

  /// No description provided for @optionAfterVerification.
  ///
  /// In de, this message translates to:
  /// **'Ab Abschluss der Verifizierung'**
  String get optionAfterVerification;

  /// No description provided for @optionAfterVerificationDesc.
  ///
  /// In de, this message translates to:
  /// **'Mitgliedschaft beginnt ab dem Tag der Bestätigung durch den Vorstand.'**
  String get optionAfterVerificationDesc;

  /// No description provided for @optionRetroFoundation.
  ///
  /// In de, this message translates to:
  /// **'Rückwirkend zum Gründungsdatum (01.08.2025)'**
  String get optionRetroFoundation;

  /// No description provided for @optionRetroFoundationDesc.
  ///
  /// In de, this message translates to:
  /// **'Sie werden retroaktiv Mitglied ab der Gründung des Vereins.'**
  String get optionRetroFoundationDesc;

  /// No description provided for @optionRetroCustom.
  ///
  /// In de, this message translates to:
  /// **'Rückwirkend zu einem anderen Datum'**
  String get optionRetroCustom;

  /// No description provided for @optionRetroCustomDesc.
  ///
  /// In de, this message translates to:
  /// **'Wählen Sie ein Datum zwischen dem 01.08.2025 und heute.'**
  String get optionRetroCustomDesc;

  /// No description provided for @selectDateLabel.
  ///
  /// In de, this message translates to:
  /// **'Datum wählen'**
  String get selectDateLabel;

  /// No description provided for @selectDateHint.
  ///
  /// In de, this message translates to:
  /// **'Datum auswählen...'**
  String get selectDateHint;

  /// No description provided for @dateNotBefore.
  ///
  /// In de, this message translates to:
  /// **'Nicht vor dem 01.08.2025 (Gründungsdatum)'**
  String get dateNotBefore;

  /// No description provided for @feeExemptRetro.
  ///
  /// In de, this message translates to:
  /// **'Beitragsbefreit: 0,00 € retroaktiv.\nNur das Mitgliedschaftsdatum wird rückwirkend gesetzt.'**
  String get feeExemptRetro;

  /// No description provided for @retroactiveFees.
  ///
  /// In de, this message translates to:
  /// **'Retroaktive Beiträge'**
  String get retroactiveFees;

  /// No description provided for @retroFeeCalculation.
  ///
  /// In de, this message translates to:
  /// **'Zeitraum: {from} – {to}\nMonate: {months}\nBeitrag: {months} × 25,00 € = {total} €'**
  String retroFeeCalculation(
      String from, String to, String months, String total);

  /// No description provided for @pleaseReadSatzung.
  ///
  /// In de, this message translates to:
  /// **'Bitte lesen Sie die Satzung des Vereins.'**
  String get pleaseReadSatzung;

  /// No description provided for @pleaseReadDatenschutz.
  ///
  /// In de, this message translates to:
  /// **'Bitte lesen Sie die Datenschutzerklärung.'**
  String get pleaseReadDatenschutz;

  /// No description provided for @pleaseReadWiderruf.
  ///
  /// In de, this message translates to:
  /// **'Bitte lesen Sie die Widerrufsbelehrung.'**
  String get pleaseReadWiderruf;

  /// No description provided for @acceptedAtRegistration.
  ///
  /// In de, this message translates to:
  /// **'Bei der Registrierung akzeptiert'**
  String get acceptedAtRegistration;

  /// No description provided for @confirmedByBoard.
  ///
  /// In de, this message translates to:
  /// **'Wird vom Vorstand nach Prüfung bestätigt.'**
  String get confirmedByBoard;

  /// No description provided for @docSatzung.
  ///
  /// In de, this message translates to:
  /// **'Satzung'**
  String get docSatzung;

  /// No description provided for @docDatenschutz.
  ///
  /// In de, this message translates to:
  /// **'Datenschutzerklärung'**
  String get docDatenschutz;

  /// No description provided for @docWiderruf.
  ///
  /// In de, this message translates to:
  /// **'Widerrufsbelehrung'**
  String get docWiderruf;

  /// No description provided for @acceptedAtRegCount.
  ///
  /// In de, this message translates to:
  /// **'Bei der Registrierung akzeptiert ({count}/3)'**
  String acceptedAtRegCount(int count);

  /// No description provided for @acceptedOn.
  ///
  /// In de, this message translates to:
  /// **'Akzeptiert am {date}'**
  String acceptedOn(String date);

  /// No description provided for @notAccepted.
  ///
  /// In de, this message translates to:
  /// **'Nicht akzeptiert'**
  String get notAccepted;

  /// No description provided for @statusAccepted.
  ///
  /// In de, this message translates to:
  /// **'Akzeptiert'**
  String get statusAccepted;

  /// No description provided for @nameTooLong.
  ///
  /// In de, this message translates to:
  /// **'Name zu lang (max 100 Zeichen)'**
  String get nameTooLong;

  /// No description provided for @emailTooLong.
  ///
  /// In de, this message translates to:
  /// **'E-Mail zu lang (max 255 Zeichen)'**
  String get emailTooLong;

  /// No description provided for @legalAcknowledgePrefix.
  ///
  /// In de, this message translates to:
  /// **'Ich habe die '**
  String get legalAcknowledgePrefix;

  /// No description provided for @legalAcknowledgeSuffix.
  ///
  /// In de, this message translates to:
  /// **' zur Kenntnis genommen.'**
  String get legalAcknowledgeSuffix;

  /// No description provided for @legalStatutesSuffix.
  ///
  /// In de, this message translates to:
  /// **' des ICD360S e.V. zur Kenntnis genommen und erkenne diese als verbindlich an.'**
  String get legalStatutesSuffix;

  /// No description provided for @legalPleaseReadFirst.
  ///
  /// In de, this message translates to:
  /// **'(bitte zuerst lesen)'**
  String get legalPleaseReadFirst;

  /// No description provided for @statusActive.
  ///
  /// In de, this message translates to:
  /// **'Aktiv'**
  String get statusActive;

  /// No description provided for @statusSuspended.
  ///
  /// In de, this message translates to:
  /// **'Gesperrt'**
  String get statusSuspended;

  /// No description provided for @statusNew.
  ///
  /// In de, this message translates to:
  /// **'Neu'**
  String get statusNew;

  /// No description provided for @statusCancelled.
  ///
  /// In de, this message translates to:
  /// **'Gekündigt'**
  String get statusCancelled;

  /// No description provided for @statusDeleted.
  ///
  /// In de, this message translates to:
  /// **'Gelöscht'**
  String get statusDeleted;

  /// No description provided for @roleMitglied.
  ///
  /// In de, this message translates to:
  /// **'Mitglied'**
  String get roleMitglied;

  /// No description provided for @roleVorsitzer.
  ///
  /// In de, this message translates to:
  /// **'Vorsitzer'**
  String get roleVorsitzer;

  /// No description provided for @roleStellvertreter.
  ///
  /// In de, this message translates to:
  /// **'Stellvertreter'**
  String get roleStellvertreter;

  /// No description provided for @roleSchatzmeister.
  ///
  /// In de, this message translates to:
  /// **'Schatzmeister'**
  String get roleSchatzmeister;

  /// No description provided for @roleSchriftfuehrer.
  ///
  /// In de, this message translates to:
  /// **'Schriftführer'**
  String get roleSchriftfuehrer;

  /// No description provided for @roleBeisitzer.
  ///
  /// In de, this message translates to:
  /// **'Beisitzer'**
  String get roleBeisitzer;

  /// No description provided for @roleKassierer.
  ///
  /// In de, this message translates to:
  /// **'Kassierer'**
  String get roleKassierer;

  /// No description provided for @roleKassenpruefer.
  ///
  /// In de, this message translates to:
  /// **'Kassenprüfer'**
  String get roleKassenpruefer;

  /// No description provided for @roleEhrenamtlich.
  ///
  /// In de, this message translates to:
  /// **'Ehrenamtlich'**
  String get roleEhrenamtlich;

  /// No description provided for @roleMitgliedergruender.
  ///
  /// In de, this message translates to:
  /// **'Mitgliedergründer'**
  String get roleMitgliedergruender;

  /// No description provided for @roleEhrenmitglied.
  ///
  /// In de, this message translates to:
  /// **'Ehrenmitglied'**
  String get roleEhrenmitglied;

  /// No description provided for @roleFoerdermitglied.
  ///
  /// In de, this message translates to:
  /// **'Fördermitglied'**
  String get roleFoerdermitglied;

  /// No description provided for @memberTypeNotSet.
  ///
  /// In de, this message translates to:
  /// **'Noch nicht festgelegt'**
  String get memberTypeNotSet;

  /// No description provided for @payMethodSepa.
  ///
  /// In de, this message translates to:
  /// **'SEPA-Lastschrift'**
  String get payMethodSepa;

  /// No description provided for @labelStatus.
  ///
  /// In de, this message translates to:
  /// **'Status'**
  String get labelStatus;

  /// No description provided for @labelMemberNumber.
  ///
  /// In de, this message translates to:
  /// **'Mitgliedernummer'**
  String get labelMemberNumber;

  /// No description provided for @labelRole.
  ///
  /// In de, this message translates to:
  /// **'Rolle'**
  String get labelRole;

  /// No description provided for @labelMemberType.
  ///
  /// In de, this message translates to:
  /// **'Mitgliedsart'**
  String get labelMemberType;

  /// No description provided for @labelPaymentMethod.
  ///
  /// In de, this message translates to:
  /// **'Zahlungsmethode'**
  String get labelPaymentMethod;

  /// No description provided for @labelRegisteredOn.
  ///
  /// In de, this message translates to:
  /// **'Registriert am'**
  String get labelRegisteredOn;

  /// No description provided for @labelLastLogin.
  ///
  /// In de, this message translates to:
  /// **'Letzter Login'**
  String get labelLastLogin;

  /// No description provided for @labelMemberSince.
  ///
  /// In de, this message translates to:
  /// **'Mitglied seit'**
  String get labelMemberSince;

  /// No description provided for @neverLoggedIn.
  ///
  /// In de, this message translates to:
  /// **'Noch nie'**
  String get neverLoggedIn;

  /// No description provided for @notActivatedYet.
  ///
  /// In de, this message translates to:
  /// **'Noch nicht aktiviert'**
  String get notActivatedYet;

  /// No description provided for @tabVerification.
  ///
  /// In de, this message translates to:
  /// **'Verifizierung'**
  String get tabVerification;

  /// No description provided for @tabWarnings.
  ///
  /// In de, this message translates to:
  /// **'Verwarnungen'**
  String get tabWarnings;

  /// No description provided for @tabDocuments.
  ///
  /// In de, this message translates to:
  /// **'Dokumente'**
  String get tabDocuments;

  /// No description provided for @tabMembership.
  ///
  /// In de, this message translates to:
  /// **'Mitgliedschaft'**
  String get tabMembership;

  /// No description provided for @pleaseEnterFirstName.
  ///
  /// In de, this message translates to:
  /// **'Bitte Vorname eingeben'**
  String get pleaseEnterFirstName;

  /// No description provided for @pleaseEnterLastName.
  ///
  /// In de, this message translates to:
  /// **'Bitte Nachname eingeben'**
  String get pleaseEnterLastName;

  /// No description provided for @noFileDataReceived.
  ///
  /// In de, this message translates to:
  /// **'Keine Dateidaten erhalten'**
  String get noFileDataReceived;

  /// No description provided for @openFile.
  ///
  /// In de, this message translates to:
  /// **'Öffnen'**
  String get openFile;

  /// No description provided for @noMicrophoneError.
  ///
  /// In de, this message translates to:
  /// **'Kein Mikrofon gefunden. Bitte schließen Sie ein Mikrofon an und versuchen Sie es erneut.'**
  String get noMicrophoneError;

  /// No description provided for @startConversation.
  ///
  /// In de, this message translates to:
  /// **'Starten Sie eine Konversation!'**
  String get startConversation;

  /// No description provided for @staffWillReply.
  ///
  /// In de, this message translates to:
  /// **'Ein Mitarbeiter wird Ihnen bald antworten.'**
  String get staffWillReply;

  /// No description provided for @inCall.
  ///
  /// In de, this message translates to:
  /// **'Im Anruf...'**
  String get inCall;

  /// No description provided for @registration.
  ///
  /// In de, this message translates to:
  /// **'Registrierung'**
  String get registration;

  /// No description provided for @deactivation.
  ///
  /// In de, this message translates to:
  /// **'Deaktivierung'**
  String get deactivation;

  /// No description provided for @deactivatedOn.
  ///
  /// In de, this message translates to:
  /// **'Deaktiviert am'**
  String get deactivatedOn;

  /// No description provided for @accountAutoSuspend.
  ///
  /// In de, this message translates to:
  /// **'Konten, die nicht innerhalb von 30 Tagen verifiziert werden, werden automatisch gesperrt.'**
  String get accountAutoSuspend;

  /// No description provided for @documentsProvidedByBoard.
  ///
  /// In de, this message translates to:
  /// **'Dokumente werden vom Vorstand bereitgestellt.'**
  String get documentsProvidedByBoard;

  /// No description provided for @noDocumentsAvailable.
  ///
  /// In de, this message translates to:
  /// **'Keine Dokumente vorhanden'**
  String get noDocumentsAvailable;

  /// No description provided for @noDocumentsDescription.
  ///
  /// In de, this message translates to:
  /// **'Es wurden noch keine Dokumente für Sie bereitgestellt.'**
  String get noDocumentsDescription;

  /// No description provided for @uploadedBy.
  ///
  /// In de, this message translates to:
  /// **'Hochgeladen von: {name}'**
  String uploadedBy(String name);

  /// No description provided for @stepsCompleted.
  ///
  /// In de, this message translates to:
  /// **'{completed}/{total} Stufen erledigt'**
  String stepsCompleted(int completed, int total);

  /// No description provided for @dayOfMonth.
  ///
  /// In de, this message translates to:
  /// **'{day}. des Monats'**
  String dayOfMonth(int day);

  /// No description provided for @changeField.
  ///
  /// In de, this message translates to:
  /// **'{field} ändern'**
  String changeField(String field);

  /// No description provided for @openDocument.
  ///
  /// In de, this message translates to:
  /// **'{name} öffnen'**
  String openDocument(String name);

  /// No description provided for @logEntries.
  ///
  /// In de, this message translates to:
  /// **'{count} Einträge'**
  String logEntries(int count);

  /// No description provided for @noLogs.
  ///
  /// In de, this message translates to:
  /// **'Keine Logs'**
  String get noLogs;

  /// No description provided for @newLoginDetected.
  ///
  /// In de, this message translates to:
  /// **'Neue Anmeldung erkannt'**
  String get newLoginDetected;

  /// No description provided for @errorNoInternet.
  ///
  /// In de, this message translates to:
  /// **'Keine Internetverbindung. Bitte überprüfen Sie Ihr Netzwerk.'**
  String get errorNoInternet;

  /// No description provided for @errorTimeout.
  ///
  /// In de, this message translates to:
  /// **'Server antwortet nicht. Bitte versuchen Sie es später erneut.'**
  String get errorTimeout;

  /// No description provided for @errorServer.
  ///
  /// In de, this message translates to:
  /// **'Serverfehler. Bitte versuchen Sie es später erneut.'**
  String get errorServer;

  /// No description provided for @errorConnection.
  ///
  /// In de, this message translates to:
  /// **'Verbindungsfehler. Bitte versuchen Sie es später erneut.'**
  String get errorConnection;

  /// No description provided for @errorUnexpected.
  ///
  /// In de, this message translates to:
  /// **'Ein unerwarteter Fehler ist aufgetreten. Bitte versuchen Sie es später erneut.'**
  String get errorUnexpected;

  /// No description provided for @securityBannerTlsInterception.
  ///
  /// In de, this message translates to:
  /// **'Ihr Netzwerk fängt sichere Verbindungen ab. Bitte wechseln Sie das Netzwerk oder deaktivieren Sie VPN/Antivirus.'**
  String get securityBannerTlsInterception;

  /// No description provided for @securityBannerDnsFailure.
  ///
  /// In de, this message translates to:
  /// **'DNS-Problem erkannt. Prüfen Sie Ihre Verbindung oder wechseln Sie das Netzwerk.'**
  String get securityBannerDnsFailure;

  /// No description provided for @securityBannerSlowNetwork.
  ///
  /// In de, this message translates to:
  /// **'Langsame Verbindung.'**
  String get securityBannerSlowNetwork;

  /// No description provided for @securityPermissionDialogTitle.
  ///
  /// In de, this message translates to:
  /// **'Möglicher Netzwerkangriff erkannt'**
  String get securityPermissionDialogTitle;

  /// No description provided for @securityPermissionDialogBody.
  ///
  /// In de, this message translates to:
  /// **'Etwas in Ihrem Netzwerk fängt möglicherweise Verbindungen ab. Um das Netzwerk zu identifizieren und Sie zu schützen, benötigen wir die Berechtigung, den WLAN-Namen zu lesen. Keine Standortverfolgung.'**
  String get securityPermissionDialogBody;

  /// No description provided for @securityPermissionDialogAllow.
  ///
  /// In de, this message translates to:
  /// **'Erlauben'**
  String get securityPermissionDialogAllow;

  /// No description provided for @securityPermissionDialogDeny.
  ///
  /// In de, this message translates to:
  /// **'Jetzt nicht'**
  String get securityPermissionDialogDeny;

  /// No description provided for @callErrorMicPermissionDenied.
  ///
  /// In de, this message translates to:
  /// **'Mikrofonzugriff ist blockiert. Aktivieren Sie ihn in Windows-Einstellungen → Datenschutz → Mikrofon (oder den Datenschutz-Einstellungen Ihres Systems) und versuchen Sie es erneut.'**
  String get callErrorMicPermissionDenied;

  /// No description provided for @callErrorMicNotFound.
  ///
  /// In de, this message translates to:
  /// **'Kein Mikrofon gefunden. Schließen Sie ein Headset oder Mikrofon an und versuchen Sie es erneut.'**
  String get callErrorMicNotFound;

  /// No description provided for @claudiuWelcomeMorning.
  ///
  /// In de, this message translates to:
  /// **'Guten Morgen'**
  String get claudiuWelcomeMorning;

  /// No description provided for @claudiuWelcomeDay.
  ///
  /// In de, this message translates to:
  /// **'Hallo'**
  String get claudiuWelcomeDay;

  /// No description provided for @claudiuWelcomeEvening.
  ///
  /// In de, this message translates to:
  /// **'Guten Abend'**
  String get claudiuWelcomeEvening;

  /// No description provided for @claudiuWelcomeNight.
  ///
  /// In de, this message translates to:
  /// **'Guten Abend'**
  String get claudiuWelcomeNight;

  /// No description provided for @claudiuWelcomeVisitor.
  ///
  /// In de, this message translates to:
  /// **'lieber Besucher'**
  String get claudiuWelcomeVisitor;

  /// No description provided for @claudiuWelcomeAsk.
  ///
  /// In de, this message translates to:
  /// **'Wie kann ich dir helfen?'**
  String get claudiuWelcomeAsk;

  /// No description provided for @claudiuWelcomeBecomeMember.
  ///
  /// In de, this message translates to:
  /// **'Ich möchte Mitglied werden'**
  String get claudiuWelcomeBecomeMember;

  /// No description provided for @claudiuWelcomeLogin.
  ///
  /// In de, this message translates to:
  /// **'Ich bin bereits Mitglied und möchte mich anmelden'**
  String get claudiuWelcomeLogin;

  /// No description provided for @claudiuWelcomeProblem.
  ///
  /// In de, this message translates to:
  /// **'Ich habe ein Problem mit der App'**
  String get claudiuWelcomeProblem;

  /// No description provided for @claudiuWelcomeEmergency.
  ///
  /// In de, this message translates to:
  /// **'Notfall — ruf uns an'**
  String get claudiuWelcomeEmergency;

  /// No description provided for @claudiuWelcomeMascotName.
  ///
  /// In de, this message translates to:
  /// **'Claudiu'**
  String get claudiuWelcomeMascotName;

  /// No description provided for @claudiuWelcomeEmergencyIntro.
  ///
  /// In de, this message translates to:
  /// **'Bevor du anrufst — unsere Geschäftszeiten:'**
  String get claudiuWelcomeEmergencyIntro;

  /// No description provided for @claudiuWelcomeScheduleOffice.
  ///
  /// In de, this message translates to:
  /// **'Im Büro'**
  String get claudiuWelcomeScheduleOffice;

  /// No description provided for @claudiuWelcomeScheduleField.
  ///
  /// In de, this message translates to:
  /// **'Beim Klienten vor Ort'**
  String get claudiuWelcomeScheduleField;

  /// No description provided for @claudiuWelcomeOutsideHoursNote.
  ///
  /// In de, this message translates to:
  /// **'Außerhalb dieser Zeiten nehmen wir nur Notfälle entgegen. Du kannst uns auch eine SMS schicken — wir melden uns zurück.'**
  String get claudiuWelcomeOutsideHoursNote;

  /// No description provided for @claudiuWelcomeCallNow.
  ///
  /// In de, this message translates to:
  /// **'Jetzt anrufen'**
  String get claudiuWelcomeCallNow;

  /// No description provided for @claudiuWelcomeSendSms.
  ///
  /// In de, this message translates to:
  /// **'SMS senden'**
  String get claudiuWelcomeSendSms;

  /// No description provided for @claudiuWelcomeSmsBody.
  ///
  /// In de, this message translates to:
  /// **'Notfall ICD360S e.V. — bitte ruft mich so schnell wie möglich zurück.'**
  String get claudiuWelcomeSmsBody;

  /// No description provided for @claudiuWelcomeCloseButton.
  ///
  /// In de, this message translates to:
  /// **'Schließen'**
  String get claudiuWelcomeCloseButton;

  /// No description provided for @claudiuLoginWelcome.
  ///
  /// In de, this message translates to:
  /// **'Willkommen zurück, liebes Mitglied!'**
  String get claudiuLoginWelcome;

  /// No description provided for @claudiuLoginAsk.
  ///
  /// In de, this message translates to:
  /// **'Bitte gib mir deine Mitgliedsnummer.'**
  String get claudiuLoginAsk;

  /// No description provided for @claudiuLoginProgress.
  ///
  /// In de, this message translates to:
  /// **'Fast geschafft… tippe weiter.'**
  String get claudiuLoginProgress;

  /// No description provided for @claudiuLoginReady.
  ///
  /// In de, this message translates to:
  /// **'Perfekt! Drück jetzt den Anmelden-Knopf.'**
  String get claudiuLoginReady;

  /// No description provided for @claudiuLoginLoading.
  ///
  /// In de, this message translates to:
  /// **'Ich prüfe die Identität… 🔍'**
  String get claudiuLoginLoading;

  /// No description provided for @claudiuLoginFoundPlain.
  ///
  /// In de, this message translates to:
  /// **'Gefunden! Du wirst jetzt eingeloggt…'**
  String get claudiuLoginFoundPlain;

  /// No description provided for @claudiuLoginFoundNamed.
  ///
  /// In de, this message translates to:
  /// **'Gefunden, {name}! Du wirst jetzt eingeloggt…'**
  String claudiuLoginFoundNamed(String name);

  /// No description provided for @claudiuLoginError.
  ///
  /// In de, this message translates to:
  /// **'Hm, die Nummer finde ich nicht. Hast du dich vielleicht vertippt?'**
  String get claudiuLoginError;

  /// No description provided for @claudiuLoginForgotHeader.
  ///
  /// In de, this message translates to:
  /// **'Mitgliedsnummer vergessen?'**
  String get claudiuLoginForgotHeader;

  /// No description provided for @claudiuLoginNoSms.
  ///
  /// In de, this message translates to:
  /// **'Wir verschicken die Nummer nicht per E-Mail oder SMS.'**
  String get claudiuLoginNoSms;

  /// No description provided for @claudiuLoginOnlyWay.
  ///
  /// In de, this message translates to:
  /// **'Der einzige Weg: ein persönlicher Termin im Vereinsbüro, mit Personalausweis.'**
  String get claudiuLoginOnlyWay;

  /// No description provided for @claudiuLoginContactUs.
  ///
  /// In de, this message translates to:
  /// **'Ruf uns an für einen Termin:'**
  String get claudiuLoginContactUs;

  /// No description provided for @claudiuDiagnosticGreeting.
  ///
  /// In de, this message translates to:
  /// **'Bevor du loslegst, eine Frage'**
  String get claudiuDiagnosticGreeting;

  /// No description provided for @claudiuDiagnosticAsk.
  ///
  /// In de, this message translates to:
  /// **'Darf ich anonyme Berichte senden, damit die Entwickler die App verbessern können?'**
  String get claudiuDiagnosticAsk;

  /// No description provided for @claudiuDiagnosticYes.
  ///
  /// In de, this message translates to:
  /// **'Ja, ich helfe gerne'**
  String get claudiuDiagnosticYes;

  /// No description provided for @claudiuDiagnosticNo.
  ///
  /// In de, this message translates to:
  /// **'Nein, ich schaue mich nur um'**
  String get claudiuDiagnosticNo;

  /// No description provided for @claudiuDiagnosticTellMore.
  ///
  /// In de, this message translates to:
  /// **'Mehr Details'**
  String get claudiuDiagnosticTellMore;

  /// No description provided for @claudiuDiagnosticSendsHeader.
  ///
  /// In de, this message translates to:
  /// **'📤 Was wir SENDEN (anonym):'**
  String get claudiuDiagnosticSendsHeader;

  /// No description provided for @claudiuDiagnosticSends1.
  ///
  /// In de, this message translates to:
  /// **'Ein anonymer Gerätecode (NICHT die Mitgliedsnummer)'**
  String get claudiuDiagnosticSends1;

  /// No description provided for @claudiuDiagnosticSends2.
  ///
  /// In de, this message translates to:
  /// **'Deine Rolle (Mitglied / Vorstand)'**
  String get claudiuDiagnosticSends2;

  /// No description provided for @claudiuDiagnosticSends3.
  ///
  /// In de, this message translates to:
  /// **'Betriebssystem (Linux / Android / iOS / Windows)'**
  String get claudiuDiagnosticSends3;

  /// No description provided for @claudiuDiagnosticSends4.
  ///
  /// In de, this message translates to:
  /// **'Gewählte Sprache'**
  String get claudiuDiagnosticSends4;

  /// No description provided for @claudiuDiagnosticSends5.
  ///
  /// In de, this message translates to:
  /// **'Akkustand + Status'**
  String get claudiuDiagnosticSends5;

  /// No description provided for @claudiuDiagnosticSends6.
  ///
  /// In de, this message translates to:
  /// **'Aktueller Bildschirm'**
  String get claudiuDiagnosticSends6;

  /// No description provided for @claudiuDiagnosticSends7.
  ///
  /// In de, this message translates to:
  /// **'Sitzungsdauer (Sekunden)'**
  String get claudiuDiagnosticSends7;

  /// No description provided for @claudiuDiagnosticSends8.
  ///
  /// In de, this message translates to:
  /// **'Fehler falls vorhanden (letzte 10)'**
  String get claudiuDiagnosticSends8;

  /// No description provided for @claudiuDiagnosticSends9.
  ///
  /// In de, this message translates to:
  /// **'Navigation (letzte 20 Bildschirme)'**
  String get claudiuDiagnosticSends9;

  /// No description provided for @claudiuDiagnosticSends10.
  ///
  /// In de, this message translates to:
  /// **'Wie oft die App Daten gesendet hat (nur Anzahl, kein Inhalt)'**
  String get claudiuDiagnosticSends10;

  /// No description provided for @claudiuDiagnosticSends11.
  ///
  /// In de, this message translates to:
  /// **'Wie das System die App einstuft und wie schnell sich der Akku entlädt'**
  String get claudiuDiagnosticSends11;

  /// No description provided for @claudiuDiagnosticNeverHeader.
  ///
  /// In de, this message translates to:
  /// **'🛡️ Was wir NIE senden:'**
  String get claudiuDiagnosticNeverHeader;

  /// No description provided for @claudiuDiagnosticNever1.
  ///
  /// In de, this message translates to:
  /// **'Dein echter Name'**
  String get claudiuDiagnosticNever1;

  /// No description provided for @claudiuDiagnosticNever2.
  ///
  /// In de, this message translates to:
  /// **'E-Mail-Adresse'**
  String get claudiuDiagnosticNever2;

  /// No description provided for @claudiuDiagnosticNever3.
  ///
  /// In de, this message translates to:
  /// **'Telefonnummer'**
  String get claudiuDiagnosticNever3;

  /// No description provided for @claudiuDiagnosticNever4.
  ///
  /// In de, this message translates to:
  /// **'Passwort'**
  String get claudiuDiagnosticNever4;

  /// No description provided for @claudiuDiagnosticNever5.
  ///
  /// In de, this message translates to:
  /// **'Inhalte deiner Chat-Nachrichten'**
  String get claudiuDiagnosticNever5;

  /// No description provided for @claudiuDiagnosticNever6.
  ///
  /// In de, this message translates to:
  /// **'Inhalte deiner Tickets'**
  String get claudiuDiagnosticNever6;

  /// No description provided for @claudiuDiagnosticNever7.
  ///
  /// In de, this message translates to:
  /// **'Dokumente oder Anhänge'**
  String get claudiuDiagnosticNever7;

  /// No description provided for @claudiuDiagnosticTechHeader.
  ///
  /// In de, this message translates to:
  /// **'📡 Technische Details:'**
  String get claudiuDiagnosticTechHeader;

  /// No description provided for @claudiuDiagnosticTech1.
  ///
  /// In de, this message translates to:
  /// **'Wird alle 15 Minuten gesendet'**
  String get claudiuDiagnosticTech1;

  /// No description provided for @claudiuDiagnosticTech2.
  ///
  /// In de, this message translates to:
  /// **'TLS-verschlüsselte Verbindung mit Pinned-Zertifikat'**
  String get claudiuDiagnosticTech2;

  /// No description provided for @claudiuDiagnosticTech3.
  ///
  /// In de, this message translates to:
  /// **'Du kannst es jederzeit in den Einstellungen abschalten'**
  String get claudiuDiagnosticTech3;

  /// No description provided for @claudiuProblemHelpTitle.
  ///
  /// In de, this message translates to:
  /// **'Wie kann ich helfen?'**
  String get claudiuProblemHelpTitle;

  /// No description provided for @claudiuProblemHelpGreeting.
  ///
  /// In de, this message translates to:
  /// **'Was ist passiert?'**
  String get claudiuProblemHelpGreeting;

  /// No description provided for @claudiuProblemHelpAsk.
  ///
  /// In de, this message translates to:
  /// **'Wie möchtest du es mir mitteilen?'**
  String get claudiuProblemHelpAsk;

  /// No description provided for @claudiuProblemHelpWriteTitle.
  ///
  /// In de, this message translates to:
  /// **'Bericht schreiben'**
  String get claudiuProblemHelpWriteTitle;

  /// No description provided for @claudiuProblemHelpWriteBody.
  ///
  /// In de, this message translates to:
  /// **'Mit Schritt-für-Schritt-Details. Das Team erhält den Text und kümmert sich später darum.'**
  String get claudiuProblemHelpWriteBody;

  /// No description provided for @claudiuProblemHelpChatTitle.
  ///
  /// In de, this message translates to:
  /// **'Jetzt sprechen'**
  String get claudiuProblemHelpChatTitle;

  /// No description provided for @claudiuProblemHelpChatBody.
  ///
  /// In de, this message translates to:
  /// **'Anonymer Chat mit einem Mitarbeiter. Antwort in Echtzeit, falls jemand online ist.'**
  String get claudiuProblemHelpChatBody;

  /// No description provided for @claudiuProblemHelpAltCallHeader.
  ///
  /// In de, this message translates to:
  /// **'Oder bei dringenden Anliegen:'**
  String get claudiuProblemHelpAltCallHeader;

  /// No description provided for @claudiuProblemHelpAltCallLabel.
  ///
  /// In de, this message translates to:
  /// **'Ruf uns an'**
  String get claudiuProblemHelpAltCallLabel;

  /// No description provided for @claudiuAnonymousChatTitle.
  ///
  /// In de, this message translates to:
  /// **'Anonymer Chat'**
  String get claudiuAnonymousChatTitle;

  /// No description provided for @claudiuAnonymousChatGreeting.
  ///
  /// In de, this message translates to:
  /// **'Hallo!'**
  String get claudiuAnonymousChatGreeting;

  /// No description provided for @claudiuAnonymousChatWelcome.
  ///
  /// In de, this message translates to:
  /// **'Ich höre dir zu. Schreib alles, was dich bewegt — ich brauche keinen Namen. Ich antworte, sobald ich da bin.'**
  String get claudiuAnonymousChatWelcome;

  /// No description provided for @claudiuAnonymousChatHint.
  ///
  /// In de, this message translates to:
  /// **'Nachricht schreiben…'**
  String get claudiuAnonymousChatHint;

  /// No description provided for @claudiuAnonymousChatWaitingOperator.
  ///
  /// In de, this message translates to:
  /// **'Wir warten, bis ein Mitarbeiter antwortet…'**
  String get claudiuAnonymousChatWaitingOperator;

  /// No description provided for @claudiuVorsitzerConnectedTitle.
  ///
  /// In de, this message translates to:
  /// **'Hallo!'**
  String get claudiuVorsitzerConnectedTitle;

  /// No description provided for @claudiuVorsitzerConnectedBody.
  ///
  /// In de, this message translates to:
  /// **'Danke, dass du dich gemeldet hast — du bist jetzt mit einem Vorsitzer verbunden. Schreib uns, wie wir dir bei deinem Mitgliedsantrag helfen können.'**
  String get claudiuVorsitzerConnectedBody;

  /// No description provided for @claudiuVorsitzerConnectedSender.
  ///
  /// In de, this message translates to:
  /// **'Vorsitzer'**
  String get claudiuVorsitzerConnectedSender;

  /// No description provided for @claudiuQuickReplyValidationTime.
  ///
  /// In de, this message translates to:
  /// **'Wie lange dauert die Prüfung?'**
  String get claudiuQuickReplyValidationTime;

  /// No description provided for @claudiuQuickReplyDocuments.
  ///
  /// In de, this message translates to:
  /// **'Welche Dokumente brauche ich?'**
  String get claudiuQuickReplyDocuments;

  /// No description provided for @claudiuQuickReplyStepProblem.
  ///
  /// In de, this message translates to:
  /// **'Ich komme bei einem Schritt nicht weiter'**
  String get claudiuQuickReplyStepProblem;

  /// No description provided for @claudiuQuickReplyHuman.
  ///
  /// In de, this message translates to:
  /// **'Kann ich jetzt mit jemandem sprechen?'**
  String get claudiuQuickReplyHuman;

  /// No description provided for @claudiuAnonymousChatConnecting.
  ///
  /// In de, this message translates to:
  /// **'Verbinde…'**
  String get claudiuAnonymousChatConnecting;

  /// No description provided for @claudiuAnonymousChatConnectionFailed.
  ///
  /// In de, this message translates to:
  /// **'Chat konnte nicht geöffnet werden. Versuch erneut oder ruf an.'**
  String get claudiuAnonymousChatConnectionFailed;

  /// No description provided for @claudiuAnonymousChatRetry.
  ///
  /// In de, this message translates to:
  /// **'Erneut versuchen'**
  String get claudiuAnonymousChatRetry;

  /// No description provided for @claudiuAnonymousChatOnline.
  ///
  /// In de, this message translates to:
  /// **'Verbunden'**
  String get claudiuAnonymousChatOnline;

  /// No description provided for @claudiuAnonymousChatOffline.
  ///
  /// In de, this message translates to:
  /// **'Wiederverbindung…'**
  String get claudiuAnonymousChatOffline;

  /// No description provided for @claudiuAnonymousChatAdminTyping.
  ///
  /// In de, this message translates to:
  /// **'Mitarbeiter schreibt…'**
  String get claudiuAnonymousChatAdminTyping;

  /// No description provided for @claudiuProblemReportTitle.
  ///
  /// In de, this message translates to:
  /// **'Problem melden'**
  String get claudiuProblemReportTitle;

  /// No description provided for @claudiuProblemReportGreeting.
  ///
  /// In de, this message translates to:
  /// **'Was ist passiert?'**
  String get claudiuProblemReportGreeting;

  /// No description provided for @claudiuProblemReportAsk.
  ///
  /// In de, this message translates to:
  /// **'Beschreibe es im Detail, und ich leite den Bericht weiter.'**
  String get claudiuProblemReportAsk;

  /// No description provided for @claudiuProblemReportIncludeHeader.
  ///
  /// In de, this message translates to:
  /// **'Bitte mit angeben:'**
  String get claudiuProblemReportIncludeHeader;

  /// No description provided for @claudiuProblemReportIncludeBullets1.
  ///
  /// In de, this message translates to:
  /// **'Was du gerade gemacht hast'**
  String get claudiuProblemReportIncludeBullets1;

  /// No description provided for @claudiuProblemReportIncludeBullets2.
  ///
  /// In de, this message translates to:
  /// **'Welche Fehlermeldung erschien'**
  String get claudiuProblemReportIncludeBullets2;

  /// No description provided for @claudiuProblemReportIncludeBullets3.
  ///
  /// In de, this message translates to:
  /// **'Auf welchem Bildschirm du warst'**
  String get claudiuProblemReportIncludeBullets3;

  /// No description provided for @claudiuProblemReportIncludeBullets4.
  ///
  /// In de, this message translates to:
  /// **'Stürzt die App ab? Wird sie weiß? Schließt sie sich?'**
  String get claudiuProblemReportIncludeBullets4;

  /// No description provided for @claudiuProblemReportIncludeBullets5.
  ///
  /// In de, this message translates to:
  /// **'Passiert es einmalig oder wiederholt'**
  String get claudiuProblemReportIncludeBullets5;

  /// No description provided for @claudiuProblemReportDescriptionLabel.
  ///
  /// In de, this message translates to:
  /// **'Deine Beschreibung'**
  String get claudiuProblemReportDescriptionLabel;

  /// No description provided for @claudiuProblemReportDescriptionHint.
  ///
  /// In de, this message translates to:
  /// **'Z.B.: Beim Öffnen des Chat-Bildschirms erscheint „Connection error\" und die App reagiert nicht mehr…'**
  String get claudiuProblemReportDescriptionHint;

  /// No description provided for @claudiuProblemReportTooShort.
  ///
  /// In de, this message translates to:
  /// **'Bitte etwas ausführlicher (mind. {count} Zeichen)'**
  String claudiuProblemReportTooShort(int count);

  /// No description provided for @claudiuProblemReportSubmit.
  ///
  /// In de, this message translates to:
  /// **'Bericht senden'**
  String get claudiuProblemReportSubmit;

  /// No description provided for @claudiuProblemReportSubmitting.
  ///
  /// In de, this message translates to:
  /// **'Wird gesendet…'**
  String get claudiuProblemReportSubmitting;

  /// No description provided for @claudiuProblemReportSentTitle.
  ///
  /// In de, this message translates to:
  /// **'Danke!'**
  String get claudiuProblemReportSentTitle;

  /// No description provided for @claudiuProblemReportSentBody.
  ///
  /// In de, this message translates to:
  /// **'Der Bericht wurde gesendet. Unser Team schaut so schnell wie möglich darauf.'**
  String get claudiuProblemReportSentBody;

  /// No description provided for @claudiuProblemReportSentClose.
  ///
  /// In de, this message translates to:
  /// **'Verstanden'**
  String get claudiuProblemReportSentClose;

  /// No description provided for @claudiuProblemReportSendFailed.
  ///
  /// In de, this message translates to:
  /// **'Bericht konnte nicht gesendet werden. Ruf uns bei dringenden Anliegen an.'**
  String get claudiuProblemReportSendFailed;

  /// No description provided for @claudiuProblemReportAlt.
  ///
  /// In de, this message translates to:
  /// **'Oder bei dringenden Anliegen:'**
  String get claudiuProblemReportAlt;

  /// No description provided for @claudiuProblemReportCallLabel.
  ///
  /// In de, this message translates to:
  /// **'Ruf uns an'**
  String get claudiuProblemReportCallLabel;

  /// No description provided for @claudiuApprovalGreeting.
  ///
  /// In de, this message translates to:
  /// **'Hallo, {name}! 👋'**
  String claudiuApprovalGreeting(String name);

  /// No description provided for @claudiuApprovalGreetingNoName.
  ///
  /// In de, this message translates to:
  /// **'Hallo! 👋'**
  String get claudiuApprovalGreetingNoName;

  /// No description provided for @claudiuApprovalGladToSeeYou.
  ///
  /// In de, this message translates to:
  /// **'Schön, dass du da bist!'**
  String get claudiuApprovalGladToSeeYou;

  /// No description provided for @claudiuApprovalCheckingForSafety.
  ///
  /// In de, this message translates to:
  /// **'Zu deiner Sicherheit prüft ein Vorsitzer gerade deine Anmeldeanfrage. 🛡️'**
  String get claudiuApprovalCheckingForSafety;

  /// No description provided for @claudiuApprovalMonthlyExplain.
  ///
  /// In de, this message translates to:
  /// **'💡 Wir machen das alle 30 Tage, um sicher zu sein, dass du es bist. Es ist wie ein Sicherheits-Check-up — dauert maximal 5 Minuten.'**
  String get claudiuApprovalMonthlyExplain;

  /// No description provided for @claudiuApprovalSuccess.
  ///
  /// In de, this message translates to:
  /// **'Fertig! 🎉 Der Vorsitzer hat dich erkannt. Du wirst jetzt eingeloggt…'**
  String get claudiuApprovalSuccess;

  /// No description provided for @claudiuApprovalDenied.
  ///
  /// In de, this message translates to:
  /// **'Hm, der Vorsitzer hat deine Anfrage abgelehnt. 😔'**
  String get claudiuApprovalDenied;

  /// No description provided for @claudiuApprovalDeniedHelp.
  ///
  /// In de, this message translates to:
  /// **'Wenn du denkst, das ist ein Fehler, ruf uns bitte an, damit wir es klären.'**
  String get claudiuApprovalDeniedHelp;

  /// No description provided for @claudiuApprovalExpired.
  ///
  /// In de, this message translates to:
  /// **'Die 5 Minuten sind vorbei und wir haben keine Antwort vom Vorsitzer erhalten.'**
  String get claudiuApprovalExpired;

  /// No description provided for @claudiuApprovalExpiredHelp.
  ///
  /// In de, this message translates to:
  /// **'Ruf uns an und wir können deine Anfrage direkt vor Ort genehmigen. 📞'**
  String get claudiuApprovalExpiredHelp;

  /// No description provided for @claudiuApprovalCallUs.
  ///
  /// In de, this message translates to:
  /// **'Ruf uns an'**
  String get claudiuApprovalCallUs;

  /// No description provided for @claudiuApprovalTryAgain.
  ///
  /// In de, this message translates to:
  /// **'Erneut versuchen'**
  String get claudiuApprovalTryAgain;

  /// No description provided for @claudiuApprovalCancel.
  ///
  /// In de, this message translates to:
  /// **'Abbrechen'**
  String get claudiuApprovalCancel;

  /// No description provided for @claudiuApprovalClose.
  ///
  /// In de, this message translates to:
  /// **'Schließen'**
  String get claudiuApprovalClose;

  /// No description provided for @wizardIntroBubble1.
  ///
  /// In de, this message translates to:
  /// **'Hallo, Besucher! 👋 Danke, dass du Teil unserer Familie werden möchtest.'**
  String get wizardIntroBubble1;

  /// No description provided for @wizardIntroBubble2.
  ///
  /// In de, this message translates to:
  /// **'Ich heiße Claudiu. Im Frühjahr 2025 hatte ich eine klare Vision: einen Verein zu gründen, der Menschen in Not hilft — ehrenamtlich, von Herzen, ohne unnötige Bürokratie. ❤️'**
  String get wizardIntroBubble2;

  /// No description provided for @wizardIntroBubble3.
  ///
  /// In de, this message translates to:
  /// **'Ich fing an, mit den Klienten zu sprechen, die ich besuchte. Ich erzählte ihnen meinen Traum. Und jeder sagte: „Ja, los!\" Im Juli 2025 trafen wir uns — 6 entschlossene Menschen. Wir beschlossen, **ICD360S e.V.** in Neu-Ulm zu gründen. 📍'**
  String get wizardIntroBubble3;

  /// No description provided for @wizardIntroBubble4.
  ///
  /// In de, this message translates to:
  /// **'Am **1. August 2025** wurde der Verein offiziell ins Vereinsregister eingetragen — mein schönstes Geschenk. 🎂'**
  String get wizardIntroBubble4;

  /// No description provided for @wizardIntroBubble5.
  ///
  /// In de, this message translates to:
  /// **'Was machen wir? Wir helfen Geflüchteten, Menschen mit Behinderung, wirtschaftlich Benachteiligten, **Kindern und Jugendlichen** — bei Behördengängen, Deutsch lernen, Wohnungssuche, Einkäufen, Sozialleistungen. Unser Vorstand besteht mehrheitlich aus Menschen mit Behinderung — so kommen die Entscheidungen aus echter Lebenserfahrung. 🤝'**
  String get wizardIntroBubble5;

  /// No description provided for @wizardIntroBubble6.
  ///
  /// In de, this message translates to:
  /// **'Jetzt bist du dran. Lass uns dich anmelden — dauert ca. 5 Minuten. Wir gehen Schritt für Schritt, ich lasse dich nicht allein. ✨'**
  String get wizardIntroBubble6;

  /// No description provided for @wizardIntroStart.
  ///
  /// In de, this message translates to:
  /// **'Lass uns anfangen'**
  String get wizardIntroStart;

  /// No description provided for @wizardBack.
  ///
  /// In de, this message translates to:
  /// **'Zurück'**
  String get wizardBack;

  /// No description provided for @wizardNext.
  ///
  /// In de, this message translates to:
  /// **'Weiter'**
  String get wizardNext;

  /// No description provided for @wizardStepLabel.
  ///
  /// In de, this message translates to:
  /// **'Schritt {step} von {total} · {title}'**
  String wizardStepLabel(int step, int total, String title);

  /// No description provided for @wizardErrRequired.
  ///
  /// In de, this message translates to:
  /// **'Dieses Feld ist erforderlich'**
  String get wizardErrRequired;

  /// No description provided for @wizardErrTooShort.
  ///
  /// In de, this message translates to:
  /// **'Zu kurz (mindestens {count} Zeichen)'**
  String wizardErrTooShort(int count);

  /// No description provided for @wizardErrOnlyLetters.
  ///
  /// In de, this message translates to:
  /// **'Nur Buchstaben, Leerzeichen, Bindestriche und Apostroph'**
  String get wizardErrOnlyLetters;

  /// No description provided for @wizardErrSaveFailed.
  ///
  /// In de, this message translates to:
  /// **'Speichern fehlgeschlagen. Verbindung prüfen und erneut versuchen.'**
  String get wizardErrSaveFailed;

  /// No description provided for @wizardStufe1aTitle.
  ///
  /// In de, this message translates to:
  /// **'Identität'**
  String get wizardStufe1aTitle;

  /// No description provided for @wizardStufe1aPrompt.
  ///
  /// In de, this message translates to:
  /// **'Wir lernen dich offiziell kennen. Bitte schreib deinen Namen genau so, wie er auf Personalausweis, Reisepass oder Aufenthaltstitel steht — dann passt es zu deinen Dokumenten.'**
  String get wizardStufe1aPrompt;

  /// No description provided for @wizardStufe1aVornameLabel.
  ///
  /// In de, this message translates to:
  /// **'Vornamen'**
  String get wizardStufe1aVornameLabel;

  /// No description provided for @wizardStufe1aVornameHelper.
  ///
  /// In de, this message translates to:
  /// **'Alle deine Vornamen, genau wie auf dem Ausweis. Mit Leerzeichen oder Bindestrich (z.B. Hans-Peter, Maria Anna).'**
  String get wizardStufe1aVornameHelper;

  /// No description provided for @wizardStufe1aNachnameLabel.
  ///
  /// In de, this message translates to:
  /// **'Familienname'**
  String get wizardStufe1aNachnameLabel;

  /// No description provided for @wizardStufe1aNachnameHelper.
  ///
  /// In de, this message translates to:
  /// **'Dein aktueller Familienname.'**
  String get wizardStufe1aNachnameHelper;

  /// No description provided for @wizardStufe1aGeburtsnameLabel.
  ///
  /// In de, this message translates to:
  /// **'Geburtsname (optional)'**
  String get wizardStufe1aGeburtsnameLabel;

  /// No description provided for @wizardStufe1aGeburtsnameHelper.
  ///
  /// In de, this message translates to:
  /// **'Nur wenn er vom Familiennamen abweicht — z.B. vor der Heirat.'**
  String get wizardStufe1aGeburtsnameHelper;

  /// No description provided for @wizardStufe1bTitle.
  ///
  /// In de, this message translates to:
  /// **'Geburtstag'**
  String get wizardStufe1bTitle;

  /// No description provided for @wizardStufe1bPrompt.
  ///
  /// In de, this message translates to:
  /// **'Wir möchten deinen Geburtstag mit dir feiern! 🎂 Und es hilft uns zu wissen, dass du mindestens 16 bist — so steht es in unserer Satzung.'**
  String get wizardStufe1bPrompt;

  /// No description provided for @wizardStufe1bGeburtsdatumLabel.
  ///
  /// In de, this message translates to:
  /// **'Geburtsdatum'**
  String get wizardStufe1bGeburtsdatumLabel;

  /// No description provided for @wizardStufe1bGeburtsdatumHelper.
  ///
  /// In de, this message translates to:
  /// **'Tippen zum Auswählen'**
  String get wizardStufe1bGeburtsdatumHelper;

  /// No description provided for @wizardStufe1bGeburtsortLabel.
  ///
  /// In de, this message translates to:
  /// **'Geburtsort'**
  String get wizardStufe1bGeburtsortLabel;

  /// No description provided for @wizardStufe1bGeburtsortHelper.
  ///
  /// In de, this message translates to:
  /// **'Stadt / Ort, wo du geboren wurdest.'**
  String get wizardStufe1bGeburtsortHelper;

  /// No description provided for @wizardAgeGatePrompt.
  ///
  /// In de, this message translates to:
  /// **'Es tut mir leid… 😔'**
  String get wizardAgeGatePrompt;

  /// No description provided for @wizardAgeGateBody1.
  ///
  /// In de, this message translates to:
  /// **'Unsere Satzung sagt, du musst mindestens 16 sein, um Mitglied zu werden. Du bist {age} — ich hoffe, wir sehen uns in {years} Jahren wieder! 🌱'**
  String wizardAgeGateBody1(int age, int years);

  /// No description provided for @wizardAgeGateBody2.
  ///
  /// In de, this message translates to:
  /// **'Wenn du dich punktuell als Ehrenamtliche*r engagieren möchtest (jedes Alter, mit Erlaubnis der Eltern), ruf uns an — wir freuen uns, junge Menschen zu unterstützen, die die Welt verändern wollen.'**
  String get wizardAgeGateBody2;

  /// No description provided for @wizardAgeGateBackHome.
  ///
  /// In de, this message translates to:
  /// **'Zurück zum Start'**
  String get wizardAgeGateBackHome;

  /// No description provided for @wizardErrInvalidPhone.
  ///
  /// In de, this message translates to:
  /// **'Ungültige Telefonnummer'**
  String get wizardErrInvalidPhone;

  /// No description provided for @wizardStufe1b1Title.
  ///
  /// In de, this message translates to:
  /// **'Einwilligung Eltern'**
  String get wizardStufe1b1Title;

  /// No description provided for @wizardStufe1b1Prompt.
  ///
  /// In de, this message translates to:
  /// **'Du bist minderjährig (16-17) — gemäß §106 BGB brauchen wir die Zustimmung eines Elternteils oder gesetzlichen Vertreters. Gib mir Namen und Telefonnummer. Ein Vorsitzer ruft an und vereinbart ein Treffen (persönlich oder per Videoanruf). Keine E-Mail — wir wollen sicher sein, dass wir mit der richtigen Person sprechen.'**
  String get wizardStufe1b1Prompt;

  /// No description provided for @wizardStufe1b1VornameLabel.
  ///
  /// In de, this message translates to:
  /// **'Vorname Erziehungsberechtigter'**
  String get wizardStufe1b1VornameLabel;

  /// No description provided for @wizardStufe1b1VornameHelper.
  ///
  /// In de, this message translates to:
  /// **'Wie auf dem Personalausweis des Elternteils.'**
  String get wizardStufe1b1VornameHelper;

  /// No description provided for @wizardStufe1b1NachnameLabel.
  ///
  /// In de, this message translates to:
  /// **'Familienname Erziehungsberechtigter'**
  String get wizardStufe1b1NachnameLabel;

  /// No description provided for @wizardStufe1b1NachnameHelper.
  ///
  /// In de, this message translates to:
  /// **'Wie auf dem Personalausweis des Elternteils.'**
  String get wizardStufe1b1NachnameHelper;

  /// No description provided for @wizardStufe1b1TelefonLabel.
  ///
  /// In de, this message translates to:
  /// **'Mobilnummer Erziehungsberechtigter'**
  String get wizardStufe1b1TelefonLabel;

  /// No description provided for @wizardStufe1b1TelefonHelper.
  ///
  /// In de, this message translates to:
  /// **'An diese Nummer ruft ein Vorsitzer an.'**
  String get wizardStufe1b1TelefonHelper;

  /// No description provided for @wizardStufe1b1RelationLabel.
  ///
  /// In de, this message translates to:
  /// **'Verhältnis zum Kind:'**
  String get wizardStufe1b1RelationLabel;

  /// No description provided for @wizardStufe1b1RelationMutter.
  ///
  /// In de, this message translates to:
  /// **'Mutter'**
  String get wizardStufe1b1RelationMutter;

  /// No description provided for @wizardStufe1b1RelationVater.
  ///
  /// In de, this message translates to:
  /// **'Vater'**
  String get wizardStufe1b1RelationVater;

  /// No description provided for @wizardStufe1b1RelationSorgeberechtigter.
  ///
  /// In de, this message translates to:
  /// **'Sorgeberechtigter'**
  String get wizardStufe1b1RelationSorgeberechtigter;

  /// No description provided for @wizardStufe1b1RelationAndere.
  ///
  /// In de, this message translates to:
  /// **'Andere/r Erziehungsberechtigte/r'**
  String get wizardStufe1b1RelationAndere;

  /// No description provided for @wizardStufe1cTitle.
  ///
  /// In de, this message translates to:
  /// **'Persönliche Details'**
  String get wizardStufe1cTitle;

  /// No description provided for @wizardStufe1cPrompt.
  ///
  /// In de, this message translates to:
  /// **'Nur damit ich dich etwas besser kennenlerne. Diese Angaben bleiben unter uns und erscheinen nirgendwo öffentlich.'**
  String get wizardStufe1cPrompt;

  /// No description provided for @wizardStufe1cGeschlechtLabel.
  ///
  /// In de, this message translates to:
  /// **'Geschlecht'**
  String get wizardStufe1cGeschlechtLabel;

  /// No description provided for @wizardStufe1cGeschlechtMaennlich.
  ///
  /// In de, this message translates to:
  /// **'Männlich'**
  String get wizardStufe1cGeschlechtMaennlich;

  /// No description provided for @wizardStufe1cGeschlechtWeiblich.
  ///
  /// In de, this message translates to:
  /// **'Weiblich'**
  String get wizardStufe1cGeschlechtWeiblich;

  /// No description provided for @wizardStufe1cGeschlechtDivers.
  ///
  /// In de, this message translates to:
  /// **'Divers'**
  String get wizardStufe1cGeschlechtDivers;

  /// No description provided for @wizardStufe1cGeschlechtKeineAngabe.
  ///
  /// In de, this message translates to:
  /// **'Keine Angabe'**
  String get wizardStufe1cGeschlechtKeineAngabe;

  /// No description provided for @wizardStufe1cFamilienstandLabel.
  ///
  /// In de, this message translates to:
  /// **'Familienstand'**
  String get wizardStufe1cFamilienstandLabel;

  /// No description provided for @wizardStufe1cFamilienstandLedig.
  ///
  /// In de, this message translates to:
  /// **'Ledig'**
  String get wizardStufe1cFamilienstandLedig;

  /// No description provided for @wizardStufe1cFamilienstandVerheiratet.
  ///
  /// In de, this message translates to:
  /// **'Verheiratet'**
  String get wizardStufe1cFamilienstandVerheiratet;

  /// No description provided for @wizardStufe1cFamilienstandGeschieden.
  ///
  /// In de, this message translates to:
  /// **'Geschieden'**
  String get wizardStufe1cFamilienstandGeschieden;

  /// No description provided for @wizardStufe1cFamilienstandVerwitwet.
  ///
  /// In de, this message translates to:
  /// **'Verwitwet'**
  String get wizardStufe1cFamilienstandVerwitwet;

  /// No description provided for @wizardStufe1dTitle.
  ///
  /// In de, this message translates to:
  /// **'Herkunft'**
  String get wizardStufe1dTitle;

  /// No description provided for @wizardStufe1dPrompt.
  ///
  /// In de, this message translates to:
  /// **'Das hilft uns, dir die richtige Unterstützung anzubieten — zum Beispiel Beratung beim Aufenthalt oder das Finden deiner Sprachcommunity.'**
  String get wizardStufe1dPrompt;

  /// No description provided for @wizardStufe1dStaatLabel.
  ///
  /// In de, this message translates to:
  /// **'Staatsangehörigkeit'**
  String get wizardStufe1dStaatLabel;

  /// No description provided for @wizardStufe1dStaatHelper.
  ///
  /// In de, this message translates to:
  /// **'Z.B. deutsch, rumänisch, ukrainisch. Mehrere mit Komma getrennt.'**
  String get wizardStufe1dStaatHelper;

  /// No description provided for @wizardStufe1dAufenthaltLabel.
  ///
  /// In de, this message translates to:
  /// **'Aufenthaltsstatus (optional)'**
  String get wizardStufe1dAufenthaltLabel;

  /// No description provided for @wizardStufe1dAufenthaltHelper.
  ///
  /// In de, this message translates to:
  /// **'Wähle den Titel aus deinem Aufenthaltskarte / Bescheid. Der Vorstand gleicht mit den Dokumenten ab.'**
  String get wizardStufe1dAufenthaltHelper;

  /// No description provided for @wizardStufe1dAufenthaltAwaitingCitizenship.
  ///
  /// In de, this message translates to:
  /// **'Bitte oben zuerst die Staatsangehörigkeit eintragen — wir zeigen nur die passenden Optionen.'**
  String get wizardStufe1dAufenthaltAwaitingCitizenship;

  /// No description provided for @wizardStufe1dAufenthaltGerman.
  ///
  /// In de, this message translates to:
  /// **'Kein Aufenthaltstitel erforderlich — Deutscher Staatsangehöriger.'**
  String get wizardStufe1dAufenthaltGerman;

  /// No description provided for @wizardStufe1dAufenthaltEuEea.
  ///
  /// In de, this message translates to:
  /// **'EU-/EWR-/CH-Bürger — Freizügigkeit.'**
  String get wizardStufe1dAufenthaltEuEea;

  /// No description provided for @wizardStufe1dAufenthaltTempHint.
  ///
  /// In de, this message translates to:
  /// **'befristet'**
  String get wizardStufe1dAufenthaltTempHint;

  /// No description provided for @wizardStufe1dAufenthaltPermHint.
  ///
  /// In de, this message translates to:
  /// **'unbefristet'**
  String get wizardStufe1dAufenthaltPermHint;

  /// No description provided for @wizardStufe1dAufenthaltAsylumProcessHint.
  ///
  /// In de, this message translates to:
  /// **'Asylverfahren'**
  String get wizardStufe1dAufenthaltAsylumProcessHint;

  /// No description provided for @wizardStufe1dAufenthaltOther.
  ///
  /// In de, this message translates to:
  /// **'Sonstige (bitte im Chat angeben)'**
  String get wizardStufe1dAufenthaltOther;

  /// No description provided for @wizardStufe1dAufenthaltRequired.
  ///
  /// In de, this message translates to:
  /// **'Bitte einen Aufenthaltstitel auswählen.'**
  String get wizardStufe1dAufenthaltRequired;

  /// No description provided for @wizardStufe1dMutterspracheLabel.
  ///
  /// In de, this message translates to:
  /// **'Muttersprache'**
  String get wizardStufe1dMutterspracheLabel;

  /// No description provided for @wizardStufe1dMutterspracheHelper.
  ///
  /// In de, this message translates to:
  /// **'Vorausgefüllt mit der App-Sprache — ändere falls anders.'**
  String get wizardStufe1dMutterspracheHelper;

  /// No description provided for @wizardStufe1eTitle.
  ///
  /// In de, this message translates to:
  /// **'Adresse'**
  String get wizardStufe1eTitle;

  /// No description provided for @wizardStufe1ePrompt.
  ///
  /// In de, this message translates to:
  /// **'Deine Postanschrift — wir nutzen sie für offizielle Unterlagen (Satzung, Mitgliedsverträge, Mitteilungen).'**
  String get wizardStufe1ePrompt;

  /// No description provided for @wizardStufe1eStrasseLabel.
  ///
  /// In de, this message translates to:
  /// **'Straße'**
  String get wizardStufe1eStrasseLabel;

  /// No description provided for @wizardStufe1eStrasseHelper.
  ///
  /// In de, this message translates to:
  /// **'Nur der Straßenname — Hausnummer ins Feld daneben.'**
  String get wizardStufe1eStrasseHelper;

  /// No description provided for @wizardStufe1eHausnummerLabel.
  ///
  /// In de, this message translates to:
  /// **'Hausnummer'**
  String get wizardStufe1eHausnummerLabel;

  /// No description provided for @wizardStufe1ePlzLabel.
  ///
  /// In de, this message translates to:
  /// **'PLZ'**
  String get wizardStufe1ePlzLabel;

  /// No description provided for @wizardStufe1eOrtLabel.
  ///
  /// In de, this message translates to:
  /// **'Ort'**
  String get wizardStufe1eOrtLabel;

  /// No description provided for @wizardStufe1eLandLabel.
  ///
  /// In de, this message translates to:
  /// **'Land'**
  String get wizardStufe1eLandLabel;

  /// No description provided for @wizardStufe1eLandHelper.
  ///
  /// In de, this message translates to:
  /// **'Vorausgefüllt mit Deutschland.'**
  String get wizardStufe1eLandHelper;

  /// No description provided for @wizardErrInvalidStreet.
  ///
  /// In de, this message translates to:
  /// **'Ungültiger Straßenname'**
  String get wizardErrInvalidStreet;

  /// No description provided for @wizardErrInvalidHausnummer.
  ///
  /// In de, this message translates to:
  /// **'Ungültige Hausnummer (z.B. 12, 12a, 12/3)'**
  String get wizardErrInvalidHausnummer;

  /// No description provided for @wizardErrInvalidPlz.
  ///
  /// In de, this message translates to:
  /// **'Ungültige PLZ (nur Ziffern)'**
  String get wizardErrInvalidPlz;

  /// No description provided for @wizardStufe1fTitle.
  ///
  /// In de, this message translates to:
  /// **'Kontakt'**
  String get wizardStufe1fTitle;

  /// No description provided for @wizardStufe1fPrompt.
  ///
  /// In de, this message translates to:
  /// **'Wie erreichen wir dich? Das Telefon nur für Notfälle — alles andere läuft über unseren Ende-zu-Ende-verschlüsselten In-App-Kanal. Deine Mitglieder-E-Mail wird automatisch zugewiesen und unten angezeigt.'**
  String get wizardStufe1fPrompt;

  /// No description provided for @wizardStufe1fTelefonLabel.
  ///
  /// In de, this message translates to:
  /// **'Mobilnummer'**
  String get wizardStufe1fTelefonLabel;

  /// No description provided for @wizardStufe1fTelefonHelper.
  ///
  /// In de, this message translates to:
  /// **'Versprochen — wir rufen nur an, wenn es wirklich wichtig ist. 📱'**
  String get wizardStufe1fTelefonHelper;

  /// No description provided for @wizardStufe2Title.
  ///
  /// In de, this message translates to:
  /// **'Mitgliedsart'**
  String get wizardStufe2Title;

  /// No description provided for @wizardStufe2Prompt.
  ///
  /// In de, this message translates to:
  /// **'Welche Art von Mitglied möchtest du sein? Lass mich dir jede Option erklären.'**
  String get wizardStufe2Prompt;

  /// No description provided for @wizardStufe2OrdentlichTitle.
  ///
  /// In de, this message translates to:
  /// **'Ordentliches Mitglied'**
  String get wizardStufe2OrdentlichTitle;

  /// No description provided for @wizardStufe2OrdentlichBody.
  ///
  /// In de, this message translates to:
  /// **'Volle Rechte. Du zahlst monatlich Beitrag, stimmst in der Mitgliederversammlung ab und kannst in den Vorstand gewählt werden. Standardwahl.'**
  String get wizardStufe2OrdentlichBody;

  /// No description provided for @wizardStufe2FoerderTitle.
  ///
  /// In de, this message translates to:
  /// **'Fördermitglied'**
  String get wizardStufe2FoerderTitle;

  /// No description provided for @wizardStufe2FoerderBody.
  ///
  /// In de, this message translates to:
  /// **'Du unterstützt den Verein finanziell, nimmst aber nicht aktiv an Entscheidungen teil. Kein Stimmrecht. Gut, wenn du aus der Ferne helfen willst.'**
  String get wizardStufe2FoerderBody;

  /// No description provided for @wizardStufe2EhrenTitle.
  ///
  /// In de, this message translates to:
  /// **'Ehrenmitglied'**
  String get wizardStufe2EhrenTitle;

  /// No description provided for @wizardStufe2EhrenBody.
  ///
  /// In de, this message translates to:
  /// **'Wird vom Vorstand für besondere Verdienste verliehen. Du wählst es nicht selbst — es wird als Anerkennung gewährt. Wähle nur, wenn dir bereits diese Ehre zuteilwurde.'**
  String get wizardStufe2EhrenBody;

  /// No description provided for @wizardStufe3Title.
  ///
  /// In de, this message translates to:
  /// **'Finanzielle Situation'**
  String get wizardStufe3Title;

  /// No description provided for @wizardStufe3Prompt.
  ///
  /// In de, this message translates to:
  /// **'Jetzt zu deiner finanziellen Situation. Nicht um zu urteilen — sondern um dich vom Beitrag zu befreien, falls du Sozialleistungen beziehst.'**
  String get wizardStufe3Prompt;

  /// No description provided for @wizardStufe3OptionBuergergeld.
  ///
  /// In de, this message translates to:
  /// **'Ich beziehe Bürgergeld'**
  String get wizardStufe3OptionBuergergeld;

  /// No description provided for @wizardStufe3OptionSozialamt.
  ///
  /// In de, this message translates to:
  /// **'Ich beziehe Sozialamt-Leistungen'**
  String get wizardStufe3OptionSozialamt;

  /// No description provided for @wizardStufe3OptionNein.
  ///
  /// In de, this message translates to:
  /// **'Ich beziehe keine dieser Leistungen'**
  String get wizardStufe3OptionNein;

  /// No description provided for @wizardStufe3FeeExemptTitle.
  ///
  /// In de, this message translates to:
  /// **'Beitrag: 0 € / Monat 🎉'**
  String get wizardStufe3FeeExemptTitle;

  /// No description provided for @wizardStufe3FeeExemptBody.
  ///
  /// In de, this message translates to:
  /// **'Mit Bürgergeld, Sozialamt, ALG I oder Krankengeld bist du nach Satzung §6 vollständig beitragsbefreit. Wir brauchen nur einen Nachweis (Leistungsbescheid oder Bescheinigung der Behörde / Krankenkasse).'**
  String get wizardStufe3FeeExemptBody;

  /// No description provided for @wizardStufe3UploadTitle.
  ///
  /// In de, this message translates to:
  /// **'Leistungsbescheid hochladen'**
  String get wizardStufe3UploadTitle;

  /// No description provided for @wizardStufe3UploadHint.
  ///
  /// In de, this message translates to:
  /// **'PDF / JPG / PNG, maximal 10 MB.'**
  String get wizardStufe3UploadHint;

  /// No description provided for @wizardStufe3UploadRequired.
  ///
  /// In de, this message translates to:
  /// **'Bitte lade den Leistungsbescheid hoch, bevor es weitergeht.'**
  String get wizardStufe3UploadRequired;

  /// No description provided for @wizardStufe3FileTooLarge.
  ///
  /// In de, this message translates to:
  /// **'Datei zu groß. Maximal 10 MB.'**
  String get wizardStufe3FileTooLarge;

  /// No description provided for @wizardStufe3UploadFailed.
  ///
  /// In de, this message translates to:
  /// **'Datei konnte nicht hochgeladen werden. Bitte erneut versuchen.'**
  String get wizardStufe3UploadFailed;

  /// No description provided for @wizardStufe3RegularFeeTitle.
  ///
  /// In de, this message translates to:
  /// **'Beitrag: 25 € / Monat'**
  String get wizardStufe3RegularFeeTitle;

  /// No description provided for @wizardStufe3RegularFeeBody.
  ///
  /// In de, this message translates to:
  /// **'Regulärer Beitrag für ordentliche Mitglieder laut Satzung.'**
  String get wizardStufe3RegularFeeBody;

  /// No description provided for @wizardStufe4Title.
  ///
  /// In de, this message translates to:
  /// **'Zahlung'**
  String get wizardStufe4Title;

  /// No description provided for @wizardStufe4Prompt.
  ///
  /// In de, this message translates to:
  /// **'Wie möchtest du den Beitrag zahlen? Und an welchem Tag im Monat soll abgebucht werden?'**
  String get wizardStufe4Prompt;

  /// No description provided for @wizardStufe4MethodUeberweisungTitle.
  ///
  /// In de, this message translates to:
  /// **'Überweisung'**
  String get wizardStufe4MethodUeberweisungTitle;

  /// No description provided for @wizardStufe4MethodUeberweisungBody.
  ///
  /// In de, this message translates to:
  /// **'Du löst die Zahlung jeden Monat manuell von deinem Konto aus.'**
  String get wizardStufe4MethodUeberweisungBody;

  /// No description provided for @wizardStufe4MethodSepaTitle.
  ///
  /// In de, this message translates to:
  /// **'SEPA-Lastschrift'**
  String get wizardStufe4MethodSepaTitle;

  /// No description provided for @wizardStufe4MethodSepaBody.
  ///
  /// In de, this message translates to:
  /// **'Wir ziehen den Betrag automatisch von deinem Konto ein. Am bequemsten, aber wir brauchen IBAN und ein Mandat.'**
  String get wizardStufe4MethodSepaBody;

  /// No description provided for @wizardStufe4MethodDauerauftragTitle.
  ///
  /// In de, this message translates to:
  /// **'Dauerauftrag'**
  String get wizardStufe4MethodDauerauftragTitle;

  /// No description provided for @wizardStufe4MethodDauerauftragBody.
  ///
  /// In de, this message translates to:
  /// **'Du richtest einen Dauerauftrag bei deiner Bank ein. Deine Bank überweist den Betrag jeden Monat automatisch.'**
  String get wizardStufe4MethodDauerauftragBody;

  /// No description provided for @wizardStufe4DayLabel.
  ///
  /// In de, this message translates to:
  /// **'Zahlungstag'**
  String get wizardStufe4DayLabel;

  /// No description provided for @wizardStufe4DayHint.
  ///
  /// In de, this message translates to:
  /// **'Wähle einen Tag zwischen 1 und 31'**
  String get wizardStufe4DayHint;

  /// No description provided for @wizardStufe4DayItem.
  ///
  /// In de, this message translates to:
  /// **'Tag {day}'**
  String wizardStufe4DayItem(int day);

  /// No description provided for @wizardStufe4DayReminder.
  ///
  /// In de, this message translates to:
  /// **'Der Beitrag wird am {day}. jedes Monats abgebucht.'**
  String wizardStufe4DayReminder(int day);

  /// No description provided for @wizardStufe5Title.
  ///
  /// In de, this message translates to:
  /// **'Beginn'**
  String get wizardStufe5Title;

  /// No description provided for @wizardStufe5Prompt.
  ///
  /// In de, this message translates to:
  /// **'Ab wann möchtest du offiziell ICD360S-Mitglied sein? Ab der Freigabe oder rückwirkend.'**
  String get wizardStufe5Prompt;

  /// No description provided for @wizardStufe5OptionAbVerifizierungTitle.
  ///
  /// In de, this message translates to:
  /// **'Ab Freigabe durch den Vorstand'**
  String get wizardStufe5OptionAbVerifizierungTitle;

  /// No description provided for @wizardStufe5OptionAbVerifizierungBody.
  ///
  /// In de, this message translates to:
  /// **'Die einfachste Wahl. Kein rückwirkender Beitrag.'**
  String get wizardStufe5OptionAbVerifizierungBody;

  /// No description provided for @wizardStufe5OptionGruendungsdatumTitle.
  ///
  /// In de, this message translates to:
  /// **'Rückwirkend ab 01.08.2025 (Gründungsdatum)'**
  String get wizardStufe5OptionGruendungsdatumTitle;

  /// No description provided for @wizardStufe5OptionGruendungsdatumBody.
  ///
  /// In de, this message translates to:
  /// **'Du zählst als Mitglied seit dem ersten Tag des Vereins.'**
  String get wizardStufe5OptionGruendungsdatumBody;

  /// No description provided for @wizardStufe5OptionAnderesDatumTitle.
  ///
  /// In de, this message translates to:
  /// **'Anderes Datum'**
  String get wizardStufe5OptionAnderesDatumTitle;

  /// No description provided for @wizardStufe5OptionAnderesDatumBody.
  ///
  /// In de, this message translates to:
  /// **'Du wählst ein Datum zwischen 01.08.2025 und heute.'**
  String get wizardStufe5OptionAnderesDatumBody;

  /// No description provided for @wizardStufe5PickDate.
  ///
  /// In de, this message translates to:
  /// **'Tippen, um Datum zu wählen'**
  String get wizardStufe5PickDate;

  /// No description provided for @wizardStufe5PickDateFirst.
  ///
  /// In de, this message translates to:
  /// **'Bitte wähle zuerst ein Datum.'**
  String get wizardStufe5PickDateFirst;

  /// No description provided for @wizardStufe5DatePickerHelp.
  ///
  /// In de, this message translates to:
  /// **'Mitgliedschaftsbeginn'**
  String get wizardStufe5DatePickerHelp;

  /// No description provided for @wizardStufe5DateRange.
  ///
  /// In de, this message translates to:
  /// **'Zwischen {start} und heute'**
  String wizardStufe5DateRange(String start);

  /// No description provided for @wizardStufe5RetroactiveTitle.
  ///
  /// In de, this message translates to:
  /// **'Rückwirkender Beitrag'**
  String get wizardStufe5RetroactiveTitle;

  /// No description provided for @wizardStufe5RetroactiveBody.
  ///
  /// In de, this message translates to:
  /// **'Vom {start} bis {end} sind das {months} Monate. Bei 25 €/Monat ergibt das eine rückwirkende Zahlung von {amount} €, zusätzlich zum laufenden Monatsbeitrag.'**
  String wizardStufe5RetroactiveBody(
      String start, String end, int months, String amount);

  /// No description provided for @wizardStufe5FeeExemptTitle.
  ///
  /// In de, this message translates to:
  /// **'Rückwirkender Beitrag: 0 € 🎉'**
  String get wizardStufe5FeeExemptTitle;

  /// No description provided for @wizardStufe5FeeExemptBody.
  ///
  /// In de, this message translates to:
  /// **'Mit Bürgergeld oder Sozialamt bist du komplett befreit — auch rückwirkend nichts zu zahlen.'**
  String get wizardStufe5FeeExemptBody;

  /// No description provided for @wizardDocumentPrompt.
  ///
  /// In de, this message translates to:
  /// **'Bevor wir abschließen, lies bitte sorgfältig die {doc}. Es ist wichtig zu wissen, was du unterschreibst.'**
  String wizardDocumentPrompt(String doc);

  /// No description provided for @wizardDocumentScrollHint.
  ///
  /// In de, this message translates to:
  /// **'Scroll bis zum Ende, um fortzufahren.'**
  String get wizardDocumentScrollHint;

  /// No description provided for @wizardDocumentScrolledOk.
  ///
  /// In de, this message translates to:
  /// **'Du hast bis zum Ende gelesen ✓'**
  String get wizardDocumentScrolledOk;

  /// No description provided for @wizardDocumentOpenButton.
  ///
  /// In de, this message translates to:
  /// **'{doc} im Browser öffnen'**
  String wizardDocumentOpenButton(String doc);

  /// No description provided for @wizardDocumentExternalHint.
  ///
  /// In de, this message translates to:
  /// **'Auf dieser Plattform öffnen wir das Dokument in deinem Standard-Browser.'**
  String get wizardDocumentExternalHint;

  /// No description provided for @wizardDocumentOpenedOk.
  ///
  /// In de, this message translates to:
  /// **'Das Dokument wurde geöffnet. Bitte lies es sorgfältig.'**
  String get wizardDocumentOpenedOk;

  /// No description provided for @wizardDocumentConfirm.
  ///
  /// In de, this message translates to:
  /// **'Ich bestätige, dass ich {doc} gelesen habe und damit einverstanden bin.'**
  String wizardDocumentConfirm(String doc);

  /// No description provided for @wizardFinalAdultTitle.
  ///
  /// In de, this message translates to:
  /// **'Geschafft! Du bist angemeldet 🎉'**
  String get wizardFinalAdultTitle;

  /// No description provided for @wizardFinalMinorTitle.
  ///
  /// In de, this message translates to:
  /// **'Deine Anfrage wurde verschickt 📨'**
  String get wizardFinalMinorTitle;

  /// No description provided for @wizardFinalMinorBody.
  ///
  /// In de, this message translates to:
  /// **'Wir kontaktieren deinen Elternteil und vereinbaren ein Treffen (persönlich oder per Videoanruf). Bitte hab Geduld — der Vorgang kann bis zu 7 Tage dauern. Du bekommst eine In-App-Benachrichtigung, sobald dein Elternteil zugestimmt hat.'**
  String get wizardFinalMinorBody;

  /// No description provided for @wizardFinalMitgliedernummerLabel.
  ///
  /// In de, this message translates to:
  /// **'Deine Mitgliedsnummer'**
  String get wizardFinalMitgliedernummerLabel;

  /// No description provided for @wizardStufe4MethodComingSoon.
  ///
  /// In de, this message translates to:
  /// **'Bald verfügbar'**
  String get wizardStufe4MethodComingSoon;

  /// No description provided for @wizardStufe4StreichungWarning.
  ///
  /// In de, this message translates to:
  /// **'Wenn du mit dem Beitrag mehr als 6 Monate im Rückstand bist, werden wir dich automatisch streichen (Satzung §6 Abs. 3).'**
  String get wizardStufe4StreichungWarning;

  /// No description provided for @wizardStufe5KuendigungInfo.
  ///
  /// In de, this message translates to:
  /// **'Zum Austritt: schicke uns deine Kündigung schriftlich 3 Monate vor dem 31. Dezember (also bis 30. September für Wirksamkeit zum Jahresende). Keine Mindestlaufzeit (Satzung §6 Abs. 3).'**
  String get wizardStufe5KuendigungInfo;

  /// No description provided for @wizardStufe1fEmailLabel.
  ///
  /// In de, this message translates to:
  /// **'Deine Mitglieder-E-Mail'**
  String get wizardStufe1fEmailLabel;

  /// No description provided for @wizardStufe1fEmailHelper.
  ///
  /// In de, this message translates to:
  /// **'Wird automatisch aus deiner Mitgliedsnummer abgeleitet. Wird aktiviert, sobald der Vorstand deinen Antrag bestätigt. Wir haben eine eigene E-Mail-App — verschlüsselte E-Mails senden und empfangen, einfach und kostenlos.'**
  String get wizardStufe1fEmailHelper;

  /// No description provided for @wizardErrInvalidEmail.
  ///
  /// In de, this message translates to:
  /// **'Ungültige E-Mail-Adresse'**
  String get wizardErrInvalidEmail;

  /// No description provided for @wizardStufe3OptionAlg1.
  ///
  /// In de, this message translates to:
  /// **'Ich beziehe Arbeitslosengeld I (ALG I)'**
  String get wizardStufe3OptionAlg1;

  /// No description provided for @wizardStufe3OptionKrankengeld.
  ///
  /// In de, this message translates to:
  /// **'Ich beziehe Krankengeld'**
  String get wizardStufe3OptionKrankengeld;

  /// No description provided for @wizardStufe3UploadAddMore.
  ///
  /// In de, this message translates to:
  /// **'Weiteres Dokument hinzufügen'**
  String get wizardStufe3UploadAddMore;

  /// No description provided for @wizardStufe3UploadLimitCount.
  ///
  /// In de, this message translates to:
  /// **'Limit erreicht: maximal 20 Dokumente.'**
  String get wizardStufe3UploadLimitCount;

  /// No description provided for @wizardStufe3UploadLimitTotal.
  ///
  /// In de, this message translates to:
  /// **'Gesamtlimit 100 MB erreicht. Lösche eine bestehende Datei.'**
  String get wizardStufe3UploadLimitTotal;

  /// No description provided for @wizardStufe3UploadDeleteTooltip.
  ///
  /// In de, this message translates to:
  /// **'Löschen'**
  String get wizardStufe3UploadDeleteTooltip;

  /// No description provided for @wizardStufe3UploadCounter.
  ///
  /// In de, this message translates to:
  /// **'{count} / {max} Dokumente'**
  String wizardStufe3UploadCounter(int count, int max);

  /// No description provided for @wizardDocumentExternalOpenFailed.
  ///
  /// In de, this message translates to:
  /// **'Konnte den Browser nicht öffnen. Der Link wurde in die Zwischenablage kopiert — füge ihn in einen Browser ein, um fortzufahren.'**
  String get wizardDocumentExternalOpenFailed;

  /// No description provided for @wizardFinalTimelineProcessing.
  ///
  /// In de, this message translates to:
  /// **'Vorstand prüft · meist 1 Werktag, max. 7'**
  String get wizardFinalTimelineProcessing;

  /// No description provided for @wizardFinalTimelineActivated.
  ///
  /// In de, this message translates to:
  /// **'Konto aktiviert'**
  String get wizardFinalTimelineActivated;

  /// No description provided for @wizardFinalAdultThank.
  ///
  /// In de, this message translates to:
  /// **'Vielen Dank, dass du das Anmeldeformular ausgefüllt hast! 🎉'**
  String get wizardFinalAdultThank;

  /// No description provided for @wizardFinalAdultUsual.
  ///
  /// In de, this message translates to:
  /// **'Dein Antrag ist bei uns angekommen. Normalerweise prüfen wir ihn innerhalb von einem Werktag.'**
  String get wizardFinalAdultUsual;

  /// No description provided for @wizardFinalAdultExceptional.
  ///
  /// In de, this message translates to:
  /// **'Manchmal kann es bis zu 7 Werktage dauern. Falls etwas nicht passt, schicken wir dich zurück ins Formular, damit du es korrigieren kannst 🙂'**
  String get wizardFinalAdultExceptional;

  /// No description provided for @wizardFinalStatusTitle.
  ///
  /// In de, this message translates to:
  /// **'ANTRAGSSTATUS'**
  String get wizardFinalStatusTitle;

  /// No description provided for @wizardFinalStatusStepsValidated.
  ///
  /// In de, this message translates to:
  /// **'{reviewed}/{total} Schritte vom Vorstand geprüft'**
  String wizardFinalStatusStepsValidated(int reviewed, int total);

  /// No description provided for @wizardFinalStufeSheetTitle.
  ///
  /// In de, this message translates to:
  /// **'Antragsdetails'**
  String get wizardFinalStufeSheetTitle;

  /// No description provided for @wizardFinalStufeSheetHint.
  ///
  /// In de, this message translates to:
  /// **'Die 8 Stufen, die du ausgefüllt hast. Der Vorstand prüft sie nacheinander — du siehst in Echtzeit, was schon geprüft wurde.'**
  String get wizardFinalStufeSheetHint;

  /// No description provided for @wizardFinalStufeStatusPending.
  ///
  /// In de, this message translates to:
  /// **'Wartet auf Prüfung'**
  String get wizardFinalStufeStatusPending;

  /// No description provided for @wizardFinalStufeStatusApproved.
  ///
  /// In de, this message translates to:
  /// **'Geprüft'**
  String get wizardFinalStufeStatusApproved;

  /// No description provided for @wizardFinalStufeStatusRejected.
  ///
  /// In de, this message translates to:
  /// **'Abgelehnt'**
  String get wizardFinalStufeStatusRejected;

  /// No description provided for @wizardFinalStatusRejectionCount.
  ///
  /// In de, this message translates to:
  /// **'{count} Schritt braucht eine Korrektur'**
  String wizardFinalStatusRejectionCount(int count);

  /// No description provided for @wizardFinalStufeRejectionReason.
  ///
  /// In de, this message translates to:
  /// **'Begründung vom Vorstand:'**
  String get wizardFinalStufeRejectionReason;

  /// No description provided for @wizardFinalStufeCorrectNow.
  ///
  /// In de, this message translates to:
  /// **'Jetzt korrigieren'**
  String get wizardFinalStufeCorrectNow;

  /// No description provided for @wizardFinalApprovalsHeader.
  ///
  /// In de, this message translates to:
  /// **'Vorstand-Bestätigungen ({current}/{total})'**
  String wizardFinalApprovalsHeader(int current, int total);

  /// No description provided for @wizardFinalApprovalAwaiting.
  ///
  /// In de, this message translates to:
  /// **'Warten auf 2. Vorstand'**
  String get wizardFinalApprovalAwaiting;

  /// No description provided for @wizardFinalApprovalRejected.
  ///
  /// In de, this message translates to:
  /// **'ABGELEHNT'**
  String get wizardFinalApprovalRejected;

  /// No description provided for @wizardFinalStufeNoDataYet.
  ///
  /// In de, this message translates to:
  /// **'Daten sind noch nicht verfügbar.'**
  String get wizardFinalStufeNoDataYet;

  /// No description provided for @wizardFinalStufeReadAt.
  ///
  /// In de, this message translates to:
  /// **'Gelesen am:'**
  String get wizardFinalStufeReadAt;

  /// No description provided for @wizardFinalStufeBeitragsfrei.
  ///
  /// In de, this message translates to:
  /// **'Beitragsfrei (kein Beitrag erforderlich)'**
  String get wizardFinalStufeBeitragsfrei;

  /// No description provided for @wizardFinalStufeNotExempt.
  ///
  /// In de, this message translates to:
  /// **'Keine Sozialleistungen'**
  String get wizardFinalStufeNotExempt;

  /// No description provided for @wizardFinalStufeBeginAtVerification.
  ///
  /// In de, this message translates to:
  /// **'Beginn ab Verifizierung'**
  String get wizardFinalStufeBeginAtVerification;

  /// No description provided for @wizardFinalStufeBeginAtFoundation.
  ///
  /// In de, this message translates to:
  /// **'Gründungsdatum (rückwirkend)'**
  String get wizardFinalStufeBeginAtFoundation;

  /// No description provided for @wizardFinalStufeBeginAtCustom.
  ///
  /// In de, this message translates to:
  /// **'Anderes Datum'**
  String get wizardFinalStufeBeginAtCustom;

  /// No description provided for @wizardFinalStufeStatusSkipped.
  ///
  /// In de, this message translates to:
  /// **'Übersprungen'**
  String get wizardFinalStufeStatusSkipped;

  /// No description provided for @wizardFinalStufeFilledAt.
  ///
  /// In de, this message translates to:
  /// **'Ausgefüllt am:'**
  String get wizardFinalStufeFilledAt;

  /// No description provided for @wizardFinalStufeReviewedAt.
  ///
  /// In de, this message translates to:
  /// **'Geprüft am:'**
  String get wizardFinalStufeReviewedAt;

  /// No description provided for @wizardFinalWithdrawLink.
  ///
  /// In de, this message translates to:
  /// **'Antrag zurückziehen'**
  String get wizardFinalWithdrawLink;

  /// No description provided for @wizardFinalWithdrawDialogTitle.
  ///
  /// In de, this message translates to:
  /// **'Antrag zurückziehen?'**
  String get wizardFinalWithdrawDialogTitle;

  /// No description provided for @wizardFinalWithdrawDialogBody.
  ///
  /// In de, this message translates to:
  /// **'Dein Antrag wird als von dir zurückgezogen markiert. Die Daten bleiben aus Auditgründen (DSGVO) in der Datenbank, dein Konto wird jedoch nicht aktiviert. Du kannst die Anmeldung jederzeit mit einer neuen Mitgliedernummer neu starten.'**
  String get wizardFinalWithdrawDialogBody;

  /// No description provided for @wizardFinalWithdrawKeep.
  ///
  /// In de, this message translates to:
  /// **'Nein, ich warte'**
  String get wizardFinalWithdrawKeep;

  /// No description provided for @wizardFinalWithdrawConfirm.
  ///
  /// In de, this message translates to:
  /// **'Ja, zurückziehen'**
  String get wizardFinalWithdrawConfirm;

  /// No description provided for @wizardErrTooManyWithdrawals.
  ///
  /// In de, this message translates to:
  /// **'Dein Antrag kann nicht automatisch bearbeitet werden. Bitte ruf uns an oder komm persönlich beim Vorstand vorbei, um die Anmeldung fortzusetzen.'**
  String get wizardErrTooManyWithdrawals;

  /// No description provided for @wizardDuplicateLoginTitle.
  ///
  /// In de, this message translates to:
  /// **'Du scheinst bereits Mitglied zu sein'**
  String get wizardDuplicateLoginTitle;

  /// No description provided for @wizardDuplicateLoginBody.
  ///
  /// In de, this message translates to:
  /// **'Mit deinem Namen und Geburtsdatum finden wir bereits ein aktives Konto. Bitte nutze „Ich bin bereits Mitglied\" auf dem Startbildschirm, um dich anzumelden. Wenn du keinen Zugang mehr hast, ruf uns an.'**
  String get wizardDuplicateLoginBody;

  /// No description provided for @wizardDuplicatePendingTitle.
  ///
  /// In de, this message translates to:
  /// **'Dein Antrag ist bereits bei uns'**
  String get wizardDuplicatePendingTitle;

  /// No description provided for @wizardDuplicatePendingBody.
  ///
  /// In de, this message translates to:
  /// **'Mit deinem Namen und Geburtsdatum finden wir bereits einen laufenden Antrag. Der Vorstand prüft ihn gerade — wir benachrichtigen dich in der App, sobald dein Konto aktiv ist. Wenn du sprechen möchtest, ruf uns an.'**
  String get wizardDuplicatePendingBody;

  /// No description provided for @wizardDuplicateRecentlyWithdrawnTitle.
  ///
  /// In de, this message translates to:
  /// **'Wir können den Antrag jetzt nicht bearbeiten'**
  String get wizardDuplicateRecentlyWithdrawnTitle;

  /// No description provided for @wizardDuplicateRecentlyWithdrawnBody.
  ///
  /// In de, this message translates to:
  /// **'Dein Name und dein Geburtsdatum stimmen mit einem kürzlich zurückgezogenen Antrag überein. Bitte ruf uns an, um vor dem Weitermachen mit dem Vorstand zu sprechen.'**
  String get wizardDuplicateRecentlyWithdrawnBody;

  /// No description provided for @wizardDuplicatePreviouslyWithdrawnTitle.
  ///
  /// In de, this message translates to:
  /// **'Du hattest schon einmal einen Antrag'**
  String get wizardDuplicatePreviouslyWithdrawnTitle;

  /// No description provided for @wizardDuplicatePreviouslyWithdrawnBody.
  ///
  /// In de, this message translates to:
  /// **'Dein Name und dein Geburtsdatum stimmen mit einem älteren Antrag überein, den du zurückgezogen hattest. Willkommen zurück — bitte ruf uns vor dem Fortfahren an, damit der Vorstand entscheiden kann, wie wir weitermachen.'**
  String get wizardDuplicatePreviouslyWithdrawnBody;

  /// No description provided for @wizardDuplicateCallUsTitle.
  ///
  /// In de, this message translates to:
  /// **'Bitte ruf uns an'**
  String get wizardDuplicateCallUsTitle;

  /// No description provided for @wizardDuplicateCallUsBody.
  ///
  /// In de, this message translates to:
  /// **'Dein Name und Geburtsdatum sind bei uns bereits vorhanden, aber wir können dir die Details nicht über die App mitteilen. Bitte ruf uns an — der Vorstand erklärt dir die Situation direkt.'**
  String get wizardDuplicateCallUsBody;

  /// No description provided for @wizardChatHelp.
  ///
  /// In de, this message translates to:
  /// **'Lass uns reden'**
  String get wizardChatHelp;

  /// No description provided for @wizardChatHelpSubtitle.
  ///
  /// In de, this message translates to:
  /// **'Live-Chat mit dem Vorstand · schnelle Antwort'**
  String get wizardChatHelpSubtitle;

  /// No description provided for @benachrichtigungTitel.
  ///
  /// In de, this message translates to:
  /// **'SMS-Erinnerungen'**
  String get benachrichtigungTitel;

  /// No description provided for @benachrichtigungIntro.
  ///
  /// In de, this message translates to:
  /// **'Damit Sie keinen Termin verpassen, kann der Verein Ihnen eine SMS schicken. Sie entscheiden, ob und wofür — und können es jederzeit ändern.'**
  String get benachrichtigungIntro;

  /// No description provided for @benachrichtigungTermineFrage.
  ///
  /// In de, this message translates to:
  /// **'Möchten Sie Erinnerungen an Ihre Termine per SMS erhalten?'**
  String get benachrichtigungTermineFrage;

  /// No description provided for @benachrichtigungTermineDetail.
  ///
  /// In de, this message translates to:
  /// **'Die SMS enthält Datum, Uhrzeit, Ort und Betreff des Termins.'**
  String get benachrichtigungTermineDetail;

  /// No description provided for @benachrichtigungMedikamenteFrage.
  ///
  /// In de, this message translates to:
  /// **'Möchten Sie auch an Ihre Medikamente erinnert werden?'**
  String get benachrichtigungMedikamenteFrage;

  /// No description provided for @benachrichtigungMedikamenteDetail.
  ///
  /// In de, this message translates to:
  /// **'Dabei steht der Name des Medikaments in der SMS. Das ist eine Gesundheitsangabe — deshalb fragen wir getrennt.'**
  String get benachrichtigungMedikamenteDetail;

  /// No description provided for @benachrichtigungHinweis.
  ///
  /// In de, this message translates to:
  /// **'Die Erinnerung ist eine Hilfe und keine Garantie: bitte verlassen Sie sich nicht allein darauf. Ändern können Sie das jederzeit in Ihrem Profil.'**
  String get benachrichtigungHinweis;

  /// No description provided for @benachrichtigungJa.
  ///
  /// In de, this message translates to:
  /// **'Ja'**
  String get benachrichtigungJa;

  /// No description provided for @benachrichtigungNein.
  ///
  /// In de, this message translates to:
  /// **'Nein'**
  String get benachrichtigungNein;

  /// No description provided for @benachrichtigungSpaeter.
  ///
  /// In de, this message translates to:
  /// **'Später entscheiden'**
  String get benachrichtigungSpaeter;

  /// No description provided for @benachrichtigungSpeichern.
  ///
  /// In de, this message translates to:
  /// **'Speichern'**
  String get benachrichtigungSpeichern;

  /// No description provided for @benachrichtigungGespeichert.
  ///
  /// In de, this message translates to:
  /// **'Danke, gespeichert.'**
  String get benachrichtigungGespeichert;

  /// No description provided for @benachrichtigungenLeer.
  ///
  /// In de, this message translates to:
  /// **'Keine Benachrichtigungen'**
  String get benachrichtigungenLeer;

  /// No description provided for @benachrichtigungenAlleGelesen.
  ///
  /// In de, this message translates to:
  /// **'Alle als gelesen markieren'**
  String get benachrichtigungenAlleGelesen;

  /// No description provided for @benachrichtigungWetterFrage.
  ///
  /// In de, this message translates to:
  /// **'Möchten Sie bei Unwetter an Ihrem Wohnort gewarnt werden?'**
  String get benachrichtigungWetterFrage;

  /// No description provided for @benachrichtigungWetterDetail.
  ///
  /// In de, this message translates to:
  /// **'Nur amtliche Warnungen des Deutschen Wetterdienstes ab Stufe „schwer“ — nicht bei jedem Regen.'**
  String get benachrichtigungWetterDetail;

  /// No description provided for @signaturTitel.
  ///
  /// In de, this message translates to:
  /// **'Unterschriften'**
  String get signaturTitel;

  /// No description provided for @signaturNichtsOffen.
  ///
  /// In de, this message translates to:
  /// **'Zurzeit liegt nichts zur Unterschrift vor.'**
  String get signaturNichtsOffen;

  /// No description provided for @signaturStatusOffen.
  ///
  /// In de, this message translates to:
  /// **'Wartet auf Ihre Unterschrift'**
  String get signaturStatusOffen;

  /// No description provided for @signaturStatusSigniert.
  ///
  /// In de, this message translates to:
  /// **'Von Ihnen unterschrieben'**
  String get signaturStatusSigniert;

  /// No description provided for @signaturStatusAbgelehnt.
  ///
  /// In de, this message translates to:
  /// **'Von Ihnen abgelehnt'**
  String get signaturStatusAbgelehnt;

  /// No description provided for @signaturStatusWiderrufen.
  ///
  /// In de, this message translates to:
  /// **'Vom Verein zurückgezogen'**
  String get signaturStatusWiderrufen;

  /// No description provided for @signaturStatusAbgelaufen.
  ///
  /// In de, this message translates to:
  /// **'Frist abgelaufen'**
  String get signaturStatusAbgelaufen;

  /// No description provided for @signaturBitteGanzLesen.
  ///
  /// In de, this message translates to:
  /// **'Bitte lesen Sie das Dokument bis zum Ende (Seite {gelesen} von {gesamt}).'**
  String signaturBitteGanzLesen(int gelesen, int gesamt);

  /// No description provided for @signaturWeiterZurUnterschrift.
  ///
  /// In de, this message translates to:
  /// **'Weiter zur Unterschrift'**
  String get signaturWeiterZurUnterschrift;

  /// No description provided for @signaturAblehnen.
  ///
  /// In de, this message translates to:
  /// **'Ablehnen'**
  String get signaturAblehnen;

  /// No description provided for @signaturAblehnenHinweis.
  ///
  /// In de, this message translates to:
  /// **'Der Verein wird darüber benachrichtigt. Sie können Ihre Gründe angeben.'**
  String get signaturAblehnenHinweis;

  /// No description provided for @signaturAblehnenGrund.
  ///
  /// In de, this message translates to:
  /// **'Grund (freiwillig)'**
  String get signaturAblehnenGrund;

  /// No description provided for @signaturMitFingerHinweis.
  ///
  /// In de, this message translates to:
  /// **'Unterschreiben Sie mit dem Finger im weißen Feld.'**
  String get signaturMitFingerHinweis;

  /// No description provided for @signaturNochmal.
  ///
  /// In de, this message translates to:
  /// **'Noch einmal'**
  String get signaturNochmal;

  /// No description provided for @signaturZurueckZumDokument.
  ///
  /// In de, this message translates to:
  /// **'Zurück zum Dokument'**
  String get signaturZurueckZumDokument;

  /// No description provided for @signaturCodeAnfordern.
  ///
  /// In de, this message translates to:
  /// **'Code per SMS anfordern'**
  String get signaturCodeAnfordern;

  /// No description provided for @signaturCodeUnterwegs.
  ///
  /// In de, this message translates to:
  /// **'Der Code ist unterwegs.'**
  String get signaturCodeUnterwegs;

  /// No description provided for @signaturCodeGesendetAn.
  ///
  /// In de, this message translates to:
  /// **'Wir haben Ihnen einen Code an {nummer} geschickt.'**
  String signaturCodeGesendetAn(String nummer);

  /// No description provided for @signaturCodeErneutSenden.
  ///
  /// In de, this message translates to:
  /// **'Code erneut senden'**
  String get signaturCodeErneutSenden;

  /// No description provided for @signaturJetztUnterschreiben.
  ///
  /// In de, this message translates to:
  /// **'Jetzt unterschreiben'**
  String get signaturJetztUnterschreiben;

  /// No description provided for @signaturCodeFalsch.
  ///
  /// In de, this message translates to:
  /// **'Der Code stimmt nicht.'**
  String get signaturCodeFalsch;

  /// No description provided for @signaturCodeAbgelaufen.
  ///
  /// In de, this message translates to:
  /// **'Der Code ist abgelaufen. Bitte fordern Sie einen neuen an.'**
  String get signaturCodeAbgelaufen;

  /// No description provided for @signaturZuVieleVersuche.
  ///
  /// In de, this message translates to:
  /// **'Zu viele Fehlversuche. Bitte fordern Sie einen neuen Code an.'**
  String get signaturZuVieleVersuche;

  /// No description provided for @signaturKeineRufnummer.
  ///
  /// In de, this message translates to:
  /// **'Für Ihr Konto ist keine Mobilnummer hinterlegt. Ohne sie können wir Ihnen keinen Code schicken — bitte wenden Sie sich an den Vorsitzenden.'**
  String get signaturKeineRufnummer;

  /// No description provided for @signaturCodeFehlgeschlagen.
  ///
  /// In de, this message translates to:
  /// **'Der Code konnte nicht verschickt werden.'**
  String get signaturCodeFehlgeschlagen;

  /// No description provided for @signaturLeer.
  ///
  /// In de, this message translates to:
  /// **'Bitte unterschreiben Sie zuerst.'**
  String get signaturLeer;

  /// No description provided for @signaturErfolg.
  ///
  /// In de, this message translates to:
  /// **'Danke — Ihre Unterschrift ist eingegangen.'**
  String get signaturErfolg;

  /// No description provided for @signaturFehlgeschlagen.
  ///
  /// In de, this message translates to:
  /// **'Das hat nicht geklappt. Bitte versuchen Sie es noch einmal.'**
  String get signaturFehlgeschlagen;

  /// No description provided for @signaturSiegelInArbeit.
  ///
  /// In de, this message translates to:
  /// **'Das Siegel wird noch erstellt. Bitte versuchen Sie es in einer Minute noch einmal.'**
  String get signaturSiegelInArbeit;

  /// Kurzer Status hinter "Von Ihnen unterschrieben ·": eine Vollmacht braucht zwei Unterschriften
  ///
  /// In de, this message translates to:
  /// **'Warten auf die zweite Unterschrift'**
  String get signaturWartetZweiteUnterschrift;

  /// Hinweisfenster, wenn das Mitglied das noch nicht gesiegelte Dokument antippt
  ///
  /// In de, this message translates to:
  /// **'Sie haben unterschrieben. Das Dokument wird gesiegelt, sobald auch die zweite Person unterschrieben hat.'**
  String get signaturWartenHinweis;

  /// Titel der Karte, die alle 90 Tage nach E-Mail und Mobilnummer fragt
  ///
  /// In de, this message translates to:
  /// **'Stimmen diese Angaben noch?'**
  String get kontaktNochAktuell;

  /// Erklaerung unter dem Titel
  ///
  /// In de, this message translates to:
  /// **'Damit Sie nichts verpassen, fragen wir alle drei Monate kurz nach. Sie bekommen einen sechsstelligen Code.'**
  String get kontaktWarumFragen;

  /// Datum der letzten Bestaetigung
  ///
  /// In de, this message translates to:
  /// **'bestätigt am {datum}'**
  String kontaktBestaetigtAm(Object datum);

  /// Warnung, wenn im Mobilfeld ein Festnetzanschluss steht
  ///
  /// In de, this message translates to:
  /// **'Das ist eine Festnetznummer — dorthin kommt keine SMS an.'**
  String get kontaktFestnetzKeinSms;

  /// Knopf: Adresse oder Nummer hat sich geaendert
  ///
  /// In de, this message translates to:
  /// **'Ist anders geworden'**
  String get kontaktIstAndersGeworden;

  /// No description provided for @themeTitle.
  ///
  /// In de, this message translates to:
  /// **'Darstellung'**
  String get themeTitle;

  /// No description provided for @themeLight.
  ///
  /// In de, this message translates to:
  /// **'Hell'**
  String get themeLight;

  /// No description provided for @themeDark.
  ///
  /// In de, this message translates to:
  /// **'Dunkel'**
  String get themeDark;

  /// No description provided for @themeSystem.
  ///
  /// In de, this message translates to:
  /// **'Gerät folgen'**
  String get themeSystem;

  /// No description provided for @themeSchedule.
  ///
  /// In de, this message translates to:
  /// **'Automatisch (20:00–06:00)'**
  String get themeSchedule;

  /// No description provided for @themeScheduleHint.
  ///
  /// In de, this message translates to:
  /// **'Von 20 Uhr bis 6 Uhr dunkel, den Rest des Tages hell.'**
  String get themeScheduleHint;

  /// Fernwartung: Einwilligung zur Fernsteuerung (Android)
  ///
  /// In de, this message translates to:
  /// **'Fernwartung'**
  String get fernwartungTitel;

  /// Fernwartung: Einwilligung zur Fernsteuerung (Android)
  ///
  /// In de, this message translates to:
  /// **'Steuerung erlauben'**
  String get fernwartungSteuerungTitel;

  /// Fernwartung: Einwilligung zur Fernsteuerung (Android)
  ///
  /// In de, this message translates to:
  /// **'Der Vorstand darf Ihr Gerät während einer Fernwartung bedienen. Sie stimmen jeder Sitzung einzeln zu; ohne Sitzung geschieht nichts. Der Dienst kann Ihren Bildschirm nicht lesen.'**
  String get fernwartungSteuerungHinweis;

  /// Fernwartung: Einwilligung zur Fernsteuerung (Android)
  ///
  /// In de, this message translates to:
  /// **'Steuerung ist eingeschaltet'**
  String get fernwartungSteuerungAktiv;

  /// Fernwartung: Einwilligung und Banner beim Mitglied
  ///
  /// In de, this message translates to:
  /// **'Fernwartung-Anfrage'**
  String get fernwartungAnfrageTitel;

  /// Fernwartung: Einwilligung und Banner beim Mitglied
  ///
  /// In de, this message translates to:
  /// **'„{name}\" möchte Ihren Bildschirm sehen und steuern, um Ihnen zu helfen. Es wird nichts ohne Ihre Zustimmung übertragen.'**
  String fernwartungAnfrageText(String name);

  /// Fernwartung: Einwilligung und Banner beim Mitglied
  ///
  /// In de, this message translates to:
  /// **'Sie sehen die ganze Zeit einen Hinweis und können jederzeit auf „Stopp\" tippen.'**
  String get fernwartungAnfrageHinweis;

  /// Fernwartung: Einwilligung und Banner beim Mitglied
  ///
  /// In de, this message translates to:
  /// **'Erlauben'**
  String get fernwartungErlauben;

  /// Fernwartung: Einwilligung und Banner beim Mitglied
  ///
  /// In de, this message translates to:
  /// **'Ablehnen'**
  String get fernwartungAblehnen;

  /// Fernwartung: Einwilligung und Banner beim Mitglied
  ///
  /// In de, this message translates to:
  /// **'Verbindung wird aufgebaut …'**
  String get fernwartungVerbindet;

  /// Fernwartung: Einwilligung und Banner beim Mitglied
  ///
  /// In de, this message translates to:
  /// **'Ihr Bildschirm wird geteilt'**
  String get fernwartungAktiv;

  /// Fernwartung: Einwilligung und Banner beim Mitglied
  ///
  /// In de, this message translates to:
  /// **'Stopp'**
  String get fernwartungStopp;

  /// Fernwartung: Einwilligung und Banner beim Mitglied
  ///
  /// In de, this message translates to:
  /// **'Mikrofon aus'**
  String get fernwartungMikroAus;

  /// Fernwartung: Einwilligung und Banner beim Mitglied
  ///
  /// In de, this message translates to:
  /// **'Mikrofon an'**
  String get fernwartungMikroAn;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
        'ar',
        'bg',
        'cs',
        'da',
        'de',
        'el',
        'en',
        'es',
        'et',
        'fi',
        'fr',
        'hr',
        'hu',
        'it',
        'lt',
        'lv',
        'nb',
        'nl',
        'pl',
        'pt',
        'ro',
        'ru',
        'sk',
        'sl',
        'sr',
        'sv',
        'tr',
        'uk'
      ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'bg':
      return AppLocalizationsBg();
    case 'cs':
      return AppLocalizationsCs();
    case 'da':
      return AppLocalizationsDa();
    case 'de':
      return AppLocalizationsDe();
    case 'el':
      return AppLocalizationsEl();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'et':
      return AppLocalizationsEt();
    case 'fi':
      return AppLocalizationsFi();
    case 'fr':
      return AppLocalizationsFr();
    case 'hr':
      return AppLocalizationsHr();
    case 'hu':
      return AppLocalizationsHu();
    case 'it':
      return AppLocalizationsIt();
    case 'lt':
      return AppLocalizationsLt();
    case 'lv':
      return AppLocalizationsLv();
    case 'nb':
      return AppLocalizationsNb();
    case 'nl':
      return AppLocalizationsNl();
    case 'pl':
      return AppLocalizationsPl();
    case 'pt':
      return AppLocalizationsPt();
    case 'ro':
      return AppLocalizationsRo();
    case 'ru':
      return AppLocalizationsRu();
    case 'sk':
      return AppLocalizationsSk();
    case 'sl':
      return AppLocalizationsSl();
    case 'sr':
      return AppLocalizationsSr();
    case 'sv':
      return AppLocalizationsSv();
    case 'tr':
      return AppLocalizationsTr();
    case 'uk':
      return AppLocalizationsUk();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
