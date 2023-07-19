import 'package:flutter_modular/flutter_modular.dart';
import 'package:tweet_app/src/features/home/submodules/add_tweet/store/add_tweet_store.dart';

import '../../../../core/repositories/tweet_repository_firestore.dart';
import '../../../../core/services/auth_service_firebase.dart';
import 'add_tweet_screen.dart';

class AddTweetModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.lazySingleton((i) => AddTweetStore(
            repository: i<TweetRepositoryFirestore>(),
            userUid: i<AuthServiceFirebase>().getCurrentUserUid()!))
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const AddTweetScreen()),
      ];
}
