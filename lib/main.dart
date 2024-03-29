import 'dart:async';
import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:lab_clinicas_core/lab_clinicas_core.dart';

import 'src/core/bindings/lab_clinica_application_bindings.dart';
import 'src/modules/auth/auth_module.dart';
import 'src/modules/home/home_module.dart';
import 'src/modules/self_service/self_service_module.dart';
import 'src/pages/splash/splash_page.dart';

late List<CameraDescription> _cameras;

void main() {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    _cameras = await availableCameras();

    runApp(const LabClinicasSelfServiceApp());
  }, (error, stack) {
    log('Erro não tratado.', error: error, stackTrace: stack);

    throw error;
  });
}

class LabClinicasSelfServiceApp extends StatelessWidget {
  const LabClinicasSelfServiceApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return LabClinicasCoreConfig(
      title: 'Lab Clínicas - Auto Atendimento',
      bindings: LabClinicaApplicationBindings(),
      pagesBuilders: [
        FlutterGetItPageBuilder(
          path: '/',
          page: (context) => const SplashPage(),
        ),
      ],
      modules: [
        AuthModule(),
        HomeModule(),
        SelfServiceModule(),
      ],
      didStart: () {
        FlutterGetItBindingRegister.registerPermanentBinding('cameras', [
          Bind.lazySingleton((i) => _cameras),
        ]);
      },
    );
  }
}
