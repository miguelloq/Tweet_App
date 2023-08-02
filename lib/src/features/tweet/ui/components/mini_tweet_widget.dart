import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tweet_app/src/features/tweet/services/tweet_repository_firestore.dart';
import 'package:tweet_app/src/features/tweet/ui/components/custom_carousel_slider.dart';
import 'package:tweet_app/src/features/tweet/ui/components/profile_picture.dart';
import 'package:tweet_app/src/features/tweet/store/mini_tweet_store.dart';

class MiniTweetWidget extends StatelessWidget {
  final String uidTweetOwner;
  final String uidLikeOwner;
  final String idTweet;
  final String identifier;
  final String text;
  final int commentsQuantity;
  final int likesQuantity;
  final List<String> imagesUrls;
  final String profileImageUrl;
  final MiniTweetStore miniTweetStore;
  final bool isAlreadyLiked;

  MiniTweetWidget({
    super.key,
    required this.identifier,
    required this.text,
    required this.isAlreadyLiked,
    required this.commentsQuantity,
    required this.likesQuantity,
    required this.profileImageUrl,
    required this.imagesUrls,
    required this.idTweet,
    required this.uidLikeOwner,
    required this.uidTweetOwner,
  }) : miniTweetStore = MiniTweetStore(
          likesQuantity: likesQuantity,
          tweetRepositoryFirestore: Modular.get<TweetRepositoryFirestore>(),
          docNameTweet: idTweet,
          uidTweetOwner: uidTweetOwner,
          uidLikeOwner: uidLikeOwner,
          isLiked: isAlreadyLiked,
        );

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProfilePicture(
          height: 40,
          width: 40,
          profileImage: Image.network(profileImageUrl),
          imageOnTap: () {
            Modular.to.pushNamed('/tweet/profile/$uidTweetOwner');
          },
        ),
        const SizedBox(
          width: 5,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                identifier,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                text,
              ),
              const SizedBox(
                height: 5,
              ),
              if (imagesUrls.isNotEmpty)
                CustomCarouselSlider(
                  imageNetworkUrl: imagesUrls,
                  imageHeight: 300,
                ),
              const SizedBox(
                width: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      Modular.to.pushNamed('/tweet/fullTweet/$idTweet');
                    },
                    child: Row(
                      children: [
                        const Icon(
                          Icons.comment,
                        ),
                        Text(commentsQuantity.toString()),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      miniTweetStore.tapLikeAction();
                    },
                    child: Observer(
                      builder: (_) => Row(
                        children: [
                          Icon(
                            Icons.favorite_border,
                            color: miniTweetStore.iconLikeColor,
                          ),
                          Text(miniTweetStore.likesQuantity.toString()),
                        ],
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        Modular.to.pushNamed('/tweet/fullTweet/$idTweet');
                      },
                      icon: const Icon(Icons.expand_less)),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
