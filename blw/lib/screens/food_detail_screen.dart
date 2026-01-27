import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../main.dart';
import '../models/food.dart';
import '../data/recipes_data.dart';
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

  Color _getCategoryColor(FoodCategory category) {
    switch (category) {
      case FoodCategory.fruits:
        return const Color(0xFFFF9500);
      case FoodCategory.vegetables:
        return const Color(0xFF34C759);
      case FoodCategory.proteins:
        return const Color(0xFFFF3B30);
      case FoodCategory.grains:
        return const Color(0xFFFFCC00);
      case FoodCategory.dairy:
        return const Color(0xFF007AFF);
    }
  }

  List<Recipe> _getRelatedRecipes() {
    final foodName = food.name.toLowerCase();
    final keywords = _getFoodKeywords(food);

    return allRecipes.where((recipe) {
      // Check if any ingredient contains the food name or keywords
      for (final ingredient in recipe.ingredients) {
        final ingredientLower = ingredient.toLowerCase();
        if (ingredientLower.contains(foodName)) return true;
        for (final keyword in keywords) {
          if (ingredientLower.contains(keyword)) return true;
        }
      }
      return false;
    }).toList();
  }

  List<String> _getFoodKeywords(Food food) {
    // Map food IDs to search keywords for better matching
    final keywordMap = {
      'banana': ['banana'],
      'maca': ['maçã', 'maca'],
      'pera': ['pera'],
      'mamao': ['mamão', 'mamao'],
      'abacate': ['abacate'],
      'manga': ['manga'],
      'morango': ['morango'],
      'laranja': ['laranja'],
      'melancia': ['melancia'],
      'uva': ['uva'],
      'cenoura': ['cenoura'],
      'batata_doce': ['batata doce', 'batata-doce'],
      'batata': ['batata'],
      'abobora': ['abóbora', 'abobora'],
      'abobrinha': ['abobrinha'],
      'brocolis': ['brócolis', 'brocolis'],
      'espinafre': ['espinafre'],
      'vagem': ['vagem'],
      'ervilha': ['ervilha'],
      'tomate': ['tomate'],
      'frango': ['frango'],
      'carne_bovina': ['carne'],
      'peixe': ['peixe', 'tilápia', 'pescada'],
      'ovo': ['ovo', 'ovos'],
      'feijao': ['feijão', 'feijao'],
      'lentilha': ['lentilha'],
      'grao_de_bico': ['grão de bico', 'grao de bico'],
      'tofu': ['tofu'],
      'arroz': ['arroz'],
      'aveia': ['aveia'],
      'quinoa': ['quinoa'],
      'pao_integral': ['pão', 'pao', 'torrada'],
      'macarrao': ['macarrão', 'macarrao'],
      'leite_materno': ['leite'],
      'iogurte': ['iogurte'],
      'queijo': ['queijo'],
    };

    return keywordMap[food.id] ?? [food.name.toLowerCase()];
  }

  String _getRecipeCategoryName(RecipeCategory category) {
    switch (category) {
      case RecipeCategory.breakfast:
        return 'Café da manhã';
      case RecipeCategory.lunch:
        return 'Almoço';
      case RecipeCategory.dinner:
        return 'Jantar';
      case RecipeCategory.snack:
        return 'Lanche';
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final foodName = l10n.getFoodName(food.id);
    final foodPrep = l10n.getFoodPreparation(food.id);
    final foodAllergenInfo = l10n.getFoodAllergenInfo(food.id);
    final relatedRecipes = _getRelatedRecipes();
    final categoryColor = _getCategoryColor(food.category);

    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F7),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF2F2F7),
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => Navigator.pop(context),
          child: const Icon(
            CupertinoIcons.chevron_back,
            color: AppColors.primary,
          ),
        ),
        title: Text(
          foodName,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1C1C1E),
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Food icon and name header
                  Center(
                    child: Container(
                      width: 140,
                      height: 140,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            categoryColor.withValues(alpha: 0.2),
                            categoryColor.withValues(alpha: 0.1),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(36),
                        boxShadow: [
                          BoxShadow(
                            color: categoryColor.withValues(alpha: 0.2),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          food.icon,
                          style: const TextStyle(fontSize: 70),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: Text(
                      foodName,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1C1C1E),
                        letterSpacing: -0.5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: categoryColor.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        l10n.fromAge(_getAgeName(context, food.minimumAge)),
                        style: TextStyle(
                          color: categoryColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),

                  // Category section
                  _buildInfoCard(
                    context,
                    icon: CupertinoIcons.tag_fill,
                    iconColor: categoryColor,
                    title: l10n.category,
                    content: _getCategoryName(context, food.category),
                  ),
                  const SizedBox(height: 16),

                  // How to prepare section
                  _buildInfoCard(
                    context,
                    icon: CupertinoIcons.sparkles,
                    iconColor: const Color(0xFFFF9500),
                    title: l10n.howToPrepare,
                    content: foodPrep,
                  ),

                  // Allergen warning
                  if (food.isAllergen) ...[
                    const SizedBox(height: 16),
                    _buildAllergenWarning(context, l10n, foodAllergenInfo),
                  ],

                  // Related recipes section
                  if (relatedRecipes.isNotEmpty) ...[
                    const SizedBox(height: 28),
                    _buildRecipesSection(context, l10n, relatedRecipes),
                  ],

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
          // Add to diary button
          _buildAddToDiaryButton(context, l10n),
        ],
      ),
    );
  }

  Widget _buildInfoCard(
    BuildContext context, {
    required IconData icon,
    required Color iconColor,
    required String title,
    required String content,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, size: 18, color: iconColor),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 17,
                  color: Color(0xFF1C1C1E),
                  letterSpacing: -0.3,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            content,
            style: const TextStyle(
              fontSize: 15,
              height: 1.5,
              color: Color(0xFF8E8E93),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAllergenWarning(BuildContext context, AppLocalizations l10n, String allergenInfo) {
    final displayInfo = allergenInfo.startsWith('allergen_')
        ? l10n.allergenDefaultInfo
        : allergenInfo;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFEBEE),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFFF3B30).withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: const Color(0xFFFF3B30).withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  CupertinoIcons.exclamationmark_triangle_fill,
                  size: 18,
                  color: Color(0xFFFF3B30),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                l10n.allergenWarning,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 17,
                  color: Color(0xFFFF3B30),
                  letterSpacing: -0.3,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            displayInfo,
            style: const TextStyle(
              fontSize: 15,
              height: 1.5,
              color: Color(0xFFB71C1C),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecipesSection(BuildContext context, AppLocalizations l10n, List<Recipe> recipes) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: const Color(0xFFAF52DE).withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                CupertinoIcons.book_fill,
                size: 18,
                color: Color(0xFFAF52DE),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              l10n.recipes,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 17,
                color: Color(0xFF1C1C1E),
                letterSpacing: -0.3,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ...recipes.map((recipe) => _buildRecipeCard(context, recipe)),
      ],
    );
  }

  Widget _buildRecipeCard(BuildContext context, Recipe recipe) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          leading: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: const Color(0xFFF2F2F7),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                recipe.icon,
                style: const TextStyle(fontSize: 26),
              ),
            ),
          ),
          title: Text(
            recipe.name,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1C1C1E),
              letterSpacing: -0.3,
            ),
          ),
          subtitle: Row(
            children: [
              Icon(
                CupertinoIcons.clock_fill,
                size: 12,
                color: Colors.grey[500],
              ),
              const SizedBox(width: 4),
              Text(
                '${recipe.prepTimeMinutes} min',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey[500],
                ),
              ),
              const SizedBox(width: 12),
              Text(
                _getRecipeCategoryName(recipe.category),
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey[500],
                ),
              ),
              if (recipe.isAllergen) ...[
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF3B30).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text(
                    '⚠️',
                    style: TextStyle(fontSize: 10),
                  ),
                ),
              ],
            ],
          ),
          children: [
            const Divider(height: 1, color: Color(0xFFE5E5EA)),
            const SizedBox(height: 16),

            // Ingredients
            _buildRecipeSubsection(
              title: 'Ingredientes',
              icon: CupertinoIcons.list_bullet,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: recipe.ingredients.map((ingredient) => Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('• ', style: TextStyle(color: Color(0xFF8E8E93))),
                      Expanded(
                        child: Text(
                          ingredient,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF3C3C43),
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                )).toList(),
              ),
            ),
            const SizedBox(height: 16),

            // Instructions
            _buildRecipeSubsection(
              title: 'Modo de Preparo',
              icon: CupertinoIcons.text_alignleft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: recipe.instructions.asMap().entries.map((entry) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 22,
                        height: 22,
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Center(
                          child: Text(
                            '${entry.key + 1}',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          entry.value,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF3C3C43),
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                )).toList(),
              ),
            ),
            const SizedBox(height: 16),

            // Tip
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF9E6),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFFFFCC00).withValues(alpha: 0.3)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('💡', style: TextStyle(fontSize: 16)),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      recipe.tip,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF8B6914),
                        height: 1.4,
                        fontStyle: FontStyle.italic,
                      ),
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

  Widget _buildRecipeSubsection({
    required String title,
    required IconData icon,
    required Widget child,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 14, color: const Color(0xFF8E8E93)),
            const SizedBox(width: 6),
            Text(
              title,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xFF8E8E93),
                letterSpacing: -0.1,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        child,
      ],
    );
  }

  Widget _buildAddToDiaryButton(BuildContext context, AppLocalizations l10n) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 34),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F2F7),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SizedBox(
        width: double.infinity,
        height: 56,
        child: CupertinoButton(
          padding: EdgeInsets.zero,
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(14),
          onPressed: () => Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (_) => AddFoodLogScreen(preselectedFood: food),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(CupertinoIcons.add, size: 20, color: Colors.white),
              const SizedBox(width: 8),
              Text(
                l10n.addToDiary,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  letterSpacing: -0.3,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
