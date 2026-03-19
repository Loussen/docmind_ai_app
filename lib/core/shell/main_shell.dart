import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';

import '../../l10n/app_localizations.dart';
import '../services/update_service.dart';
import '../theme/app_colors.dart';
import '../widgets/force_update_dialog.dart';

class MainShell extends StatefulWidget {
  final Widget child;

  const MainShell({super.key, required this.child});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  bool _updateChecked = false;

  @override
  void initState() {
    super.initState();
    _checkForUpdate();
  }

  Future<void> _checkForUpdate() async {
    if (_updateChecked) return;
    _updateChecked = true;

    final needsUpdate = await UpdateService.isUpdateRequired();
    if (needsUpdate && mounted) {
      showForceUpdateDialog(context);
    }
  }

  int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.path;
    if (location.startsWith('/home')) return 0;
    if (location.startsWith('/history')) return 1;
    if (location.startsWith('/settings')) return 2;
    return 0;
  }

  void _onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/home');
        break;
      case 1:
        context.go('/history');
        break;
      case 2:
        context.go('/settings');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedIndex = _calculateSelectedIndex(context);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      body: widget.child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (index) => _onItemTapped(context, index),
        backgroundColor: theme.colorScheme.surface,
        indicatorColor: theme.colorScheme.primary.withOpacity(0.12),
        height: 65,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        destinations: [
          NavigationDestination(
            icon: Icon(
              Iconsax.home_2,
              color: isDark ? AppColors.textTertiaryDark : null,
            ),
            selectedIcon: Icon(Iconsax.home_25, color: theme.colorScheme.primary),
            label: S.of(context)!.navHome,
          ),
          NavigationDestination(
            icon: Icon(
              Iconsax.clock,
              color: isDark ? AppColors.textTertiaryDark : null,
            ),
            selectedIcon: Icon(Iconsax.clock5, color: theme.colorScheme.primary),
            label: S.of(context)!.navHistory,
          ),
          NavigationDestination(
            icon: Icon(
              Iconsax.setting_4,
              color: isDark ? AppColors.textTertiaryDark : null,
            ),
            selectedIcon: Icon(Iconsax.setting_45, color: theme.colorScheme.primary),
            label: S.of(context)!.navSettings,
          ),
        ],
      ),
      floatingActionButton: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          gradient: AppColors.primaryGradient,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(isDark ? 0.4 : 0.3),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => _showAddOptions(context, isDark),
            borderRadius: BorderRadius.circular(16),
            child: const Icon(
              Iconsax.add,
              color: Colors.white,
              size: 28,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void _showAddOptions(BuildContext context, bool isDark) {
    // Use router for navigation so Gallery/Camera still work after async (modal context would be unmounted).
    final router = GoRouter.of(context);

    showModalBottomSheet(
      context: context,
      backgroundColor: isDark ? AppColors.cardDark : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (modalContext) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                S.of(context)!.addDocument,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: isDark ? AppColors.textLight : AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 20),
              _AddOptionTile(
                icon: Iconsax.document_text,
                label: S.of(context)!.optionDocument,
                subtitle: S.of(context)!.optionDocumentSub,
                isDark: isDark,
                onTap: () {
                  Navigator.pop(modalContext);
                  router.push('/upload');
                },
              ),
              _AddOptionTile(
                icon: Iconsax.gallery,
                label: S.of(context)!.optionGallery,
                subtitle: S.of(context)!.optionGallerySub,
                isDark: isDark,
                onTap: () async {
                  Navigator.pop(modalContext);
                  await _pickAndNavigate(router, ImageSource.gallery);
                },
              ),
              _AddOptionTile(
                icon: Iconsax.camera,
                label: S.of(context)!.optionCamera,
                subtitle: S.of(context)!.optionCameraSub,
                isDark: isDark,
                onTap: () async {
                  Navigator.pop(modalContext);
                  await _pickAndNavigate(router, ImageSource.camera);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickAndNavigate(GoRouter router, ImageSource source) async {
    final picker = ImagePicker();
    final xFile = await picker.pickImage(
      source: source,
      maxWidth: 2048,
      imageQuality: 85,
    );
    if (xFile == null) return;
    router.push('/upload', extra: {'path': xFile.path, 'fileName': xFile.name});
  }
}

class _AddOptionTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String subtitle;
  final bool isDark;
  final VoidCallback onTap;

  const _AddOptionTile({
    required this.icon,
    required this.label,
    required this.subtitle,
    required this.isDark,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      leading: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: AppColors.primary.withOpacity(isDark ? 0.2 : 0.1),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Icon(icon, color: AppColors.primary, size: 24),
      ),
      title: Text(
        label,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: isDark ? AppColors.textLight : AppColors.textPrimary,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          fontSize: 13,
          color: isDark ? AppColors.textTertiaryDark : AppColors.textTertiary,
        ),
      ),
      trailing: Icon(
        Iconsax.arrow_right_3,
        size: 20,
        color: isDark ? AppColors.textTertiaryDark : AppColors.textTertiary,
      ),
    );
  }
}
