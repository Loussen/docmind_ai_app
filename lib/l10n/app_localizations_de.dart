// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class SDe extends S {
  SDe([String locale = 'de']) : super(locale);

  @override
  String get appName => 'DoCMind AI';

  @override
  String get appTagline => 'OCR, Dokumente & KI-Zusammenfassung';

  @override
  String get navHome => 'Start';

  @override
  String get navHistory => 'Verlauf';

  @override
  String get navSettings => 'Einstellungen';

  @override
  String get addDocument => 'Dokument hinzufügen';

  @override
  String get optionDocument => 'Dokument';

  @override
  String get optionDocumentSub => 'PDF, Word oder andere Dateien';

  @override
  String get optionGallery => 'Galerie';

  @override
  String get optionGallerySub => 'Aus Fotobibliothek wählen';

  @override
  String get optionCamera => 'Kamera';

  @override
  String get optionCameraSub => 'Foto aufnehmen';

  @override
  String get greeting => 'Hallo';

  @override
  String get planPro => 'Pro';

  @override
  String get planProPlus => 'Pro+';

  @override
  String get planFree => 'Kostenlos';

  @override
  String get quickActions => 'Schnellaktionen';

  @override
  String get recentDocuments => 'Letzte Dokumente';

  @override
  String get upload => 'Hochladen';

  @override
  String get uploadFormats => 'PDF, DOCX, Bild';

  @override
  String get history => 'Verlauf';

  @override
  String get viewAllDocs => 'Alle Dokumente anzeigen';

  @override
  String get seeAll => 'Alle anzeigen';

  @override
  String get noDocumentsYet => 'Noch keine Dokumente';

  @override
  String get uploadFirstDoc =>
      'Laden Sie Ihr erstes Dokument hoch und lassen Sie die KI es für Sie zusammenfassen';

  @override
  String get uploadDocument => 'Dokument hochladen';

  @override
  String get premiumActive => 'Premium aktiv';

  @override
  String get unlimitedDocsSummaries =>
      'Unbegrenzte Dokumente & Zusammenfassungen';

  @override
  String get freePlan => 'Kostenloser Tarif';

  @override
  String get noFreeDocsLeft => 'Keine kostenlosen Dokumente mehr';

  @override
  String freeLeftCount(int count) {
    return '$count kostenlos übrig';
  }

  @override
  String get upgradeForUnlimited => 'Für unbegrenzten Zugang upgraden';

  @override
  String freeDocsUsed(int used, int limit) {
    return '$used von $limit kostenlosen Dokumenten verwendet';
  }

  @override
  String get upgrade => 'Upgrade';

  @override
  String get failed => 'Fehlgeschlagen';

  @override
  String minAgo(int count) {
    return 'vor $count Min.';
  }

  @override
  String hoursAgo(int count) {
    return 'vor ${count}h';
  }

  @override
  String get yesterday => 'Gestern';

  @override
  String daysAgo(int count) {
    return 'vor $count Tagen';
  }

  @override
  String get clearFilters => 'Filter löschen';

  @override
  String get documentDeleted => 'Dokument gelöscht';

  @override
  String get noDocumentsFiltered => 'Keine Dokumente gefunden';

  @override
  String get tryRemovingFilters =>
      'Versuchen Sie, Filter zu entfernen oder\nneue Dokumente hochzuladen';

  @override
  String get clearFiltersButton => 'Filter löschen';

  @override
  String get deleteDocument => 'Dokument löschen';

  @override
  String get deleteDocumentConfirm =>
      'Möchten Sie dieses Dokument wirklich löschen?';

  @override
  String get deleteDocumentConfirmFull =>
      'Möchten Sie dieses Dokument wirklich löschen? Diese Aktion kann nicht rückgängig gemacht werden.';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get delete => 'Löschen';

  @override
  String get allDocuments => 'Alle Dokumente';

  @override
  String get pdfOnly => 'Nur PDF';

  @override
  String get wordOnly => 'Nur Word';

  @override
  String get imagesOnly => 'Nur Bilder';

  @override
  String get settings => 'Einstellungen';

  @override
  String get proMember => 'Pro-Mitglied';

  @override
  String get proPlusMember => 'Pro+-Mitglied';

  @override
  String get unlimitedAccess => 'Unbegrenzter Zugang';

  @override
  String get upgradeForMoreFeatures => 'Für mehr Funktionen upgraden';

  @override
  String get preferences => 'Einstellungen';

  @override
  String get support => 'Support';

  @override
  String get account => 'Konto';

  @override
  String get notifications => 'Benachrichtigungen';

  @override
  String get darkMode => 'Dunkelmodus';

  @override
  String get appLanguage => 'App-Sprache';

  @override
  String get summaryLanguage => 'Zusammenfassungssprache';

  @override
  String get helpFaq => 'Hilfe & FAQ';

  @override
  String get rateApp => 'App bewerten';

  @override
  String get rateAppSub => 'Gefällt Ihnen DoCMind AI? Bewerten Sie uns!';

  @override
  String get privacyPolicy => 'Datenschutzrichtlinie';

  @override
  String get termsOfService => 'Nutzungsbedingungen';

  @override
  String get restorePurchases => 'Käufe wiederherstellen';

  @override
  String get signOut => 'Abmelden';

  @override
  String get deleteAccount => 'Konto löschen';

  @override
  String get deleteAccountConfirm =>
      'Möchten Sie Ihr Konto wirklich löschen? Dies kann nicht rückgängig gemacht werden.';

  @override
  String get deleteAccountTitle => 'Konto löschen?';

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
    return 'Neu in v$version';
  }

  @override
  String get ok => 'OK';

  @override
  String get document => 'Dokument';

  @override
  String get failedToLoadDocument => 'Dokument konnte nicht geladen werden';

  @override
  String get tryAgain => 'Erneut versuchen';

  @override
  String get documentNotFound => 'Dokument nicht gefunden';

  @override
  String get loadingPdf => 'PDF wird geladen...';

  @override
  String get loadingPreview => 'Dokumentvorschau wird geladen...';

  @override
  String showingPage(int count) {
    return 'Seite 1 von $count';
  }

  @override
  String get documentContent => 'Dokumentinhalt';

  @override
  String get noContentExtracted => 'Noch kein Inhalt extrahiert';

  @override
  String get previewNotAvailable => 'Vorschau nicht verfügbar';

  @override
  String get viewSummary => 'Zusammenfassung anzeigen';

  @override
  String get generating => 'Wird erstellt...';

  @override
  String get generateAiSummary => 'KI-Zusammenfassung erstellen';

  @override
  String pagesCount(int count) {
    return '$count Seiten';
  }

  @override
  String get uploadDocumentTitle => 'Dokument hochladen';

  @override
  String get tipReading => 'Die KI liest Ihr Dokument...';

  @override
  String get tipExtracting => 'Wichtige Informationen werden extrahiert...';

  @override
  String get tipIdentifying => 'Wichtige Abschnitte werden identifiziert...';

  @override
  String get tipBuilding => 'Strukturierte Zusammenfassung wird erstellt...';

  @override
  String get tipFinalizing => 'Fast fertig, Ergebnisse werden finalisiert...';

  @override
  String get stepUploading => 'Hochladen';

  @override
  String get stepExtractingText => 'Text extrahieren';

  @override
  String get stepAiAnalyzing => 'KI-Analyse';

  @override
  String get summaryLang => 'Zusammenfassungssprache';

  @override
  String uploadingProgress(int percent) {
    return 'Ihr Dokument wird hochgeladen... $percent%';
  }

  @override
  String get extractingText => 'Text wird aus Ihrem Dokument extrahiert...';

  @override
  String get aiAnalyzing => 'Die KI analysiert und fasst zusammen...';

  @override
  String get preparing => 'Wird vorbereitet...';

  @override
  String get tapToUpload => 'Tippen Sie, um ein Dokument hochzuladen';

  @override
  String supportedFormats(int size) {
    return 'PDF, DOCX, JPG, PNG bis $size MB';
  }

  @override
  String get aiWillExtract => 'Die KI extrahiert und fasst den Inhalt zusammen';

  @override
  String get freeLimitReached =>
      'Kostenloses Limit erreicht. Upgraden Sie, um fortzufahren';

  @override
  String get readyToProcess => 'Bereit zur Verarbeitung';

  @override
  String get chooseDifferentFile => 'Andere Datei wählen';

  @override
  String get selectedFile => 'Ausgewählte Datei';

  @override
  String get generateSummary => 'Zusammenfassung erstellen';

  @override
  String freePlanFileLimit(int size) {
    return 'Kostenloses Tariflimit: max. $size MB pro Datei. Upgraden Sie, um größere Dokumente hochzuladen.';
  }

  @override
  String fileSizeExceeded(int size) {
    return 'Die Dateigröße überschreitet Ihr Tariflimit (max. $size MB). Upgraden Sie für größere Dateien.';
  }

  @override
  String get freeLimitReachedTitle => 'Kostenloses Limit erreicht';

  @override
  String get freeLimitReachedMsg =>
      'Sie haben alle kostenlosen Dokumente verwendet. Upgraden Sie auf Pro für unbegrenzten Zugang!';

  @override
  String get maybeLater => 'Vielleicht später';

  @override
  String get upgradeNow => 'Jetzt upgraden';

  @override
  String get summary => 'Zusammenfassung';

  @override
  String get failedToLoadSummary =>
      'Zusammenfassung konnte nicht geladen werden';

  @override
  String get summaryNotFound => 'Zusammenfassung nicht gefunden';

  @override
  String get overview => 'Überblick';

  @override
  String get keyPoints => 'Wichtige Punkte';

  @override
  String get actionItems => 'Maßnahmen';

  @override
  String get keywords => 'Schlüsselwörter';

  @override
  String get importantFacts => 'Wichtige Fakten';

  @override
  String get obligations => 'Verpflichtungen';

  @override
  String get risks => 'Risiken';

  @override
  String get findings => 'Erkenntnisse';

  @override
  String wordsCount(int count) {
    return '$count Wörter';
  }

  @override
  String processingTime(String seconds) {
    return '${seconds}s';
  }

  @override
  String get viewOriginalDocument => 'Originaldokument anzeigen';

  @override
  String get copySummary => 'Zusammenfassung kopieren';

  @override
  String get summaryCopied => 'Zusammenfassung in die Zwischenablage kopiert';

  @override
  String get generatedBy => 'Erstellt von DoCMind AI';

  @override
  String wordCountLabel(int count) {
    return 'Wortanzahl: $count';
  }

  @override
  String processingTimeLabel(String seconds) {
    return 'Verarbeitungszeit: ${seconds}s';
  }

  @override
  String get upgradeRequired => 'Upgrade erforderlich';

  @override
  String get translateProOnly =>
      'Übersetzung ist in Pro-Tarifen verfügbar. Upgraden Sie, um Zusammenfassungen zu übersetzen.';

  @override
  String get notNow => 'Nicht jetzt';

  @override
  String get manageSubscription => 'Abonnement verwalten';

  @override
  String get changeYourPlan => 'Tarif ändern';

  @override
  String get unlockPremium => 'Premium freischalten';

  @override
  String get upgradeOrSwitch => 'Upgraden oder zu einem anderen Tarif wechseln';

  @override
  String get getUnlimitedAccess =>
      'Erhalten Sie unbegrenzten Zugang zu allen Funktionen';

  @override
  String get monthly => 'Monatlich';

  @override
  String get yearly => 'Jährlich';

  @override
  String get save40 => '40 % SPAREN';

  @override
  String get unlimitedDocuments => 'Unbegrenzte Dokumente';

  @override
  String get unlimitedSummaries => 'Unbegrenzte Zusammenfassungen';

  @override
  String get priorityAiProcessing => 'Prioritäre KI-Verarbeitung';

  @override
  String get exportToPdf => 'Als PDF exportieren';

  @override
  String get emailSupport => 'E-Mail-Support';

  @override
  String get everythingInPro => 'Alles aus Pro';

  @override
  String get ocrScannedDocs => 'OCR für gescannte Dokumente';

  @override
  String get longDocSupport => 'Lange Dokumente (100+ Seiten)';

  @override
  String get advancedAiAnalysis => 'Erweiterte KI-Analyse';

  @override
  String get prioritySupport => 'Prioritäts-Support';

  @override
  String get earlyAccess => 'Früher Zugang zu Funktionen';

  @override
  String get freePlanInfo =>
      'Der kostenlose Tarif umfasst 2 Dokumente mit je bis zu 5 Seiten.';

  @override
  String get restoring => 'Wird wiederhergestellt...';

  @override
  String get current => 'AKTUELL';

  @override
  String get popular => 'BELIEBT';

  @override
  String get perYear => '/Jahr';

  @override
  String get perMonth => '/Monat';

  @override
  String get billedAnnually => 'Jährlich abgerechnet';

  @override
  String thatsOnly(String price) {
    return 'Das sind nur $price/Monat';
  }

  @override
  String get getPro => 'Pro erhalten';

  @override
  String get getProPlus => 'Pro+ erhalten';

  @override
  String get currentPlan => 'Aktueller Tarif';

  @override
  String get switchToYearly => 'Auf jährlich wechseln';

  @override
  String get switchToMonthly => 'Auf monatlich wechseln';

  @override
  String get upgradeToPro => 'Auf Pro upgraden';

  @override
  String get upgradeToProPlus => 'Auf Pro+ upgraden';

  @override
  String get downgradeToPro => 'Auf Pro herabstufen';

  @override
  String get downgradeToProPlus => 'Auf Pro+ herabstufen';

  @override
  String get changesAtEnd => 'Änderungen am Ende des Abrechnungszeitraums';

  @override
  String autoRenews(String date) {
    return 'Verlängert sich automatisch am $date';
  }

  @override
  String expires(String date) {
    return 'Läuft am $date ab';
  }

  @override
  String get soon => 'bald';

  @override
  String get active => 'AKTIV';

  @override
  String get downgradePlan => 'Tarif herabstufen';

  @override
  String get downgradeConfirm =>
      'Ihr Tarif wird am Ende Ihres aktuellen Abrechnungszeitraums herabgestuft. Sie behalten Ihre aktuellen Funktionen bis dahin.';

  @override
  String get confirmDowngrade => 'Herabstufung bestätigen';

  @override
  String get welcomeBack => 'Willkommen zurück';

  @override
  String get signInContinue => 'Melden Sie sich an, um DoCMind AI zu nutzen';

  @override
  String get createAccountToStart => 'Erstellen Sie Ihr Konto, um zu starten';

  @override
  String get emailAddress => 'E-Mail-Adresse';

  @override
  String get password => 'Passwort';

  @override
  String get enterEmail => 'Bitte geben Sie Ihre E-Mail ein';

  @override
  String get validEmail => 'Bitte geben Sie eine gültige E-Mail-Adresse ein';

  @override
  String get enterPassword => 'Bitte geben Sie Ihr Passwort ein';

  @override
  String get passwordMinLength =>
      'Das Passwort muss mindestens 8 Zeichen haben';

  @override
  String get signIn => 'Anmelden';

  @override
  String get createAccount => 'Konto erstellen';

  @override
  String get orContinueWith => 'oder fortfahren mit';

  @override
  String get continueWithApple => 'Mit Apple fortfahren';

  @override
  String get tryWithoutAccount => 'Ohne Konto ausprobieren';

  @override
  String get noAccount => 'Noch kein Konto? ';

  @override
  String get haveAccount => 'Bereits ein Konto? ';

  @override
  String get signUp => 'Registrieren';

  @override
  String get tryDoCMindAi => 'DoCMind AI ausprobieren';

  @override
  String trialsLeft(int count) {
    return '$count Test(s) übrig';
  }

  @override
  String get noTrialsRemaining => 'Keine Tests mehr verfügbar';

  @override
  String get summarizeNow => 'Jetzt zusammenfassen';

  @override
  String get analyzingDocument => 'Ihr Dokument wird analysiert...';

  @override
  String get thisMayTakeAMoment => 'Das kann einen Moment dauern';

  @override
  String get guestModeLimitations => 'Einschränkungen im Gastmodus';

  @override
  String get maxPagesGuest => 'Max. 2 Seiten pro Dokument';

  @override
  String get twoTrialsOnly => 'Nur 2 Tests insgesamt (kein Zurücksetzen)';

  @override
  String get notSavedToHistory =>
      'Zusammenfassung nicht im Verlauf gespeichert';

  @override
  String get noCloudSync => 'Keine Cloud-Synchronisation';

  @override
  String get withFreeAccount => 'Mit einem kostenlosen Konto erhalten Sie:';

  @override
  String get upToFivePages => 'Bis zu 5 Seiten pro Dokument';

  @override
  String get threeDocsPerDay => '3 Dokumente pro Tag';

  @override
  String get historySavedForever => 'Verlauf dauerhaft gespeichert';

  @override
  String get cloudSyncDevices => 'Cloud-Sync auf allen Geräten';

  @override
  String get wantUnlimitedAccess => 'Unbegrenzten Zugang möchten?';

  @override
  String get createFreeForMore =>
      'Erstellen Sie ein kostenloses Konto für mehr Funktionen';

  @override
  String get createFreeAccount => 'Kostenloses Konto erstellen';

  @override
  String get selectDocSource => 'Dokumentquelle auswählen';

  @override
  String get browseFiles => 'Dateien durchsuchen';

  @override
  String get pdfWordDocs => 'PDF, Word-Dokumente';

  @override
  String get takePhoto => 'Foto aufnehmen';

  @override
  String get captureDocCamera => 'Dokument mit Kamera erfassen';

  @override
  String get photoLibrary => 'Fotobibliothek';

  @override
  String get selectFromGallery => 'Aus Galerie auswählen';

  @override
  String get fileTooLargeGuest => 'Datei zu groß. Maximal 5 MB im Gastmodus.';

  @override
  String get failedPickFile => 'Datei konnte nicht ausgewählt werden';

  @override
  String get failedCapturePhoto => 'Foto konnte nicht aufgenommen werden';

  @override
  String get failedPickImage => 'Bild konnte nicht ausgewählt werden';

  @override
  String get trialLimitReached => 'Testlimit erreicht';

  @override
  String get trialLimitMsg =>
      'Sie haben alle kostenlosen Tests verwendet. Erstellen Sie ein Konto, um DoCMind AI mit unbegrenztem Zugang weiter zu nutzen.';

  @override
  String get noSummaryAvailable => 'Keine Zusammenfassung verfügbar';

  @override
  String get summaryNotSaved =>
      'Diese Zusammenfassung wird nicht gespeichert. Erstellen Sie ein Konto, um sie zu behalten!';

  @override
  String get documentSummary => 'Dokumentzusammenfassung';

  @override
  String get noOverviewAvailable => 'Kein Überblick verfügbar';

  @override
  String moreKeyPoints(int count) {
    return '$count weitere wichtige Punkte';
  }

  @override
  String itemsCount(int count) {
    return '$count Elemente';
  }

  @override
  String get createFreeToUnlock =>
      'Kostenloses Konto erstellen zum Freischalten';

  @override
  String trialsRemaining(int count) {
    return '$count Test(s) übrig';
  }

  @override
  String get createAccountContinue =>
      'Erstellen Sie ein Konto, um DoCMind AI weiter zu nutzen';

  @override
  String get createAccountUnlimited =>
      'Erstellen Sie ein Konto für unbegrenzte Zusammenfassungen';

  @override
  String get close => 'Schließen';

  @override
  String get processingFailed =>
      'Dokumentverarbeitung fehlgeschlagen. Bitte versuchen Sie es erneut.';

  @override
  String get processingTakingLong =>
      'Die Verarbeitung dauert länger als erwartet. Prüfen Sie den Verlauf für den Status.';

  @override
  String get translating => 'Übersetzen';

  @override
  String get aiTranslatingYourSummary => 'KI übersetzt Ihre Zusammenfassung';

  @override
  String get translationComplete => 'Übersetzung abgeschlossen';

  @override
  String translatedTo(String language) {
    return 'Übersetzt nach $language';
  }

  @override
  String originalLanguage(String language) {
    return 'Original: $language';
  }

  @override
  String generatedOn(String date) {
    return 'Erstellt am $date';
  }

  @override
  String get pleaseWait => 'Bitte warten';

  @override
  String get updateRequired => 'Update erforderlich';

  @override
  String get updateRequiredMsg =>
      'Eine neue Version von DoCMind AI ist verfügbar. Bitte aktualisieren Sie die App, um sie weiter nutzen zu können.';

  @override
  String get updateNow => 'Jetzt aktualisieren';

  @override
  String get onboardingUploadTitle => 'Dokumente hochladen';

  @override
  String get onboardingUploadDesc =>
      'Laden Sie PDFs, DOCX oder Bilder hoch und lassen Sie die KI den Rest erledigen. Erhalten Sie Zusammenfassungen in Sekunden.';

  @override
  String get onboardingSummaryTitle => 'KI-gestützte Zusammenfassungen';

  @override
  String get onboardingSummaryDesc =>
      'Erhalten Sie sofort Kernpunkte, Aufgaben und Highlights aus jedem Dokument.';

  @override
  String get onboardingTranslateTitle => 'Zusammenfassungen übersetzen';

  @override
  String get onboardingTranslateDesc =>
      'Übersetzen Sie Ihre Zusammenfassungen mit einem Fingertipp in über 13 Sprachen.';

  @override
  String get onboardingShareTitle => 'Aus jeder App teilen';

  @override
  String get onboardingShareDesc =>
      'Senden Sie Dateien direkt aus WhatsApp, Telegram oder jeder anderen App für sofortige Zusammenfassungen.';

  @override
  String get onboardingHistoryTitle => 'Verlauf & Filter';

  @override
  String get onboardingHistoryDesc =>
      'Alle Ihre Dokumente an einem Ort organisiert. Filtern Sie nach PDF, Word oder Bildern.';

  @override
  String get onboardingCopyShareTitle => 'Kopieren & Teilen';

  @override
  String get onboardingCopyShareDesc =>
      'Kopieren Sie Ihre Zusammenfassungen in die Zwischenablage oder teilen Sie sie über Ihre Lieblings-Apps.';

  @override
  String get tutorial => 'Anleitung';

  @override
  String get onboardingSkip => 'Überspringen';

  @override
  String get onboardingNext => 'Weiter';

  @override
  String get onboardingGetStarted => 'Loslegen';
}
