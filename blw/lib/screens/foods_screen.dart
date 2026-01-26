import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../l10n/app_localizations.dart';
import '../main.dart';
import '../models/food.dart';
import '../data/foods_data.dart';
import '../providers/food_log_provider.dart';
import 'food_detail_screen.dart';

class FoodsScreen extends StatefulWidget {
  const FoodsScreen({super.key});

  @override
  State<FoodsScreen> createState() => _FoodsScreenState();
}

class _FoodsScreenState extends State<FoodsScreen> {
  AgeGroup _selectedAge = AgeGroup.sixMonths;
  FoodCategory? _selectedCategory;

  String _getCategoryName(BuildContext context, FoodCategory category) {
    final l10n = AppLocalizations.of(context);
    switch (category) {
      case FoodCategory.fruits:
        return l10n.fruits;
      case FoodCategory.vegetables:
        return l10n.vegetables;
      case FoodCategory.proteins:
        return l10n.proteins;
      case FoodCategory.grains:
        return l10n.grains;
      case FoodCategory.dairy:
        return l10n.dairy;
    }
  }

  String _getAgeName(BuildContext context, AgeGroup age) {
    final l10n = AppLocalizations.of(context);
    switch (age) {
      case AgeGroup.sixMonths:
        return l10n.sixMonths;
      case AgeGroup.sevenMonths:
        return l10n.sevenMonths;
      case AgeGroup.eightMonths:
        return l10n.eightMonths;
      case AgeGroup.nineMonths:
        return l10n.nineMonths;
      case AgeGroup.tenToTwelveMonths:
        return l10n.tenToTwelveMonths;
      case AgeGroup.afterOneYear:
        return l10n.afterOneYear;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          // Large title header
          SliverToBoxAdapter(
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
                child: Text(
                  l10n.foods,
                  style: const TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.4,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ),
          ),

          // Age filter
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Idade do bebe',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textSecondary,
                      letterSpacing: -0.1,
                    ),
                  ),
                  const SizedBox(height: 8),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: AgeGroup.values.map((age) {
                        final isSelected = age == _selectedAge;
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: GestureDetector(
                            onTap: () => setState(() => _selectedAge = age),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                              decoration: BoxDecoration(
                                color: isSelected ? AppColors.primary : AppColors.cardBackground,
                                borderRadius: BorderRadius.circular(20),
                                border: isSelected ? null : Border.all(color: AppColors.separator),
                              ),
                              child: Text(
                                _getAgeName(context, age),
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: isSelected ? Colors.white : AppColors.textPrimary,
                                  letterSpacing: -0.2,
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Category filter
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Categoria',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textSecondary,
                      letterSpacing: -0.1,
                    ),
                  ),
                  const SizedBox(height: 8),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildCategoryChip(null, 'Todos', '🍽️'),
                        ...FoodCategory.values.map((cat) => _buildCategoryChip(
                          cat,
                          _getCategoryName(context, cat),
                          cat.icon,
                        )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Foods list
          _buildFoodsList(),
        ],
      ),
    );
  }

  Widget _buildCategoryChip(FoodCategory? category, String label, String icon) {
    final isSelected = category == _selectedCategory;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: GestureDetector(
        onTap: () => setState(() => _selectedCategory = category),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : AppColors.cardBackground,
            borderRadius: BorderRadius.circular(20),
            border: isSelected ? null : Border.all(color: AppColors.separator),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(icon, style: const TextStyle(fontSize: 16)),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: isSelected ? Colors.white : AppColors.textPrimary,
                  letterSpacing: -0.2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFoodsList() {
    final l10n = AppLocalizations.of(context);

    var foods = allFoods.where((food) =>
      food.minimumAge.index <= _selectedAge.index
    ).toList();

    if (_selectedCategory != null) {
      foods = foods.where((food) => food.category == _selectedCategory).toList();
    }

    if (foods.isEmpty) {
      return SliverFillRemaining(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                CupertinoIcons.nosign,
                size: 48,
                color: AppColors.textSecondary.withValues(alpha: 0.5),
              ),
              const SizedBox(height: 16),
              Text(
                l10n.noFoodsAvailable,
                style: const TextStyle(
                  fontSize: 17,
                  color: AppColors.textSecondary,
                ),
              ),
              Text(
                l10n.noFoodsForAge(_getAgeName(context, _selectedAge)),
                style: const TextStyle(
                  fontSize: 15,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      );
    }

    // Group by category
    final Map<FoodCategory, List<Food>> groupedFoods = {};
    for (var food in foods) {
      groupedFoods.putIfAbsent(food.category, () => []).add(food);
    }

    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      sliver: SliverList(
        delegate: SliverChildListDelegate([
          ...groupedFoods.entries.expand((entry) => [
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 12),
              child: Text(
                '${entry.key.icon} ${_getCategoryName(context, entry.key)}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.4,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: AppColors.cardBackground,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: entry.value.asMap().entries.map((foodEntry) {
                  final index = foodEntry.key;
                  final food = foodEntry.value;
                  final isLast = index == entry.value.length - 1;
                  return _buildFoodItem(food, isLast);
                }).toList(),
              ),
            ),
            const SizedBox(height: 16),
          ]),
        ]),
      ),
    );
  }

  Widget _buildFoodItem(Food food, bool isLast) {
    final l10n = AppLocalizations.of(context);
    final foodName = l10n.getFoodName(food.id);
    final displayName = foodName.startsWith('food_') ? food.name : foodName;
    final provider = context.watch<FoodLogProvider>();
    final timesOffered = provider.getLogsForFood(food.id).length;

    return Column(
      children: [
        CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => Navigator.push(
            context,
            CupertinoPageRoute(builder: (_) => FoodDetailScreen(food: food)),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      food.icon,
                      style: const TextStyle(fontSize: 28),
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              displayName,
                              style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                color: AppColors.textPrimary,
                                letterSpacing: -0.4,
                              ),
                            ),
                          ),
                          if (food.isAllergen) ...[
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: AppColors.destructive.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Text(
                                'Alergenico',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.destructive,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          Text(
                            l10n.fromAge(_getAgeName(context, food.minimumAge)),
                            style: const TextStyle(
                              fontSize: 13,
                              color: AppColors.textSecondary,
                              letterSpacing: -0.1,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: timesOffered > 0
                                  ? AppColors.primary.withValues(alpha: 0.1)
                                  : AppColors.textSecondary.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              timesOffered > 0
                                  ? l10n.timesOffered(timesOffered)
                                  : l10n.neverOffered,
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: timesOffered > 0
                                    ? AppColors.primary
                                    : AppColors.textSecondary,
                              ),
                            ),
                          ),
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
            padding: EdgeInsets.only(left: 78),
            child: Divider(height: 1),
          ),
      ],
    );
  }
}
