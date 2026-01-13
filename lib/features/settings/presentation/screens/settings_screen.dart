import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:animate_do/animate_do.dart';
import 'package:iconsax/iconsax.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../auth/data/models/user_model.dart';
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

    // Listen for subscription state changes (restore purchases, etc.)
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
            // Profile Card
            FadeInDown(
              duration: const Duration(milliseconds: 500),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isDark ? AppColors.dividerDark : AppColors.divider,
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                        mainAxisAlignment: MainAxisAlignment.center,
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
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () => _showEditProfileDialog(context, ref, user),
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          constraints: const BoxConstraints(
                            minWidth: 40,
                            minHeight: 40,
                          ),
                          alignment: Alignment.center,
                          child: Icon(
                            Iconsax.edit_2,
                            color: colorScheme.primary,
                            size: 20,
                          ),
                        ),
                      ),
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
                    subtitle: 'Coming Soon',
                    onTap: null,
                    isDisabled: true,
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

  void _showEditProfileDialog(
      BuildContext context, WidgetRef ref, UserModel? user) {
    if (user == null) return;

    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final nameController = TextEditingController(text: user.name ?? '');
    final parentContext = context; // Store parent context for snackbar

    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setDialogState) {
          bool isSaving = false;

          return Dialog(
            backgroundColor: Colors.transparent,
            insetPadding: const EdgeInsets.all(24),
            child: Container(
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Header
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: isDark
                              ? AppColors.dividerDark
                              : AppColors.divider,
                          width: 1,
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Iconsax.profile_circle,
                            color: AppColors.primary,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Edit Profile',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: theme.colorScheme.onSurface,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'Update your personal information',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: isDark
                                      ? AppColors.textTertiaryDark
                                      : AppColors.textTertiary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Iconsax.close_circle),
                          color: isDark
                              ? AppColors.textTertiaryDark
                              : AppColors.textTertiary,
                          onPressed: () => Navigator.pop(dialogContext),
                        ),
                      ],
                    ),
                  ),

                  // Content
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Email Field (Read-only)
                        Text(
                          'Email',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                          decoration: BoxDecoration(
                            color: isDark
                                ? AppColors.inputBackgroundDark
                                : AppColors.inputBackground,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Iconsax.sms,
                                size: 18,
                                color: AppColors.textTertiary,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  user.email,
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: isDark
                                        ? AppColors.textTertiaryDark
                                        : AppColors.textTertiary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Name Field
                        Text(
                          'Name',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: nameController,
                          enabled: !isSaving,
                          decoration: InputDecoration(
                            hintText: 'Enter your name',
                            prefixIcon: const Icon(
                              Iconsax.user,
                              size: 18,
                            ),
                            filled: true,
                            fillColor: isDark
                                ? AppColors.inputBackgroundDark
                                : AppColors.inputBackground,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: BorderSide.none,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: BorderSide(
                                color: AppColors.primary,
                                width: 2,
                              ),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 14,
                            ),
                          ),
                          style: TextStyle(
                            fontSize: 15,
                            color: theme.colorScheme.onSurface,
                          ),
                          maxLength: 50,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Email cannot be changed',
                          style: TextStyle(
                            fontSize: 12,
                            color: isDark
                                ? AppColors.textTertiaryDark
                                : AppColors.textTertiary,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Actions
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: isDark
                              ? AppColors.dividerDark
                              : AppColors.divider,
                          width: 1,
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: isSaving
                                ? null
                                : () => Navigator.pop(dialogContext),
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                              side: BorderSide(
                                color: isDark
                                    ? AppColors.dividerDark
                                    : AppColors.divider,
                              ),
                            ),
                            child: const Text('Cancel'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          flex: 2,
                          child: ElevatedButton(
                            onPressed: isSaving
                                ? null
                                : () async {
                                    final newName = nameController.text.trim();

                                    if (newName == (user.name ?? '')) {
                                      Navigator.pop(dialogContext);
                                      return;
                                    }

                                    setDialogState(() => isSaving = true);

                                    final success = await ref
                                        .read(authProvider.notifier)
                                        .updateProfile(
                                          name:
                                              newName.isEmpty ? null : newName,
                                        );

                                    if (dialogContext.mounted) {
                                      Navigator.pop(dialogContext);
                                    }

                                    if (parentContext.mounted) {
                                      ScaffoldMessenger.of(parentContext)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Row(
                                            children: [
                                              Icon(
                                                success
                                                    ? Iconsax.tick_circle
                                                    : Iconsax.close_circle,
                                                color: Colors.white,
                                                size: 20,
                                              ),
                                              const SizedBox(width: 12),
                                              Expanded(
                                                child: Text(
                                                  success
                                                      ? 'Profile updated successfully'
                                                      : 'Failed to update profile',
                                                ),
                                              ),
                                            ],
                                          ),
                                          backgroundColor: success
                                              ? AppColors.success
                                              : AppColors.error,
                                          behavior: SnackBarBehavior.floating,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          margin: const EdgeInsets.all(16),
                                          duration: const Duration(seconds: 3),
                                        ),
                                      );
                                    }
                                  },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            child: isSaving
                                ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white,
                                      ),
                                    ),
                                  )
                                : const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Iconsax.tick_circle, size: 18),
                                      SizedBox(width: 8),
                                      Text(
                                        'Save Changes',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _showLogoutDialog(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final parentContext = context; // Store settings screen context

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
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
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(dialogContext);
              await ref.read(authProvider.notifier).logout();
              if (parentContext.mounted) {
                parentContext.go('/login');
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

  // TODO: Uncomment when language feature is ready
  // String _getLanguageName(String code) {
  //   switch (code) {
  //     case 'en':
  //       return 'English';
  //     case 'az':
  //       return 'Azərbaycan';
  //     case 'ru':
  //       return 'Русский';
  //     case 'tr':
  //       return 'Türkçe';
  //     default:
  //       return 'English';
  //   }
  // }

  // void _showLanguageDialog(BuildContext context, WidgetRef ref,
  //     String currentLanguage, bool isDark) {
  //   final theme = Theme.of(context);
  //   final languages = [
  //     ('en', 'English'),
  //     ('az', 'Azərbaycan'),
  //     ('ru', 'Русский'),
  //     ('tr', 'Türkçe'),
  //   ];

  //   showDialog(
  //     context: context,
  //     builder: (context) => AlertDialog(
  //       backgroundColor: theme.colorScheme.surface,
  //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
  //       title: Text(
  //         'Select Language',
  //         style: TextStyle(color: theme.colorScheme.onSurface),
  //       ),
  //       content: Column(
  //         mainAxisSize: MainAxisSize.min,
  //         children: languages.map((lang) {
  //           final isSelected = lang.$1 == currentLanguage;
  //           return ListTile(
  //             title: Text(
  //               lang.$2,
  //               style: TextStyle(
  //                 fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
  //                 color: isSelected
  //                     ? theme.colorScheme.primary
  //                     : theme.colorScheme.onSurface,
  //               ),
  //             ),
  //             trailing: isSelected
  //                 ? Icon(Iconsax.tick_circle5, color: theme.colorScheme.primary)
  //                 : null,
  //             onTap: () {
  //               Navigator.pop(context);
  //               ref.read(settingsProvider.notifier).setLanguage(lang.$1);
  //             },
  //           );
  //         }).toList(),
  //       ),
  //     ),
  //   );
  // }
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
