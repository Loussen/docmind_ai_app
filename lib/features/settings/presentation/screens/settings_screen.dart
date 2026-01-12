import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:animate_do/animate_do.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
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

    final user = ref.watch(currentUserProvider);
    final subscriptionState = ref.watch(subscriptionProvider);
    final settingsState = ref.watch(settingsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Card
            FadeInDown(
              duration: const Duration(milliseconds: 500),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isDark ? AppColors.dividerDark : AppColors.divider,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        gradient: AppColors.primaryGradient,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: Text(
                          user?.name?.isNotEmpty == true
                              ? user!.name![0].toUpperCase()
                              : user?.email[0].toUpperCase() ?? 'U',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user?.name ?? 'User',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: colorScheme.onSurface,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            user?.email ?? '',
                            style: TextStyle(
                              fontSize: 14,
                              color: isDark
                                  ? AppColors.textSecondaryDark
                                  : AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: Icon(Iconsax.edit_2, color: colorScheme.primary),
                      onPressed: () {
                        // Edit profile
                      },
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Subscription Card
            FadeInUp(
              delay: const Duration(milliseconds: 100),
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

            // Settings Sections
            FadeInUp(
              delay: const Duration(milliseconds: 200),
              duration: const Duration(milliseconds: 500),
              child: _buildSectionTitle('Preferences', isDark),
            ),

            const SizedBox(height: 12),

            FadeInUp(
              delay: const Duration(milliseconds: 300),
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
                    subtitle: _getLanguageName(settingsState.language),
                    onTap: () => _showLanguageDialog(
                        context, ref, settingsState.language, isDark),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            FadeInUp(
              delay: const Duration(milliseconds: 400),
              duration: const Duration(milliseconds: 500),
              child: _buildSectionTitle('Support', isDark),
            ),

            const SizedBox(height: 12),

            FadeInUp(
              delay: const Duration(milliseconds: 500),
              duration: const Duration(milliseconds: 500),
              child: _buildSettingsCard(
                isDark: isDark,
                colorScheme: colorScheme,
                tiles: [
                  _SettingsTile(
                    icon: Iconsax.message_question,
                    title: 'Help & FAQ',
                    onTap: () {},
                  ),
                  _SettingsTile(
                    icon: Iconsax.star,
                    title: 'Rate App',
                    onTap: () {},
                  ),
                  _SettingsTile(
                    icon: Iconsax.document,
                    title: 'Privacy Policy',
                    onTap: () {},
                  ),
                  _SettingsTile(
                    icon: Iconsax.document_text,
                    title: 'Terms of Service',
                    onTap: () {},
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            FadeInUp(
              delay: const Duration(milliseconds: 600),
              duration: const Duration(milliseconds: 500),
              child: _buildSectionTitle('Account', isDark),
            ),

            const SizedBox(height: 12),

            FadeInUp(
              delay: const Duration(milliseconds: 700),
              duration: const Duration(milliseconds: 500),
              child: _buildSettingsCard(
                isDark: isDark,
                colorScheme: colorScheme,
                tiles: [
                  _SettingsTile(
                    icon: Iconsax.refresh,
                    title: 'Restore Purchases',
                    onTap: () {
                      ref
                          .read(subscriptionProvider.notifier)
                          .restorePurchases();
                    },
                  ),
                  _SettingsTile(
                    icon: Iconsax.logout,
                    title: 'Sign Out',
                    titleColor: AppColors.error,
                    onTap: () => _showLogoutDialog(context, ref),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // App Version
            FadeIn(
              delay: const Duration(milliseconds: 800),
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
          return Column(
            children: [
              ListTile(
                onTap: tile.onTap,
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
                    (tile.onTap != null
                        ? Icon(
                            Iconsax.arrow_right_3,
                            size: 18,
                            color: isDark
                                ? AppColors.textTertiaryDark
                                : AppColors.textTertiary,
                          )
                        : null),
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

  void _showLogoutDialog(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: theme.colorScheme.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          'Sign Out',
          style: TextStyle(color: theme.colorScheme.onSurface),
        ),
        content: Text(
          'Are you sure you want to sign out?',
          style: TextStyle(color: theme.colorScheme.onSurface.withOpacity(0.8)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
              await ref.read(authProvider.notifier).logout();
              if (context.mounted) {
                context.go('/login');
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
            ),
            child: const Text('Sign Out'),
          ),
        ],
      ),
    );
  }

  String _getLanguageName(String code) {
    switch (code) {
      case 'en':
        return 'English';
      case 'az':
        return 'Azərbaycan';
      case 'ru':
        return 'Русский';
      case 'tr':
        return 'Türkçe';
      default:
        return 'English';
    }
  }

  void _showLanguageDialog(BuildContext context, WidgetRef ref,
      String currentLanguage, bool isDark) {
    final theme = Theme.of(context);
    final languages = [
      ('en', 'English'),
      ('az', 'Azərbaycan'),
      ('ru', 'Русский'),
      ('tr', 'Türkçe'),
    ];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: theme.colorScheme.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          'Select Language',
          style: TextStyle(color: theme.colorScheme.onSurface),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: languages.map((lang) {
            final isSelected = lang.$1 == currentLanguage;
            return ListTile(
              title: Text(
                lang.$2,
                style: TextStyle(
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  color: isSelected
                      ? theme.colorScheme.primary
                      : theme.colorScheme.onSurface,
                ),
              ),
              trailing: isSelected
                  ? Icon(Iconsax.tick_circle5, color: theme.colorScheme.primary)
                  : null,
              onTap: () {
                Navigator.pop(context);
                ref.read(settingsProvider.notifier).setLanguage(lang.$1);
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}

class _SettingsTile {
  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final Color? titleColor;
  final VoidCallback? onTap;

  const _SettingsTile({
    required this.icon,
    required this.title,
    this.subtitle,
    this.trailing,
    this.titleColor,
    this.onTap,
  });
}
