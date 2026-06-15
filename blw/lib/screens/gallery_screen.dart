import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../l10n/app_localizations.dart';
import '../main.dart';
import '../models/food_log.dart';
import '../data/foods_data.dart';
import '../providers/food_log_provider.dart';
import '../services/photo_service.dart';
import 'add_food_log_screen.dart';
import 'photo_viewer_screen.dart';

class GalleryScreen extends StatelessWidget {
  const GalleryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F7),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF2F2F7),
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Text(
          l10n.gallery,
          style: const TextStyle(
            fontSize: 34,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.5,
            color: Color(0xFF1C1C1E),
          ),
        ),
        centerTitle: false,
        actions: [
          Consumer<FoodLogProvider>(
            builder: (context, provider, child) {
              final photos = provider.allPhotos;
              if (photos.isEmpty) return const SizedBox.shrink();
              return CupertinoButton(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                onPressed: () => _shareAllPhotos(context, photos, l10n),
                child: const Icon(
                  CupertinoIcons.share,
                  color: AppColors.primary,
                  size: 24,
                ),
              );
            },
          ),
        ],
      ),
      body: Consumer<FoodLogProvider>(
        builder: (context, logProvider, child) {
          if (logProvider.isLoading) {
            return const Center(
              child: CupertinoActivityIndicator(radius: 14),
            );
          }

          final photos = logProvider.allPhotos;

          if (photos.isEmpty) {
            return _buildEmptyState(context, l10n);
          }

          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: photos.length,
            itemBuilder: (context, index) {
              final photo = photos[index];
              return _buildPhotoTile(context, photo, index, photos, l10n);
            },
          );
        },
      ),
      floatingActionButton: Consumer<FoodLogProvider>(
        builder: (context, provider, child) {
          if (provider.allPhotos.isEmpty) return const SizedBox.shrink();
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: FloatingActionButton(
              onPressed: () => _startAddPhoto(context),
              backgroundColor: AppColors.primary,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(
                CupertinoIcons.camera_fill,
                color: Colors.white,
                size: 26,
              ),
            ),
          );
        },
      ),
    );
  }

  /// Gallery "add photo" flow: take/pick a photo FIRST, then open the record
  /// screen with it pre-attached (where the user can fill a record or skip
  /// and keep the photo in the gallery only).
  void _startAddPhoto(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    showCupertinoModalPopup(
      context: context,
      builder: (sheetContext) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(sheetContext);
              _pickThenAddRecord(context, ImageSource.camera);
            },
            child: Text(l10n.takePhoto),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(sheetContext);
              _pickThenAddRecord(context, ImageSource.gallery);
            },
            child: Text(l10n.chooseFromGallery),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          isDefaultAction: true,
          onPressed: () => Navigator.pop(sheetContext),
          child: Text(l10n.cancel),
        ),
      ),
    );
  }

  Future<void> _pickThenAddRecord(
      BuildContext context, ImageSource source) async {
    final path = await PhotoService.pickImage(source);
    if (path == null || !context.mounted) return;
    final l10n = AppLocalizations.of(context);

    showCupertinoDialog(
      context: context,
      builder: (dialogContext) => CupertinoAlertDialog(
        title: Text(l10n.logMealPromptTitle),
        content: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Text(l10n.logMealPromptMessage),
        ),
        actions: [
          CupertinoDialogAction(
            onPressed: () {
              Navigator.pop(dialogContext);
              context.read<FoodLogProvider>().addGalleryPhoto(path);
            },
            child: Text(l10n.logMealPromptNo),
          ),
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(dialogContext);
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (_) => AddFoodLogScreen(initialPhotoPath: path),
                ),
              );
            },
            child: Text(l10n.logMealPromptYes),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, AppLocalizations l10n) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(48),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/empty_gallery.png',
              width: 176,
              height: 176,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 32),
            Text(
              l10n.noPhotosYet,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1C1C1E),
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              l10n.addPhotosHint,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 17,
                color: Color(0xFF8E8E93),
                height: 1.5,
                letterSpacing: -0.2,
              ),
            ),
            const SizedBox(height: 40),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: CupertinoButton(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(14),
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                onPressed: () => _startAddPhoto(context),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(CupertinoIcons.camera_fill, size: 22, color: Colors.white),
                    const SizedBox(width: 10),
                    Text(
                      l10n.addPhoto,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 17,
                        letterSpacing: -0.3,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPhotoTile(
    BuildContext context,
    PhotoItem photo,
    int index,
    List<PhotoItem> allPhotos,
    AppLocalizations l10n,
  ) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (_) => PhotoViewerScreen(
            photos: allPhotos,
            initialIndex: index,
          ),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.file(
                File(photo.path),
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: const Color(0xFFE5E5EA),
                    child: const Icon(
                      CupertinoIcons.photo,
                      color: Color(0xFFC7C7CC),
                    ),
                  );
                },
              ),
              // Tags only for record photos; standalone gallery photos
              // render as a clean image.
              if (!photo.isStandalone) ...[
                // Gradient overlay at bottom for tags
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 80,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black.withValues(alpha: 0.7),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),
                // Tags at bottom
                Positioned(
                  bottom: 8,
                  left: 8,
                  right: 8,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Food name tag
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              getFoodById(photo.foodId)?.icon ?? '🍽️',
                              style: const TextStyle(fontSize: 12),
                            ),
                            const SizedBox(width: 4),
                            Flexible(
                              child: Text(
                                photo.foodName,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 4),
                      // Acceptance tag
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: _getAcceptanceColor(photo.acceptance),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          '${photo.acceptance.icon} ${_getAcceptanceName(l10n, photo.acceptance)}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Color _getAcceptanceColor(Acceptance acceptance) {
    switch (acceptance) {
      case Acceptance.loved:
        return const Color(0xFFFF2D55);
      case Acceptance.liked:
        return AppColors.primary;
      case Acceptance.neutral:
        return const Color(0xFFFF9500);
      case Acceptance.disliked:
        return const Color(0xFFFF9500);
      case Acceptance.refused:
        return const Color(0xFFFF3B30);
    }
  }

  String _getAcceptanceName(AppLocalizations l10n, Acceptance acceptance) {
    switch (acceptance) {
      case Acceptance.loved:
        return l10n.loved;
      case Acceptance.liked:
        return l10n.liked;
      case Acceptance.neutral:
        return l10n.neutral;
      case Acceptance.disliked:
        return l10n.disliked;
      case Acceptance.refused:
        return l10n.refused;
    }
  }

  void _shareAllPhotos(
    BuildContext context,
    List<PhotoItem> photos,
    AppLocalizations l10n,
  ) async {
    final paths = photos.map((p) => p.path).toList();
    await PhotoService.shareMultiplePhotos(
      paths,
      text: l10n.shareGalleryText,
    );
  }
}
