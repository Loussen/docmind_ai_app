import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Theme mode state
enum AppThemeMode { system, light, dark }

class ThemeState {
  final AppThemeMode mode;
  final bool isInitialized;

  const ThemeState({
    this.mode = AppThemeMode.system,
    this.isInitialized = false,
  });

  ThemeState copyWith({
    AppThemeMode? mode,
    bool? isInitialized,
  }) {
    return ThemeState(
      mode: mode ?? this.mode,
      isInitialized: isInitialized ?? this.isInitialized,
    );
  }

  ThemeMode get themeMode {
    switch (mode) {
      case AppThemeMode.light:
        return ThemeMode.light;
      case AppThemeMode.dark:
        return ThemeMode.dark;
      case AppThemeMode.system:
        return ThemeMode.system;
    }
  }

  bool get isDark => mode == AppThemeMode.dark;
  bool get isLight => mode == AppThemeMode.light;
  bool get isSystem => mode == AppThemeMode.system;
}

class ThemeNotifier extends StateNotifier<ThemeState> {
  static const String _themeKey = 'app_theme_mode';

  ThemeNotifier() : super(const ThemeState()) {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final themeModeString = prefs.getString(_themeKey);

      AppThemeMode mode = AppThemeMode.system;
      if (themeModeString != null) {
        mode = AppThemeMode.values.firstWhere(
          (e) => e.name == themeModeString,
          orElse: () => AppThemeMode.system,
        );
      }

      state = state.copyWith(mode: mode, isInitialized: true);
      _updateSystemUI(mode);
    } catch (e) {
      state = state.copyWith(isInitialized: true);
    }
  }

  Future<void> setThemeMode(AppThemeMode mode) async {
    state = state.copyWith(mode: mode);
    _updateSystemUI(mode);

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_themeKey, mode.name);
    } catch (e) {
      // Ignore storage errors
    }
  }

  Future<void> toggleDarkMode(bool isDark) async {
    await setThemeMode(isDark ? AppThemeMode.dark : AppThemeMode.light);
  }

  void _updateSystemUI(AppThemeMode mode) {
    final isDark = mode == AppThemeMode.dark;
    final isSystem = mode == AppThemeMode.system;

    // For system mode, we'll let the system handle it
    if (isSystem) {
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
      );
      return;
    }

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
        statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
        systemNavigationBarColor:
            isDark ? const Color(0xFF121212) : Colors.white,
        systemNavigationBarIconBrightness:
            isDark ? Brightness.light : Brightness.dark,
      ),
    );
  }
}

final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeState>((ref) {
  return ThemeNotifier();
});

// Convenience provider for checking if dark mode
final isDarkModeProvider = Provider<bool>((ref) {
  final themeState = ref.watch(themeProvider);
  return themeState.isDark;
});
