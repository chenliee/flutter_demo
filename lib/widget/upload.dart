import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rating/http/upload.dart';

class UpLoadImage {
  static Future<String> uploadImage({required int type}) async {
    final ImagePicker _picker = ImagePicker();
    var pickedFile = await _picker.pickImage(
        source: type == 0 ? ImageSource.gallery : ImageSource.camera);
    File selectedImage =
        await picFileCompressAndGetFile(File(pickedFile!.path)) as File;
    String res = await UploadResponse.upload(path: selectedImage.path);
    return res;
  }

  static Future<Object?> picFileCompressAndGetFile(File file) async {
    if (file.readAsBytesSync().lengthInBytes / 1024 < 2 * 1024) return file;
    final filePath = file.absolute.path;
    final lastIndex = filePath.lastIndexOf(RegExp(r'.jp'));
    final splitter = filePath.substring(0, (lastIndex));
    final outPath = "${splitter}_out${filePath.substring(lastIndex)}";

    return await FlutterImageCompress.compressAndGetFile(
      filePath,
      outPath,
      quality: 88,
      rotate: 180,
    );
  }
}
