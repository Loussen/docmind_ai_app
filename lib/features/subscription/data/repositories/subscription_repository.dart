import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/api_constants.dart';
import '../../../../core/network/dio_client.dart';
import '../models/subscription_model.dart';

final subscriptionRepositoryProvider = Provider<SubscriptionRepository>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return SubscriptionRepository(dioClient);
});

class SubscriptionRepository {
  final DioClient _dioClient;

  SubscriptionRepository(this._dioClient);

  Future<Either<String, SubscriptionModel>> getSubscription() async {
    try {
      final response = await _dioClient.get(ApiConstants.subscription);
      return Right(SubscriptionModel.fromJson(response.data['subscription']));
    } on DioException catch (e) {
      return Left(e.error?.toString() ?? 'Failed to fetch subscription');
    } catch (e) {
      return Left('An unexpected error occurred');
    }
  }

  Future<Either<String, List<SubscriptionPlanInfo>>> getPlans() async {
    try {
      final response = await _dioClient.get(ApiConstants.plans);
      final plans = (response.data['plans'] as List)
          .map((plan) => SubscriptionPlanInfo.fromJson(plan))
          .toList();
      return Right(plans);
    } on DioException catch (e) {
      return Left(e.error?.toString() ?? 'Failed to fetch plans');
    } catch (e) {
      return Left('An unexpected error occurred');
    }
  }

  Future<Either<String, VerifyPurchaseResponse>> verifyPurchase({
    required String productId,
    required String transactionId,
    required String receiptData,
  }) async {
    try {
      final response = await _dioClient.post(
        ApiConstants.verifyPurchase,
        data: {
          'product_id': productId,
          'transaction_id': transactionId,
          'receipt_data': receiptData,
        },
      );

      return Right(VerifyPurchaseResponse.fromJson(response.data));
    } on DioException catch (e) {
      return Left(e.error?.toString() ?? 'Purchase verification failed');
    } catch (e) {
      return Left('An unexpected error occurred');
    }
  }

  Future<Either<String, UsageModel>> getUsage() async {
    try {
      final response = await _dioClient.get(ApiConstants.usage);
      return Right(UsageModel.fromJson(response.data['usage']));
    } on DioException catch (e) {
      return Left(e.error?.toString() ?? 'Failed to fetch usage');
    } catch (e) {
      return Left('An unexpected error occurred');
    }
  }

  Future<Either<String, void>> cancelSubscription() async {
    try {
      await _dioClient.post('${ApiConstants.subscription}/cancel');
      return const Right(null);
    } on DioException catch (e) {
      return Left(e.error?.toString() ?? 'Failed to cancel subscription');
    } catch (e) {
      return Left('An unexpected error occurred');
    }
  }
}

