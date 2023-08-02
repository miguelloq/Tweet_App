import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tweet_app/src/features/tweet/models/tweet_request_model.dart';
import 'package:tweet_app/src/features/tweet/models/user_request_model.dart';
import 'package:tweet_app/src/features/tweet/services/get_like_information_service.dart';
import 'package:tweet_app/src/features/tweet/store/profile_store.dart';
import 'package:tweet_app/src/features/tweet/ui/components/mini_tweet_widget.dart';
import 'package:tweet_app/src/features/tweet/ui/components/profile_banner.dart';

class ProfileScreen extends StatefulWidget {
  final String uidOwnerProfile;
  final String uidVisitor;
  const ProfileScreen(
      {super.key, required this.uidOwnerProfile, required this.uidVisitor});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ProfileStore profileStore = Modular.get<ProfileStore>();

  @override
  void initState() {
    profileStore.loadInformation(
        uidProfileOwner: widget.uidOwnerProfile, uidVisitor: widget.uidVisitor);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Screen'),
      ),
      body: Observer(
        builder: (_) {
          switch (profileStore.profileScreenState) {
            case ProfileScreenState.error:
              return Center(
                child: Text(profileStore.errorMessage!),
              );
            case ProfileScreenState.loading:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case ProfileScreenState.loaded:
              UserRequestModel profileOwner = profileStore.profileOwner;
              return Column(
                children: [
                  Observer(
                    builder: (_) => ProfileBanner(
                        imageBanner: Image.network(profileOwner.bannerPhoto),
                        imageAvatar: Image.network(profileOwner.iconPhoto),
                        identifier: profileOwner.identifier,
                        followingQuantity: 0,
                        followersQuantity: 0,
                        isFollowing: profileStore.isFollowing,
                        followButtonFunction: () => profileStore
                            .buttonFollowAction(uid: widget.uidVisitor)),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: profileStore.tweetList.length,
                      itemBuilder: (context, index) {
                        TweetRequestModel currentTweet =
                            profileStore.tweetList.elementAt(index);
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(16, 12, 16, 6),
                              child: MiniTweetWidget(
                                identifier: profileOwner.identifier,
                                text: currentTweet.text,
                                isAlreadyLiked: GetLikeInformationService()
                                    .isTweetLikedByAUser(
                                        userUidListWhoLiked:
                                            currentTweet.likesUidUsers,
                                        uidAuth: widget.uidVisitor),
                                commentsQuantity:
                                    currentTweet.commentDocNames.length,
                                likesQuantity: currentTweet.likesValue,
                                profileImageUrl: profileOwner.iconPhoto,
                                idTweet: currentTweet.docName,
                                uidLikeOwner: widget.uidVisitor,
                                uidTweetOwner: profileOwner.uidAuth,
                                imagesUrls: currentTweet.images,
                              ),
                            ),
                            const Divider(
                              thickness: 1.5,
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              );
          }
        },
      ),
    );
  }
}
