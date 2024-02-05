import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';

import 'patient_controller.dart';
import 'patient_page.dart';

class PatientRouter extends FlutterGetItModulePageRouter {
  const PatientRouter({super.key});

  @override
  List<Bind<Object>> get bindings => [
        Bind.lazySingleton((i) => PatientController(patientRepository: i())),
      ];

  @override
  WidgetBuilder get view => (context) => const PatientPage();
}
