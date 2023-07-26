class GetLikeInformationService {
  bool isTweetLikedByAUser(
      {required List<String> userUidListWhoLiked, required String uidAuth}) {
    for (var uidLikeUser in userUidListWhoLiked) {
      if (uidLikeUser == uidAuth) {
        return true;
      }
    }
    return false;
  }
}
