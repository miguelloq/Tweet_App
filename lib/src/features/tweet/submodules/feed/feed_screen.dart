import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tweet_app/src/features/tweet/services/get_like_information_service.dart';
import 'package:tweet_app/src/features/tweet/submodules/feed/models/tweet_with_user_information_model.dart';
import 'package:tweet_app/src/features/tweet/submodules/feed/store/feed_store.dart';
import 'package:tweet_app/src/features/tweet/ui/components/mini_tweet_widget.dart';

class FeedScreen extends StatefulWidget {
  final String feedOwnerUid;

  const FeedScreen({super.key, required this.feedOwnerUid});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  late final FeedStore feedStore;

  @override
  void initState() {
    feedStore = Modular.get<FeedStore>();
    feedStore.loadFeed(feedUidAuth: widget.feedOwnerUid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Icon(
          Icons.home_sharp,
          size: 30,
          color: Theme.of(context).primaryColor,
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Icon(
              Icons.notifications,
              size: 30,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ],
      ),
      body: Observer(
        builder: (_) => RefreshIndicator(
          onRefresh: () => feedStore.loadFeed(feedUidAuth: widget.feedOwnerUid),
          child: switch (feedStore.feedScreenState) {
            (FeedScreenState.idle) => const Center(
                child: Text('No tweets here!'),
              ),
            (FeedScreenState.error) => Center(
                child: Text(feedStore.errorMessage == null
                    ? 'Error'
                    : 'Error:$feedStore.errorMessage!'),
              ),
            (FeedScreenState.loading) => const Center(
                child: CircularProgressIndicator(),
              ),
            (FeedScreenState.success) => ListView.builder(
                itemCount: feedStore.tweetList.length,
                itemBuilder: (context, index) {
                  TweetWithUserInformationModel currentTweet =
                      feedStore.tweetList[index];
                  return Column(
                    children: [
                      const Divider(
                        thickness: 1.5,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 12, 16, 6),
                        child: MiniTweetWidget(
                          identifier: currentTweet.user.identifier,
                          text: currentTweet.tweet.text,
                          isAlreadyLiked: GetLikeInformationService()
                              .isTweetLikedByAUser(
                                  userUidListWhoLiked:
                                      currentTweet.tweet.likesUidUsers,
                                  uidAuth: widget.feedOwnerUid),
                          commentsQuantity:
                              currentTweet.tweet.commentDocNames.length,
                          likesQuantity: currentTweet.tweet.likesValue,
                          profileImageUrl: currentTweet.user.iconPhoto,
                          idTweet: currentTweet.tweet.docName,
                          uidLikeOwner: widget.feedOwnerUid,
                          uidTweetOwner: currentTweet.user.uidAuth,
                          imagesUrls: currentTweet.tweet.images,
                        ),
                      ),
                    ],
                  );
                },
              ),
          },
        ),
      ),
    );
  }
}
