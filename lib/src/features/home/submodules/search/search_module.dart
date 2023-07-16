import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tweet_app/src/features/home/submodules/search/search_screen.dart';

class SearchModule extends WidgetModule {
  @override
  List<Bind> get binds => [];

  @override
  Widget get view => const SearchScreen();
}
