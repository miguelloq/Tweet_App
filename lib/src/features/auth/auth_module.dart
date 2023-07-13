import 'package:flutter_modular/flutter_modular.dart';
import 'package:tweet_app/src/features/auth/registration/registration_screen.dart';
import 'package:tweet_app/src/core/services/auth_service_firebase.dart';

import 'package:tweet_app/src/features/auth/login/login_screen.dart';
import 'package:tweet_app/src/features/auth/login/store/login_store.dart';
import 'package:tweet_app/src/features/auth/registration/store/registration_store.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.instance<FirebaseAuth>(FirebaseAuth.instance),
        Bind.factory((i) => AuthServiceFirebase(firebaseAuth: i())),
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
