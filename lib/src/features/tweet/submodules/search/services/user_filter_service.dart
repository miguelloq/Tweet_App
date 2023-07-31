import 'package:tweet_app/src/core/repositories/user_repository_firestore.dart';

class UserFilterService {
  final UserRepositoryFirestore userRepository;

  UserFilterService({required this.userRepository});

  // Future<List<String>> get({required String whereInput}) async {
  //   var querySnapshot =
  //       await userRepository.readUsersBasedOnIdentifier(whereInput: whereInput);
  //   List<String> usersUrls = [];
  //   for (var docSnapshot in querySnapshot.docs) {
  //     Map<String, dynamic> docMap = docSnapshot.data() as Map<String, dynamic>;
  //     usersUrls.add(docMap['uidAuth']);
  //   }
  //   return usersUrls;
  // }
}
