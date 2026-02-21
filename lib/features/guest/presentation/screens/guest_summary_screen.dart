import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:animate_do/animate_do.dart';
import 'package:iconsax/iconsax.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../core/theme/app_colors.dart';
import '../providers/guest_provider.dart';

class GuestSummaryScreen extends ConsumerWidget {
  const GuestSummaryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final guestState = ref.watch(guestProvider);
    final summary = guestState.lastSummary;
    final document = guestState.lastDocument;

    if (summary == null) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Iconsax.arrow_left),
            onPressed: () => context.pop(),
          ),
          title: const Text('Summary'),
        ),
        body: const Center(
          child: Text('No summary available'),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left, color: AppColors.textPrimary),
          onPressed: () {
            ref.read(guestProvider.notifier).clearLastSummary();
            context.pop();
          },
        ),
        title: const Text(
          'Summary',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Iconsax.share, color: AppColors.primary),
            onPressed: () => _shareSummary(context, summary, document),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Not Saved Warning
            FadeInDown(
              duration: const Duration(milliseconds: 300),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: AppColors.warning.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.warning.withOpacity(0.3),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Iconsax.warning_2,
                      color: AppColors.warning,
                      size: 20,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: const Text(
                        'This summary won\'t be saved. Create an account to keep it!',
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xFFB8860B), // Dark golden
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Document Info
            if (document != null)
              FadeInDown(
                duration: const Duration(milliseconds: 400),
                child: _buildDocumentInfo(document),
              ),

            const SizedBox(height: 20),

            // Title
            FadeInDown(
              delay: const Duration(milliseconds: 100),
              child: Text(
                summary['title'] ?? 'Document Summary',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                  letterSpacing: -0.5,
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Overview Card
            FadeInUp(
              delay: const Duration(milliseconds: 200),
              child: _buildSectionCard(
                icon: Iconsax.document_text,
                iconColor: AppColors.primary,
                title: 'Overview',
                child: Text(
                  summary['overview'] ?? 'No overview available',
                  style: const TextStyle(
                    fontSize: 15,
                    color: AppColors.textSecondary,
                    height: 1.6,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Key Points - Only show first 2 for guests (from backend)
            if (summary['key_points'] != null &&
                (summary['key_points'] as List).isNotEmpty)
              FadeInUp(
                delay: const Duration(milliseconds: 300),
                child: _buildSectionCard(
                  icon: Iconsax.key,
                  iconColor: AppColors.success,
                  title: 'Key Points',
                  child: Column(
                    children: [
                      // Show visible key points (backend only sends first 2)
                      ...(summary['key_points'] as List)
                          .map<Widget>(
                              (point) => _buildBulletPoint(point.toString()))
                          .toList(),
                      // Show blurred preview if there are more hidden on server
                      if (guestState.hiddenKeyPoints > 0)
                        _buildBlurredPreview(
                          '${guestState.hiddenKeyPoints} more key points',
                        ),
                    ],
                  ),
                ),
              ),

            if (summary['key_points'] != null &&
                (summary['key_points'] as List).isNotEmpty)
              const SizedBox(height: 16),

            // Action Items - Fully locked for guests (count from server)
            if (guestState.totalActionItems > 0)
              FadeInUp(
                delay: const Duration(milliseconds: 400),
                child: _buildLockedSection(
                  icon: Iconsax.task_square,
                  iconColor: AppColors.warning,
                  title: 'Action Items',
                  itemCount: guestState.totalActionItems,
                  context: context,
                  ref: ref,
                ),
              ),

            if (guestState.totalActionItems > 0) const SizedBox(height: 16),

            // Keywords - Fully locked for guests (count from server)
            if (guestState.totalKeywords > 0)
              FadeInUp(
                delay: const Duration(milliseconds: 500),
                child: _buildLockedSection(
                  icon: Iconsax.tag,
                  iconColor: AppColors.secondary,
                  title: 'Keywords',
                  itemCount: guestState.totalKeywords,
                  context: context,
                  ref: ref,
                ),
              ),

            const SizedBox(height: 24),

            // Trial info & CTA
            FadeInUp(
              delay: const Duration(milliseconds: 600),
              child: _buildTrialCTA(context, ref, guestState),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildDocumentInfo(Map<String, dynamic> document) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: _getTypeColor(document['type']).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              _getTypeIcon(document['type']),
              color: _getTypeColor(document['type']),
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  document['original_name'] ?? 'Document',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  '${(document['type'] as String?)?.toUpperCase() ?? 'FILE'} • ${_getFileSizeString(document['file_size'] as int? ?? 0)} • ${document['page_count'] ?? 1} page(s)',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColors.textTertiary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
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
                  color: iconColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: iconColor, size: 20),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
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

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 8),
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: AppColors.success,
              borderRadius: BorderRadius.circular(3),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 15,
                color: AppColors.textSecondary,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBlurredPreview(String text) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.backgroundLight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.divider,
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Iconsax.lock,
            size: 16,
            color: AppColors.textTertiary,
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              fontSize: 13,
              color: AppColors.textTertiary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLockedSection({
    required IconData icon,
    required Color iconColor,
    required String title,
    required int itemCount,
    required BuildContext context,
    required WidgetRef ref,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
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
                  color: iconColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: iconColor, size: 20),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '$itemCount items',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Blurred content placeholder
          Stack(
            children: [
              // Fake blurred content
              Column(
                children: List.generate(
                  itemCount > 3 ? 3 : itemCount,
                  (index) => Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    height: 20,
                    decoration: BoxDecoration(
                      color: AppColors.divider.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    width: double.infinity,
                  ),
                ),
              ),
              // Gradient overlay
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.white.withOpacity(0.3),
                        Colors.white.withOpacity(0.9),
                        Colors.white,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Unlock button
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () {
                ref.read(guestProvider.notifier).exitGuestMode();
                context.go('/login');
              },
              icon: const Icon(Iconsax.unlock, size: 18),
              label: const Text('Create Free Account to Unlock'),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.primary,
                side: const BorderSide(color: AppColors.primary, width: 1.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrialCTA(BuildContext context, WidgetRef ref, GuestState state) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: state.limitReached
            ? const LinearGradient(
                colors: [Color(0xFFFF6B6B), Color(0xFFEE5A5A)],
              )
            : AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Icon(
            state.limitReached ? Iconsax.warning_2 : Iconsax.gift,
            color: Colors.white,
            size: 32,
          ),
          const SizedBox(height: 12),
          Text(
            state.limitReached
                ? 'Trial Limit Reached'
                : '${state.remainingTrials} Trial${state.remainingTrials != 1 ? 's' : ''} Remaining',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            state.limitReached
                ? 'Create an account to continue using DoCMind AI'
                : 'Create an account for unlimited summaries',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withOpacity(0.9),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    ref.read(guestProvider.notifier).clearLastSummary();
                    context.pop();
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: Colors.white, width: 1.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: Text(state.limitReached ? 'Close' : 'Try Again'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    ref.read(guestProvider.notifier).exitGuestMode();
                    context.go('/login');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text(
                    'Create Account',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _shareSummary(BuildContext context, Map<String, dynamic> summary,
      Map<String, dynamic>? document) {
    final buffer = StringBuffer();

    buffer.writeln('📄 ${summary['title'] ?? 'Document Summary'}');
    buffer.writeln();

    if (document != null) {
      buffer.writeln('Document: ${document['original_name']}');
      buffer.writeln();
    }

    buffer.writeln('📋 OVERVIEW');
    buffer.writeln(summary['overview'] ?? '');
    buffer.writeln();

    if (summary['key_points'] != null &&
        (summary['key_points'] as List).isNotEmpty) {
      buffer.writeln('🔑 KEY POINTS');
      for (final point in summary['key_points'] as List) {
        buffer.writeln('• $point');
      }
      buffer.writeln();
    }

    if (summary['action_items'] != null &&
        (summary['action_items'] as List).isNotEmpty) {
      buffer.writeln('✅ ACTION ITEMS');
      for (final item in summary['action_items'] as List) {
        buffer.writeln('☐ $item');
      }
      buffer.writeln();
    }

    buffer.writeln('---');
    buffer.writeln('Generated by DoCMind AI');

    // Share - iPad requires sharePositionOrigin for the popover
    final box = context.findRenderObject() as RenderBox?;
    Share.share(
      buffer.toString(),
      sharePositionOrigin: box != null
          ? box.localToGlobal(Offset.zero) & box.size
          : const Rect.fromLTWH(0, 0, 100, 100),
    );
  }

  IconData _getTypeIcon(String? type) {
    switch (type) {
      case 'pdf':
        return Iconsax.document_text;
      case 'doc':
      case 'docx':
        return Iconsax.document;
      case 'image':
        return Iconsax.image;
      default:
        return Iconsax.document;
    }
  }

  Color _getTypeColor(String? type) {
    switch (type) {
      case 'pdf':
        return Colors.red;
      case 'doc':
      case 'docx':
        return Colors.blue;
      case 'image':
        return Colors.green;
      default:
        return AppColors.primary;
    }
  }

  String _getFileSizeString(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }
}
