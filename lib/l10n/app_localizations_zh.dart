// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class SZh extends S {
  SZh([String locale = 'zh']) : super(locale);

  @override
  String get appName => 'DoCMind AI';

  @override
  String get appTagline => 'OCR、文档与 AI 智能摘要';

  @override
  String get navHome => '首页';

  @override
  String get navHistory => '历史';

  @override
  String get navSettings => '设置';

  @override
  String get addDocument => '添加文档';

  @override
  String get optionDocument => '文档';

  @override
  String get optionDocumentSub => 'PDF、Word 或其他文件';

  @override
  String get optionGallery => '相册';

  @override
  String get optionGallerySub => '从照片库选择';

  @override
  String get optionCamera => '相机';

  @override
  String get optionCameraSub => '拍照';

  @override
  String get greeting => '你好';

  @override
  String get planPro => 'Pro';

  @override
  String get planProPlus => 'Pro+';

  @override
  String get planFree => '免费';

  @override
  String get quickActions => '快捷操作';

  @override
  String get recentDocuments => '最近文档';

  @override
  String get upload => '上传';

  @override
  String get uploadFormats => 'PDF、DOCX、图片';

  @override
  String get history => '历史';

  @override
  String get viewAllDocs => '查看全部文档';

  @override
  String get seeAll => '查看全部';

  @override
  String get noDocumentsYet => '暂无文档';

  @override
  String get uploadFirstDoc => '上传您的第一份文档，让 AI 为您生成摘要';

  @override
  String get uploadDocument => '上传文档';

  @override
  String get premiumActive => '高级会员已激活';

  @override
  String get unlimitedDocsSummaries => '无限文档与摘要';

  @override
  String get freePlan => '免费版';

  @override
  String get noFreeDocsLeft => '免费额度已用完';

  @override
  String freeLeftCount(int count) {
    return '剩余 $count 次免费';
  }

  @override
  String get upgradeForUnlimited => '升级获取无限使用';

  @override
  String freeDocsUsed(int used, int limit) {
    return '已使用 $used/$limit 个免费文档';
  }

  @override
  String get upgrade => '升级';

  @override
  String get failed => '失败';

  @override
  String minAgo(int count) {
    return '$count 分钟前';
  }

  @override
  String hoursAgo(int count) {
    return '$count 小时前';
  }

  @override
  String get yesterday => '昨天';

  @override
  String daysAgo(int count) {
    return '$count 天前';
  }

  @override
  String get clearFilters => '清除筛选';

  @override
  String get documentDeleted => '文档已删除';

  @override
  String get noDocumentsFiltered => '未找到文档';

  @override
  String get tryRemovingFilters => '请尝试移除筛选条件或\n上传新文档';

  @override
  String get clearFiltersButton => '清除筛选';

  @override
  String get deleteDocument => '删除文档';

  @override
  String get deleteDocumentConfirm => '确定要删除此文档吗？';

  @override
  String get deleteDocumentConfirmFull => '确定要删除此文档吗？此操作无法撤销。';

  @override
  String get cancel => '取消';

  @override
  String get delete => '删除';

  @override
  String get allDocuments => '全部文档';

  @override
  String get pdfOnly => '仅 PDF';

  @override
  String get wordOnly => '仅 Word';

  @override
  String get imagesOnly => '仅图片';

  @override
  String get settings => '设置';

  @override
  String get proMember => 'Pro 会员';

  @override
  String get proPlusMember => 'Pro+ 会员';

  @override
  String get unlimitedAccess => '无限使用';

  @override
  String get upgradeForMoreFeatures => '升级获取更多功能';

  @override
  String get preferences => '偏好设置';

  @override
  String get support => '支持';

  @override
  String get account => '账户';

  @override
  String get notifications => '通知';

  @override
  String get darkMode => '深色模式';

  @override
  String get appLanguage => '应用语言';

  @override
  String get summaryLanguage => '摘要语言';

  @override
  String get helpFaq => '帮助与常见问题';

  @override
  String get rateApp => '为应用评分';

  @override
  String get rateAppSub => '喜欢 DoCMind AI？给我们评分吧！';

  @override
  String get privacyPolicy => '隐私政策';

  @override
  String get termsOfService => '服务条款';

  @override
  String get restorePurchases => '恢复购买';

  @override
  String get signOut => '退出登录';

  @override
  String get deleteAccount => '删除账户';

  @override
  String get deleteAccountConfirm => '确定要删除您的账户吗？此操作无法撤销。';

  @override
  String get deleteAccountTitle => '删除账户？';

  @override
  String appVersion(String version) {
    return 'DoCMind AI v$version';
  }

  @override
  String whatsNew(String version) {
    return 'v$version 更新内容';
  }

  @override
  String get ok => '确定';

  @override
  String get document => '文档';

  @override
  String get failedToLoadDocument => '加载文档失败';

  @override
  String get tryAgain => '重试';

  @override
  String get documentNotFound => '未找到文档';

  @override
  String get loadingPdf => '正在加载 PDF...';

  @override
  String get loadingPreview => '正在加载文档预览...';

  @override
  String showingPage(int count) {
    return '第 1 页，共 $count 页';
  }

  @override
  String get documentContent => '文档内容';

  @override
  String get noContentExtracted => '尚未提取内容';

  @override
  String get previewNotAvailable => '预览不可用';

  @override
  String get viewSummary => '查看摘要';

  @override
  String get generating => '生成中...';

  @override
  String get generateAiSummary => '生成 AI 摘要';

  @override
  String pagesCount(int count) {
    return '$count 页';
  }

  @override
  String get uploadDocumentTitle => '上传文档';

  @override
  String get tipReading => 'AI 正在阅读您的文档...';

  @override
  String get tipExtracting => '正在提取关键信息...';

  @override
  String get tipIdentifying => '正在识别重要段落...';

  @override
  String get tipBuilding => '正在生成结构化摘要...';

  @override
  String get tipFinalizing => '即将完成，正在处理...';

  @override
  String get stepUploading => '上传中';

  @override
  String get stepExtractingText => '提取文字';

  @override
  String get stepAiAnalyzing => 'AI 分析中';

  @override
  String get summaryLang => '摘要语言';

  @override
  String uploadingProgress(int percent) {
    return '正在上传文档... $percent%';
  }

  @override
  String get extractingText => '正在从文档中提取文字...';

  @override
  String get aiAnalyzing => 'AI 正在分析与摘要...';

  @override
  String get preparing => '准备中...';

  @override
  String get tapToUpload => '点击上传文档';

  @override
  String supportedFormats(int size) {
    return '支持 PDF、DOCX、JPG、PNG，最大 ${size}MB';
  }

  @override
  String get aiWillExtract => 'AI 将提取并摘要内容';

  @override
  String get freeLimitReached => '已达免费上限，升级后可继续使用';

  @override
  String get readyToProcess => '准备处理';

  @override
  String get chooseDifferentFile => '选择其他文件';

  @override
  String get selectedFile => '已选文件';

  @override
  String get generateSummary => '生成摘要';

  @override
  String freePlanFileLimit(int size) {
    return '免费版限制：单文件最大 ${size}MB。升级后可上传更大文档。';
  }

  @override
  String fileSizeExceeded(int size) {
    return '文件大小超出您的方案限制（最大 ${size}MB）。升级后可上传更大文件。';
  }

  @override
  String get freeLimitReachedTitle => '已达免费上限';

  @override
  String get freeLimitReachedMsg => '您已用完所有免费文档额度。升级至 Pro 获取无限使用！';

  @override
  String get maybeLater => '稍后再说';

  @override
  String get upgradeNow => '立即升级';

  @override
  String get summary => '摘要';

  @override
  String get failedToLoadSummary => '加载摘要失败';

  @override
  String get summaryNotFound => '未找到摘要';

  @override
  String get overview => '概述';

  @override
  String get keyPoints => '要点';

  @override
  String get actionItems => '待办事项';

  @override
  String get keywords => '关键词';

  @override
  String get importantFacts => '重要事实';

  @override
  String get obligations => '义务';

  @override
  String get risks => '风险';

  @override
  String get findings => '发现';

  @override
  String wordsCount(int count) {
    return '$count 字';
  }

  @override
  String processingTime(String seconds) {
    return '$seconds 秒';
  }

  @override
  String get viewOriginalDocument => '查看原文档';

  @override
  String get copySummary => '复制摘要';

  @override
  String get summaryCopied => '摘要已复制到剪贴板';

  @override
  String get generatedBy => '由 DoCMind AI 生成';

  @override
  String wordCountLabel(int count) {
    return '字数：$count';
  }

  @override
  String processingTimeLabel(String seconds) {
    return '处理时间：$seconds 秒';
  }

  @override
  String get upgradeRequired => '需要升级';

  @override
  String get translateProOnly => '翻译功能仅限 Pro 方案。升级后可翻译摘要。';

  @override
  String get notNow => '暂不';

  @override
  String get manageSubscription => '管理订阅';

  @override
  String get changeYourPlan => '更改方案';

  @override
  String get unlockPremium => '解锁高级版';

  @override
  String get upgradeOrSwitch => '升级或切换至其他方案';

  @override
  String get getUnlimitedAccess => '获取全部功能的无限使用';

  @override
  String get monthly => '月付';

  @override
  String get yearly => '年付';

  @override
  String get save40 => '省 40%';

  @override
  String get unlimitedDocuments => '无限文档';

  @override
  String get unlimitedSummaries => '无限摘要';

  @override
  String get priorityAiProcessing => '优先 AI 处理';

  @override
  String get exportToPdf => '导出为 PDF';

  @override
  String get emailSupport => '邮件支持';

  @override
  String get everythingInPro => 'Pro 全部功能';

  @override
  String get ocrScannedDocs => '扫描文档 OCR';

  @override
  String get longDocSupport => '长文档支持（100+ 页）';

  @override
  String get advancedAiAnalysis => '高级 AI 分析';

  @override
  String get prioritySupport => '优先支持';

  @override
  String get earlyAccess => '新功能抢先体验';

  @override
  String get freePlanInfo => '免费版包含 2 份文档，每份最多 5 页。';

  @override
  String get restoring => '恢复中...';

  @override
  String get current => '当前';

  @override
  String get popular => '热门';

  @override
  String get perYear => '/年';

  @override
  String get perMonth => '/月';

  @override
  String get billedAnnually => '按年计费';

  @override
  String thatsOnly(String price) {
    return '相当于每月仅 $price';
  }

  @override
  String get getPro => '获取 Pro';

  @override
  String get getProPlus => '获取 Pro+';

  @override
  String get currentPlan => '当前方案';

  @override
  String get switchToYearly => '切换至年付';

  @override
  String get switchToMonthly => '切换至月付';

  @override
  String get upgradeToPro => '升级至 Pro';

  @override
  String get upgradeToProPlus => '升级至 Pro+';

  @override
  String get downgradeToPro => '降级至 Pro';

  @override
  String get downgradeToProPlus => '降级至 Pro+';

  @override
  String get changesAtEnd => '变更在计费周期结束时生效';

  @override
  String autoRenews(String date) {
    return '将于 $date 自动续订';
  }

  @override
  String expires(String date) {
    return '将于 $date 到期';
  }

  @override
  String get soon => '即将';

  @override
  String get active => '已激活';

  @override
  String get downgradePlan => '降级方案';

  @override
  String get downgradeConfirm => '您的方案将在当前计费周期结束时降级。在此之前您仍可继续使用现有功能。';

  @override
  String get confirmDowngrade => '确认降级';

  @override
  String get welcomeBack => '欢迎回来';

  @override
  String get signInContinue => '登录以继续使用 DoCMind AI';

  @override
  String get createAccountToStart => '创建账户即可开始使用';

  @override
  String get emailAddress => '电子邮箱';

  @override
  String get password => '密码';

  @override
  String get enterEmail => '请输入邮箱';

  @override
  String get validEmail => '请输入有效的邮箱地址';

  @override
  String get enterPassword => '请输入密码';

  @override
  String get passwordMinLength => '密码至少需要 8 个字符';

  @override
  String get signIn => '登录';

  @override
  String get createAccount => '创建账户';

  @override
  String get orContinueWith => '或使用以下方式继续';

  @override
  String get continueWithApple => '使用 Apple 继续';

  @override
  String get tryWithoutAccount => '无需账户试用';

  @override
  String get noAccount => '还没有账户？';

  @override
  String get haveAccount => '已有账户？';

  @override
  String get signUp => '注册';

  @override
  String get tryDoCMindAi => '试用 DoCMind AI';

  @override
  String trialsLeft(int count) {
    return '剩余 $count 次试用';
  }

  @override
  String get noTrialsRemaining => '试用次数已用完';

  @override
  String get summarizeNow => '立即摘要';

  @override
  String get analyzingDocument => '正在分析您的文档...';

  @override
  String get thisMayTakeAMoment => '请稍候';

  @override
  String get guestModeLimitations => '访客模式限制';

  @override
  String get maxPagesGuest => '每份文档最多 2 页';

  @override
  String get twoTrialsOnly => '仅 2 次试用（不可重置）';

  @override
  String get notSavedToHistory => '摘要不会保存到历史';

  @override
  String get noCloudSync => '无云端同步';

  @override
  String get withFreeAccount => '免费账户可享：';

  @override
  String get upToFivePages => '每份文档最多 5 页';

  @override
  String get threeDocsPerDay => '每天 3 份文档';

  @override
  String get historySavedForever => '历史永久保存';

  @override
  String get cloudSyncDevices => '多设备云端同步';

  @override
  String get wantUnlimitedAccess => '想要无限使用？';

  @override
  String get createFreeForMore => '创建免费账户获取更多功能';

  @override
  String get createFreeAccount => '创建免费账户';

  @override
  String get selectDocSource => '选择文档来源';

  @override
  String get browseFiles => '浏览文件';

  @override
  String get pdfWordDocs => 'PDF、Word 文档';

  @override
  String get takePhoto => '拍照';

  @override
  String get captureDocCamera => '使用相机拍摄文档';

  @override
  String get photoLibrary => '照片库';

  @override
  String get selectFromGallery => '从相册选择';

  @override
  String get fileTooLargeGuest => '文件过大。访客模式最大 5MB。';

  @override
  String get failedPickFile => '选择文件失败';

  @override
  String get failedCapturePhoto => '拍照失败';

  @override
  String get failedPickImage => '选择图片失败';

  @override
  String get trialLimitReached => '已达试用上限';

  @override
  String get trialLimitMsg => '您已用完所有免费试用次数。创建账户即可继续使用 DoCMind AI，享受无限使用。';

  @override
  String get noSummaryAvailable => '暂无摘要';

  @override
  String get summaryNotSaved => '此摘要将不会保存。创建账户即可保存！';

  @override
  String get documentSummary => '文档摘要';

  @override
  String get noOverviewAvailable => '暂无概述';

  @override
  String moreKeyPoints(int count) {
    return '还有 $count 个要点';
  }

  @override
  String itemsCount(int count) {
    return '$count 项';
  }

  @override
  String get createFreeToUnlock => '创建免费账户以解锁';

  @override
  String trialsRemaining(int count) {
    return '剩余 $count 次试用';
  }

  @override
  String get createAccountContinue => '创建账户以继续使用 DoCMind AI';

  @override
  String get createAccountUnlimited => '创建账户获取无限摘要';

  @override
  String get close => '关闭';

  @override
  String get processingFailed => '文档处理失败，请重试。';

  @override
  String get processingTakingLong => '处理时间超出预期，请在历史记录中查看状态。';

  @override
  String get translating => '翻译中';

  @override
  String get aiTranslatingYourSummary => 'AI正在翻译您的摘要';

  @override
  String get translationComplete => '翻译完成';

  @override
  String translatedTo(String language) {
    return '已翻译为$language';
  }

  @override
  String originalLanguage(String language) {
    return '原文: $language';
  }

  @override
  String generatedOn(String date) {
    return '生成于 $date';
  }

  @override
  String get pleaseWait => '请稍候';

  @override
  String get updateRequired => '需要更新';

  @override
  String get updateRequiredMsg => 'DoCMind AI 有新版本可用。请更新以继续使用该应用。';

  @override
  String get updateNow => '立即更新';

  @override
  String get onboardingUploadTitle => '上传文档';

  @override
  String get onboardingUploadDesc => '上传您的PDF、DOCX或图片，让AI完成其余工作。几秒内即可获得摘要。';

  @override
  String get onboardingSummaryTitle => 'AI智能摘要';

  @override
  String get onboardingSummaryDesc => '即时获取任何文档的关键要点、待办事项和重要信息。';

  @override
  String get onboardingTranslateTitle => '翻译摘要';

  @override
  String get onboardingTranslateDesc => '一键将您的摘要翻译成13种以上的语言。';

  @override
  String get onboardingShareTitle => '从任何应用分享';

  @override
  String get onboardingShareDesc => '直接从WhatsApp、Telegram或任何应用发送文件，即时获取摘要。';

  @override
  String get onboardingHistoryTitle => '历史记录与筛选';

  @override
  String get onboardingHistoryDesc => '所有文档集中在一个地方。按PDF、Word或图片筛选。';

  @override
  String get onboardingCopyShareTitle => '复制与分享';

  @override
  String get onboardingCopyShareDesc => '将摘要复制到剪贴板，或通过您喜爱的应用分享给任何人。';

  @override
  String get tutorial => '教程';

  @override
  String get onboardingSkip => '跳过';

  @override
  String get onboardingNext => '下一步';

  @override
  String get onboardingGetStarted => '开始使用';
}

