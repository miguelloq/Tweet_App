import 'package:tweet_app/src/core/repositories/user_repository_firestore.dart';
import 'package:tweet_app/src/features/tweet/models/user_request_model.dart';
import 'package:tweet_app/src/features/tweet/services/get_user_information_service.dart';

class UserFilterService {
  final UserRepositoryFirestore userRepository;
  final GetUserInformationService getUser;

  UserFilterService({required this.userRepository, required this.getUser});

  Future<List<String>> _findedUsersUids({required String searchInput}) async {
    List<String> usersUrls = [];

    if (searchInput != '') {
      var querySnapshot = await userRepository.readUsersBasedOnIdentifier(
          queryInput: searchInput);

      for (var docSnapshot in querySnapshot.docs) {
        Map<String, dynamic> docMap =
            docSnapshot.data() as Map<String, dynamic>;
        usersUrls.add(docMap['uidAuth']);
      }
    }
    return usersUrls;
  }

  Future<List<UserRequestModel>> findedUsersWithProfileNetworkUrl(
      {required String searchInput}) async {
    List<String> findedUsersUids =
        await _findedUsersUids(searchInput: searchInput);
    List<UserRequestModel> usersWithNetworkImage = [];
    for (var uid in findedUsersUids) {
      usersWithNetworkImage.add(await getUser.getUserWithNetworkImage(
        uidAuth: uid,
        isOnlyProfilePicture: true,
      ));
    }
    return usersWithNetworkImage;
  }
}
