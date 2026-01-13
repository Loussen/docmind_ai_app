class AppConstants {
  AppConstants._();

  // App Info
  static const String appName = 'DocMind AI';
  static const String appTagline = 'Smart Document Summarizer';
  static const String appVersion = '1.0.0';
  static const String appStoreId = '6757693350';

  // URLs
  static const String appStoreUrl = 'https://apps.apple.com/app/id6757693350';
  static const String appStoreReviewUrl =
      'https://apps.apple.com/app/id6757693350?action=write-review';
  static const String supportUrl = 'https://docsmind.app/support';
  static const String privacyPolicyUrl = 'https://docsmind.app/privacy';
  static const String termsOfServiceUrl = 'https://docsmind.app/terms';

  // Storage Keys
  static const String authTokenKey = 'auth_token';
  static const String refreshTokenKey = 'refresh_token';
  static const String userDataKey = 'user_data';
  static const String onboardingCompleteKey = 'onboarding_complete';
  static const String themeKey = 'app_theme';

  // Document Limits
  static const int freeDocsPerDay = 3;
  static const int freePagesPerDoc = 5;
  static const int proDocsPerDay = -1; // Unlimited
  static const int proPagesPerDoc = -1; // Unlimited
  static const int proPlusDocsPerDay = -1; // Unlimited
  static const int proPlusPagesPerDoc = -1; // Unlimited

  // File Size Limits (in MB)
  static const int maxFileSizeFree = 10;
  static const int maxFileSizePro = 50;
  static const int maxFileSizeProPlus = 100;

  // Supported File Types
  static const List<String> supportedExtensions = [
    'pdf',
    'docx',
    'doc',
    'jpg',
    'jpeg',
    'png',
  ];

  static const Map<String, String> mimeTypes = {
    'pdf': 'application/pdf',
    'docx':
        'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
    'doc': 'application/msword',
    'jpg': 'image/jpeg',
    'jpeg': 'image/jpeg',
    'png': 'image/png',
  };

  // In-App Purchase Product IDs
  static const String proMonthlyProductId = 'com.docmind.pro.monthly';
  static const String proYearlyProductId = 'com.docmind.pro.yearly';
  static const String proPlusMonthlyProductId = 'com.docmind.proplus.monthly';
  static const String proPlusYearlyProductId = 'com.docmind.proplus.yearly';

  // Animation Durations
  static const Duration shortDuration = Duration(milliseconds: 200);
  static const Duration mediumDuration = Duration(milliseconds: 300);
  static const Duration longDuration = Duration(milliseconds: 500);

  // Padding & Spacing
  static const double paddingXS = 4.0;
  static const double paddingS = 8.0;
  static const double paddingM = 16.0;
  static const double paddingL = 24.0;
  static const double paddingXL = 32.0;
  static const double paddingXXL = 48.0;

  // Border Radius
  static const double radiusS = 8.0;
  static const double radiusM = 12.0;
  static const double radiusL = 16.0;
  static const double radiusXL = 24.0;
  static const double radiusFull = 999.0;
}
