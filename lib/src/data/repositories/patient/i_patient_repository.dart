import 'package:lab_clinicas_core/lab_clinicas_core.dart';

import '../../model/patient_model.dart';

typedef RegisterPatientModel = ({
  String name,
  String email,
  String phoneNumber,
  String document,
  RegisterPatientAddressModel address,
  String guardian,
  String guardianIdentificationNumber,
});

typedef RegisterPatientAddressModel = ({
  String cep,
  String streetAddress,
  String number,
  String addressComplement,
  String state,
  String city,
  String district,
});

abstract interface class IPatientRepository {
  Future<Either<RepositoryException, PatientModel?>> findByCpf(String cpf);

  Future<Either<RepositoryException, Unit>> update(PatientModel patient);

  Future<Either<RepositoryException, PatientModel>> register(RegisterPatientModel patient);
}
