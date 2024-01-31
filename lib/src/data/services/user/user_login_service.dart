import 'package:lab_clinicas_core/lab_clinicas_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../repositories/user/i_user_repository.dart';
import 'i_user_login_service.dart';

class UserLoginService implements IUserLoginService {
  final IUserRepository _userRepository;

  UserLoginService({
    required IUserRepository userRepository,
  }) : _userRepository = userRepository;

  @override
  Future<Either<ServiceException, Unit>> execute(String email, String password) async {
    final loginResponse = await _userRepository.login(email, password);

    switch (loginResponse) {
      case Left(value: AuthException(:final message)):
        return Left(ServiceException(message));
      case Right(value: final accessToken):
        final sp = await SharedPreferences.getInstance();
        sp.setString(LocalStorageConstants.accessToken, accessToken);

        return Right(unit);
    }
  }
}
