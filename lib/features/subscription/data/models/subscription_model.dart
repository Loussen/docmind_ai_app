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

@freezed
class SubscriptionModel with _$SubscriptionModel {
  const SubscriptionModel._();

  const factory SubscriptionModel({
    required String id,
    required String userId,
    required SubscriptionPlan plan,
    required SubscriptionStatus status,
    required DateTime startDate,
    DateTime? endDate,
    String? appleTransactionId,
    String? appleOriginalTransactionId,
    required bool isAutoRenewing,
    required DateTime createdAt,
    DateTime? updatedAt,
  }) = _SubscriptionModel;

  factory SubscriptionModel.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionModelFromJson(json);

  bool get isActive => status == SubscriptionStatus.active;
  bool get isPro => plan == SubscriptionPlan.pro || plan == SubscriptionPlan.proPlus;
  bool get isProPlus => plan == SubscriptionPlan.proPlus;
  bool get isFree => plan == SubscriptionPlan.free;

  int get docsPerDay {
    switch (plan) {
      case SubscriptionPlan.free:
        return 3;
      case SubscriptionPlan.pro:
      case SubscriptionPlan.proPlus:
        return -1; // Unlimited
    }
  }

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
    required double monthlyPrice,
    required double yearlyPrice,
    required List<String> features,
    required bool isPopular,
    required SubscriptionPlan planType,
  }) = _SubscriptionPlanInfo;

  factory SubscriptionPlanInfo.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionPlanInfoFromJson(json);
}

@freezed
class UsageModel with _$UsageModel {
  const UsageModel._();

  const factory UsageModel({
    required int dailyDocsUsed,
    required int dailyDocsLimit,
    required int totalDocsProcessed,
    required int totalSummariesGenerated,
    required DateTime lastResetDate,
  }) = _UsageModel;

  factory UsageModel.fromJson(Map<String, dynamic> json) =>
      _$UsageModelFromJson(json);

  bool get hasReachedDailyLimit => 
      dailyDocsLimit > 0 && dailyDocsUsed >= dailyDocsLimit;

  int get remainingDocs => 
      dailyDocsLimit > 0 ? dailyDocsLimit - dailyDocsUsed : -1;

  double get usagePercentage => 
      dailyDocsLimit > 0 ? dailyDocsUsed / dailyDocsLimit : 0;
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
    required SubscriptionModel subscription,
    String? message,
  }) = _VerifyPurchaseResponse;

  factory VerifyPurchaseResponse.fromJson(Map<String, dynamic> json) =>
      _$VerifyPurchaseResponseFromJson(json);
}

