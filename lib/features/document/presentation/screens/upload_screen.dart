import 'dart:io';
import 'dart:async';
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

class _UploadScreenState extends ConsumerState<UploadScreen>
    with TickerProviderStateMixin {
  Timer? _tipTimer;
  int _currentTipIndex = 0;

  static const _tips = [
    'AI is reading through your document...',
    'Extracting key information...',
    'Identifying important sections...',
    'Building a structured summary...',
    'Almost there, finalizing results...',
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(uploadProvider.notifier).reset();
    });
  }

  @override
  void dispose() {
    _tipTimer?.cancel();
    super.dispose();
  }

  void _startTipRotation() {
    _tipTimer?.cancel();
    _currentTipIndex = 0;
    _tipTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (mounted) {
        setState(() {
          _currentTipIndex = (_currentTipIndex + 1) % _tips.length;
        });
      }
    });
  }

  void _stopTipRotation() {
    _tipTimer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final uploadState = ref.watch(uploadProvider);
    final canUpload = ref.watch(canUploadProvider);
    final summaryState = ref.watch(summaryGenerationProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isWorking = uploadState.isWorking || summaryState.isGenerating;

    return Scaffold(
      backgroundColor:
          isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      appBar: isWorking
          ? null
          : AppBar(
              backgroundColor: isDark
                  ? AppColors.backgroundDark
                  : AppColors.backgroundLight,
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
        child: isWorking
            ? _buildProcessingView(uploadState, summaryState, isDark)
            : _buildNormalView(uploadState, canUpload, summaryState, isDark),
      ),
    );
  }

  Widget _buildNormalView(
    UploadState uploadState,
    bool canUpload,
    SummaryGenerationState summaryState,
    bool isDark,
  ) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: FadeInUp(
              duration: const Duration(milliseconds: 300),
              child: _buildUploadArea(uploadState, canUpload, isDark),
            ),
          ),
          const SizedBox(height: 24),
          if (uploadState.hasFile)
            FadeInUp(
              duration: const Duration(milliseconds: 300),
              child: _buildFileInfo(uploadState, isDark),
            ),
          if (uploadState.errorMessage != null)
            FadeIn(
              child: _buildError(uploadState.errorMessage!, isDark),
            ),
          const SizedBox(height: 24),
          FadeInUp(
            delay: const Duration(milliseconds: 100),
            duration: const Duration(milliseconds: 300),
            child: _buildActionButton(uploadState, summaryState, canUpload),
          ),
        ],
      ),
    );
  }

  Widget _buildProcessingView(
    UploadState uploadState,
    SummaryGenerationState summaryState,
    bool isDark,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          const Spacer(flex: 2),
          FadeIn(
            child: _buildProcessingAnimation(isDark),
          ),
          const SizedBox(height: 40),
          FadeInUp(
            delay: const Duration(milliseconds: 200),
            child: _buildStepIndicator(uploadState, summaryState, isDark),
          ),
          const SizedBox(height: 32),
          if (summaryState.isGenerating || uploadState.status == UploadStatus.analyzing)
            FadeIn(
              child: _buildRotatingTip(isDark),
            ),
          const Spacer(flex: 3),
        ],
      ),
    );
  }

  Widget _buildProcessingAnimation(bool isDark) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 600),
      builder: (context, value, child) {
        return Transform.scale(
          scale: 0.8 + (0.2 * value),
          child: Opacity(opacity: value, child: child),
        );
      },
      child: Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [
              AppColors.primary.withOpacity(0.15),
              AppColors.primaryLight.withOpacity(0.08),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 100,
              height: 100,
              child: CircularProgressIndicator(
                strokeWidth: 3,
                valueColor: AlwaysStoppedAnimation<Color>(
                  AppColors.primary.withOpacity(0.3),
                ),
              ),
            ),
            SizedBox(
              width: 80,
              height: 80,
              child: CircularProgressIndicator(
                strokeWidth: 2.5,
                valueColor: const AlwaysStoppedAnimation<Color>(
                  AppColors.primary,
                ),
              ),
            ),
            const Icon(
              Iconsax.magic_star5,
              size: 36,
              color: AppColors.primary,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepIndicator(
    UploadState uploadState,
    SummaryGenerationState summaryState,
    bool isDark,
  ) {
    final steps = [
      _StepData(
        icon: Iconsax.document_upload,
        label: 'Uploading',
        isActive: uploadState.currentStep == ProcessingStep.upload &&
            uploadState.isUploading,
        isCompleted: uploadState.currentStep.index > ProcessingStep.upload.index,
      ),
      _StepData(
        icon: Iconsax.document_text,
        label: 'Extracting Text',
        isActive: uploadState.currentStep == ProcessingStep.extractText,
        isCompleted:
            uploadState.currentStep.index > ProcessingStep.extractText.index,
      ),
      _StepData(
        icon: Iconsax.cpu,
        label: 'AI Analyzing',
        isActive: uploadState.currentStep == ProcessingStep.analyze ||
            summaryState.isGenerating,
        isCompleted:
            uploadState.currentStep == ProcessingStep.complete,
      ),
    ];

    return Column(
      children: [
        Row(
          children: List.generate(steps.length * 2 - 1, (index) {
            if (index.isOdd) {
              final prevStep = steps[index ~/ 2];
              return Expanded(
                child: Container(
                  height: 2,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    color: prevStep.isCompleted
                        ? AppColors.success
                        : (isDark ? AppColors.dividerDark : AppColors.divider),
                    borderRadius: BorderRadius.circular(1),
                  ),
                ),
              );
            }
            final step = steps[index ~/ 2];
            return _buildStepCircle(step, isDark);
          }),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: steps.map((step) {
            return SizedBox(
              width: 90,
              child: Text(
                step.label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight:
                      step.isActive ? FontWeight.w600 : FontWeight.w400,
                  color: step.isActive
                      ? AppColors.primary
                      : step.isCompleted
                          ? AppColors.success
                          : (isDark
                              ? AppColors.textTertiaryDark
                              : AppColors.textTertiary),
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 20),
        _buildCurrentStepMessage(uploadState, summaryState, isDark),
      ],
    );
  }

  Widget _buildStepCircle(_StepData step, bool isDark) {
    Color bgColor;
    Color iconColor;
    Widget iconWidget;

    if (step.isCompleted) {
      bgColor = AppColors.success;
      iconColor = Colors.white;
      iconWidget = const Icon(Icons.check_rounded, size: 18, color: Colors.white);
    } else if (step.isActive) {
      bgColor = AppColors.primary;
      iconColor = Colors.white;
      iconWidget = SizedBox(
        width: 18,
        height: 18,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(iconColor),
        ),
      );
    } else {
      bgColor = isDark ? AppColors.cardDark : AppColors.surfaceLight;
      iconColor = isDark ? AppColors.textTertiaryDark : AppColors.textTertiary;
      iconWidget = Icon(step.icon, size: 18, color: iconColor);
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: bgColor,
        shape: BoxShape.circle,
        border: step.isActive
            ? null
            : Border.all(
                color: step.isCompleted
                    ? AppColors.success
                    : (isDark ? AppColors.dividerDark : AppColors.divider),
                width: 1.5,
              ),
        boxShadow: step.isActive
            ? [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.3),
                  blurRadius: 12,
                  spreadRadius: 2,
                ),
              ]
            : null,
      ),
      child: Center(child: iconWidget),
    );
  }

  Widget _buildCurrentStepMessage(
    UploadState uploadState,
    SummaryGenerationState summaryState,
    bool isDark,
  ) {
    String message;
    double? progress;

    if (uploadState.isUploading) {
      final pct = (uploadState.uploadProgress * 100).toInt();
      message = 'Uploading your document... $pct%';
      progress = uploadState.uploadProgress;
    } else if (uploadState.currentStep == ProcessingStep.extractText) {
      message = 'Extracting text from your document...';
      progress = null;
    } else if (summaryState.isGenerating ||
        uploadState.currentStep == ProcessingStep.analyze) {
      message = 'AI is analyzing and summarizing...';
      progress = null;
    } else {
      message = 'Preparing...';
      progress = null;
    }

    return Column(
      children: [
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: Text(
            message,
            key: ValueKey(message),
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: isDark ? AppColors.textLight : AppColors.textPrimary,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        if (progress != null) ...[
          const SizedBox(height: 16),
          SizedBox(
            width: 200,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 6,
                backgroundColor: AppColors.primary.withOpacity(0.15),
                valueColor:
                    const AlwaysStoppedAnimation<Color>(AppColors.primary),
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildRotatingTip(bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.primary.withOpacity(0.08)
            : AppColors.primary.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Iconsax.info_circle,
            size: 18,
            color: AppColors.primary.withOpacity(0.7),
          ),
          const SizedBox(width: 10),
          Flexible(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              transitionBuilder: (child, animation) {
                return FadeTransition(
                  opacity: animation,
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0, 0.3),
                      end: Offset.zero,
                    ).animate(animation),
                    child: child,
                  ),
                );
              },
              child: Text(
                _tips[_currentTipIndex],
                key: ValueKey(_currentTipIndex),
                style: TextStyle(
                  fontSize: 13,
                  color: isDark
                      ? AppColors.textSecondaryDark
                      : AppColors.textSecondary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUploadArea(
      UploadState uploadState, bool canUpload, bool isDark) {
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
                color: isDark
                    ? AppColors.textSecondaryDark
                    : AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isDark
                    ? AppColors.info.withOpacity(0.15)
                    : AppColors.infoLight,
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
        border: Border.all(
            color: isDark ? AppColors.dividerDark : AppColors.divider),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: const BoxDecoration(
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
        border:
            Border.all(color: isDark ? AppColors.dividerDark : AppColors.divider),
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
                    color: isDark
                        ? AppColors.textTertiaryDark
                        : AppColors.textTertiary,
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
    final isLoading = uploadState.isWorking || summaryState.isGenerating;

    return SizedBox(
      height: 56,
      child: ElevatedButton(
        onPressed:
            isLoading || !uploadState.hasFile ? null : _processDocument,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          disabledBackgroundColor: AppColors.primary.withOpacity(0.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: const Row(
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

    final document = await uploadNotifier.uploadDocument();
    if (document == null) return;

    documentsNotifier.addDocument(document);

    uploadNotifier.setAnalyzing();
    _startTipRotation();

    final summary = await summaryNotifier.generateSummary(
      documentId: document.id,
    );

    _stopTipRotation();

    if (summary != null && mounted) {
      uploadNotifier.setComplete();
      ref.read(subscriptionProvider.notifier).refreshUsage();
      await Future.delayed(const Duration(milliseconds: 500));
      if (mounted) {
        context.go('/summary/${summary.id}');
      }
    }
  }

  void _showUpgradeDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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

class _StepData {
  final IconData icon;
  final String label;
  final bool isActive;
  final bool isCompleted;

  const _StepData({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.isCompleted,
  });
}
