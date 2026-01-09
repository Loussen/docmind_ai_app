import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:animate_do/animate_do.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../document/presentation/providers/document_provider.dart';
import '../../../subscription/presentation/providers/subscription_provider.dart';
import '../widgets/document_card.dart';
import '../widgets/usage_card.dart';
import '../widgets/quick_action_card.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Delay provider modification until after the build phase
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
    });
  }

  Future<void> _loadData() async {
    await Future.wait([
      ref.read(documentsProvider.notifier).loadDocuments(refresh: true),
      ref.read(subscriptionProvider.notifier).loadSubscriptionData(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(currentUserProvider);
    final documentsState = ref.watch(documentsProvider);
    final subscriptionState = ref.watch(subscriptionProvider);
    final recentDocs = ref.watch(recentDocumentsProvider);

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _loadData,
        color: AppColors.primary,
        child: CustomScrollView(
          slivers: [
            // App Bar
            SliverAppBar(
              expandedHeight: 120,
              floating: false,
              pinned: true,
              backgroundColor: AppColors.backgroundLight,
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: const EdgeInsets.only(left: 24, bottom: 16),
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hello, ${user?.name ?? 'there'}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    const Text(
                      'DocMind AI',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: GestureDetector(
                    onTap: () => context.push('/subscription'),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: subscriptionState.isPremium
                            ? AppColors.accent.withOpacity(0.1)
                            : AppColors.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            subscriptionState.isPremium
                                ? Iconsax.crown5
                                : Iconsax.crown,
                            size: 18,
                            color: subscriptionState.isPremium
                                ? AppColors.accent
                                : AppColors.primary,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            subscriptionState.isPremium ? 'Pro' : 'Free',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: subscriptionState.isPremium
                                  ? AppColors.accent
                                  : AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Content
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Usage Card
                    FadeInUp(
                      duration: const Duration(milliseconds: 500),
                      child: UsageCard(
                        usage: subscriptionState.usage,
                        isPremium: subscriptionState.isPremium,
                        onUpgrade: () => context.push('/subscription'),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Quick Actions
                    FadeInUp(
                      delay: const Duration(milliseconds: 100),
                      duration: const Duration(milliseconds: 500),
                      child: const Text(
                        'Quick Actions',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    FadeInUp(
                      delay: const Duration(milliseconds: 200),
                      duration: const Duration(milliseconds: 500),
                      child: Row(
                        children: [
                          Expanded(
                            child: QuickActionCard(
                              icon: Iconsax.document_upload,
                              title: 'Upload',
                              subtitle: 'PDF, DOCX, Image',
                              color: AppColors.primary,
                              onTap: () => context.push('/upload'),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: QuickActionCard(
                              icon: Iconsax.clock,
                              title: 'History',
                              subtitle: 'View all docs',
                              color: AppColors.secondary,
                              onTap: () => context.go('/history'),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 32),

                    // Recent Documents
                    FadeInUp(
                      delay: const Duration(milliseconds: 300),
                      duration: const Duration(milliseconds: 500),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Recent Documents',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          if (documentsState.documents.isNotEmpty)
                            TextButton(
                              onPressed: () => context.go('/history'),
                              child: const Text('See All'),
                            ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Documents List or Empty State
                    if (documentsState.isLoading &&
                        documentsState.documents.isEmpty)
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.all(32),
                          child: CircularProgressIndicator(),
                        ),
                      )
                    else if (recentDocs.isEmpty)
                      FadeInUp(
                        delay: const Duration(milliseconds: 400),
                        child: _buildEmptyState(),
                      )
                    else
                      ...recentDocs.asMap().entries.map((entry) {
                        return FadeInUp(
                          delay: Duration(milliseconds: 400 + entry.key * 100),
                          duration: const Duration(milliseconds: 500),
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: DocumentCard(
                              document: entry.value,
                              onTap: () {
                                if (entry.value.hasSummary) {
                                  context.push(
                                      '/summary/${entry.value.summaryId}');
                                } else {
                                  context.push('/document/${entry.value.id}');
                                }
                              },
                            ),
                          ),
                        );
                      }),
                  ],
                ),
              ),
            ),

            // Bottom padding for FAB
            const SliverToBoxAdapter(
              child: SizedBox(height: 100),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      padding: const EdgeInsets.all(32),
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
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Iconsax.document_text,
              size: 40,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'No documents yet',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Upload your first document and let AI summarize it for you',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () => context.push('/upload'),
            icon: const Icon(Iconsax.add),
            label: const Text('Upload Document'),
          ),
        ],
      ),
    );
  }
}

