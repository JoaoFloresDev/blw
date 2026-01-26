import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../models/food.dart';
import 'add_food_log_screen.dart';

class FoodDetailScreen extends StatelessWidget {
  final Food food;

  const FoodDetailScreen({super.key, required this.food});

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
    final foodName = l10n.getFoodName(food.id);
    final foodPrep = l10n.getFoodPreparation(food.id);
    final foodAllergenInfo = l10n.getFoodAllergenInfo(food.id);

    return Scaffold(
      appBar: AppBar(
        title: Text(foodName),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: _getCategoryColor(food.category).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(60),
                ),
                child: Center(
                  child: Text(
                    food.icon,
                    style: const TextStyle(fontSize: 60),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child: Text(
                foodName,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  l10n.fromAge(_getAgeName(context, food.minimumAge)),
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
            _buildInfoSection(
              context,
              icon: Icons.category,
              title: l10n.category,
              content: _getCategoryName(context, food.category),
            ),
            const SizedBox(height: 20),
            _buildInfoSection(
              context,
              icon: Icons.restaurant,
              title: l10n.howToPrepare,
              content: foodPrep,
            ),
            if (food.isAllergen) ...[
              const SizedBox(height: 20),
              _buildAllergenWarning(context, l10n, foodAllergenInfo),
            ],
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => AddFoodLogScreen(preselectedFood: food),
                  ),
                ),
                icon: const Icon(Icons.add),
                label: Text(l10n.addToDiary),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoSection(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String content,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 20, color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              content,
              style: const TextStyle(fontSize: 15, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAllergenWarning(BuildContext context, AppLocalizations l10n, String allergenInfo) {
    final displayInfo = allergenInfo.startsWith('allergen_')
        ? l10n.allergenDefaultInfo
        : allergenInfo;

    return Card(
      color: Colors.red[50],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.warning_amber, color: Colors.red[700]),
                const SizedBox(width: 8),
                Text(
                  l10n.allergenWarning,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.red[700],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              displayInfo,
              style: TextStyle(
                fontSize: 15,
                height: 1.5,
                color: Colors.red[900],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getCategoryColor(FoodCategory category) {
    switch (category) {
      case FoodCategory.fruits:
        return Colors.red;
      case FoodCategory.vegetables:
        return Colors.green;
      case FoodCategory.proteins:
        return Colors.brown;
      case FoodCategory.grains:
        return Colors.amber;
      case FoodCategory.dairy:
        return Colors.blue;
    }
  }
}
