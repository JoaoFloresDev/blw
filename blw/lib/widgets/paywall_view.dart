import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../l10n/app_localizations.dart';
import '../main.dart';
import '../providers/premium_provider.dart';

// MARK: - Public helpers

/// Presents the paywall as a full-screen modal. Returns true if the user
/// became premium while it was open.
Future<bool> showPaywall(BuildContext context) async {
  await Navigator.of(context, rootNavigator: true).push(
    CupertinoPageRoute(
      fullscreenDialog: true,
      builder: (_) => const _PaywallPage(),
    ),
  );
  if (!context.mounted) return false;
  return context.read<PremiumProvider>().isPremium;
}

/// Runs [onUnlocked] if the user is premium, otherwise shows the paywall
/// first and runs it only if the user converts.
class PremiumGate {
  static Future<void> guard(
    BuildContext context, {
    required VoidCallback onUnlocked,
  }) async {
    final premium = context.read<PremiumProvider>();
    if (premium.isPremium) {
      onUnlocked();
      return;
    }
    HapticFeedback.lightImpact();
    final unlocked = await showPaywall(context);
    if (unlocked && context.mounted) onUnlocked();
  }
}

/// Small "PRO" badge to mark locked features in the UI.
class ProBadge extends StatelessWidget {
  const ProBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFF9500), Color(0xFFFFB340)],
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(CupertinoIcons.lock_fill, size: 10, color: Colors.white),
          SizedBox(width: 3),
          Text(
            'PRO',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}

// MARK: - Standalone page wrapper

class _PaywallPage extends StatelessWidget {
  const _PaywallPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1B9A43),
      body: PaywallView(onClose: () => Navigator.of(context).maybePop()),
    );
  }
}

// MARK: - Reusable paywall content

/// The paywall body. Reused as a standalone modal page and as the final
/// onboarding step. [onClose] is called when the user dismisses or after a
/// successful purchase.
class PaywallView extends StatefulWidget {
  final VoidCallback onClose;
  final bool isOnboarding;

  const PaywallView({
    super.key,
    required this.onClose,
    this.isOnboarding = false,
  });

  @override
  State<PaywallView> createState() => _PaywallViewState();
}

class _PaywallViewState extends State<PaywallView> {
  bool _yearlySelected = true;
  bool _wasPremium = false;

  @override
  void initState() {
    super.initState();
    _wasPremium = context.read<PremiumProvider>().isPremium;
  }

  // MARK: - Actions
  Future<void> _purchase(PremiumProvider premium) async {
    final product = _yearlySelected
        ? premium.yearlyProduct
        : premium.weeklyProduct;
    if (product == null) {
      _showUnavailable();
      return;
    }
    HapticFeedback.mediumImpact();
    await premium.buy(product);
  }

  Future<void> _restore(PremiumProvider premium) async {
    HapticFeedback.selectionClick();
    await premium.restore();
    if (!mounted) return;
    final l10n = AppLocalizations.of(context);
    final msg = premium.isPremium ? l10n.restoreSuccess : l10n.restoreNone;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  void _showUnavailable() {
    final l10n = AppLocalizations.of(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(l10n.purchaseUnavailable)),
    );
  }

  Future<void> _openUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  // MARK: - View
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final premium = context.watch<PremiumProvider>();

