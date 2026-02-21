import 'package:freezed_annotation/freezed_annotation.dart';

part 'subscription_model.freezed.dart';
part 'subscription_model.g.dart';

enum SubscriptionPlan {
  @JsonValue('free')
  free,
  @JsonValue('pro')
  pro,
  @JsonValue('pro_plus')
  proPlus,
}

enum SubscriptionStatus {
  @JsonValue('active')
  active,
  @JsonValue('cancelled')
  cancelled,
  @JsonValue('expired')
  expired,
  @JsonValue('pending')
  pending,
}

enum BillingPeriod {
  @JsonValue('monthly')
  monthly,
  @JsonValue('yearly')
  yearly,
}

@freezed
class SubscriptionModel with _$SubscriptionModel {
  const SubscriptionModel._();

  const factory SubscriptionModel({
    required String id,
    @JsonKey(name: 'user_id') int? userId,
    @JsonKey(name: 'device_id') String? deviceId,
    required SubscriptionPlan plan,
    required SubscriptionStatus status,
    @JsonKey(name: 'billing_period')
    @Default(BillingPeriod.monthly)
    BillingPeriod billingPeriod,
    @JsonKey(name: 'start_date') required DateTime startDate,
    @JsonKey(name: 'end_date') DateTime? endDate,
    @JsonKey(name: 'apple_transaction_id') String? appleTransactionId,
    @JsonKey(name: 'apple_original_transaction_id')
    String? appleOriginalTransactionId,
    @JsonKey(name: 'apple_product_id') String? appleProductId,
    @JsonKey(name: 'is_auto_renewing') required bool isAutoRenewing,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _SubscriptionModel;

  factory SubscriptionModel.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionModelFromJson(json);

  bool get isActive => status == SubscriptionStatus.active;
  bool get isPro =>
      plan == SubscriptionPlan.pro || plan == SubscriptionPlan.proPlus;
  bool get isProPlus => plan == SubscriptionPlan.proPlus;
  bool get isFree => plan == SubscriptionPlan.free;
  bool get isYearly => billingPeriod == BillingPeriod.yearly;
  bool get isMonthly => billingPeriod == BillingPeriod.monthly;

  int get pagesPerDoc {
    switch (plan) {
      case SubscriptionPlan.free:
        return 5;
      case SubscriptionPlan.pro:
      case SubscriptionPlan.proPlus:
        return -1; // Unlimited
    }
  }
}

@freezed
class SubscriptionPlanInfo with _$SubscriptionPlanInfo {
  const factory SubscriptionPlanInfo({
    required String id,
    required String name,
    required String description,
    @JsonKey(name: 'monthly_price') required double monthlyPrice,
    @JsonKey(name: 'yearly_price') required double yearlyPrice,
    required List<String> features,
    @JsonKey(name: 'is_popular') required bool isPopular,
    @JsonKey(name: 'plan_type') required SubscriptionPlan planType,
  }) = _SubscriptionPlanInfo;

  factory SubscriptionPlanInfo.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionPlanInfoFromJson(json);
}

@freezed
class UsageModel with _$UsageModel {
  const UsageModel._();

  const factory UsageModel({
    @JsonKey(name: 'total_used') required int totalUsed,
    @JsonKey(name: 'free_limit') required int freeLimit,
    @JsonKey(name: 'is_premium') required bool isPremium,
    @JsonKey(name: 'total_docs_processed') required int totalDocsProcessed,
    @JsonKey(name: 'total_summaries_generated')
    required int totalSummariesGenerated,
  }) = _UsageModel;

  factory UsageModel.fromJson(Map<String, dynamic> json) =>
      _$UsageModelFromJson(json);

  bool get hasReachedFreeLimit => !isPremium && totalUsed >= freeLimit;

  int get remainingFree =>
      isPremium ? -1 : (freeLimit - totalUsed).clamp(0, freeLimit);

  double get usagePercentage =>
      freeLimit > 0 ? (totalUsed / freeLimit).clamp(0.0, 1.0) : 0;
}

@freezed
class VerifyPurchaseRequest with _$VerifyPurchaseRequest {
  const factory VerifyPurchaseRequest({
    required String productId,
    required String transactionId,
    required String receiptData,
  }) = _VerifyPurchaseRequest;

  factory VerifyPurchaseRequest.fromJson(Map<String, dynamic> json) =>
      _$VerifyPurchaseRequestFromJson(json);
}

@freezed
class VerifyPurchaseResponse with _$VerifyPurchaseResponse {
  const factory VerifyPurchaseResponse({
    required bool success,
    SubscriptionModel? subscription, // Nullable - not present on errors
    String? message,
  }) = _VerifyPurchaseResponse;

  factory VerifyPurchaseResponse.fromJson(Map<String, dynamic> json) =>
      _$VerifyPurchaseResponseFromJson(json);
}
