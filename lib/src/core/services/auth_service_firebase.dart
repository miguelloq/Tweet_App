import 'package:firebase_auth/firebase_auth.dart';
import 'package:tweet_app/src/core/repositories/user_repository_firestore.dart';

class AuthServiceFirebase {
  final FirebaseAuth firebaseAuth;
  final UserRepositoryFirestore userRepositoryFirestore;

  AuthServiceFirebase(
      {required this.firebaseAuth, required this.userRepositoryFirestore});

  Future<String?> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
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
    required String identifier,
  }) async {
    try {
      if (await userRepositoryFirestore.isIdentifierAvailable(
          identifierValue: identifier)) {
        UserCredential newUserCredential = await firebaseAuth
            .createUserWithEmailAndPassword(email: email, password: password);
        var newUserUid = newUserCredential.user!.uid;

        await userRepositoryFirestore.createUser(
            uidAuth: newUserUid, identifier: identifier);
      } else {
        return 'The identifer is not available';
      }
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'email-already-in-use':
          return 'The email has already been registered';
        case 'weak-password':
          return 'Your password must have at least 6 characters';
      }
      return e.code;
    } on Exception catch (e) {
      return e.toString();
    }
    return null;
  }

  Future<String?> resetPassword({
    required String email,
  }) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          return 'No user with this information was found.';
      }
      return e.code;
    }
    return null;
  }

  Future<String?> logoutUser() async {
    try {
      await firebaseAuth.signOut();
    } on FirebaseAuthException catch (e) {
      return e.code;
    }
    return null;
  }

  String? getCurrentUserUid() {
    User? currentUser = firebaseAuth.currentUser;
    if (currentUser == null) {
      return null;
    } else {
      return currentUser.uid;
    }
  }
}
