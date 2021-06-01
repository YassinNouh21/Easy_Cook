import 'dart:io';

import 'package:image_picker/image_picker.dart';

class picker {
  final ImagePicker _imagePicker = ImagePicker();
  Future uploadPhoto(var image) async {
    var pickedImage = await _imagePicker.getImage(source: ImageSource.gallery);
    if (pickedImage == null) {
      return print('no image was selected');
    } else {
      setState() {
        image = File(pickedImage.path);
      }
    }
  }
}
