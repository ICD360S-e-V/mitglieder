// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'ICD360S e.V - Portal de Membros';

  @override
  String get memberPortal => 'Portal de Membros';

  @override
  String get welcomeLoading => 'Carregando...';

  @override
  String get welcomeAutoLogin => 'Login automático...';

  @override
  String get login => 'Entrar';

  @override
  String get register => 'Registrar';

  @override
  String get becomeMember => 'Tornar-se Membro';

  @override
  String get memberNumber => 'Número de Membro';

  @override
  String get memberNumberHint => 'Digite o número de membro';

  @override
  String get password => 'Senha';

  @override
  String get passwordHint => 'Digite a senha';

  @override
  String get confirmPassword => 'Confirmar Senha';

  @override
  String get confirmPasswordHint => 'Confirme a senha';

  @override
  String get newPassword => 'Nova Senha';

  @override
  String get newPasswordHint => 'Digite a nova senha';

  @override
  String get saveCredentials => 'Salvar credenciais';

  @override
  String get autoLogin => 'Login automático';

  @override
  String get forgotPassword => 'Esqueceu a senha?';

  @override
  String get firstName => 'Nome e Sobrenome';

  @override
  String get firstNameHint => 'Digite nome e sobrenome';

  @override
  String get nameMinLength => 'O nome deve ter pelo menos 2 caracteres';

  @override
  String get nameOnlyLetters => 'Apenas letras e hífens são permitidos';

  @override
  String get email => 'Endereço de Email';

  @override
  String get emailHint => 'Digite o email';

  @override
  String get emailInvalid => 'Digite um email válido';

  @override
  String get passwordMinLength => 'A senha deve ter pelo menos 6 caracteres';

  @override
  String get passwordsNotMatch => 'As senhas não coincidem';

  @override
  String get recoveryCode => 'Código de Recuperação (6 dígitos)';

  @override
  String get recoveryCodeHelper =>
      'Lembre-se deste código para recuperar a senha';

  @override
  String get recoveryCodeHint => 'Digite o código de recuperação';

  @override
  String get recoveryCodeInvalid => 'O código deve ter exatamente 6 dígitos';

  @override
  String get loginFailed => 'Falha no login';

  @override
  String get registrationFailed => 'Falha no registro';

  @override
  String connectionError(String error) {
    return 'Erro de conexão: $error';
  }

  @override
  String registrationSuccess(String memberNumber) {
    return 'Registro bem-sucedido!\n\nSeu número de membro: $memberNumber\n\nLembre-se deste número para fazer login.';
  }

  @override
  String get tooManyDevices => 'Muitos dispositivos';

  @override
  String get maxDevicesMessage =>
      'Você já está conectado em 3 dispositivos.\nSelecione um dispositivo para desconectar:';

  @override
  String get unknownDevice => 'Dispositivo desconhecido';

  @override
  String get unknown => 'Desconhecido';

  @override
  String get logoutError => 'Erro ao desconectar';

  @override
  String error(String error) {
    return 'Erro: $error';
  }

  @override
  String get cancel => 'Cancelar';

  @override
  String get resetPassword => 'Redefinir Senha';

  @override
  String get forgotPasswordTitle => 'Esqueceu a Senha';

  @override
  String get forgotPasswordDescription =>
      'Digite seu número de membro e o código de recuperação criado durante o registro.';

  @override
  String get passwordResetSuccess =>
      'Senha redefinida com sucesso!\n\nAgora você pode fazer login com sua nova senha.';

  @override
  String get passwordResetFailed => 'Falha ao redefinir a senha';

  @override
  String get needHelp => 'Precisa de ajuda?';

  @override
  String get helpQuestion => 'Problemas com login ou registro?';

  @override
  String get helpDescription =>
      'Entre em contato pelo WhatsApp e descreva exatamente o que não está funcionando. Responderemos o mais rápido possível!';

  @override
  String get whatsapp => 'WhatsApp';

  @override
  String get emailSubject => 'Consulta pelo aplicativo ICD360S';

  @override
  String get whatsappMessage =>
      'Olá, tenho um problema com o aplicativo ICD360S. ';

  @override
  String get imprint => 'Aviso Legal';

  @override
  String get privacy => 'Política de Privacidade';

  @override
  String get statutes => 'Estatutos';

  @override
  String get revocation => 'Direito de Arrependimento';

  @override
  String get cancellation => 'Cancelamento';

  @override
  String get allRightsReserved => 'Todos os direitos reservados.';

  @override
  String get enterCredentials => 'Digite número de membro e senha';

  @override
  String get appointments => 'Compromissos';

  @override
  String get tickets => 'Tickets';

  @override
  String get liveChat => 'Chat ao Vivo';

  @override
  String get notifications => 'Notificações';

  @override
  String get myProfile => 'Meu Perfil';

  @override
  String get logout => 'Sair';

  @override
  String get goodMorning => 'Bom dia';

  @override
  String get goodDay => 'Bom dia';

  @override
  String get goodEvening => 'Boa tarde';

  @override
  String get goodNight => 'Boa noite';

  @override
  String get welcomeToICD => 'Bem-vindo ao ICD360S e.V!';

  @override
  String get accountCreatedSuccessfully => 'Sua conta foi criada com sucesso.';

  @override
  String get today => 'Hoje';

  @override
  String get membershipFeeDue => 'Taxa de membro vencida';

  @override
  String get pleaseTransferAnnualFee => 'Por favor, transfira a taxa anual.';

  @override
  String get newBadge => 'Novo';

  @override
  String get close => 'Fechar';

  @override
  String get membership => 'Adesão';

  @override
  String get myAppointments => 'Meus compromissos';

  @override
  String get appointmentsLoadingReady =>
      'Carregando compromissos - API pronto!';

  @override
  String get priority => 'Prioridade';

  @override
  String get messageLabel => 'Mensagem';

  @override
  String get createdOn => 'Criado';

  @override
  String get handler => 'Gestor';

  @override
  String get reportProblems => 'Relatar problemas';

  @override
  String get reportProblem => 'Relatar problema';

  @override
  String get weRespondIn24Hours => 'Responderemos em no máximo 24 horas!';

  @override
  String get everythingOk => 'Tudo bem!';

  @override
  String get haveProblemWeHelp => 'Tem um problema?\nNós cuidamos disso!';

  @override
  String get myMembership => 'Minha adesão';

  @override
  String get managePersonalDataAndFee => 'Gerencie seus dados pessoais e taxa';

  @override
  String get myAppointmentsTitle => 'Meus compromissos';

  @override
  String get appointmentsDescription =>
      'Aqui você pode ver seus compromissos futuros.\nVocê pode confirmar sua participação ou recusar.';

  @override
  String get loadAppointments => 'Carregar compromissos';

  @override
  String get myTickets => 'Meus tickets';

  @override
  String get newTicket => 'Novo ticket';

  @override
  String get noOpenTickets => 'Nenhum ticket aberto';

  @override
  String get haveQuestionCreateTicket =>
      'Tem uma pergunta ou problema?\nCrie um novo ticket.';

  @override
  String get whatIsTheProblem => 'Qual é o problema?';

  @override
  String get describeTheProblem => 'Descreva o problema';

  @override
  String get howUrgentIsIt => 'Quão urgente é?';

  @override
  String get low => 'Baixo';

  @override
  String get medium => 'Médio';

  @override
  String get high => 'Alto';

  @override
  String get submit => 'Enviar';

  @override
  String get fillSubjectAndMessage =>
      'Por favor, preencha o assunto e a mensagem';

  @override
  String get ticketCreated => 'Ticket criado';

  @override
  String get errorCreatingTicket => 'Erro ao criar ticket';

  @override
  String get verified => 'Verificado';

  @override
  String get account => 'Conta';

  @override
  String get myDevices => 'Meus dispositivos';

  @override
  String get changeEmail => 'Alterar email';

  @override
  String get changePassword => 'Alterar senha';

  @override
  String get newEmailAddress => 'Novo endereço de email';

  @override
  String get currentPassword => 'Senha atual';

  @override
  String get saveEmail => 'Salvar email';

  @override
  String get savePassword => 'Salvar senha';

  @override
  String get deviceLoggedOut => 'Dispositivo desconectado';

  @override
  String get passwordChangedSuccessfully => 'Senha alterada com sucesso';

  @override
  String get emailChangedSuccessfully => 'Email alterado com sucesso';

  @override
  String get errorChangingPassword => 'Erro ao alterar senha';

  @override
  String get errorChangingEmail => 'Erro ao alterar email';

  @override
  String get validEmailRequired =>
      'Por favor, insira um endereço de email válido';

  @override
  String get passwordTooShort => 'A senha deve ter pelo menos 6 caracteres';

  @override
  String get maxDevicesReached =>
      'Você está conectado no máximo de 3 dispositivos.';

  @override
  String loggedInOnDevices(int count) {
    return 'Você está conectado em $count de 3 dispositivos.';
  }

  @override
  String get noActiveSessions => 'Nenhuma sessão ativa';

  @override
  String get logoutFromDevice => 'Desconectar deste dispositivo';

  @override
  String get confirmLogoutDevice => 'Desconectar dispositivo?';

  @override
  String get confirmLogoutMessage =>
      'Deseja desconectar deste dispositivo?\n\nVocê precisará fazer login novamente para usar este dispositivo.';

  @override
  String get ipAddress => 'IP';

  @override
  String get platform => 'Plataforma';

  @override
  String trialWarningUrgentTitle(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'Faltam apenas $days dias',
      one: 'Falta apenas 1 dia',
    );
    return 'Atenção: $_temp0 para a suspensão da conta!';
  }

  @override
  String get trialWarningTitle => 'Sua conta ainda não está verificada';

  @override
  String get trialWarningDescription =>
      'Por favor, complete seus dados em \"Meu Perfil\". Após 30 dias, sua conta será suspensa automaticamente.';

  @override
  String trialDaysRemaining(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days dias',
      one: '1 dia',
    );
    return '$_temp0';
  }

  @override
  String get overview => 'Visão geral';

  @override
  String get member => 'Membro';

  @override
  String get memberManagement => 'Gestão de membros';

  @override
  String get reportProblemTooltip => 'Relatar problema';

  @override
  String get newAppointmentsTitle => 'Novos compromissos';

  @override
  String get youHaveNewAppointment => 'Você tem um novo compromisso.';

  @override
  String youHaveNewAppointments(int count) {
    return 'Você tem $count novos compromissos.';
  }

  @override
  String get appointmentReminderTomorrow => 'Lembrete: Compromisso amanhã';

  @override
  String tomorrowAppointment(String title) {
    return 'Amanhã: $title';
  }

  @override
  String youHaveTomorrowAppointments(int count) {
    return 'Você tem $count compromissos amanhã.';
  }

  @override
  String get appointmentsToday => 'Compromissos hoje';

  @override
  String todayAppointment(String title) {
    return 'Hoje: $title';
  }

  @override
  String youHaveTodayAppointments(int count) {
    return 'Você tem $count compromissos hoje.';
  }

  @override
  String get paymentReminder => 'Lembrete de pagamento';

  @override
  String paymentReminderMessage(int day, String method) {
    return 'Hoje é dia $day do mês – por favor complete $method.';
  }

  @override
  String get paymentDayLabel => 'Dia de pagamento (lembrete mensal)';

  @override
  String get updateAvailable => 'Atualização disponível';

  @override
  String newVersionAvailable(String version) {
    return 'Uma nova versão está disponível: $version';
  }

  @override
  String currentVersionLabel(String version) {
    return 'Versão atual: $version';
  }

  @override
  String get changes => 'Alterações:';

  @override
  String downloadProgress(String percent) {
    return 'Download: $percent%';
  }

  @override
  String get installationStarting => 'Iniciando instalação...';

  @override
  String get appWillRestart => 'O aplicativo será reiniciado automaticamente.';

  @override
  String get later => 'Mais tarde';

  @override
  String get updateNow => 'Atualizar agora';

  @override
  String get downloading => 'Baixando...';

  @override
  String get downloadFailed => 'Falha no download. Tente novamente mais tarde.';

  @override
  String get searchingForUpdates => 'Procurando atualizações...';

  @override
  String get appUpToDate => 'O aplicativo está atualizado';

  @override
  String get updateCheckError => 'Erro ao verificar atualizações';

  @override
  String get changelog => 'Registro de alterações';

  @override
  String get terminConfirmed => 'Consulta confirmada';

  @override
  String get terminDeclined => 'Consulta recusada';

  @override
  String get terminRescheduleRequested => 'Reagendamento solicitado';

  @override
  String get statusConfirmed => 'Confirmado';

  @override
  String get statusDeclined => 'Recusado';

  @override
  String get statusRescheduling => 'Reagendamento';

  @override
  String get statusPending => 'Pendente';

  @override
  String get categoryVorstandssitzung => 'Reunião da diretoria';

  @override
  String get categoryMitgliederversammlung => 'Assembleia geral';

  @override
  String get categorySchulung => 'Formação';

  @override
  String get categorySonstiges => 'Outros';

  @override
  String openCount(int count) {
    return '$count abertos';
  }

  @override
  String get refresh => 'Atualizar';

  @override
  String get filterUpcoming => 'Próximos';

  @override
  String get filterPast => 'Passados';

  @override
  String get filterAll => 'Todos';

  @override
  String get noUpcomingAppointments => 'Sem consultas próximas';

  @override
  String get noPastAppointments => 'Sem consultas passadas';

  @override
  String get noAppointmentsAvailable => 'Sem consultas disponíveis';

  @override
  String get appointmentsShownHere => 'As suas consultas serão mostradas aqui';

  @override
  String get dateLabel => 'Data';

  @override
  String get timeLabel => 'Hora';

  @override
  String get locationLabel => 'Local';

  @override
  String get createdByLabel => 'Criado por';

  @override
  String get descriptionLabel => 'Descrição';

  @override
  String get ticketLabel => 'Ticket';

  @override
  String get yourStatus => 'Seu estado: ';

  @override
  String reasonLabel(String reason) {
    return 'Motivo: $reason';
  }

  @override
  String durationMinutes(int minutes) {
    return '$minutes min';
  }

  @override
  String get confirm => 'Confirmar';

  @override
  String get decline => 'Recusar';

  @override
  String get reschedule => 'Reagendar';

  @override
  String get requestReschedule => 'Solicitar reagendamento';

  @override
  String appointmentLabel(String title) {
    return 'Consulta: $title';
  }

  @override
  String get rescheduleReason => 'Motivo do reagendamento *';

  @override
  String get rescheduleReasonHint => 'Indique um motivo...';

  @override
  String get pleaseProvideReason => 'Indique um motivo';

  @override
  String get request => 'Solicitar';

  @override
  String get ticketStatusOpen => 'Aberto';

  @override
  String get ticketStatusInProgress => 'Em andamento';

  @override
  String get ticketStatusWaitingMember => 'Aguardando membro';

  @override
  String get ticketStatusWaitingStaff => 'Aguardando equipe';

  @override
  String get ticketStatusWaitingAuthority => 'Aguardando autoridade';

  @override
  String get ticketStatusDone => 'Concluído';

  @override
  String get ticketPriorityHigh => 'Alta';

  @override
  String get ticketPriorityMedium => 'Média';

  @override
  String get ticketPriorityLow => 'Baixa';

  @override
  String get comments => 'Comentários';

  @override
  String get documents => 'Documentos';

  @override
  String get details => 'Detalhes';

  @override
  String get replySent => 'Resposta enviada';

  @override
  String get sendError => 'Erro ao enviar';

  @override
  String get uploading => 'Enviando...';

  @override
  String fileUploaded(String filename) {
    return '$filename enviado';
  }

  @override
  String get uploadFailed => 'Falha no envio';

  @override
  String get openError => 'Erro ao abrir';

  @override
  String get noRepliesYet => 'Ainda sem respostas';

  @override
  String get waitingForSupport => 'Aguardando resposta do suporte';

  @override
  String get writeReply => 'Escrever resposta...';

  @override
  String get attachFile => 'Anexar arquivo';

  @override
  String documentsCount(int count) {
    return 'Documentos ($count)';
  }

  @override
  String get upload => 'Enviar';

  @override
  String get noDocuments => 'Nenhum documento disponível';

  @override
  String get allowedFormats => 'Formatos permitidos: PDF, JPEG, JPG, TXT, ZIP';

  @override
  String get yourMessage => 'Sua mensagem:';

  @override
  String get translation => 'Tradução';

  @override
  String get original => 'Original';

  @override
  String get originalText => 'Texto original';

  @override
  String get autoTranslated => 'Traduzido automaticamente';

  @override
  String get originalTapTranslation => 'Original · Toque para tradução';

  @override
  String get translatedTapOriginal => 'Traduzido · Toque para original';

  @override
  String get justNow => 'Agora mesmo';

  @override
  String minutesAgo(int minutes) {
    return 'há $minutes min';
  }

  @override
  String hoursAgo(int hours) {
    return 'há $hours h';
  }

  @override
  String daysAgo(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'dias',
      one: 'dia',
    );
    return 'há $days $_temp0';
  }

  @override
  String get createdLabel => 'Criado';

  @override
  String get updatedLabel => 'Atualizado';

  @override
  String get handlerLabel => 'Responsável';

  @override
  String get doneLabel => 'Concluído';

  @override
  String get newTicketTitle => 'Novo ticket';

  @override
  String get categoryOptional => 'Categoria (opcional)';

  @override
  String get selectCategory => 'Selecionar';

  @override
  String get subjectLabel => 'Assunto';

  @override
  String get fillAllFields => 'Preencha todos os campos';

  @override
  String ticketCreatedId(int id) {
    return 'Ticket #$id criado';
  }

  @override
  String get priorityLabel => 'Prioridade: ';

  @override
  String get supportOffline => 'Suporte offline';

  @override
  String get lastSeenSeconds => 'Ativo há poucos segundos';

  @override
  String lastSeenMinutes(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: 'minutos',
      one: 'minuto',
    );
    return 'Ativo há $minutes $_temp0';
  }

  @override
  String lastSeenHours(int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: 'horas',
      one: 'hora',
    );
    return 'Ativo há $hours $_temp0';
  }

  @override
  String lastSeenDays(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'dias',
      one: 'dia',
    );
    return 'Ativo há $days $_temp0';
  }

  @override
  String get online => 'Online';

  @override
  String get callSupport => 'Ligar';

  @override
  String get typeMessage => 'Digite uma mensagem...';

  @override
  String get callBusy => 'Suporte está ocupado';

  @override
  String get callRejected => 'Chamada rejeitada';

  @override
  String get callFailed => 'Chamada não conectou';

  @override
  String get callEnded => 'Chamada encerrada';

  @override
  String get callSupportBusy => 'Suporte já está em outra chamada';

  @override
  String get errorStartingChat => 'Erro ao iniciar chat';

  @override
  String get errorStartingCall => 'Erro ao iniciar chamada';

  @override
  String get errorConnecting => 'Erro de conexão';

  @override
  String get errorAcceptingCall => 'Erro ao aceitar chamada';

  @override
  String get errorDownloading => 'Erro ao baixar';

  @override
  String get errorUploading => 'Erro ao enviar';

  @override
  String get errorSending => 'Erro ao enviar';

  @override
  String get errorPickingPhotos => 'Erro ao selecionar fotos';

  @override
  String get errorPickingFiles => 'Erro ao selecionar arquivos';

  @override
  String get errorTakingPhoto => 'Erro ao tirar foto';

  @override
  String get fileNotLoaded => 'Arquivo não carregado';

  @override
  String get attachmentIdMissing => 'ID do anexo ausente';

  @override
  String get camera => 'Câmera';

  @override
  String get gallery => 'Galeria';

  @override
  String get file => 'Arquivo';

  @override
  String typingIndicator(String name) {
    return '$name está digitando...';
  }

  @override
  String get notifNewMessageFrom => 'Nova mensagem de';

  @override
  String get notifUrgentPrefix => 'URGENTE';

  @override
  String get notifUrgentMessage => 'MENSAGEM URGENTE';

  @override
  String get notifIncomingCall => 'Chamada recebida';

  @override
  String get notifCallingYou => 'está ligando...';

  @override
  String get notifUpdateAvailable => 'Atualização disponível';

  @override
  String get notifVersionAvailable => 'já está disponível';

  @override
  String get notifConnected => 'Conectado';

  @override
  String get notifDisconnected => 'Desconectado';

  @override
  String get notifConnectedBody => 'Você está conectado ao servidor.';

  @override
  String get notifDisconnectedBody => 'A conexão com o servidor foi perdida.';

  @override
  String get notifError => 'Erro';

  @override
  String get retry => 'Tentar novamente';

  @override
  String get save => 'Salvar';

  @override
  String get accept => 'Aceitar';

  @override
  String get selectFile => 'Selecionar arquivo';

  @override
  String get dataLoadingText => 'Carregando dados...';

  @override
  String get dataSavedSuccess => 'Dados salvos com sucesso';

  @override
  String get errorSaving => 'Erro ao salvar';

  @override
  String get errorLoading => 'Erro ao carregar';

  @override
  String savedFilename(String filename) {
    return 'Salvo: $filename';
  }

  @override
  String get logsCopied => 'Logs copiados!';

  @override
  String get diagnosticDataTitle => 'Dados de diagnóstico';

  @override
  String get diagnosticDescription =>
      'Deseja enviar dados de diagnóstico anónimos para melhorar a aplicação?';

  @override
  String get noThanks => 'Não, obrigado';

  @override
  String get yesEnable => 'Sim, ativar';

  @override
  String get passwordMinEightChars =>
      'A senha deve ter pelo menos 8 caracteres';

  @override
  String get passwordChangeSuccess => 'Senha alterada com sucesso';

  @override
  String get emailChangeError => 'Erro ao alterar e-mail';

  @override
  String get acceptDocumentCheckbox => 'Li e aceito o documento.';

  @override
  String loadingErrorGeneric(String details) {
    return 'Erro ao carregar: $details';
  }

  @override
  String get incomingCallTitle => 'Chamada recebida';

  @override
  String ringingFor(int seconds) {
    return 'Tocando há ${seconds}s';
  }

  @override
  String get rejectCall => 'Rejeitar';

  @override
  String get acceptCall => 'Atender';

  @override
  String get unmute => 'Ativar som';

  @override
  String get mute => 'Silenciar';

  @override
  String get hangUp => 'Desligar';

  @override
  String get calling => 'Chamando...';

  @override
  String autoRejectIn(int seconds) {
    return 'Rejeição automática em $seconds segundos';
  }

  @override
  String get speakerOn => 'Alto-falante';

  @override
  String get speakerOff => 'Auricular';

  @override
  String get micMuted => 'Silenciado';

  @override
  String get micOn => 'Microfone';

  @override
  String get connectionExcellent => 'Excelente';

  @override
  String get connectionGood => 'Boa';

  @override
  String get connectionWeak => 'Fraca';

  @override
  String get connectionLost => 'Desconectado';

  @override
  String get personalData => 'Dados pessoais';

  @override
  String get personalDataSubtitle => 'Nome, apelido, morada';

  @override
  String get membershipFee => 'Quota de membro';

  @override
  String annualFeeYear(String year) {
    return 'Quota anual $year';
  }

  @override
  String get amount => 'Valor:';

  @override
  String get dueBy => 'Vencimento:';

  @override
  String get paid => 'Pago';

  @override
  String get versionHistory => 'Histórico de versões';

  @override
  String lastUpdated(String date) {
    return 'Última atualização: $date';
  }

  @override
  String get noVersionHistory => 'Nenhum histórico disponível';

  @override
  String get failedLoadChangelog => 'Falha ao carregar o registo de alterações';

  @override
  String get callMember => 'Ligar ao membro';

  @override
  String get closeConversation => 'Fechar conversa';

  @override
  String get chatOffline => 'Offline';

  @override
  String get attachFiles => 'Anexar ficheiros (máx. 10, 50MB)';

  @override
  String get conversationClosed => 'Esta conversa foi encerrada';

  @override
  String get noMessages => 'Sem mensagens';

  @override
  String get goBack => 'Voltar';

  @override
  String get goForward => 'Avançar';

  @override
  String get homePage => 'Início';

  @override
  String get firstNameLabel => 'Nome';

  @override
  String get lastNameLabel => 'Apelido';

  @override
  String get streetLabel => 'Rua';

  @override
  String get houseNumberLabel => 'N.º';

  @override
  String get postalCodeLabel => 'Código postal';

  @override
  String get cityLabel => 'Cidade';

  @override
  String get phoneMobileLabel => 'Telefone (Telemóvel)';

  @override
  String get phoneLandlineLabel => 'Telefone (Fixo)';

  @override
  String get newEmailLabel => 'Novo endereço de e-mail';

  @override
  String get currentPasswordLabel => 'Palavra-passe atual';

  @override
  String get newPasswordLabel => 'Nova palavra-passe';

  @override
  String get confirmPasswordLabel => 'Confirmar palavra-passe';

  @override
  String get emailChangedSuccess => 'Email alterado com sucesso';

  @override
  String get newPasswordMinChars => 'Nova palavra-passe (mín. 6 caracteres)';

  @override
  String get reasonLabel2 => 'Motivo';

  @override
  String get downloadFailed2 => 'Transferência falhada';

  @override
  String get downloadTooltip => 'Transferir';

  @override
  String get connectionErrorGeneric => 'Erro de ligação';

  @override
  String get errorNoInternet => 'Sem ligação à Internet. Verifique a sua rede.';

  @override
  String get errorTimeout => 'O servidor não responde. Tente novamente mais tarde.';

  @override
  String get errorServer => 'Erro do servidor. Tente novamente mais tarde.';

  @override
  String get errorConnection => 'Erro de ligação. Tente novamente mais tarde.';

  @override
  String get errorUnexpected => 'Ocorreu um erro inesperado. Tente novamente mais tarde.';

  @override
  String get copyLogs => 'Copiar registos';

  @override
  String get deleteLogs => 'Apagar registos';

  @override
  String get autoScrollOn => 'Rolagem automática LIGADA';

  @override
  String get autoScrollOff => 'Rolagem automática DESLIGADA';

  @override
  String get unknownValue => 'Desconhecido';

  @override
  String get bankTransfer => 'Transferência bancária';

  @override
  String get standingOrder => 'Ordem permanente';

  @override
  String get payment => 'Pagamento';

  @override
  String get warningType_ermahnung => 'Aviso';

  @override
  String get warningType_abmahnung => 'Advertência';

  @override
  String get warningType_letzte => 'Última advertência';

  @override
  String warningsTotal(int count) {
    return 'Total: $count';
  }

  @override
  String warningsErmahnung(int count) {
    return 'Avisos: $count';
  }

  @override
  String warningsAbmahnung(int count) {
    return 'Advertências: $count';
  }

  @override
  String warningsLetzte(int count) {
    return 'Últimas: $count';
  }

  @override
  String get noWarnings => 'Sem avisos';

  @override
  String get noWarningsDescription => 'De momento não tem avisos.';

  @override
  String createdBy(String name) {
    return 'Criado por: $name';
  }

  @override
  String get monthJan => 'Jan';

  @override
  String get monthFeb => 'Fev';

  @override
  String get monthMar => 'Mar';

  @override
  String get monthApr => 'Abr';

  @override
  String get monthMay => 'Mai';

  @override
  String get monthJun => 'Jun';

  @override
  String get monthJul => 'Jul';

  @override
  String get monthAug => 'Ago';

  @override
  String get monthSep => 'Set';

  @override
  String get monthOct => 'Out';

  @override
  String get monthNov => 'Nov';

  @override
  String get monthDec => 'Dez';

  @override
  String get stufe1_name => 'Dados pessoais';

  @override
  String get stufe2_name => 'Tipo de membro';

  @override
  String get stufe3_name => 'Situação financeira';

  @override
  String get stufe4_name => 'Método de pagamento';

  @override
  String get stufe5_name => 'Início da adesão';

  @override
  String get stufe6_name => 'Estatutos';

  @override
  String get stufe7_name => 'Política de privacidade';

  @override
  String get stufe8_name => 'Direito de revogação';

  @override
  String get memberType_ordentlich => 'Membro efetivo';

  @override
  String get memberType_foerder => 'Membro apoiante';

  @override
  String get memberType_ehren => 'Membro honorário';

  @override
  String get memberDesc_ordentlich =>
      'Membro ativo com direito a voto. Participa nos serviços da associação (email, cloud, apoio burocrático).';

  @override
  String get memberDesc_foerder =>
      'Apoia a associação com contribuições. Pode assistir à assembleia geral com voto consultivo, sem direito a voto ou elegibilidade para a direção.';

  @override
  String get memberDesc_ehren =>
      'Tem os direitos de um membro efetivo sem obrigação de pagar quotas. Nomeado pela assembleia geral ou pela direção.';

  @override
  String get payMethod_ueberweisung => 'Transferência bancária';

  @override
  String get payMethod_dauerauftrag => 'Ordem permanente';

  @override
  String get verifyStatus_geprueft => 'Verificado';

  @override
  String get verifyStatus_ausgefuellt => 'Preenchido';

  @override
  String get verifyStatus_abgelehnt => 'Rejeitado';

  @override
  String get verifyStatus_offen => 'Em aberto';

  @override
  String get fillRequiredFields => 'Preencha todos os campos obrigatórios.';

  @override
  String get personalDataSaved => 'Dados pessoais guardados';

  @override
  String get selectMemberType => 'Selecione um tipo de membro.';

  @override
  String get memberTypeSaved => 'Tipo de membro guardado';

  @override
  String get selectOption => 'Selecione uma opção.';

  @override
  String get financialSaved => 'Situação financeira guardada';

  @override
  String get selectPaymentMethod => 'Selecione um método de pagamento.';

  @override
  String get paymentDataSaved => 'Dados de pagamento guardados';

  @override
  String get selectDate => 'Selecione uma data.';

  @override
  String get membershipStartSaved => 'Início da adesão guardado';

  @override
  String get fileTooLarge => 'Ficheiro demasiado grande (máx. 10 MB).';

  @override
  String get leistungsbescheidUploaded =>
      'Certificado de prestações carregado com sucesso';

  @override
  String get verificationProgress => 'Progresso da verificação';

  @override
  String get notApplicable => 'Não aplicável';

  @override
  String get socialBenefitsExempt =>
      'Método de pagamento não necessário para beneficiários de prestações sociais.';

  @override
  String get locked => 'Bloqueado';

  @override
  String completePreviousStep(int step) {
    return 'Complete primeiro o passo $step.';
  }

  @override
  String rejectedNote(String note) {
    return 'Rejeitado: $note';
  }

  @override
  String get waitingForReview => 'A aguardar revisão pela direção.';

  @override
  String get stepApproved => 'Este passo foi verificado e aprovado.';

  @override
  String get changesViaChat => 'Alterações apenas possíveis por chat.';

  @override
  String get firstNameRequired => 'Nome *';

  @override
  String get lastNameRequired => 'Apelido *';

  @override
  String get birthDateLabel => 'Data de nascimento *';

  @override
  String get streetRequired => 'Rua *';

  @override
  String get houseNumberRequired => 'N.º *';

  @override
  String get cityRequired => 'Cidade *';

  @override
  String get phoneRequired => 'Número de telefone *';

  @override
  String get phonePurpose =>
      'Finalidade: Contacto quando indisponível pela app';

  @override
  String get selectMemberTypePrompt => 'Selecione o tipo de membro desejado:';

  @override
  String get financialExplanation =>
      'Para verificar se tem direito a uma redução da quota, precisamos das seguintes informações. Estas serão utilizadas exclusivamente para determinar a sua quota de membro.';

  @override
  String get socialBenefitsQuestion => 'Recebe atualmente prestações sociais?';

  @override
  String get optionBuergergeld => 'Sim, subsídio cidadão (Job Center)';

  @override
  String get optionSozialamt => 'Sim, assistência social (Serviços Sociais)';

  @override
  String get optionNoBenefits => 'Não, não recebo prestações sociais';

  @override
  String get feeExempt => 'A sua quota mensal é: 0,00 €/mês';

  @override
  String get uploadLeistungsbescheid => 'Carregar certificado de prestações';

  @override
  String get uploadLeistungsbescheidHint =>
      'Carregue um certificado de prestações atual no prazo de 14 dias para confirmar a isenção da quota.';

  @override
  String get allowedFormatsUpload =>
      'Formatos permitidos: PDF, JPG, PNG (máx. 10 MB)';

  @override
  String get feeRegular => 'A sua quota mensal é: 25,00 €/mês';

  @override
  String paymentDayReminder(int day) {
    return 'Será lembrado no dia $day de cada mês.';
  }

  @override
  String get membershipStartPrompt =>
      'Escolha quando a sua adesão deve começar.';

  @override
  String get optionAfterVerification => 'Após conclusão da verificação';

  @override
  String get optionAfterVerificationDesc =>
      'A adesão começa a partir do dia da confirmação da direção.';

  @override
  String get optionRetroFoundation =>
      'Retroativo à data de fundação (01.08.2025)';

  @override
  String get optionRetroFoundationDesc =>
      'Torna-se membro retroativo desde a fundação da associação.';

  @override
  String get optionRetroCustom => 'Retroativo a outra data';

  @override
  String get optionRetroCustomDesc =>
      'Escolha uma data entre 01.08.2025 e hoje.';

  @override
  String get selectDateLabel => 'Selecionar data';

  @override
  String get selectDateHint => 'Selecionar data...';

  @override
  String get dateNotBefore => 'Não antes de 01.08.2025 (data de fundação)';

  @override
  String get feeExemptRetro =>
      'Isenção de quota: 0,00 € retroativo.\nApenas a data de adesão é definida retroativamente.';

  @override
  String get retroactiveFees => 'Quotas retroativas';

  @override
  String retroFeeCalculation(
      String from, String to, String months, String total) {
    return 'Período: $from – $to\nMeses: $months\nQuota: $months × 25,00 € = $total €';
  }

  @override
  String get pleaseReadSatzung => 'Leia os estatutos da associação.';

  @override
  String get pleaseReadDatenschutz => 'Leia a política de privacidade.';

  @override
  String get pleaseReadWiderruf => 'Leia o direito de revogação.';

  @override
  String get acceptedAtRegistration => 'Aceite no registo';

  @override
  String get confirmedByBoard => 'Será confirmado após revisão da direção.';

  @override
  String get docSatzung => 'Estatutos';

  @override
  String get docDatenschutz => 'Política de privacidade';

  @override
  String get docWiderruf => 'Direito de revogação';

  @override
  String acceptedAtRegCount(int count) {
    return 'Aceite no registo ($count/3)';
  }

  @override
  String acceptedOn(String date) {
    return 'Aceite em $date';
  }

  @override
  String get notAccepted => 'Não aceite';

  @override
  String get statusAccepted => 'Aceite';

  @override
  String get memberNumberTooLong =>
      'Número de membro muito longo (máx. 20 caracteres)';

  @override
  String get onlyUppercaseAndNumbers =>
      'Apenas letras maiúsculas e números são permitidos';

  @override
  String get passwordTooLong => 'Senha muito longa (máx. 100 caracteres)';

  @override
  String get nameTooLong => 'Nome muito longo (máx. 100 caracteres)';

  @override
  String get emailTooLong => 'Email muito longo (máx. 255 caracteres)';

  @override
  String get legalAcknowledgePrefix => 'Eu li a ';

  @override
  String get legalAcknowledgeSuffix => '.';

  @override
  String get legalStatutesSuffix =>
      ' da ICD360S e.V. e reconheço-os como vinculativos.';

  @override
  String get legalPleaseReadFirst => '(por favor leia primeiro)';

  @override
  String get statusActive => 'Ativo';

  @override
  String get statusSuspended => 'Suspenso';

  @override
  String get statusNew => 'Novo';

  @override
  String get statusCancelled => 'Cancelado';

  @override
  String get statusDeleted => 'Eliminado';

  @override
  String get roleMitglied => 'Membro';

  @override
  String get roleVorsitzer => 'Presidente';

  @override
  String get roleStellvertreter => 'Vice-presidente';

  @override
  String get roleSchatzmeister => 'Tesoureiro';

  @override
  String get roleSchriftfuehrer => 'Secretário';

  @override
  String get roleBeisitzer => 'Assessor';

  @override
  String get roleKassierer => 'Caixa';

  @override
  String get roleKassenpruefer => 'Auditor';

  @override
  String get roleEhrenamtlich => 'Voluntário';

  @override
  String get roleMitgliedergruender => 'Membro Fundador';

  @override
  String get roleEhrenmitglied => 'Membro Honorário';

  @override
  String get roleFoerdermitglied => 'Membro de Apoio';

  @override
  String get memberTypeNotSet => 'Ainda não definido';

  @override
  String get payMethodSepa => 'Débito direto SEPA';

  @override
  String get labelStatus => 'Estado';

  @override
  String get labelMemberNumber => 'Número de membro';

  @override
  String get labelRole => 'Função';

  @override
  String get labelMemberType => 'Tipo de membro';

  @override
  String get labelPaymentMethod => 'Método de pagamento';

  @override
  String get labelRegisteredOn => 'Registrado em';

  @override
  String get labelLastLogin => 'Último acesso';

  @override
  String get labelMemberSince => 'Membro desde';

  @override
  String get neverLoggedIn => 'Nunca';

  @override
  String get notActivatedYet => 'Ainda não ativado';

  @override
  String get tabVerification => 'Verificação';

  @override
  String get tabWarnings => 'Avisos';

  @override
  String get tabDocuments => 'Documentos';

  @override
  String get tabMembership => 'Adesão';

  @override
  String get pleaseEnterFirstName => 'Insira o nome';

  @override
  String get pleaseEnterLastName => 'Insira o sobrenome';

  @override
  String get noFileDataReceived => 'Nenhum dado recebido';

  @override
  String get openFile => 'Abrir';

  @override
  String get diagnosticErrors => 'Relatórios de erro para melhoria';

  @override
  String get diagnosticAnonymousStats => 'Estatísticas de uso anônimas';

  @override
  String get diagnosticPerformance => 'Dados de desempenho do app';

  @override
  String get noMicrophoneError =>
      'Nenhum microfone encontrado. Conecte um microfone e tente novamente.';

  @override
  String get startConversation => 'Inicie uma conversa!';

  @override
  String get staffWillReply => 'Um funcionário responderá em breve.';

  @override
  String get inCall => 'Em chamada...';

  @override
  String get registration => 'Registo';

  @override
  String get deactivation => 'Desativação';

  @override
  String get deactivatedOn => 'Desativado em';

  @override
  String get accountAutoSuspend =>
      'Contas não verificadas em 30 dias serão suspensas automaticamente.';

  @override
  String get ipClean => 'IP limpo - não listado';

  @override
  String get documentsProvidedByBoard =>
      'Os documentos são fornecidos pela diretoria.';

  @override
  String get noDocumentsAvailable => 'Nenhum documento disponível';

  @override
  String get noDocumentsDescription =>
      'Ainda não foram fornecidos documentos para você.';

  @override
  String uploadedBy(String name) {
    return 'Enviado por: $name';
  }

  @override
  String stepsCompleted(int completed, int total) {
    return '$completed/$total etapas concluídas';
  }

  @override
  String dayOfMonth(int day) {
    return '$day do mês';
  }

  @override
  String changeField(String field) {
    return 'Alterar $field';
  }

  @override
  String openDocument(String name) {
    return 'Abrir $name';
  }

  @override
  String get helpImproveApp =>
      'Gostaria de nos ajudar a melhorar o aplicativo?';

  @override
  String get noPersonalDataCollected =>
      'Nenhum dado pessoal é coletado. Esta configuração pode ser alterada a qualquer momento.';

  @override
  String logEntries(int count) {
    return '$count entradas';
  }

  @override
  String get noLogs => 'Sem registros';

  @override
  String get newLoginDetected => 'Novo login detectado';

  @override
  String get waitingForMember => 'Aguardando membro';

  @override
  String get waitingForStaff => 'Aguardando funcionário';

  @override
  String get waitingForAuthority => 'Aguardando autoridade';
}
