import 'package:flutter/material.dart';

class ProfilePicture extends StatelessWidget {
  final VoidCallback imageOnTap;
  final double height;
  final double width;
  final Image profileImage;
  const ProfilePicture(
      {super.key,
      required this.profileImage,
      required this.imageOnTap,
      required this.height,
      required this.width});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: imageOnTap,
      child: Ink.image(
        height: height,
        width: width,
        image: profileImage.image,
      ),
    );
  }
}
