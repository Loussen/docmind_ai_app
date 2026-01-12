import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/api_constants.dart';
import '../../../../core/network/dio_client.dart';
import '../models/settings_model.dart';

final settingsRepositoryProvider = Provider<SettingsRepository>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return SettingsRepository(dioClient);
});

class SettingsRepository {
  final DioClient _dioClient;

  SettingsRepository(this._dioClient);

  Future<Either<String, SettingsModel>> getSettings() async {
    try {
      final response = await _dioClient.get(ApiConstants.settings);
      return Right(SettingsModel.fromJson(response.data['settings']));
    } on DioException catch (e) {
      return Left(e.error?.toString() ?? 'Failed to fetch settings');
    } catch (e) {
      return Left('An unexpected error occurred');
    }
  }

  Future<Either<String, SettingsModel>> updateSettings({
    bool? notificationsEnabled,
    bool? darkModeEnabled,
    String? language,
  }) async {
    try {
      final data = <String, dynamic>{};
      if (notificationsEnabled != null) {
        data['notifications_enabled'] = notificationsEnabled;
      }
      if (darkModeEnabled != null) {
        data['dark_mode_enabled'] = darkModeEnabled;
      }
      if (language != null) {
        data['language'] = language;
      }

      final response = await _dioClient.put(
        ApiConstants.settings,
        data: data,
      );
      return Right(SettingsModel.fromJson(response.data['settings']));
    } on DioException catch (e) {
      return Left(e.error?.toString() ?? 'Failed to update settings');
    } catch (e) {
      return Left('An unexpected error occurred');
    }
  }
}
