import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:lab_clinicas_core/lab_clinicas_core.dart';
import 'package:signals_flutter/signals_flutter.dart';
import 'package:validatorless/validatorless.dart';

import '../self_service_controller.dart';
import '../widgets/self_service_app_bar.dart';
import 'find_patient_controller.dart';

class FindPatientPage extends StatefulWidget {
  const FindPatientPage({super.key});

  @override
  State<FindPatientPage> createState() => _FindPatientPageState();
}

class _FindPatientPageState extends State<FindPatientPage> with MessageViewMixin {
  final controller = Injector.get<FindPatientController>();

  final _formKey = GlobalKey<FormState>();
  final _cpfEC = TextEditingController(text: '939.327.660-91');

  @override
  void initState() {
    messageListener(controller);

    effect(() {
      final FindPatientController(:patient, :patientNotFound) = controller;

      if (patient != null || patientNotFound != null) {
        Injector.get<SelfServiceController>().goToFormPatient(patient);
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _cpfEC.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SelfServiceAppBar(),
      body: LayoutBuilder(
        builder: (_, constraints) {
          final sizeOf = MediaQuery.sizeOf(context);

          return SingleChildScrollView(
            child: Container(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/background_login.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(40),
                  width: sizeOf.width * .8,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Image.asset('assets/images/logo_vertical.png'),
                        const SizedBox(height: 48),
                        TextFormField(
                          controller: _cpfEC,
                          autofocus: true,
                          decoration: const InputDecoration(labelText: 'Digite seu CPF'),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            CpfInputFormatter(),
                          ],
                          validator: Validatorless.multiple([
                            Validatorless.required(AppValidatorMessages.required),
                            Validatorless.cpf(AppValidatorMessages.cpf),
                          ]),
                        ),
                        const SizedBox(height: 14),
                        Row(
                          children: [
                            const Text(
                              'Não sabe o CPF do paciente?',
                              style: TextStyle(
                                color: AppTheme.blueColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            TextButton(
                              onPressed: controller.continueWithoutCpf,
                              child: const Text(
                                'Clique aqui',
                                style: TextStyle(
                                  color: AppTheme.orangeColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              final formIsValid = _formKey.currentState?.validate() ?? false;

                              if (formIsValid) {
                                controller.findPatientByCpf(_cpfEC.trimmedText);
                              }
                            },
                            child: const Text('CONTINUAR'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
