import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/services/tiktok_analytics_service.dart';
import '../../data/models/subscription_model.dart';
import '../../data/repositories/subscription_repository.dart';

// Product prices from StoreKit
class ProductPrices {
  final String? proMonthlyPrice;
  final String? proYearlyPrice;
  final String? proPlusMonthlyPrice;
  final String? proPlusYearlyPrice;

  const ProductPrices({
    this.proMonthlyPrice,
    this.proYearlyPrice,
    this.proPlusMonthlyPrice,
    this.proPlusYearlyPrice,
  });
}

// Subscription state
class SubscriptionState {
  final SubscriptionModel? subscription;
  final UsageModel? usage;
  final List<SubscriptionPlanInfo> plans;
  final ProductPrices? productPrices;
  final bool isLoading;
  final bool isPurchasing;
  final bool isRestoring;
  final String? errorMessage;
  final String? successMessage;

  const SubscriptionState({
    this.subscription,
    this.usage,
    this.plans = const [],
    this.productPrices,
    this.isLoading = false,
    this.isPurchasing = false,
    this.isRestoring = false,
    this.errorMessage,
    this.successMessage,
  });

  SubscriptionState copyWith({
    SubscriptionModel? subscription,
    UsageModel? usage,
    List<SubscriptionPlanInfo>? plans,
    ProductPrices? productPrices,
    bool? isLoading,
    bool? isPurchasing,
    bool? isRestoring,
    String? errorMessage,
    String? successMessage,
    bool clearError = false,
    bool clearSuccess = false,
  }) {
    return SubscriptionState(
      subscription: subscription ?? this.subscription,
      usage: usage ?? this.usage,
      plans: plans ?? this.plans,
      productPrices: productPrices ?? this.productPrices,
      isLoading: isLoading ?? this.isLoading,
      isPurchasing: isPurchasing ?? this.isPurchasing,
      isRestoring: isRestoring ?? this.isRestoring,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      successMessage:
          clearSuccess ? null : (successMessage ?? this.successMessage),
    );
  }

  bool get isPremium =>
      subscription?.isPro == true && subscription?.isActive == true;
  bool get isProPlus =>
      subscription?.isProPlus == true && subscription?.isActive == true;
  bool get canUploadDocument =>
      isPremium || (usage?.hasReachedFreeLimit != true);
}

class SubscriptionNotifier extends StateNotifier<SubscriptionState> {
  final SubscriptionRepository _subscriptionRepository;
  final InAppPurchase _inAppPurchase;
  StreamSubscription<List<PurchaseDetails>>? _purchaseSubscription;

  SubscriptionNotifier(this._subscriptionRepository)
      : _inAppPurchase = InAppPurchase.instance,
        super(const SubscriptionState()) {
    _initializePurchases();
  }

  Future<void> _initializePurchases() async {
    final available = await _inAppPurchase.isAvailable();
    if (!available) return;

    _purchaseSubscription =
        _inAppPurchase.purchaseStream.listen(_onPurchaseUpdate);

    // Load product prices from StoreKit
    await _loadProductPrices();
  }

  Future<void> _loadProductPrices() async {
    try {
      final productIds = {
        AppConstants.proMonthlyProductId,
        AppConstants.proYearlyProductId,
        AppConstants.proPlusMonthlyProductId,
        AppConstants.proPlusYearlyProductId,
      };

      final response = await _inAppPurchase.queryProductDetails(productIds);

      if (response.productDetails.isNotEmpty) {
        String? proMonthly, proYearly, proPlusMonthly, proPlusYearly;

        for (final product in response.productDetails) {
          switch (product.id) {
            case AppConstants.proMonthlyProductId:
              proMonthly = product.price;
              break;
            case AppConstants.proYearlyProductId:
              proYearly = product.price;
              break;
            case AppConstants.proPlusMonthlyProductId:
              proPlusMonthly = product.price;
              break;
            case AppConstants.proPlusYearlyProductId:
              proPlusYearly = product.price;
              break;
          }
        }

        state = state.copyWith(
          productPrices: ProductPrices(
            proMonthlyPrice: proMonthly,
            proYearlyPrice: proYearly,
            proPlusMonthlyPrice: proPlusMonthly,
            proPlusYearlyPrice: proPlusYearly,
          ),
        );
      }
    } catch (e) {
      // Silently fail - will use fallback prices in UI
    }
  }

