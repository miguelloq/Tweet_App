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

  Future<void> sendTweet({
    required String uidAuth,
    required String bodyText,
    List<ImageRequestModel>? imageList,
  }) async {
    String docNewTweetName = generator.idGeneration();
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
    );
  }
}
