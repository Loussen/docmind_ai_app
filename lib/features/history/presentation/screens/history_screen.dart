import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:animate_do/animate_do.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../document/presentation/providers/document_provider.dart';
import '../../../home/presentation/widgets/document_card.dart';

class HistoryScreen extends ConsumerStatefulWidget {
  const HistoryScreen({super.key});

  @override
  ConsumerState<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends ConsumerState<HistoryScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    // Delay provider modification until after the build phase
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      ref.read(documentsProvider.notifier).loadDocuments();
    }
  }

  Future<void> _loadData() async {
    await ref.read(documentsProvider.notifier).loadDocuments(refresh: true);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    final documentsState = ref.watch(documentsProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        surfaceTintColor: Colors.transparent,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(S.of(context)!.navHistory),
            if (documentsState.filterType != DocumentFilterType.all)
              Text(
                documentsState.filterType.label(context),
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                  color: isDark
                      ? AppColors.textSecondaryDark
                      : AppColors.textSecondary,
                ),
              ),
          ],
        ),
        actions: [
          if (documentsState.filterType != DocumentFilterType.all)
            IconButton(
              icon: const Icon(Iconsax.close_circle),
              onPressed: () {
                ref.read(documentsProvider.notifier).clearFilters();
              },
              tooltip: S.of(context)!.clearFilters,
            ),
          PopupMenuButton<DocumentFilterType>(
            icon: Icon(
              Iconsax.filter,
              color: documentsState.filterType != DocumentFilterType.all
                  ? colorScheme.primary
                  : null,
            ),
            color: colorScheme.surface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            onSelected: (value) {
              ref.read(documentsProvider.notifier).setFilter(value);
            },
            itemBuilder: (context) => DocumentFilterType.values.map((type) {
              final isSelected = documentsState.filterType == type;
              return PopupMenuItem(
                value: type,
                child: Row(
                  children: [
                    Icon(
                      _getFilterIcon(type),
                      size: 20,
                      color: isSelected
                          ? colorScheme.primary
                          : isDark
                              ? AppColors.textSecondaryDark
                              : AppColors.textSecondary,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      type.label(context),
                      style: TextStyle(
                        color: isSelected
                            ? colorScheme.primary
                            : colorScheme.onSurface,
                        fontWeight: isSelected ? FontWeight.w600 : null,
                      ),
                    ),
                    if (isSelected) ...[
                      const Spacer(),
                      Icon(
                        Iconsax.tick_circle5,
                        size: 18,
                        color: colorScheme.primary,
                      ),
                    ],
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _loadData,
        color: colorScheme.primary,
        child: documentsState.documents.isEmpty
            ? _buildEmptyState(documentsState.isLoading, isDark, colorScheme)
            : ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.all(24),
                itemCount: documentsState.documents.length +
                    (documentsState.hasMore ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index >= documentsState.documents.length) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }

                  final document = documentsState.documents[index];
                  return FadeInUp(
                    delay: Duration(milliseconds: (index < 5 ? index * 30 : 0)),
                    duration: const Duration(milliseconds: 250),
                    child: Dismissible(
                      key: Key(document.id),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 20),
                        margin: const EdgeInsets.only(bottom: 12),
                        decoration: BoxDecoration(
                          color: AppColors.error,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Icon(
                          Iconsax.trash,
                          color: Colors.white,
                        ),
                      ),
                      confirmDismiss: (direction) async {
                        return await _showDeleteConfirmation(context);
                      },
                      onDismissed: (direction) {
                        ref
                            .read(documentsProvider.notifier)
                            .deleteDocument(document.id);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(S.of(context)!.documentDeleted),
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            backgroundColor: AppColors.success,
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: DocumentCard(
                          document: document,
                          onTap: () {
                            if (document.hasSummary) {
                              context.push('/summary/${document.summaryId}');
                            } else {
                              context.push('/document/${document.id}');
                            }
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }

  Widget _buildEmptyState(
      bool isLoading, bool isDark, ColorScheme colorScheme) {
    final documentsState = ref.watch(documentsProvider);
    final hasFilter = documentsState.filterType != DocumentFilterType.all;

    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FadeIn(
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: colorScheme.primary.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  hasFilter ? Iconsax.filter_remove : Iconsax.document_text,
                  size: 60,
                  color: colorScheme.primary,
                ),
              ),
            ),
            const SizedBox(height: 24),
            FadeInUp(
              delay: const Duration(milliseconds: 100),
              child: Text(
                hasFilter
                    ? S.of(context)!.noDocumentsFiltered
                    : S.of(context)!.noDocumentsYet,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: colorScheme.onSurface,
                ),
              ),
            ),
            const SizedBox(height: 8),
            FadeInUp(
              delay: const Duration(milliseconds: 150),
              child: Text(
                hasFilter
                    ? S.of(context)!.tryRemovingFilters
                    : S.of(context)!.uploadFirstDoc,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: isDark
                      ? AppColors.textSecondaryDark
                      : AppColors.textSecondary,
                  height: 1.5,
                ),
              ),
            ),
            const SizedBox(height: 32),
            FadeInUp(
              delay: const Duration(milliseconds: 200),
              child: hasFilter
                  ? OutlinedButton.icon(
                      onPressed: () {
                        ref.read(documentsProvider.notifier).clearFilters();
                      },
                      icon: const Icon(Iconsax.filter_remove),
                      label: Text(S.of(context)!.clearFiltersButton),
                    )
                  : ElevatedButton.icon(
                      onPressed: () => context.push('/upload'),
                      icon: const Icon(Iconsax.add),
                      label: Text(S.of(context)!.uploadDocument),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> _showDeleteConfirmation(BuildContext context) async {
    final theme = Theme.of(context);

    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: theme.colorScheme.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          S.of(context)!.deleteDocument,
          style: TextStyle(color: theme.colorScheme.onSurface),
        ),
        content: Text(
          S.of(context)!.deleteDocumentConfirm,
          style: TextStyle(color: theme.colorScheme.onSurface.withOpacity(0.8)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(S.of(context)!.cancel),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
            ),
            child: Text(S.of(context)!.delete),
          ),
        ],
      ),
    );
    return result ?? false;
  }

  IconData _getFilterIcon(DocumentFilterType type) {
    switch (type) {
      case DocumentFilterType.all:
        return Iconsax.document;
      case DocumentFilterType.pdf:
        return Iconsax.document_text;
      case DocumentFilterType.docx:
        return Iconsax.document_1;
      case DocumentFilterType.image:
        return Iconsax.image;
    }
  }
}
