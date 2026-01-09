import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../../core/constants/api_constants.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/network/dio_client.dart';
import '../models/user_model.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return AuthRepository(dioClient);
});

class AuthRepository {
  final DioClient _dioClient;
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  AuthRepository(this._dioClient);

  Future<Either<String, AuthResponse>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dioClient.post(
        ApiConstants.login,
        data: {
          'email': email,
          'password': password,
        },
      );

      final authResponse = AuthResponse.fromJson(response.data);
      await _saveTokens(authResponse);
      return Right(authResponse);
    } on DioException catch (e) {
      return Left(e.error?.toString() ?? 'Login failed');
    } catch (e) {
      return Left('An unexpected error occurred');
    }
  }

  Future<Either<String, AuthResponse>> register({
    required String email,
    required String password,
    required String passwordConfirmation,
    String? name,
  }) async {
    try {
      final response = await _dioClient.post(
        ApiConstants.register,
        data: {
          'email': email,
          'password': password,
          'password_confirmation': passwordConfirmation,
          if (name != null) 'name': name,
        },
      );

      final authResponse = AuthResponse.fromJson(response.data);
      await _saveTokens(authResponse);
      return Right(authResponse);
    } on DioException catch (e) {
      return Left(e.error?.toString() ?? 'Registration failed');
    } catch (e) {
      return Left('An unexpected error occurred');
    }
  }

  Future<Either<String, AuthResponse>> signInWithApple({
    required String identityToken,
    required String authorizationCode,
    String? email,
    String? fullName,
  }) async {
    try {
      final response = await _dioClient.post(
        ApiConstants.appleAuth,
        data: {
          'identity_token': identityToken,
          'authorization_code': authorizationCode,
          if (email != null) 'email': email,
          if (fullName != null) 'full_name': fullName,
        },
      );

      final authResponse = AuthResponse.fromJson(response.data);
      await _saveTokens(authResponse);
      return Right(authResponse);
    } on DioException catch (e) {
      return Left(e.error?.toString() ?? 'Apple sign-in failed');
    } catch (e) {
      return Left('An unexpected error occurred');
    }
  }

  Future<Either<String, UserModel>> getCurrentUser() async {
    try {
      final response = await _dioClient.get(ApiConstants.me);
      return Right(UserModel.fromJson(response.data['user']));
    } on DioException catch (e) {
      return Left(e.error?.toString() ?? 'Failed to fetch user');
    } catch (e) {
      return Left('An unexpected error occurred');
    }
  }

  Future<Either<String, void>> logout() async {
    try {
      await _dioClient.post(ApiConstants.logout);
      await _clearTokens();
      return const Right(null);
    } on DioException catch (e) {
      await _clearTokens();
      return Left(e.error?.toString() ?? 'Logout failed');
    } catch (e) {
      await _clearTokens();
      return Left('An unexpected error occurred');
    }
  }

  Future<bool> isLoggedIn() async {
    final token = await _storage.read(key: AppConstants.authTokenKey);
    return token != null;
  }

  Future<String?> getToken() async {
    return await _storage.read(key: AppConstants.authTokenKey);
  }

  Future<void> _saveTokens(AuthResponse authResponse) async {
    await _storage.write(
      key: AppConstants.authTokenKey,
      value: authResponse.accessToken,
    );
    if (authResponse.refreshToken != null) {
      await _storage.write(
        key: AppConstants.refreshTokenKey,
        value: authResponse.refreshToken,
      );
    }
  }

  Future<void> _clearTokens() async {
    await _storage.delete(key: AppConstants.authTokenKey);
    await _storage.delete(key: AppConstants.refreshTokenKey);
    await _storage.delete(key: AppConstants.userDataKey);
  }
}

