import 'package:image_picker/image_picker.dart';

XFile? image;

String? imagepath;

class ImagePickerWidget {
  static getimage({required ImageSource source}) async {
    image = await ImagePicker().pickImage(source: source);

    if (image != null) {
      imagepath = (image!.path);
    } else {
      return null;
    }
  }
}
