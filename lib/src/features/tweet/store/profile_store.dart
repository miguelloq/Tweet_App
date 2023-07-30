import 'package:mobx/mobx.dart';
import 'package:tweet_app/src/features/tweet/models/tweet_request_model.dart';
import 'package:tweet_app/src/features/tweet/models/user_request_model.dart';
import 'package:tweet_app/src/features/tweet/services/follow_service.dart';
import 'package:tweet_app/src/features/tweet/services/get_tweet_information_service.dart';
import 'package:tweet_app/src/features/tweet/services/get_user_information_service.dart';

part 'profile_store.g.dart';

enum ProfileScreenState { loading, error, loaded }

class ProfileStore = _ProfileStore with _$ProfileStore;

abstract class _ProfileStore with Store {
  final GetUserInformationService getUser;
  final GetTweetInformationService getTweet;
  final FollowService followService;
  _ProfileStore(
      {required this.followService,
      required this.getUser,
      required this.getTweet});

  late final UserRequestModel profileOwner;
  List<TweetRequestModel> tweetList = [];

  @observable
  ProfileScreenState profileScreenState = ProfileScreenState.loading;

  @observable
  String? errorMessage;

  @observable
  bool isFollowing = false;

  @observable
  int followingAmount = 0;

  @observable
  int followersAmount = 0;

  Future<void> _loadFollowInformation({required String uidVisitor}) async {
    isFollowing = await followService.isFollowing(
        uidIsFollowing: uidVisitor, uidFollower: profileOwner.uidAuth);
    var (:followersQuantity, :followingQuantity) =
        await followService.getFollowQuantity(uidAuth: profileOwner.uidAuth);
    followingAmount = followingQuantity;
    followersAmount = followersQuantity;
  }

  Future<void> loadInformation(
      {required String uidProfileOwner, required uidVisitor}) async {
    try {
      profileOwner =
          await getUser.getUserWithNetworkImage(uidAuth: uidProfileOwner);
      await _loadFollowInformation(uidVisitor: uidVisitor);
      tweetList =
          await getTweet.getAllTweetsWithNetworkImage(uidAuth: uidProfileOwner);
      setScreenState(newState: ProfileScreenState.loaded);
    } on Exception catch (e) {
      errorMessage = e.toString();
      setScreenState(newState: ProfileScreenState.error);
    }
  }

  Future<void> buttonFollowAction({required String uid}) async {
    if (isFollowing) {
      await _removeFollowAction(uidIsRemoveFollowing: uid);
    } else {
      await _followAction(uidIsFollowing: uid);
    }
  }

  @action
  Future<void> _followAction({required String uidIsFollowing}) async {
    try {
      await followService.followUser(
          uidIsFollowing: uidIsFollowing, uidFollower: profileOwner.uidAuth);
      isFollowing = true;
    } catch (e) {
      errorMessage = e.toString();
      setScreenState(newState: ProfileScreenState.error);
    }
  }

  @action
  Future<void> _removeFollowAction(
      {required String uidIsRemoveFollowing}) async {
    try {
      followService.removeFollowUser(
          uidIsRemoveFollow: uidIsRemoveFollowing,
          uidFollower: profileOwner.uidAuth);
      isFollowing = false;
    } catch (e) {
      errorMessage = e.toString();
      setScreenState(newState: ProfileScreenState.error);
    }
  }

  @action
  void setScreenState({required ProfileScreenState newState}) {
    if (profileScreenState == ProfileScreenState.error &&
        newState != ProfileScreenState.error) {
      errorMessage = null;
    }
    profileScreenState = newState;
  }
}