    // Auto-dismiss once the purchase lands.
    if (premium.isPremium && !_wasPremium) {
      _wasPremium = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        HapticFeedback.heavyImpact();
        widget.onClose();
      });
    }

    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF3FD168),
            Color(0xFF2BB554),
            Color(0xFF1B9A43),
          ],
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            _buildCloseRow(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    _buildHero(l10n),
                    const SizedBox(height: 18),
                    _buildFeatures(l10n),
                    const SizedBox(height: 18),
                    _buildPlans(l10n, premium),
                    const SizedBox(height: 10),
                    _buildTrialNote(l10n, premium),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
            ),
            _buildFooter(l10n, premium),
          ],
        ),
      ),
    );
  }

  Widget _buildCloseRow() {
    return Align(
      alignment: Alignment.centerLeft,
      child: CupertinoButton(
        padding: const EdgeInsets.all(16),
        onPressed: () {
          HapticFeedback.selectionClick();
          widget.onClose();
        },
        child: Icon(
          CupertinoIcons.xmark,
          color: Colors.white.withValues(alpha: 0.85),
          size: 22,
        ),
      ),
    );
  }

  Widget _buildHero(AppLocalizations l10n) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 76,
              height: 76,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
            ),
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.22),
                shape: BoxShape.circle,
              ),
            ),
            const Icon(CupertinoIcons.star_fill,
                color: Colors.white, size: 32),
          ],
        ),
        const SizedBox(height: 14),
        Text(
          l10n.paywallTitle,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.5,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          l10n.paywallSubtitle,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            color: Colors.white.withValues(alpha: 0.9),
            height: 1.4,
            letterSpacing: -0.2,
          ),
        ),
      ],
    );
  }

  Widget _buildFeatures(AppLocalizations l10n) {
    final features = [
      (CupertinoIcons.doc_text_fill, l10n.paywallFeature1),
      (CupertinoIcons.book_fill, l10n.paywallFeature2),
      (CupertinoIcons.photo_on_rectangle, l10n.paywallFeature3),
      (CupertinoIcons.heart_fill, l10n.paywallFeature4),
    ];
    return Column(
      children: features.map((f) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.22),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(f.$1, color: Colors.white, size: 18),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  f.$2,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    letterSpacing: -0.3,
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  /// Weekly-equivalent price string for the yearly plan (e.g. "$0.38"),
  /// derived from the store's raw price when available.
  String _yearlyPerWeek(PremiumProvider premium) {
    final product = premium.yearlyProduct;
    if (product != null && product.rawPrice > 0) {
      final perWeek = product.rawPrice / 52;
      return '${product.currencySymbol}${perWeek.toStringAsFixed(2)}';
    }
    return '\$0.38';
  }

  Widget _buildPlans(AppLocalizations l10n, PremiumProvider premium) {
    final weekly = premium.weeklyProduct?.price ?? '\$1';
    final yearly = premium.yearlyProduct?.price ?? '\$20';
    return Column(
      children: [
        _PlanCard(
          title: l10n.planYearly,
          price: yearly,
          period: l10n.weeklyEquivalent(_yearlyPerWeek(premium)),
          badge: l10n.bestValueBadge,
          subtitle: l10n.freeTrialBadge,
          selected: _yearlySelected,
          onTap: () {
            HapticFeedback.selectionClick();
            setState(() => _yearlySelected = true);
          },
        ),
        const SizedBox(height: 12),
        _PlanCard(
          title: l10n.planWeekly,
          price: weekly,
          period: l10n.perWeek,
          badge: null,
          subtitle: l10n.freeTrialBadge,
          selected: !_yearlySelected,
          onTap: () {
            HapticFeedback.selectionClick();
            setState(() => _yearlySelected = false);
          },
        ),
      ],
    );
  }

  Widget _buildTrialNote(AppLocalizations l10n, PremiumProvider premium) {
    return Text(
      l10n.trialNote,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 12.5,
        color: Colors.white.withValues(alpha: 0.85),
        height: 1.4,
      ),
    );
  }

  Widget _buildFooter(AppLocalizations l10n, PremiumProvider premium) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: premium.purchasePending ? null : () => _purchase(premium),
            child: Container(
              width: double.infinity,
              height: 56,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.12),
                    blurRadius: 14,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: premium.purchasePending
                  ? const CupertinoActivityIndicator(color: Color(0xFF1B9A43))
                  : Text(
                      l10n.continueButton,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1B9A43),
                      ),
                    ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _footerLink(l10n.restorePurchases, () => _restore(premium)),
              _footerDot(),
              _footerLink(l10n.privacyPolicy,
                  () => _openUrl(_privacyUrl)),
              _footerDot(),
              _footerLink(l10n.termsOfUse, () => _openUrl(_termsUrl)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _footerLink(String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          color: Colors.white.withValues(alpha: 0.85),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _footerDot() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Text('·',
          style: TextStyle(
              color: Colors.white.withValues(alpha: 0.6), fontSize: 12)),
    );
  }

  static const String _privacyUrl =
      'https://drive.google.com/file/d/147xkp4cekrxhrBYZnzV-J4PzCSqkix7t/view?usp=sharing';
  static const String _termsUrl =
      'https://www.apple.com/legal/internet-services/itunes/dev/stdeula/';
}

// MARK: - Plan card

class _PlanCard extends StatelessWidget {
  final String title;
  final String price;
  final String period;
  final String? badge;
  final String subtitle;
  final bool selected;
  final VoidCallback onTap;

  const _PlanCard({
    required this.title,
    required this.price,
    required this.period,
    required this.badge,
    required this.subtitle,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const Color accent = Color(0xFF1B9A43);
    final Color cardColor =
        selected ? Colors.white : Colors.white.withValues(alpha: 0.15);
    final Color titleColor = selected ? AppColors.textPrimary : Colors.white;
    final Color priceColor = selected ? AppColors.textPrimary : Colors.white;
    final Color subtitleColor =
        selected ? accent : Colors.white.withValues(alpha: 0.9);
    final Color periodColor = selected
        ? AppColors.textSecondary
        : Colors.white.withValues(alpha: 0.85);
    final Color checkColor =
        selected ? accent : Colors.white.withValues(alpha: 0.85);
    final Color borderColor =
        selected ? Colors.white : Colors.white.withValues(alpha: 0.4);

    return GestureDetector(
      onTap: onTap,
      child: AnimatedScale(
        scale: selected ? 1.0 : 0.94,
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutBack,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: borderColor,
              width: selected ? 2 : 1,
            ),
            boxShadow: selected
                ? [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.12),
                      blurRadius: 14,
                      offset: const Offset(0, 5),
                    ),
                  ]
                : null,
          ),
          child: Row(
          children: [
            Icon(
              selected
                  ? CupertinoIcons.checkmark_circle_fill
                  : CupertinoIcons.circle,
              color: checkColor,
              size: 24,
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: titleColor,
                          letterSpacing: -0.3,
                        ),
                      ),
                      if (badge != null) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppColors.secondary,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            badge!,
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 13,
                      color: subtitleColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  price,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: priceColor,
                    letterSpacing: -0.4,
                  ),
                ),
                Text(
                  period,
                  style: TextStyle(
                    fontSize: 12,
                    color: periodColor,
                  ),
                ),
              ],
            ),
          ],
          ),
        ),
      ),
    );
  }
}
