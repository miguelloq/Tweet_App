import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../core/services/auth_service_firebase.dart';
import 'config_screen.dart';

class ConfigModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.instance<FirebaseAuth>(FirebaseAuth.instance),
        Bind.factory((i) => AuthServiceFirebase(
            firebaseAuth: i(), userRepositoryFirestore: i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const ConfigScreen()),
      ];
}
