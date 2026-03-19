// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class SRu extends S {
  SRu([String locale = 'ru']) : super(locale);

  @override
  String get appName => 'DoCMind AI';

  @override
  String get appTagline => 'OCR, документы и ИИ-резюме';

  @override
  String get navHome => 'Главная';

  @override
  String get navHistory => 'История';

  @override
  String get navSettings => 'Настройки';

  @override
  String get addDocument => 'Добавить документ';

  @override
  String get optionDocument => 'Документ';

  @override
  String get optionDocumentSub => 'PDF, Word или другие файлы';

  @override
  String get optionGallery => 'Галерея';

  @override
  String get optionGallerySub => 'Выбрать из фотобиблиотеки';

  @override
  String get optionCamera => 'Камера';

  @override
  String get optionCameraSub => 'Сделать фото';

  @override
  String get greeting => 'Здравствуйте';

  @override
  String get planPro => 'Pro';

  @override
  String get planProPlus => 'Pro+';

  @override
  String get planFree => 'Бесплатно';

  @override
  String get quickActions => 'Быстрые действия';

  @override
  String get recentDocuments => 'Недавние документы';

  @override
  String get upload => 'Загрузить';

  @override
  String get uploadFormats => 'PDF, DOCX, изображения';

  @override
  String get history => 'История';

  @override
  String get viewAllDocs => 'Все документы';

  @override
  String get seeAll => 'Смотреть всё';

  @override
  String get noDocumentsYet => 'Документов пока нет';

  @override
  String get uploadFirstDoc =>
      'Загрузите первый документ, и ИИ создаст для вас резюме';

  @override
  String get uploadDocument => 'Загрузить документ';

  @override
  String get premiumActive => 'Премиум активен';

  @override
  String get unlimitedDocsSummaries =>
      'Неограниченное количество документов и резюме';

  @override
  String get freePlan => 'Бесплатный план';

  @override
  String get noFreeDocsLeft => 'Бесплатные документы закончились';

  @override
  String freeLeftCount(int count) {
    return '$count бесплатных осталось';
  }

  @override
  String get upgradeForUnlimited =>
      'Перейдите на премиум для неограниченного доступа';

  @override
  String freeDocsUsed(int used, int limit) {
    return 'Использовано $used из $limit бесплатных документов';
  }

  @override
  String get upgrade => 'Обновить';

  @override
  String get failed => 'Ошибка';

  @override
  String minAgo(int count) {
    return '$count мин. назад';
  }

  @override
  String hoursAgo(int count) {
    return '$count ч назад';
  }

  @override
  String get yesterday => 'Вчера';

  @override
  String daysAgo(int count) {
    return '$count дн. назад';
  }

  @override
  String get clearFilters => 'Сбросить фильтры';

  @override
  String get documentDeleted => 'Документ удалён';

  @override
  String get noDocumentsFiltered => 'Документы не найдены';

  @override
  String get tryRemovingFilters =>
      'Попробуйте сбросить фильтры или загрузить\nновые документы';

  @override
  String get clearFiltersButton => 'Сбросить фильтры';

  @override
  String get deleteDocument => 'Удалить документ';

  @override
  String get deleteDocumentConfirm =>
      'Вы уверены, что хотите удалить этот документ?';

  @override
  String get deleteDocumentConfirmFull =>
      'Вы уверены, что хотите удалить этот документ? Это действие нельзя отменить.';

  @override
  String get cancel => 'Отмена';

  @override
  String get delete => 'Удалить';

  @override
  String get allDocuments => 'Все документы';

  @override
  String get pdfOnly => 'Только PDF';

  @override
  String get wordOnly => 'Только Word';

  @override
  String get imagesOnly => 'Только изображения';

  @override
  String get settings => 'Настройки';

  @override
  String get proMember => 'Участник Pro';

  @override
  String get proPlusMember => 'Участник Pro+';

  @override
  String get unlimitedAccess => 'Неограниченный доступ';

  @override
  String get upgradeForMoreFeatures =>
      'Обновитесь для доступа к дополнительным функциям';

  @override
  String get preferences => 'Предпочтения';

  @override
  String get support => 'Поддержка';

  @override
  String get account => 'Аккаунт';

  @override
  String get notifications => 'Уведомления';

  @override
  String get darkMode => 'Тёмная тема';

  @override
  String get appLanguage => 'Язык приложения';

  @override
  String get summaryLanguage => 'Язык резюме';

  @override
  String get helpFaq => 'Помощь и FAQ';

  @override
  String get rateApp => 'Оценить приложение';

  @override
  String get rateAppSub => 'Нравится DoCMind AI? Оцените нас!';

  @override
  String get privacyPolicy => 'Политика конфиденциальности';

  @override
  String get termsOfService => 'Условия использования';

  @override
  String get restorePurchases => 'Восстановить покупки';

  @override
  String get signOut => 'Выйти';

  @override
  String get deleteAccount => 'Удалить аккаунт';

  @override
  String get deleteAccountConfirm =>
      'Вы уверены, что хотите удалить свой аккаунт? Это действие нельзя отменить.';

  @override
  String get deleteAccountTitle => 'Удалить аккаунт?';

  @override
  String appVersion(String version) {
    return 'DoCMind AI v$version';
  }

  @override
  String whatsNew(String version) {
    return 'Что нового в v$version';
  }

  @override
  String get ok => 'ОК';

  @override
  String get document => 'Документ';

  @override
  String get failedToLoadDocument => 'Не удалось загрузить документ';

  @override
  String get tryAgain => 'Повторить';

  @override
  String get documentNotFound => 'Документ не найден';

  @override
  String get loadingPdf => 'Загрузка PDF...';

  @override
  String get loadingPreview => 'Загрузка предпросмотра документа...';

  @override
  String showingPage(int count) {
    return 'Страница 1 из $count';
  }

  @override
  String get documentContent => 'Содержимое документа';

  @override
  String get noContentExtracted => 'Содержимое ещё не извлечено';

  @override
  String get previewNotAvailable => 'Предпросмотр недоступен';

  @override
  String get viewSummary => 'Просмотр резюме';

  @override
  String get generating => 'Генерация...';

  @override
  String get generateAiSummary => 'Создать ИИ-резюме';

  @override
  String pagesCount(int count) {
    return '$count стр.';
  }

  @override
  String get uploadDocumentTitle => 'Загрузить документ';

  @override
  String get tipReading => 'ИИ читает ваш документ...';

  @override
  String get tipExtracting => 'Извлечение ключевой информации...';

  @override
  String get tipIdentifying => 'Определение важных разделов...';

  @override
  String get tipBuilding => 'Создание структурированного резюме...';

  @override
  String get tipFinalizing => 'Почти готово, завершение...';

  @override
  String get stepUploading => 'Загрузка';

  @override
  String get stepExtractingText => 'Извлечение текста';

  @override
  String get stepAiAnalyzing => 'Анализ ИИ';

  @override
  String get summaryLang => 'Язык резюме';

  @override
  String uploadingProgress(int percent) {
    return 'Загрузка документа... $percent%';
  }

  @override
  String get extractingText => 'Извлечение текста из документа...';

  @override
  String get aiAnalyzing => 'ИИ анализирует и создаёт резюме...';

  @override
  String get preparing => 'Подготовка...';

  @override
  String get tapToUpload => 'Нажмите, чтобы загрузить документ';

  @override
  String supportedFormats(int size) {
    return 'PDF, DOCX, JPG, PNG до $size МБ';
  }

  @override
  String get aiWillExtract => 'ИИ извлечёт и обобщит содержимое';

  @override
  String get freeLimitReached =>
      'Достигнут бесплатный лимит. Обновитесь для продолжения';

  @override
  String get readyToProcess => 'Готово к обработке';

  @override
  String get chooseDifferentFile => 'Выбрать другой файл';

  @override
  String get selectedFile => 'Выбранный файл';

  @override
  String get generateSummary => 'Создать резюме';

  @override
  String freePlanFileLimit(int size) {
    return 'Лимит бесплатного плана: макс. $size МБ на файл. Обновитесь для загрузки больших документов.';
  }

  @override
  String fileSizeExceeded(int size) {
    return 'Размер файла превышает лимит вашего плана (макс. $size МБ). Обновитесь для больших файлов.';
  }

  @override
  String get freeLimitReachedTitle => 'Достигнут бесплатный лимит';

  @override
  String get freeLimitReachedMsg =>
      'Вы использовали все бесплатные документы. Перейдите на Pro для неограниченного доступа!';

  @override
  String get maybeLater => 'Позже';

  @override
  String get upgradeNow => 'Обновить сейчас';

  @override
  String get summary => 'Резюме';

  @override
  String get failedToLoadSummary => 'Не удалось загрузить резюме';

  @override
  String get summaryNotFound => 'Резюме не найдено';

  @override
  String get overview => 'Обзор';

  @override
  String get keyPoints => 'Ключевые моменты';

  @override
  String get actionItems => 'Задачи';

  @override
  String get keywords => 'Ключевые слова';

  @override
  String get importantFacts => 'Важные факты';

  @override
  String get obligations => 'Обязательства';

  @override
  String get risks => 'Риски';

  @override
  String get findings => 'Выводы';

  @override
  String wordsCount(int count) {
    return '$count слов';
  }

  @override
  String processingTime(String seconds) {
    return '$seconds с';
  }

  @override
  String get viewOriginalDocument => 'Просмотр исходного документа';

  @override
  String get copySummary => 'Копировать резюме';

  @override
  String get summaryCopied => 'Резюме скопировано в буфер обмена';

  @override
  String get generatedBy => 'Создано DoCMind AI';

  @override
  String wordCountLabel(int count) {
    return 'Количество слов: $count';
  }

  @override
  String processingTimeLabel(String seconds) {
    return 'Время обработки: $seconds с';
  }

  @override
  String get upgradeRequired => 'Требуется обновление';

  @override
  String get translateProOnly =>
      'Перевод доступен в планах Pro. Обновитесь для перевода резюме.';

  @override
  String get notNow => 'Не сейчас';

  @override
  String get manageSubscription => 'Управление подпиской';

  @override
  String get changeYourPlan => 'Изменить план';

  @override
  String get unlockPremium => 'Разблокировать премиум';

  @override
  String get upgradeOrSwitch => 'Обновитесь или перейдите на другой план';

  @override
  String get getUnlimitedAccess =>
      'Получите неограниченный доступ ко всем функциям';

  @override
  String get monthly => 'Ежемесячно';

  @override
  String get yearly => 'Ежегодно';

  @override
  String get save40 => 'ЭКОНОМИЯ 40%';

  @override
  String get unlimitedDocuments => 'Неограниченное количество документов';

  @override
  String get unlimitedSummaries => 'Неограниченное количество резюме';

  @override
  String get priorityAiProcessing => 'Приоритетная обработка ИИ';

  @override
  String get exportToPdf => 'Экспорт в PDF';

  @override
  String get emailSupport => 'Поддержка по email';

  @override
  String get everythingInPro => 'Всё из Pro';

  @override
  String get ocrScannedDocs => 'OCR для отсканированных документов';

  @override
  String get longDocSupport => 'Поддержка длинных документов (100+ стр.)';

  @override
  String get advancedAiAnalysis => 'Расширенный ИИ-анализ';

  @override
  String get prioritySupport => 'Приоритетная поддержка';

  @override
  String get earlyAccess => 'Ранний доступ к функциям';

  @override
  String get freePlanInfo =>
      'Бесплатный план включает 2 документа до 5 страниц каждый.';

  @override
  String get restoring => 'Восстановление...';

  @override
  String get current => 'ТЕКУЩИЙ';

  @override
  String get popular => 'ПОПУЛЯРНЫЙ';

  @override
  String get perYear => '/год';

  @override
  String get perMonth => '/мес';

  @override
  String get billedAnnually => 'Оплата ежегодно';

  @override
  String thatsOnly(String price) {
    return 'Всего $price/мес';
  }

  @override
  String get getPro => 'Получить Pro';

  @override
  String get getProPlus => 'Получить Pro+';

  @override
  String get currentPlan => 'Текущий план';

  @override
  String get switchToYearly => 'Перейти на годовой';

  @override
  String get switchToMonthly => 'Перейти на месячный';

  @override
  String get upgradeToPro => 'Обновить до Pro';

  @override
  String get upgradeToProPlus => 'Обновить до Pro+';

  @override
  String get downgradeToPro => 'Понизить до Pro';

  @override
  String get downgradeToProPlus => 'Понизить до Pro+';

  @override
  String get changesAtEnd => 'Изменения в конце периода оплаты';

  @override
  String autoRenews(String date) {
    return 'Продление $date';
  }

  @override
  String expires(String date) {
    return 'Истекает $date';
  }

  @override
  String get soon => 'скоро';

  @override
  String get active => 'АКТИВЕН';

  @override
  String get downgradePlan => 'Понизить план';

  @override
  String get downgradeConfirm =>
      'Ваш план будет понижен в конце текущего периода оплаты. Текущие функции останутся до этого момента.';

  @override
  String get confirmDowngrade => 'Подтвердить понижение';

  @override
  String get welcomeBack => 'С возвращением';

  @override
  String get signInContinue => 'Войдите, чтобы продолжить в DoCMind AI';

  @override
  String get createAccountToStart => 'Создайте аккаунт, чтобы начать';

  @override
  String get emailAddress => 'Email';

  @override
  String get password => 'Пароль';

  @override
  String get enterEmail => 'Введите email';

  @override
  String get validEmail => 'Введите корректный email';

  @override
  String get enterPassword => 'Введите пароль';

  @override
  String get passwordMinLength => 'Пароль должен содержать не менее 8 символов';

  @override
  String get signIn => 'Войти';

  @override
  String get createAccount => 'Создать аккаунт';

  @override
  String get orContinueWith => 'или продолжить с';

  @override
  String get continueWithApple => 'Продолжить с Apple';

  @override
  String get tryWithoutAccount => 'Попробовать без аккаунта';

  @override
  String get noAccount => 'Нет аккаунта? ';

  @override
  String get haveAccount => 'Уже есть аккаунт? ';

  @override
  String get signUp => 'Регистрация';

  @override
  String get tryDoCMindAi => 'Попробовать DoCMind AI';

  @override
  String trialsLeft(int count) {
    return '$count проб(ы) осталось';
  }

  @override
  String get noTrialsRemaining => 'Пробные попытки закончились';

  @override
  String get summarizeNow => 'Создать резюме';

  @override
  String get analyzingDocument => 'Анализ документа...';

  @override
  String get thisMayTakeAMoment => 'Это может занять некоторое время';

  @override
  String get guestModeLimitations => 'Ограничения гостевого режима';

  @override
  String get maxPagesGuest => 'Макс. 2 страницы на документ';

  @override
  String get twoTrialsOnly => 'Только 2 пробные попытки (без сброса)';

  @override
  String get notSavedToHistory => 'Резюме не сохраняется в историю';

  @override
  String get noCloudSync => 'Нет облачной синхронизации';

  @override
  String get withFreeAccount => 'С бесплатным аккаунтом вы получаете:';

  @override
  String get upToFivePages => 'До 5 страниц на документ';

  @override
  String get threeDocsPerDay => '3 документа в день';

  @override
  String get historySavedForever => 'История сохраняется навсегда';

  @override
  String get cloudSyncDevices => 'Облачная синхронизация между устройствами';

  @override
  String get wantUnlimitedAccess => 'Нужен неограниченный доступ?';

  @override
  String get createFreeForMore =>
      'Создайте бесплатный аккаунт для дополнительных функций';

  @override
  String get createFreeAccount => 'Создать бесплатный аккаунт';

  @override
  String get selectDocSource => 'Выберите источник документа';

  @override
  String get browseFiles => 'Обзор файлов';

  @override
  String get pdfWordDocs => 'PDF, документы Word';

  @override
  String get takePhoto => 'Сделать фото';

  @override
  String get captureDocCamera => 'Сфотографировать документ';

  @override
  String get photoLibrary => 'Фотобиблиотека';

  @override
  String get selectFromGallery => 'Выбрать из галереи';

  @override
  String get fileTooLargeGuest =>
      'Файл слишком большой. Максимум 5 МБ в гостевом режиме.';

  @override
  String get failedPickFile => 'Не удалось выбрать файл';

  @override
  String get failedCapturePhoto => 'Не удалось сделать фото';

  @override
  String get failedPickImage => 'Не удалось выбрать изображение';

  @override
  String get trialLimitReached => 'Достигнут лимит проб';

  @override
  String get trialLimitMsg =>
      'Вы использовали все пробные попытки. Создайте аккаунт, чтобы продолжить использовать DoCMind AI с неограниченным доступом.';

  @override
  String get noSummaryAvailable => 'Резюме недоступно';

  @override
  String get summaryNotSaved =>
      'Это резюме не будет сохранено. Создайте аккаунт, чтобы сохранить его!';

  @override
  String get documentSummary => 'Резюме документа';

  @override
  String get noOverviewAvailable => 'Обзор недоступен';

  @override
  String moreKeyPoints(int count) {
    return 'ещё $count ключевых моментов';
  }

  @override
  String itemsCount(int count) {
    return '$count элементов';
  }

  @override
  String get createFreeToUnlock =>
      'Создайте бесплатный аккаунт для разблокировки';

  @override
  String trialsRemaining(int count) {
    return 'Осталось $count проб(ы)';
  }

  @override
  String get createAccountContinue =>
      'Создайте аккаунт, чтобы продолжить использование DoCMind AI';

  @override
  String get createAccountUnlimited =>
      'Создайте аккаунт для неограниченных резюме';

  @override
  String get close => 'Закрыть';

  @override
  String get processingFailed =>
      'Обработка документа не удалась. Попробуйте снова.';

  @override
  String get processingTakingLong =>
      'Обработка занимает больше времени, чем ожидалось. Проверьте статус в разделе «История».';

  @override
  String get translating => 'Перевод';

  @override
  String get aiTranslatingYourSummary => 'ИИ переводит ваше резюме';

  @override
  String get translationComplete => 'Перевод завершён';

  @override
  String translatedTo(String language) {
    return 'Переведено на $language';
  }

  @override
  String originalLanguage(String language) {
    return 'Оригинал: $language';
  }

  @override
  String generatedOn(String date) {
    return 'Создано $date';
  }

  @override
  String get pleaseWait => 'Подождите';

  @override
  String get updateRequired => 'Требуется обновление';

  @override
  String get updateRequiredMsg =>
      'Доступна новая версия DoCMind AI. Пожалуйста, обновите приложение, чтобы продолжить использование.';

  @override
  String get updateNow => 'Обновить сейчас';

  @override
  String get onboardingUploadTitle => 'Загрузите документы';

  @override
  String get onboardingUploadDesc =>
      'Загрузите PDF, DOCX или изображения, и ИИ сделает всё остальное. Получите сводку за секунды.';

  @override
  String get onboardingSummaryTitle => 'Сводки на основе ИИ';

  @override
  String get onboardingSummaryDesc =>
      'Мгновенно получайте ключевые моменты, задачи и важные факты из любого документа.';

  @override
  String get onboardingTranslateTitle => 'Переводите сводки';

  @override
  String get onboardingTranslateDesc =>
      'Переведите ваши сводки на 13+ языков одним нажатием.';

  @override
  String get onboardingShareTitle => 'Делитесь из любого приложения';

  @override
  String get onboardingShareDesc =>
      'Отправляйте файлы прямо из WhatsApp, Telegram или любого приложения для мгновенных сводок.';

  @override
  String get onboardingHistoryTitle => 'История и фильтры';

  @override
  String get onboardingHistoryDesc =>
      'Все ваши документы организованы в одном месте. Фильтруйте по PDF, Word или изображениям.';

  @override
  String get onboardingCopyShareTitle => 'Копировать и Поделиться';

  @override
  String get onboardingCopyShareDesc =>
      'Скопируйте резюме в буфер обмена или поделитесь ими через любимые приложения.';

  @override
  String get tutorial => 'Руководство';

  @override
  String get onboardingSkip => 'Пропустить';

  @override
  String get onboardingNext => 'Далее';

  @override
  String get onboardingGetStarted => 'Начать';
}
