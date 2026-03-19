// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Dutch Flemish (`nl`).
class SNl extends S {
  SNl([String locale = 'nl']) : super(locale);

  @override
  String get appName => 'DoCMind AI';

  @override
  String get appTagline => 'OCR, documenten & AI-samenvatting';

  @override
  String get navHome => 'Home';

  @override
  String get navHistory => 'Geschiedenis';

  @override
  String get navSettings => 'Instellingen';

  @override
  String get addDocument => 'Document toevoegen';

  @override
  String get optionDocument => 'Document';

  @override
  String get optionDocumentSub => 'PDF, Word of andere bestanden';

  @override
  String get optionGallery => 'Galerij';

  @override
  String get optionGallerySub => 'Kies uit fotobibliotheek';

  @override
  String get optionCamera => 'Camera';

  @override
  String get optionCameraSub => 'Maak een foto';

  @override
  String get greeting => 'Hallo';

  @override
  String get planPro => 'Pro';

  @override
  String get planProPlus => 'Pro+';

  @override
  String get planFree => 'Gratis';

  @override
  String get quickActions => 'Snelle acties';

  @override
  String get recentDocuments => 'Recente documenten';

  @override
  String get upload => 'Uploaden';

  @override
  String get uploadFormats => 'PDF, DOCX, Afbeelding';

  @override
  String get history => 'Geschiedenis';

  @override
  String get viewAllDocs => 'Bekijk alle documenten';

  @override
  String get seeAll => 'Alles bekijken';

  @override
  String get noDocumentsYet => 'Nog geen documenten';

  @override
  String get uploadFirstDoc =>
      'Upload je eerste document en laat AI het voor je samenvatten';

  @override
  String get uploadDocument => 'Document uploaden';

  @override
  String get premiumActive => 'Premium actief';

  @override
  String get unlimitedDocsSummaries => 'Onbeperkt documenten & samenvattingen';

  @override
  String get freePlan => 'Gratis abonnement';

  @override
  String get noFreeDocsLeft => 'Geen gratis documenten meer';

  @override
  String freeLeftCount(int count) {
    return '$count gratis over';
  }

  @override
  String get upgradeForUnlimited => 'Upgrade voor onbeperkte toegang';

  @override
  String freeDocsUsed(int used, int limit) {
    return '$used van $limit gratis documenten gebruikt';
  }

  @override
  String get upgrade => 'Upgraden';

  @override
  String get failed => 'Mislukt';

  @override
  String minAgo(int count) {
    return '$count min geleden';
  }

  @override
  String hoursAgo(int count) {
    return '${count}u geleden';
  }

  @override
  String get yesterday => 'Gisteren';

  @override
  String daysAgo(int count) {
    return '$count dagen geleden';
  }

  @override
  String get clearFilters => 'Filters wissen';

  @override
  String get documentDeleted => 'Document verwijderd';

  @override
  String get noDocumentsFiltered => 'Geen documenten gevonden';

  @override
  String get tryRemovingFilters =>
      'Probeer filters te verwijderen of\nnieuwe documenten te uploaden';

  @override
  String get clearFiltersButton => 'Filters wissen';

  @override
  String get deleteDocument => 'Document verwijderen';

  @override
  String get deleteDocumentConfirm =>
      'Weet je zeker dat je dit document wilt verwijderen?';

  @override
  String get deleteDocumentConfirmFull =>
      'Weet je zeker dat je dit document wilt verwijderen? Deze actie kan niet ongedaan worden gemaakt.';

  @override
  String get cancel => 'Annuleren';

  @override
  String get delete => 'Verwijderen';

  @override
  String get allDocuments => 'Alle documenten';

  @override
  String get pdfOnly => 'Alleen PDF';

  @override
  String get wordOnly => 'Alleen Word';

  @override
  String get imagesOnly => 'Alleen afbeeldingen';

  @override
  String get settings => 'Instellingen';

  @override
  String get proMember => 'Pro-lid';

