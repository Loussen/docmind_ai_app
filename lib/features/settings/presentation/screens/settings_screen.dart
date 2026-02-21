import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:animate_do/animate_do.dart';
import 'package:iconsax/iconsax.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../subscription/presentation/providers/subscription_provider.dart';
import '../providers/settings_provider.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
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
        title: const Text('Settings'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Subscription Card
            FadeInDown(
              duration: const Duration(milliseconds: 500),
              child: GestureDetector(
                onTap: () => context.push('/subscription'),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: subscriptionState.isPremium
                        ? const LinearGradient(
                            colors: [Color(0xFF667eea), Color(0xFF764ba2)],
                          )
                        : null,
                    color: subscriptionState.isPremium
                        ? null
                        : colorScheme.surface,
                    borderRadius: BorderRadius.circular(20),
                    border: subscriptionState.isPremium
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
                          color: subscriptionState.isPremium
                              ? Colors.white.withOpacity(0.2)
                              : AppColors.secondary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Icon(
                          Iconsax.crown5,
                          color: subscriptionState.isPremium
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
                              subscriptionState.isProPlus
                                  ? 'Pro+ Member'
                                  : subscriptionState.isPremium
                                      ? 'Pro Member'
                                      : 'Free Plan',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: subscriptionState.isPremium
                                    ? Colors.white
                                    : colorScheme.onSurface,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              subscriptionState.isPremium
                                  ? 'Unlimited access'
                                  : 'Upgrade for more features',
                              style: TextStyle(
                                fontSize: 13,
                                color: subscriptionState.isPremium
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
                        color: subscriptionState.isPremium
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
              delay: const Duration(milliseconds: 100),
              duration: const Duration(milliseconds: 500),
              child: _buildSectionTitle('Preferences', isDark),
            ),

            const SizedBox(height: 12),

            FadeInUp(
              delay: const Duration(milliseconds: 200),
              duration: const Duration(milliseconds: 500),
              child: _buildSettingsCard(
                isDark: isDark,
                colorScheme: colorScheme,
                tiles: [
                  _SettingsTile(
                    icon: Iconsax.notification,
                    title: 'Notifications',
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
                    title: 'Dark Mode',
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
                    title: 'Language',
                    subtitle: 'Coming Soon',
                    onTap: null,
                    isDisabled: true,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Support
            FadeInUp(
              delay: const Duration(milliseconds: 300),
              duration: const Duration(milliseconds: 500),
              child: _buildSectionTitle('Support', isDark),
            ),

            const SizedBox(height: 12),

            FadeInUp(
              delay: const Duration(milliseconds: 400),
              duration: const Duration(milliseconds: 500),
              child: _buildSettingsCard(
                isDark: isDark,
                colorScheme: colorScheme,
                tiles: [
                  _SettingsTile(
                    icon: Iconsax.message_question,
                    title: 'Help & FAQ',
                    onTap: () => _launchUrl('https://docsmind.app/support'),
                  ),
                  _SettingsTile(
                    icon: Iconsax.star,
                    title: 'Rate App',
                    subtitle: 'Love DocMind AI? Rate us!',
                    onTap: () => _launchUrl(AppConstants.appStoreReviewUrl),
                  ),
                  _SettingsTile(
                    icon: Iconsax.document,
                    title: 'Privacy Policy',
                    onTap: () => _launchUrl('https://docsmind.app/privacy'),
                  ),
                  _SettingsTile(
                    icon: Iconsax.document_text,
                    title: 'Terms of Service',
                    onTap: () => _launchUrl('https://docsmind.app/terms'),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Account
            FadeInUp(
              delay: const Duration(milliseconds: 500),
              duration: const Duration(milliseconds: 500),
              child: _buildSectionTitle('Account', isDark),
            ),

            const SizedBox(height: 12),

            FadeInUp(
              delay: const Duration(milliseconds: 600),
              duration: const Duration(milliseconds: 500),
              child: _buildSettingsCard(
                isDark: isDark,
                colorScheme: colorScheme,
                tiles: [
                  _SettingsTile(
                    icon: Iconsax.refresh,
                    title: 'Restore Purchases',
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

            const SizedBox(height: 32),

            FadeIn(
              delay: const Duration(milliseconds: 700),
              child: Center(
                child: Text(
                  'DocMind AI v${AppConstants.appVersion}',
                  style: TextStyle(
                    fontSize: 13,
                    color: isDark
                        ? AppColors.textTertiaryDark
                        : AppColors.textTertiary,
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
