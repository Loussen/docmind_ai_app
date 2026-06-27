// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class SIt extends S {
  SIt([String locale = 'it']) : super(locale);

  @override
  String get appName => 'DoCMind AI';

  @override
  String get appTagline => 'OCR, Documenti e Riepilogo AI';

  @override
  String get navHome => 'Home';

  @override
  String get navHistory => 'Cronologia';

  @override
  String get navSettings => 'Impostazioni';

  @override
  String get addDocument => 'Aggiungi documento';

  @override
  String get optionDocument => 'Documento';

  @override
  String get optionDocumentSub => 'PDF, Word o altri file';

  @override
  String get optionGallery => 'Galleria';

  @override
  String get optionGallerySub => 'Scegli dalla libreria foto';

  @override
  String get optionCamera => 'Fotocamera';

  @override
  String get optionCameraSub => 'Scatta una foto';

  @override
  String get greeting => 'Ciao';

  @override
  String get planPro => 'Pro';

  @override
  String get planProPlus => 'Pro+';

  @override
  String get planFree => 'Gratuito';

  @override
  String get quickActions => 'Azioni rapide';

  @override
  String get recentDocuments => 'Documenti recenti';

  @override
  String get upload => 'Carica';

  @override
  String get uploadFormats => 'PDF, DOCX, Immagine';

  @override
  String get history => 'Cronologia';

  @override
  String get viewAllDocs => 'Visualizza tutti i documenti';

  @override
  String get seeAll => 'Vedi tutto';

  @override
  String get noDocumentsYet => 'Nessun documento ancora';

  @override
  String get uploadFirstDoc =>
      'Carica il tuo primo documento e lascia che l\'AI lo riassuma per te';

  @override
  String get uploadDocument => 'Carica documento';

  @override
  String get premiumActive => 'Premium attivo';

  @override
  String get unlimitedDocsSummaries => 'Documenti e riepiloghi illimitati';

  @override
  String get freePlan => 'Piano gratuito';

  @override
  String get noFreeDocsLeft => 'Nessun documento gratuito rimasto';

  @override
  String freeLeftCount(int count) {
    return '$count gratuiti rimasti';
  }

  @override
  String get upgradeForUnlimited =>
      'Passa a un piano superiore per accesso illimitato';

  @override
  String freeDocsUsed(int used, int limit) {
    return '$used di $limit documenti gratuiti utilizzati';
  }

  @override
  String get upgrade => 'Passa a un piano superiore';

  @override
  String get failed => 'Fallito';

  @override
  String minAgo(int count) {
    return '$count min fa';
  }

  @override
  String hoursAgo(int count) {
    return '${count}h fa';
  }

  @override
  String get yesterday => 'Ieri';

  @override
  String daysAgo(int count) {
    return '$count giorni fa';
  }

  @override
  String get clearFilters => 'Cancella filtri';

  @override
  String get documentDeleted => 'Documento eliminato';

  @override
  String get noDocumentsFiltered => 'Nessun documento trovato';

  @override
  String get tryRemovingFilters =>
      'Prova a rimuovere i filtri o a caricare\nnuovi documenti';

  @override
  String get clearFiltersButton => 'Cancella filtri';

  @override
  String get deleteDocument => 'Elimina documento';

  @override
  String get deleteDocumentConfirm =>
      'Sei sicuro di voler eliminare questo documento?';

  @override
  String get deleteDocumentConfirmFull =>
      'Sei sicuro di voler eliminare questo documento? Questa azione non può essere annullata.';

  @override
  String get cancel => 'Annulla';

  @override
  String get delete => 'Elimina';

  @override
  String get allDocuments => 'Tutti i documenti';

  @override
  String get pdfOnly => 'Solo PDF';

  @override
  String get wordOnly => 'Solo Word';

  @override
  String get imagesOnly => 'Solo immagini';

  @override
  String get settings => 'Impostazioni';

  @override
  String get proMember => 'Membro Pro';

  @override
  String get proPlusMember => 'Membro Pro+';

  @override
  String get unlimitedAccess => 'Accesso illimitato';

  @override
  String get upgradeForMoreFeatures =>
      'Passa a un piano superiore per più funzionalità';

  @override
  String get preferences => 'Preferenze';

  @override
  String get support => 'Supporto';

  @override
  String get account => 'Account';

  @override
  String get notifications => 'Notifiche';

  @override
  String get darkMode => 'Modalità scura';

  @override
  String get appLanguage => 'Lingua dell\'app';

  @override
  String get summaryLanguage => 'Lingua del riepilogo';

  @override
  String get helpFaq => 'Aiuto e FAQ';

  @override
  String get rateApp => 'Valuta l\'app';

  @override
  String get rateAppSub => 'Ti piace DoCMind AI? Valutaci!';

  @override
  String get privacyPolicy => 'Informativa sulla privacy';

  @override
  String get termsOfService => 'Termini di servizio';

  @override
  String get restorePurchases => 'Ripristina acquisti';

  @override
  String get signOut => 'Esci';

  @override
  String get deleteAccount => 'Elimina account';

  @override
  String get deleteAccountConfirm =>
      'Sei sicuro di voler eliminare il tuo account? Questa azione non può essere annullata.';

  @override
  String get deleteAccountTitle => 'Eliminare l\'account?';

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
    return 'Novità in v$version';
  }

  @override
  String get ok => 'OK';

  @override
  String get document => 'Documento';

  @override
  String get failedToLoadDocument => 'Impossibile caricare il documento';

  @override
  String get tryAgain => 'Riprova';

  @override
  String get documentNotFound => 'Documento non trovato';

  @override
  String get loadingPdf => 'Caricamento PDF...';

  @override
  String get loadingPreview => 'Caricamento anteprima documento...';

  @override
  String showingPage(int count) {
    return 'Pagina 1 di $count';
  }

  @override
  String get documentContent => 'Contenuto del documento';

  @override
  String get noContentExtracted => 'Nessun contenuto estratto ancora';

  @override
  String get previewNotAvailable => 'Anteprima non disponibile';

  @override
  String get viewSummary => 'Visualizza riepilogo';

  @override
  String get generating => 'Generazione in corso...';

  @override
  String get generateAiSummary => 'Genera riepilogo AI';

  @override
  String pagesCount(int count) {
    return '$count pagine';
  }

  @override
  String get uploadDocumentTitle => 'Carica documento';

  @override
  String get tipReading => 'L\'AI sta leggendo il tuo documento...';

  @override
  String get tipExtracting => 'Estrazione delle informazioni chiave...';

  @override
  String get tipIdentifying => 'Identificazione delle sezioni importanti...';

  @override
  String get tipBuilding => 'Creazione di un riepilogo strutturato...';

  @override
  String get tipFinalizing => 'Quasi fatto, finalizzazione dei risultati...';

  @override
  String get stepUploading => 'Caricamento';

  @override
  String get stepExtractingText => 'Estrazione testo';

  @override
  String get stepAiAnalyzing => 'Analisi AI';

  @override
  String get summaryLang => 'Lingua del riepilogo';

  @override
  String uploadingProgress(int percent) {
    return 'Caricamento del documento... $percent%';
  }

  @override
  String get extractingText => 'Estrazione del testo dal documento...';

  @override
  String get aiAnalyzing => 'L\'AI sta analizzando e riassumendo...';

  @override
  String get preparing => 'Preparazione...';

  @override
  String get tapToUpload => 'Tocca per caricare un documento';

  @override
  String supportedFormats(int size) {
    return 'PDF, DOCX, JPG, PNG fino a ${size}MB';
  }

  @override
  String get aiWillExtract => 'L\'AI estrarrà e riassumerà il contenuto';

  @override
  String get freeLimitReached =>
      'Limite gratuito raggiunto. Passa a un piano superiore per continuare';

  @override
  String get readyToProcess => 'Pronto per l\'elaborazione';

  @override
  String get chooseDifferentFile => 'Scegli un altro file';

  @override
  String get selectedFile => 'File selezionato';

  @override
  String get generateSummary => 'Genera riepilogo';

  @override
  String freePlanFileLimit(int size) {
    return 'Limite piano gratuito: max ${size}MB per file. Passa a un piano superiore per caricare documenti più grandi.';
  }

  @override
  String fileSizeExceeded(int size) {
    return 'Dimensione file superiore al limite del tuo piano (max ${size}MB). Passa a un piano superiore per file più grandi.';
  }

  @override
  String get freeLimitReachedTitle => 'Limite gratuito raggiunto';

  @override
  String get freeLimitReachedMsg =>
      'Hai utilizzato tutti i documenti gratuiti. Passa a Pro per accesso illimitato!';

  @override
  String get maybeLater => 'Forse più tardi';

  @override
  String get upgradeNow => 'Passa ora';

  @override
  String get summary => 'Riepilogo';

  @override
  String get failedToLoadSummary => 'Impossibile caricare il riepilogo';

  @override
  String get summaryNotFound => 'Riepilogo non trovato';

  @override
  String get overview => 'Panoramica';

  @override
  String get keyPoints => 'Punti chiave';

  @override
  String get actionItems => 'Azioni da fare';

  @override
  String get keywords => 'Parole chiave';

  @override
  String get importantFacts => 'Fatti importanti';

  @override
  String get obligations => 'Obblighi';

  @override
  String get risks => 'Rischi';

  @override
  String get findings => 'Risultati';

  @override
  String wordsCount(int count) {
    return '$count parole';
  }

  @override
  String processingTime(String seconds) {
    return '${seconds}s';
  }

  @override
  String get viewOriginalDocument => 'Visualizza documento originale';

  @override
  String get copySummary => 'Copia riepilogo';

  @override
  String get summaryCopied => 'Riepilogo copiato negli appunti';

  @override
  String get generatedBy => 'Generato da DoCMind AI';

  @override
  String wordCountLabel(int count) {
    return 'Conteggio parole: $count';
  }

  @override
  String processingTimeLabel(String seconds) {
    return 'Tempo di elaborazione: ${seconds}s';
  }

  @override
  String get upgradeRequired => 'Upgrade richiesto';

  @override
  String get translateProOnly =>
      'La traduzione è disponibile sui piani Pro. Passa a un piano superiore per tradurre i riepiloghi.';

  @override
  String get notNow => 'Non ora';

  @override
  String get manageSubscription => 'Gestisci abbonamento';

  @override
  String get changeYourPlan => 'Cambia piano';

  @override
  String get unlockPremium => 'Sblocca Premium';

  @override
  String get upgradeOrSwitch => 'Passa o cambia piano';

  @override
  String get getUnlimitedAccess =>
      'Ottieni accesso illimitato a tutte le funzionalità';

  @override
  String get monthly => 'Mensile';

  @override
  String get yearly => 'Annuale';

  @override
  String get save40 => 'RISPARMIA 40%';

  @override
  String get unlimitedDocuments => 'Documenti illimitati';

  @override
  String get unlimitedSummaries => 'riepiloghi illimitati';

  @override
  String get priorityAiProcessing => 'Elaborazione AI prioritaria';

  @override
  String get exportToPdf => 'Esporta in PDF';

  @override
  String get emailSupport => 'Supporto via email';

  @override
  String get everythingInPro => 'Tutto ciò che è in Pro';

  @override
  String get ocrScannedDocs => 'OCR per documenti scansionati';

  @override
  String get longDocSupport => 'Supporto documenti lunghi (100+ pagine)';

  @override
  String get advancedAiAnalysis => 'Analisi AI avanzata';

  @override
  String get prioritySupport => 'Supporto prioritario';

  @override
  String get earlyAccess => 'Accesso anticipato alle funzionalità';

  @override
  String get freePlanInfo =>
      'Il piano gratuito include 2 documenti con massimo 5 pagine ciascuno.';

  @override
  String get restoring => 'Ripristino in corso...';

  @override
  String get current => 'ATTUALE';

  @override
  String get popular => 'POPOLARE';

  @override
  String get perYear => '/anno';

  @override
  String get perMonth => '/mese';

  @override
  String get billedAnnually => 'Fatturato annualmente';

  @override
  String thatsOnly(String price) {
    return 'Solo $price/mese';
  }

  @override
  String get getPro => 'Ottieni Pro';

  @override
  String get getProPlus => 'Ottieni Pro+';

  @override
  String get currentPlan => 'Piano attuale';

  @override
  String get switchToYearly => 'Passa ad annuale';

  @override
  String get switchToMonthly => 'Passa a mensile';

  @override
  String get upgradeToPro => 'Passa a Pro';

  @override
  String get upgradeToProPlus => 'Passa a Pro+';

  @override
  String get downgradeToPro => 'Passa a Pro (downgrade)';

  @override
  String get downgradeToProPlus => 'Passa a Pro+ (downgrade)';

  @override
  String get changesAtEnd => 'Modifiche alla fine del periodo di fatturazione';

  @override
  String autoRenews(String date) {
    return 'Rinnovo automatico $date';
  }

  @override
  String expires(String date) {
    return 'Scade $date';
  }

  @override
  String get soon => 'presto';

  @override
  String get active => 'ATTIVO';

  @override
  String get downgradePlan => 'Passa a piano inferiore';

  @override
  String get downgradeConfirm =>
      'Il tuo piano verrà ridotto alla fine del periodo di fatturazione corrente. Mantieni le funzionalità attuali fino ad allora.';

  @override
  String get confirmDowngrade => 'Conferma downgrade';

  @override
  String get welcomeBack => 'Bentornato';

  @override
  String get signInContinue => 'Accedi per continuare con DoCMind AI';

  @override
  String get createAccountToStart => 'Crea il tuo account per iniziare';

  @override
  String get emailAddress => 'Indirizzo email';

  @override
  String get password => 'Password';

  @override
  String get enterEmail => 'Inserisci la tua email';

  @override
  String get validEmail => 'Inserisci un\'email valida';

  @override
  String get enterPassword => 'Inserisci la tua password';

  @override
  String get passwordMinLength =>
      'La password deve contenere almeno 8 caratteri';

  @override
  String get signIn => 'Accedi';

  @override
  String get createAccount => 'Crea account';

  @override
  String get orContinueWith => 'oppure continua con';

  @override
  String get continueWithApple => 'Continua con Apple';

  @override
  String get tryWithoutAccount => 'Prova senza account';

  @override
  String get noAccount => 'Non hai un account? ';

  @override
  String get haveAccount => 'Hai già un account? ';

  @override
  String get signUp => 'Registrati';

  @override
  String get tryDoCMindAi => 'Prova DoCMind AI';

  @override
  String trialsLeft(int count) {
    return '$count prova/e rimanente/i';
  }

  @override
  String get noTrialsRemaining => 'Nessuna prova rimanente';

  @override
  String get summarizeNow => 'Riepiloga ora';

  @override
  String get analyzingDocument => 'Analisi del documento in corso...';

  @override
  String get thisMayTakeAMoment => 'Potrebbe richiedere qualche momento';

  @override
  String get guestModeLimitations => 'Limitazioni modalità ospite';

  @override
  String get maxPagesGuest => 'Massimo 2 pagine per documento';

  @override
  String get twoTrialsOnly => 'Solo 2 prove totali (nessun reset)';

  @override
  String get notSavedToHistory => 'Riepilogo non salvato nella cronologia';

  @override
  String get noCloudSync => 'Nessuna sincronizzazione cloud';

  @override
  String get withFreeAccount => 'Con un account gratuito ottieni:';

  @override
  String get upToFivePages => 'Fino a 5 pagine per documento';

  @override
  String get threeDocsPerDay => '3 documenti al giorno';

  @override
  String get historySavedForever => 'Cronologia salvata per sempre';

  @override
  String get cloudSyncDevices => 'Sincronizzazione cloud tra dispositivi';

  @override
  String get wantUnlimitedAccess => 'Vuoi accesso illimitato?';

  @override
  String get createFreeForMore =>
      'Crea un account gratuito per più funzionalità';

  @override
  String get createFreeAccount => 'Crea account gratuito';

  @override
  String get selectDocSource => 'Seleziona sorgente documento';

  @override
  String get browseFiles => 'Sfoglia file';

  @override
  String get pdfWordDocs => 'PDF, documenti Word';

  @override
  String get takePhoto => 'Scatta foto';

  @override
  String get captureDocCamera => 'Cattura documento con la fotocamera';

  @override
  String get photoLibrary => 'Libreria foto';

  @override
  String get selectFromGallery => 'Seleziona dalla galleria';

  @override
  String get fileTooLargeGuest =>
      'File troppo grande. Massimo 5MB in modalità ospite.';

  @override
  String get failedPickFile => 'Impossibile selezionare il file';

  @override
  String get failedCapturePhoto => 'Impossibile acquisire la foto';

  @override
  String get failedPickImage => 'Impossibile selezionare l\'immagine';

  @override
  String get trialLimitReached => 'Limite prove raggiunto';

  @override
  String get trialLimitMsg =>
      'Hai utilizzato tutte le prove gratuite. Crea un account per continuare a usare DoCMind AI con accesso illimitato.';

  @override
  String get noSummaryAvailable => 'Nessun riepilogo disponibile';

  @override
  String get summaryNotSaved =>
      'Questo riepilogo non verrà salvato. Crea un account per conservarlo!';

  @override
  String get documentSummary => 'Riepilogo documento';

  @override
  String get noOverviewAvailable => 'Nessuna panoramica disponibile';

  @override
  String moreKeyPoints(int count) {
    return '$count altri punti chiave';
  }

  @override
  String itemsCount(int count) {
    return '$count elementi';
  }

  @override
  String get createFreeToUnlock => 'Crea account gratuito per sbloccare';

  @override
  String trialsRemaining(int count) {
    return '$count prove rimanenti';
  }

  @override
  String get createAccountContinue =>
      'Crea un account per continuare a usare DoCMind AI';

  @override
  String get createAccountUnlimited =>
      'Crea un account per riepiloghi illimitati';

  @override
  String get close => 'Chiudi';

  @override
  String get processingFailed => 'Elaborazione del documento fallita. Riprova.';

  @override
  String get processingTakingLong =>
      'L\'elaborazione sta richiedendo più tempo del previsto. Controlla la Cronologia per lo stato.';

  @override
  String get translating => 'Traduzione';

  @override
  String get aiTranslatingYourSummary =>
      'L\'IA sta traducendo il tuo riassunto';

  @override
  String get translationComplete => 'Traduzione completata';

  @override
  String translatedTo(String language) {
    return 'Tradotto in $language';
  }

  @override
  String originalLanguage(String language) {
    return 'Originale: $language';
  }

  @override
  String generatedOn(String date) {
    return 'Generato il $date';
  }

  @override
  String get pleaseWait => 'Attendere prego';

  @override
  String get updateRequired => 'Aggiornamento richiesto';

  @override
  String get updateRequiredMsg =>
      'È disponibile una nuova versione di DoCMind AI. Aggiorna per continuare a utilizzare l\'app.';

  @override
  String get updateNow => 'Aggiorna ora';

  @override
  String get onboardingUploadTitle => 'Carica documenti';

  @override
  String get onboardingUploadDesc =>
      'Carica PDF, DOCX o immagini e lascia che l\'IA faccia il resto. Ottieni riassunti in pochi secondi.';

  @override
  String get onboardingSummaryTitle => 'Riassunti con IA';

  @override
  String get onboardingSummaryDesc =>
      'Ottieni istantaneamente punti chiave, azioni e informazioni importanti da qualsiasi documento.';

  @override
  String get onboardingTranslateTitle => 'Traduci i riassunti';

  @override
  String get onboardingTranslateDesc =>
      'Traduci i tuoi riassunti in oltre 13 lingue con un solo tocco.';

  @override
  String get onboardingShareTitle => 'Condividi da qualsiasi app';

  @override
  String get onboardingShareDesc =>
      'Invia file direttamente da WhatsApp, Telegram o qualsiasi app per riassunti istantanei.';

  @override
  String get onboardingHistoryTitle => 'Cronologia e filtri';

  @override
  String get onboardingHistoryDesc =>
      'Tutti i tuoi documenti organizzati in un unico posto. Filtra per PDF, Word o immagini.';

  @override
  String get onboardingCopyShareTitle => 'Copia e Condividi';

  @override
  String get onboardingCopyShareDesc =>
      'Copia i tuoi riassunti negli appunti o condividili tramite le tue app preferite.';

  @override
  String get tutorial => 'Tutorial';

  @override
  String get onboardingSkip => 'Salta';

  @override
  String get onboardingNext => 'Avanti';

  @override
  String get onboardingGetStarted => 'Inizia';
}