  @override
  String get proPlusMember => 'Pro+-lid';

  @override
  String get unlimitedAccess => 'Onbeperkte toegang';

  @override
  String get upgradeForMoreFeatures => 'Upgrade voor meer functies';

  @override
  String get preferences => 'Voorkeuren';

  @override
  String get support => 'Ondersteuning';

  @override
  String get account => 'Account';

  @override
  String get notifications => 'Meldingen';

  @override
  String get darkMode => 'Donkere modus';

  @override
  String get appLanguage => 'App-taal';

  @override
  String get summaryLanguage => 'Samenvattingstaal';

  @override
  String get helpFaq => 'Help & FAQ';

  @override
  String get rateApp => 'Beoordeel app';

  @override
  String get rateAppSub => 'Vind je DoCMind AI leuk? Beoordeel ons!';

  @override
  String get privacyPolicy => 'Privacybeleid';

  @override
  String get termsOfService => 'Servicevoorwaarden';

  @override
  String get restorePurchases => 'Aankopen herstellen';

  @override
  String get signOut => 'Uitloggen';

  @override
  String get deleteAccount => 'Account verwijderen';

  @override
  String get deleteAccountConfirm =>
      'Weet je zeker dat je je account wilt verwijderen? Dit kan niet ongedaan worden gemaakt.';

  @override
  String get deleteAccountTitle => 'Account verwijderen?';

  @override
  String appVersion(String version) {
    return 'DoCMind AI v$version';
  }

  @override
  String whatsNew(String version) {
    return 'Wat is er nieuw in v$version';
  }

  @override
  String get ok => 'OK';

  @override
  String get document => 'Document';

  @override
  String get failedToLoadDocument => 'Document laden mislukt';

  @override
  String get tryAgain => 'Opnieuw proberen';

  @override
  String get documentNotFound => 'Document niet gevonden';

  @override
  String get loadingPdf => 'PDF laden...';

  @override
  String get loadingPreview => 'Documentvoorbeeld laden...';

  @override
  String showingPage(int count) {
    return 'Pagina 1 van $count';
  }

  @override
  String get documentContent => 'Documentinhoud';

  @override
  String get noContentExtracted => 'Nog geen inhoud geëxtraheerd';

  @override
  String get previewNotAvailable => 'Voorbeeld niet beschikbaar';

  @override
  String get viewSummary => 'Samenvatting bekijken';

  @override
  String get generating => 'Bezig met genereren...';

  @override
  String get generateAiSummary => 'AI-samenvatting genereren';

  @override
  String pagesCount(int count) {
    return '$count pagina\'s';
  }

  @override
  String get uploadDocumentTitle => 'Document uploaden';

  @override
  String get tipReading => 'AI leest je document...';

  @override
  String get tipExtracting => 'Belangrijke informatie extraheren...';

  @override
  String get tipIdentifying => 'Belangrijke secties identificeren...';

  @override
  String get tipBuilding => 'Gestructureerde samenvatting opbouwen...';

  @override
  String get tipFinalizing => 'Bijna klaar, resultaten afronden...';

  @override
  String get stepUploading => 'Uploaden';

  @override
  String get stepExtractingText => 'Tekst extraheren';

  @override
  String get stepAiAnalyzing => 'AI-analyse';

  @override
  String get summaryLang => 'Samenvattingstaal';

  @override
  String uploadingProgress(int percent) {
    return 'Document uploaden... $percent%';
  }

  @override
  String get extractingText => 'Tekst uit je document extraheren...';

  @override
  String get aiAnalyzing => 'AI analyseert en vat samen...';

  @override
  String get preparing => 'Voorbereiden...';

  @override
  String get tapToUpload => 'Tik om een document te uploaden';

  @override
  String supportedFormats(int size) {
    return 'PDF, DOCX, JPG, PNG tot ${size}MB';
  }

  @override
  String get aiWillExtract => 'AI zal inhoud extraheren en samenvatten';

  @override
  String get freeLimitReached =>
      'Gratis limiet bereikt. Upgrade om door te gaan';

