import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';

class CloudStorageRepositoryFirebase {
  final FirebaseStorage storageInstance;

  CloudStorageRepositoryFirebase({required this.storageInstance});

  Future<TaskSnapshot> _uploadImageFileGeneric(
      {required String refLocal, required String imageFileDevicePath}) {
    File file = File(imageFileDevicePath);
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

  Future<TaskSnapshot> uploadImageAsset({
    required getStorageLocalRef,
    required String assetLocation,
  }) async {
    try {
      ByteData imageData = await rootBundle.load(assetLocation);
      Uint8List imageBytes = imageData.buffer.asUint8List();
      return storageInstance
          .ref()
          .child(getStorageLocalRef)
          .putData(imageBytes);
    } on FirebaseException catch (e) {
      throw Exception('Error in the upload: ${e.code}');
    }
  }

  String getStorageRefTweet(
      {required String uidAuth, required tweetDocName, String? imageId}) {
    if (imageId == null) {
      return 'images/tweets/$uidAuth/$tweetDocName';
    } else {
      return 'images/tweets/$uidAuth/$tweetDocName/$imageId';
    }
  }

  String getStorageRefIcon({required String uidAuth}) {
    return 'images/profile/$uidAuth/profile_banner_default';
  }

  String getStorageRefBanner({required String uidAuth}) {
    return 'images/profile/$uidAuth/profile_icon_default';
  }

  Future<TaskSnapshot> uploadImageFileTweet({
    required String uidAuth,
    required String tweetDocName,
    required String imageId,
    required String imageFileDevicePath,
  }) async {
    String refLocal =
        getStorageRefTweet(uidAuth: uidAuth, tweetDocName: tweetDocName);
    return await _uploadImageFileGeneric(
        refLocal: refLocal, imageFileDevicePath: imageFileDevicePath);
  }

  Future<TaskSnapshot> uploadImageFileBannerUser({
    required String uidAuth,
    required String imageFileDevicePath,
  }) async {
    String refLocal = getStorageRefBanner(uidAuth: uidAuth);
    return await _uploadImageFileGeneric(
        refLocal: refLocal, imageFileDevicePath: imageFileDevicePath);
  }

  Future<TaskSnapshot> uploadImageFileIconUser(
      {required String uidAuth, required String imageFileDevicePath}) async {
    String refLocal = getStorageRefIcon(uidAuth: uidAuth);
    return await _uploadImageFileGeneric(
        refLocal: refLocal, imageFileDevicePath: imageFileDevicePath);
  }

  Future<String> getImageUrl({required String storagePath}) async {
    return await storageInstance.ref().child(storagePath).getDownloadURL();
  }
}
