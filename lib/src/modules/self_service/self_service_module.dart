import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';

import 'documents/documents_page.dart';
import 'documents/scan/documents_scan_page.dart';
import 'documents/scan_confirm/documents_scan_confirm_page.dart';
import 'done/done_page.dart';
import 'find_patient/find_patient_page.dart';
import 'patient/patient_page.dart';
import 'self_service_controller.dart';
import 'self_service_page.dart';
import 'who_i_am/who_i_am_page.dart';

class SelfServiceModule extends FlutterGetItModule {
  @override
  List<Bind<Object>> get bindings => [
        Bind.lazySingleton((i) => SelfServiceController()),
      ];

  @override
  String get moduleRouteName => '/self-service';

  @override
  Map<String, WidgetBuilder> get pages => {
        '/': (context) => const SelfServicePage(),
        '/who-i-am': (context) => const WhoIAmPage(),
        '/find-patient': (context) => const FindPatientPage(),
        '/patient': (context) => const PatientPage(),
        '/documents': (context) => const DocumentsPage(),
        '/documents-scan': (context) => const DocumentsScanPage(),
        '/documents-scan-confirm': (context) => const DocumentsScanConfirmPage(),
        '/done': (context) => const DonePage(),
      };
}
