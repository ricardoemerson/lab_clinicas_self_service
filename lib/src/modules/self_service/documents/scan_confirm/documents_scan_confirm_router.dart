import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';

import '../../../../data/repositories/documents/document_repository.dart';
import '../../../../data/repositories/documents/i_document_repository.dart';
import 'documents_scan_confirm_controller.dart';
import 'documents_scan_confirm_page.dart';

class DocumentsScanConfirmRouter extends FlutterGetItModulePageRouter {
  const DocumentsScanConfirmRouter({super.key});

  @override
  List<Bind<Object>> get bindings => [
        Bind.lazySingleton<IDocumentRepository>((i) => DocumentRepository(restClient: i())),
        Bind.lazySingleton((i) => DocumentsScanConfirmController(documentRepository: i())),
      ];

  @override
  WidgetBuilder get view => (context) => DocumentsScanConfirmPage();
}
