import 'package:firebase_auth/firebase_auth.dart';

class LogoutService {
  final FirebaseAuth firebaseAuth;

  LogoutService({required this.firebaseAuth});

  Future<String?> logoutUser() async {
    try {
      await firebaseAuth.signOut();
    } on FirebaseAuthException catch (e) {
      return e.code;
    }
    return null;
  }
}