/// The translations for Chinese, using the Han script (`zh_Hant`).
class SZhHant extends SZh {
  SZhHant() : super('zh_Hant');

  @override
  String get appName => 'DoCMind AI';

  @override
  String get appTagline => 'OCR、文件與 AI 智能摘要';

  @override
  String get navHome => '首頁';

  @override
  String get navHistory => '歷史';

  @override
  String get navSettings => '設定';

  @override
  String get addDocument => '新增文件';

  @override
  String get optionDocument => '文件';

  @override
  String get optionDocumentSub => 'PDF、Word 或其他檔案';

  @override
  String get optionGallery => '相簿';

  @override
  String get optionGallerySub => '從相片庫選擇';

  @override
  String get optionCamera => '相機';

  @override
  String get optionCameraSub => '拍照';

  @override
  String get greeting => '你好';

  @override
  String get planPro => 'Pro';

  @override
  String get planProPlus => 'Pro+';

  @override
  String get planFree => '免費';

  @override
  String get quickActions => '快速操作';

  @override
  String get recentDocuments => '最近文件';

  @override
  String get upload => '上傳';

  @override
  String get uploadFormats => 'PDF、DOCX、圖片';

  @override
  String get history => '歷史';

  @override
  String get viewAllDocs => '檢視全部文件';

