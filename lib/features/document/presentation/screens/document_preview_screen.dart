import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:dio/dio.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/network/dio_client.dart';
import '../../../document/data/models/document_model.dart';
import '../../../summary/presentation/providers/summary_provider.dart';
import '../providers/document_provider.dart';

final _deviceIdProvider = FutureProvider<String?>((ref) async {
  const storage = FlutterSecureStorage();
  return storage.read(key: AppConstants.deviceIdKey);
});

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
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor:
          isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      appBar: AppBar(
        backgroundColor:
            isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
        leading: IconButton(
          icon: Icon(
            Iconsax.arrow_left,
            color: isDark ? AppColors.textLight : AppColors.textPrimary,
          ),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Document',
          style: TextStyle(
            color: isDark ? AppColors.textLight : AppColors.textPrimary,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Iconsax.trash,
              color: isDark ? AppColors.textLight : AppColors.textPrimary,
            ),
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

          return Column(
            children: [
              Expanded(
                child: _buildDocumentContent(context, ref, document, isDark),
              ),
              _buildBottomBar(context, ref, document, summaryState, isDark),
            ],
          );
        },
      ),
    );
  }

  Widget _buildDocumentContent(
    BuildContext context,
    WidgetRef ref,
    DocumentModel document,
    bool isDark,
  ) {
    final isImage = document.type == DocumentType.image;
    final isPdf = document.type == DocumentType.pdf;
    final hasFileUrl = document.fileUrl != null && document.fileUrl!.isNotEmpty;
    final hasPreview = document.previewUrl != null && document.previewUrl!.isNotEmpty;

    if (isPdf && hasFileUrl) {
      return _buildPdfViewer(context, ref, document, isDark);
    }

    if (hasPreview && (isImage || isPdf)) {
      return _buildImagePreview(context, ref, document, isDark);
    }

    return _buildTextPreview(context, document, isDark);
  }

  Widget _buildPdfViewer(
    BuildContext context,
    WidgetRef ref,
    DocumentModel document,
    bool isDark,
  ) {
    final deviceId = ref.watch(_deviceIdProvider).valueOrNull;
    if (deviceId == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Column(
      children: [
        _buildDocumentInfoBar(document, isDark),
        Expanded(
          child: FutureBuilder<Uint8List?>(
            future: _fetchPdfBytes(ref, document.fileUrl!, deviceId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 16),
                      Text('Loading PDF...'),
                    ],
                  ),
                );
              }
              final bytes = snapshot.data;
              if (snapshot.hasError || bytes == null || bytes.isEmpty) {
                return _buildPreviewErrorOrFallback(
                  context,
                  ref,
                  document,
                  isDark,
                );
              }
              return SfPdfViewer.memory(
                bytes,
                canShowScrollHead: true,
                canShowScrollStatus: true,
              );
            },
          ),
        ),
      ],
    );
  }

  Future<Uint8List?> _fetchPdfBytes(
    WidgetRef ref,
    String fileUrl,
    String deviceId,
  ) async {
    try {
      final dio = ref.read(dioClientProvider).dio;
      final response = await dio.get<Uint8List>(
        fileUrl,
        options: Options(
          responseType: ResponseType.bytes,
          headers: {'X-Device-ID': deviceId},
        ),
      );
      return response.data;
    } catch (_) {
      return null;
    }
  }

  Widget _buildImagePreview(
    BuildContext context,
    WidgetRef ref,
    DocumentModel document,
    bool isDark,
  ) {
    final deviceId = ref.watch(_deviceIdProvider).valueOrNull;

    return Column(
      children: [
        _buildDocumentInfoBar(document, isDark),
        Expanded(
          child: InteractiveViewer(
            minScale: 0.5,
            maxScale: 4.0,
            child: Container(
              width: double.infinity,
              color: isDark ? Colors.black : const Color(0xFFF0F0F0),
              child: CachedNetworkImage(
                imageUrl: document.previewUrl!,
                httpHeaders: {
                  if (deviceId != null) 'X-Device-ID': deviceId,
                },
                fit: BoxFit.contain,
                placeholder: (context, url) => const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 16),
                      Text('Loading document preview...'),
                    ],
                  ),
                ),
                errorWidget: (context, url, error) =>
                    _buildPreviewErrorOrFallback(context, ref, document, isDark),
              ),
            ),
          ),
        ),
        if (document.type == DocumentType.pdf && (document.pageCount) > 1)
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            color: isDark ? AppColors.cardDark : AppColors.surfaceLight,
            child: Center(
              child: Text(
                'Showing page 1 of ${document.pageCount}',
                style: TextStyle(
                  fontSize: 12,
                  color: isDark
                      ? AppColors.textTertiaryDark
                      : AppColors.textTertiary,
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildTextPreview(
    BuildContext context,
    DocumentModel document,
    bool isDark,
  ) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDocumentInfoCard(document, isDark),
          const SizedBox(height: 20),
          if (document.extractedText != null &&
              document.extractedText!.isNotEmpty) ...[
            Row(
              children: [
                Icon(
                  Iconsax.document_text,
                  size: 20,
                  color: isDark ? AppColors.textLight : AppColors.textPrimary,
                ),
                const SizedBox(width: 8),
                Text(
                  'Document Content',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: isDark ? AppColors.textLight : AppColors.textPrimary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDark ? AppColors.cardDark : AppColors.surfaceLight,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isDark ? AppColors.dividerDark : AppColors.divider,
                ),
              ),
              child: SelectableText(
                document.extractedText!,
                style: TextStyle(
                  fontSize: 14,
                  color: isDark
                      ? AppColors.textSecondaryDark
                      : AppColors.textSecondary,
                  height: 1.7,
                ),
              ),
            ),
          ] else
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Column(
                  children: [
                    Icon(
                      Iconsax.document_text,
                      size: 64,
                      color: isDark
                          ? AppColors.textTertiaryDark
                          : AppColors.textTertiary,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'No content extracted yet',
                      style: TextStyle(
                        fontSize: 16,
                        color: isDark
                            ? AppColors.textSecondaryDark
                            : AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildDocumentInfoBar(DocumentModel document, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: isDark ? AppColors.cardDark : AppColors.surfaceLight,
        border: Border(
          bottom: BorderSide(
            color: isDark ? AppColors.dividerDark : AppColors.divider,
          ),
        ),
      ),
      child: Row(
        children: [
          Icon(
            _getTypeIcon(document.type),
            size: 18,
            color: _getTypeColor(document.type),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              document.originalName,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: isDark ? AppColors.textLight : AppColors.textPrimary,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 8),
          _buildBadge(document.fileExtension, _getTypeColor(document.type)),
          const SizedBox(width: 6),
          _buildBadge(document.fileSizeFormatted,
              isDark ? AppColors.textTertiaryDark : AppColors.textTertiary),
        ],
      ),
    );
  }

  Widget _buildDocumentInfoCard(DocumentModel document, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.cardDark : AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? AppColors.dividerDark : AppColors.divider,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: _getTypeColor(document.type).withOpacity(0.1),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              _getTypeIcon(document.type),
              size: 26,
              color: _getTypeColor(document.type),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  document.originalName,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: isDark ? AppColors.textLight : AppColors.textPrimary,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    _buildBadge(
                        document.fileExtension, _getTypeColor(document.type)),
                    const SizedBox(width: 6),
                    _buildBadge(
                        document.fileSizeFormatted,
                        isDark
                            ? AppColors.textTertiaryDark
                            : AppColors.textTertiary),
                    const SizedBox(width: 6),
                    _buildBadge(
                        '${document.pageCount} pages',
                        isDark
                            ? AppColors.textTertiaryDark
                            : AppColors.textTertiary),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBadge(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: color,
        ),
      ),
    );
  }

  Widget _buildPreviewErrorOrFallback(
    BuildContext context,
    WidgetRef ref,
    DocumentModel document,
    bool isDark,
  ) {
    final hasText = document.extractedText != null &&
        document.extractedText!.trim().isNotEmpty;

    if (document.type == DocumentType.pdf && hasText) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildDocumentInfoBar(document, isDark),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Document content (preview image not available)',
                    style: TextStyle(
                      fontSize: 13,
                      color: isDark
                          ? AppColors.textTertiaryDark
                          : AppColors.textTertiary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isDark ? AppColors.cardDark : AppColors.surfaceLight,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isDark ? AppColors.dividerDark : AppColors.divider,
                      ),
                    ),
                    child: SelectableText(
                      document.extractedText!,
                      style: TextStyle(
                        fontSize: 14,
                        color: isDark
                            ? AppColors.textSecondaryDark
                            : AppColors.textSecondary,
                        height: 1.7,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Iconsax.image,
            size: 64,
            color: isDark ? AppColors.textTertiaryDark : AppColors.textTertiary,
          ),
          const SizedBox(height: 16),
          Text(
            'Preview not available',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            document.originalName,
            style: TextStyle(
              fontSize: 13,
              color: isDark ? AppColors.textTertiaryDark : AppColors.textTertiary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar(
    BuildContext context,
    WidgetRef ref,
    DocumentModel document,
    SummaryGenerationState summaryState,
    bool isDark,
  ) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
      decoration: BoxDecoration(
        color: isDark ? AppColors.cardDark : AppColors.surfaceLight,
        border: Border(
          top: BorderSide(
            color: isDark ? AppColors.dividerDark : AppColors.divider,
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: document.hasSummary
            ? SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton.icon(
                  onPressed: () =>
                      context.push('/summary/${document.summaryId}'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  icon: const Icon(Iconsax.document_text),
                  label: const Text(
                    'View Summary',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              )
            : SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton.icon(
                  onPressed: summaryState.isGenerating
                      ? null
                      : () => _generateSummary(context, ref),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    disabledBackgroundColor: AppColors.primary.withOpacity(0.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
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
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
      ),
    );
  }

  Color _getTypeColor(DocumentType type) {
    switch (type) {
      case DocumentType.pdf:
        return AppColors.pdfColor;
      case DocumentType.docx:
      case DocumentType.doc:
        return AppColors.docxColor;
      case DocumentType.image:
        return AppColors.imageColor;
    }
  }

  IconData _getTypeIcon(DocumentType type) {
    switch (type) {
      case DocumentType.pdf:
        return Iconsax.document_text;
      case DocumentType.docx:
      case DocumentType.doc:
        return Iconsax.document;
      case DocumentType.image:
        return Iconsax.image;
    }
  }

  Future<void> _generateSummary(BuildContext context, WidgetRef ref) async {
    final summaryNotifier = ref.read(summaryGenerationProvider.notifier);
    final summary =
        await summaryNotifier.generateSummary(documentId: documentId);

    if (summary != null && context.mounted) {
      context.go('/summary/${summary.id}');
    }
  }

  void _showDeleteDialog(BuildContext context, WidgetRef ref) {
    final screenContext = context;
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Delete Document'),
        content: const Text(
          'Are you sure you want to delete this document? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(dialogContext);
              await ref
                  .read(documentsProvider.notifier)
                  .deleteDocument(documentId);
              if (!screenContext.mounted) return;
              ScaffoldMessenger.of(screenContext).showSnackBar(
                SnackBar(
                  content: const Text('Document deleted'),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: AppColors.success,
                ),
              );
              screenContext.go('/home');
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
