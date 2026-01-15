class ApiConstants {
  ApiConstants._();

  // Base URL - Change this for production
  // Use your Mac's local IP for testing on physical devices
  static const String baseUrl = 'https://docsmind.app/api';

  // Auth Endpoints
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String logout = '/auth/logout';
  static const String refreshToken = '/auth/refresh';
  static const String appleAuth = '/auth/apple';
  static const String me = '/auth/me';

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

  // User Endpoints
  static const String profile = '/user/profile';
  static const String updateProfile = '/user/profile';
  static const String deleteAccount = '/user/account';
  static const String usage = '/user/usage';
  static const String settings = '/user/settings';

  // Subscription Endpoints
  static const String subscription = '/subscription';
  static const String verifyPurchase = '/subscription/verify';
  static const String plans = '/subscription/plans';

  // History
  static const String history = '/history';

  // Timeout durations
  static const Duration connectionTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
  static const Duration uploadTimeout = Duration(seconds: 120);
}