  @override
  String get seeAll => '檢視全部';

  @override
  String get noDocumentsYet => '尚無文件';

  @override
  String get uploadFirstDoc => '上傳您的第一份文件，讓 AI 為您產生摘要';

  @override
  String get uploadDocument => '上傳文件';

  @override
  String get premiumActive => '進階會員已啟用';

  @override
  String get unlimitedDocsSummaries => '無限文件與摘要';

  @override
  String get freePlan => '免費版';

  @override
  String get noFreeDocsLeft => '免費額度已用完';

  @override
  String freeLeftCount(int count) {
    return '剩餘 $count 次免費';
  }

  @override
  String get upgradeForUnlimited => '升級取得無限使用';

  @override
  String freeDocsUsed(int used, int limit) {
    return '已使用 $used/$limit 個免費文件';
  }

  @override
  String get upgrade => '升級';

  @override
  String get failed => '失敗';

  @override
  String minAgo(int count) {
    return '$count 分鐘前';
  }

  @override
  String hoursAgo(int count) {
    return '$count 小時前';
  }

  @override
  String get yesterday => '昨天';

  @override
  String daysAgo(int count) {
    return '$count 天前';
  }

  @override
  String get clearFilters => '清除篩選';

  @override
  String get documentDeleted => '文件已刪除';