  void _onPurchaseUpdate(List<PurchaseDetails> purchases) async {
    for (final purchase in purchases) {
      // Use our own state to determine if this was a user-initiated restore,
      // not Apple's PurchaseStatus (sandbox re-purchases come as "restored")
      final userInitiatedRestore = state.isRestoring;

      if (purchase.status == PurchaseStatus.purchased ||
          purchase.status == PurchaseStatus.restored) {
        await _verifyPurchase(purchase, isRestore: userInitiatedRestore);
      } else if (purchase.status == PurchaseStatus.error) {
        state = state.copyWith(
          isPurchasing: false,
          isRestoring: false,
          errorMessage: purchase.error?.message ?? 'Purchase failed',
        );
      } else if (purchase.status == PurchaseStatus.canceled) {
        state = state.copyWith(isPurchasing: false, isRestoring: false);
      }

      if (purchase.pendingCompletePurchase) {
        await _inAppPurchase.completePurchase(purchase);
      }
    }
  }

  Future<void> _verifyPurchase(PurchaseDetails purchase,
      {bool isRestore = false}) async {
    final receiptData = purchase.verificationData.serverVerificationData;

    // Always use verify endpoint - it handles both new and re-purchases.
    // Only use restore endpoint when user explicitly tapped "Restore Purchases".
    final result = isRestore
        ? await _subscriptionRepository.restorePurchase(
            receiptData: receiptData,
          )
        : await _subscriptionRepository.verifyPurchase(
            productId: purchase.productID,
            transactionId: purchase.purchaseID ?? '',
            receiptData: receiptData,
          );

    result.fold(
      (error) {
        state = state.copyWith(
          isPurchasing: false,
          isRestoring: false,
          errorMessage: error,
        );
      },
      (response) {
        if (response.success && response.subscription != null) {
          final price = _priceForProduct(purchase.productID);
          TikTokAnalyticsService.instance.logSubscribe(
            productId: purchase.productID,
            value: price,
          );
          TikTokAnalyticsService.instance.logPurchase(
            productId: purchase.productID,
            value: price ?? 0,
            transactionId: purchase.purchaseID,
          );

          state = state.copyWith(
            subscription: response.subscription,
            isPurchasing: false,
            isRestoring: false,
            successMessage: isRestore
                ? 'Purchase restored successfully!'
                : 'Subscription activated successfully!',
          );
        } else {
          state = state.copyWith(
            isPurchasing: false,
            isRestoring: false,
            errorMessage: response.message ?? 'Verification failed',
          );
        }
      },
    );
  }

  Future<void> loadSubscriptionData() async {
    state = state.copyWith(isLoading: true);

    final subscriptionResult = await _subscriptionRepository.getSubscription();
    final usageResult = await _subscriptionRepository.getUsage();
    final plansResult = await _subscriptionRepository.getPlans();

    state = state.copyWith(isLoading: false);

    subscriptionResult.fold(
      (error) {},
      (subscription) => state = state.copyWith(subscription: subscription),
    );

    usageResult.fold(
      (error) {},
      (usage) => state = state.copyWith(usage: usage),
    );

    plansResult.fold(
      (error) {},
      (plans) => state = state.copyWith(plans: plans),
    );
  }

  Future<void> refreshUsage() async {
    final result = await _subscriptionRepository.getUsage();
    result.fold(
      (error) {},
      (usage) => state = state.copyWith(usage: usage),
    );
  }

  Future<void> purchaseSubscription(String productId) async {
    state = state.copyWith(isPurchasing: true);

    final available = await _inAppPurchase.isAvailable();
    if (!available) {
      state = state.copyWith(
        isPurchasing: false,
        errorMessage: 'In-app purchases not available',
      );
      return;
    }

    final productIds = {productId};
    final response = await _inAppPurchase.queryProductDetails(productIds);

    if (response.productDetails.isEmpty) {
      state = state.copyWith(
        isPurchasing: false,
        errorMessage: 'Product not found',
      );
      return;
    }

    final product = response.productDetails.first;
    TikTokAnalyticsService.instance.logCheckoutStarted(productId: productId);

    final purchaseParam = PurchaseParam(productDetails: product);

    try {
      await _inAppPurchase.buyNonConsumable(purchaseParam: purchaseParam);
    } catch (e) {
      // Handle user cancellation or other errors
      final errorMessage = e.toString().toLowerCase();
      if (errorMessage.contains('cancelled') ||
          errorMessage.contains('canceled')) {
        // User cancelled - just reset state, no error message needed
        state = state.copyWith(isPurchasing: false);
      } else {
        state = state.copyWith(
          isPurchasing: false,
          errorMessage: 'Purchase failed. Please try again.',
        );
      }
    }
  }

