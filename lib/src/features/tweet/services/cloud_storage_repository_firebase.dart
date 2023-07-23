import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class CloudStorageRepositoryFirebase {
  FirebaseStorage storageInstance;

  CloudStorageRepositoryFirebase({required this.storageInstance});

  Future<TaskSnapshot> _uploadImageGeneric(
      {required String refLocal, required String path}) {
    File file = File(path);
    try {
      String refStorage = refLocal;
      final storageRef = storageInstance.ref();
      return storageRef.child(refStorage).putFile(
            file,
          );
    } on FirebaseException catch (e) {
      throw Exception('Error in the upload: ${e.code}');
    }
  }

  Future<TaskSnapshot> uploadImageTweet(
      {required String uidAuth,
      required String tweetDocName,
      required String imageId,
      required String path}) {
    return _uploadImageGeneric(
        refLocal: 'images/tweets/{$uidAuth}/{$tweetDocName/{$imageId}',
        path: path);
  }

  Future<TaskSnapshot> uploadImageBannerUser(
      {required String uidAuth, required String path}) {
    return _uploadImageGeneric(
        refLocal: 'images/tweets/{$uidAuth}/profile/banner_picture',
        path: path);
  }

  Future<TaskSnapshot> uploadImageProfileUser(
      {required String uidAuth, required String path}) {
    return _uploadImageGeneric(
        refLocal: 'images/tweets/{$uidAuth}/profile/profile_picture',
        path: path);
  }

  //TODO GETS Images
}
