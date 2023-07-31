import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tweet_app/src/core/repositories/cloud_storage_repository_firebase.dart';

class UserRepositoryFirestore {
  final FirebaseFirestore firestoreInstance;
  final CloudStorageRepositoryFirebase storageRepository;
  final CollectionReference referenceUsers;

  UserRepositoryFirestore(
      {required this.firestoreInstance, required this.storageRepository})
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
    String refInStorageIcon =
        storageRepository.getStorageRefIcon(uidAuth: uidAuth);
    String refInStorageBanner =
        storageRepository.getStorageRefBanner(uidAuth: uidAuth);

    await storageRepository.uploadImageAsset(
      getStorageLocalRef: refInStorageBanner,
      assetLocation: 'assets/profile_banner_default.jpg',
    );
    await storageRepository.uploadImageAsset(
      getStorageLocalRef: refInStorageIcon,
      assetLocation: 'assets/profile_icon_default.jpg',
    );

    return referenceUsers.doc(uidAuth).set({
      'uidAuth': uidAuth,
      'identifier': identifier,
      'iconPhoto': refInStorageIcon,
      'bannerPhoto': refInStorageBanner,
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

  Future<DocumentSnapshot> readUser({required String uidAuth}) async {
    return await referenceUsers.doc(uidAuth).get();
  }

  Future<QuerySnapshot> readUsersBasedOnIdentifier(
      {required String whereInput}) async {
    return await referenceUsers
        .where(
          'identifier',
          isGreaterThanOrEqualTo: whereInput,
          isLessThanOrEqualTo: whereInput + '\uf8ff',
        )
        .limit(10)
        .get();
  }
}