  Future<void> restorePurchases() async {
    state =
        state.copyWith(isRestoring: true, clearError: true, clearSuccess: true);
    await _inAppPurchase.restorePurchases();

    // Reset isRestoring after a short timeout in case no purchases are found
    // (stream won't emit events if there's nothing to restore)
    Future.delayed(const Duration(seconds: 2), () {
      if (state.isRestoring) {
        state = state.copyWith(
          isRestoring: false,
          successMessage: 'No purchases to restore',
        );
      }
    });
  }

  void clearError() {
    state = state.copyWith(clearError: true);
  }

  void clearSuccess() {
    state = state.copyWith(clearSuccess: true);
  }

  void clearPurchasingState() {
    state = state.copyWith(
        isPurchasing: false,
        isRestoring: false,
        clearError: true,
        clearSuccess: true);
  }

  double? _priceForProduct(String productId) {
    final prices = state.productPrices;
    if (prices == null) return null;

    String? raw;
    switch (productId) {
      case AppConstants.proMonthlyProductId:
        raw = prices.proMonthlyPrice;
      case AppConstants.proYearlyProductId:
        raw = prices.proYearlyPrice;
      case AppConstants.proPlusMonthlyProductId:
        raw = prices.proPlusMonthlyPrice;
      case AppConstants.proPlusYearlyProductId:
        raw = prices.proPlusYearlyPrice;
    }

    return TikTokAnalyticsService.parsePrice(raw);
  }

  @override
  void dispose() {
    _purchaseSubscription?.cancel();
    super.dispose();
  }
}

final subscriptionProvider =
    StateNotifierProvider<SubscriptionNotifier, SubscriptionState>((ref) {
  final repository = ref.watch(subscriptionRepositoryProvider);
  return SubscriptionNotifier(repository);
});

// Usage check provider
final canUploadProvider = Provider<bool>((ref) {
  if (ref.watch(debugFreeModProvider)) {
    final usage = ref.watch(subscriptionProvider).usage;
    return usage == null || !usage.hasReachedFreeLimit;
  }
  final subscriptionState = ref.watch(subscriptionProvider);
  return subscriptionState.canUploadDocument;
});

// Remaining docs provider
final remainingDocsProvider = Provider<int>((ref) {
  if (ref.watch(debugFreeModProvider)) {
    final usage = ref.watch(subscriptionProvider).usage;
    return usage?.remainingFree ?? AppConstants.freeDocsTotal;
  }
  final subscriptionState = ref.watch(subscriptionProvider);
  if (subscriptionState.isPremium) return -1;
  return subscriptionState.usage?.remainingFree ?? AppConstants.freeDocsTotal;
});

/// Max file size in MB for current plan. Used for upload validation and UI.
final maxFileSizeMbProvider = Provider<int>((ref) {
  if (ref.watch(debugFreeModProvider)) return AppConstants.maxFileSizeFree;
  final subscriptionState = ref.watch(subscriptionProvider);
  if (subscriptionState.isProPlus) return AppConstants.maxFileSizeProPlus;
  if (subscriptionState.isPremium) return AppConstants.maxFileSizePro;
  return AppConstants.maxFileSizeFree;
});

/// Debug: simulate Free plan to test limits. Only visible in debug builds.
final debugFreeModProvider = StateProvider<bool>((ref) => false);

/// Effective premium check — respects debug free mode.
final effectiveIsPremiumProvider = Provider<bool>((ref) {
  if (ref.watch(debugFreeModProvider)) return false;
  return ref.watch(subscriptionProvider).isPremium;
});

/// Effective Pro+ check — respects debug free mode.
final effectiveIsProPlusProvider = Provider<bool>((ref) {
  if (ref.watch(debugFreeModProvider)) return false;
  return ref.watch(subscriptionProvider).isProPlus;
});
