import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lab_clinicas_core/lab_clinicas_core.dart';
import 'package:validatorless/validatorless.dart';

import '../widgets/self_service_app_bar.dart';

class PatientPage extends StatefulWidget {
  const PatientPage({super.key});

  @override
  State<PatientPage> createState() => _PatientPageState();
}

class _PatientPageState extends State<PatientPage> with MessageViewMixin {
  final _formKey = GlobalKey<FormState>();

  final _nameEC = TextEditingController();
  final _emailEC = TextEditingController();
  final _phoneEC = TextEditingController();
  final _cpfEC = TextEditingController();
  final _cepEC = TextEditingController();
  final _streetEC = TextEditingController();
  final _numberEC = TextEditingController();
  final _complementEC = TextEditingController();
  final _stateEC = TextEditingController();
  final _cityEC = TextEditingController();
  final _districtEC = TextEditingController();
  final _guardianEC = TextEditingController();
  final _guardianIdentificationNumberEC = TextEditingController();

  @override
  void dispose() {
    _nameEC.dispose();
    _emailEC.dispose();
    _phoneEC.dispose();
    _cpfEC.dispose();
    _cepEC.dispose();
    _streetEC.dispose();
    _numberEC.dispose();
    _complementEC.dispose();
    _stateEC.dispose();
    _cityEC.dispose();
    _districtEC.dispose();
    _guardianEC.dispose();
    _guardianIdentificationNumberEC.dispose();

    super.dispose();
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
            width: sizeOf.width * .9,
            margin: const EdgeInsets.only(top: 18),
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppTheme.orangeColor),
            ),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Image.asset('assets/images/check_icon.png'),
                  const SizedBox(height: 24),
                  const Text('Cadastro encontrado', style: AppTheme.titleSmallStyle),
                  const SizedBox(height: 32),
                  const Text(
                    'Confirme os dados do seu cadastro',
                    style: TextStyle(
                      color: AppTheme.blueColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    controller: _nameEC,
                    autofocus: true,
                    decoration: const InputDecoration(labelText: 'Nome do Paciente'),
                    textCapitalization: TextCapitalization.words,
                    validator: Validatorless.required(AppValidatorMessages.required),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _emailEC,
                    autofocus: true,
                    decoration: const InputDecoration(labelText: 'e-Mail'),
                    keyboardType: TextInputType.emailAddress,
                    validator: Validatorless.multiple([
                      Validatorless.required(AppValidatorMessages.required),
                      Validatorless.email(AppValidatorMessages.email),
                    ]),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _phoneEC,
                    autofocus: true,
                    decoration: const InputDecoration(labelText: 'Telefone de Contato'),
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      TelefoneInputFormatter(),
                    ],
                    validator: Validatorless.required(AppValidatorMessages.required),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _cpfEC,
                    autofocus: true,
                    decoration: const InputDecoration(labelText: 'CPF'),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      CpfInputFormatter(),
                    ],
                    validator: Validatorless.required(AppValidatorMessages.required),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _cepEC,
                    autofocus: true,
                    decoration: const InputDecoration(labelText: 'CEP'),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      CepInputFormatter(),
                    ],
                    validator: Validatorless.required(AppValidatorMessages.required),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Flexible(
                        flex: 3,
                        child: TextFormField(
                          controller: _streetEC,
                          autofocus: true,
                          decoration: const InputDecoration(labelText: 'Endereço'),
                          textCapitalization: TextCapitalization.words,
                          keyboardType: TextInputType.streetAddress,
                          validator: Validatorless.required(AppValidatorMessages.required),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Flexible(
                        child: TextFormField(
                          controller: _numberEC,
                          autofocus: true,
                          decoration: const InputDecoration(labelText: 'Número'),
                          keyboardType: TextInputType.number,
                          validator: Validatorless.required(AppValidatorMessages.required),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _complementEC,
                          autofocus: true,
                          decoration: const InputDecoration(labelText: 'Complemento'),
                          textCapitalization: TextCapitalization.sentences,
                          keyboardType: TextInputType.streetAddress,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextFormField(
                          controller: _districtEC,
                          autofocus: true,
                          decoration: const InputDecoration(labelText: 'Bairro'),
                          textCapitalization: TextCapitalization.words,
                          keyboardType: TextInputType.streetAddress,
                          validator: Validatorless.required(AppValidatorMessages.required),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _cityEC,
                          autofocus: true,
                          decoration: const InputDecoration(labelText: 'Cidade'),
                          textCapitalization: TextCapitalization.words,
                          validator: Validatorless.required(AppValidatorMessages.required),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextFormField(
                          controller: _stateEC,
                          autofocus: true,
                          decoration: const InputDecoration(labelText: 'Estado'),
                          textCapitalization: TextCapitalization.words,
                          validator: Validatorless.required(AppValidatorMessages.required),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _guardianEC,
                    autofocus: true,
                    decoration: const InputDecoration(labelText: 'Responsável'),
                    textCapitalization: TextCapitalization.words,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _guardianIdentificationNumberEC,
                    autofocus: true,
                    decoration: const InputDecoration(labelText: 'Responsável de Identificação'),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      CpfInputFormatter(),
                    ],
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    height: 48,
                    child: Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              final formIsValid = _formKey.currentState?.validate() ?? false;

                              if (formIsValid) {}
                            },
                            child: const Text('EDITAR'),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              final formIsValid = _formKey.currentState?.validate() ?? false;

                              if (formIsValid) {}
                            },
                            child: const Text('CONTINUAR'),
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
      ),
    );
  }
}
