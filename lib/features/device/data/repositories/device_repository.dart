import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/api_constants.dart';
import '../../../../core/network/dio_client.dart';

final deviceRepositoryProvider = Provider<DeviceRepository>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return DeviceRepository(dioClient);
});

class DeviceRepository {
  final DioClient _dioClient;

  DeviceRepository(this._dioClient);

  Future<Either<String, Map<String, dynamic>>> registerDevice({
    required String deviceId,
    String platform = 'ios',
    String? model,
    String? osVersion,
  }) async {
    try {
      final response = await _dioClient.post(
        ApiConstants.deviceRegister,
        data: {
          'device_id': deviceId,
          'platform': platform,
          if (model != null) 'model': model,
          if (osVersion != null) 'os_version': osVersion,
        },
      );

      return Right(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      return Left(e.error?.toString() ?? 'Device registration failed');
    } catch (e) {
      return Left('An unexpected error occurred');
    }
  }

  Future<Either<String, Map<String, dynamic>>> syncDevice() async {
    try {
      final response = await _dioClient.get(ApiConstants.deviceSync);
      return Right(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      return Left(e.error?.toString() ?? 'Device sync failed');
    } catch (e) {
      return Left('An unexpected error occurred');
    }
  }

  Future<Either<String, void>> deleteAllData() async {
    try {
      await _dioClient.delete(ApiConstants.deviceDeleteData);
      return const Right(null);
    } on DioException catch (e) {
      return Left(e.error?.toString() ?? 'Failed to delete data');
    } catch (e) {
      return Left('An unexpected error occurred');
    }
  }
}
