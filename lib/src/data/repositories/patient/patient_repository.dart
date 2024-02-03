import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:lab_clinicas_core/lab_clinicas_core.dart';

import '../../model/patient_model.dart';
import 'i_patient_repository.dart';

class PatientRepository implements IPatientRepository {
  final RestClient _restClient;

  PatientRepository({
    required RestClient restClient,
  }) : _restClient = restClient;

  @override
  Future<Either<RepositoryException, PatientModel?>> findByCpf(String cpf) async {
    try {
      final Response(:List data) = await _restClient.auth.get(
        '/patients',
        queryParameters: {
          'document': cpf,
        },
      );

      if (data.isEmpty) return Right(null);

      return Right(PatientModel.fromJson(data.first));
    } on DioException catch (e, s) {
      log('Erro ao buscar paciente por CPF.', error: e, stackTrace: s);

      return Left(RepositoryException('Erro ao buscar paciente por CPF.'));
    }
  }
}
