import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tweet_app/src/features/tweet/models/tweet_request_model.dart';
import 'package:tweet_app/src/features/tweet/services/get_like_information_service.dart';
import 'package:tweet_app/src/features/tweet/store/full_tweet_store.dart';
import 'package:tweet_app/src/features/tweet/ui/components/add_tweet_mini_button.dart';
import 'package:tweet_app/src/features/tweet/ui/components/custom_carousel_slider.dart';
import 'package:tweet_app/src/features/tweet/ui/components/date_line.dart';
import 'package:tweet_app/src/features/tweet/ui/components/mini_tweet_widget.dart';
import 'package:tweet_app/src/features/tweet/ui/components/profile_picture.dart';
import 'package:tweet_app/src/features/tweet/ui/components/tweet_details.dart';

class FullTweetScreen extends StatefulWidget {
  final String uidVisitor;
  final String docNameTweet;
  const FullTweetScreen({
    super.key,
    required this.uidVisitor,
    required this.docNameTweet,
  });

  @override
  State<FullTweetScreen> createState() => _TweetScreenState();
}

class _TweetScreenState extends State<FullTweetScreen> {
  FullTweetStore tweetStore = Modular.get<FullTweetStore>();

  @override
  void initState() {
    tweetStore.loadInformation(tweetDocName: widget.docNameTweet);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Tweet',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
            onPressed: () {
              Modular.to.pop();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () =>
            tweetStore.loadInformation(tweetDocName: widget.docNameTweet),
        child: Observer(
          builder: (_) => switch (tweetStore.screenState) {
            (FullTweetScreenState.idle) => const Center(
                child: Text('No tweet find!'),
              ),
            (FullTweetScreenState.error) => Center(
                child: Text(tweetStore.errorMessage == null
                    ? 'Error'
                    : 'Error:$tweetStore.errorMessage!'),
              ),
            (FullTweetScreenState.loading) => const Center(
                child: Text('Waiting...'),
              ),
            (FullTweetScreenState.loaded) => CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              ProfilePicture(
                                profileImage: Image.network(
                                    tweetStore.ownerUser.iconPhoto),
                                imageOnTap: () {
                                  Modular.to.navigate(
                                      '/tweet/profile/${tweetStore.ownerUser.uidAuth}');
                                },
                                height: 50,
                                width: 50,
                              ),
                              Text(
                                tweetStore.ownerUser.identifier,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              const Spacer(),
                              const Icon(Icons.more_vert),
                            ],
                          ),
                          Text(
                            tweetStore.tweet.text,
                            style: const TextStyle(fontSize: 26),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          if (tweetStore.tweet.images.isNotEmpty)
                            CustomCarouselSlider(
                              imageNetworkUrl: tweetStore.tweet.images,
                              imageHeight: 500,
                            ),
                          const Divider(
                            thickness: 2,
                          ),
                          DateLine(
                            date: tweetStore.tweet.postCreationTime,
                            fontSize: 16,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          TweetDetails(
                            commentsAmount:
                                tweetStore.tweet.commentDocNames.length,
                            likesAmount: tweetStore.tweet.likesValue,
                          ),
                          const Divider(
                            thickness: 2,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Center(
                            child: AddTweetMiniButton(
                              docNameTweet: widget.docNameTweet,
                              height: 45,
                              width: 45,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverList.builder(
                    itemCount: tweetStore.comments.length,
                    itemBuilder: (context, index) {
                      TweetRequestModel currentTweet =
                          tweetStore.comments[index].tweet;
                      return Column(
                        children: [
                          MiniTweetWidget(
                            identifier:
                                tweetStore.comments[index].userIdentifier,
                            text: currentTweet.text,
                            isAlreadyLiked: GetLikeInformationService()
                                .isTweetLikedByAUser(
                                    userUidListWhoLiked:
                                        currentTweet.likesUidUsers,
                                    uidAuth: currentTweet.uidPoster),
                            commentsQuantity:
                                currentTweet.commentDocNames.length,
                            likesQuantity: currentTweet.likesValue,
                            profileImageUrl: tweetStore
                                .comments[index].profilePictureNetworkUrl,
                            idTweet: currentTweet.docName,
                            uidLikeOwner: widget.uidVisitor,
                            uidTweetOwner: currentTweet.uidPoster,
                            imagesUrls: currentTweet.images,
                          ),
                          const Divider(),
                        ],
                      );
                    },
                  ),
                ],
              ),
          },
        ),
      ),
    );
  }
}
