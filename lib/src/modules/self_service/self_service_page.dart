import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:lab_clinicas_core/lab_clinicas_core.dart';
import 'package:signals_flutter/signals_flutter.dart';

import 'self_service_controller.dart';

class SelfServicePage extends StatefulWidget {
  const SelfServicePage({super.key});

  @override
  State<SelfServicePage> createState() => _SelfServicePageState();
}

class _SelfServicePageState extends State<SelfServicePage> with MessageViewMixin {
  final controller = Injector.get<SelfServiceController>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.startProcess();

      effect(() {
        var baseRoute = '/self-service';
        final step = controller.step;

        switch (step) {
          case FormSteps.none:
            return;
          case FormSteps.whoIAm:
            baseRoute += '/who-i-am';
          case FormSteps.findPatient:
            baseRoute += '/find-patient';
          case FormSteps.patient:
            baseRoute += '/patient';
          case FormSteps.documents:
            baseRoute += '/documents';
          case FormSteps.done:
            baseRoute += '/done';
          case FormSteps.restart:
            Navigator.of(context).popUntil((route) => route.settings.name == '/self-service');
            controller.startProcess();
            return;
        }

        Navigator.of(context).pushNamed(baseRoute);
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: AppLoader(),
      ),
    );
  }
}
