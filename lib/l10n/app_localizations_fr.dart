// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class SFr extends S {
  SFr([String locale = 'fr']) : super(locale);

  @override
  String get appName => 'DoCMind AI';

  @override
  String get appTagline => 'OCR, documents et résumé IA';

  @override
  String get navHome => 'Accueil';

  @override
  String get navHistory => 'Historique';

  @override
  String get navSettings => 'Paramètres';

  @override
  String get addDocument => 'Ajouter un document';

  @override
  String get optionDocument => 'Document';

  @override
  String get optionDocumentSub => 'PDF, Word ou autres fichiers';

  @override
  String get optionGallery => 'Galerie';

  @override
  String get optionGallerySub => 'Choisir dans la photothèque';

  @override
  String get optionCamera => 'Appareil photo';

  @override
  String get optionCameraSub => 'Prendre une photo';

  @override
  String get greeting => 'Bonjour';

  @override
  String get planPro => 'Pro';

  @override
  String get planProPlus => 'Pro+';

  @override
  String get planFree => 'Gratuit';

  @override
  String get quickActions => 'Actions rapides';

  @override
  String get recentDocuments => 'Documents récents';

  @override
  String get upload => 'Télécharger';

  @override
  String get uploadFormats => 'PDF, DOCX, Image';

  @override
  String get history => 'Historique';

  @override
  String get viewAllDocs => 'Voir tous les documents';

  @override
  String get seeAll => 'Tout voir';

  @override
  String get noDocumentsYet => 'Aucun document pour l\'instant';

  @override
  String get uploadFirstDoc =>
      'Téléchargez votre premier document et laissez l\'IA le résumer pour vous';

  @override
  String get uploadDocument => 'Télécharger un document';

  @override
  String get premiumActive => 'Premium actif';

  @override
  String get unlimitedDocsSummaries => 'Documents et résumés illimités';

  @override
  String get freePlan => 'Forfait gratuit';

  @override
  String get noFreeDocsLeft => 'Plus de documents gratuits';

  @override
  String freeLeftCount(int count) {
    return '$count restant(s)';
  }

  @override
  String get upgradeForUnlimited => 'Passez à l\'illimité';

  @override
  String freeDocsUsed(int used, int limit) {
    return '$used sur $limit documents gratuits utilisés';
  }

  @override
  String get upgrade => 'Mettre à niveau';

  @override
  String get failed => 'Échec';

  @override
  String minAgo(int count) {
    return 'Il y a $count min';
  }

  @override
  String hoursAgo(int count) {
    return 'Il y a ${count}h';
  }

  @override
  String get yesterday => 'Hier';

  @override
  String daysAgo(int count) {
    return 'Il y a $count jours';
  }

  @override
  String get clearFilters => 'Effacer les filtres';

  @override
  String get documentDeleted => 'Document supprimé';

  @override
  String get noDocumentsFiltered => 'Aucun document trouvé';

  @override
  String get tryRemovingFilters =>
      'Essayez de retirer les filtres ou de télécharger\nde nouveaux documents';

  @override
  String get clearFiltersButton => 'Effacer les filtres';

  @override
  String get deleteDocument => 'Supprimer le document';

  @override
  String get deleteDocumentConfirm =>
      'Êtes-vous sûr de vouloir supprimer ce document ?';

  @override
  String get deleteDocumentConfirmFull =>
      'Êtes-vous sûr de vouloir supprimer ce document ? Cette action est irréversible.';

  @override
  String get cancel => 'Annuler';

  @override
  String get delete => 'Supprimer';

  @override
  String get allDocuments => 'Tous les documents';

  @override
  String get pdfOnly => 'PDF uniquement';

  @override
  String get wordOnly => 'Word uniquement';

  @override
  String get imagesOnly => 'Images uniquement';

  @override
  String get settings => 'Paramètres';

  @override
  String get proMember => 'Membre Pro';

  @override
  String get proPlusMember => 'Membre Pro+';

  @override
  String get unlimitedAccess => 'Accès illimité';

  @override
  String get upgradeForMoreFeatures =>
      'Mettez à niveau pour plus de fonctionnalités';

  @override
  String get preferences => 'Préférences';

  @override
  String get support => 'Assistance';

  @override
  String get account => 'Compte';

  @override
  String get notifications => 'Notifications';

  @override
  String get darkMode => 'Mode sombre';

  @override
  String get appLanguage => 'Langue de l\'application';

  @override
  String get summaryLanguage => 'Langue des résumés';

  @override
  String get helpFaq => 'Aide et FAQ';

  @override
  String get rateApp => 'Noter l\'application';

  @override
  String get rateAppSub => 'Vous aimez DoCMind AI ? Notez-nous !';

  @override
  String get privacyPolicy => 'Politique de confidentialité';

  @override
  String get termsOfService => 'Conditions d\'utilisation';

  @override
  String get restorePurchases => 'Restaurer les achats';

  @override
  String get signOut => 'Se déconnecter';

  @override
  String get deleteAccount => 'Supprimer le compte';

  @override
  String get deleteAccountConfirm =>
      'Êtes-vous sûr de vouloir supprimer votre compte ? Cette action est irréversible.';

  @override
  String get deleteAccountTitle => 'Supprimer le compte ?';

  @override
  String appVersion(String version) {
    return 'DoCMind AI v$version';
  }

  @override
  String whatsNew(String version) {
    return 'Nouveautés de la v$version';
  }

  @override
  String get ok => 'OK';

  @override
  String get document => 'Document';

  @override
  String get failedToLoadDocument => 'Échec du chargement du document';

  @override
  String get tryAgain => 'Réessayer';

  @override
  String get documentNotFound => 'Document introuvable';

  @override
  String get loadingPdf => 'Chargement du PDF...';

  @override
  String get loadingPreview => 'Chargement de l\'aperçu du document...';

  @override
  String showingPage(int count) {
    return 'Page 1 sur $count';
  }

  @override
  String get documentContent => 'Contenu du document';

  @override
  String get noContentExtracted => 'Aucun contenu extrait pour l\'instant';

  @override
  String get previewNotAvailable => 'Aperçu non disponible';

  @override
  String get viewSummary => 'Voir le résumé';

  @override
  String get generating => 'Génération en cours...';

  @override
  String get generateAiSummary => 'Générer un résumé IA';

  @override
  String pagesCount(int count) {
    return '$count pages';
  }

  @override
  String get uploadDocumentTitle => 'Télécharger un document';

  @override
  String get tipReading => 'L\'IA parcourt votre document...';

  @override
  String get tipExtracting => 'Extraction des informations clés...';

  @override
  String get tipIdentifying => 'Identification des sections importantes...';

  @override
  String get tipBuilding => 'Construction d\'un résumé structuré...';

  @override
  String get tipFinalizing => 'Presque terminé, finalisation en cours...';

  @override
  String get stepUploading => 'Téléchargement';

  @override
  String get stepExtractingText => 'Extraction du texte';

  @override
  String get stepAiAnalyzing => 'Analyse IA';

  @override
  String get summaryLang => 'Langue du résumé';

  @override
  String uploadingProgress(int percent) {
    return 'Téléchargement de votre document... $percent%';
  }

  @override
  String get extractingText => 'Extraction du texte de votre document...';

  @override
  String get aiAnalyzing => 'L\'IA analyse et résume...';

  @override
  String get preparing => 'Préparation...';

  @override
  String get tapToUpload => 'Appuyez pour télécharger un document';

  @override
  String supportedFormats(int size) {
    return 'PDF, DOCX, JPG, PNG jusqu\'à $size Mo';
  }

  @override
  String get aiWillExtract => 'L\'IA extraira et résumera le contenu';

  @override
  String get freeLimitReached =>
      'Limite gratuite atteinte. Mettez à niveau pour continuer';

  @override
  String get readyToProcess => 'Prêt à traiter';

  @override
  String get chooseDifferentFile => 'Choisir un autre fichier';

  @override
  String get selectedFile => 'Fichier sélectionné';

  @override
  String get generateSummary => 'Générer le résumé';

  @override
  String freePlanFileLimit(int size) {
    return 'Limite du forfait gratuit : max $size Mo par fichier. Mettez à niveau pour télécharger des documents plus volumineux.';
  }

  @override
  String fileSizeExceeded(int size) {
    return 'La taille du fichier dépasse la limite de votre forfait (max $size Mo). Mettez à niveau pour des fichiers plus volumineux.';
  }

  @override
  String get freeLimitReachedTitle => 'Limite gratuite atteinte';

  @override
  String get freeLimitReachedMsg =>
      'Vous avez utilisé tous vos documents gratuits. Passez à Pro pour un accès illimité !';

  @override
  String get maybeLater => 'Plus tard';

  @override
  String get upgradeNow => 'Mettre à niveau maintenant';

  @override
  String get summary => 'Résumé';

  @override
  String get failedToLoadSummary => 'Échec du chargement du résumé';

  @override
  String get summaryNotFound => 'Résumé introuvable';

  @override
  String get overview => 'Aperçu';

  @override
  String get keyPoints => 'Points clés';

  @override
  String get actionItems => 'Actions à réaliser';

  @override
  String get keywords => 'Mots-clés';

  @override
  String get importantFacts => 'Faits importants';

  @override
  String get obligations => 'Obligations';

  @override
  String get risks => 'Risques';

  @override
  String get findings => 'Constatations';

  @override
  String wordsCount(int count) {
    return '$count mots';
  }

  @override
  String processingTime(String seconds) {
    return '${seconds}s';
  }

  @override
  String get viewOriginalDocument => 'Voir le document original';

  @override
  String get copySummary => 'Copier le résumé';

  @override
  String get summaryCopied => 'Résumé copié dans le presse-papiers';

  @override
  String get generatedBy => 'Généré par DoCMind AI';

  @override
  String wordCountLabel(int count) {
    return 'Nombre de mots : $count';
  }

  @override
  String processingTimeLabel(String seconds) {
    return 'Temps de traitement : ${seconds}s';
  }

  @override
  String get upgradeRequired => 'Mise à niveau requise';

  @override
  String get translateProOnly =>
      'La traduction est disponible sur les forfaits Pro. Mettez à niveau pour traduire les résumés.';

  @override
  String get notNow => 'Pas maintenant';

  @override
  String get manageSubscription => 'Gérer l\'abonnement';

  @override
  String get changeYourPlan => 'Modifier votre forfait';

  @override
  String get unlockPremium => 'Débloquer Premium';

  @override
  String get upgradeOrSwitch => 'Mettez à niveau ou changez de forfait';

  @override
  String get getUnlimitedAccess =>
      'Obtenez un accès illimité à toutes les fonctionnalités';

  @override
  String get monthly => 'Mensuel';

  @override
  String get yearly => 'Annuel';

  @override
  String get save40 => 'ÉCONOMISEZ 40 %';

  @override
  String get unlimitedDocuments => 'Documents illimités';

  @override
  String get unlimitedSummaries => 'Résumés illimités';

  @override
  String get priorityAiProcessing => 'Traitement IA prioritaire';

  @override
  String get exportToPdf => 'Exporter en PDF';

  @override
  String get emailSupport => 'Assistance par e-mail';

  @override
  String get everythingInPro => 'Tout ce qu\'inclut Pro';

  @override
  String get ocrScannedDocs => 'OCR pour les documents scannés';

  @override
  String get longDocSupport => 'Documents longs (100+ pages)';

  @override
  String get advancedAiAnalysis => 'Analyse IA avancée';

  @override
  String get prioritySupport => 'Assistance prioritaire';

  @override
  String get earlyAccess => 'Accès anticipé aux fonctionnalités';

  @override
  String get freePlanInfo =>
      'Le forfait gratuit inclut 2 documents de 5 pages maximum chacun.';

  @override
  String get restoring => 'Restauration...';

  @override
  String get current => 'ACTUEL';

  @override
  String get popular => 'POPULAIRE';

  @override
  String get perYear => '/an';

  @override
  String get perMonth => '/mois';

  @override
  String get billedAnnually => 'Facturé annuellement';

  @override
  String thatsOnly(String price) {
    return 'Soit seulement $price/mois';
  }

  @override
  String get getPro => 'Obtenir Pro';

  @override
  String get getProPlus => 'Obtenir Pro+';

  @override
  String get currentPlan => 'Forfait actuel';

  @override
  String get switchToYearly => 'Passer à l\'annuel';

  @override
  String get switchToMonthly => 'Passer au mensuel';

  @override
  String get upgradeToPro => 'Passer à Pro';

  @override
  String get upgradeToProPlus => 'Passer à Pro+';

  @override
  String get downgradeToPro => 'Rétrograder vers Pro';

  @override
  String get downgradeToProPlus => 'Rétrograder vers Pro+';

  @override
  String get changesAtEnd =>
      'Modifications à la fin de la période de facturation';

  @override
  String autoRenews(String date) {
    return 'Renouvellement automatique le $date';
  }

  @override
  String expires(String date) {
    return 'Expire le $date';
  }

  @override
  String get soon => 'bientôt';

  @override
  String get active => 'ACTIF';

  @override
  String get downgradePlan => 'Rétrograder le forfait';

  @override
  String get downgradeConfirm =>
      'Votre forfait sera rétrogradé à la fin de votre période de facturation en cours. Vous conserverez vos fonctionnalités actuelles jusqu\'à cette date.';

  @override
  String get confirmDowngrade => 'Confirmer la rétrogradation';

  @override
  String get welcomeBack => 'Bon retour';

  @override
  String get signInContinue => 'Connectez-vous pour accéder à DoCMind AI';

  @override
  String get createAccountToStart => 'Créez votre compte pour commencer';

  @override
  String get emailAddress => 'Adresse e-mail';

  @override
  String get password => 'Mot de passe';

  @override
  String get enterEmail => 'Veuillez entrer votre e-mail';

  @override
  String get validEmail => 'Veuillez entrer une adresse e-mail valide';

  @override
  String get enterPassword => 'Veuillez entrer votre mot de passe';

  @override
  String get passwordMinLength =>
      'Le mot de passe doit contenir au moins 8 caractères';

  @override
  String get signIn => 'Se connecter';

  @override
  String get createAccount => 'Créer un compte';

  @override
  String get orContinueWith => 'ou continuer avec';

  @override
  String get continueWithApple => 'Continuer avec Apple';

  @override
  String get tryWithoutAccount => 'Essayer sans compte';

  @override
  String get noAccount => 'Vous n\'avez pas de compte ? ';

  @override
  String get haveAccount => 'Vous avez déjà un compte ? ';

  @override
  String get signUp => 'S\'inscrire';

  @override
  String get tryDoCMindAi => 'Essayer DoCMind AI';

  @override
  String trialsLeft(int count) {
    return '$count essai(s) restant(s)';
  }

  @override
  String get noTrialsRemaining => 'Plus d\'essais disponibles';

  @override
  String get summarizeNow => 'Résumer maintenant';

  @override
  String get analyzingDocument => 'Analyse de votre document...';

  @override
  String get thisMayTakeAMoment => 'Cela peut prendre un moment';

  @override
  String get guestModeLimitations => 'Limitations du mode invité';

  @override
  String get maxPagesGuest => 'Maximum 2 pages par document';

  @override
  String get twoTrialsOnly =>
      'Seulement 2 essais au total (sans réinitialisation)';

  @override
  String get notSavedToHistory => 'Résumé non enregistré dans l\'historique';

  @override
  String get noCloudSync => 'Pas de synchronisation cloud';

  @override
  String get withFreeAccount => 'Avec un compte gratuit vous bénéficiez de :';

  @override
  String get upToFivePages => 'Jusqu\'à 5 pages par document';

  @override
  String get threeDocsPerDay => '3 documents par jour';

  @override
  String get historySavedForever => 'Historique conservé indéfiniment';

  @override
  String get cloudSyncDevices => 'Synchronisation cloud sur tous les appareils';

  @override
  String get wantUnlimitedAccess => 'Vous voulez un accès illimité ?';

  @override
  String get createFreeForMore =>
      'Créez un compte gratuit pour plus de fonctionnalités';

  @override
  String get createFreeAccount => 'Créer un compte gratuit';

  @override
  String get selectDocSource => 'Sélectionner la source du document';

  @override
  String get browseFiles => 'Parcourir les fichiers';

  @override
  String get pdfWordDocs => 'PDF, documents Word';

  @override
  String get takePhoto => 'Prendre une photo';

  @override
  String get captureDocCamera => 'Capturer un document avec l\'appareil photo';

  @override
  String get photoLibrary => 'Photothèque';

  @override
  String get selectFromGallery => 'Sélectionner dans la galerie';

  @override
  String get fileTooLargeGuest =>
      'Fichier trop volumineux. Maximum 5 Mo en mode invité.';

  @override
  String get failedPickFile => 'Échec de la sélection du fichier';

  @override
  String get failedCapturePhoto => 'Échec de la capture photo';

  @override
  String get failedPickImage => 'Échec de la sélection de l\'image';

  @override
  String get trialLimitReached => 'Limite d\'essais atteinte';

  @override
  String get trialLimitMsg =>
      'Vous avez utilisé tous vos essais gratuits. Créez un compte pour continuer à utiliser DoCMind AI avec un accès illimité.';

  @override
  String get noSummaryAvailable => 'Aucun résumé disponible';

  @override
  String get summaryNotSaved =>
      'Ce résumé ne sera pas enregistré. Créez un compte pour le conserver !';

  @override
  String get documentSummary => 'Résumé du document';

  @override
  String get noOverviewAvailable => 'Aucun aperçu disponible';

  @override
  String moreKeyPoints(int count) {
    return '$count points clés supplémentaires';
  }

  @override
  String itemsCount(int count) {
    return '$count éléments';
  }

  @override
  String get createFreeToUnlock => 'Créez un compte gratuit pour débloquer';

  @override
  String trialsRemaining(int count) {
    return '$count essai(s) restant(s)';
  }

  @override
  String get createAccountContinue =>
      'Créez un compte pour continuer à utiliser DoCMind AI';

  @override
  String get createAccountUnlimited =>
      'Créez un compte pour des résumés illimités';

  @override
  String get close => 'Fermer';

  @override
  String get processingFailed =>
      'Le traitement du document a échoué. Veuillez réessayer.';

  @override
  String get processingTakingLong =>
      'Le traitement prend plus de temps que prévu. Consultez l\'historique pour le statut.';

  @override
  String get translating => 'Traduction';

  @override
  String get aiTranslatingYourSummary => 'L\'IA traduit votre résumé';

  @override
  String get translationComplete => 'Traduction terminée';

  @override
  String translatedTo(String language) {
    return 'Traduit en $language';
  }

  @override
  String originalLanguage(String language) {
    return 'Original : $language';
  }

  @override
  String generatedOn(String date) {
    return 'Généré le $date';
  }

  @override
  String get pleaseWait => 'Veuillez patienter';

  @override
  String get updateRequired => 'Mise à jour requise';

  @override
  String get updateRequiredMsg =>
      'Une nouvelle version de DoCMind AI est disponible. Veuillez mettre à jour pour continuer à utiliser l\'application.';

  @override
  String get updateNow => 'Mettre à jour';
}
