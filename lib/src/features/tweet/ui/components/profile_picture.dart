import 'package:flutter/material.dart';

class ProfilePicture extends StatelessWidget {
  final VoidCallback buttonFuncion;
  final String profileImageUrl;
  const ProfilePicture(
      {super.key, required this.profileImageUrl, required this.buttonFuncion});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttonFuncion,
      child: SizedBox(
        height: 40,
        width: 40,
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
