// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class SEn extends S {
  SEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'DoCMind AI';

  @override
  String get appTagline => 'OCR, Doc & AI Summarizer';

  @override
  String get navHome => 'Home';

  @override
  String get navHistory => 'History';

  @override
  String get navSettings => 'Settings';

  @override
  String get addDocument => 'Add document';

  @override
  String get optionDocument => 'Document';

  @override
  String get optionDocumentSub => 'PDF, Word, or other files';

  @override
  String get optionGallery => 'Gallery';

  @override
  String get optionGallerySub => 'Choose from photo library';

  @override
  String get optionCamera => 'Camera';

  @override
  String get optionCameraSub => 'Take a photo';

  @override
  String get greeting => 'Hello, there';

  @override
  String get planPro => 'Pro';

  @override
  String get planProPlus => 'Pro+';

  @override
  String get planFree => 'Free';

  @override
  String get quickActions => 'Quick Actions';

  @override
  String get recentDocuments => 'Recent Documents';

  @override
  String get upload => 'Upload';

  @override
  String get uploadFormats => 'PDF, DOCX, Image';

  @override
  String get history => 'History';

  @override
  String get viewAllDocs => 'View all docs';

  @override
  String get seeAll => 'See All';

  @override
  String get noDocumentsYet => 'No documents yet';

  @override
  String get uploadFirstDoc =>
      'Upload your first document and let AI summarize it for you';

  @override
  String get uploadDocument => 'Upload Document';

  @override
  String get premiumActive => 'Premium Active';

  @override
  String get unlimitedDocsSummaries => 'Unlimited documents & summaries';

  @override
  String get freePlan => 'Free Plan';

  @override
  String get noFreeDocsLeft => 'No free docs left';

  @override
  String freeLeftCount(int count) {
    return '$count free left';
  }

  @override
  String get upgradeForUnlimited => 'Upgrade for unlimited access';

  @override
  String freeDocsUsed(int used, int limit) {
    return '$used of $limit free documents used';
  }

  @override
  String get upgrade => 'Upgrade';

  @override
  String get failed => 'Failed';

  @override
  String minAgo(int count) {
    return '$count min ago';
  }

  @override
  String hoursAgo(int count) {
    return '${count}h ago';
  }

  @override
  String get yesterday => 'Yesterday';

  @override
  String daysAgo(int count) {
    return '$count days ago';
  }

  @override
  String get clearFilters => 'Clear filters';

  @override
  String get documentDeleted => 'Document deleted';

  @override
  String get noDocumentsFiltered => 'No documents found';

  @override
  String get tryRemovingFilters =>
      'Try removing filters or uploading\nnew documents';

  @override
  String get clearFiltersButton => 'Clear Filters';

  @override
  String get deleteDocument => 'Delete Document';

  @override
  String get deleteDocumentConfirm =>
      'Are you sure you want to delete this document?';

  @override
  String get deleteDocumentConfirmFull =>
      'Are you sure you want to delete this document? This action cannot be undone.';

  @override
  String get cancel => 'Cancel';

  @override
  String get delete => 'Delete';

  @override
  String get allDocuments => 'All Documents';

  @override
  String get pdfOnly => 'PDF Only';

  @override
  String get wordOnly => 'Word Only';

  @override
  String get imagesOnly => 'Images Only';

  @override
  String get settings => 'Settings';

  @override
  String get proMember => 'Pro Member';

  @override
  String get proPlusMember => 'Pro+ Member';

  @override
  String get unlimitedAccess => 'Unlimited access';

  @override
  String get upgradeForMoreFeatures => 'Upgrade for more features';

  @override
  String get preferences => 'Preferences';

  @override
  String get support => 'Support';

  @override
  String get account => 'Account';

  @override
  String get notifications => 'Notifications';

  @override
  String get darkMode => 'Dark Mode';

  @override
  String get appLanguage => 'App Language';

  @override
  String get summaryLanguage => 'Summary Language';

  @override
  String get helpFaq => 'Help & FAQ';

  @override
  String get rateApp => 'Rate App';

  @override
  String get rateAppSub => 'Love DoCMind AI? Rate us!';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get termsOfService => 'Terms of Service';

  @override
  String get restorePurchases => 'Restore Purchases';

  @override
  String get signOut => 'Sign Out';

  @override
  String get deleteAccount => 'Delete Account';

  @override
  String get deleteAccountConfirm =>
      'Are you sure you want to delete your account? This cannot be undone.';

  @override
  String get deleteAccountTitle => 'Delete Account?';

  @override
  String appVersion(String version) {
    return 'DoCMind AI v$version';
  }

  @override
  String whatsNew(String version) {
    return 'What\'s New in v$version';
  }

  @override
  String get ok => 'OK';

  @override
  String get document => 'Document';

  @override
  String get failedToLoadDocument => 'Failed to load document';

  @override
  String get tryAgain => 'Try Again';

  @override
  String get documentNotFound => 'Document not found';

  @override
  String get loadingPdf => 'Loading PDF...';

  @override
  String get loadingPreview => 'Loading document preview...';

  @override
  String showingPage(int count) {
    return 'Showing page 1 of $count';
  }

  @override
  String get documentContent => 'Document Content';

  @override
  String get noContentExtracted => 'No content extracted yet';

  @override
  String get previewNotAvailable => 'Preview not available';

  @override
  String get viewSummary => 'View Summary';

  @override
  String get generating => 'Generating...';

  @override
  String get generateAiSummary => 'Generate AI Summary';

  @override
  String pagesCount(int count) {
    return '$count pages';
  }

  @override
  String get uploadDocumentTitle => 'Upload Document';

  @override
  String get tipReading => 'AI is reading through your document...';

  @override
  String get tipExtracting => 'Extracting key information...';

  @override
  String get tipIdentifying => 'Identifying important sections...';

  @override
  String get tipBuilding => 'Building a structured summary...';

  @override
  String get tipFinalizing => 'Almost there, finalizing results...';

  @override
  String get stepUploading => 'Uploading';

  @override
  String get stepExtractingText => 'Extracting Text';

  @override
  String get stepAiAnalyzing => 'AI Analyzing';

  @override
  String get summaryLang => 'Summary language';

  @override
  String uploadingProgress(int percent) {
    return 'Uploading your document... $percent%';
  }

  @override
  String get extractingText => 'Extracting text from your document...';

  @override
  String get aiAnalyzing => 'AI is analyzing and summarizing...';

  @override
  String get preparing => 'Preparing...';

  @override
  String get tapToUpload => 'Tap to upload a document';

  @override
  String supportedFormats(int size) {
    return 'PDF, DOCX, JPG, PNG up to ${size}MB';
  }

  @override
  String get aiWillExtract => 'AI will extract and summarize content';

  @override
  String get freeLimitReached => 'Free limit reached. Upgrade to continue';

  @override
  String get readyToProcess => 'Ready to process';

  @override
  String get chooseDifferentFile => 'Choose Different File';

  @override
  String get selectedFile => 'Selected file';

  @override
  String get generateSummary => 'Generate Summary';

  @override
  String freePlanFileLimit(int size) {
    return 'Free plan limit: max ${size}MB per file. Upgrade to upload larger documents.';
  }

  @override
  String fileSizeExceeded(int size) {
    return 'File size exceeds your plan limit (max ${size}MB). Upgrade for larger files.';
  }

  @override
  String get freeLimitReachedTitle => 'Free Limit Reached';

  @override
  String get freeLimitReachedMsg =>
      'You\'ve used all your free documents. Upgrade to Pro for unlimited access!';

  @override
  String get maybeLater => 'Maybe Later';

  @override
  String get upgradeNow => 'Upgrade Now';

  @override
  String get summary => 'Summary';

  @override
  String get failedToLoadSummary => 'Failed to load summary';

  @override
  String get summaryNotFound => 'Summary not found';

  @override
  String get overview => 'Overview';

  @override
  String get keyPoints => 'Key Points';

  @override
  String get actionItems => 'Action Items';

  @override
  String get keywords => 'Keywords';

  @override
  String get importantFacts => 'Important Facts';

  @override
  String get obligations => 'Obligations';

  @override
  String get risks => 'Risks';

  @override
  String get findings => 'Findings';

  @override
  String wordsCount(int count) {
    return '$count words';
  }

  @override
  String processingTime(String seconds) {
    return '${seconds}s';
  }

  @override
  String get viewOriginalDocument => 'View Original Document';

  @override
  String get copySummary => 'Copy Summary';

  @override
  String get summaryCopied => 'Summary copied to clipboard';

  @override
  String get generatedBy => 'Generated by DoCMind AI';

  @override
  String wordCountLabel(int count) {
    return 'Word count: $count';
  }

  @override
  String processingTimeLabel(String seconds) {
    return 'Processing time: ${seconds}s';
  }

  @override
  String get upgradeRequired => 'Upgrade required';

  @override
  String get translateProOnly =>
      'Translation is available on Pro plans. Upgrade to translate summaries.';

  @override
  String get notNow => 'Not now';

  @override
  String get manageSubscription => 'Manage Subscription';

  @override
  String get changeYourPlan => 'Change Your Plan';

  @override
  String get unlockPremium => 'Unlock Premium';

  @override
  String get upgradeOrSwitch => 'Upgrade or switch to a different plan';

  @override
  String get getUnlimitedAccess => 'Get unlimited access to all features';

  @override
  String get monthly => 'Monthly';

  @override
  String get yearly => 'Yearly';

  @override
  String get save40 => 'SAVE 40%';

  @override
  String get unlimitedDocuments => 'Unlimited documents';

  @override
  String get unlimitedSummaries => 'Unlimited summaries';

  @override
  String get priorityAiProcessing => 'Priority AI processing';

  @override
  String get exportToPdf => 'Export to PDF';

  @override
  String get emailSupport => 'Email support';

  @override
  String get everythingInPro => 'Everything in Pro';

  @override
  String get ocrScannedDocs => 'OCR for scanned documents';

  @override
  String get longDocSupport => 'Long document support (100+ pages)';

  @override
  String get advancedAiAnalysis => 'Advanced AI analysis';

  @override
  String get prioritySupport => 'Priority support';

  @override
  String get earlyAccess => 'Early access to features';

  @override
  String get freePlanInfo =>
      'Free plan includes 2 documents with up to 5 pages each.';

  @override
  String get restoring => 'Restoring...';

  @override
  String get current => 'CURRENT';

  @override
  String get popular => 'POPULAR';

  @override
  String get perYear => '/year';

  @override
  String get perMonth => '/month';

  @override
  String get billedAnnually => 'Billed annually';

  @override
  String thatsOnly(String price) {
    return 'That\'s only $price/month';
  }

  @override
  String get getPro => 'Get Pro';

  @override
  String get getProPlus => 'Get Pro+';

  @override
  String get currentPlan => 'Current Plan';

  @override
  String get switchToYearly => 'Switch to Yearly';

  @override
  String get switchToMonthly => 'Switch to Monthly';

  @override
  String get upgradeToPro => 'Upgrade to Pro';

  @override
  String get upgradeToProPlus => 'Upgrade to Pro+';

  @override
  String get downgradeToPro => 'Downgrade to Pro';

  @override
  String get downgradeToProPlus => 'Downgrade to Pro+';

  @override
  String get changesAtEnd => 'Changes at end of billing period';

  @override
  String autoRenews(String date) {
    return 'Auto-renews $date';
  }

  @override
  String expires(String date) {
    return 'Expires $date';
  }

  @override
  String get soon => 'soon';

  @override
  String get active => 'ACTIVE';

  @override
  String get downgradePlan => 'Downgrade Plan';

  @override
  String get downgradeConfirm =>
      'Your plan will be downgraded at the end of your current billing period. You will keep your current features until then.';

  @override
  String get confirmDowngrade => 'Confirm Downgrade';

  @override
  String get welcomeBack => 'Welcome Back';

  @override
  String get signInContinue => 'Sign in to continue to DoCMind AI';

  @override
  String get createAccountToStart => 'Create your account to get started';

  @override
  String get emailAddress => 'Email address';

  @override
  String get password => 'Password';

  @override
  String get enterEmail => 'Please enter your email';

  @override
  String get validEmail => 'Please enter a valid email';

  @override
  String get enterPassword => 'Please enter your password';

  @override
  String get passwordMinLength => 'Password must be at least 8 characters';

  @override
  String get signIn => 'Sign In';

  @override
  String get createAccount => 'Create Account';

  @override
  String get orContinueWith => 'or continue with';

  @override
  String get continueWithApple => 'Continue with Apple';

  @override
  String get tryWithoutAccount => 'Try Without Account';

  @override
  String get noAccount => 'Don\'t have an account? ';

  @override
  String get haveAccount => 'Already have an account? ';

  @override
  String get signUp => 'Sign Up';

  @override
  String get tryDoCMindAi => 'Try DoCMind AI';

  @override
  String trialsLeft(int count) {
    return '$count trial(s) left';
  }

  @override
  String get noTrialsRemaining => 'No trials remaining';

  @override
  String get summarizeNow => 'Summarize Now';

  @override
  String get analyzingDocument => 'Analyzing your document...';

  @override
  String get thisMayTakeAMoment => 'This may take a moment';

  @override
  String get guestModeLimitations => 'Guest Mode Limitations';

  @override
  String get maxPagesGuest => 'Max 2 pages per document';

  @override
  String get twoTrialsOnly => 'Only 2 total trials (no reset)';

  @override
  String get notSavedToHistory => 'Summary not saved to history';

  @override
  String get noCloudSync => 'No cloud sync';

  @override
  String get withFreeAccount => 'With a free account you get:';

  @override
  String get upToFivePages => 'Up to 5 pages per document';

  @override
  String get threeDocsPerDay => '3 documents per day';

  @override
  String get historySavedForever => 'History saved forever';

  @override
  String get cloudSyncDevices => 'Cloud sync across devices';

  @override
  String get wantUnlimitedAccess => 'Want unlimited access?';

  @override
  String get createFreeForMore => 'Create a free account for more features';

  @override
  String get createFreeAccount => 'Create Free Account';

  @override
  String get selectDocSource => 'Select Document Source';

  @override
  String get browseFiles => 'Browse Files';

  @override
  String get pdfWordDocs => 'PDF, Word documents';

  @override
  String get takePhoto => 'Take Photo';

  @override
  String get captureDocCamera => 'Capture document with camera';

  @override
  String get photoLibrary => 'Photo Library';

  @override
  String get selectFromGallery => 'Select from gallery';

  @override
  String get fileTooLargeGuest => 'File too large. Maximum 5MB for guest mode.';

  @override
  String get failedPickFile => 'Failed to pick file';

  @override
  String get failedCapturePhoto => 'Failed to capture photo';

  @override
  String get failedPickImage => 'Failed to pick image';

  @override
  String get trialLimitReached => 'Trial Limit Reached';

  @override
  String get trialLimitMsg =>
      'You have used all your free trials. Create an account to continue using DoCMind AI with unlimited access.';

  @override
  String get noSummaryAvailable => 'No summary available';

  @override
  String get summaryNotSaved =>
      'This summary won\'t be saved. Create an account to keep it!';

  @override
  String get documentSummary => 'Document Summary';

  @override
  String get noOverviewAvailable => 'No overview available';

  @override
  String moreKeyPoints(int count) {
    return '$count more key points';
  }

  @override
  String itemsCount(int count) {
    return '$count items';
  }

  @override
  String get createFreeToUnlock => 'Create Free Account to Unlock';

  @override
  String trialsRemaining(int count) {
    return '$count Trial(s) Remaining';
  }

  @override
  String get createAccountContinue =>
      'Create an account to continue using DoCMind AI';

  @override
  String get createAccountUnlimited =>
      'Create an account for unlimited summaries';

  @override
  String get close => 'Close';

  @override
  String get processingFailed =>
      'Document processing failed. Please try again.';

  @override
  String get processingTakingLong =>
      'Processing is taking longer than expected. Check History for status.';

  @override
  String get translating => 'Translating';

  @override
  String get aiTranslatingYourSummary => 'AI is translating your summary';

  @override
  String get translationComplete => 'Translation complete';

  @override
  String translatedTo(String language) {
    return 'Translated to $language';
  }

  @override
  String originalLanguage(String language) {
    return 'Original: $language';
  }

  @override
  String generatedOn(String date) {
    return 'Generated on $date';
  }

  @override
  String get pleaseWait => 'Please wait';

  @override
  String get updateRequired => 'Update Required';

  @override
  String get updateRequiredMsg =>
      'A new version of DoCMind AI is available. Please update to continue using the app.';

  @override
  String get updateNow => 'Update Now';
}
