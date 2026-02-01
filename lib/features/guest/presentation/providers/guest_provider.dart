import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/repositories/guest_repository.dart';

// Guest mode state
class GuestState {
  final bool isGuestMode;
  final bool isLoading;
  final bool isProcessing;
  final int usedTrials;
  final int maxTrials;
  final bool limitReached;
  final String? errorMessage;
  final Map<String, dynamic>? lastSummary;
  final Map<String, dynamic>? lastDocument;
  final Map<String, dynamic>? previewInfo;
  final String? successMessage;

  const GuestState({
    this.isGuestMode = false,
    this.isLoading = false,
    this.isProcessing = false,
    this.usedTrials = 0,
    this.maxTrials = 2,
    this.limitReached = false,
    this.errorMessage,
    this.lastSummary,
    this.lastDocument,
    this.previewInfo,
    this.successMessage,
  });

  int get remainingTrials => maxTrials - usedTrials;

  // Preview info helpers
  int get hiddenKeyPoints => previewInfo?['hidden_key_points'] as int? ?? 0;
  int get hiddenActionItems => previewInfo?['hidden_action_items'] as int? ?? 0;
  int get hiddenKeywords => previewInfo?['hidden_keywords'] as int? ?? 0;
  int get totalKeyPoints => previewInfo?['total_key_points'] as int? ?? 0;
  int get totalActionItems => previewInfo?['total_action_items'] as int? ?? 0;
  int get totalKeywords => previewInfo?['total_keywords'] as int? ?? 0;
  bool get isPreview => previewInfo?['is_preview'] as bool? ?? true;

  GuestState copyWith({
    bool? isGuestMode,
    bool? isLoading,
    bool? isProcessing,
    int? usedTrials,
    int? maxTrials,
    bool? limitReached,
    String? errorMessage,
    Map<String, dynamic>? lastSummary,
    Map<String, dynamic>? lastDocument,
    Map<String, dynamic>? previewInfo,
    String? successMessage,
  }) {
    return GuestState(
      isGuestMode: isGuestMode ?? this.isGuestMode,
      isLoading: isLoading ?? this.isLoading,
      isProcessing: isProcessing ?? this.isProcessing,
      usedTrials: usedTrials ?? this.usedTrials,
      maxTrials: maxTrials ?? this.maxTrials,
      limitReached: limitReached ?? this.limitReached,
      errorMessage: errorMessage,
      lastSummary: lastSummary ?? this.lastSummary,
      lastDocument: lastDocument ?? this.lastDocument,
      previewInfo: previewInfo ?? this.previewInfo,
      successMessage: successMessage,
    );
  }
}

class GuestNotifier extends StateNotifier<GuestState> {
  final GuestRepository _repository;
  String? _deviceId;

  GuestNotifier(this._repository) : super(const GuestState());

  Future<String> _getDeviceId() async {
    if (_deviceId != null) return _deviceId!;

    final deviceInfo = DeviceInfoPlugin();
    
    try {
      if (Platform.isIOS) {
        final iosInfo = await deviceInfo.iosInfo;
        _deviceId = iosInfo.identifierForVendor ?? 'unknown_ios_${DateTime.now().millisecondsSinceEpoch}';
      } else if (Platform.isAndroid) {
        final androidInfo = await deviceInfo.androidInfo;
        _deviceId = androidInfo.id;
      } else {
        _deviceId = 'unknown_${DateTime.now().millisecondsSinceEpoch}';
      }
    } catch (e) {
      _deviceId = 'fallback_${DateTime.now().millisecondsSinceEpoch}';
    }

    return _deviceId!;
  }

  Future<void> enterGuestMode() async {
    state = state.copyWith(isLoading: true);

    try {
      // Get device ID
      final deviceId = await _getDeviceId();
      
      // Check usage from server
      final result = await _repository.checkUsage(deviceId: deviceId);
      
      result.fold(
        (error) {
          // Even if check fails, let them try
          state = state.copyWith(
            isGuestMode: true,
            isLoading: false,
          );
        },
        (data) {
          final used = data['used'] as int? ?? 0;
          final limit = data['limit'] as int? ?? 2;
          final limitReached = data['limit_reached'] as bool? ?? false;
          
          state = state.copyWith(
            isGuestMode: true,
            isLoading: false,
            usedTrials: used,
            maxTrials: limit,
            limitReached: limitReached,
          );
        },
      );

      // Save guest mode preference
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('is_guest_mode', true);
    } catch (e) {
      state = state.copyWith(
        isGuestMode: true,
        isLoading: false,
      );
    }
  }

  void exitGuestMode() async {
    state = const GuestState();
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('is_guest_mode', false);
  }

  Future<bool> summarizeDocument(File file) async {
    if (state.limitReached) {
      state = state.copyWith(
        errorMessage: 'You have used all your free trials. Create an account to continue.',
      );
      return false;
    }

    state = state.copyWith(
      isProcessing: true,
      errorMessage: null,
      successMessage: null,
    );

    try {
      final deviceId = await _getDeviceId();
      
      final result = await _repository.summarizeDocument(
        file: file,
        deviceId: deviceId,
      );

      return result.fold(
        (error) {
          if (error.startsWith('LIMIT_REACHED:')) {
            state = state.copyWith(
              isProcessing: false,
              limitReached: true,
              errorMessage: error.replaceFirst('LIMIT_REACHED:', ''),
            );
          } else {
            state = state.copyWith(
              isProcessing: false,
              errorMessage: error,
            );
          }
          return false;
        },
        (data) {
          final usage = data['usage'] as Map<String, dynamic>?;
          final document = data['document'] as Map<String, dynamic>?;
          final summary = data['summary'] as Map<String, dynamic>?;
          final previewInfo = data['preview_info'] as Map<String, dynamic>?;
          final message = data['message'] as String?;

          state = state.copyWith(
            isProcessing: false,
            usedTrials: usage?['used'] as int? ?? state.usedTrials + 1,
            maxTrials: usage?['limit'] as int? ?? state.maxTrials,
            limitReached: (usage?['remaining'] as int? ?? 1) <= 0,
            lastDocument: document,
            lastSummary: summary,
            previewInfo: previewInfo,
            successMessage: message,
          );
          return true;
        },
      );
    } catch (e) {
      state = state.copyWith(
        isProcessing: false,
        errorMessage: 'An unexpected error occurred',
      );
      return false;
    }
  }

  void clearError() {
    state = state.copyWith(errorMessage: null);
  }

  void clearSuccess() {
    state = state.copyWith(successMessage: null);
  }

  void clearLastSummary() {
    state = GuestState(
      isGuestMode: state.isGuestMode,
      usedTrials: state.usedTrials,
      maxTrials: state.maxTrials,
      limitReached: state.limitReached,
      // previewInfo cleared with lastSummary
    );
  }
}

final guestProvider = StateNotifierProvider<GuestNotifier, GuestState>((ref) {
  final repository = ref.watch(guestRepositoryProvider);
  return GuestNotifier(repository);
});
