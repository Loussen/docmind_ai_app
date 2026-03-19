// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class SId extends S {
  SId([String locale = 'id']) : super(locale);

  @override
  String get appName => 'DoCMind AI';

  @override
  String get appTagline => 'OCR, Dokumen & Ringkasan AI';

  @override
  String get navHome => 'Beranda';

  @override
  String get navHistory => 'Riwayat';

  @override
  String get navSettings => 'Pengaturan';

  @override
  String get addDocument => 'Tambah dokumen';

  @override
  String get optionDocument => 'Dokumen';

  @override
  String get optionDocumentSub => 'PDF, Word, atau file lainnya';

  @override
  String get optionGallery => 'Galeri';

  @override
  String get optionGallerySub => 'Pilih dari perpustakaan foto';

  @override
  String get optionCamera => 'Kamera';

  @override
  String get optionCameraSub => 'Ambil foto';

  @override
  String get greeting => 'Halo';

  @override
  String get planPro => 'Pro';

  @override
  String get planProPlus => 'Pro+';

  @override
  String get planFree => 'Gratis';

  @override
  String get quickActions => 'Aksi Cepat';

  @override
  String get recentDocuments => 'Dokumen Terbaru';

  @override
  String get upload => 'Unggah';

  @override
  String get uploadFormats => 'PDF, DOCX, Gambar';

  @override
  String get history => 'Riwayat';

  @override
  String get viewAllDocs => 'Semua dokumen';

  @override
  String get seeAll => 'Lihat Semua';

  @override
  String get noDocumentsYet => 'Belum ada dokumen';

  @override
  String get uploadFirstDoc =>
      'Unggah dokumen pertama Anda dan biarkan AI meringkasnya untuk Anda';

  @override
  String get uploadDocument => 'Unggah Dokumen';

  @override
  String get premiumActive => 'Premium Aktif';

  @override
  String get unlimitedDocsSummaries => 'Dokumen & ringkasan tak terbatas';

  @override
  String get freePlan => 'Paket Gratis';

  @override
  String get noFreeDocsLeft => 'Kuota gratis habis';

  @override
  String freeLeftCount(int count) {
    return 'Sisa $count gratis';
  }

  @override
  String get upgradeForUnlimited => 'Upgrade untuk akses tak terbatas';

  @override
  String freeDocsUsed(int used, int limit) {
    return '$used dari $limit dokumen gratis digunakan';
  }

  @override
  String get upgrade => 'Upgrade';

  @override
  String get failed => 'Gagal';

  @override
  String minAgo(int count) {
    return '$count menit lalu';
  }

  @override
  String hoursAgo(int count) {
    return '$count jam lalu';
  }

  @override
  String get yesterday => 'Kemarin';

  @override
  String daysAgo(int count) {
    return '$count hari lalu';
  }

  @override
  String get clearFilters => 'Hapus filter';

  @override
  String get documentDeleted => 'Dokumen dihapus';

  @override
  String get noDocumentsFiltered => 'Dokumen tidak ditemukan';

  @override
  String get tryRemovingFilters =>
      'Coba hapus filter atau unggah\ndokumen baru';

  @override
  String get clearFiltersButton => 'Hapus Filter';

  @override
  String get deleteDocument => 'Hapus Dokumen';

  @override
  String get deleteDocumentConfirm =>
      'Apakah Anda yakin ingin menghapus dokumen ini?';

  @override
  String get deleteDocumentConfirmFull =>
      'Apakah Anda yakin ingin menghapus dokumen ini? Tindakan ini tidak dapat dibatalkan.';

  @override
  String get cancel => 'Batal';

  @override
  String get delete => 'Hapus';

  @override
  String get allDocuments => 'Semua Dokumen';

  @override
  String get pdfOnly => 'Hanya PDF';

  @override
  String get wordOnly => 'Hanya Word';

  @override
  String get imagesOnly => 'Hanya Gambar';

  @override
  String get settings => 'Pengaturan';

  @override
  String get proMember => 'Anggota Pro';

  @override
  String get proPlusMember => 'Anggota Pro+';

  @override
  String get unlimitedAccess => 'Akses tak terbatas';

  @override
  String get upgradeForMoreFeatures => 'Upgrade untuk fitur lebih banyak';

  @override
  String get preferences => 'Preferensi';

  @override
  String get support => 'Dukungan';

  @override
  String get account => 'Akun';

  @override
  String get notifications => 'Notifikasi';

  @override
  String get darkMode => 'Mode Gelap';

  @override
  String get appLanguage => 'Bahasa Aplikasi';

  @override
  String get summaryLanguage => 'Bahasa Ringkasan';

  @override
  String get helpFaq => 'Bantuan & FAQ';

  @override
  String get rateApp => 'Beri Rating';

  @override
  String get rateAppSub => 'Suka DoCMind AI? Beri kami rating!';

  @override
  String get privacyPolicy => 'Kebijakan Privasi';

  @override
  String get termsOfService => 'Ketentuan Layanan';

  @override
  String get restorePurchases => 'Pulihkan Pembelian';

  @override
  String get signOut => 'Keluar';

  @override
  String get deleteAccount => 'Hapus Akun';

  @override
  String get deleteAccountConfirm =>
      'Apakah Anda yakin ingin menghapus akun Anda? Tindakan ini tidak dapat dibatalkan.';

  @override
  String get deleteAccountTitle => 'Hapus Akun?';

  @override
  String appVersion(String version) {
    return 'DoCMind AI v$version';
  }

  @override
  String whatsNew(String version) {
    return 'Yang Baru di v$version';
  }

  @override
  String get ok => 'OK';

  @override
  String get document => 'Dokumen';

  @override
  String get failedToLoadDocument => 'Gagal memuat dokumen';

  @override
  String get tryAgain => 'Coba Lagi';

  @override
  String get documentNotFound => 'Dokumen tidak ditemukan';

  @override
  String get loadingPdf => 'Memuat PDF...';

  @override
  String get loadingPreview => 'Memuat pratinjau dokumen...';

  @override
  String showingPage(int count) {
    return 'Menampilkan halaman 1 dari $count';
  }

  @override
  String get documentContent => 'Isi Dokumen';

  @override
  String get noContentExtracted => 'Isi belum diekstrak';

  @override
  String get previewNotAvailable => 'Pratinjau tidak tersedia';

  @override
  String get viewSummary => 'Lihat Ringkasan';

  @override
  String get generating => 'Memproses...';

  @override
  String get generateAiSummary => 'Buat Ringkasan AI';

  @override
  String pagesCount(int count) {
    return '$count halaman';
  }

  @override
  String get uploadDocumentTitle => 'Unggah Dokumen';

  @override
  String get tipReading => 'AI sedang membaca dokumen Anda...';

  @override
  String get tipExtracting => 'Mengekstrak informasi penting...';

  @override
  String get tipIdentifying => 'Mengidentifikasi bagian penting...';

  @override
  String get tipBuilding => 'Membangun ringkasan terstruktur...';

  @override
  String get tipFinalizing => 'Hampir selesai, menyelesaikan...';

  @override
  String get stepUploading => 'Mengunggah';

  @override
  String get stepExtractingText => 'Ekstraksi Teks';

  @override
  String get stepAiAnalyzing => 'Analisis AI';

  @override
  String get summaryLang => 'Bahasa ringkasan';

  @override
  String uploadingProgress(int percent) {
    return 'Mengunggah dokumen Anda... $percent%';
  }

  @override
  String get extractingText => 'Mengekstrak teks dari dokumen Anda...';

  @override
  String get aiAnalyzing => 'AI sedang menganalisis dan meringkas...';

  @override
  String get preparing => 'Mempersiapkan...';

  @override
  String get tapToUpload => 'Ketuk untuk mengunggah dokumen';

  @override
  String supportedFormats(int size) {
    return 'PDF, DOCX, JPG, PNG hingga ${size}MB';
  }

  @override
  String get aiWillExtract => 'AI akan mengekstrak dan meringkas konten';

  @override
  String get freeLimitReached =>
      'Batas gratis tercapai. Upgrade untuk melanjutkan';

  @override
  String get readyToProcess => 'Siap diproses';

  @override
  String get chooseDifferentFile => 'Pilih File Lain';

  @override
  String get selectedFile => 'File terpilih';

  @override
  String get generateSummary => 'Buat Ringkasan';

  @override
  String freePlanFileLimit(int size) {
    return 'Batas paket gratis: maks ${size}MB per file. Upgrade untuk mengunggah dokumen lebih besar.';
  }

  @override
  String fileSizeExceeded(int size) {
    return 'Ukuran file melebihi batas paket Anda (maks ${size}MB). Upgrade untuk file lebih besar.';
  }

  @override
  String get freeLimitReachedTitle => 'Batas Gratis Tercapai';

  @override
  String get freeLimitReachedMsg =>
      'Anda telah menggunakan semua dokumen gratis. Upgrade ke Pro untuk akses tak terbatas!';

  @override
  String get maybeLater => 'Nanti Saja';

  @override
  String get upgradeNow => 'Upgrade Sekarang';

  @override
  String get summary => 'Ringkasan';

  @override
  String get failedToLoadSummary => 'Gagal memuat ringkasan';

  @override
  String get summaryNotFound => 'Ringkasan tidak ditemukan';

  @override
  String get overview => 'Ringkasan';

  @override
  String get keyPoints => 'Poin Utama';

  @override
  String get actionItems => 'Item Tindakan';

  @override
  String get keywords => 'Kata Kunci';

  @override
  String get importantFacts => 'Fakta Penting';

  @override
  String get obligations => 'Kewajiban';

  @override
  String get risks => 'Risiko';

  @override
  String get findings => 'Temuan';

  @override
  String wordsCount(int count) {
    return '$count kata';
  }

  @override
  String processingTime(String seconds) {
    return '$seconds detik';
  }

  @override
  String get viewOriginalDocument => 'Lihat Dokumen Asli';

  @override
  String get copySummary => 'Salin Ringkasan';

  @override
  String get summaryCopied => 'Ringkasan disalin ke clipboard';

  @override
  String get generatedBy => 'Dibuat oleh DoCMind AI';

  @override
  String wordCountLabel(int count) {
    return 'Jumlah kata: $count';
  }

  @override
  String processingTimeLabel(String seconds) {
    return 'Waktu pemrosesan: $seconds detik';
  }

  @override
  String get upgradeRequired => 'Upgrade diperlukan';

  @override
  String get translateProOnly =>
      'Terjemahan tersedia di paket Pro. Upgrade untuk menerjemahkan ringkasan.';

  @override
  String get notNow => 'Tidak Sekarang';

  @override
  String get manageSubscription => 'Kelola Langganan';

  @override
  String get changeYourPlan => 'Ubah Paket Anda';

  @override
  String get unlockPremium => 'Buka Kunci Premium';

  @override
  String get upgradeOrSwitch => 'Upgrade atau beralih ke paket lain';

  @override
  String get getUnlimitedAccess => 'Dapatkan akses tak terbatas ke semua fitur';

  @override
  String get monthly => 'Bulanan';

  @override
  String get yearly => 'Tahunan';

  @override
  String get save40 => 'HEMAT 40%';

  @override
  String get unlimitedDocuments => 'Dokumen tak terbatas';

  @override
  String get unlimitedSummaries => 'Ringkasan tak terbatas';

  @override
  String get priorityAiProcessing => 'Prioritas pemrosesan AI';

  @override
  String get exportToPdf => 'Ekspor ke PDF';

  @override
  String get emailSupport => 'Dukungan email';

  @override
  String get everythingInPro => 'Semua fitur Pro';

  @override
  String get ocrScannedDocs => 'OCR untuk dokumen pindaian';

  @override
  String get longDocSupport => 'Dukungan dokumen panjang (100+ halaman)';

  @override
  String get advancedAiAnalysis => 'Analisis AI lanjutan';

  @override
  String get prioritySupport => 'Dukungan prioritas';

  @override
  String get earlyAccess => 'Akses awal fitur';

  @override
  String get freePlanInfo =>
      'Paket gratis mencakup 2 dokumen dengan maksimal 5 halaman masing-masing.';

  @override
  String get restoring => 'Memulihkan...';

  @override
  String get current => 'SAAT INI';

  @override
  String get popular => 'POPULER';

  @override
  String get perYear => '/tahun';

  @override
  String get perMonth => '/bulan';

  @override
  String get billedAnnually => 'Ditagih tahunan';

  @override
  String thatsOnly(String price) {
    return 'Hanya $price/bulan';
  }

  @override
  String get getPro => 'Dapatkan Pro';

  @override
  String get getProPlus => 'Dapatkan Pro+';

  @override
  String get currentPlan => 'Paket Saat Ini';

  @override
  String get switchToYearly => 'Beralih ke Tahunan';

  @override
  String get switchToMonthly => 'Beralih ke Bulanan';

  @override
  String get upgradeToPro => 'Upgrade ke Pro';

  @override
  String get upgradeToProPlus => 'Upgrade ke Pro+';

  @override
  String get downgradeToPro => 'Turun ke Pro';

  @override
  String get downgradeToProPlus => 'Turun ke Pro+';

  @override
  String get changesAtEnd => 'Perubahan berlaku di akhir periode penagihan';

  @override
  String autoRenews(String date) {
    return 'Perpanjangan otomatis $date';
  }

  @override
  String expires(String date) {
    return 'Kadaluarsa $date';
  }

  @override
  String get soon => 'segera';

  @override
  String get active => 'AKTIF';

  @override
  String get downgradePlan => 'Turunkan Paket';

  @override
  String get downgradeConfirm =>
      'Paket Anda akan diturunkan di akhir periode penagihan saat ini. Anda akan tetap mendapatkan fitur saat ini hingga saat itu.';

  @override
  String get confirmDowngrade => 'Konfirmasi Penurunan';

  @override
  String get welcomeBack => 'Selamat Datang Kembali';

  @override
  String get signInContinue => 'Masuk untuk melanjutkan ke DoCMind AI';

  @override
  String get createAccountToStart => 'Buat akun untuk memulai';

  @override
  String get emailAddress => 'Alamat email';

  @override
  String get password => 'Kata sandi';

  @override
  String get enterEmail => 'Masukkan email Anda';

  @override
  String get validEmail => 'Masukkan email yang valid';

  @override
  String get enterPassword => 'Masukkan kata sandi Anda';

  @override
  String get passwordMinLength => 'Kata sandi minimal 8 karakter';

  @override
  String get signIn => 'Masuk';

  @override
  String get createAccount => 'Buat Akun';

  @override
  String get orContinueWith => 'atau lanjutkan dengan';

  @override
  String get continueWithApple => 'Lanjutkan dengan Apple';

  @override
  String get tryWithoutAccount => 'Coba Tanpa Akun';

  @override
  String get noAccount => 'Belum punya akun? ';

  @override
  String get haveAccount => 'Sudah punya akun? ';

  @override
  String get signUp => 'Daftar';

  @override
  String get tryDoCMindAi => 'Coba DoCMind AI';

  @override
  String trialsLeft(int count) {
    return 'Sisa $count percobaan';
  }

  @override
  String get noTrialsRemaining => 'Percobaan habis';

  @override
  String get summarizeNow => 'Ringkas Sekarang';

  @override
  String get analyzingDocument => 'Menganalisis dokumen Anda...';

  @override
  String get thisMayTakeAMoment => 'Ini mungkin memakan waktu';

  @override
  String get guestModeLimitations => 'Batasan Mode Tamu';

  @override
  String get maxPagesGuest => 'Maks 2 halaman per dokumen';

  @override
  String get twoTrialsOnly => 'Hanya 2 percobaan total (tanpa reset)';

  @override
  String get notSavedToHistory => 'Ringkasan tidak disimpan ke riwayat';

  @override
  String get noCloudSync => 'Tidak ada sinkronisasi cloud';

  @override
  String get withFreeAccount => 'Dengan akun gratis Anda mendapatkan:';

  @override
  String get upToFivePages => 'Hingga 5 halaman per dokumen';

  @override
  String get threeDocsPerDay => '3 dokumen per hari';

  @override
  String get historySavedForever => 'Riwayat disimpan selamanya';

  @override
  String get cloudSyncDevices => 'Sinkronisasi cloud antar perangkat';

  @override
  String get wantUnlimitedAccess => 'Ingin akses tak terbatas?';

  @override
  String get createFreeForMore => 'Buat akun gratis untuk fitur lebih banyak';

  @override
  String get createFreeAccount => 'Buat Akun Gratis';

  @override
  String get selectDocSource => 'Pilih Sumber Dokumen';

  @override
  String get browseFiles => 'Jelajahi File';

  @override
  String get pdfWordDocs => 'PDF, dokumen Word';

  @override
  String get takePhoto => 'Ambil Foto';

  @override
  String get captureDocCamera => 'Tangkap dokumen dengan kamera';

  @override
  String get photoLibrary => 'Perpustakaan Foto';

  @override
  String get selectFromGallery => 'Pilih dari galeri';

  @override
  String get fileTooLargeGuest =>
      'File terlalu besar. Maksimal 5MB untuk mode tamu.';

  @override
  String get failedPickFile => 'Gagal memilih file';

  @override
  String get failedCapturePhoto => 'Gagal mengambil foto';

  @override
  String get failedPickImage => 'Gagal memilih gambar';

  @override
  String get trialLimitReached => 'Batas Percobaan Tercapai';

  @override
  String get trialLimitMsg =>
      'Anda telah menggunakan semua percobaan gratis. Buat akun untuk terus menggunakan DoCMind AI dengan akses tak terbatas.';

  @override
  String get noSummaryAvailable => 'Ringkasan tidak tersedia';

  @override
  String get summaryNotSaved =>
      'Ringkasan ini tidak akan disimpan. Buat akun untuk menyimpannya!';

  @override
  String get documentSummary => 'Ringkasan Dokumen';

  @override
  String get noOverviewAvailable => 'Ringkasan tidak tersedia';

  @override
  String moreKeyPoints(int count) {
    return '$count poin utama lainnya';
  }

  @override
  String itemsCount(int count) {
    return '$count item';
  }

  @override
  String get createFreeToUnlock => 'Buat Akun Gratis untuk Membuka';

  @override
  String trialsRemaining(int count) {
    return 'Sisa $count Percobaan';
  }

  @override
  String get createAccountContinue =>
      'Buat akun untuk terus menggunakan DoCMind AI';

  @override
  String get createAccountUnlimited => 'Buat akun untuk ringkasan tak terbatas';

  @override
  String get close => 'Tutup';

  @override
  String get processingFailed => 'Pemrosesan dokumen gagal. Silakan coba lagi.';

  @override
  String get processingTakingLong =>
      'Pemrosesan memakan waktu lebih lama dari yang diharapkan. Periksa Riwayat untuk status.';

  @override
  String get translating => 'Menerjemahkan';

  @override
  String get aiTranslatingYourSummary =>
      'AI sedang menerjemahkan ringkasan Anda';

  @override
  String get translationComplete => 'Terjemahan selesai';

  @override
  String translatedTo(String language) {
    return 'Diterjemahkan ke $language';
  }

  @override
  String originalLanguage(String language) {
    return 'Asli: $language';
  }

  @override
  String generatedOn(String date) {
    return 'Dibuat pada $date';
  }

  @override
  String get pleaseWait => 'Harap tunggu';

  @override
  String get updateRequired => 'Pembaruan diperlukan';

  @override
  String get updateRequiredMsg =>
      'Versi baru DoCMind AI tersedia. Silakan perbarui untuk terus menggunakan aplikasi.';

  @override
  String get updateNow => 'Perbarui sekarang';
}