  @override
  String get noDocumentsFiltered => '找不到文件';

  @override
  String get tryRemovingFilters => '請嘗試移除篩選條件或\n上傳新文件';

  @override
  String get clearFiltersButton => '清除篩選';

  @override
  String get deleteDocument => '刪除文件';

  @override
  String get deleteDocumentConfirm => '確定要刪除此文件嗎？';

  @override
  String get deleteDocumentConfirmFull => '確定要刪除此文件嗎？此操作無法復原。';

  @override
  String get cancel => '取消';

  @override
  String get delete => '刪除';

  @override
  String get allDocuments => '全部文件';

  @override
  String get pdfOnly => '僅 PDF';

  @override
  String get wordOnly => '僅 Word';

  @override
  String get imagesOnly => '僅圖片';

  @override
  String get settings => '設定';

  @override
  String get proMember => 'Pro 會員';

  @override
  String get proPlusMember => 'Pro+ 會員';

  @override
  String get unlimitedAccess => '無限使用';

  @override
  String get upgradeForMoreFeatures => '升級取得更多功能';

  @override
  String get preferences => '偏好設定';

  @override
  String get support => '支援';

  @override
  String get account => '帳戶';

  @override
  String get notifications => '通知';

  @override
  String get darkMode => '深色模式';

  @override
  String get appLanguage => '應用程式語言';

