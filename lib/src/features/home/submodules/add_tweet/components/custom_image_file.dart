import 'dart:io';

import 'package:flutter/material.dart';

class CustomImageFile extends StatelessWidget {
  final VoidCallback iconButtonFunction;
  final File chosenFile;
  final double height;
  final double width;

  const CustomImageFile(
      {super.key,
      required this.iconButtonFunction,
      required this.chosenFile,
      required this.height,
      required this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.file(chosenFile),
          ),
          Stack(children: [
            Icon(Icons.circle, color: Colors.grey.shade900),
            InkWell(
              onTap: iconButtonFunction,
              child: const Icon(Icons.close, color: Colors.white),
            ),
          ]),
        ],
      ),
    );
  }
}
