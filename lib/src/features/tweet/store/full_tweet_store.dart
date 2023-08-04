import 'package:mobx/mobx.dart';
import 'package:tweet_app/src/features/tweet/models/tweet_presentation_model.dart';
import 'package:tweet_app/src/features/tweet/models/tweet_request_model.dart';
import 'package:tweet_app/src/features/tweet/models/user_request_model.dart';
import 'package:tweet_app/src/features/tweet/services/get_tweet_information_service.dart';
import 'package:tweet_app/src/features/tweet/services/get_user_information_service.dart';

part 'full_tweet_store.g.dart';

enum FullTweetScreenState { loading, error, loaded, idle }

class FullTweetStore = _FullTweetStore with _$FullTweetStore;

abstract class _FullTweetStore with Store {
  final GetTweetInformationService getTweet;
  final GetUserInformationService getUser;

  _FullTweetStore({required this.getTweet, required this.getUser});

  late TweetRequestModel tweet;
  late UserRequestModel ownerUser;
  late List<TweetPresentationModel> comments;

  @observable
  FullTweetScreenState screenState = FullTweetScreenState.idle;

  @observable
  String? errorMessage;

  @action
  void setScreenState({required FullTweetScreenState newState}) {
    if (screenState == FullTweetScreenState.error &&
        newState != FullTweetScreenState.error) {
      errorMessage = null;
    }
    screenState = newState;
  }

  Future<void> loadInformation({required String tweetDocName}) async {
    setScreenState(newState: FullTweetScreenState.loading);
    try {
      tweet = await getTweet.getTweetWithNetworkImage(docName: tweetDocName);
      ownerUser =
          await getUser.getUserWithNetworkImage(uidAuth: tweet.uidPoster);
      comments = await _returnComments(
          documentIds: tweet.commentDocNames, isSortedByPostCreationTime: true);
      setScreenState(newState: FullTweetScreenState.loaded);
    } on Exception catch (e) {
      errorMessage = e.toString();
      setScreenState(newState: FullTweetScreenState.error);
    }
  }

  Future<List<TweetPresentationModel>> _returnComments(
      {required List<String> documentIds,
      required bool isSortedByPostCreationTime}) async {
    List<TweetRequestModel> tweetsWithNetworkImage =
        await getTweet.getTweetsBasedOnIdWithNetworkImage(
      documentIds: tweet.commentDocNames,
      isSortedByPostCreationTime: true,
      isIncludesComments: true,
    );
    List<TweetPresentationModel> presentationTweets = [];
    for (var tweet in tweetsWithNetworkImage) {
      UserRequestModel tweetUser = await getUser.getUserWithNetworkImage(
          uidAuth: tweet.uidPoster, isOnlyProfilePicture: true);
      presentationTweets.add(TweetPresentationModel(
          tweet: tweet,
          userIdentifier: tweetUser.identifier,
          profilePictureNetworkUrl: tweetUser.iconPhoto));
    }
    return presentationTweets;
  }
}
