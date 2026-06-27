import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/services/tiktok_analytics_service.dart';
import '../../data/repositories/device_repository.dart';

class DeviceState {
  final bool isInitialized;
  final bool isLoading;
  final String? deviceId;
  final String? subscriptionPlan;
  final int totalUsageCount;
  final int freeLimit;
  final String? errorMessage;

  const DeviceState({
    this.isInitialized = false,
    this.isLoading = false,
    this.deviceId,
    this.subscriptionPlan,
    this.totalUsageCount = 0,
    this.freeLimit = 2,
    this.errorMessage,
  });

  bool get isPremium =>
      subscriptionPlan == 'pro' || subscriptionPlan == 'pro_plus';

  bool get hasReachedFreeLimit => !isPremium && totalUsageCount >= freeLimit;

  int get remainingFree => isPremium ? -1 : (freeLimit - totalUsageCount).clamp(0, freeLimit);

  DeviceState copyWith({
    bool? isInitialized,
    bool? isLoading,
    String? deviceId,
    String? subscriptionPlan,
    int? totalUsageCount,
    int? freeLimit,
    String? errorMessage,
  }) {
    return DeviceState(
      isInitialized: isInitialized ?? this.isInitialized,
      isLoading: isLoading ?? this.isLoading,
      deviceId: deviceId ?? this.deviceId,
      subscriptionPlan: subscriptionPlan ?? this.subscriptionPlan,
      totalUsageCount: totalUsageCount ?? this.totalUsageCount,
      freeLimit: freeLimit ?? this.freeLimit,
      errorMessage: errorMessage,
    );
  }
}

class DeviceNotifier extends StateNotifier<DeviceState> {
  final DeviceRepository _repository;
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  DeviceNotifier(this._repository) : super(const DeviceState());

  Future<String> _getOrCreateDeviceId() async {
    try {
      final storedId = await _secureStorage.read(key: AppConstants.deviceIdKey);
      if (storedId != null && storedId.isNotEmpty) {
        return storedId;
      }
    } catch (_) {}

    String deviceId;
    final deviceInfo = DeviceInfoPlugin();

    try {
      if (Platform.isIOS) {
        final iosInfo = await deviceInfo.iosInfo;
        deviceId = iosInfo.identifierForVendor ??
            'ios_${DateTime.now().millisecondsSinceEpoch}';
      } else if (Platform.isAndroid) {
        final androidInfo = await deviceInfo.androidInfo;
        deviceId = androidInfo.id;
      } else {
        deviceId = 'unknown_${DateTime.now().millisecondsSinceEpoch}';
      }
    } catch (_) {
      deviceId = 'fallback_${DateTime.now().millisecondsSinceEpoch}';
    }

    try {
      await _secureStorage.write(key: AppConstants.deviceIdKey, value: deviceId);
    } catch (_) {}

    return deviceId;
  }

  String? get deviceId => state.deviceId;

  Future<bool> initializeDevice() async {
    state = state.copyWith(isLoading: true);

    try {
      final deviceId = await _getOrCreateDeviceId();
      state = state.copyWith(deviceId: deviceId);

      String? model;
      String? osVersion;
      final deviceInfo = DeviceInfoPlugin();

      try {
        if (Platform.isIOS) {
          final iosInfo = await deviceInfo.iosInfo;
          model = iosInfo.utsname.machine;
          osVersion = iosInfo.systemVersion;
        }
      } catch (_) {}

      final result = await _repository.registerDevice(
        deviceId: deviceId,
        platform: Platform.isIOS ? 'ios' : 'android',
        model: model,
        osVersion: osVersion,
      );

      result.fold(
        (error) {
          state = state.copyWith(
            isInitialized: true,
            isLoading: false,
            errorMessage: error,
          );
        },
        (data) {
          final device = data['device'] as Map<String, dynamic>?;
          state = state.copyWith(
            isInitialized: true,
            isLoading: false,
            subscriptionPlan: device?['subscription_plan'] as String? ?? 'free',
            totalUsageCount: device?['total_usage_count'] as int? ?? 0,
            freeLimit: device?['free_limit'] as int? ?? 2,
          );
        },
      );

      await TikTokAnalyticsService.instance.identifyUser(externalId: deviceId);

      return true;
    } catch (e) {
      state = state.copyWith(
        isInitialized: true,
        isLoading: false,
        errorMessage: 'Failed to initialize device',
      );
      return false;
    }
  }
}

final deviceProvider = StateNotifierProvider<DeviceNotifier, DeviceState>((ref) {
  final repository = ref.watch(deviceRepositoryProvider);
  return DeviceNotifier(repository);
});

final deviceIdProvider = Provider<String?>((ref) {
  return ref.watch(deviceProvider).deviceId;
});
