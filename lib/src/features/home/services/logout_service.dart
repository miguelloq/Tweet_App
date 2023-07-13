import 'package:firebase_auth/firebase_auth.dart';

class LogoutService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Future<String?> logout() async {
    try {
      await _firebaseAuth.signOut();
    } on FirebaseAuthException catch (e) {
      return e.code;
    }
    return null;
  }
}