  @override
  String get readyToProcess => 'Klaar om te verwerken';

  @override
  String get chooseDifferentFile => 'Ander bestand kiezen';

  @override
  String get selectedFile => 'Geselecteerd bestand';

  @override
  String get generateSummary => 'Samenvatting genereren';

  @override
  String freePlanFileLimit(int size) {
    return 'Gratis abonnement limiet: max. ${size}MB per bestand. Upgrade om grotere documenten te uploaden.';
  }

  @override
  String fileSizeExceeded(int size) {
    return 'Bestandsgrootte overschrijdt je abonnementslimiet (max. ${size}MB). Upgrade voor grotere bestanden.';
  }

  @override
  String get freeLimitReachedTitle => 'Gratis limiet bereikt';

  @override
  String get freeLimitReachedMsg =>
      'Je hebt al je gratis documenten gebruikt. Upgrade naar Pro voor onbeperkte toegang!';

  @override
  String get maybeLater => 'Misschien later';

  @override
  String get upgradeNow => 'Nu upgraden';

  @override
  String get summary => 'Samenvatting';

  @override
  String get failedToLoadSummary => 'Samenvatting laden mislukt';

  @override
  String get summaryNotFound => 'Samenvatting niet gevonden';

  @override
  String get overview => 'Overzicht';

  @override
  String get keyPoints => 'Kernpunten';

  @override
  String get actionItems => 'Actiepunten';

  @override
  String get keywords => 'Trefwoorden';

  @override
  String get importantFacts => 'Belangrijke feiten';

  @override
  String get obligations => 'Verplichtingen';

  @override
  String get risks => 'Risico\'s';

  @override
  String get findings => 'Bevindingen';

  @override
  String wordsCount(int count) {
    return '$count woorden';
  }

  @override
  String processingTime(String seconds) {
    return '${seconds}s';
  }

  @override
  String get viewOriginalDocument => 'Origineel document bekijken';

  @override
  String get copySummary => 'Samenvatting kopiëren';

  @override
  String get summaryCopied => 'Samenvatting gekopieerd naar klembord';

  @override
  String get generatedBy => 'Gegenereerd door DoCMind AI';

  @override
  String wordCountLabel(int count) {
    return 'Aantal woorden: $count';
  }

  @override
  String processingTimeLabel(String seconds) {
    return 'Verwerkingstijd: ${seconds}s';
  }

  @override
  String get upgradeRequired => 'Upgrade vereist';

  @override
  String get translateProOnly =>
      'Vertaling is beschikbaar op Pro-abonnementen. Upgrade om samenvattingen te vertalen.';

  @override
  String get notNow => 'Niet nu';

  @override
  String get manageSubscription => 'Abonnement beheren';

  @override
  String get changeYourPlan => 'Plan wijzigen';

  @override
  String get unlockPremium => 'Premium ontgrendelen';

  @override
  String get upgradeOrSwitch => 'Upgraden of overschakelen naar ander plan';

  @override
  String get getUnlimitedAccess => 'Krijg onbeperkte toegang tot alle functies';

  @override
  String get monthly => 'Maandelijks';

  @override
  String get yearly => 'Jaarlijks';

  @override
  String get save40 => 'BESPAAR 40%';

  @override
  String get unlimitedDocuments => 'Onbeperkt documenten';

  @override
  String get unlimitedSummaries => 'Onbeperkt samenvattingen';

  @override
  String get priorityAiProcessing => 'Prioritaire AI-verwerking';

  @override
  String get exportToPdf => 'Exporteren naar PDF';

  @override
  String get emailSupport => 'E-mailondersteuning';

  @override
  String get everythingInPro => 'Alles in Pro';

  @override
  String get ocrScannedDocs => 'OCR voor gescande documenten';

  @override
  String get longDocSupport =>
      'Ondersteuning lange documenten (100+ pagina\'s)';

  @override
  String get advancedAiAnalysis => 'Geavanceerde AI-analyse';

