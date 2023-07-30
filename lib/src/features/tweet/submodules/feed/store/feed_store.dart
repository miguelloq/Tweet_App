import 'package:mobx/mobx.dart';
import 'package:tweet_app/src/features/tweet/submodules/feed/models/tweet_with_user_information_model.dart';
import 'package:tweet_app/src/features/tweet/submodules/feed/services/get_feed_service.dart';

part 'feed_store.g.dart';

enum FeedScreenState { idle, loading, error, success }

class FeedStore = _FeedStore with _$FeedStore;

abstract class _FeedStore with Store {
  final GetFeedService getFeed;

  _FeedStore({required this.getFeed});

  List<TweetWithUserInformationModel> tweetList = [];

  @observable
  FeedScreenState feedScreenState = FeedScreenState.idle;

  @observable
  String? errorMessage;

  @action
  void setScreenState({required FeedScreenState newState}) {
    if (feedScreenState == FeedScreenState.error &&
        newState != FeedScreenState.error) {
      errorMessage = null;
    }
    feedScreenState = newState;
  }

  Future<void> loadFeed({required String feedUidAuth}) async {
    setScreenState(newState: FeedScreenState.loading);
    try {
      tweetList = await getFeed.loadOrderByDatetimeAllTweetsFromFollowing(
          uidAuth: feedUidAuth);
      if (tweetList.isEmpty) {
        setScreenState(newState: FeedScreenState.idle);
      } else {
        setScreenState(newState: FeedScreenState.success);
      }
    } catch (e) {
      errorMessage = e.toString();
      setScreenState(newState: FeedScreenState.error);
    }
  }
}
