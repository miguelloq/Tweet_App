import 'package:tweet_app/src/features/tweet/services/follow_repository_firestore.dart';

class FollowService {
  FollowRepositoryFirestore followRepository;

  FollowService({required this.followRepository});

  Future<bool> isFollowing(
      {required String uidIsFollowing, required String uidFollower}) async {
    List<String> uidsOfIsFollowing =
        await followRepository.safeReadFollowing(uidAuth: uidIsFollowing);
    List<String> uidsOfFollower =
        await followRepository.safeReadFollowers(uidAuth: uidFollower);

    if (uidsOfIsFollowing.contains(uidFollower) &&
        uidsOfFollower.contains(uidIsFollowing)) {
      return true;
    } else if (!uidsOfIsFollowing.contains(uidFollower) &&
        !uidsOfFollower.contains(uidIsFollowing)) {
      return false;
    } else {
      throw Exception(
          'The user has information about the other user, but the other user has no information about the user.');
    }
  }

  Future<void> followUser(
      {required String uidIsFollowing, required String uidFollower}) async {
    if (uidFollower == uidIsFollowing) {
      throw Exception('The user cannot follow himself');
    }
    List<String> followingUidsOfIsFollowing =
        await followRepository.safeReadFollowing(uidAuth: uidIsFollowing);
    List<String> followersUidsOfIsBeingFollowed =
        await followRepository.safeReadFollowers(uidAuth: uidFollower);

    if (!(await isFollowing(
        uidIsFollowing: uidIsFollowing, uidFollower: uidFollower))) {
      followingUidsOfIsFollowing.add(uidFollower);
      followersUidsOfIsBeingFollowed.add(uidIsFollowing);

      followRepository.updateFollowing(
          uidAuth: uidIsFollowing, newValue: followingUidsOfIsFollowing);

      followRepository.updateFollowers(
          uidAuth: uidFollower, newValue: followersUidsOfIsBeingFollowed);
    }
  }

  Future<void> removeFollowUser(
      {required String uidIsRemoveFollow, required String uidFollower}) async {
    if (uidFollower == uidIsRemoveFollow) {
      throw Exception('The user cannot remove follow himself');
    }
    List<String> followingUidsOfRemoveFollow =
        await followRepository.safeReadFollowing(uidAuth: uidIsRemoveFollow);
    List<String> followersUidsOfuidFollower =
        await followRepository.safeReadFollowers(uidAuth: uidFollower);

    if (await isFollowing(
        uidIsFollowing: uidIsRemoveFollow, uidFollower: uidFollower)) {
      followingUidsOfRemoveFollow.remove(uidFollower);
      followersUidsOfuidFollower.remove(uidIsRemoveFollow);

      followRepository.updateFollowing(
          uidAuth: uidIsRemoveFollow, newValue: followingUidsOfRemoveFollow);
      followRepository.updateFollowers(
          uidAuth: uidFollower, newValue: followersUidsOfuidFollower);
    }
  }

  Future<({int followersQuantity, int followingQuantity})> getFollowInformation(
      {required String uidAuth}) async {
    int followersQuantity =
        (await followRepository.safeReadFollowers(uidAuth: uidAuth)).length;
    int followingQuantity =
        (await followRepository.safeReadFollowing(uidAuth: uidAuth)).length;
    return (
      followersQuantity: followersQuantity,
      followingQuantity: followingQuantity
    );
  }
}
