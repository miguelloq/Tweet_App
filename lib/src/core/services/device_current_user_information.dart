import 'package:firebase_auth/firebase_auth.dart';

class DeviceCurrentUserInformation {
  final FirebaseAuth firebaseAuth;

  DeviceCurrentUserInformation({required this.firebaseAuth});

  String? getCurrentUserUid() {
    User? currentUser = firebaseAuth.currentUser;
    if (currentUser == null) {
      return null;
    } else {
      return currentUser.uid;
    }
  }
}
