import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../l10n/app_localizations.dart';
import '../main.dart';
import '../providers/food_log_provider.dart';
import '../models/food_log.dart';
import '../data/foods_data.dart';
import 'add_food_log_screen.dart';
import 'food_log_detail_screen.dart';

class FoodLogScreen extends StatelessWidget {
  const FoodLogScreen({super.key});

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

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Consumer<FoodLogProvider>(
        builder: (context, provider, child) {
          final logs = provider.logsSortedByDate;

          return CustomScrollView(
            slivers: [
              // Header with title and add button
              SliverToBoxAdapter(
                child: SafeArea(
                  bottom: false,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          l10n.foodDiary,
                          style: const TextStyle(
                            fontSize: 34,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.4,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        CupertinoButton(
                          padding: EdgeInsets.zero,
                          onPressed: () => Navigator.push(
                            context,
                            CupertinoPageRoute(builder: (_) => const AddFoodLogScreen()),
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              CupertinoIcons.add,
                              color: Colors.white,
                              size: 22,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Content
              if (logs.isEmpty)
                SliverFillRemaining(
                  child: _buildEmptyState(context, l10n),
                )
              else
                _buildLogList(context, logs, provider, l10n),
            ],
          );
        },
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
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                CupertinoIcons.book,
                size: 48,
                color: AppColors.primary.withValues(alpha: 0.6),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              l10n.noRecordsYet,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              l10n.startRecording,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 15,
                color: AppColors.textSecondary,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.push(
                  context,
                  CupertinoPageRoute(builder: (_) => const AddFoodLogScreen()),
                ),
                child: Text(l10n.addRecord),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogList(
    BuildContext context,
    List<FoodLog> logs,
    FoodLogProvider provider,
    AppLocalizations l10n,
  ) {
    final groupedLogs = _groupLogsByDate(logs);

    return SliverPadding(
      padding: const EdgeInsets.all(20),
      sliver: SliverList(
        delegate: SliverChildListDelegate([
          ...groupedLogs.entries.expand((entry) {
            final date = entry.key;
            final dateLogs = entry.value;

            return [
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 12),
                child: Text(
                  _formatDate(context, date, l10n),
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textSecondary,
                    letterSpacing: -0.1,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.cardBackground,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: dateLogs.asMap().entries.map((logEntry) {
                    final index = logEntry.key;
                    final log = logEntry.value;
                    final isLast = index == dateLogs.length - 1;
                    return _buildLogCard(context, log, provider, l10n, isLast);
                  }).toList(),
                ),
              ),
              const SizedBox(height: 16),
            ];
          }),
        ]),
      ),
    );
  }

  Map<DateTime, List<FoodLog>> _groupLogsByDate(List<FoodLog> logs) {
    final Map<DateTime, List<FoodLog>> grouped = {};
    for (final log in logs) {
      final dateKey = DateTime(log.date.year, log.date.month, log.date.day);
      grouped.putIfAbsent(dateKey, () => []);
      grouped[dateKey]!.add(log);
    }
    return grouped;
  }

  String _formatDate(BuildContext context, DateTime date, AppLocalizations l10n) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));

    if (date == today) {
      return l10n.today.toUpperCase();
    } else if (date == yesterday) {
      return l10n.yesterday.toUpperCase();
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }

  Widget _buildLogCard(
    BuildContext context,
    FoodLog log,
    FoodLogProvider provider,
    AppLocalizations l10n,
    bool isLast,
  ) {
    final foodName = l10n.getFoodName(log.foodId);
    final displayName = foodName.startsWith('food_') ? log.foodName : foodName;
    final food = getFoodById(log.foodId);

    return Column(
      children: [
        CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (_) => FoodLogDetailScreen(log: log),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      food?.icon ?? '🍽️',
                      style: const TextStyle(fontSize: 28),
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        displayName,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                          letterSpacing: -0.4,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          _buildMiniChip(
                            log.acceptance.icon,
                            _getAcceptanceName(context, log.acceptance),
                          ),
                          const SizedBox(width: 8),
                          if (log.reaction != Reaction.none)
                            _buildMiniChip(
                              log.reaction.icon,
                              '',
                            ),
                          if (log.photosPaths.isNotEmpty) ...[
                            const SizedBox(width: 8),
                            Icon(
                              CupertinoIcons.camera_fill,
                              size: 14,
                              color: AppColors.textSecondary.withValues(alpha: 0.6),
                            ),
                            const SizedBox(width: 2),
                            Text(
                              '${log.photosPaths.length}',
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.textSecondary.withValues(alpha: 0.6),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
                const Icon(
                  CupertinoIcons.chevron_right,
                  color: AppColors.textSecondary,
                  size: 18,
                ),
              ],
            ),
          ),
        ),
        if (!isLast)
          const Padding(
            padding: EdgeInsets.only(left: 82),
            child: Divider(height: 1),
          ),
      ],
    );
  }

  Widget _buildMiniChip(String icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(icon, style: const TextStyle(fontSize: 12)),
          if (label.isNotEmpty) ...[
            const SizedBox(width: 4),
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
