import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:lab_clinicas_core/lab_clinicas_core.dart';

import '../self_service_controller.dart';

class SelfServiceAppBar extends LabClinicasAppBar {
  SelfServiceAppBar({super.key})
      : super(
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 64),
              child: PopupMenuButton(
                child: const IconPopupMenuButton(),
                itemBuilder: (context) {
                  return [
                    const PopupMenuItem(
                      value: 1,
                      child: Text('Reiniciar Processo'),
                    ),
                  ];
                },
                onSelected: (value) async {
                  Injector.get<SelfServiceController>().restartProcess();
                },
              ),
            ),
          ],
        );
}
