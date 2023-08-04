import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tweet_app/src/core/repositories/user_repository_firestore.dart';
import 'package:tweet_app/src/core/repositories/cloud_storage_repository_firebase.dart';
import 'package:tweet_app/src/core/services/device_current_user_information.dart';
import 'package:tweet_app/src/features/tweet/services/follow_repository_firestore.dart';
import 'package:tweet_app/src/features/tweet/services/follow_service.dart';
import 'package:tweet_app/src/features/tweet/services/get_tweet_information_service.dart';
import 'package:tweet_app/src/features/tweet/services/get_user_information_service.dart';
import 'package:tweet_app/src/features/tweet/services/tweet_repository_firestore.dart';
import 'package:tweet_app/src/features/tweet/store/drawer_store.dart';
import 'package:tweet_app/src/features/tweet/store/full_tweet_store.dart';
import 'package:tweet_app/src/features/tweet/store/profile_store.dart';
import 'package:tweet_app/src/features/tweet/ui/screen/full_tweet_screen.dart';
import 'package:tweet_app/src/features/tweet/ui/screen/home_screen.dart';
import 'package:tweet_app/src/features/tweet/store/home_store.dart';
import 'package:tweet_app/src/features/tweet/submodules/add_tweet/add_tweet_module.dart';
import 'package:tweet_app/src/features/tweet/ui/screen/profile_screen.dart';

class TweetModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.singleton((i) => FollowRepositoryFirestore(
            firestoreInstance: i<FirebaseFirestore>())),
        Bind.singleton((i) => TweetRepositoryFirestore(
              firestoreInstance: i<FirebaseFirestore>(),
            )),
        Bind.singleton((i) =>
            FollowService(followRepository: i<FollowRepositoryFirestore>())),
        Bind.singleton((i) => GetUserInformationService(
              userRepository: i<UserRepositoryFirestore>(),
              storageRepository: i<CloudStorageRepositoryFirebase>(),
            )),
        Bind.singleton((i) => GetTweetInformationService(
              tweetRepository: i<TweetRepositoryFirestore>(),
              storageRepository: i<CloudStorageRepositoryFirebase>(),
            )),
        Bind.lazySingleton((i) => DrawerStore(
              uidAuth: i<DeviceCurrentUserInformation>().getCurrentUserUid()!,
              followService: i<FollowService>(),
              getUser: i<GetUserInformationService>(),
            )),
        Bind.lazySingleton((i) => HomeStore()),
        Bind.factory((i) => ProfileStore(
              followService: i<FollowService>(),
              getUser: i<GetUserInformationService>(),
              getTweet: i<GetTweetInformationService>(),
            )),
        Bind.factory((i) => FullTweetStore(
              getUser: i<GetUserInformationService>(),
              getTweet: i<GetTweetInformationService>(),
            ))
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (context, args) => const HomeScreen(),
        ),
        ModuleRoute('/addTweet',
            module: AddTweetModule(), transition: TransitionType.rightToLeft),
        ChildRoute(
          '/profile/:idOwner',
          child: (context, args) => ProfileScreen(
              uidOwnerProfile: args.params['idOwner'],
              uidVisitor: Modular.get<DeviceCurrentUserInformation>()
                  .getCurrentUserUid()!),
          transition: TransitionType.rightToLeft,
        ),
        ChildRoute('/fullTweet/:idTweet',
            child: (context, args) => FullTweetScreen(
                docNameTweet: args.params['idTweet'],
                uidVisitor: Modular.get<DeviceCurrentUserInformation>()
                    .getCurrentUserUid()!),
            transition: TransitionType.rightToLeft),
      ];
}
