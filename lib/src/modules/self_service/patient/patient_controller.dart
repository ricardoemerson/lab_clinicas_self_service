import 'package:lab_clinicas_core/lab_clinicas_core.dart';
import 'package:signals_flutter/signals_flutter.dart';

import '../../../data/model/patient_model.dart';
import '../../../data/repositories/patient/i_patient_repository.dart';

class PatientController with MessageStateMixin {
  final IPatientRepository _patientRepository;
  PatientModel? patient;
  final _nextStep = signal(false);

  bool get nextStep => _nextStep();

  PatientController({
    required IPatientRepository patientRepository,
  }) : _patientRepository = patientRepository;

  void goNextStep() {
    _nextStep.value = true;
  }

  Future<void> updateAndNext(PatientModel model) async {
    final response = await _patientRepository.update(model);

    switch (response) {
      case Left(value: RepositoryException(:final message)):
        showError(message);

      case Right():
        showSuccess('Paciente atualizado com sucesso.');

        patient = model;
        goNextStep();
    }
  }

  Future<void> saveAndNext(RegisterPatientModel model) async {
    final response = await _patientRepository.register(model);

    switch (response) {
      case Left(value: RepositoryException(:final message)):
        showError(message);

      case Right(value: final newPatient):
        showSuccess('Paciente cadastrado com sucesso.');

        patient = newPatient;
        goNextStep();
    }
  }
}
