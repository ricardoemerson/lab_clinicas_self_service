import 'package:lab_clinicas_core/lab_clinicas_core.dart';

import '../../model/self_service_model.dart';

abstract interface class IInformationFormRepository {
  Future<Either<RepositoryException, Unit>> register(SelfServiceModel model);
}
