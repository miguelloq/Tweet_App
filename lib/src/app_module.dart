import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tweet_app/src/features/auth/auth_module.dart';
import 'package:tweet_app/src/features/home/home_module.dart';
import 'package:tweet_app/src/splash_page.dart';

import 'features/auth/guards/auth_guard.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const SplashPage()),
        ModuleRoute(
          '/auth',
          module: AuthModule(),
          guards: [AuthGuard(authInstance: FirebaseAuth.instance)],
        ),
        ModuleRoute('/home', module: HomeModule()),
      ];
}
