import 'package:firebase_auth/firebase_auth.dart';

class AuthServiceFirebase {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  AuthServiceFirebase();

  Future<String?> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found' || 'wrong-password' || 'invalid-email:':
          return 'Your credentials are wrong';
        case 'user-disabled':
          return 'Your user is disabled';
      }
      return e.code;
    }
    return null;
  }

  Future<String?> registrationUser({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'email-already-in-use':
          return 'The email has already been registered';
        case 'weak-password':
          return 'Your password must have at least 6 characters';
      }
      return e.code;
    }
    return null;
  }

  Future<String?> resetPassword({
    required String email,
  }) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          return 'No user with this information was found.';
      }
      return e.code;
    }
    return null;
  }
}
