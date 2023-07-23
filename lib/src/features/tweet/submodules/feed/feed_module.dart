import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'feed_screen.dart';

class FeedModule extends WidgetModule {
  @override
  List<Bind> get binds => [];

  @override
  Widget get view => const FeedScreen();
}
