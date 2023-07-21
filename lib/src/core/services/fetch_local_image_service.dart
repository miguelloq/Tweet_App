import 'package:image_picker/image_picker.dart';

class FetchLocalImageService {
  final ImagePicker picker;

  FetchLocalImageService({required this.picker});

  Future<(String? fileName, String? filePath)> getFileImageCamera() async {
    XFile? image = await picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      return (image.name, image.path);
    } else {
      return (null, null);
    }
  }

  Future<(String? fileName, String? filePath)> getFileImageGallery() async {
    XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      return (image.name, image.path);
    } else {
      return (null, null);
    }
  }
}
