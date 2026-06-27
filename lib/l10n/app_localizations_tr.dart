// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class STr extends S {
  STr([String locale = 'tr']) : super(locale);

  @override
  String get appName => 'DoCMind AI';

  @override
  String get appTagline => 'OCR, Belge ve AI Özetleyici';

  @override
  String get navHome => 'Ana Sayfa';

  @override
  String get navHistory => 'Geçmiş';

  @override
  String get navSettings => 'Ayarlar';

  @override
  String get addDocument => 'Belge ekle';

  @override
  String get optionDocument => 'Belge';

  @override
  String get optionDocumentSub => 'PDF, Word veya diğer dosyalar';

  @override
  String get optionGallery => 'Galeri';

  @override
  String get optionGallerySub => 'Fotoğraf kütüphanesinden seç';

  @override
  String get optionCamera => 'Kamera';

  @override
  String get optionCameraSub => 'Fotoğraf çek';

  @override
  String get greeting => 'Merhaba';

  @override
  String get planPro => 'Pro';

  @override
  String get planProPlus => 'Pro+';

  @override
  String get planFree => 'Ücretsiz';

  @override
  String get quickActions => 'Hızlı İşlemler';

  @override
  String get recentDocuments => 'Son Belgeler';

  @override
  String get upload => 'Yükle';

  @override
  String get uploadFormats => 'PDF, DOCX, Görsel';

  @override
  String get history => 'Geçmiş';

  @override
  String get viewAllDocs => 'Tüm belgeleri gör';

  @override
  String get seeAll => 'Tümünü Gör';

  @override
  String get noDocumentsYet => 'Henüz belge yok';

  @override
  String get uploadFirstDoc =>
      'İlk belgenizi yükleyin ve AI\'ın sizin için özetlemesine izin verin';

  @override
  String get uploadDocument => 'Belge Yükle';

  @override
  String get premiumActive => 'Premium Aktif';

  @override
  String get unlimitedDocsSummaries => 'Sınırsız belge ve özet';

  @override
  String get freePlan => 'Ücretsiz Plan';

  @override
  String get noFreeDocsLeft => 'Ücretsiz belge kalmadı';

  @override
  String freeLeftCount(int count) {
    return '$count ücretsiz kaldı';
  }

  @override
  String get upgradeForUnlimited => 'Sınırsız erişim için yükseltin';

  @override
  String freeDocsUsed(int used, int limit) {
    return '$limit ücretsiz belgeden $used tanesi kullanıldı';
  }

  @override
  String get upgrade => 'Yükselt';

  @override
  String get failed => 'Başarısız';

  @override
  String minAgo(int count) {
    return '$count dk önce';
  }

  @override
  String hoursAgo(int count) {
    return '${count}s önce';
  }

  @override
  String get yesterday => 'Dün';

  @override
  String daysAgo(int count) {
    return '$count gün önce';
  }

  @override
  String get clearFilters => 'Filtreleri temizle';

  @override
  String get documentDeleted => 'Belge silindi';

  @override
  String get noDocumentsFiltered => 'Belge bulunamadı';

  @override
  String get tryRemovingFilters =>
      'Filtreleri kaldırmayı veya\nyeni belge yüklemeyi deneyin';

  @override
  String get clearFiltersButton => 'Filtreleri Temizle';

  @override
  String get deleteDocument => 'Belgeyi Sil';

  @override
  String get deleteDocumentConfirm =>
      'Bu belgeyi silmek istediğinizden emin misiniz?';

  @override
  String get deleteDocumentConfirmFull =>
      'Bu belgeyi silmek istediğinizden emin misiniz? Bu işlem geri alınamaz.';

  @override
  String get cancel => 'İptal';

  @override
  String get delete => 'Sil';

  @override
  String get allDocuments => 'Tüm Belgeler';

  @override
  String get pdfOnly => 'Sadece PDF';

  @override
  String get wordOnly => 'Sadece Word';

  @override
  String get imagesOnly => 'Sadece Görseller';

  @override
  String get settings => 'Ayarlar';

  @override
  String get proMember => 'Pro Üye';

  @override
  String get proPlusMember => 'Pro+ Üye';

  @override
  String get unlimitedAccess => 'Sınırsız erişim';

  @override
  String get upgradeForMoreFeatures => 'Daha fazla özellik için yükseltin';

  @override
  String get preferences => 'Tercihler';

  @override
  String get support => 'Destek';

  @override
  String get account => 'Hesap';

  @override
  String get notifications => 'Bildirimler';

  @override
  String get darkMode => 'Karanlık Mod';

  @override
  String get appLanguage => 'Uygulama Dili';

  @override
  String get summaryLanguage => 'Özet Dili';

  @override
  String get helpFaq => 'Yardım ve SSS';

  @override
  String get rateApp => 'Uygulamayı Değerlendir';

  @override
  String get rateAppSub => 'DoCMind AI\'ı sevdiniz mi? Bizi değerlendirin!';

  @override
  String get privacyPolicy => 'Gizlilik Politikası';

  @override
  String get termsOfService => 'Kullanım Koşulları';

  @override
  String get restorePurchases => 'Satın Alımları Geri Yükle';

  @override
  String get signOut => 'Çıkış Yap';

  @override
  String get deleteAccount => 'Hesabı Sil';

  @override
  String get deleteAccountConfirm =>
      'Hesabınızı silmek istediğinizden emin misiniz? Bu işlem geri alınamaz.';

  @override
  String get deleteAccountTitle => 'Hesap Silinsin mi?';

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
    return 'v$version Sürümündeki Yenilikler';
  }

  @override
  String get ok => 'Tamam';

  @override
  String get document => 'Belge';

  @override
  String get failedToLoadDocument => 'Belge yüklenemedi';

  @override
  String get tryAgain => 'Tekrar Dene';

  @override
  String get documentNotFound => 'Belge bulunamadı';

  @override
  String get loadingPdf => 'PDF yükleniyor...';

  @override
  String get loadingPreview => 'Belge önizlemesi yükleniyor...';

  @override
  String showingPage(int count) {
    return '$count sayfadan 1. sayfa gösteriliyor';
  }

  @override
  String get documentContent => 'Belge İçeriği';

  @override
  String get noContentExtracted => 'Henüz içerik çıkarılmadı';

  @override
  String get previewNotAvailable => 'Önizleme mevcut değil';

  @override
  String get viewSummary => 'Özeti Görüntüle';

  @override
  String get generating => 'Oluşturuluyor...';

  @override
  String get generateAiSummary => 'AI Özeti Oluştur';

  @override
  String pagesCount(int count) {
    return '$count sayfa';
  }

  @override
  String get uploadDocumentTitle => 'Belge Yükle';

  @override
  String get tipReading => 'AI belgenizi okuyor...';

  @override
  String get tipExtracting => 'Önemli bilgiler çıkarılıyor...';

  @override
  String get tipIdentifying => 'Önemli bölümler belirleniyor...';

  @override
  String get tipBuilding => 'Yapılandırılmış özet oluşturuluyor...';

  @override
  String get tipFinalizing => 'Neredeyse bitti, sonuçlar tamamlanıyor...';

  @override
  String get stepUploading => 'Yükleniyor';

  @override
  String get stepExtractingText => 'Metin Çıkarılıyor';

  @override
  String get stepAiAnalyzing => 'AI Analiz Ediyor';

  @override
  String get summaryLang => 'Özet dili';

  @override
  String uploadingProgress(int percent) {
    return 'Belgeniz yükleniyor... %$percent';
  }

  @override
  String get extractingText => 'Belgenizden metin çıkarılıyor...';

  @override
  String get aiAnalyzing => 'AI analiz ediyor ve özetliyor...';

  @override
  String get preparing => 'Hazırlanıyor...';

  @override
  String get tapToUpload => 'Belge yüklemek için dokunun';

  @override
  String supportedFormats(int size) {
    return 'PDF, DOCX, JPG, PNG en fazla ${size}MB';
  }

  @override
  String get aiWillExtract => 'AI içeriği çıkaracak ve özetleyecek';

  @override
  String get freeLimitReached =>
      'Ücretsiz limit doldu. Devam etmek için yükseltin';

  @override
  String get readyToProcess => 'İşlemeye hazır';

  @override
  String get chooseDifferentFile => 'Farklı Dosya Seç';

  @override
  String get selectedFile => 'Seçilen dosya';

  @override
  String get generateSummary => 'Özet Oluştur';

  @override
  String freePlanFileLimit(int size) {
    return 'Ücretsiz plan limiti: dosya başına en fazla ${size}MB. Daha büyük belgeler için yükseltin.';
  }

  @override
  String fileSizeExceeded(int size) {
    return 'Dosya boyutu plan limitinizi aşıyor (maks ${size}MB). Daha büyük dosyalar için yükseltin.';
  }

  @override
  String get freeLimitReachedTitle => 'Ücretsiz Limit Doldu';

  @override
  String get freeLimitReachedMsg =>
      'Tüm ücretsiz belgelerinizi kullandınız. Sınırsız erişim için Pro\'ya yükseltin!';

  @override
  String get maybeLater => 'Belki Daha Sonra';

  @override
  String get upgradeNow => 'Şimdi Yükselt';

  @override
  String get summary => 'Özet';

  @override
  String get failedToLoadSummary => 'Özet yüklenemedi';

  @override
  String get summaryNotFound => 'Özet bulunamadı';

  @override
  String get overview => 'Genel Bakış';

  @override
  String get keyPoints => 'Ana Noktalar';

  @override
  String get actionItems => 'Eylem Öğeleri';

  @override
  String get keywords => 'Anahtar Kelimeler';

  @override
  String get importantFacts => 'Önemli Bilgiler';

  @override
  String get obligations => 'Yükümlülükler';

  @override
  String get risks => 'Riskler';

  @override
  String get findings => 'Bulgular';

  @override
  String wordsCount(int count) {
    return '$count kelime';
  }

  @override
  String processingTime(String seconds) {
    return '${seconds}s';
  }

  @override
  String get viewOriginalDocument => 'Orijinal Belgeyi Görüntüle';

  @override
  String get copySummary => 'Özeti Kopyala';

  @override
  String get summaryCopied => 'Özet panoya kopyalandı';

  @override
  String get generatedBy => 'DoCMind AI tarafından oluşturuldu';

  @override
  String wordCountLabel(int count) {
    return 'Kelime sayısı: $count';
  }

  @override
  String processingTimeLabel(String seconds) {
    return 'İşlem süresi: ${seconds}s';
  }

  @override
  String get upgradeRequired => 'Yükseltme gerekli';

  @override
  String get translateProOnly =>
      'Çeviri Pro planlarda kullanılabilir. Özetleri çevirmek için yükseltin.';

  @override
  String get notNow => 'Şimdi değil';

  @override
  String get manageSubscription => 'Aboneliği Yönet';

  @override
  String get changeYourPlan => 'Planınızı Değiştirin';

  @override
  String get unlockPremium => 'Premium\'un Kilidini Açın';

  @override
  String get upgradeOrSwitch => 'Yükseltin veya farklı bir plana geçin';

  @override
  String get getUnlimitedAccess => 'Tüm özelliklere sınırsız erişim alın';

  @override
  String get monthly => 'Aylık';

  @override
  String get yearly => 'Yıllık';

  @override
  String get save40 => '%40 TASARRUF';

  @override
  String get unlimitedDocuments => 'Sınırsız belge';

  @override
  String get unlimitedSummaries => 'Sınırsız özet';

  @override
  String get priorityAiProcessing => 'Öncelikli AI işleme';

  @override
  String get exportToPdf => 'PDF\'ye aktar';

  @override
  String get emailSupport => 'E-posta desteği';

  @override
  String get everythingInPro => 'Pro\'daki her şey';

  @override
  String get ocrScannedDocs => 'Taranan belgeler için OCR';

  @override
  String get longDocSupport => 'Uzun belge desteği (100+ sayfa)';

  @override
  String get advancedAiAnalysis => 'Gelişmiş AI analizi';

  @override
  String get prioritySupport => 'Öncelikli destek';

  @override
  String get earlyAccess => 'Özelliklere erken erişim';

  @override
  String get freePlanInfo =>
      'Ücretsiz plan günde 2 belge ve her biri en fazla 5 sayfa içerir.';

  @override
  String get restoring => 'Geri yükleniyor...';

  @override
  String get current => 'MEVCUT';

  @override
  String get popular => 'POPÜLER';

  @override
  String get perYear => '/yıl';

  @override
  String get perMonth => '/ay';

  @override
  String get billedAnnually => 'Yıllık faturalandırılır';

  @override
  String thatsOnly(String price) {
    return 'Sadece aylık $price';
  }

  @override
  String get getPro => 'Pro\'yu Al';

  @override
  String get getProPlus => 'Pro+\'yı Al';

  @override
  String get currentPlan => 'Mevcut Plan';

  @override
  String get switchToYearly => 'Yıllığa Geç';

  @override
  String get switchToMonthly => 'Aylığa Geç';

  @override
  String get upgradeToPro => 'Pro\'ya Yükselt';

  @override
  String get upgradeToProPlus => 'Pro+\'ya Yükselt';

  @override
  String get downgradeToPro => 'Pro\'ya Düşür';

  @override
  String get downgradeToProPlus => 'Pro+\'ya Düşür';

  @override
  String get changesAtEnd => 'Fatura dönemi sonunda değişir';

  @override
  String autoRenews(String date) {
    return '$date tarihinde otomatik yenilenir';
  }

  @override
  String expires(String date) {
    return '$date tarihinde sona erer';
  }

  @override
  String get soon => 'yakında';

  @override
  String get active => 'AKTİF';

  @override
  String get downgradePlan => 'Planı Düşür';

  @override
  String get downgradeConfirm =>
      'Planınız mevcut fatura döneminizin sonunda düşürülecektir. O zamana kadar mevcut özelliklerinizi koruyacaksınız.';

  @override
  String get confirmDowngrade => 'Düşürmeyi Onayla';

  @override
  String get welcomeBack => 'Tekrar Hoş Geldiniz';

  @override
  String get signInContinue => 'DoCMind AI\'a devam etmek için giriş yapın';

  @override
  String get createAccountToStart => 'Başlamak için hesabınızı oluşturun';

  @override
  String get emailAddress => 'E-posta adresi';

  @override
  String get password => 'Şifre';

  @override
  String get enterEmail => 'Lütfen e-postanızı girin';

  @override
  String get validEmail => 'Lütfen geçerli bir e-posta girin';

  @override
  String get enterPassword => 'Lütfen şifrenizi girin';

  @override
  String get passwordMinLength => 'Şifre en az 8 karakter olmalıdır';

  @override
  String get signIn => 'Giriş Yap';

  @override
  String get createAccount => 'Hesap Oluştur';

  @override
  String get orContinueWith => 'veya şununla devam edin';

  @override
  String get continueWithApple => 'Apple ile Devam Et';

  @override
  String get tryWithoutAccount => 'Hesap Olmadan Dene';

  @override
  String get noAccount => 'Hesabınız yok mu? ';

  @override
  String get haveAccount => 'Zaten hesabınız var mı? ';

  @override
  String get signUp => 'Kayıt Ol';

  @override
  String get tryDoCMindAi => 'DoCMind AI\'ı Dene';

  @override
  String trialsLeft(int count) {
    return '$count deneme hakkı kaldı';
  }

  @override
  String get noTrialsRemaining => 'Deneme hakkı kalmadı';

  @override
  String get summarizeNow => 'Şimdi Özetle';

  @override
  String get analyzingDocument => 'Belgeniz analiz ediliyor...';

  @override
  String get thisMayTakeAMoment => 'Bu biraz zaman alabilir';

  @override
  String get guestModeLimitations => 'Misafir Modu Sınırlamaları';

  @override
  String get maxPagesGuest => 'Belge başına en fazla 2 sayfa';

  @override
  String get twoTrialsOnly => 'Toplam sadece 2 deneme (sıfırlanamaz)';

  @override
  String get notSavedToHistory => 'Özet geçmişe kaydedilmez';

  @override
  String get noCloudSync => 'Bulut senkronizasyonu yok';

  @override
  String get withFreeAccount => 'Ücretsiz hesapla şunları elde edersiniz:';

  @override
  String get upToFivePages => 'Belge başına 5 sayfaya kadar';

  @override
  String get threeDocsPerDay => 'Günde 3 belge';

  @override
  String get historySavedForever => 'Geçmiş sonsuza kadar kaydedilir';

  @override
  String get cloudSyncDevices => 'Cihazlar arası bulut senkronizasyonu';

  @override
  String get wantUnlimitedAccess => 'Sınırsız erişim ister misiniz?';

  @override
  String get createFreeForMore =>
      'Daha fazla özellik için ücretsiz hesap oluşturun';

  @override
  String get createFreeAccount => 'Ücretsiz Hesap Oluştur';

  @override
  String get selectDocSource => 'Belge Kaynağını Seçin';

  @override
  String get browseFiles => 'Dosyalara Göz At';

  @override
  String get pdfWordDocs => 'PDF, Word belgeleri';

  @override
  String get takePhoto => 'Fotoğraf Çek';

  @override
  String get captureDocCamera => 'Belgeyi kamerayla çek';

  @override
  String get photoLibrary => 'Fotoğraf Kütüphanesi';

  @override
  String get selectFromGallery => 'Galeriden seç';

  @override
  String get fileTooLargeGuest =>
      'Dosya çok büyük. Misafir modu için en fazla 5MB.';

  @override
  String get failedPickFile => 'Dosya seçilemedi';

  @override
  String get failedCapturePhoto => 'Fotoğraf çekilemedi';

  @override
  String get failedPickImage => 'Görsel seçilemedi';

  @override
  String get trialLimitReached => 'Deneme Limiti Doldu';

  @override
  String get trialLimitMsg =>
      'Tüm ücretsiz deneme haklarınızı kullandınız. DoCMind AI\'ı sınırsız erişimle kullanmaya devam etmek için hesap oluşturun.';

  @override
  String get noSummaryAvailable => 'Özet mevcut değil';

  @override
  String get summaryNotSaved =>
      'Bu özet kaydedilmeyecek. Saklamak için hesap oluşturun!';

  @override
  String get documentSummary => 'Belge Özeti';

  @override
  String get noOverviewAvailable => 'Genel bakış mevcut değil';

  @override
  String moreKeyPoints(int count) {
    return '$count ana nokta daha';
  }

  @override
  String itemsCount(int count) {
    return '$count öğe';
  }

  @override
  String get createFreeToUnlock => 'Kilidi Açmak İçin Ücretsiz Hesap Oluşturun';

  @override
  String trialsRemaining(int count) {
    return '$count Deneme Hakkı Kaldı';
  }

  @override
  String get createAccountContinue =>
      'DoCMind AI\'ı kullanmaya devam etmek için hesap oluşturun';

  @override
  String get createAccountUnlimited => 'Sınırsız özet için hesap oluşturun';

  @override
  String get close => 'Kapat';

  @override
  String get processingFailed =>
      'Belge işleme başarısız oldu. Lütfen tekrar deneyin.';

  @override
  String get processingTakingLong =>
      'İşlem beklenenden uzun sürüyor. Durum için Geçmiş\'i kontrol edin.';

  @override
  String get translating => 'Çevriliyor';

  @override
  String get aiTranslatingYourSummary => 'AI özetinizi çeviriyor';

  @override
  String get translationComplete => 'Çeviri tamamlandı';

  @override
  String translatedTo(String language) {
    return '$language diline çevrildi';
  }

  @override
  String originalLanguage(String language) {
    return 'Orijinal: $language';
  }

  @override
  String generatedOn(String date) {
    return '$date tarihinde oluşturuldu';
  }

  @override
  String get pleaseWait => 'Lütfen bekleyin';

  @override
  String get updateRequired => 'Güncelleme gerekli';

  @override
  String get updateRequiredMsg =>
      'DoCMind AI\'ın yeni bir sürümü mevcut. Uygulamayı kullanmaya devam etmek için lütfen güncelleyin.';

  @override
  String get updateNow => 'Şimdi güncelle';

  @override
  String get onboardingUploadTitle => 'Belge Yükle';

  @override
  String get onboardingUploadDesc =>
      'PDF, DOCX veya görsellerinizi yükleyin, gerisini yapay zeka halletsin. Saniyeler içinde özetler alın.';

  @override
  String get onboardingSummaryTitle => 'Yapay Zeka Destekli Özetler';

  @override
  String get onboardingSummaryDesc =>
      'Herhangi bir belgeden anında anahtar noktalar, yapılacaklar ve önemli bilgiler çıkarın.';

  @override
  String get onboardingTranslateTitle => 'Özetleri Çevir';

  @override
  String get onboardingTranslateDesc =>
      'Özetlerinizi tek dokunuşla 13\'ten fazla dile çevirin.';

  @override
  String get onboardingShareTitle => 'Her Uygulamadan Paylaş';

  @override
  String get onboardingShareDesc =>
      'WhatsApp, Telegram veya herhangi bir uygulamadan doğrudan dosya göndererek anında özet alın.';

  @override
  String get onboardingHistoryTitle => 'Geçmiş ve Filtreler';

  @override
  String get onboardingHistoryDesc =>
      'Tüm belgeleriniz tek bir yerde. PDF, Word veya görsellere göre filtreleyin.';

  @override
  String get onboardingCopyShareTitle => 'Kopyala ve Paylaş';

  @override
  String get onboardingCopyShareDesc =>
      'Özetlerinizi panoya kopyalayın veya favori uygulamalarınız aracılığıyla paylaşın.';

  @override
  String get tutorial => 'Rehber';

  @override
  String get onboardingSkip => 'Atla';

  @override
  String get onboardingNext => 'İleri';

  @override
  String get onboardingGetStarted => 'Başla';
}
