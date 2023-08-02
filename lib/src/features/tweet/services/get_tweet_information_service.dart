import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tweet_app/src/core/repositories/cloud_storage_repository_firebase.dart';
import 'package:tweet_app/src/features/tweet/models/tweet_request_model.dart';
import 'package:tweet_app/src/features/tweet/services/tweet_repository_firestore.dart';

class GetTweetInformationService {
  final TweetRepositoryFirestore tweetRepository;
  final CloudStorageRepositoryFirebase storageRepository;

  GetTweetInformationService(
      {required this.tweetRepository, required this.storageRepository});

  Future<TweetRequestModel> _imagePathToNetworkUrlForTweet(
      {required TweetRequestModel tweet}) async {
    List<String> urlImages = [];
    for (var imagePath in tweet.images) {
      urlImages
          .add(await storageRepository.getImageUrl(storagePath: imagePath));
    }
    return tweet.copyWith(images: urlImages);
  }

  Future<Map<String, dynamic>> _getTweetAsMap({required String docName}) async {
    DocumentSnapshot tweetSnapshot =
        await tweetRepository.readTweet(docNameTweet: docName);
    if (tweetSnapshot.exists) {
      Map<String, dynamic> documentData =
          tweetSnapshot.data() as Map<String, dynamic>;
      documentData['docName'] = tweetSnapshot.id;
      return documentData;
    } else {
      throw Exception('Error in getUser because document dont exists.');
    }
  }

  Future<TweetRequestModel> getTweetWithNetworkImage(
      {required String docName}) async {
    Map<String, dynamic> tweetMap = await _getTweetAsMap(docName: docName);

    TweetRequestModel tweetRequest = TweetRequestModel.fromMap(tweetMap);

    tweetRequest = await _imagePathToNetworkUrlForTweet(tweet: tweetRequest);
    return tweetRequest;
  }

  List<Map<String, dynamic>> _getTweetsAsMap({required QuerySnapshot query}) {
    QuerySnapshot queryTweets = query;
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

  Future<List<TweetRequestModel>> _getTweetsWithNetworkImage({
    required QuerySnapshot query,
    required bool isSortedByPostCreationTime,
  }) async {
    List<Map<String, dynamic>> listMapAllTweets = _getTweetsAsMap(query: query);

    List<TweetRequestModel> listAllTweets =
        listMapAllTweets.map((e) => TweetRequestModel.fromMap(e)).toList();

    List<TweetRequestModel> listAllTweetsWithNetworkImage = [];
    for (var tweet in listAllTweets) {
      listAllTweetsWithNetworkImage
          .add(await _imagePathToNetworkUrlForTweet(tweet: tweet));
    }
    if (isSortedByPostCreationTime) {
      listAllTweetsWithNetworkImage
          .sort((a, b) => b.getTweetDate().compareTo(a.getTweetDate()));
    }
    return listAllTweetsWithNetworkImage;
  }

  Future<List<TweetRequestModel>> getAllTweetsWithNetworkImage({
    required String uidAuth,
    required bool isSortedByPostCreationTime,
  }) async {
    return await _getTweetsWithNetworkImage(
      query: await tweetRepository.readAllTweetsFromUser(uidAuth: uidAuth),
      isSortedByPostCreationTime: isSortedByPostCreationTime,
    );
  }

  Future<List<TweetRequestModel>> getTweetsBasedOnIdWithNetworkImage({
    required List<String> documentIds,
    required bool isSortedByPostCreationTime,
  }) async {
    if (documentIds.isNotEmpty) {
      return await _getTweetsWithNetworkImage(
        query: await tweetRepository.readTweetsBasedOnId(tweetIds: documentIds),
        isSortedByPostCreationTime: isSortedByPostCreationTime,
      );
    } else {
      return [];
    }
  }
}
