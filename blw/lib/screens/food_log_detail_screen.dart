import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../l10n/app_localizations.dart';
import '../main.dart';
import '../models/food_log.dart';
import '../data/foods_data.dart';
import '../providers/food_log_provider.dart';
import 'add_food_log_screen.dart';
import 'photo_viewer_screen.dart';

// Helper to create PhotoItem list from log
List<PhotoItem> _createPhotoItems(FoodLog log, String displayName) {
  return log.photosPaths.map((path) => PhotoItem(
    path: path,
    foodName: displayName,
    foodId: log.foodId,
    date: log.date,
    logId: log.id,
    acceptance: log.acceptance,
    reaction: log.reaction,
    notes: log.notes,
  )).toList();
}

class FoodLogDetailScreen extends StatelessWidget {
  final FoodLog log;

  const FoodLogDetailScreen({super.key, required this.log});

  String _getAcceptanceName(BuildContext context, Acceptance acceptance) {
    final l10n = AppLocalizations.of(context);
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

  String _getReactionName(BuildContext context, Reaction reaction) {
    final l10n = AppLocalizations.of(context);
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

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final food = getFoodById(log.foodId);
    final foodName = l10n.getFoodName(log.foodId);
    final displayName = foodName.startsWith('food_') ? log.foodName : foodName;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          child: const Icon(CupertinoIcons.back, color: AppColors.primary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(l10n.details),
        actions: [
          CupertinoButton(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              l10n.edit,
              style: const TextStyle(color: AppColors.primary),
            ),
            onPressed: () => _editLog(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header with food info
            Container(
              width: double.infinity,
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.cardBackground,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        food?.icon ?? '🍽️',
                        style: const TextStyle(fontSize: 48),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    displayName,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -0.4,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _formatDate(log.date, l10n),
                    style: const TextStyle(
                      fontSize: 15,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),

            // Details section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.cardBackground,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    _buildDetailRow(
                      context,
                      icon: CupertinoIcons.heart_fill,
                      iconColor: const Color(0xFFFF2D55),
                      title: l10n.acceptance,
                      value: '${log.acceptance.icon} ${_getAcceptanceName(context, log.acceptance)}',
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 56),
                      child: Divider(height: 1),
                    ),
                    _buildDetailRow(
                      context,
                      icon: CupertinoIcons.exclamationmark_triangle_fill,
                      iconColor: AppColors.secondary,
                      title: l10n.reaction,
                      value: '${log.reaction.icon} ${_getReactionName(context, log.reaction)}',
                    ),
                  ],
                ),
              ),
            ),

            // Notes section
            if (log.notes != null && log.notes!.isNotEmpty) ...[
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.cardBackground,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            CupertinoIcons.doc_text_fill,
                            size: 20,
                            color: const Color(0xFF007AFF),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            l10n.notes,
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              letterSpacing: -0.4,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        log.notes!,
                        style: const TextStyle(
                          fontSize: 15,
                          color: AppColors.textSecondary,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],

            // Photos section
            if (log.photosPaths.isNotEmpty) ...[
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.cardBackground,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            CupertinoIcons.photo_fill,
                            size: 20,
                            color: const Color(0xFF5856D6),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            '${l10n.photos} (${log.photosPaths.length})',
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              letterSpacing: -0.4,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        height: 120,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: log.photosPaths.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () => Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (_) => PhotoViewerScreen(
                                    photos: _createPhotoItems(log, displayName),
                                    initialIndex: index,
                                  ),
                                ),
                              ),
                              child: Container(
                                width: 120,
                                height: 120,
                                margin: const EdgeInsets.only(right: 12),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  image: DecorationImage(
                                    image: FileImage(File(log.photosPaths[index])),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],

            // Delete button
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: double.infinity,
                child: CupertinoButton(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  color: AppColors.destructive.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                  onPressed: () => _confirmDelete(context, l10n, displayName),
                  child: Text(
                    l10n.deleteRecordButton,
                    style: const TextStyle(
                      color: AppColors.destructive,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(
    BuildContext context, {
    required IconData icon,
    required Color iconColor,
    required String title,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: 22),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 17,
                color: AppColors.textPrimary,
                letterSpacing: -0.4,
              ),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 17,
              color: AppColors.textSecondary,
              letterSpacing: -0.4,
            ),
          ),
        ],
      ),
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

  void _editLog(BuildContext context) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (_) => AddFoodLogScreen(
          preselectedFood: getFoodById(log.foodId),
        ),
      ),
    );
  }

  void _confirmDelete(BuildContext context, AppLocalizations l10n, String foodName) {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text(l10n.deleteRecord),
        content: Text(l10n.deleteRecordConfirm(foodName)),
        actions: [
          CupertinoDialogAction(
            child: Text(l10n.cancel),
            onPressed: () => Navigator.pop(context),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            child: Text(l10n.delete),
            onPressed: () {
              context.read<FoodLogProvider>().removeLog(log.id);
              Navigator.pop(context); // Close dialog
              Navigator.pop(context); // Go back to list
            },
          ),
        ],
      ),
    );
  }
}
