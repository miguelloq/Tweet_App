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

  Future<void> likeTweet(
      {required String docNameTweet, required uidAuth}) async {
    final docReference = referenceTweets.doc(docNameTweet);

    firestoreInstance.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(docReference);

      if (snapshot.exists) {
        Map<String, dynamic> snapshotData =
            snapshot.data() as Map<String, dynamic>;

        List<String> likesUsers =
            List.from(snapshotData['likesUidUsers'] ?? []);
        int currentValue = snapshotData['likesValue'] ?? 0;

        likesUsers.add(uidAuth);
        currentValue += 1;

        transaction.update(docReference, {
          'likesUidUsers': likesUsers,
          'likesValue': currentValue,
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
}
