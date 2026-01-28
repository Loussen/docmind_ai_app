import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:animate_do/animate_do.dart';
import 'package:iconsax/iconsax.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../providers/subscription_provider.dart';

class SubscriptionScreen extends ConsumerStatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  ConsumerState<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends ConsumerState<SubscriptionScreen> {
  bool _isYearly = true;
  String? _purchasingProductId;

  @override
  void initState() {
    super.initState();
    // Reset any stale purchasing state when screen opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(subscriptionProvider.notifier).clearPurchasingState();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    final subscriptionState = ref.watch(subscriptionProvider);
    final isPremium = subscriptionState.isPremium;

    // Listen for error and success messages
    ref.listen<SubscriptionState>(subscriptionProvider, (previous, next) {
      if (next.errorMessage != null &&
          next.errorMessage != previous?.errorMessage) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Iconsax.close_circle, color: Colors.white, size: 20),
                const SizedBox(width: 12),
                Expanded(child: Text(next.errorMessage!)),
              ],
            ),
            backgroundColor: AppColors.error,
            behavior: SnackBarBehavior.floating,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            margin: const EdgeInsets.all(16),
          ),
        );
        ref.read(subscriptionProvider.notifier).clearError();
      }
      if (next.successMessage != null &&
          next.successMessage != previous?.successMessage) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Iconsax.tick_circle, color: Colors.white, size: 20),
                const SizedBox(width: 12),
                Expanded(child: Text(next.successMessage!)),
              ],
            ),
            backgroundColor: AppColors.success,
            behavior: SnackBarBehavior.floating,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            margin: const EdgeInsets.all(16),
          ),
        );
        ref.read(subscriptionProvider.notifier).clearSuccess();
      }
    });

    // Reset purchasing state when not purchasing
    if (!subscriptionState.isPurchasing && _purchasingProductId != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          setState(() => _purchasingProductId = null);
        }
      });
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Iconsax.close_circle),
          onPressed: () => context.pop(),
        ),
        title: Text(isPremium ? 'Manage Subscription' : 'Upgrade'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Current Subscription Card (if premium)
            if (isPremium) ...[
              FadeInDown(
                duration: const Duration(milliseconds: 500),
                child: _buildCurrentPlanCard(subscriptionState),
              ),
              const SizedBox(height: 24),
            ],

            // Hero Section
            FadeInDown(
              duration: const Duration(milliseconds: 500),
              delay: Duration(milliseconds: isPremium ? 100 : 0),
              child: Column(
                children: [
                  if (!isPremium) ...[
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF667eea), Color(0xFF764ba2)],
                        ),
                        borderRadius: BorderRadius.circular(28),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF667eea).withOpacity(0.4),
                            blurRadius: 24,
                            offset: const Offset(0, 12),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Iconsax.crown5,
                        size: 48,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                  Text(
                    isPremium ? 'Change Your Plan' : 'Unlock Premium',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    isPremium
                        ? 'Upgrade or switch to a different plan'
                        : 'Get unlimited access to all features',
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

            const SizedBox(height: 32),

            // Billing Toggle
            FadeInUp(
              delay: const Duration(milliseconds: 100),
              duration: const Duration(milliseconds: 500),
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: isDark
                      ? AppColors.inputBackgroundDark
                      : AppColors.inputBackground,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _isYearly = false),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: !_isYearly
                                ? colorScheme.surface
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: !_isYearly
                                ? [
                                    BoxShadow(
                                      color: Colors.black
                                          .withOpacity(isDark ? 0.2 : 0.05),
                                      blurRadius: 8,
                                    ),
                                  ]
                                : null,
                          ),
                          child: Text(
                            'Monthly',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: !_isYearly
                                  ? colorScheme.onSurface
                                  : isDark
                                      ? AppColors.textTertiaryDark
                                      : AppColors.textTertiary,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _isYearly = true),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: _isYearly
                                ? colorScheme.surface
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: _isYearly
                                ? [
                                    BoxShadow(
                                      color: Colors.black
                                          .withOpacity(isDark ? 0.2 : 0.05),
                                      blurRadius: 8,
                                    ),
                                  ]
                                : null,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Yearly',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: _isYearly
                                      ? colorScheme.onSurface
                                      : isDark
                                          ? AppColors.textTertiaryDark
                                          : AppColors.textTertiary,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.success,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: const Text(
                                  'SAVE 40%',
                                  style: TextStyle(
                                    fontSize: 9,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Plans
            FadeInUp(
              delay: Duration(milliseconds: isPremium ? 300 : 200),
              duration: const Duration(milliseconds: 500),
              child: _buildPlanCard(
                title: 'Pro',
                monthlyPrice: 4.99,
                yearlyPrice: 35.99,
                features: [
                  'Unlimited documents',
                  'Unlimited summaries',
                  'Priority AI processing',
                  'Export to PDF',
                  'Email support',
                ],
                isPopular: true, // Pro is always the popular choice
                productId: _isYearly
                    ? AppConstants.proYearlyProductId
                    : AppConstants.proMonthlyProductId,
                subscriptionState: subscriptionState,
                planType: 'pro',
                isDark: isDark,
              ),
            ),

            const SizedBox(height: 16),

            FadeInUp(
              delay: Duration(milliseconds: isPremium ? 400 : 300),
              duration: const Duration(milliseconds: 500),
              child: _buildPlanCard(
                title: 'Pro+',
                monthlyPrice: 9.99,
                yearlyPrice: 71.99,
                features: [
                  'Everything in Pro',
                  'OCR for scanned documents',
                  'Long document support (100+ pages)',
                  'Advanced AI analysis',
                  'Priority support',
                  'Early access to features',
                ],
                isPopular: false, // Pro+ is premium, not "popular"
                productId: _isYearly
                    ? AppConstants.proPlusYearlyProductId
                    : AppConstants.proPlusMonthlyProductId,
                subscriptionState: subscriptionState,
                planType: 'pro_plus',
                isDark: isDark,
              ),
            ),

            const SizedBox(height: 24),

            // Free Plan Info
            FadeInUp(
              delay: const Duration(milliseconds: 400),
              duration: const Duration(milliseconds: 500),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.infoLight,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Row(
                  children: [
                    Icon(Iconsax.info_circle, color: AppColors.info, size: 22),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Free plan includes 3 documents per day with up to 5 pages each.',
                        style: TextStyle(
                          fontSize: 13,
                          color: AppColors.info,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Restore Purchases
            FadeIn(
              delay: const Duration(milliseconds: 500),
              child: Center(
                child: TextButton(
                  onPressed: subscriptionState.isRestoring
                      ? null
                      : () {
                          ref
                              .read(subscriptionProvider.notifier)
                              .restorePurchases();
                        },
                  child: subscriptionState.isRestoring
                      ? Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: isDark
                                    ? AppColors.textSecondaryDark
                                    : AppColors.textSecondary,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Restoring...',
                              style: TextStyle(
                                color: isDark
                                    ? AppColors.textSecondaryDark
                                    : AppColors.textSecondary,
                              ),
                            ),
                          ],
                        )
                      : Text(
                          'Restore Purchases',
                          style: TextStyle(
                            color: isDark
                                ? AppColors.textSecondaryDark
                                : AppColors.textSecondary,
                          ),
                        ),
                ),
              ),
            ),

            const SizedBox(height: 8),

            // Legal Links
            FadeIn(
              delay: const Duration(milliseconds: 600),
              child: Center(
                child: Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () =>
                          _launchUrl(AppConstants.termsOfServiceUrl),
                      child: const Text(
                        'Terms of Service',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.textTertiary,
                        ),
                      ),
                    ),
                    const Text(
                      '•',
                      style: TextStyle(color: AppColors.textTertiary),
                    ),
                    TextButton(
                      onPressed: () =>
                          _launchUrl(AppConstants.privacyPolicyUrl),
                      child: const Text(
                        'Privacy Policy',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.textTertiary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildPlanCard({
    required String title,
    required double monthlyPrice,
    required double yearlyPrice,
    required List<String> features,
    required bool isPopular,
    required String productId,
    required SubscriptionState subscriptionState,
    required String planType, // 'pro' or 'pro_plus'
    required bool isDark,
  }) {
    final price = _isYearly ? yearlyPrice : monthlyPrice;
    final period = _isYearly ? 'year' : 'month';
    final perMonth = _isYearly ? (yearlyPrice / 12) : monthlyPrice;

    // Determine button state based on current subscription
    final currentPlan = subscriptionState.subscription?.plan;
    final isCurrentPlan = _isCurrentPlan(currentPlan, planType, _isYearly);
    final buttonInfo = _getButtonInfo(currentPlan, planType, title);
    final isThisButtonPurchasing = _purchasingProductId == productId;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? AppColors.cardDark : AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isCurrentPlan
              ? AppColors.success
              : isPopular
                  ? AppColors.primary
                  : (isDark ? AppColors.dividerDark : AppColors.divider),
          width: isCurrentPlan || isPopular ? 2 : 1,
        ),
        boxShadow: isPopular || isCurrentPlan
            ? [
                BoxShadow(
                  color: (isCurrentPlan ? AppColors.success : AppColors.primary)
                      .withOpacity(isDark ? 0.2 : 0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ]
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: isDark ? AppColors.textLight : AppColors.textPrimary,
                ),
              ),
              if (isCurrentPlan)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.success,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'CURRENT',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                )
              else if (isPopular)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'POPULAR',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '\$${price.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: isDark ? AppColors.textLight : AppColors.textPrimary,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 6, left: 4),
                child: Text(
                  '/$period',
                  style: TextStyle(
                    fontSize: 14,
                    color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
                  ),
                ),
              ),
            ],
          ),
          if (_isYearly)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                'That\'s only \$${perMonth.toStringAsFixed(2)}/month',
                style: const TextStyle(
                  fontSize: 13,
                  color: AppColors.success,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          const SizedBox(height: 20),
          ...features.map((feature) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  children: [
                    Container(
                      width: 22,
                      height: 22,
                      decoration: BoxDecoration(
                        color: AppColors.success.withOpacity(isDark ? 0.2 : 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.check,
                        size: 14,
                        color: AppColors.success,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        feature,
                        style: TextStyle(
                          fontSize: 14,
                          color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: isCurrentPlan || subscriptionState.isPurchasing
                  ? null
                  : () => _purchasePlan(productId, buttonInfo.isDowngrade),
              style: ElevatedButton.styleFrom(
                backgroundColor: isCurrentPlan
                    ? AppColors.success.withOpacity(isDark ? 0.2 : 0.1)
                    : buttonInfo.isDowngrade
                        ? (isDark ? AppColors.surfaceDark : AppColors.inputBackground)
                        : isPopular
                            ? AppColors.primary
                            : (isDark ? AppColors.surfaceDark : AppColors.inputBackground),
                foregroundColor: isCurrentPlan
                    ? AppColors.success
                    : buttonInfo.isDowngrade
                        ? (isDark ? AppColors.textSecondaryDark : AppColors.textSecondary)
                        : isPopular
                            ? Colors.white
                            : (isDark ? AppColors.textLight : AppColors.textPrimary),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: isThisButtonPurchasing
                  ? const SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(strokeWidth: 2.5),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (buttonInfo.icon != null) ...[
                          Icon(buttonInfo.icon, size: 18),
                          const SizedBox(width: 8),
                        ],
                        Text(
                          buttonInfo.text,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
            ),
          ),
          if (buttonInfo.isDowngrade && !isCurrentPlan)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                'Changes at end of billing period',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.textTertiary,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildCurrentPlanCard(SubscriptionState subscriptionState) {
    final subscription = subscriptionState.subscription;
    if (subscription == null) return const SizedBox.shrink();

    final planName = subscription.isProPlus ? 'Pro+' : 'Pro';
    final endDate = subscription.endDate;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF667eea), Color(0xFF764ba2)],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Iconsax.crown5,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$planName Member',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subscription.isAutoRenewing
                          ? 'Auto-renews ${endDate != null ? _formatDate(endDate) : 'soon'}'
                          : 'Expires ${endDate != null ? _formatDate(endDate) : 'soon'}',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'ACTIVE',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }

  bool _isCurrentPlan(dynamic currentPlan, String planType, bool isYearly) {
    if (currentPlan == null) return false;

    // Check if plan type matches (pro or pro_plus)
    final currentPlanStr = currentPlan.toString().toLowerCase();
    if (planType == 'pro' && currentPlanStr == 'pro') return true;
    if (planType == 'pro_plus' &&
        (currentPlanStr == 'pro_plus' || currentPlanStr == 'proplus'))
      return true;

    return false;
  }

  _ButtonInfo _getButtonInfo(
      dynamic currentPlan, String planType, String title) {
    if (currentPlan == null) {
      return _ButtonInfo(text: 'Get $title', icon: null, isDowngrade: false);
    }

    final currentPlanStr = currentPlan.toString().toLowerCase();
    final currentLevel = _getPlanLevel(currentPlanStr);
    final targetLevel = _getPlanLevel(planType);

    if (currentLevel == targetLevel) {
      return _ButtonInfo(
          text: 'Current Plan', icon: Iconsax.tick_circle5, isDowngrade: false);
    } else if (targetLevel > currentLevel) {
      return _ButtonInfo(
          text: 'Upgrade to $title',
          icon: Iconsax.arrow_up_2,
          isDowngrade: false);
    } else {
      return _ButtonInfo(
          text: 'Downgrade to $title',
          icon: Iconsax.arrow_down,
          isDowngrade: true);
    }
  }

  int _getPlanLevel(String plan) {
    switch (plan.toLowerCase()) {
      case 'free':
        return 0;
      case 'pro':
        return 1;
      case 'pro_plus':
      case 'proplus':
        return 2;
      default:
        return 0;
    }
  }

  void _purchasePlan(String productId, bool isDowngrade) {
    setState(() => _purchasingProductId = productId);

    if (isDowngrade) {
      _showDowngradeConfirmation(productId);
    } else {
      ref.read(subscriptionProvider.notifier).purchaseSubscription(productId);
    }
  }

  void _showDowngradeConfirmation(String productId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Downgrade Plan'),
        content: const Text(
          'Your plan will be downgraded at the end of your current billing period. '
          'You will keep your current features until then.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() => _purchasingProductId = null);
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ref
                  .read(subscriptionProvider.notifier)
                  .purchaseSubscription(productId);
            },
            child: const Text('Confirm Downgrade'),
          ),
        ],
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}

class _ButtonInfo {
  final String text;
  final IconData? icon;
  final bool isDowngrade;

  _ButtonInfo({
    required this.text,
    required this.icon,
    required this.isDowngrade,
  });
}
