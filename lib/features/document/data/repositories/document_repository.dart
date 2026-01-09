import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/api_constants.dart';
import '../../../../core/network/dio_client.dart';
import '../models/document_model.dart';

final documentRepositoryProvider = Provider<DocumentRepository>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return DocumentRepository(dioClient);
});

class DocumentRepository {
  final DioClient _dioClient;

  DocumentRepository(this._dioClient);

  Future<Either<String, DocumentModel>> uploadDocument({
    required File file,
    required String fileName,
    void Function(int, int)? onProgress,
  }) async {
    try {
      final formData = FormData.fromMap({
        'document': await MultipartFile.fromFile(
          file.path,
          filename: fileName,
        ),
      });

      final response = await _dioClient.uploadFile(
        ApiConstants.uploadDocument,
        formData: formData,
        onSendProgress: onProgress,
      );

      return Right(DocumentModel.fromJson(response.data['document']));
    } on DioException catch (e) {
      return Left(e.error?.toString() ?? 'Upload failed');
    } catch (e) {
      return Left('An unexpected error occurred');
    }
  }

  Future<Either<String, List<DocumentModel>>> getDocuments({
    int page = 1,
    int perPage = 20,
  }) async {
    try {
      final response = await _dioClient.get(
        ApiConstants.documents,
        queryParameters: {
          'page': page,
          'per_page': perPage,
        },
      );

      final documents = (response.data['data'] as List)
          .map((doc) => DocumentModel.fromJson(doc))
          .toList();

      return Right(documents);
    } on DioException catch (e) {
      return Left(e.error?.toString() ?? 'Failed to fetch documents');
    } catch (e) {
      return Left('An unexpected error occurred');
    }
  }

  Future<Either<String, DocumentModel>> getDocument(String id) async {
    try {
      final response = await _dioClient.get(
        ApiConstants.documentById(id),
      );

      return Right(DocumentModel.fromJson(response.data['document']));
    } on DioException catch (e) {
      return Left(e.error?.toString() ?? 'Failed to fetch document');
    } catch (e) {
      return Left('An unexpected error occurred');
    }
  }

  Future<Either<String, void>> deleteDocument(String id) async {
    try {
      await _dioClient.delete(ApiConstants.deleteDocument(id));
      return const Right(null);
    } on DioException catch (e) {
      return Left(e.error?.toString() ?? 'Failed to delete document');
    } catch (e) {
      return Left('An unexpected error occurred');
    }
  }

  Future<Either<String, DocumentModel>> processDocument(String id) async {
    try {
      final response = await _dioClient.post(
        '${ApiConstants.documentById(id)}/process',
      );

      return Right(DocumentModel.fromJson(response.data['document']));
    } on DioException catch (e) {
      return Left(e.error?.toString() ?? 'Processing failed');
    } catch (e) {
      return Left('An unexpected error occurred');
    }
  }
}

