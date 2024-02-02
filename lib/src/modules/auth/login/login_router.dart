import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';

import '../../../data/services/user/i_user_login_service.dart';
import '../../../data/services/user/user_login_service.dart';
import 'login_controller.dart';
import 'login_page.dart';

class LoginRouter extends FlutterGetItModulePageRouter {
  const LoginRouter({super.key});

  @override
  List<Bind<Object>> get bindings => [
        Bind.lazySingleton<IUserLoginService>((i) => UserLoginService(userRepository: i())),
        Bind.lazySingleton((i) => LoginController(userLoginService: i())),
      ];

  @override
  WidgetBuilder get view => (_) => const LoginPage();
}
