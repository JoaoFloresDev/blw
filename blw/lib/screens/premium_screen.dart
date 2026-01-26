import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../l10n/app_localizations.dart';
import '../main.dart';
import '../providers/premium_provider.dart';

class PremiumScreen extends StatelessWidget {
  final VoidCallback? onDismiss;

  const PremiumScreen({super.key, this.onDismiss});

  void _handleDismiss(BuildContext context) {
    if (onDismiss != null) {
      onDismiss!();
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Consumer<PremiumProvider>(
        builder: (context, provider, child) {
          if (provider.isPremium) {
            return _buildPremiumActive(context, provider, l10n);
          }
          return _buildPremiumOffer(context, provider, l10n);
        },
      ),
    );
  }

  Widget _buildPremiumActive(
    BuildContext context,
    PremiumProvider provider,
    AppLocalizations l10n,
  ) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: CupertinoButton(
                padding: EdgeInsets.zero,
                child: const Icon(CupertinoIcons.xmark_circle_fill,
                  color: AppColors.textSecondary, size: 28),
                onPressed: () => _handleDismiss(context),
              ),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.all(28),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color(0xFFFFD700),
                    const Color(0xFFFF9500),
                  ],
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFFF9500).withValues(alpha: 0.4),
                    blurRadius: 30,
                    offset: const Offset(0, 15),
                  ),
                ],
              ),
              child: const Icon(CupertinoIcons.star_fill, size: 56, color: Colors.white),
            ),
            const SizedBox(height: 32),
            Text(
              l10n.youArePremium,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                letterSpacing: -0.4,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              l10n.premiumActiveDescription,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 17,
                color: AppColors.textSecondary,
                height: 1.4,
              ),
            ),
            if (provider.expiryDate != null) ...[
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(CupertinoIcons.calendar, color: AppColors.primary, size: 20),
                    const SizedBox(width: 10),
                    Text(
                      '${l10n.validUntil}: ${_formatDate(provider.expiryDate!)}',
                      style: const TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: CupertinoButton(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(14),
                onPressed: () => _handleDismiss(context),
                child: Text(
                  l10n.goBack,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 17,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPremiumOffer(
    BuildContext context,
    PremiumProvider provider,
    AppLocalizations l10n,
  ) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xFFFFD700).withValues(alpha: 0.15),
            AppColors.background,
          ],
        ),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: CupertinoButton(
                  padding: EdgeInsets.zero,
                  child: const Icon(CupertinoIcons.xmark_circle_fill,
                    color: AppColors.textSecondary, size: 28),
                  onPressed: () => _handleDismiss(context),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFFFFD700), Color(0xFFFF9500)],
                  ),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFFF9500).withValues(alpha: 0.4),
                      blurRadius: 30,
                      offset: const Offset(0, 15),
                    ),
                  ],
                ),
                child: const Icon(CupertinoIcons.star_fill, size: 48, color: Colors.white),
              ),
              const SizedBox(height: 24),
              Text(
                l10n.goPremium,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.4,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                l10n.premiumDescription,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 17,
                  color: AppColors.textSecondary,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 32),
              _buildFeaturesList(l10n),
              const SizedBox(height: 32),
              _buildPlanCard(
                context,
                provider,
                l10n,
                plan: PremiumPlan.yearly,
                title: l10n.yearlyPlan,
                subtitle: l10n.yearlyPlanDescription,
                isPopular: true,
              ),
              const SizedBox(height: 12),
              _buildPlanCard(
                context,
                provider,
                l10n,
                plan: PremiumPlan.monthly,
                title: l10n.monthlyPlan,
                subtitle: l10n.monthlyPlanDescription,
                isPopular: false,
              ),
              const SizedBox(height: 24),
              CupertinoButton(
                onPressed: () => provider.restorePurchases(),
                child: Text(
                  l10n.restorePurchases,
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontSize: 15,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                l10n.purchaseDisclaimer,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeaturesList(AppLocalizations l10n) {
    final features = [
      (CupertinoIcons.photo_fill, l10n.featureUnlimitedPhotos),
      (CupertinoIcons.book_fill, l10n.featureMoreRecipes),
      (CupertinoIcons.nosign, l10n.featureNoAds),
      (CupertinoIcons.chat_bubble_2_fill, l10n.featurePrioritySupport),
    ];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: features.asMap().entries.map((entry) {
          final index = entry.key;
          final feature = entry.value;
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(feature.$1, color: AppColors.primary, size: 22),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Text(
                        feature.$2,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                    const Icon(
                      CupertinoIcons.checkmark_circle_fill,
                      color: AppColors.primary,
                      size: 22,
                    ),
                  ],
                ),
              ),
              if (index < features.length - 1)
                const Divider(height: 1),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildPlanCard(
    BuildContext context,
    PremiumProvider provider,
    AppLocalizations l10n, {
    required PremiumPlan plan,
    required String title,
    required String subtitle,
    required bool isPopular,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        border: Border.all(
          color: isPopular ? AppColors.primary : AppColors.separator,
          width: isPopular ? 2 : 1,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () => _purchasePlan(context, provider, plan, l10n),
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          subtitle,
                          style: const TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: isPopular
                          ? AppColors.primary
                          : AppColors.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      'R\$ ${plan.price.toStringAsFixed(2).replaceAll('.', ',')}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: isPopular ? Colors.white : AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (isPopular)
            Positioned(
              top: 0,
              right: 16,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(8),
                  ),
                ),
                child: Text(
                  l10n.mostPopular,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _purchasePlan(
    BuildContext context,
    PremiumProvider provider,
    PremiumPlan plan,
    AppLocalizations l10n,
  ) async {
    showCupertinoDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CupertinoActivityIndicator(radius: 16),
      ),
    );

    final success = await provider.purchasePremium(plan);

    if (context.mounted) Navigator.pop(context);

    if (success && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.purchaseSuccess),
          backgroundColor: AppColors.primary,
        ),
      );
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
