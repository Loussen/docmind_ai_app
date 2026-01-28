import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/dio_client.dart';

final guestRepositoryProvider = Provider<GuestRepository>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return GuestRepository(dioClient);
});

class GuestRepository {
  final DioClient _dioClient;

  GuestRepository(this._dioClient);

  Future<Either<String, Map<String, dynamic>>> summarizeDocument({
    required File file,
    required String deviceId,
  }) async {
    try {
      final formData = FormData.fromMap({
        'document': await MultipartFile.fromFile(
          file.path,
          filename: file.path.split('/').last,
        ),
        'device_id': deviceId,
      });

      final response = await _dioClient.uploadFile(
        '/guest/summarize',
        formData: formData,
      );

      return Right(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      final data = e.response?.data;
      if (data is Map<String, dynamic>) {
        final message = data['message'] ?? 'Failed to process document';
        final limitReached = data['limit_reached'] ?? false;
        
        if (limitReached == true) {
          return Left('LIMIT_REACHED:$message');
        }
        return Left(message);
      }
      return const Left('Failed to process document');
    } catch (e) {
      return const Left('An unexpected error occurred');
    }
  }

  Future<Either<String, Map<String, dynamic>>> checkUsage({
    required String deviceId,
  }) async {
    try {
      final response = await _dioClient.post(
        '/guest/check-usage',
        data: {'device_id': deviceId},
      );

      return Right(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      final data = e.response?.data;
      if (data is Map<String, dynamic>) {
        final message = data['message'] ?? 'Failed to check usage';
        return Left(message);
      }
      return const Left('Failed to check usage');
    } catch (e) {
      return const Left('An unexpected error occurred');
    }
  }
}
