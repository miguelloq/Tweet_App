import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tweet_app/src/core/repositories/user_repository_firestore.dart';
import 'package:tweet_app/src/features/auth/auth_module.dart';
import 'package:tweet_app/src/features/config/config_module.dart';
import 'package:tweet_app/src/features/home/home_module.dart';
import 'package:tweet_app/src/splash_page.dart';

import 'core/services/auth_service_firebase.dart';
import 'features/auth/guards/auth_guard.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.instance<FirebaseFirestore>(FirebaseFirestore.instance),
        Bind.instance<FirebaseAuth>(FirebaseAuth.instance),
        Bind.singleton((i) => UserRepositoryFirestore(
              firestoreInstance: i<FirebaseFirestore>(),
            )),
        Bind.singleton((i) => AuthServiceFirebase(
            firebaseAuth: i<FirebaseAuth>(),
            userRepositoryFirestore: i<UserRepositoryFirestore>())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const SplashPage()),
        ModuleRoute(
          '/auth',
          module: AuthModule(),
          guards: [AuthGuard(authInstance: FirebaseAuth.instance)],
        ),
        ModuleRoute('/home', module: HomeModule()),
        ModuleRoute('/config', module: ConfigModule())
      ];
}
