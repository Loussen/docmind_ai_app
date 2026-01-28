import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:animate_do/animate_do.dart';
import 'package:iconsax/iconsax.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/theme/app_colors.dart';
import '../providers/guest_provider.dart';

class GuestHomeScreen extends ConsumerStatefulWidget {
  const GuestHomeScreen({super.key});

  @override
  ConsumerState<GuestHomeScreen> createState() => _GuestHomeScreenState();
}

class _GuestHomeScreenState extends ConsumerState<GuestHomeScreen> {
  File? _selectedFile;
  String? _fileName;

  @override
  Widget build(BuildContext context) {
    final guestState = ref.watch(guestProvider);

    // Listen for limit reached
    ref.listen<GuestState>(guestProvider, (previous, next) {
      if (next.limitReached && previous?.limitReached != true) {
        _showLimitReachedDialog();
      }
      if (next.lastSummary != null && previous?.lastSummary == null) {
        // Navigate to guest summary screen
        context.push('/guest/summary');
      }
    });

    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isDark
                ? [AppColors.backgroundDark, const Color(0xFF1A1A2E)]
                : [
                    AppColors.backgroundLight,
                    AppColors.primary.withOpacity(0.05)
                  ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with trial info
                FadeInDown(
                  duration: const Duration(milliseconds: 500),
                  child: _buildHeader(guestState, isDark),
                ),
                const SizedBox(height: 32),

                // Upload area
                FadeInUp(
                  delay: const Duration(milliseconds: 200),
                  child: _buildUploadArea(guestState, isDark),
                ),
                const SizedBox(height: 24),

                // Selected file info
                if (_selectedFile != null)
                  FadeIn(
                    child: _buildSelectedFile(isDark),
                  ),

                if (_selectedFile != null) const SizedBox(height: 24),

                // Summarize button
                if (_selectedFile != null && !guestState.isProcessing)
                  FadeInUp(
                    child: _buildSummarizeButton(guestState),
                  ),

                // Processing indicator
                if (guestState.isProcessing)
                  FadeIn(
                    child: _buildProcessingIndicator(isDark),
                  ),

                const SizedBox(height: 32),

                // Features info
                FadeInUp(
                  delay: const Duration(milliseconds: 400),
                  child: _buildFeaturesInfo(isDark),
                ),

                const SizedBox(height: 24),

                // Create account CTA
                FadeInUp(
                  delay: const Duration(milliseconds: 500),
                  child: _buildCreateAccountCTA(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(GuestState state, bool isDark) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Try DocMind AI',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: isDark ? AppColors.textLight : AppColors.textPrimary,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                state.remainingTrials > 0
                    ? '${state.remainingTrials} trial${state.remainingTrials != 1 ? 's' : ''} left'
                    : 'No trials remaining',
                style: TextStyle(
                  fontSize: 16,
                  color: state.remainingTrials > 0
                      ? (isDark
                          ? AppColors.textSecondaryDark
                          : AppColors.textSecondary)
                      : AppColors.error,
                ),
              ),
            ],
          ),
        ),
        // Trial counter badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: state.remainingTrials > 0
                ? AppColors.warning.withOpacity(isDark ? 0.25 : 0.15)
                : AppColors.error.withOpacity(isDark ? 0.25 : 0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                state.remainingTrials > 0 ? Iconsax.timer_1 : Iconsax.warning_2,
                size: 18,
                color: state.remainingTrials > 0
                    ? AppColors.warning
                    : AppColors.error,
              ),
              const SizedBox(width: 6),
              Text(
                '${state.remainingTrials}/${state.maxTrials}',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: state.remainingTrials > 0
                      ? AppColors.warning
                      : AppColors.error,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildUploadArea(GuestState state, bool isDark) {
    return GestureDetector(
      onTap: state.isProcessing ? null : _showPickerOptions,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(40),
        decoration: BoxDecoration(
          color: isDark ? AppColors.cardDark : Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: AppColors.primary.withOpacity(isDark ? 0.5 : 0.3),
            width: 2,
            strokeAlign: BorderSide.strokeAlignInside,
          ),
          boxShadow: [
            BoxShadow(
              color: isDark
                  ? Colors.black.withOpacity(0.3)
                  : AppColors.primary.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(
                Iconsax.document_upload,
                size: 40,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Upload Document',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: isDark ? AppColors.textLight : AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'PDF, Word, or Image (max 5MB, 2 pages)',
              style: TextStyle(
                fontSize: 14,
                color: isDark
                    ? AppColors.textTertiaryDark
                    : AppColors.textTertiary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectedFile(bool isDark) {
    final extension = _fileName?.split('.').last.toLowerCase() ?? '';
    final icon = _getFileIcon(extension);
    final color = _getFileColor(extension);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.cardDark : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.3 : 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: color.withOpacity(isDark ? 0.2 : 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _fileName ?? 'Unknown file',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: isDark ? AppColors.textLight : AppColors.textPrimary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  _getFileSizeString(_selectedFile?.lengthSync() ?? 0),
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
            onPressed: () {
              setState(() {
                _selectedFile = null;
                _fileName = null;
              });
            },
            icon: Icon(
              Iconsax.close_circle,
              color:
                  isDark ? AppColors.textTertiaryDark : AppColors.textTertiary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummarizeButton(GuestState state) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: state.limitReached ? null : _handleSummarize,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Iconsax.magic_star, size: 22),
            const SizedBox(width: 10),
            const Text(
              'Summarize Now',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProcessingIndicator(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: isDark ? AppColors.cardDark : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.3 : 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
          ),
          const SizedBox(height: 16),
          Text(
            'Analyzing your document...',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: isDark ? AppColors.textLight : AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'This may take a moment',
            style: TextStyle(
              fontSize: 14,
              color:
                  isDark ? AppColors.textTertiaryDark : AppColors.textTertiary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturesInfo(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color:
            isDark ? AppColors.cardDark : AppColors.warning.withOpacity(0.08),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.warning.withOpacity(isDark ? 0.5 : 0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Iconsax.info_circle,
                color: AppColors.warning,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Guest Mode Limitations',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: isDark ? AppColors.textLight : AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildLimitationRow(
              Iconsax.close_circle, 'Max 2 pages per document', true, isDark),
          _buildLimitationRow(Iconsax.close_circle,
              'Only 2 total trials (no reset)', true, isDark),
          _buildLimitationRow(Iconsax.close_circle,
              'Summary not saved to history', true, isDark),
          _buildLimitationRow(
              Iconsax.close_circle, 'No cloud sync', true, isDark),
          Divider(
              height: 24,
              color: isDark ? AppColors.dividerDark : AppColors.divider),
          const Text(
            '✨ With a free account you get:',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.success,
            ),
          ),
          const SizedBox(height: 12),
          _buildLimitationRow(
              Iconsax.tick_circle, 'Up to 5 pages per document', false, isDark),
          _buildLimitationRow(
              Iconsax.tick_circle, '3 summaries per day', false, isDark),
          _buildLimitationRow(
              Iconsax.tick_circle, 'History saved forever', false, isDark),
          _buildLimitationRow(
              Iconsax.tick_circle, 'Cloud sync across devices', false, isDark),
        ],
      ),
    );
  }

  Widget _buildLimitationRow(
      IconData icon, String text, bool isNegative, bool isDark) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Icon(
            icon,
            size: 18,
            color: isNegative
                ? (isDark ? AppColors.error : AppColors.error.withOpacity(0.7))
                : AppColors.success,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14,
                color: isNegative
                    ? (isDark
                        ? AppColors.textTertiaryDark
                        : AppColors.textSecondary)
                    : (isDark ? AppColors.textLight : AppColors.textPrimary),
                decoration: isNegative ? TextDecoration.lineThrough : null,
                decorationColor:
                    isDark ? AppColors.error : AppColors.error.withOpacity(0.5),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCreateAccountCTA() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          const Text(
            'Want unlimited access?',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Create a free account for more features',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withOpacity(0.9),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                ref.read(guestProvider.notifier).exitGuestMode();
                context.go('/login');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text(
                'Create Free Account',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showPickerOptions() {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: isDark ? AppColors.surfaceDark : Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: isDark ? AppColors.dividerDark : AppColors.divider,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Select Document Source',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: isDark ? AppColors.textLight : AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 24),
            _buildPickerOption(
              icon: Iconsax.folder_open,
              title: 'Browse Files',
              subtitle: 'PDF, Word documents',
              isDark: isDark,
              onTap: () {
                Navigator.pop(ctx);
                _pickFile();
              },
            ),
            const SizedBox(height: 12),
            _buildPickerOption(
              icon: Iconsax.camera,
              title: 'Take Photo',
              subtitle: 'Capture document with camera',
              isDark: isDark,
              onTap: () {
                Navigator.pop(ctx);
                _takePhoto();
              },
            ),
            const SizedBox(height: 12),
            _buildPickerOption(
              icon: Iconsax.gallery,
              title: 'Photo Library',
              subtitle: 'Select from gallery',
              isDark: isDark,
              onTap: () {
                Navigator.pop(ctx);
                _pickImage();
              },
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildPickerOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    required bool isDark,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark ? AppColors.cardDark : AppColors.backgroundLight,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: AppColors.primary, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color:
                          isDark ? AppColors.textLight : AppColors.textPrimary,
                    ),
                  ),
                  Text(
                    subtitle,
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
            Icon(
              Iconsax.arrow_right_3,
              color:
                  isDark ? AppColors.textTertiaryDark : AppColors.textTertiary,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickFile() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx'],
      );

      if (result != null && result.files.single.path != null) {
        final file = File(result.files.single.path!);
        final size = file.lengthSync();

        if (size > 5 * 1024 * 1024) {
          _showErrorSnackbar('File too large. Maximum 5MB for guest mode.');
          return;
        }

        setState(() {
          _selectedFile = file;
          _fileName = result.files.single.name;
        });
      }
    } catch (e) {
      _showErrorSnackbar('Failed to pick file');
    }
  }

  Future<void> _takePhoto() async {
    try {
      final picker = ImagePicker();
      final image = await picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 85,
      );

      if (image != null) {
        final file = File(image.path);
        setState(() {
          _selectedFile = file;
          _fileName = image.name;
        });
      }
    } catch (e) {
      _showErrorSnackbar('Failed to capture photo');
    }
  }

  Future<void> _pickImage() async {
    try {
      final picker = ImagePicker();
      final image = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
      );

      if (image != null) {
        final file = File(image.path);
        final size = file.lengthSync();

        if (size > 5 * 1024 * 1024) {
          _showErrorSnackbar('File too large. Maximum 5MB for guest mode.');
          return;
        }

        setState(() {
          _selectedFile = file;
          _fileName = image.name;
        });
      }
    } catch (e) {
      _showErrorSnackbar('Failed to pick image');
    }
  }

  Future<void> _handleSummarize() async {
    if (_selectedFile == null) return;

    final success = await ref
        .read(guestProvider.notifier)
        .summarizeDocument(_selectedFile!);

    if (!success && mounted) {
      final error = ref.read(guestProvider).errorMessage;
      if (error != null) {
        _showErrorSnackbar(error);
      }
    }
  }

  void _showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.error,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  void _showLimitReachedDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Row(
          children: [
            Icon(Iconsax.warning_2, color: AppColors.warning, size: 28),
            SizedBox(width: 12),
            Text('Trial Limit Reached'),
          ],
        ),
        content: const Text(
          'You have used all your free trials. Create an account to continue using DocMind AI with unlimited access.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Maybe Later'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ref.read(guestProvider.notifier).exitGuestMode();
              context.go('/login');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text('Create Account'),
          ),
        ],
      ),
    );
  }

  IconData _getFileIcon(String extension) {
    switch (extension) {
      case 'pdf':
        return Iconsax.document_text;
      case 'doc':
      case 'docx':
        return Iconsax.document;
      case 'jpg':
      case 'jpeg':
      case 'png':
        return Iconsax.image;
      default:
        return Iconsax.document;
    }
  }

  Color _getFileColor(String extension) {
    switch (extension) {
      case 'pdf':
        return Colors.red;
      case 'doc':
      case 'docx':
        return Colors.blue;
      case 'jpg':
      case 'jpeg':
      case 'png':
        return Colors.green;
      default:
        return AppColors.primary;
    }
  }

  String _getFileSizeString(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }
}
