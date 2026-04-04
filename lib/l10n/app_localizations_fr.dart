// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'ICD360S e.V - Portail Membres';

  @override
  String get memberPortal => 'Portail Membres';

  @override
  String get welcomeLoading => 'Chargement...';

  @override
  String get welcomeAutoLogin => 'Connexion automatique...';

  @override
  String get login => 'Connexion';

  @override
  String get register => 'Inscription';

  @override
  String get becomeMember => 'Devenir Membre';

  @override
  String get memberNumber => 'Numéro de Membre';

  @override
  String get memberNumberHint => 'Veuillez entrer le numéro de membre';

  @override
  String get password => 'Mot de passe';

  @override
  String get passwordHint => 'Veuillez entrer le mot de passe';

  @override
  String get confirmPassword => 'Confirmer le mot de passe';

  @override
  String get confirmPasswordHint => 'Veuillez confirmer le mot de passe';

  @override
  String get newPassword => 'Nouveau mot de passe';

  @override
  String get newPasswordHint => 'Veuillez entrer le nouveau mot de passe';

  @override
  String get saveCredentials => 'Enregistrer les identifiants';

  @override
  String get autoLogin => 'Connexion automatique';

  @override
  String get forgotPassword => 'Mot de passe oublié ?';

  @override
  String get firstName => 'Prénom et Nom';

  @override
  String get firstNameHint => 'Veuillez entrer le prénom et le nom';

  @override
  String get nameMinLength => 'Le nom doit avoir au moins 2 caractères';

  @override
  String get nameOnlyLetters => 'Seules les lettres et tirets sont autorisés';

  @override
  String get email => 'Adresse e-mail';

  @override
  String get emailHint => 'Veuillez entrer l\'email';

  @override
  String get emailInvalid => 'Veuillez entrer un email valide';

  @override
  String get passwordMinLength =>
      'Le mot de passe doit avoir au moins 6 caractères';

  @override
  String get passwordsNotMatch => 'Les mots de passe ne correspondent pas';

  @override
  String get recoveryCode => 'Code de Récupération (6 chiffres)';

  @override
  String get recoveryCodeHelper =>
      'Mémorisez ce code pour récupérer votre mot de passe';

  @override
  String get recoveryCodeHint => 'Veuillez entrer le code de récupération';

  @override
  String get recoveryCodeInvalid => 'Le code doit avoir exactement 6 chiffres';

  @override
  String get loginFailed => 'Échec de connexion';

  @override
  String get registrationFailed => 'Échec d\'inscription';

  @override
  String connectionError(String error) {
    return 'Erreur de connexion: $error';
  }

  @override
  String registrationSuccess(String memberNumber) {
    return 'Inscription réussie!\n\nVotre numéro de membre: $memberNumber\n\nMémorisez ce numéro pour la connexion.';
  }

  @override
  String get tooManyDevices => 'Trop d\'appareils';

  @override
  String get maxDevicesMessage =>
      'Vous êtes déjà connecté sur 3 appareils.\nSélectionnez un appareil à déconnecter:';

  @override
  String get unknownDevice => 'Appareil inconnu';

  @override
  String get unknown => 'Inconnu';

  @override
  String get logoutError => 'Erreur de déconnexion';

  @override
  String error(String error) {
    return 'Erreur: $error';
  }

  @override
  String get cancel => 'Annuler';

  @override
  String get resetPassword => 'Réinitialiser le mot de passe';

  @override
  String get forgotPasswordTitle => 'Mot de passe oublié';

  @override
  String get forgotPasswordDescription =>
      'Entrez votre numéro de membre et le code de récupération créé lors de l\'inscription.';

  @override
  String get passwordResetSuccess =>
      'Mot de passe réinitialisé avec succès!\n\nVous pouvez maintenant vous connecter avec votre nouveau mot de passe.';

  @override
  String get passwordResetFailed => 'Échec de réinitialisation';

  @override
  String get needHelp => 'Besoin d\'aide ?';

  @override
  String get helpQuestion => 'Des problèmes de connexion ou d\'inscription ?';

  @override
  String get helpDescription =>
      'Contactez-nous via WhatsApp et décrivez exactement ce qui ne fonctionne pas. Nous répondrons dès que possible!';

  @override
  String get whatsapp => 'WhatsApp';

  @override
  String get emailSubject => 'Demande via l\'application ICD360S';

  @override
  String get whatsappMessage =>
      'Bonjour, j\'ai un problème avec l\'application ICD360S. ';

  @override
  String get imprint => 'Mentions Légales';

  @override
  String get privacy => 'Politique de Confidentialité';

  @override
  String get statutes => 'Statuts';

  @override
  String get revocation => 'Droit de Rétractation';

  @override
  String get cancellation => 'Résiliation';

  @override
  String get allRightsReserved => 'Tous droits réservés.';

  @override
  String get enterCredentials =>
      'Veuillez entrer le numéro de membre et le mot de passe';

  @override
  String get appointments => 'Rendez-vous';

  @override
  String get tickets => 'Tickets';

  @override
  String get liveChat => 'Chat en Direct';

  @override
  String get notifications => 'Notifications';

  @override
  String get myProfile => 'Mon Profil';

  @override
  String get logout => 'Déconnexion';

  @override
  String get goodMorning => 'Bonjour';

  @override
  String get goodDay => 'Bonne journée';

  @override
  String get goodEvening => 'Bonsoir';

  @override
  String get goodNight => 'Bonne nuit';

  @override
  String get welcomeToICD => 'Bienvenue chez ICD360S e.V!';

  @override
  String get accountCreatedSuccessfully =>
      'Votre compte a été créé avec succès.';

  @override
  String get today => 'Aujourd\'hui';

  @override
  String get membershipFeeDue => 'Cotisation de membre due';

  @override
  String get pleaseTransferAnnualFee =>
      'Veuillez transférer la cotisation annuelle.';

  @override
  String get newBadge => 'Nouveau';

  @override
  String get close => 'Fermer';

  @override
  String get membership => 'Adhésion';

  @override
  String get myAppointments => 'Mes rendez-vous';

  @override
  String get appointmentsLoadingReady =>
      'Chargement des rendez-vous - API prêt!';

  @override
  String get priority => 'Priorité';

  @override
  String get messageLabel => 'Message';

  @override
  String get createdOn => 'Créé';

  @override
  String get handler => 'Gestionnaire';

  @override
  String get reportProblems => 'Signaler des problèmes';

  @override
  String get reportProblem => 'Signaler un problème';

  @override
  String get weRespondIn24Hours =>
      'Nous vous répondrons dans un délai maximum de 24 heures!';

  @override
  String get everythingOk => 'Tout va bien!';

  @override
  String get haveProblemWeHelp => 'Un problème?\nNous nous en occupons!';

  @override
  String get myMembership => 'Mon adhésion';

  @override
  String get managePersonalDataAndFee =>
      'Gérer vos données personnelles et cotisation';

  @override
  String get myAppointmentsTitle => 'Mes rendez-vous';

  @override
  String get appointmentsDescription =>
      'Ici vous pouvez voir vos rendez-vous à venir.\nVous pouvez confirmer votre participation ou refuser.';

  @override
  String get loadAppointments => 'Charger les rendez-vous';

  @override
  String get myTickets => 'Mes tickets';

  @override
  String get newTicket => 'Nouveau ticket';

  @override
  String get noOpenTickets => 'Aucun ticket ouvert';

  @override
  String get haveQuestionCreateTicket =>
      'Vous avez une question ou un problème?\nCréez un nouveau ticket.';

  @override
  String get whatIsTheProblem => 'Quel est le problème ?';

  @override
  String get describeTheProblem => 'Décrivez le problème';

  @override
  String get howUrgentIsIt => 'Quelle est l\'urgence ?';

  @override
  String get low => 'Faible';

  @override
  String get medium => 'Moyen';

  @override
  String get high => 'Élevé';

  @override
  String get submit => 'Soumettre';

  @override
  String get fillSubjectAndMessage => 'Veuillez remplir le sujet et le message';

  @override
  String get ticketCreated => 'Ticket créé';

  @override
  String get errorCreatingTicket => 'Erreur lors de la création du ticket';

  @override
  String get verified => 'Vérifié';

  @override
  String get account => 'Compte';

  @override
  String get myDevices => 'Mes appareils';

  @override
  String get changeEmail => 'Changer l\'email';

  @override
  String get changePassword => 'Changer le mot de passe';

  @override
  String get newEmailAddress => 'Nouvelle adresse email';

  @override
  String get currentPassword => 'Mot de passe actuel';

  @override
  String get saveEmail => 'Enregistrer l\'email';

  @override
  String get savePassword => 'Enregistrer le mot de passe';

  @override
  String get deviceLoggedOut => 'Appareil déconnecté';

  @override
  String get passwordChangedSuccessfully => 'Mot de passe modifié avec succès';

  @override
  String get emailChangedSuccessfully => 'Email modifié avec succès';

  @override
  String get errorChangingPassword =>
      'Erreur lors du changement de mot de passe';

  @override
  String get errorChangingEmail => 'Erreur lors du changement d\'email';

  @override
  String get validEmailRequired => 'Veuillez entrer une adresse email valide';

  @override
  String get passwordTooShort =>
      'Le mot de passe doit contenir au moins 6 caractères';

  @override
  String get maxDevicesReached =>
      'Vous êtes connecté sur le maximum de 3 appareils.';

  @override
  String loggedInOnDevices(int count) {
    return 'Vous êtes connecté sur $count appareils sur 3.';
  }

  @override
  String get noActiveSessions => 'Aucune session active';

  @override
  String get logoutFromDevice => 'Se déconnecter de cet appareil';

  @override
  String get confirmLogoutDevice => 'Déconnecter l\'appareil ?';

  @override
  String get confirmLogoutMessage =>
      'Voulez-vous vous déconnecter de cet appareil?\n\nVous devrez vous reconnecter pour utiliser cet appareil.';

  @override
  String get ipAddress => 'IP';

  @override
  String get platform => 'Plateforme';

  @override
  String trialWarningUrgentTitle(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days jours',
      one: '1 jour',
    );
    return 'Attention: Plus que $_temp0 avant la suspension du compte!';
  }

  @override
  String get trialWarningTitle => 'Votre compte n\'est pas encore vérifié';

  @override
  String get trialWarningDescription =>
      'Veuillez compléter vos données dans \"Mon Profil\". Après 30 jours, votre compte sera automatiquement suspendu.';

  @override
  String trialDaysRemaining(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days jours',
      one: '1 jour',
    );
    return '$_temp0';
  }

  @override
  String get overview => 'Aperçu';

  @override
  String get member => 'Membre';

  @override
  String get memberManagement => 'Gestion des membres';

  @override
  String get reportProblemTooltip => 'Signaler un problème';

  @override
  String get newAppointmentsTitle => 'Nouveaux rendez-vous';

  @override
  String get youHaveNewAppointment => 'Vous avez un nouveau rendez-vous.';

  @override
  String youHaveNewAppointments(int count) {
    return 'Vous avez $count nouveaux rendez-vous.';
  }

  @override
  String get appointmentReminderTomorrow => 'Rappel: Rendez-vous demain';

  @override
  String tomorrowAppointment(String title) {
    return 'Demain: $title';
  }

  @override
  String youHaveTomorrowAppointments(int count) {
    return 'Vous avez $count rendez-vous demain.';
  }

  @override
  String get appointmentsToday => 'Rendez-vous aujourd\'hui';

  @override
  String todayAppointment(String title) {
    return 'Aujourd\'hui: $title';
  }

  @override
  String youHaveTodayAppointments(int count) {
    return 'Vous avez $count rendez-vous aujourd\'hui.';
  }

  @override
  String get paymentReminder => 'Rappel de paiement';

  @override
  String paymentReminderMessage(int day, String method) {
    return 'Aujourd\'hui c\'est le $day du mois – veuillez compléter $method.';
  }

  @override
  String get paymentDayLabel => 'Jour de paiement (rappel mensuel)';

  @override
  String get updateAvailable => 'Mise à jour disponible';

  @override
  String newVersionAvailable(String version) {
    return 'Une nouvelle version est disponible : $version';
  }

  @override
  String currentVersionLabel(String version) {
    return 'Version actuelle : $version';
  }

  @override
  String get changes => 'Modifications :';

  @override
  String downloadProgress(String percent) {
    return 'Téléchargement : $percent%';
  }

  @override
  String get installationStarting => 'Installation en cours...';

  @override
  String get appWillRestart => 'L\'application redémarrera automatiquement.';

  @override
  String get later => 'Plus tard';

  @override
  String get updateNow => 'Mettre à jour maintenant';

  @override
  String get downloading => 'Téléchargement en cours...';

  @override
  String get downloadFailed =>
      'Échec du téléchargement. Veuillez réessayer plus tard.';

  @override
  String get searchingForUpdates => 'Recherche de mises à jour...';

  @override
  String get appUpToDate => 'L\'application est à jour';

  @override
  String get updateCheckError => 'Erreur lors de la vérification';

  @override
  String get changelog => 'Journal des modifications';

  @override
  String get terminConfirmed => 'Rendez-vous confirmé';

  @override
  String get terminDeclined => 'Rendez-vous refusé';

  @override
  String get terminRescheduleRequested => 'Report demandé';

  @override
  String get statusConfirmed => 'Confirmé';

  @override
  String get statusDeclined => 'Refusé';

  @override
  String get statusRescheduling => 'Report';

  @override
  String get statusPending => 'En attente';

  @override
  String get categoryVorstandssitzung => 'Réunion du conseil';

  @override
  String get categoryMitgliederversammlung => 'Assemblée générale';

  @override
  String get categorySchulung => 'Formation';

  @override
  String get categorySonstiges => 'Autre';

  @override
  String openCount(int count) {
    return '$count ouvert(s)';
  }

  @override
  String get refresh => 'Actualiser';

  @override
  String get filterUpcoming => 'À venir';

  @override
  String get filterPast => 'Passés';

  @override
  String get filterAll => 'Tous';

  @override
  String get noUpcomingAppointments => 'Pas de rendez-vous à venir';

  @override
  String get noPastAppointments => 'Pas de rendez-vous passés';

  @override
  String get noAppointmentsAvailable => 'Aucun rendez-vous disponible';

  @override
  String get appointmentsShownHere => 'Vos rendez-vous seront affichés ici';

  @override
  String get dateLabel => 'Date';

  @override
  String get timeLabel => 'Heure';

  @override
  String get locationLabel => 'Lieu';

  @override
  String get createdByLabel => 'Créé par';

  @override
  String get descriptionLabel => 'Description';

  @override
  String get ticketLabel => 'Ticket';

  @override
  String get yourStatus => 'Votre statut : ';

  @override
  String reasonLabel(String reason) {
    return 'Raison : $reason';
  }

  @override
  String durationMinutes(int minutes) {
    return '$minutes min';
  }

  @override
  String get confirm => 'Confirmer';

  @override
  String get decline => 'Refuser';

  @override
  String get reschedule => 'Reporter';

  @override
  String get requestReschedule => 'Demander un report';

  @override
  String appointmentLabel(String title) {
    return 'Rendez-vous : $title';
  }

  @override
  String get rescheduleReason => 'Raison du report *';

  @override
  String get rescheduleReasonHint => 'Veuillez indiquer une raison...';

  @override
  String get pleaseProvideReason => 'Veuillez indiquer une raison';

  @override
  String get request => 'Demander';

  @override
  String get ticketStatusOpen => 'Ouvert';

  @override
  String get ticketStatusInProgress => 'En cours';

  @override
  String get ticketStatusWaitingMember => 'En attente du membre';

  @override
  String get ticketStatusWaitingStaff => 'En attente du personnel';

  @override
  String get ticketStatusWaitingAuthority => 'En attente de l\'autorité';

  @override
  String get ticketStatusDone => 'Terminé';

  @override
  String get ticketPriorityHigh => 'Haute';

  @override
  String get ticketPriorityMedium => 'Moyenne';

  @override
  String get ticketPriorityLow => 'Basse';

  @override
  String get comments => 'Commentaires';

  @override
  String get documents => 'Documents';

  @override
  String get details => 'Détails';

  @override
  String get replySent => 'Réponse envoyée';

  @override
  String get sendError => 'Erreur d\'envoi';

  @override
  String get uploading => 'Chargement...';

  @override
  String fileUploaded(String filename) {
    return '$filename chargé';
  }

  @override
  String get uploadFailed => 'Échec du chargement';

  @override
  String get openError => 'Erreur d\'ouverture';

  @override
  String get noRepliesYet => 'Pas encore de réponses';

  @override
  String get waitingForSupport => 'En attente de réponse du support';

  @override
  String get writeReply => 'Écrire une réponse...';

  @override
  String get attachFile => 'Joindre un fichier';

  @override
  String documentsCount(int count) {
    return 'Documents ($count)';
  }

  @override
  String get upload => 'Charger';

  @override
  String get noDocuments => 'Aucun document disponible';

  @override
  String get allowedFormats => 'Formats autorisés : PDF, JPEG, JPG, TXT, ZIP';

  @override
  String get yourMessage => 'Votre message :';

  @override
  String get translation => 'Traduction';

  @override
  String get original => 'Original';

  @override
  String get originalText => 'Texte original';

  @override
  String get autoTranslated => 'Traduit automatiquement';

  @override
  String get originalTapTranslation =>
      'Texte original · Appuyez pour la traduction';

  @override
  String get translatedTapOriginal => 'Traduit · Appuyez pour l\'original';

  @override
  String get justNow => 'À l\'instant';

  @override
  String minutesAgo(int minutes) {
    return 'il y a $minutes min';
  }

  @override
  String hoursAgo(int hours) {
    return 'il y a $hours h';
  }

  @override
  String daysAgo(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'jours',
      one: 'jour',
    );
    return 'il y a $days $_temp0';
  }

  @override
  String get createdLabel => 'Créé';

  @override
  String get updatedLabel => 'Mis à jour';

  @override
  String get handlerLabel => 'Responsable';

  @override
  String get doneLabel => 'Terminé';

  @override
  String get newTicketTitle => 'Nouveau ticket';

  @override
  String get categoryOptional => 'Catégorie (optionnel)';

  @override
  String get selectCategory => 'Choisir';

  @override
  String get subjectLabel => 'Objet';

  @override
  String get fillAllFields => 'Veuillez remplir tous les champs';

  @override
  String ticketCreatedId(int id) {
    return 'Ticket #$id créé';
  }

  @override
  String get priorityLabel => 'Priorité : ';

  @override
  String get supportOffline => 'Support hors ligne';

  @override
  String get lastSeenSeconds => 'Actif il y a quelques secondes';

  @override
  String lastSeenMinutes(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: 'minutes',
      one: 'minute',
    );
    return 'Actif il y a $minutes $_temp0';
  }

  @override
  String lastSeenHours(int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: 'heures',
      one: 'heure',
    );
    return 'Actif il y a $hours $_temp0';
  }

  @override
  String lastSeenDays(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'jours',
      one: 'jour',
    );
    return 'Actif il y a $days $_temp0';
  }

  @override
  String get online => 'En ligne';

  @override
  String get callSupport => 'Appeler';

  @override
  String get typeMessage => 'Écrire un message...';

  @override
  String get callBusy => 'Le support est occupé';

  @override
  String get callRejected => 'Appel refusé';

  @override
  String get callFailed => 'Appel impossible';

  @override
  String get callEnded => 'Appel terminé';

  @override
  String get callSupportBusy => 'Le support est déjà en appel';

  @override
  String get errorStartingChat => 'Erreur au démarrage du chat';

  @override
  String get errorStartingCall => 'Erreur au démarrage de l\'appel';

  @override
  String get errorConnecting => 'Erreur de connexion';

  @override
  String get errorAcceptingCall => 'Erreur lors de l\'acceptation';

  @override
  String get errorDownloading => 'Erreur de téléchargement';

  @override
  String get errorUploading => 'Erreur de chargement';

  @override
  String get errorSending => 'Erreur d\'envoi';

  @override
  String get errorPickingPhotos => 'Erreur de sélection des photos';

  @override
  String get errorPickingFiles => 'Erreur de sélection des fichiers';

  @override
  String get errorTakingPhoto => 'Erreur de prise de photo';

  @override
  String get fileNotLoaded => 'Le fichier n\'a pas pu être chargé';

  @override
  String get attachmentIdMissing => 'ID de pièce jointe manquant';

  @override
  String get camera => 'Appareil photo';

  @override
  String get gallery => 'Galerie';

  @override
  String get file => 'Fichier';

  @override
  String typingIndicator(String name) {
    return '$name écrit...';
  }

  @override
  String get notifNewMessageFrom => 'Nouveau message de';

  @override
  String get notifUrgentPrefix => 'URGENT';

  @override
  String get notifUrgentMessage => 'MESSAGE URGENT';

  @override
  String get notifIncomingCall => 'Appel entrant';

  @override
  String get notifCallingYou => 'vous appelle...';

  @override
  String get notifUpdateAvailable => 'Mise à jour disponible';

  @override
  String get notifVersionAvailable => 'est maintenant disponible';

  @override
  String get notifConnected => 'Connecté';

  @override
  String get notifDisconnected => 'Déconnecté';

  @override
  String get notifConnectedBody => 'Vous êtes maintenant connecté au serveur.';

  @override
  String get notifDisconnectedBody => 'La connexion au serveur a été perdue.';

  @override
  String get notifError => 'Erreur';

  @override
  String get retry => 'Réessayer';

  @override
  String get save => 'Enregistrer';

  @override
  String get accept => 'Accepter';

  @override
  String get selectFile => 'Sélectionner un fichier';

  @override
  String get dataLoadingText => 'Chargement des données...';

  @override
  String get dataSavedSuccess => 'Données enregistrées avec succès';

  @override
  String get errorSaving => 'Erreur lors de l\'enregistrement';

  @override
  String get errorLoading => 'Erreur de chargement';

  @override
  String savedFilename(String filename) {
    return 'Enregistré : $filename';
  }

  @override
  String get logsCopied => 'Journaux copiés !';

  @override
  String get diagnosticDataTitle => 'Données de diagnostic';

  @override
  String get diagnosticDescription =>
      'Souhaitez-vous envoyer des données de diagnostic anonymes pour améliorer l\'application ?';

  @override
  String get noThanks => 'Non, merci';

  @override
  String get yesEnable => 'Oui, activer';

  @override
  String get passwordMinEightChars =>
      'Le mot de passe doit comporter au moins 8 caractères';

  @override
  String get passwordChangeSuccess => 'Mot de passe modifié avec succès';

  @override
  String get emailChangeError => 'Erreur lors du changement d\'e-mail';

  @override
  String get acceptDocumentCheckbox => 'J\'ai lu et j\'accepte le document.';

  @override
  String loadingErrorGeneric(String details) {
    return 'Erreur de chargement : $details';
  }

  @override
  String get incomingCallTitle => 'Appel entrant';

  @override
  String ringingFor(int seconds) {
    return 'Sonne depuis ${seconds}s';
  }

  @override
  String get rejectCall => 'Refuser';

  @override
  String get acceptCall => 'Accepter';

  @override
  String get unmute => 'Réactiver le son';

  @override
  String get mute => 'Couper le son';

  @override
  String get hangUp => 'Raccrocher';

  @override
  String get calling => 'Appel en cours...';

  @override
  String autoRejectIn(int seconds) {
    return 'Rejet automatique dans $seconds secondes';
  }

  @override
  String get speakerOn => 'Haut-parleur';

  @override
  String get speakerOff => 'Écouteur';

  @override
  String get micMuted => 'Muet';

  @override
  String get micOn => 'Microphone';

  @override
  String get connectionExcellent => 'Excellente';

  @override
  String get connectionGood => 'Bonne';

  @override
  String get connectionWeak => 'Faible';

  @override
  String get connectionLost => 'Déconnecté';

  @override
  String get personalData => 'Données personnelles';

  @override
  String get personalDataSubtitle => 'Nom, prénom, adresse';

  @override
  String get membershipFee => 'Cotisation';

  @override
  String annualFeeYear(String year) {
    return 'Cotisation annuelle $year';
  }

  @override
  String get amount => 'Montant :';

  @override
  String get dueBy => 'Échéance :';

  @override
  String get paid => 'Payé';

  @override
  String get versionHistory => 'Historique des versions';

  @override
  String lastUpdated(String date) {
    return 'Dernière mise à jour : $date';
  }

  @override
  String get noVersionHistory => 'Aucun historique disponible';

  @override
  String get failedLoadChangelog => 'Échec du chargement';

  @override
  String get callMember => 'Appeler le membre';

  @override
  String get closeConversation => 'Fermer la conversation';

  @override
  String get chatOffline => 'Hors ligne';

  @override
  String get attachFiles => 'Joindre des fichiers (max. 10, 50Mo)';

  @override
  String get conversationClosed => 'Cette conversation a été fermée';

  @override
  String get noMessages => 'Aucun message';

  @override
  String get goBack => 'Retour';

  @override
  String get goForward => 'Suivant';

  @override
  String get homePage => 'Accueil';

  @override
  String get firstNameLabel => 'Prénom';

  @override
  String get lastNameLabel => 'Nom';

  @override
  String get streetLabel => 'Rue';

  @override
  String get houseNumberLabel => 'N°';

  @override
  String get postalCodeLabel => 'Code postal';

  @override
  String get cityLabel => 'Ville';

  @override
  String get phoneMobileLabel => 'Téléphone (Mobile)';

  @override
  String get phoneLandlineLabel => 'Téléphone (Fixe)';

  @override
  String get newEmailLabel => 'Nouvelle adresse e-mail';

  @override
  String get currentPasswordLabel => 'Mot de passe actuel';

  @override
  String get newPasswordLabel => 'Nouveau mot de passe';

  @override
  String get confirmPasswordLabel => 'Confirmer le mot de passe';

  @override
  String get emailChangedSuccess => 'E-mail modifié avec succès';

  @override
  String get newPasswordMinChars => 'Nouveau mot de passe (min. 6 car.)';

  @override
  String get reasonLabel2 => 'Raison';

  @override
  String get downloadFailed2 => 'Téléchargement échoué';

  @override
  String get downloadTooltip => 'Télécharger';

  @override
  String get connectionErrorGeneric => 'Erreur de connexion';

  @override
  String get copyLogs => 'Copier les journaux';

  @override
  String get deleteLogs => 'Supprimer les journaux';

  @override
  String get autoScrollOn => 'Défilement auto ACTIVÉ';

  @override
  String get autoScrollOff => 'Défilement auto DÉSACTIVÉ';

  @override
  String get unknownValue => 'Inconnu';

  @override
  String get bankTransfer => 'Virement';

  @override
  String get standingOrder => 'Ordre permanent';

  @override
  String get payment => 'Paiement';

  @override
  String get warningType_ermahnung => 'Avertissement';

  @override
  String get warningType_abmahnung => 'Mise en demeure';

  @override
  String get warningType_letzte => 'Dernière mise en demeure';

  @override
  String warningsTotal(int count) {
    return 'Total : $count';
  }

  @override
  String warningsErmahnung(int count) {
    return 'Avertissements : $count';
  }

  @override
  String warningsAbmahnung(int count) {
    return 'Mises en demeure : $count';
  }

  @override
  String warningsLetzte(int count) {
    return 'Dernières : $count';
  }

  @override
  String get noWarnings => 'Aucun avertissement';

  @override
  String get noWarningsDescription =>
      'Vous n\'avez actuellement aucun avertissement.';

  @override
  String createdBy(String name) {
    return 'Créé par : $name';
  }

  @override
  String get monthJan => 'Jan';

  @override
  String get monthFeb => 'Fév';

  @override
  String get monthMar => 'Mar';

  @override
  String get monthApr => 'Avr';

  @override
  String get monthMay => 'Mai';

  @override
  String get monthJun => 'Jun';

  @override
  String get monthJul => 'Jul';

  @override
  String get monthAug => 'Aoû';

  @override
  String get monthSep => 'Sep';

  @override
  String get monthOct => 'Oct';

  @override
  String get monthNov => 'Nov';

  @override
  String get monthDec => 'Déc';

  @override
  String get stufe1_name => 'Données personnelles';

  @override
  String get stufe2_name => 'Type d\'adhésion';

  @override
  String get stufe3_name => 'Situation financière';

  @override
  String get stufe4_name => 'Mode de paiement';

  @override
  String get stufe5_name => 'Début d\'adhésion';

  @override
  String get stufe6_name => 'Statuts';

  @override
  String get stufe7_name => 'Politique de confidentialité';

  @override
  String get stufe8_name => 'Droit de rétractation';

  @override
  String get memberType_ordentlich => 'Membre ordinaire';

  @override
  String get memberType_foerder => 'Membre de soutien';

  @override
  String get memberType_ehren => 'Membre d\'honneur';

  @override
  String get memberDesc_ordentlich =>
      'Membre actif avec droit de vote. Participe aux services de l\'association.';

  @override
  String get memberDesc_foerder =>
      'Soutient l\'association par des cotisations. Peut participer à l\'assemblée avec voix consultative.';

  @override
  String get memberDesc_ehren =>
      'A les droits d\'un membre ordinaire sans l\'obligation de payer des cotisations.';

  @override
  String get payMethod_ueberweisung => 'Virement';

  @override
  String get payMethod_dauerauftrag => 'Ordre permanent';

  @override
  String get verifyStatus_geprueft => 'Vérifié';

  @override
  String get verifyStatus_ausgefuellt => 'Complété';

  @override
  String get verifyStatus_abgelehnt => 'Refusé';

  @override
  String get verifyStatus_offen => 'Ouvert';

  @override
  String get fillRequiredFields =>
      'Veuillez remplir tous les champs obligatoires.';

  @override
  String get personalDataSaved => 'Données personnelles enregistrées';

  @override
  String get selectMemberType => 'Veuillez sélectionner un type d\'adhésion.';

  @override
  String get memberTypeSaved => 'Type d\'adhésion enregistré';

  @override
  String get selectOption => 'Veuillez sélectionner une option.';

  @override
  String get financialSaved => 'Situation financière enregistrée';

  @override
  String get selectPaymentMethod =>
      'Veuillez sélectionner un mode de paiement.';

  @override
  String get paymentDataSaved => 'Données de paiement enregistrées';

  @override
  String get selectDate => 'Veuillez sélectionner une date.';

  @override
  String get membershipStartSaved => 'Début d\'adhésion enregistré';

  @override
  String get fileTooLarge => 'Fichier trop volumineux (max. 10 Mo).';

  @override
  String get leistungsbescheidUploaded => 'Attestation téléchargée avec succès';

  @override
  String get verificationProgress => 'Progression de la vérification';

  @override
  String get notApplicable => 'Non applicable';

  @override
  String get socialBenefitsExempt =>
      'Mode de paiement non requis pour les bénéficiaires d\'aides sociales.';

  @override
  String get locked => 'Verrouillé';

  @override
  String completePreviousStep(int step) {
    return 'Veuillez d\'abord compléter l\'étape $step.';
  }

  @override
  String rejectedNote(String note) {
    return 'Refusé : $note';
  }

  @override
  String get waitingForReview => 'En attente de vérification par le conseil.';

  @override
  String get stepApproved => 'Cette étape a été vérifiée et approuvée.';

  @override
  String get changesViaChat =>
      'Modifications possibles uniquement via le chat.';

  @override
  String get firstNameRequired => 'Prénom *';

  @override
  String get lastNameRequired => 'Nom *';

  @override
  String get birthDateLabel => 'Date de naissance *';

  @override
  String get streetRequired => 'Rue *';

  @override
  String get houseNumberRequired => 'N° *';

  @override
  String get cityRequired => 'Ville *';

  @override
  String get phoneRequired => 'Numéro de téléphone *';

  @override
  String get phonePurpose =>
      'Objectif : Contact en cas d\'injoignabilité via l\'application';

  @override
  String get selectMemberTypePrompt =>
      'Sélectionnez votre type d\'adhésion souhaité :';

  @override
  String get financialExplanation =>
      'Pour vérifier votre éligibilité à une réduction de cotisation, nous avons besoin des informations suivantes.';

  @override
  String get socialBenefitsQuestion =>
      'Recevez-vous actuellement des prestations sociales ?';

  @override
  String get optionBuergergeld => 'Oui, allocation citoyenne (Pôle emploi)';

  @override
  String get optionSozialamt => 'Oui, aide sociale';

  @override
  String get optionNoBenefits =>
      'Non, je ne reçois pas de prestations sociales';

  @override
  String get feeExempt => 'Votre cotisation mensuelle : 0,00 €/mois';

  @override
  String get uploadLeistungsbescheid => 'Télécharger l\'attestation';

  @override
  String get uploadLeistungsbescheidHint =>
      'Veuillez télécharger une attestation récente dans les 14 jours.';

  @override
  String get allowedFormatsUpload =>
      'Formats autorisés : PDF, JPG, PNG (max. 10 Mo)';

  @override
  String get feeRegular => 'Votre cotisation mensuelle : 25,00 €/mois';

  @override
  String paymentDayReminder(int day) {
    return 'Rappel le $day de chaque mois.';
  }

  @override
  String get membershipStartPrompt =>
      'Choisissez quand votre adhésion doit commencer.';

  @override
  String get optionAfterVerification => 'Après la vérification';

  @override
  String get optionAfterVerificationDesc =>
      'L\'adhésion commence à la confirmation du conseil.';

  @override
  String get optionRetroFoundation =>
      'Rétroactif à la date de fondation (01.08.2025)';

  @override
  String get optionRetroFoundationDesc =>
      'Vous devenez membre rétroactivement depuis la fondation.';

  @override
  String get optionRetroCustom => 'Rétroactif à une autre date';

  @override
  String get optionRetroCustomDesc =>
      'Choisissez une date entre le 01.08.2025 et aujourd\'hui.';

  @override
  String get selectDateLabel => 'Sélectionner la date';

  @override
  String get selectDateHint => 'Sélectionner la date...';

  @override
  String get dateNotBefore => 'Pas avant le 01.08.2025 (date de fondation)';

  @override
  String get feeExemptRetro =>
      'Exempté : 0,00 € rétroactif.\nSeule la date d\'adhésion est définie rétroactivement.';

  @override
  String get retroactiveFees => 'Cotisations rétroactives';

  @override
  String retroFeeCalculation(
      String from, String to, String months, String total) {
    return 'Période : $from – $to\nMois : $months\nCotisation : $months × 25,00 € = $total €';
  }

  @override
  String get pleaseReadSatzung =>
      'Veuillez lire les statuts de l\'association.';

  @override
  String get pleaseReadDatenschutz =>
      'Veuillez lire la politique de confidentialité.';

  @override
  String get pleaseReadWiderruf => 'Veuillez lire le droit de rétractation.';

  @override
  String get acceptedAtRegistration => 'Accepté lors de l\'inscription';

  @override
  String get confirmedByBoard =>
      'Sera confirmé après vérification par le conseil.';

  @override
  String get docSatzung => 'Statuts';

  @override
  String get docDatenschutz => 'Politique de confidentialité';

  @override
  String get docWiderruf => 'Droit de rétractation';

  @override
  String acceptedAtRegCount(int count) {
    return 'Accepté lors de l\'inscription ($count/3)';
  }

  @override
  String acceptedOn(String date) {
    return 'Accepté le $date';
  }

  @override
  String get notAccepted => 'Non accepté';

  @override
  String get statusAccepted => 'Accepté';

  @override
  String get memberNumberTooLong =>
      'Numéro de membre trop long (max 20 caractères)';

  @override
  String get onlyUppercaseAndNumbers =>
      'Seules les lettres majuscules et les chiffres sont autorisés';

  @override
  String get passwordTooLong => 'Mot de passe trop long (max 100 caractères)';

  @override
  String get nameTooLong => 'Nom trop long (max 100 caractères)';

  @override
  String get emailTooLong => 'E-mail trop long (max 255 caractères)';

  @override
  String get legalAcknowledgePrefix => 'J\'ai pris connaissance de la ';

  @override
  String get legalAcknowledgeSuffix => '.';

  @override
  String get legalStatutesSuffix =>
      ' de l\'ICD360S e.V. et les reconnais comme contraignants.';

  @override
  String get legalPleaseReadFirst => '(veuillez lire d\'abord)';

  @override
  String get statusActive => 'Actif';

  @override
  String get statusSuspended => 'Suspendu';

  @override
  String get statusNew => 'Nouveau';

  @override
  String get statusCancelled => 'Résilié';

  @override
  String get statusDeleted => 'Supprimé';

  @override
  String get roleMitglied => 'Membre';

  @override
  String get roleVorsitzer => 'Président';

  @override
  String get roleStellvertreter => 'Adjoint';

  @override
  String get roleSchatzmeister => 'Trésorier';

  @override
  String get roleSchriftfuehrer => 'Secrétaire';

  @override
  String get roleBeisitzer => 'Assesseur';

  @override
  String get roleKassierer => 'Caissier';

  @override
  String get roleKassenpruefer => 'Commissaire aux comptes';

  @override
  String get roleEhrenamtlich => 'Bénévole';

  @override
  String get roleMitgliedergruender => 'Membre Fondateur';

  @override
  String get roleEhrenmitglied => 'Membre Honoraire';

  @override
  String get roleFoerdermitglied => 'Membre de Soutien';

  @override
  String get memberTypeNotSet => 'Pas encore défini';

  @override
  String get payMethodSepa => 'Prélèvement SEPA';

  @override
  String get labelStatus => 'Statut';

  @override
  String get labelMemberNumber => 'Numéro de membre';

  @override
  String get labelRole => 'Rôle';

  @override
  String get labelMemberType => 'Type de membre';

  @override
  String get labelPaymentMethod => 'Mode de paiement';

  @override
  String get labelRegisteredOn => 'Inscrit le';

  @override
  String get labelLastLogin => 'Dernière connexion';

  @override
  String get labelMemberSince => 'Membre depuis';

  @override
  String get neverLoggedIn => 'Jamais';

  @override
  String get notActivatedYet => 'Pas encore activé';

  @override
  String get tabVerification => 'Vérification';

  @override
  String get tabWarnings => 'Avertissements';

  @override
  String get tabDocuments => 'Documents';

  @override
  String get tabMembership => 'Adhésion';

  @override
  String get pleaseEnterFirstName => 'Veuillez saisir le prénom';

  @override
  String get pleaseEnterLastName => 'Veuillez saisir le nom';

  @override
  String get noFileDataReceived => 'Aucune donnée reçue';

  @override
  String get openFile => 'Ouvrir';

  @override
  String get diagnosticErrors => 'Rapports d\'erreurs pour amélioration';

  @override
  String get diagnosticAnonymousStats => 'Statistiques d\'utilisation anonymes';

  @override
  String get diagnosticPerformance =>
      'Données de performance de l\'application';

  @override
  String get noMicrophoneError =>
      'Aucun microphone trouvé. Veuillez connecter un microphone et réessayer.';

  @override
  String get startConversation => 'Démarrez une conversation !';

  @override
  String get staffWillReply => 'Un collaborateur vous répondra bientôt.';

  @override
  String get inCall => 'En appel...';

  @override
  String get registration => 'Inscription';

  @override
  String get deactivation => 'Désactivation';

  @override
  String get deactivatedOn => 'Désactivé le';

  @override
  String get accountAutoSuspend =>
      'Les comptes non vérifiés dans les 30 jours seront automatiquement suspendus.';

  @override
  String get ipClean => 'IP propre - non listé';

  @override
  String get documentsProvidedByBoard =>
      'Les documents sont fournis par le conseil d\'administration.';

  @override
  String get noDocumentsAvailable => 'Aucun document disponible';

  @override
  String get noDocumentsDescription =>
      'Aucun document ne vous a encore été fourni.';

  @override
  String uploadedBy(String name) {
    return 'Téléchargé par : $name';
  }

  @override
  String stepsCompleted(int completed, int total) {
    return '$completed/$total étapes terminées';
  }

  @override
  String dayOfMonth(int day) {
    return '$day du mois';
  }

  @override
  String changeField(String field) {
    return 'Modifier $field';
  }

  @override
  String openDocument(String name) {
    return 'Ouvrir $name';
  }

  @override
  String get helpImproveApp =>
      'Souhaitez-vous nous aider à améliorer l\'application ?';

  @override
  String get noPersonalDataCollected =>
      'Aucune donnée personnelle n\'est collectée. Ce paramètre peut être modifié à tout moment.';

  @override
  String logEntries(int count) {
    return '$count entrées';
  }

  @override
  String get noLogs => 'Aucun journal';

  @override
  String get newLoginDetected => 'Nouvelle connexion détectée';

  @override
  String get waitingForMember => 'En attente du membre';

  @override
  String get waitingForStaff => 'En attente du personnel';

  @override
  String get waitingForAuthority => 'En attente de l\'autorité';
}
