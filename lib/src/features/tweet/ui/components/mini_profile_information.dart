import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tweet_app/src/features/tweet/ui/components/profile_picture.dart';

class MiniProfileInformation extends StatelessWidget {
  final Image profileImage;
  final int followersAmount;
  final int followingAmount;
  final String identifier;

  const MiniProfileInformation({
    super.key,
    required this.profileImage,
    required this.followersAmount,
    required this.followingAmount,
    required this.identifier,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProfilePicture(
          profileImage: profileImage,
          imageOnTap: () {},
          height: 50,
          width: 50,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          identifier,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Text('$followingAmount Following  $followersAmount Followers'),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
