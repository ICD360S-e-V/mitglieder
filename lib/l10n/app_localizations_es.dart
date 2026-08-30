// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get welcomeLoading => 'Cargando...';

  @override
  String get welcomeAutoLogin => 'Inicio de sesión automático...';

  @override
  String get login => 'Iniciar Sesión';

  @override
  String get register => 'Registrarse';

  @override
  String get becomeMember => 'Hacerse Miembro';

  @override
  String get memberNumber => 'Número de Miembro';

  @override
  String get memberNumberHint => 'Ingrese el número de miembro';

  @override
  String get confirmPassword => 'Confirmar Contraseña';

  @override
  String get confirmPasswordHint => 'Confirme la contraseña';

  @override
  String get newPassword => 'Nueva Contraseña';

  @override
  String get newPasswordHint => 'Ingrese la nueva contraseña';

  @override
  String get firstName => 'Nombre y Apellido';

  @override
  String get firstNameHint => 'Ingrese nombre y apellido';

  @override
  String get nameMinLength => 'El nombre debe tener al menos 2 caracteres';

  @override
  String get nameOnlyLetters => 'Solo se permiten letras y guiones';

  @override
  String get email => 'Correo Electrónico';

  @override
  String get emailHint => 'Ingrese el correo electrónico';

  @override
  String get emailInvalid => 'Ingrese un correo válido';

  @override
  String get passwordMinLength =>
      'La contraseña debe tener al menos 6 caracteres';

  @override
  String get passwordsNotMatch => 'Las contraseñas no coinciden';

  @override
  String get registrationFailed => 'Error de registro';

  @override
  String connectionError(String error) {
    return 'Error de conexión: $error';
  }

  @override
  String registrationSuccess(String memberNumber) {
    return '¡Registro exitoso!\n\nSu número de miembro: $memberNumber\n\nRecuerde este número para iniciar sesión.';
  }

  @override
  String get unknown => 'Desconocido';

  @override
  String error(String error) {
    return 'Error: $error';
  }

  @override
  String get cancel => 'Cancelar';

  @override
  String get resetPassword => 'Restablecer Contraseña';

  @override
  String get imprint => 'Aviso Legal';

  @override
  String get privacy => 'Política de Privacidad';

  @override
  String get statutes => 'Estatutos';

  @override
  String get revocation => 'Derecho de Desistimiento';

  @override
  String get appointments => 'Citas';

  @override
  String get tickets => 'Tickets';

  @override
  String get liveChat => 'Chat en Vivo';

  @override
  String get notifications => 'Notificaciones';

  @override
  String get myProfile => 'Mi Perfil';

  @override
  String get logout => 'Cerrar Sesión';

  @override
  String get goodMorning => 'Buenos días';

  @override
  String get goodDay => 'Buen día';

  @override
  String get goodEvening => 'Buenas tardes';

  @override
  String get goodNight => 'Buenas noches';

  @override
  String get welcomeToICD => '¡Bienvenido a ICD360S e.V!';

  @override
  String get accountCreatedSuccessfully =>
      'Su cuenta ha sido creada con éxito.';

  @override
  String get today => 'Hoy';

  @override
  String get membershipFeeDue => 'Cuota de membresía vencida';

  @override
  String get pleaseTransferAnnualFee => 'Por favor, transfiera la cuota anual.';

  @override
  String get newBadge => 'Nuevo';

  @override
  String get close => 'Cerrar';

  @override
  String get myAppointments => 'Mis citas';

  @override
  String get priority => 'Prioridad';

  @override
  String get messageLabel => 'Mensaje';

  @override
  String get reportProblems => 'Reportar problemas';

  @override
  String get weRespondIn24Hours =>
      '¡Le responderemos en un máximo de 24 horas!';

  @override
  String get everythingOk => '¡Todo bien!';

  @override
  String get haveProblemWeHelp => '¿Tiene un problema?\n¡Nos encargamos!';

  @override
  String get myMembership => 'Mi membresía';

  @override
  String get managePersonalDataAndFee =>
      'Administre sus datos personales y cuota';

  @override
  String get myAppointmentsTitle => 'Mis citas';

  @override
  String get appointmentsDescription =>
      'Aquí puede ver sus citas próximas.\nPuede confirmar su participación o rechazar.';

  @override
  String get loadAppointments => 'Cargar citas';

  @override
  String get myTickets => 'Mis tickets';

  @override
  String get low => 'Bajo';

  @override
  String get high => 'Alto';

  @override
  String get submit => 'Enviar';

  @override
  String get errorCreatingTicket => 'Error al crear el ticket';

  @override
  String get verified => 'Verificado';

  @override
  String get account => 'Cuenta';

  @override
  String get myDevices => 'Mis dispositivos';

  @override
  String get changeEmail => 'Cambiar email';

  @override
  String get changePassword => 'Cambiar contraseña';

  @override
  String get saveEmail => 'Guardar email';

  @override
  String get savePassword => 'Guardar contraseña';

  @override
  String get deviceLoggedOut => 'Dispositivo desconectado';

  @override
  String get emailChangedSuccessfully => 'Email cambiado con éxito';

  @override
  String get errorChangingPassword => 'Error al cambiar la contraseña';

  @override
  String get errorChangingEmail => 'Error al cambiar el email';

  @override
  String get validEmailRequired =>
      'Por favor ingrese una dirección de email válida';

  @override
  String get confirmLogoutDevice => '¿Cerrar sesión del dispositivo?';

  @override
  String get confirmLogoutMessage =>
      '¿Desea cerrar sesión en este dispositivo?\n\nDeberá iniciar sesión nuevamente para usar este dispositivo.';

  @override
  String get ipAddress => 'IP';

  @override
  String get platform => 'Plataforma';

  @override
  String trialWarningUrgentTitle(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'quedan $days días',
      one: 'queda 1 día',
    );
    return '¡Atención: Solo $_temp0 hasta la suspensión de la cuenta!';
  }

  @override
  String get trialWarningTitle => 'Su cuenta aún no está verificada';

  @override
  String get trialWarningDescription =>
      'Por favor complete sus datos en \"Mi Perfil\". Después de 30 días, su cuenta será suspendida automáticamente.';

  @override
  String trialDaysRemaining(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days días',
      one: '1 día',
    );
    return '$_temp0';
  }

  @override
  String get overview => 'Resumen';

  @override
  String get member => 'Miembro';

  @override
  String get memberManagement => 'Gestión de miembros';

  @override
  String get reportProblemTooltip => 'Informar problema';

  @override
  String get newAppointmentsTitle => 'Nuevas citas';

  @override
  String get youHaveNewAppointment => 'Tiene una nueva cita.';

  @override
  String youHaveNewAppointments(int count) {
    return 'Tiene $count nuevas citas.';
  }

  @override
  String get appointmentReminderTomorrow => 'Recordatorio: Cita mañana';

  @override
  String tomorrowAppointment(String title) {
    return 'Mañana: $title';
  }

  @override
  String youHaveTomorrowAppointments(int count) {
    return 'Tiene $count citas mañana.';
  }

  @override
  String get appointmentsToday => 'Citas hoy';

  @override
  String todayAppointment(String title) {
    return 'Hoy: $title';
  }

  @override
  String youHaveTodayAppointments(int count) {
    return 'Tiene $count citas hoy.';
  }

  @override
  String get paymentReminder => 'Recordatorio de pago';

  @override
  String paymentReminderMessage(int day, String method) {
    return 'Hoy es el día $day del mes – por favor complete $method.';
  }

  @override
  String get paymentDayLabel => 'Día de pago (recordatorio mensual)';

  @override
  String get updateAvailable => 'Actualización disponible';

  @override
  String newVersionAvailable(String version) {
    return 'Hay una nueva versión disponible: $version';
  }

  @override
  String currentVersionLabel(String version) {
    return 'Versión actual: $version';
  }

  @override
  String get changes => 'Cambios:';

  @override
  String downloadProgress(String percent) {
    return 'Descarga: $percent%';
  }

  @override
  String get installationStarting => 'Iniciando instalación...';

  @override
  String get appWillRestart => 'La aplicación se reiniciará automáticamente.';

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
  String get later => 'Más tarde';

  @override
  String get updateNow => 'Actualizar ahora';

  @override
  String get downloading => 'Descargando...';

  @override
  String get downloadFailed =>
      'Error en la descarga. Inténtelo de nuevo más tarde.';

  @override
  String get searchingForUpdates => 'Buscando actualizaciones...';

  @override
  String get appUpToDate => 'La aplicación está actualizada';

  @override
  String get updateCheckError => 'Error al buscar actualizaciones';

  @override
  String get changelog => 'Registro de cambios';

  @override
  String get terminConfirmed => 'Cita confirmada';

  @override
  String get terminDeclined => 'Cita rechazada';

  @override
  String get terminRescheduleRequested => 'Reprogramación solicitada';

  @override
  String get statusConfirmed => 'Confirmado';

  @override
  String get statusDeclined => 'Rechazado';

  @override
  String get statusRescheduling => 'Reprogramación';

  @override
  String get statusPending => 'Pendiente';

  @override
  String get categoryVorstandssitzung => 'Reunión de junta';

  @override
  String get categoryMitgliederversammlung => 'Asamblea general';

  @override
  String get categorySchulung => 'Formación';

  @override
  String get categorySonstiges => 'Otros';

  @override
  String openCount(int count) {
    return '$count abiertos';
  }

  @override
  String get refresh => 'Actualizar';

  @override
  String get filterUpcoming => 'Próximos';

  @override
  String get filterPast => 'Pasados';

  @override
  String get filterAll => 'Todos';

  @override
  String get noUpcomingAppointments => 'No hay citas próximas';

  @override
  String get noPastAppointments => 'No hay citas pasadas';

  @override
  String get noAppointmentsAvailable => 'No hay citas disponibles';

  @override
  String get appointmentsShownHere => 'Sus citas se mostrarán aquí';

  @override
  String get dateLabel => 'Fecha';

  @override
  String get timeLabel => 'Hora';

  @override
  String get locationLabel => 'Lugar';

  @override
  String get createdByLabel => 'Creado por';

  @override
  String get descriptionLabel => 'Descripción';

  @override
  String get ticketLabel => 'Ticket';

  @override
  String get yourStatus => 'Su estado: ';

  @override
  String reasonLabel(String reason) {
    return 'Razón: $reason';
  }

  @override
  String durationMinutes(int minutes) {
    return '$minutes min';
  }

  @override
  String get confirm => 'Confirmar';

  @override
  String get decline => 'Rechazar';

  @override
  String get reschedule => 'Reprogramar';

  @override
  String get requestReschedule => 'Solicitar reprogramación';

  @override
  String appointmentLabel(String title) {
    return 'Cita: $title';
  }

  @override
  String get rescheduleReason => 'Razón de reprogramación *';

  @override
  String get rescheduleReasonHint => 'Indique una razón...';

  @override
  String get pleaseProvideReason => 'Indique una razón';

  @override
  String get request => 'Solicitar';

  @override
  String get ticketStatusOpen => 'Abierto';

  @override
  String get ticketStatusInProgress => 'En progreso';

  @override
  String get ticketStatusWaitingMember => 'Esperando miembro';

  @override
  String get ticketStatusWaitingStaff => 'Esperando personal';

  @override
  String get ticketStatusWaitingAuthority => 'Esperando autoridad';

  @override
  String get ticketStatusDone => 'Resuelto';

  @override
  String get ticketPriorityHigh => 'Alta';

  @override
  String get ticketPriorityMedium => 'Media';

  @override
  String get ticketPriorityLow => 'Baja';

  @override
  String get comments => 'Comentarios';

  @override
  String get documents => 'Documentos';

  @override
  String get details => 'Detalles';

  @override
  String get replySent => 'Respuesta enviada';

  @override
  String get sendError => 'Error al enviar';

  @override
  String get uploading => 'Subiendo...';

  @override
  String fileUploaded(String filename) {
    return '$filename subido';
  }

  @override
  String get uploadFailed => 'Subida fallida';

  @override
  String get openError => 'Error al abrir';

  @override
  String get noRepliesYet => 'Aún no hay respuestas';

  @override
  String get waitingForSupport => 'Esperando respuesta del soporte';

  @override
  String get writeReply => 'Escribir respuesta...';

  @override
  String get attachFile => 'Adjuntar archivo';

  @override
  String documentsCount(int count) {
    return 'Documentos ($count)';
  }

  @override
  String get upload => 'Subir';

  @override
  String get noDocuments => 'No hay documentos';

  @override
  String get allowedFormats => 'Formatos permitidos: PDF, JPEG, JPG, TXT, ZIP';

  @override
  String get yourMessage => 'Su mensaje:';

  @override
  String get translation => 'Traducción';

  @override
  String get original => 'Original';

  @override
  String get originalText => 'Texto original';

  @override
  String get autoTranslated => 'Traducido automáticamente';

  @override
  String get originalTapTranslation => 'Texto original · Toque para traducción';

  @override
  String get translatedTapOriginal => 'Traducido · Toque para original';

  @override
  String get justNow => 'Ahora mismo';

  @override
  String minutesAgo(int minutes) {
    return 'hace $minutes min';
  }

  @override
  String hoursAgo(int hours) {
    return 'hace $hours h';
  }

  @override
  String daysAgo(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'días',
      one: 'día',
    );
    return 'hace $days $_temp0';
  }

  @override
  String get createdLabel => 'Creado';

  @override
  String get updatedLabel => 'Actualizado';

  @override
  String get handlerLabel => 'Responsable';

  @override
  String get doneLabel => 'Resuelto';

  @override
  String get newTicketTitle => 'Nuevo ticket';

  @override
  String get categoryOptional => 'Categoría (opcional)';

  @override
  String get selectCategory => 'Seleccionar';

  @override
  String get subjectLabel => 'Asunto';

  @override
  String get fillAllFields => 'Por favor complete todos los campos';

  @override
  String ticketCreatedId(int id) {
    return 'Ticket #$id creado';
  }

  @override
  String get priorityLabel => 'Prioridad: ';

  @override
  String get supportOffline => 'Soporte desconectado';

  @override
  String get lastSeenSeconds => 'Activo hace unos segundos';

  @override
  String lastSeenMinutes(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: 'minutos',
      one: 'minuto',
    );
    return 'Activo hace $minutes $_temp0';
  }

  @override
  String lastSeenHours(int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: 'horas',
      one: 'hora',
    );
    return 'Activo hace $hours $_temp0';
  }

  @override
  String lastSeenDays(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'días',
      one: 'día',
    );
    return 'Activo hace $days $_temp0';
  }

  @override
  String get online => 'En línea';

  @override
  String get callSupport => 'Llamar';

  @override
  String get typeMessage => 'Escribir mensaje...';

  @override
  String get callBusy => 'Soporte está ocupado';

  @override
  String get callRejected => 'Llamada rechazada';

  @override
  String get callFailed => 'No se pudo conectar';

  @override
  String get callEnded => 'Llamada finalizada';

  @override
  String get callSupportBusy => 'Soporte ya está en otra llamada';

  @override
  String get errorStartingChat => 'Error al iniciar chat';

  @override
  String get errorStartingCall => 'Error al iniciar llamada';

  @override
  String get errorConnecting => 'Error de conexión';

  @override
  String get errorDownloading => 'Error de descarga';

  @override
  String get errorUploading => 'Error de carga';

  @override
  String get errorSending => 'Error de envío';

  @override
  String get errorPickingPhotos => 'Error al seleccionar fotos';

  @override
  String get errorPickingFiles => 'Error al seleccionar archivos';

  @override
  String get errorTakingPhoto => 'Error al tomar foto';

  @override
  String get fileNotLoaded => 'No se pudo cargar el archivo';

  @override
  String get attachmentIdMissing => 'Falta ID del adjunto';

  @override
  String get camera => 'Cámara';

  @override
  String get gallery => 'Galería';

  @override
  String get file => 'Archivo';

  @override
  String get notifNewMessageFrom => 'Nuevo mensaje de';

  @override
  String get notifUrgentPrefix => 'URGENTE';

  @override
  String get notifUrgentMessage => 'MENSAJE URGENTE';

  @override
  String get notifIncomingCall => 'Llamada entrante';

  @override
  String get notifCallingYou => 'está llamando...';

  @override
  String get notifUpdateAvailable => 'Actualización disponible';

  @override
  String get notifVersionAvailable => 'ya está disponible';

  @override
  String get notifConnected => 'Conectado';

  @override
  String get notifDisconnected => 'Desconectado';

  @override
  String get notifConnectedBody => 'Ahora está conectado al servidor.';

  @override
  String get notifDisconnectedBody => 'Se perdió la conexión con el servidor.';

  @override
  String get notifError => 'Error';

  @override
  String get retry => 'Reintentar';

  @override
  String get save => 'Guardar';

  @override
  String get accept => 'Aceptar';

  @override
  String get selectFile => 'Seleccionar archivo';

  @override
  String get dataLoadingText => 'Cargando datos...';

  @override
  String get dataSavedSuccess => 'Datos guardados correctamente';

  @override
  String get errorSaving => 'Error al guardar';

  @override
  String get errorLoading => 'Error al cargar';

  @override
  String savedFilename(String filename) {
    return 'Guardado: $filename';
  }

  @override
  String get logsCopied => 'Registros copiados!';

  @override
  String get passwordMinEightChars =>
      'La contraseña debe tener al menos 8 caracteres';

  @override
  String get passwordChangeSuccess => 'Contraseña cambiada con éxito';

  @override
  String get emailChangeError => 'Error al cambiar el correo';

  @override
  String get acceptDocumentCheckbox => 'He leído y acepto el documento.';

  @override
  String loadingErrorGeneric(String details) {
    return 'Error de carga: $details';
  }

  @override
  String get incomingCallTitle => 'Llamada entrante';

  @override
  String ringingFor(int seconds) {
    return 'Sonando ${seconds}s';
  }

  @override
  String get rejectCall => 'Rechazar';

  @override
  String get acceptCall => 'Aceptar';

  @override
  String get unmute => 'Activar sonido';

  @override
  String get mute => 'Silenciar';

  @override
  String get hangUp => 'Colgar';

  @override
  String get calling => 'Llamando...';

  @override
  String autoRejectIn(int seconds) {
    return 'Rechazo en $seconds segundos';
  }

  @override
  String get speakerOn => 'Altavoz';

  @override
  String get speakerOff => 'Auricular';

  @override
  String get micMuted => 'Silenciado';

  @override
  String get micOn => 'Micrófono';

  @override
  String get connectionExcellent => 'Excelente';

  @override
  String get connectionGood => 'Buena';

  @override
  String get connectionWeak => 'Baja';

  @override
  String get connectionLost => 'Desconectado';

  @override
  String get personalData => 'Datos personales';

  @override
  String get personalDataSubtitle => 'Nombre, apellido, dirección';

  @override
  String get membershipFee => 'Cuota';

  @override
  String annualFeeYear(String year) {
    return 'Cuota anual $year';
  }

  @override
  String get amount => 'Importe:';

  @override
  String get dueBy => 'Vence:';

  @override
  String get paid => 'Pagado';

  @override
  String get versionHistory => 'Historial de versiones';

  @override
  String lastUpdated(String date) {
    return 'Actualizado: $date';
  }

  @override
  String get noVersionHistory => 'Sin historial';

  @override
  String get failedLoadChangelog => 'Error al cargar';

  @override
  String get callMember => 'Llamar miembro';

  @override
  String get closeConversation => 'Cerrar chat';

  @override
  String get chatOffline => 'Desconectado';

  @override
  String get attachFiles => 'Adjuntar (máx. 10, 50MB)';

  @override
  String get conversationClosed => 'Conversación cerrada';

  @override
  String get noMessages => 'Sin mensajes';

  @override
  String get goBack => 'Atrás';

  @override
  String get goForward => 'Adelante';

  @override
  String get homePage => 'Inicio';

  @override
  String get firstNameLabel => 'Nombre';

  @override
  String get lastNameLabel => 'Apellido';

  @override
  String get streetLabel => 'Calle';

  @override
  String get houseNumberLabel => 'Nº';

  @override
  String get postalCodeLabel => 'C.P.';

  @override
  String get cityLabel => 'Ciudad';

  @override
  String get phoneMobileLabel => 'Móvil';

  @override
  String get phoneLandlineLabel => 'Fijo';

  @override
  String get newEmailLabel => 'Nuevo email';

  @override
  String get currentPasswordLabel => 'Contraseña actual';

  @override
  String get newPasswordLabel => 'Nueva contraseña';

  @override
  String get confirmPasswordLabel => 'Confirmar contraseña';

  @override
  String get emailChangedSuccess => 'Email cambiado';

  @override
  String get reasonLabel2 => 'Motivo';

  @override
  String get downloadFailed2 => 'Descarga fallida';

  @override
  String get downloadTooltip => 'Descargar';

  @override
  String get copyLogs => 'Copiar logs';

  @override
  String get deleteLogs => 'Borrar logs';

  @override
  String get autoScrollOn => 'Auto-scroll ON';

  @override
  String get autoScrollOff => 'Auto-scroll OFF';

  @override
  String get unknownValue => 'Desconocido';

  @override
  String get payment => 'Pago';

  @override
  String get warningType_ermahnung => 'Amonestación';

  @override
  String get warningType_abmahnung => 'Advertencia';

  @override
  String get warningType_letzte => 'Advertencia final';

  @override
  String warningsTotal(int count) {
    return 'Total: $count';
  }

  @override
  String warningsErmahnung(int count) {
    return 'Amonestaciones: $count';
  }

  @override
  String warningsAbmahnung(int count) {
    return 'Advertencias: $count';
  }

  @override
  String warningsLetzte(int count) {
    return 'Finales: $count';
  }

  @override
  String get noWarnings => 'Sin amonestaciones';

  @override
  String get noWarningsDescription => 'No tiene amonestaciones.';

  @override
  String createdBy(String name) {
    return 'Creado por: $name';
  }

  @override
  String get monthJan => 'Ene';

  @override
  String get monthFeb => 'Feb';

  @override
  String get monthMar => 'Mar';

  @override
  String get monthApr => 'Abr';

  @override
  String get monthMay => 'May';

  @override
  String get monthJun => 'Jun';

  @override
  String get monthJul => 'Jul';

  @override
  String get monthAug => 'Ago';

  @override
  String get monthSep => 'Sep';

  @override
  String get monthOct => 'Oct';

  @override
  String get monthNov => 'Nov';

  @override
  String get monthDec => 'Dic';

  @override
  String get stufe1_name => 'Datos personales';

  @override
  String get stufe2_name => 'Tipo de socio';

  @override
  String get stufe3_name => 'Situación financiera';

  @override
  String get stufe4_name => 'Método de pago';

  @override
  String get stufe5_name => 'Inicio de membresía';

  @override
  String get stufe6_name => 'Estatutos';

  @override
  String get stufe7_name => 'Política de privacidad';

  @override
  String get stufe8_name => 'Derecho de desistimiento';

  @override
  String get memberType_ordentlich => 'Socio ordinario';

  @override
  String get memberType_foerder => 'Socio colaborador';

  @override
  String get memberType_ehren => 'Socio honorario';

  @override
  String get memberDesc_ordentlich =>
      'Miembro activo con derecho a voto. Participa en los servicios de la asociación.';

  @override
  String get memberDesc_foerder =>
      'Apoya la asociación con cuotas. Puede asistir a la asamblea con voto consultivo.';

  @override
  String get memberDesc_ehren =>
      'Tiene derechos de socio ordinario sin obligación de pagar cuotas.';

  @override
  String get payMethod_ueberweisung => 'Transferencia';

  @override
  String get payMethod_dauerauftrag => 'Domiciliación';

  @override
  String get verifyStatus_geprueft => 'Verificado';

  @override
  String get verifyStatus_ausgefuellt => 'Completado';

  @override
  String get verifyStatus_abgelehnt => 'Rechazado';

  @override
  String get verifyStatus_offen => 'Abierto';

  @override
  String get fillRequiredFields => 'Complete todos los campos.';

  @override
  String get personalDataSaved => 'Datos guardados';

  @override
  String get selectMemberType => 'Seleccione tipo de socio.';

  @override
  String get memberTypeSaved => 'Tipo guardado';

  @override
  String get selectOption => 'Seleccione una opción.';

  @override
  String get financialSaved => 'Situación guardada';

  @override
  String get selectPaymentMethod => 'Seleccione método de pago.';

  @override
  String get paymentDataSaved => 'Datos de pago guardados';

  @override
  String get selectDate => 'Seleccione fecha.';

  @override
  String get membershipStartSaved => 'Inicio guardado';

  @override
  String get fileTooLarge => 'Archivo muy grande (máx. 10 MB).';

  @override
  String get leistungsbescheidUploaded => 'Certificado subido';

  @override
  String get verificationProgress => 'Progreso de verificación';

  @override
  String get notApplicable => 'No aplica';

  @override
  String get socialBenefitsExempt =>
      'No se requiere pago para beneficiarios sociales.';

  @override
  String get locked => 'Bloqueado';

  @override
  String completePreviousStep(int step) {
    return 'Complete primero el paso $step.';
  }

  @override
  String rejectedNote(String note) {
    return 'Rechazado: $note';
  }

  @override
  String get waitingForReview => 'Esperando revisión.';

  @override
  String get stepApproved => 'Paso verificado y aprobado.';

  @override
  String get changesViaChat => 'Cambios solo por chat.';

  @override
  String get firstNameRequired => 'Nombre *';

  @override
  String get lastNameRequired => 'Apellido *';

  @override
  String get birthDateLabel => 'Fecha nacimiento *';

  @override
  String get streetRequired => 'Calle *';

  @override
  String get houseNumberRequired => 'Nº *';

  @override
  String get cityRequired => 'Ciudad *';

  @override
  String get phoneRequired => 'Teléfono *';

  @override
  String get phonePurpose => 'Contacto cuando no localizable por la app';

  @override
  String get selectMemberTypePrompt => 'Seleccione tipo de membresía:';

  @override
  String get financialExplanation =>
      'Para verificar reducción de cuota, necesitamos esta información.';

  @override
  String get socialBenefitsQuestion => '¿Recibe prestaciones sociales?';

  @override
  String get optionBuergergeld => 'Sí, subsidio ciudadano';

  @override
  String get optionSozialamt => 'Sí, ayuda social';

  @override
  String get optionNoBenefits => 'No recibo prestaciones';

  @override
  String get feeExempt => 'Cuota: 0,00 €/mes';

  @override
  String get uploadLeistungsbescheid => 'Subir certificado';

  @override
  String get uploadLeistungsbescheidHint =>
      'Suba certificado en 14 días para confirmar exención.';

  @override
  String get allowedFormatsUpload => 'Formatos: PDF, JPG, PNG (máx. 10 MB)';

  @override
  String get feeRegular => 'Cuota: 25,00 €/mes';

  @override
  String paymentDayReminder(int day) {
    return 'Recordatorio el día $day de cada mes.';
  }

  @override
  String get membershipStartPrompt => 'Elija inicio de membresía.';

  @override
  String get optionAfterVerification => 'Tras verificación';

  @override
  String get optionAfterVerificationDesc => 'Desde confirmación de la junta.';

  @override
  String get optionRetroFoundation => 'Retroactivo a fundación (01.08.2025)';

  @override
  String get optionRetroFoundationDesc => 'Socio retroactivo desde fundación.';

  @override
  String get optionRetroCustom => 'Retroactivo a otra fecha';

  @override
  String get optionRetroCustomDesc => 'Fecha entre 01.08.2025 y hoy.';

  @override
  String get selectDateLabel => 'Seleccionar fecha';

  @override
  String get selectDateHint => 'Seleccionar...';

  @override
  String get dateNotBefore => 'No antes del 01.08.2025';

  @override
  String get feeExemptRetro =>
      'Exento: 0,00 € retroactivo.\nSolo la fecha se establece retroactivamente.';

  @override
  String get retroactiveFees => 'Cuotas retroactivas';

  @override
  String retroFeeCalculation(
      String from, String to, String months, String total) {
    return 'Período: $from – $to\nMeses: $months\nCuota: $months × 25,00 € = $total €';
  }

  @override
  String get pleaseReadSatzung => 'Lea los estatutos.';

  @override
  String get pleaseReadDatenschutz => 'Lea la política de privacidad.';

  @override
  String get pleaseReadWiderruf => 'Lea el derecho de desistimiento.';

  @override
  String get acceptedAtRegistration => 'Aceptado al registrarse';

  @override
  String get confirmedByBoard => 'Se confirmará tras revisión.';

  @override
  String get docSatzung => 'Estatutos';

  @override
  String get docDatenschutz => 'Política de privacidad';

  @override
  String get docWiderruf => 'Derecho de desistimiento';

  @override
  String acceptedAtRegCount(int count) {
    return 'Aceptado al registrarse ($count/3)';
  }

  @override
  String acceptedOn(String date) {
    return 'Aceptado el $date';
  }

  @override
  String get notAccepted => 'No aceptado';

  @override
  String get statusAccepted => 'Aceptado';

  @override
  String get nameTooLong => 'Nombre demasiado largo (máx. 100 caracteres)';

  @override
  String get emailTooLong => 'Correo demasiado largo (máx. 255 caracteres)';

  @override
  String get legalAcknowledgePrefix => 'He leído la ';

  @override
  String get legalAcknowledgeSuffix => '.';

  @override
  String get legalStatutesSuffix =>
      ' de ICD360S e.V. y los reconozco como vinculantes.';

  @override
  String get legalPleaseReadFirst => '(por favor lea primero)';

  @override
  String get statusActive => 'Activo';

  @override
  String get statusSuspended => 'Suspendido';

  @override
  String get statusNew => 'Nuevo';

  @override
  String get statusCancelled => 'Cancelado';

  @override
  String get statusDeleted => 'Eliminado';

  @override
  String get roleMitglied => 'Miembro';

  @override
  String get roleVorsitzer => 'Presidente';

  @override
  String get roleStellvertreter => 'Vicepresidente';

  @override
  String get roleSchatzmeister => 'Tesorero';

  @override
  String get roleSchriftfuehrer => 'Secretario';

  @override
  String get roleBeisitzer => 'Asesor';

  @override
  String get roleKassierer => 'Cajero';

  @override
  String get roleKassenpruefer => 'Auditor';

  @override
  String get roleEhrenamtlich => 'Voluntario';

  @override
  String get roleMitgliedergruender => 'Miembro Fundador';

  @override
  String get roleEhrenmitglied => 'Miembro Honorario';

  @override
  String get roleFoerdermitglied => 'Miembro de Apoyo';

  @override
  String get memberTypeNotSet => 'Aún no definido';

  @override
  String get payMethodSepa => 'Domiciliación SEPA';

  @override
  String get labelStatus => 'Estado';

  @override
  String get labelMemberNumber => 'Número de miembro';

  @override
  String get labelRole => 'Rol';

  @override
  String get labelMemberType => 'Tipo de miembro';

  @override
  String get labelPaymentMethod => 'Método de pago';

  @override
  String get labelRegisteredOn => 'Registrado el';

  @override
  String get labelLastLogin => 'Último acceso';

  @override
  String get labelMemberSince => 'Miembro desde';

  @override
  String get neverLoggedIn => 'Nunca';

  @override
  String get notActivatedYet => 'Aún no activado';

  @override
  String get tabVerification => 'Verificación';

  @override
  String get tabWarnings => 'Advertencias';

  @override
  String get tabDocuments => 'Documentos';

  @override
  String get tabMembership => 'Membresía';

  @override
  String get pleaseEnterFirstName => 'Ingrese el nombre';

  @override
  String get pleaseEnterLastName => 'Ingrese el apellido';

  @override
  String get noFileDataReceived => 'No se recibieron datos';

  @override
  String get openFile => 'Abrir';

  @override
  String get noMicrophoneError =>
      'No se encontró micrófono. Conecte un micrófono e intente de nuevo.';

  @override
  String get startConversation => '¡Inicie una conversación!';

  @override
  String get staffWillReply => 'Un empleado le responderá pronto.';

  @override
  String get inCall => 'En llamada...';

  @override
  String get registration => 'Registro';

  @override
  String get deactivation => 'Desactivación';

  @override
  String get deactivatedOn => 'Desactivado el';

  @override
  String get accountAutoSuspend =>
      'Las cuentas no verificadas en 30 días serán suspendidas automáticamente.';

  @override
  String get documentsProvidedByBoard =>
      'Los documentos son proporcionados por la junta directiva.';

  @override
  String get noDocumentsAvailable => 'No hay documentos';

  @override
  String get noDocumentsDescription =>
      'Aún no se han proporcionado documentos para usted.';

  @override
  String uploadedBy(String name) {
    return 'Subido por: $name';
  }

  @override
  String stepsCompleted(int completed, int total) {
    return '$completed/$total pasos completados';
  }

  @override
  String dayOfMonth(int day) {
    return '$day del mes';
  }

  @override
  String changeField(String field) {
    return 'Cambiar $field';
  }

  @override
  String openDocument(String name) {
    return 'Abrir $name';
  }

  @override
  String logEntries(int count) {
    return '$count entradas';
  }

  @override
  String get noLogs => 'Sin registros';

  @override
  String get newLoginDetected => 'Nuevo inicio de sesión detectado';

  @override
  String get errorNoInternet =>
      'Sin conexión a Internet. Por favor, compruebe su red.';

  @override
  String get errorTimeout =>
      'El servidor no responde. Por favor, inténtelo más tarde.';

  @override
  String get errorServer =>
      'Error del servidor. Por favor, inténtelo más tarde.';

  @override
  String get errorConnection =>
      'Error de conexión. Por favor, inténtelo más tarde.';

  @override
  String get errorUnexpected =>
      'Se ha producido un error inesperado. Por favor, inténtelo más tarde.';

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
  String get claudiuWelcomeMorning => 'Buenos días';

  @override
  String get claudiuWelcomeDay => 'Hola';

  @override
  String get claudiuWelcomeEvening => 'Buenas tardes';

  @override
  String get claudiuWelcomeNight => 'Buenas tardes';

  @override
  String get claudiuWelcomeVisitor => 'querido visitante';

  @override
  String get claudiuWelcomeAsk => '¿Cómo puedo ayudarte?';

  @override
  String get claudiuWelcomeBecomeMember => 'Quiero hacerme miembro';

  @override
  String get claudiuWelcomeLogin => 'Ya soy miembro y quiero iniciar sesión';

  @override
  String get claudiuWelcomeProblem => 'Tengo un problema con la app';

  @override
  String get claudiuWelcomeEmergency => 'Emergencia — llámanos';

  @override
  String get claudiuWelcomeMascotName => 'Claudiu';

  @override
  String get claudiuWelcomeEmergencyIntro =>
      'Antes de llamar — nuestro horario:';

  @override
  String get claudiuWelcomeScheduleOffice => 'En la oficina';

  @override
  String get claudiuWelcomeScheduleField => 'En el terreno con clientes';

  @override
  String get claudiuWelcomeOutsideHoursNote =>
      'Fuera de este horario solo atendemos urgencias. También puedes enviarnos un SMS al mismo número — te contactaremos.';

  @override
  String get claudiuWelcomeCallNow => 'Llamar ahora';

  @override
  String get claudiuWelcomeSendSms => 'Enviar SMS';

  @override
  String get claudiuWelcomeSmsBody =>
      'Emergencia ICD360S e.V. — por favor, contáctenme lo antes posible.';

  @override
  String get claudiuWelcomeCloseButton => 'Cerrar';

  @override
  String get claudiuLoginWelcome => '¡Bienvenido de nuevo, querido miembro!';

  @override
  String get claudiuLoginAsk => 'Dime tu número de socio, por favor.';

  @override
  String get claudiuLoginProgress => 'Casi… sigue escribiendo.';

  @override
  String get claudiuLoginReady => '¡Perfecto! Pulsa el botón de abajo.';

  @override
  String get claudiuLoginLoading => 'Verificando identidad… 🔍';

  @override
  String get claudiuLoginFoundPlain => '¡Te encontré! Iniciando sesión…';

  @override
  String claudiuLoginFoundNamed(String name) {
    return '¡Te encontré, $name! Iniciando sesión…';
  }

  @override
  String get claudiuLoginError =>
      'Hm, no encuentro ese número. ¿Lo escribiste bien?';

  @override
  String get claudiuLoginForgotHeader => '¿Olvidaste tu número de socio?';

  @override
  String get claudiuLoginNoSms => 'No enviamos el número por email ni SMS.';

  @override
  String get claudiuLoginOnlyWay =>
      'La única vía: vernos en persona en la oficina de la asociación, tras verificar la identificación.';

  @override
  String get claudiuLoginContactUs => 'Llámanos para una cita:';

  @override
  String get claudiuDiagnosticGreeting =>
      'Antes de entrar, una pregunta rápida';

  @override
  String get claudiuDiagnosticAsk =>
      '¿Puedo enviar informes anónimos para que los desarrolladores mejoren la app?';

  @override
  String get claudiuDiagnosticYes => 'Sí, quiero ayudar';

  @override
  String get claudiuDiagnosticNo => 'No, solo estoy mirando';

  @override
  String get claudiuDiagnosticTellMore => 'Cuéntame más';

  @override
  String get claudiuDiagnosticSendsHeader => '📤 Lo que ENVIAMOS (anónimo):';

  @override
  String get claudiuDiagnosticSends1 =>
      'Un código anónimo del dispositivo (NO tu número de socio)';

  @override
  String get claudiuDiagnosticSends2 => 'Tu rol (miembro / junta)';

  @override
  String get claudiuDiagnosticSends3 =>
      'Sistema operativo (Linux / Android / iOS / Windows)';

  @override
  String get claudiuDiagnosticSends4 => 'Idioma elegido';

  @override
  String get claudiuDiagnosticSends5 => 'Nivel y estado de batería';

  @override
  String get claudiuDiagnosticSends6 => 'Pantalla actual';

  @override
  String get claudiuDiagnosticSends7 => 'Duración de sesión (segundos)';

  @override
  String get claudiuDiagnosticSends8 => 'Errores si los hay (últimos 10)';

  @override
  String get claudiuDiagnosticSends9 => 'Navegación (últimas 20 pantallas)';

  @override
  String get claudiuDiagnosticSends10 =>
      'Cuántas veces la aplicación envió datos (solo el número, sin contenido)';

  @override
  String get claudiuDiagnosticSends11 =>
      'Cómo clasifica el sistema la aplicación y con qué rapidez se descarga la batería';

  @override
  String get claudiuDiagnosticNeverHeader => '🛡️ Lo que NUNCA enviamos:';

  @override
  String get claudiuDiagnosticNever1 => 'Tu nombre real';

  @override
  String get claudiuDiagnosticNever2 => 'Dirección de email';

  @override
  String get claudiuDiagnosticNever3 => 'Número de teléfono';

  @override
  String get claudiuDiagnosticNever4 => 'Contraseña';

  @override
  String get claudiuDiagnosticNever5 => 'Contenido de los mensajes de chat';

  @override
  String get claudiuDiagnosticNever6 => 'Contenido de tickets';

  @override
  String get claudiuDiagnosticNever7 => 'Documentos o adjuntos';

  @override
  String get claudiuDiagnosticTechHeader => '📡 Detalles técnicos:';

  @override
  String get claudiuDiagnosticTech1 => 'Se envía cada 15 minutos';

  @override
  String get claudiuDiagnosticTech2 =>
      'Conexión cifrada TLS con certificado fijado';

  @override
  String get claudiuDiagnosticTech3 =>
      'Puedes desactivarlo en cualquier momento desde Ajustes';

  @override
  String get claudiuProblemHelpTitle => '¿Cómo puedo ayudar?';

  @override
  String get claudiuProblemHelpGreeting => '¿Qué pasó?';

  @override
  String get claudiuProblemHelpAsk => '¿Cómo prefieres contármelo?';

  @override
  String get claudiuProblemHelpWriteTitle => 'Escribir un informe';

  @override
  String get claudiuProblemHelpWriteBody =>
      'Con detalles paso a paso. El equipo recibe el texto y lo resuelve después.';

  @override
  String get claudiuProblemHelpChatTitle => 'Hablemos ahora';

  @override
  String get claudiuProblemHelpChatBody =>
      'Chat anónimo con un operador. Respuesta en tiempo real si alguien está conectado.';

  @override
  String get claudiuProblemHelpAltCallHeader => 'O, si es urgente:';

  @override
  String get claudiuProblemHelpAltCallLabel => 'Llamar';

  @override
  String get claudiuAnonymousChatTitle => 'Chat anónimo';

  @override
  String get claudiuAnonymousChatGreeting => '¡Hola!';

  @override
  String get claudiuAnonymousChatWelcome =>
      'Te escucho. Escribe lo que quieras — no necesito nombre. Responderé en cuanto esté aquí.';

  @override
  String get claudiuAnonymousChatHint => 'Escribe un mensaje…';

  @override
  String get claudiuAnonymousChatWaitingOperator =>
      'Esperando que un operador responda…';

  @override
  String get claudiuVorsitzerConnectedTitle => '¡Hola!';

  @override
  String get claudiuVorsitzerConnectedBody =>
      'Gracias por escribir — ya estás en contacto con un Vorsitzer. Cuéntanos cómo podemos ayudarte con tu solicitud de membresía.';

  @override
  String get claudiuVorsitzerConnectedSender => 'Vorsitzer';

  @override
  String get claudiuQuickReplyValidationTime => '¿Cuánto tarda la validación?';

  @override
  String get claudiuQuickReplyDocuments => '¿Qué documentos necesito?';

  @override
  String get claudiuQuickReplyStepProblem => 'Me he atascado en un paso';

  @override
  String get claudiuQuickReplyHuman => '¿Puedo hablar con alguien ahora?';

  @override
  String get claudiuAnonymousChatConnecting => 'Conectando…';

  @override
  String get claudiuAnonymousChatConnectionFailed =>
      'No se pudo abrir el chat. Intenta de nuevo o llámanos.';

  @override
  String get claudiuAnonymousChatRetry => 'Reintentar';

  @override
  String get claudiuAnonymousChatOnline => 'Conectado';

  @override
  String get claudiuAnonymousChatOffline => 'Reconectando…';

  @override
  String get claudiuAnonymousChatAdminTyping => 'El operador está escribiendo…';

  @override
  String get claudiuProblemReportTitle => 'Reportar un problema';

  @override
  String get claudiuProblemReportGreeting => '¿Qué pasó?';

  @override
  String get claudiuProblemReportAsk =>
      'Cuéntame con detalle y reenviaré el informe al equipo.';

  @override
  String get claudiuProblemReportIncludeHeader => 'Por favor incluye:';

  @override
  String get claudiuProblemReportIncludeBullets1 =>
      'Qué hacías cuando apareció el problema';

  @override
  String get claudiuProblemReportIncludeBullets2 =>
      'Cualquier mensaje de error que viste';

  @override
  String get claudiuProblemReportIncludeBullets3 => 'En qué pantalla estabas';

  @override
  String get claudiuProblemReportIncludeBullets4 =>
      '¿La app se cierra, falla o muestra una pantalla en blanco?';

  @override
  String get claudiuProblemReportIncludeBullets5 =>
      '¿Sucede cada vez o solo una vez?';

  @override
  String get claudiuProblemReportDescriptionLabel => 'Tu descripción';

  @override
  String get claudiuProblemReportDescriptionHint =>
      'Ej: Al abrir el chat sale \"Connection error\" y la app deja de responder…';

  @override
  String claudiuProblemReportTooShort(int count) {
    return 'Un poco más de detalle, por favor (mínimo $count caracteres)';
  }

  @override
  String get claudiuProblemReportSubmit => 'Enviar informe';

  @override
  String get claudiuProblemReportSubmitting => 'Enviando…';

  @override
  String get claudiuProblemReportSentTitle => '¡Gracias!';

  @override
  String get claudiuProblemReportSentBody =>
      'El informe ha sido enviado. Nuestro equipo lo revisará lo antes posible.';

  @override
  String get claudiuProblemReportSentClose => 'Entendido';

  @override
  String get claudiuProblemReportSendFailed =>
      'No se pudo enviar el informe. Llámanos para ayuda urgente.';

  @override
  String get claudiuProblemReportAlt => 'O, si es urgente:';

  @override
  String get claudiuProblemReportCallLabel => 'Llamar';

  @override
  String claudiuApprovalGreeting(String name) {
    return '¡Hola, $name! 👋';
  }

  @override
  String get claudiuApprovalGreetingNoName => '¡Hola! 👋';

  @override
  String get claudiuApprovalGladToSeeYou => '¡Me alegra que estés aquí!';

  @override
  String get claudiuApprovalCheckingForSafety =>
      'Por tu seguridad, un Vorsitzer está revisando tu solicitud de inicio de sesión. 🛡️';

  @override
  String get claudiuApprovalMonthlyExplain =>
      '💡 Hacemos esto cada 30 días para asegurarnos de que eres tú. Es como un chequeo de seguridad — dura máximo 5 minutos.';

  @override
  String get claudiuApprovalSuccess =>
      '¡Listo! 🎉 El Vorsitzer te reconoció. Iniciando sesión…';

  @override
  String get claudiuApprovalDenied =>
      'Hm, el Vorsitzer rechazó tu solicitud. 😔';

  @override
  String get claudiuApprovalDeniedHelp =>
      'Si crees que es un error, por favor llámanos para aclararlo.';

  @override
  String get claudiuApprovalExpired =>
      'Pasaron los 5 minutos y no recibimos respuesta del Vorsitzer.';

  @override
  String get claudiuApprovalExpiredHelp =>
      'Llámanos y podemos aprobar tu solicitud directamente. 📞';

  @override
  String get claudiuApprovalCallUs => 'Llamar';

  @override
  String get claudiuApprovalTryAgain => 'Reintentar';

  @override
  String get claudiuApprovalCancel => 'Cancelar';

  @override
  String get claudiuApprovalClose => 'Cerrar';

  @override
  String get wizardIntroBubble1 =>
      '¡Hola, visitante! 👋 Gracias por querer formar parte de nuestra familia.';

  @override
  String get wizardIntroBubble2 =>
      'Me llamo Claudiu. En la primavera de 2025 tuve una visión clara: crear una asociación que ayude a personas necesitadas — voluntariamente, con el corazón, sin burocracia inútil. ❤️';

  @override
  String get wizardIntroBubble3 =>
      'Empecé a hablar con los clientes que visitaba. Les conté mi sueño. Y cada uno dijo: «¡Sí, vamos!». En julio de 2025 nos reunimos — 6 personas decididas. Decidimos fundar **ICD360S e.V.** en Neu-Ulm. 📍';

  @override
  String get wizardIntroBubble4 =>
      'El **1 de agosto de 2025**, la asociación cobró vida oficialmente — en el Registro de Asociaciones. El regalo más hermoso para mí. 🎂';

  @override
  String get wizardIntroBubble5 =>
      '¿Qué hacemos? Ayudamos a refugiados, personas con discapacidad, personas en desventaja económica, **niños y jóvenes** — con trámites, alemán, vivienda, compras, prestaciones sociales. Nuestro Vorstand está formado mayoritariamente por personas con discapacidad — así las decisiones surgen de la experiencia vivida. 🤝';

  @override
  String get wizardIntroBubble6 =>
      'Ahora es tu turno. Vamos a inscribirte — tarda unos 5 minutos. Iremos paso a paso, no te dejo solo. ✨';

  @override
  String get wizardIntroStart => 'Empecemos';

  @override
  String get wizardBack => 'Atrás';

  @override
  String get wizardNext => 'Siguiente';

  @override
  String wizardStepLabel(int step, int total, String title) {
    return 'Paso $step de $total · $title';
  }

  @override
  String get wizardErrRequired => 'Este campo es obligatorio';

  @override
  String wizardErrTooShort(int count) {
    return 'Demasiado corto (mínimo $count caracteres)';
  }

  @override
  String get wizardErrOnlyLetters =>
      'Solo letras, espacios, guiones y apóstrofos';

  @override
  String get wizardErrSaveFailed =>
      'No se pudo guardar. Comprueba la conexión y vuelve a intentarlo.';

  @override
  String get wizardStufe1aTitle => 'Identidad';

  @override
  String get wizardStufe1aPrompt =>
      'Vamos a conocerte oficialmente. Por favor escribe tu nombre exactamente como aparece en Personalausweis, Reisepass o Aufenthaltstitel — para que coincida con tus documentos.';

  @override
  String get wizardStufe1aVornameLabel => 'Vornamen (nombres)';

  @override
  String get wizardStufe1aVornameHelper =>
      'Todos tus nombres, exactamente como en el documento. Con espacio o guion (p. ej. Hans-Peter, Maria Anna).';

  @override
  String get wizardStufe1aNachnameLabel => 'Familienname (apellido)';

  @override
  String get wizardStufe1aNachnameHelper => 'Tu apellido actual.';

  @override
  String get wizardStufe1aGeburtsnameLabel =>
      'Geburtsname (nombre de nacimiento) — opcional';

  @override
  String get wizardStufe1aGeburtsnameHelper =>
      'Solo si difiere del Familienname — p. ej. antes del matrimonio.';

  @override
  String get wizardStufe1bTitle => 'Cumpleaños';

  @override
  String get wizardStufe1bPrompt =>
      '¡Nos encantaría celebrar tu cumpleaños contigo! 🎂 Y nos ayuda a confirmar que tienes al menos 16 años — así lo dice nuestro Satzung.';

  @override
  String get wizardStufe1bGeburtsdatumLabel => 'Fecha de nacimiento';

  @override
  String get wizardStufe1bGeburtsdatumHelper => 'Toca para elegir una fecha';

  @override
  String get wizardStufe1bGeburtsortLabel => 'Lugar de nacimiento';

  @override
  String get wizardStufe1bGeburtsortHelper =>
      'Ciudad / localidad donde naciste.';

  @override
  String get wizardAgeGatePrompt => 'Lo siento… 😔';

  @override
  String wizardAgeGateBody1(int age, int years) {
    return 'Nuestro Satzung dice que debes tener al menos 16 años para ser miembro. Tienes $age — ¡espero verte en $years años! 🌱';
  }

  @override
  String get wizardAgeGateBody2 =>
      'Si quieres ayudar puntualmente como voluntario (cualquier edad, con consentimiento de los padres), llámanos — nos encanta apoyar a jóvenes que quieren cambiar el mundo.';

  @override
  String get wizardAgeGateBackHome => 'Volver al inicio';

  @override
  String get wizardErrInvalidPhone => 'Número de teléfono no válido';

  @override
  String get wizardStufe1b1Title => 'Consentimiento parental';

  @override
  String get wizardStufe1b1Prompt =>
      'Eres menor (16-17) — según §106 BGB necesitamos el consentimiento de un padre o tutor legal. Dime su nombre y número de teléfono. Un Vorsitzer le llamará y concertará una reunión (presencial o videollamada). Sin email — queremos estar seguros de hablar con la persona real.';

  @override
  String get wizardStufe1b1VornameLabel => 'Nombre del padre/madre';

  @override
  String get wizardStufe1b1VornameHelper =>
      'Como aparece en el Personalausweis del padre/madre.';

  @override
  String get wizardStufe1b1NachnameLabel => 'Apellido del padre/madre';

  @override
  String get wizardStufe1b1NachnameHelper =>
      'Como aparece en el Personalausweis del padre/madre.';

  @override
  String get wizardStufe1b1TelefonLabel => 'Móvil del padre/madre';

  @override
  String get wizardStufe1b1TelefonHelper =>
      'Un Vorsitzer llamará a este número.';

  @override
  String get wizardStufe1b1RelationLabel => 'Relación con el niño/a:';

  @override
  String get wizardStufe1b1RelationMutter => 'Madre';

  @override
  String get wizardStufe1b1RelationVater => 'Padre';

  @override
  String get wizardStufe1b1RelationSorgeberechtigter => 'Tutor legal';

  @override
  String get wizardStufe1b1RelationAndere => 'Otro tutor';

  @override
  String get wizardStufe1cTitle => 'Datos personales';

  @override
  String get wizardStufe1cPrompt =>
      'Solo para conocerte un poco mejor. Esto queda entre nosotros y no se muestra públicamente en ningún lado.';

  @override
  String get wizardStufe1cGeschlechtLabel => 'Género';

  @override
  String get wizardStufe1cGeschlechtMaennlich => 'Hombre';

  @override
  String get wizardStufe1cGeschlechtWeiblich => 'Mujer';

  @override
  String get wizardStufe1cGeschlechtDivers => 'Diverso';

  @override
  String get wizardStufe1cGeschlechtKeineAngabe => 'Prefiero no decirlo';

  @override
  String get wizardStufe1cFamilienstandLabel => 'Estado civil';

  @override
  String get wizardStufe1cFamilienstandLedig => 'Soltero/a';

  @override
  String get wizardStufe1cFamilienstandVerheiratet => 'Casado/a';

  @override
  String get wizardStufe1cFamilienstandGeschieden => 'Divorciado/a';

  @override
  String get wizardStufe1cFamilienstandVerwitwet => 'Viudo/a';

  @override
  String get wizardStufe1dTitle => 'Tu origen';

  @override
  String get wizardStufe1dPrompt =>
      'Esto nos ayuda a ofrecerte el apoyo adecuado — por ejemplo asesoramiento sobre Aufenthalt o encontrar tu comunidad lingüística.';

  @override
  String get wizardStufe1dStaatLabel => 'Nacionalidad';

  @override
  String get wizardStufe1dStaatHelper =>
      'P. ej. deutsch, rumänisch, ukrainisch. Varias separadas por coma.';

  @override
  String get wizardStufe1dAufenthaltLabel =>
      'Estatus de residencia (Aufenthaltsstatus) — opcional';

  @override
  String get wizardStufe1dAufenthaltHelper =>
      'Elige el título de tu Aufenthaltskarte / resolución. El Vorstand lo coteja con tus documentos.';

  @override
  String get wizardStufe1dAufenthaltAwaitingCitizenship =>
      'Rellena primero la nacionalidad arriba — mostraremos solo las opciones que apliquen.';

  @override
  String get wizardStufe1dAufenthaltGerman =>
      'No se necesita Aufenthaltstitel — ciudadano alemán.';

  @override
  String get wizardStufe1dAufenthaltEuEea =>
      'Ciudadano UE/EEE/CH — libre circulación (Freizügigkeit).';

  @override
  String get wizardStufe1dAufenthaltTempHint => 'temporal';

  @override
  String get wizardStufe1dAufenthaltPermHint => 'residencia permanente';

  @override
  String get wizardStufe1dAufenthaltAsylumProcessHint =>
      'procedimiento de asilo';

  @override
  String get wizardStufe1dAufenthaltOther =>
      'Otro (especifica en el chat por favor)';

  @override
  String get wizardStufe1dAufenthaltRequired =>
      'Elige un Aufenthaltstitel por favor.';

  @override
  String get wizardStufe1dMutterspracheLabel => 'Lengua materna';

  @override
  String get wizardStufe1dMutterspracheHelper =>
      'Rellenado con el idioma de la app — cámbialo si es diferente.';

  @override
  String get wizardStufe1eTitle => 'Dirección';

  @override
  String get wizardStufe1ePrompt =>
      'Tu dirección postal — la usamos para documentos oficiales (Satzung, contratos de socio, notificaciones).';

  @override
  String get wizardStufe1eStrasseLabel => 'Calle';

  @override
  String get wizardStufe1eStrasseHelper =>
      'Solo el nombre de la calle — el número va al lado.';

  @override
  String get wizardStufe1eHausnummerLabel => 'Nº';

  @override
  String get wizardStufe1ePlzLabel => 'PLZ (C.P.)';

  @override
  String get wizardStufe1eOrtLabel => 'Ciudad';

  @override
  String get wizardStufe1eLandLabel => 'País';

  @override
  String get wizardStufe1eLandHelper => 'Rellenado: Deutschland.';

  @override
  String get wizardErrInvalidStreet => 'Nombre de calle no válido';

  @override
  String get wizardErrInvalidHausnummer =>
      'Número no válido (p. ej. 12, 12a, 12/3)';

  @override
  String get wizardErrInvalidPlz => 'Código postal no válido (solo dígitos)';

  @override
  String get wizardStufe1fTitle => 'Contacto';

  @override
  String get wizardStufe1fPrompt =>
      '¿Cómo te contactamos? El teléfono solo para emergencias — todo lo demás pasa por nuestro canal cifrado de extremo a extremo dentro de la app. Tu email de socio se asigna automáticamente y lo ves abajo.';

  @override
  String get wizardStufe1fTelefonLabel => 'Móvil';

  @override
  String get wizardStufe1fTelefonHelper =>
      'Prometo, solo te llamo si es importante. 📱';

  @override
  String get wizardStufe2Title => 'Tipo de membresía';

  @override
  String get wizardStufe2Prompt =>
      '¿Qué tipo de miembro quieres ser? Déjame explicarte cada opción.';

  @override
  String get wizardStufe2OrdentlichTitle => 'Miembro ordinario (ordentlich)';

  @override
  String get wizardStufe2OrdentlichBody =>
      'Derechos completos. Pagas la cuota mensual, votas en la Mitgliederversammlung, puedes ser elegido para el Vorstand. La opción estándar.';

  @override
  String get wizardStufe2FoerderTitle => 'Miembro de apoyo (Fördermitglied)';

  @override
  String get wizardStufe2FoerderBody =>
      'Apoyas la asociación económicamente pero no participas activamente en las decisiones. Sin derecho a voto. Bueno si quieres ayudar a distancia.';

  @override
  String get wizardStufe2EhrenTitle => 'Miembro honorario (Ehrenmitglied)';

  @override
  String get wizardStufe2EhrenBody =>
      'Otorgado por el Vorstand por méritos especiales. No lo eliges tú — se concede como reconocimiento. Selecciona solo si ya has sido honrado.';

  @override
  String get wizardStufe3Title => 'Situación financiera';

  @override
  String get wizardStufe3Prompt =>
      'Ahora sobre tu situación financiera. No para juzgarte — solo para eximirte de la cuota si recibes prestaciones sociales.';

  @override
  String get wizardStufe3OptionBuergergeld => 'Recibo Bürgergeld';

  @override
  String get wizardStufe3OptionSozialamt => 'Recibo ayudas del Sozialamt';

  @override
  String get wizardStufe3OptionNein => 'No recibo ninguna';

  @override
  String get wizardStufe3FeeExemptTitle => 'Cuota: 0 € / mes 🎉';

  @override
  String get wizardStufe3FeeExemptBody =>
      'Con Bürgergeld, Sozialamt, ALG I o Krankengeld estás totalmente exento de la cuota según Satzung §6. Solo necesitamos un comprobante (Leistungsbescheid o certificado de la autoridad / seguro de salud).';

  @override
  String get wizardStufe3UploadTitle => 'Subir Leistungsbescheid';

  @override
  String get wizardStufe3UploadHint => 'PDF / JPG / PNG, máximo 10 MB.';

  @override
  String get wizardStufe3UploadRequired =>
      'Por favor sube el Leistungsbescheid antes de continuar.';

  @override
  String get wizardStufe3FileTooLarge =>
      'Archivo demasiado grande. Máximo 10 MB.';

  @override
  String get wizardStufe3UploadFailed =>
      'No se pudo subir el archivo. Inténtalo de nuevo.';

  @override
  String get wizardStufe3RegularFeeTitle => 'Cuota: 25 € / mes';

  @override
  String get wizardStufe3RegularFeeBody =>
      'Cuota estándar para miembros ordinarios según el Satzung.';

  @override
  String get wizardStufe4Title => 'Pago';

  @override
  String get wizardStufe4Prompt =>
      '¿Cómo quieres pagar la cuota? ¿Y qué día del mes prefieres que se cobre?';

  @override
  String get wizardStufe4MethodUeberweisungTitle =>
      'Transferencia (Überweisung)';

  @override
  String get wizardStufe4MethodUeberweisungBody =>
      'Tú inicias el pago cada mes desde tu cuenta.';

  @override
  String get wizardStufe4MethodSepaTitle => 'SEPA-Lastschrift (domiciliación)';

  @override
  String get wizardStufe4MethodSepaBody =>
      'Cargamos el importe automáticamente desde tu cuenta. Lo más cómodo, pero necesitamos IBAN y un mandato firmado.';

  @override
  String get wizardStufe4MethodDauerauftragTitle =>
      'Dauerauftrag (orden permanente)';

  @override
  String get wizardStufe4MethodDauerauftragBody =>
      'Configuras una orden permanente en tu banco. Tu banco transfiere el importe automáticamente cada mes.';

  @override
  String get wizardStufe4DayLabel => 'Día de pago';

  @override
  String get wizardStufe4DayHint => 'Elige un día entre 1 y 31';

  @override
  String wizardStufe4DayItem(int day) {
    return 'Día $day';
  }

  @override
  String wizardStufe4DayReminder(int day) {
    return 'La cuota se cobrará el día $day de cada mes.';
  }

  @override
  String get wizardStufe5Title => 'Inicio';

  @override
  String get wizardStufe5Prompt =>
      '¿Cuándo quieres ser oficialmente miembro de ICD360S? Desde la aprobación o retroactivamente.';

  @override
  String get wizardStufe5OptionAbVerifizierungTitle =>
      'Desde la aprobación del Vorstand';

  @override
  String get wizardStufe5OptionAbVerifizierungBody =>
      'La opción más sencilla. Sin cuota retroactiva.';

  @override
  String get wizardStufe5OptionGruendungsdatumTitle =>
      'Retroactivamente desde 01.08.2025 (fundación)';

  @override
  String get wizardStufe5OptionGruendungsdatumBody =>
      'Contarás como miembro desde el primer día de la asociación.';

  @override
  String get wizardStufe5OptionAnderesDatumTitle => 'Otra fecha';

  @override
  String get wizardStufe5OptionAnderesDatumBody =>
      'Tú eliges una fecha entre 01.08.2025 y hoy.';

  @override
  String get wizardStufe5PickDate => 'Toca para elegir fecha';

  @override
  String get wizardStufe5PickDateFirst => 'Por favor elige una fecha primero.';

  @override
  String get wizardStufe5DatePickerHelp => 'Inicio de la membresía';

  @override
  String wizardStufe5DateRange(String start) {
    return 'Entre $start y hoy';
  }

  @override
  String get wizardStufe5RetroactiveTitle => 'Cuota retroactiva';

  @override
  String wizardStufe5RetroactiveBody(
      String start, String end, int months, String amount) {
    return 'Desde $start hasta $end son $months meses. A 25 €/mes son $amount € a pagar retroactivamente, además de la cuota mensual actual.';
  }

  @override
  String get wizardStufe5FeeExemptTitle => 'Cuota retroactiva: 0 € 🎉';

  @override
  String get wizardStufe5FeeExemptBody =>
      'Con Bürgergeld o Sozialamt estás totalmente exento — incluso retroactivamente no debes nada.';

  @override
  String wizardDocumentPrompt(String doc) {
    return 'Antes de cerrar, por favor lee con atención el $doc. Es importante saber qué firmas.';
  }

  @override
  String get wizardDocumentScrollHint =>
      'Desplázate hasta el final para continuar.';

  @override
  String get wizardDocumentScrolledOk => 'Has leído hasta el final ✓';

  @override
  String wizardDocumentOpenButton(String doc) {
    return 'Abrir $doc en el navegador';
  }

  @override
  String get wizardDocumentExternalHint =>
      'En esta plataforma abrimos el documento en tu navegador predeterminado.';

  @override
  String get wizardDocumentOpenedOk =>
      'El documento se ha abierto. Por favor léelo con atención.';

  @override
  String wizardDocumentConfirm(String doc) {
    return 'Confirmo que he leído y acepto el $doc.';
  }

  @override
  String get wizardFinalAdultTitle => '¡Listo! Estás inscrito 🎉';

  @override
  String get wizardFinalMinorTitle => 'Tu solicitud ha sido enviada 📨';

  @override
  String get wizardFinalMinorBody =>
      'Contactaremos a tu padre/madre y concertaremos una reunión (en persona o videollamada). Por favor ten paciencia — el proceso puede tardar hasta 7 días. Recibirás una notificación en la app en cuanto tu padre/madre apruebe.';

  @override
  String get wizardFinalMitgliedernummerLabel => 'Tu número de socio';

  @override
  String get wizardStufe4MethodComingSoon => 'Próximamente';

  @override
  String get wizardStufe4StreichungWarning =>
      'Si te retrasas más de 6 meses con la cuota, te eliminaremos automáticamente (Satzung §6 Abs. 3).';

  @override
  String get wizardStufe5KuendigungInfo =>
      'Para darte de baja: envíanos la cancelación por escrito 3 meses antes del 31 de diciembre (hasta el 30 de septiembre para que sea efectiva a fin de año). No hay duración mínima (Satzung §6 Abs. 3).';

  @override
  String get wizardStufe1fEmailLabel => 'Tu email de socio';

  @override
  String get wizardStufe1fEmailHelper =>
      'Se asigna automáticamente a partir de tu número de socio. Se activa en cuanto la junta directiva (Vorstand) valida tu solicitud. Tenemos nuestra propia app de correo — envía y recibe emails cifrados, sencillo y gratis.';

  @override
  String get wizardErrInvalidEmail => 'Dirección de email no válida';

  @override
  String get wizardStufe3OptionAlg1 =>
      'Recibo Arbeitslosengeld I (ALG I, prestación por desempleo)';

  @override
  String get wizardStufe3OptionKrankengeld =>
      'Recibo Krankengeld (prestación por enfermedad de larga duración)';

  @override
  String get wizardStufe3UploadAddMore => 'Añadir otro documento';

  @override
  String get wizardStufe3UploadLimitCount =>
      'Has alcanzado el límite: máximo 20 documentos.';

  @override
  String get wizardStufe3UploadLimitTotal =>
      'Has alcanzado el límite total de 100 MB. Elimina un archivo existente.';

  @override
  String get wizardStufe3UploadDeleteTooltip => 'Eliminar';

  @override
  String wizardStufe3UploadCounter(int count, int max) {
    return '$count / $max documentos';
  }

  @override
  String get wizardDocumentExternalOpenFailed =>
      'No se pudo abrir el navegador. El enlace está en el portapapeles — pégalo en un navegador para continuar.';

  @override
  String get wizardFinalTimelineProcessing =>
      'Vorstand revisando · normalmente 1 día laborable, hasta 7';

  @override
  String get wizardFinalTimelineActivated => 'Cuenta activada';

  @override
  String get wizardFinalAdultThank =>
      '¡Gracias por completar el formulario de registro! 🎉';

  @override
  String get wizardFinalAdultUsual =>
      'Tu solicitud ya está con nosotros. Normalmente la validamos en un día laborable.';

  @override
  String get wizardFinalAdultExceptional =>
      'A veces puede tardar hasta 7 días laborables. Y si algo no cuadra, te enviamos de vuelta al formulario para que lo corrijas 🙂';

  @override
  String get wizardFinalStatusTitle => 'ESTADO DE LA SOLICITUD';

  @override
  String wizardFinalStatusStepsValidated(int reviewed, int total) {
    return '$reviewed/$total pasos validados por el Vorstand';
  }

  @override
  String get wizardFinalStufeSheetTitle => 'Detalles de la solicitud';

  @override
  String get wizardFinalStufeSheetHint =>
      'Las 8 etapas que has completado. El Vorstand las revisa una a una — ves en tiempo real qué se ha validado.';

  @override
  String get wizardFinalStufeStatusPending => 'En espera de revisión';

  @override
  String get wizardFinalStufeStatusApproved => 'Aprobado';

  @override
  String get wizardFinalStufeStatusRejected => 'Rechazado';

  @override
  String wizardFinalStatusRejectionCount(int count) {
    return '$count paso necesita corrección';
  }

  @override
  String get wizardFinalStufeRejectionReason => 'Motivo del Vorstand:';

  @override
  String get wizardFinalStufeCorrectNow => 'Corregir ahora';

  @override
  String wizardFinalApprovalsHeader(int current, int total) {
    return 'Aprobaciones del Vorstand ($current/$total)';
  }

  @override
  String get wizardFinalApprovalAwaiting => 'Esperando al 2.º Vorstand';

  @override
  String get wizardFinalApprovalRejected => 'RECHAZADO';

  @override
  String get wizardFinalStufeNoDataYet => 'Datos aún no disponibles.';

  @override
  String get wizardFinalStufeReadAt => 'Leído el:';

  @override
  String get wizardFinalStufeBeitragsfrei => 'Exento de cuota (sin pago)';

  @override
  String get wizardFinalStufeNotExempt => 'Sin ayudas sociales';

  @override
  String get wizardFinalStufeBeginAtVerification =>
      'Inicia con la verificación';

  @override
  String get wizardFinalStufeBeginAtFoundation =>
      'Fecha de fundación (retroactivo)';

  @override
  String get wizardFinalStufeBeginAtCustom => 'Otra fecha';

  @override
  String get wizardFinalStufeStatusSkipped => 'Omitido';

  @override
  String get wizardFinalStufeFilledAt => 'Rellenado:';

  @override
  String get wizardFinalStufeReviewedAt => 'Revisado:';

  @override
  String get wizardFinalWithdrawLink => 'Retirar solicitud';

  @override
  String get wizardFinalWithdrawDialogTitle => '¿Retirar la solicitud?';

  @override
  String get wizardFinalWithdrawDialogBody =>
      'Tu solicitud quedará marcada como retirada por ti. Los datos siguen en la base para auditoría (GDPR), pero la cuenta no se activará. Puedes reiniciar el registro cuando quieras con un nuevo número de miembro.';

  @override
  String get wizardFinalWithdrawKeep => 'No, voy a esperar';

  @override
  String get wizardFinalWithdrawConfirm => 'Sí, retirar';

  @override
  String get wizardErrTooManyWithdrawals =>
      'Tu solicitud no se puede procesar automáticamente. Llámanos o pásate personalmente por el Vorstand para continuar el registro.';

  @override
  String get wizardDuplicateLoginTitle => 'Parece que ya eres socio';

  @override
  String get wizardDuplicateLoginBody =>
      'Con tu nombre y fecha de nacimiento ya encontramos una cuenta activa. Por favor, usa \"Ya soy socio\" en la pantalla principal para iniciar sesión. Si ya no tienes acceso, llámanos.';

  @override
  String get wizardDuplicatePendingTitle => 'Tu solicitud ya está con nosotros';

  @override
  String get wizardDuplicatePendingBody =>
      'Con tu nombre y fecha de nacimiento ya tenemos una solicitud en revisión. El Vorstand está trabajando en ella — te avisaremos en la app en cuanto tu cuenta esté activa. Llámanos si quieres comentar.';

  @override
  String get wizardDuplicateRecentlyWithdrawnTitle =>
      'Ahora no podemos procesar esta solicitud';

  @override
  String get wizardDuplicateRecentlyWithdrawnBody =>
      'Tu nombre y fecha de nacimiento coinciden con una solicitud retirada recientemente. Por favor, llámanos para hablar con el Vorstand antes de seguir.';

  @override
  String get wizardDuplicatePreviouslyWithdrawnTitle =>
      'Ya has solicitado antes';

  @override
  String get wizardDuplicatePreviouslyWithdrawnBody =>
      'Tu nombre y fecha de nacimiento coinciden con una solicitud anterior que retiraste. Bienvenido de nuevo — por favor llámanos antes de continuar para que el Vorstand decida cómo procedemos.';

  @override
  String get wizardDuplicateCallUsTitle => 'Por favor, llámanos';

  @override
  String get wizardDuplicateCallUsBody =>
      'Tu nombre y fecha de nacimiento ya constan en nuestros registros, pero no podemos compartir los detalles por la app. Llámanos — el Vorstand te explicará directamente la situación.';

  @override
  String get wizardChatHelp => 'Hablemos';

  @override
  String get wizardChatHelpSubtitle =>
      'Chat en vivo con el Vorstand · respuesta rápida';

  @override
  String get benachrichtigungTitel => 'Recordatorios por SMS';

  @override
  String get benachrichtigungIntro =>
      'Para que no pierda ninguna cita, la asociación puede enviarle un SMS. Usted decide si lo desea y para qué — y puede cambiarlo en cualquier momento.';

  @override
  String get benachrichtigungTermineFrage =>
      '¿Desea recibir recordatorios de sus citas por SMS?';

  @override
  String get benachrichtigungTermineDetail =>
      'El mensaje contiene la fecha, la hora, el lugar y el asunto de la cita.';

  @override
  String get benachrichtigungMedikamenteFrage =>
      '¿Desea que también le recordemos sus medicamentos?';

  @override
  String get benachrichtigungMedikamenteDetail =>
      'En ese caso, el nombre del medicamento aparece en el mensaje. Es un dato de salud, por eso lo preguntamos por separado.';

  @override
  String get benachrichtigungHinweis =>
      'El recordatorio es una ayuda y no una garantía: por favor, no confíe únicamente en él. Puede cambiarlo en cualquier momento en su perfil.';

  @override
  String get benachrichtigungJa => 'Sí';

  @override
  String get benachrichtigungNein => 'No';

  @override
  String get benachrichtigungSpaeter => 'Decidir más tarde';

  @override
  String get benachrichtigungSpeichern => 'Guardar';

  @override
  String get benachrichtigungGespeichert => 'Gracias, guardado.';

  @override
  String get benachrichtigungenLeer => 'Sin notificaciones';

  @override
  String get benachrichtigungenAlleGelesen => 'Marcar todo como leído';

  @override
  String get benachrichtigungWetterFrage =>
      '¿Desea recibir avisos de temporal en su lugar de residencia?';

  @override
  String get benachrichtigungWetterDetail =>
      'Solo avisos oficiales del Servicio Meteorológico Alemán a partir del nivel «grave» — no con cada lluvia.';

  @override
  String get signaturTitel => 'Firmas';

  @override
  String get signaturNichtsOffen =>
      'Por el momento no hay nada pendiente de firma.';

  @override
  String get signaturStatusOffen => 'Pendiente de su firma';

  @override
  String get signaturStatusSigniert => 'Firmado por usted';

  @override
  String get signaturStatusAbgelehnt => 'Rechazado por usted';

  @override
  String get signaturStatusWiderrufen => 'Retirado por la asociación';

  @override
  String get signaturStatusAbgelaufen => 'Plazo vencido';

  @override
  String signaturBitteGanzLesen(int gelesen, int gesamt) {
    return 'Por favor, lea el documento hasta el final (página $gelesen de $gesamt).';
  }

  @override
  String get signaturWeiterZurUnterschrift => 'Ir a la firma';

  @override
  String get signaturAblehnen => 'Rechazar';

  @override
  String get signaturAblehnenHinweis =>
      'Se informará a la asociación. Puede indicar sus motivos.';

  @override
  String get signaturAblehnenGrund => 'Motivo (opcional)';

  @override
  String get signaturMitFingerHinweis =>
      'Firme con el dedo en el recuadro blanco.';

  @override
  String get signaturNochmal => 'Repetir';

  @override
  String get signaturZurueckZumDokument => 'Volver al documento';

  @override
  String get signaturCodeAnfordern => 'Solicitar código por SMS';

  @override
  String get signaturCodeUnterwegs => 'El código está en camino.';

  @override
  String signaturCodeGesendetAn(String nummer) {
    return 'Le hemos enviado un código al $nummer.';
  }

  @override
  String get signaturCodeErneutSenden => 'Reenviar código';

  @override
  String get signaturJetztUnterschreiben => 'Firmar ahora';

  @override
  String get signaturCodeFalsch => 'El código no es correcto.';

  @override
  String get signaturCodeAbgelaufen =>
      'El código ha caducado. Por favor, solicite uno nuevo.';

  @override
  String get signaturZuVieleVersuche =>
      'Demasiados intentos fallidos. Por favor, solicite un código nuevo.';

  @override
  String get signaturKeineRufnummer =>
      'En su cuenta no hay ningún número de móvil registrado. Sin ese número no podemos enviarle el código — por favor, póngase en contacto con el presidente de la asociación.';

  @override
  String get signaturCodeFehlgeschlagen => 'No se ha podido enviar el código.';

  @override
  String get signaturLeer => 'Por favor, firme primero.';

  @override
  String get signaturErfolg => 'Gracias — hemos recibido su firma.';

  @override
  String get signaturFehlgeschlagen =>
      'No ha funcionado. Por favor, inténtelo de nuevo.';

  @override
  String get signaturSiegelInArbeit =>
      'El documento sellado todavía se está preparando. Vuelva a intentarlo dentro de un minuto.';

  @override
  String get signaturWartetZweiteUnterschrift =>
      'Pendiente de la segunda firma';

  @override
  String get signaturWartenHinweis =>
      'Usted ha firmado. El documento se sellará en cuanto también haya firmado la segunda persona.';

  @override
  String get kontaktNochAktuell => '¿Siguen siendo correctos estos datos?';

  @override
  String get kontaktWarumFragen =>
      'Para que no se pierda nada, preguntamos brevemente cada tres meses. Recibirá un código de seis dígitos.';

  @override
  String kontaktBestaetigtAm(Object datum) {
    return 'confirmado el $datum';
  }

  @override
  String get kontaktFestnetzKeinSms =>
      'Este es un número fijo: no llega ningún SMS.';

  @override
  String get kontaktIstAndersGeworden => 'Ha cambiado';

  @override
  String get themeTitle => 'Apariencia';

  @override
  String get themeLight => 'Claro';

  @override
  String get themeDark => 'Oscuro';

  @override
  String get themeSystem => 'Seguir el dispositivo';

  @override
  String get themeSchedule => 'Automático (20:00–06:00)';

  @override
  String get themeScheduleHint =>
      'Oscuro de 20:00 a 6:00, claro el resto del día.';

  @override
  String get fernwartungTitel => 'Fernwartung';

  @override
  String get fernwartungSteuerungTitel => 'Steuerung erlauben';

  @override
  String get fernwartungSteuerungHinweis =>
      'Der Vorstand darf Ihr Gerät während einer Fernwartung bedienen. Sie stimmen jeder Sitzung einzeln zu; ohne Sitzung geschieht nichts. Der Dienst kann Ihren Bildschirm nicht lesen.';

  @override
  String get fernwartungSteuerungAktiv => 'Steuerung ist eingeschaltet';
}
