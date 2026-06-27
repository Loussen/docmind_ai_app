import 'package:flutter/foundation.dart';
import 'package:tiktok_events_sdk/tiktok_events_sdk.dart';

import '../constants/tiktok_constants.dart';

/// Wrapper around [TikTokEventsSdk] for DoCMind AI conversion events.
class TikTokAnalyticsService {
  TikTokAnalyticsService._();

  static final TikTokAnalyticsService instance = TikTokAnalyticsService._();

  bool _initialized = false;

  bool get isInitialized => _initialized;

  Future<void> initialize() async {
    if (_initialized || !TikTokConstants.isConfigured) {
      if (!TikTokConstants.isConfigured && kDebugMode) {
        debugPrint(
          'TikTok SDK skipped: set TIKTOK_IOS_ID via --dart-define '
          '(copy from TikTok Events Manager → App details).',
        );
      }
      return;
    }

    try {
      final iosOptions = TikTokIosOptions(
        accessToken: TikTokConstants.accessToken.isEmpty
            ? null
            : TikTokConstants.accessToken,
        disableSKAdNetworkSupport: false,
        displayAtt: true,
        attUserAuthorizationDelaySeconds: 2,
      );

      final androidOptions = const TikTokAndroidOptions(
        enableAutoIapTrack: true,
      );

      await TikTokEventsSdk.initSdk(
        androidAppId: TikTokConstants.androidAppId,
        tikTokAndroidId: TikTokConstants.tiktokAndroidId,
        iosAppId: TikTokConstants.iosAppId,
        tiktokIosId: TikTokConstants.tiktokIosId,
        isDebugMode: TikTokConstants.debugMode,
        logLevel: TikTokConstants.debugMode
            ? TikTokLogLevel.debug
            : TikTokLogLevel.info,
        iosOptions: iosOptions,
        androidOptions: androidOptions,
      );

      _initialized = true;

      if (kDebugMode) {
        debugPrint('TikTok SDK initialized (debugMode=${TikTokConstants.debugMode})');
      }
    } catch (e, stack) {
      debugPrint('TikTok SDK init failed: $e\n$stack');
    }
  }

  Future<void> identifyUser({
    required String externalId,
    String? email,
  }) async {
    if (!_initialized) return;

    try {
      await TikTokEventsSdk.identify(
        identifier: TikTokIdentifier(
          externalId: externalId,
          email: email,
        ),
      );
    } catch (e) {
      debugPrint('TikTok identify failed: $e');
    }
  }

  Future<void> logLaunchApp() async {
    await _logStandard(BaseEventName.launchApp);
  }

  Future<void> logCompleteTutorial() async {
    await _logStandard(BaseEventName.completeTutorial);
  }

  Future<void> logViewContent({
    required String contentId,
    String? contentName,
    String contentType = 'screen',
  }) async {
    await _logEvent(
      eventName: TTEventType.viewContent.name,
      eventType: TTEventType.viewContent,
      properties: EventProperties(
        contentId: contentId,
        contentName: contentName,
        contentType: contentType,
      ),
    );
  }

  Future<void> logDocumentUploaded({
    required String documentId,
    required String fileType,
  }) async {
    await _logEvent(
      eventName: 'document_uploaded',
      properties: EventProperties(
        contentId: documentId,
        contentType: fileType,
        contentName: 'document_upload',
        customProperties: {
          'file_type': fileType,
        },
      ),
    );
  }

  Future<void> logSummaryGenerated({
    required String summaryId,
    required String documentId,
  }) async {
    await _logEvent(
      eventName: 'summary_generated',
      properties: EventProperties(
        contentId: summaryId,
        contentType: 'summary',
        contentName: 'ai_summary',
        customProperties: {
          'document_id': documentId,
        },
      ),
    );
  }

  Future<void> logSubscribe({
    required String productId,
    double? value,
    String currency = 'USD',
  }) async {
    await _logEvent(
      eventName: BaseEventName.subscribe.value,
      eventType: TTEventType.none,
      properties: EventProperties(
        contentId: productId,
        contentType: 'subscription',
        value: value,
        currency: _currencyCode(currency),
      ),
    );
  }

  Future<void> logPurchase({
    required String productId,
    required double value,
    String currency = 'USD',
    String? transactionId,
  }) async {
    await _logEvent(
      eventName: TTEventType.purchase.name,
      eventType: TTEventType.purchase,
      eventId: transactionId,
      properties: EventProperties(
        contentId: productId,
        contentType: 'subscription',
        value: value,
        price: value,
        currency: _currencyCode(currency),
        quantity: 1,
      ),
    );
  }

  Future<void> logCheckoutStarted({required String productId}) async {
    await _logEvent(
      eventName: TTEventType.checkout.name,
      eventType: TTEventType.checkout,
      properties: EventProperties(
        contentId: productId,
        contentType: 'subscription',
      ),
    );
  }

  Future<void> flush() async {
    if (!_initialized) return;
    try {
      await TikTokEventsSdk.flush();
    } catch (_) {}
  }

  Future<void> _logStandard(BaseEventName event) async {
    await _logEvent(eventName: event.value);
  }

  Future<void> _logEvent({
    required String eventName,
    TTEventType eventType = TTEventType.none,
    String? eventId,
    EventProperties? properties,
  }) async {
    if (!_initialized) return;

    try {
      await TikTokEventsSdk.logEvent(
        event: TikTokEvent(
          eventName: eventName,
          eventType: eventType,
          eventId: eventId,
          properties: properties,
        ),
      );
    } catch (e) {
      debugPrint('TikTok event "$eventName" failed: $e');
    }
  }

  CurrencyCode? _currencyCode(String code) {
    try {
      return CurrencyCode.values.firstWhere(
        (c) => c.name.toUpperCase() == code.toUpperCase(),
      );
    } catch (_) {
      return CurrencyCode.USD;
    }
  }

  /// Parses StoreKit price strings like "\$4.99" or "4,99 €".
  static double? parsePrice(String? priceString) {
    if (priceString == null || priceString.isEmpty) return null;
    final normalized = priceString.replaceAll(RegExp(r'[^\d.,]'), '');
    if (normalized.isEmpty) return null;

    if (normalized.contains(',') && normalized.contains('.')) {
      final value = normalized.replaceAll(',', '');
      return double.tryParse(value);
    }

    if (normalized.contains(',') && !normalized.contains('.')) {
      return double.tryParse(normalized.replaceAll(',', '.'));
    }

    return double.tryParse(normalized);
  }
}
