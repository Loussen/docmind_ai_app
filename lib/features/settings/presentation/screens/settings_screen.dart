import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:animate_do/animate_do.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../subscription/presentation/providers/subscription_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    final subscriptionState = ref.watch(subscriptionProvider);

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
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
                  color: AppColors.surfaceLight,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.divider),
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
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            user?.email ?? '',
                            style: const TextStyle(
                              fontSize: 14,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Iconsax.edit_2, color: AppColors.primary),
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
                        : AppColors.surfaceLight,
                    borderRadius: BorderRadius.circular(20),
                    border: subscriptionState.isPremium
                        ? null
                        : Border.all(color: AppColors.divider),
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
                              subscriptionState.isPremium
                                  ? 'Premium Member'
                                  : 'Free Plan',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: subscriptionState.isPremium
                                    ? Colors.white
                                    : AppColors.textPrimary,
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
              child: _buildSectionTitle('Preferences'),
            ),

            const SizedBox(height: 12),

            FadeInUp(
              delay: const Duration(milliseconds: 300),
              duration: const Duration(milliseconds: 500),
              child: _buildSettingsCard([
                _SettingsTile(
                  icon: Iconsax.notification,
                  title: 'Notifications',
                  trailing: Switch.adaptive(
                    value: true,
                    onChanged: (value) {},
                    activeColor: AppColors.primary,
                  ),
                ),
                _SettingsTile(
                  icon: Iconsax.moon,
                  title: 'Dark Mode',
                  trailing: Switch.adaptive(
                    value: false,
                    onChanged: (value) {},
                    activeColor: AppColors.primary,
                  ),
                ),
                _SettingsTile(
                  icon: Iconsax.language_circle,
                  title: 'Language',
                  subtitle: 'English',
                  onTap: () {},
                ),
              ]),
            ),

            const SizedBox(height: 24),

            FadeInUp(
              delay: const Duration(milliseconds: 400),
              duration: const Duration(milliseconds: 500),
              child: _buildSectionTitle('Support'),
            ),

            const SizedBox(height: 12),

            FadeInUp(
              delay: const Duration(milliseconds: 500),
              duration: const Duration(milliseconds: 500),
              child: _buildSettingsCard([
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
              ]),
            ),

            const SizedBox(height: 24),

            FadeInUp(
              delay: const Duration(milliseconds: 600),
              duration: const Duration(milliseconds: 500),
              child: _buildSectionTitle('Account'),
            ),

            const SizedBox(height: 12),

            FadeInUp(
              delay: const Duration(milliseconds: 700),
              duration: const Duration(milliseconds: 500),
              child: _buildSettingsCard([
                _SettingsTile(
                  icon: Iconsax.refresh,
                  title: 'Restore Purchases',
                  onTap: () {
                    ref.read(subscriptionProvider.notifier).restorePurchases();
                  },
                ),
                _SettingsTile(
                  icon: Iconsax.logout,
                  title: 'Sign Out',
                  titleColor: AppColors.error,
                  onTap: () => _showLogoutDialog(context, ref),
                ),
              ]),
            ),

            const SizedBox(height: 32),

            // App Version
            FadeIn(
              delay: const Duration(milliseconds: 800),
              child: Center(
                child: Text(
                  'DocMind AI v${AppConstants.appVersion}',
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.textTertiary,
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

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: AppColors.textTertiary,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildSettingsCard(List<_SettingsTile> tiles) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.divider),
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
                    color: (tile.titleColor ?? AppColors.primary).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    tile.icon,
                    color: tile.titleColor ?? AppColors.primary,
                    size: 20,
                  ),
                ),
                title: Text(
                  tile.title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: tile.titleColor ?? AppColors.textPrimary,
                  ),
                ),
                subtitle: tile.subtitle != null
                    ? Text(
                        tile.subtitle!,
                        style: const TextStyle(
                          fontSize: 13,
                          color: AppColors.textTertiary,
                        ),
                      )
                    : null,
                trailing: tile.trailing ??
                    (tile.onTap != null
                        ? const Icon(
                            Iconsax.arrow_right_3,
                            size: 18,
                            color: AppColors.textTertiary,
                          )
                        : null),
              ),
              if (!isLast)
                const Divider(
                  height: 1,
                  indent: 68,
                  color: AppColors.divider,
                ),
            ],
          );
        }).toList(),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Sign Out'),
        content: const Text('Are you sure you want to sign out?'),
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

