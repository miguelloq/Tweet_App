import 'package:flutter/material.dart';

class ProfileBanner extends StatelessWidget {
  final Image imageBanner;
  final Image imageAvatar;
  final String identifier;
  final int followingQuantity;
  final int followersQuantity;
  final bool isFollowing;
  final VoidCallback followButtonFunction;

  const ProfileBanner({
    super.key,
    required this.imageBanner,
    required this.imageAvatar,
    required this.identifier,
    required this.followingQuantity,
    required this.followersQuantity,
    required this.isFollowing,
    required this.followButtonFunction,
  });

  final int coverHeight = 250;
  final int radiusAvatar = 75;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: radiusAvatar.toDouble()),
              width: MediaQuery.sizeOf(context).width,
              height: coverHeight.toDouble(),
              child: imageBanner,
            ),
            Positioned(
              top: (coverHeight - radiusAvatar).toDouble(),
              child: CircleAvatar(
                radius: radiusAvatar.toDouble(),
                child: ClipOval(child: imageAvatar),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          identifier,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Text(
                  followersQuantity.toString(),
                  style: const TextStyle(fontSize: 20),
                ),
                const Text(
                  'Followers',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  followingQuantity.toString(),
                  style: const TextStyle(fontSize: 20),
                ),
                const Text(
                  'Following',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          width: MediaQuery.sizeOf(context).width * 0.75,
          height: 50,
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: isFollowing
                  ? const MaterialStatePropertyAll(Colors.black)
                  : const MaterialStatePropertyAll(Colors.indigo),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
              ),
            ),
            onPressed: followButtonFunction,
            child: isFollowing
                ? const Text(
                    'Following',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  )
                : const Text(
                    'Follow',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
          ),
        ),
        const Divider(
          thickness: 1.5,
        ),
      ],
    );
  }
}
