import 'package:lab_clinicas_core/lab_clinicas_core.dart';

import '../../model/patient_model.dart';

abstract interface class IPatientRepository {
  Future<Either<RepositoryException, PatientModel?>> findByCpf(String cpf);
}
