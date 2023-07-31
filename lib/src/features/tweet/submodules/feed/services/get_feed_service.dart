import 'package:tweet_app/src/features/tweet/models/user_request_model.dart';
import 'package:tweet_app/src/features/tweet/services/follow_repository_firestore.dart';
import 'package:tweet_app/src/features/tweet/services/get_tweet_information_service.dart';
import 'package:tweet_app/src/features/tweet/services/get_user_information_service.dart';
import 'package:tweet_app/src/features/tweet/submodules/feed/models/tweet_with_user_information_model.dart';

class GetFeedService {
  final GetUserInformationService getUser;
  final GetTweetInformationService getTweet;
  final FollowRepositoryFirestore followRepository;

  GetFeedService(
      {required this.followRepository,
      required this.getTweet,
      required this.getUser});

  //WARNING: The algorithm was made with the notion that a reading will be done with a small number of users and posts. Aiming to show in a simple way how the concept of follower works in the application.
  Future<List<TweetWithUserInformationModel>>
      loadOrderByDatetimeAllTweetsFromFollowing(
          {required String uidAuth}) async {
    List<String> userFollowingUidsList =
        await followRepository.safeReadFollowing(uidAuth: uidAuth);
    List<TweetWithUserInformationModel> followingTweets = [];

    for (var userUid in userFollowingUidsList) {
      UserRequestModel user =
          await getUser.getUserWithNetworkImage(uidAuth: userUid);

      followingTweets.addAll((await getTweet.getAllTweetsWithNetworkImage(
              uidAuth: user.uidAuth, isSortedByPostCreationTime: false))
          .map((e) => TweetWithUserInformationModel(user: user, tweet: e))
          .toList());
    }
    followingTweets
        .sort((a, b) => b.getTweetDate().compareTo(a.getTweetDate()));
    return followingTweets;
  }
}
