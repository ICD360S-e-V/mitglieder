// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'ICD360S e.V - Portal de Miembros';

  @override
  String get memberPortal => 'Portal de Miembros';

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
  String get password => 'Contraseña';

  @override
  String get passwordHint => 'Ingrese la contraseña';

  @override
  String get confirmPassword => 'Confirmar Contraseña';

  @override
  String get confirmPasswordHint => 'Confirme la contraseña';

  @override
  String get newPassword => 'Nueva Contraseña';

  @override
  String get newPasswordHint => 'Ingrese la nueva contraseña';

  @override
  String get saveCredentials => 'Guardar credenciales';

  @override
  String get autoLogin => 'Inicio automático';

  @override
  String get forgotPassword => '¿Olvidó su contraseña?';

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
  String get recoveryCode => 'Código de Recuperación (6 dígitos)';

  @override
  String get recoveryCodeHelper =>
      'Recuerde este código para recuperar su contraseña';

  @override
  String get recoveryCodeHint => 'Ingrese el código de recuperación';

  @override
  String get recoveryCodeInvalid =>
      'El código debe tener exactamente 6 dígitos';

  @override
  String get loginFailed => 'Error de inicio de sesión';

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
  String get tooManyDevices => 'Demasiados dispositivos';

  @override
  String get maxDevicesMessage =>
      'Ya ha iniciado sesión en 3 dispositivos.\nSeleccione un dispositivo para cerrar sesión:';

  @override
  String get unknownDevice => 'Dispositivo desconocido';

  @override
  String get unknown => 'Desconocido';

  @override
  String get logoutError => 'Error al cerrar sesión';

  @override
  String error(String error) {
    return 'Error: $error';
  }

  @override
  String get cancel => 'Cancelar';

  @override
  String get resetPassword => 'Restablecer Contraseña';

  @override
  String get forgotPasswordTitle => 'Contraseña Olvidada';

  @override
  String get forgotPasswordDescription =>
      'Ingrese su número de miembro y el código de recuperación creado durante el registro.';

  @override
  String get passwordResetSuccess =>
      '¡Contraseña restablecida con éxito!\n\nAhora puede iniciar sesión con su nueva contraseña.';

  @override
  String get passwordResetFailed => 'Error al restablecer la contraseña';

  @override
  String get needHelp => '¿Necesita ayuda?';

  @override
  String get helpQuestion => '¿Problemas con el inicio de sesión o registro?';

  @override
  String get helpDescription =>
      'Contáctenos por WhatsApp y describa exactamente qué no funciona. ¡Responderemos lo antes posible!';

  @override
  String get whatsapp => 'WhatsApp';

  @override
  String get emailSubject => 'Consulta a través de la aplicación ICD360S';

  @override
  String get whatsappMessage =>
      'Hola, tengo un problema con la aplicación ICD360S. ';

  @override
  String get imprint => 'Aviso Legal';

  @override
  String get privacy => 'Política de Privacidad';

  @override
  String get statutes => 'Estatutos';

  @override
  String get revocation => 'Derecho de Desistimiento';

  @override
  String get cancellation => 'Cancelación';

  @override
  String get allRightsReserved => 'Todos los derechos reservados.';

  @override
  String get enterCredentials => 'Ingrese número de miembro y contraseña';

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
  String get membership => 'Membresía';

  @override
  String get myAppointments => 'Mis citas';

  @override
  String get appointmentsLoadingReady => 'Cargando citas - ¡API listo!';

  @override
  String get priority => 'Prioridad';

  @override
  String get messageLabel => 'Mensaje';

  @override
  String get createdOn => 'Creado';

  @override
  String get handler => 'Gestor';

  @override
  String get reportProblems => 'Reportar problemas';

  @override
  String get reportProblem => 'Reportar problema';

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
  String get newTicket => 'Nuevo ticket';

  @override
  String get noOpenTickets => 'No hay tickets abiertos';

  @override
  String get haveQuestionCreateTicket =>
      '¿Tiene una pregunta o problema?\nCree un nuevo ticket.';

  @override
  String get whatIsTheProblem => '¿Cuál es el problema?';

  @override
  String get describeTheProblem => 'Describa el problema';

  @override
  String get howUrgentIsIt => '¿Qué tan urgente es?';

  @override
  String get low => 'Bajo';

  @override
  String get medium => 'Medio';

  @override
  String get high => 'Alto';

  @override
  String get submit => 'Enviar';

  @override
  String get fillSubjectAndMessage =>
      'Por favor complete el asunto y el mensaje';

  @override
  String get ticketCreated => 'Ticket creado';

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
  String get newEmailAddress => 'Nueva dirección de email';

  @override
  String get currentPassword => 'Contraseña actual';

  @override
  String get saveEmail => 'Guardar email';

  @override
  String get savePassword => 'Guardar contraseña';

  @override
  String get deviceLoggedOut => 'Dispositivo desconectado';

  @override
  String get passwordChangedSuccessfully => 'Contraseña cambiada con éxito';

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
  String get passwordTooShort =>
      'La contraseña debe tener al menos 6 caracteres';

  @override
  String get maxDevicesReached =>
      'Ha iniciado sesión en el máximo de 3 dispositivos.';

  @override
  String loggedInOnDevices(int count) {
    return 'Ha iniciado sesión en $count de 3 dispositivos.';
  }

  @override
  String get noActiveSessions => 'No hay sesiones activas';

  @override
  String get logoutFromDevice => 'Cerrar sesión en este dispositivo';

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
  String get errorAcceptingCall => 'Error al aceptar llamada';

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
  String typingIndicator(String name) {
    return '$name está escribiendo...';
  }

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
  String get diagnosticDataTitle => 'Datos de diagnóstico';

  @override
  String get diagnosticDescription =>
      '¿Desea enviar datos de diagnóstico anónimos para mejorar la aplicación?';

  @override
  String get noThanks => 'No, gracias';

  @override
  String get yesEnable => 'Sí, activar';

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
  String get newPasswordMinChars => 'Nueva contraseña (mín. 6)';

  @override
  String get reasonLabel2 => 'Motivo';

  @override
  String get downloadFailed2 => 'Descarga fallida';

  @override
  String get downloadTooltip => 'Descargar';

  @override
  String get connectionErrorGeneric => 'Error de conexión';

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
  String get bankTransfer => 'Transferencia';

  @override
  String get standingOrder => 'Domiciliación';

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
  String get memberNumberTooLong =>
      'Número de miembro demasiado largo (máx. 20 caracteres)';

  @override
  String get onlyUppercaseAndNumbers =>
      'Solo se permiten letras mayúsculas y números';

  @override
  String get passwordTooLong =>
      'Contraseña demasiado larga (máx. 100 caracteres)';

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
  String get diagnosticErrors => 'Informes de error para mejora';

  @override
  String get diagnosticAnonymousStats => 'Estadísticas de uso anónimas';

  @override
  String get diagnosticPerformance => 'Datos de rendimiento de la app';

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
  String get ipClean => 'IP limpia - no listada';

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
  String get helpImproveApp =>
      '¿Le gustaría ayudarnos a mejorar la aplicación?';

  @override
  String get noPersonalDataCollected =>
      'No se recopilan datos personales. Esta configuración se puede cambiar en cualquier momento.';

  @override
  String logEntries(int count) {
    return '$count entradas';
  }

  @override
  String get noLogs => 'Sin registros';

  @override
  String get newLoginDetected => 'Nuevo inicio de sesión detectado';

  @override
  String get waitingForMember => 'Esperando al miembro';

  @override
  String get waitingForStaff => 'Esperando al personal';

  @override
  String get waitingForAuthority => 'Esperando a la autoridad';
}
