import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:file_picker/file_picker.dart';
import 'package:animate_do/animate_do.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../subscription/presentation/providers/subscription_provider.dart';
import '../../../summary/presentation/providers/summary_provider.dart';
import '../providers/document_provider.dart';

class UploadScreen extends ConsumerStatefulWidget {
  const UploadScreen({super.key});

  @override
  ConsumerState<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends ConsumerState<UploadScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(uploadProvider.notifier).reset();
    });
  }

  @override
  Widget build(BuildContext context) {
    final uploadState = ref.watch(uploadProvider);
    final canUpload = ref.watch(canUploadProvider);
    final summaryState = ref.watch(summaryGenerationProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      appBar: AppBar(
        backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
        leading: IconButton(
          icon: Icon(
            Iconsax.close_circle,
            color: isDark ? AppColors.textLight : AppColors.textPrimary,
          ),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Upload Document',
          style: TextStyle(
            color: isDark ? AppColors.textLight : AppColors.textPrimary,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Upload Area
              Expanded(
                child: FadeInUp(
                  duration: const Duration(milliseconds: 300),
                  child: _buildUploadArea(uploadState, canUpload, isDark),
                ),
              ),

              const SizedBox(height: 24),

              // Progress and Status
              if (uploadState.hasFile)
                FadeInUp(
                  duration: const Duration(milliseconds: 300),
                  child: _buildFileInfo(uploadState, isDark),
                ),

              if (uploadState.isUploading || uploadState.isProcessing)
                FadeIn(
                  child: _buildProgress(uploadState, summaryState, isDark),
                ),

              if (uploadState.errorMessage != null)
                FadeIn(
                  child: _buildError(uploadState.errorMessage!, isDark),
                ),

              const SizedBox(height: 24),

              // Action Button
              FadeInUp(
                delay: const Duration(milliseconds: 100),
                duration: const Duration(milliseconds: 300),
                child: _buildActionButton(uploadState, summaryState, canUpload),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUploadArea(UploadState uploadState, bool canUpload, bool isDark) {
    if (uploadState.hasFile) {
      return _buildSelectedFileArea(uploadState, isDark);
    }

    return GestureDetector(
      onTap: canUpload ? _pickFile : _showUpgradeDialog,
      child: Container(
        decoration: BoxDecoration(
          color: isDark ? AppColors.cardDark : AppColors.surfaceLight,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: AppColors.primary.withOpacity(isDark ? 0.5 : 0.3),
            width: 2,
            strokeAlign: BorderSide.strokeAlignInside,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Iconsax.document_upload,
                size: 48,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Tap to upload a document',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: isDark ? AppColors.textLight : AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'PDF, DOCX, JPG, PNG up to ${AppConstants.maxFileSizeFree}MB',
              style: TextStyle(
                fontSize: 14,
                color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isDark ? AppColors.info.withOpacity(0.15) : AppColors.infoLight,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Iconsax.info_circle,
                    size: 18,
                    color: AppColors.info,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    canUpload
                        ? 'AI will extract and summarize content'
                        : 'Free limit reached. Upgrade to continue',
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.info,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectedFileArea(UploadState uploadState, bool isDark) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.cardDark : AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: isDark ? AppColors.dividerDark : AppColors.divider),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: AppColors.successLight,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Iconsax.document_text5,
              size: 48,
              color: AppColors.success,
            ),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              uploadState.fileName ?? 'Document',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: isDark ? AppColors.textLight : AppColors.textPrimary,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Ready to process',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.success,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 24),
          TextButton.icon(
            onPressed: _pickFile,
            icon: const Icon(Iconsax.refresh),
            label: const Text('Choose Different File'),
          ),
        ],
      ),
    );
  }

  Widget _buildFileInfo(UploadState uploadState, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.cardDark : AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: isDark ? AppColors.dividerDark : AppColors.divider),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Iconsax.document_text,
              color: AppColors.primary,
              size: 22,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  uploadState.fileName ?? 'Document',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: isDark ? AppColors.textLight : AppColors.textPrimary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  'Selected file',
                  style: TextStyle(
                    fontSize: 12,
                    color: isDark ? AppColors.textTertiaryDark : AppColors.textTertiary,
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Iconsax.tick_circle5,
            color: AppColors.success,
            size: 24,
          ),
        ],
      ),
    );
  }

  Widget _buildProgress(UploadState uploadState, SummaryGenerationState summaryState, bool isDark) {
    String status;
    double progress;

    if (uploadState.isUploading) {
      status = 'Uploading document...';
      progress = uploadState.uploadProgress;
    } else if (summaryState.isGenerating) {
      status = 'AI is analyzing your document...';
      progress = -1; // Indeterminate
    } else {
      status = 'Processing...';
      progress = -1;
    }

    return Container(
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  value: progress >= 0 ? progress : null,
                  valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  status,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primary,
                  ),
                ),
              ),
              if (progress >= 0)
                Text(
                  '${(progress * 100).toInt()}%',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
            ],
          ),
          if (progress >= 0) ...[
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 6,
                backgroundColor: AppColors.primary.withOpacity(0.2),
                valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildError(String message, bool isDark) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.error.withOpacity(0.15) : AppColors.errorLight,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const Icon(
            Iconsax.warning_2,
            color: AppColors.error,
            size: 22,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.error,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Iconsax.close_circle, color: AppColors.error),
            onPressed: () => ref.read(uploadProvider.notifier).clearError(),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
    UploadState uploadState,
    SummaryGenerationState summaryState,
    bool canUpload,
  ) {
    final isLoading = uploadState.isUploading || 
                      uploadState.isProcessing || 
                      summaryState.isGenerating;

    return SizedBox(
      height: 56,
      child: ElevatedButton(
        onPressed: isLoading || !uploadState.hasFile
            ? null
            : _processDocument,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          disabledBackgroundColor: AppColors.primary.withOpacity(0.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: isLoading
            ? const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                  SizedBox(width: 12),
                  Text('Processing...'),
                ],
              )
            : const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Iconsax.magic_star),
                  SizedBox(width: 8),
                  Text(
                    'Generate Summary',
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

  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: AppConstants.supportedExtensions,
    );

    if (result != null && result.files.isNotEmpty) {
      final file = File(result.files.first.path!);
      final fileName = result.files.first.name;
      ref.read(uploadProvider.notifier).selectFile(file, fileName);
    }
  }

  Future<void> _processDocument() async {
    final uploadNotifier = ref.read(uploadProvider.notifier);
    final summaryNotifier = ref.read(summaryGenerationProvider.notifier);
    final documentsNotifier = ref.read(documentsProvider.notifier);

    // Upload document
    final document = await uploadNotifier.uploadDocument();
    if (document == null) return;

    // Add to documents list
    documentsNotifier.addDocument(document);

    // Generate summary
    final summary = await summaryNotifier.generateSummary(
      documentId: document.id,
    );

    if (summary != null && mounted) {
      // Refresh usage
      ref.read(subscriptionProvider.notifier).refreshUsage();
      
      // Navigate to summary
      context.go('/summary/${summary.id}');
    }
  }

  void _showUpgradeDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Row(
          children: [
            Icon(Iconsax.crown5, color: AppColors.secondary),
            SizedBox(width: 8),
            Text('Free Limit Reached'),
          ],
        ),
        content: const Text(
          'You\'ve used all your free documents. Upgrade to Pro for unlimited access!',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Maybe Later'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              context.push('/subscription');
            },
            child: const Text('Upgrade Now'),
          ),
        ],
      ),
    );
  }
}

