import 'dart:developer' as developer;
import 'package:firebase_analytics/firebase_analytics.dart';

/// Central analytics facade. Every user-behavior event funnels through here
/// so event names stay consistent and call sites stay one-liners. Failures
/// are swallowed — analytics must never break a user flow.
class AnalyticsService {
  // MARK: - Core

  static final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  static Future<void> _log(String name, [Map<String, Object>? params]) async {
    try {
      await _analytics.logEvent(name: name, parameters: params);
    } catch (e) {
      developer.log('analytics drop: $name', error: e);
    }
  }

  static Future<void> screen(String name) async {
    try {
      await _analytics.logScreenView(screenName: name);
    } catch (e) {
      developer.log('analytics drop: screen $name', error: e);
    }
  }

  // MARK: - Onboarding

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
}
