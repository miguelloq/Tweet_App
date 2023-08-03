import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tweet_app/src/core/repositories/user_repository_firestore.dart';
import 'package:tweet_app/src/features/auth/services/auth_service_firebase.dart';
import 'package:tweet_app/src/features/auth/registration/registration_screen.dart';

import 'package:tweet_app/src/features/auth/login/login_screen.dart';
import 'package:tweet_app/src/features/auth/login/store/login_store.dart';
import 'package:tweet_app/src/features/auth/registration/store/registration_store.dart';

class AuthModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.lazySingleton((i) => RegistrationStore(authService: i())),
        Bind.lazySingleton((i) => LoginStore(authService: i())),
        Bind.lazySingleton((i) => AuthServiceFirebase(
              firebaseAuth: i<FirebaseAuth>(),
              userRepositoryFirestore: i<UserRepositoryFirestore>(),
            )),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const LoginScreen()),
        ChildRoute('/registration',
            child: (context, args) => const RegistrationScreen()),
      ];
}
