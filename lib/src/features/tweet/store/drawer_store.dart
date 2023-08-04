import 'package:mobx/mobx.dart';
import 'package:tweet_app/src/features/tweet/models/user_request_model.dart';
import 'package:tweet_app/src/features/tweet/services/follow_service.dart';
import 'package:tweet_app/src/features/tweet/services/get_user_information_service.dart';

part 'drawer_store.g.dart';

enum DrawerScreenState { loading, error, loaded }

class DrawerStore = _DrawerStore with _$DrawerStore;

abstract class _DrawerStore with Store {
  final GetUserInformationService getUser;
  final FollowService followService;
  final String uidAuth;

  _DrawerStore({
    required this.getUser,
    required this.followService,
    required this.uidAuth,
  });

  UserRequestModel user = UserRequestModel.empty();
  int followingAmount = 0;
  int followersAmount = 0;

  @observable
  DrawerScreenState screenState = DrawerScreenState.loading;

  @observable
  String? errorMessage;

  loadInformation() async {
    try {
      user = await getUser.getUserWithNetworkImage(uidAuth: uidAuth);
      var (:followersQuantity, :followingQuantity) =
          await followService.getFollowQuantity(uidAuth: uidAuth);
      followersAmount = followersQuantity;
      followingAmount = followingQuantity;
      setScreenState(newState: DrawerScreenState.loaded);
    } on Exception {
      errorMessage = 'Error in load the Drawer';
      setScreenState(newState: DrawerScreenState.error);
    }
  }

  @action
  setScreenState({required DrawerScreenState newState}) {
    if (screenState == DrawerScreenState.error &&
        newState != DrawerScreenState.error) {
      errorMessage = null;
    }
    screenState = newState;
  }

  String returnUidAuth() {
    return uidAuth;
  }
}
