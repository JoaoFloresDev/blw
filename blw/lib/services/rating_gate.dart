// GambitStudio rating pipeline (adapted from _GambitStudio/templates/flutter/rating_gate.dart).
//
// Pre-gate question routes happy users to the native in-app review prompt and
// unhappy users to an internal feedback form, so 1-2 star intent never reaches
// the App Store unprompted. Presented on the root navigator (navigatorKey) so
// call sites can trigger it even while popping their own routes.

import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../l10n/app_localizations.dart';
import 'analytics_service.dart';

class RatingGate {
  RatingGate._();
  static final RatingGate instance = RatingGate._();

  /// Attach to MaterialApp so the gate can present after route pops.
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  // -- Config ---------------------------------------------------------------
  /// Celebrations (new foods tried) before the gate may show.
  static const int _minPositiveEvents = 1;
  static const int _cooldownDays = 60;
  static const int _negativeCooldownDays = 120;
  static const int _maxNativePromptsPerYear = 3;

  static const _kPositiveCount = 'gate.positiveCount';
  static const _kLastShown = 'gate.lastShownMs';
  static const _kLastNegative = 'gate.lastNegativeMs';
  static const _kAnsweredYes = 'gate.answeredYes';
  static const _kNativePrompts = 'gate.nativePromptsMs';
  // Legacy key from AppOpensService — users who already saw the old native
  // prompt shouldn't be re-asked right away.
  static const _kLegacyRequested = 'review_requested';

  // -- Public API -----------------------------------------------------------

  /// Call on every positive moment (each new-food celebration). Presents the
  /// gate only from the [_minPositiveEvents]-th event on, when eligible.
  Future<void> recordPositiveEvent({required String trigger}) async {
    final prefs = await SharedPreferences.getInstance();
    final count = (prefs.getInt(_kPositiveCount) ?? 0) + 1;
    await prefs.setInt(_kPositiveCount, count);
    if (count < _minPositiveEvents) return;
    await maybePresent(trigger: trigger);
  }

  /// Presents the gate at an aha-moment if eligible. Safe to call while the
  /// caller is popping routes: presentation happens on the root navigator
  /// after the current frame.
  Future<void> maybePresent({required String trigger}) async {
    final prefs = await SharedPreferences.getInstance();
    if (!_isEligible(prefs)) return;
    await prefs.setInt(_kLastShown, DateTime.now().millisecondsSinceEpoch);
    AnalyticsService.ratingGateShown(trigger);
    // Callers trigger this while popping their own routes — wait for the pop
    // animations to settle on the home screen before sliding the sheet up,
    // otherwise the sheet races the navigation transition.
    await Future.delayed(const Duration(milliseconds: 600));
    final context = navigatorKey.currentContext;
    if (context == null || !context.mounted) return;
    final answered = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (_) => _GateSheet(trigger: trigger),
    );
    if (answered == null) {
      AnalyticsService.ratingGateDismissed(trigger);
    }
  }

  // -- Eligibility ----------------------------------------------------------

  bool _isEligible(SharedPreferences prefs) {
    if (prefs.getBool(_kAnsweredYes) ?? false) return false;
    final now = DateTime.now().millisecondsSinceEpoch;
    const dayMs = 86400000;
    // Legacy single-ask flag: treat as a native prompt ~now; re-ask only after cooldown.
    if ((prefs.getBool(_kLegacyRequested) ?? false) &&
        prefs.getInt(_kLastShown) == null) {
      return false;
    }
    final last = prefs.getInt(_kLastShown);
    if (last != null && now - last < _cooldownDays * dayMs) return false;
    final negative = prefs.getInt(_kLastNegative);
    if (negative != null && now - negative < _negativeCooldownDays * dayMs) {
      return false;
    }
    final prompts = prefs.getStringList(_kNativePrompts) ?? [];
    final yearAgo = now - 365 * dayMs;
    return prompts.where((m) => (int.tryParse(m) ?? 0) > yearAgo).length <
        _maxNativePromptsPerYear;
  }

  // -- Outcomes -------------------------------------------------------------

  Future<void> _answeredYes(String trigger) async {
    AnalyticsService.ratingGateYes(trigger);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_kAnsweredYes, true);
    final prompts = prefs.getStringList(_kNativePrompts) ?? [];
    prompts.add(DateTime.now().millisecondsSinceEpoch.toString());
    await prefs.setStringList(_kNativePrompts,
        prompts.length > 10 ? prompts.sublist(prompts.length - 10) : prompts);
    final review = InAppReview.instance;
    if (await review.isAvailable()) await review.requestReview();
  }

  Future<void> _answeredNo(String trigger) async {
    AnalyticsService.ratingGateNo(trigger);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_kLastNegative, DateTime.now().millisecondsSinceEpoch);
  }

  void _submitFeedback(String text, String trigger) {
    AnalyticsService.ratingGateFeedback(trigger, text);
  }
}

// -- Sheet -------------------------------------------------------------------

class _GateSheet extends StatefulWidget {
  const _GateSheet({required this.trigger});
  final String trigger;

  @override
  State<_GateSheet> createState() => _GateSheetState();
}

class _GateSheetState extends State<_GateSheet> {
  bool _showFeedback = false;
  bool _sent = false;
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final accent = Theme.of(context).colorScheme.primary;
    final l10n = AppLocalizations.of(context);
    return Padding(
      padding: EdgeInsets.only(
          left: 24, right: 24, top: 24,
          bottom: MediaQuery.of(context).viewInsets.bottom + 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: _showFeedback ? _feedback(accent, l10n) : _question(accent, l10n),
      ),
    );
  }

  List<Widget> _question(Color accent, AppLocalizations l10n) => [
        Icon(Icons.favorite_rounded, size: 52, color: accent),
        const SizedBox(height: 12),
        Text(l10n.ratingGateTitle,
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center),
        const SizedBox(height: 6),
        Text(l10n.ratingGateSubtitle,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center),
        const SizedBox(height: 20),
        FilledButton(
          style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(50)),
          onPressed: () {
            RatingGate.instance._answeredYes(widget.trigger);
            Navigator.of(context).pop(true);
          },
          child: Text(l10n.ratingGateYes),
        ),
        const SizedBox(height: 10),
        TextButton(
          style: TextButton.styleFrom(
            minimumSize: const Size.fromHeight(50),
            foregroundColor: Theme.of(context).textTheme.bodyMedium?.color,
          ),
          onPressed: () {
            RatingGate.instance._answeredNo(widget.trigger);
            setState(() => _showFeedback = true);
          },
          child: Text(l10n.ratingGateNo),
        ),
      ];

  List<Widget> _feedback(Color accent, AppLocalizations l10n) => _sent
      ? [
          Icon(Icons.check_circle_rounded, size: 52, color: accent),
          const SizedBox(height: 12),
          Text(l10n.ratingGateThanks,
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center),
        ]
      : [
          Text(l10n.ratingGateFeedbackTitle,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center),
          const SizedBox(height: 14),
          TextField(
            controller: _controller,
            maxLines: 4,
            decoration: InputDecoration(
              hintText: l10n.ratingGateFeedbackHint,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
          const SizedBox(height: 14),
          FilledButton(
            style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(50)),
            onPressed: () {
              final text = _controller.text.trim();
              if (text.isEmpty) return;
              RatingGate.instance._submitFeedback(text, widget.trigger);
              setState(() => _sent = true);
              Future.delayed(const Duration(milliseconds: 1400), () {
                if (mounted) Navigator.of(context).pop(true);
              });
            },
            child: Text(l10n.ratingGateSend),
          ),
        ];
}