  @override
  String get prioritySupport => 'Prioritaire ondersteuning';

  @override
  String get earlyAccess => 'Vroege toegang tot functies';

  @override
  String get freePlanInfo =>
      'Gratis abonnement bevat 2 documenten met maximaal 5 pagina\'s elk.';

  @override
  String get restoring => 'Herstellen...';

  @override
  String get current => 'HUIDIG';

  @override
  String get popular => 'POPULAIR';

  @override
  String get perYear => '/jaar';

  @override
  String get perMonth => '/maand';

  @override
  String get billedAnnually => 'Jaarlijks gefactureerd';

  @override
  String thatsOnly(String price) {
    return 'Dat is slechts $price/maand';
  }

  @override
  String get getPro => 'Pro krijgen';

  @override
  String get getProPlus => 'Pro+ krijgen';

  @override
  String get currentPlan => 'Huidig plan';

  @override
  String get switchToYearly => 'Overschakelen naar jaarlijks';

  @override
  String get switchToMonthly => 'Overschakelen naar maandelijks';

  @override
  String get upgradeToPro => 'Upgraden naar Pro';

  @override
  String get upgradeToProPlus => 'Upgraden naar Pro+';

  @override
  String get downgradeToPro => 'Downgraden naar Pro';

  @override
  String get downgradeToProPlus => 'Downgraden naar Pro+';

  @override
  String get changesAtEnd => 'Wijzigingen aan einde factureringsperiode';

  @override
  String autoRenews(String date) {
    return 'Automatische verlenging $date';
  }

  @override
  String expires(String date) {
    return 'Verloopt $date';
  }

  @override
  String get soon => 'binnenkort';

  @override
  String get active => 'ACTIEF';

  @override
  String get downgradePlan => 'Plan downgraden';

  @override
  String get downgradeConfirm =>
      'Je plan wordt aan het einde van je huidige factureringsperiode gedowngraded. Je behoudt je huidige functies tot dan.';

  @override
  String get confirmDowngrade => 'Downgrade bevestigen';

  @override
  String get welcomeBack => 'Welkom terug';

  @override
  String get signInContinue => 'Log in om door te gaan naar DoCMind AI';

  @override
  String get createAccountToStart => 'Maak een account aan om te beginnen';

  @override
  String get emailAddress => 'E-mailadres';

  @override
  String get password => 'Wachtwoord';

  @override
  String get enterEmail => 'Voer je e-mailadres in';

  @override
  String get validEmail => 'Voer een geldig e-mailadres in';

  @override
  String get enterPassword => 'Voer je wachtwoord in';

  @override
  String get passwordMinLength => 'Wachtwoord moet minimaal 8 tekens bevatten';

  @override
  String get signIn => 'Inloggen';

  @override
  String get createAccount => 'Account aanmaken';

  @override
  String get orContinueWith => 'of ga verder met';

  @override
  String get continueWithApple => 'Doorgaan met Apple';

  @override
  String get tryWithoutAccount => 'Proberen zonder account';

  @override
  String get noAccount => 'Geen account? ';

  @override
  String get haveAccount => 'Heb je al een account? ';

  @override
  String get signUp => 'Registreren';

  @override
  String get tryDoCMindAi => 'Probeer DoCMind AI';

  @override
  String trialsLeft(int count) {
    return '$count proef(versie) over';
  }

  @override
  String get noTrialsRemaining => 'Geen proefversies meer';

  @override
  String get summarizeNow => 'Nu samenvatten';

  @override
  String get analyzingDocument => 'Document analyseren...';

  @override
  String get thisMayTakeAMoment => 'Dit kan even duren';

  @override
  String get guestModeLimitations => 'Beperkingen gastmodus';

  @override
  String get maxPagesGuest => 'Max. 2 pagina\'s per document';

  @override
  String get twoTrialsOnly => 'Slechts 2 proefversies in totaal (geen reset)';

  @override
  String get notSavedToHistory =>
      'Samenvatting niet opgeslagen in geschiedenis';

