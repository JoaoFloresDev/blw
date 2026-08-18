import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../l10n/app_localizations.dart';
import '../main.dart';
import '../providers/food_log_provider.dart';
import '../providers/premium_provider.dart';
import '../models/food_log.dart';
import '../models/food.dart';
import '../data/foods_data.dart';
import '../services/pdf_service.dart';
import '../services/analytics_service.dart';
import '../widgets/paywall_view.dart';
import 'add_food_log_screen.dart';
import 'food_log_detail_screen.dart';
import 'food_detail_screen.dart';
import '../widgets/food_icon.dart';

class FoodLogScreen extends StatelessWidget {
  const FoodLogScreen({super.key});

  void _exportPdf(BuildContext context, FoodLogProvider provider, AppLocalizations l10n) {
    final logs = provider.logsSortedByDate;
    final introducedFoodIds = provider.introducedFoodIds;
    final box = context.findRenderObject() as RenderBox?;

    PdfService.generateAndShareReport(
      sharePositionOrigin:
          box == null ? null : box.localToGlobal(Offset.zero) & box.size,
      logs: logs,
      introducedFoodIds: introducedFoodIds,
      title: l10n.foodDiary,
      subtitle: l10n.diarySubtitle,
      labels: {
        'page': 'Página',
        'summary': 'Resumo',
        'foodsTried': 'Alimentos\nExperimentados',
        'totalRecords': 'Total de\nRegistros',
        'reactions': 'Reações\nRegistradas',
        'foodsIntroduced': 'Alimentos Introduzidos',
        'food': 'Alimento',
        'times': 'Vezes',
        'acceptance': 'Aceitação',
        'lastDate': 'Última Data',
        'date': 'Data',
        'reaction': 'Reação',
        'reactionsTitle': 'Reações Registradas',
        'recentRecords': 'Registros Recentes',
        'noReaction': l10n.noReaction,
        'mildReaction': l10n.mildReaction,
        'moderateReaction': l10n.moderateReaction,
        'severeReaction': l10n.severeReaction,
      },
    );
  }

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
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
              const BorderRadius.vertical(top: Radius.circular(24)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 14,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
            child: SizedBox(
            width: double.infinity,
            child: CupertinoButton(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(16),
              padding: const EdgeInsets.symmetric(vertical: 15),
              onPressed: () => Navigator.push(
                context,
                CupertinoPageRoute(
                    builder: (_) => const AddFoodLogScreen()),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(CupertinoIcons.add, size: 20, color: Colors.white),
                  const SizedBox(width: 8),
                  Text(
                    l10n.addRecord,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      letterSpacing: -0.3,
                    ),
                  ),
                ],
              ),
            ),
          ),
          ),
        ),
      ),
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
                        Row(
                          children: [
                            if (logs.isNotEmpty)
                              CupertinoButton(
                                padding: EdgeInsets.zero,
                                onPressed: () => PremiumGate.guard(
                                  context,
                                  source: 'pdf_export',
                                  onUnlocked: () {
                                    AnalyticsService.pdfExported();
                                    _exportPdf(context, provider, l10n);
                                  },
                                ),
                                child: Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    // Same white-card look as the header
                                    // buttons on the Foods tab (btn_*.png).
                                    Container(
                                      padding: const EdgeInsets.all(7),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(14),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black
                                                .withValues(alpha: 0.06),
                                            blurRadius: 8,
                                            offset: const Offset(0, 3),
                                          ),
                                        ],
                                      ),
                                      child: Image.asset(
                                        'assets/images/btn_pdf.png',
                                        width: 30,
                                        height: 30,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    if (!context
                                        .watch<PremiumProvider>()
                                        .isPremium)
                                      const Positioned(
                                        top: -6,
                                        right: -6,
                                        child: _LockDot(),
                                      ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Progress summary (moved from the old Home tab)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 4, 20, 8),
                  child: _buildProgressCard(context, provider, l10n),
                ),
              ),

              // "Try next" suggestions
              SliverToBoxAdapter(
                child: _buildTryNext(context, provider, l10n),
              ),

              // Content
              if (logs.isEmpty)
                SliverFillRemaining(
                  hasScrollBody: false,
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

  Widget _buildTryNext(
    BuildContext context,
    FoodLogProvider provider,
    AppLocalizations l10n,
  ) {
    return FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot) {
        final ageIndex =
            snapshot.data?.getInt('foods.selectedAgeIndex') ?? 0;
        final tried = provider.introducedFoodIds;
        final untried = allFoods
            .where((food) =>
                !tried.contains(food.id) &&
                !food.isAllergen &&
                food.minimumAge.index <= ageIndex)
            .toList();
        if (untried.isEmpty) return const SizedBox.shrink();

        // One suggestion per category, round-robin, rotating daily.
        final day = DateTime.now().difference(DateTime(2026)).inDays;
        final byCategory = <FoodCategory, List<Food>>{};
        for (final food in untried) {
          byCategory.putIfAbsent(food.category, () => []).add(food);
        }
        final categories = FoodCategory.values
            .where((cat) => byCategory.containsKey(cat))
            .toList();
        final taken = {for (final cat in categories) cat: 0};
        final suggestions = <Food>[];
        var slot = 0;
        while (suggestions.length < 8 && slot < 40) {
          final cat = categories[(day + slot) % categories.length];
          final pool = byCategory[cat]!;
          final used = taken[cat]!;
          if (used < pool.length) {
            suggestions.add(pool[(day + used) % pool.length]);
            taken[cat] = used + 1;
          }
          slot++;
          if (taken.values.every(
              (count) => count >= (byCategory.values.map((p) => p.length)
                  .reduce((a, b) => a > b ? a : b)))) {
            break;
          }
        }

        return _buildTryNextContent(context, suggestions, l10n);
      },
    );
  }

  Widget _buildTryNextContent(
      BuildContext context, List<Food> suggestions, AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.tryNext,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
              letterSpacing: -0.2,
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 112,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              clipBehavior: Clip.none,
              itemCount: suggestions.length,
              separatorBuilder: (_, i) => const SizedBox(width: 6),
              itemBuilder: (context, index) => SizedBox(
                width: 86,
                child:
                    _buildSuggestionCard(context, suggestions[index], l10n),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuggestionCard(
      BuildContext context, Food food, AppLocalizations l10n) {
    final name = l10n.getFoodName(food.id);
    final displayName = name.startsWith('food_') ? food.name : name;
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: () => Navigator.push(
        context,
        CupertinoPageRoute(builder: (_) => FoodDetailScreen(food: food)),
      ),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FoodIcon(food, size: 26),
            const SizedBox(height: 6),
            Text(
              displayName,
              maxLines: 2,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
                letterSpacing: -0.2,
                height: 1.15,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressCard(
    BuildContext context,
    FoodLogProvider provider,
    AppLocalizations l10n,
  ) {
    final triedFoods = provider.introducedFoodIds.length;
    // "First 100 foods" journey; once past it, the goal grows to the catalog.
    final totalFoods = triedFoods > 100 ? allFoods.length : 100;
    final progress = totalFoods > 0 ? triedFoods / totalFoods : 0.0;

    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFE8F8EB), Color(0xFFD3F2DB)],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(18, 14, 10, 14),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.foodsTried.replaceAll('\n', ' '),
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1FA047),
                    letterSpacing: -0.2,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      '$triedFoods',
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textPrimary,
                        letterSpacing: -0.6,
                      ),
                    ),
                    Text(
                      ' / $totalFoods',
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textSecondary,
                        letterSpacing: -0.3,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Stack(
                  children: [
                    Container(
                      height: 14,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(7),
                      ),
                    ),
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final w = constraints.maxWidth *
                            progress.clamp(0.0, 1.0);
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 600),
                          curve: Curves.easeOutCubic,
                          height: 14,
                          width: w < 14 && triedFoods > 0 ? 14 : w,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFF3FD168), Color(0xFF1FA047)],
                            ),
                            borderRadius: BorderRadius.circular(7),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Image.asset(
            'assets/images/home_hero.png',
            width: 84,
            height: 84,
            fit: BoxFit.contain,
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, AppLocalizations l10n) {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(40, 0, 40, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/images/empty_diary.png',
              width: 150,
              height: 150,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 6),
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
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.08),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
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
          onPressed: () {
            AnalyticsService.logOpened();
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (_) => FoodLogDetailScreen(log: log),
              ),
            );
          },
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

// MARK: - Lock indicator

/// Small lock dot rendered over premium-gated icon buttons.
class _LockDot extends StatelessWidget {
  const _LockDot();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 18,
      height: 18,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFF9500), Color(0xFFFFB340)],
        ),
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 1.5),
      ),
      child: const Icon(CupertinoIcons.lock_fill, size: 9, color: Colors.white),
    );
  }
}

