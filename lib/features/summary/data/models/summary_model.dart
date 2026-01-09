import 'package:freezed_annotation/freezed_annotation.dart';

part 'summary_model.freezed.dart';
part 'summary_model.g.dart';

@freezed
class SummaryModel with _$SummaryModel {
  const SummaryModel._();

  const factory SummaryModel({
    required String id,
    @JsonKey(name: 'document_id') required String documentId,
    @JsonKey(name: 'user_id') required int userId,
    required String title,
    required String overview,
    @JsonKey(name: 'key_points') required List<String> keyPoints,
    @JsonKey(name: 'action_items') required List<String> actionItems,
    required List<String> keywords,
    @JsonKey(name: 'important_facts') String? importantFacts,
    String? obligations,
    String? risks,
    String? findings,
    @JsonKey(name: 'word_count') required int wordCount,
    @JsonKey(name: 'processing_time_ms') required int processingTimeMs,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _SummaryModel;

  factory SummaryModel.fromJson(Map<String, dynamic> json) =>
      _$SummaryModelFromJson(json);

  bool get hasActionItems => actionItems.isNotEmpty;
  bool get hasObligations => obligations != null && obligations!.isNotEmpty;
  bool get hasRisks => risks != null && risks!.isNotEmpty;
  bool get hasFindings => findings != null && findings!.isNotEmpty;
}

@freezed
class SummarySection with _$SummarySection {
  const factory SummarySection({
    required String title,
    required SummarySectionType type,
    required dynamic content,
    String? icon,
  }) = _SummarySection;

  factory SummarySection.fromJson(Map<String, dynamic> json) =>
      _$SummarySectionFromJson(json);
}

enum SummarySectionType {
  overview,
  keyPoints,
  actionItems,
  keywords,
  facts,
  obligations,
  risks,
  findings,
}

@freezed
class GenerateSummaryRequest with _$GenerateSummaryRequest {
  const factory GenerateSummaryRequest({
    required String documentId,
    @Default('standard') String summaryType,
    @Default('en') String language,
  }) = _GenerateSummaryRequest;

  factory GenerateSummaryRequest.fromJson(Map<String, dynamic> json) =>
      _$GenerateSummaryRequestFromJson(json);
}

@freezed
class SummaryListResponse with _$SummaryListResponse {
  const factory SummaryListResponse({
    required List<SummaryModel> data,
    required int total,
    required int page,
    required int perPage,
  }) = _SummaryListResponse;

  factory SummaryListResponse.fromJson(Map<String, dynamic> json) =>
      _$SummaryListResponseFromJson(json);
}
