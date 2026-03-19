import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';

import 'core/constants/app_constants.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_provider.dart';
import 'features/settings/presentation/providers/settings_provider.dart';
import 'l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await Hive.openBox('app_settings');

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(
    const ProviderScope(child: DoCMindApp()),
  );
}

class DoCMindApp extends ConsumerStatefulWidget {
  const DoCMindApp({super.key});

  @override
  ConsumerState<DoCMindApp> createState() => _DoCMindAppState();
}

class _DoCMindAppState extends ConsumerState<DoCMindApp> {
  StreamSubscription? _sharingIntentSub;

  @override
  void initState() {
    super.initState();
    _initSharingIntent();
  }

  @override
  void dispose() {
    _sharingIntentSub?.cancel();
    super.dispose();
  }

  void _initSharingIntent() {
    // Handle files shared while app is already running (from background)
    _sharingIntentSub = ReceiveSharingIntent.instance.getMediaStream().listen(
      _handleSharedFiles,
      onError: (_) {},
    );

    // Handle files shared that opened the app (cold start)
    ReceiveSharingIntent.instance.getInitialMedia().then(_handleSharedFiles);
  }

  void _handleSharedFiles(List<SharedMediaFile> files) {
    if (files.isEmpty) return;

    final file = files.first;
    final path = file.path;
    final fileName = path.split('/').last;
    final ext = fileName.split('.').last.toLowerCase();

    if (!AppConstants.supportedExtensions.contains(ext)) return;

    final router = ref.read(appRouterProvider);
    router.push('/upload', extra: {'path': path, 'fileName': fileName});

    ReceiveSharingIntent.instance.reset();
  }

  @override
  Widget build(BuildContext context) {
    final router = ref.watch(appRouterProvider);
    final themeState = ref.watch(themeProvider);
    final settingsState = ref.watch(settingsProvider);

    Locale? locale;
    final code = settingsState.uiLanguage;
    if (code.contains('-')) {
      final parts = code.split('-');
      if (parts.length >= 2) {
        locale = Locale(parts[0], parts[1]);
      } else {
        locale = Locale(parts[0]);
      }
    } else {
      locale = Locale(code);
    }

    return MaterialApp.router(
      title: 'DoCMind AI',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeState.themeMode,
      locale: locale,
      supportedLocales: S.supportedLocales,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      routerConfig: router,
    );
  }
}
