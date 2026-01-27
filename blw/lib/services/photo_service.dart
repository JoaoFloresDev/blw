import 'dart:io';
import 'dart:ui' as ui;
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

  /// Creates a share image with overlay containing food info as tags at the top
  static Future<String?> createShareImageWithOverlay({
    required String imagePath,
    required String foodIcon,
    required String foodName,
    required String acceptanceIcon,
    required String acceptanceText,
  }) async {
    try {
      // Load the original image
      final imageFile = File(imagePath);
      if (!await imageFile.exists()) return null;

      final imageBytes = await imageFile.readAsBytes();
      final codec = await ui.instantiateImageCodec(imageBytes);
      final frame = await codec.getNextFrame();
      final originalImage = frame.image;

      // Create a picture recorder
      final recorder = ui.PictureRecorder();
      final canvas = Canvas(recorder);

      final width = originalImage.width.toDouble();
      final height = originalImage.height.toDouble();

      // Draw the original image
      canvas.drawImage(originalImage, Offset.zero, Paint());

      // Draw gradient overlay at bottom
      final bottomGradient = ui.Gradient.linear(
        Offset(0, height),
        Offset(0, height - 120),
        [
          const Color(0xCC000000),
          const Color(0x00000000),
        ],
      );
      canvas.drawRect(
        Rect.fromLTWH(0, height - 120, width, 120),
        Paint()..shader = bottomGradient,
      );

      // Tag styling
      final tagPadding = width * 0.02;
      final tagRadius = width * 0.015;
      final tagFontSize = width * 0.032;
      final tagSpacing = width * 0.015;
      final marginX = width * 0.03;
      final marginY = width * 0.03;

      // Calculate tag height
      final tagHeight = tagFontSize + tagPadding * 2;
      final tagY = height - marginY - tagHeight;

      // Prepare all text painters first to calculate positions
      final foodTagText = '$foodIcon $foodName';
      final foodPainter = TextPainter(
        text: TextSpan(
          text: foodTagText,
          style: TextStyle(
            color: Colors.white,
            fontSize: tagFontSize,
            fontWeight: FontWeight.w600,
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      foodPainter.layout();

      final acceptanceTagText = '$acceptanceIcon $acceptanceText';
      final acceptancePainter = TextPainter(
        text: TextSpan(
          text: acceptanceTagText,
          style: TextStyle(
            color: Colors.white,
            fontSize: tagFontSize,
            fontWeight: FontWeight.w600,
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      acceptancePainter.layout();

      final brandPainter = TextPainter(
        text: TextSpan(
          text: 'BLW Baby',
          style: TextStyle(
            color: Colors.white,
            fontSize: tagFontSize,
            fontWeight: FontWeight.w600,
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      brandPainter.layout();

      // Draw tags horizontally from left to right
      var currentX = marginX;

      // Food name tag (green)
      final foodTagRect = RRect.fromRectAndRadius(
        Rect.fromLTWH(
          currentX,
          tagY,
          foodPainter.width + tagPadding * 2,
          tagHeight,
        ),
        Radius.circular(tagRadius),
      );
      canvas.drawRRect(
        foodTagRect,
        Paint()..color = const Color(0xFF34C759),
      );
      foodPainter.paint(
        canvas,
        Offset(currentX + tagPadding, tagY + tagPadding),
      );
      currentX += foodPainter.width + tagPadding * 2 + tagSpacing;

      // Acceptance tag (orange)
      final acceptanceTagRect = RRect.fromRectAndRadius(
        Rect.fromLTWH(
          currentX,
          tagY,
          acceptancePainter.width + tagPadding * 2,
          tagHeight,
        ),
        Radius.circular(tagRadius),
      );
      canvas.drawRRect(
        acceptanceTagRect,
        Paint()..color = const Color(0xFFFF9500),
      );
      acceptancePainter.paint(
        canvas,
        Offset(currentX + tagPadding, tagY + tagPadding),
      );
      currentX += acceptancePainter.width + tagPadding * 2 + tagSpacing;

      // BLW Baby branding tag (semi-transparent)
      final brandTagRect = RRect.fromRectAndRadius(
        Rect.fromLTWH(
          currentX,
          tagY,
          brandPainter.width + tagPadding * 2,
          tagHeight,
        ),
        Radius.circular(tagRadius),
      );
      canvas.drawRRect(
        brandTagRect,
        Paint()..color = const Color(0x99000000),
      );
      brandPainter.paint(
        canvas,
        Offset(currentX + tagPadding, tagY + tagPadding),
      );

      // Convert to image
      final picture = recorder.endRecording();
      final finalImage = await picture.toImage(width.toInt(), height.toInt());
      final byteData = await finalImage.toByteData(format: ui.ImageByteFormat.png);

      if (byteData == null) return null;

      // Save to temp file
      final tempDir = await getTemporaryDirectory();
      final tempPath = '${tempDir.path}/share_${DateTime.now().millisecondsSinceEpoch}.png';
      final tempFile = File(tempPath);
      await tempFile.writeAsBytes(byteData.buffer.asUint8List());

      return tempPath;
    } catch (e) {
      debugPrint('Error creating share image with overlay: $e');
      return null;
    }
  }

  /// Share photo with overlay
  static Future<void> sharePhotoWithOverlay({
    required String imagePath,
    required String foodIcon,
    required String foodName,
    required String acceptanceIcon,
    required String acceptanceText,
    String? text,
  }) async {
    try {
      final overlayPath = await createShareImageWithOverlay(
        imagePath: imagePath,
        foodIcon: foodIcon,
        foodName: foodName,
        acceptanceIcon: acceptanceIcon,
        acceptanceText: acceptanceText,
      );

      if (overlayPath != null) {
        await sharePhoto(overlayPath, text: text);
        // Clean up temp file after sharing
        Future.delayed(const Duration(seconds: 5), () {
          File(overlayPath).delete().ignore();
        });
      } else {
        // Fallback to regular share
        await sharePhoto(imagePath, text: text);
      }
    } catch (e) {
      debugPrint('Error sharing photo with overlay: $e');
      await sharePhoto(imagePath, text: text);
    }
  }
}
