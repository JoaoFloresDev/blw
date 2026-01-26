import 'package:in_app_review/in_app_review.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppOpensService {
  static const String _appOpensKey = 'app_opens_count';
  static const String _reviewRequestedKey = 'review_requested';

  static Future<int> incrementAndGetOpens() async {
    final prefs = await SharedPreferences.getInstance();
    final currentOpens = prefs.getInt(_appOpensKey) ?? 0;
    final newOpens = currentOpens + 1;
    await prefs.setInt(_appOpensKey, newOpens);
    return newOpens;
  }

  static Future<int> getOpensCount() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_appOpensKey) ?? 0;
  }

  static Future<bool> hasRequestedReview() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_reviewRequestedKey) ?? false;
  }

  static Future<void> markReviewRequested() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_reviewRequestedKey, true);
  }

  // Review request: from 5th to 10th open
  static Future<bool> shouldRequestReview() async {
    final opens = await getOpensCount();
    final alreadyRequested = await hasRequestedReview();
    return opens >= 5 && opens <= 10 && !alreadyRequested;
  }

  static Future<void> requestReview() async {
    final InAppReview inAppReview = InAppReview.instance;
    if (await inAppReview.isAvailable()) {
      await inAppReview.requestReview();
      await markReviewRequested();
    }
  }

  // Purchase screen: from 11th open onwards
  static Future<bool> shouldShowPurchaseScreen() async {
    final opens = await getOpensCount();
    return opens >= 11;
  }
}