  @override
  String get summaryLanguage => '摘要語言';

  @override
  String get helpFaq => '說明與常見問題';

  @override
  String get rateApp => '為應用程式評分';

  @override
  String get rateAppSub => '喜歡 DoCMind AI？給我們評分吧！';

  @override
  String get privacyPolicy => '隱私權政策';

  @override
  String get termsOfService => '服務條款';

  @override
  String get restorePurchases => '恢復購買';

  @override
  String get signOut => '登出';

  @override
  String get deleteAccount => '刪除帳戶';

  @override
  String get deleteAccountConfirm => '確定要刪除您的帳戶嗎？此操作無法復原。';

  @override
  String get deleteAccountTitle => '刪除帳戶？';

  @override
  String appVersion(String version) {
    return 'DoCMind AI v$version';
  }

  @override
  String whatsNew(String version) {
    return 'v$version 更新內容';
  }

  @override
  String get ok => '確定';

  @override
  String get document => '文件';

  @override
  String get failedToLoadDocument => '載入文件失敗';

  @override
  String get tryAgain => '重試';

  @override
  String get documentNotFound => '找不到文件';

  @override
  String get loadingPdf => '正在載入 PDF...';

  @override
  String get loadingPreview => '正在載入文件預覽...';

  @override
  String showingPage(int count) {
    return '第 1 頁，共 $count 頁';
  }

