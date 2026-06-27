import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:animate_do/animate_do.dart';
import 'package:iconsax/iconsax.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/services/tiktok_analytics_service.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/constants/app_constants.dart';
import '../../data/models/subscription_model.dart';
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
      TikTokAnalyticsService.instance.logViewContent(
        contentId: 'subscription_screen',
        contentName: 'Subscription Plans',
      );
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
        title: Text(isPremium ? S.of(context)!.manageSubscription : S.of(context)!.upgrade),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Current Subscription Card (if premium)
            if (isPremium) ...[
              FadeInDown(
                duration: const Duration(milliseconds: 300),
                child: _buildCurrentPlanCard(context, subscriptionState),
              ),
              const SizedBox(height: 24),
            ],

            // Hero Section
            FadeInDown(
              duration: const Duration(milliseconds: 300),
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
                    isPremium ? S.of(context)!.changeYourPlan : S.of(context)!.unlockPremium,
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
                        ? S.of(context)!.upgradeOrSwitch
                        : S.of(context)!.getUnlimitedAccess,
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
              delay: const Duration(milliseconds: 50),
              duration: const Duration(milliseconds: 300),
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
                            S.of(context)!.monthly,
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
                                S.of(context)!.yearly,
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
                                child: Text(
                                  S.of(context)!.save40,
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

            FadeInUp(
              delay: Duration(milliseconds: isPremium ? 120 : 80),
              duration: const Duration(milliseconds: 300),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Text(
                  S.of(context)!.subscriptionLegalDisclosure,
                  style: TextStyle(
                    fontSize: 12,
                    height: 1.45,
                    color: isDark
                        ? AppColors.textTertiaryDark
                        : AppColors.textTertiary,
                  ),
                ),
              ),
            ),

            if (isPremium) ...[
              const SizedBox(height: 12),
              FadeInUp(
                delay: Duration(milliseconds: isPremium ? 130 : 90),
                duration: const Duration(milliseconds: 300),
                child: Center(
                  child: TextButton(
                    onPressed: () => _launchUrl(
                      'https://apps.apple.com/account/subscriptions',
                    ),
                    child: Text(S.of(context)!.manageInAppStore),
                  ),
                ),
              ),
            ],

            const SizedBox(height: 16),

            // Plans
            FadeInUp(
              delay: Duration(milliseconds: isPremium ? 150 : 100),
              duration: const Duration(milliseconds: 300),
              child: _buildPlanCard(
                context: context,
                title: S.of(context)!.planPro,
                monthlyPrice:
                    subscriptionState.productPrices?.proMonthlyPrice ??
                        S.of(context)!.pricesLoading,
                yearlyPrice: subscriptionState.productPrices?.proYearlyPrice ??
                    S.of(context)!.pricesLoading,
                features: [
                  S.of(context)!.unlimitedDocuments,
                  S.of(context)!.unlimitedSummaries,
                  S.of(context)!.priorityAiProcessing,
                  S.of(context)!.exportToPdf,
                  S.of(context)!.emailSupport,
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
              delay: Duration(milliseconds: isPremium ? 200 : 150),
              duration: const Duration(milliseconds: 300),
              child: _buildPlanCard(
                context: context,
                title: S.of(context)!.planProPlus,
                monthlyPrice:
                    subscriptionState.productPrices?.proPlusMonthlyPrice ??
                        S.of(context)!.pricesLoading,
                yearlyPrice:
                    subscriptionState.productPrices?.proPlusYearlyPrice ??
                        S.of(context)!.pricesLoading,
                features: [
                  S.of(context)!.everythingInPro,
                  S.of(context)!.ocrScannedDocs,
                  S.of(context)!.longDocSupport,
                  S.of(context)!.advancedAiAnalysis,
                  S.of(context)!.prioritySupport,
                  S.of(context)!.earlyAccess,
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
              delay: const Duration(milliseconds: 50),
              duration: const Duration(milliseconds: 300),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.infoLight,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    const Icon(Iconsax.info_circle, color: AppColors.info, size: 22),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        S.of(context)!.freePlanInfo,
                        style: const TextStyle(
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
              delay: const Duration(milliseconds: 250),
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
                              S.of(context)!.restoring,
                              style: TextStyle(
                                color: isDark
                                    ? AppColors.textSecondaryDark
                                    : AppColors.textSecondary,
                              ),
                            ),
                          ],
                        )
                      : Text(
                          S.of(context)!.restorePurchases,
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
              delay: const Duration(milliseconds: 150),
              child: Center(
                child: Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () =>
                          _launchUrl(AppConstants.termsOfServiceUrl),
                      child: Text(
                        S.of(context)!.termsOfService,
                        style: const TextStyle(
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
                      child: Text(
                        S.of(context)!.privacyPolicy,
                        style: const TextStyle(
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
    required BuildContext context,
    required String title,
    required String monthlyPrice,
    required String yearlyPrice,
    required List<String> features,
    required bool isPopular,
    required String productId,
    required SubscriptionState subscriptionState,
    required String planType, // 'pro' or 'pro_plus'
    required bool isDark,
  }) {
    final pricesLoaded = subscriptionState.productPrices != null;
    final price = _isYearly ? yearlyPrice : monthlyPrice;
    final period = _isYearly ? S.of(context)!.perYear : S.of(context)!.perMonth;

    // Determine button state based on current subscription
    final subscription = subscriptionState.subscription;
    final currentPlan = subscription?.plan;
    final currentBillingIsYearly = subscription?.isYearly ?? false;
    final isCurrentPlan = _isCurrentPlan(currentPlan, planType, _isYearly, currentBillingIsYearly);
    final buttonInfo = _getButtonInfo(context, currentPlan, planType, title, _isYearly, currentBillingIsYearly);
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
                  child: Text(
                    S.of(context)!.current,
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
                  child: Text(
                    S.of(context)!.popular,
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
                price,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: isDark ? AppColors.textLight : AppColors.textPrimary,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 6, left: 4),
                child: Text(
                  period,
                  style: TextStyle(
                    fontSize: 14,
                    color: isDark
                        ? AppColors.textSecondaryDark
                        : AppColors.textSecondary,
                  ),
                ),
              ),
            ],
          ),
          if (_isYearly)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                S.of(context)!.billedAnnually,
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
                        color:
                            AppColors.success.withOpacity(isDark ? 0.2 : 0.1),
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
                          color: isDark
                              ? AppColors.textSecondaryDark
                              : AppColors.textSecondary,
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
              onPressed: !pricesLoaded || isCurrentPlan || subscriptionState.isPurchasing
                  ? null
                  : () => _purchasePlan(productId, buttonInfo.isDowngrade),
              style: ElevatedButton.styleFrom(
                backgroundColor: isCurrentPlan
                    ? AppColors.success.withOpacity(isDark ? 0.2 : 0.1)
                    : buttonInfo.isDowngrade
                        ? (isDark
                            ? AppColors.surfaceDark
                            : AppColors.inputBackground)
                        : isPopular
                            ? AppColors.primary
                            : (isDark
                                ? AppColors.surfaceDark
                                : AppColors.inputBackground),
                foregroundColor: isCurrentPlan
                    ? AppColors.success
                    : buttonInfo.isDowngrade
                        ? (isDark
                            ? AppColors.textSecondaryDark
                            : AppColors.textSecondary)
                        : isPopular
                            ? Colors.white
                            : (isDark
                                ? AppColors.textLight
                                : AppColors.textPrimary),
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
                S.of(context)!.changesAtEnd,
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

  Widget _buildCurrentPlanCard(BuildContext context, SubscriptionState subscriptionState) {
    final subscription = subscriptionState.subscription;
    if (subscription == null) return const SizedBox.shrink();

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
                      subscription.isProPlus
                          ? S.of(context)!.proPlusMember
                          : S.of(context)!.proMember,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subscription.isAutoRenewing
                          ? S.of(context)!.autoRenews(endDate != null ? _formatDate(context, endDate) : S.of(context)!.soon)
                          : S.of(context)!.expires(endDate != null ? _formatDate(context, endDate) : S.of(context)!.soon),
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
                child: Text(
                  S.of(context)!.active,
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

  String _formatDate(BuildContext context, DateTime date) {
    final locale = Localizations.localeOf(context);
    return DateFormat.yMMMd(locale.toString()).format(date);
  }

  bool _isCurrentPlan(dynamic currentPlan, String planType, bool tabIsYearly, bool currentBillingIsYearly) {
    if (currentPlan == null) return false;
    if (tabIsYearly != currentBillingIsYearly) return false;

    String currentPlanStr;
    if (currentPlan is SubscriptionPlan) {
      currentPlanStr = currentPlan.name;
    } else {
      currentPlanStr = currentPlan.toString().toLowerCase();
    }

    if (planType == 'pro' && currentPlanStr == 'pro') return true;
    if (planType == 'pro_plus' &&
        (currentPlanStr == 'pro_plus' || currentPlanStr == 'proPlus'))
      return true;

    return false;
  }

  _ButtonInfo _getButtonInfo(
      BuildContext context, dynamic currentPlan, String planType, String title, bool tabIsYearly, bool currentBillingIsYearly) {
    if (currentPlan == null || _getPlanLevel(_planStr(currentPlan)) == 0) {
      return _ButtonInfo(
        text: planType == 'pro' ? S.of(context)!.getPro : S.of(context)!.getProPlus,
        icon: null,
        isDowngrade: false,
      );
    }

    final currentPlanStr = _planStr(currentPlan);
    final currentLevel = _getPlanLevel(currentPlanStr);
    final targetLevel = _getPlanLevel(planType);

    // Exact same plan AND same billing period = current plan
    if (currentLevel == targetLevel && tabIsYearly == currentBillingIsYearly) {
      return _ButtonInfo(
          text: S.of(context)!.currentPlan, icon: Iconsax.tick_circle5, isDowngrade: false);
    }

    // Same plan type but different billing period = switch billing
    if (currentLevel == targetLevel && tabIsYearly != currentBillingIsYearly) {
      final label = tabIsYearly ? S.of(context)!.switchToYearly : S.of(context)!.switchToMonthly;
      return _ButtonInfo(text: label, icon: Iconsax.refresh, isDowngrade: false);
    }

    if (targetLevel > currentLevel) {
      return _ButtonInfo(
          text: planType == 'pro' ? S.of(context)!.upgradeToPro : S.of(context)!.upgradeToProPlus,
          icon: Iconsax.arrow_up_2,
          isDowngrade: false);
    } else {
      return _ButtonInfo(
          text: planType == 'pro' ? S.of(context)!.downgradeToPro : S.of(context)!.downgradeToProPlus,
          icon: Iconsax.arrow_down,
          isDowngrade: true);
    }
  }

  String _planStr(dynamic plan) {
    if (plan is SubscriptionPlan) return plan.name;
    return plan.toString().toLowerCase();
  }

  int _getPlanLevel(String plan) {
    final p = plan.toLowerCase();
    if (p == 'pro') return 1;
    if (p == 'pro_plus' || p == 'proplus') return 2;
    return 0;
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
        title: Text(S.of(context)!.downgradePlan),
        content: Text(S.of(context)!.downgradeConfirm),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() => _purchasingProductId = null);
            },
            child: Text(S.of(context)!.cancel),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ref
                  .read(subscriptionProvider.notifier)
                  .purchaseSubscription(productId);
            },
            child: Text(S.of(context)!.confirmDowngrade),
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
