import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/document_model.dart';
import '../../data/repositories/document_repository.dart';
import '../../../../core/services/tiktok_analytics_service.dart';
import '../../../../l10n/app_localizations.dart';

enum UploadStatus { idle, selecting, uploading, processing, analyzing, success, error }

enum ProcessingStep { upload, extractText, analyze, complete }

class UploadState {
  final UploadStatus status;
  final File? selectedFile;
  final String? fileName;
  final double uploadProgress;
  final DocumentModel? uploadedDocument;
  final String? errorMessage;
  final ProcessingStep currentStep;

  const UploadState({
    this.status = UploadStatus.idle,
    this.selectedFile,
    this.fileName,
    this.uploadProgress = 0,
    this.uploadedDocument,
    this.errorMessage,
    this.currentStep = ProcessingStep.upload,
  });

  UploadState copyWith({
    UploadStatus? status,
    File? selectedFile,
    String? fileName,
    double? uploadProgress,
    DocumentModel? uploadedDocument,
    String? errorMessage,
    ProcessingStep? currentStep,
  }) {
    return UploadState(
      status: status ?? this.status,
      selectedFile: selectedFile ?? this.selectedFile,
      fileName: fileName ?? this.fileName,
      uploadProgress: uploadProgress ?? this.uploadProgress,
      uploadedDocument: uploadedDocument ?? this.uploadedDocument,
      errorMessage: errorMessage ?? this.errorMessage,
      currentStep: currentStep ?? this.currentStep,
    );
  }

  bool get isUploading => status == UploadStatus.uploading;
  bool get isProcessing => status == UploadStatus.processing || status == UploadStatus.analyzing;
  bool get isWorking => isUploading || isProcessing;
  bool get hasFile => selectedFile != null;
}

class UploadNotifier extends StateNotifier<UploadState> {
  final DocumentRepository _documentRepository;

  UploadNotifier(this._documentRepository) : super(const UploadState());

  void selectFile(File file, String fileName) {
    state = UploadState(
      status: UploadStatus.selecting,
      selectedFile: file,
      fileName: fileName,
    );
  }

  Future<DocumentModel?> uploadDocument() async {
    if (state.selectedFile == null) return null;

    state = state.copyWith(
      status: UploadStatus.uploading,
      uploadProgress: 0,
      currentStep: ProcessingStep.upload,
    );

    final result = await _documentRepository.uploadDocument(
      file: state.selectedFile!,
      fileName: state.fileName ?? 'document',
      onProgress: (sent, total) {
        state = state.copyWith(uploadProgress: sent / total);
      },
    );

    return result.fold(
      (error) {
        state = state.copyWith(
          status: UploadStatus.error,
          errorMessage: error,
        );
        return null;
      },
      (document) {
        state = state.copyWith(
          status: UploadStatus.processing,
          uploadedDocument: document,
          currentStep: ProcessingStep.extractText,
        );
        TikTokAnalyticsService.instance.logDocumentUploaded(
          documentId: document.id,
          fileType: document.type.name,
        );
        return document;
      },
    );
  }

  void setAnalyzing() {
    state = state.copyWith(
      status: UploadStatus.analyzing,
      currentStep: ProcessingStep.analyze,
    );
  }

  void setComplete() {
    state = state.copyWith(
      status: UploadStatus.success,
      currentStep: ProcessingStep.complete,
    );
  }

  void reset() {
    state = const UploadState();
  }

  void clearError() {
    state = state.copyWith(errorMessage: null, status: UploadStatus.idle);
  }

  void setError(String message) {
    state = state.copyWith(
      status: UploadStatus.error,
      errorMessage: message,
    );
  }
}

final uploadProvider = StateNotifierProvider<UploadNotifier, UploadState>((ref) {
  final repository = ref.watch(documentRepositoryProvider);
  return UploadNotifier(repository);
});

// Filter types
enum DocumentFilterType { all, pdf, docx, image }

extension DocumentFilterTypeExtension on DocumentFilterType {
  String get value {
    switch (this) {
      case DocumentFilterType.all:
        return 'all';
      case DocumentFilterType.pdf:
        return 'pdf';
      case DocumentFilterType.docx:
        return 'docx';
      case DocumentFilterType.image:
        return 'image';
    }
  }

