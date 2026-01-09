import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:animate_do/animate_do.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/theme/app_colors.dart';
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
    final documentsState = ref.watch(documentsProvider);

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        title: const Text('History'),
        actions: [
          if (documentsState.documents.isNotEmpty)
            PopupMenuButton<String>(
              icon: const Icon(Iconsax.filter),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              onSelected: (value) {
                // Handle filter
              },
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'all',
                  child: Text('All Documents'),
                ),
                const PopupMenuItem(
                  value: 'pdf',
                  child: Text('PDF Only'),
                ),
                const PopupMenuItem(
                  value: 'docx',
                  child: Text('Word Only'),
                ),
                const PopupMenuItem(
                  value: 'image',
                  child: Text('Images Only'),
                ),
              ],
            ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _loadData,
        color: AppColors.primary,
        child: documentsState.documents.isEmpty
            ? _buildEmptyState(documentsState.isLoading)
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
                    delay: Duration(milliseconds: index * 50),
                    duration: const Duration(milliseconds: 400),
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

  Widget _buildEmptyState(bool isLoading) {
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
                  color: AppColors.primary.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Iconsax.document_text,
                  size: 60,
                  color: AppColors.primary,
                ),
              ),
            ),
            const SizedBox(height: 24),
            FadeInUp(
              delay: const Duration(milliseconds: 200),
              child: const Text(
                'No documents yet',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            const SizedBox(height: 8),
            FadeInUp(
              delay: const Duration(milliseconds: 300),
              child: const Text(
                'Upload your first document and start\ngetting AI-powered summaries',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: AppColors.textSecondary,
                  height: 1.5,
                ),
              ),
            ),
            const SizedBox(height: 32),
            FadeInUp(
              delay: const Duration(milliseconds: 400),
              child: ElevatedButton.icon(
                onPressed: () => context.push('/upload'),
                icon: const Icon(Iconsax.add),
                label: const Text('Upload Document'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> _showDeleteConfirmation(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Delete Document'),
        content: const Text(
          'Are you sure you want to delete this document?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    return result ?? false;
  }
}

