import 'dart:developer' as developer;
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';

/// Central analytics facade. Every user-behavior event funnels through here
/// so event names stay consistent and call sites stay one-liners. Failures
/// are swallowed — analytics must never break a user flow.
/// Debug builds only print to console — QA sessions in the simulator must
/// never pollute the production funnel.
class AnalyticsService {
  // MARK: - Core

  static final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  static Future<void> _log(String name, [Map<String, Object>? params]) async {
    if (kDebugMode) {
      developer.log('analytics (debug, not sent): $name ${params ?? ''}');
      return;
    }
    try {
      await _analytics.logEvent(name: name, parameters: params);
    } catch (e) {
      developer.log('analytics drop: $name', error: e);
    }
  }

  static Future<void> screen(String name) async {
    if (kDebugMode) return;
    try {
      await _analytics.logScreenView(screenName: name);
    } catch (e) {
      developer.log('analytics drop: screen $name', error: e);
    }
  }

  // MARK: - Onboarding

  /// Fired once per feature page (0-based) so drop-off inside the
  /// onboarding is measurable; the paywall step logs paywall_shown instead.
  static Future<void> onboardingStepViewed(int step) =>
      // String value: GA4 custom dimensions only capture string params.
      _log('onboarding_step_viewed', {'step': '$step'});

  static Future<void> onboardingCompleted() => _log('onboarding_completed');

  // MARK: - Sales funnel

  /// [source] identifies which gate opened the paywall: diary_add, home_add,
  /// food_detail_add, log_edit, gallery_log, recipes, pdf_export, photo_limit,
  /// onboarding.
  static Future<void> paywallShown(String source) =>
      _log('paywall_shown', {'source': source});

  static Future<void> paywallDismissed(String source) =>
      _log('paywall_dismissed', {'source': source});

  static Future<void> purchaseStarted(String plan, String source) =>
      _log('purchase_started', {'plan': plan, 'source': source});

  static Future<void> purchaseSuccess(String source) =>
      _log('purchase_success', {'source': source});

  static Future<void> purchaseRestored() => _log('purchase_restored');

  /// The native payment sheet ended without a purchase.
  /// [reason] is 'canceled' (user dismissed) or 'error' (payment failed).
  static Future<void> purchaseAbandoned(String reason) =>
      _log('purchase_abandoned', {'reason': reason});

  /// Where the user went right after abandoning the payment sheet:
  /// 'retried' (tapped the CTA again), 'closed_paywall', 'left_app'
  /// (backgrounded within the watch window) or 'stayed_on_paywall'
  /// (still on the paywall when the window expired).
  static Future<void> postAbandonOutcome(String outcome, String source) =>
      _log('post_abandon_outcome', {'outcome': outcome, 'source': source});

  // MARK: - Core usage

  static Future<void> foodViewed(String foodId) =>
      _log('food_viewed', {'food_id': foodId});

  static Future<void> foodLogSaved({required bool firstTime, required int photoCount}) =>
      _log('food_log_saved', {'first_time': '$firstTime', 'photo_count': photoCount});

  static Future<void> recipesOpened() => _log('recipes_opened');

  static Future<void> allergensOpened() => _log('allergens_opened');

  static Future<void> pdfExported() => _log('pdf_exported');

  static Future<void> galleryPhotoAdded() => _log('gallery_photo_added');

  static Future<void> reviewPromptRequested(String trigger) =>
      _log('review_prompt_requested', {'trigger': trigger});

  // MARK: - Navigation & secondary actions

  /// [tab] is diary, foods or gallery.
  static Future<void> tabViewed(String tab) => _log('tab_viewed', {'tab': tab});

  static Future<void> logOpened() => _log('food_log_opened');

  static Future<void> logDeleted() => _log('food_log_deleted');

  static Future<void> recipeViewed(String recipeId) =>
      _log('recipe_viewed', {'recipe_id': recipeId});

  static Future<void> tipsOpened() => _log('tips_opened');

  static Future<void> galleryPhotoViewed() => _log('gallery_photo_viewed');
}
