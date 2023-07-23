import 'package:cloud_firestore/cloud_firestore.dart';

class TweetRepositoryFirestore {
  final FirebaseFirestore firestoreInstance;
  CollectionReference referenceTweets;

  TweetRepositoryFirestore({required this.firestoreInstance})
      : referenceTweets = firestoreInstance.collection('tweets');

  Future<void> createTweet({
    required String docTweetName,
    required String uidAuth,
    required String bodyText,
    required DateTime postCreationTime,
    List<String>? images,
  }) async {
    return await referenceTweets
        .doc(uidAuth)
        .collection('usersTweet')
        .doc(docTweetName)
        .set({
      'uidPoster': uidAuth,
      'text': bodyText,
      'postCreationTime': Timestamp.fromDate(postCreationTime),
      'images': images,
      'likesValue': 0,
      'likesUidUsers': [],
    });
  }

  Future<void> alterLikesValueTweet(
      {required String docNameTweet,
      required uidTweetOwner,
      required uidLikeOwner,
      required bool isIncrement}) async {
    final docReference = referenceTweets
        .doc(uidTweetOwner)
        .collection('usersTweet')
        .doc(docNameTweet);

    firestoreInstance.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(docReference);

      if (snapshot.exists) {
        Map<String, dynamic> snapshotData =
            snapshot.data() as Map<String, dynamic>;

        List<String> likesUsers =
            List.from(snapshotData['likesUidUsers'] ?? []);
        int currentValue = snapshotData['likesValue'] ?? 0;

        if (isIncrement) {
          if (!likesUsers.contains(uidLikeOwner)) {
            likesUsers.add(uidLikeOwner);
            currentValue += 1;
          } else {
            Exception(
                'Likeowner tried to like the post, but the like has already been given.');
          }
        } else {
          if (likesUsers.contains(uidLikeOwner) && currentValue > 0) {
            likesUsers.remove(uidLikeOwner);
            currentValue -= 1;
          } else {
            throw Exception(
                'LikeOwner tried to unlike the post, but he had not previously liked it.');
          }
        }

        transaction.update(docReference, {
          'likesValue': currentValue,
          'likesUidUsers': likesUsers,
        });
      } else {
        Exception('Tweet dont exists');
      }
    });
  }

  Future<void> deleteTweet({required uidAuth, required docNameTweet}) async {
    return await referenceTweets
        .doc(uidAuth)
        .collection('usersTweet')
        .doc(docNameTweet)
        .delete();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> readAllTweetsFromUser({
    required String uidAuth,
  }) async {
    return await referenceTweets
        .doc(uidAuth)
        .collection('usersTweet')
        .orderBy('postCreationTime')
        .get();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> readTweet(
      {required String uidAuth, required String docNameTweet}) async {
    return await referenceTweets
        .doc(uidAuth)
        .collection('usersTweet')
        .doc(docNameTweet)
        .get();
  }
}
