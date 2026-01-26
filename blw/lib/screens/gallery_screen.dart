import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../l10n/app_localizations.dart';
import '../main.dart';
import '../providers/food_log_provider.dart';
import '../providers/premium_provider.dart';
import '../services/photo_service.dart';
import 'add_food_log_screen.dart';
import 'photo_viewer_screen.dart';
import 'premium_screen.dart';

class GalleryScreen extends StatelessWidget {
  const GalleryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.gallery),
        actions: [
          Consumer<FoodLogProvider>(
            builder: (context, provider, child) {
              final photos = provider.allPhotos;
              if (photos.isEmpty) return const SizedBox.shrink();
              return IconButton(
                icon: const Icon(Icons.share),
                onPressed: () => _shareAllPhotos(context, photos, l10n),
              );
            },
          ),
        ],
      ),
      body: Consumer2<FoodLogProvider, PremiumProvider>(
        builder: (context, logProvider, premiumProvider, child) {
          if (logProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final photos = logProvider.allPhotos;

          if (photos.isEmpty) {
            return _buildEmptyState(context, l10n);
          }

          return Column(
            children: [
              if (!premiumProvider.isPremium) _buildPremiumBanner(context, l10n),
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(8),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 4,
                    mainAxisSpacing: 4,
                  ),
                  itemCount: photos.length,
                  itemBuilder: (context, index) {
                    final photo = photos[index];
                    return _buildPhotoTile(context, photo, index, photos, l10n);
                  },
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddPhotoOptions(context, l10n),
        backgroundColor: AppColors.primary,
        child: const Icon(CupertinoIcons.camera_fill, color: Colors.white),
      ),
    );
  }

  void _showAddPhotoOptions(BuildContext context, AppLocalizations l10n) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        title: Text(l10n.addPhoto),
        actions: [
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                CupertinoPageRoute(builder: (_) => const AddFoodLogScreen()),
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(CupertinoIcons.doc_text_fill, color: AppColors.primary),
                const SizedBox(width: 8),
                Text(l10n.newRecord),
              ],
            ),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          onPressed: () => Navigator.pop(context),
          isDestructiveAction: true,
          child: Text(l10n.cancel),
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, AppLocalizations l10n) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                CupertinoIcons.photo_on_rectangle,
                size: 56,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 28),
            Text(
              l10n.noPhotosYet,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
                letterSpacing: -0.4,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              l10n.addPhotosHint,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                color: AppColors.textSecondary,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 32),
            CupertinoButton(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(14),
              onPressed: () => _showAddPhotoOptions(context, l10n),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(CupertinoIcons.camera_fill, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    l10n.addPhoto,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPremiumBanner(BuildContext context, AppLocalizations l10n) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.amber[600]!, Colors.orange[600]!],
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const PremiumScreen()),
        ),
        child: Row(
          children: [
            const Icon(Icons.star, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.unlimitedPhotos,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    l10n.upgradeToPremium,
                    style: const TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16),
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
        MaterialPageRoute(
          builder: (_) => PhotoViewerScreen(
            photos: allPhotos,
            initialIndex: index,
          ),
        ),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.file(
              File(photo.path),
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[300],
                  child: const Icon(Icons.broken_image),
                );
              },
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Colors.black54, Colors.transparent],
                ),
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(8),
                ),
              ),
              child: Text(
                photo.foodName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
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
