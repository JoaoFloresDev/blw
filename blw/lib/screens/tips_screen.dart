import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../main.dart';

class TipsScreen extends StatelessWidget {
  const TipsScreen({super.key});

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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.blwTips,
                      style: const TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.4,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      l10n.tipsSubtitle,
                      style: const TextStyle(
                        fontSize: 17,
                        color: AppColors.textSecondary,
                        letterSpacing: -0.4,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Tips content
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // Getting Started Section
                _buildSectionHeader(context, l10n.sectionGettingStarted, CupertinoIcons.star_fill, const Color(0xFFFFCC00)),
                const SizedBox(height: 12),
                _buildTipCard(
                  context,
                  icon: CupertinoIcons.clock_fill,
                  iconColor: const Color(0xFF007AFF),
                  title: l10n.whenToStart,
                  content: l10n.whenToStartContent,
                ),
                const SizedBox(height: 12),
                _buildTipCard(
                  context,
                  icon: CupertinoIcons.hand_raised_fill,
                  iconColor: AppColors.primary,
                  title: l10n.whatIsBLW,
                  content: l10n.whatIsBLWContent,
                ),
                const SizedBox(height: 12),
                _buildTipCard(
                  context,
                  icon: CupertinoIcons.scissors,
                  iconColor: AppColors.secondary,
                  title: l10n.howToCut,
                  content: l10n.howToCutContent,
                ),

                // Safety Section
                const SizedBox(height: 24),
                _buildSectionHeader(context, l10n.sectionSafety, CupertinoIcons.shield_fill, const Color(0xFFFF3B30)),
                const SizedBox(height: 12),
                _buildTipCard(
                  context,
                  icon: CupertinoIcons.exclamationmark_triangle_fill,
                  iconColor: const Color(0xFFFF3B30),
                  title: l10n.chokingVsGag,
                  content: l10n.chokingVsGagContent,
                ),
                const SizedBox(height: 12),
                _buildTipCard(
                  context,
                  icon: CupertinoIcons.xmark_octagon_fill,
                  iconColor: const Color(0xFFAF52DE),
                  title: l10n.forbiddenFoods,
                  content: l10n.forbiddenFoodsContent,
                ),
                const SizedBox(height: 12),
                _buildTipCard(
                  context,
                  icon: CupertinoIcons.checkmark_shield_fill,
                  iconColor: const Color(0xFF5856D6),
                  title: l10n.safety,
                  content: l10n.safetyContent,
                ),

                // Additional Tips Section
                const SizedBox(height: 24),
                _buildSectionHeader(context, l10n.sectionPracticalTips, CupertinoIcons.lightbulb_fill, const Color(0xFFFFCC00)),
                const SizedBox(height: 12),
                _buildTipCard(
                  context,
                  icon: CupertinoIcons.heart_fill,
                  iconColor: const Color(0xFFFF2D55),
                  title: l10n.importantTips,
                  content: l10n.importantTipsContent,
                ),
                const SizedBox(height: 12),
                _buildTipCard(
                  context,
                  icon: CupertinoIcons.arrow_counterclockwise,
                  iconColor: const Color(0xFF00C7BE),
                  title: l10n.patience,
                  content: l10n.patienceContent,
                ),
                const SizedBox(height: 12),
                _buildTipCard(
                  context,
                  icon: CupertinoIcons.person_2_fill,
                  iconColor: const Color(0xFF5856D6),
                  title: l10n.familyMeals,
                  content: l10n.familyMealsContent,
                ),
                const SizedBox(height: 12),
                _buildTipCard(
                  context,
                  icon: CupertinoIcons.drop_fill,
                  iconColor: const Color(0xFF007AFF),
                  title: l10n.hydration,
                  content: l10n.hydrationContent,
                ),

                // Nutrition Section
                const SizedBox(height: 24),
                _buildSectionHeader(context, l10n.sectionNutrition, CupertinoIcons.leaf_arrow_circlepath, AppColors.primary),
                const SizedBox(height: 12),
                _buildTipCard(
                  context,
                  icon: CupertinoIcons.chart_pie_fill,
                  iconColor: AppColors.primary,
                  title: l10n.balancedDiet,
                  content: l10n.balancedDietContent,
                ),
                const SizedBox(height: 12),
                _buildTipCard(
                  context,
                  icon: CupertinoIcons.bolt_fill,
                  iconColor: const Color(0xFFFF9500),
                  title: l10n.ironRich,
                  content: l10n.ironRichContent,
                ),
                const SizedBox(height: 12),
                _buildTipCard(
                  context,
                  icon: CupertinoIcons.sparkles,
                  iconColor: const Color(0xFFAF52DE),
                  title: l10n.varietyTip,
                  content: l10n.varietyTipContent,
                ),

                // Consult pediatrician card
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFFFFCC00).withValues(alpha: 0.15),
                        const Color(0xFFFF9500).withValues(alpha: 0.15),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: const Color(0xFFFF9500).withValues(alpha: 0.3),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFF9500).withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          CupertinoIcons.doc_text_fill,
                          color: Color(0xFFFF9500),
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Text(
                          l10n.consultPediatrician,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.orange[900],
                            fontWeight: FontWeight.w500,
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title, IconData icon, Color color) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            letterSpacing: -0.4,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }

  Widget _buildTipCard(
    BuildContext context, {
    required IconData icon,
    required Color iconColor,
    required String title,
    required String content,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          leading: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: iconColor, size: 22),
          ),
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
              letterSpacing: -0.4,
            ),
          ),
          iconColor: AppColors.textSecondary,
          collapsedIconColor: AppColors.textSecondary,
          children: [
            Text(
              content,
              style: const TextStyle(
                fontSize: 15,
                color: AppColors.textSecondary,
                height: 1.6,
                letterSpacing: -0.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
