import 'package:flutter_modular/flutter_modular.dart';
import 'package:tweet_app/src/core/services/auth_service_firebase.dart';
import 'package:tweet_app/src/features/auth/check/auth_check.dart';
import 'package:tweet_app/src/features/auth/login/login_screen.dart';
import 'package:tweet_app/src/features/auth/login/store/login_store.dart';
import 'package:tweet_app/src/features/auth/registration/store/registration_store.dart';
import 'package:tweet_app/src/features/home/home_screen.dart';

import 'features/auth/registration/registration_screen.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.factory((i) => AuthServiceFirebase()),
        Bind.lazySingleton((i) => RegistrationStore(authService: i())),
        Bind.lazySingleton((i) => LoginStore(authService: i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const AuthCheck()),
        ChildRoute('/home', child: (context, args) => const HomeScreen()),
        ChildRoute('/authCheck', child: (context, args) => const AuthCheck()),
        ChildRoute('/login', child: (context, args) => const LoginScreen()),
        ChildRoute('/registration',
            child: (context, args) => const RegistrationScreen()),
      ];
}
