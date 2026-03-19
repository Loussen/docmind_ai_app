import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:animate_do/animate_do.dart';
import 'package:iconsax/iconsax.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/i18n/language_options.dart';
import '../../../subscription/presentation/providers/subscription_provider.dart';
import '../providers/settings_provider.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  void _showLanguagePicker({
    required bool isDark,
    required String title,
    required List<LanguageOption> options,
    required String selectedCode,
    required void Function(String code) onSelect,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: isDark ? AppColors.cardDark : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: isDark ? AppColors.textLight : AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 12),
              Flexible(
                child: ListView(
                  shrinkWrap: true,
                  children: options.map((lang) {
                    final isSelected = lang.code == selectedCode;
                    return ListTile(
                      leading: Text(
                        lang.flag,
                        style: const TextStyle(fontSize: 24),
                      ),
                      title: Text(
                        lang.name,
                        style: TextStyle(
                          color:
                              isDark ? AppColors.textLight : AppColors.textPrimary,
                          fontWeight:
                              isSelected ? FontWeight.w700 : FontWeight.w500,
                        ),
                      ),
                      trailing: isSelected
                          ? const Icon(Iconsax.tick_circle, color: AppColors.primary)
                          : null,
                      onTap: () {
                        Navigator.pop(context);
                        onSelect(lang.code);
                      },
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(settingsProvider.notifier).loadSettings();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    final subscriptionState = ref.watch(subscriptionProvider);
    final isPremium = ref.watch(effectiveIsPremiumProvider);
    final isProPlus = ref.watch(effectiveIsProPlusProvider);
    final settingsState = ref.watch(settingsProvider);

    ref.listen<SubscriptionState>(subscriptionProvider, (previous, next) {
      if (next.errorMessage != null &&
          next.errorMessage != previous?.errorMessage) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Iconsax.close_circle, color: Colors.white, size: 20),
                const SizedBox(width: 12),
                Expanded(child: Text(next.errorMessage!)),
              ],
            ),
            backgroundColor: AppColors.error,
            behavior: SnackBarBehavior.floating,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            margin: const EdgeInsets.all(16),
          ),
        );
        ref.read(subscriptionProvider.notifier).clearError();
      }
      if (next.successMessage != null &&
          next.successMessage != previous?.successMessage) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Iconsax.tick_circle, color: Colors.white, size: 20),
                const SizedBox(width: 12),
                Expanded(child: Text(next.successMessage!)),
              ],
            ),
            backgroundColor: AppColors.success,
            behavior: SnackBarBehavior.floating,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            margin: const EdgeInsets.all(16),
          ),
        );
        ref.read(subscriptionProvider.notifier).clearSuccess();
      }
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        surfaceTintColor: Colors.transparent,
        title: Text(S.of(context)!.settings),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Subscription Card
            FadeInDown(
              duration: const Duration(milliseconds: 300),
              child: GestureDetector(
                onTap: () => context.push('/subscription'),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: isPremium
                        ? const LinearGradient(
                            colors: [Color(0xFF667eea), Color(0xFF764ba2)],
                          )
                        : null,
                    color: isPremium
                        ? null
                        : colorScheme.surface,
                    borderRadius: BorderRadius.circular(20),
                    border: isPremium
                        ? null
                        : Border.all(
                            color: isDark
                                ? AppColors.dividerDark
                                : AppColors.divider,
                          ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: isPremium
                              ? Colors.white.withOpacity(0.2)
                              : AppColors.secondary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Icon(
                          Iconsax.crown5,
                          color: isPremium
                              ? Colors.white
                              : AppColors.secondary,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              isProPlus
                                  ? S.of(context)!.proPlusMember
                                  : isPremium
                                      ? S.of(context)!.proMember
                                      : S.of(context)!.freePlan,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: isPremium
                                    ? Colors.white
                                    : colorScheme.onSurface,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              isPremium
                                  ? S.of(context)!.unlimitedAccess
                                  : S.of(context)!.upgradeForMoreFeatures,
                              style: TextStyle(
                                fontSize: 13,
                                color: isPremium
                                    ? Colors.white70
                                    : isDark
                                        ? AppColors.textSecondaryDark
                                        : AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Iconsax.arrow_right_3,
                        color: isPremium
                            ? Colors.white
                            : isDark
                                ? AppColors.textTertiaryDark
                                : AppColors.textTertiary,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 32),

            // Preferences
            FadeInUp(
              delay: const Duration(milliseconds: 50),
              duration: const Duration(milliseconds: 300),
              child: _buildSectionTitle(S.of(context)!.preferences, isDark),
            ),

            const SizedBox(height: 12),

            FadeInUp(
              delay: const Duration(milliseconds: 100),
              duration: const Duration(milliseconds: 300),
              child: _buildSettingsCard(
                isDark: isDark,
                colorScheme: colorScheme,
                tiles: [
                  _SettingsTile(
                    icon: Iconsax.notification,
                    title: S.of(context)!.notifications,
                    trailing: Switch.adaptive(
                      value: settingsState.notificationsEnabled,
                      onChanged: (value) {
                        ref
                            .read(settingsProvider.notifier)
                            .setNotificationsEnabled(value);
                      },
                      activeColor: colorScheme.primary,
                    ),
                  ),
                  _SettingsTile(
                    icon: Iconsax.moon,
                    title: S.of(context)!.darkMode,
                    trailing: Switch.adaptive(
                      value: isDark,
                      onChanged: (value) {
                        ref
                            .read(settingsProvider.notifier)
                            .setDarkModeEnabled(value);
                      },
                      activeColor: colorScheme.primary,
                    ),
                  ),
                  _SettingsTile(
                    icon: Iconsax.language_circle,
                    title: S.of(context)!.appLanguage,
                    subtitle: '${languageFlag(settingsState.uiLanguage, forUi: true)} ${languageName(settingsState.uiLanguage, forUi: true)}',
                    onTap: () => _showLanguagePicker(
                      isDark: isDark,
                      title: S.of(context)!.appLanguage,
                      options: appUiLanguages,
                      selectedCode: settingsState.uiLanguage,
                      onSelect: (code) => ref
                          .read(settingsProvider.notifier)
                          .setUiLanguage(code),
                    ),
                  ),
                  _SettingsTile(
                    icon: Iconsax.translate,
                    title: S.of(context)!.summaryLanguage,
                    subtitle: '${languageFlag(settingsState.outputLanguage)} ${languageName(settingsState.outputLanguage)}',
                    onTap: () => _showLanguagePicker(
                      isDark: isDark,
                      title: S.of(context)!.summaryLanguage,
                      options: outputLanguages,
                      selectedCode: settingsState.outputLanguage,
                      onSelect: (code) => ref
                          .read(settingsProvider.notifier)
                          .setOutputLanguage(code),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Support
            FadeInUp(
              delay: const Duration(milliseconds: 150),
              duration: const Duration(milliseconds: 300),
              child: _buildSectionTitle(S.of(context)!.support, isDark),
            ),

            const SizedBox(height: 12),

            FadeInUp(
              delay: const Duration(milliseconds: 200),
              duration: const Duration(milliseconds: 300),
              child: _buildSettingsCard(
                isDark: isDark,
                colorScheme: colorScheme,
                tiles: [
                  _SettingsTile(
                    icon: Iconsax.teacher,
                    title: S.of(context)!.tutorial,
                    onTap: () => context.push('/onboarding', extra: true),
                  ),
                  _SettingsTile(
                    icon: Iconsax.message_question,
                    title: S.of(context)!.helpFaq,
                    onTap: () => _launchUrl('https://docsmind.app/support'),
                  ),
                  _SettingsTile(
                    icon: Iconsax.star,
                    title: S.of(context)!.rateApp,
                    subtitle: S.of(context)!.rateAppSub,
                    onTap: () => _launchUrl(AppConstants.appStoreReviewUrl),
                  ),
                  _SettingsTile(
                    icon: Iconsax.document,
                    title: S.of(context)!.privacyPolicy,
                    onTap: () => _launchUrl('https://docsmind.app/privacy'),
                  ),
                  _SettingsTile(
                    icon: Iconsax.document_text,
                    title: S.of(context)!.termsOfService,
                    onTap: () => _launchUrl('https://docsmind.app/terms'),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Account
            FadeInUp(
              delay: const Duration(milliseconds: 250),
              duration: const Duration(milliseconds: 300),
              child: _buildSectionTitle(S.of(context)!.account, isDark),
            ),

            const SizedBox(height: 12),

            FadeInUp(
              delay: const Duration(milliseconds: 300),
              duration: const Duration(milliseconds: 300),
              child: _buildSettingsCard(
                isDark: isDark,
                colorScheme: colorScheme,
                tiles: [
                  _SettingsTile(
                    icon: Iconsax.refresh,
                    title: S.of(context)!.restorePurchases,
                    trailing: subscriptionState.isRestoring
                        ? SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: isDark
                                  ? AppColors.textTertiaryDark
                                  : AppColors.textTertiary,
                            ),
                          )
                        : null,
                    onTap: subscriptionState.isRestoring
                        ? null
                        : () {
                            ref
                                .read(subscriptionProvider.notifier)
                                .restorePurchases();
                          },
                  ),
                ],
              ),
            ),

            if (kDebugMode) ...[
              const SizedBox(height: 24),

              FadeInUp(
                delay: const Duration(milliseconds: 350),
                duration: const Duration(milliseconds: 300),
                child: _buildSectionTitle('Debug', isDark),
              ),

              const SizedBox(height: 12),

              FadeInUp(
                delay: const Duration(milliseconds: 400),
                duration: const Duration(milliseconds: 300),
                child: _buildSettingsCard(
                  isDark: isDark,
                  colorScheme: colorScheme,
                  tiles: [
                    _SettingsTile(
                      icon: Iconsax.shield_tick,
                      title: 'Simulate Free Plan',
                      trailing: Switch.adaptive(
                        value: ref.watch(debugFreeModProvider),
                        onChanged: (value) {
                          ref.read(debugFreeModProvider.notifier).state = value;
                        },
                        activeColor: AppColors.error,
                      ),
                    ),
                  ],
                ),
              ),

              if (ref.watch(debugFreeModProvider))
                Padding(
                  padding: const EdgeInsets.only(top: 8, left: 4, right: 4),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.error.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.error.withValues(alpha: 0.3)),
                    ),
                    child: Row(
                      children: [
                        const Icon(Iconsax.warning_2, color: AppColors.error, size: 20),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Free plan active: ${AppConstants.maxFileSizeFree}MB limit, daily upload limit, no translate',
                            style: TextStyle(
                              fontSize: 12,
                              color: isDark ? AppColors.error : AppColors.error,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],

            const SizedBox(height: 32),

            FadeIn(
              delay: const Duration(milliseconds: 350),
              child: GestureDetector(
                onTap: () => _showWhatsNewDialog(context, isDark),
                child: Center(
                  child: Text(
                    'DoCMind AI v${AppConstants.appVersion}',
                    style: TextStyle(
                      fontSize: 13,
                      color: isDark
                          ? AppColors.textTertiaryDark
                          : AppColors.textTertiary,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, bool isDark) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: isDark ? AppColors.textTertiaryDark : AppColors.textTertiary,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildSettingsCard({
    required bool isDark,
    required ColorScheme colorScheme,
    required List<_SettingsTile> tiles,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? AppColors.dividerDark : AppColors.divider,
        ),
      ),
      child: Column(
        children: tiles.asMap().entries.map((entry) {
          final isLast = entry.key == tiles.length - 1;
          final tile = entry.value;
          final isDisabled = tile.isDisabled;
          return Column(
            children: [
              Opacity(
                opacity: isDisabled ? 0.5 : 1.0,
                child: ListTile(
                  onTap: isDisabled ? null : tile.onTap,
                  leading: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: (tile.titleColor ?? colorScheme.primary)
                          .withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      tile.icon,
                      color: tile.titleColor ?? colorScheme.primary,
                      size: 20,
                    ),
                  ),
                  title: Text(
                    tile.title,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: tile.titleColor ?? colorScheme.onSurface,
                    ),
                  ),
                  subtitle: tile.subtitle != null
                      ? Text(
                          tile.subtitle!,
                          style: TextStyle(
                            fontSize: 13,
                            color: isDark
                                ? AppColors.textTertiaryDark
                                : AppColors.textTertiary,
                          ),
                        )
                      : null,
                  trailing: tile.trailing ??
                      (tile.onTap != null && !isDisabled
                          ? Icon(
                              Iconsax.arrow_right_3,
                              size: 18,
                              color: isDark
                                  ? AppColors.textTertiaryDark
                                  : AppColors.textTertiary,
                            )
                          : null),
                ),
              ),
              if (!isLast)
                Divider(
                  height: 1,
                  indent: 68,
                  color: isDark ? AppColors.dividerDark : AppColors.divider,
                ),
            ],
          );
        }).toList(),
      ),
    );
  }

  void _showWhatsNewDialog(BuildContext context, bool isDark) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          'What\'s New in v${AppConstants.appVersion}',
          style: TextStyle(color: isDark ? AppColors.textLight : AppColors.textPrimary),
        ),
        content: SingleChildScrollView(
          child: Text(
            AppConstants.whatsNew1_0_8.trim(),
            style: TextStyle(
              fontSize: 14,
              height: 1.5,
              color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}

class _SettingsTile {
  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final Color? titleColor;
  final VoidCallback? onTap;
  final bool isDisabled;

  const _SettingsTile({
    required this.icon,
    required this.title,
    this.subtitle,
    this.trailing,
    this.titleColor,
    this.onTap,
    this.isDisabled = false,
  });
}
