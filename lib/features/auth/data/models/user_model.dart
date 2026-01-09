import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    @JsonKey(fromJson: _idFromJson) required String id,
    required String email,
    String? name,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    @JsonKey(name: 'subscription_plan')
    @Default('free')
    String subscriptionPlan,
    @JsonKey(name: 'subscription_expires_at') DateTime? subscriptionExpiresAt,
    @JsonKey(name: 'daily_usage_count') @Default(0) int dailyUsageCount,
    @JsonKey(name: 'last_usage_date') DateTime? lastUsageDate,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}

// Helper to convert int or String id to String
String _idFromJson(dynamic id) => id.toString();

@freezed
class AuthResponse with _$AuthResponse {
  const factory AuthResponse({
    @JsonKey(name: 'access_token') required String accessToken,
    @JsonKey(name: 'refresh_token') String? refreshToken,
    required UserModel user,
    @JsonKey(name: 'expires_in') required int expiresIn,
  }) = _AuthResponse;

  factory AuthResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseFromJson(json);
}

@freezed
class LoginRequest with _$LoginRequest {
  const factory LoginRequest({
    required String email,
    required String password,
  }) = _LoginRequest;

  factory LoginRequest.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestFromJson(json);
}

@freezed
class RegisterRequest with _$RegisterRequest {
  const factory RegisterRequest({
    required String email,
    required String password,
    @JsonKey(name: 'password_confirmation')
    required String passwordConfirmation,
    String? name,
  }) = _RegisterRequest;

  factory RegisterRequest.fromJson(Map<String, dynamic> json) =>
      _$RegisterRequestFromJson(json);
}

@freezed
class AppleAuthRequest with _$AppleAuthRequest {
  const factory AppleAuthRequest({
    @JsonKey(name: 'identity_token') required String identityToken,
    @JsonKey(name: 'authorization_code') required String authorizationCode,
    String? email,
    @JsonKey(name: 'full_name') String? fullName,
  }) = _AppleAuthRequest;

  factory AppleAuthRequest.fromJson(Map<String, dynamic> json) =>
      _$AppleAuthRequestFromJson(json);
}
