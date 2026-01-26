import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../l10n/app_localizations.dart';
import '../providers/food_log_provider.dart';
import '../services/photo_service.dart';

class PhotoViewerScreen extends StatefulWidget {
  final List<PhotoItem> photos;
  final int initialIndex;

  const PhotoViewerScreen({
    super.key,
    required this.photos,
    required this.initialIndex,
  });

  @override
  State<PhotoViewerScreen> createState() => _PhotoViewerScreenState();
}

class _PhotoViewerScreenState extends State<PhotoViewerScreen> {
  late PageController _pageController;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final photo = widget.photos[_currentIndex];

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              photo.foodName,
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              _formatDate(photo.date, l10n),
              style: const TextStyle(fontSize: 12, color: Colors.white70),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () => _sharePhoto(photo, l10n),
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: () => _confirmDelete(context, photo, l10n),
          ),
        ],
      ),
      body: PageView.builder(
        controller: _pageController,
        itemCount: widget.photos.length,
        onPageChanged: (index) {
          setState(() => _currentIndex = index);
        },
        itemBuilder: (context, index) {
          final photo = widget.photos[index];
          return InteractiveViewer(
            minScale: 0.5,
            maxScale: 4.0,
            child: Center(
              child: Image.file(
                File(photo.path),
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    Icons.broken_image,
                    size: 64,
                    color: Colors.white54,
                  );
                },
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: widget.photos.length > 1
          ? Container(
              color: Colors.black,
              padding: const EdgeInsets.all(16),
              child: Text(
                '${_currentIndex + 1} / ${widget.photos.length}',
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white70),
              ),
            )
          : null,
    );
  }

  String _formatDate(DateTime date, AppLocalizations l10n) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final dateOnly = DateTime(date.year, date.month, date.day);

    if (dateOnly == today) {
      return l10n.today;
    } else if (dateOnly == today.subtract(const Duration(days: 1))) {
      return l10n.yesterday;
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }

  void _sharePhoto(PhotoItem photo, AppLocalizations l10n) async {
    await PhotoService.sharePhoto(
      photo.path,
      text: l10n.sharePhotoText(photo.foodName),
    );
  }

  void _confirmDelete(
    BuildContext context,
    PhotoItem photo,
    AppLocalizations l10n,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.deletePhoto),
        content: Text(l10n.deletePhotoConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _deletePhoto(photo);
            },
            child: Text(
              l10n.delete,
              style: TextStyle(color: Colors.red[700]),
            ),
          ),
        ],
      ),
    );
  }

  void _deletePhoto(PhotoItem photo) async {
    final provider = context.read<FoodLogProvider>();
    await provider.removePhotoFromLog(photo.logId, photo.path);

    if (widget.photos.length == 1) {
      if (mounted) Navigator.pop(context);
    } else {
      setState(() {
        widget.photos.removeAt(_currentIndex);
        if (_currentIndex >= widget.photos.length) {
          _currentIndex = widget.photos.length - 1;
        }
      });
    }
  }
}
