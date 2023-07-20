import 'dart:io';

import 'package:flutter/material.dart';

class CustomImageFile extends StatelessWidget {
  final VoidCallback iconButtonFunction;
  final File chosenFile;

  const CustomImageFile(
      {super.key, required this.iconButtonFunction, required this.chosenFile});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 125,
      width: 125,
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
