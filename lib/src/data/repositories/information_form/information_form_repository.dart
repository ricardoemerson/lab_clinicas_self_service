import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:lab_clinicas_core/lab_clinicas_core.dart';

import '../../model/patient_model.dart';
import '../../model/self_service_model.dart';
import 'i_information_form_repository.dart';

class InformationFormRepository implements IInformationFormRepository {
  final RestClient _restClient;

  InformationFormRepository({
    required RestClient restClient,
  }) : _restClient = restClient;

  @override
  Future<Either<RepositoryException, Unit>> register(SelfServiceModel model) async {
    try {
      final SelfServiceModel(
        :firstName,
        :lastName,
        patient: PatientModel(id: patientId)!,
        documents: {
          DocumentType.healthInsuranceCard: List(first: healthInsuranceCardDoc),
          DocumentType.medicalOrder: medicalOrderDocs,
        }!
      ) = model;

      await _restClient.auth.post(
        '/patientInformationForm',
        data: {
          'patient_id': patientId,
          'health_insurance_card': healthInsuranceCardDoc,
          'medical_order': medicalOrderDocs,
          'password': '$firstName $lastName',
          'date_created': DateTime.now().toIso8601String(),
          'status': 'Waiting',
          'tests': [],
        },
      );

      return Right(unit);
    } on DioException catch (e, s) {
      log('Erro ao finalizar formulário de autoatendimento.', error: e, stackTrace: s);

      return Left(RepositoryException('Erro ao finalizar formulário de autoatendimento.'));
    }
  }
}