  @override
  String get documentContent => '文件內容';

  @override
  String get noContentExtracted => '尚未擷取內容';

  @override
  String get previewNotAvailable => '預覽不可用';

  @override
  String get viewSummary => '檢視摘要';

  @override
  String get generating => '產生中...';

  @override
  String get generateAiSummary => '產生 AI 摘要';

  @override
  String pagesCount(int count) {
    return '$count 頁';
  }

  @override
  String get uploadDocumentTitle => '上傳文件';

  @override
  String get tipReading => 'AI 正在閱讀您的文件...';

  @override
  String get tipExtracting => '正在擷取關鍵資訊...';

  @override
  String get tipIdentifying => '正在識別重要段落...';

  @override
  String get tipBuilding => '正在產生結構化摘要...';

  @override
  String get tipFinalizing => '即將完成，正在處理...';

  @override
  String get stepUploading => '上傳中';

  @override
  String get stepExtractingText => '擷取文字';

  @override
  String get stepAiAnalyzing => 'AI 分析中';

  @override
  String get summaryLang => '摘要語言';

  @override
  String uploadingProgress(int percent) {
    return '正在上傳文件... $percent%';
  }

  @override
  String get extractingText => '正在從文件中擷取文字...';

  @override
  String get aiAnalyzing => 'AI 正在分析與摘要...';

  @override
  String get preparing => '準備中...';

  @override
  String get tapToUpload => '點擊上傳文件';

  @override
  String supportedFormats(int size) {
    return '支援 PDF、DOCX、JPG、PNG，最大 ${size}MB';
  }

  @override
  String get aiWillExtract => 'AI 將擷取並摘要內容';

  @override
  String get freeLimitReached => '已達免費上限，升級後可繼續使用';

  @override
  String get readyToProcess => '準備處理';

  @override
  String get chooseDifferentFile => '選擇其他檔案';

  @override
  String get selectedFile => '已選檔案';

  @override
  String get generateSummary => '產生摘要';

  @override
  String freePlanFileLimit(int size) {
    return '免費版限制：單檔最大 ${size}MB。升級後可上傳更大文件。';
  }

  @override
  String fileSizeExceeded(int size) {
    return '檔案大小超出您的方案限制（最大 ${size}MB）。升級後可上傳更大檔案。';
  }

  @override
  String get freeLimitReachedTitle => '已達免費上限';

  @override
  String get freeLimitReachedMsg => '您已用完所有免費文件額度。升級至 Pro 取得無限使用！';

  @override
  String get maybeLater => '稍後再說';

  @override
  String get upgradeNow => '立即升級';

  @override
  String get summary => '摘要';

  @override
  String get failedToLoadSummary => '載入摘要失敗';

  @override
  String get summaryNotFound => '找不到摘要';

  @override
  String get overview => '概述';

  @override
  String get keyPoints => '要點';

  @override
  String get actionItems => '待辦事項';

  @override
  String get keywords => '關鍵字';

  @override
  String get importantFacts => '重要事實';

  @override
  String get obligations => '義務';

  @override
  String get risks => '風險';

  @override
  String get findings => '發現';

  @override
  String wordsCount(int count) {
    return '$count 字';
  }

  @override
  String processingTime(String seconds) {
    return '$seconds 秒';
  }

  @override
  String get viewOriginalDocument => '檢視原始文件';

  @override
  String get copySummary => '複製摘要';

  @override
  String get summaryCopied => '摘要已複製到剪貼簿';

  @override
  String get generatedBy => '由 DoCMind AI 產生';

  @override
  String wordCountLabel(int count) {
    return '字數：$count';
  }

  @override
  String processingTimeLabel(String seconds) {
    return '處理時間：$seconds 秒';
  }

  @override
  String get upgradeRequired => '需要升級';

  @override
  String get translateProOnly => '翻譯功能僅限 Pro 方案。升級後可翻譯摘要。';

  @override
  String get notNow => '暫不';

  @override
  String get manageSubscription => '管理訂閱';

  @override
  String get changeYourPlan => '變更方案';

