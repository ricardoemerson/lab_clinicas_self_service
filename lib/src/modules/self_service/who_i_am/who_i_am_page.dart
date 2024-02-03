import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:lab_clinicas_core/lab_clinicas_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:validatorless/validatorless.dart';

import '../self_service_controller.dart';

class WhoIAmPage extends StatefulWidget {
  const WhoIAmPage({super.key});

  @override
  State<WhoIAmPage> createState() => _WhoIAmPageState();
}

class _WhoIAmPageState extends State<WhoIAmPage> {
  final controller = Injector.get<SelfServiceController>();

  final _formKey = GlobalKey<FormState>();
  final _firstNameEC = TextEditingController(text: 'João');
  final _lastNameEC = TextEditingController(text: 'Marques');

  @override
  void dispose() {
    _firstNameEC.dispose();
    _lastNameEC.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        _firstNameEC.text = '';
        _lastNameEC.text = '';
        controller.clearForm();
      },
      child: Scaffold(
        appBar: LabClinicasAppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 64),
              child: PopupMenuButton(
                child: const IconPopupMenuButton(),
                itemBuilder: (context) {
                  return [
                    const PopupMenuItem(
                      value: 1,
                      child: Text('Finalizar Terminal'),
                    ),
                  ];
                },
                onSelected: (value) async {
                  if (value == 1) {
                    final sp = await SharedPreferences.getInstance();
                    sp.clear();

                    if (!mounted) return;

                    Navigator.of(context).pushNamedAndRemoveUntil('/auth/login', (route) => false);
                  }
                },
              ),
            ),
          ],
        ),
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
                          const Text(
                            'Bem-vindo!',
                            style: AppTheme.titleStyle,
                          ),
                          const SizedBox(height: 48),
                          TextFormField(
                            controller: _firstNameEC,
                            autofocus: true,
                            decoration: const InputDecoration(labelText: 'Digite seu nome'),
                            textCapitalization: TextCapitalization.words,
                            validator: Validatorless.required(AppValidatorMessages.required),
                          ),
                          const SizedBox(height: 24),
                          TextFormField(
                            controller: _lastNameEC,
                            decoration: const InputDecoration(labelText: 'Digite seu sobrenome'),
                            textCapitalization: TextCapitalization.words,
                            validator: Validatorless.required(AppValidatorMessages.required),
                          ),
                          const SizedBox(height: 24),
                          SizedBox(
                            width: sizeOf.width * .8,
                            height: 48,
                            child: ElevatedButton(
                              onPressed: () {
                                final formIsValid = _formKey.currentState?.validate() ?? false;

                                if (formIsValid) {
                                  controller.setWhoIAmDataStepAndNext(
                                    _firstNameEC.trimmedText,
                                    _lastNameEC.trimmedText,
                                  );
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
      ),
    );
  }
}
