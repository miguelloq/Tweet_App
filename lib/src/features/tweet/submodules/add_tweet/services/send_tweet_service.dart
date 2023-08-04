import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:tweet_app/src/core/repositories/cloud_storage_repository_firebase.dart';
import 'package:tweet_app/src/features/tweet/services/tweet_repository_firestore.dart';
import '../models/image_request_model.dart';
import 'random_generator_id_service.dart';

class SendTweetService {
  final TweetRepositoryFirestore tweetRepository;
  final CloudStorageRepositoryFirebase storageRepository;
  final RandomGeneratorIdService generator;

  SendTweetService(
      {required this.tweetRepository,
      required this.storageRepository,
      required this.generator});

  Future<List<String>> _sendImagesTweet(
      {required String uidAuth,
      required String tweetDocName,
      required List<ImageRequestModel> imageList}) async {
    List<String> imageFullPaths = [];
    for (var image in imageList) {
      TaskSnapshot snapshot = await storageRepository.uploadImageFileTweet(
          uidAuth: uidAuth,
          tweetDocName: tweetDocName,
          imageId: image.fileName,
          imageFileDevicePath: image.filePath);
      imageFullPaths.add(snapshot.ref.fullPath);
    }
    return imageFullPaths;
  }

  Future<void> _createTweetAndSendImages({
    required String uidAuth,
    required String bodyText,
    required String docTweetName,
    List<ImageRequestModel>? imageList,
    bool isComment = false,
  }) async {
    String docNewTweetName = docTweetName;
    List<String> imageFullPaths = [];
    if (imageList != null) {
      imageFullPaths = await _sendImagesTweet(
          uidAuth: uidAuth,
          tweetDocName: docNewTweetName,
          imageList: imageList);
    }
    await tweetRepository.createTweet(
      docTweetName: docNewTweetName,
      uidAuth: uidAuth,
      bodyText: bodyText,
      postCreationTime: DateTime.now(),
      images: imageFullPaths,
      isComment: isComment,
    );
  }

  Future<void> sendTweet({
    required String uidAuth,
    required String bodyText,
    List<ImageRequestModel>? imageList,
  }) async {
    String docTweetName = generator.idGeneration();
    if (imageList == null) {
      await _createTweetAndSendImages(
          uidAuth: uidAuth, bodyText: bodyText, docTweetName: docTweetName);
    } else {
      await _createTweetAndSendImages(
          uidAuth: uidAuth,
          bodyText: bodyText,
          docTweetName: docTweetName,
          imageList: imageList);
    }
  }

  Future<void> sendTweetComment({
    required String uidAuth,
    required String bodyText,
    List<ImageRequestModel>? imageList,
    required String commentedTweetDocName,
  }) async {
    String docTweetName = generator.idGeneration();

    DocumentSnapshot commentedDoc =
        await tweetRepository.readTweet(docNameTweet: commentedTweetDocName);

    if (commentedDoc.exists) {
      if (imageList == null) {
        await _createTweetAndSendImages(
          uidAuth: uidAuth,
          bodyText: bodyText,
          docTweetName: docTweetName,
          isComment: true,
        );
      } else {
        await _createTweetAndSendImages(
          uidAuth: uidAuth,
          bodyText: bodyText,
          docTweetName: docTweetName,
          imageList: imageList,
          isComment: true,
        );
      }

      Map<String, dynamic> commentedMap =
          commentedDoc.data() as Map<String, dynamic>;
      List<String> commentDocNames =
          List<String>.from(commentedMap['commentDocNames'] as List<dynamic>);
      commentDocNames.add(docTweetName);

      tweetRepository.updateTweet(
          tweetDocName: commentedTweetDocName,
          field: 'commentDocNames',
          newValue: commentDocNames);
    } else {
      Exception('The tweet that will receive a comment does not exist.');
    }
  }
}
