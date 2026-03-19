import 'package:freezed_annotation/freezed_annotation.dart';

part 'settings_model.freezed.dart';
part 'settings_model.g.dart';

@freezed
class SettingsModel with _$SettingsModel {
  const factory SettingsModel({
    @JsonKey(name: 'notifications_enabled') @Default(true) bool notificationsEnabled,
    @JsonKey(name: 'dark_mode_enabled') @Default(false) bool darkModeEnabled,
    // App UI language (BCP-47, e.g. en, en-GB, tr, zh-Hans)
    @JsonKey(name: 'ui_language') @Default('en') String uiLanguage,
    // Back-compat: older backend key
    @JsonKey(name: 'language') String? legacyLanguage,
    // AI output language (BCP-47). Used for summaries/translations.
    @JsonKey(name: 'output_language') @Default('en') String outputLanguage,
  }) = _SettingsModel;

  factory SettingsModel.fromJson(Map<String, dynamic> json) =>
      _$SettingsModelFromJson(json);
}
