import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tweet_app/src/features/tweet/models/tweet_request_model.dart';
import 'package:tweet_app/src/features/tweet/models/user_request_model.dart';
import 'package:tweet_app/src/features/tweet/services/get_like_information_service.dart';
import 'package:tweet_app/src/features/tweet/store/profile_store.dart';
import 'package:tweet_app/src/features/tweet/ui/components/mini_tweet_widget.dart';

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
    profileStore
        .loadProfileOwnerUser(uidOwnerProfile: widget.uidOwnerProfile)
        .then((_) => profileStore.loadTweetOwnerUser(
            uidOwnerProfile: widget.uidOwnerProfile));
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
            case ProfileScreenState.userLoaded:
              return Center(
                  child: ListView(
                children: [
                  Text(profileStore.profileOwner.identifier),
                  SizedBox(
                      height: 30,
                      width: 30,
                      child:
                          Image.network(profileStore.profileOwner.iconPhoto)),
                  SizedBox(
                      height: 30,
                      width: 30,
                      child:
                          Image.network(profileStore.profileOwner.bannerPhoto)),
                  const Divider(
                    thickness: 2,
                  ),
                ],
              ));
            case ProfileScreenState.fullyLoaded:
              return Center(
                child: ListView.builder(
                  itemCount: profileStore.tweetList.length,
                  itemBuilder: (context, index) {
                    TweetRequestModel currentTweet =
                        profileStore.tweetList.elementAt(index);
                    UserRequestModel profileOwner = profileStore.profileOwner;
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
                            commentsQuantity: 0,
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
              );
          }
        },
      ),
    );
  }
}
