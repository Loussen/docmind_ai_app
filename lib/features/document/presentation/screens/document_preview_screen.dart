import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../summary/presentation/providers/summary_provider.dart';
import '../providers/document_provider.dart';

class DocumentPreviewScreen extends ConsumerWidget {
  final String documentId;

  const DocumentPreviewScreen({
    super.key,
    required this.documentId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final documentAsync = ref.watch(documentProvider(documentId));
    final summaryState = ref.watch(summaryGenerationProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left),
          onPressed: () => context.pop(),
        ),
        title: const Text('Document'),
        actions: [
          IconButton(
            icon: const Icon(Iconsax.trash),
            onPressed: () => _showDeleteDialog(context, ref),
          ),
        ],
      ),
      body: documentAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Iconsax.warning_2, size: 64, color: AppColors.error),
              const SizedBox(height: 16),
              Text(
                'Failed to load document',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () => ref.refresh(documentProvider(documentId)),
                child: const Text('Try Again'),
              ),
            ],
          ),
        ),
        data: (document) {
          if (document == null) {
            return const Center(child: Text('Document not found'));
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Document Info Card
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceLight,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.divider),
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Icon(
                          Iconsax.document_text5,
                          size: 40,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        document.originalName,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildInfoChip(
                            document.fileExtension,
                            AppColors.primary,
                          ),
                          const SizedBox(width: 8),
                          _buildInfoChip(
                            document.fileSizeFormatted,
                            AppColors.textTertiary,
                          ),
                          const SizedBox(width: 8),
                          _buildInfoChip(
                            '${document.pageCount} pages',
                            AppColors.textTertiary,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Extracted Text Section
                if (document.extractedText != null) ...[
                  const Text(
                    'Extracted Text',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.inputBackground,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      document.extractedText!.length > 500
                          ? '${document.extractedText!.substring(0, 500)}...'
                          : document.extractedText!,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                        height: 1.6,
                      ),
                    ),
                  ),
                ],

                const SizedBox(height: 32),

                // Generate Summary Button
                if (!document.hasSummary)
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton.icon(
                      onPressed: summaryState.isGenerating
                          ? null
                          : () => _generateSummary(context, ref),
                      icon: summaryState.isGenerating
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                          : const Icon(Iconsax.magic_star),
                      label: Text(
                        summaryState.isGenerating
                            ? 'Generating...'
                            : 'Generate AI Summary',
                      ),
                    ),
                  )
                else
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton.icon(
                      onPressed: () =>
                          context.push('/summary/${document.summaryId}'),
                      icon: const Icon(Iconsax.document_text),
                      label: const Text('View Summary'),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoChip(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: color,
        ),
      ),
    );
  }

  Future<void> _generateSummary(BuildContext context, WidgetRef ref) async {
    final summaryNotifier = ref.read(summaryGenerationProvider.notifier);
    final summary = await summaryNotifier.generateSummary(documentId: documentId);

    if (summary != null && context.mounted) {
      context.go('/summary/${summary.id}');
    }
  }

  void _showDeleteDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Delete Document'),
        content: const Text(
          'Are you sure you want to delete this document? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
              await ref.read(documentsProvider.notifier).deleteDocument(documentId);
              if (context.mounted) {
                context.go('/home');
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}

