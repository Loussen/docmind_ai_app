import 'package:freezed_annotation/freezed_annotation.dart';

part 'document_model.freezed.dart';
part 'document_model.g.dart';

enum DocumentType {
  @JsonValue('pdf')
  pdf,
  @JsonValue('docx')
  docx,
  @JsonValue('doc')
  doc,
  @JsonValue('image')
  image,
}

enum DocumentStatus {
  @JsonValue('pending')
  pending,
  @JsonValue('processing')
  processing,
  @JsonValue('completed')
  completed,
  @JsonValue('failed')
  failed,
}

@freezed
class DocumentModel with _$DocumentModel {
  const DocumentModel._();

  const factory DocumentModel({
    required String id,
    @JsonKey(name: 'user_id') int? userId,
    @JsonKey(name: 'device_id') String? deviceId,
    @JsonKey(name: 'file_name') required String fileName,
    @JsonKey(name: 'original_name') required String originalName,
    required DocumentType type,
    @JsonKey(name: 'file_size') required int fileSize,
    @JsonKey(name: 'page_count') required int pageCount,
    @Default(DocumentStatus.pending) DocumentStatus status,
    @JsonKey(name: 'file_path') String? filePath,
    @JsonKey(name: 'extracted_text') String? extractedText,
    @JsonKey(name: 'thumbnail_url') String? thumbnailUrl,
    @JsonKey(name: 'summary_id') String? summaryId,
    @JsonKey(name: 'error_message') String? errorMessage,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
    @JsonKey(name: 'processed_at') DateTime? processedAt,
  }) = _DocumentModel;

  factory DocumentModel.fromJson(Map<String, dynamic> json) =>
      _$DocumentModelFromJson(json);

  String get fileExtension {
    switch (type) {
      case DocumentType.pdf:
        return 'PDF';
      case DocumentType.docx:
      case DocumentType.doc:
        return 'DOC';
      case DocumentType.image:
        return 'IMG';
    }
  }

  String get fileSizeFormatted {
    if (fileSize < 1024) {
      return '$fileSize B';
    } else if (fileSize < 1024 * 1024) {
      return '${(fileSize / 1024).toStringAsFixed(1)} KB';
    } else {
      return '${(fileSize / (1024 * 1024)).toStringAsFixed(1)} MB';
    }
  }

  bool get isProcessing => status == DocumentStatus.processing;
  bool get isCompleted => status == DocumentStatus.completed;
  bool get hasFailed => status == DocumentStatus.failed;
  bool get hasSummary => summaryId != null;
}

@freezed
class UploadDocumentRequest with _$UploadDocumentRequest {
  const factory UploadDocumentRequest({
    required String filePath,
    required String fileName,
    required String mimeType,
  }) = _UploadDocumentRequest;

  factory UploadDocumentRequest.fromJson(Map<String, dynamic> json) =>
      _$UploadDocumentRequestFromJson(json);
}

@freezed
class DocumentListResponse with _$DocumentListResponse {
  const factory DocumentListResponse({
    required List<DocumentModel> data,
    required PaginationMeta meta,
  }) = _DocumentListResponse;

  factory DocumentListResponse.fromJson(Map<String, dynamic> json) =>
      _$DocumentListResponseFromJson(json);
}

@freezed
class PaginationMeta with _$PaginationMeta {
  const factory PaginationMeta({
    @JsonKey(name: 'current_page') required int currentPage,
    @JsonKey(name: 'last_page') required int lastPage,
    @JsonKey(name: 'per_page') required int perPage,
    required int total,
  }) = _PaginationMeta;

  factory PaginationMeta.fromJson(Map<String, dynamic> json) =>
      _$PaginationMetaFromJson(json);
}
