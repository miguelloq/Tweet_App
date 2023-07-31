import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tweet_app/src/core/repositories/cloud_storage_repository_firebase.dart';
import 'package:tweet_app/src/features/tweet/models/tweet_request_model.dart';
import 'package:tweet_app/src/features/tweet/services/tweet_repository_firestore.dart';

class GetTweetInformationService {
  final TweetRepositoryFirestore tweetRepository;
  final CloudStorageRepositoryFirebase storageRepository;

  GetTweetInformationService(
      {required this.tweetRepository, required this.storageRepository});

  Future<Map<String, dynamic>> _getTweetAsMap(
      {required String uidAuth, required docName}) async {
    DocumentSnapshot tweetSnapshot =
        await tweetRepository.readTweet(docNameTweet: docName);
    if (tweetSnapshot.exists) {
      return tweetSnapshot.data() as Map<String, dynamic>;
    } else {
      throw Exception('Error in getUser because document dont exists.');
    }
  }

  Future<TweetRequestModel> getTweetWithNetworkImage(
      {required String uidAuth, required docName}) async {
    Map<String, dynamic> tweetMap =
        await _getTweetAsMap(uidAuth: uidAuth, docName: docName);

    TweetRequestModel tweetRequest = TweetRequestModel.fromMap(tweetMap);

    List<String> urlImages = [];
    for (var imagePath in tweetRequest.images) {
      urlImages
          .add(await storageRepository.getImageUrl(storagePath: imagePath));
    }

    tweetRequest = tweetRequest.copyWith(images: urlImages);
    return tweetRequest;
  }

  Future<List<Map<String, dynamic>>> _getAllTweetsAsMapList(
      {required String uidAuth}) async {
    QuerySnapshot queryTweets =
        await tweetRepository.readAllTweetsFromUser(uidAuth: uidAuth);
    List<Map<String, dynamic>> documentList = [];
    for (var doc in queryTweets.docs) {
      if (doc.exists) {
        Map<String, dynamic> documentData = doc.data() as Map<String, dynamic>;
        documentData['docName'] = doc.id;
        documentList.add(documentData);
      }
    }
    return documentList;
  }

  Future<List<TweetRequestModel>> getAllTweetsWithNetworkImage({
    required String uidAuth,
    required bool isSortedByPostCreationTime,
  }) async {
    List<Map<String, dynamic>> listMapAllTweets =
        await _getAllTweetsAsMapList(uidAuth: uidAuth);

    List<TweetRequestModel> listAllTweets =
        listMapAllTweets.map((e) => TweetRequestModel.fromMap(e)).toList();

    List<TweetRequestModel> listAllTweetsWithNetworkImage = [];
    for (var tweet in listAllTweets) {
      List<String> imagesUrl = [];
      for (var imagePath in tweet.images) {
        imagesUrl
            .add(await storageRepository.getImageUrl(storagePath: imagePath));
      }
      listAllTweetsWithNetworkImage.add(tweet.copyWith(images: imagesUrl));
    }
    if (isSortedByPostCreationTime) {
      listAllTweetsWithNetworkImage
          .sort((a, b) => b.getTweetDate().compareTo(a.getTweetDate()));
    }
    return listAllTweetsWithNetworkImage;
  }
}
