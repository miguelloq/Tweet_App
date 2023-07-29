import 'package:cloud_firestore/cloud_firestore.dart';

class FollowRepositoryFirestore {
  final FirebaseFirestore firestoreInstance;
  final CollectionReference referenceFollow;

  FollowRepositoryFirestore({required this.firestoreInstance})
      : referenceFollow = firestoreInstance.collection('follow');

  Future<void> _createDocFollow({required String uidAuth}) async {
    return await referenceFollow.doc(uidAuth).set({
      'following': [],
      'followers': [],
    });
  }

  Future<DocumentSnapshot> _safeGetDoc({required String uidAuth}) async {
    DocumentSnapshot snapshot = await referenceFollow.doc(uidAuth).get();
    if (snapshot.exists) {
      return snapshot;
    } else {
      await _createDocFollow(uidAuth: uidAuth);
      return await referenceFollow.doc(uidAuth).get();
    }
  }

  Future<List<String>> safeReadFollowers({required String uidAuth}) async {
    DocumentSnapshot uidSnapshot = await _safeGetDoc(uidAuth: uidAuth);
    Map<String, dynamic> uidData = uidSnapshot.data() as Map<String, dynamic>;
    return List<String>.from(uidData['followers'] as List<dynamic>);
  }

  Future<List<String>> safeReadFollowing({required String uidAuth}) async {
    DocumentSnapshot uidSnapshot = await _safeGetDoc(uidAuth: uidAuth);
    Map<String, dynamic> uidData = uidSnapshot.data() as Map<String, dynamic>;
    return List<String>.from(uidData['following'] as List<dynamic>);
  }

  Future<DocumentSnapshot> safeReadFollowInformation(
      {required String uidAuth}) async {
    return await _safeGetDoc(uidAuth: uidAuth);
  }

  Future<void> updateFollowers(
      {required String uidAuth, required List<String> newValue}) async {
    await referenceFollow.doc(uidAuth).update({'followers': newValue});
  }

  Future<void> updateFollowing(
      {required uidAuth, required List<String> newValue}) async {
    await referenceFollow.doc(uidAuth).update({'following': newValue});
  }
}
