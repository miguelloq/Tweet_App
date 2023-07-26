import 'package:flutter/material.dart';

class ProfilePicture extends StatelessWidget {
  final VoidCallback buttonFuncion;
  final double height;
  final double width;
  final String profileImageUrl;
  const ProfilePicture(
      {super.key,
      required this.profileImageUrl,
      required this.buttonFuncion,
      required this.height,
      required this.width});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttonFuncion,
      child: SizedBox(
        height: height,
        width: width,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(
            profileImageUrl,
          ),
        ),
      ),
    );
  }
}
