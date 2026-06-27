// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class SPt extends S {
  SPt([String locale = 'pt']) : super(locale);

  @override
  String get appName => 'DoCMind AI';

  @override
  String get appTagline => 'OCR, Documentos e Resumo por IA';

  @override
  String get navHome => 'Início';

  @override
  String get navHistory => 'Histórico';

  @override
  String get navSettings => 'Definições';

  @override
  String get addDocument => 'Adicionar documento';

  @override
  String get optionDocument => 'Documento';

  @override
  String get optionDocumentSub => 'PDF, Word ou outros ficheiros';

  @override
  String get optionGallery => 'Galeria';

  @override
  String get optionGallerySub => 'Escolher da biblioteca de fotos';

  @override
  String get optionCamera => 'Câmara';

  @override
  String get optionCameraSub => 'Tirar uma foto';

  @override
  String get greeting => 'Olá';

  @override
  String get planPro => 'Pro';

  @override
  String get planProPlus => 'Pro+';

  @override
  String get planFree => 'Grátis';

  @override
  String get quickActions => 'Ações rápidas';

  @override
  String get recentDocuments => 'Documentos recentes';

  @override
  String get upload => 'Carregar';

  @override
  String get uploadFormats => 'PDF, DOCX, Imagem';

  @override
  String get history => 'Histórico';

  @override
  String get viewAllDocs => 'Ver todos os documentos';

  @override
  String get seeAll => 'Ver tudo';

  @override
  String get noDocumentsYet => 'Ainda sem documentos';

  @override
  String get uploadFirstDoc =>
      'Carregue o seu primeiro documento e deixe a IA resumir para si';

  @override
  String get uploadDocument => 'Carregar documento';

  @override
  String get premiumActive => 'Premium ativo';

  @override
  String get unlimitedDocsSummaries => 'Documentos e resumos ilimitados';

  @override
  String get freePlan => 'Plano gratuito';

  @override
  String get noFreeDocsLeft => 'Sem documentos gratuitos restantes';

  @override
  String freeLeftCount(int count) {
    return '$count gratuitos restantes';
  }

  @override
  String get upgradeForUnlimited => 'Atualize para acesso ilimitado';

  @override
  String freeDocsUsed(int used, int limit) {
    return '$used de $limit documentos gratuitos utilizados';
  }

  @override
  String get upgrade => 'Atualizar';

  @override
  String get failed => 'Falhou';

  @override
  String minAgo(int count) {
    return 'há $count min';
  }

  @override
  String hoursAgo(int count) {
    return 'há ${count}h';
  }

  @override
  String get yesterday => 'Ontem';

  @override
  String daysAgo(int count) {
    return 'há $count dias';
  }

  @override
  String get clearFilters => 'Limpar filtros';

  @override
  String get documentDeleted => 'Documento eliminado';

  @override
  String get noDocumentsFiltered => 'Nenhum documento encontrado';

  @override
  String get tryRemovingFilters =>
      'Tente remover os filtros ou carregar\nnovos documentos';

  @override
  String get clearFiltersButton => 'Limpar filtros';

  @override
  String get deleteDocument => 'Eliminar documento';

  @override
  String get deleteDocumentConfirm =>
      'Tem a certeza que deseja eliminar este documento?';

  @override
  String get deleteDocumentConfirmFull =>
      'Tem a certeza que deseja eliminar este documento? Esta ação não pode ser desfeita.';

  @override
  String get cancel => 'Cancelar';

  @override
  String get delete => 'Eliminar';

  @override
  String get allDocuments => 'Todos os documentos';

  @override
  String get pdfOnly => 'Apenas PDF';

  @override
  String get wordOnly => 'Apenas Word';

  @override
  String get imagesOnly => 'Apenas imagens';

  @override
  String get settings => 'Definições';

  @override
  String get proMember => 'Membro Pro';

  @override
  String get proPlusMember => 'Membro Pro+';

  @override
  String get unlimitedAccess => 'Acesso ilimitado';

  @override
  String get upgradeForMoreFeatures => 'Atualize para mais funcionalidades';

  @override
  String get preferences => 'Preferências';

  @override
  String get support => 'Suporte';

  @override
  String get account => 'Conta';

  @override
  String get notifications => 'Notificações';

  @override
  String get darkMode => 'Modo escuro';

  @override
  String get appLanguage => 'Idioma da app';

  @override
  String get summaryLanguage => 'Idioma do resumo';

  @override
  String get helpFaq => 'Ajuda e FAQ';

  @override
  String get rateApp => 'Avaliar app';

  @override
  String get rateAppSub => 'Gosta do DoCMind AI? Avalie-nos!';

  @override
  String get privacyPolicy => 'Política de privacidade';

  @override
  String get termsOfService => 'Termos de serviço';

  @override
  String get restorePurchases => 'Restaurar compras';

  @override
  String get signOut => 'Terminar sessão';

  @override
  String get deleteAccount => 'Eliminar conta';

  @override
  String get deleteAccountConfirm =>
      'Tem a certeza que deseja eliminar a sua conta? Esta ação não pode ser desfeita.';

  @override
  String get deleteAccountTitle => 'Eliminar conta?';

  @override
  String get deleteAccountSuccess => 'Your data has been deleted successfully.';

  @override
  String get deleteAccountFailed =>
      'Could not delete your data. Please try again.';

  @override
  String get signOutConfirm => 'Are you sure you want to sign out?';

  @override
  String get subscriptionLegalDisclosure =>
      'Payment will be charged to your Apple ID account at confirmation of purchase. Subscription automatically renews unless it is canceled at least 24 hours before the end of the current period. Your account will be charged for renewal within 24 hours prior to the end of the current period. You can manage and cancel subscriptions in your App Store account settings.';

  @override
  String get manageInAppStore => 'Manage in App Store';

  @override
  String get pricesLoading => 'Loading prices...';

  @override
  String appVersion(String version) {
    return 'DoCMind AI v$version';
  }

  @override
  String whatsNew(String version) {
    return 'Novidades na v$version';
  }

  @override
  String get ok => 'OK';

  @override
  String get document => 'Documento';

  @override
  String get failedToLoadDocument => 'Falha ao carregar documento';

  @override
  String get tryAgain => 'Tentar novamente';

  @override
  String get documentNotFound => 'Documento não encontrado';

  @override
  String get loadingPdf => 'A carregar PDF...';

  @override
  String get loadingPreview => 'A carregar pré-visualização do documento...';

  @override
  String showingPage(int count) {
    return 'A mostrar página 1 de $count';
  }

  @override
  String get documentContent => 'Conteúdo do documento';

  @override
  String get noContentExtracted => 'Ainda sem conteúdo extraído';

  @override
  String get previewNotAvailable => 'Pré-visualização não disponível';

  @override
  String get viewSummary => 'Ver resumo';

  @override
  String get generating => 'A gerar...';

  @override
  String get generateAiSummary => 'Gerar resumo por IA';

  @override
  String pagesCount(int count) {
    return '$count páginas';
  }

  @override
  String get uploadDocumentTitle => 'Carregar documento';

  @override
  String get tipReading => 'A IA está a ler o seu documento...';

  @override
  String get tipExtracting => 'A extrair informações-chave...';

  @override
  String get tipIdentifying => 'A identificar secções importantes...';

  @override
  String get tipBuilding => 'A construir um resumo estruturado...';

  @override
  String get tipFinalizing => 'Quase lá, a finalizar resultados...';

  @override
  String get stepUploading => 'A carregar';

  @override
  String get stepExtractingText => 'A extrair texto';

  @override
  String get stepAiAnalyzing => 'Análise por IA';

  @override
  String get summaryLang => 'Idioma do resumo';

  @override
  String uploadingProgress(int percent) {
    return 'A carregar o seu documento... $percent%';
  }

  @override
  String get extractingText => 'A extrair texto do seu documento...';

  @override
  String get aiAnalyzing => 'A IA está a analisar e resumir...';

  @override
  String get preparing => 'A preparar...';

  @override
  String get tapToUpload => 'Toque para carregar um documento';

  @override
  String supportedFormats(int size) {
    return 'PDF, DOCX, JPG, PNG até ${size}MB';
  }

  @override
  String get aiWillExtract => 'A IA irá extrair e resumir o conteúdo';

  @override
  String get freeLimitReached =>
      'Limite gratuito atingido. Atualize para continuar';

  @override
  String get readyToProcess => 'Pronto para processar';

  @override
  String get chooseDifferentFile => 'Escolher outro ficheiro';

  @override
  String get selectedFile => 'Ficheiro selecionado';

  @override
  String get generateSummary => 'Gerar resumo';

  @override
  String freePlanFileLimit(int size) {
    return 'Limite do plano gratuito: máx. ${size}MB por ficheiro. Atualize para carregar documentos maiores.';
  }

  @override
  String fileSizeExceeded(int size) {
    return 'O tamanho do ficheiro excede o limite do seu plano (máx. ${size}MB). Atualize para ficheiros maiores.';
  }

  @override
  String get freeLimitReachedTitle => 'Limite gratuito atingido';

  @override
  String get freeLimitReachedMsg =>
      'Utilizou todos os seus documentos gratuitos. Atualize para Pro para acesso ilimitado!';

  @override
  String get maybeLater => 'Talvez mais tarde';

  @override
  String get upgradeNow => 'Atualizar agora';

  @override
  String get summary => 'Resumo';

  @override
  String get failedToLoadSummary => 'Falha ao carregar resumo';

  @override
  String get summaryNotFound => 'Resumo não encontrado';

  @override
  String get overview => 'Visão geral';

  @override
  String get keyPoints => 'Pontos-chave';

  @override
  String get actionItems => 'Ações a realizar';

  @override
  String get keywords => 'Palavras-chave';

  @override
  String get importantFacts => 'Factos importantes';

  @override
  String get obligations => 'Obrigações';

  @override
  String get risks => 'Riscos';

  @override
  String get findings => 'Conclusões';

  @override
  String wordsCount(int count) {
    return '$count palavras';
  }

  @override
  String processingTime(String seconds) {
    return '${seconds}s';
  }

  @override
  String get viewOriginalDocument => 'Ver documento original';

  @override
  String get copySummary => 'Copiar resumo';

  @override
  String get summaryCopied => 'Resumo copiado para a área de transferência';

  @override
  String get generatedBy => 'Gerado por DoCMind AI';

  @override
  String wordCountLabel(int count) {
    return 'Contagem de palavras: $count';
  }

  @override
  String processingTimeLabel(String seconds) {
    return 'Tempo de processamento: ${seconds}s';
  }

  @override
  String get upgradeRequired => 'Atualização necessária';

  @override
  String get translateProOnly =>
      'A tradução está disponível nos planos Pro. Atualize para traduzir resumos.';

  @override
  String get notNow => 'Agora não';

  @override
  String get manageSubscription => 'Gerir subscrição';

  @override
  String get changeYourPlan => 'Alterar plano';

  @override
  String get unlockPremium => 'Desbloquear Premium';

  @override
  String get upgradeOrSwitch => 'Atualizar ou mudar para outro plano';

  @override
  String get getUnlimitedAccess =>
      'Obtenha acesso ilimitado a todas as funcionalidades';

  @override
  String get monthly => 'Mensal';

  @override
  String get yearly => 'Anual';

  @override
  String get save40 => 'POUPE 40%';

  @override
  String get unlimitedDocuments => 'Documentos ilimitados';

  @override
  String get unlimitedSummaries => 'Resumos ilimitados';

  @override
  String get priorityAiProcessing => 'Processamento prioritário por IA';

  @override
  String get exportToPdf => 'Exportar para PDF';

  @override
  String get emailSupport => 'Suporte por email';

  @override
  String get everythingInPro => 'Tudo o que está no Pro';

  @override
  String get ocrScannedDocs => 'OCR para documentos digitalizados';

  @override
  String get longDocSupport => 'Suporte para documentos longos (100+ páginas)';

  @override
  String get advancedAiAnalysis => 'Análise avançada por IA';

  @override
  String get prioritySupport => 'Suporte prioritário';

  @override
  String get earlyAccess => 'Acesso antecipado a funcionalidades';

  @override
  String get freePlanInfo =>
      'O plano gratuito inclui 2 documentos com até 5 páginas cada.';

  @override
  String get restoring => 'A restaurar...';

  @override
  String get current => 'ATUAL';

  @override
  String get popular => 'POPULAR';

  @override
  String get perYear => '/ano';

  @override
  String get perMonth => '/mês';

  @override
  String get billedAnnually => 'Faturado anualmente';

  @override
  String thatsOnly(String price) {
    return 'Apenas $price/mês';
  }

  @override
  String get getPro => 'Obter Pro';

  @override
  String get getProPlus => 'Obter Pro+';

  @override
  String get currentPlan => 'Plano atual';

  @override
  String get switchToYearly => 'Mudar para anual';

  @override
  String get switchToMonthly => 'Mudar para mensal';

  @override
  String get upgradeToPro => 'Atualizar para Pro';

  @override
  String get upgradeToProPlus => 'Atualizar para Pro+';

  @override
  String get downgradeToPro => 'Fazer downgrade para Pro';

  @override
  String get downgradeToProPlus => 'Fazer downgrade para Pro+';

  @override
  String get changesAtEnd => 'Alterações no fim do período de faturação';

  @override
  String autoRenews(String date) {
    return 'Renovação automática $date';
  }

  @override
  String expires(String date) {
    return 'Expira $date';
  }

  @override
  String get soon => 'em breve';

  @override
  String get active => 'ATIVO';

  @override
  String get downgradePlan => 'Fazer downgrade do plano';

  @override
  String get downgradeConfirm =>
      'O seu plano será reduzido no fim do período de faturação atual. Manterá as funcionalidades atuais até lá.';

  @override
  String get confirmDowngrade => 'Confirmar downgrade';

  @override
  String get welcomeBack => 'Bem-vindo de volta';

  @override
  String get signInContinue => 'Inicie sessão para continuar no DoCMind AI';

  @override
  String get createAccountToStart => 'Crie a sua conta para começar';

  @override
  String get emailAddress => 'Endereço de email';

  @override
  String get password => 'Palavra-passe';

  @override
  String get enterEmail => 'Introduza o seu email';

  @override
  String get validEmail => 'Introduza um email válido';

  @override
  String get enterPassword => 'Introduza a sua palavra-passe';

  @override
  String get passwordMinLength =>
      'A palavra-passe deve ter pelo menos 8 caracteres';

  @override
  String get signIn => 'Iniciar sessão';

  @override
  String get createAccount => 'Criar conta';

  @override
  String get orContinueWith => 'ou continuar com';

  @override
  String get continueWithApple => 'Continuar com Apple';

  @override
  String get tryWithoutAccount => 'Experimentar sem conta';

  @override
  String get noAccount => 'Não tem conta? ';

  @override
  String get haveAccount => 'Já tem conta? ';

  @override
  String get signUp => 'Registar';

  @override
  String get tryDoCMindAi => 'Experimentar DoCMind AI';

  @override
  String trialsLeft(int count) {
    return '$count experiência(s) restante(s)';
  }

  @override
  String get noTrialsRemaining => 'Sem experiências restantes';

  @override
  String get summarizeNow => 'Resumir agora';

  @override
  String get analyzingDocument => 'A analisar o seu documento...';

  @override
  String get thisMayTakeAMoment => 'Isto pode demorar um momento';

  @override
  String get guestModeLimitations => 'Limitações do modo convidado';

  @override
  String get maxPagesGuest => 'Máx. 2 páginas por documento';

  @override
  String get twoTrialsOnly => 'Apenas 2 experiências no total (sem reset)';

  @override
  String get notSavedToHistory => 'Resumo não guardado no histórico';

  @override
  String get noCloudSync => 'Sem sincronização na nuvem';

  @override
  String get withFreeAccount => 'Com uma conta gratuita obtém:';

  @override
  String get upToFivePages => 'Até 5 páginas por documento';

  @override
  String get threeDocsPerDay => '3 documentos por dia';

  @override
  String get historySavedForever => 'Histórico guardado para sempre';

  @override
  String get cloudSyncDevices => 'Sincronização na nuvem entre dispositivos';

  @override
  String get wantUnlimitedAccess => 'Quer acesso ilimitado?';

  @override
  String get createFreeForMore =>
      'Crie uma conta gratuita para mais funcionalidades';

  @override
  String get createFreeAccount => 'Criar conta gratuita';

  @override
  String get selectDocSource => 'Selecionar origem do documento';

  @override
  String get browseFiles => 'Procurar ficheiros';

  @override
  String get pdfWordDocs => 'PDF, documentos Word';

  @override
  String get takePhoto => 'Tirar foto';

  @override
  String get captureDocCamera => 'Capturar documento com a câmara';

  @override
  String get photoLibrary => 'Biblioteca de fotos';

  @override
  String get selectFromGallery => 'Selecionar da galeria';

  @override
  String get fileTooLargeGuest =>
      'Ficheiro demasiado grande. Máximo 5MB no modo convidado.';

  @override
  String get failedPickFile => 'Falha ao selecionar ficheiro';

  @override
  String get failedCapturePhoto => 'Falha ao capturar foto';

  @override
  String get failedPickImage => 'Falha ao selecionar imagem';

  @override
  String get trialLimitReached => 'Limite de experiências atingido';

  @override
  String get trialLimitMsg =>
      'Utilizou todas as suas experiências gratuitas. Crie uma conta para continuar a usar o DoCMind AI com acesso ilimitado.';

  @override
  String get noSummaryAvailable => 'Nenhum resumo disponível';

  @override
  String get summaryNotSaved =>
      'Este resumo não será guardado. Crie uma conta para o conservar!';

  @override
  String get documentSummary => 'Resumo do documento';

  @override
  String get noOverviewAvailable => 'Nenhuma visão geral disponível';

  @override
  String moreKeyPoints(int count) {
    return '$count mais pontos-chave';
  }

  @override
  String itemsCount(int count) {
    return '$count itens';
  }

  @override
  String get createFreeToUnlock => 'Criar conta gratuita para desbloquear';

  @override
  String trialsRemaining(int count) {
    return '$count experiências restantes';
  }

  @override
  String get createAccountContinue =>
      'Crie uma conta para continuar a usar o DoCMind AI';

  @override
  String get createAccountUnlimited => 'Crie uma conta para resumos ilimitados';

  @override
  String get close => 'Fechar';

  @override
  String get processingFailed =>
      'O processamento do documento falhou. Por favor, tente novamente.';

  @override
  String get processingTakingLong =>
      'O processamento está a demorar mais do que o esperado. Verifique o Histórico para o estado.';

  @override
  String get translating => 'Traduzindo';

  @override
  String get aiTranslatingYourSummary => 'A IA está traduzindo seu resumo';

  @override
  String get translationComplete => 'Tradução concluída';

  @override
  String translatedTo(String language) {
    return 'Traduzido para $language';
  }

  @override
  String originalLanguage(String language) {
    return 'Original: $language';
  }

  @override
  String generatedOn(String date) {
    return 'Gerado em $date';
  }

  @override
  String get pleaseWait => 'Aguarde';

  @override
  String get updateRequired => 'Atualização necessária';

  @override
  String get updateRequiredMsg =>
      'Uma nova versão do DoCMind AI está disponível. Atualize para continuar usando o aplicativo.';

  @override
  String get updateNow => 'Atualizar agora';

  @override
  String get onboardingUploadTitle => 'Enviar documentos';

  @override
  String get onboardingUploadDesc =>
      'Envie seus PDFs, DOCX ou imagens e deixe a IA fazer o resto. Obtenha resumos em segundos.';

  @override
  String get onboardingSummaryTitle => 'Resumos com IA';

  @override
  String get onboardingSummaryDesc =>
      'Obtenha instantaneamente pontos-chave, tarefas e destaques de qualquer documento.';

  @override
  String get onboardingTranslateTitle => 'Traduzir resumos';

  @override
  String get onboardingTranslateDesc =>
      'Traduza seus resumos para mais de 13 idiomas com um único toque.';

  @override
  String get onboardingShareTitle => 'Compartilhar de qualquer app';

  @override
  String get onboardingShareDesc =>
      'Envie arquivos diretamente do WhatsApp, Telegram ou qualquer app para resumos instantâneos.';

  @override
  String get onboardingHistoryTitle => 'Histórico e filtros';

  @override
  String get onboardingHistoryDesc =>
      'Todos os seus documentos organizados em um só lugar. Filtre por PDF, Word ou imagens.';

  @override
  String get onboardingCopyShareTitle => 'Copiar e Compartilhar';

  @override
  String get onboardingCopyShareDesc =>
      'Copie seus resumos para a área de transferência ou compartilhe-os pelos seus aplicativos favoritos.';

  @override
  String get tutorial => 'Tutorial';

  @override
  String get onboardingSkip => 'Pular';

  @override
  String get onboardingNext => 'Próximo';

  @override
  String get onboardingGetStarted => 'Começar';
}
