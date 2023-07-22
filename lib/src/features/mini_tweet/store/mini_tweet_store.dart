import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:tweet_app/src/core/repositories/tweet_repository_firestore.dart';

part 'mini_tweet_store.g.dart';

class MiniTweetStore = _MiniTweetStore with _$MiniTweetStore;

abstract class _MiniTweetStore with Store {
  final String docNameTweet;
  final String uidTweetOwner;
  final String uidLikeOwner;
  final TweetRepositoryFirestore tweetRepositoryFirestore;

  _MiniTweetStore({
    required this.uidLikeOwner,
    required this.uidTweetOwner,
    required this.docNameTweet,
    required this.isLiked,
    required this.tweetRepositoryFirestore,
    required this.likesQuantity,
  }) {
    isLiked == true ? iconLikeColor = Colors.red : iconLikeColor = null;
  }

  @observable
  int likesQuantity;

  @observable
  bool isLiked;

  @observable
  Color? iconLikeColor;

  @action
  tapLikeAction() {
    tweetRepositoryFirestore
        .alterLikesValueTweet(
            docNameTweet: docNameTweet,
            uidTweetOwner: uidTweetOwner,
            uidLikeOwner: uidLikeOwner,
            isIncrement: !isLiked)
        .then((value) {
      if (!isLiked) {
        likesQuantity++;
        iconLikeColor = Colors.red;
      } else {
        likesQuantity--;
        iconLikeColor = null;
      }
      isLiked = !isLiked;
    });
  }
}
