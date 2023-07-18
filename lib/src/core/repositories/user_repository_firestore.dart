import 'package:cloud_firestore/cloud_firestore.dart';

class UserRepositoryFirestore {
  final FirebaseFirestore firestoreInstance;
  CollectionReference referenceUsers;

  UserRepositoryFirestore({required this.firestoreInstance})
      : referenceUsers = firestoreInstance.collection('users');

  Future<bool> isIdentifierAvailable({required String identifierValue}) async {
    try {
      final QuerySnapshot snapshot = await referenceUsers
          .where("identifier", isEqualTo: '@$identifierValue')
          .limit(1)
          .get();

      return snapshot.docs.isEmpty;
    } catch (e) {
      return false;
    }
  }

  Future<bool> isUserExistsInUsers({required String uidAuth}) async {
    final QuerySnapshot snapshot = await referenceUsers
        .where('uidAuth', isEqualTo: uidAuth)
        .limit(1)
        .get();

    return snapshot.docs.isNotEmpty;
  }

  Future<void> createUser(
      {required String uidAuth, required String identifier}) async {
    return referenceUsers.doc(uidAuth).set({
      'uidAuth': uidAuth,
      'identifier': '@$identifier',
      'photo': null,
      'bannerPhoto': null,
    });
  }

  Future<void> updateUser(
      {required String uidAuth,
      required String fieldName,
      required newFieldValue}) async {
    if (await isUserExistsInUsers(uidAuth: uidAuth)) {
      referenceUsers.doc(uidAuth).update({fieldName: newFieldValue});
    }
  }

  Future<void> deleteUser({required String uidAuth}) async {
    return await referenceUsers.doc(uidAuth).delete();
  }

  readUser() {
    //TODO readUser, maybe use Records and Patterns
  }
}
