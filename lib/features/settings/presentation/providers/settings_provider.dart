import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/theme_provider.dart';
import '../../data/models/settings_model.dart';
import '../../data/repositories/settings_repository.dart';

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
  String get language => settings?.language ?? 'en';
}

class SettingsNotifier extends StateNotifier<SettingsState> {
  final SettingsRepository _repository;
  final Ref _ref;

  SettingsNotifier(this._repository, this._ref) : super(const SettingsState());

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
      },
    );
  }

  Future<void> setLanguage(String language) async {
    // Optimistic update
    final oldSettings = state.settings;
    state = state.copyWith(
      settings: state.settings?.copyWith(language: language) ??
          SettingsModel(language: language),
    );

    final result = await _repository.updateSettings(language: language);

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
}

final settingsProvider = StateNotifierProvider<SettingsNotifier, SettingsState>((ref) {
  final repository = ref.watch(settingsRepositoryProvider);
  return SettingsNotifier(repository, ref);
});