  @override
  String get unlockPremium => '解鎖進階版';

  @override
  String get upgradeOrSwitch => '升級或切換至其他方案';

  @override
  String get getUnlimitedAccess => '取得全部功能的無限使用';

  @override
  String get monthly => '月付';

  @override
  String get yearly => '年付';

  @override
  String get save40 => '省 40%';

  @override
  String get unlimitedDocuments => '無限文件';

  @override
  String get unlimitedSummaries => '無限摘要';

  @override
  String get priorityAiProcessing => '優先 AI 處理';

  @override
  String get exportToPdf => '匯出為 PDF';

  @override
  String get emailSupport => '電子郵件支援';

  @override
  String get everythingInPro => 'Pro 全部功能';

  @override
  String get ocrScannedDocs => '掃描文件 OCR';

  @override
  String get longDocSupport => '長文件支援（100+ 頁）';

  @override
  String get advancedAiAnalysis => '進階 AI 分析';

  @override
  String get prioritySupport => '優先支援';

  @override
  String get earlyAccess => '新功能搶先體驗';

  @override
  String get freePlanInfo => '免費版包含 2 份文件，每份最多 5 頁。';

  @override
  String get restoring => '恢復中...';

  @override
  String get current => '目前';

  @override
  String get popular => '熱門';

  @override
  String get perYear => '/年';

  @override
  String get perMonth => '/月';

  @override
  String get billedAnnually => '按年計費';

  @override
  String thatsOnly(String price) {
    return '相當於每月僅 $price';
  }

  @override
  String get getPro => '取得 Pro';

  @override
  String get getProPlus => '取得 Pro+';

  @override
  String get currentPlan => '目前方案';

  @override
  String get switchToYearly => '切換至年付';

  @override
  String get switchToMonthly => '切換至月付';

  @override
  String get upgradeToPro => '升級至 Pro';

  @override
  String get upgradeToProPlus => '升級至 Pro+';

  @override
  String get downgradeToPro => '降級至 Pro';

  @override
  String get downgradeToProPlus => '降級至 Pro+';

  @override
  String get changesAtEnd => '變更在計費週期結束時生效';

  @override
  String autoRenews(String date) {
    return '將於 $date 自動續訂';
  }

  @override
  String expires(String date) {
    return '將於 $date 到期';
  }

  @override
  String get soon => '即將';

  @override
  String get active => '已啟用';

  @override
  String get downgradePlan => '降級方案';

  @override
  String get downgradeConfirm => '您的方案將在目前計費週期結束時降級。在此之前您仍可繼續使用現有功能。';

  @override
  String get confirmDowngrade => '確認降級';

  @override
  String get welcomeBack => '歡迎回來';

  @override
  String get signInContinue => '登入以繼續使用 DoCMind AI';

  @override
  String get createAccountToStart => '建立帳戶即可開始使用';

  @override
  String get emailAddress => '電子郵件';

  @override
  String get password => '密碼';

  @override
  String get enterEmail => '請輸入電子郵件';

  @override
  String get validEmail => '請輸入有效的電子郵件地址';

  @override
  String get enterPassword => '請輸入密碼';

  @override
  String get passwordMinLength => '密碼至少需要 8 個字元';

  @override
  String get signIn => '登入';

  @override
  String get createAccount => '建立帳戶';

  @override
  String get orContinueWith => '或使用以下方式繼續';

  @override
  String get continueWithApple => '使用 Apple 繼續';

  @override
  String get tryWithoutAccount => '無需帳戶試用';

  @override
  String get noAccount => '還沒有帳戶？';

  @override
  String get haveAccount => '已有帳戶？';

  @override
  String get signUp => '註冊';

  @override
  String get tryDoCMindAi => '試用 DoCMind AI';

  @override
  String trialsLeft(int count) {
    return '剩餘 $count 次試用';
  }

  @override
  String get noTrialsRemaining => '試用次數已用完';

  @override
  String get summarizeNow => '立即摘要';

  @override
  String get analyzingDocument => '正在分析您的文件...';

  @override
  String get thisMayTakeAMoment => '請稍候';

  @override
  String get guestModeLimitations => '訪客模式限制';

  @override
  String get maxPagesGuest => '每份文件最多 2 頁';

  @override
  String get twoTrialsOnly => '僅 2 次試用（不可重置）';

  @override
  String get notSavedToHistory => '摘要不會儲存至歷史';

  @override
  String get noCloudSync => '無雲端同步';

  @override
  String get withFreeAccount => '免費帳戶可享：';

  @override
  String get upToFivePages => '每份文件最多 5 頁';

