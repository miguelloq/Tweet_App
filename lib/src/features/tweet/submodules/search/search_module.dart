import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tweet_app/src/core/repositories/user_repository_firestore.dart';
import 'package:tweet_app/src/features/tweet/services/get_user_information_service.dart';
import 'package:tweet_app/src/features/tweet/submodules/search/search_screen.dart';
import 'package:tweet_app/src/features/tweet/submodules/search/services/user_filter_service.dart';
import 'package:tweet_app/src/features/tweet/submodules/search/store/search_store.dart';

class SearchModule extends WidgetModule {
  @override
  List<Bind> get binds => [
        Bind.singleton((i) => UserFilterService(
              userRepository: i<UserRepositoryFirestore>(),
              getUser: i<GetUserInformationService>(),
            )),
        Bind.lazySingleton((i) => SearchStore(
              filterService: i<UserFilterService>(),
            ))
      ];

  @override
  Widget get view => const SearchScreen();
}
