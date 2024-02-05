import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:lab_clinicas_core/lab_clinicas_core.dart';
import 'package:signals_flutter/signals_flutter.dart';
import 'package:validatorless/validatorless.dart';

import '../../../data/model/patient_model.dart';
import '../../../data/model/self_service_model.dart';
import '../../../data/repositories/patient/i_patient_repository.dart';
import '../self_service_controller.dart';
import '../widgets/self_service_app_bar.dart';
import 'patient_controller.dart';

class PatientPage extends StatefulWidget {
  const PatientPage({super.key});

  @override
  State<PatientPage> createState() => _PatientPageState();
}

class _PatientPageState extends State<PatientPage> with MessageViewMixin {
  final controller = Injector.get<PatientController>();
  final selfServiceController = Injector.get<SelfServiceController>();

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

  late bool patientFound;
  late bool enableForm;

  @override
  void initState() {
    messageListener(controller);

    final SelfServiceModel(:patient) = selfServiceController.model;
    patientFound = patient != null;
    enableForm = !patientFound;
    initializeForm(patient);

    effect(() {
      if (controller.nextStep) {
        selfServiceController.updatePatientAndGoDocument(controller.patient);
      }
    });

    super.initState();
  }

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

  void initializeForm(final PatientModel? patient) {
    if (patient != null) {
      _nameEC.text = patient.name;
      _emailEC.text = patient.email;
      _phoneEC.text = patient.phoneNumber;
      _cpfEC.text = patient.document;
      _cepEC.text = patient.address.cep;
      _streetEC.text = patient.address.streetAddress;
      _numberEC.text = patient.address.number;
      _complementEC.text = patient.address.addressComplement;
      _stateEC.text = patient.address.state;
      _cityEC.text = patient.address.city;
      _districtEC.text = patient.address.district;
      _guardianEC.text = patient.guardian;
      _guardianIdentificationNumberEC.text = patient.guardianIdentificationNumber;
    }
  }

  PatientModel getPatientModelFromInputText(final PatientModel patient) {
    return patient.copyWith(
      name: _nameEC.trimmedText,
      email: _emailEC.trimmedText,
      phoneNumber: _phoneEC.trimmedText,
      document: _cpfEC.trimmedText,
      address: patient.address.copyWith(
        cep: _cepEC.trimmedText,
        streetAddress: _streetEC.trimmedText,
        number: _numberEC.trimmedText,
        addressComplement: _complementEC.trimmedText,
        state: _stateEC.trimmedText,
        city: _cityEC.trimmedText,
        district: _districtEC.trimmedText,
      ),
      guardian: _guardianEC.trimmedText,
      guardianIdentificationNumber: _guardianIdentificationNumberEC.trimmedText,
    );
  }

  RegisterPatientModel getRegisterPatientModelFromInputText() {
    return (
      name: _nameEC.trimmedText,
      email: _emailEC.trimmedText,
      phoneNumber: _phoneEC.trimmedText,
      document: _cpfEC.trimmedText,
      address: (
        cep: _cepEC.trimmedText,
        streetAddress: _streetEC.trimmedText,
        number: _numberEC.trimmedText,
        addressComplement: _complementEC.trimmedText,
        state: _stateEC.trimmedText,
        city: _cityEC.trimmedText,
        district: _districtEC.trimmedText,
      ),
      guardian: _guardianEC.trimmedText,
      guardianIdentificationNumber: _guardianIdentificationNumberEC.trimmedText,
    );
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
                  Visibility(
                    visible: patientFound,
                    replacement: Image.asset('assets/images/lupa_icon.png'),
                    child: Image.asset('assets/images/check_icon.png'),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    patientFound ? 'Cadastro encontrado' : 'Cadastro não encontrado',
                    style: AppTheme.titleSmallStyle,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    patientFound
                        ? 'Confirme os dados do seu cadastro'
                        : 'Preencha o formulário abaixo para fazer o seu cadastro',
                    style: const TextStyle(
                      color: AppTheme.blueColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 32),
                  TextFormField(
                    controller: _nameEC,
                    readOnly: !enableForm,
                    autofocus: true,
                    decoration: const InputDecoration(labelText: 'Nome do Paciente'),
                    textCapitalization: TextCapitalization.words,
                    validator: Validatorless.required(AppValidatorMessages.required),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _emailEC,
                    readOnly: !enableForm,
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
                    readOnly: !enableForm,
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
                    readOnly: !enableForm,
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
                    readOnly: !enableForm,
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
                          readOnly: !enableForm,
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
                          readOnly: !enableForm,
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
                          readOnly: !enableForm,
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
                          readOnly: !enableForm,
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
                          readOnly: !enableForm,
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
                          readOnly: !enableForm,
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
                    readOnly: !enableForm,
                    autofocus: true,
                    decoration: const InputDecoration(labelText: 'Responsável'),
                    textCapitalization: TextCapitalization.words,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _guardianIdentificationNumberEC,
                    readOnly: !enableForm,
                    autofocus: true,
                    decoration: const InputDecoration(labelText: 'Responsável de Identificação'),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      CpfInputFormatter(),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Visibility(
                    visible: !enableForm,
                    replacement: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          final formIsValid = _formKey.currentState?.validate() ?? false;

                          if (formIsValid) {
                            if (patientFound) {
                              controller
                                  .updateAndNext(getPatientModelFromInputText(selfServiceController.model.patient!));
                            } else {
                              controller.saveAndNext(getRegisterPatientModelFromInputText());
                            }
                          }
                        },
                        child: Text(!patientFound ? 'CADASTRAR' : 'SALVAR E CONTINUAR'),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              setState(() {
                                enableForm = true;
                              });
                            },
                            child: const Text('EDITAR'),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              controller.patient = selfServiceController.model.patient;
                              controller.goNextStep();
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
