import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_id.dart';
import 'app_localizations_it.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_nl.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_tr.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of S
/// returned by `S.of(context)`.
///
/// Applications need to include `S.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: S.localizationsDelegates,
///   supportedLocales: S.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the S.supportedLocales
/// property.
abstract class S {
  S(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static S? of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  static const LocalizationsDelegate<S> delegate = _SDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('id'),
    Locale('it'),
    Locale('ja'),
    Locale('nl'),
    Locale('pt'),
    Locale('ru'),
    Locale('tr'),
    Locale('zh'),
    Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hant')
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'DoCMind AI'**
  String get appName;

  /// No description provided for @appTagline.
  ///
  /// In en, this message translates to:
  /// **'OCR, Doc & AI Summarizer'**
  String get appTagline;

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navHistory.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get navHistory;

  /// No description provided for @navSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get navSettings;

  /// No description provided for @addDocument.
  ///
  /// In en, this message translates to:
  /// **'Add document'**
  String get addDocument;

  /// No description provided for @optionDocument.
  ///
  /// In en, this message translates to:
  /// **'Document'**
  String get optionDocument;

  /// No description provided for @optionDocumentSub.
  ///
  /// In en, this message translates to:
  /// **'PDF, Word, or other files'**
  String get optionDocumentSub;

  /// No description provided for @optionGallery.
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get optionGallery;

  /// No description provided for @optionGallerySub.
  ///
  /// In en, this message translates to:
  /// **'Choose from photo library'**
  String get optionGallerySub;

  /// No description provided for @optionCamera.
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get optionCamera;

  /// No description provided for @optionCameraSub.
  ///
  /// In en, this message translates to:
  /// **'Take a photo'**
  String get optionCameraSub;

  /// No description provided for @greeting.
  ///
  /// In en, this message translates to:
  /// **'Hello, there'**
  String get greeting;

  /// No description provided for @planPro.
  ///
  /// In en, this message translates to:
  /// **'Pro'**
  String get planPro;

  /// No description provided for @planProPlus.
  ///
  /// In en, this message translates to:
  /// **'Pro+'**
  String get planProPlus;

  /// No description provided for @planFree.
  ///
  /// In en, this message translates to:
  /// **'Free'**
  String get planFree;

  /// No description provided for @quickActions.
  ///
  /// In en, this message translates to:
  /// **'Quick Actions'**
  String get quickActions;

  /// No description provided for @recentDocuments.
  ///
  /// In en, this message translates to:
  /// **'Recent Documents'**
  String get recentDocuments;

  /// No description provided for @upload.
  ///
  /// In en, this message translates to:
  /// **'Upload'**
  String get upload;

  /// No description provided for @uploadFormats.
  ///
  /// In en, this message translates to:
  /// **'PDF, DOCX, Image'**
  String get uploadFormats;

  /// No description provided for @history.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get history;

  /// No description provided for @viewAllDocs.
  ///
  /// In en, this message translates to:
  /// **'View all docs'**
  String get viewAllDocs;

  /// No description provided for @seeAll.
  ///
  /// In en, this message translates to:
  /// **'See All'**
  String get seeAll;

  /// No description provided for @noDocumentsYet.
  ///
  /// In en, this message translates to:
  /// **'No documents yet'**
  String get noDocumentsYet;

  /// No description provided for @uploadFirstDoc.
  ///
  /// In en, this message translates to:
  /// **'Upload your first document and let AI summarize it for you'**
  String get uploadFirstDoc;

  /// No description provided for @uploadDocument.
  ///
  /// In en, this message translates to:
  /// **'Upload Document'**
  String get uploadDocument;

  /// No description provided for @premiumActive.
  ///
  /// In en, this message translates to:
  /// **'Premium Active'**
  String get premiumActive;

  /// No description provided for @unlimitedDocsSummaries.
  ///
  /// In en, this message translates to:
  /// **'Unlimited documents & summaries'**
  String get unlimitedDocsSummaries;

  /// No description provided for @freePlan.
  ///
  /// In en, this message translates to:
  /// **'Free Plan'**
  String get freePlan;

  /// No description provided for @noFreeDocsLeft.
  ///
  /// In en, this message translates to:
  /// **'No free docs left'**
  String get noFreeDocsLeft;

  /// No description provided for @freeLeftCount.
  ///
  /// In en, this message translates to:
  /// **'{count} free left'**
  String freeLeftCount(int count);

  /// No description provided for @upgradeForUnlimited.
  ///
  /// In en, this message translates to:
  /// **'Upgrade for unlimited access'**
  String get upgradeForUnlimited;

  /// No description provided for @freeDocsUsed.
  ///
  /// In en, this message translates to:
  /// **'{used} of {limit} free documents used'**
  String freeDocsUsed(int used, int limit);

  /// No description provided for @upgrade.
  ///
  /// In en, this message translates to:
  /// **'Upgrade'**
  String get upgrade;

  /// No description provided for @failed.
  ///
  /// In en, this message translates to:
  /// **'Failed'**
  String get failed;

  /// No description provided for @minAgo.
  ///
  /// In en, this message translates to:
  /// **'{count} min ago'**
  String minAgo(int count);

  /// No description provided for @hoursAgo.
  ///
  /// In en, this message translates to:
  /// **'{count}h ago'**
  String hoursAgo(int count);

  /// No description provided for @yesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get yesterday;

  /// No description provided for @daysAgo.
  ///
  /// In en, this message translates to:
  /// **'{count} days ago'**
  String daysAgo(int count);

  /// No description provided for @clearFilters.
  ///
  /// In en, this message translates to:
  /// **'Clear filters'**
  String get clearFilters;

  /// No description provided for @documentDeleted.
  ///
  /// In en, this message translates to:
  /// **'Document deleted'**
  String get documentDeleted;

  /// No description provided for @noDocumentsFiltered.
  ///
  /// In en, this message translates to:
  /// **'No documents found'**
  String get noDocumentsFiltered;

  /// No description provided for @tryRemovingFilters.
  ///
  /// In en, this message translates to:
  /// **'Try removing filters or uploading\nnew documents'**
  String get tryRemovingFilters;

  /// No description provided for @clearFiltersButton.
  ///
  /// In en, this message translates to:
  /// **'Clear Filters'**
  String get clearFiltersButton;

  /// No description provided for @deleteDocument.
  ///
  /// In en, this message translates to:
  /// **'Delete Document'**
  String get deleteDocument;

  /// No description provided for @deleteDocumentConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this document?'**
  String get deleteDocumentConfirm;

  /// No description provided for @deleteDocumentConfirmFull.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this document? This action cannot be undone.'**
  String get deleteDocumentConfirmFull;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @allDocuments.
  ///
  /// In en, this message translates to:
  /// **'All Documents'**
  String get allDocuments;

  /// No description provided for @pdfOnly.
  ///
  /// In en, this message translates to:
  /// **'PDF Only'**
  String get pdfOnly;

  /// No description provided for @wordOnly.
  ///
  /// In en, this message translates to:
  /// **'Word Only'**
  String get wordOnly;

  /// No description provided for @imagesOnly.
  ///
  /// In en, this message translates to:
  /// **'Images Only'**
  String get imagesOnly;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @proMember.
  ///
  /// In en, this message translates to:
  /// **'Pro Member'**
  String get proMember;

  /// No description provided for @proPlusMember.
  ///
  /// In en, this message translates to:
  /// **'Pro+ Member'**
  String get proPlusMember;

  /// No description provided for @unlimitedAccess.
  ///
  /// In en, this message translates to:
  /// **'Unlimited access'**
  String get unlimitedAccess;

  /// No description provided for @upgradeForMoreFeatures.
  ///
  /// In en, this message translates to:
  /// **'Upgrade for more features'**
  String get upgradeForMoreFeatures;

  /// No description provided for @preferences.
  ///
  /// In en, this message translates to:
  /// **'Preferences'**
  String get preferences;

  /// No description provided for @support.
  ///
  /// In en, this message translates to:
  /// **'Support'**
  String get support;

  /// No description provided for @account.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get account;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkMode;

  /// No description provided for @appLanguage.
  ///
  /// In en, this message translates to:
  /// **'App Language'**
  String get appLanguage;

  /// No description provided for @summaryLanguage.
  ///
  /// In en, this message translates to:
  /// **'Summary Language'**
  String get summaryLanguage;

  /// No description provided for @helpFaq.
  ///
  /// In en, this message translates to:
  /// **'Help & FAQ'**
  String get helpFaq;

  /// No description provided for @rateApp.
  ///
  /// In en, this message translates to:
  /// **'Rate App'**
  String get rateApp;

  /// No description provided for @rateAppSub.
  ///
  /// In en, this message translates to:
  /// **'Love DoCMind AI? Rate us!'**
  String get rateAppSub;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @termsOfService.
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get termsOfService;

  /// No description provided for @restorePurchases.
  ///
  /// In en, this message translates to:
  /// **'Restore Purchases'**
  String get restorePurchases;

  /// No description provided for @signOut.
  ///
  /// In en, this message translates to:
  /// **'Sign Out'**
  String get signOut;

  /// No description provided for @deleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get deleteAccount;

  /// No description provided for @deleteAccountConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete your account? This cannot be undone.'**
  String get deleteAccountConfirm;

  /// No description provided for @deleteAccountTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Account?'**
  String get deleteAccountTitle;

  /// No description provided for @deleteAccountSuccess.
  ///
  /// In en, this message translates to:
  /// **'Your data has been deleted successfully.'**
  String get deleteAccountSuccess;

  /// No description provided for @deleteAccountFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not delete your data. Please try again.'**
  String get deleteAccountFailed;

  /// No description provided for @signOutConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to sign out?'**
  String get signOutConfirm;

  /// No description provided for @subscriptionLegalDisclosure.
  ///
  /// In en, this message translates to:
  /// **'Payment will be charged to your Apple ID account at confirmation of purchase. Subscription automatically renews unless it is canceled at least 24 hours before the end of the current period. Your account will be charged for renewal within 24 hours prior to the end of the current period. You can manage and cancel subscriptions in your App Store account settings.'**
  String get subscriptionLegalDisclosure;

  /// No description provided for @manageInAppStore.
  ///
  /// In en, this message translates to:
  /// **'Manage in App Store'**
  String get manageInAppStore;

  /// No description provided for @pricesLoading.
  ///
  /// In en, this message translates to:
  /// **'Loading prices...'**
  String get pricesLoading;

  /// No description provided for @appVersion.
  ///
  /// In en, this message translates to:
  /// **'DoCMind AI v{version}'**
  String appVersion(String version);

  /// No description provided for @whatsNew.
  ///
  /// In en, this message translates to:
  /// **'What\'s New in v{version}'**
  String whatsNew(String version);

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @document.
  ///
  /// In en, this message translates to:
  /// **'Document'**
  String get document;

  /// No description provided for @failedToLoadDocument.
  ///
  /// In en, this message translates to:
  /// **'Failed to load document'**
  String get failedToLoadDocument;

  /// No description provided for @tryAgain.
  ///
  /// In en, this message translates to:
  /// **'Try Again'**
  String get tryAgain;

  /// No description provided for @documentNotFound.
  ///
  /// In en, this message translates to:
  /// **'Document not found'**
  String get documentNotFound;

  /// No description provided for @loadingPdf.
  ///
  /// In en, this message translates to:
  /// **'Loading PDF...'**
  String get loadingPdf;

  /// No description provided for @loadingPreview.
  ///
  /// In en, this message translates to:
  /// **'Loading document preview...'**
  String get loadingPreview;

  /// No description provided for @showingPage.
  ///
  /// In en, this message translates to:
  /// **'Showing page 1 of {count}'**
  String showingPage(int count);

  /// No description provided for @documentContent.
  ///
  /// In en, this message translates to:
  /// **'Document Content'**
  String get documentContent;

  /// No description provided for @noContentExtracted.
  ///
  /// In en, this message translates to:
  /// **'No content extracted yet'**
  String get noContentExtracted;

  /// No description provided for @previewNotAvailable.
  ///
  /// In en, this message translates to:
  /// **'Preview not available'**
  String get previewNotAvailable;

  /// No description provided for @viewSummary.
  ///
  /// In en, this message translates to:
  /// **'View Summary'**
  String get viewSummary;

  /// No description provided for @generating.
  ///
  /// In en, this message translates to:
  /// **'Generating...'**
  String get generating;

  /// No description provided for @generateAiSummary.
  ///
  /// In en, this message translates to:
  /// **'Generate AI Summary'**
  String get generateAiSummary;

  /// No description provided for @pagesCount.
  ///
  /// In en, this message translates to:
  /// **'{count} pages'**
  String pagesCount(int count);

  /// No description provided for @uploadDocumentTitle.
  ///
  /// In en, this message translates to:
  /// **'Upload Document'**
  String get uploadDocumentTitle;

  /// No description provided for @tipReading.
  ///
  /// In en, this message translates to:
  /// **'AI is reading through your document...'**
  String get tipReading;

  /// No description provided for @tipExtracting.
  ///
  /// In en, this message translates to:
  /// **'Extracting key information...'**
  String get tipExtracting;

  /// No description provided for @tipIdentifying.
  ///
  /// In en, this message translates to:
  /// **'Identifying important sections...'**
  String get tipIdentifying;

  /// No description provided for @tipBuilding.
  ///
  /// In en, this message translates to:
  /// **'Building a structured summary...'**
  String get tipBuilding;

  /// No description provided for @tipFinalizing.
  ///
  /// In en, this message translates to:
  /// **'Almost there, finalizing results...'**
  String get tipFinalizing;

  /// No description provided for @stepUploading.
  ///
  /// In en, this message translates to:
  /// **'Uploading'**
  String get stepUploading;

  /// No description provided for @stepExtractingText.
  ///
  /// In en, this message translates to:
  /// **'Extracting Text'**
  String get stepExtractingText;

  /// No description provided for @stepAiAnalyzing.
  ///
  /// In en, this message translates to:
  /// **'AI Analyzing'**
  String get stepAiAnalyzing;

  /// No description provided for @summaryLang.
  ///
  /// In en, this message translates to:
  /// **'Summary language'**
  String get summaryLang;

  /// No description provided for @uploadingProgress.
  ///
  /// In en, this message translates to:
  /// **'Uploading your document... {percent}%'**
  String uploadingProgress(int percent);

  /// No description provided for @extractingText.
  ///
  /// In en, this message translates to:
  /// **'Extracting text from your document...'**
  String get extractingText;

  /// No description provided for @aiAnalyzing.
  ///
  /// In en, this message translates to:
  /// **'AI is analyzing and summarizing...'**
  String get aiAnalyzing;

  /// No description provided for @preparing.
  ///
  /// In en, this message translates to:
  /// **'Preparing...'**
  String get preparing;

  /// No description provided for @tapToUpload.
  ///
  /// In en, this message translates to:
  /// **'Tap to upload a document'**
  String get tapToUpload;

  /// No description provided for @supportedFormats.
  ///
  /// In en, this message translates to:
  /// **'PDF, DOCX, JPG, PNG up to {size}MB'**
  String supportedFormats(int size);

  /// No description provided for @aiWillExtract.
  ///
  /// In en, this message translates to:
  /// **'AI will extract and summarize content'**
  String get aiWillExtract;

  /// No description provided for @freeLimitReached.
  ///
  /// In en, this message translates to:
  /// **'Free limit reached. Upgrade to continue'**
  String get freeLimitReached;

  /// No description provided for @readyToProcess.
  ///
  /// In en, this message translates to:
  /// **'Ready to process'**
  String get readyToProcess;

  /// No description provided for @chooseDifferentFile.
  ///
  /// In en, this message translates to:
  /// **'Choose Different File'**
  String get chooseDifferentFile;

  /// No description provided for @selectedFile.
  ///
  /// In en, this message translates to:
  /// **'Selected file'**
  String get selectedFile;

  /// No description provided for @generateSummary.
  ///
  /// In en, this message translates to:
  /// **'Generate Summary'**
  String get generateSummary;

  /// No description provided for @freePlanFileLimit.
  ///
  /// In en, this message translates to:
  /// **'Free plan limit: max {size}MB per file. Upgrade to upload larger documents.'**
  String freePlanFileLimit(int size);

  /// No description provided for @fileSizeExceeded.
  ///
  /// In en, this message translates to:
  /// **'File size exceeds your plan limit (max {size}MB). Upgrade for larger files.'**
  String fileSizeExceeded(int size);

  /// No description provided for @freeLimitReachedTitle.
  ///
  /// In en, this message translates to:
  /// **'Free Limit Reached'**
  String get freeLimitReachedTitle;

  /// No description provided for @freeLimitReachedMsg.
  ///
  /// In en, this message translates to:
  /// **'You\'ve used all your free documents. Upgrade to Pro for unlimited access!'**
  String get freeLimitReachedMsg;

  /// No description provided for @maybeLater.
  ///
  /// In en, this message translates to:
  /// **'Maybe Later'**
  String get maybeLater;

  /// No description provided for @upgradeNow.
  ///
  /// In en, this message translates to:
  /// **'Upgrade Now'**
  String get upgradeNow;

  /// No description provided for @summary.
  ///
  /// In en, this message translates to:
  /// **'Summary'**
  String get summary;

  /// No description provided for @failedToLoadSummary.
  ///
  /// In en, this message translates to:
  /// **'Failed to load summary'**
  String get failedToLoadSummary;

  /// No description provided for @summaryNotFound.
  ///
  /// In en, this message translates to:
  /// **'Summary not found'**
  String get summaryNotFound;

  /// No description provided for @overview.
  ///
  /// In en, this message translates to:
  /// **'Overview'**
  String get overview;

  /// No description provided for @keyPoints.
  ///
  /// In en, this message translates to:
  /// **'Key Points'**
  String get keyPoints;

  /// No description provided for @actionItems.
  ///
  /// In en, this message translates to:
  /// **'Action Items'**
  String get actionItems;

  /// No description provided for @keywords.
  ///
  /// In en, this message translates to:
  /// **'Keywords'**
  String get keywords;

  /// No description provided for @importantFacts.
  ///
  /// In en, this message translates to:
  /// **'Important Facts'**
  String get importantFacts;

  /// No description provided for @obligations.
  ///
  /// In en, this message translates to:
  /// **'Obligations'**
  String get obligations;

  /// No description provided for @risks.
  ///
  /// In en, this message translates to:
  /// **'Risks'**
  String get risks;

  /// No description provided for @findings.
  ///
  /// In en, this message translates to:
  /// **'Findings'**
  String get findings;

  /// No description provided for @wordsCount.
  ///
  /// In en, this message translates to:
  /// **'{count} words'**
  String wordsCount(int count);

  /// No description provided for @processingTime.
  ///
  /// In en, this message translates to:
  /// **'{seconds}s'**
  String processingTime(String seconds);

  /// No description provided for @viewOriginalDocument.
  ///
  /// In en, this message translates to:
  /// **'View Original Document'**
  String get viewOriginalDocument;

  /// No description provided for @copySummary.
  ///
  /// In en, this message translates to:
  /// **'Copy Summary'**
  String get copySummary;

  /// No description provided for @summaryCopied.
  ///
  /// In en, this message translates to:
  /// **'Summary copied to clipboard'**
  String get summaryCopied;

  /// No description provided for @generatedBy.
  ///
  /// In en, this message translates to:
  /// **'Generated by DoCMind AI'**
  String get generatedBy;

  /// No description provided for @wordCountLabel.
  ///
  /// In en, this message translates to:
  /// **'Word count: {count}'**
  String wordCountLabel(int count);

  /// No description provided for @processingTimeLabel.
  ///
  /// In en, this message translates to:
  /// **'Processing time: {seconds}s'**
  String processingTimeLabel(String seconds);

  /// No description provided for @upgradeRequired.
  ///
  /// In en, this message translates to:
  /// **'Upgrade required'**
  String get upgradeRequired;

  /// No description provided for @translateProOnly.
  ///
  /// In en, this message translates to:
  /// **'Translation is available on Pro plans. Upgrade to translate summaries.'**
  String get translateProOnly;

  /// No description provided for @notNow.
  ///
  /// In en, this message translates to:
  /// **'Not now'**
  String get notNow;

  /// No description provided for @manageSubscription.
  ///
  /// In en, this message translates to:
  /// **'Manage Subscription'**
  String get manageSubscription;

  /// No description provided for @changeYourPlan.
  ///
  /// In en, this message translates to:
  /// **'Change Your Plan'**
  String get changeYourPlan;

  /// No description provided for @unlockPremium.
  ///
  /// In en, this message translates to:
  /// **'Unlock Premium'**
  String get unlockPremium;

  /// No description provided for @upgradeOrSwitch.
  ///
  /// In en, this message translates to:
  /// **'Upgrade or switch to a different plan'**
  String get upgradeOrSwitch;

  /// No description provided for @getUnlimitedAccess.
  ///
  /// In en, this message translates to:
  /// **'Get unlimited access to all features'**
  String get getUnlimitedAccess;

  /// No description provided for @monthly.
  ///
  /// In en, this message translates to:
  /// **'Monthly'**
  String get monthly;

  /// No description provided for @yearly.
  ///
  /// In en, this message translates to:
  /// **'Yearly'**
  String get yearly;

  /// No description provided for @save40.
  ///
  /// In en, this message translates to:
  /// **'SAVE 40%'**
  String get save40;

  /// No description provided for @unlimitedDocuments.
  ///
  /// In en, this message translates to:
  /// **'Unlimited documents'**
  String get unlimitedDocuments;

  /// No description provided for @unlimitedSummaries.
  ///
  /// In en, this message translates to:
  /// **'Unlimited summaries'**
  String get unlimitedSummaries;

  /// No description provided for @priorityAiProcessing.
  ///
  /// In en, this message translates to:
  /// **'Priority AI processing'**
  String get priorityAiProcessing;

  /// No description provided for @exportToPdf.
  ///
  /// In en, this message translates to:
  /// **'Export to PDF'**
  String get exportToPdf;

  /// No description provided for @emailSupport.
  ///
  /// In en, this message translates to:
  /// **'Email support'**
  String get emailSupport;

  /// No description provided for @everythingInPro.
  ///
  /// In en, this message translates to:
  /// **'Everything in Pro'**
  String get everythingInPro;

  /// No description provided for @ocrScannedDocs.
  ///
  /// In en, this message translates to:
  /// **'OCR for scanned documents'**
  String get ocrScannedDocs;

  /// No description provided for @longDocSupport.
  ///
  /// In en, this message translates to:
  /// **'Long document support (100+ pages)'**
  String get longDocSupport;

  /// No description provided for @advancedAiAnalysis.
  ///
  /// In en, this message translates to:
  /// **'Advanced AI analysis'**
  String get advancedAiAnalysis;

  /// No description provided for @prioritySupport.
  ///
  /// In en, this message translates to:
  /// **'Priority support'**
  String get prioritySupport;

  /// No description provided for @earlyAccess.
  ///
  /// In en, this message translates to:
  /// **'Early access to features'**
  String get earlyAccess;

  /// No description provided for @freePlanInfo.
  ///
  /// In en, this message translates to:
  /// **'Free plan includes 2 documents with up to 5 pages each.'**
  String get freePlanInfo;

  /// No description provided for @restoring.
  ///
  /// In en, this message translates to:
  /// **'Restoring...'**
  String get restoring;

  /// No description provided for @current.
  ///
  /// In en, this message translates to:
  /// **'CURRENT'**
  String get current;

  /// No description provided for @popular.
  ///
  /// In en, this message translates to:
  /// **'POPULAR'**
  String get popular;

  /// No description provided for @perYear.
  ///
  /// In en, this message translates to:
  /// **'/year'**
  String get perYear;

  /// No description provided for @perMonth.
  ///
  /// In en, this message translates to:
  /// **'/month'**
  String get perMonth;

  /// No description provided for @billedAnnually.
  ///
  /// In en, this message translates to:
  /// **'Billed annually'**
  String get billedAnnually;

  /// No description provided for @thatsOnly.
  ///
  /// In en, this message translates to:
  /// **'That\'s only {price}/month'**
  String thatsOnly(String price);

  /// No description provided for @getPro.
  ///
  /// In en, this message translates to:
  /// **'Get Pro'**
  String get getPro;

  /// No description provided for @getProPlus.
  ///
  /// In en, this message translates to:
  /// **'Get Pro+'**
  String get getProPlus;

  /// No description provided for @currentPlan.
  ///
  /// In en, this message translates to:
  /// **'Current Plan'**
  String get currentPlan;

  /// No description provided for @switchToYearly.
  ///
  /// In en, this message translates to:
  /// **'Switch to Yearly'**
  String get switchToYearly;

  /// No description provided for @switchToMonthly.
  ///
  /// In en, this message translates to:
  /// **'Switch to Monthly'**
  String get switchToMonthly;

  /// No description provided for @upgradeToPro.
  ///
  /// In en, this message translates to:
  /// **'Upgrade to Pro'**
  String get upgradeToPro;

  /// No description provided for @upgradeToProPlus.
  ///
  /// In en, this message translates to:
  /// **'Upgrade to Pro+'**
  String get upgradeToProPlus;

  /// No description provided for @downgradeToPro.
  ///
  /// In en, this message translates to:
  /// **'Downgrade to Pro'**
  String get downgradeToPro;

  /// No description provided for @downgradeToProPlus.
  ///
  /// In en, this message translates to:
  /// **'Downgrade to Pro+'**
  String get downgradeToProPlus;

  /// No description provided for @changesAtEnd.
  ///
  /// In en, this message translates to:
  /// **'Changes at end of billing period'**
  String get changesAtEnd;

  /// No description provided for @autoRenews.
  ///
  /// In en, this message translates to:
  /// **'Auto-renews {date}'**
  String autoRenews(String date);

  /// No description provided for @expires.
  ///
  /// In en, this message translates to:
  /// **'Expires {date}'**
  String expires(String date);

  /// No description provided for @soon.
  ///
  /// In en, this message translates to:
  /// **'soon'**
  String get soon;

  /// No description provided for @active.
  ///
  /// In en, this message translates to:
  /// **'ACTIVE'**
  String get active;

  /// No description provided for @downgradePlan.
  ///
  /// In en, this message translates to:
  /// **'Downgrade Plan'**
  String get downgradePlan;

  /// No description provided for @downgradeConfirm.
  ///
  /// In en, this message translates to:
  /// **'Your plan will be downgraded at the end of your current billing period. You will keep your current features until then.'**
  String get downgradeConfirm;

  /// No description provided for @confirmDowngrade.
  ///
  /// In en, this message translates to:
  /// **'Confirm Downgrade'**
  String get confirmDowngrade;

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back'**
  String get welcomeBack;

  /// No description provided for @signInContinue.
  ///
  /// In en, this message translates to:
  /// **'Sign in to continue to DoCMind AI'**
  String get signInContinue;

  /// No description provided for @createAccountToStart.
  ///
  /// In en, this message translates to:
  /// **'Create your account to get started'**
  String get createAccountToStart;

  /// No description provided for @emailAddress.
  ///
  /// In en, this message translates to:
  /// **'Email address'**
  String get emailAddress;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @enterEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email'**
  String get enterEmail;

  /// No description provided for @validEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email'**
  String get validEmail;

  /// No description provided for @enterPassword.
  ///
  /// In en, this message translates to:
  /// **'Please enter your password'**
  String get enterPassword;

  /// No description provided for @passwordMinLength.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters'**
  String get passwordMinLength;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signIn;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get createAccount;

  /// No description provided for @orContinueWith.
  ///
  /// In en, this message translates to:
  /// **'or continue with'**
  String get orContinueWith;

  /// No description provided for @continueWithApple.
  ///
  /// In en, this message translates to:
  /// **'Continue with Apple'**
  String get continueWithApple;

  /// No description provided for @tryWithoutAccount.
  ///
  /// In en, this message translates to:
  /// **'Try Without Account'**
  String get tryWithoutAccount;

  /// No description provided for @noAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account? '**
  String get noAccount;

  /// No description provided for @haveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account? '**
  String get haveAccount;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUp;

  /// No description provided for @tryDoCMindAi.
  ///
  /// In en, this message translates to:
  /// **'Try DoCMind AI'**
  String get tryDoCMindAi;

  /// No description provided for @trialsLeft.
  ///
  /// In en, this message translates to:
  /// **'{count} trial(s) left'**
  String trialsLeft(int count);

  /// No description provided for @noTrialsRemaining.
  ///
  /// In en, this message translates to:
  /// **'No trials remaining'**
  String get noTrialsRemaining;

  /// No description provided for @summarizeNow.
  ///
  /// In en, this message translates to:
  /// **'Summarize Now'**
  String get summarizeNow;

  /// No description provided for @analyzingDocument.
  ///
  /// In en, this message translates to:
  /// **'Analyzing your document...'**
  String get analyzingDocument;

  /// No description provided for @thisMayTakeAMoment.
  ///
  /// In en, this message translates to:
  /// **'This may take a moment'**
  String get thisMayTakeAMoment;

  /// No description provided for @guestModeLimitations.
  ///
  /// In en, this message translates to:
  /// **'Guest Mode Limitations'**
  String get guestModeLimitations;

  /// No description provided for @maxPagesGuest.
  ///
  /// In en, this message translates to:
  /// **'Max 2 pages per document'**
  String get maxPagesGuest;

  /// No description provided for @twoTrialsOnly.
  ///
  /// In en, this message translates to:
  /// **'Only 2 total trials (no reset)'**
  String get twoTrialsOnly;

  /// No description provided for @notSavedToHistory.
  ///
  /// In en, this message translates to:
  /// **'Summary not saved to history'**
  String get notSavedToHistory;

  /// No description provided for @noCloudSync.
  ///
  /// In en, this message translates to:
  /// **'No cloud sync'**
  String get noCloudSync;

  /// No description provided for @withFreeAccount.
  ///
  /// In en, this message translates to:
  /// **'With a free account you get:'**
  String get withFreeAccount;

  /// No description provided for @upToFivePages.
  ///
  /// In en, this message translates to:
  /// **'Up to 5 pages per document'**
  String get upToFivePages;

  /// No description provided for @threeDocsPerDay.
  ///
  /// In en, this message translates to:
  /// **'3 documents per day'**
  String get threeDocsPerDay;

  /// No description provided for @historySavedForever.
  ///
  /// In en, this message translates to:
  /// **'History saved forever'**
  String get historySavedForever;

  /// No description provided for @cloudSyncDevices.
  ///
  /// In en, this message translates to:
  /// **'Cloud sync across devices'**
  String get cloudSyncDevices;

  /// No description provided for @wantUnlimitedAccess.
  ///
  /// In en, this message translates to:
  /// **'Want unlimited access?'**
  String get wantUnlimitedAccess;

  /// No description provided for @createFreeForMore.
  ///
  /// In en, this message translates to:
  /// **'Create a free account for more features'**
  String get createFreeForMore;

  /// No description provided for @createFreeAccount.
  ///
  /// In en, this message translates to:
  /// **'Create Free Account'**
  String get createFreeAccount;

  /// No description provided for @selectDocSource.
  ///
  /// In en, this message translates to:
  /// **'Select Document Source'**
  String get selectDocSource;

  /// No description provided for @browseFiles.
  ///
  /// In en, this message translates to:
  /// **'Browse Files'**
  String get browseFiles;

  /// No description provided for @pdfWordDocs.
  ///
  /// In en, this message translates to:
  /// **'PDF, Word documents'**
  String get pdfWordDocs;

  /// No description provided for @takePhoto.
  ///
  /// In en, this message translates to:
  /// **'Take Photo'**
  String get takePhoto;

  /// No description provided for @captureDocCamera.
  ///
  /// In en, this message translates to:
  /// **'Capture document with camera'**
  String get captureDocCamera;

  /// No description provided for @photoLibrary.
  ///
  /// In en, this message translates to:
  /// **'Photo Library'**
  String get photoLibrary;

  /// No description provided for @selectFromGallery.
  ///
  /// In en, this message translates to:
  /// **'Select from gallery'**
  String get selectFromGallery;

  /// No description provided for @fileTooLargeGuest.
  ///
  /// In en, this message translates to:
  /// **'File too large. Maximum 5MB for guest mode.'**
  String get fileTooLargeGuest;

  /// No description provided for @failedPickFile.
  ///
  /// In en, this message translates to:
  /// **'Failed to pick file'**
  String get failedPickFile;

  /// No description provided for @failedCapturePhoto.
  ///
  /// In en, this message translates to:
  /// **'Failed to capture photo'**
  String get failedCapturePhoto;

  /// No description provided for @failedPickImage.
  ///
  /// In en, this message translates to:
  /// **'Failed to pick image'**
  String get failedPickImage;

  /// No description provided for @trialLimitReached.
  ///
  /// In en, this message translates to:
  /// **'Trial Limit Reached'**
  String get trialLimitReached;

  /// No description provided for @trialLimitMsg.
  ///
  /// In en, this message translates to:
  /// **'You have used all your free trials. Create an account to continue using DoCMind AI with unlimited access.'**
  String get trialLimitMsg;

  /// No description provided for @noSummaryAvailable.
  ///
  /// In en, this message translates to:
  /// **'No summary available'**
  String get noSummaryAvailable;

  /// No description provided for @summaryNotSaved.
  ///
  /// In en, this message translates to:
  /// **'This summary won\'t be saved. Create an account to keep it!'**
  String get summaryNotSaved;

  /// No description provided for @documentSummary.
  ///
  /// In en, this message translates to:
  /// **'Document Summary'**
  String get documentSummary;

  /// No description provided for @noOverviewAvailable.
  ///
  /// In en, this message translates to:
  /// **'No overview available'**
  String get noOverviewAvailable;

  /// No description provided for @moreKeyPoints.
  ///
  /// In en, this message translates to:
  /// **'{count} more key points'**
  String moreKeyPoints(int count);

  /// No description provided for @itemsCount.
  ///
  /// In en, this message translates to:
  /// **'{count} items'**
  String itemsCount(int count);

  /// No description provided for @createFreeToUnlock.
  ///
  /// In en, this message translates to:
  /// **'Create Free Account to Unlock'**
  String get createFreeToUnlock;

  /// No description provided for @trialsRemaining.
  ///
  /// In en, this message translates to:
  /// **'{count} Trial(s) Remaining'**
  String trialsRemaining(int count);

  /// No description provided for @createAccountContinue.
  ///
  /// In en, this message translates to:
  /// **'Create an account to continue using DoCMind AI'**
  String get createAccountContinue;

  /// No description provided for @createAccountUnlimited.
  ///
  /// In en, this message translates to:
  /// **'Create an account for unlimited summaries'**
  String get createAccountUnlimited;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @processingFailed.
  ///
  /// In en, this message translates to:
  /// **'Document processing failed. Please try again.'**
  String get processingFailed;

  /// No description provided for @processingTakingLong.
  ///
  /// In en, this message translates to:
  /// **'Processing is taking longer than expected. Check History for status.'**
  String get processingTakingLong;

  /// No description provided for @translating.
  ///
  /// In en, this message translates to:
  /// **'Translating'**
  String get translating;

  /// No description provided for @aiTranslatingYourSummary.
  ///
  /// In en, this message translates to:
  /// **'AI is translating your summary'**
  String get aiTranslatingYourSummary;

  /// No description provided for @translationComplete.
  ///
  /// In en, this message translates to:
  /// **'Translation complete'**
  String get translationComplete;

  /// No description provided for @translatedTo.
  ///
  /// In en, this message translates to:
  /// **'Translated to {language}'**
  String translatedTo(String language);

  /// No description provided for @originalLanguage.
  ///
  /// In en, this message translates to:
  /// **'Original: {language}'**
  String originalLanguage(String language);

  /// No description provided for @generatedOn.
  ///
  /// In en, this message translates to:
  /// **'Generated on {date}'**
  String generatedOn(String date);

  /// No description provided for @pleaseWait.
  ///
  /// In en, this message translates to:
  /// **'Please wait'**
  String get pleaseWait;

  /// No description provided for @updateRequired.
  ///
  /// In en, this message translates to:
  /// **'Update Required'**
  String get updateRequired;

  /// No description provided for @updateRequiredMsg.
  ///
  /// In en, this message translates to:
  /// **'A new version of DoCMind AI is available. Please update to continue using the app.'**
  String get updateRequiredMsg;

  /// No description provided for @updateNow.
  ///
  /// In en, this message translates to:
  /// **'Update Now'**
  String get updateNow;

  /// No description provided for @onboardingUploadTitle.
  ///
  /// In en, this message translates to:
  /// **'Upload Documents'**
  String get onboardingUploadTitle;

  /// No description provided for @onboardingUploadDesc.
  ///
  /// In en, this message translates to:
  /// **'Drop your PDF, DOCX, or images and let AI do the rest. Get structured summaries in seconds.'**
  String get onboardingUploadDesc;

  /// No description provided for @onboardingSummaryTitle.
  ///
  /// In en, this message translates to:
  /// **'AI-Powered Summaries'**
  String get onboardingSummaryTitle;

  /// No description provided for @onboardingSummaryDesc.
  ///
  /// In en, this message translates to:
  /// **'Instantly get key points, action items, and highlights from any document.'**
  String get onboardingSummaryDesc;

  /// No description provided for @onboardingTranslateTitle.
  ///
  /// In en, this message translates to:
  /// **'Translate Summaries'**
  String get onboardingTranslateTitle;

  /// No description provided for @onboardingTranslateDesc.
  ///
  /// In en, this message translates to:
  /// **'Translate your summaries into 13+ languages with a single tap.'**
  String get onboardingTranslateDesc;

  /// No description provided for @onboardingShareTitle.
  ///
  /// In en, this message translates to:
  /// **'Share from Any App'**
  String get onboardingShareTitle;

  /// No description provided for @onboardingShareDesc.
  ///
  /// In en, this message translates to:
  /// **'Send files directly from WhatsApp, Telegram, or any app to get instant summaries.'**
  String get onboardingShareDesc;

  /// No description provided for @onboardingHistoryTitle.
  ///
  /// In en, this message translates to:
  /// **'History & Filters'**
  String get onboardingHistoryTitle;

  /// No description provided for @onboardingHistoryDesc.
  ///
  /// In en, this message translates to:
  /// **'All your documents organized in one place. Filter by PDF, Word, or images.'**
  String get onboardingHistoryDesc;

  /// No description provided for @onboardingCopyShareTitle.
  ///
  /// In en, this message translates to:
  /// **'Copy & Share'**
  String get onboardingCopyShareTitle;

  /// No description provided for @onboardingCopyShareDesc.
  ///
  /// In en, this message translates to:
  /// **'Copy your summaries to clipboard or share them with anyone via your favorite apps.'**
  String get onboardingCopyShareDesc;

  /// No description provided for @tutorial.
  ///
  /// In en, this message translates to:
  /// **'Tutorial'**
  String get tutorial;

  /// No description provided for @onboardingSkip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get onboardingSkip;

  /// No description provided for @onboardingNext.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get onboardingNext;

  /// No description provided for @onboardingGetStarted.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get onboardingGetStarted;
}

class _SDelegate extends LocalizationsDelegate<S> {
  const _SDelegate();

  @override
  Future<S> load(Locale locale) {
    return SynchronousFuture<S>(lookupS(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
        'de',
        'en',
        'es',
        'fr',
        'id',
        'it',
        'ja',
        'nl',
        'pt',
        'ru',
        'tr',
        'zh'
      ].contains(locale.languageCode);

  @override
  bool shouldReload(_SDelegate old) => false;
}

S lookupS(Locale locale) {
  // Lookup logic when language+script codes are specified.
  switch (locale.languageCode) {
    case 'zh':
      {
        switch (locale.scriptCode) {
          case 'Hant':
            return SZhHant();
        }
        break;
      }
  }

  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return SDe();
    case 'en':
      return SEn();
    case 'es':
      return SEs();
    case 'fr':
      return SFr();
    case 'id':
      return SId();
    case 'it':
      return SIt();
    case 'ja':
      return SJa();
    case 'nl':
      return SNl();
    case 'pt':
      return SPt();
    case 'ru':
      return SRu();
    case 'tr':
      return STr();
    case 'zh':
      return SZh();
  }

  throw FlutterError(
      'S.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
