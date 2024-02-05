import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:lab_clinicas_core/lab_clinicas_core.dart';

import '../../../data/model/self_service_model.dart';
import '../self_service_controller.dart';
import '../widgets/self_service_app_bar.dart';
import 'widgets/document_box.dart';

class DocumentsPage extends StatefulWidget {
  const DocumentsPage({super.key});

  @override
  State<DocumentsPage> createState() => _DocumentsPageState();
}

class _DocumentsPageState extends State<DocumentsPage> with MessageViewMixin {
  final selfServiceController = Injector.get<SelfServiceController>();

  @override
  void initState() {
    messageListener(selfServiceController);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.sizeOf(context);
    final documents = selfServiceController.model.documents;
    final totalHealthInsuranceCard = documents?[DocumentType.healthInsuranceCard]?.length ?? 0;
    final totalMedicalOrder = documents?[DocumentType.medicalOrder]?.length ?? 0;

    return Scaffold(
      appBar: SelfServiceAppBar(),
      body: Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Container(
            width: sizeOf.width * .8,
            margin: const EdgeInsets.only(top: 18),
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppTheme.orangeColor),
            ),
            child: Column(
              children: [
                Image.asset('assets/images/folder.png'),
                const SizedBox(height: 24),
                const Text(
                  'Adicionar Documentos',
                  style: AppTheme.titleSmallStyle,
                ),
                const SizedBox(height: 12),
                const Text(
                  'Selecione o documento que deseja fotografar',
                  style: TextStyle(
                    color: AppTheme.blueColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: sizeOf.width * .8,
                  height: 241,
                  child: Row(
                    children: [
                      DocumentBox(
                        onTap: () async {
                          final filePath = await Navigator.of(context).pushNamed('/self-service/documents/scan');

                          if (filePath != null && filePath != '') {
                            selfServiceController.registerDocument(
                              DocumentType.healthInsuranceCard,
                              filePath.toString(),
                            );

                            setState(() {});
                          }
                        },
                        uploaded: totalHealthInsuranceCard > 0,
                        icon: Image.asset('assets/images/id_card.png'),
                        label: 'Carteirinha',
                        totalFiles: totalHealthInsuranceCard,
                      ),
                      const SizedBox(width: 32),
                      DocumentBox(
                        onTap: () async {
                          final filePath = await Navigator.of(context).pushNamed('/self-service/documents/scan');

                          if (filePath != null && filePath != '') {
                            selfServiceController.registerDocument(
                              DocumentType.medicalOrder,
                              filePath.toString(),
                            );

                            setState(() {});
                          }
                        },
                        uploaded: totalMedicalOrder > 0,
                        icon: Image.asset('assets/images/document.png'),
                        label: 'Pedido Médico',
                        totalFiles: totalMedicalOrder,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                Visibility(
                  visible: totalHealthInsuranceCard > 0 && totalMedicalOrder > 0,
                  child: Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: selfServiceController.clearDocuments,
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.red,
                            side: const BorderSide(color: Colors.red),
                          ),
                          child: const Text('REMOVER TODAS'),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.orangeColor,
                          ),
                          child: const Text('FINALIZAR'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
