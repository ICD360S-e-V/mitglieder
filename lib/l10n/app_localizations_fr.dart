// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

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
  String get confirmPassword => 'Confirmer le mot de passe';

  @override
  String get confirmPasswordHint => 'Veuillez confirmer le mot de passe';

  @override
  String get newPassword => 'Nouveau mot de passe';

  @override
  String get newPasswordHint => 'Veuillez entrer le nouveau mot de passe';

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
  String get unknown => 'Inconnu';

  @override
  String error(String error) {
    return 'Erreur: $error';
  }

  @override
  String get cancel => 'Annuler';

  @override
  String get resetPassword => 'Réinitialiser le mot de passe';

  @override
  String get imprint => 'Mentions Légales';

  @override
  String get privacy => 'Politique de Confidentialité';

  @override
  String get statutes => 'Statuts';

  @override
  String get revocation => 'Droit de Rétractation';

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
  String get myAppointments => 'Mes rendez-vous';

  @override
  String get priority => 'Priorité';

  @override
  String get messageLabel => 'Message';

  @override
  String get reportProblems => 'Signaler des problèmes';

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
  String get low => 'Faible';

  @override
  String get high => 'Élevé';

  @override
  String get submit => 'Soumettre';

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
  String get saveEmail => 'Enregistrer l\'email';

  @override
  String get savePassword => 'Enregistrer le mot de passe';

  @override
  String get deviceLoggedOut => 'Appareil déconnecté';

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
  String get autoUpdateEnableTitle => 'Install future updates automatically';

  @override
  String get autoUpdateEnableHint =>
      'The app downloads and installs updates on its own and restarts briefly. No further prompts.';

  @override
  String autoUpdateInstalling(String version) {
    return 'Version $version is being installed in the background. The app will restart shortly.';
  }

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
  String get reasonLabel2 => 'Raison';

  @override
  String get downloadFailed2 => 'Téléchargement échoué';

  @override
  String get downloadTooltip => 'Télécharger';

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
  String logEntries(int count) {
    return '$count entrées';
  }

  @override
  String get noLogs => 'Aucun journal';

  @override
  String get newLoginDetected => 'Nouvelle connexion détectée';

  @override
  String get errorNoInternet =>
      'Pas de connexion Internet. Veuillez vérifier votre réseau.';

  @override
  String get errorTimeout =>
      'Le serveur ne répond pas. Veuillez réessayer plus tard.';

  @override
  String get errorServer => 'Erreur du serveur. Veuillez réessayer plus tard.';

  @override
  String get errorConnection =>
      'Erreur de connexion. Veuillez réessayer plus tard.';

  @override
  String get errorUnexpected =>
      'Une erreur inattendue s\'est produite. Veuillez réessayer plus tard.';

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
  String get claudiuWelcomeMorning => 'Bonjour';

  @override
  String get claudiuWelcomeDay => 'Bonjour';

  @override
  String get claudiuWelcomeEvening => 'Bonsoir';

  @override
  String get claudiuWelcomeNight => 'Bonsoir';

  @override
  String get claudiuWelcomeVisitor => 'cher visiteur';

  @override
  String get claudiuWelcomeAsk => 'Comment puis-je t\'aider ?';

  @override
  String get claudiuWelcomeBecomeMember => 'Je veux devenir membre';

  @override
  String get claudiuWelcomeLogin =>
      'Je suis déjà membre et je veux me connecter';

  @override
  String get claudiuWelcomeProblem => 'J\'ai un problème avec l\'application';

  @override
  String get claudiuWelcomeEmergency => 'Urgence — appelez-nous';

  @override
  String get claudiuWelcomeMascotName => 'Claudiu';

  @override
  String get claudiuWelcomeEmergencyIntro =>
      'Avant d\'appeler — nos heures d\'ouverture :';

  @override
  String get claudiuWelcomeScheduleOffice => 'Au bureau';

  @override
  String get claudiuWelcomeScheduleField => 'Sur le terrain avec nos clients';

  @override
  String get claudiuWelcomeOutsideHoursNote =>
      'En dehors de ces horaires nous ne traitons que les urgences. Tu peux aussi nous envoyer un SMS au même numéro — nous te rappellerons.';

  @override
  String get claudiuWelcomeCallNow => 'Appeler maintenant';

  @override
  String get claudiuWelcomeSendSms => 'Envoyer un SMS';

  @override
  String get claudiuWelcomeSmsBody =>
      'Urgence à ICD360S e.V. — veuillez me contacter dès que possible.';

  @override
  String get claudiuWelcomeCloseButton => 'Fermer';

  @override
  String get claudiuLoginWelcome => 'Bon retour, cher membre !';

  @override
  String get claudiuLoginAsk =>
      'Donne-moi ton numéro de membre, s\'il te plaît.';

  @override
  String get claudiuLoginProgress => 'Presque… continue à taper.';

  @override
  String get claudiuLoginReady => 'Parfait ! Appuie sur le bouton ci-dessous.';

  @override
  String get claudiuLoginLoading => 'Je vérifie ton identité… 🔍';

  @override
  String get claudiuLoginFoundPlain => 'Trouvé ! Connexion en cours…';

  @override
  String claudiuLoginFoundNamed(String name) {
    return 'Trouvé, $name ! Connexion en cours…';
  }

  @override
  String get claudiuLoginError =>
      'Hum, je ne trouve pas ce numéro. L\'as-tu tapé correctement ?';

  @override
  String get claudiuLoginForgotHeader => 'Tu as oublié ton numéro de membre ?';

  @override
  String get claudiuLoginNoSms =>
      'Nous n\'envoyons pas le numéro par e-mail ou SMS.';

  @override
  String get claudiuLoginOnlyWay =>
      'Le seul moyen : nous rencontrer en personne au bureau de l\'association, après vérification de l\'identité.';

  @override
  String get claudiuLoginContactUs => 'Appelle-nous pour prendre rendez-vous :';

  @override
  String get claudiuDiagnosticGreeting =>
      'Avant d\'entrer, une question rapide';

  @override
  String get claudiuDiagnosticAsk =>
      'Puis-je envoyer des rapports anonymes pour que les développeurs améliorent l\'application ?';

  @override
  String get claudiuDiagnosticYes => 'Oui, je veux aider';

  @override
  String get claudiuDiagnosticNo => 'Non, je regarde juste';

  @override
  String get claudiuDiagnosticTellMore => 'Dis-m\'en plus';

  @override
  String get claudiuDiagnosticSendsHeader =>
      '📤 Ce que nous ENVOYONS (anonyme) :';

  @override
  String get claudiuDiagnosticSends1 =>
      'Un code anonyme de l\'appareil (PAS le numéro de membre)';

  @override
  String get claudiuDiagnosticSends2 => 'Ton rôle (membre / conseil)';

  @override
  String get claudiuDiagnosticSends3 =>
      'Système d\'exploitation (Linux / Android / iOS / Windows)';

  @override
  String get claudiuDiagnosticSends4 => 'Langue choisie';

  @override
  String get claudiuDiagnosticSends5 => 'Niveau et état de la batterie';

  @override
  String get claudiuDiagnosticSends6 => 'Écran actuel';

  @override
  String get claudiuDiagnosticSends7 => 'Durée de la session (secondes)';

  @override
  String get claudiuDiagnosticSends8 => 'Erreurs s\'il y en a (10 dernières)';

  @override
  String get claudiuDiagnosticSends9 => 'Navigation (20 derniers écrans)';

  @override
  String get claudiuDiagnosticNeverHeader =>
      '🛡️ Ce que nous n\'envoyons JAMAIS :';

  @override
  String get claudiuDiagnosticNever1 => 'Ton vrai nom';

  @override
  String get claudiuDiagnosticNever2 => 'Adresse e-mail';

  @override
  String get claudiuDiagnosticNever3 => 'Numéro de téléphone';

  @override
  String get claudiuDiagnosticNever4 => 'Mot de passe';

  @override
  String get claudiuDiagnosticNever5 => 'Contenu des messages de chat';

  @override
  String get claudiuDiagnosticNever6 => 'Contenu des tickets';

  @override
  String get claudiuDiagnosticNever7 => 'Documents ou pièces jointes';

  @override
  String get claudiuDiagnosticTechHeader => '📡 Détails techniques :';

  @override
  String get claudiuDiagnosticTech1 => 'Envoyé toutes les 2 minutes';

  @override
  String get claudiuDiagnosticTech2 =>
      'Connexion chiffrée TLS avec certificat épinglé';

  @override
  String get claudiuDiagnosticTech3 =>
      'Tu peux le désactiver à tout moment dans les Paramètres';

  @override
  String get claudiuProblemHelpTitle => 'Comment puis-je aider ?';

  @override
  String get claudiuProblemHelpGreeting => 'Que s\'est-il passé ?';

  @override
  String get claudiuProblemHelpAsk => 'Comment veux-tu me le dire ?';

  @override
  String get claudiuProblemHelpWriteTitle => 'Écrire un rapport';

  @override
  String get claudiuProblemHelpWriteBody =>
      'Avec des détails étape par étape. L\'équipe reçoit le texte et le résout plus tard.';

  @override
  String get claudiuProblemHelpChatTitle => 'Parlons maintenant';

  @override
  String get claudiuProblemHelpChatBody =>
      'Chat anonyme avec un opérateur. Réponse en temps réel si quelqu\'un est en ligne.';

  @override
  String get claudiuProblemHelpAltCallHeader => 'Ou, si c\'est urgent :';

  @override
  String get claudiuProblemHelpAltCallLabel => 'Appelez-nous';

  @override
  String get claudiuAnonymousChatTitle => 'Chat anonyme';

  @override
  String get claudiuAnonymousChatGreeting => 'Salut !';

  @override
  String get claudiuAnonymousChatWelcome =>
      'Je t\'écoute. Écris ce que tu veux — pas besoin de nom. Je réponds dès que je suis là.';

  @override
  String get claudiuAnonymousChatHint => 'Écris un message…';

  @override
  String get claudiuAnonymousChatWaitingOperator =>
      'En attente d\'un opérateur…';

  @override
  String get claudiuVorsitzerConnectedTitle => 'Salut !';

  @override
  String get claudiuVorsitzerConnectedBody =>
      'Merci de nous avoir écrit — tu es maintenant en contact avec un Vorsitzer. Dis-nous comment on peut t\'aider pour ta demande d\'adhésion.';

  @override
  String get claudiuVorsitzerConnectedSender => 'Vorsitzer';

  @override
  String get claudiuQuickReplyValidationTime =>
      'Combien de temps prend la validation ?';

  @override
  String get claudiuQuickReplyDocuments => 'Quels documents me faut-il ?';

  @override
  String get claudiuQuickReplyStepProblem => 'Je suis bloqué sur une étape';

  @override
  String get claudiuQuickReplyHuman =>
      'Je peux parler à quelqu\'un maintenant ?';

  @override
  String get claudiuAnonymousChatConnecting => 'Connexion…';

  @override
  String get claudiuAnonymousChatConnectionFailed =>
      'Impossible d\'ouvrir le chat. Réessaie ou appelle-nous.';

  @override
  String get claudiuAnonymousChatRetry => 'Réessayer';

  @override
  String get claudiuAnonymousChatOnline => 'Connecté';

  @override
  String get claudiuAnonymousChatOffline => 'Reconnexion…';

  @override
  String get claudiuAnonymousChatAdminTyping => 'L\'opérateur écrit…';

  @override
  String get claudiuProblemReportTitle => 'Signaler un problème';

  @override
  String get claudiuProblemReportGreeting => 'Que s\'est-il passé ?';

  @override
  String get claudiuProblemReportAsk =>
      'Dis-moi en détail et je transmettrai le rapport à l\'équipe.';

  @override
  String get claudiuProblemReportIncludeHeader => 'Merci d\'inclure :';

  @override
  String get claudiuProblemReportIncludeBullets1 =>
      'Ce que tu faisais quand le problème est apparu';

  @override
  String get claudiuProblemReportIncludeBullets2 =>
      'Tout message d\'erreur que tu as vu';

  @override
  String get claudiuProblemReportIncludeBullets3 => 'Sur quel écran tu étais';

  @override
  String get claudiuProblemReportIncludeBullets4 =>
      'L\'application plante, se ferme ou affiche un écran blanc ?';

  @override
  String get claudiuProblemReportIncludeBullets5 =>
      'Cela arrive-t-il à chaque fois ou une seule fois ?';

  @override
  String get claudiuProblemReportDescriptionLabel => 'Ta description';

  @override
  String get claudiuProblemReportDescriptionHint =>
      'P. ex. : Quand j\'ouvre l\'écran de chat j\'ai un message « Connection error » et l\'application ne répond plus…';

  @override
  String claudiuProblemReportTooShort(int count) {
    return 'Un peu plus de détails, s\'il te plaît (au moins $count caractères)';
  }

  @override
  String get claudiuProblemReportSubmit => 'Envoyer le rapport';

  @override
  String get claudiuProblemReportSubmitting => 'Envoi…';

  @override
  String get claudiuProblemReportSentTitle => 'Merci !';

  @override
  String get claudiuProblemReportSentBody =>
      'Le rapport a été envoyé. Notre équipe l\'examinera dès que possible.';

  @override
  String get claudiuProblemReportSentClose => 'Compris';

  @override
  String get claudiuProblemReportSendFailed =>
      'Impossible d\'envoyer le rapport. Appelle-nous pour une aide urgente.';

  @override
  String get claudiuProblemReportAlt => 'Ou, si c\'est urgent :';

  @override
  String get claudiuProblemReportCallLabel => 'Appelez-nous';

  @override
  String claudiuApprovalGreeting(String name) {
    return 'Salut, $name ! 👋';
  }

  @override
  String get claudiuApprovalGreetingNoName => 'Salut ! 👋';

  @override
  String get claudiuApprovalGladToSeeYou => 'Content que tu sois là !';

  @override
  String get claudiuApprovalCheckingForSafety =>
      'Pour ta sécurité, un Vorsitzer vérifie maintenant ta demande de connexion. 🛡️';

  @override
  String get claudiuApprovalMonthlyExplain =>
      '💡 Nous faisons cela tous les 30 jours pour être sûrs que c\'est bien toi. C\'est comme un check-up de sécurité — 5 minutes maximum.';

  @override
  String get claudiuApprovalSuccess =>
      'C\'est bon ! 🎉 Le Vorsitzer t\'a reconnu. Connexion en cours…';

  @override
  String get claudiuApprovalDenied =>
      'Hum, le Vorsitzer a refusé ta demande. 😔';

  @override
  String get claudiuApprovalDeniedHelp =>
      'Si tu penses que c\'est une erreur, appelle-nous pour qu\'on règle ça.';

  @override
  String get claudiuApprovalExpired =>
      'Les 5 minutes sont écoulées et nous n\'avons pas eu de réponse du Vorsitzer.';

  @override
  String get claudiuApprovalExpiredHelp =>
      'Appelle-nous et nous pourrons approuver ta demande directement. 📞';

  @override
  String get claudiuApprovalCallUs => 'Appelez-nous';

  @override
  String get claudiuApprovalTryAgain => 'Réessayer';

  @override
  String get claudiuApprovalCancel => 'Annuler';

  @override
  String get claudiuApprovalClose => 'Fermer';

  @override
  String get wizardIntroBubble1 =>
      'Salut, visiteur ! 👋 Merci de vouloir rejoindre notre famille.';

  @override
  String get wizardIntroBubble2 =>
      'Je m\'appelle Claudiu. Au printemps 2025, j\'avais une vision claire : créer une association qui aide les personnes dans le besoin — bénévolement, avec le cœur, sans bureaucratie inutile. ❤️';

  @override
  String get wizardIntroBubble3 =>
      'J\'ai commencé à parler avec les clients que je visitais. Je leur ai raconté mon rêve. Et chacun a dit : « Oui, allons-y ! » En juillet 2025, nous étions six à nous rencontrer — des gens déterminés. Nous avons décidé de fonder **ICD360S e.V.** à Neu-Ulm. 📍';

  @override
  String get wizardIntroBubble4 =>
      'Le **1er août 2025**, l\'association a officiellement vu le jour — dans le registre des associations. Le plus beau cadeau pour moi. 🎂';

  @override
  String get wizardIntroBubble5 =>
      'Que faisons-nous ? Nous aidons les réfugiés, les personnes handicapées, les personnes économiquement défavorisées, **les enfants et les jeunes** — pour les démarches administratives, l\'allemand, le logement, les courses, les prestations sociales. Notre Vorstand est composé majoritairement de personnes handicapées — ainsi les décisions viennent d\'une expérience vécue réelle. 🤝';

  @override
  String get wizardIntroBubble6 =>
      'C\'est ton tour maintenant. Inscrivons-toi — environ 5 minutes. On y va pas à pas, je ne te laisse pas seul. ✨';

  @override
  String get wizardIntroStart => 'C\'est parti';

  @override
  String get wizardBack => 'Retour';

  @override
  String get wizardNext => 'Suivant';

  @override
  String wizardStepLabel(int step, int total, String title) {
    return 'Étape $step sur $total · $title';
  }

  @override
  String get wizardErrRequired => 'Ce champ est obligatoire';

  @override
  String wizardErrTooShort(int count) {
    return 'Trop court (au moins $count caractères)';
  }

  @override
  String get wizardErrOnlyLetters =>
      'Uniquement lettres, espaces, traits d\'union et apostrophes';

  @override
  String get wizardErrSaveFailed =>
      'Impossible d\'enregistrer. Vérifie ta connexion et réessaie.';

  @override
  String get wizardStufe1aTitle => 'Identité';

  @override
  String get wizardStufe1aPrompt =>
      'Faisons connaissance officiellement. Écris ton nom exactement comme il apparaît sur ton Personalausweis, Reisepass ou Aufenthaltstitel — pour que ça corresponde à tes documents.';

  @override
  String get wizardStufe1aVornameLabel => 'Vornamen (prénoms)';

  @override
  String get wizardStufe1aVornameHelper =>
      'Tous tes prénoms, exactement comme sur le document. Avec espace ou tiret (p. ex. Hans-Peter, Maria Anna).';

  @override
  String get wizardStufe1aNachnameLabel => 'Familienname (nom de famille)';

  @override
  String get wizardStufe1aNachnameHelper => 'Ton nom de famille actuel.';

  @override
  String get wizardStufe1aGeburtsnameLabel =>
      'Geburtsname (nom de naissance) — facultatif';

  @override
  String get wizardStufe1aGeburtsnameHelper =>
      'Seulement s\'il diffère du Familienname — par exemple avant le mariage.';

  @override
  String get wizardStufe1bTitle => 'Anniversaire';

  @override
  String get wizardStufe1bPrompt =>
      'On aimerait fêter ton anniversaire avec toi ! 🎂 Et ça nous aide à vérifier que tu as au moins 16 ans — c\'est ce que dit notre Satzung.';

  @override
  String get wizardStufe1bGeburtsdatumLabel => 'Date de naissance';

  @override
  String get wizardStufe1bGeburtsdatumHelper => 'Appuie pour choisir une date';

  @override
  String get wizardStufe1bGeburtsortLabel => 'Lieu de naissance';

  @override
  String get wizardStufe1bGeburtsortHelper => 'Ville / commune où tu es né.';

  @override
  String get wizardAgeGatePrompt => 'Je suis désolé… 😔';

  @override
  String wizardAgeGateBody1(int age, int years) {
    return 'Notre Satzung dit qu\'il faut au moins 16 ans pour devenir membre. Tu as $age ans — j\'espère te revoir dans $years ans ! 🌱';
  }

  @override
  String get wizardAgeGateBody2 =>
      'Si tu veux faire du bénévolat ponctuel (à tout âge, avec l\'accord de tes parents), appelle-nous — on adore soutenir les jeunes qui veulent changer le monde.';

  @override
  String get wizardAgeGateBackHome => 'Retour à l\'accueil';

  @override
  String get wizardErrInvalidPhone => 'Numéro de téléphone invalide';

  @override
  String get wizardStufe1b1Title => 'Accord parental';

  @override
  String get wizardStufe1b1Prompt =>
      'Tu es mineur (16-17) — selon §106 BGB nous avons besoin du consentement d\'un parent ou d\'un tuteur légal. Donne-moi le nom et le téléphone. Un Vorsitzer appellera et fixera un rendez-vous (en personne ou par appel vidéo). Pas d\'e-mail — nous voulons être sûrs de parler à la bonne personne.';

  @override
  String get wizardStufe1b1VornameLabel => 'Prénom du parent';

  @override
  String get wizardStufe1b1VornameHelper =>
      'Tel qu\'il apparaît sur le Personalausweis du parent.';

  @override
  String get wizardStufe1b1NachnameLabel => 'Nom du parent';

  @override
  String get wizardStufe1b1NachnameHelper =>
      'Tel qu\'il apparaît sur le Personalausweis du parent.';

  @override
  String get wizardStufe1b1TelefonLabel => 'Mobile du parent';

  @override
  String get wizardStufe1b1TelefonHelper => 'Un Vorsitzer appellera ce numéro.';

  @override
  String get wizardStufe1b1RelationLabel => 'Relation avec l\'enfant :';

  @override
  String get wizardStufe1b1RelationMutter => 'Mère';

  @override
  String get wizardStufe1b1RelationVater => 'Père';

  @override
  String get wizardStufe1b1RelationSorgeberechtigter => 'Tuteur légal';

  @override
  String get wizardStufe1b1RelationAndere => 'Autre tuteur';

  @override
  String get wizardStufe1cTitle => 'Informations personnelles';

  @override
  String get wizardStufe1cPrompt =>
      'Juste pour mieux te connaître. Ça reste entre nous et n\'est affiché nulle part publiquement.';

  @override
  String get wizardStufe1cGeschlechtLabel => 'Genre';

  @override
  String get wizardStufe1cGeschlechtMaennlich => 'Homme';

  @override
  String get wizardStufe1cGeschlechtWeiblich => 'Femme';

  @override
  String get wizardStufe1cGeschlechtDivers => 'Divers';

  @override
  String get wizardStufe1cGeschlechtKeineAngabe => 'Préfère ne pas dire';

  @override
  String get wizardStufe1cFamilienstandLabel => 'État civil';

  @override
  String get wizardStufe1cFamilienstandLedig => 'Célibataire';

  @override
  String get wizardStufe1cFamilienstandVerheiratet => 'Marié(e)';

  @override
  String get wizardStufe1cFamilienstandGeschieden => 'Divorcé(e)';

  @override
  String get wizardStufe1cFamilienstandVerwitwet => 'Veuf/Veuve';

  @override
  String get wizardStufe1dTitle => 'Tes origines';

  @override
  String get wizardStufe1dPrompt =>
      'Cela nous aide à te proposer le bon soutien — par exemple un conseil sur l\'Aufenthalt ou trouver ta communauté linguistique.';

  @override
  String get wizardStufe1dStaatLabel => 'Nationalité';

  @override
  String get wizardStufe1dStaatHelper =>
      'Ex. deutsch, rumänisch, ukrainisch. Plusieurs séparés par une virgule.';

  @override
  String get wizardStufe1dAufenthaltLabel =>
      'Statut de séjour (Aufenthaltsstatus) — facultatif';

  @override
  String get wizardStufe1dAufenthaltHelper =>
      'Choisis le titre depuis ta Aufenthaltskarte / décision. Le Vorstand vérifie avec tes documents.';

  @override
  String get wizardStufe1dAufenthaltAwaitingCitizenship =>
      'Renseigne d\'abord la nationalité ci-dessus — on n\'affiche que les options pertinentes.';

  @override
  String get wizardStufe1dAufenthaltGerman =>
      'Aucun Aufenthaltstitel requis — citoyen allemand.';

  @override
  String get wizardStufe1dAufenthaltEuEea =>
      'Citoyen UE/EEE/CH — libre circulation (Freizügigkeit).';

  @override
  String get wizardStufe1dAufenthaltTempHint => 'temporaire';

  @override
  String get wizardStufe1dAufenthaltPermHint => 'séjour permanent';

  @override
  String get wizardStufe1dAufenthaltAsylumProcessHint => 'procédure d\'asile';

  @override
  String get wizardStufe1dAufenthaltOther => 'Autre (précise dans le chat)';

  @override
  String get wizardStufe1dAufenthaltRequired => 'Choisis un Aufenthaltstitel.';

  @override
  String get wizardStufe1dMutterspracheLabel => 'Langue maternelle';

  @override
  String get wizardStufe1dMutterspracheHelper =>
      'Pré-rempli avec la langue de l\'app — change si différent.';

  @override
  String get wizardStufe1eTitle => 'Adresse';

  @override
  String get wizardStufe1ePrompt =>
      'Ton adresse postale — nous l\'utilisons pour les documents officiels (Satzung, contrats de membre, notifications).';

  @override
  String get wizardStufe1eStrasseLabel => 'Rue';

  @override
  String get wizardStufe1eStrasseHelper =>
      'Juste le nom de la rue — le numéro va dans la case d\'à côté.';

  @override
  String get wizardStufe1eHausnummerLabel => 'N°';

  @override
  String get wizardStufe1ePlzLabel => 'PLZ (CP)';

  @override
  String get wizardStufe1eOrtLabel => 'Ville';

  @override
  String get wizardStufe1eLandLabel => 'Pays';

  @override
  String get wizardStufe1eLandHelper => 'Pré-rempli : Deutschland.';

  @override
  String get wizardErrInvalidStreet => 'Nom de rue invalide';

  @override
  String get wizardErrInvalidHausnummer =>
      'Numéro invalide (p. ex. 12, 12a, 12/3)';

  @override
  String get wizardErrInvalidPlz =>
      'Code postal invalide (chiffres uniquement)';

  @override
  String get wizardStufe1fTitle => 'Contact';

  @override
  String get wizardStufe1fPrompt =>
      'Comment te joindre ? Le téléphone, c\'est uniquement pour les urgences — tout le reste passe par notre canal chiffré de bout en bout dans l\'app. Ton e-mail de membre t\'est attribué automatiquement et s\'affiche ci-dessous.';

  @override
  String get wizardStufe1fTelefonLabel => 'Mobile';

  @override
  String get wizardStufe1fTelefonHelper =>
      'Promis, je n\'appelle que si c\'est important. 📱';

  @override
  String get wizardStufe2Title => 'Type de membre';

  @override
  String get wizardStufe2Prompt =>
      'Quel type de membre veux-tu être ? Laisse-moi t\'expliquer chaque option.';

  @override
  String get wizardStufe2OrdentlichTitle => 'Membre ordinaire (ordentlich)';

  @override
  String get wizardStufe2OrdentlichBody =>
      'Droits complets. Tu paies la cotisation mensuelle, tu votes à l\'assemblée générale, tu peux être élu au Vorstand. Choix par défaut.';

  @override
  String get wizardStufe2FoerderTitle => 'Membre soutien (Fördermitglied)';

  @override
  String get wizardStufe2FoerderBody =>
      'Tu soutiens l\'association financièrement mais ne participes pas activement aux décisions. Pas de droit de vote. Bien si tu veux aider à distance.';

  @override
  String get wizardStufe2EhrenTitle => 'Membre honoraire (Ehrenmitglied)';

  @override
  String get wizardStufe2EhrenBody =>
      'Décerné par le Vorstand pour services exceptionnels. Tu ne le choisis pas — il est attribué en reconnaissance. Sélectionne uniquement si tu as déjà été honoré.';

  @override
  String get wizardStufe3Title => 'Situation financière';

  @override
  String get wizardStufe3Prompt =>
      'Maintenant ta situation financière. Pas pour te juger — juste pour t\'exempter de cotisation si tu reçois des aides sociales.';

  @override
  String get wizardStufe3OptionBuergergeld => 'Je reçois Bürgergeld';

  @override
  String get wizardStufe3OptionSozialamt => 'Je reçois des aides du Sozialamt';

  @override
  String get wizardStufe3OptionNein => 'Je ne reçois aucune de ces aides';

  @override
  String get wizardStufe3FeeExemptTitle => 'Cotisation : 0 € / mois 🎉';

  @override
  String get wizardStufe3FeeExemptBody =>
      'Avec Bürgergeld, Sozialamt, ALG I ou Krankengeld tu es totalement exempté de cotisation selon Satzung §6. Il nous faut juste un justificatif (Leistungsbescheid ou attestation de l\'administration / caisse maladie).';

  @override
  String get wizardStufe3UploadTitle => 'Téléverser Leistungsbescheid';

  @override
  String get wizardStufe3UploadHint => 'PDF / JPG / PNG, 10 Mo max.';

  @override
  String get wizardStufe3UploadRequired =>
      'Téléverse le Leistungsbescheid avant de continuer.';

  @override
  String get wizardStufe3FileTooLarge => 'Fichier trop volumineux. 10 Mo max.';

  @override
  String get wizardStufe3UploadFailed =>
      'Impossible de téléverser le fichier. Réessaye.';

  @override
  String get wizardStufe3RegularFeeTitle => 'Cotisation : 25 € / mois';

  @override
  String get wizardStufe3RegularFeeBody =>
      'Cotisation standard pour les membres ordinaires selon le Satzung.';

  @override
  String get wizardStufe4Title => 'Paiement';

  @override
  String get wizardStufe4Prompt =>
      'Comment veux-tu payer la cotisation ? Et quel jour du mois préfères-tu pour le prélèvement ?';

  @override
  String get wizardStufe4MethodUeberweisungTitle => 'Virement (Überweisung)';

  @override
  String get wizardStufe4MethodUeberweisungBody =>
      'Tu déclenches le paiement chaque mois depuis ton compte.';

  @override
  String get wizardStufe4MethodSepaTitle => 'SEPA-Lastschrift (prélèvement)';

  @override
  String get wizardStufe4MethodSepaBody =>
      'Nous prélevons le montant automatiquement sur ton compte. Le plus pratique, mais il nous faut ton IBAN et un mandat signé.';

  @override
  String get wizardStufe4MethodDauerauftragTitle =>
      'Dauerauftrag (ordre permanent)';

  @override
  String get wizardStufe4MethodDauerauftragBody =>
      'Tu mets en place un ordre permanent à ta banque. Ta banque transfère le montant automatiquement chaque mois.';

  @override
  String get wizardStufe4DayLabel => 'Jour du paiement';

  @override
  String get wizardStufe4DayHint => 'Choisis un jour entre 1 et 31';

  @override
  String wizardStufe4DayItem(int day) {
    return 'Le $day';
  }

  @override
  String wizardStufe4DayReminder(int day) {
    return 'La cotisation sera prélevée le $day de chaque mois.';
  }

  @override
  String get wizardStufe5Title => 'Début';

  @override
  String get wizardStufe5Prompt =>
      'À partir de quand veux-tu être officiellement membre d\'ICD360S ? Dès l\'approbation ou rétroactivement.';

  @override
  String get wizardStufe5OptionAbVerifizierungTitle =>
      'À partir de l\'approbation du Vorstand';

  @override
  String get wizardStufe5OptionAbVerifizierungBody =>
      'Le choix le plus simple. Pas de cotisation rétroactive.';

  @override
  String get wizardStufe5OptionGruendungsdatumTitle =>
      'Rétroactivement depuis le 01.08.2025 (fondation)';

  @override
  String get wizardStufe5OptionGruendungsdatumBody =>
      'Tu comptes comme membre dès le premier jour de l\'association.';

  @override
  String get wizardStufe5OptionAnderesDatumTitle => 'Une autre date';

  @override
  String get wizardStufe5OptionAnderesDatumBody =>
      'Tu choisis une date entre le 01.08.2025 et aujourd\'hui.';

  @override
  String get wizardStufe5PickDate => 'Appuie pour choisir une date';

  @override
  String get wizardStufe5PickDateFirst => 'Choisis d\'abord une date.';

  @override
  String get wizardStufe5DatePickerHelp => 'Début de l\'adhésion';

  @override
  String wizardStufe5DateRange(String start) {
    return 'Entre le $start et aujourd\'hui';
  }

  @override
  String get wizardStufe5RetroactiveTitle => 'Cotisation rétroactive';

  @override
  String wizardStufe5RetroactiveBody(
      String start, String end, int months, String amount) {
    return 'De $start à $end cela fait $months mois. À 25 €/mois cela représente $amount € à payer rétroactivement, en plus de la cotisation mensuelle courante.';
  }

  @override
  String get wizardStufe5FeeExemptTitle => 'Cotisation rétroactive : 0 € 🎉';

  @override
  String get wizardStufe5FeeExemptBody =>
      'Avec Bürgergeld ou Sozialamt tu es totalement exempté — même rétroactivement, tu ne dois rien.';

  @override
  String wizardDocumentPrompt(String doc) {
    return 'Avant de conclure, lis attentivement le $doc. C\'est important de savoir ce que tu signes.';
  }

  @override
  String get wizardDocumentScrollHint =>
      'Fais défiler jusqu\'en bas pour continuer.';

  @override
  String get wizardDocumentScrolledOk => 'Tu as lu jusqu\'au bout ✓';

  @override
  String wizardDocumentOpenButton(String doc) {
    return 'Ouvrir $doc dans le navigateur';
  }

  @override
  String get wizardDocumentExternalHint =>
      'Sur cette plateforme, nous ouvrons le document dans ton navigateur par défaut.';

  @override
  String get wizardDocumentOpenedOk =>
      'Le document a été ouvert. Lis-le attentivement.';

  @override
  String wizardDocumentConfirm(String doc) {
    return 'Je confirme avoir lu et accepter le $doc.';
  }

  @override
  String get wizardFinalAdultTitle => 'C\'est fait ! Tu es inscrit 🎉';

  @override
  String get wizardFinalMinorTitle => 'Ta demande a été envoyée 📨';

  @override
  String get wizardFinalMinorBody =>
      'Nous contacterons ton parent et organiserons un rendez-vous (en personne ou par appel vidéo). Sois patient — la procédure peut prendre jusqu\'à 7 jours. Tu recevras une notification dans l\'app dès que ton parent aura donné son accord.';

  @override
  String get wizardFinalMitgliedernummerLabel => 'Ton numéro de membre';

  @override
  String get wizardStufe4MethodComingSoon => 'Bientôt disponible';

  @override
  String get wizardStufe4StreichungWarning =>
      'Si tu accumules plus de 6 mois de retard sur la cotisation, on te radie automatiquement (Satzung §6 Abs. 3).';

  @override
  String get wizardStufe5KuendigungInfo =>
      'Pour partir : envoie-nous ta démission par écrit 3 mois avant le 31 décembre (au plus tard le 30 septembre pour effet en fin d\'année). Pas de durée minimale (Satzung §6 Abs. 3).';

  @override
  String get wizardStufe1fEmailLabel => 'Ton e-mail de membre';

  @override
  String get wizardStufe1fEmailHelper =>
      'Attribué automatiquement à partir de ton numéro de membre. Activé dès que le conseil d\'administration (Vorstand) valide ta demande. Nous avons notre propre application e-mail — envoie et reçois des e-mails chiffrés, simple et gratuit.';

  @override
  String get wizardErrInvalidEmail => 'Adresse e-mail invalide';

  @override
  String get wizardStufe3OptionAlg1 =>
      'Je perçois Arbeitslosengeld I (ALG I, allocation chômage)';

  @override
  String get wizardStufe3OptionKrankengeld =>
      'Je perçois Krankengeld (indemnités maladie longue durée)';

  @override
  String get wizardStufe3UploadAddMore => 'Ajouter un autre document';

  @override
  String get wizardStufe3UploadLimitCount =>
      'Limite atteinte : 20 documents maximum.';

  @override
  String get wizardStufe3UploadLimitTotal =>
      'Limite totale de 100 Mo atteinte. Supprime un fichier existant.';

  @override
  String get wizardStufe3UploadDeleteTooltip => 'Supprimer';

  @override
  String wizardStufe3UploadCounter(int count, int max) {
    return '$count / $max documents';
  }

  @override
  String get wizardDocumentExternalOpenFailed =>
      'Impossible d\'ouvrir le navigateur. Le lien est dans le presse-papiers — colle-le dans un navigateur pour continuer.';

  @override
  String get wizardFinalTimelineProcessing =>
      'Vorstand examine · en général 1 jour ouvré, jusqu’à 7';

  @override
  String get wizardFinalTimelineActivated => 'Compte activé';

  @override
  String get wizardFinalAdultThank =>
      'Merci d\'avoir rempli le formulaire d\'inscription ! 🎉';

  @override
  String get wizardFinalAdultUsual =>
      'Ta demande est entre nos mains. On la valide en général en un jour ouvré.';

  @override
  String get wizardFinalAdultExceptional =>
      'Parfois ça peut prendre jusqu\'à 7 jours ouvrés. Et si quelque chose ne colle pas, on te renvoie au formulaire pour corriger 🙂';

  @override
  String get wizardFinalStatusTitle => 'STATUT DE LA DEMANDE';

  @override
  String wizardFinalStatusStepsValidated(int reviewed, int total) {
    return '$reviewed/$total étapes validées par le Vorstand';
  }

  @override
  String get wizardFinalStufeSheetTitle => 'Détails de la demande';

  @override
  String get wizardFinalStufeSheetHint =>
      'Les 8 étapes que tu as remplies. Le Vorstand les vérifie une par une — tu vois en temps réel ce qui a été validé.';

  @override
  String get wizardFinalStufeStatusPending => 'En attente de vérification';

  @override
  String get wizardFinalStufeStatusApproved => 'Validé';

  @override
  String get wizardFinalStufeStatusRejected => 'Rejeté';

  @override
  String wizardFinalStatusRejectionCount(int count) {
    return '$count étape à corriger';
  }

  @override
  String get wizardFinalStufeRejectionReason => 'Motif du Vorstand :';

  @override
  String get wizardFinalStufeCorrectNow => 'Corriger maintenant';

  @override
  String wizardFinalApprovalsHeader(int current, int total) {
    return 'Approbations du Vorstand ($current/$total)';
  }

  @override
  String get wizardFinalApprovalAwaiting => 'En attente du 2e Vorstand';

  @override
  String get wizardFinalApprovalRejected => 'REJETÉ';

  @override
  String get wizardFinalStufeNoDataYet => 'Données pas encore disponibles.';

  @override
  String get wizardFinalStufeReadAt => 'Lu le :';

  @override
  String get wizardFinalStufeBeitragsfrei =>
      'Exempté de cotisation (sans paiement)';

  @override
  String get wizardFinalStufeNotExempt => 'Sans aides sociales';

  @override
  String get wizardFinalStufeBeginAtVerification => 'Débute à la vérification';

  @override
  String get wizardFinalStufeBeginAtFoundation =>
      'Date de fondation (rétroactif)';

  @override
  String get wizardFinalStufeBeginAtCustom => 'Autre date';

  @override
  String get wizardFinalStufeStatusSkipped => 'Sauté';

  @override
  String get wizardFinalStufeFilledAt => 'Rempli :';

  @override
  String get wizardFinalStufeReviewedAt => 'Vérifié :';

  @override
  String get wizardFinalWithdrawLink => 'Retirer la demande';

  @override
  String get wizardFinalWithdrawDialogTitle => 'Retirer ta demande ?';

  @override
  String get wizardFinalWithdrawDialogBody =>
      'Ta demande sera marquée comme retirée par toi. Les données restent dans la base pour audit (RGPD), mais le compte ne sera pas activé. Tu peux relancer l\'inscription à tout moment avec un nouveau numéro de membre.';

  @override
  String get wizardFinalWithdrawKeep => 'Non, j’attends';

  @override
  String get wizardFinalWithdrawConfirm => 'Oui, retirer';

  @override
  String get wizardErrTooManyWithdrawals =>
      'Ta demande ne peut pas être traitée automatiquement. Appelle-nous ou viens en personne au Vorstand pour continuer ton inscription.';

  @override
  String get wizardDuplicateLoginTitle => 'On dirait que tu es déjà membre';

  @override
  String get wizardDuplicateLoginBody =>
      'Avec ton nom et ta date de naissance, on trouve déjà un compte actif. Utilise « Je suis déjà membre » sur l\'écran d\'accueil pour te connecter. Si tu n\'as plus accès, appelle-nous.';

  @override
  String get wizardDuplicatePendingTitle => 'Ta demande est déjà chez nous';

  @override
  String get wizardDuplicatePendingBody =>
      'Avec ton nom et ta date de naissance, on a déjà une demande en cours d\'examen. Le Vorstand y travaille — on te notifie dans l\'app dès que ton compte est actif. Appelle-nous si tu veux en discuter.';

  @override
  String get wizardDuplicateRecentlyWithdrawnTitle =>
      'On ne peut pas traiter cette demande maintenant';

  @override
  String get wizardDuplicateRecentlyWithdrawnBody =>
      'Ton nom et ta date de naissance correspondent à une demande retirée récemment. Appelle-nous pour parler avec le Vorstand avant de continuer.';

  @override
  String get wizardDuplicatePreviouslyWithdrawnTitle =>
      'Tu as déjà déposé une demande';

  @override
  String get wizardDuplicatePreviouslyWithdrawnBody =>
      'Ton nom et ta date de naissance correspondent à une demande plus ancienne que tu avais retirée. Re-bienvenue — appelle-nous avant de continuer pour que le Vorstand décide comment on procède.';

  @override
  String get wizardDuplicateCallUsTitle => 'Appelle-nous, s’il te plaît';

  @override
  String get wizardDuplicateCallUsBody =>
      'Ton nom et ta date de naissance figurent déjà chez nous, mais on ne peut pas te donner les détails via l\'app. Appelle-nous — le Vorstand t\'expliquera la situation directement.';

  @override
  String get wizardChatHelp => 'Parlons';

  @override
  String get wizardChatHelpSubtitle =>
      'Chat en direct avec le Vorstand · réponse rapide';

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

  @override
  String get signaturTitel => 'Unterschriften';

  @override
  String get signaturNichtsOffen =>
      'Zurzeit liegt nichts zur Unterschrift vor.';

  @override
  String get signaturStatusOffen => 'Wartet auf Ihre Unterschrift';

  @override
  String get signaturStatusSigniert => 'Von Ihnen unterschrieben';

  @override
  String get signaturStatusAbgelehnt => 'Von Ihnen abgelehnt';

  @override
  String get signaturStatusWiderrufen => 'Vom Verein zurückgezogen';

  @override
  String get signaturStatusAbgelaufen => 'Frist abgelaufen';

  @override
  String signaturBitteGanzLesen(int gelesen, int gesamt) {
    return 'Bitte lesen Sie das Dokument bis zum Ende (Seite $gelesen von $gesamt).';
  }

  @override
  String get signaturWeiterZurUnterschrift => 'Weiter zur Unterschrift';

  @override
  String get signaturAblehnen => 'Ablehnen';

  @override
  String get signaturAblehnenHinweis =>
      'Der Verein wird darüber benachrichtigt. Sie können Ihre Gründe angeben.';

  @override
  String get signaturAblehnenGrund => 'Grund (freiwillig)';

  @override
  String get signaturMitFingerHinweis =>
      'Unterschreiben Sie mit dem Finger im weißen Feld.';

  @override
  String get signaturNochmal => 'Noch einmal';

  @override
  String get signaturZurueckZumDokument => 'Zurück zum Dokument';

  @override
  String get signaturCodeAnfordern => 'Code per SMS anfordern';

  @override
  String get signaturCodeUnterwegs => 'Der Code ist unterwegs.';

  @override
  String signaturCodeGesendetAn(String nummer) {
    return 'Wir haben Ihnen einen Code an $nummer geschickt.';
  }

  @override
  String get signaturCodeErneutSenden => 'Code erneut senden';

  @override
  String get signaturJetztUnterschreiben => 'Jetzt unterschreiben';

  @override
  String get signaturCodeFalsch => 'Der Code stimmt nicht.';

  @override
  String get signaturCodeAbgelaufen =>
      'Der Code ist abgelaufen. Bitte fordern Sie einen neuen an.';

  @override
  String get signaturZuVieleVersuche =>
      'Zu viele Fehlversuche. Bitte fordern Sie einen neuen Code an.';

  @override
  String get signaturKeineRufnummer =>
      'Für Ihr Konto ist keine Mobilnummer hinterlegt. Ohne sie können wir Ihnen keinen Code schicken — bitte wenden Sie sich an den Vorsitzenden.';

  @override
  String get signaturCodeFehlgeschlagen =>
      'Der Code konnte nicht verschickt werden.';

  @override
  String get signaturLeer => 'Bitte unterschreiben Sie zuerst.';

  @override
  String get signaturErfolg => 'Danke — Ihre Unterschrift ist eingegangen.';

  @override
  String get signaturFehlgeschlagen =>
      'Das hat nicht geklappt. Bitte versuchen Sie es noch einmal.';

  @override
  String get signaturSiegelInArbeit =>
      'Das Siegel wird noch erstellt. Bitte versuchen Sie es in einer Minute noch einmal.';
}
