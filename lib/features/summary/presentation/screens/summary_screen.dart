import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:animate_do/animate_do.dart';
import 'package:iconsax/iconsax.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../core/theme/app_colors.dart';
import '../providers/summary_provider.dart';
import '../../data/models/summary_model.dart';

class SummaryScreen extends ConsumerWidget {
  final String summaryId;

  const SummaryScreen({
    super.key,
    required this.summaryId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summaryAsync = ref.watch(summaryProvider(summaryId));
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      appBar: AppBar(
        backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
        leading: IconButton(
          icon: Icon(
            Iconsax.arrow_left,
            color: isDark ? AppColors.textLight : AppColors.textPrimary,
          ),
          onPressed: () => context.go('/home'),
        ),
        title: Text(
          'Summary',
          style: TextStyle(
            color: isDark ? AppColors.textLight : AppColors.textPrimary,
          ),
        ),
        actions: [
          summaryAsync.when(
            data: (summary) => summary != null
                ? IconButton(
                    icon: Icon(
                      Iconsax.share,
                      color: isDark ? AppColors.textLight : AppColors.textPrimary,
                    ),
                    onPressed: () => _shareSummary(context, summary),
                  )
                : const SizedBox.shrink(),
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
              const Icon(Iconsax.warning_2, size: 64, color: AppColors.error),
              const SizedBox(height: 16),
              Text(
                'Failed to load summary',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () => ref.refresh(summaryProvider(summaryId)),
                child: const Text('Try Again'),
              ),
            ],
          ),
        ),
        data: (summary) {
          if (summary == null) {
            return const Center(child: Text('Summary not found'));
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title Section
                FadeInDown(
                  duration: const Duration(milliseconds: 500),
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
                        Row(
                          children: [
                            _buildStatChip(
                              '${summary.wordCount} words',
                              Iconsax.text,
                            ),
                            const SizedBox(width: 8),
                            _buildStatChip(
                              '${(summary.processingTimeMs / 1000).toStringAsFixed(1)}s',
                              Iconsax.timer_1,
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
                  delay: const Duration(milliseconds: 100),
                  duration: const Duration(milliseconds: 500),
                  child: _buildSection(
                    context,
                    title: 'Overview',
                    icon: Iconsax.note_215,
                    color: AppColors.primary,
                    child: Text(
                      summary.overview,
                      style: TextStyle(
                        fontSize: 15,
                        color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
                        height: 1.6,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Key Points Section
                FadeInUp(
                  delay: const Duration(milliseconds: 200),
                  duration: const Duration(milliseconds: 500),
                  child: _buildSection(
                    context,
                    title: 'Key Points',
                    icon: Iconsax.task_square,
                    color: AppColors.accent,
                    child: Column(
                      children: summary.keyPoints.asMap().entries.map((entry) {
                        return _buildBulletPoint(context, entry.value, entry.key);
                      }).toList(),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Action Items Section
                if (summary.actionItems.isNotEmpty)
                  FadeInUp(
                    delay: const Duration(milliseconds: 300),
                    duration: const Duration(milliseconds: 500),
                    child: _buildSection(
                      context,
                      title: 'Action Items',
                      icon: Iconsax.tick_square,
                      color: AppColors.secondary,
                      child: Column(
                        children:
                            summary.actionItems.asMap().entries.map((entry) {
                          return _buildActionItem(context, entry.value, entry.key);
                        }).toList(),
                      ),
                    ),
                  ),

                if (summary.actionItems.isNotEmpty) const SizedBox(height: 20),

                // Keywords Section
                if (summary.keywords.isNotEmpty)
                  FadeInUp(
                    delay: const Duration(milliseconds: 400),
                    duration: const Duration(milliseconds: 500),
                    child: _buildSection(
                      context,
                      title: 'Keywords',
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
                    delay: const Duration(milliseconds: 500),
                    duration: const Duration(milliseconds: 500),
                    child: _buildSection(
                      context,
                      title: 'Important Facts',
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
                    delay: const Duration(milliseconds: 600),
                    duration: const Duration(milliseconds: 500),
                    child: _buildSection(
                      context,
                      title: 'Obligations',
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
                    delay: const Duration(milliseconds: 700),
                    duration: const Duration(milliseconds: 500),
                    child: _buildSection(
                      context,
                      title: 'Risks',
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

                const SizedBox(height: 32),

                // Copy to Clipboard Button
                FadeInUp(
                  delay: const Duration(milliseconds: 800),
                  child: SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: OutlinedButton.icon(
                      onPressed: () => _copySummary(context, summary.overview),
                      icon: const Icon(Iconsax.copy),
                      label: const Text('Copy Summary'),
                    ),
                  ),
                ),

                const SizedBox(height: 32),
              ],
            ),
          );
        },
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
        border: Border.all(color: isDark ? AppColors.dividerDark : AppColors.divider),
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
                color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
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
                color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
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
        content: const Text('Summary copied to clipboard'),
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
    shareText.writeln('Generated by DocMind AI');
    shareText.writeln('');
    
    // Overview
    shareText.writeln('📋 OVERVIEW');
    shareText.writeln('─' * 40);
    shareText.writeln(summary.overview);
    shareText.writeln('');
    
    // Key Points
    if (summary.keyPoints.isNotEmpty) {
      shareText.writeln('🔑 KEY POINTS');
      shareText.writeln('─' * 40);
      for (int i = 0; i < summary.keyPoints.length; i++) {
        shareText.writeln('${i + 1}. ${summary.keyPoints[i]}');
      }
      shareText.writeln('');
    }
    
    // Action Items
    if (summary.actionItems.isNotEmpty) {
      shareText.writeln('✅ ACTION ITEMS');
      shareText.writeln('─' * 40);
      for (int i = 0; i < summary.actionItems.length; i++) {
        shareText.writeln('${i + 1}. ${summary.actionItems[i]}');
      }
      shareText.writeln('');
    }
    
    // Important Facts
    if (summary.importantFacts != null && summary.importantFacts!.isNotEmpty) {
      shareText.writeln('💡 IMPORTANT FACTS');
      shareText.writeln('─' * 40);
      shareText.writeln(summary.importantFacts!);
      shareText.writeln('');
    }
    
    // Obligations
    if (summary.obligations != null && summary.obligations!.isNotEmpty) {
      shareText.writeln('📜 OBLIGATIONS');
      shareText.writeln('─' * 40);
      shareText.writeln(summary.obligations!);
      shareText.writeln('');
    }
    
    // Risks
    if (summary.risks != null && summary.risks!.isNotEmpty) {
      shareText.writeln('⚠️ RISKS');
      shareText.writeln('─' * 40);
      shareText.writeln(summary.risks!);
      shareText.writeln('');
    }
    
    // Keywords
    if (summary.keywords.isNotEmpty) {
      shareText.writeln('🏷️ KEYWORDS');
      shareText.writeln('─' * 40);
      shareText.writeln(summary.keywords.join(', '));
      shareText.writeln('');
    }
    
    // Footer
    shareText.writeln('─' * 40);
    shareText.writeln('Word count: ${summary.wordCount}');
    shareText.writeln('Processing time: ${(summary.processingTimeMs / 1000).toStringAsFixed(1)}s');
    shareText.writeln('');
    shareText.writeln('Generated on ${summary.createdAt.toString().split(' ')[0]}');
    shareText.writeln('');
    shareText.writeln('📱 DocMind AI - Smart Document Summarizer');
    
    // Share
    Share.share(
      shareText.toString(),
      subject: summary.title,
    );
  }
}

