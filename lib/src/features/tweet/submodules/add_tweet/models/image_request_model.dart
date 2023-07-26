import 'dart:io';

class ImageRequestModel {
  File file;
  String fileName;
  String filePath;

  ImageRequestModel(
      {required this.file, required this.fileName, required this.filePath});

  bool isSameName({required ImageRequestModel otherImage}) {
    return fileName == otherImage.fileName;
  }
}
