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

  /// No description provided for @appTitle.
  ///
  /// In de, this message translates to:
  /// **'ICD360S e.V - Mitgliederportal'**
  String get appTitle;

  /// No description provided for @memberPortal.
  ///
  /// In de, this message translates to:
  /// **'Mitgliederportal'**
  String get memberPortal;

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

  /// No description provided for @password.
  ///
  /// In de, this message translates to:
  /// **'Passwort'**
  String get password;

  /// No description provided for @passwordHint.
  ///
  /// In de, this message translates to:
  /// **'Bitte Passwort eingeben'**
  String get passwordHint;

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

  /// No description provided for @saveCredentials.
  ///
  /// In de, this message translates to:
  /// **'Anmeldedaten speichern'**
  String get saveCredentials;

  /// No description provided for @autoLogin.
  ///
  /// In de, this message translates to:
  /// **'Automatisch anmelden'**
  String get autoLogin;

  /// No description provided for @forgotPassword.
  ///
  /// In de, this message translates to:
  /// **'Passwort vergessen?'**
  String get forgotPassword;

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

  /// No description provided for @recoveryCode.
  ///
  /// In de, this message translates to:
  /// **'Wiederherstellungscode (6 Ziffern)'**
  String get recoveryCode;

  /// No description provided for @recoveryCodeHelper.
  ///
  /// In de, this message translates to:
  /// **'Merken Sie sich diesen Code für Passwort-Wiederherstellung'**
  String get recoveryCodeHelper;

  /// No description provided for @recoveryCodeHint.
  ///
  /// In de, this message translates to:
  /// **'Bitte Wiederherstellungscode eingeben'**
  String get recoveryCodeHint;

  /// No description provided for @recoveryCodeInvalid.
  ///
  /// In de, this message translates to:
  /// **'Code muss genau 6 Ziffern haben'**
  String get recoveryCodeInvalid;

  /// No description provided for @loginFailed.
  ///
  /// In de, this message translates to:
  /// **'Anmeldung fehlgeschlagen'**
  String get loginFailed;

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

  /// No description provided for @tooManyDevices.
  ///
  /// In de, this message translates to:
  /// **'Zu viele Geräte'**
  String get tooManyDevices;

  /// No description provided for @maxDevicesMessage.
  ///
  /// In de, this message translates to:
  /// **'Sie sind bereits auf 3 Geräten angemeldet.\nWählen Sie ein Gerät zum Abmelden:'**
  String get maxDevicesMessage;

  /// No description provided for @unknownDevice.
  ///
  /// In de, this message translates to:
  /// **'Unbekanntes Gerät'**
  String get unknownDevice;

  /// No description provided for @unknown.
  ///
  /// In de, this message translates to:
  /// **'Unbekannt'**
  String get unknown;

  /// No description provided for @logoutError.
  ///
  /// In de, this message translates to:
  /// **'Fehler beim Abmelden'**
  String get logoutError;

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

  /// No description provided for @forgotPasswordTitle.
  ///
  /// In de, this message translates to:
  /// **'Passwort vergessen'**
  String get forgotPasswordTitle;

  /// No description provided for @forgotPasswordDescription.
  ///
  /// In de, this message translates to:
  /// **'Geben Sie Ihre Mitgliedernummer und den Wiederherstellungscode ein, den Sie bei der Registrierung erstellt haben.'**
  String get forgotPasswordDescription;

  /// No description provided for @passwordResetSuccess.
  ///
  /// In de, this message translates to:
  /// **'Passwort erfolgreich zurückgesetzt!\n\nSie können sich jetzt mit Ihrem neuen Passwort anmelden.'**
  String get passwordResetSuccess;

  /// No description provided for @passwordResetFailed.
  ///
  /// In de, this message translates to:
  /// **'Passwort-Zurücksetzung fehlgeschlagen'**
  String get passwordResetFailed;

  /// No description provided for @needHelp.
  ///
  /// In de, this message translates to:
  /// **'Hilfe benötigt?'**
  String get needHelp;

  /// No description provided for @helpQuestion.
  ///
  /// In de, this message translates to:
  /// **'Haben Sie Probleme bei der Anmeldung oder Registrierung?'**
  String get helpQuestion;

  /// No description provided for @helpDescription.
  ///
  /// In de, this message translates to:
  /// **'Kontaktieren Sie uns über WhatsApp und beschreiben Sie uns genau, was nicht funktioniert. Wir antworten Ihnen schnellstmöglich!'**
  String get helpDescription;

  /// No description provided for @whatsapp.
  ///
  /// In de, this message translates to:
  /// **'WhatsApp'**
  String get whatsapp;

  /// No description provided for @emailSubject.
  ///
  /// In de, this message translates to:
  /// **'Anfrage über die ICD360S App'**
  String get emailSubject;

  /// No description provided for @whatsappMessage.
  ///
  /// In de, this message translates to:
  /// **'Hallo, ich habe ein Problem mit der ICD360S App. '**
  String get whatsappMessage;

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

  /// No description provided for @cancellation.
  ///
  /// In de, this message translates to:
  /// **'Kündigung'**
  String get cancellation;

  /// No description provided for @allRightsReserved.
  ///
  /// In de, this message translates to:
  /// **'Alle Rechte vorbehalten.'**
  String get allRightsReserved;

  /// No description provided for @enterCredentials.
  ///
  /// In de, this message translates to:
  /// **'Bitte Mitgliedernummer und Passwort eingeben'**
  String get enterCredentials;

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

  /// No description provided for @membership.
  ///
  /// In de, this message translates to:
  /// **'Mitgliedschaft'**
  String get membership;

  /// No description provided for @myAppointments.
  ///
  /// In de, this message translates to:
  /// **'Meine Termine'**
  String get myAppointments;

  /// No description provided for @appointmentsLoadingReady.
  ///
  /// In de, this message translates to:
  /// **'Termine laden - API ist bereit!'**
  String get appointmentsLoadingReady;

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

  /// No description provided for @createdOn.
  ///
  /// In de, this message translates to:
  /// **'Erstellt'**
  String get createdOn;

  /// No description provided for @handler.
  ///
  /// In de, this message translates to:
  /// **'Bearbeiter'**
  String get handler;

  /// No description provided for @reportProblems.
  ///
  /// In de, this message translates to:
  /// **'Probleme melden'**
  String get reportProblems;

  /// No description provided for @reportProblem.
  ///
  /// In de, this message translates to:
  /// **'Problem melden'**
  String get reportProblem;

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

  /// No description provided for @newTicket.
  ///
  /// In de, this message translates to:
  /// **'Neues Ticket'**
  String get newTicket;

  /// No description provided for @noOpenTickets.
  ///
  /// In de, this message translates to:
  /// **'Keine offenen Tickets'**
  String get noOpenTickets;

  /// No description provided for @haveQuestionCreateTicket.
  ///
  /// In de, this message translates to:
  /// **'Haben Sie eine Frage oder ein Problem?\nErstellen Sie ein neues Ticket.'**
  String get haveQuestionCreateTicket;

  /// No description provided for @whatIsTheProblem.
  ///
  /// In de, this message translates to:
  /// **'Was ist das Problem?'**
  String get whatIsTheProblem;

  /// No description provided for @describeTheProblem.
  ///
  /// In de, this message translates to:
  /// **'Beschreiben Sie das Problem'**
  String get describeTheProblem;

  /// No description provided for @howUrgentIsIt.
  ///
  /// In de, this message translates to:
  /// **'Wie dringend ist es?'**
  String get howUrgentIsIt;

  /// No description provided for @low.
  ///
  /// In de, this message translates to:
  /// **'Niedrig'**
  String get low;

  /// No description provided for @medium.
  ///
  /// In de, this message translates to:
  /// **'Mittel'**
  String get medium;

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

  /// No description provided for @fillSubjectAndMessage.
  ///
  /// In de, this message translates to:
  /// **'Bitte Betreff und Nachricht ausfüllen'**
  String get fillSubjectAndMessage;

  /// No description provided for @ticketCreated.
  ///
  /// In de, this message translates to:
  /// **'Ticket wurde erstellt'**
  String get ticketCreated;

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

  /// No description provided for @newEmailAddress.
  ///
  /// In de, this message translates to:
  /// **'Neue E-Mail-Adresse'**
  String get newEmailAddress;

  /// No description provided for @currentPassword.
  ///
  /// In de, this message translates to:
  /// **'Aktuelles Passwort'**
  String get currentPassword;

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

  /// No description provided for @passwordChangedSuccessfully.
  ///
  /// In de, this message translates to:
  /// **'Passwort erfolgreich geändert'**
  String get passwordChangedSuccessfully;

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

  /// No description provided for @passwordTooShort.
  ///
  /// In de, this message translates to:
  /// **'Passwort muss mindestens 6 Zeichen lang sein'**
  String get passwordTooShort;

  /// No description provided for @maxDevicesReached.
  ///
  /// In de, this message translates to:
  /// **'Sie sind auf dem Maximum von 3 Geräten angemeldet.'**
  String get maxDevicesReached;

  /// No description provided for @loggedInOnDevices.
  ///
  /// In de, this message translates to:
  /// **'Sie sind auf {count} von 3 Geräten angemeldet.'**
  String loggedInOnDevices(int count);

  /// No description provided for @noActiveSessions.
  ///
  /// In de, this message translates to:
  /// **'Keine aktiven Sitzungen'**
  String get noActiveSessions;

  /// No description provided for @logoutFromDevice.
  ///
  /// In de, this message translates to:
  /// **'Von diesem Gerät abmelden'**
  String get logoutFromDevice;

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

  /// No description provided for @errorAcceptingCall.
  ///
  /// In de, this message translates to:
  /// **'Fehler beim Annehmen'**
  String get errorAcceptingCall;

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

  /// No description provided for @typingIndicator.
  ///
  /// In de, this message translates to:
  /// **'{name} tippt...'**
  String typingIndicator(String name);

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

  /// No description provided for @diagnosticDataTitle.
  ///
  /// In de, this message translates to:
  /// **'Diagnose-Daten'**
  String get diagnosticDataTitle;

  /// No description provided for @diagnosticDescription.
  ///
  /// In de, this message translates to:
  /// **'Möchten Sie anonyme Diagnosedaten senden, um die App zu verbessern?'**
  String get diagnosticDescription;

  /// No description provided for @noThanks.
  ///
  /// In de, this message translates to:
  /// **'Nein, danke'**
  String get noThanks;

  /// No description provided for @yesEnable.
  ///
  /// In de, this message translates to:
  /// **'Ja, aktivieren'**
  String get yesEnable;

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

  /// No description provided for @newPasswordMinChars.
  ///
  /// In de, this message translates to:
  /// **'Neues Passwort (min. 6 Zeichen)'**
  String get newPasswordMinChars;

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

  /// No description provided for @connectionErrorGeneric.
  ///
  /// In de, this message translates to:
  /// **'Verbindungsfehler'**
  String get connectionErrorGeneric;

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

  /// No description provided for @bankTransfer.
  ///
  /// In de, this message translates to:
  /// **'Überweisung'**
  String get bankTransfer;

  /// No description provided for @standingOrder.
  ///
  /// In de, this message translates to:
  /// **'Dauerauftrag'**
  String get standingOrder;

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

  /// No description provided for @memberNumberTooLong.
  ///
  /// In de, this message translates to:
  /// **'Mitgliedernummer zu lang (max 20 Zeichen)'**
  String get memberNumberTooLong;

  /// No description provided for @onlyUppercaseAndNumbers.
  ///
  /// In de, this message translates to:
  /// **'Nur Großbuchstaben und Zahlen erlaubt'**
  String get onlyUppercaseAndNumbers;

  /// No description provided for @passwordTooLong.
  ///
  /// In de, this message translates to:
  /// **'Passwort zu lang (max 100 Zeichen)'**
  String get passwordTooLong;

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

  /// No description provided for @diagnosticErrors.
  ///
  /// In de, this message translates to:
  /// **'Fehlermeldungen zur Verbesserung'**
  String get diagnosticErrors;

  /// No description provided for @diagnosticAnonymousStats.
  ///
  /// In de, this message translates to:
  /// **'Anonyme Nutzungsstatistiken'**
  String get diagnosticAnonymousStats;

  /// No description provided for @diagnosticPerformance.
  ///
  /// In de, this message translates to:
  /// **'App-Performance-Daten'**
  String get diagnosticPerformance;

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

  /// No description provided for @ipClean.
  ///
  /// In de, this message translates to:
  /// **'IP sauber - nicht gelistet'**
  String get ipClean;

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

  /// No description provided for @helpImproveApp.
  ///
  /// In de, this message translates to:
  /// **'Möchten Sie uns helfen, die App zu verbessern?'**
  String get helpImproveApp;

  /// No description provided for @noPersonalDataCollected.
  ///
  /// In de, this message translates to:
  /// **'Keine persönlichen Daten werden gesammelt. Diese Einstellung kann jederzeit geändert werden.'**
  String get noPersonalDataCollected;

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

  /// No description provided for @waitingForMember.
  ///
  /// In de, this message translates to:
  /// **'Warten auf Mitglied'**
  String get waitingForMember;

  /// No description provided for @waitingForStaff.
  ///
  /// In de, this message translates to:
  /// **'Warten auf Mitarbeiter'**
  String get waitingForStaff;

  /// No description provided for @waitingForAuthority.
  ///
  /// In de, this message translates to:
  /// **'Warten auf Behörde'**
  String get waitingForAuthority;
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
