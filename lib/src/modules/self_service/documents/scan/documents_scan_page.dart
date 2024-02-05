import 'package:asyncstate/asyncstate.dart';
import 'package:camera/camera.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:lab_clinicas_core/lab_clinicas_core.dart';

import '../../widgets/self_service_app_bar.dart';

class DocumentsScanPage extends StatefulWidget {
  const DocumentsScanPage({super.key});

  @override
  State<DocumentsScanPage> createState() => _DocumentsScanPageState();
}

class _DocumentsScanPageState extends State<DocumentsScanPage> {
  late CameraController cameraController;

  @override
  void initState() {
    cameraController = CameraController(
      Injector.get<List<CameraDescription>>().last,
      ResolutionPreset.ultraHigh,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.sizeOf(context);

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
                Image.asset('assets/images/cam_icon.png'),
                const SizedBox(height: 24),
                const Text(
                  'Tirar a Foto Agora',
                  style: AppTheme.titleSmallStyle,
                ),
                const SizedBox(height: 12),
                const Text(
                  'Posicione o documento dentro do quadrado abaixo e aperte o botão para tirar a foto',
                  style: TextStyle(
                    color: AppTheme.blueColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                FutureBuilder(
                  future: cameraController.initialize(),
                  builder: (context, snapshot) {
                    switch (snapshot) {
                      case AsyncSnapshot(connectionState: ConnectionState.waiting || ConnectionState.active):
                        return const Center(
                          child: AppLoader(),
                        );
                      case AsyncSnapshot(connectionState: ConnectionState.done):
                        if (cameraController.value.isInitialized) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: SizedBox(
                              width: sizeOf.width * .5,
                              child: CameraPreview(
                                cameraController,
                                child: DottedBorder(
                                  borderType: BorderType.RRect,
                                  strokeWidth: 4,
                                  strokeCap: StrokeCap.square,
                                  color: AppTheme.orangeColor,
                                  dashPattern: const [1, 10, 1, 3],
                                  radius: const Radius.circular(16),
                                  child: const SizedBox.expand(),
                                ),
                              ),
                            ),
                          );
                        }
                    }

                    return const Center(
                      child: Text('Erro ao carregar câmera.'),
                    );
                  },
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      final foto = await cameraController.takePicture().asyncLoader();

                      if (!mounted) return;

                      Navigator.of(context).pushNamed(
                        '/self-service/documents/scan/confirm',
                        arguments: foto,
                      );
                    },
                    child: const Text('TIRAR FOTO'),
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
