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

  @override
  Future<Either<RepositoryException, Unit>> update(PatientModel patient) async {
    try {
      await _restClient.auth.put(
        '/patients/${patient.id}',
        data: patient.toJson(),
      );

      return Right(unit);
    } on DioException catch (e, s) {
      log('Erro ao atualizar o paciente.', error: e, stackTrace: s);

      return Left(RepositoryException('Erro ao atualizar o paciente. Chame o atendente.'));
    }
  }

  @override
  Future<Either<RepositoryException, PatientModel>> register(RegisterPatientModel patient) async {
    try {
      final Response(:data) = await _restClient.auth.post(
        '/patients',
        data: {
          'name': patient.name,
          'email': patient.email,
          'phone_number': patient.phoneNumber,
          'document': patient.document,
          'address': {
            'cep': patient.address.cep,
            'street_address': patient.address.streetAddress,
            'number': patient.address.number,
            'address_complement': patient.address.addressComplement,
            'state': patient.address.state,
            'city': patient.address.city,
            'district': patient.address.district,
          },
          'guardian': patient.guardian,
          'guardian_identification_number': patient.guardianIdentificationNumber,
        },
      );

      return Right(PatientModel.fromJson(data));
    } on DioException catch (e, s) {
      log('Erro ao cadastrar paciente.', error: e, stackTrace: s);

      return Left(RepositoryException('Erro ao cadastrar paciente. Chame o atendente.'));
    }
  }
}
