import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tweet_app/src/features/config/services/logout_service.dart';

import 'config_screen.dart';

class ConfigModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.lazySingleton(
            (i) => LogoutService(firebaseAuth: i<FirebaseAuth>())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const ConfigScreen()),
      ];
}
