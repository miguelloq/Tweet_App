import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tweet_app/src/core/services/auth_service_firebase.dart';
import 'package:tweet_app/src/features/tweet/services/follow_repository_firestore.dart';
import 'package:tweet_app/src/features/tweet/services/get_tweet_information_service.dart';
import 'package:tweet_app/src/features/tweet/services/get_user_information_service.dart';
import 'package:tweet_app/src/features/tweet/submodules/feed/services/get_feed_service.dart';
import 'package:tweet_app/src/features/tweet/submodules/feed/store/feed_store.dart';

import 'feed_screen.dart';

class FeedModule extends WidgetModule {
  @override
  List<Bind> get binds => [
        Bind.singleton((i) => GetFeedService(
              followRepository: i<FollowRepositoryFirestore>(),
              getTweet: i<GetTweetInformationService>(),
              getUser: i<GetUserInformationService>(),
            )),
        Bind.lazySingleton(
          (i) => FeedStore(getFeed: i<GetFeedService>()),
        ),
      ];

  @override
  Widget get view => FeedScreen(
      feedOwnerUid: Modular.get<AuthServiceFirebase>().getCurrentUserUid()!);
}
