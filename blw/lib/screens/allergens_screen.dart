import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../data/foods_data.dart';
import '../models/food.dart';
import 'food_detail_screen.dart';

class AllergensScreen extends StatelessWidget {
  const AllergensScreen({super.key});

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
    final allergenFoods = getAllergenFoods();

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.allergenicFoods),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildInfoCard(context, l10n),
          const SizedBox(height: 16),
          _buildIntroductionGuide(context, l10n),
          const SizedBox(height: 24),
          Text(
            l10n.allergenicFoods,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 12),
          ...allergenFoods.map((food) => _buildAllergenCard(context, food, l10n)),
        ],
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context, AppLocalizations l10n) {
    return Card(
      color: Colors.red[50],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.info, color: Colors.red[700]),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    l10n.whatAreAllergens,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.red[700],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              l10n.allergensExplanation,
              style: TextStyle(
                color: Colors.red[900],
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIntroductionGuide(BuildContext context, AppLocalizations l10n) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.checklist, color: Colors.blue),
                const SizedBox(width: 8),
                Text(
                  l10n.howToIntroduce,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildStep('1', l10n.step1),
            _buildStep('2', l10n.step2),
            _buildStep('3', l10n.step3),
            _buildStep('4', l10n.step4),
            _buildStep('5', l10n.step5),
          ],
        ),
      ),
    );
  }

  Widget _buildStep(String number, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: Colors.blue[100],
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                number,
                style: TextStyle(
                  color: Colors.blue[700],
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(height: 1.4),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAllergenCard(BuildContext context, Food food, AppLocalizations l10n) {
    final foodName = l10n.getFoodName(food.id);
    final allergenInfo = l10n.getFoodAllergenInfo(food.id);
    final displayAllergenInfo = allergenInfo.startsWith('allergen_')
        ? null
        : allergenInfo;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => FoodDetailScreen(food: food)),
        ),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.red[50],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        food.icon,
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          foodName,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          l10n.fromAge(_getAgeName(context, food.minimumAge)),
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey[400]),
                ],
              ),
              if (displayAllergenInfo != null) ...[
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.orange[50],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.warning_amber, size: 16, color: Colors.orange[700]),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          displayAllergenInfo,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.orange[900],
                            height: 1.4,
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
}