  @override
  String get threeDocsPerDay => '每天 3 份文件';

  @override
  String get historySavedForever => '歷史永久儲存';

  @override
  String get cloudSyncDevices => '多裝置雲端同步';

  @override
  String get wantUnlimitedAccess => '想要無限使用？';

  @override
  String get createFreeForMore => '建立免費帳戶取得更多功能';

  @override
  String get createFreeAccount => '建立免費帳戶';

  @override
  String get selectDocSource => '選擇文件來源';

  @override
  String get browseFiles => '瀏覽檔案';

  @override
  String get pdfWordDocs => 'PDF、Word 文件';

  @override
  String get takePhoto => '拍照';

  @override
  String get captureDocCamera => '使用相機拍攝文件';

  @override
  String get photoLibrary => '相片庫';

  @override
  String get selectFromGallery => '從相簿選擇';

  @override
  String get fileTooLargeGuest => '檔案過大。訪客模式最大 5MB。';

  @override
  String get failedPickFile => '選擇檔案失敗';

  @override
  String get failedCapturePhoto => '拍照失敗';

  @override
  String get failedPickImage => '選擇圖片失敗';

  @override
  String get trialLimitReached => '已達試用上限';

  @override
  String get trialLimitMsg => '您已用完所有免費試用次數。建立帳戶即可繼續使用 DoCMind AI，享受無限使用。';

  @override
  String get noSummaryAvailable => '尚無摘要';

  @override
  String get summaryNotSaved => '此摘要將不會儲存。建立帳戶即可儲存！';

  @override
  String get documentSummary => '文件摘要';

  @override
  String get noOverviewAvailable => '尚無概述';

  @override
  String moreKeyPoints(int count) {
    return '還有 $count 個要點';
  }

  @override
  String itemsCount(int count) {
    return '$count 項';
  }

  @override
  String get createFreeToUnlock => '建立免費帳戶以解鎖';

  @override
  String trialsRemaining(int count) {
    return '剩餘 $count 次試用';
  }

  @override
  String get createAccountContinue => '建立帳戶以繼續使用 DoCMind AI';

  @override
  String get createAccountUnlimited => '建立帳戶取得無限摘要';

  @override
  String get close => '關閉';

  @override
  String get processingFailed => '文件處理失敗，請重試。';

  @override
  String get processingTakingLong => '處理時間超出預期，請在歷史記錄中檢視狀態。';

  @override
  String get translating => '翻譯中';

  @override
  String get aiTranslatingYourSummary => 'AI正在翻譯您的摘要';

  @override
  String get translationComplete => '翻譯完成';

  @override
  String translatedTo(String language) {
    return '已翻譯為$language';
  }

  @override
  String originalLanguage(String language) {
    return '原文：$language';
  }

  @override
  String generatedOn(String date) {
    return '產生於 $date';
  }

  @override
  String get pleaseWait => '請稍候';

  @override
  String get updateRequired => '需要更新';

  @override
  String get updateRequiredMsg => 'DoCMind AI 有新版本可用。請更新以繼續使用此應用程式。';

  @override
  String get updateNow => '立即更新';

  @override
  String get onboardingUploadTitle => '上傳文件';

  @override
  String get onboardingUploadDesc => '上傳您的PDF、DOCX或圖片，讓AI完成其餘工作。幾秒內即可獲得摘要。';

  @override
  String get onboardingSummaryTitle => 'AI智慧摘要';

  @override
  String get onboardingSummaryDesc => '即時取得任何文件的關鍵要點、待辦事項和重要資訊。';

  @override
  String get onboardingTranslateTitle => '翻譯摘要';

  @override
  String get onboardingTranslateDesc => '一鍵將您的摘要翻譯成13種以上的語言。';

  @override
  String get onboardingShareTitle => '從任何應用程式分享';

  @override
  String get onboardingShareDesc => '直接從WhatsApp、Telegram或任何應用程式傳送檔案，即時取得摘要。';

  @override
  String get onboardingHistoryTitle => '歷史記錄與篩選';

  @override
  String get onboardingHistoryDesc => '所有文件集中在一處。按PDF、Word或圖片篩選。';

  @override
  String get onboardingCopyShareTitle => '複製與分享';

  @override
  String get onboardingCopyShareDesc => '將摘要複製到剪貼簿，或透過您喜愛的應用程式分享給任何人。';

  @override
  String get tutorial => '教學';

  @override
  String get onboardingSkip => '略過';

  @override
  String get onboardingNext => '下一步';

  @override
  String get onboardingGetStarted => '開始使用';
}
