// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

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
  String get confirmPassword => 'Confirmar Senha';

  @override
  String get confirmPasswordHint => 'Confirme a senha';

  @override
  String get newPassword => 'Nova Senha';

  @override
  String get newPasswordHint => 'Digite a nova senha';

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
  String get unknown => 'Desconhecido';

  @override
  String error(String error) {
    return 'Erro: $error';
  }

  @override
  String get cancel => 'Cancelar';

  @override
  String get resetPassword => 'Redefinir Senha';

  @override
  String get imprint => 'Aviso Legal';

  @override
  String get privacy => 'Política de Privacidade';

  @override
  String get statutes => 'Estatutos';

  @override
  String get revocation => 'Direito de Arrependimento';

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
  String get myAppointments => 'Meus compromissos';

  @override
  String get priority => 'Prioridade';

  @override
  String get messageLabel => 'Mensagem';

  @override
  String get reportProblems => 'Relatar problemas';

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
  String get low => 'Baixo';

  @override
  String get high => 'Alto';

  @override
  String get submit => 'Enviar';

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
  String get saveEmail => 'Salvar email';

  @override
  String get savePassword => 'Salvar senha';

  @override
  String get deviceLoggedOut => 'Dispositivo desconectado';

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
  String get autoUpdateEnableTitle => 'Install future updates automatically';

  @override
  String get autoUpdateEnableHint =>
      'The app downloads and installs updates on its own and restarts briefly. No further prompts.';

  @override
  String autoUpdateInstalling(String version) {
    return 'Version $version is being installed in the background. The app will restart shortly.';
  }

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
  String get reasonLabel2 => 'Motivo';

  @override
  String get downloadFailed2 => 'Transferência falhada';

  @override
  String get downloadTooltip => 'Transferir';

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
  String logEntries(int count) {
    return '$count entradas';
  }

  @override
  String get noLogs => 'Sem registros';

  @override
  String get newLoginDetected => 'Novo login detectado';

  @override
  String get errorNoInternet => 'Sem ligação à Internet. Verifique a sua rede.';

  @override
  String get errorTimeout =>
      'O servidor não responde. Tente novamente mais tarde.';

  @override
  String get errorServer => 'Erro do servidor. Tente novamente mais tarde.';

  @override
  String get errorConnection => 'Erro de ligação. Tente novamente mais tarde.';

  @override
  String get errorUnexpected =>
      'Ocorreu um erro inesperado. Tente novamente mais tarde.';

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
  String get claudiuWelcomeMorning => 'Bom dia';

  @override
  String get claudiuWelcomeDay => 'Olá';

  @override
  String get claudiuWelcomeEvening => 'Boa noite';

  @override
  String get claudiuWelcomeNight => 'Boa noite';

  @override
  String get claudiuWelcomeVisitor => 'caro visitante';

  @override
  String get claudiuWelcomeAsk => 'Como posso ajudar?';

  @override
  String get claudiuWelcomeBecomeMember => 'Quero tornar-me membro';

  @override
  String get claudiuWelcomeLogin => 'Já sou membro e quero entrar';

  @override
  String get claudiuWelcomeProblem => 'Tenho um problema com a app';

  @override
  String get claudiuWelcomeEmergency => 'Emergência — ligue-nos';

  @override
  String get claudiuWelcomeMascotName => 'Claudiu';

  @override
  String get claudiuWelcomeEmergencyIntro =>
      'Antes de ligares — o nosso horário:';

  @override
  String get claudiuWelcomeScheduleOffice => 'No escritório';

  @override
  String get claudiuWelcomeScheduleField => 'No terreno com clientes';

  @override
  String get claudiuWelcomeOutsideHoursNote =>
      'Fora deste horário só atendemos emergências. Também podes enviar SMS para o mesmo número — entraremos em contacto.';

  @override
  String get claudiuWelcomeCallNow => 'Ligar agora';

  @override
  String get claudiuWelcomeSendSms => 'Enviar SMS';

  @override
  String get claudiuWelcomeSmsBody =>
      'Emergência ICD360S e.V. — por favor contactem-me o mais rápido possível.';

  @override
  String get claudiuWelcomeCloseButton => 'Fechar';

  @override
  String get claudiuLoginWelcome => 'Bem-vindo de volta, caro membro!';

  @override
  String get claudiuLoginAsk => 'Diz-me o teu número de membro.';

  @override
  String get claudiuLoginProgress => 'Quase… continua a escrever.';

  @override
  String get claudiuLoginReady => 'Perfeito! Toca no botão abaixo.';

  @override
  String get claudiuLoginLoading => 'A verificar a identidade… 🔍';

  @override
  String get claudiuLoginFoundPlain => 'Encontrei-te! A entrar…';

  @override
  String claudiuLoginFoundNamed(String name) {
    return 'Encontrei-te, $name! A entrar…';
  }

  @override
  String get claudiuLoginError =>
      'Hm, não encontro esse número. Escreveste-o corretamente?';

  @override
  String get claudiuLoginForgotHeader => 'Esqueceste-te do número de membro?';

  @override
  String get claudiuLoginNoSms => 'Não enviamos o número por email ou SMS.';

  @override
  String get claudiuLoginOnlyWay =>
      'A única forma: encontrar-nos pessoalmente na sede da associação, após verificação de identidade.';

  @override
  String get claudiuLoginContactUs => 'Liga-nos para marcar:';

  @override
  String get claudiuDiagnosticGreeting =>
      'Antes de entrares, uma pergunta rápida';

  @override
  String get claudiuDiagnosticAsk =>
      'Posso enviar relatórios anónimos para os programadores melhorarem a app?';

  @override
  String get claudiuDiagnosticYes => 'Sim, quero ajudar';

  @override
  String get claudiuDiagnosticNo => 'Não, só estou a explorar';

  @override
  String get claudiuDiagnosticTellMore => 'Conta-me mais';

  @override
  String get claudiuDiagnosticSendsHeader => '📤 O que ENVIAMOS (anónimo):';

  @override
  String get claudiuDiagnosticSends1 =>
      'Um código anónimo do dispositivo (NÃO o número de membro)';

  @override
  String get claudiuDiagnosticSends2 => 'O teu papel (membro / direção)';

  @override
  String get claudiuDiagnosticSends3 =>
      'Sistema operativo (Linux / Android / iOS / Windows)';

  @override
  String get claudiuDiagnosticSends4 => 'Idioma escolhido';

  @override
  String get claudiuDiagnosticSends5 => 'Nível e estado da bateria';

  @override
  String get claudiuDiagnosticSends6 => 'Ecrã atual';

  @override
  String get claudiuDiagnosticSends7 => 'Duração da sessão (segundos)';

  @override
  String get claudiuDiagnosticSends8 => 'Erros, se houver (últimos 10)';

  @override
  String get claudiuDiagnosticSends9 => 'Navegação (últimos 20 ecrãs)';

  @override
  String get claudiuDiagnosticSends10 =>
      'Quantas vezes a aplicação enviou dados (apenas o número, sem conteúdo)';

  @override
  String get claudiuDiagnosticSends11 =>
      'Como o sistema classifica a aplicação e a rapidez com que a bateria descarrega';

  @override
  String get claudiuDiagnosticNeverHeader => '🛡️ O que NUNCA enviamos:';

  @override
  String get claudiuDiagnosticNever1 => 'O teu nome real';

  @override
  String get claudiuDiagnosticNever2 => 'Endereço de email';

  @override
  String get claudiuDiagnosticNever3 => 'Número de telefone';

  @override
  String get claudiuDiagnosticNever4 => 'Palavra-passe';

  @override
  String get claudiuDiagnosticNever5 => 'Conteúdo das mensagens de chat';

  @override
  String get claudiuDiagnosticNever6 => 'Conteúdo dos tickets';

  @override
  String get claudiuDiagnosticNever7 => 'Documentos ou anexos';

  @override
  String get claudiuDiagnosticTechHeader => '📡 Detalhes técnicos:';

  @override
  String get claudiuDiagnosticTech1 => 'Enviado a cada 15 minutos';

  @override
  String get claudiuDiagnosticTech2 =>
      'Conexão TLS encriptada com certificado afixado';

  @override
  String get claudiuDiagnosticTech3 =>
      'Podes desligar a qualquer momento nas Definições';

  @override
  String get claudiuProblemHelpTitle => 'Como posso ajudar?';

  @override
  String get claudiuProblemHelpGreeting => 'O que aconteceu?';

  @override
  String get claudiuProblemHelpAsk => 'Como queres contar-me?';

  @override
  String get claudiuProblemHelpWriteTitle => 'Escrever um relatório';

  @override
  String get claudiuProblemHelpWriteBody =>
      'Com detalhes passo a passo. A equipa recebe o texto e resolve depois.';

  @override
  String get claudiuProblemHelpChatTitle => 'Falemos agora';

  @override
  String get claudiuProblemHelpChatBody =>
      'Chat anónimo com um operador. Resposta em tempo real se alguém estiver online.';

  @override
  String get claudiuProblemHelpAltCallHeader => 'Ou, se for urgente:';

  @override
  String get claudiuProblemHelpAltCallLabel => 'Liga-nos';

  @override
  String get claudiuAnonymousChatTitle => 'Chat anónimo';

  @override
  String get claudiuAnonymousChatGreeting => 'Olá!';

  @override
  String get claudiuAnonymousChatWelcome =>
      'Estou a ouvir. Escreve o que quiseres — sem nome. Respondo assim que chegar.';

  @override
  String get claudiuAnonymousChatHint => 'Escreve uma mensagem…';

  @override
  String get claudiuAnonymousChatWaitingOperator =>
      'À espera que um operador responda…';

  @override
  String get claudiuVorsitzerConnectedTitle => 'Olá!';

  @override
  String get claudiuVorsitzerConnectedBody =>
      'Obrigado por escreveres — agora estás em contacto com um Vorsitzer. Conta-nos como podemos ajudar com o teu pedido de adesão.';

  @override
  String get claudiuVorsitzerConnectedSender => 'Vorsitzer';

  @override
  String get claudiuQuickReplyValidationTime =>
      'Quanto tempo demora a validação?';

  @override
  String get claudiuQuickReplyDocuments => 'Que documentos preciso?';

  @override
  String get claudiuQuickReplyStepProblem => 'Estou preso num passo';

  @override
  String get claudiuQuickReplyHuman => 'Posso falar com alguém agora?';

  @override
  String get claudiuAnonymousChatConnecting => 'A ligar…';

  @override
  String get claudiuAnonymousChatConnectionFailed =>
      'Não foi possível abrir o chat. Tenta de novo ou liga.';

  @override
  String get claudiuAnonymousChatRetry => 'Tentar de novo';

  @override
  String get claudiuAnonymousChatOnline => 'Ligado';

  @override
  String get claudiuAnonymousChatOffline => 'A reconectar…';

  @override
  String get claudiuAnonymousChatAdminTyping => 'O operador está a escrever…';

  @override
  String get claudiuProblemReportTitle => 'Reportar um problema';

  @override
  String get claudiuProblemReportGreeting => 'O que aconteceu?';

  @override
  String get claudiuProblemReportAsk =>
      'Conta-me em detalhe e encaminharei o relatório para a equipa.';

  @override
  String get claudiuProblemReportIncludeHeader => 'Por favor inclui:';

  @override
  String get claudiuProblemReportIncludeBullets1 =>
      'O que estavas a fazer quando o problema apareceu';

  @override
  String get claudiuProblemReportIncludeBullets2 =>
      'Qualquer mensagem de erro que viste';

  @override
  String get claudiuProblemReportIncludeBullets3 => 'Em que ecrã estavas';

  @override
  String get claudiuProblemReportIncludeBullets4 =>
      'A app falha, fecha-se ou mostra um ecrã em branco?';

  @override
  String get claudiuProblemReportIncludeBullets5 =>
      'Acontece todas as vezes ou apenas uma vez?';

  @override
  String get claudiuProblemReportDescriptionLabel => 'A tua descrição';

  @override
  String get claudiuProblemReportDescriptionHint =>
      'P. ex.: Quando abro o ecrã de chat aparece \'Connection error\' e a app deixa de responder…';

  @override
  String claudiuProblemReportTooShort(int count) {
    return 'Um pouco mais de detalhe, por favor (mínimo $count caracteres)';
  }

  @override
  String get claudiuProblemReportSubmit => 'Enviar relatório';

  @override
  String get claudiuProblemReportSubmitting => 'A enviar…';

  @override
  String get claudiuProblemReportSentTitle => 'Obrigado!';

  @override
  String get claudiuProblemReportSentBody =>
      'O relatório foi enviado. A nossa equipa irá analisá-lo o mais rápido possível.';

  @override
  String get claudiuProblemReportSentClose => 'Entendido';

  @override
  String get claudiuProblemReportSendFailed =>
      'Não foi possível enviar o relatório. Liga-nos para ajuda urgente.';

  @override
  String get claudiuProblemReportAlt => 'Ou, se for urgente:';

  @override
  String get claudiuProblemReportCallLabel => 'Liga-nos';

  @override
  String claudiuApprovalGreeting(String name) {
    return 'Olá, $name! 👋';
  }

  @override
  String get claudiuApprovalGreetingNoName => 'Olá! 👋';

  @override
  String get claudiuApprovalGladToSeeYou => 'Que bom que vieste!';

  @override
  String get claudiuApprovalCheckingForSafety =>
      'Para tua segurança, um Vorsitzer está a verificar o teu pedido de início de sessão. 🛡️';

  @override
  String get claudiuApprovalMonthlyExplain =>
      '💡 Fazemos isto a cada 30 dias para nos certificarmos de que és mesmo tu. É como um check-up de segurança — máximo 5 minutos.';

  @override
  String get claudiuApprovalSuccess =>
      'Pronto! 🎉 O Vorsitzer reconheceu-te. A entrar…';

  @override
  String get claudiuApprovalDenied =>
      'Hm, o Vorsitzer recusou o teu pedido. 😔';

  @override
  String get claudiuApprovalDeniedHelp =>
      'Se achas que é um engano, por favor liga-nos para esclarecer.';

  @override
  String get claudiuApprovalExpired =>
      'Passaram os 5 minutos e não tivemos resposta do Vorsitzer.';

  @override
  String get claudiuApprovalExpiredHelp =>
      'Liga-nos e podemos aprovar o teu pedido na hora. 📞';

  @override
  String get claudiuApprovalCallUs => 'Liga-nos';

  @override
  String get claudiuApprovalTryAgain => 'Tentar de novo';

  @override
  String get claudiuApprovalCancel => 'Cancelar';

  @override
  String get claudiuApprovalClose => 'Fechar';

  @override
  String get wizardIntroBubble1 =>
      'Olá, visitante! 👋 Obrigado por quereres juntar-te à nossa família.';

  @override
  String get wizardIntroBubble2 =>
      'Chamo-me Claudiu. Na primavera de 2025 tive uma visão clara: criar uma associação que ajuda pessoas necessitadas — voluntariamente, de coração, sem burocracia inútil. ❤️';

  @override
  String get wizardIntroBubble3 =>
      'Comecei a falar com os clientes que visitava. Contei-lhes o meu sonho. E cada um disse: \"Sim, vamos!\" Em julho de 2025 reunimo-nos — 6 pessoas determinadas. Decidimos fundar a **ICD360S e.V.** em Neu-Ulm. 📍';

  @override
  String get wizardIntroBubble4 =>
      'A **1 de agosto de 2025**, a associação ganhou vida oficialmente — no Registo de Associações. O presente mais bonito para mim. 🎂';

  @override
  String get wizardIntroBubble5 =>
      'O que fazemos? Ajudamos refugiados, pessoas com deficiência, pessoas economicamente desfavorecidas, **crianças e jovens** — com questões administrativas, alemão, habitação, compras, prestações sociais. O nosso Vorstand é maioritariamente composto por pessoas com deficiência — assim as decisões nascem da experiência real. 🤝';

  @override
  String get wizardIntroBubble6 =>
      'Agora é a tua vez. Vamos inscrever-te — leva cerca de 5 minutos. Vamos passo a passo, não te deixo sozinho. ✨';

  @override
  String get wizardIntroStart => 'Vamos começar';

  @override
  String get wizardBack => 'Voltar';

  @override
  String get wizardNext => 'Seguinte';

  @override
  String wizardStepLabel(int step, int total, String title) {
    return 'Passo $step de $total · $title';
  }

  @override
  String get wizardErrRequired => 'Este campo é obrigatório';

  @override
  String wizardErrTooShort(int count) {
    return 'Demasiado curto (mínimo $count caracteres)';
  }

  @override
  String get wizardErrOnlyLetters =>
      'Apenas letras, espaços, hífenes e apóstrofos';

  @override
  String get wizardErrSaveFailed =>
      'Não foi possível guardar. Verifica a ligação e tenta de novo.';

  @override
  String get wizardStufe1aTitle => 'Identidade';

  @override
  String get wizardStufe1aPrompt =>
      'Vamos conhecer-nos oficialmente. Por favor escreve o teu nome exatamente como aparece no Personalausweis, Reisepass ou Aufenthaltstitel — para ficar consistente com os documentos.';

  @override
  String get wizardStufe1aVornameLabel => 'Vornamen (nomes)';

  @override
  String get wizardStufe1aVornameHelper =>
      'Todos os teus nomes, exatamente como no documento. Com espaço ou hífen (ex. Hans-Peter, Maria Anna).';

  @override
  String get wizardStufe1aNachnameLabel => 'Familienname (apelido)';

  @override
  String get wizardStufe1aNachnameHelper => 'O teu apelido atual.';

  @override
  String get wizardStufe1aGeburtsnameLabel =>
      'Geburtsname (nome de nascimento) — opcional';

  @override
  String get wizardStufe1aGeburtsnameHelper =>
      'Apenas se for diferente do Familienname — p. ex. antes do casamento.';

  @override
  String get wizardStufe1bTitle => 'Aniversário';

  @override
  String get wizardStufe1bPrompt =>
      'Adoraríamos celebrar o teu aniversário contigo! 🎂 Também nos ajuda a confirmar que tens pelo menos 16 anos — é o que diz o nosso Satzung.';

  @override
  String get wizardStufe1bGeburtsdatumLabel => 'Data de nascimento';

  @override
  String get wizardStufe1bGeburtsdatumHelper => 'Toca para escolher uma data';

  @override
  String get wizardStufe1bGeburtsortLabel => 'Local de nascimento';

  @override
  String get wizardStufe1bGeburtsortHelper =>
      'Cidade / localidade onde nasceste.';

  @override
  String get wizardAgeGatePrompt => 'Lamento… 😔';

  @override
  String wizardAgeGateBody1(int age, int years) {
    return 'O nosso Satzung diz que tens de ter pelo menos 16 anos para seres membro. Tens $age — espero ver-te daqui a $years anos! 🌱';
  }

  @override
  String get wizardAgeGateBody2 =>
      'Se quiseres fazer voluntariado pontual (qualquer idade, com consentimento dos pais), liga-nos — adoramos apoiar jovens que querem mudar o mundo.';

  @override
  String get wizardAgeGateBackHome => 'Voltar ao início';

  @override
  String get wizardErrInvalidPhone => 'Número de telefone inválido';

  @override
  String get wizardStufe1b1Title => 'Consentimento dos pais';

  @override
  String get wizardStufe1b1Prompt =>
      'És menor (16-17) — segundo §106 BGB precisamos do consentimento de um pai/mãe ou tutor legal. Diz-me o nome e o número de telefone. Um Vorsitzer ligará e marcará um encontro (presencial ou videochamada). Sem email — queremos ter a certeza de falar com a pessoa certa.';

  @override
  String get wizardStufe1b1VornameLabel => 'Nome do progenitor';

  @override
  String get wizardStufe1b1VornameHelper =>
      'Como no Personalausweis do progenitor.';

  @override
  String get wizardStufe1b1NachnameLabel => 'Apelido do progenitor';

  @override
  String get wizardStufe1b1NachnameHelper =>
      'Como no Personalausweis do progenitor.';

  @override
  String get wizardStufe1b1TelefonLabel => 'Telemóvel do progenitor';

  @override
  String get wizardStufe1b1TelefonHelper =>
      'Um Vorsitzer ligará para este número.';

  @override
  String get wizardStufe1b1RelationLabel => 'Relação com a criança:';

  @override
  String get wizardStufe1b1RelationMutter => 'Mãe';

  @override
  String get wizardStufe1b1RelationVater => 'Pai';

  @override
  String get wizardStufe1b1RelationSorgeberechtigter => 'Tutor legal';

  @override
  String get wizardStufe1b1RelationAndere => 'Outro tutor';

  @override
  String get wizardStufe1cTitle => 'Dados pessoais';

  @override
  String get wizardStufe1cPrompt =>
      'Só para te conhecer um pouco melhor. Isto fica entre nós e não aparece publicamente em lado nenhum.';

  @override
  String get wizardStufe1cGeschlechtLabel => 'Género';

  @override
  String get wizardStufe1cGeschlechtMaennlich => 'Homem';

  @override
  String get wizardStufe1cGeschlechtWeiblich => 'Mulher';

  @override
  String get wizardStufe1cGeschlechtDivers => 'Diverso';

  @override
  String get wizardStufe1cGeschlechtKeineAngabe => 'Prefiro não dizer';

  @override
  String get wizardStufe1cFamilienstandLabel => 'Estado civil';

  @override
  String get wizardStufe1cFamilienstandLedig => 'Solteiro/a';

  @override
  String get wizardStufe1cFamilienstandVerheiratet => 'Casado/a';

  @override
  String get wizardStufe1cFamilienstandGeschieden => 'Divorciado/a';

  @override
  String get wizardStufe1cFamilienstandVerwitwet => 'Viúvo/a';

  @override
  String get wizardStufe1dTitle => 'A tua origem';

  @override
  String get wizardStufe1dPrompt =>
      'Isto ajuda-nos a oferecer-te o apoio certo — por exemplo aconselhamento sobre Aufenthalt ou encontrar a tua comunidade linguística.';

  @override
  String get wizardStufe1dStaatLabel => 'Nacionalidade';

  @override
  String get wizardStufe1dStaatHelper =>
      'P. ex. deutsch, rumänisch, ukrainisch. Várias separadas por vírgula.';

  @override
  String get wizardStufe1dAufenthaltLabel =>
      'Estatuto de residência (Aufenthaltsstatus) — opcional';

  @override
  String get wizardStufe1dAufenthaltHelper =>
      'Escolhe o título da tua Aufenthaltskarte / decisão. O Vorstand confere com os teus documentos.';

  @override
  String get wizardStufe1dAufenthaltAwaitingCitizenship =>
      'Preenche primeiro a nacionalidade acima — mostraremos apenas as opções aplicáveis.';

  @override
  String get wizardStufe1dAufenthaltGerman =>
      'Aufenthaltstitel não necessário — cidadão alemão.';

  @override
  String get wizardStufe1dAufenthaltEuEea =>
      'Cidadão UE/EEE/CH — livre circulação (Freizügigkeit).';

  @override
  String get wizardStufe1dAufenthaltTempHint => 'temporário';

  @override
  String get wizardStufe1dAufenthaltPermHint => 'residência permanente';

  @override
  String get wizardStufe1dAufenthaltAsylumProcessHint =>
      'procedimento de asilo';

  @override
  String get wizardStufe1dAufenthaltOther => 'Outro (especifica no chat)';

  @override
  String get wizardStufe1dAufenthaltRequired =>
      'Por favor escolhe um Aufenthaltstitel.';

  @override
  String get wizardStufe1dMutterspracheLabel => 'Língua materna';

  @override
  String get wizardStufe1dMutterspracheHelper =>
      'Pré-preenchido com o idioma da app — muda se for diferente.';

  @override
  String get wizardStufe1eTitle => 'Endereço';

  @override
  String get wizardStufe1ePrompt =>
      'A tua morada postal — usamo-la para documentos oficiais (Satzung, contratos de membro, avisos).';

  @override
  String get wizardStufe1eStrasseLabel => 'Rua';

  @override
  String get wizardStufe1eStrasseHelper =>
      'Apenas o nome da rua — o número vai no campo ao lado.';

  @override
  String get wizardStufe1eHausnummerLabel => 'Nº';

  @override
  String get wizardStufe1ePlzLabel => 'PLZ (cód. postal)';

  @override
  String get wizardStufe1eOrtLabel => 'Cidade';

  @override
  String get wizardStufe1eLandLabel => 'País';

  @override
  String get wizardStufe1eLandHelper => 'Pré-preenchido: Deutschland.';

  @override
  String get wizardErrInvalidStreet => 'Nome de rua inválido';

  @override
  String get wizardErrInvalidHausnummer =>
      'Número inválido (p. ex. 12, 12a, 12/3)';

  @override
  String get wizardErrInvalidPlz => 'Código postal inválido (apenas dígitos)';

  @override
  String get wizardStufe1fTitle => 'Contacto';

  @override
  String get wizardStufe1fPrompt =>
      'Como te contactamos? O telefone é só para emergências — tudo o resto passa pelo nosso próprio canal cifrado ponta-a-ponta na app. O teu email de membro é atribuído automaticamente e mostrado abaixo.';

  @override
  String get wizardStufe1fTelefonLabel => 'Telemóvel';

  @override
  String get wizardStufe1fTelefonHelper =>
      'Prometo, só te ligo se for importante. 📱';

  @override
  String get wizardStufe2Title => 'Tipo de membro';

  @override
  String get wizardStufe2Prompt =>
      'Que tipo de membro queres ser? Deixa-me explicar cada opção.';

  @override
  String get wizardStufe2OrdentlichTitle => 'Membro ordinário (ordentlich)';

  @override
  String get wizardStufe2OrdentlichBody =>
      'Direitos completos. Pagas a quota mensal, votas na assembleia geral, podes ser eleito para o Vorstand. A escolha padrão.';

  @override
  String get wizardStufe2FoerderTitle => 'Membro apoiante (Fördermitglied)';

  @override
  String get wizardStufe2FoerderBody =>
      'Apoias a associação financeiramente mas não participas ativamente nas decisões. Sem direito de voto. Bom se queres ajudar à distância.';

  @override
  String get wizardStufe2EhrenTitle => 'Membro honorário (Ehrenmitglied)';

  @override
  String get wizardStufe2EhrenBody =>
      'Atribuído pelo Vorstand por mérito especial. Não o escolhes tu — é concedido como reconhecimento. Seleciona apenas se já foste honrado.';

  @override
  String get wizardStufe3Title => 'Situação financeira';

  @override
  String get wizardStufe3Prompt =>
      'Agora sobre a tua situação financeira. Não para te julgar — apenas para te isentar da quota se receberes prestações sociais.';

  @override
  String get wizardStufe3OptionBuergergeld => 'Recebo Bürgergeld';

  @override
  String get wizardStufe3OptionSozialamt => 'Recebo apoios do Sozialamt';

  @override
  String get wizardStufe3OptionNein => 'Não recebo nenhum destes';

  @override
  String get wizardStufe3FeeExemptTitle => 'Quota: 0 € / mês 🎉';

  @override
  String get wizardStufe3FeeExemptBody =>
      'Com Bürgergeld, Sozialamt, ALG I ou Krankengeld estás totalmente isento da quota nos termos do Satzung §6. Só precisamos de uma prova (Leistungsbescheid ou certidão da autoridade / seguro de saúde).';

  @override
  String get wizardStufe3UploadTitle => 'Carregar Leistungsbescheid';

  @override
  String get wizardStufe3UploadHint => 'PDF / JPG / PNG, máximo 10 MB.';

  @override
  String get wizardStufe3UploadRequired =>
      'Por favor carrega o Leistungsbescheid antes de continuar.';

  @override
  String get wizardStufe3FileTooLarge =>
      'Ficheiro demasiado grande. Máximo 10 MB.';

  @override
  String get wizardStufe3UploadFailed =>
      'Não foi possível carregar o ficheiro. Tenta de novo.';

  @override
  String get wizardStufe3RegularFeeTitle => 'Quota: 25 € / mês';

  @override
  String get wizardStufe3RegularFeeBody =>
      'Quota padrão para membros ordinários segundo o Satzung.';

  @override
  String get wizardStufe4Title => 'Pagamento';

  @override
  String get wizardStufe4Prompt =>
      'Como queres pagar a quota? E em que dia do mês preferes que seja debitada?';

  @override
  String get wizardStufe4MethodUeberweisungTitle =>
      'Transferência (Überweisung)';

  @override
  String get wizardStufe4MethodUeberweisungBody =>
      'Inicias tu o pagamento todos os meses a partir da tua conta.';

  @override
  String get wizardStufe4MethodSepaTitle => 'SEPA-Lastschrift (débito direto)';

  @override
  String get wizardStufe4MethodSepaBody =>
      'Debitamos o valor automaticamente da tua conta. O mais cómodo, mas precisamos do IBAN e de um mandato assinado.';

  @override
  String get wizardStufe4MethodDauerauftragTitle =>
      'Dauerauftrag (ordem permanente)';

  @override
  String get wizardStufe4MethodDauerauftragBody =>
      'Configuras uma ordem permanente no teu banco. O teu banco transfere o valor automaticamente todos os meses.';

  @override
  String get wizardStufe4DayLabel => 'Dia do pagamento';

  @override
  String get wizardStufe4DayHint => 'Escolhe um dia entre 1 e 31';

  @override
  String wizardStufe4DayItem(int day) {
    return 'Dia $day';
  }

  @override
  String wizardStufe4DayReminder(int day) {
    return 'A quota será debitada no dia $day de cada mês.';
  }

  @override
  String get wizardStufe5Title => 'Início';

  @override
  String get wizardStufe5Prompt =>
      'A partir de quando queres ser oficialmente membro do ICD360S? Desde a aprovação ou retroativamente.';

  @override
  String get wizardStufe5OptionAbVerifizierungTitle =>
      'Desde a aprovação do Vorstand';

  @override
  String get wizardStufe5OptionAbVerifizierungBody =>
      'A escolha mais simples. Sem quota retroativa.';

  @override
  String get wizardStufe5OptionGruendungsdatumTitle =>
      'Retroativo a 01.08.2025 (fundação)';

  @override
  String get wizardStufe5OptionGruendungsdatumBody =>
      'Contarás como membro desde o primeiro dia da associação.';

  @override
  String get wizardStufe5OptionAnderesDatumTitle => 'Outra data';

  @override
  String get wizardStufe5OptionAnderesDatumBody =>
      'Escolhes uma data entre 01.08.2025 e hoje.';

  @override
  String get wizardStufe5PickDate => 'Toca para escolher uma data';

  @override
  String get wizardStufe5PickDateFirst =>
      'Por favor escolhe primeiro uma data.';

  @override
  String get wizardStufe5DatePickerHelp => 'Início da adesão';

  @override
  String wizardStufe5DateRange(String start) {
    return 'Entre $start e hoje';
  }

  @override
  String get wizardStufe5RetroactiveTitle => 'Quota retroativa';

  @override
  String wizardStufe5RetroactiveBody(
      String start, String end, int months, String amount) {
    return 'De $start a $end são $months meses. A 25 €/mês são $amount € a pagar retroativamente, além da quota mensal atual.';
  }

  @override
  String get wizardStufe5FeeExemptTitle => 'Quota retroativa: 0 € 🎉';

  @override
  String get wizardStufe5FeeExemptBody =>
      'Com Bürgergeld ou Sozialamt estás totalmente isento — mesmo retroativamente, nada deves.';

  @override
  String wizardDocumentPrompt(String doc) {
    return 'Antes de terminarmos, por favor lê o $doc com atenção. É importante saberes o que assinas.';
  }

  @override
  String get wizardDocumentScrollHint => 'Desliza até ao fim para continuar.';

  @override
  String get wizardDocumentScrolledOk => 'Leste até ao fim ✓';

  @override
  String wizardDocumentOpenButton(String doc) {
    return 'Abrir $doc no navegador';
  }

  @override
  String get wizardDocumentExternalHint =>
      'Nesta plataforma abrimos o documento no teu navegador predefinido.';

  @override
  String get wizardDocumentOpenedOk =>
      'O documento foi aberto. Por favor lê-o com atenção.';

  @override
  String wizardDocumentConfirm(String doc) {
    return 'Confirmo que li e aceito o $doc.';
  }

  @override
  String get wizardFinalAdultTitle => 'Pronto! Estás inscrito 🎉';

  @override
  String get wizardFinalMinorTitle => 'O teu pedido foi enviado 📨';

  @override
  String get wizardFinalMinorBody =>
      'Contactaremos o teu progenitor e marcaremos um encontro (presencial ou videochamada). Por favor, tem paciência — o processo pode demorar até 7 dias. Receberás uma notificação na app assim que o teu progenitor aprovar.';

  @override
  String get wizardFinalMitgliedernummerLabel => 'O teu número de membro';

  @override
  String get wizardStufe4MethodComingSoon => 'Em breve';

  @override
  String get wizardStufe4StreichungWarning =>
      'Se atrasares mais de 6 meses na quota, vamos retirar-te automaticamente (Satzung §6 Abs. 3).';

  @override
  String get wizardStufe5KuendigungInfo =>
      'Para sair: envia-nos a renúncia por escrito 3 meses antes de 31 de dezembro (até 30 de setembro para fazer efeito no final do ano). Não há duração mínima (Satzung §6 Abs. 3).';

  @override
  String get wizardStufe1fEmailLabel => 'O teu email de membro';

  @override
  String get wizardStufe1fEmailHelper =>
      'Atribuído automaticamente a partir do teu número de membro. É ativado no momento em que a direção (Vorstand) valida a tua candidatura. Temos a nossa própria app de email — envia e recebe emails encriptados, simples e gratuito.';

  @override
  String get wizardErrInvalidEmail => 'Endereço de email inválido';

  @override
  String get wizardStufe3OptionAlg1 =>
      'Recebo Arbeitslosengeld I (ALG I, subsídio de desemprego)';

  @override
  String get wizardStufe3OptionKrankengeld =>
      'Recebo Krankengeld (subsídio de doença prolongada)';

  @override
  String get wizardStufe3UploadAddMore => 'Adicionar outro documento';

  @override
  String get wizardStufe3UploadLimitCount =>
      'Limite atingido: máximo 20 documentos.';

  @override
  String get wizardStufe3UploadLimitTotal =>
      'Limite total de 100 MB atingido. Apaga um ficheiro existente.';

  @override
  String get wizardStufe3UploadDeleteTooltip => 'Apagar';

  @override
  String wizardStufe3UploadCounter(int count, int max) {
    return '$count / $max documentos';
  }

  @override
  String get wizardDocumentExternalOpenFailed =>
      'Não foi possível abrir o navegador. O link foi copiado para a área de transferência — cola-o num navegador para continuar.';

  @override
  String get wizardFinalTimelineProcessing =>
      'Vorstand está a verificar · normalmente 1 dia útil, até 7';

  @override
  String get wizardFinalTimelineActivated => 'Conta ativada';

  @override
  String get wizardFinalAdultThank =>
      'Obrigado por preencheres o formulário de inscrição! 🎉';

  @override
  String get wizardFinalAdultUsual =>
      'O teu pedido está connosco. Normalmente validamo-lo num dia útil.';

  @override
  String get wizardFinalAdultExceptional =>
      'Por vezes pode demorar até 7 dias úteis. E se algo não bater certo, mandamos-te de volta ao formulário para corrigires 🙂';

  @override
  String get wizardFinalStatusTitle => 'ESTADO DO PEDIDO';

  @override
  String wizardFinalStatusStepsValidated(int reviewed, int total) {
    return '$reviewed/$total etapas validadas pelo Vorstand';
  }

  @override
  String get wizardFinalStufeSheetTitle => 'Detalhes do pedido';

  @override
  String get wizardFinalStufeSheetHint =>
      'As 8 fases que preencheste. O Vorstand verifica-as uma a uma — vês em tempo real o que foi validado.';

  @override
  String get wizardFinalStufeStatusPending => 'A aguardar verificação';

  @override
  String get wizardFinalStufeStatusApproved => 'Aprovado';

  @override
  String get wizardFinalStufeStatusRejected => 'Rejeitado';

  @override
  String wizardFinalStatusRejectionCount(int count) {
    return '$count etapa precisa de correção';
  }

  @override
  String get wizardFinalStufeRejectionReason => 'Motivo do Vorstand:';

  @override
  String get wizardFinalStufeCorrectNow => 'Corrigir agora';

  @override
  String wizardFinalApprovalsHeader(int current, int total) {
    return 'Aprovações do Vorstand ($current/$total)';
  }

  @override
  String get wizardFinalApprovalAwaiting => 'À espera do 2.º Vorstand';

  @override
  String get wizardFinalApprovalRejected => 'REJEITADO';

  @override
  String get wizardFinalStufeNoDataYet => 'Dados ainda não disponíveis.';

  @override
  String get wizardFinalStufeReadAt => 'Lido em:';

  @override
  String get wizardFinalStufeBeitragsfrei => 'Isento de quota (sem pagamento)';

  @override
  String get wizardFinalStufeNotExempt => 'Sem apoios sociais';

  @override
  String get wizardFinalStufeBeginAtVerification => 'Começa na verificação';

  @override
  String get wizardFinalStufeBeginAtFoundation =>
      'Data de fundação (retroativo)';

  @override
  String get wizardFinalStufeBeginAtCustom => 'Outra data';

  @override
  String get wizardFinalStufeStatusSkipped => 'Ignorado';

  @override
  String get wizardFinalStufeFilledAt => 'Preenchido:';

  @override
  String get wizardFinalStufeReviewedAt => 'Verificado:';

  @override
  String get wizardFinalWithdrawLink => 'Retirar pedido';

  @override
  String get wizardFinalWithdrawDialogTitle => 'Retirar o teu pedido?';

  @override
  String get wizardFinalWithdrawDialogBody =>
      'O teu pedido será marcado como retirado por ti. Os dados permanecem na base de dados para auditoria (RGPD), mas a conta não será ativada. Podes reiniciar o registo a qualquer momento com um novo número de membro.';

  @override
  String get wizardFinalWithdrawKeep => 'Não, vou esperar';

  @override
  String get wizardFinalWithdrawConfirm => 'Sim, retirar';

  @override
  String get wizardErrTooManyWithdrawals =>
      'O teu pedido não pode ser processado automaticamente. Liga-nos ou passa pessoalmente pelo Vorstand para continuar o registo.';

  @override
  String get wizardDuplicateLoginTitle => 'Parece que já és sócio';

  @override
  String get wizardDuplicateLoginBody =>
      'Com o teu nome e data de nascimento já encontramos uma conta ativa. Por favor, usa \'Já sou sócio\' no ecrã inicial para iniciar sessão. Se já não tens acesso, liga-nos.';

  @override
  String get wizardDuplicatePendingTitle => 'O teu pedido já está connosco';

  @override
  String get wizardDuplicatePendingBody =>
      'Com o teu nome e data de nascimento já temos um pedido em análise. O Vorstand está a tratar dele — avisamos-te na app assim que a tua conta estiver ativa. Liga-nos se quiseres conversar.';

  @override
  String get wizardDuplicateRecentlyWithdrawnTitle =>
      'Não conseguimos processar este pedido agora';

  @override
  String get wizardDuplicateRecentlyWithdrawnBody =>
      'O teu nome e data de nascimento coincidem com um pedido retirado recentemente. Por favor, liga-nos para falar com o Vorstand antes de continuares.';

  @override
  String get wizardDuplicatePreviouslyWithdrawnTitle =>
      'Já te candidataste antes';

  @override
  String get wizardDuplicatePreviouslyWithdrawnBody =>
      'O teu nome e data de nascimento coincidem com um pedido mais antigo que tinhas retirado. Bem-vindo de volta — por favor liga-nos antes de continuares para o Vorstand decidir como prosseguir.';

  @override
  String get wizardDuplicateCallUsTitle => 'Por favor, liga-nos';

  @override
  String get wizardDuplicateCallUsBody =>
      'O teu nome e data de nascimento já constam dos nossos registos, mas não podemos partilhar os detalhes através da app. Liga-nos — o Vorstand explicará a situação diretamente.';

  @override
  String get wizardChatHelp => 'Vamos falar';

  @override
  String get wizardChatHelpSubtitle =>
      'Chat ao vivo com o Vorstand · resposta rápida';

  @override
  String get benachrichtigungTitel => 'Lembretes por SMS';

  @override
  String get benachrichtigungIntro =>
      'Para que não perca nenhuma marcação, a associação pode enviar-lhe um SMS. É você que decide se e para quê — e pode alterá-lo a qualquer momento.';

  @override
  String get benachrichtigungTermineFrage =>
      'Deseja receber lembretes das suas marcações por SMS?';

  @override
  String get benachrichtigungTermineDetail =>
      'A mensagem contém a data, a hora, o local e o assunto da marcação.';

  @override
  String get benachrichtigungMedikamenteFrage =>
      'Deseja também ser lembrado dos seus medicamentos?';

  @override
  String get benachrichtigungMedikamenteDetail =>
      'Nesse caso, o nome do medicamento consta da mensagem. Trata-se de um dado de saúde — por isso perguntamos separadamente.';

  @override
  String get benachrichtigungHinweis =>
      'O lembrete é uma ajuda e não uma garantia: por favor, não confie apenas nele. Pode alterar isto a qualquer momento no seu perfil.';

  @override
  String get benachrichtigungJa => 'Sim';

  @override
  String get benachrichtigungNein => 'Não';

  @override
  String get benachrichtigungSpaeter => 'Decidir mais tarde';

  @override
  String get benachrichtigungSpeichern => 'Guardar';

  @override
  String get benachrichtigungGespeichert => 'Obrigado, guardado.';

  @override
  String get benachrichtigungenLeer => 'Sem notificações';

  @override
  String get benachrichtigungenAlleGelesen => 'Marcar tudo como lido';

  @override
  String get benachrichtigungWetterFrage =>
      'Deseja ser avisado em caso de mau tempo na sua área de residência?';

  @override
  String get benachrichtigungWetterDetail =>
      'Apenas avisos oficiais do Serviço Meteorológico Alemão a partir do nível «forte» — não em cada chuva.';

  @override
  String get signaturTitel => 'Assinaturas';

  @override
  String get signaturNichtsOffen => 'De momento, não há nada para assinar.';

  @override
  String get signaturStatusOffen => 'À espera da sua assinatura';

  @override
  String get signaturStatusSigniert => 'Assinado por si';

  @override
  String get signaturStatusAbgelehnt => 'Recusado por si';

  @override
  String get signaturStatusWiderrufen => 'Retirado pela associação';

  @override
  String get signaturStatusAbgelaufen => 'Prazo expirado';

  @override
  String signaturBitteGanzLesen(int gelesen, int gesamt) {
    return 'Por favor, leia o documento até ao fim (página $gelesen de $gesamt).';
  }

  @override
  String get signaturWeiterZurUnterschrift => 'Continuar para assinar';

  @override
  String get signaturAblehnen => 'Recusar';

  @override
  String get signaturAblehnenHinweis =>
      'A associação será informada. Pode indicar os seus motivos.';

  @override
  String get signaturAblehnenGrund => 'Motivo (opcional)';

  @override
  String get signaturMitFingerHinweis => 'Assine com o dedo no campo branco.';

  @override
  String get signaturNochmal => 'Repetir';

  @override
  String get signaturZurueckZumDokument => 'Voltar ao documento';

  @override
  String get signaturCodeAnfordern => 'Pedir código por SMS';

  @override
  String get signaturCodeUnterwegs => 'O código está a caminho.';

  @override
  String signaturCodeGesendetAn(String nummer) {
    return 'Enviámos-lhe um código para $nummer.';
  }

  @override
  String get signaturCodeErneutSenden => 'Reenviar código';

  @override
  String get signaturJetztUnterschreiben => 'Assinar agora';

  @override
  String get signaturCodeFalsch => 'O código não está correto.';

  @override
  String get signaturCodeAbgelaufen =>
      'O código expirou. Por favor, peça um novo.';

  @override
  String get signaturZuVieleVersuche =>
      'Demasiadas tentativas falhadas. Por favor, peça um novo código.';

  @override
  String get signaturKeineRufnummer =>
      'Não temos nenhum número de telemóvel registado na sua conta. Sem ele não lhe podemos enviar um código — por favor, contacte o presidente da associação.';

  @override
  String get signaturCodeFehlgeschlagen => 'Não foi possível enviar o código.';

  @override
  String get signaturLeer => 'Por favor, assine primeiro.';

  @override
  String get signaturErfolg => 'Obrigado — recebemos a sua assinatura.';

  @override
  String get signaturFehlgeschlagen =>
      'Algo correu mal. Por favor, tente novamente.';

  @override
  String get signaturSiegelInArbeit =>
      'O documento selado ainda está a ser preparado. Por favor, tente novamente dentro de um minuto.';

  @override
  String get signaturWartetZweiteUnterschrift =>
      'À espera da segunda assinatura';

  @override
  String get signaturWartenHinweis =>
      'Já assinou. O documento será selado assim que a segunda pessoa também tiver assinado.';

  @override
  String get kontaktNochAktuell => 'Estes dados ainda estão corretos?';

  @override
  String get kontaktWarumFragen =>
      'Para que não perca nada, perguntamos brevemente a cada três meses. Receberá um código de seis dígitos.';

  @override
  String kontaktBestaetigtAm(Object datum) {
    return 'confirmado em $datum';
  }

  @override
  String get kontaktFestnetzKeinSms =>
      'Este é um número fixo — não chega nenhum SMS.';

  @override
  String get kontaktIstAndersGeworden => 'Foi alterado';

  @override
  String get themeTitle => 'Aparência';

  @override
  String get themeLight => 'Claro';

  @override
  String get themeDark => 'Escuro';

  @override
  String get themeSystem => 'Seguir o dispositivo';

  @override
  String get themeSchedule => 'Automático (20:00–06:00)';

  @override
  String get themeScheduleHint =>
      'Escuro das 20:00 às 6:00, claro no resto do dia.';
}
