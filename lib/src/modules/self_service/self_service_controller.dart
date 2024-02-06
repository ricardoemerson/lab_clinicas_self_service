import 'package:asyncstate/asyncstate.dart';
import 'package:lab_clinicas_core/lab_clinicas_core.dart';
import 'package:signals_flutter/signals_flutter.dart';

import '../../data/model/patient_model.dart';
import '../../data/model/self_service_model.dart';
import '../../data/repositories/information_form/i_information_form_repository.dart';

enum FormSteps {
  none,
  whoIAm,
  findPatient,
  patient,
  documents,
  done,
  restart,
}

class SelfServiceController with MessageStateMixin {
  final IInformationFormRepository _informationFormRepository;

  SelfServiceController({
    required IInformationFormRepository informationFormRepository,
  }) : _informationFormRepository = informationFormRepository;

  final _step = ValueSignal(FormSteps.none);
  var _model = const SelfServiceModel();
  var password = '';

  FormSteps get step => _step();

  SelfServiceModel get model => _model;

  void startProcess() {
    _step.forceUpdate(FormSteps.whoIAm);
  }

  void clearForm() {
    _model = _model.clear();
  }

  void setWhoIAmDataStepAndNext(String firstName, String lastName) {
    _model = _model.copyWith(firstName: () => firstName, lastName: () => lastName);
    _step.forceUpdate(FormSteps.findPatient);
  }

  void goToFormPatient(PatientModel? patient) {
    _model = _model.copyWith(patient: () => patient);
    _step.forceUpdate(FormSteps.patient);
  }

  void restartProcess() {
    _step.forceUpdate(FormSteps.restart);
    clearForm();
  }

  void updatePatientAndGoDocument(PatientModel? patient) {
    _model = _model.copyWith(patient: () => patient);
    _step.forceUpdate(FormSteps.documents);
  }

  void registerDocument(DocumentType type, String filePath) {
    final documents = _model.documents ?? {};

    if (type == DocumentType.healthInsuranceCard) {
      documents[type]?.clear();
    }

    final values = documents[type] ?? [];
    values.add(filePath);
    documents[type] = values;

    _model = _model.copyWith(documents: () => documents);
  }

  void clearDocuments() {
    _model = _model.copyWith(documents: () => {});
  }

  Future<void> finalize() async {
    final response = await _informationFormRepository.register(model).asyncLoader();

    switch (response) {
      case Left(value: RepositoryException(:final message)):
        showError(message);
      case Right():
        password = '${_model.firstName} ${_model.lastName}';
        _step.forceUpdate(FormSteps.done);
    }
  }
}
