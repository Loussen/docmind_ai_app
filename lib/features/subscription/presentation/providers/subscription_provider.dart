import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

import '../../../../core/constants/app_constants.dart';
import '../../data/models/subscription_model.dart';
import '../../data/repositories/subscription_repository.dart';

// Subscription state
class SubscriptionState {
  final SubscriptionModel? subscription;
  final UsageModel? usage;
  final List<SubscriptionPlanInfo> plans;
  final bool isLoading;
  final bool isPurchasing;
  final String? errorMessage;

  const SubscriptionState({
    this.subscription,
    this.usage,
    this.plans = const [],
    this.isLoading = false,
    this.isPurchasing = false,
    this.errorMessage,
  });

  SubscriptionState copyWith({
    SubscriptionModel? subscription,
    UsageModel? usage,
    List<SubscriptionPlanInfo>? plans,
    bool? isLoading,
    bool? isPurchasing,
    String? errorMessage,
  }) {
    return SubscriptionState(
      subscription: subscription ?? this.subscription,
      usage: usage ?? this.usage,
      plans: plans ?? this.plans,
      isLoading: isLoading ?? this.isLoading,
      isPurchasing: isPurchasing ?? this.isPurchasing,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  bool get isPremium =>
      subscription?.isPro == true && subscription?.isActive == true;
  bool get isProPlus =>
      subscription?.isProPlus == true && subscription?.isActive == true;
  bool get canUploadDocument =>
      isPremium || (usage?.hasReachedDailyLimit != true);
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
  }

  void _onPurchaseUpdate(List<PurchaseDetails> purchases) async {
    for (final purchase in purchases) {
      if (purchase.status == PurchaseStatus.purchased ||
          purchase.status == PurchaseStatus.restored) {
        await _verifyPurchase(purchase);
      } else if (purchase.status == PurchaseStatus.error) {
        state = state.copyWith(
          isPurchasing: false,
          errorMessage: purchase.error?.message ?? 'Purchase failed',
        );
      } else if (purchase.status == PurchaseStatus.canceled) {
        state = state.copyWith(isPurchasing: false);
      }

      if (purchase.pendingCompletePurchase) {
        await _inAppPurchase.completePurchase(purchase);
      }
    }
  }

  Future<void> _verifyPurchase(PurchaseDetails purchase) async {
    final result = await _subscriptionRepository.verifyPurchase(
      productId: purchase.productID,
      transactionId: purchase.purchaseID ?? '',
      receiptData: purchase.verificationData.serverVerificationData,
    );

    result.fold(
      (error) {
        state = state.copyWith(
          isPurchasing: false,
          errorMessage: error,
        );
      },
      (response) {
        if (response.success) {
          state = state.copyWith(
            subscription: response.subscription,
            isPurchasing: false,
          );
        } else {
          state = state.copyWith(
            isPurchasing: false,
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
    final purchaseParam = PurchaseParam(productDetails: product);
    await _inAppPurchase.buyNonConsumable(purchaseParam: purchaseParam);
  }

  Future<void> restorePurchases() async {
    state = state.copyWith(isPurchasing: true);
    await _inAppPurchase.restorePurchases();
  }

  void clearError() {
    state = state.copyWith(errorMessage: null);
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
  final subscriptionState = ref.watch(subscriptionProvider);
  return subscriptionState.canUploadDocument;
});

// Remaining docs provider
final remainingDocsProvider = Provider<int>((ref) {
  final subscriptionState = ref.watch(subscriptionProvider);
  if (subscriptionState.isPremium) return -1;
  return subscriptionState.usage?.remainingDocs ?? AppConstants.freeDocsPerDay;
});

