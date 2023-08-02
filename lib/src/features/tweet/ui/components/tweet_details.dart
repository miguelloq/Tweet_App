import 'package:flutter/material.dart';

class TweetDetails extends StatelessWidget {
  final int commentsAmount;
  final int likesAmount;

  const TweetDetails(
      {super.key, required this.commentsAmount, required this.likesAmount});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        style: const TextStyle(fontSize: 16),
        children: [
          TextSpan(text: likesAmount.toString()),
          const TextSpan(
            text: ' Likes ',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          TextSpan(text: commentsAmount.toString()),
          const TextSpan(
            text: ' Comments ',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
