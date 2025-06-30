import 'dart:io';

import 'package:blog_app/core/error/exception.dart';
import 'package:image_picker/image_picker.dart';

Future<File?> pickImage() async {
  try {
    final xFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (xFile != null) {
      return File(xFile.path);
    }
    return null;
  } catch (e) {
    return null;
  }
}
