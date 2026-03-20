import 'dart:ui' as ui;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../../core/theme/theme_provider.dart';
import '../../../../l10n/app_localizations.dart';
import '../../data/models/settings_model.dart';
import '../../data/repositories/settings_repository.dart';

const _settingsBoxName = 'app_settings';
const _keyUiLanguage = 'ui_language';
const _keyOutputLanguage = 'output_language';
const _keyDarkMode = 'dark_mode_enabled';

class SettingsState {
  final SettingsModel? settings;
  final bool isLoading;
  final String? errorMessage;

  const SettingsState({
    this.settings,
    this.isLoading = false,
    this.errorMessage,
  });

  SettingsState copyWith({
    SettingsModel? settings,
    bool? isLoading,
    String? errorMessage,
  }) {
    return SettingsState(
      settings: settings ?? this.settings,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }

  bool get notificationsEnabled => settings?.notificationsEnabled ?? true;
  bool get darkModeEnabled => settings?.darkModeEnabled ?? false;
  String get uiLanguage => settings?.uiLanguage ?? settings?.legacyLanguage ?? SettingsNotifier._resolveDeviceLanguage();
  String get outputLanguage => settings?.outputLanguage ?? 'en';
}

class SettingsNotifier extends StateNotifier<SettingsState> {
  final SettingsRepository _repository;
  final Ref _ref;

  SettingsNotifier(this._repository, this._ref)
      : super(SettingsState(settings: _loadCachedSettings())) {
    // Load from backend in background at startup
    Future.microtask(loadSettings);
  }

  static SettingsModel? _loadCachedSettings() {
    try {
      final box = Hive.box(_settingsBoxName);
      final cachedUi = box.get(_keyUiLanguage) as String?;
      final out = box.get(_keyOutputLanguage) as String?;
      final dark = box.get(_keyDarkMode) as bool?;

      final resolvedUi = cachedUi ?? _resolveDeviceLanguage();

      return SettingsModel(
        uiLanguage: resolvedUi,
        outputLanguage: out ?? resolvedUi,
        darkModeEnabled: dark ?? false,
      );
    } catch (_) {
      return null;
    }
  }

  static String _resolveDeviceLanguage() {
    final deviceLocale = ui.PlatformDispatcher.instance.locale;
    final supportedCodes = S.supportedLocales.map((l) => l.languageCode).toSet();

    if (deviceLocale.scriptCode != null) {
      final withScript = '${deviceLocale.languageCode}-${deviceLocale.scriptCode}';
      final hasScript = S.supportedLocales.any(
        (l) => l.languageCode == deviceLocale.languageCode && l.scriptCode == deviceLocale.scriptCode,
      );
      if (hasScript) return withScript;
    }

    if (supportedCodes.contains(deviceLocale.languageCode)) {
      return deviceLocale.languageCode;
    }

    return 'en';
  }

  Future<void> _cacheSettings(SettingsModel settings) async {
    try {
      final box = Hive.box(_settingsBoxName);
      await box.put(_keyUiLanguage, settings.uiLanguage);
      await box.put(_keyOutputLanguage, settings.outputLanguage);
      await box.put(_keyDarkMode, settings.darkModeEnabled);
    } catch (_) {
      // Best-effort cache (never block UX)
    }
  }

  Future<void> loadSettings() async {
    if (state.isLoading) return;

    state = state.copyWith(isLoading: true);

    final result = await _repository.getSettings();

    result.fold(
      (error) {
        state = state.copyWith(
          isLoading: false,
          errorMessage: error,
        );
      },
      (settings) {
        state = state.copyWith(
          settings: settings,
          isLoading: false,
        );
        // Sync theme with loaded settings
        _ref.read(themeProvider.notifier).toggleDarkMode(settings.darkModeEnabled);
        _cacheSettings(settings);
      },
    );
  }

  Future<void> setNotificationsEnabled(bool enabled) async {
    // Optimistic update
    final oldSettings = state.settings;
    state = state.copyWith(
      settings: state.settings?.copyWith(notificationsEnabled: enabled) ??
          SettingsModel(notificationsEnabled: enabled),
    );

    final result = await _repository.updateSettings(notificationsEnabled: enabled);

    result.fold(
      (error) {
        // Revert on error
        state = state.copyWith(
          settings: oldSettings,
          errorMessage: error,
        );
      },
      (settings) {
        state = state.copyWith(settings: settings);
      },
    );
  }

  Future<void> setDarkModeEnabled(bool enabled) async {
    // Update theme immediately for instant feedback
    _ref.read(themeProvider.notifier).toggleDarkMode(enabled);

    // Optimistic update
    final oldSettings = state.settings;
    state = state.copyWith(
      settings: state.settings?.copyWith(darkModeEnabled: enabled) ??
          SettingsModel(darkModeEnabled: enabled),
    );

    final result = await _repository.updateSettings(darkModeEnabled: enabled);

    result.fold(
      (error) {
        // Revert on error
        _ref.read(themeProvider.notifier).toggleDarkMode(!enabled);
        state = state.copyWith(
          settings: oldSettings,
          errorMessage: error,
        );
      },
      (settings) {
        state = state.copyWith(settings: settings);
        _cacheSettings(settings);
      },
    );
  }

  Future<void> setUiLanguage(String uiLanguage) async {
    // Optimistic update
    final oldSettings = state.settings;
    state = state.copyWith(
      settings: state.settings?.copyWith(uiLanguage: uiLanguage) ??
          SettingsModel(uiLanguage: uiLanguage),
    );

    final result = await _repository.updateSettings(uiLanguage: uiLanguage);

    result.fold(
      (error) {
        // Revert on error
        state = state.copyWith(
          settings: oldSettings,
          errorMessage: error,
        );
      },
      (settings) {
        state = state.copyWith(settings: settings);
        _cacheSettings(settings);
      },
    );
  }

  Future<void> setOutputLanguage(String outputLanguage) async {
    final oldSettings = state.settings;
    state = state.copyWith(
      settings: state.settings?.copyWith(outputLanguage: outputLanguage) ??
          SettingsModel(outputLanguage: outputLanguage),
    );

    final result = await _repository.updateSettings(outputLanguage: outputLanguage);

    result.fold(
      (error) {
        state = state.copyWith(
          settings: oldSettings,
          errorMessage: error,
        );
      },
      (settings) {
        state = state.copyWith(settings: settings);
        _cacheSettings(settings);
      },
    );
  }
}

final settingsProvider = StateNotifierProvider<SettingsNotifier, SettingsState>((ref) {
  final repository = ref.watch(settingsRepositoryProvider);
  return SettingsNotifier(repository, ref);
});
