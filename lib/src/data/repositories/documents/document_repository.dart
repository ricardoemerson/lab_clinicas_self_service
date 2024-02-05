import 'dart:developer';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:lab_clinicas_core/lab_clinicas_core.dart';

import 'i_document_repository.dart';

class DocumentRepository implements IDocumentRepository {
  final RestClient _restClient;

  DocumentRepository({
    required RestClient restClient,
  }) : _restClient = restClient;

  @override
  Future<Either<RepositoryException, String>> uploadImage(Uint8List imageBytes, String fileName) async {
    try {
      final formData = FormData.fromMap({
        'file': MultipartFile.fromBytes(imageBytes, filename: fileName),
      });

      final Response(data: {'url': pathImage}) = await _restClient.auth.post('/uploads', data: formData);

      return Right(pathImage);
    } on DioException catch (e, s) {
      log('Erro ao realizar upload da imagem.', error: e, stackTrace: s);

      return Left(RepositoryException('Erro ao realizar upload da imagem.'));
    }
  }
}
