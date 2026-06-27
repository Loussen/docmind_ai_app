import 'package:flutter/foundation.dart';

/// TikTok Events Manager configuration.
///
/// Set IDs via `--dart-define` at build time:
/// ```bash
/// flutter run --dart-define=TIKTOK_IOS_ID=YOUR_TIKTOK_APP_ID
/// flutter build ipa --dart-define=TIKTOK_IOS_ID=YOUR_TIKTOK_APP_ID
/// ```
///
/// Find `TIKTOK_IOS_ID` in TikTok Ads Manager → Tools → Events → your app →
/// "Copy the TikTok App ID".
class TikTokConstants {
  TikTokConstants._();

  /// App Store numeric ID (same as AppConstants.appStoreId).
  static const String iosAppId = String.fromEnvironment(
    'TIKTOK_IOS_APP_ID',
    defaultValue: '6757693350',
  );

  /// TikTok App ID from Events Manager (required for SDK init).
  static const String tiktokIosId = String.fromEnvironment(
    'TIKTOK_IOS_ID',
    defaultValue: '7655759737541935122',
  );

  static const String androidAppId = String.fromEnvironment(
    'TIKTOK_ANDROID_APP_ID',
    defaultValue: 'com.docmind.docmind_ai',
  );

  static const String tiktokAndroidId = String.fromEnvironment(
    'TIKTOK_ANDROID_ID',
    defaultValue: '',
  );

  /// Optional access token from TikTok Events Manager (if provided).
  static const String accessToken = String.fromEnvironment(
    'TIKTOK_ACCESS_TOKEN',
    defaultValue: '',
  );

  static bool get isConfigured {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      return tiktokIosId.isNotEmpty;
    }
    if (defaultTargetPlatform == TargetPlatform.android) {
      return tiktokAndroidId.isNotEmpty;
    }
    return false;
  }

  static bool get debugMode => kDebugMode;
}
