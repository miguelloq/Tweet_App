import 'package:image_picker/image_picker.dart';

class FetchLocalImageService {
  final ImagePicker picker;

  FetchLocalImageService({required this.picker});

  Future<XFile?> getFileImagePath() async {
    XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      return image;
    } else {
      return null;
    }
  }
}