  String label(BuildContext context) {
    switch (this) {
      case DocumentFilterType.all:
        return S.of(context)!.allDocuments;
      case DocumentFilterType.pdf:
        return S.of(context)!.pdfOnly;
      case DocumentFilterType.docx:
        return S.of(context)!.wordOnly;
      case DocumentFilterType.image:
        return S.of(context)!.imagesOnly;
    }
  }
}

// Documents list state
class DocumentsState {
  final List<DocumentModel> documents;
  final bool isLoading;
  final bool hasMore;
  final int currentPage;
  final String? errorMessage;
  final DocumentFilterType filterType;
  final String? searchQuery;

  const DocumentsState({
    this.documents = const [],
    this.isLoading = false,
    this.hasMore = true,
    this.currentPage = 1,
    this.errorMessage,
    this.filterType = DocumentFilterType.all,
    this.searchQuery,
  });

  DocumentsState copyWith({
    List<DocumentModel>? documents,
    bool? isLoading,
    bool? hasMore,
    int? currentPage,
    String? errorMessage,
    DocumentFilterType? filterType,
    String? searchQuery,
  }) {
    return DocumentsState(
      documents: documents ?? this.documents,
      isLoading: isLoading ?? this.isLoading,
      hasMore: hasMore ?? this.hasMore,
      currentPage: currentPage ?? this.currentPage,
      errorMessage: errorMessage ?? this.errorMessage,
      filterType: filterType ?? this.filterType,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}

class DocumentsNotifier extends StateNotifier<DocumentsState> {
  final DocumentRepository _documentRepository;

  DocumentsNotifier(this._documentRepository) : super(const DocumentsState());

  Future<void> loadDocuments({bool refresh = false}) async {
    if (state.isLoading) return;
    if (!refresh && !state.hasMore) return;

    final page = refresh ? 1 : state.currentPage;
    state = state.copyWith(isLoading: true);

    final result = await _documentRepository.getDocuments(
      page: page,
      type: state.filterType.value,
      search: state.searchQuery,
    );

    result.fold(
      (error) {
        state = state.copyWith(
          isLoading: false,
          errorMessage: error,
        );
      },
      (documents) {
        state = state.copyWith(
          documents: refresh ? documents : [...state.documents, ...documents],
          isLoading: false,
          hasMore: documents.length >= 20,
          currentPage: page + 1,
        );
      },
    );
  }

  Future<void> setFilter(DocumentFilterType filterType) async {
    if (state.filterType == filterType) return;
    
    state = state.copyWith(
      filterType: filterType,
      documents: [],
      currentPage: 1,
      hasMore: true,
    );
    
    await loadDocuments(refresh: true);
  }

  Future<void> setSearch(String? query) async {
    state = state.copyWith(
      searchQuery: query,
      documents: [],
      currentPage: 1,
      hasMore: true,
    );
    
    await loadDocuments(refresh: true);
  }

  void clearFilters() {
    state = state.copyWith(
      filterType: DocumentFilterType.all,
      searchQuery: null,
      documents: [],
      currentPage: 1,
      hasMore: true,
    );
    loadDocuments(refresh: true);
  }

  void clearAll() {
    state = const DocumentsState();
  }

  Future<void> deleteDocument(String id) async {
    final result = await _documentRepository.deleteDocument(id);
    result.fold(
      (error) {
        state = state.copyWith(errorMessage: error);
      },
      (_) {
        state = state.copyWith(
          documents: state.documents.where((doc) => doc.id != id).toList(),
        );
      },
    );
  }

  void addDocument(DocumentModel document) {
    state = state.copyWith(
      documents: [document, ...state.documents],
    );
  }

  void updateDocument(DocumentModel document) {
    state = state.copyWith(
      documents: state.documents.map((doc) {
        return doc.id == document.id ? document : doc;
      }).toList(),
    );
  }
}

final documentsProvider = StateNotifierProvider<DocumentsNotifier, DocumentsState>((ref) {
  final repository = ref.watch(documentRepositoryProvider);
  return DocumentsNotifier(repository);
});

// Single document provider
final documentProvider = FutureProvider.family<DocumentModel?, String>((ref, id) async {
  final repository = ref.watch(documentRepositoryProvider);
  final result = await repository.getDocument(id);
  return result.fold((error) => null, (document) => document);
});

// Recent documents provider
final recentDocumentsProvider = Provider<List<DocumentModel>>((ref) {
  final documentsState = ref.watch(documentsProvider);
  return documentsState.documents.take(5).toList();
});

