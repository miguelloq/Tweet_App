import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tweet_app/src/core/repositories/user_repository_firestore.dart';
import 'package:tweet_app/src/core/services/device_current_user_information.dart';
import 'package:tweet_app/src/features/auth/auth_module.dart';
import 'package:tweet_app/src/features/config/config_module.dart';
import 'package:tweet_app/src/features/tweet/tweet_module.dart';
import 'package:tweet_app/src/splash_page.dart';

import 'core/repositories/cloud_storage_repository_firebase.dart';
import 'features/auth/guards/auth_guard.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.instance<FirebaseFirestore>(FirebaseFirestore.instance),
        Bind.instance<FirebaseAuth>(FirebaseAuth.instance),
        Bind.instance<FirebaseStorage>(FirebaseStorage.instance),
        Bind.singleton((i) => CloudStorageRepositoryFirebase(
              storageInstance: i<FirebaseStorage>(),
            )),
        Bind.singleton((i) => UserRepositoryFirestore(
              firestoreInstance: i<FirebaseFirestore>(),
              storageRepository: i<CloudStorageRepositoryFirebase>(),
            )),
        Bind.singleton((i) =>
            DeviceCurrentUserInformation(firebaseAuth: i<FirebaseAuth>())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const SplashPage()),
        ModuleRoute(
          '/auth',
          module: AuthModule(),
          guards: [AuthGuard(authInstance: FirebaseAuth.instance)],
        ),
        ModuleRoute('/tweet', module: TweetModule()),
        ModuleRoute('/config', module: ConfigModule())
      ];
}
