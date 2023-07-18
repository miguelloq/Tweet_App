import 'package:flutter_modular/flutter_modular.dart';
import 'package:tweet_app/src/features/auth/registration/registration_screen.dart';

import 'package:tweet_app/src/features/auth/login/login_screen.dart';
import 'package:tweet_app/src/features/auth/login/store/login_store.dart';
import 'package:tweet_app/src/features/auth/registration/store/registration_store.dart';

class AuthModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.lazySingleton((i) => RegistrationStore(authService: i())),
        Bind.lazySingleton((i) => LoginStore(authService: i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const LoginScreen()),
        ChildRoute('/registration',
            child: (context, args) => const RegistrationScreen()),
      ];
}
