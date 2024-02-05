import 'dart:typed_data';

import 'package:asyncstate/asyncstate.dart';
import 'package:lab_clinicas_core/lab_clinicas_core.dart';
import 'package:signals_flutter/signals_flutter.dart';

import '../../../../data/repositories/documents/i_document_repository.dart';

class DocumentsScanConfirmController with MessageStateMixin {
  final IDocumentRepository _documentRepository;

  DocumentsScanConfirmController({
    required IDocumentRepository documentRepository,
  }) : _documentRepository = documentRepository;

  final pathRemoteStorage = signal<String?>(null);

  Future<void> uploadImage(Uint8List imageBytes, String fileName) async {
    final response = await _documentRepository.uploadImage(imageBytes, fileName).asyncLoader();

    switch (response) {
      case Left(value: RepositoryException(:final message)):
        showError(message);
      case Right(value: final filePath):
        pathRemoteStorage.value = filePath;
    }
  }
}
