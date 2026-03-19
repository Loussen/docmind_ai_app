import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/api_constants.dart';
import '../../../../core/network/dio_client.dart';
import '../models/summary_model.dart';

final summaryRepositoryProvider = Provider<SummaryRepository>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return SummaryRepository(dioClient);
});

class SummaryRepository {
  final DioClient _dioClient;

  SummaryRepository(this._dioClient);

  Future<Either<String, SummaryModel>> generateSummary({
    required String documentId,
    String summaryType = 'standard',
    String language = 'en',
  }) async {
    try {
      final response = await _dioClient.post(
        ApiConstants.generateSummary(documentId),
        data: {
          'summary_type': summaryType,
          'language': language,
        },
      );

      return Right(SummaryModel.fromJson(response.data['summary']));
    } on DioException catch (e) {
      return Left(e.error?.toString() ?? 'Failed to generate summary');
    } catch (e, stackTrace) {
      print('Summary parsing error: $e');
      print('Stack trace: $stackTrace');
      return Left('An unexpected error occurred: $e');
    }
  }

  Future<Either<String, SummaryModel>> getSummary(String id) async {
    try {
      final response = await _dioClient.get(
        ApiConstants.summaryById(id),
      );

      return Right(SummaryModel.fromJson(response.data['summary']));
    } on DioException catch (e) {
      return Left(e.error?.toString() ?? 'Failed to fetch summary');
    } catch (e) {
      return Left('An unexpected error occurred');
    }
  }

  Future<Either<String, List<SummaryModel>>> getSummaries({
    int page = 1,
    int perPage = 20,
  }) async {
    try {
      final response = await _dioClient.get(
        ApiConstants.summaries,
        queryParameters: {
          'page': page,
          'per_page': perPage,
        },
      );

      final summaries = (response.data['data'] as List)
          .map((summary) => SummaryModel.fromJson(summary))
          .toList();

      return Right(summaries);
    } on DioException catch (e) {
      return Left(e.error?.toString() ?? 'Failed to fetch summaries');
    } catch (e) {
      return Left('An unexpected error occurred');
    }
  }

  Future<Either<String, SummaryModel>> getSummaryByDocumentId(
    String documentId,
  ) async {
    try {
      final response = await _dioClient.get(
        '${ApiConstants.documentById(documentId)}/summary',
      );

      return Right(SummaryModel.fromJson(response.data['summary']));
    } on DioException catch (e) {
      return Left(e.error?.toString() ?? 'Failed to fetch summary');
    } catch (e) {
      return Left('An unexpected error occurred');
    }
  }

  Future<Either<String, SummaryModel>> translateSummary({
    required String summaryId,
    required String targetLanguage,
  }) async {
    try {
      final response = await _dioClient.post(
        '${ApiConstants.summaryById(summaryId)}/translate',
        data: {
          'target_language': targetLanguage,
        },
      );
      return Right(SummaryModel.fromJson(response.data['summary']));
    } on DioException catch (e) {
      return Left(e.error?.toString() ?? 'Failed to translate summary');
    } catch (e) {
      return Left('An unexpected error occurred');
    }
  }
}
