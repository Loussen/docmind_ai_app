import 'package:dio/dio.dart';

import '../constants/app_constants.dart';

class UpdateService {
  static const _lookupUrl =
      'https://itunes.apple.com/lookup?bundleId=com.docmind.docmindAi&country=us';

  /// Returns `true` when the App Store has a newer version than the running app.
  /// Returns `false` on any error (network, parse, etc.) so the user is never
  /// blocked by a failed check.
  static Future<bool> isUpdateRequired() async {
    try {
      final dio = Dio(BaseOptions(
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 5),
      ));

      final response = await dio.get(_lookupUrl);
      final data = response.data;

      if (data is! Map<String, dynamic>) return false;

      final results = data['results'] as List?;
      if (results == null || results.isEmpty) return false;

      final storeVersion = results[0]['version'] as String?;
      if (storeVersion == null) return false;

      return _isNewer(storeVersion, AppConstants.appVersion);
    } catch (_) {
      return false;
    }
  }

  /// Returns `true` when [storeVersion] is strictly newer than [currentVersion].
  /// Compares major.minor.patch numerically (e.g. "1.1.0" > "1.0.9").
  static bool _isNewer(String storeVersion, String currentVersion) {
    final storeParts = storeVersion.split('.').map((e) => int.tryParse(e) ?? 0).toList();
    final currentParts = currentVersion.split('.').map((e) => int.tryParse(e) ?? 0).toList();

    final length = storeParts.length > currentParts.length
        ? storeParts.length
        : currentParts.length;

    for (var i = 0; i < length; i++) {
      final s = i < storeParts.length ? storeParts[i] : 0;
      final c = i < currentParts.length ? currentParts[i] : 0;
      if (s > c) return true;
      if (s < c) return false;
    }
    return false;
  }
}
