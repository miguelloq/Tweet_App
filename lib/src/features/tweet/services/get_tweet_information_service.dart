import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tweet_app/src/core/repositories/cloud_storage_repository_firebase.dart';
import 'package:tweet_app/src/features/tweet/models/tweet_request_model.dart';
import 'package:tweet_app/src/features/tweet/services/tweet_repository_firestore.dart';

class GetTweetInformationService {
  TweetRepositoryFirestore tweetRepository;
  CloudStorageRepositoryFirebase storageRepository;

  GetTweetInformationService(
      {required this.tweetRepository, required this.storageRepository});

  Future<Map<String, dynamic>> _getTweetAsMap(
      {required String uidAuth, required docName}) async {
    DocumentSnapshot tweetSnapshot = await tweetRepository.readTweet(
        uidAuth: uidAuth, docNameTweet: docName);
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

    var listResultAllImagesFromTweet = await storageRepository.storageInstance
        .ref()
        .child(storageRepository.getStorageLocalRefTweet(
            uidAuth: uidAuth, tweetDocName: docName))
        .listAll();
    List<String> urlImages = [];
    for (var photo in listResultAllImagesFromTweet.items) {
      urlImages.add(await photo.getDownloadURL());
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
        documentList.add(doc.data() as Map<String, dynamic>);
      }
    }
    return documentList;
  }

  //TODO  getAllTweetWithNetworkImage
}
