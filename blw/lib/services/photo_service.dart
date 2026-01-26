import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class PhotoService {
  static final ImagePicker _picker = ImagePicker();

  static Future<String?> pickImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: source,
        maxWidth: 1200,
        maxHeight: 1200,
        imageQuality: 85,
      );

      if (image == null) return null;

      final directory = await getApplicationDocumentsDirectory();
      final photosDir = Directory('${directory.path}/photos');

      if (!await photosDir.exists()) {
        await photosDir.create(recursive: true);
      }

      final fileName = 'blw_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final savedPath = '${photosDir.path}/$fileName';

      await File(image.path).copy(savedPath);

      return savedPath;
    } catch (e) {
      debugPrint('Error picking image: $e');
      return null;
    }
  }

  static Future<void> deletePhoto(String path) async {
    try {
      final file = File(path);
      if (await file.exists()) {
        await file.delete();
      }
    } catch (e) {
      debugPrint('Error deleting photo: $e');
    }
  }

  static Future<void> sharePhoto(String path, {String? text}) async {
    try {
      final file = XFile(path);
      await Share.shareXFiles(
        [file],
        text: text,
      );
    } catch (e) {
      debugPrint('Error sharing photo: $e');
    }
  }

  static Future<void> shareMultiplePhotos(List<String> paths,
      {String? text}) async {
    try {
      final files = paths.map((path) => XFile(path)).toList();
      await Share.shareXFiles(
        files,
        text: text,
      );
    } catch (e) {
      debugPrint('Error sharing photos: $e');
    }
  }

  static bool photoExists(String path) {
    return File(path).existsSync();
  }
}
