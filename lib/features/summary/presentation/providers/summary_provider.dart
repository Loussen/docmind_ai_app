import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/summary_model.dart';
import '../../data/repositories/summary_repository.dart';
import '../../../../core/services/tiktok_analytics_service.dart';

// Summary generation state
enum SummaryGenerationStatus { idle, generating, success, error }

class SummaryGenerationState {
  final SummaryGenerationStatus status;
  final SummaryModel? summary;
  final String? errorMessage;
  final int? processingTimeMs;

  const SummaryGenerationState({
    this.status = SummaryGenerationStatus.idle,
    this.summary,
    this.errorMessage,
    this.processingTimeMs,
  });

  SummaryGenerationState copyWith({
    SummaryGenerationStatus? status,
    SummaryModel? summary,
    String? errorMessage,
    int? processingTimeMs,
  }) {
    return SummaryGenerationState(
      status: status ?? this.status,
      summary: summary ?? this.summary,
      errorMessage: errorMessage ?? this.errorMessage,
      processingTimeMs: processingTimeMs ?? this.processingTimeMs,
    );
  }

  bool get isGenerating => status == SummaryGenerationStatus.generating;
  bool get isSuccess => status == SummaryGenerationStatus.success;
  bool get hasError => status == SummaryGenerationStatus.error;
}

class SummaryGenerationNotifier extends StateNotifier<SummaryGenerationState> {
  final SummaryRepository _summaryRepository;

  SummaryGenerationNotifier(this._summaryRepository)
      : super(const SummaryGenerationState());

  Future<SummaryModel?> generateSummary({
    required String documentId,
    String summaryType = 'standard',
    String language = 'en',
  }) async {
    state = state.copyWith(status: SummaryGenerationStatus.generating);

    final startTime = DateTime.now();
    final result = await _summaryRepository.generateSummary(
      documentId: documentId,
      summaryType: summaryType,
      language: language,
    );
    final endTime = DateTime.now();

    return result.fold(
      (error) {
        state = state.copyWith(
          status: SummaryGenerationStatus.error,
          errorMessage: error,
        );
        return null;
      },
      (summary) {
        state = state.copyWith(
          status: SummaryGenerationStatus.success,
          summary: summary,
          processingTimeMs: endTime.difference(startTime).inMilliseconds,
        );
        TikTokAnalyticsService.instance.logSummaryGenerated(
          summaryId: summary.id,
          documentId: documentId,
        );
        return summary;
      },
    );
  }

  void reset() {
    state = const SummaryGenerationState();
  }

  void clearError() {
    state = state.copyWith(
      status: SummaryGenerationStatus.idle,
      errorMessage: null,
    );
  }
}

final summaryGenerationProvider =
    StateNotifierProvider<SummaryGenerationNotifier, SummaryGenerationState>(
        (ref) {
  final repository = ref.watch(summaryRepositoryProvider);
  return SummaryGenerationNotifier(repository);
});

// Single summary provider
final summaryProvider = FutureProvider.family<SummaryModel?, String>((ref, id) async {
  final repository = ref.watch(summaryRepositoryProvider);
  final result = await repository.getSummary(id);
  return result.fold((error) => null, (summary) => summary);
});

// Summaries list state
class SummariesState {
  final List<SummaryModel> summaries;
  final bool isLoading;
  final bool hasMore;
  final int currentPage;
  final String? errorMessage;

  const SummariesState({
    this.summaries = const [],
    this.isLoading = false,
    this.hasMore = true,
    this.currentPage = 1,
    this.errorMessage,
  });

  SummariesState copyWith({
    List<SummaryModel>? summaries,
    bool? isLoading,
    bool? hasMore,
    int? currentPage,
    String? errorMessage,
  }) {
    return SummariesState(
      summaries: summaries ?? this.summaries,
      isLoading: isLoading ?? this.isLoading,
      hasMore: hasMore ?? this.hasMore,
      currentPage: currentPage ?? this.currentPage,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class SummariesNotifier extends StateNotifier<SummariesState> {
  final SummaryRepository _summaryRepository;

  SummariesNotifier(this._summaryRepository) : super(const SummariesState());

  Future<void> loadSummaries({bool refresh = false}) async {
    if (state.isLoading) return;
    if (!refresh && !state.hasMore) return;

    final page = refresh ? 1 : state.currentPage;
    state = state.copyWith(isLoading: true);

    final result = await _summaryRepository.getSummaries(page: page);

    result.fold(
      (error) {
        state = state.copyWith(
          isLoading: false,
          errorMessage: error,
        );
      },
      (summaries) {
        state = state.copyWith(
          summaries: refresh ? summaries : [...state.summaries, ...summaries],
          isLoading: false,
          hasMore: summaries.length >= 20,
          currentPage: page + 1,
        );
      },
    );
  }

  void addSummary(SummaryModel summary) {
    state = state.copyWith(
      summaries: [summary, ...state.summaries],
    );
  }
}

final summariesProvider =
    StateNotifierProvider<SummariesNotifier, SummariesState>((ref) {
  final repository = ref.watch(summaryRepositoryProvider);
  return SummariesNotifier(repository);
});

// Translated summary cache per summaryId (client-side)
final translatedSummaryProvider =
    StateProvider.family<SummaryModel?, String>((ref, summaryId) => null);

final isTranslatingProvider = StateProvider<bool>((ref) => false);

