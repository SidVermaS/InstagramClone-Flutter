import 'dart:io';

import 'package:compressimage/compressimage.dart';
import 'package:image_picker/image_picker.dart';

class ImageUtils  {
  Future<File> getImage(ImageSource imageSource) async {
    return await ImagePicker.pickImage(source: imageSource);
  }
  Future<void> compressImage(File file) async {
    await CompressImage.compress(imageSrc: file.path, desiredQuality: 10);
  }
}
