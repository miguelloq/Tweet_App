import 'package:flutter/material.dart';

import 'package:tweet_app/src/features/tweet/ui/components/mini_tweet_widget.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feed Screen'),
      ),
      body: ListView.builder(
        itemCount: 3,
        itemBuilder: ((context, index) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 6),
                child: MiniTweetWidget(
                  isAlreadyLiked: false,
                  uidLikeOwner: 'tjxxq0mYmyWChk8b34R4DLSqudT2',
                  uidTweetOwner: 'yth8obRxiRSPS6j6JoQcpQMxz4h2',
                  identifier: '@abc',
                  text:
                      'Hello Worldadsssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss',
                  commentsQuantity: 10,
                  likesQuantity: 22,
                  idTweet: '4859feae-5172-41fa-b9f8-8911f0f437e2',
                  profileImageUrl:
                      'https://firebasestorage.googleapis.com/v0/b/tweet-app-firebase-d1a27.appspot.com/o/images%2Fcore%2Fprofile_icon_default.jpg?alt=media&token=9d671d86-2fb6-40b4-b9b3-ada1aea46805',
                  imagesUrls: const [
                    'https://firebasestorage.googleapis.com/v0/b/tweet-app-firebase-d1a27.appspot.com/o/images%2Ftweets%2F%7Byth8obRxiRSPS6j6JoQcpQMxz4h2%7D%2F%7B82f4d829-a994-4c6d-8896-9079bf8a7435%2FKaiki.jpg?alt=media&token=0df4dcb7-8216-4d38-b3cf-1d3cfa40614e',
                    'https://firebasestorage.googleapis.com/v0/b/tweet-app-firebase-d1a27.appspot.com/o/images%2Ftweets%2F%7Byth8obRxiRSPS6j6JoQcpQMxz4h2%7D%2F%7B82f4d829-a994-4c6d-8896-9079bf8a7435%2Fflos.png?alt=media&token=500bcddd-75a5-4feb-8ab1-9431e092ca76',
                    'https://firebasestorage.googleapis.com/v0/b/tweet-app-firebase-d1a27.appspot.com/o/images%2Ftweets%2F%7Byth8obRxiRSPS6j6JoQcpQMxz4h2%7D%2F%7B82f4d829-a994-4c6d-8896-9079bf8a7435%2F%7BIMG_20230719_231506.jpg%7D?alt=media&token=88f08a71-be06-40fd-8bef-122d07db60e6https://firebasestorage.googleapis.com/v0/b/tweet-app-firebase-d1a27.appspot.com/o/images%2Ftweets%2F%7Byth8obRxiRSPS6j6JoQcpQMxz4h2%7D%2F%7B82f4d829-a994-4c6d-8896-9079bf8a7435%2F%7BIMG_20230719_231506.jpg%7D?alt=media&token=88f08a71-be06-40fd-8bef-122d07db60e6',
                  ],
                ),
              ),
              const Divider(
                thickness: 2,
              )
            ],
          );
        }),
      ),
    );
  }
}
