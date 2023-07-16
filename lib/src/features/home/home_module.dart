import 'package:flutter_modular/flutter_modular.dart';
import 'package:tweet_app/src/features/home/home_screen.dart';
import 'package:tweet_app/src/features/home/store/home_store.dart';

class HomeModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.lazySingleton((i) => HomeStore()),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (context, args) => const HomeScreen(),
        ),
      ];
}
