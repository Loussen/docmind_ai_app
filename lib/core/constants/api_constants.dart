class ApiConstants {
  ApiConstants._();

  static const String baseUrl = 'https://docsmind.app/api';

  // Device Endpoints
  static const String deviceRegister = '/device/register';
  static const String deviceSync = '/device/sync';
  static const String deviceDeleteData = '/device/data';

  // Document Endpoints
  static const String documents = '/documents';
  static const String uploadDocument = '/documents/upload';
  static String documentById(String id) => '/documents/$id';
  static String deleteDocument(String id) => '/documents/$id';

  // Summary Endpoints
  static const String summaries = '/summaries';
  static String summaryById(String id) => '/summaries/$id';
  static String generateSummary(String documentId) =>
      '/documents/$documentId/summarize';

  // Auth Endpoints
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String appleAuth = '/auth/apple';
  static const String me = '/auth/me';
  static const String updateProfile = '/auth/profile';
  static const String logout = '/auth/logout';
  static const String deleteAccount = '/auth/account';

  // User Endpoints
  static const String usage = '/user/usage';
  static const String settings = '/user/settings';

  // Subscription Endpoints
  static const String subscription = '/subscription';
  static const String verifyPurchase = '/subscription/verify';
  static const String restorePurchase = '/subscription/restore';
  static const String plans = '/subscription/plans';

  // History
  static const String history = '/history';

  // Timeout durations
  static const Duration connectionTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 120);
  static const Duration uploadTimeout = Duration(seconds: 120);
}
