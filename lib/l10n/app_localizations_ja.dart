// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class SJa extends S {
  SJa([String locale = 'ja']) : super(locale);

  @override
  String get appName => 'DoCMind AI';

  @override
  String get appTagline => 'OCR、ドキュメント＆AI要約';

  @override
  String get navHome => 'ホーム';

  @override
  String get navHistory => '履歴';

  @override
  String get navSettings => '設定';

  @override
  String get addDocument => 'ドキュメントを追加';

  @override
  String get optionDocument => 'ドキュメント';

  @override
  String get optionDocumentSub => 'PDF、Word、その他のファイル';

  @override
  String get optionGallery => 'ギャラリー';

  @override
  String get optionGallerySub => 'フォトライブラリから選択';

  @override
  String get optionCamera => 'カメラ';

  @override
  String get optionCameraSub => '写真を撮る';

  @override
  String get greeting => 'こんにちは';

  @override
  String get planPro => 'Pro';

  @override
  String get planProPlus => 'Pro+';

  @override
  String get planFree => '無料';

  @override
  String get quickActions => 'クイックアクション';

  @override
  String get recentDocuments => '最近のドキュメント';

  @override
  String get upload => 'アップロード';

  @override
  String get uploadFormats => 'PDF、DOCX、画像';

  @override
  String get history => '履歴';

  @override
  String get viewAllDocs => 'すべてのドキュメント';

  @override
  String get seeAll => 'すべて見る';

  @override
  String get noDocumentsYet => 'ドキュメントはまだありません';

  @override
  String get uploadFirstDoc => '最初のドキュメントをアップロードして、AIに要約してもらいましょう';

  @override
  String get uploadDocument => 'ドキュメントをアップロード';

  @override
  String get premiumActive => 'プレミアム有効';

  @override
  String get unlimitedDocsSummaries => '無制限のドキュメント＆要約';

  @override
  String get freePlan => '無料プラン';

  @override
  String get noFreeDocsLeft => '無料枠がなくなりました';

  @override
  String freeLeftCount(int count) {
    return '残り$count件';
  }

  @override
  String get upgradeForUnlimited => '無制限アクセスにアップグレード';

  @override
  String freeDocsUsed(int used, int limit) {
    return '無料ドキュメント $used/$limit 件使用済み';
  }

  @override
  String get upgrade => 'アップグレード';

  @override
  String get failed => '失敗';

  @override
  String minAgo(int count) {
    return '$count分前';
  }

  @override
  String hoursAgo(int count) {
    return '$count時間前';
  }

  @override
  String get yesterday => '昨日';

  @override
  String daysAgo(int count) {
    return '$count日前';
  }

  @override
  String get clearFilters => 'フィルターをクリア';

  @override
  String get documentDeleted => 'ドキュメントを削除しました';

  @override
  String get noDocumentsFiltered => 'ドキュメントが見つかりません';

  @override
  String get tryRemovingFilters => 'フィルターを解除するか、\n新しいドキュメントをアップロードしてください';

  @override
  String get clearFiltersButton => 'フィルターをクリア';

  @override
  String get deleteDocument => 'ドキュメントを削除';

  @override
  String get deleteDocumentConfirm => 'このドキュメントを削除してもよろしいですか？';

  @override
  String get deleteDocumentConfirmFull => 'このドキュメントを削除してもよろしいですか？この操作は元に戻せません。';

  @override
  String get cancel => 'キャンセル';

  @override
  String get delete => '削除';

  @override
  String get allDocuments => 'すべてのドキュメント';

  @override
  String get pdfOnly => 'PDFのみ';

  @override
  String get wordOnly => 'Wordのみ';

  @override
  String get imagesOnly => '画像のみ';

  @override
  String get settings => '設定';

  @override
  String get proMember => 'Proメンバー';

  @override
  String get proPlusMember => 'Pro+メンバー';

  @override
  String get unlimitedAccess => '無制限アクセス';

  @override
  String get upgradeForMoreFeatures => 'より多くの機能にアップグレード';

  @override
  String get preferences => '環境設定';

  @override
  String get support => 'サポート';

  @override
  String get account => 'アカウント';

  @override
  String get notifications => '通知';

  @override
  String get darkMode => 'ダークモード';

  @override
  String get appLanguage => 'アプリの言語';

  @override
  String get summaryLanguage => '要約の言語';

  @override
  String get helpFaq => 'ヘルプ＆FAQ';

  @override
  String get rateApp => 'アプリを評価';

  @override
  String get rateAppSub => 'DoCMind AIが気に入りましたか？評価をお願いします！';

  @override
  String get privacyPolicy => 'プライバシーポリシー';

  @override
  String get termsOfService => '利用規約';

  @override
  String get restorePurchases => '購入を復元';

  @override
  String get signOut => 'サインアウト';

  @override
  String get deleteAccount => 'アカウントを削除';

  @override
  String get deleteAccountConfirm => 'アカウントを削除してもよろしいですか？この操作は元に戻せません。';

  @override
  String get deleteAccountTitle => 'アカウントを削除しますか？';

  @override
  String appVersion(String version) {
    return 'DoCMind AI v$version';
  }

  @override
  String whatsNew(String version) {
    return 'v$versionの新機能';
  }

  @override
  String get ok => 'OK';

  @override
  String get document => 'ドキュメント';

  @override
  String get failedToLoadDocument => 'ドキュメントの読み込みに失敗しました';

  @override
  String get tryAgain => '再試行';

  @override
  String get documentNotFound => 'ドキュメントが見つかりません';

  @override
  String get loadingPdf => 'PDFを読み込み中...';

  @override
  String get loadingPreview => 'ドキュメントのプレビューを読み込み中...';

  @override
  String showingPage(int count) {
    return '1 / $count ページを表示中';
  }

  @override
  String get documentContent => 'ドキュメントの内容';

  @override
  String get noContentExtracted => 'まだ内容が抽出されていません';

  @override
  String get previewNotAvailable => 'プレビューは利用できません';

  @override
  String get viewSummary => '要約を表示';

  @override
  String get generating => '生成中...';

  @override
  String get generateAiSummary => 'AI要約を生成';

  @override
  String pagesCount(int count) {
    return '$countページ';
  }

  @override
  String get uploadDocumentTitle => 'ドキュメントをアップロード';

  @override
  String get tipReading => 'AIがドキュメントを読み込んでいます...';

  @override
  String get tipExtracting => '重要な情報を抽出しています...';

  @override
  String get tipIdentifying => '重要なセクションを特定しています...';

  @override
  String get tipBuilding => '構造化された要約を作成しています...';

  @override
  String get tipFinalizing => 'もう少しで完了です...';

  @override
  String get stepUploading => 'アップロード中';

  @override
  String get stepExtractingText => 'テキスト抽出';

  @override
  String get stepAiAnalyzing => 'AI分析';

  @override
  String get summaryLang => '要約の言語';

  @override
  String uploadingProgress(int percent) {
    return 'ドキュメントをアップロード中... $percent%';
  }

  @override
  String get extractingText => 'ドキュメントからテキストを抽出しています...';

  @override
  String get aiAnalyzing => 'AIが分析・要約しています...';

  @override
  String get preparing => '準備中...';

  @override
  String get tapToUpload => 'タップしてドキュメントをアップロード';

  @override
  String supportedFormats(int size) {
    return 'PDF、DOCX、JPG、PNG（最大${size}MB）';
  }

  @override
  String get aiWillExtract => 'AIが内容を抽出して要約します';

  @override
  String get freeLimitReached => '無料枠に達しました。続けるにはアップグレードしてください';

  @override
  String get readyToProcess => '処理の準備ができました';

  @override
  String get chooseDifferentFile => '別のファイルを選択';

  @override
  String get selectedFile => '選択したファイル';

  @override
  String get generateSummary => '要約を生成';

  @override
  String freePlanFileLimit(int size) {
    return '無料プランの制限：1ファイル最大${size}MB。大きなドキュメントをアップロードするにはアップグレードしてください。';
  }

  @override
  String fileSizeExceeded(int size) {
    return 'ファイルサイズがプランの制限を超えています（最大${size}MB）。大きなファイルにはアップグレードしてください。';
  }

  @override
  String get freeLimitReachedTitle => '無料枠に達しました';

  @override
  String get freeLimitReachedMsg =>
      '無料ドキュメントをすべて使用しました。Proにアップグレードして無制限にアクセスしましょう！';

  @override
  String get maybeLater => '後で';

  @override
  String get upgradeNow => '今すぐアップグレード';

  @override
  String get summary => '要約';

  @override
  String get failedToLoadSummary => '要約の読み込みに失敗しました';

  @override
  String get summaryNotFound => '要約が見つかりません';

  @override
  String get overview => '概要';

  @override
  String get keyPoints => '要点';

  @override
  String get actionItems => 'アクション項目';

  @override
  String get keywords => 'キーワード';

  @override
  String get importantFacts => '重要な事実';

  @override
  String get obligations => '義務';

  @override
  String get risks => 'リスク';

  @override
  String get findings => '発見事項';

  @override
  String wordsCount(int count) {
    return '$count語';
  }

  @override
  String processingTime(String seconds) {
    return '$seconds秒';
  }

  @override
  String get viewOriginalDocument => '元のドキュメントを表示';

  @override
  String get copySummary => '要約をコピー';

  @override
  String get summaryCopied => '要約をクリップボードにコピーしました';

  @override
  String get generatedBy => 'DoCMind AIが生成';

  @override
  String wordCountLabel(int count) {
    return '語数：$count';
  }

  @override
  String processingTimeLabel(String seconds) {
    return '処理時間：$seconds秒';
  }

  @override
  String get upgradeRequired => 'アップグレードが必要です';

  @override
  String get translateProOnly => '翻訳はProプランで利用できます。要約を翻訳するにはアップグレードしてください。';

  @override
  String get notNow => '今はしない';

  @override
  String get manageSubscription => 'サブスクリプションを管理';

  @override
  String get changeYourPlan => 'プランを変更';

  @override
  String get unlockPremium => 'プレミアムをアンロック';

  @override
  String get upgradeOrSwitch => 'アップグレードまたは別のプランに切り替え';

  @override
  String get getUnlimitedAccess => 'すべての機能に無制限でアクセス';

  @override
  String get monthly => '月額';

  @override
  String get yearly => '年額';

  @override
  String get save40 => '40%オフ';

  @override
  String get unlimitedDocuments => '無制限のドキュメント';

  @override
  String get unlimitedSummaries => '無制限の要約';

  @override
  String get priorityAiProcessing => '優先AI処理';

  @override
  String get exportToPdf => 'PDFにエクスポート';

  @override
  String get emailSupport => 'メールサポート';

  @override
  String get everythingInPro => 'Proのすべて';

  @override
  String get ocrScannedDocs => 'スキャンしたドキュメントのOCR';

  @override
  String get longDocSupport => '長文ドキュメント対応（100ページ以上）';

  @override
  String get advancedAiAnalysis => '高度なAI分析';

  @override
  String get prioritySupport => '優先サポート';

  @override
  String get earlyAccess => '新機能の先行利用';

  @override
  String get freePlanInfo => '無料プランには、それぞれ最大5ページのドキュメントが2件含まれます。';

  @override
  String get restoring => '復元中...';

  @override
  String get current => '現在';

  @override
  String get popular => '人気';

  @override
  String get perYear => '/年';

  @override
  String get perMonth => '/月';

  @override
  String get billedAnnually => '年払い';

  @override
  String thatsOnly(String price) {
    return '月額$priceのみ';
  }

  @override
  String get getPro => 'Proを取得';

  @override
  String get getProPlus => 'Pro+を取得';

  @override
  String get currentPlan => '現在のプラン';

  @override
  String get switchToYearly => '年額に切り替え';

  @override
  String get switchToMonthly => '月額に切り替え';

  @override
  String get upgradeToPro => 'Proにアップグレード';

  @override
  String get upgradeToProPlus => 'Pro+にアップグレード';

  @override
  String get downgradeToPro => 'Proにダウングレード';

  @override
  String get downgradeToProPlus => 'Pro+にダウングレード';

  @override
  String get changesAtEnd => '請求期間終了時に変更';

  @override
  String autoRenews(String date) {
    return '$dateに自動更新';
  }

  @override
  String expires(String date) {
    return '$dateに期限切れ';
  }

  @override
  String get soon => '近日';

  @override
  String get active => '有効';

  @override
  String get downgradePlan => 'プランをダウングレード';

  @override
  String get downgradeConfirm =>
      '現在の請求期間終了時にプランがダウングレードされます。それまでは現在の機能をご利用いただけます。';

  @override
  String get confirmDowngrade => 'ダウングレードを確認';

  @override
  String get welcomeBack => 'おかえりなさい';

  @override
  String get signInContinue => 'DoCMind AIにサインインして続行';

  @override
  String get createAccountToStart => 'アカウントを作成して始めましょう';

  @override
  String get emailAddress => 'メールアドレス';

  @override
  String get password => 'パスワード';

  @override
  String get enterEmail => 'メールアドレスを入力してください';

  @override
  String get validEmail => '有効なメールアドレスを入力してください';

  @override
  String get enterPassword => 'パスワードを入力してください';

  @override
  String get passwordMinLength => 'パスワードは8文字以上で入力してください';

  @override
  String get signIn => 'サインイン';

  @override
  String get createAccount => 'アカウントを作成';

  @override
  String get orContinueWith => 'または次で続行';

  @override
  String get continueWithApple => 'Appleで続行';

  @override
  String get tryWithoutAccount => 'アカウントなしで試す';

  @override
  String get noAccount => 'アカウントをお持ちでないですか？ ';

  @override
  String get haveAccount => 'すでにアカウントをお持ちですか？ ';

  @override
  String get signUp => 'サインアップ';

  @override
  String get tryDoCMindAi => 'DoCMind AIを試す';

  @override
  String trialsLeft(int count) {
    return '残り$count回のトライアル';
  }

  @override
  String get noTrialsRemaining => 'トライアルが残っていません';

  @override
  String get summarizeNow => '今すぐ要約';

  @override
  String get analyzingDocument => 'ドキュメントを分析しています...';

  @override
  String get thisMayTakeAMoment => '少々お待ちください';

  @override
  String get guestModeLimitations => 'ゲストモードの制限';

  @override
  String get maxPagesGuest => '1ドキュメント最大2ページ';

  @override
  String get twoTrialsOnly => 'トライアルは合計2回のみ（リセットなし）';

  @override
  String get notSavedToHistory => '要約は履歴に保存されません';

  @override
  String get noCloudSync => 'クラウド同期なし';

  @override
  String get withFreeAccount => '無料アカウントでは：';

  @override
  String get upToFivePages => '1ドキュメント最大5ページ';

  @override
  String get threeDocsPerDay => '1日3ドキュメント';

  @override
  String get historySavedForever => '履歴を永久に保存';

  @override
  String get cloudSyncDevices => 'デバイス間でクラウド同期';

  @override
  String get wantUnlimitedAccess => '無制限アクセスが欲しい？';

  @override
  String get createFreeForMore => '無料アカウントを作成してより多くの機能を利用';

  @override
  String get createFreeAccount => '無料アカウントを作成';

  @override
  String get selectDocSource => 'ドキュメントのソースを選択';

  @override
  String get browseFiles => 'ファイルを参照';

  @override
  String get pdfWordDocs => 'PDF、Wordドキュメント';

  @override
  String get takePhoto => '写真を撮る';

  @override
  String get captureDocCamera => 'カメラでドキュメントを撮影';

  @override
  String get photoLibrary => 'フォトライブラリ';

  @override
  String get selectFromGallery => 'ギャラリーから選択';

  @override
  String get fileTooLargeGuest => 'ファイルが大きすぎます。ゲストモードでは最大5MBです。';

  @override
  String get failedPickFile => 'ファイルの選択に失敗しました';

  @override
  String get failedCapturePhoto => '写真の撮影に失敗しました';

  @override
  String get failedPickImage => '画像の選択に失敗しました';

  @override
  String get trialLimitReached => 'トライアル制限に達しました';

  @override
  String get trialLimitMsg =>
      'すべての無料トライアルを使用しました。アカウントを作成して、DoCMind AIを無制限にご利用ください。';

  @override
  String get noSummaryAvailable => '要約は利用できません';

  @override
  String get summaryNotSaved => 'この要約は保存されません。アカウントを作成して保存しましょう！';

  @override
  String get documentSummary => 'ドキュメントの要約';

  @override
  String get noOverviewAvailable => '概要は利用できません';

  @override
  String moreKeyPoints(int count) {
    return 'あと$countつの要点';
  }

  @override
  String itemsCount(int count) {
    return '$count件';
  }

  @override
  String get createFreeToUnlock => '無料アカウントを作成してアンロック';

  @override
  String trialsRemaining(int count) {
    return '残り$count回のトライアル';
  }

  @override
  String get createAccountContinue => 'アカウントを作成してDoCMind AIを続けて利用';

  @override
  String get createAccountUnlimited => 'アカウントを作成して無制限の要約を利用';

  @override
  String get close => '閉じる';

  @override
  String get processingFailed => 'ドキュメントの処理に失敗しました。もう一度お試しください。';

  @override
  String get processingTakingLong => '処理に予想以上の時間がかかっています。履歴でステータスを確認してください。';

  @override
  String get translating => '翻訳中';

  @override
  String get aiTranslatingYourSummary => 'AIが要約を翻訳しています';

  @override
  String get translationComplete => '翻訳完了';

  @override
  String translatedTo(String language) {
    return '$languageに翻訳済み';
  }

  @override
  String originalLanguage(String language) {
    return '元の言語: $language';
  }

  @override
  String generatedOn(String date) {
    return '$dateに生成';
  }

  @override
  String get pleaseWait => 'お待ちください';

  @override
  String get updateRequired => 'アップデートが必要です';

  @override
  String get updateRequiredMsg =>
      'DoCMind AIの新しいバージョンが利用可能です。アプリを引き続きご利用いただくには、アップデートしてください。';

  @override
  String get updateNow => '今すぐアップデート';

  @override
  String get onboardingUploadTitle => 'ドキュメントをアップロード';

  @override
  String get onboardingUploadDesc =>
      'PDF、DOCX、画像をアップロードすると、AIが残りを処理します。数秒で要約を取得。';

  @override
  String get onboardingSummaryTitle => 'AI搭載の要約';

  @override
  String get onboardingSummaryDesc => 'あらゆるドキュメントから重要ポイント、アクション項目、ハイライトを即座に取得。';

  @override
  String get onboardingTranslateTitle => '要約を翻訳';

  @override
  String get onboardingTranslateDesc => 'ワンタップで要約を13以上の言語に翻訳できます。';

  @override
  String get onboardingShareTitle => 'どのアプリからも共有';

  @override
  String get onboardingShareDesc =>
      'WhatsApp、Telegramなど、どのアプリからでもファイルを直接送信して即座に要約を取得。';

  @override
  String get onboardingHistoryTitle => '履歴とフィルター';

  @override
  String get onboardingHistoryDesc => 'すべてのドキュメントを一か所で整理。PDF、Word、画像でフィルタリング。';

  @override
  String get onboardingCopyShareTitle => 'コピー＆共有';

  @override
  String get onboardingCopyShareDesc => '要約をクリップボードにコピーしたり、お気に入りのアプリで共有できます。';

  @override
  String get tutorial => 'チュートリアル';

  @override
  String get onboardingSkip => 'スキップ';

  @override
  String get onboardingNext => '次へ';

  @override
  String get onboardingGetStarted => '始める';
}
