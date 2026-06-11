import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../document/data/models/document_model.dart';

final _deviceIdProvider = FutureProvider<String?>((ref) async {
  const storage = FlutterSecureStorage();
  return storage.read(key: AppConstants.deviceIdKey);
});

class DocumentCard extends ConsumerWidget {
  final DocumentModel document;
  final VoidCallback onTap;
  final VoidCallback? onDelete;

  const DocumentCard({
    super.key,
    required this.document,
    required this.onTap,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        constraints: const BoxConstraints(minHeight: 88),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isDark ? AppColors.dividerDark : AppColors.divider,
          ),
          boxShadow: [
            BoxShadow(
              color: isDark ? AppColors.shadowDark : AppColors.shadowLight,
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: IntrinsicHeight(
          child: Row(
            children: [
              _buildPreview(isDark, ref),
              const SizedBox(width: 12),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      document.originalName,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: theme.colorScheme.onSurface,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        _buildTypeBadge(),
                        const SizedBox(width: 8),
                        Text(
                          document.fileSizeFormatted,
                          style: TextStyle(
                            fontSize: 11,
                            color: isDark
                                ? AppColors.textTertiaryDark
                                : AppColors.textTertiary,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${document.pageCount} pg',
                          style: TextStyle(
                            fontSize: 11,
                            color: isDark
                                ? AppColors.textTertiaryDark
                                : AppColors.textTertiary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _formatDate(document.createdAt),
                      style: TextStyle(
                        fontSize: 11,
                        color: isDark
                            ? AppColors.textTertiaryDark
                            : AppColors.textTertiary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: _buildStatusIndicator(isDark, theme.colorScheme),
            ),
          ],
          ),
        ),
      ),
    );
  }

  Widget _buildPreview(bool isDark, WidgetRef ref) {
    final hasPreview = document.previewUrl != null && document.previewUrl!.isNotEmpty;
    final isImage = document.type == DocumentType.image;

    if (hasPreview && (isImage || document.type == DocumentType.pdf)) {
      final deviceIdAsync = ref.watch(_deviceIdProvider);
      final deviceId = deviceIdAsync.valueOrNull;

      return ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(15),
          bottomLeft: Radius.circular(15),
        ),
        child: SizedBox(
          width: 72,
          child: deviceIdAsync.isLoading || deviceId == null
              ? Container(
                  color: _getTypeColor().withOpacity(0.08),
                  child: Center(
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          _getTypeColor().withOpacity(0.5),
                        ),
                      ),
                    ),
                  ),
                )
              : CachedNetworkImage(
                  imageUrl: document.previewUrl!,
                  httpHeaders: {'X-Device-ID': deviceId},
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    color: _getTypeColor().withOpacity(0.08),
                    child: Center(
                      child: SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            _getTypeColor().withOpacity(0.5),
                          ),
                        ),
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) =>
                      _buildFallbackPreview(isDark),
                ),
        ),
      );
    }

    return _buildFallbackPreview(isDark);
  }

  Widget _buildFallbackPreview(bool isDark) {
    return Container(
      width: 72,
      decoration: BoxDecoration(
        color: _getTypeColor().withOpacity(isDark ? 0.15 : 0.08),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(15),
          bottomLeft: Radius.circular(15),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            _getTypeIcon(),
            color: _getTypeColor(),
            size: 28,
          ),
          const SizedBox(height: 4),
          Text(
            document.fileExtension,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: _getTypeColor(),
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTypeBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: _getTypeColor().withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        document.fileExtension,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: _getTypeColor(),
        ),
      ),
    );
  }

  Widget _buildStatusIndicator(bool isDark, ColorScheme colorScheme) {
    if (document.isProcessing) {
      return SizedBox(
        width: 24,
        height: 24,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(colorScheme.primary),
        ),
      );
    }

    if (document.hasFailed) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: AppColors.errorLight,
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Text(
          'Failed',
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: AppColors.error,
          ),
        ),
      );
    }

    if (document.hasSummary) {
      return Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: AppColors.successLight,
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Icon(
          Iconsax.tick_circle5,
          color: AppColors.success,
          size: 16,
        ),
      );
    }

    return Icon(
      Iconsax.arrow_right_3,
      color: isDark ? AppColors.textTertiaryDark : AppColors.textTertiary,
      size: 20,
    );
  }

  Color _getTypeColor() {
    switch (document.type) {
      case DocumentType.pdf:
        return AppColors.pdfColor;
      case DocumentType.docx:
      case DocumentType.doc:
        return AppColors.docxColor;
      case DocumentType.image:
        return AppColors.imageColor;
    }
  }

  IconData _getTypeIcon() {
    switch (document.type) {
      case DocumentType.pdf:
        return Iconsax.document_text;
      case DocumentType.docx:
      case DocumentType.doc:
        return Iconsax.document;
      case DocumentType.image:
        return Iconsax.image;
    }
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      if (difference.inHours == 0) {
        return '${difference.inMinutes} min ago';
      }
      return '${difference.inHours}h ago';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    }

    return DateFormat('MMM d, yyyy').format(date);
  }
}
