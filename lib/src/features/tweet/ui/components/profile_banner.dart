import 'package:flutter/material.dart';

class ProfileBanner extends StatelessWidget {
  final Image imageBanner;
  final Image imageAvatar;
  final String identifier;
  final int followingQuantity;
  final int followersQuantity;
  final bool isFollowing;
  final VoidCallback followButtonFunction;

  const ProfileBanner(
      {super.key,
      required this.imageBanner,
      required this.imageAvatar,
      required this.identifier,
      required this.followingQuantity,
      required this.followersQuantity,
      required this.isFollowing,
      required this.followButtonFunction});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            SizedBox(
              width: MediaQuery.sizeOf(context).width,
              height: 200,
              child: imageBanner,
            ),
            SizedBox(
              width: 80,
              height: 80,
              child: imageAvatar,
            ),
          ],
        ),
        Text('Following: $followingQuantity'),
        Text('Followers: $followersQuantity'),
        ElevatedButton(
          style: ButtonStyle(
              backgroundColor: isFollowing
                  ? const MaterialStatePropertyAll(Colors.indigo)
                  : const MaterialStatePropertyAll(Colors.black)),
          onPressed: followButtonFunction,
          child: const Text('Follow'),
        ),
      ],
    );
  }
}
