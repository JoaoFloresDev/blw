import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../l10n/app_localizations.dart';
import '../main.dart';
import '../models/food_log.dart';
import '../providers/food_log_provider.dart';
import '../services/photo_service.dart';
import '../data/foods_data.dart';

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
  bool _showInfo = true;

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
    final food = getFoodById(photo.foodId);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Image viewer
          GestureDetector(
            onTap: () => setState(() => _showInfo = !_showInfo),
            child: PageView.builder(
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
                          CupertinoIcons.photo,
                          size: 64,
                          color: Colors.white54,
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ),

          // Top bar
          AnimatedPositioned(
            duration: const Duration(milliseconds: 200),
            top: _showInfo ? 0 : -100,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.7),
                    Colors.transparent,
                  ],
                ),
              ),
              child: SafeArea(
                bottom: false,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  child: Row(
                    children: [
                      CupertinoButton(
                        padding: EdgeInsets.zero,
                        onPressed: () => Navigator.pop(context),
                        child: const Icon(
                          CupertinoIcons.back,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                      const Spacer(),
                      CupertinoButton(
                        padding: EdgeInsets.zero,
                        onPressed: () => _sharePhoto(photo, l10n),
                        child: const Icon(
                          CupertinoIcons.share,
                          color: Colors.white,
                          size: 26,
                        ),
                      ),
                      const SizedBox(width: 8),
                      CupertinoButton(
                        padding: EdgeInsets.zero,
                        onPressed: () => _confirmDelete(context, photo, l10n),
                        child: const Icon(
                          CupertinoIcons.trash,
                          color: Colors.white,
                          size: 26,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Bottom info panel
          AnimatedPositioned(
            duration: const Duration(milliseconds: 200),
            bottom: _showInfo ? 0 : -300,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.9),
                    Colors.black.withValues(alpha: 0.7),
                    Colors.transparent,
                  ],
                  stops: const [0.0, 0.7, 1.0],
                ),
              ),
              child: SafeArea(
                top: false,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 40, 20, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Food name with emoji
                      Row(
                        children: [
                          if (food != null)
                            Text(
                              food.icon,
                              style: const TextStyle(fontSize: 32),
                            ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  l10n.getFoodName(photo.foodId).startsWith('food_')
                                      ? photo.foodName
                                      : l10n.getFoodName(photo.foodId),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: -0.5,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  _formatDate(photo.date, l10n),
                                  style: TextStyle(
                                    color: Colors.white.withValues(alpha: 0.7),
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      // Acceptance and reaction badges
                      Row(
                        children: [
                          _buildBadge(
                            icon: _getAcceptanceIcon(photo.acceptance),
                            label: _getAcceptanceName(l10n, photo.acceptance),
                            color: _getAcceptanceColor(photo.acceptance),
                          ),
                          const SizedBox(width: 12),
                          if (photo.reaction != Reaction.none)
                            _buildBadge(
                              icon: CupertinoIcons.exclamationmark_triangle_fill,
                              label: _getReactionName(l10n, photo.reaction),
                              color: _getReactionColor(photo.reaction),
                            ),
                        ],
                      ),

                      // Notes
                      if (photo.notes != null && photo.notes!.isNotEmpty) ...[
                        const SizedBox(height: 16),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    CupertinoIcons.doc_text,
                                    color: Colors.white.withValues(alpha: 0.7),
                                    size: 16,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    l10n.notes,
                                    style: TextStyle(
                                      color: Colors.white.withValues(alpha: 0.7),
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                photo.notes!,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  height: 1.4,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],

                      // Page indicator
                      if (widget.photos.length > 1) ...[
                        const SizedBox(height: 16),
                        Center(
                          child: Text(
                            '${_currentIndex + 1} / ${widget.photos.length}',
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.5),
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBadge({
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 18),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  IconData _getAcceptanceIcon(Acceptance acceptance) {
    switch (acceptance) {
      case Acceptance.loved:
        return CupertinoIcons.heart_fill;
      case Acceptance.liked:
        return CupertinoIcons.hand_thumbsup_fill;
      case Acceptance.neutral:
        return CupertinoIcons.minus_circle_fill;
      case Acceptance.disliked:
        return CupertinoIcons.hand_thumbsdown_fill;
      case Acceptance.refused:
        return CupertinoIcons.xmark_circle_fill;
    }
  }

  Color _getAcceptanceColor(Acceptance acceptance) {
    switch (acceptance) {
      case Acceptance.loved:
        return const Color(0xFFFF2D55);
      case Acceptance.liked:
        return AppColors.primary;
      case Acceptance.neutral:
        return const Color(0xFFFFCC00);
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

  Color _getReactionColor(Reaction reaction) {
    switch (reaction) {
      case Reaction.none:
        return Colors.grey;
      case Reaction.mild:
        return const Color(0xFFFFCC00);
      case Reaction.moderate:
        return const Color(0xFFFF9500);
      case Reaction.severe:
        return const Color(0xFFFF3B30);
    }
  }

  String _getReactionName(AppLocalizations l10n, Reaction reaction) {
    switch (reaction) {
      case Reaction.none:
        return l10n.noReaction;
      case Reaction.mild:
        return l10n.mildReaction;
      case Reaction.moderate:
        return l10n.moderateReaction;
      case Reaction.severe:
        return l10n.severeReaction;
    }
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
    final food = getFoodById(photo.foodId);
    final foodName = l10n.getFoodName(photo.foodId).startsWith('food_')
        ? photo.foodName
        : l10n.getFoodName(photo.foodId);
    final acceptanceName = _getAcceptanceName(l10n, photo.acceptance);
    final acceptanceIcon = photo.acceptance.icon;

    String shareText = '#BLWBaby #IntroducaoAlimentar';
    if (photo.notes != null && photo.notes!.isNotEmpty) {
      shareText = '${photo.notes}\n\n$shareText';
    }

    await PhotoService.sharePhotoWithOverlay(
      imagePath: photo.path,
      foodIcon: food?.icon ?? '🍽️',
      foodName: foodName,
      acceptanceIcon: acceptanceIcon,
      acceptanceText: acceptanceName,
      text: shareText,
    );
  }

  void _confirmDelete(
    BuildContext context,
    PhotoItem photo,
    AppLocalizations l10n,
  ) {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text(l10n.deletePhoto),
        content: Text(l10n.deletePhotoConfirm),
        actions: [
          CupertinoDialogAction(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.cancel),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context);
              _deletePhoto(photo);
            },
            child: Text(l10n.delete),
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
