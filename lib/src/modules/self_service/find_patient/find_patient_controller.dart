import 'package:lab_clinicas_core/lab_clinicas_core.dart';
import 'package:signals_flutter/signals_flutter.dart';

import '../../../data/model/patient_model.dart';
import '../../../data/repositories/patient/i_patient_repository.dart';

class FindPatientController with MessageStateMixin {
  final IPatientRepository _patientRepository;

  final _patientNotFound = ValueSignal<bool?>(null);
  final _patient = ValueSignal<PatientModel?>(null);

  bool? get patientNotFound => _patientNotFound();

  PatientModel? get patient => _patient();

  FindPatientController({
    required IPatientRepository patientRepository,
  }) : _patientRepository = patientRepository;

  Future<void> findPatientByCpf(String cpf) async {
    final response = await _patientRepository.findByCpf(cpf);

    bool patientNotFound;
    PatientModel? patient;

    switch (response) {
      case Right(value: final PatientModel model?):
        patientNotFound = false;
        patient = model;

      case Right(value: _):
        patientNotFound = true;
        patient = null;

      case Left(value: RepositoryException(:final message)):
        patientNotFound = true;
        patient = null;

        showError(message);
    }

    batch(() {
      _patient.value = patient;
      _patientNotFound.forceUpdate(patientNotFound);
    });
  }

  void continueWithoutCpf() {
    batch(() {
      _patient.value = null;
      _patientNotFound.forceUpdate(true);
    });
  }
}
