import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:animate_do/animate_do.dart';
import 'package:iconsax/iconsax.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/i18n/language_options.dart';
import '../../../../l10n/app_localizations.dart';
import '../providers/summary_provider.dart';
import '../../data/models/summary_model.dart';
import '../../../subscription/presentation/providers/subscription_provider.dart';
import '../../data/repositories/summary_repository.dart';

class SummaryScreen extends ConsumerWidget {
  final String summaryId;

  const SummaryScreen({
    super.key,
    required this.summaryId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summaryAsync = ref.watch(summaryProvider(summaryId));
    final translated = ref.watch(translatedSummaryProvider(summaryId));
    final isTranslating = ref.watch(isTranslatingProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return PopScope(
      canPop: !isTranslating,
      child: Stack(
        children: [
          Scaffold(
            backgroundColor:
                isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
            appBar: AppBar(
              backgroundColor:
                  isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
              surfaceTintColor: Colors.transparent,
              leading: IconButton(
                icon: Icon(
                  Iconsax.arrow_left,
                  color: isDark ? AppColors.textLight : AppColors.textPrimary,
                ),
                onPressed: isTranslating ? null : () => context.go('/home'),
              ),
              title: Text(
                S.of(context)!.summary,
                style: TextStyle(
                  color: isDark ? AppColors.textLight : AppColors.textPrimary,
                ),
              ),
              actions: [
                summaryAsync.when(
                  data: (summary) {
                    final displayed = translated ?? summary;
                    if (displayed == null) return const SizedBox.shrink();
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(
                            Iconsax.translate,
                            color: isDark
                                ? AppColors.textLight
                                : AppColors.textPrimary,
                          ),
                          onPressed: isTranslating
                              ? null
                              : () async {
                                  final isPremium =
                                      ref.read(effectiveIsPremiumProvider);
                                  final isProPlus =
                                      ref.read(effectiveIsProPlusProvider);
                                  if (!isPremium && !isProPlus) {
                                    _showUpgradeForTranslate(context);
                                    return;
                                  }
                                  final repo =
                                      ref.read(summaryRepositoryProvider);
                                  final translatedNotifier = ref.read(
                                      translatedSummaryProvider(summaryId)
                                          .notifier);
                                  final translatingNotifier =
                                      ref.read(isTranslatingProvider.notifier);

                                  final picked = await _pickOutputLanguage(
                                      context, isDark);
                                  if (picked == null) return;

                                  translatingNotifier.state = true;

                                  final result = await repo.translateSummary(
                                    summaryId: summaryId,
                                    targetLanguage: picked,
                                  );

                                  translatingNotifier.state = false;

                                  result.fold(
                                    (err) => ScaffoldMessenger.of(context)
                                        .showSnackBar(
                                      SnackBar(
                                        content: Text(err),
                                        backgroundColor: AppColors.error,
                                        behavior: SnackBarBehavior.floating,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                    ),
                                    (s) {
                                      translatedNotifier.state = s;
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(S
                                              .of(context)!
                                              .translationComplete),
                                          backgroundColor: AppColors.success,
                                          behavior: SnackBarBehavior.floating,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                        ),
                        IconButton(
                          icon: Icon(
                            Iconsax.share,
                            color: isDark
                                ? AppColors.textLight
                                : AppColors.textPrimary,
                          ),
                          onPressed: isTranslating
                              ? null
                              : () => _shareSummary(context, displayed),
                        ),
                      ],
                    );
                  },
                  loading: () => const SizedBox.shrink(),
                  error: (_, __) => const SizedBox.shrink(),
                ),
              ],
            ),
            body: summaryAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Iconsax.warning_2,
                        size: 64, color: AppColors.error),
                    const SizedBox(height: 16),
                    Text(
                      S.of(context)!.failedToLoadSummary,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 8),
                    TextButton(
                      onPressed: () => ref.refresh(summaryProvider(summaryId)),
                      child: Text(S.of(context)!.tryAgain),
                    ),
                  ],
                ),
              ),
              data: (original) {
                final summary = translated ?? original;
                if (summary == null) {
                  return Center(child: Text(S.of(context)!.summaryNotFound));
                }

                return SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title Section
                      FadeInDown(
                        duration: const Duration(milliseconds: 300),
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            gradient: AppColors.primaryGradient,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primary.withOpacity(0.3),
                                blurRadius: 20,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Iconsax.document_text5,
                                    color: Colors.white,
                                    size: 28,
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      summary.title,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: [
                                  _buildStatChip(
                                    S
                                        .of(context)!
                                        .wordsCount(summary.wordCount),
                                    Iconsax.text,
                                  ),
                                  _buildStatChip(
                                    S.of(context)!.processingTime(
                                          (summary.processingTimeMs / 1000)
                                              .toStringAsFixed(1),
                                        ),
                                    Iconsax.timer_1,
                                  ),
                                  if (original != null)
                                    _buildStatChip(
                                      languageName(original.language),
                                      Iconsax.language_circle,
                                    ),
                                  if (translated != null)
                                    _buildStatChip(
                                      S.of(context)!.translatedTo(
                                            languageName(translated.language),
                                          ),
                                      Iconsax.translate,
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Overview Section
                      FadeInUp(
                        delay: const Duration(milliseconds: 50),
                        duration: const Duration(milliseconds: 300),
                        child: _buildSection(
                          context,
                          title: S.of(context)!.overview,
                          icon: Iconsax.note_215,
                          color: AppColors.primary,
                          child: Text(
                            summary.overview,
                            style: TextStyle(
                              fontSize: 15,
                              color: isDark
                                  ? AppColors.textSecondaryDark
                                  : AppColors.textSecondary,
                              height: 1.6,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Key Points Section
                      FadeInUp(
                        delay: const Duration(milliseconds: 100),
                        duration: const Duration(milliseconds: 300),
                        child: _buildSection(
                          context,
                          title: S.of(context)!.keyPoints,
                          icon: Iconsax.task_square,
                          color: AppColors.accent,
                          child: Column(
                            children:
                                summary.keyPoints.asMap().entries.map((entry) {
                              return _buildBulletPoint(
                                  context, entry.value, entry.key);
                            }).toList(),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Action Items Section
                      if (summary.actionItems.isNotEmpty)
                        FadeInUp(
                          delay: const Duration(milliseconds: 150),
                          duration: const Duration(milliseconds: 300),
                          child: _buildSection(
                            context,
                            title: S.of(context)!.actionItems,
                            icon: Iconsax.tick_square,
                            color: AppColors.secondary,
                            child: Column(
                              children: summary.actionItems
                                  .asMap()
                                  .entries
                                  .map((entry) {
                                return _buildActionItem(
                                    context, entry.value, entry.key);
                              }).toList(),
                            ),
                          ),
                        ),

                      if (summary.actionItems.isNotEmpty)
                        const SizedBox(height: 20),

                      // Keywords Section
                      if (summary.keywords.isNotEmpty)
                        FadeInUp(
                          delay: const Duration(milliseconds: 200),
                          duration: const Duration(milliseconds: 300),
                          child: _buildSection(
                            context,
                            title: S.of(context)!.keywords,
                            icon: Iconsax.tag,
                            color: AppColors.info,
                            child: Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: summary.keywords.map((keyword) {
                                return Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 14,
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.info.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    keyword,
                                    style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.info,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),

                      // Important Facts (if contract)
                      if (summary.importantFacts != null) ...[
                        const SizedBox(height: 20),
                        FadeInUp(
                          delay: const Duration(milliseconds: 250),
                          duration: const Duration(milliseconds: 300),
                          child: _buildSection(
                            context,
                            title: S.of(context)!.importantFacts,
                            icon: Iconsax.warning_2,
                            color: AppColors.warning,
                            child: Text(
                              summary.importantFacts!,
                              style: const TextStyle(
                                fontSize: 15,
                                color: AppColors.textSecondary,
                                height: 1.6,
                              ),
                            ),
                          ),
                        ),
                      ],

                      // Obligations (if contract)
                      if (summary.obligations != null) ...[
                        const SizedBox(height: 20),
                        FadeInUp(
                          delay: const Duration(milliseconds: 300),
                          duration: const Duration(milliseconds: 300),
                          child: _buildSection(
                            context,
                            title: S.of(context)!.obligations,
                            icon: Iconsax.shield_tick,
                            color: AppColors.success,
                            child: Text(
                              summary.obligations!,
                              style: const TextStyle(
                                fontSize: 15,
                                color: AppColors.textSecondary,
                                height: 1.6,
                              ),
                            ),
                          ),
                        ),
                      ],

                      // Risks (if contract)
                      if (summary.risks != null) ...[
                        const SizedBox(height: 20),
                        FadeInUp(
                          delay: const Duration(milliseconds: 350),
                          duration: const Duration(milliseconds: 300),
                          child: _buildSection(
                            context,
                            title: S.of(context)!.risks,
                            icon: Iconsax.danger,
                            color: AppColors.error,
                            child: Text(
                              summary.risks!,
                              style: const TextStyle(
                                fontSize: 15,
                                color: AppColors.textSecondary,
                                height: 1.6,
                              ),
                            ),
                          ),
                        ),
                      ],

                      const SizedBox(height: 24),

                      // View Original Document Button
                      FadeInUp(
                        delay: const Duration(milliseconds: 350),
                        child: SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: ElevatedButton.icon(
                            onPressed: () =>
                                context.push('/document/${summary.documentId}'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            icon: const Icon(Iconsax.eye),
                            label: Text(
                              S.of(context)!.viewOriginalDocument,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 12),

                      // Copy to Clipboard Button
                      FadeInUp(
                        delay: const Duration(milliseconds: 400),
                        child: SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: OutlinedButton.icon(
                            onPressed: () =>
                                _copySummary(context, summary.overview),
                            icon: const Icon(Iconsax.copy),
                            label: Text(S.of(context)!.copySummary),
                          ),
                        ),
                      ),

                      const SizedBox(height: 32),
                    ],
                  ),
                );
              },
            ),
          ),
          if (isTranslating)
            Container(
              color: Colors.black.withValues(alpha: 0.6),
              child: Center(
                child: Container(
                  width: 220,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 28, vertical: 32),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: isDark
                          ? [const Color(0xFF1E1E2E), const Color(0xFF2A2A3E)]
                          : [Colors.white, const Color(0xFFF5F3FF)],
                    ),
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.25),
                        blurRadius: 30,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 64,
                        height: 64,
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(16),
                          child: CircularProgressIndicator(
                            strokeWidth: 3,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Icon(
                        Iconsax.translate,
                        color: AppColors.primary,
                        size: 24,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        S.of(context)!.translating,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: isDark
                              ? AppColors.textLight
                              : AppColors.textPrimary,
                          decoration: TextDecoration.none,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        S.of(context)!.aiTranslatingYourSummary,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 13,
                          color: isDark
                              ? AppColors.textSecondaryDark
                              : AppColors.textSecondary,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildStatChip(String label, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: Colors.white),
          const SizedBox(width: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Color color,
    required Widget child,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? AppColors.cardDark : AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
            color: isDark ? AppColors.dividerDark : AppColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: color.withOpacity(isDark ? 0.2 : 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, size: 18, color: color),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: isDark ? AppColors.textLight : AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }

  Widget _buildBulletPoint(BuildContext context, String text, int index) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 6),
            width: 6,
            height: 6,
            decoration: const BoxDecoration(
              color: AppColors.accent,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 15,
                color: isDark
                    ? AppColors.textSecondaryDark
                    : AppColors.textSecondary,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionItem(BuildContext context, String text, int index) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 2),
            width: 22,
            height: 22,
            decoration: BoxDecoration(
              color: AppColors.secondary.withOpacity(isDark ? 0.2 : 0.1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Center(
              child: Text(
                '${index + 1}',
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: AppColors.secondary,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 15,
                color: isDark
                    ? AppColors.textSecondaryDark
                    : AppColors.textSecondary,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _copySummary(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(S.of(context)!.summaryCopied),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: AppColors.success,
      ),
    );
  }

  void _shareSummary(BuildContext context, SummaryModel summary) {
    final StringBuffer shareText = StringBuffer();

    // Header
    shareText.writeln('📄 ${summary.title}');
    shareText.writeln('');
    final l = S.of(context)!;
    shareText.writeln(l.generatedBy);
    shareText.writeln('');

    shareText.writeln('📋 ${l.overview.toUpperCase()}');
    shareText.writeln('─' * 40);
    shareText.writeln(summary.overview);
    shareText.writeln('');

    if (summary.keyPoints.isNotEmpty) {
      shareText.writeln('🔑 ${l.keyPoints.toUpperCase()}');
      shareText.writeln('─' * 40);
      for (int i = 0; i < summary.keyPoints.length; i++) {
        shareText.writeln('${i + 1}. ${summary.keyPoints[i]}');
      }
      shareText.writeln('');
    }

    if (summary.actionItems.isNotEmpty) {
      shareText.writeln('✅ ${l.actionItems.toUpperCase()}');
      shareText.writeln('─' * 40);
      for (int i = 0; i < summary.actionItems.length; i++) {
        shareText.writeln('${i + 1}. ${summary.actionItems[i]}');
      }
      shareText.writeln('');
    }

    if (summary.importantFacts != null && summary.importantFacts!.isNotEmpty) {
      shareText.writeln('💡 ${l.importantFacts.toUpperCase()}');
      shareText.writeln('─' * 40);
      shareText.writeln(summary.importantFacts!);
      shareText.writeln('');
    }

    if (summary.obligations != null && summary.obligations!.isNotEmpty) {
      shareText.writeln('📜 ${l.obligations.toUpperCase()}');
      shareText.writeln('─' * 40);
      shareText.writeln(summary.obligations!);
      shareText.writeln('');
    }

    if (summary.risks != null && summary.risks!.isNotEmpty) {
      shareText.writeln('⚠️ ${l.risks.toUpperCase()}');
      shareText.writeln('─' * 40);
      shareText.writeln(summary.risks!);
      shareText.writeln('');
    }

    if (summary.keywords.isNotEmpty) {
      shareText.writeln('🏷️ ${l.keywords.toUpperCase()}');
      shareText.writeln('─' * 40);
      shareText.writeln(summary.keywords.join(', '));
      shareText.writeln('');
    }

    shareText.writeln('─' * 40);
    shareText.writeln(l.wordCountLabel(summary.wordCount));
    shareText.writeln(l.processingTimeLabel(
        (summary.processingTimeMs / 1000).toStringAsFixed(1)));
    shareText.writeln('');
    shareText
        .writeln(l.generatedOn(summary.createdAt.toString().split(' ')[0]));
    shareText.writeln('');
    shareText.writeln('📱 DoCMind AI - ${l.appTagline}');

    // Share - iPad requires sharePositionOrigin for the popover
    final box = context.findRenderObject() as RenderBox?;
    Share.share(
      shareText.toString(),
      subject: summary.title,
      sharePositionOrigin: box != null
          ? box.localToGlobal(Offset.zero) & box.size
          : const Rect.fromLTWH(0, 0, 100, 100),
    );
  }

  Future<String?> _pickOutputLanguage(BuildContext context, bool isDark) async {
    return await showModalBottomSheet<String>(
      context: context,
      backgroundColor: isDark ? AppColors.cardDark : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: isDark ? AppColors.dividerDark : AppColors.divider,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              S.of(context)!.summaryLang,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: isDark ? AppColors.textLight : AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Flexible(
              child: ListView(
                shrinkWrap: true,
                children: outputLanguages
                    .map(
                      (l) => ListTile(
                        leading:
                            Text(l.flag, style: const TextStyle(fontSize: 28)),
                        title: Text(
                          l.name,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: isDark
                                ? AppColors.textLight
                                : AppColors.textPrimary,
                          ),
                        ),
                        onTap: () => Navigator.pop(ctx, l.code),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showUpgradeForTranslate(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(S.of(context)!.upgradeRequired),
        content: Text(S.of(context)!.translateProOnly),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(S.of(context)!.notNow),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              context.push('/subscription');
            },
            child: Text(S.of(context)!.upgrade),
          ),
        ],
      ),
    );
  }
}
