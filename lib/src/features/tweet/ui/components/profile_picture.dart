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
    return GestureDetector(
      onTap: imageOnTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: SizedBox(
          height: height,
          width: width,
          child: profileImage,
        ),
      ),
    );
  }
}
