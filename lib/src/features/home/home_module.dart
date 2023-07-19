import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tweet_app/src/features/home/home_screen.dart';
import 'package:tweet_app/src/features/home/store/home_store.dart';
import 'package:tweet_app/src/features/home/submodules/add_tweet/add_tweet_module.dart';

import '../../core/repositories/tweet_repository_firestore.dart';

class HomeModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.lazySingleton((i) => HomeStore()),
        Bind.singleton((i) => TweetRepositoryFirestore(
              firestoreInstance: i<FirebaseFirestore>(),
            )),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (context, args) => const HomeScreen(),
        ),
        ModuleRoute('/addTweet', module: AddTweetModule())
      ];
}