  @override
  String get noCloudSync => 'Geen cloudsynchronisatie';

  @override
  String get withFreeAccount => 'Met een gratis account krijg je:';

  @override
  String get upToFivePages => 'Tot 5 pagina\'s per document';

  @override
  String get threeDocsPerDay => '3 documenten per dag';

  @override
  String get historySavedForever => 'Geschiedenis voor altijd opgeslagen';

  @override
  String get cloudSyncDevices => 'Cloudsynchronisatie over apparaten';

  @override
  String get wantUnlimitedAccess => 'Wil je onbeperkte toegang?';

  @override
  String get createFreeForMore => 'Maak een gratis account voor meer functies';

  @override
  String get createFreeAccount => 'Gratis account aanmaken';

  @override
  String get selectDocSource => 'Documentbron selecteren';

  @override
  String get browseFiles => 'Bestanden bladeren';

  @override
  String get pdfWordDocs => 'PDF, Word-documenten';

  @override
  String get takePhoto => 'Foto maken';

  @override
  String get captureDocCamera => 'Document vastleggen met camera';

  @override
  String get photoLibrary => 'Fotobibliotheek';

  @override
  String get selectFromGallery => 'Selecteren uit galerij';

  @override
  String get fileTooLargeGuest =>
      'Bestand te groot. Maximaal 5MB in gastmodus.';

  @override
  String get failedPickFile => 'Bestand selecteren mislukt';

  @override
  String get failedCapturePhoto => 'Foto vastleggen mislukt';

  @override
  String get failedPickImage => 'Afbeelding selecteren mislukt';

  @override
  String get trialLimitReached => 'Proeflimiet bereikt';

  @override
  String get trialLimitMsg =>
      'Je hebt al je gratis proefversies gebruikt. Maak een account aan om DoCMind AI met onbeperkte toegang te blijven gebruiken.';

  @override
  String get noSummaryAvailable => 'Geen samenvatting beschikbaar';

  @override
  String get summaryNotSaved =>
      'Deze samenvatting wordt niet opgeslagen. Maak een account aan om het te bewaren!';

  @override
  String get documentSummary => 'Documentsamenvatting';

  @override
  String get noOverviewAvailable => 'Geen overzicht beschikbaar';

  @override
  String moreKeyPoints(int count) {
    return '$count meer kernpunten';
  }

  @override
  String itemsCount(int count) {
    return '$count items';
  }

  @override
  String get createFreeToUnlock => 'Maak gratis account aan om te ontgrendelen';

  @override
  String trialsRemaining(int count) {
    return '$count proef(versie) over';
  }

  @override
  String get createAccountContinue =>
      'Maak een account aan om DoCMind AI te blijven gebruiken';

  @override
  String get createAccountUnlimited =>
      'Maak een account aan voor onbeperkte samenvattingen';

  @override
  String get close => 'Sluiten';

  @override
  String get processingFailed =>
      'Documentverwerking mislukt. Probeer het opnieuw.';

  @override
  String get processingTakingLong =>
      'Verwerking duurt langer dan verwacht. Controleer Geschiedenis voor de status.';

  @override
  String get translating => 'Vertalen';

  @override
  String get aiTranslatingYourSummary => 'AI vertaalt uw samenvatting';

  @override
  String get translationComplete => 'Vertaling voltooid';

  @override
  String translatedTo(String language) {
    return 'Vertaald naar $language';
  }

  @override
  String originalLanguage(String language) {
    return 'Origineel: $language';
  }

  @override
  String generatedOn(String date) {
    return 'Gegenereerd op $date';
  }

  @override
  String get pleaseWait => 'Even geduld';

  @override
  String get updateRequired => 'Update vereist';

  @override
  String get updateRequiredMsg =>
      'Er is een nieuwe versie van DoCMind AI beschikbaar. Werk de app bij om deze te blijven gebruiken.';

  @override
  String get updateNow => 'Nu bijwerken';
}
