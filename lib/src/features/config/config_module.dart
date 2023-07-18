import 'package:flutter_modular/flutter_modular.dart';

import 'config_screen.dart';

class ConfigModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const ConfigScreen()),
      ];
}
