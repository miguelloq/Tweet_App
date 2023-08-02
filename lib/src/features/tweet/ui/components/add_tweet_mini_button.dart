import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AddTweetMiniButton extends StatelessWidget {
  final String docNameTweet;
  final double height;
  final double width;
  const AddTweetMiniButton(
      {super.key,
      required this.docNameTweet,
      required this.height,
      required this.width});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Modular.to.pushNamed('/tweet/addTweet/comment/$docNameTweet');
      },
      borderRadius: BorderRadius.circular(30),
      child: Ink(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(30),
        ),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
