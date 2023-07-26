import 'package:mobx/mobx.dart';
import 'package:tweet_app/src/features/tweet/models/tweet_request_model.dart';
import 'package:tweet_app/src/features/tweet/models/user_request_model.dart';
import 'package:tweet_app/src/features/tweet/services/get_tweet_information_service.dart';
import 'package:tweet_app/src/features/tweet/services/get_user_information_service.dart';

part 'profile_store.g.dart';

enum ProfileScreenState { loading, userLoaded, error, fullyLoaded }

class ProfileStore = _ProfileStore with _$ProfileStore;

abstract class _ProfileStore with Store {
  final GetUserInformationService getUser;
  final GetTweetInformationService getTweet;

  _ProfileStore({required this.getUser, required this.getTweet});

  late UserRequestModel profileOwner;
  List<TweetRequestModel> tweetList = [];

  Future<void> loadProfileOwnerUser({required uidOwnerProfile}) async {
    try {
      profileOwner =
          await getUser.getUserWithNetworkImage(uidAuth: uidOwnerProfile);
      setScreenState(newState: ProfileScreenState.userLoaded);
    } catch (e) {
      errorMessage = e.toString();
      setScreenState(newState: ProfileScreenState.error);
    }
  }

  Future<void> loadTweetOwnerUser({required String uidOwnerProfile}) async {
    try {
      tweetList =
          await getTweet.getAllTweetsWithNetworkImage(uidAuth: uidOwnerProfile);
      setScreenState(newState: ProfileScreenState.fullyLoaded);
    } catch (e) {
      errorMessage = e.toString();
      setScreenState(newState: ProfileScreenState.error);
    }
  }

  @observable
  ProfileScreenState profileScreenState = ProfileScreenState.loading;

  @observable
  String? errorMessage;

  @action
  void setScreenState({required ProfileScreenState newState}) {
    if (profileScreenState == ProfileScreenState.error &&
        newState != ProfileScreenState.error) {
      errorMessage = null;
    }
    profileScreenState = newState;
  }
}
